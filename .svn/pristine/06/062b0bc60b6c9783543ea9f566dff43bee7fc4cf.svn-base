package com.hwfs.rc.bms.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

 /**
 * EventMgmtService에 대한 설명 작성
 * @ClassName EventMgmtService.java
 * @Description EventMgmtService Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 6. 30.   박대영        최초생성
 * </pre>
 * @author FC종합전산구축 : 연회웨딩
 * @since 2015. 6. 30.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface EventMgmtService {
	
	RecordSet reservDuplicationCheck(Map<String, Object> parameter) throws Exception;
	RecordSet reservList(Map<String, Object> parameter) throws Exception;
	
	RecordSet selectListMst(Map<String, Object> parameter) throws Exception;
	RecordSet selectListWedding(Map<String, Object> parameter) throws Exception;
	RecordSet selectListGoods(Map<String, Object> parameter) throws Exception;
	RecordSet selectListRoom(Map<String, Object> parameter) throws Exception;
	RecordSet selectListOther(Map<String, Object> parameter) throws Exception;
	RecordSet selectListOutSide(Map<String, Object> parameter) throws Exception;
	RecordSet selectListBanquet(Map<String, Object> parameter) throws Exception;
	RecordSet selectListPayment(Map<String, Object> parameter) throws Exception; 
	 
	String saveData(DataSetMap  reservMst,   DataSetMap  reservBanquet, DataSetMap  reservGoods,   DataSetMap  reservRoom
			      , DataSetMap  reservOther, DataSetMap  reservOutside, DataSetMap  reservWedding, DataSetMap  reservFile
			      , String sabun) throws Exception;

	int saveDataPayment(DataSetMap  payMst) throws Exception;
	 
	
	RecordSet selectListCardVan(Map<String, Object> parameter) throws Exception; 
	
	//선수금 처리
	Map<String, Object> insertDataAdvanceIns(Map<String, Object> parameter) throws Exception;
	Map<String, Object> insertDataAdvancePay(Map<String, Object> parameter) throws Exception;
	Map<String, Object> insertDataAdvanceCancel(Map<String, Object> parameter) throws Exception;
	
	
}
