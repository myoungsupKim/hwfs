package com.hwfs.rc.roa.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 용역 근무 내용 관리하는 PartTimeDutyDetail DAO
 * 
 * @ClassName PartTimeDutyDetailDAO.java
 * @Description PartTimeDutyDetailDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2018.11.22   	김지영        최초생성
 * </pre>
 * @author 서비스ITO2 : 김지영
 * @since 2018.11.22
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/rc/roa/partTimeDutyDetailDAO")
public class PartTimeDutyDetailDAO extends DefaultDAO {
	
	/**
	 * 용역 근무 내용 관리 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("rc.roa.partTimeDutyDetailDAO.selectList", mapParam);
	}

	/**
	 * 용역 근무 내용 관리 중복체크
	 */
	public int selectExists(Map<String, Object> parameter) {
		return super.queryForInt("rc.roa.partTimeDutyDetailDAO.selectExists", parameter);
	}
	
	/**
	 * 용역 근무 내용 관리(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.roa.partTimeDutyDetailDAO.insert", mapParam);
	}
	
	/**
	 * 용역 근무 내용 관리(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.roa.partTimeDutyDetailDAO.update", mapParam);
	}
	
	/**
	 * 용역 근무 내용 관리(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.roa.partTimeDutyDetailDAO.delete", mapParam);
	}
	
	/**
	 * 용역 근무내용정보(Combo)를 조회한다.
	 * @return RecordSet
	 */
	public RecordSet selectDutyDetail(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("rc.roa.partTimeDutyDetailDAO.selectDutyDetail",mapParam);
	}
	
}
