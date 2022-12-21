package com.hwfs.rc.roa.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 특근 캘린더 관리하는 OverTimeCalendar DAO
 * 
 * @ClassName OverTimeCalendarDAO.java
 * @Description OverTimeCalendarDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.06.29   	손형민        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 홍길동
 * @since 2015.06.29
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/rc/roa/overTimeCalendarDAO")
public class OverTimeCalendarDAO extends DefaultDAO {
	
	/**
	 * 특근 캘린더 관리 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("rc.roa.overTimeCalendarDAO.selectList", mapParam);
	}

	/**
	 * 특근 캘린더 관리(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.roa.overTimeCalendarDAO.insert", mapParam);
	}
	
	/**
	 * 특근 캘린더 관리(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.roa.overTimeCalendarDAO.update", mapParam);
	}
	
	/**
	 * 특근 캘린더 관리(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.roa.overTimeCalendarDAO.delete", mapParam);
	}
	
}
