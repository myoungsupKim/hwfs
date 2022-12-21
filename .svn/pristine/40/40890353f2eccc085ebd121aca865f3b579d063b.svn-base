package com.hwfs.rc.rrm.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 레시피 분류 코드를 관리하는 RecipeClassCodeMgnt DAO
 * 
 * @ClassName RecipeClassCodeMgntDAO.java
 * @Description RecipeClassCodeMgntDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.24   	유인찬        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 유인찬
 * @since 2015.03.24
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/rc/rrm/recipeClassCodeMgntDAO")
public class RecipeClassCodeMgntDAO extends DefaultDAO {
	
	/**
	 * 레시피 대분류 코드 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectListMgrp(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("rc.rrm.recipeClassCodeMgntDAO.selectListMgrp", mapParam);
	}
	
	/**
	 * 레시피 중분류 코드 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectListMcalss(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("rc.rrm.recipeClassCodeMgntDAO.selectListMcalss", mapParam);
	}
	
	/**
	 * 레시피 소분류 코드 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectListSclass(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("rc.rrm.recipeClassCodeMgntDAO.selectListSclass", mapParam);
	}
	
	/**
	 * 레시피 대분류 코드 중복체크 
	 * @param parameter
	 * @return
	 */
	public int selectMgrpExists(Map<String, Object> parameter) throws Exception {
		return super.queryForInt("rc.rrm.recipeClassCodeMgntDAO.selectMgrpExists", parameter);
	}
	
	/**
	 * 레시피 중분류 코드 중복체크 
	 * @param parameter
	 * @return
	 */
	public int selectMcalssExists(Map<String, Object> parameter) throws Exception {
		return super.queryForInt("rc.rrm.recipeClassCodeMgntDAO.selectMcalssExists", parameter);
	}
	
	/**
	 * 레시피 소분류 코드 중복체크 
	 * @param parameter
	 * @return
	 */
	public int selectSclassExists(Map<String, Object> parameter) throws Exception {
		return super.queryForInt("rc.rrm.recipeClassCodeMgntDAO.selectSclassExists", parameter);
	}

	/**
	 * 레시피 대분류 코드(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertMgrp(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rrm.recipeClassCodeMgntDAO.insertMgrp", mapParam);
	}
	
	/**
	 * 레시피 중분류 코드(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertMcalss(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rrm.recipeClassCodeMgntDAO.insertMcalss", mapParam);
	}
	
	/**
	 * 레시피 소분류 코드(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertSclass(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rrm.recipeClassCodeMgntDAO.insertSclass", mapParam);
	}
	
	/**
	 * 레시피 대분류 코드(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateMgrp(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rrm.recipeClassCodeMgntDAO.updateMgrp", mapParam);
	}
	
	/**
	 * 레시피 중분류 코드(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateMcalss(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rrm.recipeClassCodeMgntDAO.updateMcalss", mapParam);
	}
	
	/**
	 * 레시피 소분류 코드(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateSclass(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rrm.recipeClassCodeMgntDAO.updateSclass", mapParam);
	}
	
	/**
	 * 레시피 대분류 코드(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteMgrp(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rrm.recipeClassCodeMgntDAO.deleteMgrp", mapParam);
	}
	
	/**
	 * 레시피 중분류 코드(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteMcalss(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rrm.recipeClassCodeMgntDAO.deleteMcalss", mapParam);
	}
	
	/**
	 * 레시피 소분류 코드(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteSclass(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rrm.recipeClassCodeMgntDAO.deleteSclass", mapParam);
	}

	/**
	 * 레시피 중분류 코드 모든 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public RecordSet selectListMcalssAll(Map<String, Object> mapParam) throws Exception{
		return super.queryForRecordSet("rc.rrm.recipeClassCodeMgntDAO.selectListMcalssAll", mapParam);
	}
	
	/**
	 * 레시피 소분류 코드 모든 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public RecordSet selectListSclassAll(Map<String, Object> mapParam) throws Exception{
		return super.queryForRecordSet("rc.rrm.recipeClassCodeMgntDAO.selectListSclassAll", mapParam);
	}
}
