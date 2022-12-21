package com.hwfs.rc.roa.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 용역 시급을 관리하는 PartTimeSalary DAO
 * 
 * @ClassName PartTimeSalaryDAO.java
 * @Description PartTimeSalaryDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.19   	JUN        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 JUN
 * @since 2015.03.19
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/rc/roa/partTimeSalaryDAO")
public class PartTimeSalaryDAO extends DefaultDAO {
	
	/**
	 * 용역 시급 관리 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("rc.roa.partTimeSalaryDAO.selectList", mapParam);
	}

	/**
	 * 용역 시급 관리 중복체크
	 */
	public int selectExists(Map<String, Object> parameter) {
		return super.queryForInt("rc.roa.partTimeSalaryDAO.selectExists", parameter);
	}
	
	/**
	 * 용역 시급 관리(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.roa.partTimeSalaryDAO.insert", mapParam);
	}
	
	/**
	 * 용역 시급 관리(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.roa.partTimeSalaryDAO.update", mapParam);
	}
	
	/**
	 * 용역 시급 관리(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.roa.partTimeSalaryDAO.delete", mapParam);
	}
	
}
