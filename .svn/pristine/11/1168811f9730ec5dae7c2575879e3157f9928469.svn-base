package com.hwfs.sm.stm.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 세금계산서 미발행하는 TaxInvoiceUnissued DAO
 * 
 * @ClassName TaxInvoiceUnissuedDAO.java
 * @Description TaxInvoiceUnissuedDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.08.25   	남유민        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 남유민
 * @since 2015.08.25
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sm/stm/taxInvoiceUnissuedDAO")
public class TaxInvoiceUnissuedDAO extends DefaultDAO {
	
	/**
	 * 세금계산서 미발행 목록(매출)을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectSalsList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.stm.taxInvoiceUnissuedDAO.selectSalsList", mapParam);
	}
	
	/**
	 * 세금계산서 미발행 목록(채권)을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectArList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.stm.taxInvoiceUnissuedDAO.selectArList", mapParam);
	}
	
	/**
	 * 세금계산서 미발행 목록(선수금)을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectAdvanceList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.stm.taxInvoiceUnissuedDAO.selectAdvanceList", mapParam);
	}

	/**
	 * 세금계산서 미발행(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.stm.taxInvoiceUnissuedDAO.insert", mapParam);
	}
	
	/**
	 * 세금계산서 미발행(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.stm.taxInvoiceUnissuedDAO.update", mapParam);
	}
	
	/**
	 * 세금계산서 미발행(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.stm.taxInvoiceUnissuedDAO.delete", mapParam);
	}
	
}
