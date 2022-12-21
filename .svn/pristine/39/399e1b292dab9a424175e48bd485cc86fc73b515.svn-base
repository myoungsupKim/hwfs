package com.hwfs.sc.scu.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 사용자ID 신청현황을 관리하는 UserIdReqList DAO
 *
 * @ClassName UserIdReqListDAO.java
 * @Description UserIdReqListDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.01   	김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.04.01
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sc/scu/userIdReqListDAO")
public class UserIdReqListDAO extends DefaultDAO {

	/**
	 * 사용자ID 신청현황 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.scu.userIdReqListDAO.selectList", mapParam);
	}

	/**
	 * 사용자권한목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectUserAuthList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.scu.userIdReqListDAO.selectUserAuthList", mapParam);
	}

	/**
	 * 사용자게시판권한목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectBoardAuthList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.scu.userIdReqListDAO.selectBoardAuthList", mapParam);
	}
	/**
	 * 사용자군 권한목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectUserGroupAuthList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.scu.userIdReqListDAO.selectUserGroupAuthList", mapParam);
	}

	/**
	 * 사용자권한을 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertUserAuth(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scu.userIdReqListDAO.insertUserAuth", mapParam);
	}

	/**
	 * 사용자정보를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateUserInfo(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scu.userIdReqListDAO.updateUserInfo", mapParam);
	}

	/**
	 * 사용자정보를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteAuthLevel(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scu.userIdReqListDAO.deleteAuthLevel", mapParam);
	}

	/**
	 * 사용자정보를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertAuthLevel(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scu.userIdReqListDAO.insertAuthLevel", mapParam);
	}

	/**
	 * 사용자정보를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateStopUserInfo(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scu.userIdReqListDAO.updateStopUserInfo", mapParam);
	}

	/**
	 * 사용자ID 신청현황(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scu.userIdReqListDAO.update", mapParam);
	}

	/**
	 * 사용자정보를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateReturn(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scu.userIdReqListDAO.updateReturn", mapParam);
	}

	/**
	 * 사용자정보를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateReturnUserInfo(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scu.userIdReqListDAO.updateReturnUserInfo", mapParam);
	}

	/**
	 * 사용자 권한을 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteUserAuth(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scu.userIdReqListDAO.deleteUserAuth", mapParam);
	}

	/**
	 * 사용자 예외권한을 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteUserMenu(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scu.userIdReqListDAO.deleteUserMenu", mapParam);
	}

	/**
	 * 사용자 게시판 권한을 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteBbsAuth(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scu.userIdReqListDAO.deleteBbsAuth", mapParam);
	}

	/**
	 * 사용자 게시판 권한을 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertBbsAuth(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scu.userIdReqListDAO.insertBbsAuth", mapParam);
	}
}
