package com.hwfs.rc.bms.dao;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * BasOrderplceMgmtDAO에 대한 설명 작성
 * @ClassName BasOrderplceMgmtDAO.java
 * @Description BasOrderplceMgmtDAO Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 2. 24.   박대영        최초생성
 * </pre>
 * @author FC종합전산구축 : 연회웨딩
 * @since 2015. 2. 24.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/rc/bms/basOrderplceMgmtDAO")
public class BasOrderplceMgmtDAO extends DefaultDAO {

	/**
	 * selectOrderplceList 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @see com.hwfs.rc.bms.service.BasOrderplceMgmtService#selectOrderplceList(java.util.Map)
	 */
 
	public RecordSet selectOrderplceList(Map<String, Object> parameter) {
	 
		return super.queryForRecordSet("rc.bms.basOrderplceMgmtDAO.selectOrderplceList", parameter);
	}
	
	public RecordSet selectOrderplceListMask(Map<String, Object> parameter) {
		 
		return super.queryForRecordSet("rc.bms.basOrderplceMgmtDAO.selectOrderplceListMask", parameter);
	}

	/**
	 * insertOrderplceMgmt 기능 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter : 쿼리문으로 전달되는 Parameter
	 * @return
	 */
	public int insertOrderplceMgmt(Map<String, Object> parameter) {
		//if (parameter.size() <= 0) return 0;
		return super.update("rc.bms.basOrderplceMgmtDAO.insertOrderplceMgmt", parameter);
	}
	
	/**
	 * updateOrderplceMgmt  수정한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public int updateOrderplceMgmt(Map<String, Object> parameter) {
		//if (parameter.size() <= 0) return 0;
		return super.update("rc.bms.basOrderplceMgmtDAO.updateOrderplceMgmt", parameter);
	}
	
	
	public Record maxOrderplceCodeCreate(Map<String, Object> parameter) {
		return super.queryForRecord("rc.bms.basOrderplceMgmtDAO.maxOrderplceCodeCreate",parameter);
	}
}
