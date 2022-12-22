package com.hwfs.sc.scu.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

/**
 * 사용자 계정(ID)를 신청하는 UserIdRequest DAO
 *
 * @ClassName UserIdRequestDAO.java
 * @Description UserIdRequestDAO Class
 * @Modification-Information <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.06.29   	김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.06.29
 * @version 1.0
 * @see <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sc/scu/userIdRequestDAO")
public class UserIdRequestDAO extends DefaultDAO {

	/**
	 * 사용자 계정(ID) 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.scu.userIdRequestDAO.selectList",
				mapParam);
	}

	/**
	 * 사용자 계정(ID) 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectUserCheck(Map<String, Object> mapParam)
			throws Exception {
		return super.queryForRecordSet(
				"sc.scu.userIdRequestDAO.selectUserCheck", mapParam);
	}

	/**
	 * 사용자정보를 생성한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertUserInfo(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scu.userIdRequestDAO.insertUserInfo", mapParam);
	}

	/**
	 * 사용자 계정(ID)(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scu.userIdRequestDAO.insert", mapParam);
	}
	
	/**
	 * 사용자 계정(ID)(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertAuthLevel(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scu.userIdRequestDAO.insertAuthLevel", mapParam);
	}

	/**
	 * 사용자 계정(ID)(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteAuthLevel(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scu.userIdRequestDAO.deleteAuthLevel", mapParam);
	}
	
	/**
	 * 사용자 계정(ID)(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateUserInfo(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scu.userIdRequestDAO.updateUserInfo", mapParam);
	}

}
