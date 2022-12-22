package com.hwfs.sc.scc.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 운영로그 대상 사용자를 등록관리하는 OpLogUserMgmt DAO
 * 
 * @ClassName OpLogUserMgmtDAO.java
 * @Description OpLogUserMgmtDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.13   	kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015.05.13
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sc/scc/opLogUserMgmtDAO")
public class OpLogUserMgmtDAO extends DefaultDAO {
	
	/**
	 * 운영로그 대상 사용자 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.scc.opLogUserMgmtDAO.selectList", mapParam);
	}

	/**
	 * 운영로그 대상 사용자(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scc.opLogUserMgmtDAO.insert", mapParam);
	}
	
	/**
	 * 운영로그 대상 사용자(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scc.opLogUserMgmtDAO.delete", mapParam);
	}
	
}
