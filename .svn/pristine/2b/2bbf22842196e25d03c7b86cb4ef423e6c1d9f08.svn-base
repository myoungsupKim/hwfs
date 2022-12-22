<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.Iterator"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONException"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%
	request.setCharacterEncoding("UTF-8");

	String requestURL = request.getRequestURL().toString();
	String cbAction = requestURL.substring(0, requestURL.lastIndexOf('/'))+"/result.jsp";
	
	System.out.println("==============cbAction:" + cbAction);
	String params = request.getParameter("p");
	
	ApAgentParam apAgentParam = new ApAgentParam();
	
	apAgentParam.populate(params);
	
	System.out.println("apAgentParam serviceName :: "+apAgentParam.getWfCode());
	System.out.println("apAgentParam bodyURL :: "+apAgentParam.getBodyLink());
	System.out.println("apAgentParam getParameter(id) :: "+apAgentParam.getParameter("id"));
	
	String serviceName = apAgentParam.getWfCode();
	String bodyURL = apAgentParam.getBodyLink();
	String mode = apAgentParam.getMode();
	
	String key = apAgentParam.getParameter("id");
	String client = apAgentParam.getParameter("client");
	String alarmYn = apAgentParam.getParameter("alarmYn");
	String viewYn = apAgentParam.getParameter("viewYn");
	
	if ( client == null ) client = "PRD";
	client = client.toUpperCase();
	String formSize = null;

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>전자결재 상신</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/apagent/lib/config/config_bizwell.jsp" %>
<script>
var connection = new bizwell.commons.PostConnection('connection');
var progressPane = new bizwell.commons.ProgressPane('progressPane');
var dw = new bizwell.approval.DraftWindow();
var o = new Object();
var Obj = null;
function init(params) {
	submitBody();
}
function submitBody() {

	var bodyLink = '<%=bodyURL%>';
	
	if ( bodyLink == "" ) {
		submitApproval();
	} else {
		bodyLink = '<%=bodyURL%>';
		if (bodyLink.indexOf("?", 0) == -1) {
			bodyLink += "?";
		}
		bodyLink += '&wfCode='+'<%=serviceName%>'+'&id='+'<%=key%>';
		processBodyAction(bodyLink);
	}
}

function submitApproval() {

<%
	System.out.println("formSize ::: "+formSize);
	if ( formSize != null ) {
%>
	dw.addParam("formSize", "<%=formSize%>");
<%
	}
%>

	document.f.returnUrl.value = encodeURIComponent(document.f.returnUrl.value);
	document.f.sabun.value = '<%=apAgentParam.getParameter("slo_p_ota")%>';
	document.f.title.value = encodeURIComponent('<%=apAgentParam.getParameter("title")%>');
	document.f.workid.value = '<%=apAgentParam.getParameter("company_work_id")%>';

	//document.f.action = "http://"+approvalHost+":"+approvalPort+"/xclickr3_winplus/dispatcherPurchase.jsp";
	document.f.action = "http://"+approvalHost+":"+approvalPort+"/xclickr3_foodist/dispatcherSales.jsp";
	document.f.target = "_self";
	
	document.f.submit();
}
function processBodyAction(bodyLink) {

	connection.init();
	connection.setForm(document.bodyForm);
	connection.setCallback(processBodyActionCallback);
	try {
		connection.send(bodyLink);
	} catch (e) {
		alert("본문내용 생성 요청 중 에러가 발생하였습니다." + e.description);

	}	
}

function processBodyActionCallback(code) {
	if ( code > 0 ) {
		try {
			var responseHTML = connection.responseHTML;
			if ( !responseHTML ) {
				connection.showDebugWindow();
			};

			document.f.bodyHtml.value = encodeURIComponent(responseHTML);

			submitApproval();

		} catch (e) {
			alert(e.description);

		}
	} else if ( code < 0 ) {
		alert("본문내용 생성 중 에러가 발생하였습니다.\r\n" + connection.statusMessage);
	}
}
</script>
</head>
<body leftmargin="0" topmargin="0" scroll="no">
<iframe id="inc" name="inc" style="width: 100%; height: 100%; border: 0px solid;" marginleft="0" marginwidth="0" marginheight="0" tabindex="-1" frameborder="0" scrolling="auto" src="wait.jsp"></iframe>
<form name="f" method="post">
<input type="hidden" name="key" value="<%=key%>">
<input type="hidden" name="serviceName" value="<%=serviceName%>">
<input type="hidden" name="title" value="">
<input type="hidden" name="client" value="<%=client%>">
<input type="hidden" name="alarmYn" value="<%=alarmYn%>">
<input type="hidden" name="viewYn" value="<%=viewYn%>">
<input type="hidden" name="bodyHtml" value="">
<input type="hidden" name="mode" value="<%=mode%>">
<input type="hidden" name="popupType" value="linkPopUp">
<input type="hidden" name="workid" value="">
<input type="hidden" name="sabun" value="">
<input type="hidden" name="returnUrl" value="<%=cbAction%>">
</form>

<form name="bodyForm" method="post"></form>
</body>
<script type="text/javascript">
var params = $.popup.getDialogParams();
$().ready(function(){
	init(params);
});
</script>
</html>
<%!

/*****ApAgentParam**********/
class ApAgentParam {
	
	private JSONObject jsonObject;
	private String jsonString; //jsonString
	private String jsonParamString;
	private Map params; //params
	private String wfCode;
	private String bodyLink;
	private String agentDocPath;
	private String agentBodyHtml;
	private String mode;
	
	/** populate  String객체**/
	public void populate(String paramString) throws JSONException {
		this.jsonString = paramString;
		//JSONObject 생성
		this.jsonObject = new JSONObject(paramString);
		
		if(this.jsonObject.has("service")){
			setWfCode(this.jsonObject.getString("service"));
		}
		
		if(this.jsonObject.has("bodyLink")){
			setBodyLink(this.jsonObject.getString("bodyLink"));
		}
		
		if(this.jsonObject.has("mode")){
			this.mode = this.jsonObject.getString("mode");
		}
		
		if(this.jsonObject.has("params") && !this.jsonObject.get("params").equals("none")){
			this.jsonParamString = this.jsonObject.getString("params");
			JSONArray jsonArray = this.jsonObject.getJSONArray("params");
			
			this.params = new HashMap();
			
			for(int i=0; i<jsonArray.length(); i++) {
		        JSONObject jsonPObj = jsonArray.getJSONObject(i);
		        
		        for(Iterator ii=jsonPObj.keys(); ii.hasNext();) {
		            String key = (String)ii.next();
		            String value = jsonPObj.getString(key);
		            
		            this.params.put(key, value);
		        }
		    }
		}else{
			this.params = new HashMap();
			this.params.put("no", "no");
		}

	}
	
	/**
	 * @return the jsonObject
	 */
	public JSONObject getJsonObject() {
		return jsonObject;
	}
	
	public Map getParams(){
		return this.params;
	}
	
	public String getJsonString(){
		return this.jsonString;
	}
	
	/**
	 * @return the jsonParamString
	 */
	public String getJsonParamString() {
		return jsonParamString;
	}
	
	public void setWfCode(String wfCode){
		this.wfCode = wfCode;
	}
	
	public String getWfCode(){
		if(!this.wfCode.equals("none"))
			return this.wfCode;
		else 
			return "";
	}

	/**
	 * @return the bodyLink
	 */
	public String getBodyLink() {
		if(!this.bodyLink.equals("none"))
			return this.bodyLink;
		else
			return "";
	}

	/**
	 * @param bodyLink the bodyLink to set
	 */
	public void setBodyLink(String bodyLink) {
		this.bodyLink = bodyLink;
	}

	/**
	 * @return the agentDocPath
	 */
	public String getAgentDocPath() {
		return agentDocPath;
	}

	/**
	 * @param agentDocPath the agentDocPath to set
	 * @throws IOException 
	 * @throws FileNotFoundException 
	 */
	public void setAgentDocPath(String agentDocPath) {
		this.agentDocPath = agentDocPath;
	}
	
	/**
	 * @return the mode
	 */
	public String getMode() {
		return mode;
	}

	

	/*********getParameter()**********/
	public String getParameter(String key) throws JSONException{
		if (this.params.containsKey(key))
            return (String)this.params.get(key);
		else
			return "";

	}
}

%>