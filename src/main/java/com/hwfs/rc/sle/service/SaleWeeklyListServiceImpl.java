package com.hwfs.rc.sle.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.rc.sle.dao.SaleWeeklyListDAO;

 /**
 * SaleWeeklyListServiceImpl에 대한 설명 작성
 * @ClassName SaleWeeklyListServiceImpl.java
 * @Description SaleWeeklyListServiceImpl Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 8. 21.   박대영        최초생성
 * </pre>
 * @author FC종합전산구축 : 외식영업(POS영업관리)
 * @since 2015. 8. 21.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/rc/sle/saleWeeklyService")
public class SaleWeeklyListServiceImpl extends DefaultServiceImpl implements SaleWeeklyListService {
	@Resource(name="/rc/sle/saleWeeklyDAO")
	private SaleWeeklyListDAO saleWeekly;
	
	/**
	 * selectList 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.rc.sle.service.SaleWeeklyListService#selectList(java.util.Map)
	 */
	@Override
	public RecordSet selectList(Map<String, Object> parameter) throws Exception {
		return saleWeekly.selectList(parameter);
	}
	
}
