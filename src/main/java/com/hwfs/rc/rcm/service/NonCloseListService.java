package com.hwfs.rc.rcm.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

 /**
 * 미마감현황을 조회하는 NonCloseList Service Interface
 * 
 * @ClassName NonCloseListService.java
 * @Description NonCloseListService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.09.08    JUN        최초생성
 *  
 * </pre>
 * @author FC종합전산구축 : 통합영업 JUN
 * @since 2015.09.08
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface NonCloseListService {

	/**
	 * 미마감현황 목록을 조회한다.
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectList(Map<String, Object> mapParam) throws Exception;

}
