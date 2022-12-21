package com.hwfs.sc.sca.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

/**
 * 권한별 메뉴를 관리하는 AuthByMenuMgmt DAO
 *
 * @ClassName AuthByMenuMgmtDAO.java
 * @Description AuthByMenuMgmtDAO Class
 * @Modification-Information <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.16   	김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.03.16
 * @version 1.0
 * @see <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sc/sca/authByMenuMgmtDAO")
public class AuthByMenuMgmtDAO extends DefaultDAO {

	/**
	 * 특정 시스템에서 사용하는 권한 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectRoleList(Map<String, Object> mapParam)
			throws Exception {
		return super.queryForRecordSet(
				"sc.sca.authByMenuMgmtDAO.selectRoleList", mapParam);
	}

	/**
	 * 권한별 메뉴 목록(미등록)을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectMenuList(Map<String, Object> mapParam)
			throws Exception {
		return super.queryForRecordSet(
				"sc.sca.authByMenuMgmtDAO.selectMenuList", mapParam);
	}

	/**
	 * 권한별 메뉴 목록(등록)을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectRoleMenuList(Map<String, Object> mapParam)
			throws Exception {
		return super.queryForRecordSet(
				"sc.sca.authByMenuMgmtDAO.selectRoleMenuList", mapParam);
	}

	/**
	 * 권한별 메뉴(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.sca.authByMenuMgmtDAO.insert", mapParam);
	}

	/**
	 * 권한별 메뉴(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.sca.authByMenuMgmtDAO.update", mapParam);
	}

	/**
	 * 권한별 메뉴(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.sca.authByMenuMgmtDAO.delete", mapParam);
	}

	/**
	 * 기 등록된 메뉴를 가져온다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectGetMenuList(Map<String, Object> mapParam)
			throws Exception {
		return super.queryForRecordSet(
				"sc.sca.authByMenuMgmtDAO.selectGetMenuList", mapParam);
	}
}
