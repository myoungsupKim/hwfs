package com.hwfs.sc.cmn.web;

import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.XplatformMapDTO;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.sc.cmn.dto.LoginDTO;
import com.hwfs.sc.cmn.service.LoginService;

 /**
 * Login 처리 Controller
 * <pre>
 * -ID/PWD 기반 로그인 처리
 * -로그인정보DTO를 세션에 저정하고 클라이언트에 전달
 * -(중요)개인정보보호 지침을 준수
 * </pre>
 * @ClassName LoginController.java
 * @Description LoginController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 02. 10.   kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015. 02. 10.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
public class LoginController extends DefaultController {

	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

    /** Login Service */
    @Resource (name="/sc/cmn/loginService")
    private LoginService loginService;

    /**
	 * 로그인을 처리한다.
	 * <pre>
	 * - ID/PWD/sysType을 파라미터로 전달 받음
	 * - 개인정보보호 지침 처리
	 * - 로그인정보DTO를 세션에 저장하고 클라이언트에 전달
	 * </pre>
     * 
     * @param xpDto XPlatformMapDTO
     * @param req HttpServletRequest
     * @return ModelAndView
     * @throws Exception
     */
    @RequestMapping(value = "/sc/cmn/login.xdo")
    public ModelAndView login(
    		@Bind(id="", type=XplatformMapDTO.class)XplatformMapDTO xpDto
    	  , HttpServletRequest req) throws Exception {
		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = createModelAndView();
		
		//login 파라미터를 얻는다.
		Map <String, Object> inVar = xpDto.getInVariableMap();
		
    	//로그인 처리
		LoginDTO loginDTO = loginService.idLogin(req, inVar);
		
		String appId = (inVar.containsKey("appId"))? (String)inVar.get("appId") : "unknown";
		
		//정상적인 로그인 처리
		if (loginDTO.getResultCode() >= 0) {
			//접속로그를 저장한다.
			loginService.insertConnUserLogNewTx(appId, loginDTO.getSabun(), true, true, loginDTO.getAccessIp(), "", req.getHeader("User-Agent"));
			
			List<LoginDTO> list = new ArrayList<LoginDTO>();
			list.add(loginDTO);

	    	//전달할 결과 ResultSet에 설정
			addOutVariable(mav, "gdsUserInfo", list);

			if (loginDTO.getResultCode() == 1)	//클라이언트에 메시지 전달
				setResultSet (mav, 1, messageService.getMessage("success.login.dstry.noti.cancel"));
			else
				setResultSet (mav, DefaultConsts.OK_CODE, "");
		}
		//상황에 따른 오류 처리
		else {
			String errMsg = "";
			switch (loginDTO.getResultCode()) {
				case -1 :	// 사용자정보가 존재하지 않음
	    			errMsg = messageService.getMessage("fail.login.id");
	    			break;
	    			
	    		case -2 :	// 비밀번호가 일치하지 않음 (비밀번호 오류 임계치 내)
	    			//errMsg = messageService.getMessage("fail.login.pwd", new Object[]{loginDTO.getMaxPwdErrCnt(), loginDTO.getPwdErrCnt()});
	    			errMsg = messageService.getMessage("fail.login.id");	// 2016년 5월 정보보안팀 취약점 점검 후속 조치
	    			break;
	    			
	    		case -22 :	// 파기통보 상태내 비밀번호가 일치하지 않음
	    			errMsg = messageService.getMessage("fail.login.pwd.dstry.noti");
	    			break;

	    		case -3 :	// 비밀번호가 일치하지 않음 (비밀번호 오류 임계치 초과)
	    			errMsg = messageService.getMessage("fail.login.pwd.over", new Object[]{loginDTO.getMaxPwdErrCnt()});
	    			
	    			//개인정보보호 로깅
	    			accessLogService.pwdOverLog(loginDTO, errMsg);
	    			break;
	    			
	    		case -4 :	// 비밀번호 오류 임계치 초과하여 계정이 잠김 상태
	    			errMsg = messageService.getMessage("fail.login.pwd.locked", new Object[]{loginDTO.getMaxPwdErrCnt()});
	    			break;

	    		case -5 :	// 기타 사유로 계정이 잠김 상태
	    			errMsg = messageService.getMessage("fail.login.account.locked");
	    			break;
	
	    		case -10 :	// 관리자 로그인 외부망 접속불가 --> 적용하지 않음
	    			errMsg = messageService.getMessage("fail.login.admin.ip.public");
	    			
	    			//개인정보보호 로깅
	    			accessLogService.adminNotAllowLoginLog(loginDTO, errMsg);
	    			break;
	    			
	    		case -11 :	// 관리자 등록된 IP가 아니면 접속불가
	    			errMsg = messageService.getMessage("fail.login.admin.ip.not");

	    			//개인정보보호 로깅
	    			accessLogService.adminNotAllowLoginLog(loginDTO, errMsg);
	    			break;
	    			
	    		case -12 :	// 중복로그인인 경우 접속불가
	    			errMsg = messageService.getMessage("fail.login.duplication", new Object[]{loginDTO.getAlreadyConnIp(), loginDTO.getAlreadyLoginDate()});

	    			//개인정보보호 로깅
	    			accessLogService.sameTimeLoginLog(loginDTO, errMsg);
	    			break;

	    		case -13 :	// 무단사용자 접근차단에 의한 접속불가
	    			errMsg = messageService.getMessage("fail.login.no.permission.user", new Object[]{loginDTO.getAlreadyConnIp(), loginDTO.getAlreadyLoginDate()});
	    			break;
	
	    		case -14 :	// 사용가능기간이 아니어서 접속불가
	    			errMsg = messageService.getMessage("fail.login.cannot.use.date", new Object[]{loginDTO.getUseDate()});
	    			break;
	    			
	    		case -20 :	// 통합영업시스템은 외부사용자 접근 불가
	    			errMsg = messageService.getMessage("fail.login.app.not.allowed");
	    			break;

	    		case -21 :	// 통합영업시스템은 외부망 접근 불가
	    			errMsg = messageService.getMessage("fail.login.app.not.allowed.ip.public");
	    			break;

	    		default :	// 그외 오류
	    			errMsg = messageService.getMessage("fail.login");
	    			break;
			}
			//접속로그를 저장한다.
			if (loginDTO.getResultCode() != -1)	//등록된 사용자가 아닌 경우는 사번을 알지 못해 로그를 쌓지 않음
				loginService.insertConnUserLogNewTx(appId, loginDTO.getSabun(), true, false, loginDTO.getAccessIp(), errMsg, "");
			
			logger.error(String.format("[ID=%s]%s", loginDTO.getUserid(), errMsg));
			setResultSet (mav, DefaultConsts.ERR_CODE, errMsg);
		}
		
		return mav;
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
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/sc/cmn/logout.xdo")
    public ModelAndView logout(
    		@Bind(id="", type=XplatformMapDTO.class)XplatformMapDTO xpDto
    	  , HttpServletRequest req) throws Exception {
		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = createModelAndView();
		
		//logout 파라미터를 얻는다.
		Map <String, Object> inVar = xpDto.getInVariableMap();
		
    	//로그아웃 처리
		loginService.logout(req, inVar);
		
    	//전달할 결과 ResultSet에 설정
		return setResultSet (mav, DefaultConsts.OK_CODE, "");		
    }
}
