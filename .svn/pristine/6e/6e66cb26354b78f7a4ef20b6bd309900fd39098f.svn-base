package com.hwfs.ms.mom.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 창고조회(콤보팝업)하는 SubInventory DAO
 * 
 * @ClassName SubInventoryDAO.java
 * @Description SubInventoryDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.16   	강대성        최초생성
 * </pre>
 * @author FC종합전산구축 : 모바일 강대성
 * @since 2015.03.16
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/ms/mom/subInventoryDAO")
public class SubInventoryDAO extends DefaultDAO {
	
	/**
	 * 창고조회(콤보팝업) 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectFmsSubinList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("ms.mom.subInventoryDAO.selectFmsSubinList", mapParam);
	}
	
	/**
	 * 창고조회(콤보팝업) 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectVoSubinList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("ms.mom.subInventoryDAO.selectVoSubinList", mapParam);
	}
	
	/**
	 * 창고조회(콤보팝업) 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectStockSubinList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("ms.mom.subInventoryDAO.selectStockSubinList", mapParam);
	}

	
	
}
