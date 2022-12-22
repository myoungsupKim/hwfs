<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<script type="text/javascript" src="http://172.16.1.121:8091/js/jquery/jquery-1.11.1.min.js" ></script>
<script type="text/javascript">
$(document).ready(function (){
	
	$("#btn1").bind("click", function() {
		$.ajax({
			  type : "POST"
			, url : "http://172.16.1.121:8091/sc/cmn/jsonCommon.jDo"
			, dataType : "json"
			, contentType : "application/json"
			//1.기준정보
			, data : "{'txHeader':{'txId':'IF_FC_INFO_RESULT', 'encoding':'utf-8', 'encYn':'false', 'txDiv':'SELECTDATA'}, 'txData':{'data':{'A' : '1', 'B' : '2'}}, 'txResult':{}}"
			, success : function (data) {
		    	alert(data.txResult.resultCode + "\n" + data.txResult.resultMessage);
		    }
		});
	});
	
	$("#btn2").bind("click", function() {
		$.ajax({
			  type : "POST"
			, url : "http://172.16.1.121:8091/sc/cmn/jsonCommon.jDo"
			, dataType : "json"
			, contentType : "application/json"
			//2.거래처정보
			, data : "{'txHeader':{'txId':'IF_FC_CUST_RESULT', 'encoding':'utf-8', 'encYn':'false', 'txDiv':'SELECTDATA', 'fixedDt':'20190101'}, 'txData':{'data':{'A' : '1', 'B' : '2'}}, 'txResult':{}}"
			 , success : function (data) {
		    	alert(data.txResult.resultCode + "\n" + data.txResult.resultMessage + "\n" +data.txData);
		    }
		});
	});
	
	$("#btn3").bind("click", function() {
		$.ajax({
			  type : "POST"
			, url : "http://172.16.1.121:8091/sc/cmn/jsonCommon.jDo"
			, dataType : "json"
			, contentType : "application/json"
			//3.날씨정보
			, data : "{'txHeader':{'txId':'IF_FC_WEATHER_RESULT', 'encoding':'utf-8', 'encYn':'false', 'txDiv':'SELECTDATA', 'fromDt':'20190701', 'toDt':'201900731'}, 'txData':{'data':{'A' : '1', 'B' : '2'}}, 'txResult':{}}"
			  , success : function (data) {		    	
		    	alert(data.txResult.resultCode + "\n" + data.txResult.resultMessage);
		    }
		});
	});
	
	$("#btn4").bind("click", function() {
		$.ajax({
			  type : "POST"
			, url : "http://172.16.1.121:8091/sc/cmn/jsonCommon.jDo"
			, dataType : "json"
			, contentType : "application/json"
			//4.레시피정보
			, data : "{'txHeader':{'txId':'IF_FC_RECIPE_RESULT', 'encoding':'utf-8', 'encYn':'false', 'txDiv':'SELECTDATA', 'fixedDt':'20190101'}, 'txData':{'data':{'A' : '1', 'B' : '2'}}, 'txResult':{}}"
			, success : function (data) {
		    	alert(data.txResult.resultCode + "\n" + data.txResult.resultMessage);
		    }
		});
	});
	
	$("#btn5").bind("click", function() {
		$.ajax({
			  type : "POST"
			, url : "http://172.16.1.121:8091/sc/cmn/jsonCommon.jDo"
			, dataType : "json"
			, contentType : "application/json"
			//5.식단정보
			, data : "{'txHeader':{'txId':'IF_FC_MENU_RESULT', 'encoding':'utf-8', 'encYn':'false', 'txDiv':'SELECTDATA', 'fromDt':'20190701', 'toDt':'20190731', 'fixedDt':'20190701'}, 'txData':{'data':{'A' : '1', 'B' : '2'}}, 'txResult':{}}"
			 , success : function (data) {
		    	alert(data.txResult.resultCode + "\n" + data.txResult.resultMessage);
		    }
		});
	});
	
});
</script>
</head>
<body>
<input type="button" id="btn1" name="btn1" value="1.기준정보(업장/식당/코너)" /><p>
<input type="button" id="btn2" name="btn2" value="2.거래처정보" /><p>
<input type="button" id="btn3" name="btn3" value="3.날씨정보" /><p>
<input type="button" id="btn4" name="btn4" value="4.레시피정보" /><p>
<input type="button" id="btn5" name="btn5" value="5.식단정보" />


</body>
</html>