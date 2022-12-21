<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
	response.setHeader("Pragma","no-cache"); //HTTP 1.0
	response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
	
	String title = request.getParameter("title");
	String scroll = request.getParameter("scroll");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title><%=title%></title>
<%@ include file="/apagent/lib/config/config.jsp" %>
</head>
<body>
<iframe id="main" name="main" src="wait.jsp" MARGINWIDTH="0" tabIndex="-1" MARGINHEIGHT="0" frameBorder="0" style="marginLeft:0px;width:100%;height:100%;text-align:center;border:0px; solid" scrolling="<%=scroll%>"></iframe>
<form id="viewForm" name="viewForm" method="post" target="main">
<%
	for(java.util.Enumeration paramEnum = request.getParameterNames(); paramEnum.hasMoreElements(); ) {
		String paramKey = (String)paramEnum.nextElement();
		String paramValue = request.getParameter(paramKey);
		paramValue = request.getParameter(paramKey);
%>		
<input type="hidden" name="<%=paramKey%>" value="<%=paramValue%>">
<%
	}
%>
</form>
</body>
<script type="text/javascript">

$().ready(function(){
	var vForm = document.getElementById("viewForm");
	var callUrl = window.dialogArguments.url;

	vForm.action = callUrl;
	var f = $("#viewForm");
	if ( window.dialogArguments.param ) {
		var params = window.dialogArguments.param;
		for(var k in params) {
			f.append( $(document.createElement('input')).attr({"type":"hidden","name":k,"value":params[k]}) );
		}
	}
	vForm.submit();
});

</script>
</html>