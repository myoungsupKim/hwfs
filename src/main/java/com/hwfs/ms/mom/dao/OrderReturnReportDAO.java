package com.hwfs.ms.mom.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 발주반려현황조회하는 OrderReturnReport DAO
 * 
 * @ClassName OrderReturnReportDAO.java
 * @Description OrderReturnReportDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.03   	강대성        최초생성
 * </pre>
 * @author FC종합전산구축 : 모바일 강대성
 * @since 2015.04.03
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/ms/mom/orderReturnReportDAO")
public class OrderReturnReportDAO extends DefaultDAO {
	
	/**
	 * 발주반려현황조회 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("ms.mom.orderReturnReportDAO.selectList", mapParam);
	}	
	
}
