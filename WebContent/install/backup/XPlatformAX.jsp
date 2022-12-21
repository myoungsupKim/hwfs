<%@ page language="java" contentType="text/html; charset=UTF-8"  %>
<HTML>
<HEAD>
<TITLE>실행</TITLE>
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
<BODY style="overflow:hidden;margin:0px;padding:0px;" onload="fn_onload()" onresize="fn_onresize()">
오픈할 화면경로를 입력하세요 : <input type="text" id="formid" style="width:400;" value="U_MAC::MAC10010E.xfdl"> <input type="button" value="호출" onclick="fn_callform();"><br>
<SCRIPT LANGUAGE="JavaScript">
//  XPLATFORM Engine
document.write('<OBJECT ID="XPlatformAXCtrl" CLASSID="CLSID:43C5FE00-DD32-4792-83DB-19AE4F88F2A6" width="100%" height="100%" border="0" '
		+ 'CodeBase="./xplatform/download/XPLATFORM9.2_SetupEngine.cab#VERSION='+XPLATFORM_CAB_VER+'" onError="fn_objectOnError()">'
		+ '</OBJECT>');
		
// Namo 7
document.write('<OBJECT ID="Wec" CLASSID="CLSID:D53F36BF-F63A-4B2F-8B7C-C40B428C3A5D" WIDTH="0" HEIGHT="0" '
		+ 'CodeBase="./namo/NamoWec.cab#Version=7,0,3,41"'
		+ '</OBJECT>');
</SCRIPT>
</BODY>
</HTML>