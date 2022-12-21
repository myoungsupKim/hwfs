package com.hwfs.ft.ftp.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 구매주문 INVOICE하는 PoOrderInvoice DAO
 * 
 * @ClassName PoOrderInvoiceDAO.java
 * @Description PoOrderInvoiceDAO Class
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
@Repository("/ft/ftp/poOrderInvoiceDAO")
public class PoOrderInvoiceDAO extends DefaultDAO {
	
	/**
	 * 구매주문 INVOICE 관리 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("ft.ftp.poOrderInvoiceDAO.selectList", mapParam);
	}

	/**
	 * 구매주문 INVOICE 관리(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("ft.ftp.poOrderInvoiceDAO.insert", mapParam);
	}
	
	/**
	 * 구매주문 INVOICE 관리(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("ft.ftp.poOrderInvoiceDAO.update", mapParam);
	}
	
	/**
	 * 구매주문 INVOICE 관리(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("ft.ftp.poOrderInvoiceDAO.delete", mapParam);
	}

	/**
	 * 구매주문 INVOICE 관리(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteInvoice(Map<String, Object> mapParam) throws Exception {
		return super.update("ft.ftp.poOrderInvoiceDAO.deleteInvoice", mapParam);
	}

}
