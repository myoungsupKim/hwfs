<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<script type="text/javascript" src="http://localhost:8080/js/jquery/jquery-1.11.1.min.js" ></script>
<script type="text/javascript">
$(document).ready(function (){
	
	$("#btn1").bind("click", function() {
		$.ajax({
			  type : "POST"
			, url : "http://localhost:8080/sc/cmn/jsonCommon.jDo"
			, dataType : "json"
			, contentType : "application/json"
			//1.업장정보
			, data : "{'txHeader':{'txId':'IF_FC_UPJANG_RESULT', 'encoding':'utf-8', 'encYn':'false', 'txDiv':'SELECTDATA'}, 'txData':{'data':{'A' : '1', 'B' : '2'}}, 'txResult':{}}"
/*
			//2.식당정보
			, data : "{'txHeader':{'txId':'IF_FC_HALL_RESULT', 'encoding':'utf-8', 'encYn':'false', 'txDiv':'SELECTDATA'}, 'txData':{'data':{'A' : '1', 'B' : '2'}}, 'txResult':{}}"
			//3.끼니정보
			, data : "{'txHeader':{'txId':'IF_FC_MEAL_RESULT', 'encoding':'utf-8', 'encYn':'false', 'txDiv':'SELECTDATA'}, 'txData':{'data':{'A' : '1', 'B' : '2'}}, 'txResult':{}}"
			//4.코너정보
			, data : "{'txHeader':{'txId':'IF_FC_CORNER_RESULT', 'encoding':'utf-8', 'encYn':'false', 'txDiv':'SELECTDATA'}, 'txData':{'data':{'A' : '1', 'B' : '2'}}, 'txResult':{}}"
			//5.거래처정보
			, data : "{'txHeader':{'txId':'IF_FC_CUST_RESULT', 'encoding':'utf-8', 'encYn':'false', 'txDiv':'SELECTDATA'}, 'txData':{'data':{'A' : '1', 'B' : '2'}}, 'txResult':{}}"
			//6.날씨정보
			, data : "{'txHeader':{'txId':'IF_FC_WEATHER_RESULT', 'encoding':'utf-8', 'encYn':'false', 'txDiv':'SELECTDATA'}, 'txData':{'data':{'A' : '1', 'B' : '2'}}, 'txResult':{}}"
			//7.식수정보
			, data : "{'txHeader':{'txId':'IF_FC_MEALQTY_RESULT', 'encoding':'utf-8', 'encYn':'false', 'txDiv':'SELECTDATA'}, 'txData':{'data':{'A' : '1', 'B' : '2'}}, 'txResult':{}}"
			//8.식단정보
			, data : "{'txHeader':{'txId':'IF_FC_MENU_RESULT', 'encoding':'utf-8', 'encYn':'false', 'txDiv':'SELECTDATA'}, 'txData':{'data':{'A' : '1', 'B' : '2'}}, 'txResult':{}}"
*/
		    // JSON 공통 샘플
		    //, data : "{'txHeader':{'txId':'ExtIfTable', 'encoding':'utf-8', 'encYn':'false'}, 'txData':{'datas':[{'empNo':'2234', 'empNm':'아무개', 'deptNm':'아무부서'}, {'empNo':'2235', 'empNm':'홍길동', 'deptNm':'아무부서'}]}, 'txResult':{}}"
		    , success : function (data) {
		    	alert(data.txResult.resultCode + "\n" + data.txResult.resultMessage);
		    }
		});
	});
	
	$("#btn2").bind("click", function() {
		$.ajax({
			  type : "POST"
			, url : "http://localhost:8080/sc/cmn/jsonCommon.jDo"
			, dataType : "json"
			, contentType : "application/json"
			//2.식당정보
			, data : "{'txHeader':{'txId':'IF_FC_HALL_RESULT', 'encoding':'utf-8', 'encYn':'false', 'txDiv':'SELECTDATA'}, 'txData':{'data':{'A' : '1', 'B' : '2'}}, 'txResult':{}}"
			// JSON 공통 샘플
		    //, data : "{'txHeader':{'txId':'ExtIfTable', 'encoding':'utf-8', 'encYn':'false'}, 'txData':{'datas':[{'empNo':'2234', 'empNm':'아무개', 'deptNm':'아무부서'}, {'empNo':'2235', 'empNm':'홍길동', 'deptNm':'아무부서'}]}, 'txResult':{}}"
		    , success : function (data) {
		    	alert(data.txResult.resultCode + "\n" + data.txResult.resultMessage);
		    }
		});
	});
	
	$("#btn3").bind("click", function() {
		$.ajax({
			  type : "POST"
			, url : "http://localhost:8080/sc/cmn/jsonCommon.jDo"
			, dataType : "json"
			, contentType : "application/json"
			//3.끼니정보
			, data : "{'txHeader':{'txId':'IF_FC_MEAL_RESULT', 'encoding':'utf-8', 'encYn':'false', 'txDiv':'SELECTDATA'}, 'txData':{'data':{'A' : '1', 'B' : '2'}}, 'txResult':{}}"
			// JSON 공통 샘플
		    //, data : "{'txHeader':{'txId':'ExtIfTable', 'encoding':'utf-8', 'encYn':'false'}, 'txData':{'datas':[{'empNo':'2234', 'empNm':'아무개', 'deptNm':'아무부서'}, {'empNo':'2235', 'empNm':'홍길동', 'deptNm':'아무부서'}]}, 'txResult':{}}"
		    , success : function (data) {
		    	alert(data.txResult.resultCode + "\n" + data.txResult.resultMessage);
		    }
		});
	});
	
	$("#btn4").bind("click", function() {
		$.ajax({
			  type : "POST"
			, url : "http://localhost:8080/sc/cmn/jsonCommon.jDo"
			, dataType : "json"
			, contentType : "application/json"
			//4.코너정보
			, data : "{'txHeader':{'txId':'IF_FC_CORNER_RESULT', 'encoding':'utf-8', 'encYn':'false', 'txDiv':'SELECTDATA'}, 'txData':{'data':{'A' : '1', 'B' : '2'}}, 'txResult':{}}"
			// JSON 공통 샘플
		    //, data : "{'txHeader':{'txId':'ExtIfTable', 'encoding':'utf-8', 'encYn':'false'}, 'txData':{'datas':[{'empNo':'2234', 'empNm':'아무개', 'deptNm':'아무부서'}, {'empNo':'2235', 'empNm':'홍길동', 'deptNm':'아무부서'}]}, 'txResult':{}}"
		    , success : function (data) {
		    	alert(data.txResult.resultCode + "\n" + data.txResult.resultMessage);
		    }
		});
	});
	
	$("#btn5").bind("click", function() {
		$.ajax({
			  type : "POST"
			, url : "http://localhost:8080/sc/cmn/jsonCommon.jDo"
			, dataType : "json"
			, contentType : "application/json"
			//5.거래처정보
			, data : "{'txHeader':{'txId':'IF_FC_CUST_RESULT', 'encoding':'utf-8', 'encYn':'false', 'txDiv':'SELECTDATA'}, 'txData':{'data':{'A' : '1', 'B' : '2'}}, 'txResult':{}}"
			// JSON 공통 샘플
		    //, data : "{'txHeader':{'txId':'ExtIfTable', 'encoding':'utf-8', 'encYn':'false'}, 'txData':{'datas':[{'empNo':'2234', 'empNm':'아무개', 'deptNm':'아무부서'}, {'empNo':'2235', 'empNm':'홍길동', 'deptNm':'아무부서'}]}, 'txResult':{}}"
		    , success : function (data) {
		    	alert(data.txResult.resultCode + "\n" + data.txResult.resultMessage);
		    }
		});
	});
	
	$("#btn6").bind("click", function() {
		$.ajax({
			  type : "POST"
			, url : "http://localhost:8080/sc/cmn/jsonCommon.jDo"
			, dataType : "json"
			, contentType : "application/json"
			//6.날씨정보
			, data : "{'txHeader':{'txId':'IF_FC_WEATHER_RESULT', 'encoding':'utf-8', 'encYn':'false', 'txDiv':'SELECTDATA'}, 'txData':{'data':{'A' : '1', 'B' : '2'}}, 'txResult':{}}"
			// JSON 공통 샘플
		    //, data : "{'txHeader':{'txId':'ExtIfTable', 'encoding':'utf-8', 'encYn':'false'}, 'txData':{'datas':[{'empNo':'2234', 'empNm':'아무개', 'deptNm':'아무부서'}, {'empNo':'2235', 'empNm':'홍길동', 'deptNm':'아무부서'}]}, 'txResult':{}}"
		    , success : function (data) {
		    	var ct=0;
		    	$.each(data,function(index, value){
                    ct++;
               });
		    	ct = Object.keys(data).length;
		    	alert(data.txResult.resultCode + "\n" + data.txResult.resultMessage + "\n" + ct);
		    }
		});
	});
	
	$("#btn7").bind("click", function() {
		$.ajax({
			  type : "POST"
			, url : "http://localhost:8080/sc/cmn/jsonCommon.jDo"
			, dataType : "json"
			, contentType : "application/json"
			//7.식수정보
			, data : "{'txHeader':{'txId':'IF_FC_MEALQTY_RESULT', 'encoding':'utf-8', 'encYn':'false', 'txDiv':'SELECTDATA'}, 'txData':{'data':{'A' : '1', 'B' : '2'}}, 'txResult':{}}"
			// JSON 공통 샘플
		    //, data : "{'txHeader':{'txId':'ExtIfTable', 'encoding':'utf-8', 'encYn':'false'}, 'txData':{'datas':[{'empNo':'2234', 'empNm':'아무개', 'deptNm':'아무부서'}, {'empNo':'2235', 'empNm':'홍길동', 'deptNm':'아무부서'}]}, 'txResult':{}}"
		    , success : function (data) {
		    	alert(data.txResult.resultCode + "\n" + data.txResult.resultMessage);
		    }
		});
	});
	
	$("#btn8").bind("click", function() {
		$.ajax({
			  type : "POST"
			, url : "http://localhost:8080/sc/cmn/jsonCommon.jDo"
			, dataType : "json"
			, contentType : "application/json"
			//8.식단정보
			, data : "{'txHeader':{'txId':'IF_FC_MENU_RESULT', 'encoding':'utf-8', 'encYn':'false', 'txDiv':'SELECTDATA'}, 'txData':{'data':{'A' : '1', 'B' : '2'}}, 'txResult':{}}"
			// JSON 공통 샘플
		    //, data : "{'txHeader':{'txId':'ExtIfTable', 'encoding':'utf-8', 'encYn':'false'}, 'txData':{'datas':[{'empNo':'2234', 'empNm':'아무개', 'deptNm':'아무부서'}, {'empNo':'2235', 'empNm':'홍길동', 'deptNm':'아무부서'}]}, 'txResult':{}}"
		    , success : function (data) {
		    	alert(data.txResult.resultCode + "\n" + data.txResult.resultMessage);
		    }
		});
	});
	
});
</script>
</head>
<body>
<input type="button" id="btn1" name="btn1" value="1.업장정보" /><p>
<input type="button" id="btn2" name="btn2" value="2.식당정보" /><p>
<input type="button" id="btn3" name="btn3" value="3.끼니정보" /><p>
<input type="button" id="btn4" name="btn4" value="4.코너정보" /><p>
<input type="button" id="btn5" name="btn5" value="5.거래처정보" /><p>
<input type="button" id="btn6" name="btn6" value="6.날씨정보" /><p>
<input type="button" id="btn7" name="btn7" value="7.식수정보" /><p>
<input type="button" id="btn8" name="btn8" value="8.식단정보" />


</body>
</html>