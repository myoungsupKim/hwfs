package com.hwfs.sm.stm.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 구매 세금계산서 자동 발행하는 TaxInvoiceAuto DAO
 * 
 * @ClassName TaxInvoiceAutoDAO.java
 * @Description TaxInvoiceAutoDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.12.01   	김명호        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 김명호
 * @since 2015.12.01
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sm/stm/taxInvoiceAutoDAO")
public class TaxInvoiceAutoDAO extends DefaultDAO {
	
	/**
	 * 구매 세금계산서 자동 발행 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.stm.taxInvoiceAutoDAO.selectList", mapParam);
	}

	/**
	 * 구매 세금계산서 자동 발행(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.stm.taxInvoiceAutoDAO.insert", mapParam);
	}
	
	/**
	 * 구매 세금계산서 자동 발행(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.stm.taxInvoiceAutoDAO.update", mapParam);
	}
	
	/**
	 * 구매 세금계산서 자동 발행(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.stm.taxInvoiceAutoDAO.delete", mapParam);
	}
	
}
