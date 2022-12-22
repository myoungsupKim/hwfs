package com.hwfs.rc.sle.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * OutletDscnListDAO에 대한 설명 작성
 * @ClassName OutletDscnListDAO.java
 * @Description OutletDscnListDAO Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 5. 20.   박대영        최초생성
 * </pre>
 * @author FC종합전산구축 :외식영업(POS영업관리)
 * @since 2015. 5. 20.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/rc/sle/outletDscnListDAO")
public class OutletDscnListDAO extends DefaultDAO {
	
	public RecordSet selectList(Map<String, Object> parameter) {	 
		return super.queryForRecordSet("rc.sle.outletDscnListDAO.selectList", parameter);
	}
	public RecordSet selectDayList(Map<String, Object> parameter) {	 
		return super.queryForRecordSet("rc.sle.outletDscnListDAO.selectDayList", parameter);
	}
	//2017.03.13 DC상세내역 추가(현대카드 M포인트 추가 후 수정) 김호석 CH201702_00668
	public RecordSet dcSalesList(Map<String, Object> parameter) {	 
		return super.queryForRecordSet("rc.sle.outletDscnListDAO.dcSalesList", parameter);
	}	
	public RecordSet selectDcSumList(Map<String, Object> parameter) {	 
		return super.queryForRecordSet("rc.sle.outletDscnListDAO.selectDcSumList", parameter);
	}
}
