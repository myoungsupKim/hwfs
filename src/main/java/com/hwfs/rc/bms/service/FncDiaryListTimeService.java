package com.hwfs.rc.bms.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

 /**
 * FncDiaryListTimeService에 대한 설명 작성
 * @ClassName FncDiaryListTimeService.java
 * @Description FncDiaryListTimeService Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 7. 28.   박대영        최초생성
 * </pre>
 * @author FC종합전산구축 : 연회웨딩
 * @since 2015. 7. 28.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface FncDiaryListTimeService {
	RecordSet selectList(Map<String, Object> parameter) throws Exception;
	RecordSet selectDtList(Map<String, Object> parameter) throws Exception;
}
