package com.hwfs.sc.scm.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

 /**
 * MenuMgmtService에 대한 설명 작성
 * @ClassName MenuMgmtService.java
 * @Description MenuMgmtService Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 1. 27.   Administrator        최초생성
 * </pre>
 * @author FC종합전산구축 : 팀명 Administrator
 * @since 2015. 1. 27.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface MenuMgmtService {
	RecordSet selectList(Map<String, Object> parameter);
	int saveList(DataSetMap parameter);
}
