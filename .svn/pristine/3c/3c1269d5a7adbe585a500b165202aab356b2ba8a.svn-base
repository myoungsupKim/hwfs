package com.hwfs.rc.rrm.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 업장 레시피를 조회(by Item)하는 RecipeInquirybyItem DAO
 * 
 * @ClassName RecipeInquirybyItemDAO.java
 * @Description RecipeInquirybyItemDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.17   	Yu        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 Yu
 * @since 2015.04.17
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/rc/rrm/recipeInquirybyItemDAO")
public class RecipeInquirybyItemDAO extends DefaultDAO {
	
	/**
	 * 업장 레시피 조회(by Item) 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("rc.rrm.recipeInquirybyItemDAO.selectList", mapParam);
	}

	/**
	 * 업장의 센터코드를 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectCenterCode(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("rc.rrm.recipeInquirybyItemDAO.selectCenterCode", mapParam);
	}
}
