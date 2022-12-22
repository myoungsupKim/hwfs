package com.hwfs.rc.bms.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * BasOutletRptDAO에 대한 설명 작성
 * @ClassName BasOutletRptDAO.java
 * @Description BasOutletRptDAO Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 7. 31.   박대영        최초생성
 * </pre>
 * @author FC종합전산구축 : 연회웨딩
 * @since 2015. 7. 31.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/rc/bms/basOutletRptDAO")
public class BasOutletRptDAO extends DefaultDAO {
	
	public RecordSet selectList(Map<String, Object> parameter) {
		 
		return super.queryForRecordSet("rc.bms.basOutletRptDAO.selectList", parameter);
	}
	
	 
	 
	public int insertData(Map<String, Object> parameter) {
		//if (parameter.size() <= 0) return 0;
		return super.update("rc.bms.basOutletRptDAO.insertData", parameter);
	}
	
	 
	public int updateData(Map<String, Object> parameter) {
		//if (parameter.size() <= 0) return 0;
		return super.update("rc.bms.basOutletRptDAO.updateData", parameter);
	}
	
	 
}
