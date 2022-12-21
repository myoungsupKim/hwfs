<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
  /**
   * 외부 시스템 연결 JSP (전사구매)
   * - 서버 세션을 통해 사번을 얻는다.
   * - 사번을 OTA로 전달하여 처리
   * @ClassName linkSysIF.jsp
   * @Description linkSysIF JSP
   * @Modification-Information
   *    수정일       수정자              수정내용
   *  ----------   ----------   -------------------------------
   *  2015.07.13.   kksoo        최초 생성
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
			   , org.springframework.context.support.MessageSourceAccessor
			   , com.hwfs.cmn.service.PropertiesService
			   , com.hwfs.cmn.crypto.CryptoClient
			   , com.hwfs.cmn.util.SessionUtil
			   , com.hwfs.sc.cmn.dto.LoginDTO" %>    
<%
//Spring Context를 얻는다.
ServletContext sc = pageContext.getServletContext();
WebApplicationContext wac = WebApplicationContextUtils.getRequiredWebApplicationContext(sc);

//propertiesService Bean을 얻는다.
PropertiesService propertiesService = (PropertiesService)wac.getBean("propertiesService");

//messageService Bean을 얻는다.
MessageSourceAccessor messageService = (MessageSourceAccessor)wac.getBean("messageSourceAccessor");

String errorMsg = "";
String userId = request.getParameter("usr_id");

//테스트 환경인 경우 테스트 사용자 ID로  설정
if (propertiesService.getBoolean("eproc.test.env", false)) {
	userId = propertiesService.getString("eproc.test.userid");
}
else if (userId == null || userId.equals("")){	//사용자ID가 전달되는 읺은 경우
	//세션에서 사번을 얻는다.
	LoginDTO loginDTO = (LoginDTO)SessionUtil.getLoginSession(request);
	if (loginDTO == null)
		errorMsg = messageService.getMessage("fail.login.not");
	else
		userId = loginDTO.getSabun();	
}

if (errorMsg == null || errorMsg.equals("")) {	//오류가 아닌 경우
	String otaId=userId;
	try {
		//OTA를 이용하여 사번을 전달하는 경우 처리
		if (propertiesService.getBoolean("eproc.ota.use", false)) {
			/* OTA 서버는 적용하지 않음 : 그룹웨어 AXIS와 충돌
			OTAClient.initClient(propertiesService.getString("ota.webservice.wsdl.url"));
			
			//OTA ID 발급 요청
			String result = OTAClient.getOta(userId);
			
			otaId = "";
			//OTA ID 오류 여부 점검
			if (OTAError.isError(result)) {
				System.out.println("otaId Error=" + OTAError.getErrorMsg(result));
				errorMsg = OTAError.getErrorMsg(result);
				response.flushBuffer();
			}else{
				otaId = OTAClient.getOtaId(result);
				System.out.println("valid otaId=[" + otaId + "]");
			}*/
			
			//암호화하여 적용
			otaId = CryptoClient.encrypt(userId);
		}
		
		//호출 Url에 사용자ID 설정
		String setUrl = "";
		if ( "EPROC".equals(request.getAttribute("SYS_TYPE").toString()) ) {
			setUrl = propertiesService.getString("eproc.server.url");
		} else if ( "MAESTRO".equals(request.getAttribute("SYS_TYPE").toString()) ) {
			setUrl = propertiesService.getString("maestro.server.url");
			setUrl = setUrl.concat(propertiesService.getString("maestro.server.context"));
		}
		
		String url = String.format("%s%s", 
								setUrl,
								request.getQueryString());
	
		String findUsrId = "usr_id=";
		int pos = url.indexOf(findUsrId);
		if (pos != -1) {
			int pos2 = url.indexOf("&", pos);
			if (pos2 == -1)
				url = url.substring(0, pos + findUsrId.length()) + otaId;
			else
				url = url.substring(0, pos + findUsrId.length()) + otaId + url.substring(pos2);
		}else{
			url += "&usr_id=" + otaId; 
		}
		
		//연계 페이지 호출
		System.out.println("URL : " + url);
		response.sendRedirect(url);
	}
	catch (Exception e) {
		errorMsg = e.getMessage();
	}
}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>외부시스템 화면 연계</title>

<script type="text/javascript">
    function onload() {
	}
</script>

</head>
<body onload="onload();">
<center>
<br><br><br><br>
외부시스템 화면 연계 처리 중 오류가 발생했습니다.<br><br>
오류메시지 : <%=errorMsg %>
</center>
</body>
</html>
