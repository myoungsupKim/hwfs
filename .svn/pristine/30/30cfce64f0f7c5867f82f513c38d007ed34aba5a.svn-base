package com.hwfs.sm.srm.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

/**
 * SAP 미발행 전표현황을 조회하는 SapSlipNonUpoadList DAO
 * 
 * @ClassName MonthCloseChkDAO.java
 * @Description MonthCloseChkDAO Class
 * @Modification-Information <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.12.21    백승현      최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 백승현
 * @since 2015.12.21
 * @version 1.0
 * @see <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sm/srm/monthCloseChkDAO")
public class MonthCloseChkDAO extends DefaultDAO {

	/**
	 *  월마감관리 현황 목록을 조회한다.
	 * 
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.srm.monthCloseChkDAO.selectList", mapParam);
	}

	/**
	 * 월마감 현황을 조회 DataSetMap의 데이터를 Merge 처리한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.srm.monthCloseChkDAO.insert", mapParam);
	}
	
	/**
	 * 월마감 현황을 조회 DataSetMap의 데이터를 Merge 처리한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert2(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.srm.monthCloseChkDAO.insert2", mapParam);
	}	
	
	/**
	 *  회계 월마감관리 현황 목록을 조회한다.
	 * 
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList2(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.srm.monthCloseChkDAO.selectList2", mapParam);
	}
}
