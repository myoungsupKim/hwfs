package com.hwfs.fm.fms.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 행사상품을 조회하는 DAO
 * 
 * @ClassName EventItemListDAO.java
 * @Description EventItemListDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2021.07.30   DEV02        최초생성
 * </pre>
 * @author [PJT]주문채널통합 : DEV02
 * @since 2021.07.30
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fm/fms/eventItemListDAO")
public class EventItemListDAO extends DefaultDAO {
	
	/**
	 * 행사상품을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectEventItemList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.eventItemListDAO.selectEventItemList", mapParam);
	}
	
}
