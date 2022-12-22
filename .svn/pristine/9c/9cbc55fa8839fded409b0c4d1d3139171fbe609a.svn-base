package com.hwfs.sc.scu.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 사용자 변경을하는 UserChange DAO
 * 
 * @ClassName UserChangeDAO.java
 * @Description UserChangeDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.08.19   	김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.08.19
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sc/scu/userChangeDAO")
public class UserChangeDAO extends DefaultDAO {
	
	/**
	 * 사용자 변경 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.scu.userChangeDAO.selectList", mapParam);
	}
	
	public int upadteAcctStatus(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scu.userChangeDAO.upadteAcctStatus", mapParam);
	}
	
	public int upadtePassword(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scu.userChangeDAO.upadtePassword", mapParam);
	}
	
	public int insertUserChngLog(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scu.userChangeDAO.insertUserChngLog", mapParam);
	}
	
}
