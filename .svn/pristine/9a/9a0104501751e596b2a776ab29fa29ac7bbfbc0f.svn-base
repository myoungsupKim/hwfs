package com.hwfs.rc.roa.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.rc.roa.dao.MonthOverTimeListDAO;

/**
* 월별 근무시간 조회하는 MonthOverTimeList Service Implementation
* @ClassName MonthOverTimeListServiceImpl.java
* @Description MonthOverTimeListServiceImpl Class 
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
@Service("/rc/roa/monthOverTimeListService")
public class MonthOverTimeListServiceImpl extends DefaultServiceImpl implements MonthOverTimeListService
{
	/** MonthOverTimeListDAO Bean 생성 */
	@Resource(name = "/rc/roa/monthOverTimeListDAO")
	private MonthOverTimeListDAO monthOverTimeListDAO;

	/**
	 * 월별 근무일을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectWorkDayList(Map<String, Object> mapParam) throws Exception
	{
		return monthOverTimeListDAO.selectWorkDayList(mapParam);
	}

	/**
	 * 월별 근무 시간을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception
	{
		return monthOverTimeListDAO.selectList(mapParam);
	}


}
