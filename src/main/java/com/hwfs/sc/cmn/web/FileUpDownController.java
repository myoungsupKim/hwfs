package com.hwfs.sc.cmn.web;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.hwfs.cmn.crypto.aria.ARIACryptoServiceImpl;
import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.cmn.idgen.UUIdGenService;
import com.hwfs.sc.cmn.dto.AttachFileDTO;
import com.hwfs.sc.cmn.service.AttachFileService;
import com.hwfs.sc.cmn.util.FileUtil;
import com.hwfs.sc.cmn.util.StringUtil;
import com.tobesoft.xplatform.data.ColumnHeader;
import com.tobesoft.xplatform.data.DataSet;
import com.tobesoft.xplatform.data.DataTypes;
import com.tobesoft.xplatform.data.PlatformData;

 /**
 * 프로젝트 공통 File Upload & Download 기능을 제공하는 Controller 클래스이다.
 * @ClassName FileUpDownController.java
 * @Description FileUpDownController Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2014. 12. 8.   kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2014. 12. 8.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
public class FileUpDownController extends DefaultController {
    /** LogService */
    private final Logger logger = LoggerFactory.getLogger (this.getClass());

    /** 파일Read 시 버퍼 사이즈 */
    private static final int BUFFER_SIZE     = 2048;

    /** 파일이 없거나 오류가 난 경우 응답 문자열 */
    private static final String UNKNOWN_FILE   = "unknownfile";

    /** CryptoService */
    @Resource(name = "ariaCryptoService")
    protected ARIACryptoServiceImpl cryptoService;

    /** UUIdGenService */
    @Resource(name = "idGenUUIdService")
    protected UUIdGenService idGenUUIdService;

    /** FileAttach Service Bean 생성 */
    @Resource(name = "/sc/cmn/attachFileService")
    private AttachFileService attachFileService;

    /**
     * 파일을 임시저장소로 업로드 한다. 최종 저장소로의 이동은 각 업무 Controller에서 처리해야 한다.
     * <pre>
     * - XPLATFORM Runtime과 HTML5에서 이용 가능하다.
     * </pre>
     * @param request HttpServletRequest
     * @param response HttpServletResponse
     * @throws Exception
     */
    @RequestMapping(value="/sc/cmn/uploadFile.do")
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
            	logger.error("uploadFile:{}", errMsg);
                setResultSet (xpfData, DefaultConsts.ERR_CODE, errMsg);

                //처리결과를 전송한다.
                sendPlatformData (xpfData, response);
                return ;
            }else if (chk == -2) {	//파일크기 오류
            	String errMsg = messageService.getMessage("fail.uploadfile.size.over", new String[]{propertiesService.getString("global.fileupload.size", "")});
            	logger.error("uploadFile:{}", errMsg);
                setResultSet (xpfData, DefaultConsts.ERR_CODE, errMsg);

                //처리결과를 전송한다.
                sendPlatformData (xpfData, response);
                return;
            }
            
            /*
             * 업로드 파일을 파일 저장소에 저장 처리
             */
            String strUploadPath = propertiesService.getString("global.fileupload.path");	// 임시 파일 저장소
            logger.debug ("Upload Path={}", strUploadPath);

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
            logger.error("uploadFile", e);
            setResultSet (xpfData, DefaultConsts.ERR_CODE, e);
        }

        //처리결과를 전송한다.
        sendPlatformData (xpfData, response);
        return;
    }

    /**
     * 파일 저장소에 저장된 파일을 다운로드 한다.
     * <pre>
     * - 보안상 문제가 있어 이 함수의 사용은 비표준이다.
     * - XPLATFORM Runtime과 HTML5에서 이용 가능하다.
     * </pre>
     * @param response HttpServletResponse
     * @param strRelPath 파일 저장소의 Root 디렉토리로부터의 상대 디렉토리
     * @param strFileName 다운로드할 파일 명 (파일 저장소의 Root 디렉토리를 제외한 Path 포함)
     * @param webRepoYn 파일저장소가 webapp 아래인지 여부(true이면 global.imagerepository.path 아래가 된다.)
     * @throws Exception
     */
    @SuppressWarnings("null")
    @RequestMapping(value="/sc/cmn/downloadFile.do")
    public void downloadFile (HttpServletResponse response,
                              @RequestParam(value = "relPath") String strRelPath,
                              @RequestParam(value = "fileName") String strFileName,
                              @RequestParam(value="webRepoYn", required=false, defaultValue="false") boolean webRepoYn) throws Exception {
        if (response == null) response.sendRedirect(UNKNOWN_FILE);

        String strFileRootPath;
        if (webRepoYn)
            strFileRootPath = propertiesService.getString("global.imagerepository.path");	// 파일 저장소 Root
        else
            strFileRootPath = propertiesService.getString("global.filerepository.path");	// 파일 저장소 Root

        String strRealFile = strFileRootPath;
        if (strRelPath != null && !strRelPath.equals("")) strRealFile += strRelPath;
        if (strFileName != null && !strFileName.equals("")) strRealFile += "/" + strFileName;
        logger.debug ("Down File={}" , strRealFile);

        //실제 파일을 다운로드
        downloadRealFile (response, strRealFile, strFileName, false);
    }

    /**
     * 임시저장소에 저장된 파일을 다운로드 한다.
     * <pre>
     * - 업무에서 임시로 파일을 생성 후 다운로드 할 경우에 이용한다.
     * - XPLATFORM Runtime과 HTML5에서 이용 가능하다.
     * </pre>
     * @param response HttpServletResponse
     * @param strRelPath 파일 임시 저장소의 Root 디렉토리로 부터의 상대 디렉토리
     * @param strFileName 다운로드할 파일 명 (파일 저장소의 Root 디렉토리를 제외한 Path 포함)
     * @throws Exception
     */
    @SuppressWarnings("null")
    @RequestMapping(value="/sc/cmn/downloadTempFile.do")
    public void downloadTempFile (HttpServletResponse response,
                              @RequestParam(value = "relPath") String strRelPath,
                              @RequestParam(value = "fileName") String strFileName) throws Exception {
        if (response == null) response.sendRedirect(UNKNOWN_FILE);

        String strFileRootPath = propertiesService.getString("global.filedownload.path");	// 파일 임시저장소 Root
        String strRealFile = strFileRootPath;
        if (strRelPath != null && !strRelPath.equals("")) strRealFile += strRelPath;
        if (strFileName != null && !strFileName.equals("")) strRealFile += "/" + strFileName;
        logger.debug ("Down File={}", strRealFile);

        //실제 파일을 다운로드
        downloadRealFile (response, strRealFile, strFileName, false);
    }

    /**
     * DB에 저장된 파일을 다운로드 한다.
     * <pre>
     * - 보안을 위해 이 함수룰 이용하여 다운로드해야 한다. (표준)
     * - 암호화된 파일을 복호화하여 다운로드한다.
     * - XPLATFORM Runtime과 HTML5에서 이용 가능하다.
     * </pre>
     *
     * @param response HttpServletResponse
     * @param strRefSeq 첨부참조일련번호
     * @param lngAppendSeq 첨부일련번호
     * @param webRepoYn 파일저장소가 webapp 아래인지 여부(true이면 global.imagerepository.path 아래가 된다.)
     * @throws Exception
     */
    @SuppressWarnings("null")
    @RequestMapping(value="/sc/cmn/downloadFileDB.do")
    public void downloadFileDB (HttpServletRequest request, HttpServletResponse response,
                              @RequestParam(value = "refSeq") String strRefSeq,
                              @RequestParam(value = "appendSeq") long lngAppendSeq,
                              @RequestParam(value="webRepoYn", required=false, defaultValue="false") boolean webRepoYn) throws Exception {
        if (response == null) response.sendRedirect(UNKNOWN_FILE);

        //DB 데이터를 조회한다.
        AttachFileDTO attachFileVO = attachFileService.selectFileInfo(strRefSeq, lngAppendSeq);
        if (attachFileVO == null) response.sendRedirect(UNKNOWN_FILE);

        String strFileRootPath;
        if (webRepoYn)
            strFileRootPath = propertiesService.getString("global.imagerepository.path");	// 파일 저장소 Root
        else
            strFileRootPath = propertiesService.getString("global.filerepository.path");	// 파일 저장소 Root

        String strOrgnlFileName = attachFileVO.getOrgnlFileNm();
        String strRealFile = strFileRootPath;
        if (attachFileVO.getRelPath() != null && !attachFileVO.getRelPath().equals("")) strRealFile += attachFileVO.getRelPath();
        if (attachFileVO.getSaveFileNm() != null && !attachFileVO.getSaveFileNm().equals("")) strRealFile += "/" + attachFileVO.getSaveFileNm();
        logger.debug ("Down File={}", strRealFile);

        //실제 파일을 다운로드 : 암호화된 경우는 암호화를 해제하여 다운로드한다.
        downloadRealFile (response, strRealFile, strOrgnlFileName, attachFileVO.getEncYn());
    }

    /**
     * 디렉토리에 저장된 파일을 다운로드한다.
     *
     * @param response
     * @param strRealFile 실제 파일 위치
     * @param blnEnc 파일암호화 여부
     */
    private void downloadRealFile (HttpServletResponse response, String strRealFile, String strFileName, boolean blnEnc) throws Exception {
        String strRealFileTmp = strRealFile; //PMD Rule에 의해 Tmp변수로 이동
        //개인정보보호 다운로드 파일의 접근로그 처리
        Map<String,Object> mapLogData = new HashMap<String,Object>();
        mapLogData.put("realFile", strRealFileTmp);
        mapLogData.put("fileName", strFileName);
        accessLogService.downloadLog(mapLogData);

        //암호화된 경우는 복호화하여 다운로드
        if (blnEnc) {
            String decFile =  propertiesService.getString("global.fileupload.path") + "/" + idGenUUIdService.getNextStringHostId() + "_dec";
            cryptoService.decryptFile(strRealFileTmp, decFile);
            strRealFileTmp = decFile;
        }

        File objFile = new File(StringUtil.replaceRelativePath(strRealFileTmp));
        if(objFile.exists()){
            BufferedOutputStream outStream = new BufferedOutputStream(response.getOutputStream());
            BufferedInputStream inStream = null;
            byte[] bytBuffer = new byte[BUFFER_SIZE];

            try{
                response.reset();
                response.setContentType("utf-8");
                response.setContentType("application/octet;charset=utf-8");
                response.setHeader("Accept-Ranges", "bytes");
                response.setHeader("Content-Disposition", "attachment;filename=" + StringUtil.replaceHeaderFormat(java.net.URLEncoder.encode(strFileName,"UTF-8")));

                //out.clear();
                //out = pageContext.pushBody();

                //파일을 버퍼 만끔씩 읽어 전송
                inStream = new BufferedInputStream(new FileInputStream(objFile));

                int n = 0;
                while ((n = inStream.read(bytBuffer, 0, bytBuffer.length)) != -1) {
                    outStream.write(bytBuffer, 0, n);
                }
                outStream.flush();
            } catch (Exception e) {
                logger.error(e.getMessage());
                response.sendRedirect(UNKNOWN_FILE);
            } finally {
                if(inStream != null)  try { inStream.close(); } catch (Exception e)  {logger.error(e.getMessage());}
                if(outStream != null) try { outStream.close(); } catch (Exception e) {logger.error(e.getMessage());}
            }
        }else{
            logger.error(strRealFileTmp + messageService.getMessage("fail.file.not.found"));
            response.sendRedirect(UNKNOWN_FILE);
        }

    }
}
