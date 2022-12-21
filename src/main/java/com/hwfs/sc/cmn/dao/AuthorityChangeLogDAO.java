package com.hwfs.sc.cmn.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 권한의 변경 이력을 생성하는 AuthorityChangeLog DAO
 *
 * @ClassName AuthorityChangeLogDAO.java
 * @Description AuthorityChangeLogDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.18   	김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.05.18
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sc/cmn/authorityChangeLogDAO")
public class AuthorityChangeLogDAO extends DefaultDAO {

	/**
	 * 권한 변경 이력 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.cmn.authorityChangeLogDAO.selectList", mapParam);
	}

	/**
	 * 권한 변경 이력(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertChangeLog(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.cmn.authorityChangeLogDAO.insertChangeLog", mapParam);
	}

	/**
	 * 권한 변경 이력 사용자(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertUserChangeLog(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.cmn.authorityChangeLogDAO.insertUserChangeLog", mapParam);
	}

	/**
	 * 권한그룹 변경 이력(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertRoleChangeLog(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.cmn.authorityChangeLogDAO.insertRoleChangeLog", mapParam);
	}

	/**
	 * 권한그룹 메뉴 변경 이력(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertRoleMenuChangeLog(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.cmn.authorityChangeLogDAO.insertRoleMenuChangeLog", mapParam);
	}

	/**
	 * 부서별 권한그룹 변경 이력(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertDeptRoleChangeLog(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.cmn.authorityChangeLogDAO.insertDeptRoleChangeLog", mapParam);
	}

	/**
	 * 사용자군별 권한그룹 변경 이력(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertUserGroupRoleChangeLog(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.cmn.authorityChangeLogDAO.insertUserGroupRoleChangeLog", mapParam);
	}

	/**
	 * 사용자별 권한그룹 변경 이력(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertUserRoleChangeLog(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.cmn.authorityChangeLogDAO.insertUserRoleChangeLog", mapParam);
	}

	/**
	 * 사용자별 메뉴 변경 이력(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertUserMenuChangeLog(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.cmn.authorityChangeLogDAO.insertUserMenuChangeLog", mapParam);
	}
}
