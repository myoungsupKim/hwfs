package com.hwfs.rc.rrm.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 표준 레시피 조리법을 관리하는 StandardRecipeMasterMgntPop DAO
 * 
 * @ClassName StandardRecipeMasterMgntPopDAO.java
 * @Description StandardRecipeMasterMgntPopDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.01   	유인찬        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 유인찬
 * @since 2015.04.01
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/rc/rrm/standardRecipeMasterMgntPopDAO")
public class StandardRecipeMasterMgntPopDAO extends DefaultDAO {
	
	/**
	 * 표준 레시피 조리법 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("rc.rrm.standardRecipeMasterMgntPopDAO.selectList", mapParam);
	}

	/**
	 * 표준 레시피 조리법(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rrm.standardRecipeMasterMgntPopDAO.insert", mapParam);
	}
	
	/**
	 * 표준 레시피 조리법(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rrm.standardRecipeMasterMgntPopDAO.update", mapParam);
	}
	
	/**
	 * 표준 레시피 조리법(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rrm.standardRecipeMasterMgntPopDAO.delete", mapParam);
	}
	

	/**
	 * 업장 레시피 조리법(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete2(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rrm.standardRecipeMasterMgntPopDAO.delete2", mapParam);
	}
	
	/**
	 * 표준레시피 조리법 등록시 업장 레시피 조리법에 일괄 등록한다.
	 * - 업장수정허용여부가 'N'인것만 등록
	 * @param mapParam
	 * @return
	 */
	public int insertUpjangRecipeCuisine(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rrm.standardRecipeMasterMgntPopDAO.insertUpjangRecipeCuisine", mapParam);
	}
	
	/**
	 * 표준레시피 조리법 수정시 업장 레시피 조리법을 일괄 수정한다.
	 * - 업장수정허용여부가 'N'인것만 수정
	 * @param mapParam
	 * @return
	 */
	public int updateUpjangRecipeCuisine(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rrm.standardRecipeMasterMgntPopDAO.updateUpjangRecipeCuisine", mapParam);
	}
	
	/**
	 * 복사되어 있는 레시피 조리법의 업장코드 목록 검색한다.
	 * 
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectListUpjangCd(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("rc.rrm.standardRecipeMasterMgntPopDAO.selectListUpjangCd", mapParam);
	}
	
}
