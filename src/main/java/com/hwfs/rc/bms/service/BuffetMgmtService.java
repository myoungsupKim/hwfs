package com.hwfs.rc.bms.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

 /**
 * BuffetMgmtService에 대한 설명 작성
 * @ClassName BuffetMgmtService.java
 * @Description BuffetMgmtService Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 8. 3.   박대영        최초생성
 * </pre>
 * @author FC종합전산구축 : 연회웨딩
 * @since 2015. 8. 3.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface BuffetMgmtService {
	RecordSet selectListCst(Map<String, Object> parameter) throws Exception;
	RecordSet selectListCstDetail(Map<String, Object> parameter) throws Exception;
	int saveData(DataSetMap  cstMst, DataSetMap  cstDetail) throws Exception;
}
