package com.hwfs.sc.app.dao;

import java.util.Map;

import hone.core.util.record.RecordSet;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 식재앱 입금매입매출 인터페이스용  DAO 개체
 * @ClassName TransactionDAO.java
 * @Description  TransactionDAO Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2022.09.08.   구승모        최초생성
 * </pre>
 * @author 푸디스트
 * @since 2022.09.08.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by 한화시스템ICT CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sc/app/transactionDAO")
public class TransactionDAO extends DefaultDAO {
	/**
	 * 입금내역 조회
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectDepositInfo(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.transactionDAO.selectDepositInfo", parameter);
	}
	
	/**
	 * 매출실적 조회
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectCreditInfo(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.transactionDAO.selectCreditInfo", parameter);
	}

	/**
	 * 기본여신 조회
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectDefaultCreditInfo(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.transactionDAO.selectDefaultCreditInfo", parameter);
	}
	
	/**
	 * 매출액재료비 조회
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectProfitandlossInfo(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.transactionDAO.selectProfitandlossInfo", parameter);
	}
	
	/**
	 * 입고현황 조회
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectTransactionInfo(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.transactionDAO.selectTransactionInfo", parameter);
	}
	
	/**
	 * 입고현황상세 조회
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectTransactionDetailInfo(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.transactionDAO.selectTransactionDetailInfo", parameter);
	}
	
	/**
	 * 로그정보를 입력한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int logInsert(Map<String, Object> parameter) throws Exception {
		return super.update("sc.app.transactionDAO.logInsert", parameter);
	}
	
}
