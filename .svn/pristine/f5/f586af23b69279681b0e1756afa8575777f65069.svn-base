package com.hwfs.fs.fsl.dao;

import hone.core.util.record.RecordSet;

import java.sql.Types;
import java.util.Map;

import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 선수금관리하는 UpjangMealTicketRegMgnt DAO
 * 
 * @ClassName UpjangMealTicketRegMgntDAO.java
 * @Description UpjangMealTicketRegMgntDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.06.02   	손형민        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 손형민
 * @since 2015.06.02
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fs/fsl/upjangMealTicketRegMgntDAO")
public class UpjangMealTicketRegMgntDAO extends DefaultDAO {
	
	/**
	 * 선수금관리 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsl.upjangMealTicketRegMgntDAO.selectList", mapParam);
	}
	
	/**
	 * 식권 수불 내역을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet ticketHistory(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsl.upjangMealTicketRegMgntDAO.ticketHistory", mapParam);
	}
	
	/**
	 * 카드  목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet cardList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsl.upjangMealTicketRegMgntDAO.cardList", mapParam);
	}
	
	/**
	 * 삭제전 매출등록 여부 확인
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectSaleRegMgnt(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsl.upjangMealTicketRegMgntDAO.selectSaleRegMgnt", mapParam);
	}
	
	
	/**
	 * IF 식권판매 마스터(을)를 등록, 수정, 삭제 한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int ticketSalMst_insert(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsl.upjangMealTicketRegMgntDAO.ticketSalMst_insert", mapParam);
	}
	
	public int ticketSalMst_update(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsl.upjangMealTicketRegMgntDAO.ticketSalMst_update", mapParam);
	}
	
	public int ticketSalMst_delete(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsl.upjangMealTicketRegMgntDAO.ticketSalMst_delete", mapParam);
	}
	
	/**
	 * IF 식권 결제 수단(을)를 등록, 수정, 삭제 한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int ticketSettleWay_insert(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsl.upjangMealTicketRegMgntDAO.ticketSettleWay_insert", mapParam);
	}
	
	public int ticketSettleWay_update(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsl.upjangMealTicketRegMgntDAO.ticketSettleWay_update", mapParam);
	}
	
	public int ticketSettleWay_delete(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsl.upjangMealTicketRegMgntDAO.ticketSettleWay_delete", mapParam);
	}
	
	/**
	 * IF 선수금 발생(을)를 등록, 수정, 삭제 한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int advanceOccur_insert(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsl.upjangMealTicketRegMgntDAO.advanceOccur_insert", mapParam);
	}
	
	public int advanceOccur_update(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsl.upjangMealTicketRegMgntDAO.advanceOccur_update", mapParam);
	}
	
	public int advanceOccur_delete(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsl.upjangMealTicketRegMgntDAO.advanceOccur_delete", mapParam);
	}
	
	/**
	 * IF 선수금 결제 수단(을)를 등록, 수정, 삭제 한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int advanceSettleWay_insert(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsl.upjangMealTicketRegMgntDAO.advanceSettleWay_insert", mapParam);
	}
	
	public int advanceSettleWay_update(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsl.upjangMealTicketRegMgntDAO.advanceSettleWay_update", mapParam);
	}
	
	public int advanceSettleWay_delete(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsl.upjangMealTicketRegMgntDAO.advanceSettleWay_delete", mapParam);
	}
	
	/**
	 * IF 카드 정보를 등록, 수정, 삭제 한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int cardApprvInfo_insert(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsl.upjangMealTicketRegMgntDAO.cardApprvInfo_insert", mapParam);
	}
	
	public int cardApprvInfo_update(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsl.upjangMealTicketRegMgntDAO.cardApprvInfo_update", mapParam);
	}
	
	public int cardApprvInfo_delete(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsl.upjangMealTicketRegMgntDAO.cardApprvInfo_delete", mapParam);
	}
	public String cardApprvInfo_cnt(Map<String, Object> mapParam) throws Exception {
		return (String)super.queryForObject("fs.fsl.upjangMealTicketRegMgntDAO.cardApprvInfo_cnt", mapParam, null);
	}
	
	/**
	 * 마지막 SEQ 번호를 조회 한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public String advanceSeq(Map<String, Object> mapParam) throws Exception {
		return (String)super.queryForObject("fs.fsl.upjangMealTicketRegMgntDAO.advanceSeq", mapParam , null);
	}
	
	public String ticketSeq(Map<String, Object> mapParam) throws Exception {
		return (String)super.queryForObject("fs.fsl.upjangMealTicketRegMgntDAO.ticketSeq", mapParam , null);
	}
	
	
	/**
	 * 가맹점 번호를 조회 한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public String frncStorNum(Map<String, Object> mapParam) throws Exception {
		return (String)super.queryForObject("fs.fsl.upjangMealTicketRegMgntDAO.frncStorNum", mapParam , null);
	}
	
	/**
	 * 영수증번호를 조회한다(일반)
	 *
	 * @param mapParam
	 * @return
	 */
	public String receiptNumAdvance(Map<String, Object> mapParam) throws Exception {
		return (String)super.queryForObject("fs.fsl.upjangMealTicketRegMgntDAO.receiptNumAdvance", mapParam, null);
	}
	
	/**
	 * 영수증번호를 조회한다(티켓)
	 *
	 * @param mapParam
	 * @return
	 */
	public String receiptNumTicKet(Map<String, Object> mapParam) throws Exception {
		return (String)super.queryForObject("fs.fsl.upjangMealTicketRegMgntDAO.receiptNumTicKet", mapParam, null);
	}
	
	/**
	 * 식권 판매 관리(을)를 등록, 삭제 한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int ticket_insert(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsl.upjangMealTicketRegMgntDAO.ticket_insert", mapParam);
	}
	
	public int ticket_update(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsl.upjangMealTicketRegMgntDAO.ticket_update", mapParam);
	}
	
	
	public int ticket_delete(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsl.upjangMealTicketRegMgntDAO.ticket_delete", mapParam);
	}
	
	public String ticketMstGroupSeq(Map<String, Object> mapParam) throws Exception {
		return (String)super.queryForObject("fs.fsl.upjangMealTicketRegMgntDAO.ticketMstGroupSeq", mapParam , null);
	}
	
	/**
	 * 마감여부를 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet dtCnt(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsl.upjangMealTicketRegMgntDAO.dtCnt", mapParam);
	}
	
	/**
	 * 입금여부를 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet rvCnt(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsl.upjangMealTicketRegMgntDAO.rvCnt", mapParam);
	}
		
	/**
	 * 사업장일마감 기획승인여부를 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectApprv(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsl.upjangMealTicketRegMgntDAO.selectApprv", mapParam);
	}
	
	/**
	 * 건별 취소, 추가 프로시져호출
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param inParam
	 * @param callProcName
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> callCloseProcedure(Map<String, Object> inParam, String callProcName) throws Exception{
		//전달 순서대로 생성
		SqlParameter[] sqlParameter = new SqlParameter[]{
			new SqlParameter("P_OCCUR_DATE", Types.VARCHAR),
			new SqlParameter("P_SYS_CLASS", Types.VARCHAR),
			new SqlParameter("P_UPJANG_CD", Types.VARCHAR),
			new SqlParameter("P_OCCUR_ADVANCE_NUM", Types.VARCHAR),
			new SqlParameter("P_RECEIPT_NUM", Types.VARCHAR),
			new SqlOutParameter("O_RTN",    	Types.VARCHAR),
            new SqlOutParameter("O_RTNMSG", 	Types.VARCHAR)
		};
		
		// Procedure Call
		return callProcedure(callProcName, sqlParameter, inParam);
	}
	
	/**
	 * 전일 식권 판매 여부 확인.
	 *
	 * @param mapParam
	 * @return
	 */
	public int selectTicketMst(Map<String, Object> mapParam) throws Exception {
		return super.queryForInt("fs.fsl.upjangMealTicketRegMgntDAO.selectTicketMst", mapParam);
	}
	
	/**
	 * 전일 식권 판매 여부 확인.
	 *
	 * @param mapParam
	 * @return
	 */
	public String advance(Map<String, Object> mapParam) throws Exception {
		return (String)super.queryForObject("fs.fsl.upjangMealTicketRegMgntDAO.advance", mapParam, null);
	}
	
	/**
	 * 교환식권 선수금 등록 여부 확인.
	 *
	 * @param mapParam
	 * @return
	 */
	public String selectTicketChgReceiptNum(Map<String, Object> mapParam) throws Exception {
		return (String)super.queryForObject("fs.fsl.upjangMealTicketRegMgntDAO.selectTicketChgReceiptNum", mapParam, null);
	}
	
	/**
	 * 교환식권 선수금 등록 영수증번호 업데이트.
	 *
	 * @param mapParam
	 * @return
	 */
	public int chgReceiptNum_Update(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsl.upjangMealTicketRegMgntDAO.chgReceiptNum_Update", mapParam);
	}
	
	/**
	 * 교환식권 선수금 삭제 영수증번호 제거 업데이트.
	 *
	 * @param mapParam
	 * @return
	 */
	public int chgReceiptNum_Dupdate(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsl.upjangMealTicketRegMgntDAO.chgReceiptNum_Dupdate", mapParam);
	}
	
}
