package com.hwfs.ft.ftr.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 도매유통수불현황 조회하는 WholesaleSubulRpt DAO
 * 
 * @ClassName WholesaleSubulRptDAO.java
 * @Description WholesaleSubulRptDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.12.11   	강대성        최초생성
 * </pre>
 * @author FC종합전산구축 : 도매유통 강대성
 * @since 2015.12.11
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/ft/ftr/wholesaleSubulRptDAO")
public class WholesaleSubulRptDAO extends DefaultDAO {
	
	/**
	 * 도매유통수불현황 조회 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("ft.ftr.wholesaleSubulRptDAO.selectList", mapParam);
	}
	
}
