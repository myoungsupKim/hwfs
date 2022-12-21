package com.hwfs.rc.sle.web;

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
import com.hwfs.rc.sle.service.EodMgmtService;

 /**
 * EodMgmtController에 대한 설명 작성
 * @ClassName EodMgmtController.java
 * @Description EodMgmtController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 6. 15.   박대영        최초생성
 * </pre>
 * @author FC종합전산구축 : 외식영업(POS영업관리)
 * @since 2015. 6. 15.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/rc/sle/eodMgmt/")
public class EodMgmtController extends DefaultController {
	@Resource(name="/rc/sle/eodMgmtService")
	private EodMgmtService eodMgmt;
	
	//마감상태읽기
	@SuppressWarnings("unchecked")
	@RequestMapping("eodList.xdo")
	public ModelAndView eodList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		//ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Variable Parameter을 추출한다.
	 
		Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

		RecordSet rs = eodMgmt.eodList(parameter.get("ds_paramInfo").get(0));
		
		//개인정보보호 접근로그 조회 조건과 건수
		//accessLogService.readLog(parameter, rs.size());
		 
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_eodList", rs);

		//ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	//마감상태읽기
	@SuppressWarnings("unchecked")
	@RequestMapping("eodOfDayList.xdo")
	public ModelAndView eodOfDayList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		//ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Variable Parameter을 추출한다.
	 
		Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

		RecordSet rs = eodMgmt.endOfDayList(parameter.get("ds_paramInfo").get(0));
		
		//개인정보보호 접근로그 조회 조건과 건수
		//accessLogService.readLog(parameter, rs.size());
		 
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_eodOfDayList", rs);

		//ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	//마감상태읽기
	@SuppressWarnings("unchecked")
	@RequestMapping("eodAllList.xdo")
	public ModelAndView eodAllList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		//ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Variable Parameter을 추출한다.
	 
		Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

		RecordSet rs = eodMgmt.eodAllList(parameter.get("ds_paramInfo").get(0));
		
		//개인정보보호 접근로그 조회 조건과 건수
		//accessLogService.readLog(parameter, rs.size());
		 
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_eod", rs);

		//ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	//자재 인터페이스
	@SuppressWarnings("unchecked")
	@RequestMapping("fopostrInfo.xdo")
	public ModelAndView fopostrInfo(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		//ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Variable Parameter을 추출한다.
	 
		Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
		Map<String, Object> rs = eodMgmt.fopostrInfo(parameter.get("ds_paramInfo").get(0));
		
		//개인정보보호 접근로그 조회 조건과 건수
		//accessLogService.readLog(parameter, rs.size());
		
		
		
		rs.put("oRtn",    rs.get("O_RTN"));
		rs.put("oRtnmsg", rs.get("O_RTNMSG"));
		
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_fopostrInfo", rs);

		//ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	

	//매출정보전송
	@SuppressWarnings("unchecked")
	@RequestMapping("salesInfo.xdo")
	public ModelAndView salesInfo(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		//ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Variable Parameter을 추출한다.
		
		
		Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
		Map<String, Object> sendData   = parameter.get("ds_paramInfo").get(0);	
		//Map<String, Object> sendDataIf = parameter.get("ds_paramInfo").get(0);	
		Map<String, Object> rs = eodMgmt.salesInfo(sendData);
		//Map<String, Object> rsIf = eodMgmt.salesInfoIf(sendDataIf);
		 
		rs.put("oRtn",    rs.get("O_RTN"));
		rs.put("oRtnmsg", rs.get("O_RTNMSG"));
		
		//rs.put("oRtn",    rsIf.get("O_RTN"));
		//rs.put("oRtnmsg", rsIf.get("O_RTNMSG"));
		
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_salesInfo", rs);

		//ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}


	//매출상세정보전송
	@SuppressWarnings("unchecked")
	@RequestMapping("salesDetailInfo.xdo")
	public ModelAndView salesDetailInfo(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		//ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Variable Parameter을 추출한다.
	 
		Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
		Map<String, Object> rs = eodMgmt.salesDetailInfo(parameter.get("ds_paramInfo").get(0));
		//Map<String, Object> rsIf = eodMgmt.salesDetailInfoIf(parameter.get("ds_paramInfo").get(0));
		//개인정보보호 접근로그 조회 조건과 건수
		//accessLogService.readLog(parameter, rs.size());
		rs.put("oRtn",    rs.get("O_RTN"));
		rs.put("oRtnmsg", rs.get("O_RTNMSG"));
		//rs.put("oRtn",    rsIf.get("O_RTN"));
		//rs.put("oRtnmsg", rsIf.get("O_RTNMSG"));
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_salesDetailInfo", rs);

		//ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	


	//매출결제정보전송
	@SuppressWarnings("unchecked")
	@RequestMapping("salesPaymentInfo.xdo")
	public ModelAndView salesPaymentInfo(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		//ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Variable Parameter을 추출한다.
	 
		Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
		Map<String, Object> rs = eodMgmt.salesPaymentInfo(parameter.get("ds_paramInfo").get(0));
		//Map<String, Object> rsIf = eodMgmt.salesPaymentInfoIf(parameter.get("ds_paramInfo").get(0));
		//개인정보보호 접근로그 조회 조건과 건수
		//accessLogService.readLog(parameter, rs.size());
		rs.put("oRtn",    rs.get("O_RTN"));
		rs.put("oRtnmsg", rs.get("O_RTNMSG"));
		//rs.put("oRtn",    rsIf.get("O_RTN"));
		//rs.put("oRtnmsg", rsIf.get("O_RTNMSG"));
		
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_salesPaymentInfo", rs);

		//ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	


	//카드승인정보전송
	@SuppressWarnings("unchecked")
	@RequestMapping("cardApprovalInfo.xdo")
	public ModelAndView cardApprovalInfo(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		//ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Variable Parameter을 추출한다.
	 
		Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
		Map<String, Object> rs = eodMgmt.cardApprovalInfo(parameter.get("ds_paramInfo").get(0));
		//Map<String, Object> rsIf =  eodMgmt.cardApprovalInfoIf(parameter.get("ds_paramInfo").get(0));
		//개인정보보호 접근로그 조회 조건과 건수
		//accessLogService.readLog(parameter, rs.size());
		rs.put("oRtn",    rs.get("O_RTN"));
		rs.put("oRtnmsg", rs.get("O_RTNMSG"));
		//rs.put("oRtn",    rsIf.get("O_RTN"));
		//rs.put("oRtnmsg", rsIf.get("O_RTNMSG"));
		
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "cardApprovalInfo", rs);

		//ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	

	//매출집계
	@SuppressWarnings("unchecked")
	@RequestMapping("salesSum.xdo")
	public ModelAndView salesSum(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		//ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Variable Parameter을 추출한다.
	 
		Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
		Map<String, Object> rs = eodMgmt.salesSum(parameter.get("ds_paramInfo").get(0));
		//Map<String, Object> rsIf = eodMgmt.salesSumIf(parameter.get("ds_paramInfo").get(0));
		//개인정보보호 접근로그 조회 조건과 건수
		//accessLogService.readLog(parameter, rs.size());
		
		rs.put("oRtn",    rs.get("O_RTN"));
		rs.put("oRtnmsg", rs.get("O_RTNMSG"));
		//rs.put("oRtn",    rsIf.get("O_RTN"));
		//rs.put("oRtnmsg", rsIf.get("O_RTNMSG"));
		
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_sumInfo", rs);

		//ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

    
	//시간대별집계
	@SuppressWarnings("unchecked")
	@RequestMapping("timeSum.xdo")
	public ModelAndView timeSum(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		//ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Variable Parameter을 추출한다.
	 
		Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
		Map<String, Object> rs = eodMgmt.timeSum(parameter.get("ds_paramInfo").get(0));
		//Map<String, Object> rsIf = eodMgmt.timeSumIf(parameter.get("ds_paramInfo").get(0));
		//개인정보보호 접근로그 조회 조건과 건수
		//accessLogService.readLog(parameter, rs.size());
		
		
		
		rs.put("oRtn",    rs.get("O_RTN"));
		rs.put("oRtnmsg", rs.get("O_RTNMSG"));
		
		//rs.put("oRtn",    rsIf.get("O_RTN"));
		//rs.put("oRtnmsg", rsIf.get("O_RTNMSG"));
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_timeSumInfo", rs);

		//ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	//메뉴집계
	@SuppressWarnings("unchecked")
	@RequestMapping("menuSum.xdo")
	public ModelAndView menuSum(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		//ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Variable Parameter을 추출한다.
	 
		Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
		Map<String, Object> rs = eodMgmt.menuSum(parameter.get("ds_paramInfo").get(0));
		//Map<String, Object> rsIf = eodMgmt.menuSumIf(parameter.get("ds_paramInfo").get(0));
		
		//개인정보보호 접근로그 조회 조건과 건수
		//accessLogService.readLog(parameter, rs.size());
		
		
		
		rs.put("oRtn",    rs.get("O_RTN"));
		rs.put("oRtnmsg", rs.get("O_RTNMSG"));
		
		//rs.put("oRtn",    rsIf.get("O_RTN"));
		//rs.put("oRtnmsg", rsIf.get("O_RTNMSG"));
		
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_menuSumInfo", rs);

		//ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	//할인집계
	@SuppressWarnings("unchecked")
	@RequestMapping("discnSum.xdo")
	public ModelAndView discnSum(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		//ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Variable Parameter을 추출한다.
	 
		Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
		Map<String, Object> rs = eodMgmt.discnSum(parameter.get("ds_paramInfo").get(0));
		
		//개인정보보호 접근로그 조회 조건과 건수SLE_DISCNSUM_PRO
		//accessLogService.readLog(parameter, rs.size());
 
		rs.put("oRtn", rs.get("O_RTN"));
		rs.put("oRtnmsg", rs.get("O_RTNMSG"));
		
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_discnSumInfo", rs);

		//ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	//연세대 매출 인터페이스
	@SuppressWarnings("unchecked")
	@RequestMapping("boInterface.xdo")
	public ModelAndView boInterface(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		//ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Variable Parameter을 추출한다.
	 
		Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
		Map<String, Object> rs = eodMgmt.boInterface(parameter.get("ds_paramInfo").get(0));
		
		//개인정보보호 접근로그 조회 조건과 건수SLE_DISCNSUM_PRO
		//accessLogService.readLog(parameter, rs.size());
 
		rs.put("oRtn", rs.get("O_RTN"));
		rs.put("oRtnmsg", rs.get("O_RTNMSG"));
		
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_boSumInfo", rs);

		//ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
}
