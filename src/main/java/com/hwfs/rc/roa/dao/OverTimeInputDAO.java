package com.hwfs.rc.roa.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 특근 근태 발생 등록하는 OverTimeInput DAO
 * 
 * @ClassName OverTimeInputDAO.java
 * @Description OverTimeInputDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.06.30   	손형민        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 손형민
 * @since 2015.06.30
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/rc/roa/overTimeInputDAO")
public class OverTimeInputDAO extends DefaultDAO {
	
	/**
	 * 특근 근태 발생 등록 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectWeekly(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("rc.roa.overTimeInputDAO.selectWeekly", mapParam);
	}

	/**
	 * 특근 근태 발생 등록 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("rc.roa.overTimeInputDAO.selectList", mapParam);
	}
	
	/**
	 * 특근 근태 발생이 존재 한지 체크 한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public String listCnt(Map<String, Object> mapParam) throws Exception {
		return (String)super.queryForObject("rc.roa.overTimeInputDAO.listCnt", mapParam , null);
	}
	
	/**
	 * 특근 근태 발생 등록 이력이 존재 한지 체크 한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public String logCnt(Map<String, Object> mapParam) throws Exception {
		return (String)super.queryForObject("rc.roa.overTimeInputDAO.logCnt", mapParam , null);
	}
	
	
	
	/**
	 * 특근 근태 발생 등록(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.roa.overTimeInputDAO.insert", mapParam);
	}
	
	/**
	 * 특근 근태 발생 등록(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int infoInser(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.roa.overTimeInputDAO.infoInser", mapParam);
	}
	
	/**
	 * 특근 사용 등록(을)를 LOG를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int logInser(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.roa.overTimeInputDAO.logInser", mapParam);
	}
	
	public int logInfo(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.roa.overTimeInputDAO.logInfo", mapParam);
	}
	
	/**
	 * 특근 근태 발생 등록(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.roa.overTimeInputDAO.update", mapParam);
	}
	
	/**
	 * 특근 근태 발생 등록(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.roa.overTimeInputDAO.delete", mapParam);
	}
	
	
	
	
}
