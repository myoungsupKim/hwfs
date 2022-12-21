package com.hwfs.rc.rrm.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 표준 레시피 자재를 일괄 변경하는 StandardRecipeBatchChange DAO
 * 
 * @ClassName StandardRecipeBatchChangeDAO.java
 * @Description StandardRecipeBatchChangeDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.20   	Yu        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 Yu
 * @since 2015.04.20
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/rc/rrm/standardRecipeBatchChangeDAO")
public class StandardRecipeBatchChangeDAO extends DefaultDAO {
	
	/**
	 * 표준 레시피 자재 일괄 변경 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("rc.rrm.standardRecipeBatchChangeDAO.selectList", mapParam);
	}
	
	/**
	 * 표준 레시피 자재 일괄 변경 시 변경 후자재가 있는지 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int selectOldList(Map<String, Object> mapParam) throws Exception {
		return super.queryForInt("rc.rrm.standardRecipeBatchChangeDAO.selectOldList", mapParam);
	}

	/**
	 * 표준 레시피 자재 일괄 변경(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rrm.standardRecipeBatchChangeDAO.insert", mapParam);
	}
	
	/**
	 * 표준 레시피 내 변경 후 자재 삭제
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteStd(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rrm.standardRecipeBatchChangeDAO.deleteStd", mapParam);
	}
	
	/**
	 * (표준)변경된 기투입자재를 수정한다.(종료일자를 변경후자재의 시작일자 -1 일자로 변경)
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateEdate(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rrm.standardRecipeBatchChangeDAO.updateEdate", mapParam);
	}
	
	/**
	 * 업장 레시피 내 변경 후 자재 삭제
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteUpjang(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rrm.standardRecipeBatchChangeDAO.deleteUpjang", mapParam);
	}
	
	/**
	 * 업장 레시피 자재 일괄 변경(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertUpjang(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rrm.standardRecipeBatchChangeDAO.insertUpjang", mapParam);
	}
	
	/**
	 * (업장)변경된 기투입자재를 수정한다.(종료일자를 변경후자재의 시작일자 -1 일자로 변경)
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateEdateUpjang(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rrm.standardRecipeBatchChangeDAO.updateEdateUpjang", mapParam);
	}

	/**
	 * 표준 레시피 자재 일괄 변경 후 이력을 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertStdLog(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rrm.standardRecipeBatchChangeDAO.insertStdLog", mapParam);
	}
}
