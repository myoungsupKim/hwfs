package com.hwfs.rc.bms.web;

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
import com.hwfs.rc.bms.service.TmMgmtService;

 /**
 * TmGoalMngtController에 대한 설명 작성
 * @ClassName TmGoalMngtController.java
 * @Description TmGoalMngtController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 3. 2.   Administrator        최초생성
 * </pre>
 * @author FC종합전산구축 : 팀명 Administrator
 * @since 2015. 3. 2.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/rc/bms/tmMgmt/")
public class TmMgmtController extends DefaultController {
	@Resource(name="/rc/bms/tmMgmtService")
	private TmMgmtService tmMgmt;
	                 
	@RequestMapping("selectGoalList.xdo")
	public ModelAndView selectGoalList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		//ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Variable Parameter을 추출한다.
		Map<String, Object> parameter = xpDTO.getInVariableMap();

		RecordSet rs = tmMgmt.selectGoalList(parameter);
		
		//개인정보보호 접근로그 조회 조건과 건수
		//accessLogService.readLog(parameter, rs.size());
				
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_tmGoal", rs);

		//ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	@RequestMapping("selectSaleList.xdo")
	public ModelAndView selectSaleList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		//ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Variable Parameter을 추출한다.
		Map<String, Object> parameter = xpDTO.getInVariableMap();

		RecordSet rs = tmMgmt.selectSaleList(parameter);
		
		//개인정보보호 접근로그 조회 조건과 건수
		//accessLogService.readLog(parameter, rs.size());
				
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_tmSale", rs);

		//ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	

	@RequestMapping("selectAddSaleList.xdo")
	public ModelAndView selectAddSaleList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		//ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Variable Parameter을 추출한다.
		Map<String, Object> parameter = xpDTO.getInVariableMap();

		RecordSet rs = tmMgmt.selectAddSaleList(parameter);
		
		//개인정보보호 접근로그 조회 조건과 건수
		//accessLogService.readLog(parameter, rs.size());
				
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_tmSale", rs);

		//ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	@RequestMapping("selectTmGoalChk.xdo")
	public ModelAndView selectTmGoalChk(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		//ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Variable Parameter을 추출한다.
		Map<String, Object> parameter = xpDTO.getInVariableMap();

		RecordSet rs = tmMgmt.selectTmGoalChk(parameter);
		
		//개인정보보호 접근로그 조회 조건과 건수
		//accessLogService.readLog(parameter, rs.size());
				
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_tmGoalSearch", rs);

		//ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	//실적 조회
	@RequestMapping("selectSaleSumList.xdo")
	public ModelAndView selectSaleSumList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		//ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Variable Parameter을 추출한다.
		Map<String, Object> parameter = xpDTO.getInVariableMap();

		parameter.put("gubun01", "01");
		RecordSet rs1 = tmMgmt.selectSaleSumList(parameter);
		parameter.put("gubun01", "02");
		RecordSet rs2 = tmMgmt.selectSaleSumList(parameter);
		parameter.put("gubun01", "03");
		RecordSet rs3 = tmMgmt.selectSaleSumList(parameter);
		parameter.put("gubun01", "04");
		RecordSet rs4 = tmMgmt.selectSaleSumList(parameter);
		
		//개인정보보호 접근로그 조회 조건과 건수
		//accessLogService.readLog(parameter, rs.size());
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_gubun01", rs1);
		super.addOutDataSet(mav, "ds_gubun02", rs2);
		super.addOutDataSet(mav, "ds_gubun03", rs3);
		super.addOutDataSet(mav, "ds_gubun04", rs4);		

		//ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	

	

	@RequestMapping("saveGoalData.xdo")
	public ModelAndView saveGoalMgmt(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		//ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 DataSet Parameter을 추출한다.
		Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

		int procCnt =  tmMgmt.saveGoalData(parameter.get("ds_tmGoal"));

		//XPlatform으로 넘겨줄 Form Global Variable을 설정한다.
		super.addOutVariable(mav, "fv_iProcessCnt",  procCnt);
	
		//ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
		
	}
	
	@RequestMapping("saveSaleData.xdo")
	public ModelAndView saveSaleMgmt(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		//ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 DataSet Parameter을 추출한다.
		Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

		int procCnt =  tmMgmt.saveSaleData(parameter.get("ds_tmSale"));

		//XPlatform으로 넘겨줄 Form Global Variable을 설정한다.
		super.addOutVariable(mav, "fv_iProcessCnt",  procCnt);
	
		//ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	

	@RequestMapping("saveAddSaleData.xdo")
	public ModelAndView saveAddSaleMgmt(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		//ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 DataSet Parameter을 추출한다.
		Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
		
		int procCnt =  tmMgmt.saveAddSaleData(parameter.get("ds_tmSale"));

		//XPlatform으로 넘겨줄 Form Global Variable을 설정한다.
		super.addOutVariable(mav, "fv_iProcessCnt",  procCnt);
	
		//ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	@RequestMapping("selectBCodeList.xdo")
	public ModelAndView selectBCodeList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		//ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Variable Parameter을 추출한다.
		Map<String, Object> parameter = xpDTO.getInVariableMap();

		RecordSet rs = tmMgmt.selectBCodeList(parameter);
		
		//개인정보보호 접근로그 조회 조건과 건수
		//accessLogService.readLog(parameter, rs.size());
				
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_codeList", rs);

		//ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

}
