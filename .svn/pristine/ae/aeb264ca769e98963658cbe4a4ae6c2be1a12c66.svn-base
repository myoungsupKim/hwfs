package com.hwfs.sm.sar.service;

import hone.online.xplatform.map.DataSetMap;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sc.cmn.sap.EAIResponse;
import com.hwfs.sc.cmn.sap.request.CancelSuspenseAltRequest;
import com.hwfs.sc.cmn.sap.request.SuspenseAltRequest;
import com.hwfs.sc.cmn.sap.request.SuspenseAltResult;
import com.hwfs.sm.cmn.dao.SuspenseCommonDAO;
import com.hwfs.sc.cmn.sap.request.SuspenseInqueryRequest;
import com.hwfs.sc.cmn.sap.request.SuspenseLogInqueryRequest;
import com.hwfs.sc.cmn.sap.service.EAIService;

/**
 * 가수금을 전환 신청하는 SuspenseReturnRequest Service Implementation
 * 
 * @ClassName SuspenseReturnRequestServiceImpl.java
 * @Description SuspenseReturnRequestServiceImpl Class
 * @Modification-Information <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.15    JUN        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 JUN
 * @since 2015.05.15
 * @version 1.0
 * @see <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sm/sar/suspenseReturnRequestService")
public class SuspenseReturnRequestServiceImpl extends DefaultServiceImpl
		implements SuspenseReturnRequestService {

	/** LogService */
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	/** SuspenseCommonDAO Bean 생성 */
	@Resource(name = "/sm/cmn/suspenseCommonDAO")
	private SuspenseCommonDAO suspenseCommonDAO;

	@Resource(name = "EAIService")
	EAIService eaiService;

	/**
	 * 가수금 전환 신청 목록을 조회한다.
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
			dto.setBuCd(mapParam.get("buCd").toString().trim());

		if (mapParam.containsKey("susNo"))
			dto.setSuspenseNum(mapParam.get("susNo").toString().trim());

		if (mapParam.containsKey("startDt"))
			dto.setStartDate(mapParam.get("startDt").toString().trim());

		if (mapParam.containsKey("endDt"))
			dto.setEndDate(mapParam.get("endDt").toString().trim());

//		if (mapParam.containsKey("ccCd"))
//			dto.setCcCd(mapParam.get("ccCd").toString().trim());
//
//		if (mapParam.containsKey("muCd"))
//			dto.setMuCd(mapParam.get("muCd").toString().trim());
		
		if (mapParam.containsKey("bankAcctNoOrg"))
			dto.setBankAcctNo(mapParam.get("bankAcctNoOrg").toString().trim());

		if (mapParam.containsKey("receiveGuestNm"))
			dto.setReceiveGuestNm(mapParam.get("receiveGuestNm").toString().trim());

		if (mapParam.containsKey("closeYn"))
			dto.setCloseYn(mapParam.get("closeYn").toString().trim());

//		System.out.println("##### 가수금 전환 신청 목록 EAI 호출 Strat");
		// EAI를 호출하여 결과를 수신한다.
		EAIResponse res = eaiService.call(dto); // JSONObject

//		System.out.println("##### 가수금 전환 신청 목록 EAI 호출 End");
		
		if (res.isSuccess()) {
			try {
				if(res.getListMap().size() > 0){
					list = res.getListMap();
				}
			} catch (Exception e) {
				logger.error(e.getMessage());
			}
		} else {
			// TODO :: 결과가 없거나 에러인 경우에 아래를 적절히 코딩하세요....
			//logger.debug(res.getErrorCode() + " / " + res.getErrorMsg());
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

//		System.out.println("##### 가수금 전환 신청 상세 EAI 호출 Strat");

		if (mapParam.containsKey("buCd"))
			dto.setBuCd(mapParam.get("buCd").toString().trim());

		if (mapParam.containsKey("susNo"))
			dto.setSuspenseNum(mapParam.get("susNo").toString().trim());

		// EAI를 호출하여 결과를 수신한다.
		EAIResponse res = eaiService.call(dto);

//		System.out.println(res.getListMap().size());
		
//		System.out.println("##### 가수금 전환 신청 상세 EAI 호출 End");

		if (res.isSuccess()) {
			try {
				if(res.getListMap().size() > 0){
					list = res.getListMap();
				}
			} catch (Exception e) {
				logger.error(e.getMessage());
			}
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
	 * 가수금전환신청 EAI 호출
	 * 
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 * 
	 * @param mapParam
	 * @return
	 * @throws Exception
	 * @see com.hwfs.guide.sample.service.EAISampleService#processSuspenseAltRequest(java.util.Map)
	 */
	// @Override
	@SuppressWarnings("unchecked")
	public String processSuspenseAltRequest(Map<String, Object> mapParam, DataSetMap list) throws Exception {

		String retVal = "";
		String strAltBuCd = "";
		String strAltCcCd = "";
		String newCc = "";
		
		strAltBuCd	= mapParam.get("altBuCd").toString();
		strAltCcCd	= mapParam.get("altCcCd").toString();
		
	
//		System.out.println("##### 가수금전환신청 EAI 호출 Strat");

		for (int i = 0; i < list.size(); i++) {
			Map<String, Object> rowData = list.get(i);

			SuspenseAltRequest dto = new SuspenseAltRequest();

			if ("1".equals(rowData.get("chk").toString())) {
				
				if (rowData.containsKey("buCd"))
					dto.setBuCd(rowData.get("buCd").toString().trim());

				if (rowData.containsKey("suspenseNum"))
					dto.setSuspenseNum(rowData.get("suspenseNum").toString().trim());

//				if (rowData.containsKey("altBuCd"))
//					dto.setAltBuCd(rowData.get("altBuCd").toString().trim());

//				if (rowData.containsKey("ccCd"))
//					dto.setCcCd(rowData.get("ccCd").toString().trim());

				if (rowData.containsKey("currency"))
					dto.setCurrency(rowData.get("currency").toString().trim());

				if (rowData.containsKey("altAmt"))
					dto.setAltAmt((BigDecimal) rowData.get("altAmt"));

				if (rowData.containsKey("sabun"))
					dto.setSabun(rowData.get("sabun").toString().trim());
				
				//가수금전환신청시 요청일자 추가 (sysdate) 20151208 시작
				if (rowData.containsKey("reqDate"))
					dto.setReqDate(rowData.get("reqDate").toString().trim());
				//가수금전환신청시 요청일자 추가 (sysdate) 20151208 끝

				//logger.debug("mapParam : "+mapParam);
				//logger.debug("rowData : "+rowData);
				
				dto.setAltBuCd(strAltBuCd);		//로그인 소속회사

				//외식사업부인 경우 신규 조직 코드 가져오기 
				if (strAltBuCd.equals("1000")) {
					logger.debug("전환신청 구조직 strAltCcCd : "+strAltCcCd);
					mapParam.put("ccCd", strAltCcCd);
					newCc = suspenseCommonDAO.selectCc(mapParam);
					logger.debug("전환신청 신규조직 newCc : "+newCc);
					dto.setCcCd(newCc);
					//logger.debug("ccCd : "+rowData.get("ccCd").toString().trim());
					//dto.setCcCd(rowData.get("ccCd").toString().trim());										
				} else { 
					dto.setCcCd(strAltCcCd);		//로그인 CC
				}
				//logger.debug("dto : "+dto);
				

				// EAI를 호출하여 결과를 수신한다.
				EAIResponse res = eaiService.call(dto);

				if (!res.isSuccess()) {
					retVal = res.getErrorCode() + ":" + res.getErrorMsg();
					// logger.debug("##### EAI 호출 ERROR = ["+retVal+"]");
//					System.out.println("##### EAI 호출 ERROR = [" + retVal + "]");
					return retVal;
				} else {
					retVal = "Success";
				}
			}
		}

//		System.out.println("##### 가수금전환신청 EAI 호출 End");
		return retVal;
	}

	/**
	 * 가수금전환취소신청 EAI 호출
	 * 
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 * 
	 * @param mapParam
	 * @return
	 * @throws Exception
	 * @see com.hwfs.guide.sample.service.EAISampleService#cancelSuspenseAltRequest(java.util.Map)
	 */
	// @Override
	@SuppressWarnings("unchecked")
	public String processCancelSuspenseAltRequest(Map<String, Object> mapParam, DataSetMap list) throws Exception {

		String retVal = "";
		String strAltBuCd = "";
		String strAltCcCd = "";
		String oldCc = "";
		
		
		strAltBuCd	= mapParam.get("altBuCd").toString();
		strAltCcCd	= mapParam.get("altCcCd").toString();
		
//		System.out.println("##### 가수금전환취소신청 EAI 호출 Strat");

		for (int i = 0; i < list.size(); i++) {
			Map<String, Object> rowData = list.get(i);
 
			CancelSuspenseAltRequest dto = new CancelSuspenseAltRequest();
			
			
			if ("1".equals(rowData.get("chk").toString())) {

				if (rowData.containsKey("buCd"))
					dto.setBUKRS(rowData.get("buCd").toString().trim());

				if (rowData.containsKey("sapSuspenseNum"))
					dto.setSUS_NO(rowData.get("sapSuspenseNum").toString().trim());
				
				//추가 20151207 맹수영---시작
			    //	if (rowData.containsKey("altBuCd"))
			    //	    dto.setAltBuCd(rowData.get("altBuCd").toString().trim());

			    //    if (rowData.containsKey("ccCd"))
		     	//	    dto.setCcCd(rowData.get("ccCd").toString().trim());
			    //추가 20151207  맹수영---끝
			    
				if (rowData.containsKey("currency"))
					dto.setWAERS(rowData.get("currency").toString().trim());

				if (rowData.containsKey("altAmt"))
					dto.setWRBTR((BigDecimal) rowData.get("altAmt"));

				if (rowData.containsKey("empNo"))
					dto.setPERNR(rowData.get("empNo").toString().trim());
				
				
				dto.setTO_BUKRS(strAltBuCd);
				
				//외식사업부인 경우 신규 조직 코드 가져오기 
				if (strAltBuCd.equals("1000")) {
					//logger.debug("ccCd : "+rowData.get("ccCd").toString().trim());
					dto.setTO_KOSTL(rowData.get("chgCcCd").toString().trim());			
				} else { 
					dto.setTO_KOSTL(strAltCcCd);
				}
			
				
				// EAI를 호출하여 결과를 수신한다.
				EAIResponse res = eaiService.call(dto);

				if (!res.isSuccess()) {
					retVal = res.getErrorCode() + ":" + res.getErrorMsg();
					// logger.debug("##### EAI 호출 ERROR = ["+retVal+"]");
//					System.out.println("##### EAI 호출 ERROR = [" + retVal + "]");
					return retVal;
				} else {
					retVal = "Success";
				}
			}
		}

//		System.out.println("##### 가수금전환취소신청 EAI 호출 End");
		return retVal;
	}
	
	/**
	 * 가수금 전환결과 EAI 호출.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 조회결과
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectSuspenseAltRequest(
			Map<String, Object> mapParam) throws Exception {
		
		List<Map<String, Object>> list = null;
		SuspenseAltResult dto = new SuspenseAltResult();

//		System.out.println("##### 가수금 전환결과 EAI 호출 Strat");

		String sabun = "";
		String reqDateStart = "";
		String reqDateEnd = "";
		String sapProcStatus = "";
		
		if (mapParam.containsKey("sabun")) sabun = mapParam.get("sabun").toString().trim();
		if (mapParam.containsKey("reqDateStart")) reqDateStart = mapParam.get("reqDateStart").toString().trim();
		if (mapParam.containsKey("reqDateEnd")) reqDateEnd = mapParam.get("reqDateEnd").toString().trim();
		if (mapParam.containsKey("sapProcStatus")) sapProcStatus = mapParam.get("sapProcStatus").toString().trim();
			
//		System.out.println("##### sabun:"+sabun);
//		System.out.println("##### reqDateStart:"+reqDateStart);
//		System.out.println("##### reqDateEnd:"+reqDateEnd);
//		System.out.println("##### sapProcStatus:"+sapProcStatus);
		
		dto.setSabun(sabun);
		dto.setReqDateStart(reqDateStart);
		dto.setReqDateEnd(reqDateEnd);
		dto.setSapProcStatus(sapProcStatus);
		
		// EAI를 호출하여 결과를 수신한다.
		EAIResponse res = eaiService.call(dto); // JSONObject
		
//		System.out.println("##### 가수금 전환결과 EAI 호출 End");

//		System.out.println("##### ErrorCode:"	+res.getErrorCode());
//		System.out.println("##### ErrorMsg:"	+res.getErrorMsg());
//		System.out.println("##### res:"	+res.toString());
		
		if (res.isSuccess()) {
			
			try {
//				System.out.println("##### res.getListMap():"	+res.getListMap());
				if(res.getListMap().size() > 0){
					list = res.getListMap();
				}
			} catch (Exception e) {
				logger.error(e.getMessage());
			}
			//System.out.println("##### res.getJSONObject():"	+res.getJSONObject());
			//System.out.println("##### res.getListMap():"	+res.getListMap());
			
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
}
