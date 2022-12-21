package com.hwfs.sc.app.dao;

import java.util.Map;

import hone.core.util.record.RecordSet;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 식재앱 관리용  DAO 개체
 * @ClassName MaintenanceDAO.java
 * @Description  MaintenanceDAO Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2022.12.14.   김명섭        최초생성
 * </pre>
 * @author 푸디스트
 * @since 2022.12.14.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by 한화시스템ICT CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sc/app/maintenanceDAO")
public class MaintenanceDAO extends DefaultDAO {
	
	/**
	 * 테스트 조회
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectTest(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.maintenanceDAO.selectTest", parameter);
	}

	/**
	 * 센터 조회
	 *
	 * @param parameter
	 * @return
	 */
	public String selectCenter(Map<String, Object> parameter) throws Exception {
        return (String) super.queryForObject("sc.app.maintenanceDAO.selectCenter", parameter, null);
	}
	
	/**
	 * 단가 조회
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectFsale(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.maintenanceDAO.selectFsale", parameter);
	}

	public RecordSet sendFsale(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.maintenanceDAO.sendFsale", parameter);
	}
	
}
