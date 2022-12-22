package com.hwfs.rc.bms.service;

import hone.core.util.record.RecordSet;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.rc.bms.dao.MonthlyListDAO;

 /**
 * MonthlyListServiceImpl에 대한 설명 작성
 * @ClassName MonthlyListServiceImpl.java
 * @Description MonthlyListServiceImpl Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 7. 27.   박대영        최초생성
 * </pre>
 * @author FC종합전산구축 : 연회웨딩
 * @since 2015. 7. 27.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/rc/bms/monthlyListService")
public class MonthlyListServiceImpl extends DefaultServiceImpl implements MonthlyListService {
	@Resource(name="/rc/bms/monthlyListDAO")
	private MonthlyListDAO monthlyList;
	/**
	 * selectList 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.rc.bms.service.MonthlyListService#selectList(java.util.Map)
	 */
	@Override
	public Map<String, RecordSet> selectList(Map<String, Object> parameter) throws Exception {
		
		Map<String, RecordSet> rtn = new HashMap<String, RecordSet>();

		RecordSet rs = monthlyList.selectMonthStartEndDay(parameter);
		rtn.put("ds_startWeekEndDay", rs);

		parameter.put("dateFr", rs.get(0).get("monStartDt"));
		parameter.put("dateTo", rs.get(0).get("monEndDt"));

		rtn.put("ds_dayData", monthlyList.selectList(parameter));

		return rtn;
	}

}
