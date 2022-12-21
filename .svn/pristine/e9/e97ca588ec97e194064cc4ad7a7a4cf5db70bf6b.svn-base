<%@ page language="java" contentType="text/html; charset=UTF-8"  %>
<HTML>
<HEAD>
<TITLE>로그인</TITLE>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<SCRIPT LANGUAGE="JavaScript"> 
var sKey = "HWFS";				//key
var sXadl = "HWFS.xadl";	 	//ADL
var Server_FullPath   = window.location.href;
var Server_Path 	  = Server_FullPath.substring(0, Server_FullPath.indexOf('/install'));	//URL 기술

function fn_onload()
{  	
	npXPlatformPlugin.autosize = true;
	npXPlatformPlugin.key = sKey;
	npXPlatformPlugin.xadl = Server_Path + "/xui/" + sXadl;
	npXPlatformPlugin.run();
	//fn_onresize();
}

function fn_onresize()
{
	var w = window.innerWidth;
	var h = window.innerHeight;

	npXPlatformPlugin.width = w;
	npXPlatformPlugin.height = h;
	
	//npXPlatformPlugin.callscript("af_browserResize("+w+", "+h+")");
}

function npXPlatformPlugin_addlog(strMsg)
{
}

function npXPlatformPlugin_beforeexit()
{
}

function npXPlatformPlugin_communication(bStart)
{
}

function npXPlatformPlugin_error(nError, strErrMsg)
{
	//alert(strErrMsg);
}

function npXPlatformPlugin_exit()
{
}

function npXPlatformPlugin_load(strURL)
{
	//npXPlatformPlugin.callscript("af_setEmbededBorder()");
}

function npXPlatformPlugin_loadingglobalvariables(strURL)
{
}

function npXPlatformPlugin_loadtypedefinition(strURL)
{
}

function npXPlatformPlugin_usernotify(nNotifyID, strMsg)
{
}

</SCRIPT> 
</HEAD>
<BODY style="overflow:hidden;margin:0px;padding:0px;" onload="fn_onload()" onresize="fn_onresize()">
<SCRIPT LANGUAGE="JavaScript">
//XPLATFORM Engine
document.write('<embed ID="npXPlatformPlugin" type="application/xplatform9.2-plugin" width="0" height="0" ' + 
               'addlog="npXPlatformPlugin_addlog" ' +
               'beforeexit="npXPlatformPlugin_beforeexit" ' +
               'communication="npXPlatformPlugin_communication" ' +
               'error="npXPlatformPlugin_error" ' +
               'exit="npXPlatformPlugin_exit" ' +
               'load="npXPlatformPlugin_load" ' +
               'loadingglobalvariables="npXPlatformPlugin_loadingglobalvariables" ' +
               'loadtypedefinition="npXPlatformPlugin_loadtypedefinition" ' +
               'usernotify="npXPlatformPlugin_usernotify"> ' +
		       '</embed>');
</SCRIPT>
</BODY>
</HTML>