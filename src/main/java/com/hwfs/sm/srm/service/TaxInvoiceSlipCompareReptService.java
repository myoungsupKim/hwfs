package com.hwfs.sm.srm.service;

import hone.core.util.record.RecordSet;
import java.util.Map;

/**
 * 식재 세금계산서/전표 발행 비교 현황을 관리하는 TaxInvoiceSlipCompareRept Service Interface
 * 
 * @ClassName TaxInvoiceSlipCompareReptService.java
 * @Description TaxInvoiceSlipCompareReptService Class
 * @Modification-Information <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2016.05.09    백승현      최초생성
 * 
 * </pre>
 * @author FC종합전산구축 : 통합영업 백승현
 * @since 2016.05.09
 * @version 1.0
 * @see <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface TaxInvoiceSlipCompareReptService {

	/**
	 * 식재 세금계산서/전표 발행 비교 목록을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 조회결과
	 * @throws Exception
	 */
	RecordSet selectList(Map<String, Object> mapParam) throws Exception;
}
