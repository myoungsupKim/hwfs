package com.hwfs.fs.fsl.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.math.BigDecimal;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.exception.BizException;
import com.hwfs.fs.fsl.dao.UpjangMealTicketRegMgntDAO;
import com.hwfs.sc.cmn.util.StringUtil;
import com.tobesoft.xplatform.data.DataSet;
import com.hwfs.sc.cmn.sap.request.SuspenseReceiveRequest;
import com.hwfs.sc.cmn.sap.service.EAIService;
import com.hwfs.sm.cmn.dao.SuspenseCommonDAO;

 /**
 * 선수금관리하는 UpjangMealTicketRegMgnt Service Implementation
 * 
 * @ClassName UpjangMealTicketRegMgntServiceImpl.java
 * @Description UpjangMealTicketRegMgntServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.06.02    손형민        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 손형민
 * @since 2015.06.02
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fs/fsl/upjangMealTicketRegMgntService")
public class UpjangMealTicketRegMgntServiceImpl extends DefaultServiceImpl implements UpjangMealTicketRegMgntService {
	/** UpjangMealTicketRegMgntDAO Bean 생성 */
	@Resource(name = "/fs/fsl/upjangMealTicketRegMgntDAO")
	private UpjangMealTicketRegMgntDAO upjangMealTicketRegMgntDAO;
	
	/** SuspenseCommonDAO Bean 생성 */
	@Resource(name = "/sm/cmn/suspenseCommonDAO")
	private SuspenseCommonDAO suspenseCommonDAO;
	
	@Resource(name = "EAIService")
	EAIService eaiService;	
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	/**
	 * 선수금관리 목록을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return upjangMealTicketRegMgntDAO.selectList(mapParam);
	}
	
	/**
	 * 식권 수불 내역을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet ticketHistory(Map<String, Object> mapParam) throws Exception {
		return upjangMealTicketRegMgntDAO.ticketHistory(mapParam);
	}
	
	
	/**
	 * 카드목록을 조회 한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet cardList(Map<String, Object> mapParam) throws Exception {
		return upjangMealTicketRegMgntDAO.cardList(mapParam);
	}
	
	/**
	 * 삭제전 매출등록 여부 확인
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectSaleRegMgnt(Map<String, Object> mapParam) throws Exception {
		return upjangMealTicketRegMgntDAO.selectSaleRegMgnt(mapParam);
	}

	/**
	 * 선수금관리 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
	public int saveList(DataSetMap list, DataSetMap ticket) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		int ticketRowCnt = 0;
		String receiptNum = "";
		String tmpSeq = "";
		int altSeq = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				//receiptNum 생성
				if("001".equals(rowData.get("advanceClass").toString()) || "002".equals(rowData.get("advanceClass").toString()) || "004".equals(rowData.get("advanceClass").toString())){//식권
					receiptNum = upjangMealTicketRegMgntDAO.receiptNumTicKet(rowData); 
				}else{
					receiptNum = upjangMealTicketRegMgntDAO.receiptNumAdvance(rowData); 
				}
				
				rowData.put("receiptNum", receiptNum);
				if("3".equals(rowData.get("settleClass").toString())){//결제 구분 카드
					//순번 체크
					rowData.put("sapSuspenseNum", rowData.get("settleRefInfo"));
					altSeq = suspenseCommonDAO.selectAltSeq(rowData);
					rowData.put("altSeq", altSeq);
				}
				
				if("001".equals(rowData.get("advanceClass").toString()) || "002".equals(rowData.get("advanceClass").toString()) || "004".equals(rowData.get("advanceClass").toString())){//식권
					//교환식권일경우 판매된 식권없음. 무시
					if(!"004".equals(rowData.get("advanceClass").toString())){
						int ticketCnt = upjangMealTicketRegMgntDAO.selectTicketMst(rowData);
						if(ticketCnt > 0){
							throw new BizException("이후에 판매된 식권이존재하여 입력할 수 없습니다.");
						}
					}else{
						//교환식권(004)일 경우 저장 할땐 advanceClass = '001' 로 변경.
						logger.debug("rowData : " + rowData.toString());
						String chgReceiptNum = upjangMealTicketRegMgntDAO.selectTicketChgReceiptNum(rowData);
						if(!"".equals(nvls(chgReceiptNum))){
							throw new BizException("교환식권에 등록된 선수금이 존재합니다.\n재 조회 후 다시 등록 해 주세요.");
							
						}
						//교환식권에 영수증번호 등록.
						insRowCnt += upjangMealTicketRegMgntDAO.chgReceiptNum_Update(rowData);
					}
					
					String seq = upjangMealTicketRegMgntDAO.advanceSeq(rowData);
					rowData.put("seq", seq);
					
					insRowCnt += upjangMealTicketRegMgntDAO.ticketSalMst_insert(rowData);
					insRowCnt += upjangMealTicketRegMgntDAO.ticketSettleWay_insert(rowData);
					
					
				}else{//그외(선수일반)
					String seq = upjangMealTicketRegMgntDAO.advanceSeq(rowData);
					rowData.put("seq", seq);
					
					insRowCnt += upjangMealTicketRegMgntDAO.advanceOccur_insert(rowData);
					insRowCnt += upjangMealTicketRegMgntDAO.advanceSettleWay_insert(rowData);
				}
				if("2".equals(rowData.get("settleClass").toString())){//결제 구분 카드
					insRowCnt += upjangMealTicketRegMgntDAO.cardApprvInfo_insert(rowData);
				}
				/*가수금 EAI 전송 추가 : 김명호 2016-01-16 */
				if("3".equals(rowData.get("settleClass").toString())){//결제 구분 가수금
					//순번 체크
					rowData.put("altSeq", altSeq);	
					
					long time = System.currentTimeMillis();
					
					SimpleDateFormat sDay = new SimpleDateFormat("yyyymmdd", java.util.Locale.getDefault());
					SimpleDateFormat sTime = new SimpleDateFormat("HHmmss", java.util.Locale.getDefault());
					
					String strDay = com.hwfs.sc.cmn.util.DateUtil.getYyyymmdd();//sDay.format(new Date(time));
					String strTime = sTime.format(new Date(time));					
					
					//가수금대체 디테일정보 등록(적용금액을 입력했을 경우)
					String sabun = suspenseCommonDAO.selectSabun(rowData);					
					
					/************************************************************************************************
					 * SAP IFC 가수금 입금 반제 Start
					************************************************************************************************/
					
					SuspenseReceiveRequest dto = new SuspenseReceiveRequest();
					
					dto.setBuCd("2000");					
					if (rowData.containsKey("settleRefInfo"))
						dto.setSapSuspenseNum(rowData.get("settleRefInfo").toString().trim());
					//if (rowData.containsKey("seq"))
					dto.setSeq(Integer.parseInt(rowData.get("altSeq").toString()));
					//if (rowData.containsKey("sabun"))
					dto.setAltProcUser(sabun.toString().trim());
					if (rowData.containsKey("amt"))
						dto.setAmt((BigDecimal) rowData.get("amt"));
					if (rowData.containsKey("ccCd"))
						dto.setCcCd(rowData.get("ccCd").toString().trim());
					if (rowData.containsKey("occurDate"))
						dto.setAltDate(rowData.get("occurDate").toString().trim());
					dto.setSapCustCd("");
					
					dto.setAltProcDate(strDay);
					dto.setAltProcTime(strTime);
					dto.setCurrency("KRW");
					dto.setAltSlipNum(" ");
					dto.setReqType("1");
					eaiService.call(dto);
				}
				
				tmpSeq = rowData.get("tmpSeq").toString();
				receiptNum = rowData.get("receiptNum").toString();
				// 식권 판매 매출 저장 mas_ticket_mst
				ticketRowCnt= ticketSave(ticket, receiptNum, tmpSeq);
				
				logger.debug("modifySalsYn = "+nvls(rowData.get("modifySalsYn")));
				
				// 저장완료후 건별 추가일때는 프로시져 호출 : 2015.10.23 추가
				if("A".equals(nvls(rowData.get("modifySalsYn")))){
					logger.debug("===============================================================");
					logger.debug("저장후 건별추가일때는 영수증 번호로 프로시져 호출 / 영수증번호 = " + receiptNum);
					logger.debug("===============================================================");
					
					Map<String, Object> inParam = new HashMap<String, Object>();
					Map<String, Object> retVal = new HashMap<String, Object>();
					//String strRtn	= null;
					//String strRtnMsg= null;
					
					inParam.put("P_OCCUR_DATE", rowData.get("occurDate"));
					inParam.put("P_SYS_CLASS", rowData.get("sysClass"));
					inParam.put("P_UPJANG_CD", rowData.get("upjangCd"));
					inParam.put("P_RECEIPT_NUM", receiptNum); // 영수증번호 
					
					String callProcName = "";
					
					callProcName = "SP_SLA_ADVANCE_RECEIPT_PROC";
					
					// 건별마감 procedure 호출 : 2015.10.23
					retVal = upjangMealTicketRegMgntDAO.callCloseProcedure(inParam, callProcName);
					//strRtn = String.valueOf(rowData.get("O_RTN"));
					//strRtnMsg = String.valueOf(rowData.get("O_RTNMSG"));
					
					logger.debug("====================================================================");
					logger.debug("프로시저 결과");
					logger.debug("O_RTN = " + retVal.get("O_RTN"));
					logger.debug("O_RTNMSG = " + retVal.get("O_RTNMSG"));
					logger.debug("====================================================================");
					
					// 프로시저 실패시 롤백
					if("FALSE".equals(retVal.get("O_RTN").toString())){
						throw new BizException(retVal.get("O_RTNMSG").toString());
					}
				}
			}
			//Update 처리
//			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
//				if("001".equals(rowData.get("advanceClass").toString()) || "002".equals(rowData.get("advanceClass").toString())){//식권
//					updRowCnt += upjangMealTicketRegMgntDAO.ticketSalMst_update(rowData);
//					updRowCnt += upjangMealTicketRegMgntDAO.ticketSettleWay_update(rowData);
//				}else{
//					updRowCnt += upjangMealTicketRegMgntDAO.advanceOccur_update(rowData);
//					updRowCnt += upjangMealTicketRegMgntDAO.advanceSettleWay_update(rowData);
//				}
//				if("2".equals(rowData.get("settleClass").toString())){//결제 구분 카드
//					String cnt = upjangMealTicketRegMgntDAO.cardApprvInfo_cnt(rowData);
//					if(Integer.valueOf(cnt) > 0){
//						updRowCnt += upjangMealTicketRegMgntDAO.cardApprvInfo_update(rowData);
//					}else{
//						insRowCnt += upjangMealTicketRegMgntDAO.cardApprvInfo_insert(rowData);
//					}
//				}else{
//					delRowCnt += upjangMealTicketRegMgntDAO.cardApprvInfo_delete(rowData);
//				}
//			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				logger.debug("rowData : " + rowData);
				String advanceDelYn = upjangMealTicketRegMgntDAO.advance(rowData);
				if(advanceDelYn != null &&"Y".equals(advanceDelYn)){
					throw new BizException("영업회계 선수금이 존재하여 삭제할 수 없습니다.");
				}
				if("001".equals(rowData.get("advanceClass").toString()) || "002".equals(rowData.get("advanceClass").toString()) || "004".equals(rowData.get("advanceClass").toString())){//식권
					delRowCnt += upjangMealTicketRegMgntDAO.ticketSalMst_delete(rowData);
					delRowCnt += upjangMealTicketRegMgntDAO.ticketSettleWay_delete(rowData);
				}else{
					delRowCnt += upjangMealTicketRegMgntDAO.advanceOccur_delete(rowData);
					delRowCnt += upjangMealTicketRegMgntDAO.advanceSettleWay_delete(rowData);
				}
				if("2".equals(rowData.get("settleClass").toString())){//결제 구분 카드
					delRowCnt += upjangMealTicketRegMgntDAO.cardApprvInfo_delete(rowData);
				}
				
				//mas_ticket_mst
				delRowCnt += upjangMealTicketRegMgntDAO.ticket_delete(rowData);
				//교환 식권 영수증번호 NULL 업데이트 key : receiptNum
				delRowCnt += upjangMealTicketRegMgntDAO.chgReceiptNum_Dupdate(rowData);
				
				/*가수금 EAI 전송 추가 : 김명호 2016-01-16 */
				if(!rowData.get("altSeq").toString().isEmpty()){
					
					if("3".equals(rowData.get("settleClass").toString())){//결제 구분 가수금
						
						long time = System.currentTimeMillis();
						
						SimpleDateFormat sDay = new SimpleDateFormat("yyyymmdd", java.util.Locale.getDefault());
						SimpleDateFormat sTime = new SimpleDateFormat("HHmmss", java.util.Locale.getDefault());
						
						String strDay = com.hwfs.sc.cmn.util.DateUtil.getYyyymmdd();//sDay.format(new Date(time));
						String strTime = sTime.format(new Date(time));					
						
						//가수금대체 디테일정보 등록(적용금액을 입력했을 경우)
						String sabun = suspenseCommonDAO.selectSabun(rowData);					
						
						/************************************************************************************************
						 * SAP IFC 가수금 입금 반제 Start
						************************************************************************************************/
						
						SuspenseReceiveRequest dto = new SuspenseReceiveRequest();
						
	
						dto.setBuCd("2000");					
						if (rowData.containsKey("settleRefInfo"))
							dto.setSapSuspenseNum(rowData.get("settleRefInfo").toString().trim());
						//if (rowData.containsKey("seq"))
						dto.setSeq(Integer.parseInt(rowData.get("altSeq").toString()));
						//if (rowData.containsKey("sabun"))
						dto.setAltProcUser(sabun.toString().trim());
						
						//if (rowData.containsKey("settleAmt"))
							//dto.setAmt((BigDecimal) rowData.get("settleAmt"));
						double dblAmt = 0;
						dblAmt = Double.parseDouble(rowData.get("amt").toString());
											
						dto.setAmt(BigDecimal.valueOf(dblAmt) );
						
						if (rowData.containsKey("ccCd"))
							dto.setCcCd(rowData.get("ccCd").toString().trim());
						if (rowData.containsKey("occurDate"))
							dto.setAltDate(rowData.get("occurDate").toString().trim());
						dto.setSapCustCd("");
						
						dto.setAltProcDate(strDay);
						dto.setAltProcTime(strTime);
						dto.setCurrency("KRW");
						dto.setAltSlipNum(" ");
						dto.setReqType("2");
						eaiService.call(dto);
					}	
				}
					
			}
			
		}
				
		return insRowCnt + updRowCnt + delRowCnt + ticketRowCnt;
	}
	
	
	/**
	 * 선수금관리 식권 데이터를 rowType에 따라 Insert 처리한다.
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
	public int ticketSave(DataSetMap list, String receiptNum, String tmpSeq) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		String ticketMstGroupSeq = "";
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			if(tmpSeq.equals(rowData.get("tmpSeq").toString())){
				if("".equals(ticketMstGroupSeq)){
					ticketMstGroupSeq = upjangMealTicketRegMgntDAO.ticketMstGroupSeq(rowData);
				}
				
				rowData.put("receiptNum", receiptNum);
				rowData.put("ticketGroupSeq", ticketMstGroupSeq);
				insRowCnt += upjangMealTicketRegMgntDAO.ticket_insert(rowData);
			}
		}
		return insRowCnt + updRowCnt + delRowCnt;
	}

	/**
	 * 마감체크를 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet beforeDt(Map<String, Object> mapParam) throws Exception {
		return upjangMealTicketRegMgntDAO.dtCnt(mapParam);
	}
	
	/**
	 * 입금여부를 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet beforeRv(Map<String, Object> mapParam) throws Exception {
		return upjangMealTicketRegMgntDAO.rvCnt(mapParam);
	}
	
	/**
	 * 사업장일마감 기획승인여부를 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectApprv(Map<String, Object> mapParam) throws Exception {
		return upjangMealTicketRegMgntDAO.selectApprv(mapParam);
	}
	
	/**
	 * 건별취소 한다.
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public String modifySalsN(DataSetMap list) throws Exception {
	    
		String strRtn	= null;
		String strRtnMsg= null;
		int delRowCnt = 0;
		
		Map<String, Object> inParam = new HashMap<String, Object>();
		Map<String, Object> rowData = list.get(0);

		//입력값 Setting
		inParam.put("P_OCCUR_DATE",	String.valueOf(rowData.get("occurDate")));
		inParam.put("P_SYS_CLASS",	String.valueOf(rowData.get("sysClass")));
		inParam.put("P_UPJANG_CD",	String.valueOf(rowData.get("upjangCd")));
		inParam.put("P_OCCUR_ADVANCE_NUM",	String.valueOf(rowData.get("occurAdvanceNum")));	// 발생선수금 번호
		inParam.put("P_RECEIPT_NUM",	String.valueOf(rowData.get("receiptNum")));							// 영수증 번호

		String callProcName = "";
		callProcName = "SP_SLA_ADVANCE_RECEIPT_CANCEL";
		
		// 건별취소 Procedure 호출
		Map<String, Object> retVal = upjangMealTicketRegMgntDAO.callCloseProcedure(inParam, callProcName);

		//교환 식권 영수증번호 NULL 업데이트 key : receiptNum
		//건별 삭제 시 교환식권 영수증번호 초기화 안되는 오류 수정 선조치 2017.11.02 김호석
		delRowCnt = upjangMealTicketRegMgntDAO.chgReceiptNum_Dupdate(rowData);
		
		//출력값 Setting
		strRtn		= String.valueOf(retVal.get("O_RTN"));
		strRtnMsg	= String.valueOf(retVal.get("O_RTNMSG"));
		
		return strRtn + "|" + strRtnMsg;
	}
	
	public String nvls(Object col) throws Exception{
		if(col == null)
			return "";
		else
			return StringUtil.null2string(col.toString(), "");
	}
}
