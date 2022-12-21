package com.hwfs.sc.scc.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 무단사용자를 관리하는 NoPermissionUserMgmt DAO
 * 
 * @ClassName NoPermissionUserMgmtDAO.java
 * @Description NoPermissionUserMgmtDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.07.08   	kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015.07.08
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sc/scc/noPermissionUserMgmtDAO")
public class NoPermissionUserMgmtDAO extends DefaultDAO {
	
	/**
	 * 무단사용자 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.scc.noPermissionUserMgmtDAO.selectList", mapParam);
	}

	/**
	 * 무단사용자를 접속차단/해지하기 위해 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int saveNoPermissionUser(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scc.noPermissionUserMgmtDAO.saveNoPermissionUser", mapParam);
	}
	
	/**
	 * 무단사용자(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scc.noPermissionUserMgmtDAO.delete", mapParam);
	}
	
}
