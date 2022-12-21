package com.hwfs.ms.mmb.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 로그인관리자 디바이스 정보 갱신하는 LoginSessionUpdate DAO
 * 
 * @ClassName LoginSessionUpdateDAO.java
 * @Description LoginSessionUpdateDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.07   	강대성        최초생성
 * </pre>
 * @author FC종합전산구축 : 모바일 강대성
 * @since 2015.04.07
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/ms/mmb/loginSessionUpdateDAO")
public class LoginSessionUpdateDAO extends DefaultDAO {
	
	/**
	 * 로그인관리자 디바이스 정보 갱신 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("ms.mmb.loginSessionUpdateDAO.selectSettingList", mapParam);
	}
	
	/**
	 * 기존 유저디바이스 등록 여부 확인
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return 건수
	 * @exception Exception
	 */
	public int selectAppCnt(Map<String, Object> mapParam) throws Exception {
		return super.queryForInt("ms.mmb.loginSessionUpdateDAO.selectAppCnt", mapParam);
	}

	/**
	 * 로그인관리자 디바이스 정보 갱신(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("ms.mmb.loginSessionUpdateDAO.insert", mapParam);
	}
	
	/**
	 * 로그인관리자 디바이스 정보 갱신(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("ms.mmb.loginSessionUpdateDAO.update", mapParam);
	}
	
	/**
	 * 로그인관리자 디바이스 정보 갱신(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("ms.mmb.loginSessionUpdateDAO.delete", mapParam);
	}
	
	/**
	 * 로그인관리자 디바이스 정보 갱신(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateSetting(Map<String, Object> mapParam) throws Exception {
		return super.update("ms.mmb.loginSessionUpdateDAO.updateSetting", mapParam);
	}
	
	
}
