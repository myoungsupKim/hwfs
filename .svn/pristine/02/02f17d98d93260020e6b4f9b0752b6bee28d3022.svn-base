package com.hwfs.rc.rcm.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 마감현황을 조회하는 CloseStatus DAO
 * 
 * @ClassName CloseStatusDAO.java
 * @Description CloseStatusDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.08.03   	JUN        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 JUN
 * @since 2015.08.03
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/rc/rcm/closeStatusDAO")
public class CloseStatusDAO extends DefaultDAO {
	
	/**
	 * 마감현황 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("rc.rcm.closeStatusDAO.selectList", mapParam);
	}

	/**
	 * 마감현황 상세목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectDtlList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("rc.rcm.closeStatusDAO.selectDtlList", mapParam);
	}
}
