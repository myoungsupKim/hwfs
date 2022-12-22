package com.hwfs.rc.bms.dao;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * BasCustMgmtDAO에 대한 설명 작성
 * @ClassName BasCustMgmtDAO.java
 * @Description BasCustMgmtDAO Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 2. 26.   Administrator        최초생성
 * </pre>
 * @author FC종합전산구축 : 팀명 Administrator
 * @since 2015. 2. 26.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/rc/bms/basCustMgmtDAO")
public class BasCustMgmtDAO extends DefaultDAO {
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
 
	public RecordSet selectCustList(Map<String, Object> parameter) {
	 
		return super.queryForRecordSet("rc.bms.basCustMgmtDAO.selectCustList", parameter);
	}
	
	public RecordSet selectCustListMask(Map<String, Object> parameter) {
		 
		return super.queryForRecordSet("rc.bms.basCustMgmtDAO.selectCustListMask", parameter);
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
	public int insertCustMgmt(Map<String, Object> parameter) {
		//if (parameter.size() <= 0) return 0;
		return super.update("rc.bms.basCustMgmtDAO.insertCustMgmt", parameter);
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
	public int updateCustMgmt(Map<String, Object> parameter) {
		//if (parameter.size() <= 0) return 0;
		return super.update("rc.bms.basCustMgmtDAO.updateCustMgmt", parameter);
	}
	
	
	public Record maxCustCodeCreate(Map<String, Object> parameter) {
		return super.queryForRecord("rc.bms.basCustMgmtDAO.maxCustCodeCreate",parameter);
	}
}
