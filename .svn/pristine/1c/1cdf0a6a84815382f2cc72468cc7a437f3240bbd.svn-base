package com.hwfs.sc.scu.dao;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

/**
 * 사용자를 관리하는 UserMngt DAO
 *
 * @ClassName UserMngtDAO.java
 * @Description UserMngtDAO Class
 * @Modification-Information <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.27   	김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.03.27
 * @version 1.0
 * @see <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sc/scu/userMngtDAO")
public class UserMngtDAO extends DefaultDAO {

	/**
	 * 선택된 사용자가 존재하는지를 검색한다.
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public RecordSet selectExistsUser(Map<String, Object> mapParam)
			throws Exception {
		return super.queryForRecordSet(
				"sc.scu.userMngtDAO.selectExistsUser", mapParam);
	}

	/**
	 * 사용자 권한레벨정보 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectAuthLevelList(Map<String, Object> mapParam)
			throws Exception {
		return super.queryForRecordSet(
				"sc.scu.userMngtDAO.selectAuthLevelList", mapParam);
	}

	/**
	 * 사용자 정보을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public Record select(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecord("sc.scu.userMngtDAO.select", mapParam);
	}

	/**
	 * 사용자 정보(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scu.userMngtDAO.insert", mapParam);
	}

	/**
	 * 사용자 정보(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scu.userMngtDAO.update", mapParam);
	}

	/**
	 * 사용자 정보(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scu.userMngtDAO.delete", mapParam);
	}

	/**
	 * 사용자 권한레벨 정보(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertAuthLevel(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scu.userMngtDAO.insertAuthLevel", mapParam);
	}

	/**
	 * 사용자 권한레벨 정보(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteAuthLevel(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scu.userMngtDAO.deleteAuthLevel", mapParam);
	}

	/**
	 * 미등록된 사용자권한 정보를 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectUnUserAuth(Map<String, Object> mapParam)
			throws Exception {
		return super.queryForRecordSet("sc.scu.userMngtDAO.selectUnUserAuth",
				mapParam);
	}

	/**
	 * 등록된 사용자권한 정보를 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectUserAuth(Map<String, Object> mapParam)
			throws Exception {
		return super.queryForRecordSet("sc.scu.userMngtDAO.selectUserAuth",
				mapParam);
	}

	/**
	 * 사용자 권한정보(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertUserAuth(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scu.userMngtDAO.insertUserAuth", mapParam);
	}

	/**
	 * 사용자 권한정보(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateUserAuth(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scu.userMngtDAO.updateUserAuth", mapParam);
	}

	/**
	 * 사용자 권한정보(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteUserAuth(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scu.userMngtDAO.deleteUserAuth", mapParam);
	}

	/**
	 * 사용자 예외권한 정보를 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectExptAuthList(Map<String, Object> mapParam)
			throws Exception {
		return super.queryForRecordSet("sc.scu.userMngtDAO.selectExptAuthList",
				mapParam);
	}

	/**
	 * 사용자 권한정보(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertExptAuth(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scu.userMngtDAO.insertExptAuth", mapParam);
	}

	/**
	 * 사용자 권한정보(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateExptAuth(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scu.userMngtDAO.updateExptAuth", mapParam);
	}

	/**
	 * 사용자 권한정보(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteExptAuth(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scu.userMngtDAO.deleteExptAuth", mapParam);
	}

	/**
	 * 미등록 게시판 권한 정보를 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectUnBbsAuthList(Map<String, Object> mapParam)
			throws Exception {
		return super.queryForRecordSet(
				"sc.scu.userMngtDAO.selectUnBbsAuthList", mapParam);
	}

	/**
	 * 등록 게시판 권한 정보를 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectBbsAuthList(Map<String, Object> mapParam)
			throws Exception {
		return super.queryForRecordSet("sc.scu.userMngtDAO.selectBbsAuthList",
				mapParam);
	}

	/**
	 * 사용자 권한정보(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertBbsAuth(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scu.userMngtDAO.insertBbsAuth", mapParam);
	}

	/**
	 * 사용자 권한정보(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateBbsAuth(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scu.userMngtDAO.updateBbsAuth", mapParam);
	}

	/**
	 * 사용자 권한정보(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteBbsAuth(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scu.userMngtDAO.deleteBbsAuth", mapParam);
	}

	/**
	 * 복수업장 정보를 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectDualUpjang(Map<String, Object> mapParam)
			throws Exception {
		return super.queryForRecordSet("sc.scu.userMngtDAO.selectDualUpjang",
				mapParam);
	}

	/**
	 * 복수업장 정보를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertDualUpjang(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scu.userMngtDAO.insertDualUpjang", mapParam);
	}

	/**
	 * 복수업장 정보를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateDualUpjang(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scu.userMngtDAO.updateDualUpjang", mapParam);
	}

	/**
	 * 복수업장 정보를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteDualUpjang(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scu.userMngtDAO.deleteDualUpjang", mapParam);
	}

	public int updateUnLock(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scu.userMngtDAO.updateUnLock", mapParam);
	}

	public int updatePwd(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scu.userMngtDAO.updatePwd", mapParam);
	}

	public RecordSet selectLoginHistory(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.scu.userMngtDAO.selectLoginHistory", mapParam);
	}
	
	public RecordSet selectRandom(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.scu.userMngtDAO.selectRandom", mapParam);
	}

	public RecordSet selectHistory(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.scu.userMngtDAO.selectHistory", mapParam);
	}

}
