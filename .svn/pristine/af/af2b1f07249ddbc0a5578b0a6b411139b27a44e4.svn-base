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

@Repository("/rc/rrm/standardRecipeBatchHistoryDAO")
public class StandardRecipeBatchHistoryDAO extends DefaultDAO
{
	/**
	 * 표준 레시피 자재 일괄 변경 이력을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception
	{
		return super.queryForRecordSet("rc.rrm.standardRecipeBatchHistoryDAO.selectList", mapParam);
	}

	/**
	 * 표준 레시피 자재 일괄 변경 상세이력을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public RecordSet selectDetailList(Map<String, Object> mapParam) throws Exception
	{
		return super.queryForRecordSet("rc.rrm.standardRecipeBatchHistoryDAO.selectDetailList", mapParam);
	}
}