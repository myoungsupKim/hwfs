package com.hwfs.sm.sar.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 영업현금을 관리하는 SaleCashByValidDate DAO
 * 
 * @ClassName SaleCashByValidDateDAO.java
 * @Description SaleCashByValidDateDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.07.22   	Yu        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 Yu
 * @since 2015.07.22
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sm/sar/saleCashByValidDateDAO")
public class SaleCashByValidDateDAO extends DefaultDAO {
	
	/**
	 * 영업현금 내역 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.sar.saleCashByValidDateDAO.selectList", mapParam);
	}

	
	/**
	 * 영업현금 내역 목록을 조회한다. (영업잔액조회 -From~To)
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList2(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.sar.saleCashByValidDateDAO.selectList2", mapParam);
	}
}
