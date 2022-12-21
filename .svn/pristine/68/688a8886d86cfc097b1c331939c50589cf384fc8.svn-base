package com.hwfs.rc.sle.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.rc.sle.dao.PayTicketSaleListDAO;

/**
* 지불수단별 식권판매현황 조회하는 PayTicketSaleList Service Implementation
* @ClassName PayTicketSaleListServiceImpl.java
* @Description PayTicketSaleListServiceImpl Class 
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

@Service("/rc/sle/payTicketSaleListService")
public class PayTicketSaleListServiceImpl extends DefaultServiceImpl implements PayTicketSaleListService
{
	/** PayTicketSaleListDAO Bean 생성 */
	@Resource(name="/rc/sle/payTicketSaleListDAO")
	private PayTicketSaleListDAO payTicketSaleListDAO;

	/**
	 * 지불수단별 식권판매현황을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	@Override
	public RecordSet selectList(Map<String, Object> parameter) throws Exception
	{
		return payTicketSaleListDAO.selectList(parameter);
	}
}
