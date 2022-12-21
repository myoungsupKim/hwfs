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
   *  2015.06.17.   kksoo        XPLATFORM POPUP으로부터 호출하고 그룹웨어 페이지 오픈 후 팝업이 close되도록 개선(MSIE 이용 방식)
   *
   * @author FC종합전산구축 : AA kksoo
   * @since 2015.03. 23.
   * @version 1.0
   * @see
   * 
   *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
   */
%>
<%@page session="false" %>	<!-- HWFS 세션공유를 위해서 false로 설정 -->
<%@ page import="java.io.*
			   , java.util.*
			   , com.hwfs.sc.cmn.service.GwIfService
			   , org.springframework.web.context.*
			   , org.springframework.web.context.support.WebApplicationContextUtils
			   , com.hwfs.cmn.service.PropertiesService" %>  
<%
//(주의)XP의 MSIE와 세션유지를 위한 설정은 그룹웨어 에이전트 단에서의 처리 불가 (많은 소스 변경필요)
//- HWFS 세션공유를 위해서는 설정
//- 본문 Body는 세션을 체크하지 않도록 설정하여 처리하도록 변경
HttpSession session = request.getSession(false);
if (session == null) {
	//횟수 제한 검사
	int cnt = 0;
	if (request.getParameter("cnt") != null) cnt = Integer.parseInt(request.getParameter("cnt"));
	if (cnt >= 10)
		return;
	else
		cnt++;

	System.out.println("**********************JSID=" + request.getParameter("JSESSIONID") + ";CNT=" + cnt);
	
	//URL Rewriting으로 기존 세션을 생성
	response.sendRedirect(response.encodeRedirectURL("/common/linkGwViewIF.jsp;jsessionid=" + request.getParameter("JSESSIONID") + "?JSESSIONID=" + request.getParameter("JSESSIONID") + "&cnt=" + cnt));

	return;
}
//System.out.println("**********************유지JSID=" + session.getId());
//세션값을 쿠키에 설정하여 이후 호출 시 유지되도록 한다. --> 이 부분은 그룹웨어 에이전트까지 적용이 안됨 
Cookie cookie = new Cookie("JSESSIONID", session.getId());
response.addCookie(cookie);

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
    //post popup
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
     **************/
     
	/***********
	//get방식 - 현재 Xplatform에서 popup을 뜨운후 focus를 주었을경우 일부 브라우저에서 창이 2개 뜨는 현상이 발생되어
	//          post방식의 popup를 사용하지 않고 get방식으로 변경처리함.
	**************/
	var myUrl = "http://"+ approvalHost + ":" + approvalPort;
	    
    var sUrl  = myUrl 
    				+ '/neo/modules/approval/apagent/channel/v4/showFlowChart_' + agentCompanyAlias + '.mvc?'
				    + 'instanceId='+$("#instanceId").val()
					+ '&slo_p_ota='+$("#slo_p_ota").val()
					+ '&showTitleBar=' + $("#showTitleBar").val()
					+ '&mode=' + $("#mode").val()
					+ '&popupYn=' + $("#popupYn").val()
					+ '&btn=' + $("#btn").val()
		    		+ '&isPreSaveView=' + $("#isPreSaveView").val()
					;
    
    var sName = "statusViewPopup";
    //var sMethod = "post";
    var nWindowWidth = 1070;
    var nWindowHeight = 800;
    var sPosition = ",left=0,top=0";
    var oPopup = window.open(sUrl, sName, "width="+nWindowWidth+",height="+nWindowHeight+",toolbar=no,location=no, scrollbars=yes, menubar=no,resizable=yes"+sPosition);
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
    //post popup
    var myUrl = "https://"+ approvalHost + ":" + approvalPort; //245서버
    
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
	**************/
	
	/***********
	//get방식 - 현재 Xplatform에서 popup을 뜨운후 focus를 주었을경우 일부 브라우저에서 창이 2개 뜨는 현상이 발생되어
	//          post방식의 popup를 사용하지 않고 get방식으로 변경처리함.
	**************/
	var myUrl = "http://"+ approvalHost + ":" + approvalPort;
	   
	var sUrl  = myUrl 
					+ '/neo/modules/approval/apagent/channel/v4/view_' + agentCompanyAlias + '.mvc?'
					+ 'instanceId='+$("#instanceId").val()
		    		+ '&slo_p_ota='+$("#slo_p_ota").val()
		    		+ '&showTitleBar=' + $("#showTitleBar").val()
		    		+ '&mode=' + $("#mode").val()
		    		+ '&popupYn=' + $("#popupYn").val()
		    		+ '&btn=' + $("#btn").val()
		    		+ '&isPreSaveView=' + $("#isPreSaveView").val()
		    		;
	
	var sName = "detailViewPopup";
	var nWindowWidth = 1070;
	var nWindowHeight = 800;
	var sPosition = ",left=0,top=0";
	var oPopup2 = window.open(sUrl, sName, "width="+nWindowWidth+",height="+nWindowHeight+",toolbar=no,location=no, scrollbars=yes, menubar=no,resizable=yes"+sPosition);
	oPopup2.focus();
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
	//Xplatform에 이벤트 전달 : MSIE 방식
	document.title = msg; 
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
	<input type="hidden" id="isPreSaveView"	name="isPreSaveView" value="Y"></input>
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