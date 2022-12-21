package com.hwfs.sc.app.dao;

import java.util.Map;

import hone.core.util.record.RecordSet;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 식재앱 소모품발주 인터페이스용  DAO 개체
 * @ClassName ConsumableDAO.java
 * @Description  ConsumableDAO Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2022.07.29.   김명섭        최초생성
 * </pre>
 * @author 푸디스트
 * @since 2022.07.29.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by 한화시스템ICT CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sc/app/consumableDAO")
public class ConsumableDAO extends DefaultDAO {
	
	/**
	 * 테스트 조회
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectTest(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.consumableDAO.selectTest", parameter);
	}

	/**
	 * 업장창고 조회
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectSubinv(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.consumableDAO.selectSubinv", parameter);
	}

	/**
	 * 계정과목 조회
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectAccinfo(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.consumableDAO.selectAccinfo", parameter);
	}

	/**
	 * 소모품검색
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectItem(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.consumableDAO.selectItem", parameter);
	}

	/**
	 * 신청내역 헤더 조회
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectInfo(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.consumableDAO.selectInfo", parameter);
	}

	/**
	 * 신청내역 상세 조회
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectDetail(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.consumableDAO.selectDetail", parameter);
	}
	
	/**
	 * 로그정보를 입력한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int logInsert(Map<String, Object> parameter) throws Exception {
		return super.update("sc.app.consumableDAO.logInsert", parameter);
	}
	
}
