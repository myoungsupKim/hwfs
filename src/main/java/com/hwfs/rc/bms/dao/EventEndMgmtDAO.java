package com.hwfs.rc.bms.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * EventEndMgmtDAO에 대한 설명 작성
 * @ClassName EventEndMgmtDAO.java
 * @Description EventEndMgmtDAO Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 7. 21.   박대영        최초생성
 * </pre>
 * @author FC종합전산구축 : 연회웨딩
 * @since 2015. 7. 21.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/rc/bms/eventEndMgmtDAO")
public class EventEndMgmtDAO extends DefaultDAO {
	public RecordSet selectList(Map<String, Object> parameter) {
		return super.queryForRecordSet("rc.bms.eventEndMgmtDAO.selectList", parameter);
	}
	public RecordSet selectListMst(Map<String, Object> parameter) {
		return super.queryForRecordSet("rc.bms.eventEndMgmtDAO.selectListMst", parameter);
	}
	public RecordSet selectListEndEvent(Map<String, Object> parameter) {
		return super.queryForRecordSet("rc.bms.eventEndMgmtDAO.selectListEndEvent", parameter);
	}
	public int updateDataMst(Map<String, Object> parameter) {
		return super.update("rc.bms.eventEndMgmtDAO.updateDataMst", parameter);
	}
	public int updateDataResStatus(Map<String, Object> parameter) {
		return super.update("rc.bms.eventEndMgmtDAO.updateDataResStatus", parameter);
	}
	
}
