package com.hwfs.sc.cmn.service;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.util.SessionUtil;
import com.hwfs.sc.cmn.dao.LoginDAO;
import com.hwfs.sc.cmn.dto.LoginDTO;
import com.hwfs.sc.scp.service.PersDstryHistService;

 /**
 * LoginServiceImpl에 대한 설명 작성
 * @ClassName LoginServiceImpl.java
 * @Description LoginServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2014. 11. 20.   kksoo        최초생성
 *  2015. 04. 20.   kksoo        로직 구현
 *  2015. 07. 08.   kksoo        무단사용자 점검을 위해 SESSION ID 저장
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2014. 11. 20.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sc/cmn/loginService")
public class LoginServiceImpl extends DefaultServiceImpl implements LoginService {

	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** LoginDAO */
    @Resource(name="/sc/cmn/loginDAO")
    private LoginDAO loginDAO;

	/** PersDstryHistService Bean 생성 */
	@Resource(name = "/sc/scp/persDstryHistService")
	private PersDstryHistService persDstryHistService;

	/**
	 * ID로 Login하여 로그인정보를 세션에 설정한다.
	 * <pre>
	 * - 개발용으로만 사용되며 autologin 기능에서만 사용
	 * </pre>
	 *
	 * @param req
	 * @param userId
	 * @throws Exception
	 * @see com.hwfs.cmn.service.LoginService#idLogin(java.lang.String)
	*/
	@Override
	public void idLogin(HttpServletRequest req, String userId) throws Exception {
		if (propertiesService.getBoolean(DefaultConsts.AUTOLOGIN_USE, false)) {
			// autologin 사용여부가 true일 경우만 허용 처리
			doAutoLogin (req, userId);
		}else{
			logger.error (messageService.getMessage("autologin.not.support"));
			throw processException("autologin.not.support");
		}
	}

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
	 * @see com.hwfs.sc.cmn.service.LoginService#idLogin(javax.servlet.http.HttpServletRequest, java.util.Map)
	*/
	@Override
	public LoginDTO idLogin(HttpServletRequest req, Map<String, Object> inVar) throws Exception {
		// 사용자정보 비밀번호 검사 및 조회
		return doLogin (req, inVar);
	}

	/**
	 * 사번으로 로그인한다.
	 * <pre>
	 * - 사용하지 않음
	 * </pre>
	 *
	 * @param req
	 * @param sabun
	 * @throws Exception
	 * @see com.hwfs.cmn.service.LoginService#sabunLogin(java.lang.String)
	*/
	@Override
	public void sabunLogin(HttpServletRequest req, String sabun) throws Exception {
		logger.error ("사번 Login 처리는 지원하지 않습니다.!!!");
	}

	/**
	 * 현재 세션에 설정된 로그인 사용자ID를 얻는다.
	 * <pre>
	 * - LoginCheckInterceptor에서 ThreadLocal에 설정하기 위해 사용
	 * </pre>
	 *
	 * @param req
	 * @return 사용자ID
	 * @throws Exception
	 * @see com.hwfs.cmn.service.LoginService#getUserId(javax.servlet.http.HttpServletRequest)
	*/
	@Override
	public String getUserId(HttpServletRequest req) throws Exception {
		if (SessionUtil.isLogin(req))
			return ((LoginDTO)SessionUtil.getLoginSession(req)).getUserid();
		else
			return "unknown";
	}

	/**
	 * 현재 세션에 설정된 로그인 사번을 얻는다.
	 * <pre>
	 * - LoginCheckInterceptor에서 ThreadLocal에 설정하기 위해 사용
	 * </pre>
	 *
	 * @param req
	 * @return sabun
	 * @throws Exception
	 * @see com.hwfs.cmn.service.LoginService#getSabun(javax.servlet.http.HttpServletRequest)
	*/
	@Override
	public String getSabun(HttpServletRequest req) throws Exception {
		if (SessionUtil.isLogin(req))
			return ((LoginDTO)SessionUtil.getLoginSession(req)).getSabun();
		else
			return "unknown";
	}

	/**
	 * 현재 세션에 설정된 로그인 사번의 개인정보항목별 마스크 정보을 얻는다.
	 * <pre>
	 * - LoginCheckInterceptor에서 ThreadLocal에 설정하기 위해 사용
	 * </pre>
	 *
	 * @param req
	 * @return 개인정보항목별 마스크 정보
	 * @throws Exception
	 */
	@Override
	public String getPersInfoMask(HttpServletRequest req) throws Exception {
		if (SessionUtil.isLogin(req))
			return ((LoginDTO)SessionUtil.getLoginSession(req)).getPersInfoMask();
		else
			return "YYYYYYYYYYYYYY";
	}

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
	public void logout (HttpServletRequest req, Map <String, Object> inVar) throws Exception {
		//현재 접속된 사용자 정보 얻기
		LoginDTO loginDTO = (LoginDTO)SessionUtil.getLoginSession(req);

		//로그아웃 정보를 만든다.
		Map<String, Object> mapParam = new HashMap<String, Object>();
		mapParam.put("appId", inVar.get("appId"));
		mapParam.put("sysType", inVar.get("sysType"));
		mapParam.put("prgId", inVar.get("prgId"));
		mapParam.put("sabun", loginDTO.getSabun());
		mapParam.put("loginYn", "N");
		mapParam.put("connSuccYn", "");
		mapParam.put("connIp", loginDTO.getAccessIp());
		mapParam.put("errDesc", "");
		mapParam.put("logDesc", req.getHeader("User-Agent"));
		
		logger.debug("***logout={}", mapParam);

		//DB에 로그아웃 저장
		loginDAO.logout(mapParam);

		//세션에서 제거
		SessionUtil.removeLoginSession(req);

		//세션을 무효화 시킨다.
		req.getSession().invalidate();
	}

	/**
	 * 사용자정보를 조회하고 Login을 처리한다.
	 * <pre>
	 * - 개발용으로만 사용되며 autologin 기능에서만 사용
	 * </pre>
	 *
	 * @param req
	 * @param userId
	 * @return LoginDTO
	 * @throws Exception
	 */
	private LoginDTO doAutoLogin (HttpServletRequest req, String userId) throws Exception {
		Map<String, Object> mapParam = new HashMap<String, Object>();
		mapParam.put("id", userId);
		mapParam.put("autologinYn", "Y");
		mapParam.put("applyAuthYn", super.propertiesService.getBoolean("authority.apply")?"Y":"N");

		//사용자정보 조회
		LoginDTO loginDTO = loginDAO.selectLoginInfo(mapParam);

		//사용자정보 조회 : 사용안함
		//LoginDTO loginDTO = loginDAO.selectLoginInfo(userId);


		//로그인 처리
		if (loginDTO != null) {
			loginDTO.setAccessIp(req.getRemoteAddr()); // 사용자접속 IP 설정
			loginDTO.setMainUpjangImg(super.propertiesService.getString("main.upjang.ci.image") + "/" + loginDTO.getMainUpjangImg());

			// 로그인 세션에 저장
			SessionUtil.setLoginSession(req, loginDTO);

			// Locale을 세션에 저장
			//TODO 사용자 Locale에 따라 설정
			//SessionUtil.setLocaleSession(req, Locale.US); //Locale.KOREAN);
		}

		return loginDTO;
	}

	/**
	 * 사용자정보를 조회하고 Login을 처리한다.
	 * <pre>
	 * - 로그인 화면에서 입력한 내용으로 실제 로그인 처리한다.
	 * - 개인정보보호 요건에 대한 프로세스를 처리한다. (비밀번호오류횟수, 계정잠김, 관리자IP, 중복로그인 등을 검사)
	 * </pre>
	 *
	 * @param req
	 * @param mapParam
	 * @return LoginDTO
	 * @throws Exception
	 */
	private LoginDTO doLogin (HttpServletRequest req, Map<String, Object> mapParam) throws Exception {
		//무단사용자 점검을 위한 설정 추가
		mapParam.put("connIp", req.getRemoteAddr());
		mapParam.put("applyAuthYn", super.propertiesService.getBoolean("authority.apply")?"Y":"N");

		//사용자정보 조회
		LoginDTO loginDTO = loginDAO.selectLoginInfo(mapParam);

		//등록된 사용자가 없는 경우
		if (loginDTO == null) {
			loginDTO = new LoginDTO();
			loginDTO.setResultCode(-1);
			return loginDTO;
		}

		loginDTO.setAccessIp(req.getRemoteAddr()); 	// 사용자접속 IP 설정
		
		if ("NO_IMG".equals(loginDTO.getMainUpjangImg())) {
			loginDTO.setMainUpjangImg(loginDTO.getMainUpjangImg());
		}
		else {
			loginDTO.setMainUpjangImg(super.propertiesService.getString("main.upjang.ci.image") + "/" + loginDTO.getMainUpjangImg());
		}
		

		mapParam.put("sabun", loginDTO.getSabun());	// 이후 사용을 위해 사번 설정

		//통합영업시스템은 내부사용자이면서 내부망에서만 접근가능
		if (mapParam.get("appId").toString().equals("HWFS")) {
			if (!loginDTO.getUserType().equals("내부")) {
				loginDTO.setResultCode(-20);
				return loginDTO;
			}
			if (req.getServerName().equals("203.233.82.141")     || 
				req.getServerName().startsWith("203.233.82.142") ||
				req.getServerName().startsWith("203.233.82.143")) {
				loginDTO.setResultCode(-21);
				return loginDTO;
			}
		}

		//1.비밀번호가 틀린 경우 처리
		if (!loginDTO.getValidPwdYn().equalsIgnoreCase("Y")) {
			//(주의)파기통보 상태일 경우는 횟수 검사하지 않음
			if (loginDTO.getAcctStatus() != null && loginDTO.getAcctStatus().equalsIgnoreCase("DSTRY_NOTI")) {
				loginDTO.setResultCode(-22);  // 파기통보 상태에서의 비밀번호 오류
			}
			else {
				loginDAO.updateLoginPwdErrCnt(mapParam);   			//비밀번호 오류 임계치관리 정보 DB Update
				loginDTO.setPwdErrCnt(loginDTO.getPwdErrCnt()+1);   //비밀번호 오류 임계치관리 정보 DTO Update

				//5회 이상 비밀번호 오류가 발생한 경우
	            if (loginDTO.getPwdErrCnt() >= loginDTO.getMaxPwdErrCnt()) {
	            	loginDTO.setResultCode(-3);  // 비밀번호 오류 횟수 임계치 초과 오류
	            	//계정을 잠근다.
	            	if (loginDTO.getPwdErrCnt() == loginDTO.getMaxPwdErrCnt())
	            		loginDAO.updateAccountLockForPwdErrOver (mapParam);
	            }
	            else {
	            	loginDTO.setResultCode(-2);  // 비밀번호 오류 횟수 임계치 내 오류
	            }
			}
		}
		//2.비밀번호가 맞는 경우 처리
		else {
			//정상 로그인인 경우 임계치관리 정보 DB 초기화
			if (loginDTO.getPwdErrCnt() > 0)
	            loginDAO.updateLoginPwdErrCntInit(mapParam);

			boolean blnLoginOk = true;
			//2.0.1무단사용자 차단여부 검사 처리
			if (loginDTO.getItctYn().equalsIgnoreCase("Y")) {
				loginDTO.setResultCode(-13);  	// 무단사용자 접근차단에 의한 접속불가
				blnLoginOk = false;
			}

			//2.0.2사용가능기간인지 검사 처리
			else if (!loginDTO.getUseDateYn().equalsIgnoreCase("Y")) {
				loginDTO.setResultCode(-14);  	// 사용가능기간이 아니어서 접속불가
				blnLoginOk = false;
			}

			//2.1중복로그인 검사 처리
			else {
				LoginDTO loginConnDTO = isDuplicationLogin (mapParam, loginDTO.getAccessIp());
				if (loginConnDTO != null) {
					// 중복로그인 정보 DTO에 설정
					loginDTO.setAlreadyConnIp(loginConnDTO.getAlreadyConnIp());
					loginDTO.setAlreadyLoginDate(loginConnDTO.getAlreadyLoginDate());

					loginDTO.setResultCode(-12);  	// 중복로그인인 경우 접속불가
					blnLoginOk = false;
				}
			}

			if (blnLoginOk) {
				//2.2관리자로그인 시 허용 IP 검사를 할 경우, 스템관리자(99), ITO관리자(999)인 경우 IP 검사 처리
				if (propertiesService.getBoolean("login.admin.ip.check", false) &&
					loginDTO.getAuthLevels() != null && loginDTO.getAuthLevels().matches(".*99.*")) {
					//if (loginDTO.getManageAllowIp() == null) {
					//	loginDTO.setResultCode(-11);  // 관리자 등록된 IP가 아니면 접속불가
					//	blnLoginOk = false;
					//}
					//else {
					//IP 정보가 등록된 경우에만 검사 : 초기 IP 등록을 본인이 하도록 하기 위함
					if (loginDTO.getManageAllowIp() != null && !loginDTO.getManageAllowIp().trim().equals("")) {
						String strIp = loginDTO.getManageAllowIp().replace(" ", "");
						String [] arrIp =  strIp.split(",");
						boolean blnMatch = false;
						for (int i=0; i<arrIp.length; i++) {
							if (arrIp[i].equals(loginDTO.getAccessIp())) {
								blnMatch = true;
								break;
							}
						}
						if (!blnMatch) {
							loginDTO.setResultCode(-11);  // 관리자 등록된 IP가 아니면 접속불가
							blnLoginOk = false;
						}
					}
				}
				//2.3계정이 잠긴 경우와 파기통보인 경우 처리
				else if (loginDTO.getAcctStatus() != null) {
					//파기통보상태인 경우
					if (loginDTO.getAcctStatus().equalsIgnoreCase("DSTRY_NOTI")) {
						//파기통보 해제 처리
						persDstryHistService.cancelDstryNoti(mapParam);

						//계정상태를 정상으로 설정
						loginDAO.updateAccountToNormal(mapParam);

						loginDTO.setResultCode(1);	//정상이지만 클라이언트에 메시지 전송
						blnLoginOk = true;
					}
					//계정이 잠긴 경우
					else if (loginDTO.getAcctStatus().equalsIgnoreCase("LOCK")) {
						if (loginDTO.getAcctLkReasonCd() != null && loginDTO.getAcctLkReasonCd().equalsIgnoreCase("PWD_ERR_OVER")) {	//비밀번호 오류초과로 잠김 경우 --> 비밀번호재설정해야 함
							loginDTO.setResultCode(-4);
							blnLoginOk = false;
						}else if (loginDTO.getAcctLkReasonCd() != null && loginDTO.getAcctLkReasonCd().equalsIgnoreCase("NO_USE_TIME_OVER")) { 	//일정기간 사용하지 않아 계정잠김
							//계정상태를 정상으로 설정 --> 여기서 하지 않고 비밀번호 변경에서 한다.
							//loginDAO.updateAccountToNormal(mapParam);

							//비밀번호 변경하도록 설정
							loginDTO.setPwdChgYn("Y");
							blnLoginOk = true;
						}else {
							loginDTO.setResultCode(-5);	// 기타 사유로 계정이 잠긴 상태
							blnLoginOk = false;
						}
					}
				}
			}

			if (blnLoginOk) {
				//접속사용자에 저장
				mapParam.put("sabun", loginDTO.getSabun());
				mapParam.put("connIp", loginDTO.getAccessIp());
				mapParam.put("sessionId", req.getSession().getId());
				loginDAO.saveLoginConnUser(mapParam);

				//이미 세션이 있는 경우는 제거
				if (SessionUtil.isLogin(req))
					SessionUtil.removeLoginSession(req);

				// 로그인 세션에 저장
				SessionUtil.setLoginSession(req, loginDTO);
				
				//loginDAO.saveUserPlain(mapParam);
			}
		}

		// Locale을 세션에 저장
		//TODO 사용자 Locale에 따라 설정 : 적용 필요 없음
		//SessionUtil.setLocaleSession(req, Locale.US); //Locale.KOREAN);

		return loginDTO;
	}

	/**
	 * 로그인/로그아웃 로그를 기록한다.
	 * <pre>
	 * - 성공 또는 실패 모두 기록한다.
	 * - 트랜잭션을 분리하여 처리한다.
	 * - Exception은 무시한다.
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
	public void insertConnUserLogNewTx (String appId, String sabun, boolean isLogin, boolean isSuccess, String connIp, String logMsg, String logDesc) {
		Map<String, Object> mapParam = new HashMap<String, Object>();

		mapParam.put("appId", appId);
		mapParam.put("sabun", sabun);
		if (isLogin) mapParam.put("loginYn", "Y"); else mapParam.put("loginYn", "N");
		if (isSuccess) mapParam.put("connSuccYn", "Y"); else mapParam.put("connSuccYn", "N");
		mapParam.put("connIp", connIp);
		mapParam.put("errDesc", logMsg);
		mapParam.put("logDesc", logDesc);
		
		try {
			loginDAO.insertConnUserLog (mapParam);
		}catch (Exception e) {
			//Exception 무시
			logger.error("error at insertConnUserLogNewTx", e);
		}
	}

	/**
	 * 중복로그인 여부를 검사한다.
	 * <pre>
	 * - 로그인 되어 있으며, 이미 접속된 접속주소와 로그인 요청한 접속주소가 서로 다른 경우만 중복로그인 되어 있는 것으로 판단
	 * - properties 파일에 login.duplication.allow=false로 설정된 경우만 검사한다.
	 * </pre>
	 *
	 * @param mapParam    로그인 정보
	 * @param reqConnIp   로그인 요청 접속자 주소
	 * @return LoginDTO   null이면 중복로그인이 아니며, 중복로그인 인 경우는 이미 접속한 정보를 반환한다.
	 * @throws Exception
	 */
	private LoginDTO isDuplicationLogin (Map<String,Object>mapParam, String reqConnIp) throws Exception {
		//중복로그인 방지 적용 여부
		if (propertiesService.getBoolean("login.duplication.allow", false)) return null;

		//현재 접속된 정보를 조회한다.
		LoginDTO loginConnDTO = loginDAO.selectLoginConnUser (mapParam);

		if (loginConnDTO == null) return null;
		//중복로그인 검사
		if (loginConnDTO.getAlreadyLoginYn().equals("Y") && !loginConnDTO.getAlreadyConnIp().equals(reqConnIp))
			return loginConnDTO;	//이미 접속한 정보를 반환
		else
			return null;
	}
}
