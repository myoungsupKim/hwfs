package com.hwfs.rc.roa.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 용역 발생을 등록하는 PartTime DAO
 * 
 * @ClassName PartTimeDAO.java
 * @Description PartTimeDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.23   	JUN        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 JUN
 * @since 2015.03.23
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/rc/roa/partTimeDAO")
public class PartTimeDAO extends DefaultDAO {
	
	/**
	 * 용역 발생 등록 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("rc.roa.partTimeDAO.selectList", mapParam);
	}

	/**
	 * 용역 발생 차수를 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet getOccurNumOfTimes(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("rc.roa.partTimeDAO.getOccurNumOfTimes", mapParam);
	}

	/**
	 * 공제시간을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet getDeducTime(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("rc.roa.partTimeDAO.getDeducTime", mapParam);
	}

	/**
	 * 용역 대상자 사번을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectPartTimeEmpSabun(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("rc.roa.partTimeDAO.selectPartTimeEmpSabun", mapParam);
	}
	
	/**
	 * 용역 발생 등록(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.roa.partTimeDAO.insert", mapParam);
	}
	
	/**
	 * 용역 발생 등록(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.roa.partTimeDAO.update", mapParam);
	}
	
	/**
	 * 용역 발생 등록(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.roa.partTimeDAO.delete", mapParam);
	}

	/**
	 * 용역 대상자(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert1(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.roa.partTimeDAO.insert1", mapParam);
	}
}
