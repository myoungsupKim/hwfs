package com.hwfs.sc.app.dao;

import java.util.Map;

import hone.core.util.record.RecordSet;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 식재앱 관리자 인터페이스용  DAO 개체
 * @ClassName AdminDAO.java
 * @Description  AdminDAO Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2022.06.20.   김명섭        최초생성
 * </pre>
 * @author 푸디스트
 * @since 2022.06.20.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by 한화시스템ICT CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sc/app/adminDAO")
public class AdminDAO extends DefaultDAO {
	
	/**
	 * 테스트 조회
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectTest(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.adminDAO.selectTest", parameter);
	}

	/**
	 * 업장 조회
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectUpjang(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.adminDAO.selectUpjang", parameter);
	}

	/**
	 * 품목분류 조회
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectItemClass(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.adminDAO.selectItemClass", parameter);
	}
	
	/**
	 * 센터정보 조회
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectCenterInfo(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.adminDAO.selectCenterInfo", parameter);
	}
	
	/**
	 * 로그정보를 입력한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int logInsert(Map<String, Object> parameter) throws Exception {
		return super.update("sc.app.adminDAO.logInsert", parameter);
	}
	
}
