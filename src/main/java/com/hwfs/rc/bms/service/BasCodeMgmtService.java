package com.hwfs.rc.bms.service;

import java.util.Map;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

 /**
 * BasCodeMgmtService에 대한 설명 작성
 * @ClassName BasCodeMgmtService.java
 * @Description BasCodeMgmtService Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 2. 6.   박대영        최초생성
 * </pre>
 * @author FC종합전산구축 : 연회웨딩
 * @since 2015. 2. 6.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface BasCodeMgmtService {
	RecordSet selectGroupList();
	RecordSet selectCodeList(Map<String, Object> parameter);
	RecordSet selectListSCC(Map<String, Object> parameter);
	int saveList(DataSetMap groupList, DataSetMap codeList);
}
