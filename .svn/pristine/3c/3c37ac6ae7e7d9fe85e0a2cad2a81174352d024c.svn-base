package com.hwfs.rc.rrm.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 표준 레시피를 조회하는 StandardRecipeInquirybyRecipe DAO
 * 
 * @ClassName StandardRecipeInquirybyRecipeDAO.java
 * @Description StandardRecipeInquirybyRecipeDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.15   	Yu        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 Yu
 * @since 2015.04.15
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/rc/rrm/standardRecipeInquirybyRecipeDAO")
public class StandardRecipeInquirybyRecipeDAO extends DefaultDAO {
	
	/**
	 * 표준 레시피 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("rc.rrm.standardRecipeInquirybyRecipeDAO.selectList", mapParam);
	}

	/**
	 * 표준 레시피 검색(레시피 내역 가장 상단에 표시될 레시피)
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectRecipe(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("rc.rrm.standardRecipeInquirybyRecipeDAO.selectRecipe", mapParam);
	}
}
