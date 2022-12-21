package com.hwfs.sc.sca.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

/**
 * 메뉴별 권한정보를 조회하는 AuthByMenuRetv DAO
 *
 * @ClassName AuthByMenuRetvDAO.java
 * @Description AuthByMenuRetvDAO Class
 * @Modification-Information <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.31   	김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.03.31
 * @version 1.0
 * @see <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sc/sca/authByMenuRetvDAO")
public class AuthByMenuRetvDAO extends DefaultDAO {

	/**
	 * 메뉴별 권한정보 메뉴목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectMenuList(Map<String, Object> mapParam)
			throws Exception {
		return super.queryForRecordSet(
				"sc.sca.authByMenuRetvDAO.selectMenuList", mapParam);
	}

	/**
	 * 메뉴별 권한정보 권한목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectRoleList(Map<String, Object> mapParam)
			throws Exception {
		return super.queryForRecordSet(
				"sc.sca.authByMenuRetvDAO.selectRoleList", mapParam);
	}

	/**
	 * 메뉴별 권한정보 사용자목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectUserList(Map<String, Object> mapParam)
			throws Exception {
		return super.queryForRecordSet(
				"sc.sca.authByMenuRetvDAO.selectUserList", mapParam);
	}
}
