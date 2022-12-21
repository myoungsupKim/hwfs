package com.hwfs.ft.fsi.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 계정관리하는 AcctMgmt DAO
 * 
 * @ClassName AcctMgmtDAO.java
 * @Description AcctMgmtDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.18   	김종준        최초생성
 * </pre>
 * @author FC종합전산구축 : 식재도매 김종준
 * @since 2015.03.18
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/ft/fsi/acctMgmtDAO")
public class AcctMgmtDAO extends DefaultDAO {
	
	/**
	 * 계정관리 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("ft.fsi.acctMgmtDAO.selectList", mapParam);
	}

	/**
	 * 계정관리(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("ft.fsi.acctMgmtDAO.insert", mapParam);
	}
	
	/**
	 * 계정관리(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("ft.fsi.acctMgmtDAO.update", mapParam);
	}
	
	/**
	 * 계정관리(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("ft.fsi.acctMgmtDAO.delete", mapParam);
	}
	
}
