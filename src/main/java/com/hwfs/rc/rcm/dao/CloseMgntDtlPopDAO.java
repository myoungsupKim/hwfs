package com.hwfs.rc.rcm.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 일마감 정보하는 CloseMgntDtlPop DAO
 * 
 * @ClassName CloseMgntDtlPopDAO.java
 * @Description CloseMgntDtlPopDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.08.11   	JUN        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 JUN
 * @since 2015.08.11
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/rc/rcm/closeMgntDtlPopDAO")
public class CloseMgntDtlPopDAO extends DefaultDAO {
	
	/**
	 * 일마감 정보를 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("rc.rcm.closeMgntDtlPopDAO.selectList", mapParam);
	}
	
	/**
	 * 일마감 매출정보를 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectSalsList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("rc.rcm.closeMgntDtlPopDAO.selectSalsList", mapParam);
	}

	/**
	 * 일마감 매출정보를 조회한다(사업장일마감용).
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectSalsListMag(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("rc.rcm.closeMgntDtlPopDAO.selectSalsListMag", mapParam);
	}
	
	/**
	 * 일마감 지불정보를 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectPayList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("rc.rcm.closeMgntDtlPopDAO.selectPayList", mapParam);
	}

	/**
	 * 일마감 지불정보를 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectPayListMag(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("rc.rcm.closeMgntDtlPopDAO.selectPayListMag", mapParam);
	}
}
