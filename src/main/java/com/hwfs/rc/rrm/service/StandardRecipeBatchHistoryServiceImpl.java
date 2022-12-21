package com.hwfs.rc.rrm.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.rc.rrm.dao.StandardRecipeBatchHistoryDAO;

 /**
 * 표준 레시피 자재 일괄 변경 이력을 관리하는 StandardRecipeBatchHistory Service Implementation
 * 
 * @ClassName StandardRecipeBatchHistoryServiceImpl.java
 * @Description StandardRecipeBatchHistoryServiceImpl Class
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

@Service("/rc/rrm/standardRecipeBatchHistoryService")
public class StandardRecipeBatchHistoryServiceImpl extends DefaultServiceImpl implements StandardRecipeBatchHistoryService
{
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** RecipeListDAO Bean 생성 */
	@Resource(name = "/rc/rrm/standardRecipeBatchHistoryDAO")
	private StandardRecipeBatchHistoryDAO standardRecipeBatchHistoryDAO;
	
	/**
	 * 표준 레시피 자재 일괄 변경 이력을 조회한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략하면 삭제할 것
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception
	{
			return standardRecipeBatchHistoryDAO.selectList(mapParam);
	}

	/**
	 * 표준 레시피 자재 일괄 변경 상세이력을 조회한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략하면 삭제할 것
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectDetailList(Map<String, Object> mapParam) throws Exception
	{
			return standardRecipeBatchHistoryDAO.selectDetailList(mapParam);
	}
}