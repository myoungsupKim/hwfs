package com.hwfs.sc.scu.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

/**
 * 사용자 계정을 신청하는 UserIdReq DAO
 *
 * @ClassName UserIdReqDAO.java
 * @Description UserIdReqDAO Class
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
@Repository("/sc/scu/userIdReqDAO")
public class UserIdReqDAO extends DefaultDAO {

	/**
	 * 입력한 사용자 ID의 중복을 검사한다.
	 *
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public int selectExistsUserId(Map<String, Object> mapParam)
			throws Exception {
		return super.queryForInt("sc.scu.userIdReqDAO.selectExistsUserId",
				mapParam);
	}

	/**
	 * 사용자 정보 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.scu.userIdReqDAO.selectList",
				mapParam);
	}

	/**
	 * 사용자 정보(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertUserInfo(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scu.userIdReqDAO.insertUserInfo", mapParam);
	}

	/**
	 * 사용자 정보(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateUserInfo(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scu.userIdReqDAO.updateUserInfo", mapParam);
	}

	/**
	 * 사용자 정보(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scu.userIdReqDAO.insert", mapParam);
	}

	/**
	 * 사용자 정보(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scu.userIdReqDAO.update", mapParam);
	}

	/**
	 * 사용자 정보(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scu.userIdReqDAO.delete", mapParam);
	}

}
