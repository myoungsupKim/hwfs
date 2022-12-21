package com.hwfs.rc.sle.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.rc.sle.dao.OutletDailySalesDAO;

 /**
 * OutletDailySalesServiceImpl에 대한 설명 작성
 * @ClassName OutletDailySalesServiceImpl.java
 * @Description OutletDailySalesServiceImpl Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 8. 25.   박대영        최초생성
 * </pre>
 * @author FC종합전산구축 : 외식영업(POS영업관리)
 * @since 2015. 8. 25.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/rc/sle/outletDailySalesService")
public class OutletDailySalesServiceImpl extends DefaultServiceImpl implements OutletDailySalesService {
	@Resource(name="/rc/sle/outletDailySalesDAO")
	private OutletDailySalesDAO outletDailySales;
	
	/**
	 * selectSalesInqList 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.rc.sle.service.OutletSalesService#selectSalesInqList(java.util.Map)
	 */
	@Override
	public RecordSet selectList(Map<String, Object> parameter) throws Exception {
		int groupProcCnt = 0;
		
		groupProcCnt += outletDailySales.dailyDelete(parameter);
		groupProcCnt += outletDailySales.dailyInsert(parameter);
		groupProcCnt += outletDailySales.dailyHap(parameter);
		groupProcCnt += outletDailySales.dailyHapDelete(parameter);
		groupProcCnt += outletDailySales.dailyGroup(parameter);
		groupProcCnt += outletDailySales.dailySum(parameter);
		groupProcCnt += outletDailySales.dailyTotal(parameter);
		
		
		   
		return outletDailySales.selectList(parameter);
	}
	
}
