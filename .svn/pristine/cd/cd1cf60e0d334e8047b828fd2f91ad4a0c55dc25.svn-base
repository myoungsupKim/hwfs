package com.hwfs.sm.srm.service;

import hone.core.util.record.RecordSet;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sm.srm.dao.TaxInvoiceSlipCompareReptDAO;

/**
 * 식재 세금계산서/전표 발행 비교 현황을 관리하는 TaxInvoiceSlipCompareRept Service Implementation
 * 
 * @ClassName TaxInvoiceSlipCompareReptServiceImpl.java
 * @Description TaxInvoiceSlipCompareReptServiceImpl Class
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
@Service("/sm/srm/taxInvoiceSlipCompareReptService")
public class TaxInvoiceSlipCompareReptServiceImpl extends DefaultServiceImpl implements TaxInvoiceSlipCompareReptService {

	/** LogService */
	// private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** SapSlipNonUpoadListDAO Bean 생성 */
	@Resource(name = "/sm/srm/taxInvoiceSlipCompareReptDAO")
	private TaxInvoiceSlipCompareReptDAO taxInvoiceSlipCompareReptDAO;

	/**
	 * 식재 세금계산서/전표 발행 비교 목록을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 조회결과
	 * @throws Exception
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return taxInvoiceSlipCompareReptDAO.selectList(mapParam);
	}
}
