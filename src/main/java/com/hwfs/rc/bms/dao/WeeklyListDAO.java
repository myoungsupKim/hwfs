package com.hwfs.rc.bms.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * WeeklyListDAO에 대한 설명 작성
 * @ClassName WeeklyListDAO.java
 * @Description WeeklyListDAO Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 7. 27.   박대영        최초생성
 * </pre>
 * @author FC종합전산구축 : 연회웨딩
 * @since 2015. 7. 27.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/rc/bms/weeklyListDAO")
public class WeeklyListDAO extends DefaultDAO {
	
	public RecordSet selectList(Map<String, Object> parameter) {
		return super.queryForRecordSet("rc.bms.weeklyListDAO.selectList", parameter);
	}
	public RecordSet selectDtList(Map<String, Object> parameter) {
		return super.queryForRecordSet("rc.bms.weeklyListDAO.selectDtList", parameter);
	}
	
}
