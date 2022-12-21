package com.hwfs.rc.sle.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * SaleWeeklyListDAO에 대한 설명 작성
 * @ClassName SaleWeeklyListDAO.java
 * @Description SaleWeeklyListDAO Class 
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
@Repository("/rc/sle/outletSalesDAO")
public class OutletSalesDAO extends DefaultDAO {
	
	/**
	 * selectSalesInqList 기능 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectSalesInqList(Map<String, Object> parameter) {	 
		return super.queryForRecordSet("rc.sle.outletSalesDAO.selectSalesInqList", parameter);
	}
	
	public RecordSet selectSalesApprList(Map<String, Object> parameter) {	 
		return super.queryForRecordSet("rc.sle.outletSalesDAO.selectSalesApprList", parameter);
	}
	public RecordSet selectYn(Map<String, Object> parameter) {	 
		return super.queryForRecordSet("rc.sle.outletSalesDAO.selectYn", parameter);
	}
	public int insertData(Map<String, Object> parameter) {
		//if (parameter.size() <= 0) return 0;
		return super.update("rc.sle.outletSalesDAO.insertData", parameter);
	}
	public int updateData1(Map<String, Object> parameter) {
		//if (parameter.size() <= 0) return 0;
		return super.update("rc.sle.outletSalesDAO.updateData1", parameter);
	}
	public int updateData2(Map<String, Object> parameter) {
		//if (parameter.size() <= 0) return 0;
		return super.update("rc.sle.outletSalesDAO.updateData2", parameter);
	}
	public int updateData3(Map<String, Object> parameter) {
		//if (parameter.size() <= 0) return 0;
		return super.update("rc.sle.outletSalesDAO.updateData3", parameter);
	}
}
