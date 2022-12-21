<%@ page language="java" contentType="text/html; charset=UTF-8"  %>
<%
  /**
   * Component 설치 페이지
   * @ClassName comp.jsp
   * @Description component JSP
   * @Modification-Information
   *    수정일       수정자              수정내용
   *  ----------   ----------   -------------------------------
   *  2015.07.31.   kksoo        기본 Component 설치 페이지 구성
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
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Component Install Page</title>
<script type="text/javascript">
//나모 컴포넌트 설치 검사
function checkNamoInstall () {
	var blnInstalled = false;
	try {
		var namo = new ActiveXObject("NamoWeCtl.0117150001.7.0"); //한화호텔 ProgID
		if(namo)
        	blnInstalled = true;
    }
	catch(ex) {
		alert(ex.message);
	}
	return blnInstalled;
}

function fn_load() {
	var blnInstalled = checkNamoInstall ();
	if(blnInstalled == true) {
		 installSatus.innerHTML = "나모 컴포넌트가 정상적으로 설치되었습니다.";
		alert("나모 컴포넌트가 정상적으로 설치되었습니다.");
	}
	else {
		alert("나모 컴포넌트가 정상적으로 설치되지 않았습니다.");
	}

}
</script>
</head>
<body onload="fn_load()">
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
						<td height="8px"></td>
					</tr>					
					<tr>
						<td style="line-height:25px;"><img src="./img/insu_down_list_icon1.gif">윈도우 XP서비스팩2 사용자께서는 주소 표시줄 아래 경고문구<br><font color="#d55900">"이 사이트에서...여기를 클릭하십시요"</font>를 선택하시어, ACTIVE X 컨트롤을 설치하시기 바랍니다.</td>
					</tr>
					<tr>
						<td height="8px"></td>
					</tr>					
					<tr>
						<td style="line-height:25px;"><img src="./img/insu_down_list_icon1.gif">상기와 같은 설치여부를 묻는 경고창이나 경고문구가 나타나지 않으면 정상적으로 설치된 것입니다.</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
</div>
<div id="installSatus" style=" font-family:dotum; font-size:14px; text-align:center; position:absolute; width:640px; height:100px; top:30%; left:50%; margin-left:-330px; margin-top:-150px;">
</div>

<script language="JavaScript">
//Namo 7
document.write('<OBJECT ID="Wec" CLASSID="CLSID:D53F36BF-F63A-4B2F-8B7C-C40B428C3A5D" WIDTH="0" HEIGHT="0" '
		+ 'CodeBase="./namo/NamoWec.cab#Version=7,0,3,41"'
		+ '</OBJECT>');

</script>
</body>
</html>

