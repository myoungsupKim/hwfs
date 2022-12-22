package com.hwfs.sc.app.dao;

import java.util.Map;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 식재앱 로그인 인터페이스용  DAO 개체
 * @ClassName LoginDAO.java
 * @Description  LoginDAO Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2022.06.20.   김명섭        최초생성
 * </pre>
 * @author 푸디스트
 * @since 2022.06.20.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by 한화시스템ICT CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sc/app/loginDAO")
public class LoginDAO extends DefaultDAO {
	
	/**
	 * 테스트 조회
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectTest(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.loginDAO.selectTest", parameter);
	}
	
	/**
	 * 사용자 조회
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectUser(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.loginDAO.selectUser", parameter);
	}

	/**
	 * 영업사원매출처 조회
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectSalesUpjang(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.loginDAO.selectSalesUpjang", parameter);
	}
	
	/**
	 * 사용자모바일권한 조회
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectUserRole(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.loginDAO.selectUserRole", parameter);
	}
	
	/**
	 * 로그인 비밀번호 오류 횟수를 증가시킨다.
	 * 
	 * @param mapParam
	 * @throws Exception
	 */
	public void updateLoginPwdErrCnt (Map<String, Object> parameter) throws Exception {
		super.update("sc.app.loginDAO.updateLoginPwdErrCnt", parameter);
	}
	
	/**
	 * 비밀번호 오류 횟수 초과로 계정을 잠근다.
	 * 
	 * @param mapParam
	 * @throws Exception
	 */
	public void updateAccountLockForPwdErrOver (Map<String, Object> parameter) throws Exception {
		super.update("sc.app.loginDAO.updateAccountLockForPwdErrOver", parameter);
	}

	/**
	 * 로그인 비밀번호 오류 횟수를 초기화한다.
	 * 
	 * @param mapParam
	 * @throws Exception
	 */
	public void updateLoginPwdErrCntInit (Map<String, Object> parameter) throws Exception {
		super.update("sc.app.loginDAO.updateLoginPwdErrCntInit", parameter);
	}

	/**
	 * 정보광고성처리동의여부를 반영한다.
	 * 
	 * @param mapParam
	 * @throws Exception
	 */
	public int updateMrecvYn (Map<String, Object> parameter) throws Exception {
		return super.update("sc.app.loginDAO.updateMrecvYn", parameter);
	}
	
	/**
	 * 개인정보처리동의여부를 반영한다.
	 * 
	 * @param mapParam
	 * @throws Exception
	 */
	public int updateMrecvYn2 (Map<String, Object> parameter) throws Exception {
		return super.update("sc.app.loginDAO.updateMrecvYn2", parameter);
	}	
	
	/**
	 * 비밀번호을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public Record selectPwdChg(Map<String, Object> parameter) throws Exception {
		return super.queryForRecord("sc.app.loginDAO.selectPwdChg", parameter);
	}

	/**
	 * 비밀번호(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updatePwd(Map<String, Object> parameter) throws Exception {
		return super.update("sc.app.loginDAO.updatePwd", parameter);
	}

	/**
	 * 아이디찾기 등록된 사용자인지를 조회한다.
	 *
	 * @param mapParam
	 * @return String 
	 */
	public RecordSet selectIdFind(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.loginDAO.selectIdFind", parameter);
	}
	
	/**
	 * 접속사용자 로그인 정보를 저장한다.
	 *
	 * @param mapParam
	 * @throws Exception
	 */
	public void saveLoginConnUser (Map <String, Object> parameter) throws Exception {
		super.update("sc.app.loginDAO.saveLoginConnUser", parameter);
	}
	
	/**
	 * 접속로그를 입력한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public void insertConnUserLog(Map<String, Object> parameter) throws Exception {
		super.update("sc.app.loginDAO.insertConnUserLog", parameter);
	}
	
	/**
	 * 로그정보를 입력한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int logInsert(Map<String, Object> parameter) throws Exception {
		return super.update("sc.app.loginDAO.logInsert", parameter);
	}
	
}
