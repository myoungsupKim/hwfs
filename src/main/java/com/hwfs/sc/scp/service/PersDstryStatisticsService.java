package com.hwfs.sc.scp.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

 /**
 * 개인정보 파기이력통계를 조회하는 PersDstryStatistics Service Interface
 * 
 * @ClassName PersDstryStatisticsService.java
 * @Description PersDstryStatisticsService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.22    kksoo        최초생성
 *  
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015.05.22
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface PersDstryStatisticsService {

	/**
	 * 파기상태별 개인정보 파기이력통계 목록을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	RecordSet selectListPerDstryStatus(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 파기구분별 개인정보 파기이력통계 목록을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	RecordSet selectListPerDstryClass(Map<String, Object> mapParam) throws Exception;
	
}
