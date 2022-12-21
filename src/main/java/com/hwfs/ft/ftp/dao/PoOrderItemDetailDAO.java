package com.hwfs.ft.ftp.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 구매 주문 품목 상세하는 PoOrderItemDetail DAO
 * 
 * @ClassName PoOrderItemDetailDAO.java
 * @Description PoOrderItemDetailDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.20   	KJJ        최초생성
 * </pre>
 * @author FC종합전산구축 : 식재도매 KJJ
 * @since 2015.03.20
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/ft/ftp/poOrderItemDetailDAO")
public class PoOrderItemDetailDAO extends DefaultDAO {
	
	/**
	 * 구매 주문 품목 상세 관리 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("ft.ftp.poOrderItemDetailDAO.selectList", mapParam);
	}

	/**
	 * 구매 주문 품목 상세 관리(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("ft.ftp.poOrderItemDetailDAO.insert", mapParam);
	}
	
	/**
	 * 구매 주문 품목 상세 관리(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("ft.ftp.poOrderItemDetailDAO.update", mapParam);
	}
	
	/**
	 * 구매 주문 품목 상세 관리(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("ft.ftp.poOrderItemDetailDAO.delete", mapParam);
	}

	/**
	 * 구매 주문 품목 상세 관리(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteItem(Map<String, Object> mapParam) throws Exception {
		return super.update("ft.ftp.poOrderItemDetailDAO.deleteItem", mapParam);
	}

	/**
	 * PoOrderMstService.java
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @return
	 * @param parameter
	 */
	public int updateEntryEndQuantity(Map<String, Object> parameter) {
		//if (parameter.size() <= 0) return 0;
		return super.update("ft.ftp.poOrderItemDetailDAO.updateEntryEndQuantity", parameter);
	}		
}
