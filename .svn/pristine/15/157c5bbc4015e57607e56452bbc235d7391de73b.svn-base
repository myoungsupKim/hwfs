package com.hwfs.rc.rrm.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

 /**
 * 식자재를 조회하는 StandardRecipeDetailedItemPop Service Interface
 * 
 * @ClassName StandardRecipeDetailedItemPopService.java
 * @Description StandardRecipeDetailedItemPopService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.02    유인찬        최초생성
 *  
 * </pre>
 * @author FC종합전산구축 : 통합영업 유인찬
 * @since 2015.04.02
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface StandardRecipeDetailedItemPopService {

	/**
	 * 식자재 목록을 조회한다.
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectList(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 식자재 분류 코드를 조회한다.
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectListItem(Map<String, Object> mapParam) throws Exception;

	/**
	 * 표준레시피 식자재 목록을 조회한다.
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectStdRecipeItemList(Map<String, Object> mapParam) throws Exception;

	/**
	 * 업장레시피 식자재 목록을 조회한다.
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectUpjangRecipeItemList(Map<String, Object> mapParam) throws Exception;

	/**
	 * 표준레시피 기투입자재 목록을 조회한다.
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectStdOrgItemList(Map<String, Object> mapParam) throws Exception;

	/**
	 * 업장레시피 기투입자재 목록을 조회한다.
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectUpjangOrgItemList(Map<String, Object> mapParam) throws Exception;
}
