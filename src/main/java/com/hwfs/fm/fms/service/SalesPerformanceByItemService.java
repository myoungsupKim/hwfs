package com.hwfs.fm.fms.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import com.hwfs.sc.cmn.dto.LoginDTO;

 /**
 * 단가계약업장을 설정하는 SalesPerformanceByItem Service Interface
 * 
 * @ClassName SalesPerformanceByItemService.java
 * @Description SalesPerformanceByItemService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2018.09.04    kihoon        최초생성
 *   
 * </pre>
 * @author FC종합전산구축 : 통합영업 최성연
 * @since 2018.09.04
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface SalesPerformanceByItemService {
	
	//RecordSet selectMaxDt(Map<String, Object> mapParam) throws Exception;
	/**
	 * 
	 * <pre>
	 * - DTO 
	 * </pre>
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectList(Map<String, Object> mapParam) throws Exception;
	
}
