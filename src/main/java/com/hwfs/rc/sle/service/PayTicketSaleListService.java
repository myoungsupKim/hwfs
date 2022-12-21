package com.hwfs.rc.sle.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

/**
* 지불수단별 식권판매현황 조회하는 PayTicketSaleList Service Interface
* @ClassName PayTicketSaleListService.java
* @Description PayTicketSaleListService Class 
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

public interface PayTicketSaleListService
{
	/**
	 * 지불수단별 식권판매현황을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	RecordSet selectList(Map<String, Object> parameter) throws Exception;
}
