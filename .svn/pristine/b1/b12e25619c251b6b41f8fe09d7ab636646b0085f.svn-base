package com.hwfs.sm.stm.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sm.stm.dao.TaxInvoiceOccurObjPopDAO;

 /**
 * 세금계산서 발생대상을 조회하는 TaxInvoiceOccurObjPop Service Implementation
 * 
 * @ClassName TaxInvoiceOccurObjPopServiceImpl.java
 * @Description TaxInvoiceOccurObjPopServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.06.08    JUN        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 JUN
 * @since 2015.06.08
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sm/stm/taxInvoiceOccurObjPopService")
public class TaxInvoiceOccurObjPopServiceImpl extends DefaultServiceImpl implements TaxInvoiceOccurObjPopService {
	
	/** LogService */
//	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** TaxInvoiceOccurObjPopDAO Bean 생성 */
	@Resource(name = "/sm/stm/taxInvoiceOccurObjPopDAO")
	private TaxInvoiceOccurObjPopDAO taxInvoiceOccurObjPopDAO;
	

	/**
	 * 세금계산서 발생대상 목록을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		String occurClass = (String)mapParam.get("inqueryOccurClass");
		String sMuCd = (String)mapParam.get("inqueryMuCd");

		
		if(occurClass.equals("1") || occurClass.equals("2")){
			return taxInvoiceOccurObjPopDAO.selectArList(mapParam);			//채권
		}else if(occurClass.equals("3") || occurClass.equals("4")){
			return taxInvoiceOccurObjPopDAO.selectAdvanceList(mapParam);	//선수금
		}else if(occurClass.equals("5")){
			return taxInvoiceOccurObjPopDAO.selectAdvanceAltList(mapParam);	//선수금
		}else if(occurClass.equals("ITEM")){
			return taxInvoiceOccurObjPopDAO.selectTaxItemList(mapParam);	//선수금
		}else {
			if(sMuCd.equals("2004"))
				return taxInvoiceOccurObjPopDAO.selectSalsList2004(mapParam);			//매출(식재는 따로 뺌			
			else return taxInvoiceOccurObjPopDAO.selectSalsList(mapParam);			//매출
		}
	}
	
}
