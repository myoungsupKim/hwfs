<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
 /**
  * Batch Job 실행 List 화면
  * @ClassName BatchList.jsp
  * @Description BatchList 화면 
  * @Modification-Information
  *    수정일       수정자              수정내용
  *  ----------   ----------   -------------------------------
  *  2014.12.19.   kksoo        최초생성
  * 
  * @author FC종합전산구축 : AA kksoo
  * @since 2014.12.19.
  * @version 1.0
  * @see 
  * <pre>
  *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
  * </pre>
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Job 실행 List</title>
<link type="text/css" rel="stylesheet" href="<c:url value='/css/guide/default.css'/>"/>
<script type="text/javaScript" language="javascript" defer="defer">
<!--
/* Job 실행 function */
function batchRun() {
   	document.listForm.action = "<c:url value='/guide/sample/batchRun.do'/>";
   	document.listForm.submit();		
}
-->
</script>
</head>
<body style="text-align:center; margin:0 auto; display:inline; padding-top:100px;">
<div id="content_pop">
	<!-- 타이틀 -->
	<div id="title">
		<ul>
			<li><img src="<c:url value='/images/guide/sample/title_dot.gif'/>"> Batch Job 실행 List </li>
		</ul>
	</div>
	<!-- Job List -->
	<form:form commandName="searchVO" name="listForm" method="post">
	<div id="table">
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<colgroup>
				<col width="40">				
				<col width="60">
				<col width="">
			</colgroup>		  
			<tr>
				<th align="center">No</th>
				<th align="center">작업선택</th>
				<th align="center">Job 이름</th>
			</tr>
			<c:forEach items="${jobList}" var="item" varStatus="status">      
			<tr>
				<td align="center" class="listtd"><c:out value="${status.count}"/></td>
				<td align="center" class="listtd"><input type="radio" name="jobName" value="${item}" <c:if test="${status.first == true}">checked</c:if>/></a></td>
				<td align="center" class="listtd"><c:out value="${item}"/>&nbsp;</td>
			</tr>
			</c:forEach>
		</table>
	</div>
	</form:form>
	<!-- /Job List -->
	<!--  Button -->
	<div id="sysbtn1">
		<ul>
		<div id="sysbtn"><ul>
		<li><span class="btn_blue_l"><a href="javascript:batchRun();">배치실행</a><img src="<c:url value='/images/guide/sample/btn_bg_r.gif'/>" style="margin-left:6px;"></span></li></ul>
		</div>
		</ul>
	</div>
</div>
</body>
</html>