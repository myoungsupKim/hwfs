package com.hwfs.fs.fsa.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 현장인력 채용지원 실적을 조회하는 AdoptionResultList DAO
 * 
 * @ClassName AdoptionResultListDAO.java
 * @Description AdoptionResultListDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.16   	김예진        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 김예진
 * @since 2015.04.16
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fs/fsa/adoptionResultListDAO")
public class AdoptionResultListDAO extends DefaultDAO {
	
	/**
	 * 현장인력 채용지원 실적 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectResultList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsa.adoptionResultListDAO.selectResultList", mapParam);
	}
	public RecordSet selectResult(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsa.adoptionResultListDAO.selectResult", mapParam);
	}
	public RecordSet selectUpjangResult(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsa.adoptionResultListDAO.selectUpjangResult", mapParam);
	}

	/**
	 * 현장인력 채용지원 실적(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsa.adoptionResultListDAO.insert", mapParam);
	}
	
	/**
	 * 현장인력 채용지원 실적(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsa.adoptionResultListDAO.update", mapParam);
	}
	
	/**
	 * 현장인력 채용지원 실적(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsa.adoptionResultListDAO.delete", mapParam);
	}
	
}
