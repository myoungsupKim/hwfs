package com.hwfs.sc.cmn.web;

import hone.core.util.record.RecordSet;
import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.DataSetMap;
import hone.online.xplatform.map.XplatformMapDTO;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.sc.cmn.service.EproAttachFileService;;

 /**
 * EproAttachFileController에 대한 설명 작성
 * @ClassName EproAttachFileController.java
 * @Description EproAttachFileController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2017. 2. 17.   kihoon      최초생성
 * </pre>
 * @author FC종합전산구축 : COM kihoon
 * @since 2017. 2. 17.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/sc/cmn/EproAttachFile/")
public class EproAttachFileController extends DefaultController {
	@Resource(name="/sc/cmn/eproAttachFileService")
	private EproAttachFileService eproAttachFile;
	
	/**
	 * 구매시스템의 첨부파일 목록을 조회한다.
	 * <pre>
	 * </pre>
	 *
	 * @param xpDTO
	 * @return
	 */
	@RequestMapping("selectFileList_doc.xdo")
	public ModelAndView selectSidoList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) {
		//ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();
		
		//XPlatform에서 넘어온 DataSet Parameter을 추출한다.
		//Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
		//조회 조건 파라미터를 얻는다.
		Map <String, Object> inVar = xpDTO.getInVariableMap();
		
		RecordSet rs = eproAttachFile.selectFileList_doc(inVar);
		
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);
		
		//ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
}
