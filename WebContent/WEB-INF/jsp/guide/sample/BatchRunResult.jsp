<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
 /**
  * Batch Job 실행 결과 화면
  * @ClassName BatchRunResult.jsp
  * @Description BatchRunResult 화면 
  * @Modification-Information
  *    수정일       수정자              수정내용
  *  ----------   ----------   -------------------------------
  *  2013. 8. 02.   kksoo        최초생성
  * 
  * @author 사학연금 통합정보시스템 : AA kksoo
  * @since 2013. 8. 01.
  * @version 1.0
  * @see 
  * 
  *  Copyright (C) 2013 by Teachers' Pension, All right reserved.
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Batch Job 실행 결과</title>
<link type="text/css" rel="stylesheet" href="<c:url value='/css/guide/default.css'/>"/>
<script type="text/javaScript" language="javascript" defer="defer">
<!--
/* Job 실행 function */
function goBack() {
   	location.href="/guide/sample/batchList.do";		
}
-->
</script>
</head>
<body style="text-align:center; margin:0 auto; display:inline; padding-top:100px;">
	<div id="content_pop">
		<!-- 타이틀 -->
		<div id="title">
			<ul>
				<li><img src="<c:url value='/images/guide/sample/title_dot.gif'/>"> Batch Job 실행 결과 </li>
			</ul>
		</div>
		<!-- 결과 List -->
		<div id="table">
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<colgroup>
					<col width="120">				
					<col width="">
				</colgroup>
				<tr>
					<th colspan="2">Job 정보</th>
				</tr>
				<tr>
					<td class="listtd"><b>Job 아이디</b></td>
					<td class="listtd">${ jobInstances.id }</td> 
				</tr>
				<tr>
					<td class="listtd"><b>Job 이름</b></td>
					<td class="listtd">${ jobInstances.name }</td> 
				</tr>
				<tr>
					<td class="listtd"><b>Job 파라미터</b></td>
					<td class="listtd">${ jobInstances.parameters }</td> 
				</tr>
				<tr>
					<td class="listtd"><b>Job 시작시간</b></td>
					<td class="listtd">${ jobInstances.startTime }</td>
				</tr>
				<tr>
					<td class="listtd"><b>Job 실행 중 여부</b></td>
					<td class="listtd">${ jobInstances.isRunning }</td> 
				</tr>
				<tr>
					<td class="listtd"><b>Job 종료시간</b></td>
					<td class="listtd">${ jobInstances.endTime }</td>
				</tr>
				<tr>
					<td class="listtd"><b>종료시 상태(exitStatus)</b></td>
					<td class="listtd">${jobInstances.exitStatus}</td> 
				</tr>
			</table>
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<th width="40">Step 아이디 </th>
					<th>Step 이름 </th>
					<th>Read Count</th>
					<th>Write Count</th>
					<th>Read Skip Count</th>
					<th>Process Skip Count</th>
					<th>Write Skip Count</th>
					<th>Total Skip Count</th>
					<th>Commit Count</th>
					<th>Rollback Count</th>
					<th>종료시 상태(exitStatus)</th>
				</tr>
				<c:forEach var="stepList" items="${stepsInfo}" varStatus="varStatus">
				<tr>			
					<td class="listtd" align="center">${stepList.stepId }</td>
					<td class="listtd" align="center">${stepList.stepName }</td>
					<td class="listtd" align="center">${stepList.readCount }</td>
					<td class="listtd" align="center">${stepList.writeCount }</td>
					<td class="listtd" align="center">${stepList.readSkipCount }</td>
					<td class="listtd" align="center">${stepList.processSkipCount }</td>
					<td class="listtd" align="center">${stepList.writeSkipCount }</td>
					<td class="listtd" align="center">${stepList.totalSkipCount}</td>
					<td class="listtd" align="center">${stepList.commitCount }</td>
					<td class="listtd" align="center">${stepList.rollbackCount }</td>
					<td class="listtd" align="center">${stepList.exitStatus }</td>				
				</tr>
				</c:forEach>
			</table>
		</div>
	</div>
	<!--  Button -->
	<div id="sysbtn1">
		<ul>
			<div id="sysbtn">
				<ul>
					<li><span class="btn_blue_l"><a
							href="javascript:goBack();">돌아가기</a><img
							src="<c:url value='/images/guide/sample/btn_bg_r.gif'/>"
							style="margin-left: 6px;">
					</span> <span class="btn_blue_l"><a
							href="javascript:window.close();">닫기</a><img
							src="<c:url value='/images/guide/sample/btn_bg_r.gif'/>"
							style="margin-left: 6px;">
					</span></li>
				</ul>
			</div>
		</ul>
	</div>
</body>
</html>