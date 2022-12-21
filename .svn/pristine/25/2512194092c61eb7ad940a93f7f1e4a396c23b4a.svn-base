package com.hwfs.sc.scb.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * Batch Job Repository에 등록된 Batch Job Scheduler 정보를 관리하는 BatchSchdMngt DAO
 * -CronTrigger 정보만 관리한다.
 * 
 * @ClassName BatchSchdMngtDAO.java
 * @Description BatchSchdMngtDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.09   	kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015.04.09
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sc/scb/batchSchdMngtDAO")
public class BatchSchdMngtDAO extends DefaultDAO {
	
	/**
	 * Batch Job Scheduler 정보 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.scb.batchSchdMngtDAO.selectList", mapParam);
	}

//	/**
//	 * Batch Job Scheduler 정보(을)를 등록한다.
//	 *
//	 * @param mapParam
//	 * @return
//	 */
//	public int insert(Map<String, Object> mapParam) throws Exception {
//		return super.update("sc.scb.batchSchdMngtDAO.insert", mapParam);
//	}
//	
//	/**
//	 * Batch Job Scheduler 정보(을)를 수정한다.
//	 *
//	 * @param mapParam
//	 * @return
//	 */
//	public int update(Map<String, Object> mapParam) throws Exception {
//		return super.update("sc.scb.batchSchdMngtDAO.update", mapParam);
//	}
//	
//	/**
//	 * Batch Job Scheduler 정보(을)를 삭제한다.
//	 *
//	 * @param mapParam
//	 * @return
//	 */
//	public int delete(Map<String, Object> mapParam) throws Exception {
//		return super.update("sc.scb.batchSchdMngtDAO.delete", mapParam);
//	}
	
}
