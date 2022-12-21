package com.hwfs.rc.roa.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 특근 마감 작업하는 OverTimeClosing DAO
 * 
 * @ClassName OverTimeClosingDAO.java
 * @Description OverTimeClosingDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.07.01   	손형민        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 손형민
 * @since 2015.07.01
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/rc/roa/overTimeClosingDAO")
public class OverTimeClosingDAO extends DefaultDAO {
	
	/**
	 * 특근 마감 작업 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("rc.roa.overTimeClosingDAO.selectList", mapParam);
	}

	/**
	 * 특근 마감 작업(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.roa.overTimeClosingDAO.insert", mapParam);
	}
	
	/**
	 * 특근 마감 작업(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.roa.overTimeClosingDAO.update", mapParam);
	}
	
	/**
	 * 특근 마감 작업(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.roa.overTimeClosingDAO.delete", mapParam);
	}
	
	/**
	 * 마감처리
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertOverTimeInfoSum(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.roa.overTimeClosingDAO.insertOverTimeInfoSum", mapParam);
	}
	
	/**
	 * 마감처리LOG
	 *
	 * @param mapParam
	 * @return
	 */
	public int logInfo(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.roa.overTimeClosingDAO.logInfo", mapParam);
	}
	
	/**
	 * 마감취소
	 *
	 * @param mapParam
	 * @return
	 */
	public int cancelOverTimeInfoSum(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.roa.overTimeClosingDAO.cancelOverTimeInfoSum", mapParam);
	}
	
	/**
	 * 마감취소LOG
	 *
	 * @param mapParam
	 * @return
	 */
	public int cancelLogInfo(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.roa.overTimeClosingDAO.cancelLogInfo", mapParam);
	}
}
