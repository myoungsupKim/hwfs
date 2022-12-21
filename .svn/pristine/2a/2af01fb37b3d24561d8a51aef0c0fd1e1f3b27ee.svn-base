<%@ page language="java" contentType="text/html; charset=UTF-8"  %>
<%
  /**
   * FC통합영업 공개게시판 JSP
   * @ClassName openbbs.jsp
   * @Description openbbs JSP
   * @Modification-Information
   *    수정일       수정자              수정내용
   *  ----------   ----------   -------------------------------
   *  2015.08.18.   kksoo        최초 생성 - 사용자인증 없는 공개게시판
   *  2015.10.05.   kksoo        XP 버전 분리
   *
   * @author FC종합전산구축 : AA kksoo
   * @since 2015.03. 23.
   * @version 1.0
   * @see
   * 
   *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
   */
%>
<%@page session="false" %>	<!-- 세션을 생성하지 않는다. -->
<%
//no cache 설정
response.setHeader("Cache-Control", "no-cache, must-revalidate");
%>
<HTML>
<HEAD>
<TITLE>FC통합영업 공개게시판</TITLE>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<SCRIPT LANGUAGE="JavaScript"> 
var sKey = "WEB";			//key
var sXadl = "WEB.xadl";	 	//ADL
var Server_FullPath   = window.location.href;
var Server_Path 	  = Server_FullPath.substring(0, Server_FullPath.indexOf('/install'));	//URL 기술
var XPLATFORM_CAB_VER = "2014,7,29,1";	//version

function fn_onload()  
{  		
	fn_onresize();
	XPlatformAXCtrl.autosize = false;
	XPlatformAXCtrl.key = sKey;
	XPlatformAXCtrl.xadl = Server_Path + "/xui/" + sXadl;	
	XPlatformAXCtrl.run();
}  

function fn_onresize()
{
    var iwidth = document.body.offsetWidth; 
    var iheight = document.body.offsetHeight;
    
    if(iwidth == null){ 
    	iwidth = 1252;
    	iheight = 740;
    }
    
    XPlatformAXCtrl.width = iwidth - 4; 
    XPlatformAXCtrl.height = iheight - 4;
}

function fn_callform()
{
	var formid = document.getElementById("formid").value;
	
	XPlatformAXCtrl.callscript("af_callForm('"+formid+"')");
}

</SCRIPT> 

<SCRIPT LANGUAGE="JavaScript" FOR="XPlatformAXCtrl" EVENT="addlog(strMsg)">		
</SCRIPT>
<SCRIPT LANGUAGE="JavaScript" FOR="XPlatformAXCtrl" EVENT="beforeexit(bCloseFlag, bHandledFlag)">	
</SCRIPT>
<SCRIPT LANGUAGE="JavaScript" FOR="XPlatformAXCtrl" EVENT="communication(bStart)">		
</SCRIPT>
<SCRIPT LANGUAGE="JavaScript" FOR="XPlatformAXCtrl" EVENT="error(nError, strErrMsg)">	
</SCRIPT>
<SCRIPT LANGUAGE="JavaScript" FOR="XPlatformAXCtrl" EVENT="exit()">		
</SCRIPT>
<SCRIPT LANGUAGE="JavaScript" FOR="XPlatformAXCtrl" EVENT="load(strURL)">
	//XPlatformAXCtrl.callscript("af_setEmbededBorder()");
</SCRIPT>
<SCRIPT LANGUAGE="JavaScript" FOR="XPlatformAXCtrl" EVENT="loadingglobalvariables(strURL)">
	XPlatformAXCtrl.setvariablevalue("gv_temp", "sample::NamoWeb7ActiveX.xfdl");
</SCRIPT>
<SCRIPT LANGUAGE="JavaScript" FOR="XPlatformAXCtrl" EVENT="loadtypedefinition(strURL)">		
</SCRIPT>
<SCRIPT LANGUAGE="JavaScript" FOR="XPlatformAXCtrl" EVENT="usernotify(nNotifyID, strMsg)">	
</SCRIPT>

</HEAD>
<BODY style="overflow:hidden;margin:0px 0px 0px 0px;padding:0px;" onload="fn_onload()" onresize="fn_onresize()">
<SCRIPT LANGUAGE="JavaScript">
//  XPLATFORM Engine
document.write('<OBJECT ID="XPlatformAXCtrl" CLASSID="CLSID:EAED28F3-79C3-4941-BD38-5CD9128DD6B0" width="100%" height="100%" border="0" '
		+ 'CodeBase="./xplatform/download/XPLATFORM9.2_SetupEngine_hanwharesort.cab#VERSION='+XPLATFORM_CAB_VER+'" onError="fn_objectOnError()">'
		+ '</OBJECT>');
		
// Namo 7
document.write('<OBJECT ID="Wec" CLASSID="CLSID:D53F36BF-F63A-4B2F-8B7C-C40B428C3A5D" WIDTH="0" HEIGHT="0" '
		+ 'CodeBase="./namo/NamoWec.cab#Version=7,0,3,41"'
		+ '</OBJECT>');
</SCRIPT>
</BODY>
</HTML>