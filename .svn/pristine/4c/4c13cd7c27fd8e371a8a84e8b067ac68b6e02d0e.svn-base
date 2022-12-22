package com.hwfs.sc.scu.dao;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

/**
 * 사용자 권한을 부여하는 UserRoleGrant DAO
 *
 * @ClassName UserRoleGrantDAO.java
 * @Description UserRoleGrantDAO Class
 * @Modification-Information <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.25   	김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.03.25
 * @version 1.0
 * @see <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sc/scu/userRoleGrantDAO")
public class UserRoleGrantDAO extends DefaultDAO {

	/**
	 * 대상 사용자의 정보를 조회한다.
	 *
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public Record selectUserInfo(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecord("sc.scu.userRoleGrantDAO.selectUserInfo",
				mapParam);
	}

	/**
	 * 권한부여(부서권한) 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectDeptAuthList(Map<String, Object> mapParam)
			throws Exception {
		return super.queryForRecordSet(
				"sc.scu.userRoleGrantDAO.selectDeptAuthList", mapParam);
	}

	/**
	 * 권한부여(사용자군권한) 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectUserGroupAuthList(Map<String, Object> mapParam)
			throws Exception {
		return super.queryForRecordSet(
				"sc.scu.userRoleGrantDAO.selectUserGroupAuthList", mapParam);
	}

	/**
	 * 권한부여(사용자권한) 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectUserAuthList(Map<String, Object> mapParam)
			throws Exception {
		return super.queryForRecordSet(
				"sc.scu.userRoleGrantDAO.selectUserAuthList", mapParam);
	}

	/**
	 * 권한부여(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scu.userRoleGrantDAO.insert", mapParam);
	}

	/**
	 * 사용자 정보를 갱신한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateUserInfo(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scu.userRoleGrantDAO.updateUserInfo", mapParam);
	}

	/**
	 * 권한부여(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scu.userRoleGrantDAO.update", mapParam);
	}

	/**
	 * 권한부여(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scu.userRoleGrantDAO.delete", mapParam);
	}

}
