<%@page pageEncoding="KSC5601"%><%response.setContentType("text/html; charset=UTF-8");%><%
	String instanceId = request.getParameter("instanceId");
	String tempYn = request.getParameter("tempYn");
	String agentResultCode = request.getParameter("agentResultCode"); //1은 정상, -1은 오류
	
	if ( instanceId == null ) instanceId = "-1";
	if ( tempYn == null ) tempYn = "N";
	if ( agentResultCode == null ) agentResultCode = "-1";
	
	System.out.println("######## result.jsp - START ##################");
	System.out.println("# instanceId : " + instanceId);
	System.out.println("# tempYn : " + tempYn);
	System.out.println("# agentResultCode : " + agentResultCode);
	System.out.println("######## result.jsp - END ##################");
%>
<html>
<head>
<script>
function init() {
	try {
		var o = new Object();
		o.tempYn = '<%=tempYn%>';
		o.instanceId = '<%=instanceId%>';
		o.agentResultCode = '<%=agentResultCode%>';

		window.returnValue = o;
		window.close(); 

	} catch (e) {
		alert(e.description);
	}
}

</script>
</head>
<body onload="init()"></body>
</html>