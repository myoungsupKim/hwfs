package com.hwfs.fm.fmo.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 주문지시서하는 OrderDirec DAO
 * 
 * @ClassName OrderDirecDAO.java
 * @Description OrderDirecDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.07.29   	최영준        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최영준
 * @since 2015.07.29
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fm/fmo/orderDirecDAO")
public class OrderDirecDAO extends DefaultDAO {
	
	/**
	 * 주문지시서 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmo.orderDirecDAO.selectList", mapParam);
	}

	/**
	 * 주문지시서(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmo.orderDirecDAO.insert", mapParam);
	}
	
	/**
	 * 주문지시서(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmo.orderDirecDAO.update", mapParam);
	}
	
	/**
	 * 주문지시서(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmo.orderDirecDAO.delete", mapParam);
	}
	
}
