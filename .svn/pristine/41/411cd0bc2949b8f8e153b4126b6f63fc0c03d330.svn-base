package com.hwfs.sc.cmn.util;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.context.support.WebApplicationContextUtils;

 /**
 * Spring IoC에 등록된 Bean에 접근하는 Util
 * @ClassName BeanUtil.java
 * @Description BeanUtil Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 4. 1.   kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015. 4. 1.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public class BeanUtil {

	/**
	 * Spring IoC에서 bean을 얻는다.
	 * <pre>
	 * - 반환된 Object는 해당 bean class로 Type Casting하여 사용한다.
	 * </pre>
	 *
	 * @param sc ServletContext
	 * @param beanId Bean Id
	 * @return bean object
	 */
	public static Object getBean (ServletContext sc, String beanId) {
		WebApplicationContext wac = WebApplicationContextUtils.getRequiredWebApplicationContext(sc);
		
		//Bean을 얻어 반환한다.
		return wac.getBean(beanId);
	}
	
	/**
	 * Spring IoC에서 bean을 얻는다.
	 * <pre>
	 * - 현재 Thread의 RequestContext를 이용한다.
	 * - 반환된 Object는 해당 bean class로 Type Casting하여 사용한다.
	 * </pre>
	 *
	 * @param beanId Bean Id
	 * @return
	 */
	public static Object getBean (String beanId) {
		//현재 요청중인 thread local의 HttpServletRequest 객체 가져오기
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		 
		//HttpSession 객체 가져오기
		HttpSession session = request.getSession();
		 
		//ServletContext 객체 가져오기
		ServletContext context = session.getServletContext();
		 
		//Spring Context 가져오기
		WebApplicationContext wac = WebApplicationContextUtils.getWebApplicationContext(context);

		//Bean을 얻어 반환한다.
		return wac.getBean(beanId);
	}
}
