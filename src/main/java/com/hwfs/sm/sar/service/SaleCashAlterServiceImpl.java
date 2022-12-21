package com.hwfs.sm.sar.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import java.math.BigDecimal;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sc.cmn.sap.EAIResponse;
import com.hwfs.sc.cmn.sap.request.SuspenseReceiveRequest;
import com.hwfs.sc.cmn.sap.service.EAIService;
import com.hwfs.sc.cmn.util.StringUtil;
import com.hwfs.sm.cmn.dao.SuspenseCommonDAO;
import com.hwfs.sm.cmn.service.SuspenseCommonService;
import com.hwfs.sm.sar.dao.SaleCashAlterDAO;

 /**
 * 영업수입 현금 가수금 대체하는 SaleCashAlter Service Implementation
 * 
 * @ClassName SaleCashAlterServiceImpl.java
 * @Description SaleCashAlterServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.14    김명호        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 김명호
 * @since 2015.04.14
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sm/sar/saleCashAlterService")
public class SaleCashAlterServiceImpl extends DefaultServiceImpl implements SaleCashAlterService {
	
	/** LogService */
//	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** SaleCashAlterDAO Bean 생성 */
	@Resource(name = "/sm/sar/saleCashAlterDAO")
	private SaleCashAlterDAO saleCashAlterDAO;
	
	/** SuspenseCommonService Bean 생성 */
	@Resource(name = "/sm/cmn/suspenseCommonService")
	private SuspenseCommonService suspenseCommonService;
	
	/** SuspenseCommonDAO Bean 생성 */
	@Resource(name = "/sm/cmn/suspenseCommonDAO")
	private SuspenseCommonDAO suspenseCommonDAO;
	
	@Resource(name = "EAIService")
	EAIService eaiService;
	
	/**
	 * 영업수입 현금 가수금 대체 목록을 조회한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략하면 삭제할 것
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return saleCashAlterDAO.selectList(mapParam);
	}
	
	/**
	 * 영업수입 현금 대체 마스터 목록을 조회한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략하면 삭제할 것
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectMstList(Map<String, Object> mapParam) throws Exception {
		return saleCashAlterDAO.selectMstList(mapParam);
	}

	/**
	 * 영업수입 현금 가수금 대체 DataSetMap의 데이터를 rowType에 따라 대체 처리한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public int saveList(DataSetMap search, DataSetMap list, DataSetMap listSuspense) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		String maxSalesCashReceiveNum = "";
		Map<String,Object> mapData = new HashMap<String,Object>();   //가수금대체처리후(대체값)
		Map<String,Object> rowDataMst = new HashMap<String,Object>();
		Map<String,Object> searchData = new HashMap<String,Object>(); //조회데이타
		
		searchData = search.get(0);
		//list행 첫번째행
		rowDataMst = list.get(0);
		//가수금 대체처리
		if("K01".equals(nvls(searchData.get("altTypeCd"))))
				mapData = this.setSuspenseAltProc(listSuspense);
		
		//영업현금대체상세 신규등록
		if (rowDataMst.get("salesCashReceiveNum").toString().isEmpty()){
			for (int i = 0 ; i < list.size() ; i++) {
				Map<String, Object> rowData = list.get(i);
				
//				int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
				if (i == 0 && rowData.get("salesCashReceiveNum").toString().isEmpty()){
					rowData.put("altDate", searchData.get("receiveDate"));   //입금일자
					maxSalesCashReceiveNum = saleCashAlterDAO.selectMaxSalesCashReceiveNum(rowData);
						//rowData.put("salesCashReceiveNum", maxSalesCashReceiveNum);
				}
				if (!rowData.get("receiveAmt").toString().equals("0")){
					rowData.put("altDate", searchData.get("receiveDate"));   //입금일자
					rowData.put("salesCashReceiveNum", maxSalesCashReceiveNum);
					rowData.put("class", "2");
					
					//영업현금대체상세 insert
					insRowCnt += saleCashAlterDAO.insertSalesCashAltDetail(rowData);
					
					//영업 현금 발생 정보에 대체금액 update
					updRowCnt += saleCashAlterDAO.updateSaleCash(rowData);
				}
				
			}
			
			//영업현금대체마스터등록
			rowDataMst.put("salesCashReceiveNum", maxSalesCashReceiveNum);
			rowDataMst.put("altDate", searchData.get("receiveDate"));
			rowDataMst.put("suspenseAltNum", nvls(mapData.get("atlNum")));
			rowDataMst.put("inqueryStartDate", searchData.get("inqueryStartDate"));
			rowDataMst.put("inqueryEndDate", searchData.get("inqueryEndDate"));
			rowDataMst.put("inqueryMuCd", searchData.get("inqueryMuCd"));
			rowDataMst.put("inqueryTmCd", searchData.get("inqueryTmCd"));
			rowDataMst.put("inqueryCcCd", searchData.get("inqueryCcCd"));
			rowDataMst.put("upjangCd", searchData.get("upjangCd"));
			rowDataMst.put("altTypeCd", searchData.get("altTypeCd"));
			rowDataMst.put("remark", searchData.get("remark"));
			insRowCnt += saleCashAlterDAO.insertSalesCashAltMst(rowDataMst);
			
			//입금액 제셋팅 합산금액
			updRowCnt += saleCashAlterDAO.updateSalesCashAltMstAmt(rowDataMst);
		//영업현금대체상세 수정저장
		} else {
			for (int i = 0 ; i < list.size() ; i++) {
				Map<String, Object> rowData = list.get(i);
				
//				int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
				
				if (i == 0){
					maxSalesCashReceiveNum = (String)rowData.get("salesCashReceiveNum");
				}
				rowData.put("altDate", searchData.get("receiveDate"));   //입금일자
				rowData.put("class", "2");
				
				//영업현금대체상세 update
				updRowCnt += saleCashAlterDAO.updateSalesCashAltDetail(rowData);
				
				//영업 현금 발생 정보에 대체금액 update
				updRowCnt += saleCashAlterDAO.updateSaleCash(rowData);
				
			}
			
			//영업현금대체마스터등록
			updRowCnt += saleCashAlterDAO.updateSalesCashAltMst(rowDataMst);
			
			//입금액 제셋팅 합산금액
			updRowCnt += saleCashAlterDAO.updateSalesCashAltMstAmt(rowDataMst);
		}
		
		
		//영업현금대체마스터등록
		/*if (rowDataMst.get("salesCashReceiveNum").toString().isEmpty()){
			rowDataMst.put("salesCashReceiveNum", maxSalesCashReceiveNum);
			rowDataMst.put("altDate", searchData.get("receiveDate"));
			rowDataMst.put("suspenseAltNum", mapData.get("atlNum"));
			insRowCnt += saleCashAlterDAO.insertSalesCashAltMst(rowDataMst);
			
			//입금액 제셋팅 합산금액
			updRowCnt += saleCashAlterDAO.updateSalesCashAltMstAmt(rowDataMst);
		} else {
			updRowCnt += saleCashAlterDAO.updateSalesCashAltMst(rowDataMst);
			
			//입금액 제셋팅 합산금액
			updRowCnt += saleCashAlterDAO.updateSalesCashAltMstAmt(rowDataMst);
		}*/
		
		return insRowCnt + updRowCnt + delRowCnt;
	}

	/**
	 * 영업수입 현금 가수금 대체 DataSetMap의 데이터를 rowType에 따라 대체 취소 처리한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public int cancleList(DataSetMap list, DataSetMap listSuspense, DataSetMap search) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
//		String maxSuspenseAltNum ="";
		Map<String,Object> searchData = new HashMap<String,Object>(); //조회데이타
		
		searchData = search.get(0);
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			
			//영업현금 대체상세 취소처리한다
			updRowCnt += saleCashAlterDAO.cancelSalesCashAltDetail(rowData);
			
			//영업 현금 발생 정보에 가수금 정보 update
			rowData.put("receiveAmt", null);
			updRowCnt += saleCashAlterDAO.updateSaleCash(rowData);
		}
		
		//영업현금 대체마스터 취소처리한다
		updRowCnt += saleCashAlterDAO.cancelSalesCashAltMst(searchData);
		
		//가수금 정보 update
		if("K01".equals(nvls(searchData.get("altTypeCd"))))
			updRowCnt += suspenseCommonService.setSuspenseAltCancel(listSuspense);
				
		return insRowCnt + updRowCnt + delRowCnt;
	}
	
	/**
	 * 입금처리 DataSetMap의 데이터를 rowType에 따라 처리한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public Map<String,Object> setSuspenseAltProc(DataSetMap list) throws Exception {
		Map<String,Object> reMapData = new HashMap<String,Object>();
		int rowCnt 			= 0;	//건수
		int iApplyAmt		= 0;	//적용금액
//		int eaiCnt			= 0;
		String newCc 	    = "";
		
		String sRowStatus	= "";	//디테일 상태
		String sAtlNum		= "";	//가수금 대체번호
		String sMaxAtlNum	= "";	//신규 가수금 대체번호
		
		long time = System.currentTimeMillis();
		
		SimpleDateFormat sDay = new SimpleDateFormat("yyyymmdd", java.util.Locale.getDefault());
		SimpleDateFormat sTime = new SimpleDateFormat("HHmmss", java.util.Locale.getDefault());
		
		//String strDay = sDay.format(new Date(time));
		String strDay = com.hwfs.sc.cmn.util.DateUtil.getYyyymmdd();//sDay.format(new Date(time));
		String strTime = sTime.format(new Date(time));
		
		/************************************************************************************************
		 * 가수금 대체 디테일 등록/수정/삭제, 가수금 마스터정보 변경
		************************************************************************************************/
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			
			//상태
			if(rowData.get("rowStatus") == null) sRowStatus = "";
			else sRowStatus = rowData.get("rowStatus").toString();
			
			//적용금액
			if(rowData.get("applyAmt") == null) iApplyAmt = 0;
			else iApplyAmt = Integer.parseInt(rowData.get("applyAmt").toString());

			//가수금대체번호
			if(rowData.get("altNum") == null) sAtlNum = "";
			else sAtlNum = rowData.get("altNum").toString();
			
			String sabun = suspenseCommonDAO.selectSabun(list.get(0));
			int altSeq;
			//가수금대체 디테일정보 등록(적용금액을 입력했을 경우)
			if("INSERT".equals(sRowStatus) && iApplyAmt > 0){

				//가수금 대체번호 채번(신규일 경우 채번)
				if(i == 0) sMaxAtlNum = suspenseCommonDAO.getMaxAtlNum(list.get(i));
				
				//순번 체크
				altSeq = suspenseCommonDAO.selectAltSeq(rowData);
				
				rowData.put("altSeq", altSeq);
				
				if("".equals(sAtlNum)) rowData.put("altNum", sMaxAtlNum);	//신규 가수금대체번호
				rowCnt += suspenseCommonDAO.insertSuspenseAltDtl(rowData);
				
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
				
				//if (rowData.containsKey("seq"))
				dto.setSeq(Integer.parseInt(rowData.get("altSeq").toString()));
				
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
				eaiService.call(dto);
//				EAIResponse res = eaiService.call(dto);
//				
//				if (res.isSuccess()) {
//					eaiCnt++;
//				}
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
				
				//if (rowData.containsKey("seq"))
				dto2.setSeq(Integer.parseInt(rowData.get("altSeq").toString()));
				
				//if (rowData.containsKey("sabun"))
				//dto2.setAltProcUser(rowData.get("sabun").toString().trim());
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
				eaiService.call(dto2);
//				EAIResponse res2 = eaiService.call(dto2);
//
//				if (res2.isSuccess()) {
//					eaiCnt++;
//				}				

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
				
				if (rowData.containsKey("altSeq"))
				dto1.setSeq(Integer.parseInt(rowData.get("altSeq").toString()));
				
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
				eaiService.call(dto1);
//				EAIResponse res1 = eaiService.call(dto1);
//				
//				if (res1.isSuccess()) {
//					eaiCnt++;
//				}
				

				/************************************************************************************************
				 * SAP IFC 가수금 입금 반제/취소 End
				************************************************************************************************/
			}
			
			//가수금 대체디테일정보 삭제(단건 대체취소 (ApplyAmt = 0))
			if("DELETE".equals(sRowStatus) && iApplyAmt == 0){
				rowCnt += suspenseCommonDAO.deleteSuspenseAltDtl(rowData);
				
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
				
				//if (rowData.containsKey("seq"))
				dto.setSeq(Integer.parseInt(rowData.get("altSeq").toString()));
				
				//if (rowData.containsKey("sabun"))
				//	dto.setAltProcUser(rowData.get("sabun").toString().trim());
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
				eaiService.call(dto);
//				EAIResponse res2 = eaiService.call(dto);
//
//				if (res2.isSuccess()) {
//					eaiCnt++;
//				}
				/************************************************************************************************
				 * SAP IFC 가수금 입금 반제취소 End
				************************************************************************************************/
			}
			
			//가수금 마스터정보 변경
			//rowCnt += suspenseCommonDAO.updateSuspenseApplyAmtProc(rowData);
		}

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
		
		reMapData.put("rowCnt", rowCnt);
		reMapData.put("atlNum", sMaxAtlNum);
		
		return reMapData;
	}
	
	public String nvls(Object col) throws Exception{
		if(col == null)
			return "";
		else
			return StringUtil.null2string(col.toString(), "");
	}
}
