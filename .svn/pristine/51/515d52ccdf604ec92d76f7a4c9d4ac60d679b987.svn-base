package com.hwfs.fs.fsa.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 채용인력배정하는 AdoptionAssign DAO
 * 
 * @ClassName AdoptionAssignDAO.java
 * @Description AdoptionAssignDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.09   	김예진        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 김예진
 * @since 2015.04.09
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fs/fsa/adoptionAssignDAO")
public class AdoptionAssignDAO extends DefaultDAO {
	
	/**
	 * 채용인력 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectChasu(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsa.adoptionAssignDAO.selectChasu", mapParam);
	}
	public RecordSet selectVstList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsa.adoptionAssignDAO.selectVstList", mapParam);
	}

	
	/**
	 * 채용지원정보 상태(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateReq(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsa.adoptionAssignDAO.updateReq", mapParam);
	}
	
	/**
	 * 방문일지(을)를 등록,수정 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertVisit(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsa.adoptionAssignDAO.insertVisit", mapParam);
	}
	public int updateVisit(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsa.adoptionAssignDAO.updateVisit", mapParam);
	}
	public int deleteVisit(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsa.adoptionAssignDAO.deleteVisit", mapParam);
	}
	
	/**
	 * 채용인력(을)를 등록,삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertAssign(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsa.adoptionAssignDAO.insertAssign", mapParam);
	}
	public int updatePoolMst(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsa.adoptionAssignDAO.updatePoolMst", mapParam);
	}
	public int deleteAssign(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsa.adoptionAssignDAO.deleteAssign", mapParam);
	}
	

	
}
