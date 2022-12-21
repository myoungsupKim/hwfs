<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
  /**
   * 그룹웨어 상신 IF JSP
   * @ClassName linkBizwellGwDraftIF.jsp
   * @Description linkBizwellGwDraftIF JSP
   * @Modification-Information
   *    수정일       수정자              수정내용
   *  ----------   ----------   -------------------------------
   *  2020.10.29   김명섭                  비즈웰 그룹웨어 IF
   */
%>
<%@page session="false" %>	<!-- HWFS 세션공유를 위해서 false로 설정 -->
<%@ page import="java.io.*
			   , java.util.*
			   , com.hwfs.sc.cmn.service.GwIfService
			   , org.springframework.web.context.*
			   , org.springframework.web.context.support.WebApplicationContextUtils
			   , com.hwfs.cmn.service.PropertiesService
			   , com.hwfs.sc.cmn.util.DateUtil
			   , com.hwfs.cmn.util.SessionUtil
			   , com.hwfs.sc.cmn.dto.LoginDTO" %>    
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
	response.sendRedirect(response.encodeRedirectURL("/common/linkBizwellGwDraftIF.jsp;jsessionid=" + request.getParameter("JSESSIONID") + "?JSESSIONID=" + request.getParameter("JSESSIONID") + "&cnt=" + cnt));
	return;
}
//System.out.println("**********************유지JSID=" + session.getId());
//세션값을 쿠키에 설정하여 이후 호출 시 유지되도록 한다. --> 이 부분은 그룹웨어 에이전트까지 적용이 안됨 
Cookie cookie = new Cookie("JSESSIONID", session.getId());
response.addCookie(cookie);

//Groupware Interface Service Bean을 얻는다.
ServletContext sc = pageContext.getServletContext();
WebApplicationContext wac = WebApplicationContextUtils.getRequiredWebApplicationContext(sc);

//propertiesService Bean을 얻는다.
PropertiesService propertiesService = (PropertiesService)wac.getBean("propertiesService");

//비즈웰 그룹웨어 연동을 위한 사번 Get
String sabun;
if (propertiesService.getBoolean("bizwellgw.test.env",true)) {
	sabun = propertiesService.getString("bizwellgw.test.empNo"); //테스트 사용자 사번
}else{
	//(실제용) 로그인 사번
	LoginDTO loginDTO = (LoginDTO)SessionUtil.getLoginSession(request);
	sabun = loginDTO.getSabun();
}

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/apagent/lib/config/config_bizwell.jsp" %>

<title>그룹웨어 상신 IF</title>
<!-- XPLATFORM 화면과 연동을 위한 스크립트 -->
<script type="text/javascript" src="/js/cmn/WebIF.js"></script>

<script type="text/javascript">
var dw = new bizwell.approval.DraftWindow();

function sendDraft() 
{
	//============== 기본값 셋팅 시작 ================
	var strService = $("#txtService").val().trim();
	if(strService == null || strService == "")
	{
		alert('결재서비스명 값이 없습니다.');
		return;
	}
			
	var strBodyUrl = $("#txtBodyUrl").val().trim();
	if(strBodyUrl == null || strBodyUrl == "")
	{
		alert('본문 URL 값이 없습니다.');
		return;
	}
	
	var strTitle = $("#txtTitle").val().trim();
	if(strTitle == null || strTitle == "")
	{
		alert('본문 제목 값이 없습니다.');
		return;
	}
	
	var strSabun = $("#txtSabun").val().trim();
	if(strSabun == null || strSabun == "")
	{
		alert('사번이 없습니다.');
		return;
	}
	
	var strDocPortraitType = $("#txtDocPortraitType").val();
	if(strDocPortraitType == null || strDocPortraitType == "")
	{
		alert('양식구분 값이 없습니다.');
		return;
	}
	
	var strClientId = $("#txtClientId").val().trim();
	if(strClientId == "" || strClientId == null)
	{		
		strClientId = getDefaultClientId(); //해당 업무의 디폴트 ID
	}
	
	//============== 기본값 셋팅 끝 ================
	
			
	//============== 상신 로직 처리 시작 ================
	//객체 초기화
	dw.init();
	//서비스명 
	dw.setService(strService); 	// 결재문서 서비스명
	//조회 : view, "" : 상신
	dw.setMode("");
	//결재문서의 업무 고유 ID (FC 업무에서 사용하는 id : TB_EVT_INFO.CLIENT_ID에 설정 됨)
	dw.setId(strClientId);
	//본문 내용 URL
	if (strBodyUrl.indexOf("?", 0) == -1) strBodyUrl += "?";
	dw.setBody(strBodyUrl + "&title=" + strTitle);	//title을 전달하여 처리
	//문서제목
	dw.setTitle(strTitle);
	//문서 양식 (horizontal : 가로양식 , vertical : 세로양식)
	dw.setDocPortraitType(strDocPortraitType); //
	//사번 설정
	dw.setOtaId(strSabun);
	
	dw.addParam("company_work_id", "<%=propertiesService.getString("bizwellgw.company.work.id")%>"); 	//통합영업: HWFS, 전사구매 : HWPO
	
	// windows 8 and 10 처리를 위해 설정 2015-08-05
	//dw.addParam("multi4","Ajax"); //미사용
	dw.addParam("XFlatformClientForApAgent","Y"); 

	//상신 window open
	var rtn = dw.open();
	if (rtn == null) return;
	
	//상신 처리결과 반환
	//alert ("return instanceId=" + rtn.instanceId + ", agentResultCode=" + rtn.agentResultCode);
    //XPLATFORM에 결과 전달
    if (rtn.instanceId != null) {
    	fireToXPLATFORM (rtn.instanceId);
    }
	//============== 상신 로직 처리 끝 ================
}

//XPLATFORM 으로 데이터 전달
function fireToXPLATFORM(msg) {
	//Xplatform에 이벤트 전달 : 앞에 Tag를 붙여 전달
	window.TOBEHTML.FireUserNotify("instanceId="+ msg);
}

/**
 * 전자결재의 instance id와 연관되어 있는 업무의 디폴트 id를 얻는다.
 * <pre>
 * - 디폴트 id로 상신 시 현재 시각으로 설정한다.
 * </pre>
 * @return 업무 디폴트 ID
 */
function getDefaultClientId()
{
	//서버 Timestamp로 변경
	 return "<%=DateUtil.getTimestamp6WithIp()%>";
}

</script>

</head>
<body>
	<div id="divProcessing" style="visibility:show;" align="center">
		<div>
			<div>
				<h4>처리 중 입니다. 잠시만 기다려 주십시오.</h4>
			</div>
		</div>
	  
		<div>
			<img src="/images/cmn/processing.gif" />
		</div>
	</div> 
	<div style="visibility:hidden;">
	<form id="frm" name="frm">
		<!-- 결재문서 서비스명 -->
		<br/><input type="text" id="txtService" name="txtService" value="" size="50"/> 
		<br/>
		<!-- 본문URL -->
		<br/><input type="text" id="txtBodyUrl" name="txtBodyUrl" value="" size="50"/>
		<br/>
		<!-- 본문제목 -->
		<br/><input type="text" name="txtTitle" id="txtTitle" value="" size="50"/>
		<br/>
		<!-- 기안자의 사번 --> 
		<br/><input type="text" name="txtSabun" id="txtSabun" value="<%=sabun%>" size="50"/>
		<br/>
		<!-- 가로/세로양식 : horizontal or vertical -->
		<br/><input type="text" id="txtDocPortraitType" name="txtDocPortraitType" value="vertical" size="50"/>
		<br/>
	</form>
	<br><br>
	<input type="text" id="txtClientId" name="txtClientId" value=""/>
	<br><br>
	<input type="text" id="txtAttachList" name="txtAttachList" value=""/>
	<br><br>
	<input type="button" id=btnCall name=btnCall value="GW Draft" onclick="sendDraft();" />
	
	<form name="frmAgentPopUp" id="frmAgentPopUp">
		<input type="text" name="host"/>
		<input type="text" name="port"/>
		<input type="text" name="p"/>
	</form>
	</div>
</body>
</html>