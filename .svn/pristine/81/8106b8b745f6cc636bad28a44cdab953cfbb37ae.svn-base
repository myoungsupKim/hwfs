package com.hwfs.guide.sample.service;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sc.cmn.sap.EAIRequest;
import com.hwfs.sc.cmn.sap.EAIResponse;
import com.hwfs.sc.cmn.sap.request.CorpCardInqueryRequest;
import com.hwfs.sc.cmn.sap.request.ElctnTaxShetInqueryRequest;
import com.hwfs.sc.cmn.sap.request.InOutDescRequest;
import com.hwfs.sc.cmn.sap.request.RestBudgetInqueryRequest;
import com.hwfs.sc.cmn.sap.request.SuspenseAltRequest;
import com.hwfs.sc.cmn.sap.request.SuspenseInqueryRequest;
import com.hwfs.sc.cmn.sap.request.SuspenseLogInqueryRequest;
import com.hwfs.sc.cmn.sap.request.YearBudgetInqueryRequest;
import com.hwfs.sc.cmn.sap.service.EAIService;

/**
 * EAI 호출 샘플하는 EAISample Service Implementation
 *
 * @ClassName EAISampleServiceImpl.java
 * @Description EAISampleServiceImpl Class
 * @Modification-Information <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.10    김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.04.10
 * @version 1.0
 * @see <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/guide/sample/EAISampleService")
public class EAISampleServiceImpl extends DefaultServiceImpl implements
		EAISampleService {

	/** LogService */
	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	@Resource(name = "EAIService")
	EAIService eaiService;

	/**
	 * 가수금 조회
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 조회결과
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectSuspenseInquery(
			Map<String, Object> mapParam) throws Exception {
		List<Map<String, Object>> list = null;
		SuspenseInqueryRequest dto = new SuspenseInqueryRequest();

		if (mapParam.containsKey("buCd"))
			dto.setBuCd(mapParam.get("buCd").toString());
		if (mapParam.containsKey("susNo"))
			dto.setSuspenseNum(mapParam.get("susNo").toString());
		if (mapParam.containsKey("startDt"))
			dto.setStartDate(mapParam.get("startDt").toString());
		if (mapParam.containsKey("endDt"))
			dto.setEndDate(mapParam.get("endDt").toString());
		if (mapParam.containsKey("ccCd"))
			dto.setCcCd(mapParam.get("ccCd").toString());
		if (mapParam.containsKey("muCd"))
			dto.setCcCd(mapParam.get("muCd").toString());
		if (mapParam.containsKey("bankAcctNo"))
			dto.setCcCd(mapParam.get("bankAcctNo").toString());
		if (mapParam.containsKey("receiveGuestNm"))
			dto.setCcCd(mapParam.get("receiveGuestNm").toString());
		if (mapParam.containsKey("closeYn"))
			dto.setCcCd(mapParam.get("closeYn").toString());

		// EAI를 호출하여 결과를 수신한다.
		EAIResponse res = eaiService.call(dto);

		if (res.isSuccess()) {
			list = res.getListMap();
		} else {
			// TODO :: 결과가 없거나 에러인 경우에 아래를 적절히 코딩하세요....
			logger.debug(res.getErrorCode() + " / " + res.getErrorMsg());
			if (res.getErrorCode() == -1) {
				logger.debug("조회된 결과가 없습니다.");
			} else {
				throw super.processException("eai.exception");
			}
		}

		return list;
	}

	/**
	 * 가수금 상세(히스토리) 조회
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 * @see com.hwfs.guide.sample.service.EAISampleService#selectSuspenseLogInquery(java.util.Map)
	 */
	public List<Map<String, Object>> selectSuspenseLogInquery(
			Map<String, Object> mapParam) throws Exception {
		List<Map<String, Object>> list = null;
		SuspenseLogInqueryRequest dto = new SuspenseLogInqueryRequest();

		if (mapParam.containsKey("buCd"))
			dto.setBuCd(mapParam.get("buCd").toString());
		if (mapParam.containsKey("susNo"))
			dto.setSuspenseNum(mapParam.get("susNo").toString());

		// EAI를 호출하여 결과를 수신한다.
		EAIResponse res = eaiService.call(dto);

		if (res.isSuccess()) {
			list = res.getListMap();
		} else {
			// TODO :: 결과가 없거나 에러인 경우에 아래를 적절히 코딩하세요....
			logger.debug(res.getErrorCode() + " / " + res.getErrorMsg());
			if (res.getErrorCode() == -1) {
				logger.debug("조회된 결과가 없습니다.");
			} else {
				throw super.processException("eai.exception");
			}
		}

		return list;
	}

	/**
	 * processSuspenseAltRequest 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 * @see com.hwfs.guide.sample.service.EAISampleService#processSuspenseAltRequest(java.util.Map)
	*/
	@Override
	public Map<String, Object> processSuspenseAltRequest(
			Map<String, Object> mapParam) throws Exception {
		Map<String, Object> rtn = new HashMap<String, Object>();
		SuspenseAltRequest dto = new SuspenseAltRequest();

		if (mapParam.containsKey("buCd")) dto.setBuCd(mapParam.get("buCd").toString());
		if (mapParam.containsKey("suspenseNum")) dto.setSuspenseNum(mapParam.get("suspenseNum").toString());
		if (mapParam.containsKey("altBuCd")) dto.setAltBuCd(mapParam.get("altBuCd").toString());
		if (mapParam.containsKey("ccCd")) dto.setCcCd(mapParam.get("ccCd").toString());
		if (mapParam.containsKey("currency")) dto.setCurrency(mapParam.get("currency").toString());
		if (mapParam.containsKey("altAmt")) dto.setAltAmt((BigDecimal)mapParam.get("altAmt") );
		if (mapParam.containsKey("sabun")) dto.setSabun(mapParam.get("sabun").toString());

		// EAI를 호출하여 결과를 수신한다.
		EAIResponse res = eaiService.call(dto);

		if (res.isSuccess()) {
			rtn = res.getMap();
		} else {
			// TODO :: 결과가 없거나 에러인 경우에 아래를 적절히 코딩하세요....
			logger.debug(res.getErrorCode() + " / " + res.getErrorMsg());
			if (res.getErrorCode() == -1) {
				logger.debug("조회된 결과가 없습니다.");
			} else {
				throw super.processException("eai.exception");
			}
		}

		return rtn;
	}

	/**
	 * selectSuspenseAltRequest 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 * @see com.hwfs.guide.sample.service.EAISampleService#selectSuspenseAltRequest(java.util.Map)
	*/
	@Override
	public List<Map<String, Object>> selectSuspenseAltResult(
			Map<String, Object> mapParam) throws Exception {
		List<Map<String, Object>> list = null;

		Map<String, Object> map = null;

// 	 	/* ******************************************************************************* */
//		/* 법인카드이용내역                                                                */
//		/* ******************************************************************************* */
//		CorpCardInqueryRequest request = new CorpCardInqueryRequest();
//		
//		request.setiFrdat("20150101");
//		request.setiTodat("20151001");
//		request.setiCardno("4265866777900024");
//		
//		EAIResponse res = eaiService.call(request);
//		
//		if (res.isSuccess()) {
//			//map = res.getMap();
//			list = res.getListMap();
//		} else {
//			logger.debug(res.getErrorCode() + " / " + res.getErrorMsg());
//			if (res.getErrorCode() == -1) {
//				logger.debug("조회된 결과가 없습니다.");
//			} else {
//				throw super.processException("eai.exception");	
//			}
//		}
//		
//		return list;
//		
//		
// 	 	/* ******************************************************************************* */
//		/* 잔여예산조회                                                                    */
//		/* ******************************************************************************* */
//		RestBudgetInqueryRequest request = new RestBudgetInqueryRequest();
//		
//		request.setCcFg("");
//		request.setCctrCd("");
//		request.setIoCd("");
//		request.setAcctCd("");
//		request.setYymmdd("");
//		
//		EAIResponse res = eaiService.call(request);
//		
//		if (res.isSuccess()) {
//			map = res.getMap();
//		} else {
//			logger.debug(res.getErrorCode() + " / " + res.getErrorMsg());
//			if (res.getErrorCode() == -1) {
//				logger.debug("조회된 결과가 없습니다.");
//			} else {
//				throw super.processException("eai.exception");	
//			}
//		}
//		
//		return list;
		
// 	 	/* ******************************************************************************* */
//		/* 연간예산조회                                                                    */
//		/* ******************************************************************************* */
//		YearBudgetInqueryRequest request = new YearBudgetInqueryRequest();
//		
//		//request.setCompCd("2000");
//		request.setInqYy("2015");
//		request.setCctrCd("310120");
//		request.setIoCd("");
//		request.setAcctCd("43215020");
//		
//		EAIResponse res = eaiService.call(request);
//		
//		if (res.isSuccess()) {
//			list = res.getListMap();
//		} else {
//			logger.debug(res.getErrorCode() + " / " + res.getErrorMsg());
//			if (res.getErrorCode() == -1) {
//				logger.debug("조회된 결과가 없습니다.");
//			} else {
//				throw super.processException("eai.exception");	
//			}
//		}
//		
//		return list;

		
		/* ******************************************************************************* */
		/* 전자세금계산서 조회 (식재도매용)                                                */
		/* ******************************************************************************* */
		
		ElctnTaxShetInqueryRequest request = new ElctnTaxShetInqueryRequest();
		
		request.setBukrs("1000");
		request.setSuName("갤러리아");
		request.setFrDate("20150603");
		request.setToDate("20150603");
		request.setDeptId("");
		request.setStatsCd("");
		
		EAIResponse res = eaiService.call(request);
		
		if (res.isSuccess()) {
			list = res.getListMap();
		} else {
			logger.debug(res.getErrorCode() + " / " + res.getErrorMsg());
			if (res.getErrorCode() == -1) {
				logger.debug("조회된 결과가 없습니다.");
			} else {
				throw super.processException("eai.exception");	
			}
		}
		return list;
		
//		/* ******************************************************************************* */
//		/* [[고정자산 조회 */
//		/* ******************************************************************************* */
//		FixedAssetsRequest dto = new FixedAssetsRequest();
//		
//		dto.setBuCd("2000");
//		dto.setAsstCls("1111");
//		dto.setAsstNm("1111");
//		dto.setAsstNo("1111");
//		dto.setCcCd("310000");
//		dto.setFrErdat("20150731");
//		dto.setToErdat("20150731");
//		dto.setFrAktiv("20150731");
//		dto.setToAktiv("20150731");
//		
//		EAIResponse res = eaiService.call(dto);
//		
//		if (res.isSuccess()) {
//			list = res.getListMap();
//		} else {
//			// TODO :: 결과가 없거나 에러인 경우에 아래를 적절히 코딩하세요....
//			logger.debug(res.getErrorCode() + " / " + res.getErrorMsg());
//			if (res.getErrorCode() == -1) {
//				logger.debug("조회된 결과가 없습니다.");
//			} else {
//				throw super.processException("eai.exception");	
//			}
//		}
//		/* ******************************************************************************* */
//		/* 고정자산 조회]] */
//		/* ******************************************************************************* */

		
//		/* ******************************************************************************* */
//		/* [[구매 및 입출고 내역 */
//		/* ******************************************************************************* */
//		List<EAIRequest> inOutDescRequestList = new ArrayList<EAIRequest>();
//		
//		InOutDescRequest inOutDescRequest1 = new InOutDescRequest();
//		inOutDescRequest1.setTyp("1");
//		inOutDescRequest1.setDocNo("2");
//		inOutDescRequest1.setDocLno("3");
//		inOutDescRequest1.setPoClose("4");
//		inOutDescRequest1.setPoCancl("N");
//		inOutDescRequest1.setSlipYn("N");
//		inOutDescRequest1.setCcCd("7");
//		inOutDescRequest1.setIoNo("8");
//		inOutDescRequest1.setAccCd("9");
//		inOutDescRequest1.setQty(BigDecimal.valueOf(1));
//		inOutDescRequest1.setUnit("10");
//		inOutDescRequest1.setUPrice(BigDecimal.valueOf(1));
//		inOutDescRequest1.setAmt(BigDecimal.valueOf(1));
//		inOutDescRequest1.setCur("11");
//		inOutDescRequest1.setRegDt("12");
//		inOutDescRequest1.setGrFDt("13");
//		inOutDescRequest1.setMvt("14");
//		inOutDescRequest1.setPrNo("15");
//		inOutDescRequest1.setPrLno("16");
//		inOutDescRequest1.setPoNo("17");
//		inOutDescRequest1.setPoLno("18");
//		
//		InOutDescRequest inOutDescRequest2 = new InOutDescRequest();
//		inOutDescRequest2.setTyp("1");
//		inOutDescRequest2.setDocNo("2");
//		inOutDescRequest2.setDocLno("3");
//		inOutDescRequest2.setPoClose("4");
//		inOutDescRequest2.setPoCancl("5");
//		inOutDescRequest2.setSlipYn("6");
//		inOutDescRequest2.setCcCd("7");
//		inOutDescRequest2.setIoNo("8");
//		inOutDescRequest2.setAccCd("9");
//		inOutDescRequest2.setQty(BigDecimal.valueOf(1));
//		inOutDescRequest2.setUnit("10");
//		inOutDescRequest2.setUPrice(BigDecimal.valueOf(1));
//		inOutDescRequest2.setAmt(BigDecimal.valueOf(1));
//		inOutDescRequest2.setCur("11");
//		inOutDescRequest2.setRegDt("12");
//		inOutDescRequest2.setGrFDt("13");
//		inOutDescRequest2.setMvt("14");
//		inOutDescRequest2.setPrNo("15");
//		inOutDescRequest2.setPrLno("16");
//		inOutDescRequest2.setPoNo("17");
//		inOutDescRequest2.setPoLno("18");
//
//		inOutDescRequestList.add(inOutDescRequest1);
//		inOutDescRequestList.add(inOutDescRequest2);
//		
//		EAIResponse res = eaiService.call(inOutDescRequestList);
//		
//		if (res.isSuccess()) {
//			list = res.getListMap();
//		} else {
//			// TODO :: 결과가 없거나 에러인 경우에 아래를 적절히 코딩하세요....
//			logger.debug(res.getErrorCode() + " / " + res.getErrorMsg());
//			if (res.getErrorCode() == -1) {
//				logger.debug("조회된 결과가 없습니다.");
//			} else {
//				throw super.processException("eai.exception");	
//			}
//		}
		
		/* ******************************************************************************* */
		/* 구매 및 입출고 내역]] */
		/* ******************************************************************************* */
		
//
//		SuspenseAltResult dto = new SuspenseAltResult();
//
//		if (mapParam.containsKey("sabun"))
//			dto.setSabun(mapParam.get("sabun").toString());
//		if (mapParam.containsKey("reqDateStart"))
//			dto.setReqDateStart(mapParam.get("reqDateStart").toString());
//		if (mapParam.containsKey("reqDateEnd"))
//			dto.setReqDateEnd(mapParam.get("reqDateEnd").toString());
//		if (mapParam.containsKey("sapProcStatus"))
//			dto.setSapProcStatus(mapParam.get("sapProcStatus").toString());
//
//		// EAI를 호출하여 결과를 수신한다.
//		EAIResponse res = eaiService.call(dto);
//
//		if (res.isSuccess()) {
//			list = res.getListMap();
//		} else {
//			// TODO :: 결과가 없거나 에러인 경우에 아래를 적절히 코딩하세요....
//			logger.debug(res.getErrorCode() + " / " + res.getErrorMsg());
//			if (res.getErrorCode() == -1) {
//				logger.debug("조회된 결과가 없습니다.");
//			} else {
//				throw super.processException("eai.exception");
//			}
//		}

/*
		List<EAIRequest> l = new ArrayList<EAIRequest>();

		for (int i=0 ; i < 10 ; i++) {
			SuspenseReceiveRequest dto = new SuspenseReceiveRequest();
			dto.setBuCd("200"+i);
			l.add(dto);
		}

		// EAI를 호출하여 결과를 수신한다.
		EAIResponse res = eaiService.call(l);
*/

/* 김태윤 책임님은 이부분을 확인하세요.
		List<AcctPlanReqDTO> lst = new ArrayList<AcctPlanReqDTO>();
		AcctPlanReqDTO acctPlanReqDTO01 = new AcctPlanReqDTO();
		acctPlanReqDTO01.setPlanClass("aa");
		acctPlanReqDTO01.setPlanYear("2015");
		acctPlanReqDTO01.setVerCd("11");
		acctPlanReqDTO01.setCcCd("aaa");
		acctPlanReqDTO01.setJobGradeCd("cc");
		acctPlanReqDTO01.setAcctCd("111111");

		lst.add(acctPlanReqDTO01);

		AcctPlanReqDTO acctPlanReqDTO02 = new AcctPlanReqDTO();
		acctPlanReqDTO02.setPlanClass("bb");
		acctPlanReqDTO02.setPlanYear("2015");
		acctPlanReqDTO02.setVerCd("2");
		acctPlanReqDTO02.setCcCd("a");
		acctPlanReqDTO02.setJobGradeCd("dd");
		acctPlanReqDTO02.setAcctCd("11121");

		lst.add(acctPlanReqDTO02);

		AcctPlanReqList acctPlanReqList = new AcctPlanReqList();
		acctPlanReqList.setDataList(lst);

		EAIResponse res = eaiService.call(acctPlanReqList);

		if (res.isSuccess()) {
			//TODO :: 성공에 대하여 적절히 코딩하세요.
			//list = res.getListMap();
		} else {
			// TODO :: 결과가 없거나 에러인 경우에 아래를 적절히 코딩하세요....
			logger.debug(res.getErrorCode() + " / " + res.getErrorMsg());
		}
*/

//전자세금계산서 상태변경
//		List<ElctnTaxShetStatusSendDTO> lst = new ArrayList<ElctnTaxShetStatusSendDTO>();
//		ElctnTaxShetStatusSendDTO dto01 = new ElctnTaxShetStatusSendDTO();
//		dto01.setTaxShetNum("11");
//		dto01.setChgRequestDate("11");
//		dto01.setWriteDate("11");
//		dto01.setChgRequestCd("11");
//		dto01.setSendDdtt("11");
//		dto01.setSendStatusCd("11");
//		dto01.setSendDetailInfo("11");
//		dto01.setStatusProcDdtt("11");
//		dto01.setSendcpnyCd("11");
//		dto01.setSendcpnyBizCd("11");
//		dto01.setRequesterId("11");
//		dto01.setCreationDate("11");
//		dto01.setCreationTime("11");
//		dto01.setCreationName("11");
//		dto01.setModifyDate("11");
//		dto01.setModifyTime("11");
//		dto01.setModifyName("11");
//		dto01.setResultCd("11");
//		dto01.setResultMsg("11");
//		dto01.setPistat("A");
//
//		lst.add(dto01);
//
//		ElctnTaxShetStatusSendDTO dto02 = new ElctnTaxShetStatusSendDTO();
//		dto02.setTaxShetNum("12");
//		dto02.setChgRequestDate("12");
//		dto02.setWriteDate("12");
//		dto02.setChgRequestCd("12");
//		dto02.setSendDdtt("12");
//		dto02.setSendStatusCd("12");
//		dto02.setSendDetailInfo("12");
//		dto02.setStatusProcDdtt("12");
//		dto02.setSendcpnyCd("12");
//		dto02.setSendcpnyBizCd("12");
//		dto02.setRequesterId("12");
//		dto02.setCreationDate("12");
//		dto02.setCreationTime("12");
//		dto02.setCreationName("12");
//		dto02.setModifyDate("12");
//		dto02.setModifyTime("12");
//		dto02.setModifyName("12");
//		dto02.setResultCd("12");
//		dto02.setResultMsg("12");
//		dto02.setPistat("A");
//
//		lst.add(dto02);
//
//		ElctnTaxShetStatusSendList elctnTaxShetStatusSendList = new ElctnTaxShetStatusSendList();
//		elctnTaxShetStatusSendList.setDataList(lst);
//
//		EAIResponse res = eaiService.call(elctnTaxShetStatusSendList);
//
//		if (res.isSuccess()) {
//			//TODO :: 성공에 대하여 적절히 코딩하세요.
//			//list = res.getListMap();
//		} else {
//			// TODO :: 결과가 없거나 에러인 경우에 아래를 적절히 코딩하세요....
//			logger.debug(res.getErrorCode() + " / " + res.getErrorMsg());
//		}

/*
		계좌송신
		List<Map<String, Object>> list = null;
		BankAcctNoRequest dto = new BankAcctNoRequest();

		//dto.setSysCd("IPO");
		dto.setBuCd("2000");
		dto.setSapCustCd("1063700");

		// EAI를 호출하여 결과를 수신한다.
		EAIResponse res = eaiService.call(dto);

		if (res.isSuccess()) {
			list = res.getListMap();
		} else {
			// TODO :: 결과가 없거나 에러인 경우에 아래를 적절히 코딩하세요....
			logger.debug(res.getErrorCode() + " / " + res.getErrorMsg());
			if (res.getErrorCode() == -1) {
				logger.debug("조회된 결과가 없습니다.");
			} else {
				throw super.processException("eai.exception");
			}
		}
*/
	}
}
