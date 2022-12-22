package com.hwfs.sc.scu.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 사용자 인터페이스 로그를 조회하는 UserInterfaceLog DAO
 * 
 * @ClassName UserInterfaceLogDAO.java
 * @Description UserInterfaceLogDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.08.07   	김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.08.07
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sc/scu/userInterfaceLogDAO")
public class UserInterfaceLogDAO extends DefaultDAO {
	
	/**
	 * 사용자 인테페이스 로그 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.scu.userInterfaceLogDAO.selectList", mapParam);
	}

	/**
	 * 사용자 인테페이스 로그(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scu.userInterfaceLogDAO.insert", mapParam);
	}
	
	/**
	 * 사용자 인테페이스 로그(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scu.userInterfaceLogDAO.update", mapParam);
	}
	
	/**
	 * 사용자 인테페이스 로그(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scu.userInterfaceLogDAO.delete", mapParam);
	}
	
}
