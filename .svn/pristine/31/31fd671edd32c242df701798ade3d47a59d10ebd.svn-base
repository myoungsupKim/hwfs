package com.hwfs.sc.app.dao;

import java.util.Map;

import hone.core.util.record.RecordSet;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 식재앱 임시여신 인터페이스용  DAO 개체
 * @ClassName CreditOverDAO.java
 * @Description  CreditOverDAO Class 
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
@Repository("/sc/app/creditOverDAO")
public class CreditOverDAO extends DefaultDAO {
	/**
	 * 임시여신 신청내역 조회
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectCreditOverHist(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.creditOverDAO.selectCreditOverHist", parameter);
	}

	/**
	 * 임시여신 미승인건 존재여부 조회
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectCreditOverReqYn(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.creditOverDAO.selectCreditOverReqYn", parameter);
	}
	
	/**
	 * 임시여신 신청
	 *
	 * @param parameter
	 * @return
	 */
	public int saveCreditOver(Map<String, Object> parameter) throws Exception {
		return super.update("sc.app.creditOverDAO.saveCreditOver", parameter);
	}
	
	/**
	 * 임시여신 승인여부 조회
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectCreditOverApprvYn(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.creditOverDAO.selectCreditOverApprvYn", parameter);
	}
	
	/**
	 * 임시여신 승인 1 (fms_upjang 업데이트)
	 *
	 * @param parameter
	 * @return
	 */
	public int saveCreditOverApprv1(Map<String, Object> parameter) throws Exception {
		return super.update("sc.app.creditOverDAO.saveCreditOverApprv1", parameter);
	}
	
	/**
	 * 임시여신 승인 2 (FMS_CREDIT_MOBILE 업데이트)
	 *
	 * @param parameter
	 * @return
	 */
	public int saveCreditOverApprv2(Map<String, Object> parameter) throws Exception {
		return super.update("sc.app.creditOverDAO.saveCreditOverApprv2", parameter);
	}
	
	/**
	 * 임시여신 반려 (FMS_CREDIT_MOBILE 업데이트)
	 *
	 * @param parameter
	 * @return
	 */
	public int saveCreditOverReject(Map<String, Object> parameter) throws Exception {
		return super.update("sc.app.creditOverDAO.saveCreditOverReject", parameter);
	}
	
	/**
	 * 로그정보를 입력한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int logInsert(Map<String, Object> parameter) throws Exception {
		return super.update("sc.app.creditOverDAO.logInsert", parameter);
	}
	
}
