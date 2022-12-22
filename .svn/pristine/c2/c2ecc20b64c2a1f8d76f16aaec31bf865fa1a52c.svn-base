package com.hwfs.rc.bms.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.rc.bms.dao.FncDiaryListDAO;

 /**
 * FncDiaryListServiceImpl에 대한 설명 작성
 * @ClassName FncDiaryListServiceImpl.java
 * @Description FncDiaryListServiceImpl Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 7. 28.   박대영        최초생성
 * </pre>
 * @author FC종합전산구축 : 연회웨딩
 * @since 2015. 7. 28.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/rc/bms/fncDiaryListService")
public class FncDiaryListServiceImpl extends DefaultServiceImpl implements FncDiaryListService {
	@Resource(name="/rc/bms/fncDiaryListDAO")
	private FncDiaryListDAO fncDiaryList;
	/**
	 * selectList 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.rc.bms.service.FncDiaryListService#selectList(java.util.Map)
	 */
	@Override
	public RecordSet selectList(Map<String, Object> parameter) throws Exception {
		
		RecordSet rs = fncDiaryList.selectMonthStartEndDay(parameter);
		

		parameter.put("dateFr", rs.get(0).get("monStartDt"));
		parameter.put("dateTo", rs.get(0).get("monEndDt"));
		
		return fncDiaryList.selectList(parameter);
	}

	 
}
