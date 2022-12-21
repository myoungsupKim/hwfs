package com.hwfs.sc.scp.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 개인정보처리등급을 관리하는 PersProcGradeMgmt DAO
 * 
 * @ClassName PersProcGradeMgmtDAO.java
 * @Description PersProcGradeMgmtDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.14   	kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015.05.14
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sc/scp/persProcGradeMgmtDAO")
public class PersProcGradeMgmtDAO extends DefaultDAO {
	
	/**
	 * 개인정보처리등급 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.scp.persProcGradeMgmtDAO.selectList", mapParam);
	}

	/**
	 * 개인정보처리등급(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scp.persProcGradeMgmtDAO.insert", mapParam);
	}
	
	/**
	 * 개인정보처리등급(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scp.persProcGradeMgmtDAO.update", mapParam);
	}
	
	/**
	 * 개인정보처리등급(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scp.persProcGradeMgmtDAO.delete", mapParam);
	}
	
}
