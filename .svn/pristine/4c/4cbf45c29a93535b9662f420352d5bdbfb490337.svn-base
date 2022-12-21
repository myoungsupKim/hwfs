package com.hwfs.rc.rrm.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 표준 레시피를 조회(By Item)하는 StandardRecipeInquirybyItem DAO
 * 
 * @ClassName StandardRecipeInquirybyItemDAO.java
 * @Description StandardRecipeInquirybyItemDAO Class
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
@Repository("/rc/rrm/standardRecipeInquirybyItemDAO")
public class StandardRecipeInquirybyItemDAO extends DefaultDAO {
	
	/**
	 * 표준 레시피 조회(By Item) 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("rc.rrm.standardRecipeInquirybyItemDAO.selectList", mapParam);
	}

}
