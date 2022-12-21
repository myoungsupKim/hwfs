package com.hwfs.rc.sle.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

/**
* 일별 식권판매현황 조회하는 DailyTicketSaleList DAO
* @ClassName DailyTicketSaleListDAO.java
* @Description DailyTicketSaleListDAO Class 
* @Modification-Information
* <pre>
*    수정일       수정자              수정내용
*  ----------   ----------   -------------------------------
*  2016. 1. 20.   Administrator        최초생성
* </pre>
* @author FC종합전산구축 : 팀명 Administrator
* @since 2016. 2. 15.
* @version 1.0
* @see 
* <pre>
*  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
* </pre>
*/

@Repository("/rc/sle/dailyTicketSaleListDAO")
public class DailyTicketSaleListDAO extends DefaultDAO
{
	/**
	 * 일별 식권판매현황을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectList(Map<String, Object> parameter)
	{
		return super.queryForRecordSet("rc.sle.dailyTicketSaleListDAO.selectList", parameter);
	}
}