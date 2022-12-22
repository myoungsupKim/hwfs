package com.hwfs.sc.scc.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

 /**
 * CodeMgmtService에 대한 설명 작성
 * @ClassName CodeMgmtService.java
 * @Description CodeMgmtService Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 1. 19.   Administrator        최초생성
 * </pre>
 * @author FC종합전산구축 : 팀명 Administrator
 * @since 2015. 1. 19.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface CodeMgmtService {
	RecordSet selectGroupList(Map<String, Object> parameter);
	RecordSet selectCodeList(Map<String, Object> parameter);
	
	int saveList(DataSetMap groupList, DataSetMap codeList);
}
