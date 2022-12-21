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
import com.hwfs.sc.cmn.service.IntroFrameService;

/**
 * 인트로 화면의 내용을 조회하는 IntroFrame Controller
 *
 * @ClassName IntroFrameController.java
 * @Description IntroFrameController Class
 * @Modification-Information <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.20    김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.05.20
 * @version 1.0
 * @see <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/sc/cmn/introFrame/")
public class IntroFrameController extends DefaultController {

	/** LogService */
	// private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** IntroFrameService Bean 생성 */
	@Resource(name = "/sc/cmn/introFrameService")
	private IntroFrameService introFrameService;

	/**
	 * 인트로 화면 목록을 조회한다.
	 *
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략 시 이 부분 삭제할 것
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectList.xdo")
	public ModelAndView selectList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO)
			throws Exception {

		// XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		// 조회 조건 파라미터를 얻는다.
		Map<String, Object> inVar = xpDTO.getInVariableMap();
		
		/*
		// parameter 변조 확인
		Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
		for ( Object key : parameter.get("ds_cond").get(0).keySet() ){
			System.out.println(key.toString()+"==>"+parameter.get("ds_cond").get(0).get(key)+"=="+inVar.get(key));
			if ( key.toString() != "ROW_TYPE" ) {
				if ( !(parameter.get("ds_cond").get(0).get(key)).equals(inVar.get(key)) ) {
					return super.setResultSet(mav, DefaultConsts.ERR_CODE, messageService.getMessage("fail.common.msg"));
				}
			}
		}
		
		*/
		

		// 인트로 화면 을(를) 조회한다.
		Map<String, RecordSet> rtn = introFrameService.selectList(inVar);

		if ("IntroFrameType01".equals(inVar.get("introFrameId").toString())) {
			super.addOutDataSet(mav, "ds_totalBbsList", (RecordSet) rtn.get("totalBbsList"));
			super.addOutDataSet(mav, "ds_quickList", (RecordSet) rtn.get("quickList"));
			super.addOutDataSet(mav, "ds_poBbsList", (RecordSet) rtn.get("poBbsList"));
			super.addOutDataSet(mav, "ds_limsBbsList", (RecordSet) rtn.get("limsBbsList"));
		}
		else if ("IntroFrameType02".equals(inVar.get("introFrameId").toString())) {

			if ("ALL".equals(inVar.get("viewData").toString())) {
				super.addOutDataSet(mav, "ds_quickList", (RecordSet) rtn.get("quickList"));
				super.addOutDataSet(mav, "ds_totalBbsList", (RecordSet) rtn.get("totalBbsList"));
				super.addOutDataSet(mav, "ds_poBbsList", (RecordSet) rtn.get("poBbsList"));
//				super.addOutDataSet(mav, "ds_item01List", (RecordSet) rtn.get("item01"));
//				super.addOutDataSet(mav, "ds_item02List", (RecordSet) rtn.get("item02"));
//				super.addOutDataSet(mav, "ds_item03List", (RecordSet) rtn.get("item03"));
//				super.addOutDataSet(mav, "ds_item04List", (RecordSet) rtn.get("item04"));
//				super.addOutDataSet(mav, "ds_upjangRateList", (RecordSet) rtn.get("upjangRateList"));
				super.addOutDataSet(mav, "ds_chargeUpjangList", (RecordSet) rtn.get("chargeList"));
				//super.addOutDataSet(mav, "ds_unApprovedJumCnt", (RecordSet) rtn.get("unApprovedJumCnt"));
				super.addOutDataSet(mav, "ds_unApprovalJumJang", (RecordSet) rtn.get("unApprovalJumJang"));
				super.addOutDataSet(mav, "ds_checkList01", (RecordSet) rtn.get("checkList01"));
				super.addOutDataSet(mav, "ds_checkList02", (RecordSet) rtn.get("checkList02"));
				super.addOutDataSet(mav, "ds_checkList03", (RecordSet) rtn.get("checkList03"));
				super.addOutDataSet(mav, "ds_doBondCount", (RecordSet) rtn.get("doBondCount"));
				super.addOutDataSet(mav, "ds_myDesk04", (RecordSet) rtn.get("myDesk04"));
				super.addOutDataSet(mav, "ds_myDesk03", (RecordSet) rtn.get("myDesk03"));
				super.addOutDataSet(mav, "ds_limsBbsList", (RecordSet) rtn.get("limsBbsList"));
				super.addOutDataSet(mav, "ds_pbBbsList", (RecordSet) rtn.get("pbBbsList"));
			}
			else if ("300001".equals(inVar.get("viewData").toString())) {
				super.addOutDataSet(mav, "ds_item01List", (RecordSet) rtn.get("item01"));
			}
			else if ("300002".equals(inVar.get("viewData").toString())) {
				super.addOutDataSet(mav, "ds_item02List", (RecordSet) rtn.get("item02"));
			}
			else if ("300004".equals(inVar.get("viewData").toString())) {
				super.addOutDataSet(mav, "ds_item03List", (RecordSet) rtn.get("item03"));
			}
			else if ("300005".equals(inVar.get("viewData").toString())) {
				super.addOutDataSet(mav, "ds_item04List", (RecordSet) rtn.get("item04"));
			}
		}
		else if ("IntroFrameType03".equals(inVar.get("introFrameId").toString())) {
			super.addOutDataSet(mav, "ds_personalList", (RecordSet) rtn.get("personalList"));
			super.addOutDataSet(mav, "ds_quickList", (RecordSet) rtn.get("quickList"));
			super.addOutDataSet(mav, "ds_speedBbsList", (RecordSet) rtn.get("speedBbsList"));
			super.addOutDataSet(mav, "ds_totalBbsList", (RecordSet) rtn.get("totalBbsList"));
			super.addOutDataSet(mav, "ds_goodsBbsList", (RecordSet) rtn.get("goodsBbsList"));
			super.addOutDataSet(mav, "ds_fileBbsList", (RecordSet) rtn.get("fileBbsList"));
			//super.addOutDataSet(mav, "ds_creditList", (RecordSet) rtn.get("creditList"));
		}
		else if ("IntroFrameType04".equals(inVar.get("introFrameId").toString())) {
			super.addOutDataSet(mav, "ds_quickList", (RecordSet) rtn.get("quickList"));
			super.addOutDataSet(mav, "ds_personalList", (RecordSet) rtn.get("personalList"));
			super.addOutDataSet(mav, "ds_totalBbsList", (RecordSet) rtn.get("totalBbsList"));
			super.addOutDataSet(mav, "ds_speedBbsList", (RecordSet) rtn.get("speedBbsList"));
			super.addOutDataSet(mav, "ds_goodsBbsList", (RecordSet) rtn.get("goodsBbsList"));
		}
		else if ("IntroFrameType05".equals(inVar.get("introFrameId").toString())) {
			super.addOutDataSet(mav, "ds_quickList", (RecordSet) rtn.get("quickList"));
			super.addOutDataSet(mav, "ds_speedBbsList", (RecordSet) rtn.get("speedBbsList"));
			super.addOutDataSet(mav, "ds_totalBbsList", (RecordSet) rtn.get("totalBbsList"));
			super.addOutDataSet(mav, "ds_oneBbsList", (RecordSet) rtn.get("oneBbsList"));
			super.addOutDataSet(mav, "ds_fileBbsList", (RecordSet) rtn.get("fileBbsList"));
		}
		else if ("IntroFrameType06".equals(inVar.get("introFrameId").toString())) {
			super.addOutDataSet(mav, "ds_quickList", (RecordSet) rtn.get("quickList"));
			super.addOutDataSet(mav, "ds_totalBbsList", (RecordSet) rtn.get("totalBbsList"));
			super.addOutDataSet(mav, "ds_eFoodistList", (RecordSet) rtn.get("eFoodistList"));
			super.addOutDataSet(mav, "ds_salesUpjangList", (RecordSet) rtn.get("salesUpjangList"));
		}
		else if ("IntroFrameType16".equals(inVar.get("introFrameId").toString())) {
			super.addOutDataSet(mav, "ds_quickList", (RecordSet) rtn.get("quickList"));
			super.addOutDataSet(mav, "ds_totalBbsList", (RecordSet) rtn.get("totalBbsList"));
			super.addOutDataSet(mav, "ds_goodsBbsList", (RecordSet) rtn.get("goodsBbsList"));
			super.addOutDataSet(mav, "ds_eFoodistList", (RecordSet) rtn.get("eFoodistList"));
			super.addOutDataSet(mav, "ds_salesUpjangList", (RecordSet) rtn.get("salesUpjangList"));
		}
		else if ("IntroFrameType07".equals(inVar.get("introFrameId").toString())) {
			super.addOutDataSet(mav, "ds_quickList", (RecordSet) rtn.get("quickList"));
			super.addOutDataSet(mav, "ds_totalBbsList", (RecordSet) rtn.get("totalBbsList"));
			super.addOutDataSet(mav, "ds_upjangRateList", (RecordSet) rtn.get("upjangRateList"));
			super.addOutDataSet(mav, "ds_clearCheckList", (RecordSet) rtn.get("clearCheckList"));
			super.addOutDataSet(mav, "ds_planUpperUpjangList", (RecordSet) rtn.get("planUpperUpjangList"));
			super.addOutDataSet(mav, "ds_upjangPlNotInputList", (RecordSet) rtn.get("upjangPlNotInputList"));
			//super.addOutDataSet(mav, "ds_unApprovedTeamCnt", (RecordSet) rtn.get("unApprovedTeamCnt"));
			super.addOutDataSet(mav, "ds_unApprovalTeamJang", (RecordSet) rtn.get("unApprovalTeamJang"));
			super.addOutDataSet(mav, "ds_checkList01", (RecordSet) rtn.get("checkList01"));
			super.addOutDataSet(mav, "ds_checkList02", (RecordSet) rtn.get("checkList02"));
			super.addOutDataSet(mav, "ds_checkList03", (RecordSet) rtn.get("checkList03"));
			super.addOutDataSet(mav, "ds_doBondCount", (RecordSet) rtn.get("doBondCount"));
			super.addOutDataSet(mav, "ds_myDesk04", (RecordSet) rtn.get("myDesk04"));
			super.addOutDataSet(mav, "ds_limsBbsList", (RecordSet) rtn.get("limsBbsList"));
		}
		else if ("IntroFrameType08".equals(inVar.get("introFrameId").toString())) {
			//super.addOutDataSet(mav, "ds_totalBbsList", (RecordSet) rtn.get("totalBbsList"));
			super.addOutDataSet(mav, "ds_quickList", (RecordSet) rtn.get("quickList"));
			//super.addOutDataSet(mav, "ds_poBbsList", (RecordSet) rtn.get("poBbsList"));
			//super.addOutDataSet(mav, "ds_limsBbsList", (RecordSet) rtn.get("limsBbsList"));
		}
		else if ("IntroFrameType09".equals(inVar.get("introFrameId").toString())) {
			super.addOutDataSet(mav, "ds_clearCheckList", (RecordSet) rtn.get("clearCheckList"));
			super.addOutDataSet(mav, "ds_quickList", (RecordSet) rtn.get("quickList"));
			super.addOutDataSet(mav, "ds_poBbsList", (RecordSet) rtn.get("poBbsList"));
			super.addOutDataSet(mav, "ds_limsBbsList", (RecordSet) rtn.get("limsBbsList"));
			super.addOutDataSet(mav, "ds_upjangSaleChart", (RecordSet) rtn.get("upjangSaleChart"));
			super.addOutDataSet(mav, "ds_upjangBondList", (RecordSet) rtn.get("upjangBondList"));
			super.addOutDataSet(mav, "ds_base_note", (RecordSet) rtn.get("weatherList"));
		}
		else if ("IntroFrameType10".equals(inVar.get("introFrameId").toString())) {
			super.addOutDataSet(mav, "ds_clearCheckList", (RecordSet) rtn.get("clearCheckList"));
			super.addOutDataSet(mav, "ds_quickList", (RecordSet) rtn.get("quickList"));
			super.addOutDataSet(mav, "ds_totalBbsList", (RecordSet) rtn.get("totalBbsList"));
			//super.addOutDataSet(mav, "ds_limsBbsList", (RecordSet) rtn.get("limsBbsList"));
			super.addOutDataSet(mav, "ds_tmSaleChart", (RecordSet) rtn.get("tmSaleChart"));
			super.addOutDataSet(mav, "ds_tmBondList", (RecordSet) rtn.get("tmBondList"));
			super.addOutDataSet(mav, "ds_base_note", (RecordSet) rtn.get("weatherList"));
		}
		else if ("IntroFrameType11".equals(inVar.get("introFrameId").toString())) {
			super.addOutDataSet(mav, "ds_wholeSaleList", (RecordSet) rtn.get("wholeSaleList"));
			super.addOutDataSet(mav, "ds_quickList", (RecordSet) rtn.get("quickList"));
			super.addOutDataSet(mav, "ds_totalBbsList", (RecordSet) rtn.get("totalBbsList"));
			super.addOutDataSet(mav, "ds_bbsList", (RecordSet) rtn.get("bbsList"));
		}
		//외식고객
//		else if ("IntroFrameType12".equals(inVar.get("introFrameId").toString())) {
//		}
		else if ("IntroFrameType13".equals(inVar.get("introFrameId").toString())) {
			super.addOutDataSet(mav, "ds_personalList", (RecordSet) rtn.get("personalList"));
			super.addOutDataSet(mav, "ds_quickList", (RecordSet) rtn.get("quickList"));
			super.addOutDataSet(mav, "ds_speedBbsList", (RecordSet) rtn.get("speedBbsList"));
			super.addOutDataSet(mav, "ds_totalBbsList", (RecordSet) rtn.get("totalBbsList"));
			super.addOutDataSet(mav, "ds_goodsBbsList", (RecordSet) rtn.get("goodsBbsList"));
			super.addOutDataSet(mav, "ds_fileBbsList", (RecordSet) rtn.get("fileBbsList"));
			//super.addOutDataSet(mav, "ds_creditList", (RecordSet) rtn.get("creditList"));
		}
		else if ("IntroFrameType14".equals(inVar.get("introFrameId").toString())) {
			super.addOutDataSet(mav, "ds_personalList", (RecordSet) rtn.get("personalList"));
			super.addOutDataSet(mav, "ds_quickList", (RecordSet) rtn.get("quickList"));
			super.addOutDataSet(mav, "ds_speedBbsList", (RecordSet) rtn.get("speedBbsList"));
			super.addOutDataSet(mav, "ds_totalBbsList", (RecordSet) rtn.get("totalBbsList"));
			super.addOutDataSet(mav, "ds_goodsBbsList", (RecordSet) rtn.get("goodsBbsList"));
			super.addOutDataSet(mav, "ds_fileBbsList", (RecordSet) rtn.get("fileBbsList"));
		}
		else if ("IntroFrameType15".equals(inVar.get("introFrameId").toString())) {
			super.addOutDataSet(mav, "ds_quickList", (RecordSet) rtn.get("quickList"));
			super.addOutDataSet(mav, "ds_creditList", (RecordSet) rtn.get("creditList"));
			super.addOutDataSet(mav, "ds_personalList", (RecordSet) rtn.get("personalList"));
			super.addOutDataSet(mav, "ds_totalBbsList", (RecordSet) rtn.get("totalBbsList"));
			//super.addOutDataSet(mav, "ds_speedBbsList", (RecordSet) rtn.get("speedBbsList"));
			super.addOutDataSet(mav, "ds_goodsBbsList", (RecordSet) rtn.get("goodsBbsList"));
		}
		else if ("IntroFrame_spoon".equals(inVar.get("introFrameId").toString())) {
			super.addOutDataSet(mav, "ds_quickList", (RecordSet) rtn.get("quickList"));
			super.addOutDataSet(mav, "ds_creditList", (RecordSet) rtn.get("creditList"));
			super.addOutDataSet(mav, "ds_personalList", (RecordSet) rtn.get("personalList"));
			super.addOutDataSet(mav, "ds_totalBbsList", (RecordSet) rtn.get("totalBbsList"));
			//super.addOutDataSet(mav, "ds_speedBbsList", (RecordSet) rtn.get("speedBbsList"));
			super.addOutDataSet(mav, "ds_goodsBbsList", (RecordSet) rtn.get("goodsBbsList"));
		}
		
		super.addOutDataSet(mav, "ds_mainImageFileName", (RecordSet) rtn.get("mainImageFileName"));

		// 전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	@RequestMapping("selectUpjangToMonthList.xdo")
	public ModelAndView selectUpjangToMonthList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO)
			throws Exception {
		// XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();
		// 조회 조건 파라미터를 얻는다.
		Map<String, Object> inVar = xpDTO.getInVariableMap();

		// 인트로 화면 을(를) 조회한다.
		Map<String, RecordSet> rtn = introFrameService.selectUpjangToMonthList(inVar);

		super.addOutDataSet(mav, "ds_upjangToMonthList", (RecordSet) rtn.get("upjangToMonthList"));
		super.addOutDataSet(mav, "ds_upjangTwoWeekChart", (RecordSet) rtn.get("upjangTwoWeekChart"));

		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	@RequestMapping("selectCreditList.xdo")
	public ModelAndView selectCreditList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO)
			throws Exception {
		// XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();
		// 조회 조건 파라미터를 얻는다.
		Map<String, Object> inVar = xpDTO.getInVariableMap();

		// 인트로 화면 을(를) 조회한다.
		Map<String, RecordSet> rtn = introFrameService.selectCreditList(inVar);

		super.addOutDataSet(mav, "ds_creditList", (RecordSet) rtn.get("creditList"));

		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	@RequestMapping("selectBudgetList.xdo")
	public ModelAndView selectBudgetList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO)
			throws Exception {
		// XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();
		// 조회 조건 파라미터를 얻는다.
		Map<String, Object> inVar = xpDTO.getInVariableMap();

		// 인트로 화면 을(를) 조회한다.
		Map<String, RecordSet> rtn = introFrameService.selectBudgetList(inVar);

		super.addOutDataSet(mav, "ds_budgetList", (RecordSet) rtn.get("budgetList"));

		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
}
