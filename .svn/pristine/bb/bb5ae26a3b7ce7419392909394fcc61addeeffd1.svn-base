<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
  /**
   * HelpWiki 연결 JSP (자동로그인을 처리한다.)
   * @ClassName linkHelpIF.jsp
   * @Description linkHelpIF JSP
   * @Modification-Information
   *    수정일       수정자              수정내용
   *  ----------   ----------   -------------------------------
   *  2015.06.03.   kksoo        최초 생성
   *  
   * @author FC종합전산구축 : AA kksoo
   * @since 2015. 2. 03.
   * @version 1.0
   * @see
   * 
   *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
   */
%>
<%@ page import="java.io.*
			   , java.util.*
			   , org.springframework.web.context.*
			   , org.springframework.web.context.support.WebApplicationContextUtils
			   , com.hwfs.cmn.service.PropertiesService" %>    
<%
//Spring Context를 얻는다.
ServletContext sc = pageContext.getServletContext();
WebApplicationContext wac = WebApplicationContextUtils.getRequiredWebApplicationContext(sc);

//propertiesService Bean을 얻는다.
PropertiesService propertiesService = (PropertiesService)wac.getBean("propertiesService");

String url = String.format("%s?os_username=%s&os_password=%s", 
							propertiesService.getString("help.server.login.action"),
							propertiesService.getString("help.userid"),
							propertiesService.getString("help.userpw"));

response.sendRedirect(url);
//하단의 클리언트 스크립트는 필요 없음.
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>헬프 Wiki 링크</title>

<script type="text/javascript">
    function openHelp() {

		var url = "<%=propertiesService.getString("help.server.login.action")%>";
	  
		document.getElementById("os_username").value = "<%=propertiesService.getString("help.userid")%>";
		document.getElementById("os_password").value = "<%=propertiesService.getString("help.userpw")%>";
		
        var frm = document.getElementById("frmIF");
		
        frm.target = "_self";
        frm.action = url;
        frm.submit();	
	}
</script>

</head>
<body onload="openHelp();">
	<form id="frmIF" method="post">
		<input type="hidden" id="os_username" name="os_username"/>
		<input type="hidden" id="os_password" name="os_password"/>
	</form>
</body>
</html>
