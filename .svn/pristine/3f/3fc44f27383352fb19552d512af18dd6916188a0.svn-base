package com.hwfs.sc.cmn.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.hwfs.sc.cmn.dto.LoginDTO;

 /**
 * 프로젝트 LoginService Interface
 * -공통 LoginService Interface를 확장하고 필요한 부분을 추가한다.
 * @ClassName LoginService.java
 * @Description LoginService Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2014. 11. 20.   kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2014. 11. 20.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface LoginService extends com.hwfs.cmn.service.LoginService {
	
	/**
	 * ID/PWD로 Login하여 로그인정보를 세션에 설정한다.
	 * <pre>
	 * - ID/PWD/sysType을 파라미터로 전달 받음
	 * - 개인정보보호 지침 처리
	 * - 로그인정보DTO를 세션에 저장하고 클라이언트에 전달
	 * </pre>
	 *
	 * @param req
	 * @param inVar
	 * @return LoginDTO
	 * @throws Exception
	 */
	public LoginDTO idLogin (HttpServletRequest req, Map <String, Object> inVar) throws Exception;

    /**
     * 접속한 사용자를 로그아웃 처리한다.
     * <pre>
     * - 세션에 등록된 사용자를 이용하여 로그아웃 처리
     * - 개인정보보호 지침 처리
     * - 로그인정보DTO를 세션에서 제거
     * </pre>
     *
     * @param req
	 * @param inVar
     * @throws Exception
     */
	public void logout (HttpServletRequest req, Map <String, Object> inVar) throws Exception;
	
	/**
	 * 로그인/로그아웃 로그를 기록한다.
	 * <pre>
	 * - 성공 또는 실패 모두 기록한다.
	 * - 트랜잭션을 분리하여 처리한다. 
	 * </pre>
	 *
	 * @param appId
	 * @param sabun
	 * @param isLogin
	 * @param isSuccess
	 * @param connIp
	 * @param logMsg
	 * @throws Exception
	 */
	public void insertConnUserLogNewTx (String appId, String sabun, boolean isLogin, boolean isSuccess, String connIp, String logMsg, String descMsg);

}
