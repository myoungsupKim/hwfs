package com.hwfs.rc.bms.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

 /**
 * ProAmGoalService에 대한 설명 작성
 * @ClassName ProAmGoalService.java
 * @Description ProAmGoalService Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 3. 2.   Administrator        최초생성
 * </pre>
 * @author FC종합전산구축 : 팀명 Administrator
 * @since 2015. 3. 2.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface TmMgmtService {
	RecordSet selectGoalList(Map<String, Object> parameter) throws Exception;
	int saveGoalData(DataSetMap bmsTmGoal) throws Exception;
	RecordSet selectTmGoalChk(Map<String, Object> parameter) throws Exception;
	RecordSet selectSaleList(Map<String, Object> parameter) throws Exception;
	int saveSaleData(DataSetMap bmsTmSale) throws Exception;
	RecordSet selectAddSaleList(Map<String, Object> parameter) throws Exception;
	int saveAddSaleData(DataSetMap bmsTmAddSale) throws Exception;
	RecordSet selectSaleSumList(Map<String, Object> parameter) throws Exception;
	RecordSet selectBCodeList(Map<String, Object> parameter) throws Exception;
	
}
