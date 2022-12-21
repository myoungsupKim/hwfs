<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
  /**
   * 그룹웨어 결재진행상태/결재문서상세 보기 IF JSP
   * @ClassName linkGwViewIF.jsp
   * @Description linkGwViewIF JSP
   * @Modification-Information
   *    수정일       수정자              수정내용
   *  ----------   ----------   -------------------------------
   *  2015.03.23.   kksoo        최초 생성
   *  2015.06.17.   kksoo        XPLATFORM POPUP으로부터 호출하고 그룹웨어 페이지 오픈 후 팝업이 close되도록 개선(WebBrowser 컴포넌트 이용 방식)
   *
   * @author FC종합전산구축 : AA kksoo
   * @since 2015.03. 23.
   * @version 1.0
   * @see
   * 
   *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
   */
%>
<%@ page import="com.hwfs.sc.cmn.service.GwIfService, org.springframework.web.context.*
			  , org.springframework.web.context.support.WebApplicationContextUtils" %>    
<%
//XplatformExcepHndlr Bean을 얻는다.
ServletContext sc = pageContext.getServletContext();
WebApplicationContext wac = WebApplicationContextUtils.getRequiredWebApplicationContext(sc);
GwIfService gwIfService = (GwIfService)wac.getBean("/sc/cmn/gwIfService");

//SLO연계를 위한 OTA ID를 얻는다.
String otaId = gwIfService.selectOtaId((HttpServletRequest)request);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/apagent/lib/config/config.jsp" %>

<title>그룹웨어 결재진행상태/결재문서상세 보기 IF</title>
<!-- XPLATFORM 화면과 연동을 위한 스크립트 -->
<script type="text/javascript" src="/js/cmn/WebIF.js"></script>

<script type="text/javascript">

/**
 * 결재진행상태 보기를 호출한다.
 */
function goStatusViewPost()
{
	var instanceId = $("#instanceId").val().trim();
	if(instanceId == null || instanceId == "")
	{
		alert('instanceId 값이 없습니다.');
		return;
	}
	
	var slo_p_ota = $("#slo_p_ota").val().trim();
	if(slo_p_ota == null || slo_p_ota == "")
	{
		alert('slo_p_ota 값이 없습니다.');
		return;
	}
	
	/**************
     *post popup
     **************/
    var myUrl = "http://"+ approvalHost + ":" + approvalPort;
    
    var sUrl  = myUrl + "/neo/modules/approval/apagent/channel/v4/showFlowChart_" + agentCompanyAlias + ".mvc";
    var sName = "statusViewPopup";
    var sMethod = "post";
    var nWindowWidth = 800;
    var nWindowHeight = 800;
    var sX = 10;
    var sY = 10;
    var sPosition = ",left=0,top=0";
    oPopup = window.open('about:blank',sName,"width="+nWindowWidth+",height="+nWindowHeight+",toolbar=no,location=no, scrollbars=yes, menubar=no,resizable=yes"+sPosition);
    
    document.frm.method = sMethod;
    document.frm.action = sUrl;
    document.frm.target = sName;
       
    document.frm.submit();
    oPopup.focus();
}

/**
 * 결재상세 보기를 호출한다.
 */
function goDetailViewPost()
{
	var instanceId = $("#instanceId").val().trim();
	if(instanceId == null || instanceId == "")
	{
		alert('instanceId 값이 없습니다.');
		return;
	}
	
	var slo_p_ota = $("#slo_p_ota").val().trim();
	if(slo_p_ota == null || slo_p_ota == "")
	{
		alert('slo_p_ota 값이 없습니다.');
		return;
	}	
	
	/**************
     *post popup
     **************/
    var myUrl = "http://"+ approvalHost + ":" + approvalPort; //245서버
    
    var sUrl  = myUrl + "/neo/modules/approval/apagent/channel/v4/view_" + agentCompanyAlias + ".mvc";
    var sName = "detailViewPopup";
    var sMethod = "post";
    var nWindowWidth = 800;
    var nWindowHeight = 800;
    var sX = 10;
    var sY = 10;
    var sPosition = ",left=0,top=0";
    childWindow = window.open('about:blank',sName,"width="+nWindowWidth+",height="+nWindowHeight+",toolbar=no,location=no, scrollbars=yes, menubar=no,resizable=yes"+sPosition);
    
    
    document.frm.method = sMethod;
    document.frm.action = sUrl;
    document.frm.target = sName;
       
    document.frm.submit();
    childWindow.focus();
    //intervalID = window.setInterval(childWindow, 1000);
}

/**
 * 그룹웨어 연계 모드에 따라 그룹웨어 연계를 호출한다.
 */
function callGwView () {
	//mode에 따라 처리
	var mode = $("#viewMode").val().trim();
	if(mode == null || mode == "")
	{
		alert('그룹웨어 연계 모드를 설정해야 합니다.');
		return;
	}

	if (mode == "statusView")		//결재진행상태 보기 모드
		goStatusViewPost();
	else if (mode == "detailView")	//결재상세 보기 모드
		goDetailViewPost();
	
	//XPLATFORM POPUP에게 전달
	fireToXPLATFORM ("CLOSE");
}

//XPLATFORM 으로 데이터 전달
function fireToXPLATFORM(msg) {
	//Xplatform에 이벤트 전달
	window.TOBEHTML.FireUserNotify(msg);
}
</script>

</head>
<body>
<form id="frm" name="frm">
 	<!-- 전자결재 instance id -->
	<br/><input type="text" id="instanceId" name="instanceId" value="" size="50"/>
	<br/>
	<!-- 기안자의 OTA_ID --> 
	<br/><input type="text" id="slo_p_ota" name="slo_p_ota" value="<%=otaId%>" size="50"/>
	<br/>
	<%-- 추가 파라메터 셋팅 - 시작 --%>
	<input type="hidden" id="showTitleBar" 	name="showTitleBar" value="false"></input>
	<input type="hidden" id="mode" 			name="mode" 		value="view"></input>
	<input type="hidden" id="popupYn" 		name="popupYn" 		value="1"></input>
	<input type="hidden" id="btn" 			name="btn" 			value="{showCancle:N,showClosePopup:Y}"></input>
	<%-- 추가 파라메터 셋팅 - 끝 --%>
	<br/>
</form>
<!-- View Mode : status/detail --> 
<br/><input type="text" id="viewMode" name="viewMode" value="" size="50"/>
<br/> 	

<br><br>
<input type="button" id=btnCall name=btnCall value="Call GW" onclick="callGwView();" />
</body>
</html>