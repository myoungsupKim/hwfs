package com.hwfs.fs.fsl.dao;

import hone.core.util.record.RecordSet;

import java.sql.Types;
import java.util.Map;

import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 급식의 매출(식권/장례식장 등)을 관리하는 화면이다.하는 UpjangSaleRegMgnt DAO
 * 
 * @ClassName UpjangSaleRegMgntDAO.java
 * @Description UpjangSaleRegMgntDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.20   	손형민        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 손형민
 * @since 2015.05.20
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fs/fsl/upjangSaleRegMgntDAO")
public class UpjangSaleRegMgntDAO extends DefaultDAO {
	
	/**
	 * 매출등록 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsl.upjangSaleRegMgntDAO.selectList", mapParam);
	}
	public RecordSet selectSgList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsl.upjangSaleRegMgntDAO.selectSgList", mapParam);
	}
	public RecordSet selectSgListStat(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsl.upjangSaleRegMgntDAO.selectSgListStat", mapParam);
	}
	public RecordSet selectSgListStat2(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsl.upjangSaleRegMgntDAO.selectSgListStat2", mapParam);
	}
	
	/**
	 * 매출등록 목록을 조회한다(하단).
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectListSysClass(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsl.upjangSaleRegMgntDAO.selectListSysClass", mapParam);
	}
	
	
	/**
	 * 매출등록(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int mst_insert(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsl.upjangSaleRegMgntDAO.mst_insert", mapParam);
	}
	public int detail_insert(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsl.upjangSaleRegMgntDAO.detail_insert", mapParam);
	}
	public int payment_insert(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsl.upjangSaleRegMgntDAO.payment_insert", mapParam);
	}
	
	/**
	 * 매출등록(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int mst_update(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsl.upjangSaleRegMgntDAO.mst_update", mapParam);
	}
	public int detail_update(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsl.upjangSaleRegMgntDAO.detail_update", mapParam);
	}
	public int payment_update(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsl.upjangSaleRegMgntDAO.payment_update", mapParam);
	}
	public int ar_update(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsl.upjangSaleRegMgntDAO.ar_update", mapParam);
	}
	/**
	 * 매출등록(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int mst_delete(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsl.upjangSaleRegMgntDAO.mst_delete", mapParam);
	}
	public int detail_delete(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsl.upjangSaleRegMgntDAO.detail_delete", mapParam);
	}
	public int payment_delete(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsl.upjangSaleRegMgntDAO.payment_delete", mapParam);
	}
	public int paymentAdvance_delete(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsl.upjangSaleRegMgntDAO.paymentAdvance_delete", mapParam);
	}
	/**
	 * 카드승인 정보를 저장한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int card_insert(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsl.upjangSaleRegMgntDAO.card_insert", mapParam);
	}
	public int card_update(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsl.upjangSaleRegMgntDAO.card_update", mapParam);
	}
	public int card_delete(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsl.upjangSaleRegMgntDAO.card_delete", mapParam);
	}
	
	/**
	 * 업장 CC_CD를 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectUpjangCcCdInfo(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsl.upjangSaleRegMgntDAO.selectUpjangCcCdInfo", mapParam);
	}
	
	/**
	 * 창고 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet posClassList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsl.upjangSaleRegMgntDAO.posClassList", mapParam);
	}
	
	/**
	 * 회수예정일을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectExpDt(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsl.upjangSaleRegMgntDAO.selectExpDt", mapParam);
	}
	
	/**
	 * 마감여부를 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet dtCnt(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsl.upjangSaleRegMgntDAO.dtCnt", mapParam);
	}
	
	/**
	 * 마감여부(전일자)를 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet dtCnt2(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsl.upjangSaleRegMgntDAO.dtCnt2", mapParam);
	}
	
	/**
	 * 전일자 마감여부를 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet dtCntCopy(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsl.upjangSaleRegMgntDAO.dtCntCopy", mapParam);
	}
	
	/**
	 * 상품권 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet evCnt(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsl.upjangSaleRegMgntDAO.evCnt", mapParam);
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
	 * 선수금잔액합계를 조회한다(선수식권)
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectSumAdvanceAmtTicketP2(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsl.upjangSaleRegMgntDAO.selectSumAdvanceAmtTicketP2", mapParam);
	}
	
	/**
	 * 선수금 차감 잔액을 조회한다(선수식권)
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectMinusAdvanceAmtTicketP2(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsl.upjangSaleRegMgntDAO.selectMinusAdvanceAmtTicketP2", mapParam);
	}
	
	/**
	 * 선수금잔액합계를 조회한다(외상식권)
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectSumAdvanceAmtTicketP3(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsl.upjangSaleRegMgntDAO.selectSumAdvanceAmtTicketP3", mapParam);
	}
	
	/**
	 * 선수금 차감 잔액을 조회한다(외상식권)
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectMinusAdvanceAmtTicketP3(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsl.upjangSaleRegMgntDAO.selectMinusAdvanceAmtTicketP3", mapParam);
	}
	
	/**
	 * 식권팝업용 번호를  생성한다
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectTmpSeq(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsl.upjangSaleRegMgntDAO.selectTmpSeq", mapParam);
	}
	
	/**
	 * 영수증번호를 조회한다
	 *
	 * @param mapParam
	 * @return
	 */
	public String receiptNum(Map<String, Object> mapParam) throws Exception {
		return (String)super.queryForObject("fs.fsl.upjangSaleRegMgntDAO.receiptNum", mapParam, null);
	}
	
	/**
	 * 식권 판매 관리(을)를 등록, 삭제 한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int ticket_insert(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsl.upjangSaleRegMgntDAO.ticket_insert", mapParam);
	}
	
	public int ticket_update(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsl.upjangSaleRegMgntDAO.ticket_update", mapParam);
	}
	
	
	public int ticket_delete(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsl.upjangSaleRegMgntDAO.ticket_delete", mapParam);
	}
	
	public String ticketMstGroupSeq(Map<String, Object> mapParam) throws Exception {
		return (String)super.queryForObject("fs.fsl.UpjangSaleRegMgntDAO.ticketMstGroupSeq", mapParam , null);
	}
	
	
	/**
	 * 건별권한을 갖기위한 기획자 승인여부 
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectCloseModifyreq(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsl.upjangSaleRegMgntDAO.selectCloseModifyreq", mapParam);
	}
	
	/**
	 * 사업장별 오픈일자 가져오기
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectOpenDate(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsl.upjangSaleRegMgntDAO.selectOpenDate", mapParam);
	}
	
	
	/**
	 * 주문확정 후 구매 프로시저 호출.
	 *
	 * @param mapParam
	 * @return
	 */
	public Map<String, Object> recepitModify(Map<String, Object> parameter, String procedureName) throws Exception {
		//전달 순서대로 설정
        SqlParameter[] sqlParameter = new SqlParameter[] {
            new SqlParameter("P_OCCUR_DATE",      	Types.VARCHAR),
            new SqlParameter("P_SYS_CLASS",      	Types.VARCHAR),
            new SqlParameter("P_UPJANG_CD",    		Types.VARCHAR),
            new SqlParameter("P_RECEIPT_NUM",   	Types.VARCHAR),
            new SqlOutParameter("O_RTN",  			Types.VARCHAR),
            new SqlOutParameter("O_RTNMSG",   		Types.VARCHAR)
        };
        /*
        	P_OCCUR_DATE	IN VARCHAR2,
		   	P_SYS_CLASS     IN  VARCHAR2,
		   	P_UPJANG_CD     IN  VARCHAR2,
		    P_RECEIPT_NUM   IN VARCHAR2,
		   	O_RTN         	OUT VARCHAR2,
		   	O_RTNMSG      	OUT VARCHAR2
         */
        // procedure 호출
        return callProcedure(procedureName, sqlParameter, parameter);
	}
	
	/**
	 * 전일 식권 판매 여부 확인.
	 *
	 * @param mapParam
	 * @return
	 */
	public int selectTicketMst(Map<String, Object> mapParam) throws Exception {
		return super.queryForInt("fs.fsl.upjangSaleRegMgntDAO.selectTicketMst", mapParam);
	}
	
	/**
	 * 선수금 일반 잔액 조회
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectAdvanceAmtList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsl.upjangSaleRegMgntDAO.selectAdvanceAmtList", mapParam);
	}
}
