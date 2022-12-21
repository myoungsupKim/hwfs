package com.hwfs.rc.bms.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * WeddingReportDAO에 대한 설명 작성
 * @ClassName WeddingReportDAO.java
 * @Description WeddingReportDAO Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 8. 25.   박대영        최초생성
 * </pre>
 * @author FC종합전산구축 : 연회웨딩
 * @since 2015. 8. 25.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/rc/bms/weddingReportDAO")
public class WeddingReportDAO extends DefaultDAO {

	public RecordSet selectList(Map<String, Object> parameter) {	 
		return super.queryForRecordSet("rc.bms.weddingReportDAO.selectList", parameter);
	}
		
	public int insertData(Map<String, Object> parameter) {
		//if (parameter.size() <= 0) return 0;
		return super.update("rc.bms.weddingReportDAO.insertData", parameter);
	}
	
	public int updateData(Map<String, Object> parameter) {
		//if (parameter.size() <= 0) return 0;
		return super.update("rc.bms.weddingReportDAO.updateData", parameter);
	}
}
