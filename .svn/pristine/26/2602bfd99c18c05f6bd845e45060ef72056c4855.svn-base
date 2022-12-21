package com.hwfs.rc.sle.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * OutletDailySalesDAO에 대한 설명 작성
 * @ClassName OutletDailySalesDAO.java
 * @Description OutletDailySalesDAO Class 
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
@Repository("/rc/sle/outletDailySalesDAO")
public class OutletDailySalesDAO extends DefaultDAO {
	
	/**
	 * selectSalesInqList 기능 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	
	//자료삭제
	public int dailyDelete(Map<String, Object> parameter) {	 
		return super.update("rc.sle.outletDailySalesDAO.dailyDelete", parameter); 	
	}
	//기본집계
	public int dailyInsert(Map<String, Object> parameter) {	 
		return super.update("rc.sle.outletDailySalesDAO.dailyInsert", parameter); 	
	}
	//종사업장 하나로 묶기
	public int dailyHap(Map<String, Object> parameter) {	 
		return super.update("rc.sle.outletDailySalesDAO.dailyHap", parameter); 	
	}
	//묶은사업장 삭제 
	public int dailyHapDelete(Map<String, Object> parameter) {	 
		return super.update("rc.sle.outletDailySalesDAO.dailyHapDelete", parameter); 	
	}
	//
	public int dailyGroup(Map<String, Object> parameter) {	 
		return super.update("rc.sle.outletDailySalesDAO.dailyGroup", parameter); 	
	}
	//사업구분별 합계dailySum
	public int dailySum(Map<String, Object> parameter) {	 
		return super.update("rc.sle.outletDailySalesDAO.dailySum", parameter); 	
	}
	//전체 합계
	public int dailyTotal(Map<String, Object> parameter) {	 
		return super.update("rc.sle.outletDailySalesDAO.dailyTotal", parameter); 	
	}
	//검색
	public RecordSet selectList(Map<String, Object> parameter) {	 
		return super.queryForRecordSet("rc.sle.outletDailySalesDAO.selectList", parameter);
	}
	
//	public List selectList(Map<String, Object> parameter) {	 
//		//return super.queryForRecordSet("rc.sle.outletDailySalesDAO.selectList", parameter);
//        SimpleJdbcCall scrapDeliveryInterfaceCall = new SimpleJdbcCall(getDataSource()).withSchemaName("FCUS").withProcedureName("SLE_DAILY_REPORT_PRO");
//		MapSqlParameterSource params = new MapSqlParameterSource();
//		params.addValue("V_DATE",   parameter.get("searchDt"));
//
//		Map<String, Object> out = scrapDeliveryInterfaceCall.execute(params);
//
//	    return (List) out.get("V_RET_CURSOR");
//
//	}
	
}
