<%@ page language="java" contentType="text/html; charset=UTF-8"  %>
<HTML>
<HEAD>
<TITLE>Install Page</TITLE>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<SCRIPT LANGUAGE="JavaScript"> 
var sKey = "HWFS";				//key
var sXadl = "HWFS.xadl";	 	//ADL
var Server_FullPath   = window.location.href;
var Server_Path 	  = Server_FullPath.substring(0, Server_FullPath.indexOf('/install'));	//URL 기술

function fn_load()
{  
	var bInstallXLauncherPlugin = false;
	var bInstallXPlatformPlugin = false;
	
	for (var i=0; i<navigator.plugins.length; i++) {
		if (navigator.plugins[i].name == "XPLATFORM") {
			if (navigator.userAgent.indexOf("Opera") > -1) {				
				if (navigator.plugins[i].filename == "npXLauncherPlugin92.dll") {
					bInstallXLauncherPlugin = true;
				}
				if (navigator.plugins[i].filename == "npXLauncherPlugin92.dll") {
					bInstallXPlatformPlugin = true;
				}			
			} else {
				//alert(navigator.plugins[i][0].type.toLowerCase());
				if (navigator.plugins[i][0].type.toLowerCase() == "application/xplauncher9.2-plugin") {
					bInstallXLauncherPlugin = true;
				}
				if (navigator.plugins[i][0].type.toLowerCase() == "application/xplauncher9.2-plugin") {
					bInstallXPlatformPlugin = true;
				}				
			}			
		}
	}

	if (!(bInstallXLauncherPlugin && bInstallXPlatformPlugin)) {
		alert("Please install XPLATFORM Plugin and restart browser");
		location.href = "./xplatform/download/XPLATFORM9.2_SetupEngine.exe";
	} else {
		if (confirm("Launch XPLATFORM ?\n\nYes : Execute XPLATFORM browser\nNo  : Embeded Web browser")) {
			fn_launchX();
		} else {
			var query = "";	
			window.location.href = "./XPlatformPlugin.jsp?"+query;
		}
	}
}

function fn_launchX()
{  
	npXLauncherPlugin.key = sKey;
	npXLauncherPlugin.xadl = Server_Path + "/" + sXadl;
	npXLauncherPlugin.onlyone = false;
	npXLauncherPlugin.splashimage = Server_Path+"/install/img/loading_img.gif";      // application 구동 이미지
	npXLauncherPlugin.loadingimage = Server_Path+"/install/img/loading.gif";	 // data loading 구동 이미지
	npXLauncherPlugin.makeshortcut(sKey, Server_Path+"/install/img/" + sKey + ".ico", "desktop");		
	npXLauncherPlugin.globalvalue = "g_SystemId:g=" + sKey;
	npXLauncherPlugin.launch();
}

</SCRIPT> 
</HEAD>
<BODY onload="fn_load()">
<SCRIPT LANGUAGE="JavaScript">
//XPLATFORM Launcher
document.write('<embed ID="npXLauncherPlugin" type="application/xplauncher9.2-plugin" width="0" height="0"></embed>');
</SCRIPT>
</BODY>
</HTML>