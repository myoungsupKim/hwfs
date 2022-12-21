package com.hwfs.sm.srm.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

/**
 * 식재 세금계산서/전표 발행 비교 현황을 관리하는 TaxInvoiceSlipCompareRept DAO
 * 
 * @ClassName TaxInvoiceSlipCompareReptDAO.java
 * @Description TaxInvoiceSlipCompareReptDAO Class
 * @Modification-Information <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2016.05.09    백승현      최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 백승현
 * @since 2016.05.09
 * @version 1.0
 * @see <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sm/srm/taxInvoiceSlipCompareReptDAO")
public class TaxInvoiceSlipCompareReptDAO extends DefaultDAO {

	/**
	 *  식재 세금계산서/전표 발행 비교 목록을 조회한다.
	 * 
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.srm.taxInvoiceSlipCompareReptDAO.selectList", mapParam);
	}
}
