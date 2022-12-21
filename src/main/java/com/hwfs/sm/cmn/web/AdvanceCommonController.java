package com.hwfs.sm.cmn.web;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;
import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.DataSetMap;
import hone.online.xplatform.map.XplatformMapDTO;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.sm.cmn.service.AdvanceCommonService;


 /**
 * 선수금정보 공통 AdvanceCommon Controller
 * 
 * @ClassName AdvanceCommonController.java
 * @Description AdvanceCommonController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.29    JUN        최초생성
 * </pre>
 * @author FC종합전산구축 :  통합영업 JUN
 * @since 2015.04.29
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/sm/cmn/advanceCommon/")
public class AdvanceCommonController extends DefaultController {
	
	/** AdvanceCommonService Bean 생성 */
	@Resource(name = "/sm/cmn/advanceCommonService")
	private AdvanceCommonService advanceCommonService;
	
	/**
	 * 선수금정보 조회
	 * @return ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("selectAdvanceMst.xdo")
	public ModelAndView selectAdvanceMst(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		Map<String, Object> parameter = param.get("ds_search").get(0);
		
		RecordSet rs = advanceCommonService.selectAdvanceMst(parameter);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 선수금 환불 대상 정보 조회
	 * @return ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("selectAdvanceRefundMst.xdo")
	public ModelAndView selectAdvanceRefundMst(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		Map<String, Object> parameter = param.get("ds_search").get(0);
		
		RecordSet rs = advanceCommonService.selectAdvanceRefundMst(parameter);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 선수금 대체 정보 조회(조회조건)
	 * @return ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectAdvanceAltMst.xdo")
	public ModelAndView selectAdvanceAltMst(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, Object> inVar = xpDTO.getInVariableMap();
		
		RecordSet rs = advanceCommonService.selectAdvanceAltMst(inVar);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_search", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 선수금 입금수단 조회
	 * @return ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("selectAdvanceReceiveWay.xdo")
	public ModelAndView selectAdvanceReceiveWay(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, DataSetMap> inVar = xpDTO.getInDataSetMap();
		
		RecordSet rs = advanceCommonService.selectAdvanceReceiveWay(inVar.get("ds_search").get(0));

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_view", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 선수금대체처리(을)를 처리한다.(이관 포함)
	 * @param xpDto XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
	@RequestMapping("setAdvanceAltProc.xdo")
	public ModelAndView setAdvanceAltProc(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameterMst = param.get("ds_search");
		DataSetMap parameterDtl = param.get("ds_list");

		//선수금대체처리
		int processCnt = advanceCommonService.setAdvanceAltProc(parameterMst, parameterDtl);

		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 선수금대체처리(을)를 처리한다.(이관전 등록)
	 * @param xpDto XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
	@RequestMapping("setAdvanceAltProcReq.xdo")
	public ModelAndView setAdvanceAltProcReq(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameterMst = param.get("ds_search");
		DataSetMap parameterDtl = param.get("ds_list");

		//선수금대체처리
		int processCnt = advanceCommonService.setAdvanceAltProcReq(parameterMst, parameterDtl);

		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 전자결재정보를 Update 처리한다.
	 * <pre>
	 * - 업무 테이블에 Instance ID Update
	 * - 결재정보 공통 테이블에 결재정보 Insert or Update
	 * </pre>
	 *
	 * @param xpDTO
	 * @param req
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "saveSignInfo.xdo")
	public ModelAndView saveSignInfo(
			@Bind(id="", type=XplatformMapDTO.class)XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_list");

		advanceCommonService.saveSignInfo(parameter);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 선수금대체취소 처리(을)를 처리한다.(이관 포함)
	 * @param xpDto XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
	@RequestMapping("setAdvanceAltCancel.xdo")
	public ModelAndView setAdvanceAltCancel(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameterMst = param.get("ds_search");
		DataSetMap parameterDtl = param.get("ds_list");
		
		//선수금대체취소
		int processCnt = advanceCommonService.setAdvanceAltCancel(parameterMst, parameterDtl);

		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 재이관 여부 체크
	 * @return ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("chkAdvanceTransInfo.xdo")
	public ModelAndView chkAdvanceTransInfo(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, Object> inVar = xpDTO.getInVariableMap();
		
		RecordSet rs = advanceCommonService.chkAdvanceTransInfo(inVar);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_chkAdvanceTransInfo", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}


	/**
	 * 이관취소 가능여부
	 * @return ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("chkAdvanceTransCancel.xdo")
	public ModelAndView chkAdvanceTransCancel(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, Object> inVar = xpDTO.getInVariableMap();
		
		RecordSet rs = advanceCommonService.chkAdvanceTransCancel(inVar);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_chkAdvanceTransCancel", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 선수금잔액 조회
	 * @return ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("selectTotalAdvanceAmt.xdo")
	public ModelAndView selectTotalAdvanceAmt(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		Map<String, Object> parameter = param.get("ds_search").get(0);
		
		RecordSet rs = advanceCommonService.selectTotalAdvanceAmt(parameter);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 선수금환불처리(을)를 처리한다.(식권 포함)
	 * @param xpDto XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
	@RequestMapping("setAdvanceRefundProc.xdo")
	public ModelAndView setAdvanceRefundProc(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
	
		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();

		DataSetMap parameterMst = param.get("ds_search");
		DataSetMap parameterDtl = param.get("ds_list");
		DataSetMap parameterTicket = param.get("ds_masTicketMst");
	
		//선수금이관처리
		int processCnt = advanceCommonService.setAdvanceRefundProc(parameterMst, parameterDtl, parameterTicket);
	
		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);
	
		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 선수금환불 취소처리한다.(식권 포함)
	 * @param xpDto XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
	@RequestMapping("setAdvanceRefundCancel.xdo")
	public ModelAndView setAdvanceRefundCancel(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameterMst = param.get("ds_search");
		DataSetMap parameterDtl = param.get("ds_list");
		
		//선수금대체취소
		int processCnt = advanceCommonService.setAdvanceRefundCancel(parameterMst, parameterDtl);

		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 선수금이관처리(을)를 처리한다.(식권 포함)
	 * @param xpDto XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
	@RequestMapping("setAdvanceTransProc.xdo")
	public ModelAndView setAdvanceTransProc(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
	
		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();

		DataSetMap parameterMst = param.get("ds_search");
		DataSetMap parameterDtl = param.get("ds_list");
		DataSetMap parameterTicket = param.get("ds_masTicketMst");
	
		//선수금이관처리
		int processCnt = advanceCommonService.setAdvanceTransProc(parameterMst, parameterDtl, parameterTicket);
	
		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);
	
		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 선수금이관 취소처리한다.(식권 포함)
	 * @param xpDto XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
	@RequestMapping("setAdvanceTransCancel.xdo")
	public ModelAndView setAdvanceTransCancel(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameterMst = param.get("ds_search");
		DataSetMap parameterDtl = param.get("ds_list");
		
		//선수금대체취소
		int processCnt = advanceCommonService.setAdvanceTransCancel(parameterMst, parameterDtl);

		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 선수금잔액 체크
	 * @return ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("getAdvanceAltYn.xdo")
	public ModelAndView getAdvanceAltYn(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_list");
		
		String advanceAltYn = advanceCommonService.getAdvanceAltYn(parameter);

		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_advanceAltYn", advanceAltYn);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}		
	

	/**
	 * 전자결재의 본문을 생성한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param request
	 * @param model
	 * @param chgSrlnum
	 * @param strBodyTitle
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "makeGwDraftContent.do")
    public ModelAndView makeGwDraftContent(HttpServletRequest request, Model model,
          //  @RequestParam(value = "requestNums", required = true) String requestNums,
    		@RequestParam(value = "muNm", required = true) String muNm,
    		@RequestParam(value = "ccNm", required = true) String ccNm,
    		@RequestParam(value = "tDate", required = true) String tDate,
    		@RequestParam(value = "advGubun", required = true) String advGubun,
    		@RequestParam(value = "transType", required = true) String transType,
    		@RequestParam(value = "amt", required = true) String amt,
    		@RequestParam(value = "fromCust", required = true) String fromCust,
    		@RequestParam(value = "toCust", required = true) String toCust,
    		@RequestParam(value = "fromCc", required = true) String fromCc,
    		@RequestParam(value = "toCc", required = true) String toCc,
    		@RequestParam(value = "remark", required = true) String remark,
            @RequestParam(value = "gName", required = true) String gName,
            @RequestParam(value = "sabun", required = true) String sabun,
            @RequestParam(value = "title", required = false, defaultValue = "") String strBodyTitle) throws Exception {

		/*
		List<Object> l = new ArrayList<Object>();
		String[] requestNum = requestNums.split(",");
		
		for (int i = 0 ; i < requestNum.length ; i++) {
			l.add(requestNum[i]);
		}
		*/
		System.out.println("### 신청자:"+sabun+"(" + gName + ")");	
		System.out.println("### 사업부:"+muNm);		
		System.out.println("### 발생CC:"+ccNm);		
		System.out.println("### 이관일자:"+tDate);		
		System.out.println("### 선수금유형:"+advGubun);		
		System.out.println("### 이관유형:"+transType);		
		System.out.println("### 이관금액:"+amt);		
		System.out.println("### From거래처:"+fromCust);		
		System.out.println("### To거래처:"+toCust);		
		System.out.println("### From CC:"+fromCc);		
		System.out.println("### To CC:"+toCc);		
		System.out.println("### 비고:"+remark);			
		
        //상신 본문 데이터를 조회 - 업무에 맞게 조회
        Map<String, Object> parameter = new HashMap<String, Object>();
        parameter.put("requestNums", "112233");
        parameter.put("sabun", "Z9952396");
        
        //Map<String, Object> datas = advanceCommonService.selectGwContent(parameter);
        
        //parameter.put("requestNums", requestNums);
//        Record rs = authChngRequestService.selectGwDraftMst(parameter); // 마스터을 조회한다.

        model.addAttribute("muNm", muNm);   			//사업부
        model.addAttribute("ccNm", ccNm);				//발생CC
        model.addAttribute("tDate", tDate);				//이관일자
        model.addAttribute("advGubun", advGubun);		//선수금유형
        model.addAttribute("transType", transType);		//이관유형
        model.addAttribute("amt", amt);					//이관금액
        model.addAttribute("fromCust", fromCust);		//From거래처
        model.addAttribute("toCust", toCust);			//To거래처
        model.addAttribute("fromCc", fromCc);			//From CC
        model.addAttribute("toCc", toCc);				//To CC
        model.addAttribute("remark", remark);        	//비고
        model.addAttribute("gwDraftSendUser", gName);	//신청자명
        model.addAttribute("sabun", sabun);				//신청자사번
        model.addAttribute("gwDraftTitle", "선수금이관 신청");

        //본문을 생성하는 JSP 호출 AdTransRequestGwDraft.jsp
        String path = "/gw/spm/AdTransRequestGwDraft"; 

        return new ModelAndView(path);
    }
	
}
