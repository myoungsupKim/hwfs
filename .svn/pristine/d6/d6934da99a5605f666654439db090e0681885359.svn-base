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
   *  2015.10.05.   kksoo        XP 버전 분리
   *  2015.11.06.   kksoo        VPN사용하지 않고 외부망에서 접속 허용
   *  2021.12.14.   ksm          신규런처 적용
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
	request.getServerName().equals("nfics.hanwhafoodist.co.kr")   ||
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
<style>
  .button {
    display: inline-block;
    border-radius: 4px;
    background-color: #01a7ad;
    border: none;
    color: #FFFFFF;
    text-align: center;
    font-size: 20px;
    padding: 10px;
    width: 300px;
    transition: all 0.5s;
    margin: 4px;
  }
  
  .button span {
    cursor: pointer;
    display: inline-block;
    position: relative;
    transition: 0.5s;
  }
  
  .button span:after {
    content: '\00bb';
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

  .button2 {
    display: inline-block;
    border-radius: 4px;
    background-color: #f0ad4e;
    border: none;
    color: #FFFFFF;
    text-align: center;
    font-size: 20px;
    padding: 10px;
    width: 100px;
    transition: all 0.5s;
    cursor: pointer;
    margin: 4px;
  }
  
  .button2 span {
    cursor: pointer;
    display: inline-block;
    position: relative;
    transition: 0.5s;
  }
  
  .button2 span:after {
    content: '\00bb';
    position: absolute;
    opacity: 0;
    top: 0;
    right: -20px;
    transition: 0.5s;
  }
  
  .button2:hover span {
    padding-right: 25px;
  }
  
  .button2:hover span:after {
    opacity: 1;
    right: 0;
  }

  .txt {
    display: inline-block;
    border-radius: 4px;
    background-color: #FFFFFF;
    border: none;
    color: #555;
    text-align: center;
    font-size: 24px;
    padding: 20px;
    width: 400px;
    transition: all 0.5s;
    margin: 10px;
  }
  .disabled {
    opacity: 1;
    display: inline-block;
    border-radius: 4px;
    background-color: #ccc;
    border: none;
    color: #FFFFFF;
    text-align: center;
    font-size: 20px;
    padding: 10px;
    width: 100px;
    transition: all 0.5s;
    cursor: default;
    margin: 4px;
    pointer-events: none;
    text-decoration: none;
  }
  .info {
    display: inline-block;
    color: #fff;
    text-align: left;
    font-size: 24px;
    background-color: #2196F3;
    width:700px;
    padding: 20px;
    margin: 10px;
  }
  .warnnig {
    display: inline-block;
    color: #fff;
    text-align: left;
    font-size: 24px;
    background-color: #d9534f;
    padding: 20px;
    margin: 5px;
  }
</style>
<SCRIPT LANGUAGE="JavaScript"> 
/**
 *  TPLService 사용자 정의 항목은 고객사 프로젝트 환경에 맞게 변경하세요.
 *  변수이름의 경우 do_property, do_method 시 사용하기 때문에 변수이름 변경시 do_property, do_method 함수 내의 변수이름도 변경 필요합니다.
 *  크롬(Chorme) 브라우저의 경우 window.open 으로 이 화면을  띄워야 close 를 할 수 있습니다.
 */
var strKey  = "HWFS";				    //key
var strADL = "HWFS.xadl";	 		//ADL
var strShortCut = "HWFC";				//Shortcut Name
var strServerFullPath   = window.location.href;

var strServerPath 	  = strServerFullPath.substring(0, strServerFullPath.indexOf('/install'));	//URL 기술

//port 값 얻기
var sPort;
var nPos = strServerPath.indexOf(":", strServerPath.indexOf("://")+1);
if (nPos == -1)
	sPort = "80";
else
	sPort = strServerPath.substring(nPos+1);

//운영서버인 경우는 SSL설정을 위해 포트 제거
if(strServerPath.indexOf("localhost") == -1 && strServerPath.indexOf("127.0.0.1") == -1 &&
   strServerPath.indexOf("172.16.1.121") == -1 && strServerPath.indexOf("test.hanwhafoodist.co.kr") == -1) {
	strServerPath = strServerPath.replace(":" + sPort, "");
	//https로 변경 : SSL 적용 후
	strServerPath = strServerPath.replace("http://", "https://");
}

var strShortCutIcon = strServerPath+"/install/img/" + strKey + ".ico";				//Shortcut Icon
var strNexaFilePath = strServerPath + "/install/xplatform/download";   //TPLSvc_Setup, XPLATFORM Engine file 위치
var bOnError = false;
var XPLATFORM_CAB_VER = "2014,7,29,1";	//version
var timeOut=null;						//window 닫기 위한 setTimeOut변수
var chkInstallTimeOut=null;				//인스톨 검사 setTimeOut변수
var blnInstallOn=true;					//인스톨 진행 여부
var strVersion = "9.2.0.330";                            //설치되는 버젼 정보를 비교하기 때문에 XPLATFORM 버젼 명시
 //var strXPVersion = "9.2.2";                              //제품버젼에 따라 참조되는 엔진의 경로가 다르기 때문에 버젼 명시
 //var strXPVersion = "9.2.1";    
var strXPVersion = "9.2"; 
//     var strComponentPath = "%USERAPPLOCAL%\\newLauncher_Test\\Component\\";                                                		//컴포넌트 위치    
var strComponentPath = "%INSTALLROOT%/HWFC";		//C:\Users\[username]\AppData\LocalLow\TOBESOFT\HWFC에 설치
var strLoadingimage = strServerPath+"/install/img/loading.gif";	 // data loading 구동 이미지
var strSplashimage = strServerPath+"/install/img/loading_img.gif";      // application 구동 이미지
//     var strWallpapericon = strServerPath + "img/xicon.ico";        //아이콘 경로
var strWallpapericon = strServerPath + "/img/xicon2.ico";        //아이콘 경로
var strWallpaperposition = "desktop";                        //아이콘 위치 지정 "startmenu"/ "startup" / "programs" / "desktop" 중 택일함 
var strLauncherVersion = "1,1,0,26";                            //런처 버전
var bOnlyone = false;                                           // nexacro only 속성 설정(true/false)
var bMakeShortcut = true;                                      
var bAddWebInfo = true;
var bEndClose = true;               							//완료 후 창닫기 여부
var strErrFile = "";
// get 방식으로 Parameter 전달 받은 값을 Application.Variable에 전달하는 방식 예제
var strUserId;
var strIpAddr;
var strGlobalvalue;

strADL = strServerPath + "/xui/" + strADL;  //엑스플랫폼 애플리케이션 ADL 경로를 지정하는 속성
 
//     var strComponentPath = "%USERAPPLOCAL%\\newLauncher_Test\\Component\\";                                                		//컴포넌트 위치    
//     var strWallpapericon = strServerPath + "img/xicon.ico";        //아이콘 경로

if(strServerPath.indexOf("localhost") != -1 || strServerPath.indexOf("127.0.0.1") != -1)
{
	strKey = strKey + "_LOCAL";
	strShortCut = strShortCut + "_L";
//		XLauncher.makeshortcut(strShortCut + " 로컬", strServerPath+"/install/img/" + strKey + ".ico", "desktop");		
}
else if(strServerPath.indexOf("172.16.1.121") != -1 || strServerPath.indexOf("test.hanwhafoodist.co.kr") != -1)
{
	strKey = strKey + "_DEV";
	strShortCut = strShortCut + "_D";
//		XLauncher.makeshortcut(strShortCut + " 개발", strServerPath+"/install/img/" + strKey + ".ico", "desktop");		
}	
else {
	strKey = strKey;
//		XLauncher.makeshortcut(strShortCut, strServerPath+"/install/img/" + strKey + ".ico", "desktop");
}

// 설치 CallBack
function nexaCallBack(str,msg,downURL)
{
	switch(str) {
		case "newlanucher" :			// new Launcher 설치 완료
			var aDom = document.getElementById("linklaucher");
			aDom.className = "disabled";
			aDom.innerHTML = "설치완료";
			break;
		case "xplatform" :				// nexacro engine 설치 완료
			var aDom = document.getElementById("linkEngine");
			aDom.className = "disabled";
			aDom.innerHTML = "설치완료";
			break;
		case "EngineDownload" :			// engine 미설치
			var tdCon = document.getElementById("errorDiv")
			tdCon.innerHTML = msg;
			tdCon = document.getElementById("linkEngine");
			tdCon.href = downURL;
			break;
		case "TPLDownloadNewLauncher" :	// TPLService 미설치
			var tdCon = document.getElementById("errorDiv")
			tdCon.innerHTML = msg;
			tdCon = document.getElementById("linkEngine");
			tdCon.href = downURL;
			break;
		case "close" :					// 처리끝
			var tdCon = document.getElementById("errorDiv")
			tdCon.innerHTML = msg; 
			fn_close();
			break;
		case "error" :					// 종료
			var tdCon = document.getElementById("errorDiv")
			tdCon.innerHTML = msg;
			break;
		default :
	}
}

//GET방식으로 넘어온 값을 가져온다.
function getRequest(param)
{
	if(location.search){ //if address has parameters, 
		var baseRequest = location.search.substr(1);
		//alert("baseRequest : " + baseRequest);
		var arrVars = baseRequest.split("&"); 
		//alert("arrVars : " + arrVars);
		for(i=0;i<arrVars.length;i++){ 
			var tmpVar = baseRequest.split("&")[i].split("="); 
			if(param==tmpVar[0]) {
				 //alert("tmpVar[1] : " + tmpVar[1]);
				return tmpVar[1]; 
			}
		} 
	} 
	return null; 
}

strUserId = "evTest";
strIpAddr = "avTest";
strGlobalvalue = "g_SystemId:g=" + strKey;

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
  <script type="text/javascript" src="./newLauncher.js" charset="UTF-8"></script>  
</HEAD>
<% if (canAccess) { %>
<BODY style="background:#fffdf1;">
<div style=" font-size:smaller; position:absolute; width:300px; height:200px; top:30%; left:50%; margin-left:-330px; margin-top:-100px;">
	<table width="648" height="630">
		<tr>
			<td background="./img/system_bg.jpg" style="padding:100px 45px 10px 45px">
				<table width="100%" style="font-family:dotum;font-size:12px;font-color:#444444;">				
					<tr>
						<td colspan="2" style="line-height:25px;"><img src="./img/insu_down_list_icon1.gif">자동으로 파일이 다운로드 되지 않을 경우 설치 버튼을 눌러 파일을 다운로드 후 설치를 진행해 주시기 바랍니다.</td>
					</tr>
					<tr>
						<td colspan="2" height="10px"></td>
					</tr>
					<tr>
						<td colspan="2" style="line-height:25px;"><img src="./img/insu_down_list_icon1.gif">설치 후에는 새로고침 또는 재접속 하여 확인하시기 바랍니다.</td>
					</tr>
					<tr>
						<td colspan="2" height="10px"></td>
					</tr>
					<tr>
						<td align="center">
							<button type="button" class="button" style="vertical-align:middle">통합설치프로그램</button>
						</td>
						<td align="center">
							<a id="linkAll" class="button2" style="background-color:#01a7ad;" href="./installation/Setup_HWFC.exe">설치</a>
						</td>
					</tr>
					<tr>
						<td colspan="2" height="10px"></td>
					</tr>
					<tr>
						<td align="center">
							<button type="button" class="button" style="vertical-align:middle">New Launcher</button>
						</td>
						<td align="center">
							<a id="linklaucher" class="button2" href="./xplatform/download/TPLSvc_Setup.exe">설치</a>
						</td>
					</tr>
					<tr>
						<td colspan="2" height="10px"></td>
					</tr>
					<tr>
						<td align="center">
							<button type="button" class="button" style="vertical-align:middle">XPLATFORM Engine</button>
						</td>
						<td align="center">
							<a id="linkEngine" class="button2" href="./xplatform/download/XPLATFORM9.2_SetupEngine_hanwharesort.exe">설치</a>
						</td>
					</tr>
					<tr>
						<td colspan="2" height="10px"></td>
					</tr>
					<tr>
						<td colspan="2" id="errorDiv" style="line-height:25px;"></td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
</div>
</BODY>
<%} else { %>
<body>
<br/>
<h3>
외부망에서는 접근할 수 없습니다.<br/><br/>
<br/>
<br/>
<br/>
</h3>
</body>
<%}%>
</HTML>