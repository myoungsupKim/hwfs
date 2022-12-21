package com.hwfs.sc.sca.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 권한그룹을 관리한다.
 * @ClassName AuthMgmtDAO.java
 * @Description AuthMgmtDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 1. 29.   김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015. 1. 29.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sc/sca/authMgmtDAO")
public class AuthMgmtDAO extends DefaultDAO {

	/**
	 * 권한그룹을 조회한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 */
	public RecordSet selectList(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.sca.authMgmtDAO.selectList", parameter);
	}

	/**
	 * 신규 권한그룹을 생성한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 */
	public int insertList(Map<String, Object> parameter) throws Exception {
		return super.update("sc.sca.authMgmtDAO.insertList", parameter);
	}

	/**
	 * 변경된 권한그룹을 저장한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 */
	public int updateList(Map<String, Object> parameter) throws Exception {
		return super.update("sc.sca.authMgmtDAO.updateList", parameter);
	}

	/**
	 * 권한그룹을 삭제한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 */
	public int deleteList(Map<String, Object> parameter) throws Exception {
		return super.update("sc.sca.authMgmtDAO.deleteList", parameter);
	}

	public int deleteUserRole(Map<String, Object> parameter) throws Exception {
		return super.update("sc.sca.authMgmtDAO.deleteUserRole", parameter);
	}

	public int deleteDeptRole(Map<String, Object> parameter) throws Exception {
		return super.update("sc.sca.authMgmtDAO.deleteDeptRole", parameter);
	}

	public int deleteUgrpRole(Map<String, Object> parameter) throws Exception {
		return super.update("sc.sca.authMgmtDAO.deleteUgrpRole", parameter);
	}
}
