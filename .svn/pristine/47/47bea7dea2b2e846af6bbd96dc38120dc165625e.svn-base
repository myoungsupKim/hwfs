<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<%@ include file="/apagent/lib/config/config.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>전자결재 상세보기</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script>
var intervalID;
var childWindow;

function checkWindow() 
{
	//console.log('childWindow : ' + childWindow);
	//console.log('childWindow.closed : ' + childWindow.closed); //true(팝업창이 닫히면), false (팝업차이 떠있으면)
    if (childWindow && childWindow.closed)
    {
        //alert('자식창이 닫혔다. 부모창을 리로드 한다.');
		window.clearInterval(intervalID);
		window.location.reload();
    }
}



function goDetailViewPost()
{
	var instanceId = $("#instanceId").val().trim();
	if(instanceId == null || instanceId == "")
	{
		alert('instanceId 입력하시기 바랍니다.');
		$("#instanceId").focus();
		return;
	}
	
	var slo_p_ota = $("#slo_p_ota").val().trim();
	if(slo_p_ota == null || slo_p_ota == "")
	{
		alert('slo_p_ota 입력하시기 바랍니다.');
		$("#slo_p_ota").focus();
		return;
	}
	
	
	
	/**************
    //post popup
    **************/
    var myUrl = "http://"+ approvalHost + ":" + approvalPort; //245서버
    
    var sUrl  = myUrl + "/neo/modules/approval/apagent/channel/v4/view_" + agentCompanyAlias + ".mvc";
    var sName = "Popup1";
    var sMethod = "post";
    var nWindowWidth = 800;
    var nWindowHeight = 800;
    var sX = 10;
    var sY = 10;
    var sPosition = ",left=0,top=0";
    childWindow = window.open('about:blank',sName,"width="+nWindowWidth+",height="+nWindowHeight+",toolbar=no,location=no, scrollbars=yes, menubar=no,resizable=yes"+sPosition);
    
    
    document.f.method = sMethod;
    document.f.action = sUrl;
    document.f.target = sName;
       
    document.f.submit();
    childWindow.focus();
    intervalID = window.setInterval(checkWindow, 1000);
}

</script>
</head>
<body leftmargin="0" topmargin="0" scroll="no">
<br/>

전자결재 상세보기<br>
<form name="f">
	1. 전자결재 InstanceId( ex:1234567 ) :
	<br/>	
	<input type="text" id="instanceId" name="instanceId" value="" size="50"/>
	<br></br>
	2. OTA_ID : 
	<br/>
	<input type="text" id="slo_p_ota" name="slo_p_ota" value="" size="50"/>
	<br></br>
	<%-- 추가 파라메터 셋팅 - 시작 --%>
	<input type="hidden" id="showTitleBar" 	name="showTitleBar" value="false"></input>
	<input type="hidden" id="mode" 			name="mode" 		value="view"></input>
	<input type="hidden" id="popupYn" 		name="popupYn" 		value="1"></input>
	<input type="hidden" id="btn" 			name="btn" 			value="{showCancle:Y,showClosePopup:Y}"></input>
	<%-- 추가 파라메터 셋팅 - 끝 --%>
	<br/>
	<input type="button" name="goPost" value="상세보기" onclick="javascript:goDetailViewPost();">
</form>

</body>
<script type="text/javascript">
$().ready(function(){
});
</script>
</html>
