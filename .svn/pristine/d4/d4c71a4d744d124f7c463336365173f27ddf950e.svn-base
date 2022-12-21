package com.hwfs.sm.sar.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * SAP 계좌번호를 조회하는 SuspenseReturnRequestPop DAO
 * 
 * @ClassName SuspenseReturnRequestPopDAO.java
 * @Description SuspenseReturnRequestPopDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.19   	JUN        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 JUN
 * @since 2015.05.19
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sm/sar/suspenseReturnRequestPopDAO")
public class SuspenseReturnRequestPopDAO extends DefaultDAO {
	
	/**
	 * SAP 계좌번호 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.sar.suspenseReturnRequestPopDAO.selectList", mapParam);
	}
	
	/**
	 * SAP 가수금 전환 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectDetailList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.sar.suspenseReturnRequestPopDAO.selectDetailList", mapParam);
	}
	

}
