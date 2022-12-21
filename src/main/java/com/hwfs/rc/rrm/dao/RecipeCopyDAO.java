package com.hwfs.rc.rrm.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 표준 레시피를 복사하는 RecipeCopy DAO
 * 
 * @ClassName RecipeCopyDAO.java
 * @Description RecipeCopyDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.08   	유인찬        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 유인찬
 * @since 2015.04.08
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/rc/rrm/recipeCopyDAO")
public class RecipeCopyDAO extends DefaultDAO {
	
	/**
	 * 표준 레시피 복사 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("rc.rrm.recipeCopyDAO.selectList", mapParam);
	}

	/**
	 * 표준 레시피 업장 레시피로 복사한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertRecipe(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rrm.recipeCopyDAO.insertRecipe", mapParam);
	}
	
	/**
	 * 표준 레시피 상세 업장 레시피 상세로 복사한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertRecipeDetail(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rrm.recipeCopyDAO.insertRecipeDetail", mapParam);
	}
	
	/**
	 * 표준 레시피 조리법 업장 레시피 조리법으로 복사한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertRecipeCuisine(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rrm.recipeCopyDAO.insertRecipeCuisine", mapParam);
	}
	
	/**
	 * 표준 레시피 업장 레시피로 복사(수정)한다.(MERGE INTO)
	 *
	 * @param mapParam
	 * @return
	 */
	public int mergeRecipe(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rrm.recipeCopyDAO.mergeRecipe", mapParam);
	}
	
	/**
	 * 표준 레시피 상세 업장 레시피 상세로 복사(수정)한다.(MERGE INTO)
	 *
	 * @param mapParam
	 * @return
	 */
	public int mergeRecipeDetail(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rrm.recipeCopyDAO.mergeRecipeDetail", mapParam);
	}
	
	/**
	 * 표준 레시피 조리법 업장 레시피 조리법으로 복사(수정)한다.(MERGE INTO)
	 *
	 * @param mapParam
	 * @return
	 */
	public int mergeRecipeCuisine(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rrm.recipeCopyDAO.mergeRecipeCuisine", mapParam);
	}

	/**
	 * 레시피 복사전 업장레시피 등록여부를 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectUpjangRecipe(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("rc.rrm.recipeCopyDAO.selectUpjangRecipe", mapParam);
	}

	/**
	 * 표준레시피 복사전 업장레시피를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteUpjangRecipeMst(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rrm.recipeCopyDAO.deleteUpjangRecipeMst", mapParam);
	}

	/**
	 * 표준레시피 복사전 업장레시피상세를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteUpjangRecipeDtl(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rrm.recipeCopyDAO.deleteUpjangRecipeDtl", mapParam);
	}

	/**
	 * 표준레시피 복사전 업장레시피조리법을 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteUpjangRecipeCuisine(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rrm.recipeCopyDAO.deleteUpjangRecipeCuisine", mapParam);
	}

	/**
	 * 표준 레시피를 업장 레시피로 복사한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int saveUpjangRecipeMst(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rrm.recipeCopyDAO.saveUpjangRecipeMst", mapParam);
	}

	/**
	 * 표준 레시피 상세를 업장 레시피 상세로 복사한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int saveUpjangRecipeDtl(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rrm.recipeCopyDAO.saveUpjangRecipeDtl", mapParam);
	}

	/**
	 * 표준 레시피 조리법을 업장 레시피 조리법으로 복사한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int saveUpjangRecipeCuisine(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rrm.recipeCopyDAO.saveUpjangRecipeCuisine", mapParam);
	}
}
