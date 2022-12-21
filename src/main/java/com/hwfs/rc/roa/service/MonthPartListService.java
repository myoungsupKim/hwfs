package com.hwfs.rc.roa.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

/**
* 월별 아르바이트 근무시간 조회하는 MonthPartList Service Interface
* @ClassName MonthPartListService.java
* @Description MonthPartListService Class 
* @Modification-Information
* <pre>
*    수정일       수정자              수정내용
*  ----------   ----------   -------------------------------
*  2016. 1. 20.   Administrator        최초생성
* </pre>
* @author FC종합전산구축 : 팀명 Administrator
* @since 2016. 1. 20.
* @version 1.0
* @see 
* <pre>
*  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
* </pre>
*/
public interface MonthPartListService
{

	/**
	 * 월별 근무일을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	RecordSet selectWorkDayList(Map<String, Object> parameter) throws Exception;

	/**
	 * 월별 근무 시간을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	RecordSet selectList(Map<String, Object> parameter) throws Exception;

}
