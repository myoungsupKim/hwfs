<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="java.util.*" %>
<%
  /**
   * OZ Report XML Viewer JSP
   * 서버에서 레포트 정책 : 레포트 로그, 공통 파라미터 및 개별 파리미터 전달
   * @ClassName reportXmlViewer.jsp
   * @Description OZ Report Xml Viewer JSP
   * @Modification-Information
   *    수정일       수정자              수정내용
   *  ----------   ----------   -------------------------------
   *  2015.01.23.   kksoo        최초생성
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
    <script language = "JavaScript" src = "<%=propertiesService.getString("oz.download.js")%>ztransferx_browers.js"></script>
    <script language = "JavaScript" src = "<%=propertiesService.getString("oz.download.js")%>ozviewer_browers.js"></script>
    <script language ="JavaScript">
    	// Oz Viewer 초기화
        function ZTInstallEndCommand_ZTransferX(param1,param2) {
            Create_Div();
            Initialize_OZViewer("OZReportViewer", "CLSID:0DEF32F8-170F-46f8-B1FF-4BF7443F5F25", "98%", "98%", "application/OZRViewer");
        }
        
        // Oz Viewer 실행
        function runOzViewer () {
            Insert_OZViewer_Param("connection.servlet", "<%=propertiesService.getString("oz.connection.servlet")%>");
            Insert_OZViewer_Param("toolbar.close", "false");

		    <%
			if (request.getParameter("zoom") == null) {
			%>	
				Insert_OZViewer_Param("applet.zoom", "100");	
		    <%
			}else{
		    %>
		    	Insert_OZViewer_Param("applet.zoom", "<%=request.getParameter("zoom")%>");
		    <%} %>

			Insert_OZViewer_Param("connection.reportname", "<%=reportViewerDTO.getReportName()%>");
			// 공통 파라미터
		    Insert_OZViewer_Param("connection.args1", "p_userInfo=<%=reportViewerDTO.getUserInfo()%>");
		    Insert_OZViewer_Param("connection.args2", "p_sabun=<%=reportViewerDTO.getSabun()%>");
		    Insert_OZViewer_Param("connection.args3", "p_userNm=<%=reportViewerDTO.getUserNm()%>");
		    Insert_OZViewer_Param("connection.args4", "p_deptNm=<%=reportViewerDTO.getDeptNm()%>");
		    Insert_OZViewer_Param("connection.args5", "p_persInfoMask=<%=reportViewerDTO.getPersInfoMask()%>");
		    //고객별 로고는 관리하지 않으므로 적용하지 않음
		    Insert_OZViewer_Param("connection.args6", "p_topLogo=");
		    Insert_OZViewer_Param("connection.args7", "p_stamp=<%=propertiesService.getString("oz.stamp.image")%>");
		    <%
			paramCnt=7;
		    %>
			// 파라미터 갯수 설정
		    Insert_OZViewer_Param("connection.pcount", "<%=paramCnt%>");

			Insert_OZViewer_Param("connection.datafromserver", "false");	//true이거나 설정하지 않으면 오류

			// OID 정보설정
			Insert_OZViewer_Param("odi.odinames", "<%=request.getParameter("odiname")%>");
			Insert_OZViewer_Param("odi.<%=request.getParameter("odiname")%>.pcount", "1");
			//Insert_OZViewer_Param("odi.<%=request.getParameter("odiname")%>.usescheduleddata", "ozp:///OzSdmMakerForXML.js");
			Insert_OZViewer_Param("odi.<%=request.getParameter("odiname")%>.usescheduleddata", "<%=strHostUrl%>/js/report/OzSdmMakerForXML.js");
			Insert_OZViewer_Param("odi.<%=request.getParameter("odiname")%>.args1", "xmlData=" +  bindData.value, true);	//클라이언트 바인드 파라미터 객체 설정. tag변경을 위해 true설정
			
			// 인쇄창에 속성 표시되도록 설정
			Insert_OZViewer_Param("print.properties", "true");

			// 기타 설정
			Insert_OZViewer_Param("viewer.isframe", "false");
			Insert_OZViewer_Param("information.debug", "true");
			Insert_OZViewer_Param("viewer.namespace", "custom_namespace/ozviewer");
            Start_OZViewer();
        }
        
        // Oz Viewer를 실행한다.        
        function onLoad () {
        	//alert ("bind=" + bindData.value);
        	runOzViewer ();
        }
    </script>
</head>

<body onload="onLoad()" style='height:100%'>
	<div id = "InstallOZViewer">
	    <script language = "JavaScript">
	        Initialize_ZT("ZTransferX", "CLSID:C7C7225A-9476-47AC-B0B0-FF3B79D55E67", "0", "0", "<%=propertiesService.getString("oz.download.ztransferx.server")%>ZTransferX_2,2,6,4.cab#version=2,2,6,4", "application/OZTransferX_1027");
	        Insert_ZT_Param("download.server", "<%=propertiesService.getString("oz.download.server")%>");
	        Insert_ZT_Param("download.port", "<%=propertiesService.getString("oz.download.port")%>");
	        Insert_ZT_Param("download.instruction", "ozrviewer.idf");
	        Insert_ZT_Param("install.base", "<PROGRAMS>/Forcs");
	        Insert_ZT_Param("install.namespace", "custom_namespace");
	        Start_ZT();
	    </script>
	</div>
	<input type="hidden" name="bindData" id="bindData"/>
	<input type="hidden" name="bindParam" id="bindParam"/>
</body>
</html>
