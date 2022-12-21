package com.hwfs.rc.rrm.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.rc.rrm.dao.RecipeUseSearchDAO;

 /**
 * 레시피 메뉴 사용통계를 조회하는 StandardRecipeBatchChange Service Implementation
 * 
 * @ClassName StandardRecipeBatchChangeServiceImpl.java
 * @Description StandardRecipeBatchChangeServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.20    Yu        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 Yu
 * @since 2015.04.20
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/rc/rrm/recipeUseSearchService")
public class RecipeUseSearchServiceImpl extends DefaultServiceImpl implements RecipeUseSearchService {
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** RecipeUseSerachDAO Bean 생성 */
	@Resource(name = "/rc/rrm/recipeUseSearchDAO")
	private RecipeUseSearchDAO recipeUseSearchDAO; 
	

	/**
	 * 레시피 메뉴 사용통계를 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return recipeUseSearchDAO.selectList(mapParam);
	}

	
}
