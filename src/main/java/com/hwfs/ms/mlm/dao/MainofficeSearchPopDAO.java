package com.hwfs.ms.mlm.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 본사검색하는 MainofficeSearchPop DAO
 * 
 * @ClassName MainofficeSearchPopDAO.java
 * @Description MainofficeSearchPopDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.13   	강대성        최초생성
 * </pre>
 * @author FC종합전산구축 : 모바일 강대성
 * @since 2015.03.13
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/ms/mlm/mainofficeSearchPopDAO")
public class MainofficeSearchPopDAO extends DefaultDAO {
	
	/**
	 * 본사검색 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("ms.mlm.mainofficeSearchPopDAO.selectList", mapParam);
	}
	
	/**
	 * 본사검색 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectMainList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("ms.mlm.mainofficeSearchPopDAO.selectMainList", mapParam);
	}

	
	
}
