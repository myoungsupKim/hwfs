<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="java.util.*" %>
<%
  /**
   * OZ Report Dynamic XML Viewer JSP
   * XML을 이용하여 동적으로 레포트를 생성한다. (XML의 첫번째 Record가 타이틀이 된다)
   * 서버에서 레포트 정책 : 레포트 로그, 공통 파라미터 및 개별 파리미터 전달
   * @ClassName reportDynamicXmlViewer.jsp
   * @Description OZ Report Dynamic Xml Viewer JSP
   * @Modification-Information
   *    수정일       수정자              수정내용
   *  ----------   ----------   -------------------------------
   *  2015.02.17.   kksoo        최초생성
   *  
   * @author FC종합전산구축 : AA kksoo
   * @since 2015. 1. 23.
   * @version 1.0
   * @see 
   * <pre>
   *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
   * </pre>
   */
%>
<%@ page import="java.io.*
	, java.util.*
	, org.springframework.web.context.*
	, org.springframework.web.context.support.WebApplicationContextUtils
	, com.hwfs.cmn.service.PropertiesService
	, com.hwfs.sc.cmn.util.StringUtil
	, com.hwfs.sc.cmn.dto.ReportViewerDTO"%>
<%
	ServletContext sc = pageContext.getServletContext();
	WebApplicationContext wac = WebApplicationContextUtils.getRequiredWebApplicationContext(sc);
	
	//propertiesService Bean을 얻는다.
	PropertiesService propertiesService = (PropertiesService)wac.getBean("propertiesService");
	
	//Controller에서 전달된 Model을 얻는다.
	ReportViewerDTO reportViewerDTO = (ReportViewerDTO)request.getAttribute("reportViewerDTO");

	//Parameter Count
	int paramCnt = 0;
	
	//현재 요청 서버 주소와 포트 얻기
	String strUrl = request.getRequestURL().toString();
	int pos = strUrl.indexOf("://");
	pos = strUrl.indexOf("/", pos + 3);
	String strHostUrl =  strUrl.substring (0, pos);
%>
<html style='height:100%'>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>
	    <%
		if (request.getParameter("title") == null) {
		%>
			Report Viewer	
	    <%
		}else{
	    %>
	    	<%=request.getParameter("title")%>
	    <%} %>
	</title>
    <script language ="JavaScript">
    function OZCall() {
    	var strOZCall; 
   		var strOZDataXML;
		var ozSep = "^";
		//XML 데이터 바인딩
		strOZDataXML = bindData.value;
		
   		var viewerMode = "preview";
   		strOZCall ="";
   		strOZCall += "connection.dataFromServer=false" +ozSep;
    	strOZCall += "connection.servlet=<%=propertiesService.getString("oz.connection.servlet")%>" +ozSep;
    	
	    <%
		if (request.getParameter("zoom") == null) {
		%>	
   			strOZCall += "applet.zoom=100" +ozSep;
	    <%
		}else{
	    %>
			strOZCall += "applet.zoom=<%=request.getParameter("zoom")%>" +ozSep;
	    <%} %>
	    
		<%
		if (request.getParameter("vertical") == null || request.getParameter("vertical").equalsIgnoreCase("Y")) {
		%>
			strOZCall += "connection.reportname=/hwfs/DynamicXml.ozr" +ozSep;
	    <%
		}else{
	    %>
    		strOZCall += "connection.reportname=/hwfs/DynamicXmlHorz.ozr" +ozSep;
   	    <%} %>

   	    // 공통 파라미터 
    	strOZCall += "connection.args1=p_userInfo=<%=reportViewerDTO.getUserInfo()%>" +ozSep;
    	strOZCall += "connection.args2=p_sabun=<%=reportViewerDTO.getSabun()%>" +ozSep;
    	strOZCall += "connection.args3=p_userNm=<%=reportViewerDTO.getUserNm()%>" +ozSep;
    	strOZCall += "connection.args4=p_deptNm=<%=reportViewerDTO.getDeptNm()%>" +ozSep;
    	strOZCall += "connection.args5=p_persInfoMask=<%=reportViewerDTO.getPersInfoMask()%>" +ozSep;
    	strOZCall += "connection.args6=p_topLogo=" +ozSep;
    	strOZCall += "connection.args7=p_stamp=<%=propertiesService.getString("oz.stamp.image")%>" +ozSep;
    	strOZCall += "connection.args8=title=<%=request.getParameter("title")%>" +ozSep;
		// 파라미터 갯수 설정
    	strOZCall += "connection.pcount=8" +ozSep;

    	strOZCall += "print.properties=true" +ozSep;
    	strOZCall += "information.debug=true" +ozSep;
    	strOZCall += "viewer.isframe=false" +ozSep;
    	strOZCall += "viewer.namespace=custom_namespace\\ozviewer" +ozSep;
    	strOZCall += "viewer.mode=preview" +ozSep;
    	strOZCall += "odi.odinames=sdm3" +ozSep;
    	//strOZCall += "odi.sdm3.usescheduleddata=ozp:///OzSdmMakerForXML_dynamic.js" +ozSep;
    	strOZCall += "odi.sdm3.usescheduleddata=<%=strHostUrl%>/js/report/OzSdmMakerForXML_dynamic.js" +ozSep;
    	strOZCall += "odi.sdm3.pcount=1" +ozSep;
    	strOZCall += "odi.sdm3.args1=xmlData=" + strOZDataXML + ozSep;

    	OZViewer.CreateReportEX(strOZCall, ozSep);
   	}
    </script>
</head>

<body onload="OZCall()" style='height:100%'>
	<OBJECT id = "OZViewer" CLASSID="CLSID:0DEF32F8-170F-46f8-B1FF-4BF7443F5F25" width="100%" height="100%">
    	<PARAM NAME="information.debug" value="true">
    	<PARAM NAME="viewer.isframe" value="false">
    	<PARAM NAME="viewer.emptyframe" value="true">
	</OBJECT>
	<input type="hidden" name="bindData" id="bindData"/>
	<input type="hidden" name="bindParam" id="bindParam"/>
</body>
</html>
