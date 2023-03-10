package com.hwfs.sc.app.web;

import hone.hanwha.CustomAnnotaion.CustomAnnotationHandler;
import hone.hanwha.CustomAnnotaion.ServiceMethod;

import java.util.Date;
import java.util.Map;

import org.apache.commons.lang.time.FastDateFormat;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.ReflectionUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.cmn.exception.BizException;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.hwfs.sc.cmn.dto.AttachFileDTO;
import com.hwfs.sc.cmn.util.FileUtil;
import com.tobesoft.xplatform.data.ColumnHeader;
import com.tobesoft.xplatform.data.DataSet;
import com.tobesoft.xplatform.data.DataTypes;
import com.tobesoft.xplatform.data.PlatformData;
 /**
 * 식재앱 공통 json 처리 Controller
 * @ClassName JsonMobileController.java
 * @Description JsonMobileController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2022.06.20.   김명섭      최초생성
 * </pre>
 * @author 
 * @since 2022. 06. 20.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2015 by 한화시스템ICT CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
public class MobileFileUploadController extends DefaultController {
    /** LogService */
    private final Logger logger = LoggerFactory.getLogger (this.getClass());

    /** 파일Read 시 버퍼 사이즈 */
    private static final int BUFFER_SIZE     = 2048;

    /** 파일이 없거나 오류가 난 경우 응답 문자열 */
    private static final String UNKNOWN_FILE   = "unknownfile";

    /**
	 * json요청을 처리한다.
	 * <pre>
	 * - 식재 모바일앱 연동 json 공통 콘트롤러
	 * </pre>
     * 
     * @param rawData JSONObject
     * @return ModelAndView
     * @throws Exception
     */
    @RequestMapping(value = "/mobileApp/uploadFile.jDo")
    public void uploadFile (HttpServletRequest request, HttpServletResponse response) throws Exception {
        PlatformData xpfData = createPlatformData();

        try {
            // 한글 파일명 처리를 위한 설정
            request.setCharacterEncoding("utf-8");

            //전달 받은 Request객체를 MultipartHttpServletRequest로 바인딩
            MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;

            //첨부된 파일목록을 얻는다.
            Map<String, MultipartFile> mapFiles = multipartRequest.getFileMap();

            //파일 확장자와 크기 제한 검사
            int chk = FileUtil.checkUploadFileSizeExt(mapFiles, propertiesService.getInt("global.fileupload.size", 0), 
            													propertiesService.getString("global.fileupload.excludeFileExt", ""));
            if (chk == -1) {	//확장자 오류
            	String errMsg = messageService.getMessage("fail.uploadfile.ext.not.allowed", new String[]{propertiesService.getString("global.fileupload.excludeFileExt", "")});
                setResultSet (xpfData, DefaultConsts.ERR_CODE, errMsg);

                //처리결과를 전송한다.
                sendPlatformData (xpfData, response);
                return ;
            }else if (chk == -2) {	//파일크기 오류
            	String errMsg = messageService.getMessage("fail.uploadfile.size.over", new String[]{propertiesService.getString("global.fileupload.size", "")});
                setResultSet (xpfData, DefaultConsts.ERR_CODE, errMsg);

                //처리결과를 전송한다.
                sendPlatformData (xpfData, response);
                return;
            }
            
            /*
             * 업로드 파일을 파일 저장소에 저장 처리
             */
            String fullSubDir = "";
    		String sourceFile = "";
    		String targetFile = "";
    		int procCnt = 0; //처리건수
            
            fullSubDir = "/photo/fmc/";
            String strUploadPath = propertiesService.getString("global.imagerepository.path") +"/"+propertiesService.getString("ms.file.path") + fullSubDir;
            
            List<AttachFileDTO> fileInfoList = FileUtil.attchFileUpload(strUploadPath, mapFiles, ""); //파일 저장 처리

            /*
             * 업로드 정보를 XPLATFORM에 전달하기 위한 데이터셋을 만든다.
             */
            DataSet dsOut = new DataSet("Dataset00");
            dsOut.addColumn(new ColumnHeader("orgnlFileNm", DataTypes.STRING));
            dsOut.addColumn(new ColumnHeader("fileUploadNm", DataTypes.STRING));	//임시저장된 파일명
            dsOut.addColumn(new ColumnHeader("fileSize", DataTypes.LONG));
            dsOut.addColumn(new ColumnHeader("fileExt", DataTypes.STRING));
            dsOut.addColumn(new ColumnHeader("fileDesc", DataTypes.STRING));

            List<Map<String, Object>> listLog = new ArrayList<Map<String, Object>>();	//접근로그 정보

            for (int i=0; i<fileInfoList.size(); i++) {
                int row = dsOut.newRow();
                dsOut.set(row, "orgnlFileNm", fileInfoList.get(i).getOrgnlFileNm());
                dsOut.set(row, "fileUploadNm", fileInfoList.get(i).getSaveFileNm());
                dsOut.set(row, "fileSize", fileInfoList.get(i).getFileSize());
                dsOut.set(row, "fileExt", fileInfoList.get(i).getFileExt());
                dsOut.set(row, "fileDesc", fileInfoList.get(i).getFileDesc());
                
                sourceFile = strUploadPath +"/" + fileInfoList.get(i).getSaveFileNm();
                targetFile = propertiesService.getString("global.ifisrepository.path") + "/" + fileInfoList.get(i).getSaveFileNm();
        		FileUtil.copyFile (sourceFile, targetFile);
        		
                //접근로그 정보
                Map<String, Object> mapLog = new HashMap<String, Object>();
                mapLog.put("orgnlFileNm", fileInfoList.get(i).getOrgnlFileNm());
                mapLog.put("fileSize", fileInfoList.get(i).getFileSize());

                listLog.add(mapLog);
            }

            // 업로드 파일 정보를 설정한다. (참고 : DB에 저장은 별도 Controller에서 처리한다.)
            addOutDataSet (xpfData, dsOut);
            setResultSet (xpfData, DefaultConsts.OK_CODE, "OK");

            //개인정보보호 다운로드 파일의 접근로그 처리
            accessLogService.uploadLog(listLog.toString());

        }catch (Exception e) {
            setResultSet (xpfData, DefaultConsts.ERR_CODE, e);
        }

        //처리결과를 전송한다.
        sendPlatformData (xpfData, response);
        return;
    }

}
