package com.hwfs.rc.rrm.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 업장 레시피를 조회(by Recipe)하는 RecipeInquirybyRecipe DAO
 * 
 * @ClassName RecipeInquirybyRecipeDAO.java
 * @Description RecipeInquirybyRecipeDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.17   	Y        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 Y
 * @since 2015.04.17
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/rc/rrm/recipeInquirybyRecipeDAO")
public class RecipeInquirybyRecipeDAO extends DefaultDAO {
	
	/**
	 * 업장 레시피 조회(by Recipe) 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("rc.rrm.recipeInquirybyRecipeDAO.selectList", mapParam);
	}
	
	/**
	 * 업장 레시피 검색(레시피 내역 가장 상단에 표시될 레시피)
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectRecipe(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("rc.rrm.recipeInquirybyRecipeDAO.selectRecipe", mapParam);
	}

}
