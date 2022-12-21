package com.hwfs.rc.roa.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 특근 발생 현황하는 OverTimeUpjang DAO
 * 
 * @ClassName OverTimeUpjangDAO.java
 * @Description OverTimeUpjangDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.11.26   	손형민        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 손형민
 * @since 2015.11.26
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/rc/roa/overTimeUpjangDAO")
public class OverTimeUpjangDAO extends DefaultDAO {
	
	/**
	 * 특근 발생 현황 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("rc.roa.overTimeUpjangDAO.selectList", mapParam);
	}

	/**
	 * 특근 발생 현황(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.roa.overTimeUpjangDAO.insert", mapParam);
	}
	
	/**
	 * 특근 발생 현황(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.roa.overTimeUpjangDAO.update", mapParam);
	}
	
	/**
	 * 특근 발생 현황(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.roa.overTimeUpjangDAO.delete", mapParam);
	}
	
}
