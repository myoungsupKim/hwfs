<%@ page language="java" contentType="text/html; charset=UTF-8"  %>
<%
  /**
   * FICS 설치 페이지
   * @ClassName fics.jsp
   * @Description fics JSP
   * @Modification-Information
   *    수정일       수정자              수정내용
   *  ----------   ----------   -------------------------------
   *  2015.07.31.   kksoo        기존 설치 페이지 재구성
   *  2015.09.10.   kksoo        도메인 적용
   *  2015.09.24.   kksoo        SSL 적용을 위해 수정 (port제거)
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
<%
//no cache 설정
response.setHeader("Cache-Control", "no-cache, must-revalidate");
%>
<HTML>
<HEAD>
<TITLE>FICS Install Page</TITLE>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<style>
.button {
  display: inline-block;
  border-radius: 4px;
  background-color: #f97878;
  border: none;
  color: #FFFFFF;
  text-align: center;
  font-size: 20px;
  width: 300px;
  height: 40px;
  transition: all 0.5s;
  cursor: pointer;
  margin: 4px;
}

.button span {
  cursor: pointer;
  display: inline-block;
  position: relative;
  transition: 0.5s;
}

.button span:after {
  content: '>>';
  position: absolute;
  opacity: 0;
  top: 0;
  right: -20px;
  transition: 0.5s;
}

.button:hover span {
  padding-right: 25px;
}

.button:hover span:after {
  opacity: 1;
  right: 0;
}
</style>
<SCRIPT LANGUAGE="JavaScript"> 
var sKey  = "FICS";				    //key
var sXadl = "FICS.xadl";	 		//ADL
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
	XLauncher.enginesetupkey = "{A40D9F11-567E-4779-AD57-BA947261D5ED}";	// 레스트리정보 설치/삭제시 프로그램에서 참조

	XLauncher.xadl = Server_Path + "/xui/" + sXadl;
	//alert("Server_Path Full : " + Server_Path + "/xui/" + sXadl);
	XLauncher.onlyone = false;
	XLauncher.splashimage = Server_Path+"/install/img/loading_img.gif";      // application 구동 이미지
	XLauncher.splashmessage = "none";                                          // application 메시지
	
	if(Server_Path.indexOf("localhost") != -1 || Server_Path.indexOf("127.0.0.1") != -1)
	{
		XLauncher.key = sKey + "_LOCAL";
		XLauncher.makeshortcut(sKey + " 로컬", Server_Path+"/install/img/" + sKey + ".ico", "desktop");		
	}
	else if(Server_Path.indexOf("172.16.1.121") != -1 || Server_Path.indexOf("test.hanwhafoodist.co.kr") != -1)
	{
		XLauncher.key = sKey + "_DEV";
		XLauncher.makeshortcut(sKey + " 개발", Server_Path+"/install/img/" + sKey + ".ico", "desktop");		
	}	
	else {
		XLauncher.key = sKey;
		XLauncher.makeshortcut(sKey, Server_Path+"/install/img/" + sKey + ".ico", "desktop");
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

	if( (navigator.appVersion.indexOf("MSIE 7.0")>=0) ||
		(navigator.appVersion.indexOf("MSIE 8.0")>=0) ||
		(navigator.appVersion.indexOf("MSIE 9.0")>=0) ||
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

function prgmMsg2(ev){
	var mBox = document.getElementById("msgBoxLayer2");
	if(ev == "over"){
		mBox.style.display = "block";
		mBox.style.width = "423px";
		mBox.style.height = "87px";
		mBox.style.position = "relative";
		mBox.style.left = "100px";
		if ( navigator.appVersion.indexOf("MSIE") >= 0
				|| navigator.appVersion.indexOf("Trident") >= 0 ) {
			mBox.style.top = "-265px";
		} else {
			mBox.style.top = "-265px";
		}
		mBox.style.background = "url(./img/tooltip.png) no-repeat left top"; 
		
	}
	if(ev == "out"){
		mBox.style.display = "none";
	}
}
</SCRIPT>
</HEAD>

<BODY onload="fn_load()" style="background:#fffdf1;">
<div style=" font-size:smaller; position:absolute; width:300px; height:200px; top:30%; left:50%; margin-left:-330px; margin-top:-100px;">
	<table width="648" height="630">
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
					<tr>
						<td height="20px"></td>
					</tr>
					<tr>
						<td style="line-height:25px;"><img src="./img/insu_down_list_icon1.gif">사용자 환경에 따라 자동 설치가 불가능한 경우에는 <br><font color="#d55900">"통합설치프로그램 다운로드"</font>를 클릭하시면 자동으로 설치가 진행됩니다.</td>
					</tr>
					<tr>
						<td align="center">
						<a href = "./installation/Setup_FICS.exe">
							<button type="button" class="button" style="vertical-align:middle" onmouseover="prgmMsg2('over');" onmouseout="prgmMsg2('out');" onfocus="prgmMsg2('over');" onblur="prgmMsg2('out');">통합설치프로그램 다운로드</button>
						</a>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<div id="msgBoxLayer2" style="display:none;text-align:center;padding-top:10px">
		파일 다운로드 안내창에서 <font color="#FF7300"><strong>[저장] 버튼</strong></font>을 눌러 PC에 저장하신 후 <br><font color="#FF7300">PC에 저장된 "통합설치프로그램(Setup_FICS.exe)"을 실행</font>하여 <br>안내에 따라 설치하신 후 이용하시기 바랍니다.
	</div>
</div>
<SCRIPT LANGUAGE="JavaScript">
//  XPLATFORM Engine
document.write('<OBJECT ID="XPlatformAX" CLASSID="CLSID:EAED28F3-79C3-4941-BD38-5CD9128DD6B0" width="0" height="0" '
		+ 'CodeBase="./xplatform/download/XPLATFORM9.2_SetupEngine_hanwharesort.cab#VERSION='+XPLATFORM_CAB_VER+'" onError="fn_objectOnError()">'
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
</HTML>