package com.hwfs.sm.cmn.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.math.BigDecimal;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.util.DateUtil;
import com.hwfs.sc.cmn.sap.EAIResponse;
import com.hwfs.sc.cmn.sap.request.SuspenseReceiveRequest;
import com.hwfs.sc.cmn.sap.service.EAIService;
import com.hwfs.sm.cmn.dao.AdvanceCommonDAO;
import com.hwfs.sm.cmn.dao.SuspenseCommonDAO;
import com.hwfs.sm.ssi.dao.SalesTypeMgntDAO;

 /**
 * 가수금정보 공통 SuspenseCommon Service Implementation
 * 
 * @ClassName SuspenseCommonServiceImpl.java
 * @Description SuspenseCommonServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.06    JUN        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 JUN
 * @since 2015.05.06
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sm/cmn/suspenseCommonService")
public class SuspenseCommonServiceImpl extends DefaultServiceImpl implements SuspenseCommonService {
	
	/** SuspenseCommonDAO Bean 생성 */
	@Resource(name = "/sm/cmn/suspenseCommonDAO")
	private SuspenseCommonDAO suspenseCommonDAO;
	
	/** AdvanceCommonDAO Bean 생성 */
	@Resource(name = "/sm/cmn/advanceCommonDAO")
	private AdvanceCommonDAO advanceCommonDAO;
	
	/** SalesTypeMgntDAO Bean 생성 */
	@Resource(name = "/sm/ssi/salesTypeMgntDAO")
	private SalesTypeMgntDAO salesTypeMgntDAO;
	
	@Resource(name = "EAIService")
	EAIService eaiService;
	
	/**
	 * 가수금정보 조회
	 * @return RecordSet 조회결과
	 * @throws Exception
	 */
	public RecordSet selectSuspenseList(Map<String, Object> mapParam) throws Exception {
		return suspenseCommonDAO.selectSuspenseList(mapParam);
	}
	
	/**
	 * 가수금정보 내역조회
	 * @return RecordSet 조회결과
	 * @throws Exception
	 */
	public RecordSet selectSuspenseHistory(Map<String, Object> mapParam) throws Exception {
		return suspenseCommonDAO.selectSuspenseHistory(mapParam);
	}

	/**
	 * 가수금 대체 정보 조회
	 * @return RecordSet 조회결과
	 * @throws Exception
	 */
	public RecordSet selectSuspenseAltMst(Map<String, Object> mapParam) throws Exception {
		return suspenseCommonDAO.selectSuspenseAltMst(mapParam);
	}
	
	/**
	 * 가수금대체처리
	 * @param list - DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public int setSuspenseAltProc(DataSetMap list) throws Exception {
		int rowCnt 			= 0;	//건수
		long iApplyAmt 		= 0;	//적용금액
		int eaiCnt			= 0;
		String newCc 		= "";

		String sRowStatus	= "";	//디테일 상태
		String sAtlNum		= "";	//가수금 대체번호
		String sMaxAtlNum	= "";	//신규 가수금 대체번호
		String maxAdvanceNum = "";      //선수금번호 생성
		
		long time = System.currentTimeMillis();
		
		SimpleDateFormat sDay = new SimpleDateFormat("yyyymmdd", java.util.Locale.getDefault());
		SimpleDateFormat sTime = new SimpleDateFormat("HHmmss", java.util.Locale.getDefault());
		
		String strDay = com.hwfs.sc.cmn.util.DateUtil.getYyyymmdd();//sDay.format(new Date(time));
		String strTime = sTime.format(new Date(time));
		String sabun = selectSabun(list.get(0));
		
		/************************************************************************************************
		 * 가수금 대체 디테일 등록/수정/삭제, 가수금 마스터정보 변경
		************************************************************************************************/
//		System.out.println("################################################ list.size():"+list.size());
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			
			//상태
			if(rowData.get("rowStatus") == null) sRowStatus = "";
			else sRowStatus = rowData.get("rowStatus").toString();
			
			//적용금액
			if(rowData.get("applyAmt") == null) iApplyAmt = 0;
			else iApplyAmt = Long.parseLong(rowData.get("applyAmt").toString());

			//가수금대체번호
			if(rowData.get("altNum") == null) sAtlNum = "";
			else sAtlNum = rowData.get("altNum").toString();
			
			//가수금대체 디테일정보 등록(적용금액을 입력했을 경우)
			if("INSERT".equals(sRowStatus) && iApplyAmt > 0){
				//영업유형 을(를) 조회한다.(계정코드 가져오자)
				Map<String,Object> mapData = new HashMap<String,Object>();
				
				//순번 체크
				int altSeq = suspenseCommonDAO.selectAltSeq(rowData);
				
				rowData.put("altSeq", altSeq);				
				
				mapData.put("typeGrpCdDtl", "014");
				mapData.put("typeCd", rowData.get("suspenseAltType"));
				RecordSet rs = salesTypeMgntDAO.selectDtlList(mapData);
				
				for (int j = 0; j < rs.size(); j++){
					mapData.put("acctCd", rs.get(j).get("acctCd"));
				}
				rowData.put("acctCd", mapData.get("acctCd"));  //해당 유형별 계정 코드를 가져온다.
				
				
				//선수금대체유형이 선수금(사업장)발생, 계약이행선납금발생 인 경우 선수금발생
				if ("L04".equals(rowData.get("suspenseAltType")) || "L06".equals(rowData.get("suspenseAltType")) || "L09".equals(rowData.get("suspenseAltType"))){
					//선수금마스터 채번 MAX값
					maxAdvanceNum = advanceCommonDAO.getMaxAdvanceNum(rowData);
					
					rowData.put("seq", "1");			//지불테이블에 순번
					rowData.put("maxAdvanceNum", maxAdvanceNum);
					rowData.put("advanceNum", maxAdvanceNum);
					rowData.put("occurDate", rowData.get("altDate"));                //발생일자
					rowData.put("fiscalDate", rowData.get("altDate"));               //회계일자
					rowData.put("advanceOccurClass", "AO05");                        //선수금발생유형
					
					if ("L04".equals(rowData.get("suspenseAltType"))) rowData.put("advanceTypeCd", "F08");	//선수금_선매출
					if ("L06".equals(rowData.get("suspenseAltType"))) rowData.put("advanceTypeCd", "F07");	//선수금_계약이행선납금
					if ("L09".equals(rowData.get("suspenseAltType"))) rowData.put("advanceTypeCd", "F08");	//선수금_계약이행선납금
					
					/*if ("L04".equals(rowData.get("suspenseAltType"))){
						rowData.put("acctCd", "21401020");                               //계정코드 선수금_사업장
					} else if ("L06".equals(rowData.get("suspenseAltType"))){
						rowData.put("acctCd", "21401030");                               //계정코드 선수금_계약이행선납금
					}*/
					
					rowData.put("occurAmt", iApplyAmt);                				//발생금액
					rowData.put("occurSupplyAmt", iApplyAmt);          				//발생공급가액
					rowData.put("occurVatAmt", 0);                                   //발생부가세
					rowData.put("vatCd", "X");                                      //부가세구분  40:면세 기타
					rowData.put("journalzYn", "N");                                  //분개여부
					//적용금액은 0 처리하자
					//rowData.put("applyAmt", 0);                                      //적용금액 0처리
					
					//선수금마스터 발생
					rowCnt += advanceCommonDAO.insertAdvanceMaster(rowData);

				}
				
				//가수금 대체번호 채번(신규일 경우 채번)
				//if(i == 0) sMaxAtlNum = suspenseCommonDAO.getMaxAtlNum(list.get(i));
				//가수금 대체를 건바이 건으로 처리
				sMaxAtlNum = suspenseCommonDAO.getMaxAtlNum(list.get(i));
				
				if("".equals(sAtlNum)) rowData.put("altNum", sMaxAtlNum);	//신규 가수금대체번호
				rowCnt += suspenseCommonDAO.insertSuspenseAltDtl(rowData);
				
				if ("L04".equals(rowData.get("suspenseAltType")) || "L06".equals(rowData.get("suspenseAltType")) || "L09".equals(rowData.get("suspenseAltType"))){
					
					//지불 수단 발생
					rowCnt += advanceCommonDAO.insertAdvanceReceiveWay(rowData);
				}
				//if(rowCnt > 0) suspenseCommonDAO.insertSapIfcSuspenseReceive(rowData);
				
				/************************************************************************************************
				 * SAP IFC 가수금 입금 반제 Start
				************************************************************************************************/
				SuspenseReceiveRequest dto = new SuspenseReceiveRequest();
								
				if (rowData.containsKey("buCd")) {
					//외식사업부 BU,MU,CC 맵핑 변경 20200131 김호석
					if (rowData.get("muCd").equals("2003")) {
						dto.setBuCd("1000");						
					} else {
						dto.setBuCd(rowData.get("buCd").toString().trim());
					}
				}
				
				if (rowData.containsKey("sapSuspenseNum"))
					dto.setSapSuspenseNum(rowData.get("sapSuspenseNum").toString().trim());
				
				//if (rowData.containsKey("sabun"))
				dto.setAltProcUser(sabun.toString().trim());
				
				if (rowData.containsKey("applyAmt"))
					dto.setAmt((BigDecimal) rowData.get("applyAmt"));

				if (rowData.containsKey("ccCd")) {
					//외식사업부 BU,MU,CC 맵핑 변경 20200131 김호석
					if (rowData.get("muCd").equals("2003")) {
						//구 cc 검색해서 가져오기 
						newCc = suspenseCommonDAO.selectCc(rowData);
						dto.setCcCd(newCc);
					} else {
						dto.setCcCd(rowData.get("ccCd").toString().trim());
					}					
				}

				if (rowData.containsKey("altDate"))
					dto.setAltDate(rowData.get("altDate").toString().trim());
				
				if (rowData.containsKey("sapCustCd"))
					dto.setSapCustCd(rowData.get("sapCustCd").toString().trim());
				
				dto.setAltProcDate(strDay);
				dto.setAltProcTime(strTime);
				dto.setCurrency("KRW");
				dto.setAltSlipNum(" ");
				dto.setReqType("1");
				dto.setSeq(Integer.parseInt(rowData.get("altSeq").toString()));
				
				EAIResponse res = eaiService.call(dto);
				
				if (res.isSuccess()) {
					eaiCnt++;
				}
				/************************************************************************************************
				 * SAP IFC 가수금 입금 반제 End
				************************************************************************************************/
			}
			
			//가수금대체 디테일정보 변경
			if("UPDATE".equals(sRowStatus)){
				rowCnt += suspenseCommonDAO.updateSuspenseAltDtl(rowData);
				
				/************************************************************************************************
				 * SAP IFC 가수금 입금 반제/취소 Strat
				************************************************************************************************/
				SuspenseReceiveRequest dto1 = new SuspenseReceiveRequest();	//반제
				SuspenseReceiveRequest dto2 = new SuspenseReceiveRequest();	//반제취소
				
				if (rowData.containsKey("buCd")) {
					//외식사업부 BU,MU,CC 맵핑 변경 20200131 김호석
					if (rowData.get("muCd").equals("2003")) {
						dto2.setBuCd("1000");						
					} else {
						dto2.setBuCd(rowData.get("buCd").toString().trim());
					}
				}
				
				if (rowData.containsKey("sapSuspenseNum"))
					dto2.setSapSuspenseNum(rowData.get("sapSuspenseNum").toString().trim());
				
				//if (rowData.containsKey("sabun"))
				dto2.setAltProcUser(sabun.toString().trim());
				
				if (rowData.containsKey("applyAmtOrg"))
					dto2.setAmt((BigDecimal) rowData.get("applyAmtOrg"));
				
				if (rowData.containsKey("ccCd")) {
					//외식사업부 BU,MU,CC 맵핑 변경 20200131 김호석
					if (rowData.get("muCd").equals("2003")) {
						//구 cc 검색해서 가져오기 
						newCc = suspenseCommonDAO.selectCc(rowData);
						dto2.setCcCd(newCc);
					} else {
						dto2.setCcCd(rowData.get("ccCd").toString().trim());
					}					
				}
				
				if (rowData.containsKey("altDate"))
					dto2.setAltDate(rowData.get("altDate").toString().trim());
				
				if (rowData.containsKey("sapCustCd"))
					dto2.setSapCustCd(rowData.get("sapCustCd").toString().trim());

				dto2.setAltProcDate(strDay);
				dto2.setAltProcTime(strTime);
				dto2.setCurrency("KRW");
				dto2.setAltSlipNum(" ");
				dto2.setReqType("2");
				dto2.setSeq(Integer.parseInt(rowData.get("altSeq").toString()));
				
				EAIResponse res2 = eaiService.call(dto2);

				if (res2.isSuccess()) {
					eaiCnt++;
				}				
				
				if (rowData.containsKey("buCd")) {
					//외식사업부 BU,MU,CC 맵핑 변경 20200131 김호석
					if (rowData.get("muCd").equals("2003")) {
						dto1.setBuCd("1000");						
					} else {
						dto1.setBuCd(rowData.get("buCd").toString().trim());
					}
				}
				
				if (rowData.containsKey("sapSuspenseNum"))
					dto1.setSapSuspenseNum(rowData.get("sapSuspenseNum").toString().trim());
				
				System.out.println("UPDATE ###########################");
				System.out.println("########################### i = "+i);
				System.out.println("########################### i + 1 = "+ (i + 1));
				System.out.println("###########################");
				
				//if (rowData.containsKey("sabun"))
				dto1.setAltProcUser(sabun.toString().trim());
				
				if (rowData.containsKey("applyAmt"))
					dto1.setAmt((BigDecimal) rowData.get("applyAmt"));

				if (rowData.containsKey("ccCd")) {
					//외식사업부 BU,MU,CC 맵핑 변경 20200131 김호석
					if (rowData.get("muCd").equals("2003")) {
						//구 cc 검색해서 가져오기 
						newCc = suspenseCommonDAO.selectCc(rowData);
						dto1.setCcCd(newCc);
					} else {
						dto1.setCcCd(rowData.get("ccCd").toString().trim());
					}					
				}
				
				if (rowData.containsKey("altDate"))
					dto1.setAltDate(rowData.get("altDate").toString().trim());
				
				if (rowData.containsKey("sapCustCd"))
					dto1.setSapCustCd(rowData.get("sapCustCd").toString().trim());

				dto1.setAltProcDate(strDay);
				dto1.setAltProcTime(strTime);
				dto1.setCurrency("KRW");
				dto1.setAltSlipNum(" ");
				dto1.setReqType("1");
				dto1.setSeq(Integer.parseInt(rowData.get("altSeq").toString()));
				
				EAIResponse res1 = eaiService.call(dto1);
				
				if (res1.isSuccess()) {
					eaiCnt++;
				}
				
				/************************************************************************************************
				 * SAP IFC 가수금 입금 반제/취소 End
				************************************************************************************************/
				
				//선수금대체유형이 선수금(사업장)발생인 경우 선수금발생
				if ("L04".equals(rowData.get("suspenseAltType")) || "L06".equals(rowData.get("suspenseAltType")) || "L09".equals(rowData.get("suspenseAltType"))){
					//선수금마스터 채번 MAX값
					maxAdvanceNum = (String) rowData.get("advanceNum");
					
					rowData.put("advanceNum", maxAdvanceNum);
					rowData.put("occurDate", rowData.get("altDate"));                //발생일자
					rowData.put("fiscalDate", rowData.get("altDate"));               //회계일자
					rowData.put("occurAmt", rowData.get("applyAmt"));                //발생금액
					
					//선수금마스터 발생
					rowCnt += advanceCommonDAO.updateAdvanceMasterCoupon(rowData);
				}
			}
			
			//가수금 대체디테일정보 삭제(단건 대체취소 (ApplyAmt = 0))
			if("DELETE".equals(sRowStatus) && iApplyAmt == 0){
				rowCnt += suspenseCommonDAO.deleteSuspenseAltDtl(rowData);
				
				//SAP IFC 가수금 입금 반제취소
				//if(rowCnt > 0) suspenseCommonDAO.deleteSapIfcSuspenseReceive(rowData);	
				System.out.println("DELETE ###########################");
				System.out.println("########################### i = "+i);
				System.out.println("########################### i + 1 = "+ (i + 1));
				System.out.println("###########################");
				
				/************************************************************************************************
				 * SAP IFC 가수금 입금 반제취소 Strat
				************************************************************************************************/
				SuspenseReceiveRequest dto = new SuspenseReceiveRequest();	//반제취소
				
				if (rowData.containsKey("buCd")) {
					//외식사업부 BU,MU,CC 맵핑 변경 20200131 김호석
					if (rowData.get("muCd").equals("2003")) {
						dto.setBuCd("1000");						
					} else {
						dto.setBuCd(rowData.get("buCd").toString().trim());
					}
				}
				
				if (rowData.containsKey("sapSuspenseNum"))
					dto.setSapSuspenseNum(rowData.get("sapSuspenseNum").toString().trim());
				
				//if (rowData.containsKey("sabun"))
				dto.setAltProcUser(sabun.toString().trim());
				
				if (rowData.containsKey("applyAmtOrg"))
					dto.setAmt((BigDecimal) rowData.get("applyAmtOrg"));

				if (rowData.containsKey("ccCd")) {
					//외식사업부 BU,MU,CC 맵핑 변경 20200131 김호석
					if (rowData.get("muCd").equals("2003")) {
						//구 cc 검색해서 가져오기 
						newCc = suspenseCommonDAO.selectCc(rowData);
						dto.setCcCd(newCc);
					} else {
						dto.setCcCd(rowData.get("ccCd").toString().trim());
					}					
				}
				
				if (rowData.containsKey("altDate"))
					dto.setAltDate(rowData.get("altDate").toString().trim());
				
				if (rowData.containsKey("sapCustCd"))
					dto.setSapCustCd(rowData.get("sapCustCd").toString().trim());

				dto.setAltProcDate(strDay);
				dto.setAltProcTime(strTime);
				dto.setCurrency("KRW");
				dto.setAltSlipNum(" ");
				dto.setReqType("2");
				dto.setSeq(Integer.parseInt(rowData.get("altSeq").toString()));
				
				EAIResponse res2 = eaiService.call(dto);

				if (res2.isSuccess()) {
					eaiCnt++;
				}
				/************************************************************************************************
				 * SAP IFC 가수금 입금 반제취소 End
				************************************************************************************************/
			}
			
			//가수금 마스터정보 변경
			//rowCnt += suspenseCommonDAO.updateSuspenseApplyAmtProc(rowData);
	
			/************************************************************************************************
			 * 상태 - 가수금 대체 마스터 정보 상태값
			************************************************************************************************/
			Map<String, Object> rowDataMst = list.get(0);
			
			if(rowDataMst.get("rowStatus") == null) sRowStatus = "";
			else sRowStatus = rowDataMst.get("rowStatus").toString();
	
			/************************************************************************************************
			 * 가수금 대체 마스터정보 등록/수정
			************************************************************************************************/
			//가수금 대체 마스터 등록
			if("INSERT".equals(sRowStatus)){
	
				rowDataMst.put("altNum", sMaxAtlNum);	//신규 가수금대체번호
				rowCnt = suspenseCommonDAO.insertSuspenseAltMst(rowDataMst);
				
			//가수금대체 마스터정보 변경	
			}else if("UPDATE".equals(sRowStatus)){
				rowCnt = suspenseCommonDAO.updateSuspenseAltMst(rowDataMst);
			}
		
		}
		return rowCnt + eaiCnt;
	}
	
	/**
	 * 가수금대체 취소처리
	 * @param list - DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public int setSuspenseAltCancel(DataSetMap list) throws Exception {
		int rowCnt	= 0;
		int iApplyAmt = 0;
		int eaiCnt = 0;
		String newCc = "";
		
		long time = System.currentTimeMillis();
		
		SimpleDateFormat sDay =  new SimpleDateFormat("yyyymmdd", java.util.Locale.getDefault());
		SimpleDateFormat sTime = new SimpleDateFormat("HHmmss", java.util.Locale.getDefault());
		
		String strDay = com.hwfs.sc.cmn.util.DateUtil.getYyyymmdd();//sDay.format(new Date(time));
		String strTime = sTime.format(new Date(time));
		String sabun = selectSabun(list.get(0));
		
		/************************************************************************************************
		 * 가수금 마스터, 가수금대체 디테일 정보 삭제
		************************************************************************************************/
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);

			//적용금액
			if(rowData.get("applyAmt") == null) iApplyAmt = 0;
			else iApplyAmt = Integer.parseInt(rowData.get("applyAmt").toString());
			
			
			//가수금 대체 디테일 정보 삭제 (RECD_STATUS = 'D')
			if(iApplyAmt > 0) rowCnt += suspenseCommonDAO.cancelSuspenseAltDetail(rowData);
			
			//SAP IFC 가수금 입금 반제취소
			//if(rowCnt > 0) suspenseCommonDAO.deleteSapIfcSuspenseReceive(rowData);	
			
			/************************************************************************************************
			 * SAP IFC 가수금 입금 반제취소 Strat
			************************************************************************************************/
			SuspenseReceiveRequest dto = new SuspenseReceiveRequest();	//반제취소
			
			if (rowData.containsKey("buCd")) {
				//외식사업부 BU,MU,CC 맵핑 변경 20200131 김호석
				if (rowData.get("muCd").equals("2003")) {
					dto.setBuCd("1000");						
				} else {
					dto.setBuCd(rowData.get("buCd").toString().trim());
				}
			}
			
			if (rowData.containsKey("sapSuspenseNum"))
				dto.setSapSuspenseNum(rowData.get("sapSuspenseNum").toString().trim());
			
			//if (rowData.containsKey("sabun"))
			dto.setAltProcUser(sabun.toString().trim());
			
			if (rowData.containsKey("applyAmtOrg"))
				dto.setAmt((BigDecimal) rowData.get("applyAmtOrg"));
			
			if (rowData.containsKey("ccCd")) {
				//외식사업부 BU,MU,CC 맵핑 변경 20200131 김호석
				if (rowData.get("muCd").equals("2003")) {
					//구 cc 검색해서 가져오기 
					newCc = suspenseCommonDAO.selectCc(rowData);
					dto.setCcCd(newCc);
				} else {
					dto.setCcCd(rowData.get("ccCd").toString().trim());
				}					
			}

			if (rowData.containsKey("altDate"))
				dto.setAltDate(rowData.get("altDate").toString().trim());
			
			if (rowData.containsKey("sapCustCd"))
				dto.setSapCustCd(rowData.get("sapCustCd").toString().trim());

			dto.setAltProcDate(strDay);
			dto.setAltProcTime(strTime);
			dto.setCurrency("KRW");
			dto.setAltSlipNum(" ");
			dto.setReqType("2");
			dto.setSeq(Integer.parseInt(rowData.get("altSeq").toString()));
			
			EAIResponse res2 = eaiService.call(dto);

			if (res2.isSuccess()) {
				eaiCnt++;
			}
			
			/************************************************************************************************
			 * SAP IFC 가수금 입금 반제취소 End
			************************************************************************************************/
			
			//선수금대체유형이 선수금(사업장)발생인 경우 선수금발생
			if ("L04".equals(rowData.get("suspenseAltType")) || "L06".equals(rowData.get("suspenseAltType")) || "L07".equals(rowData.get("suspenseAltType")) || "L09".equals(rowData.get("suspenseAltType"))){
				//선수금발생 취소
				rowCnt += advanceCommonDAO.mstAdvanceCancel(rowData);
				rowCnt += advanceCommonDAO.advanceReceiveWayCancel(rowData);
			}
			
			//가수금 마스터정보 변경
			//rowCnt += suspenseCommonDAO.updateSuspenseApplyAmtProc(rowData);
		}

		/************************************************************************************************
		 * 가수금대체 마스터정보 삭제
		************************************************************************************************/	
		Map<String, Object> rowDataMst = list.get(0);
		
		//가수금 대체 마스터 정보 삭제 (RECD_STATUS = 'D')
		rowCnt = suspenseCommonDAO.cancelSuspenseAltMaster(rowDataMst);
		
		return eaiCnt + rowCnt;
	}
	
	/**
	 * 가수금잔액 조회
	 * @return RecordSet 조회결과
	 * @throws Exception
	 */
	public RecordSet selectTotalSuspenseAmt(Map<String, Object> mapParam) throws Exception {
		return suspenseCommonDAO.selectTotalSuspenseAmt(mapParam);
	}
	
	
	/**
	 * 사번 조회
	 * @return RecordSet 조회결과
	 * @throws Exception
	 */
	public String selectSabun(Map<String, Object> mapParam) throws Exception {
		return suspenseCommonDAO.selectSabun(mapParam);
	}
	
	/**
	 * 가수금잔액 체크
	 * @return String 조회결과
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public String getSuspenseAltYn(DataSetMap list) throws Exception {
		String sSuspenseAltYn	= "Y";
		int applyAmt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			applyAmt = Integer.parseInt(rowData.get("applyAmt").toString());
			if("Y".equals(sSuspenseAltYn) && applyAmt > 0){
				sSuspenseAltYn = suspenseCommonDAO.getSuspenseAltYn(rowData);
			}
		}
		return sSuspenseAltYn;
	}

}
