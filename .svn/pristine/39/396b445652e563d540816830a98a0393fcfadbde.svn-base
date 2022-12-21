package com.hwfs.rc.rcm.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 업장 마감을하는 CloseMgnt01 DAO
 * 
 * @ClassName CloseMgnt01DAO.java
 * @Description CloseMgnt01DAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.26   	JUN        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 JUN
 * @since 2015.05.26
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/rc/rcm/closeMgnt01DAO")
public class CloseMgnt01DAO extends DefaultDAO {
	
	/**
	 * 업장 마감 (매출목록)을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet salsList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("rc.rcm.closeMgnt01DAO.salsList", mapParam);
	}

	/**
	 * 업장 마감 (지불목록)을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet paymentList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("rc.rcm.closeMgnt01DAO.paymentList", mapParam);
	}
	
	/**
	 * 업장 마감(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rcm.closeMgnt01DAO.insert", mapParam);
	}
	
	/**
	 * 업장 마감(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rcm.closeMgnt01DAO.update", mapParam);
	}
	
	/**
	 * 업장 마감(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rcm.closeMgnt01DAO.delete", mapParam);
	}
	
	/**
	 * 업장 마감 (선수금발생 목록)을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectAdvanceOccurList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("rc.rcm.closeMgnt01DAO.selectAdvanceOccurList", mapParam);
	}
}
