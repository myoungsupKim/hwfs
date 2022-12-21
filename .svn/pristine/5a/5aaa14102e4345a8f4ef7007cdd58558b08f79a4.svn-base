package com.hwfs.rc.rrm.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 레시피를 관리하는 RecipeList DAO
 * 
 * @ClassName RecipeListDAO.java
 * @Description RecipeListDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2016.07.11    백승현        최초생성
 * </pre>
 * @author FC종합전산구축 :  통합영업 백승현
 * @since 2016.07.11
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */

@Repository("/rc/rrm/recipeListDAO")
public class RecipeListDAO extends DefaultDAO
{
	/**
	 * 표준레시피 조회
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public RecordSet selectStdRecipeList(Map<String, Object> mapParam) throws Exception
	{
		return super.queryForRecordSet("rc.rrm.recipeListDAO.selectStdRecipeList", mapParam);
	}

	/**
	 * 표준레시피 상세 조회
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public RecordSet selectStdRecipeDetail(Map<String, Object> mapParam) throws Exception
	{
		return super.queryForRecordSet("rc.rrm.recipeListDAO.selectStdRecipeDetail", mapParam);
	}

	/**
	 * 업장레시피 조회
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public RecordSet selectUpjangRecipeList(Map<String, Object> mapParam) throws Exception
	{
		return super.queryForRecordSet("rc.rrm.recipeListDAO.selectUpjangRecipeList", mapParam);
	}

	/**
	 * 업장레시피 상세 조회
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public RecordSet selectUpjangRecipeDetail(Map<String, Object> mapParam) throws Exception
	{
		return super.queryForRecordSet("rc.rrm.recipeListDAO.selectUpjangRecipeDetail", mapParam);
	}

	/**
	 * 가상레시피 조회
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public RecordSet selectSmlRecipeList(Map<String, Object> mapParam) throws Exception
	{
		return super.queryForRecordSet("rc.rrm.recipeListDAO.selectSmlRecipeList", mapParam);
	}

	/**
	 * 가상레시피 상세 조회
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public RecordSet selectSmlRecipeDetail(Map<String, Object> mapParam) throws Exception
	{
		return super.queryForRecordSet("rc.rrm.recipeListDAO.selectSmlRecipeDetail", mapParam);
	}

	/**
	 * 표준 레시피 조리법을 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public int deleteList(Map<String, Object> mapParam) throws Exception
	{
		return super.update("rc.rrm.recipeListDAO.deleteList", mapParam);
	}
	/**
	 * 표준 레시피 조리법을 저장한다.
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public int saveList(Map<String, Object> mapParam) throws Exception
	{
		return super.update("rc.rrm.recipeListDAO.saveList", mapParam);
	}
}