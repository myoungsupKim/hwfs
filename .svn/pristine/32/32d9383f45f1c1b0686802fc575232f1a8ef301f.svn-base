package com.hwfs.rc.sle.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * MonMenuSalesListDAO에 대한 설명 작성
 * @ClassName MonMenuSalesListDAO.java
 * @Description MonMenuSalesListDAO Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 5. 15.   박대영        최초생성
 * </pre>
 * @author FC종합전산구축 :외식영업(POS영업관리)
 * @since 2015. 5. 15.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/rc/sle/monMenuSalesListDAO")
public class MonMenuSalesListDAO extends DefaultDAO {
	
	public RecordSet selectList(Map<String, Object> parameter) {	 
		return super.queryForRecordSet("rc.sle.monMenuSalesListDAO.selectList", parameter);
	}
	public RecordSet selectDayList(Map<String, Object> parameter) {	 
		return super.queryForRecordSet("rc.sle.monMenuSalesListDAO.selectDayList", parameter);
	}
}
