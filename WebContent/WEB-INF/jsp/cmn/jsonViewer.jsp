<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="java.util.*" %>
<%
  /**
   * Json Result Viewer JSP
   * Json 결과를 전송하는 Viewer 
   * @ClassName jsonViewer.jsp
   * @Description Json Result Viewer JSP
   * @Modification-Information
   *    수정일       수정자              수정내용
   *  ----------   ----------   -------------------------------
   *  2015.02.05.   kksoo       Json 결과 전송 Viewer
   *
   * @author FC종합전산구축 : AA kksoo
   * @since 2015.02.05.
   * @version 1.0
   * @see
   *
   *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
   */
%>
<%@ page import="java.io.*, java.util.*"%>
<%
	//Controller에서 전달된 json 결과를 얻는다.
	String strJsonResult = (String)request.getAttribute("jsonResult");

	//결과값 출력
	out.clear();
	out.write(strJsonResult);
	out.flush();
%>
