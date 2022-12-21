package com.hwfs.rc.sle.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

 /**
 * DcEventMgmtService에 대한 설명 작성
 * @ClassName DcEventMgmtService.java
 * @Description DcEventMgmtService Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 4. 22.   박대영        최초생성
 * </pre>
 * @author FC종합전산구축 :외식영업(POS영업관리)
 * @since 2015. 4. 22.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface DcEventMgmtService {
	RecordSet selectListPrmt(Map<String, Object> parameter) throws Exception;
	RecordSet selectListCond(Map<String, Object> parameter) throws Exception;
	RecordSet selectListMixs(Map<String, Object> parameter) throws Exception;
	RecordSet selectListRcpt(Map<String, Object> parameter) throws Exception;
	RecordSet selectListCard(Map<String, Object> parameter) throws Exception;
	RecordSet selectListOutlet(Map<String, Object> parameter) throws Exception;
	
	int saveData(DataSetMap slePrmt,     DataSetMap slePrmtOutlet, DataSetMap slePrmtCond,
			     DataSetMap slePrmtMixs, DataSetMap slePrmtRcpt,   DataSetMap slePrmtCard) throws Exception;
	
}
