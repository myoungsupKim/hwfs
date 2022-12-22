<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
/**
 * 로그인이 되어 있지 않은 경우 오류 메시지를 XPLATFORM 형식의 메시지로 전송하는 View 페이지
 * - XML/SSV/BIN 데이터 포맷 및 암호화 송수신인 경우에도 적용 됨
 * @ClassName LoginCheckFailureXp.jsp
 * @Description LoginCheckFailureXp jsp
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
%>
<%@ page import="com.hwfs.cmn.exception.XplatformExceptionHandler, org.springframework.web.context.*
			  , org.springframework.web.context.support.WebApplicationContextUtils" %>    
<%
//XplatformExcepHndlr Bean을 얻는다.
ServletContext sc = pageContext.getServletContext();
WebApplicationContext wac = WebApplicationContextUtils.getRequiredWebApplicationContext(sc);
XplatformExceptionHandler xplatformExcepHndlr = (XplatformExceptionHandler)wac.getBean("/cmn/exception/xplatformExceptionHandler");

//XPLATFORM 메시지 형식으로 생성하여 Client에 전달
xplatformExcepHndlr.sendNotLoginMessage("fail.login.not", response);
%>
