package com.hwfs.rc.sle.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * PaySalesListDAO에 대한 설명 작성
 * @ClassName PaySalesListDAO.java
 * @Description PaySalesListDAO Class 
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
@Repository("/rc/sle/paySalesListDAO")
public class PaySalesListDAO extends DefaultDAO {
	
	public RecordSet selectList(Map<String, Object> parameter) {	 
		return super.queryForRecordSet("rc.sle.paySalesListDAO.selectList", parameter);
	}

	public RecordSet selectListDetail(Map<String, Object> parameter) {	 
		return super.queryForRecordSet("rc.sle.paySalesListDAO.selectListDetail", parameter);
	}
}
