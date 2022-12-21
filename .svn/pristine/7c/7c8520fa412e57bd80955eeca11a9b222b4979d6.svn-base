package com.hwfs.rc.rrm.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 식자재를 조회하는 StandardRecipeDetailedItemPop DAO
 * 
 * @ClassName StandardRecipeDetailedItemPopDAO.java
 * @Description StandardRecipeDetailedItemPopDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.02   	유인찬        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 유인찬
 * @since 2015.04.02
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/rc/rrm/standardRecipeDetailedItemPopDAO")
public class StandardRecipeDetailedItemPopDAO extends DefaultDAO {
	
	/**
	 * 식자재 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("rc.rrm.standardRecipeDetailedItemPopDAO.selectList", mapParam);
	}

	/**
	 * 식자재 분류 코드를 조회한다.
	 * 대분류 - 중분류 - 소분류
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectListItem(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("rc.rrm.standardRecipeDetailedItemPopDAO.selectListItem", mapParam);
	}

	/**
	 * 표준레시피 식자재 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectStdRecipeItemList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("rc.rrm.standardRecipeDetailedItemPopDAO.selectStdRecipeItemList", mapParam);
	}

	/**
	 * 업장레시피 식자재 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectUpjangRecipeItemList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("rc.rrm.standardRecipeDetailedItemPopDAO.selectUpjangRecipeItemList", mapParam);
	}

	/**
	 * 표준레시피 기투입자재 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectStdOrgItemList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("rc.rrm.standardRecipeDetailedItemPopDAO.selectStdOrgItemList", mapParam);
	}

	/**
	 * 업장레시피 기투입자재 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectUpjangOrgItemList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("rc.rrm.standardRecipeDetailedItemPopDAO.selectUpjangOrgItemList", mapParam);
	}
}
