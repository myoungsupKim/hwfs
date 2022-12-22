package com.hwfs.ms.msc.web;

import hone.core.util.record.RecordSet;
import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.DataSetMap;
import hone.online.xplatform.map.XplatformMapDTO;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.cmn.util.SessionUtil;
import com.hwfs.ms.msc.service.SaniImgService;
import com.hwfs.sc.cmn.dto.LoginDTO;


 /**
 * 위생점검결과조회 SaniImgController
 * 
 * @ClassName SaniImgController.java
 * @Description SaniImgController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2022.07.29                최초생성
 * </pre>
 * @author 
 * @since 2022.07.29
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/ms/msc/saniImg/")
public class SaniImgController extends DefaultController {
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** SaniImgService Bean 생성 */
	@Resource(name = "/ms/msc/saniImgService")
	private SaniImgService saniImgService;
	
	/**
	 * 위생점검결과 목록을 조회한다.
	 */
	@RequestMapping("selectList.xdo")
	public ModelAndView selectList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		ModelAndView mav = super.createModelAndView();
		//Map <String, Object> inVar = xpDTO.getInVariableMap();
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		//DataSetMap parameter = param.get("ds_input");
		Map <String, Object> inVarParam = param.get("ds_input").get(0);
		//System.out.println("inVarParam >>> " + inVarParam);
		
		RecordSet rs = saniImgService.selectList(inVarParam);
		super.addOutDataSet(mav, "ds_imgList", rs);
		
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}	
	
	@RequestMapping("selectCommonCdList.xdo")
	public ModelAndView selectCommonCdList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		ModelAndView mav = super.createModelAndView();
		Map <String, Object> inVar = xpDTO.getInVariableMap();
		
		// 점검 구분
		inVar.put("groupCode", "FS0126");
		RecordSet checkRs = saniImgService.selectCommonCdList(inVar);
		super.addOutDataSet(mav, "ds_photoType", checkRs);
		
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	@RequestMapping("saveList.xdo")
	public ModelAndView saveList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO, HttpServletRequest request) throws Exception {
		ModelAndView mav = super.createModelAndView();
		LoginDTO loginDTO = (LoginDTO) SessionUtil.getLoginSession(request);
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		DataSetMap dsImgList = param.get("ds_imgList");
		DataSetMap dsInput = param.get("ds_input");
		
		int processCnt = saniImgService.saveList(dsImgList, dsInput, loginDTO);
		super.addOutVariable(mav, "fv_processCnt", processCnt);
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	
	@RequestMapping("deleteList.xdo")
	public ModelAndView deleteList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO, HttpServletRequest request) throws Exception {
		ModelAndView mav = super.createModelAndView();
		LoginDTO loginDTO = (LoginDTO) SessionUtil.getLoginSession(request);
		//Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		Map <String, Object> inVar = xpDTO.getInVariableMap();
		
		int processCnt = saniImgService.deleteList(inVar, loginDTO);
		super.addOutVariable(mav, "fv_processCnt", processCnt);
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
}
