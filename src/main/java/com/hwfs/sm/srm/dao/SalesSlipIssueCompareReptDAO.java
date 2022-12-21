package com.hwfs.sm.srm.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 영업전표발행비교 조회하는 SalesSlipIssueCompareRept DAO
 * 
 * @ClassName SalesSlipIssueCompareReptDAO.java
 * @Description SalesSlipIssueCompareReptDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.12.14   	강대성        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 강대성
 * @since 2015.12.14
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sm/srm/salesSlipIssueCompareReptDAO")
public class SalesSlipIssueCompareReptDAO extends DefaultDAO {
	
	/**
	 * 영업전표발행비교(매출금액비교) 조회 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectTab1List(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.srm.salesSlipIssueCompareReptDAO.selectTab1List", mapParam);
	}
	
	/**
	 * 영업전표발행비교(채권금액비교) 조회 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectTab2List(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.srm.salesSlipIssueCompareReptDAO.selectTab2List", mapParam);
	}
	
	/**
	 * 영업전표발행비교(선수금금액비교 조회 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectTab3List(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.srm.salesSlipIssueCompareReptDAO.selectTab3List", mapParam);
	}	
	
}
