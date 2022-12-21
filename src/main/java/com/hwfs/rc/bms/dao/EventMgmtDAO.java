package com.hwfs.rc.bms.dao;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;

import java.sql.Types;
import java.util.Map;

import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * EventMgmtDAO에 대한 설명 작성
 * @ClassName EventMgmtDAO.java
 * @Description EventMgmtDAO Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 6. 30.   박대영        최초생성
 * </pre>
 * @author FC종합전산구축 : 연회웨딩
 * @since 2015. 6. 30.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/rc/bms/eventMgmtDAO")
public class EventMgmtDAO extends DefaultDAO {

	//중복예약 체크
	public RecordSet reservDuplicationCheck(Map<String, Object> parameter) {
		return super.queryForRecordSet("rc.bms.eventMgmtDAO.reservDuplicationCheck", parameter);
	}

	public RecordSet selectListMst(Map<String, Object> parameter) {
		return super.queryForRecordSet("rc.bms.eventMgmtDAO.selectListMst", parameter);
	}
	
	public RecordSet selectListWedding(Map<String, Object> parameter) {
		return super.queryForRecordSet("rc.bms.eventMgmtDAO.selectListWedding", parameter);
	}

	public RecordSet reservList(Map<String, Object> parameter) {
		return super.queryForRecordSet("rc.bms.eventMgmtDAO.reservList", parameter);
	} 
	
	public RecordSet selectListGoods(Map<String, Object> parameter) {
		return super.queryForRecordSet("rc.bms.eventMgmtDAO.selectListGoods", parameter);
	}
	public RecordSet selectListRoom(Map<String, Object> parameter) {
		return super.queryForRecordSet("rc.bms.eventMgmtDAO.selectListRoom", parameter);
	}
	  
	public RecordSet selectListPayment(Map<String, Object> parameter) {
		return super.queryForRecordSet("rc.bms.eventMgmtDAO.selectListPayment", parameter);
	}

	/**
	 * maxCodeCreate 기능 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @return
	 */
	//마스터 (예약번호 생성 년월(6) 일련번호(6)
	public Record maxCodeCreateMst(Map<String, Object> parameter) {
		return super.queryForRecord("rc.bms.eventMgmtDAO.maxCodeCreateMst","");
	}
	
	//룸예약 일련번호 생성
	public Record maxCodeCreateRoom(Map<String, Object> parameter) {
		return super.queryForRecord("rc.bms.eventMgmtDAO.maxCodeCreateRoom",parameter);
	}
	//메뉴(식음,기타,외부) 일련번호 생성
	public Record maxCodeCreateGoods(Map<String, Object> parameter) {
		return super.queryForRecord("rc.bms.eventMgmtDAO.maxCodeCreateGoods",parameter);
	}
	
	//지불조건 일련번호 생성 maxCodeCreatePayment
	public Record maxCodeCreatePayment(Map<String, Object> parameter) {
		return super.queryForRecord("rc.bms.eventMgmtDAO.maxCodeCreatePayment",parameter);
	}
	/**
	 * insertMgmt 기능 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	 
	public int insertDataMst(Map<String, Object> parameter) {
		return super.update("rc.bms.eventMgmtDAO.insertDataMst", parameter);
	}
	
	public int insertDataGoods(Map<String, Object> parameter) {
		return super.update("rc.bms.eventMgmtDAO.insertDataGoods", parameter);
	}
	public int insertDataRoom(Map<String, Object> parameter) {
		return super.update("rc.bms.eventMgmtDAO.insertDataRoom", parameter);
	}
	public int insertDataOther(Map<String, Object> parameter) {
		return super.update("rc.bms.eventMgmtDAO.insertDataOther", parameter);
	}
	public int insertDataOutSide(Map<String, Object> parameter) {
		return super.update("rc.bms.eventMgmtDAO.insertDataOutSide", parameter);
	}
	
	public int insertDataWedding(Map<String, Object> parameter) {
		return super.update("rc.bms.eventMgmtDAO.insertDataWedding", parameter);
	}
	
	
	public int insertDataPayment(Map<String, Object> parameter) {
		return super.update("rc.bms.eventMgmtDAO.insertDataPayment", parameter);
	}
	
	
	
 
	
	//선수금 발생 정보
	public RecordSet selectListCardVan(Map<String, Object> parameter) {
		return super.queryForRecordSet("rc.bms.eventMgmtDAO.selectListCardVan", parameter);
	}
	
	public Map<String, Object> insertDataAdvanceIns(Map<String, Object> parameter) throws Exception { SqlParameter[] sqlParameter = new SqlParameter[] {
			    
			    new SqlParameter("P_SYS_CLASS",     Types.VARCHAR),    
			    new SqlParameter("P_OCCUR_DATE",    Types.VARCHAR),
			    new SqlParameter("P_UPJANG_CD",     Types.NUMERIC),
			    new SqlParameter("P_RECEIPT_NUM",   Types.VARCHAR),
			    new SqlParameter("P_POS_GUESTINFO", Types.VARCHAR),
				new SqlParameter("P_CUST_CD",       Types.NUMERIC), 
				new SqlParameter("P_CUST_NM",       Types.VARCHAR),
				new SqlParameter("P_TEL_NUM",       Types.VARCHAR),
				new SqlParameter("P_REMARK",        Types.VARCHAR),
				new SqlParameter("P_AMT",           Types.NUMERIC),
				new SqlParameter("P_SUPPLY_AMT",    Types.NUMERIC),
				new SqlParameter("P_VAT_AMT",       Types.NUMERIC),
				new SqlParameter("P_SETTLE_CLASS",  Types.VARCHAR),
				new SqlParameter("P_ADVANCE_CLASS", Types.VARCHAR),
				new SqlParameter("P_CUSER",         Types.VARCHAR),
			    
	            new SqlOutParameter("O_RTN",        Types.VARCHAR),
	            new SqlOutParameter("O_MESSAGE",    Types.VARCHAR)

			};

		return super.callProcedure("SP_SLA_IF_ADVANCE_OCCUR_INS", sqlParameter, parameter);
		
	}
	
	//결제내역 저장
	/*
	P_SYS_CLASS         IN  VARCHAR2,   --시스템구분
	P_OCCUR_DATE        IN  VARCHAR2,   --발생일자
	P_UPJANG_CD         IN  NUMBER,     --업장
	P_RECEIPT_NUM       IN  VARCHAR2,   --영수증번호
	P_SETTLE_CLASS	    IN  VARCHAR2,   --결제구분
	P_SETTLE_REF_INFO	IN	VARCHAR2,	--결제 참조정보
	P_CUST_CD			IN	NUMBER,	    --거래처코드
	P_CUST_NM			IN  VARCHAR2,	--거래처명
	P_SETTLE_AMT		IN  NUMBER,	    --결제금액
	P_ENC_SETTLE_INFO	IN	VARCHAR2,	--암호화 결제 정보
	P_APPRV_NUM		    IN	VARCHAR2,	--승인 번호
	P_CUSER			    IN	VARCHAR2,	--등록자
	O_RTN			    OUT VARCHAR2,   --RETURN 값
	O_MESSAGE		    OUT VARCHAR2    --RETURN MESSAGE
	 */
	
	public Map<String, Object> insertDataAdvancePay(Map<String, Object> parameter) throws Exception { SqlParameter[] sqlParameter = new SqlParameter[] {
		    
		    new SqlParameter("P_SYS_CLASS",       Types.VARCHAR),    
		    new SqlParameter("P_OCCUR_DATE",      Types.VARCHAR),
		    new SqlParameter("P_UPJANG_CD",       Types.VARCHAR),
		    new SqlParameter("P_RECEIPT_NUM",     Types.VARCHAR),
		    new SqlParameter("P_SETTLE_CLASS",    Types.VARCHAR),
		    new SqlParameter("P_SETTLE_REF_INFO", Types.VARCHAR),
		    new SqlParameter("P_CUST_CD",         Types.NUMERIC), 
			new SqlParameter("P_CUST_NM",         Types.VARCHAR),
			new SqlParameter("P_SETTLE_AMT",      Types.NUMERIC),
			new SqlParameter("P_ENC_SETTLE_INFO", Types.VARCHAR),
			new SqlParameter("P_APPRV_NUM",       Types.VARCHAR),
			new SqlParameter("P_CUSER",           Types.VARCHAR),
            new SqlOutParameter("O_RTN",          Types.VARCHAR),
            new SqlOutParameter("O_MESSAGE",      Types.VARCHAR)

			};

		return super.callProcedure("SP_SLA_IF_ADVANCE_SETTLE_INS", sqlParameter, parameter);
	
	}
	
	//선수금 취소
	/*
	 *  P_SYS_CLASS      IN  VARCHAR2,   --시스템구분
		P_OCCUR_DATE     IN  VARCHAR2,   --판매일자
		P_UPJANG_CD      IN  NUMBER,     --업장
		P_RECEIPT_NUM    IN  VARCHAR2,   --영수증번호
		P_USER           IN  VARCHAR2,   --사용자
		O_RTN            OUT VARCHAR2,   --RETURN 값
		O_MESSAGE        OUT VARCHAR2    --RETURN MESSAGE
	 */

	public Map<String, Object> insertDataAdvanceCancel(Map<String, Object> parameter) throws Exception { SqlParameter[] sqlParameter = new SqlParameter[] {
		    
		    new SqlParameter("P_SYS_CLASS",       Types.VARCHAR),    
		    new SqlParameter("P_OCCUR_DATE",      Types.VARCHAR),
		    new SqlParameter("P_UPJANG_CD",       Types.VARCHAR),
		    new SqlParameter("P_RECEIPT_NUM",     Types.VARCHAR),
			new SqlParameter("P_USER",            Types.VARCHAR),
			
            new SqlOutParameter("O_RTN",          Types.VARCHAR),
            new SqlOutParameter("O_MESSAGE",      Types.VARCHAR)

			};

		return super.callProcedure("SP_SLA_IF_ADVANCE_OCCUR_CANCEL", sqlParameter, parameter);
	
	}

	 
	
	
	/**
	 * updateAmMgmt  수정한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	
	public int updateDataMst(Map<String, Object> parameter) {
		return super.update("rc.bms.eventMgmtDAO.updateDataMst", parameter);
	}
	
	public int updateDataGoods(Map<String, Object> parameter) {
		return super.update("rc.bms.eventMgmtDAO.updateDataGoods", parameter);
	}
	
	public int updateDataRoom(Map<String, Object> parameter) {
		return super.update("rc.bms.eventMgmtDAO.updateDataRoom", parameter);
	}
	
	public int updateDataOther(Map<String, Object> parameter) {
		return super.update("rc.bms.eventMgmtDAO.updateDataOther", parameter);
	}

	public int updateDataOutSide(Map<String, Object> parameter) {
		return super.update("rc.bms.eventMgmtDAO.updateDataOutSide", parameter);
	}
	
	public int updateDataWedding(Map<String, Object> parameter) {
		return super.update("rc.bms.eventMgmtDAO.updateDataWedding", parameter);
	}
	
	//이력 저장 프로시져 호출
	public Map<String, Object> reservLogSave(Map<String, Object> parameter) throws Exception { SqlParameter[] sqlParameter = new SqlParameter[] {
			    new SqlParameter("V_RESERV_NUM", Types.VARCHAR),
	            new SqlOutParameter("O_RTN", Types.VARCHAR),
	            new SqlOutParameter("O_RTNMSG", Types.VARCHAR)
			};

		return super.callProcedure("BMS_RESERV_LOG_PRO", sqlParameter, parameter);
	}

	
}
