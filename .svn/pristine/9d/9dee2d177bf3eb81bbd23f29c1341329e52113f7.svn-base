package com.hwfs.ms.mlm.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 사업장검색하는 WorkplaceSearchPop DAO
 * 
 * @ClassName WorkplaceSearchPopDAO.java
 * @Description WorkplaceSearchPopDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.12   	강대성        최초생성
 * </pre>
 * @author FC종합전산구축 : 모바일 강대성
 * @since 2015.03.12
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/ms/mlm/workplaceSearchPopDAO")
public class WorkplaceSearchPopDAO extends DefaultDAO {
	
	/**
	 * ST사업장검색 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("ms.mlm.workplaceSearchPopDAO.selectList", mapParam);
	}	
	
	/**
	 * 식재 업장검색 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectFmsUpjangList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("ms.mlm.workplaceSearchPopDAO.selectFmsUpjangList", mapParam);
	}	
	
	/**
	 * 업장검색 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectUpjangList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("ms.mlm.workplaceSearchPopDAO.select"
				+ mapParam.get("roleSetId"), mapParam);
	}
	
}
