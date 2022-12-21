package com.hwfs.rc.roa.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 용역 공제 시간을 관리하는 PartTimeDeductionTime DAO
 * 
 * @ClassName PartTimeDeductionTimeDAO.java
 * @Description PartTimeDeductionTimeDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.20   	JUN        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 JUN
 * @since 2015.03.20
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/rc/roa/partTimeDeductionTimeDAO")
public class PartTimeDeductionTimeDAO extends DefaultDAO {
	
	/**
	 * 용역 공제 시간 관리 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("rc.roa.partTimeDeductionTimeDAO.selectList", mapParam);
	}

	/**
	 * 용역 공제 시간 중복체크
	 */
	public int selectExists(Map<String, Object> parameter) {
		return super.queryForInt("rc.roa.partTimeDeductionTimeDAO.selectExists", parameter);
	}
	
	/**
	 * 용역 공제 시간 관리(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.roa.partTimeDeductionTimeDAO.insert", mapParam);
	}
	
	/**
	 * 용역 공제 시간 관리(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.roa.partTimeDeductionTimeDAO.update", mapParam);
	}
	
	/**
	 * 용역 공제 시간 관리(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.roa.partTimeDeductionTimeDAO.delete", mapParam);
	}
	
}
