<%@ page language="java" contentType="text/html; charset=UTF-8"  %>
<%
  /**
   * HWFC 통합영업 설치 페이지
   * @ClassName hwfc.jsp
   * @Description hwfc JSP
   * @Modification-Information
   *    수정일       수정자              수정내용
   *  ----------   ----------   -------------------------------
   *  2015.07.31.   kksoo        기존 설치 페이지 재구성
   *  2015.08.04.   kksoo        내부망에서만 접속할 수 있도록 구성 
   *  2015.09.10.   kksoo        도메인 적용
   *  2015.09.24.   kksoo        SSL 적용을 위해 수정 (port제거)
   *
   * @author FC종합전산구축 : AA kksoo
   * @since 2015.03. 23.
   * @version 1.0
   * @see
   * 
   *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
   */
%>
<%
//no cache 설정
response.setHeader("Cache-Control", "no-cache, must-revalidate");

boolean canAccess = false; //오픈 시 false로 변경할 것
//로컬 서버, 내부 개발서버, 내부 운영서버 IP로 접근할 수 있도록 함
if (request.getServerName().equals("localhost")       ||
	request.getServerName().equals("test.hanwhafoodist.co.kr")    ||
	request.getServerName().equals("hwfc.hanwhafoodist.co.kr")    ||
	request.getServerName().equals("127.0.0.1")    ||
	request.getServerName().equals("172.16.1.121")    ||
	request.getServerName().equals("172.16.1.75") ||
	request.getServerName().equals("172.16.1.68") ||
	request.getServerName().equals("172.16.1.69"))
	canAccess = true;

%>

<HTML>
<HEAD>
<TITLE>HWFC Install Page</TITLE>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<SCRIPT LANGUAGE="JavaScript"> 
var sKey  = "HWFS";				    //key
var sXadl = "HWFS.xadl";	 		//ADL
var sShortCut = "HWFC";				//Shortcut Name
var Server_FullPath   = window.location.href;
var Server_Path 	  = Server_FullPath.substring(0, Server_FullPath.indexOf('/install'));	//URL 기술
var bOnError = false;
var XPLATFORM_CAB_VER = "2014,7,29,1";	//version
var timeOut=null;						//window 닫기 위한 setTimeOut변수
var chkInstallTimeOut=null;				//인스톨 검사 setTimeOut변수
var blnInstallOn=true;					//인스톨 진행 여부

function fn_namoOnError() {
	alert("fn_namoOnError");
}

function fn_objectOnError() {
	//alert("fn_objectOnError");
	bOnError = true;
}

//나모 컴포넌트 설치 검사
function checkNamoInstall () {
	var blnInstalled = false;
	try {
		var namo = new ActiveXObject("NamoWeCtl.0117150001.7.0"); //한화호텔 ProgID
		if(namo) {
        	blnInstalled = true;
        	namo =  null;
		}
    }
	catch(ex) {
		/*
		if (!confirm("설치를 계속 진행하시겠습니까?")) {
			//설치 확인 이벤트 해제
			clearTimeout (chkInstallTimeOut);
			blnInstallOn = false;		
		}*/
	}
	return blnInstalled;
}

function fn_load()
{  
	if(bOnError == false) {
		//마지막에 설치되는 나모설치를 확인한다.
		var blnInstalled = checkNamoInstall ();
		if(blnInstalled == true) {
			//설치 확인 이벤트 해제
			if (chkInstallTimeOut != null) clearTimeout (chkInstallTimeOut);
			chkInstallTimeOut = null;
			
			fn_launchX();
		
			//현재 화면을 닫도록 이벤트 발생
			timeOut = setTimeout(function(){fn_close();}, 1000);
		}
		else if (blnInstallOn) {
			//나모 설치 확인을 위한 이벤트 발생
			if (chkInstallTimeOut == null) chkInstallTimeOut = setTimeout(function(){fn_load();}, 2000);			
		}
	}
}

function fn_launchX()
{
	//port 값 얻기
	var sPort;
	var nPos = Server_Path.indexOf(":", Server_Path.indexOf("://")+1);
	if (nPos == -1)
		sPort = "80";
	else
		sPort = Server_Path.substring(nPos+1);
	
	//운영서버인 경우 기본 포트 8091로 설정 --> SSL로 사용 안함
	//if(Server_Path.indexOf("localhost") == -1 && Server_Path.indexOf("127.0.0.1") == -1 && sPort == "80")
	//	Server_Path +=  ":8091";
	
	//운영서버인 경우는 SSL설정을 위해 포트 제거
	if(Server_Path.indexOf("localhost") == -1 && Server_Path.indexOf("127.0.0.1") == -1 &&
	   Server_Path.indexOf("172.16.1.121") == -1 && Server_Path.indexOf("test.hanwhafoodist.co.kr") == -1) {
		Server_Path =  Server_Path.replace(":" + sPort, "");
		//https로 변경 : SSL 적용 후
		Server_Path = Server_Path.replace("http://", "https://");
	}
	
	//alert("Server_Path : " + Server_Path + ", Server_Port : " + sPort);

	XLauncher.xadl = Server_Path + "/xui/" + sXadl;
	//alert("Server_Path Full : " + Server_Path + "/xui/" + sXadl);
	XLauncher.onlyone = false;
	XLauncher.splashimage = Server_Path+"/install/img/loading_img.gif";      // application 구동 이미지
	XLauncher.splashmessage = "none";                                          // application 메시지
	
	if(Server_Path.indexOf("localhost") != -1 || Server_Path.indexOf("127.0.0.1") != -1)
	{
		XLauncher.key = sKey + "_LOCAL";
		XLauncher.makeshortcut(sShortCut + " 로컬", Server_Path+"/install/img/" + sKey + ".ico", "desktop");		
	}
	else if(Server_Path.indexOf("172.16.1.121") != -1 || Server_Path.indexOf("test.hanwhafoodist.co.kr") != -1)
	{
		XLauncher.key = sKey + "_DEV";
		XLauncher.makeshortcut(sShortCut + " 개발", Server_Path+"/install/img/" + sKey + ".ico", "desktop");		
	}	
	else {
		XLauncher.key = sKey;
		XLauncher.makeshortcut(sShortCut, Server_Path+"/install/img/" + sKey + ".ico", "desktop");
	}	

	XLauncher.componentpath = "%INSTALLROOT%/HWFC";		//C:\Users\[username]\AppData\LocalLow\TOBESOFT\HWFC에 설치
	XLauncher.loadingimage = Server_Path+"/install/img/loading.gif";	 // data loading 구동 이미지
	XLauncher.globalvalue  = "g_SystemId:g=" + sKey;
	XLauncher.launch();
}

function fn_close()
{
	if (timeOut != null) clearTimeout (timeOut);
	if (chkInstallTimeOut != null) clearTimeout (chkInstallTimeOut);
	
	if( (navigator.appVersion.indexOf("MSIE 7.0")>=0)	||
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
<% if (canAccess) { %>
<BODY onload="fn_load()" style="background:#fffdf1;">
<div style=" font-size:smaller; position:absolute; width:300px; height:200px; top:30%; left:50%; margin-left:-330px; margin-top:-100px;">
	<table width="648" height="364">
		<tr>
			<td background="./img/system_bg.jpg" style="padding:170px 45px 45px 45px">
				<table width="100%" style="font-family:dotum;font-size:12px;font-color:#444444;">
					<tr>
						<td><img src="./img/insu_down_list_icon1.gif">프로그램 설치여부를 묻는 보안경고창이 나타나면 반드시 "<font color="#d55900" style="font-weight:bold">예</font>"를 선택하여 주시기 바랍니다.</td>
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
<SCRIPT LANGUAGE="JavaScript">
//  XPLATFORM Engine
document.write('<OBJECT ID="XPlatformAX" CLASSID="CLSID:43C5FE00-DD32-4792-83DB-19AE4F88F2A6" width="0" height="0" '
		+ 'CodeBase="./xplatform/download/XPLATFORM9.2_SetupEngine.cab#VERSION='+XPLATFORM_CAB_VER+'" onError="fn_objectOnError()">'
		+ '</OBJECT>');

//  XPLATFORM Launcher
document.write('<OBJECT ID="XLauncher" CLASSID="CLSID:A30D5481-7381-4dd9-B0F4-0D1D37449E97" width="0" height="0" '
		+ 'codebase="./xplatform/download/XPLATFORM9.2_XPLauncher.cab#VERSION='+XPLATFORM_CAB_VER+'" onError="fn_objectOnError()">'
		+ '</OBJECT>');

//Namo 7
document.write('<OBJECT ID="Wec" CLASSID="CLSID:D53F36BF-F63A-4B2F-8B7C-C40B428C3A5D" WIDTH="0" HEIGHT="0" '
		+ 'CodeBase="./namo/NamoWec.cab#Version=7,0,3,41"'
		+ '</OBJECT>');

</SCRIPT>
</BODY>
<%} else { %>
<body>
<br/>
<h3>
외부망에서는 접근할 수 없습니다.<br/><br/>
</h3>
</body>
<%}%>
</HTML>