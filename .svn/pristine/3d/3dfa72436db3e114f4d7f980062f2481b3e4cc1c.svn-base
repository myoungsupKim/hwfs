package com.hwfs.sc.scp.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

 /**
 * 개인정보 열람이력 통계를 조회하는 PersReadStatistics Service Interface
 * 
 * @ClassName PersReadStatisticsService.java
 * @Description PersReadStatisticsService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.19    kksoo        최초생성
 *  
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015.05.19
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface PersReadStatisticsService {

	/**
	 * 사용자 시간대별 개인정보 열람이력 통계 목록을 조회한다.
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectListPerUserHour(Map<String, Object> mapParam) throws Exception;

	/**
	 * 일자별 개인정보 열람이력 통계 목록을 조회한다.
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectListPerDay(Map<String, Object> mapParam) throws Exception;

}
