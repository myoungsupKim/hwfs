package com.hwfs.rc.sle.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

 /**
 * OutletSalesService에 대한 설명 작성
 * @ClassName OutletSalesService.java
 * @Description OutletSalesService Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 8. 25.   박대영        최초생성
 * </pre>
 * @author FC종합전산구축 : 외식영업(POS영업관리)
 * @since 2015. 8. 25.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface OutletSalesService {
	RecordSet selectSalesInqList(Map<String, Object> parameter) throws Exception;
	RecordSet selectSalesApprList(Map<String, Object> parameter) throws Exception;
	int saveData1(DataSetMap sleOutletSales) throws Exception;
	int saveData2(DataSetMap sleOutletSales) throws Exception;
	int saveData3(DataSetMap sleOutletSales) throws Exception;
}
