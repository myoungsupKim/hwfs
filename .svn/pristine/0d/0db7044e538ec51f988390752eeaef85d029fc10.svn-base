<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
/**
 * 등록된 JSON요청이 아닌 경우 표시되는 오류 웹페이지
 * @ClassName jsonCheckFailure.jsp
 * @Description jsonCheckFailure jsp
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2016.07.29.   kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015.06.24.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
%>
<%@ page import= "java.io.*
				, java.util.*
				, org.apache.commons.lang.time.FastDateFormat
				, org.json.JSONObject
				, org.springframework.web.context.*
				, org.springframework.web.context.support.WebApplicationContextUtils
				, org.springframework.context.support.MessageSourceAccessor
				, com.hwfs.cmn.defaults.DefaultConsts"%>
<%
	ServletContext sc = pageContext.getServletContext();
	WebApplicationContext wac = WebApplicationContextUtils.getRequiredWebApplicationContext(sc);
	
	//messageService Bean을 얻는다.
	MessageSourceAccessor messageService = (MessageSourceAccessor)wac.getBean("messageSourceAccessor");

	//등록된 JSON 요청이 아닌 오류를 전송한다.
	JSONObject	jsonReturn = new JSONObject();

	FastDateFormat fdf = FastDateFormat.getInstance("yyyy-MM-dd' 'HH:mm:ss");
	String currentDt = fdf.format(new Date());

	//Header
	JSONObject txHeader = new JSONObject();

	//Data
	JSONObject txData = new JSONObject();
	txData.put("data", "");

	//오류결과
	JSONObject txResult = new JSONObject();
	txResult.put("resultDateTime", currentDt);
	txResult.put("resultCode", DefaultConsts.ERR_CODE);
	txResult.put("resultMessage", messageService.getMessage("sc.cmn.json.valid.fail.msg"));

	//반환할 JSONObject에 설정 
	jsonReturn.put("txHeader",txHeader);
	jsonReturn.put("txData",  txData);
	jsonReturn.put("txResult", txResult);
	
	//결과값 출력
	out.clear();
	out.write(jsonReturn.toString());
	out.flush();
%>
