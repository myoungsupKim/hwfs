package com.hwfs.sc.cmn.web;

import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.DataSetMap;
import hone.online.xplatform.map.XplatformMapDTO;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStreamWriter;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.sc.cmn.util.DateUtil;


 /**
 * 웹문서를 첨부하는 WebDocAttach Controller
 * 
 * @ClassName WebDocAttachController.java
 * @Description WebDocAttachController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.12    kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 :  AA kksoo
 * @since 2015.05.12
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/sc/cmn/webDocAttach/")
public class WebDocAttachController extends DefaultController {
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/**
	 * 웹문서(을)를 임시 저장소에 첨부한다.
	 * <pre>
	 * - 웹에서 접근할 수 있는 임시저장소에 첨부되며 일정 시간 후에 삭제된다.
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
	@RequestMapping("attachDoc.xdo")
	public ModelAndView attachDoc(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		@SuppressWarnings("unchecked")
		Map<String, Object> map = param.get("ds_list").get(0);

		//CHARSET을 UTF-8로 변환
		String strData = map.get("contents").toString().replaceFirst("text/html; charset=euc-kr", "text/html; charset=utf-8");

		//웹문서을(를) 임시저장소에 저장한다.
		String attachPath = propertiesService.getString("global.imagerepository.path") + 
							propertiesService.getString("webtemp.file.path");
		String attachFile = DateUtil.getTimestamp() + ".html";
		
		saveDocToFile(attachPath, attachFile, strData);

		//웹에서 접근할 수 있도록 첨부파일 위치를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_attachPath", "/upload" + "/" + propertiesService.getString("webtemp.file.path") + "/" + attachFile);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 문서 내용을 파일로 저장한다.
	 *
	 * @param srcPath
	 * @param srcFile
	 * @param strData
	 * @throws Exception
	 */
    private void saveDocToFile(String srcPath, String srcFile, String strData) throws Exception {
    	BufferedWriter objWriter = null;
    	FileOutputStream objFos = null;
    	OutputStreamWriter objOsw = null;
    	
        try {
        	// 디렉토리가 존재하지 않으면 생성함
        	File file = new File(srcPath);
        	if (!file.exists()) file.mkdirs();
           
        	objFos =new FileOutputStream (srcPath + "/" + srcFile);
        	objOsw = new OutputStreamWriter (objFos);
        	objWriter = new BufferedWriter (objOsw);
        	objWriter.write(strData);
        } finally {
        	if (objWriter != null){
                try { objWriter.close(); } catch (Exception e) { logger.error(e.getLocalizedMessage()); }
            }
        	if (objOsw != null){
                try { objOsw.close(); } catch (Exception e) { logger.error(e.getLocalizedMessage()); }
            }
        	if (objFos != null){
                try { objFos.close(); } catch (Exception e) { logger.error(e.getLocalizedMessage()); }
            }
        }
    }

}
