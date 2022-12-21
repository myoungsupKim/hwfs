package com.hwfs.sc.cmn.interceptor.security;

import javax.servlet.http.HttpServletRequest;

import com.hwfs.cmn.log.AccessLogService;
import com.hwfs.cmn.util.SessionUtil;
import com.hwfs.sc.cmn.util.BeanUtil;
import com.sz.core.ServiceManagerFactory;
import com.sz.service.ui.xplatform.DefaultXplatformAction;
import com.sz.ui.BusinessContext;

 /**
 * FSP 프레임워크에서 Login여부를 Check하는 Interceptor
 * @ClassName FspLoginCheckInterceptor.java
 * @Description FspLoginCheckInterceptor Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 8. 24.   kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015. 8. 24.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@SuppressWarnings("serial")
public class FspLoginCheckInterceptor extends DefaultXplatformAction {

	/** 초기화 처리 여부 */
	private static boolean isInit = false;
	/** 자동로그인 사용여부 */
	private static boolean isAutoLogin = false;
	/** 접근로그 서버스 */
	private static AccessLogService accessLogService = null;
	
	/**
	 * 로그인 여부를 체크한다.
	 * <pre>
	 * - 세션에 LoginDTO가 있는지 여부로 인증 여부를 체크한다.
	 * - LoginDTO가 없다면, 로그인을 하도록 메시지를 전달한다.
	 * - autologin이 true인 경우는 인증 여부를 체크하지 않는다.
	 * - Exception이 발생한 경우 접근로그에 오류로그를 저장한다.
	 * </pre>
	 *
	 * @param ctx
	 * @throws Throwable
	 * @see com.sz.service.ui.xplatform.DefaultXplatformAction#execute(com.sz.ui.BusinessContext)
	 */
	public void execute(BusinessContext ctx) throws Throwable{
		// 초기화 시 설정 
		if (!isInit) {
			//자동로그인 여부
			String autoLogin = ServiceManagerFactory.getProperty("autologin.use");
			if (autoLogin == null || autoLogin.equalsIgnoreCase("true"))
				isAutoLogin = true;
			else
				isAutoLogin = false;
			
			//접근로그 서비스 bean
			accessLogService = (AccessLogService)BeanUtil.getBean("accessLogService");
			
			isInit = true;
		}
		
		HttpServletRequest req = (HttpServletRequest)ctx.getInputRequest();
		String sysType = req.getParameter("sysType");
		
		// 이미 로그인이 된 경우 또는 자동 로그인 모드, 외부 공개인 경우
		if (SessionUtil.isLogin(req) || (sysType != null && sysType.equalsIgnoreCase("PUBLIC")) || isAutoLogin) {
			// Action 수행
			try {
				super.execute(ctx);
			} catch (Exception ex) {
				//접근로그에 오류로그 저장				
				if (accessLogService != null) accessLogService.errorLog(req, ex);
				throw ex;
			}
			
		// 로그인이 안된 경우
		} else {			
			ctx.makeErrorResult(-99, "로그인이 되어 있지 않습니다. 로그인하여 주십시오.");
			ctx.sendData();
		}
	}

}
