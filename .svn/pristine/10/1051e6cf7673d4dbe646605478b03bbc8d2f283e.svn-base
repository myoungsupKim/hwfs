package com.hwfs.sc.sca.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

/**
 * 권한을 부여하는 AuthMappingMgmt DAO
 *
 * @ClassName AuthMappingMgmtDAO.java
 * @Description AuthMappingMgmtDAO Class
 * @Modification-Information <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.17   	김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.03.17
 * @version 1.0
 * @see <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sc/sca/authMappingMgmtDAO")
public class AuthMappingMgmtDAO extends DefaultDAO {

	/**
	 * 권한 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectAuthList(Map<String, Object> mapParam)
			throws Exception {
		return super.queryForRecordSet(
				"sc.sca.authMappingMgmtDAO.selectAuthList", mapParam);
	}

	/**
	 * 권한별 부서에서 미등록 CC목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectAuthDeptUnCcMapList(Map<String, Object> mapParam)
			throws Exception {
		return super
				.queryForRecordSet(
						"sc.sca.authMappingMgmtDAO.selectAuthDeptUnCcMapList",
						mapParam);
	}

	/**
	 * 권한별 부서에서 등록 CC목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectAuthDeptCcMapList(Map<String, Object> mapParam)
			throws Exception {
		return super.queryForRecordSet(
				"sc.sca.authMappingMgmtDAO.selectAuthDeptCcMapList", mapParam);
	}

	/**
	 * CC목록을 조회한다.(CC별 권한관리)
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectDeptAuthCcList(Map<String, Object> mapParam)
			throws Exception {
		return super.queryForRecordSet(
				"sc.sca.authMappingMgmtDAO.selectDeptAuthCcList", mapParam);
	}

	/**
	 * 미등록 권한목록을 조회한다.(CC별 권한관리)
	 *
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public RecordSet selectDeptAuthUnAuthMapList(Map<String, Object> mapParam)
			throws Exception {
		return super.queryForRecordSet(
				"sc.sca.authMappingMgmtDAO.selectDeptAuthUnAuthMapList",
				mapParam);
	}

	/**
	 * 등록된 권한목록을 조회한다.(CC별 권한관리)
	 *
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public RecordSet selectDeptAuthAuthMapList(Map<String, Object> mapParam)
			throws Exception {
		return super
				.queryForRecordSet(
						"sc.sca.authMappingMgmtDAO.selectDeptAuthAuthMapList",
						mapParam);
	}

	/**
	 * 권한 부여(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertDeptRole(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.sca.authMappingMgmtDAO.insertDeptRole",
				mapParam);
	}

	/**
	 * 권한 부여(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateDeptRole(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.sca.authMappingMgmtDAO.updateDeptRole",
				mapParam);
	}

	/**
	 * 권한 부여(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteDeptRole(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.sca.authMappingMgmtDAO.deleteDeptRole",
				mapParam);
	}

	/**
	 * 권한별 사용자군에서 미등록 사용자군목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectAuthCustUnCustMapList(Map<String, Object> mapParam)
			throws Exception {
		return super.queryForRecordSet(
				"sc.sca.authMappingMgmtDAO.selectAuthCustUnCustMapList",
				mapParam);
	}

	/**
	 * 권한별 사용자군에서 등록 사용자군목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectAuthCustCustMapList(Map<String, Object> mapParam)
			throws Exception {
		return super
				.queryForRecordSet(
						"sc.sca.authMappingMgmtDAO.selectAuthCustCustMapList",
						mapParam);
	}

	/**
	 * 권한 부여(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertUserGroupRole(Map<String, Object> mapParam)
			throws Exception {
		return super.update("sc.sca.authMappingMgmtDAO.insertUserGroupRole",
				mapParam);
	}

	/**
	 * 권한 부여(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateUserGroupRole(Map<String, Object> mapParam)
			throws Exception {
		return super.update("sc.sca.authMappingMgmtDAO.updateUserGroupRole",
				mapParam);
	}

	/**
	 * 권한 부여(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteUserGroupRole(Map<String, Object> mapParam)
			throws Exception {
		return super.update("sc.sca.authMappingMgmtDAO.deleteUserGroupRole",
				mapParam);
	}

	/**
	 * 권한별 사용자군에서 등록 사용자군목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectCustAuthUserGroupList(Map<String, Object> mapParam)
			throws Exception {
		return super.queryForRecordSet(
				"sc.sca.authMappingMgmtDAO.selectCustAuthUserGroupList",
				mapParam);
	}

	/**
	 * 미등록 권한목록을 조회한다.(사용자군별 권한관리)
	 *
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public RecordSet selectCustAuthUnAuthMapList(Map<String, Object> mapParam)
			throws Exception {
		return super.queryForRecordSet(
				"sc.sca.authMappingMgmtDAO.selectCustAuthUnAuthMapList",
				mapParam);
	}

	/**
	 * 등록된 권한목록을 조회한다.(사용자군별 권한관리)
	 *
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public RecordSet selectCustAuthAuthMapList(Map<String, Object> mapParam)
			throws Exception {
		return super
				.queryForRecordSet(
						"sc.sca.authMappingMgmtDAO.selectCustAuthAuthMapList",
						mapParam);
	}

}
