package com.hwfs.sc.app.dao;

import java.util.Map;

import hone.core.util.record.RecordSet;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 식재앱 거래처관리 인터페이스용  DAO 개체
 * @ClassName CustomerDAO.java
 * @Description  CustomerDAO Class 
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
@Repository("/sc/app/customerDAO")
public class CustomerDAO extends DefaultDAO {
	
	/**
	 * 거래처 조회
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectCustInfo(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.customerDAO.selectCustInfo", parameter);
	}
	
	/**
	 * 거래처상세 조회
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectCustDetailInfo(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.customerDAO.selectCustDetailInfo", parameter);
	}

	/**
	 * 검수서 조회
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectInspectionInfo(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.customerDAO.selectInspectionInfo", parameter);
	}
	
	/**
	 * 로그정보를 입력한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int logInsert(Map<String, Object> parameter) throws Exception {
		return super.update("sc.app.customerDAO.logInsert", parameter);
	}
	
}
