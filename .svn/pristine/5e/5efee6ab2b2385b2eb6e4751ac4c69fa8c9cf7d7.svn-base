package com.hwfs.fs.fse.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 이벤트 스케줄관리하는 EventMealSchlMgnt DAO
 * 
 * @ClassName EventMealSchlMgntDAO.java
 * @Description EventMealSchlMgntDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.16   	남기빈        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 남기빈
 * @since 2015.04.16
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fs/fse/eventMealSchlMgntDAO")
public class EventMealSchlMgntDAO extends DefaultDAO {
	
	/**
	 * 이벤트 스케줄관리 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fse.eventMealSchlMgntDAO.selectList", mapParam);
	}
	
	/**
	 * 이벤트 스케줄관리 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectSchl(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fse.eventMealSchlMgntDAO.selectSchl", mapParam);
	}
	
		
	/**
	 * 이벤트 등록(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fse.eventMealSchlMgntDAO.insert", mapParam);
	}
	
	/**
	 * 이벤트 등록(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fse.eventMealSchlMgntDAO.update", mapParam);
	}
	
	/**
	 * 이벤트 등록(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fse.eventMealSchlMgntDAO.delete", mapParam);
	}
}
