<%@ page language="java" contentType="text/html; charset=UTF-8"  %>
<HTML>
<HEAD>
<TITLE>Install Page</TITLE>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<SCRIPT LANGUAGE="JavaScript"> 
var sKey  = "HWFS";				    //key
var sXadl = "HWFS.xadl";	 		//ADL
var Server_FullPath   = window.location.href;
var Server_Path 	  = Server_FullPath.substring(0, Server_FullPath.indexOf('/install'));	//URL 기술
var bOnError = false;
var XPLATFORM_CAB_VER = "2014,7,29,1";	//version

function fn_namoOnError() {
	alert("fn_namoOnError");
}

function fn_objectOnError() {
	//alert("fn_objectOnError");
	bOnError = true;
}

function fn_load()
{  
	if(bOnError == false) {  
		fn_launchX();
	}
}

function fn_launchX()
{
	//alert("Server_Path : " + Server_Path);

	XLauncher.xadl = Server_Path + "/xui/" + sXadl;
	//alert("Server_Path Full : " + Server_Path + "/xui/" + sXadl);
	XLauncher.onlyone = false;
	XLauncher.splashimage = Server_Path+"/install/img/loading_img.gif";      // application 구동 이미지
	XLauncher.splashmessage = "none";                                          // application 메시지
	
	if(Server_Path == "http://localhost:8080")
	{
		XLauncher.key = sKey + "_LOCAL";
		XLauncher.makeshortcut(sKey + " 로컬", Server_Path+"/install/img/" + sKey + ".ico", "desktop");		
	}
	else if(Server_Path == "http://172.16.1.121:8091")
	{
		XLauncher.key = sKey + "_DEV";
		XLauncher.makeshortcut(sKey + " 개발", Server_Path+"/install/img/" + sKey + ".ico", "desktop");		
	}	
	else if(Server_Path == "http://172.25.7.199:8080")
	{
		XLauncher.key = sKey + "_DEV";
		XLauncher.makeshortcut(sKey + " 개발", Server_Path+"/install/img/" + sKey + ".ico", "desktop");		
	}	
	else {
		XLauncher.key = sKey;
		XLauncher.makeshortcut(sKey, Server_Path+"/install/img/" + sKey + ".ico", "desktop");
	}	
	
	XLauncher.loadingimage = Server_Path+"/install/img/loading.gif";	 // data loading 구동 이미지
	XLauncher.globalvalue  = "g_SystemId:g=" + sKey;
	XLauncher.launch();
	
	//fn_close();
}

function fn_close()
{
	if( (navigator.appVersion.indexOf("MSIE 7.0")>=0)  ||
		(navigator.appVersion.indexOf("MSIE 8.0")>=0)  ||
		(navigator.appVersion.indexOf("MSIE 9.0")>=0)  ||
		(navigator.appVersion.indexOf("MSIE 10.0")>=0) ||
		(navigator.userAgent.indexOf("Trident")>=0)
	  )
	{
		window.open('about:blank','_self').close();
	} else {
	    window.opener = self;
	    self.close();
	}
}
</SCRIPT>
</HEAD>

<BODY onload="fn_load()" style="background:#fffdf1;">
<SCRIPT LANGUAGE="JavaScript">
//  XPLATFORM Engine
document.write('<OBJECT ID="XPlatformAX" CLASSID="CLSID:43C5FE00-DD32-4792-83DB-19AE4F88F2A6" width="0" height="0" '
		+ 'CodeBase="./xplatform/download/XPLATFORM9.2_SetupEngine.cab#VERSION='+XPLATFORM_CAB_VER+'" onError="fn_objectOnError()">'
		+ '</OBJECT>');

//  XPLATFORM Launcher
document.write('<OBJECT ID="XLauncher" CLASSID="CLSID:A30D5481-7381-4dd9-B0F4-0D1D37449E97" width="0" height="0" '
		+ 'codebase="./xplatform/download/XPLATFORM9.2_XPLauncher.cab#VERSION='+XPLATFORM_CAB_VER+'" onError="fn_objectOnError()">'
		+ '</OBJECT>');
		
// Namo 7
document.write('<OBJECT ID="Wec" CLASSID="CLSID:D53F36BF-F63A-4B2F-8B7C-C40B428C3A5D" WIDTH="0" HEIGHT="0" '
		+ 'CodeBase="./namo/NamoWec.cab#Version=7,0,3,41"'
		+ '</OBJECT>');
</SCRIPT>
<div style=" font-size:smaller; position:absolute; width:300px; height:200px; top:30%; left:50%; margin-left:-330px; margin-top:-100px;">
	<table width="648" height="364">
		<tr>
			<td background="./img/system_bg.jpg" style="padding:170px 45px 45px 45px">
				<table width="100%" style="font-family:dotum;font-size:12px;font-color:#444444;">
					<tr>
						<td><img src="./img/insu_down_list_icon1.gif">암호화 프로그램 설치여부를 묻는 보안경고창이 나타나면 반드시 "<font color="#d55900" style="font-weight:bold">예</font>"를 선택하여 주시기 바랍니다.</td>
					</tr>
					<tr>
						<td height="25px">&nbsp;&nbsp;"<img src="./img/insu_down_list_icon2.gif">아니오"를 선택하시면 보안을 위해 사용이 제한됩니다.</td>
					</tr>
					<tr>
						<td height="20px"></td>
					</tr>					
					<tr>
						<td style="line-height:25px;"><img src="./img/insu_down_list_icon1.gif">윈도우 XP서비스팩2 사용자께서는 주소 표시줄 아래 경고문구<br><font color="#d55900">"이 사이트에서...여기를 클릭하십시요"</font>를 선택하시어, ACTIVE X 컨트롤을 설치하시기 바랍니다.</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
</div>
</BODY>
</HTML>