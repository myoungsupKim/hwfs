<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="ktag" uri="/WEB-INF/tld/ktag.tld" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Test CSRF Test</title>
<style type="text/css">
/* <![CDATA[ */
body { margin:0; padding:0; font-size:12px; font-family:dotum; color:#333; }
input.essentiality  {height:18px; background-color:#ebebeb; border:1px solid #BCC8D8; padding-top:2px; color:#000; cursor:text;}

#LblockDetail0 table {
    border-collapse:collapse;
}
#LblockDetail0 table th, #LblockDetail0 table td {
    border:1px solid #AAAAAA;
}
#LblockListTable0 table {
    border-collapse:collapse;
}
#LblockListTable0 table td {
    text-align:left;
    border:1px solid #AAAAAA;
}

/* ]]> */
</style>
<script type="text/javascript">
// <![CDATA[
    function test() {
        var frm = document.getElementById("mainForm");
        
		frm.submit();	//submit 시는 validation 처리하지 않음
    }
// ]]>
</script>
</head>
<body>
<form id="mainForm" action="" method="post">
	<div class="LblockMain">
		<!-- title 영역 -->
		<div class="LblockPageTitle">
			<h1>CSRF Test</h1>
		</div>
		<!-- 버튼 영역 -->
		<input type="button" value="테스트" onclick="test();" />
	</div>
	<ktag:token name="savedToken" />
</form>
</body>
</html>