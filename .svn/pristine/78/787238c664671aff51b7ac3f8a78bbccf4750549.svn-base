package com.hwfs.rc.rrm.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.rc.rrm.dao.StandardRecipeDetailedItemPopDAO;

 /**
 * 식자재를 조회하는 StandardRecipeDetailedItemPop Service Implementation
 * 
 * @ClassName StandardRecipeDetailedItemPopServiceImpl.java
 * @Description StandardRecipeDetailedItemPopServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.02    유인찬        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 유인찬
 * @since 2015.04.02
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/rc/rrm/standardRecipeDetailedItemPopService")
public class StandardRecipeDetailedItemPopServiceImpl extends DefaultServiceImpl implements StandardRecipeDetailedItemPopService {
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());
 
	/** StandardRecipeDetailedItemPopDAO Bean 생성 */
	@Resource(name = "/rc/rrm/standardRecipeDetailedItemPopDAO")
	private StandardRecipeDetailedItemPopDAO standardRecipeDetailedItemPopDAO;
	

	/**
	 * 식자재 목록을 조회한다.
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return standardRecipeDetailedItemPopDAO.selectList(mapParam);
	}
	
	/**
	 * 식자재 분류 코드를 조회한다.
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectListItem(Map<String, Object> mapParam) throws Exception {
		return standardRecipeDetailedItemPopDAO.selectListItem(mapParam);
	}

	/**
	 * 표준레시피 식자재 목록을 조회한다.
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectStdRecipeItemList(Map<String, Object> mapParam) throws Exception {
		return standardRecipeDetailedItemPopDAO.selectStdRecipeItemList(mapParam);
	}

	/**
	 * 업장레시피 식자재 목록을 조회한다.
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectUpjangRecipeItemList(Map<String, Object> mapParam) throws Exception {
		return standardRecipeDetailedItemPopDAO.selectUpjangRecipeItemList(mapParam);
	}

	/**
	 * 표준레시피 기투입자재 목록을 조회한다.
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectStdOrgItemList(Map<String, Object> mapParam) throws Exception {
		return standardRecipeDetailedItemPopDAO.selectStdOrgItemList(mapParam);
	}

	/**
	 * 업장레시피 기투입자재 목록을 조회한다.
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectUpjangOrgItemList(Map<String, Object> mapParam) throws Exception {
		return standardRecipeDetailedItemPopDAO.selectUpjangOrgItemList(mapParam);
	}
}
