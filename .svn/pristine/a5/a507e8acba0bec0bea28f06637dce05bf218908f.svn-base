<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*
			   , java.util.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
Test HWFS 테스트....<br>
<%
	// 파라미터 한글 테스트
	Enumeration params = request.getParameterNames();

	while (params.hasMoreElements()) {
		String name = (String)params.nextElement();
		String value = request.getParameter(name);
	%>
<%=name%>=<%=value%><br>
<%	}
%>
</body>
</html>