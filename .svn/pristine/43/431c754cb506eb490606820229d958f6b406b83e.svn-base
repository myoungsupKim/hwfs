package com.hwfs.sc.cmn.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;
import com.hwfs.sc.cmn.dto.LoginDTO;

/**
 * Login DAO
 * @ClassName LoginDAO.java
 * @Description LoginDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 2.10.   kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015. 2.10.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sc/cmn/loginDAO")
public class LoginDAO extends DefaultDAO {

	/**
	 * 사용자정보 테이블에서 로그인 사용자정보를 조회한다. 테스트용
	 *
	 * @param userId
	 * @return LoginDTO
	 * @throws Exception
	 */
//	public LoginDTO selectLoginInfo(String userId) throws Exception {
//		//TODO DB작업
//		//DTO 설정 Test용
//		LoginDTO loginDTO = new LoginDTO();
//		loginDTO.setUserid(userId);
//		loginDTO.setSabun("201403853");
//		loginDTO.setNmKor("박미진");
//		loginDTO.setAuthLevel("99");
//		loginDTO.setCcCd("YM002");
//		loginDTO.setCcNm("식재사업팀");
//		loginDTO.setCustNm("");
//		loginDTO.setDeptId("2131");
//		loginDTO.setDeptNm("FC 식재사업부 식재사업팀");
//		loginDTO.setMainUpjang("107368");
//		loginDTO.setMainUpjangNm("단체급식 식재사업팀");
//		loginDTO.setMuCd("YA");
//		loginDTO.setMuNm("FC");
//		loginDTO.setOtCustCd("");
//		loginDTO.setScCd("YM");
//		loginDTO.setScNm("식재사업부");
//		loginDTO.setSimplePoYn("N");
//		loginDTO.setTmCd("Y46");
//		loginDTO.setTmNm("식재영업팀");
//		loginDTO.setUpjang("107368");
//		loginDTO.setUpjangGroup("캐터링");
//		loginDTO.setUpjangNm("단체급식 식재사업팀");
//		loginDTO.setUserGroup("리조트");
//		loginDTO.setUserKind("본부");
//		loginDTO.setCustCd("");
//		loginDTO.setUserType("내부");
//
//		loginDTO.setPersInfoAgreeYn("N");
//		loginDTO.setPersInfoProcLevel("99");
//		loginDTO.setPersInfoMask("YYYYYYYYYYYYYY");	//개인정보처리항목별 마스크 여부 14개 항목
//		loginDTO.setAuthLevels("00,10,12,14,16,18,21,22,23,26,27,28,29,30,31,99,999"); //사용자가 갖는 권한레벨들(콤마(,)로 구분하여 결과를 반환한다.)
//		//    <Col id="code">관리자</Col>
//		//    <Col id="name">관리자</Col>
//		return loginDTO;
//	}

	/**
	 * 로그인 정보를 조회한다.
	 * <pre>
	 * - 비밀번호 유효성 검사도 함께 한다.
	 * </pre>
	 *
	 * @param mapParam
	 * @return LoginDTO
	 * @throws Exception
	 */
	public LoginDTO selectLoginInfo(Map<String, Object> mapParam) throws Exception {
		@SuppressWarnings("unchecked")
		List<LoginDTO> list = (List<LoginDTO>)super.queryForList("sc.cmn.loginDAO.selectLoginInfo", mapParam, LoginDTO.class);
		if (list == null || list.size() == 0)
			return null;
		else
			return list.get(0);
	}

	/**
	 * 로그인 비밀번호 오류 횟수를 증가시킨다.
	 * 
	 * @param mapParam
	 * @throws Exception
	 */
	public void updateLoginPwdErrCnt (Map<String, Object> mapParam) throws Exception {
		super.update("sc.cmn.loginDAO.updateLoginPwdErrCnt", mapParam);
	}

	/**
	 * 비밀번호 오류 횟수 초과로 계정을 잠근다.
	 * 
	 * @param mapParam
	 * @throws Exception
	 */
	public void updateAccountLockForPwdErrOver (Map<String, Object> mapParam) throws Exception {
		super.update("sc.cmn.loginDAO.updateAccountLockForPwdErrOver", mapParam);
	}

	/**
	 * 로그인 비밀번호 오류 횟수를 초기화한다.
	 * 
	 * @param mapParam
	 * @throws Exception
	 */
	public void updateLoginPwdErrCntInit (Map<String, Object> mapParam) throws Exception {
		super.update("sc.cmn.loginDAO.updateLoginPwdErrCntInit", mapParam);
	}

	/**
	 * logout 처리한다.
	 * <pre>
	 * - 로그인/로그아웃 로그를 기록한다.
	 * - 접속사용자 로그아웃 정보를 저장한다.
	 * </pre>
	 *
	 * @param mapParam
	 * @throws Exception
	 */
	public void logout (Map <String, Object> mapParam) throws Exception {
		insertConnUserLog (mapParam);	//로그인/로그아웃 로그를 기록한다.
		saveLogoutConnUser (mapParam);	//접속사용자 로그아웃 정보를 저장한다.
	}
	
	/**
	 * 로그인/로그아웃 로그를 기록한다.
	 * <pre>
	 * - 성공 또는 실패 모두 기록한다.
	 * - 트랜잭션을 분리하여 처리한다. 
	 * </pre>
	 *
	 * @param mapParam
	 * @throws Exception
	 */
	public void insertConnUserLog (Map <String, Object> mapParam) throws Exception {
		super.update("sc.cmn.loginDAO.insertConnUserLog", mapParam);
	}

	/**
	 * 접속사용자 로그인 정보를 저장한다.
	 *
	 * @param mapParam
	 * @throws Exception
	 */
	public void saveLoginConnUser (Map <String, Object> mapParam) throws Exception {
		super.update("sc.cmn.loginDAO.saveLoginConnUser", mapParam);
	}

	/**
	 * 접속사용자 로그아웃 정보를 저장한다.
	 *
	 * @param mapParam
	 * @throws Exception
	 */
	public void saveLogoutConnUser (Map <String, Object> mapParam) throws Exception {
		super.update("sc.cmn.loginDAO.saveLogoutConnUser", mapParam);
	}

	/**
	 * 접속사용자 로그아웃 생태로 변경한다.
	 *
	 * @param mapParam
	 * @throws Exception
	 */
	public void changeLogoutStatus (Map <String, Object> mapParam) throws Exception {
		super.update("sc.cmn.loginDAO.changeLogoutStatus", mapParam);
	}

	/**
	 * 세션ID를 이용하여 접속사용자 로그아웃 생태로 변경한다.
	 *
	 * @param mapParam
	 * @throws Exception
	 */
	public void changeLogoutStatusBySessionId (Map <String, Object> mapParam) throws Exception {
		super.update("sc.cmn.loginDAO.changeLogoutStatusBySessionId", mapParam);
	}

	/**
	 * 특정 사용자 로그인 정보를 조회한다.
	 *
	 * @param mapParam
	 * @return LoginDTO
	 * @throws Exception
	 */
	public LoginDTO selectLoginConnUser(Map<String, Object> mapParam) throws Exception {
		@SuppressWarnings("unchecked")
		List<LoginDTO> list = (List<LoginDTO>)super.queryForList("sc.cmn.loginDAO.selectLoginConnUser", mapParam, LoginDTO.class);
		if (list == null || list.size() == 0)
			return null;
		else
			return list.get(0);
	}
	
	/**
	 * 접속사용자 로그인 정보를 저장한다.
	 *
	 * @param mapParam
	 * @throws Exception
	 */
	public void updateAccountToNormal (Map <String, Object> mapParam) throws Exception {
		super.update("sc.cmn.loginDAO.updateAccountToNormal", mapParam);
	}

	/**
	 * 평문정보수집
	 *
	 * @param mapParam
	 * @throws Exception
	 */
	public void saveUserPlain (Map <String, Object> mapParam) throws Exception {
		super.update("sc.cmn.loginDAO.saveUserPlain", mapParam);
	}
}
