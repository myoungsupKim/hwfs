package com.hwfs.rc.roa.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 특근 사용 등록하는 OverTimeMgnt DAO
 * 
 * @ClassName OverTimeMgntDAO.java
 * @Description OverTimeMgntDAO Class
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
@Repository("/rc/roa/overTimeMgntDAO")
public class OverTimeMgntDAO extends DefaultDAO {
	
	/**
	 * 특근 사용 등록 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("rc.roa.overTimeMgntDAO.selectList", mapParam);
	}

	/**
	 * 특근 사용 등록(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.roa.overTimeMgntDAO.insert", mapParam);
	}
	
	/**
	 * 특근 사용 등록(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.roa.overTimeMgntDAO.update", mapParam);
	}
	
	/**
	 * 특근 사용 등록(을)를 LOG를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int logInser(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.roa.overTimeMgntDAO.logInser", mapParam);
	}
	
	/**
	 * 특근 사용 등록(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.roa.overTimeMgntDAO.delete", mapParam);
	}

	/**
	 * 특근 사용 등록(을)를 이월등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int lastUpdate(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.roa.overTimeMgntDAO.lastUpdate", mapParam);
	}
	
}
