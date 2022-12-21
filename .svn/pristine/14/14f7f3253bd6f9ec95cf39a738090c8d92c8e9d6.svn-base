package com.hwfs.fm.fmo.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 구매반려내역하는 OrderReturnList DAO
 * 
 * @ClassName OrderReturnListDAO.java
 * @Description OrderReturnListDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.08.10   	최영준        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최영준
 * @since 2015.08.10
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fm/fmo/orderReturnListDAO")
public class OrderReturnListDAO extends DefaultDAO {
	
	/**
	 * 반려내역 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectListRe(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmo.orderReturnListDAO.selectListRe", mapParam);
	}
	
	/**
	 * 입고일변경 내역 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectListChg(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmo.orderReturnListDAO.selectListChg", mapParam);
	}

	/**
	 * 주문신청 자재변경 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectListItem(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmo.orderReturnListDAO.selectListItem", mapParam);
	}
	
}
