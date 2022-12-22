<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ktag" uri="/WEB-INF/tld/ktag.tld" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Function Test Page </title>
<link type="text/css" rel="stylesheet" href="<c:url value='/css/guide/sample.css'/>"/>
<script type="text/javaScript" language="javascript" defer="defer">
<!--
function testProperties() {
   	document.testForm.action = "<c:url value='/guide/test/testProperties.do'/>";
   	document.testForm.submit();		
}


function testLocale() {
   	document.testForm.action = "<c:url value='/guide/test/testLocale.do'/>";
   	document.testForm.submit();		
}

function testEncDec() {
   	document.testForm.action = "<c:url value='/guide/test/testEncDec.do'/>";
   	document.testForm.submit();		
}

function testEncDecFile() {
   	document.testForm.action = "<c:url value='/guide/test/testEncDecFile.do'/>";
   	document.testForm.submit();		
}

function testUUID() {
   	document.testForm.action = "<c:url value='/guide/test/testUUID.do'/>";
   	document.testForm.submit();		
}

function testCache() {
   	document.testForm.action = "<c:url value='/guide/test/testCache.do'/>";
   	document.testForm.submit();		
}

function testJmsBlocking() {
   	document.testForm.action = "<c:url value='/guide/test/testJmsBlocking.do'/>";
   	document.testForm.submit();		
}

function testJmsNonBlocking() {
   	document.testForm.action = "<c:url value='/guide/test/testJmsNonBlocking.do'/>";
   	document.testForm.submit();		
}

function testRmiIsAliveServer() {
   	document.testForm.action = "<c:url value='/guide/test/testRmiIsAliveServer.do'/>";
   	document.testForm.submit();		
}

function testSms() {
   	document.testForm.action = "<c:url value='/guide/test/testSms.do'/>";
   	document.testForm.submit();		
}

function testFax() {
   	document.testForm.action = "<c:url value='/guide/test/testFax.do'/>";
   	document.testForm.submit();		
}

function testCSRF() {
   	document.testForm.action = "<c:url value='/guide/test/testCSRF.do'/>";
   	document.testForm.submit();		
}

function testAccessLog() {
   	document.testForm.action = "<c:url value='/guide/test/testAccessLog.do'/>";
   	document.testForm.submit();		
}

function testProcedure() {
   	document.testForm.action = "<c:url value='/guide/sample/testProcedure.do'/>";
   	document.testForm.submit();		
}

function testProcedureArray() {
   	document.testForm.action = "<c:url value='/guide/sample/testProcedureArray.do'/>";
   	document.testForm.submit();		
}

function testPersonalInfoCheck() {
   	document.testForm.action = "<c:url value='/guide/sample/testPersonalInfoCheck.do'/>";
   	document.testForm.submit();		
}

function testServiceTxNew() {
   	document.testForm.action = "<c:url value='/guide/sample/testServiceTxNew.do'/>";
   	document.testForm.submit();		
}

function testServiceTxNew2() {
   	document.testForm.action = "<c:url value='/guide/sample/testServiceTxNew2.do'/>";
   	document.testForm.submit();		
}

function testServiceTxNew3() {
   	document.testForm.action = "<c:url value='/guide/sample/testServiceTxNew3.do'/>";
   	document.testForm.submit();		
}

function testGlobalTx() {
   	document.testForm.action = "<c:url value='/guide/sample/testGlobalTx.do'/>";
   	document.testForm.submit();		
}

function testLocalTx() {
   	document.testForm.action = "<c:url value='/guide/sample/testLocalTx.do'/>";
   	document.testForm.submit();		
}

function getBatchScheduler() {
   	document.testForm.action = "<c:url value='/guide/sample/getBatchScheduler.do'/>";
   	document.testForm.submit();		
}

function testLoginCheck() {
   	document.testForm.action = "<c:url value='/test/aaa.do'/>";
   	document.testForm.submit();		
}

function testLoginUncheck() {
   	document.testForm.action = "<c:url value='/test/a/aaa.do'/>";
   	document.testForm.submit();		
}

function testMobileLoginCheck() {
   	document.testForm.action = "<c:url value='/mobile/aaa.do'/>";
   	document.testForm.submit();		
}

-->
</script>
</head>
<body style="text-align:center; margin:0 auto; display:inline; padding-top:100px;">
<form:form name="testForm" method="post">
<div id="content_pop">
	<!-- 타이틀 -->
	<div id="title">
		<ul>
			<li>Function Test </li>
		</ul>
	</div>
	<!-- // 버튼 -->
	<div>
		<ul>
			<li><a href="javascript:testProperties();">Properties 테스트</a></li><br>
			<li><a href="javascript:testLocale();">Locale 테스트</a></li><br>
			<li><a href="javascript:testEncDec();">데이터 암/복호 테스트</a></li><br>
			<li><a href="javascript:testEncDecFile();">파일 암/복호 테스트</a></li><br>
			<li><a href="javascript:testUUID();">UUID 테스트</a></li><br>
			<li><a href="javascript:testCache();">Cache 테스트</a></li><br>
			<li><a href="javascript:testJmsBlocking();">JMS write/read (blocking방식) 테스트</a></li><br>
			<li><a href="javascript:testJmsNonBlocking();">JMS write/read (nonblocking방식) 테스트</a></li><br>
			<li><a href="javascript:testRmiIsAliveServer();">RMI 테스트 : isAliveServer</a></li><br>
			<li><a href="javascript:testSms();">SMS 테스트</a></li><br>
			<li><a href="javascript:testFax();">FAX 테스트</a></li><br>
			<li><a href="javascript:testCSRF();">CSRF 테스트</a></li><br>
			<li><a href="javascript:testAccessLog();">접근로그 테스트</a></li><br>
			<li><a href="javascript:testProcedure();">DB Procedure 호출</a></li><br>
			<li><a href="javascript:testProcedureArray();">DB Procedure Array파라미터 호출</a></li><br>
			<li><a href="javascript:testPersonalInfoCheck();">개인정보필터링 호출</a></li><br>
			<li><a href="javascript:testServiceTxNew();">서비스에서 트랜잭션 분리 테스트:Main Tx에서 Exception발생하고 Sub Tx와 분리되는지 테스트</a></li><br>
			<li><a href="javascript:testServiceTxNew2();">서비스에서 트랜잭션 분리 테스트:Sub Tx에서 Exception발생하고 Main Tx와 분리되는지 테스트</a></li><br>
			<li><a href="javascript:testServiceTxNew3();">서비스에서 트랜잭션 분리 테스트:Sub Service에서 밸생한 Exception을 Main Tx에서 무시하는 테스트</a></li><br>
			<li><a href="javascript:testGlobalTx();">Global Tx 테스트</a></li><br>
			<li><a href="javascript:testLocalTx();">Local Tx 테스트(dataSourceJdbc 이용)</a></li><br>
			<li><a href="javascript:getBatchScheduler();">Quartz Batch Scheduler 정보얻기</a></li><br>
			<li><a href="javascript:testLoginCheck();">LoginCheck Test : check</a></li><br>
			<li><a href="javascript:testLoginUncheck();">LoginCheck Test : uncheck</a></li><br>
			<li><a href="javascript:testMobileLoginCheck();">Mobile LoginCheck Test : check</a></li><br>
		</ul>		
	</div>
	<div>
		<br><b>[결과메시지]</b>
		<br>
		<script type="text/javaScript" language="javascript">
		    <c:if test="${!empty resultMsg}">var strMsg="<c:out value="${resultMsg}" escapeXml="false" />"; document.write("[" + strMsg + "]");</c:if>
		</script>
	</div>
</div>
<ktag:token name="savedToken" />
</form:form>
</body>
</html>
