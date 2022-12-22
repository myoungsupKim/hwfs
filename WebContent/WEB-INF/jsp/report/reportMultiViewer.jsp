<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="java.util.*" %>
<%
  /**
   * OZ Report Viewer JSP
   * 서버에서 레포트 정책 : 레포트 로그, 공통 파라미터 및 개별 파리미터 전달
   * @ClassName reportViewer.jsp
   * @Description OZ Report Viewer JSP
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
	//String map = request.getAttribute("reportViewerDTO");
	HashMap<String,String> map = (HashMap<String,String>)request.getAttribute("test");
	//Parameter Count
	int paramCnt = 0;
	
	
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
</head>
<script language="JavaScript">
var oReport;
var strExportName;
function onLoad()
{
	//ToDo
	setTimeout("fn_onTimer()", 6000);
}

function fn_onTimer() {
	//console.log(1);
	document.getElementById("RunOZViewer").style.background = "url(../../../install/img/report_install.png)";
	//document.getElementById("RunOZViewer").style.backgroundSize = "492px 1262px";
	document.getElementById("RunOZViewer").style.backgroundRepeat = "no-repeat";
}

</script>
<body onload="onLoad()" leftmargin=0 topmargin=0 scroll=no>
	<div id = "InstallOZViewer">
	    <object id = "ZTransferX" classid = "CLSID:C7C7225A-9476-47AC-B0B0-FF3B79D55E67" width = "0" height = "0" codebase = "<%=propertiesService.getString("oz.download.ztransferx.server")%>ZTransferX_2,2,6,4.cab#version=2,2,6,4">
		    <param name = "download.server" value = "<%=propertiesService.getString("oz.download.server")%>">
		    <param name = "download.port" value = "<%=propertiesService.getString("oz.download.port")%>">
		    <param name = "download.instruction" value = "ozrviewer.idf">
		    <param name = "install.base" value = "<PROGRAMS>/Forcs">
		    <param name = "install.namespace" value = "custom_namespace">
	    </object>
	</div>
	
	<!-- div id = "RunOZViewer" style='height:98%; background: url(../../../install/img/report_install.png); background-size: 492px 1262px; background-repeat: no-repeat'-->
	<div id = "RunOZViewer" style='height:98%;'>
	    <object id = "OZReportViewer" classid = "CLSID:0DEF32F8-170F-46f8-B1FF-4BF7443F5F25" width = "100%" height = "100%">
	    <param name = "connection.servlet"   value = "<%=propertiesService.getString("oz.connection.servlet")%>">
	    <param name = "connection.fetchtype" value = "concurrent">
	    <param name = "toolbar.close"        value="false">
	    
	    <%
	    //System.out.println("$$$$$$$$$$$$$$$$$"+request.getParameter("PO_NUM").split(","));
	    //String[] sArray1 = request.getParameter("odiParams").split("@");
	    //System.out.println((int)request.getParameter("odiParams").split("@").length-1);
	    //int test = request.getParameter("odiParams").split("@").length;
	    //System.out.println(test-1);
	    
	    //FICS 거래명세서출력시 외부고객은 파일을 저장할 수 없게함.
	    if("CS".equals(reportViewerDTO.getSabun().substring(0,2)) && "/FICS/FMP00350R_R01.ozr".equals(reportViewerDTO.getReportName()))
	    {
	    	//System.out.println("외부");
	    	%>
	    	<param name = "toolbar.save"        value="false">
	    	<%
	    }else{
	    	//System.out.println("내부");
	    	%>
	    	<param name = "toolbar.save"        value="true">
	    	<%
	    }
	    %>
	    
	    <%
		if (request.getParameter("zoom") == null) {
		%>	
			<param name = "applet.zoom" value="100">	
	    <%
		}else{
	    %>
	    	<param name = "applet.zoom" value="<%=request.getParameter("zoom")%>">
	    <%} %>
	    
	    <param name = "connection.reportname" value = "<%=reportViewerDTO.getReportName()%>">
	    <!-- 공통 파라미터 -->
	    <param name = "connection.args1" value = "p_userInfo=<%=reportViewerDTO.getUserInfo()%>">
	    <param name = "connection.args2" value = "p_sabun=<%=reportViewerDTO.getSabun()%>">
	    <param name = "connection.args3" value = "p_userNm=<%=reportViewerDTO.getUserNm()%>">
	    <param name = "connection.args4" value = "p_deptNm=<%=reportViewerDTO.getDeptNm()%>">
	    <param name = "connection.args5" value = "p_persInfoMask=<%=reportViewerDTO.getPersInfoMask()%>">
	    <!-- 고객별 로고는 관리하지 않으므로 적용하지 않음 -->
	    <!-- <param name = "connection.args6" value = "p_topLogo=<%=propertiesService.getString("oz.toplogo.image")%>"> -->
	    <param name = "connection.args6" value = "p_topLogo=">
	    <param name = "connection.args7" value = "p_stamp=<%=propertiesService.getString("oz.stamp.image")%>">
	    <!-- 멀티레포트 파라미터 -->
	    <param name = "viewer.childcount" value = "<%=(int)request.getParameter("odiParams").split("@").length-1%>">
	    <param name = "viewer.focus_doc_index" value = "0">
	    <param name = "viewer.showtree" value = "true">
	    <param name = "print.alldocument" value = "true">
	    <param name = "global.concatpage" value = "true">
	    <param name = "global.inheritparameter" value = "true">
	    <!-- 개발자정의 파라미터 설정: 기존 형식의 경우 p?를 PARAM?로 변경하고, 신규 형식은 파라미터 형식 그대로 전달 -->
	    <%
		paramCnt=7;
	    if (request.getParameter("paramcnvt") != null && request.getParameter("paramcnvt").equalsIgnoreCase("N")) {
			// 신규 형식의 경우 처리
			System.out.println("odiLengthss"+request.getParameter("odiParams").split("@").length);
			String[] sArrayParams1 = request.getParameter("odiParams").split("@");
			//String[] sArrayReportName = request.getParameter("reportName").split(",");
			for( int i = 0; i < sArrayParams1.length; i++ ){
		    	String[] sArrayParams2 = sArrayParams1[i].split(",");
		    	if(i==0){
		    		System.out.println("connection.pcount"+sArrayParams2.length);
		    	}else{
		    		System.out.println("child"+i+".connection.pcount"+sArrayParams2.length);
		    		%>
		    		<param name = "child<%=i%>.connection.reportname" value = "<%=reportViewerDTO.getReportName()%>">
		    		<param name = "child<%=i%>.connection.pcount" value = "<%=sArrayParams2.length%>">
		    		<%
		    	}
			    	for( int j = 0; j < sArrayParams2.length; j++ ){
			    		if(i==0){
			    			System.out.println("connection.args"+(j+1)+sArrayParams2[j].replace(":","="));
			    		%>
			    			<param name = "connection.reportname" value = "<%=reportViewerDTO.getReportName()%>">
		    				<param name = "connection.pcount" value = "<%=sArrayParams2.length%>">
			    			<param name = "connection.args<%=j+1%>" value = "<%=sArrayParams2[j].replace(":","=")%>">
			    		<%
			    		}else{
			    			System.out.println("child"+i+".connection.args"+(j+1)+sArrayParams2[j].replace(":","="));
			    		%>
			    			<param name = "child<%=i%>.connection.args<%=j+1%>" value = "<%=sArrayParams2[j].replace(":","=")%>">
			    		<%
			    		}
			    	}
		    }
		}else{
			// 기존 형식의 경우 처리
			if (request.getParameter("cnt") != null && Integer.parseInt(request.getParameter("cnt").toString()) > 0) {
				for (int i = 1; i <= Integer.parseInt(request.getParameter("cnt")); i++) {
					paramCnt++;
					System.out.println("2222$$$$$$$$$$$$$$$$$"+request.getParameter("p" + i));
			%>
					<param name="connection.args<%=paramCnt%>"   value="PARAM<%=i%>=<%=request.getParameter("p" + i)%>">	
			<%
				}
			}
		} %>
		
		<!-- 파라미터 갯수 설정 -->
	    <param name = "connection.pcount" value = "<%=paramCnt%>">
	    
	    <%
		if (request.getParameter("lockflag") != null && request.getParameter("lockflag").equalsIgnoreCase("TRUE")) {
		%>
  			<param name="print.lockopt"       value="true">	
		<%
		}
		%>
		<%
		if (request.getParameter("onceflag") != null && request.getParameter("onceflag").equalsIgnoreCase("TRUE")) {
		%>
  			<param name="print.once"          value="true">	
		<%
		}
		%>
	    
		<!-- 인쇄창에 속성 표시되도록 설정 -->
	    <param name = "print.properties" value = "true">

	    <!-- 의미없음
	    <param name = "odi.odinames" value = "sample11">
		<param name = "odi.sample.pcount" value = "1">
		<param name = "odi.sample.args1" value = "id=">
		 -->
	    <param name = "viewer.isframe" value = "false">
	    <param name = "information.debug" value = "true">
	    <param name = "viewer.namespace" value = "custom_namespace\\ozviewer">
	    </object>
	</div>
	<input type="hidden" name="bindData" id="bindData"/>
	<input type="hidden" name="bindParam" id="bindParam"/>
</body>
</html>