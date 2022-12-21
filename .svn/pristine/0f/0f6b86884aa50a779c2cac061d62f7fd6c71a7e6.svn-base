package com.hwfs.sc.cmn.interceptor.security;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ModelAndViewDefiningException;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.hwfs.cmn.service.PropertiesService;

/**
 * 유효한 JSON 요청(식권발매기 정보전송) 여부를 Check하는 Interceptor
 * <pre>
 * - 등록된 JSON 요청 IP에서만 요청되도록 검사한다.
 * - 검사는 json.valid.checck.use 프로퍼티 설정에 의해 처리된다.
 * </pre>
 * @ClassName JsonCheckInterceptor.java
 * @Description jSonCheckInterceptor Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.07.29.   kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015.06.24.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public class JsonCheckInterceptor extends HandlerInterceptorAdapter {

	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** PropertyService DI */
	@Resource(name = "propertiesService")
	protected PropertiesService propertiesService;

	/** MessageService DI */
	@Resource(name = "messageSourceAccessor")
	protected MessageSourceAccessor messageService;
	
	/** 유효한 식권발매기만 등록하여 관리되는 Map으로 key는 접속IP로 한다.  */
	private static Map<String, Object> validJson = new HashMap<String, Object>();
	
	/**
	 * 유효한 POS 여부를 체크하는 Interceptor의 preHandle
	 * <pre>
	 * - validPos에 등록되어 있는지 여부로 인증 여부를 체크한다.
	 * - validPos에 등록되지 않는 경우는 DB의 POS 등록 테이블에 등록되어 있는지 체크하고 등록되어 있으면 validPos에 등록하여 관리한다.
	 * </pre>
	 *
	 * @param req
	 * @param res
	 * @param handler
	 * @return
	 * @throws Exception
	 * @see org.springframework.web.servlet.handler.HandlerInterceptorAdapter#preHandle(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse, java.lang.Object)
	 */
	@Override
	public boolean preHandle(HttpServletRequest req, HttpServletResponse res, Object handler)
			throws Exception {

		//유효한 POS 여부를 검사하지 않는 경우  
		if (!propertiesService.getBoolean("json.valid.check.use", false)) {
			//logger.debug (messageService.getMessage("sc.cmn.json.valid.not.check"));
			return true;
		}
		
		//유효한 JSON 요청(식권발매기 정보전송)으로 등록된 경우
		if (validJson.containsKey(req.getRemoteAddr())) {
			return true;
		//유효한 JSON 요청으로 등록되지 않은 경우는 등록 테이블을 조회하여 확인
		} else  {			
			//등록된 JSON 요청인지 검사하는 서비스 호출
			boolean isValid = true; //posCheckService.selectValidPos(req.getRemoteAddr());
			if (isValid) {
				//유효한 식권발매기로 등록 : 멀티 쓰레드에서 접근하므로 동기화 처리 
				synchronized(this) {
					validJson.put(req.getRemoteAddr(), true);
				}
				return true;
			}else{
				//오류 발생
				logger.error ("{} [{}]", messageService.getMessage("sc.cmn.json.valid.fail.msg"), req.getRemoteAddr());
				
				ModelAndView modelAndView;
				modelAndView = new ModelAndView("/cmn/error/jsonCheckFailure");
				throw new ModelAndViewDefiningException(modelAndView);
			}
		}
	}
	
}
