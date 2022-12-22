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
import com.hwfs.ms.msc.service.SaniCheckResultService;
import com.hwfs.sc.cmn.dto.LoginDTO;


 /**
 * 위생점검결과조회 SaniCheckResult Controller
 * 
 * @ClassName SaniCheckResultController.java
 * @Description SaniCheckResultController Class 
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
@RequestMapping("/ms/msc/saniCheckResult/")
public class SaniCheckResultController extends DefaultController {
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** SaniCheckResultService Bean 생성 */
	@Resource(name = "/ms/msc/saniCheckResultService")
	private SaniCheckResultService saniCheckResultService;
	
	/**
	 * 위생점검결과 목록을 조회한다.
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("selectList.xdo")
	public ModelAndView selectList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		ModelAndView mav = super.createModelAndView();
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		Map <String, Object> inVarParam = null;
		Map <String, Object> inVar = xpDTO.getInVariableMap();
		
		DataSetMap parameter = param.get("ds_input");
		inVarParam = (Map<String, Object>) parameter.get(0);
		
		//System.out.println("inVar >> " + inVar);
		//System.out.println("inVarParam >> " + inVarParam);
		//inVar >> {gv_xp_txdatatype=, sysType=FSMOBILE, upjang=148682, JSESSIONID=9588F282F907AD5E541C979D60097C9D, appId=FSMOBILE, ktagTokenField=savedToken, savedToken=4XMLTDZ3MKTZEVY9Z6RFJURZU7T10ZA7, menuId=3349, prgId=}
		//inVarParam >> {upjang=194446, ROW_TYPE=0, upjangNm=(주)윈플러스마트-마포점, formCdNm=마트 테스트, formCd=202204, checkSabun=202100132, checkDate=20220801, tableType=009, checkTypeNm=정기, checkType=001, tableTypeNm=마트, checkNm=박종환}

		
		// ds_master 조회
		RecordSet rsMst = saniCheckResultService.selectMasterList(inVarParam);
		super.addOutDataSet(mav, "ds_master", rsMst);
		
		// ds_detail 조회
		RecordSet rs = saniCheckResultService.selectDetailNewList(inVarParam);
		super.addOutDataSet(mav, "ds_detail", rs);

		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}	
	
	@RequestMapping("deleteList.xdo")
	public ModelAndView deleteList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO, HttpServletRequest request) throws Exception {
		ModelAndView mav = super.createModelAndView();
		LoginDTO loginDTO = (LoginDTO) SessionUtil.getLoginSession(request);
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		DataSetMap dsMaster = param.get("ds_master");
		DataSetMap dsDetail = param.get("ds_detail");
		
		int processCnt = saniCheckResultService.deleteList(dsMaster, dsDetail);
		super.addOutVariable(mav, "fv_processCnt", processCnt);
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	
	@RequestMapping("saveList.xdo")
	public ModelAndView saveList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO, HttpServletRequest request) throws Exception {
		ModelAndView mav = super.createModelAndView();
		LoginDTO loginDTO = (LoginDTO) SessionUtil.getLoginSession(request);
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		DataSetMap dsMaster = param.get("ds_master");
		DataSetMap dsDetail = param.get("ds_detail");
		
		int processCnt = saniCheckResultService.saveList(dsMaster, dsDetail, loginDTO);
		super.addOutVariable(mav, "fv_processCnt", processCnt);
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	
	
	/**
	 * 점검자 목록을 조회한다.
	 */
	@RequestMapping("selectSabunList.xdo")
	public ModelAndView selectSabunList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		ModelAndView mav = super.createModelAndView();
		Map <String, Object> inVar = xpDTO.getInVariableMap();
		RecordSet rs = saniCheckResultService.selectSabunList(inVar);
		super.addOutDataSet(mav, "ds_list", rs);
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	
	/**
	 * 공통코드들을 조회한다
	 */
	@RequestMapping("selectCommonCdList.xdo")
	public ModelAndView selectCommonCdList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		ModelAndView mav = super.createModelAndView();
		Map <String, Object> inVar = xpDTO.getInVariableMap();
		
		// 양식구분
		RecordSet formRs = saniCheckResultService.selectFormCdList(inVar);
		super.addOutDataSet(mav, "ds_formCd", formRs);
		
		// 점검표구분
		inVar.put("groupCode", "FS0041");
		RecordSet tableRs = saniCheckResultService.selectCommonCdList(inVar);
		super.addOutDataSet(mav, "ds_tableType", tableRs);
		
		// 점검 구분
		inVar.put("groupCode", "FS0042");
		RecordSet checkRs = saniCheckResultService.selectCommonCdList(inVar);
		super.addOutDataSet(mav, "ds_checkType", checkRs);
		
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	
}
