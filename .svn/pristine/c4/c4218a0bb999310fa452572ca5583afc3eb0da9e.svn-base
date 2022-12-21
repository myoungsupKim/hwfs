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
		$("#result").empty();
        var sdata = "";
        sdata += "{                                           ";
        sdata += "    'txHeader': {                           ";
        sdata += "        'txDiv': 'SelectItem',              ";
        sdata += "        'txId': 'IF_CONSUMABLE_SERVICE',    ";
        sdata += "        'encoding': 'utf-8',                ";
        sdata += "        'encYn': 'false'                    ";
        sdata += "    },                                      ";
        sdata += "    'txData': {                             ";
        sdata += "        'data':                             ";
        sdata += "        {                                   ";
        sdata += "            'searchGubun': '2',             ";
        sdata += "            'searchText': '티슈',            ";
        sdata += "            'needDate': '20221006',         ";
        sdata += "            'centerCode': '300008',         ";
        sdata += "            'operOrgSnPurc': '911',         ";
        sdata += "            'shopGrpCd': 'SH000738',        ";
        sdata += "            'pageNum': 1,                   ";
        sdata += "            'listCnt': 10                   ";
        sdata += "        }                                   ";
        sdata += "    },                                      ";
        sdata += "    'txResult': {                           ";
        sdata += "        'resultDateTime': '',               ";
        sdata += "        'resultCode': '',                   ";
        sdata += "        'resultMessage': ''                 ";
        sdata += "    }                                       ";
        sdata += "}                                           ";
		$.ajax({
			  type : "POST"
			, url : "http://172.16.1.121:8091/mobileApp/jsonCommon.jDo"
			, dataType : "json"
			, contentType : "application/json"
			, data : sdata
			, success : function (data) {
				var txResult = data.txResult;
				var resultCode = txResult.resultCode;
				var resultMessage = txResult.resultMessage;

				if(resultCode == 0) {
	  				var txData = data.txData.data;
	  				var jsonData = JSON.parse(txData);
	  				var resultCount = jsonData.resultCount;
	  				var resultData = jsonData.resultData;
	  				var dataList = JSON.parse(resultData);
	  
	  				var html = "";
	  				html += "<h1>결과코드 : "+ resultCode +"</h1>";
	  				html += "<h1>결과메세지 : "+ resultMessage +"</h1>";
	  				html += "<h1>결과건수 : "+ resultCount +"</h1>";
	  				html += "<table border=1>"
	  				for(var i = 0; i < dataList.length; i ++) {
	  				  if(i == 0) {
	  					html += "<tr>";
	  					html += "<td align='center' width='100'>A</td>";
	  					html += "<td align='center' width='100'>B</td>";
	  					html += "<td align='center' width='100'>C</td>";
	  					html += "<td align='center' width='100'>D</td>";
	  					html += "<td align='center' width='100'>E</td>";
	  					html += "<td align='center' width='100'>F</td>";
	  					html += "</tr>";
	  				  }
	  					html += "<tr>";
	  					html += "<td>" + dataList[i].itemCd + "</td>";
	  					html += "<td>" + dataList[i].itemNm + "</td>";
	  					html += "<td>" + dataList[i].spec + "</td>";
	  					html += "<td>" + dataList[i].unitNm + "</td>";
	  					html += "<td>" + dataList[i].itemMgtPrice + "</td>";
	  					html += "<td>" + dataList[i].itemBuyPrice + "</td>";
	  					html += "</tr>";
	  				}
	  				html += "</table>";
	  				$("#result").append(html);
				}
				else {
	  				var ehtml = "";
	  				ehtml += "<h1>결과코드 : "+ resultCode +"</h1>";
	  				ehtml += "<h1>결과메세지 : "+ resultMessage +"</h1>";
	  				$("#result").append(ehtml);
				}
		    }
		    , error : function(request) {
		    	alert("API 요청 오류");
		    }
		});
	});
	
	$("#btn2").bind("click", function() {
		$("#result").empty();
        var sdata = "";
        sdata += "{                                           ";
        sdata += "    'txHeader': {                           ";
        sdata += "        'txDiv': 'SelectCtrlAmt',           ";
        sdata += "        'txId': 'IF_ORDER_SERVICE',         ";
        sdata += "        'encoding': 'utf-8',                ";
        sdata += "        'encYn': 'false'                    ";
        sdata += "    },                                      ";
        sdata += "    'txData': {                             ";
        sdata += "        'data':                             ";
        sdata += "        {                                   ";
        sdata += "            'upjangCd': '189843',           ";
        sdata += "            'needDate': '20221006'          ";
        sdata += "        }                                   ";
        sdata += "    },                                      ";
        sdata += "    'txResult': {                           ";
        sdata += "        'resultDateTime': '',               ";
        sdata += "        'resultCode': '',                   ";
        sdata += "        'resultMessage': ''                 ";
        sdata += "    }                                       ";
        sdata += "}                                           ";
		$.ajax({
			  type : "POST"
			, url : "http://172.16.1.121:8091/mobileApp/jsonCommon.jDo"
			, dataType : "json"
			, contentType : "application/json"
			, data : sdata
			, success : function (data) {
				var txResult = data.txResult;
				var resultCode = txResult.resultCode;
				var resultMessage = txResult.resultMessage;

				if(resultCode == 0) {
	  				var txData = data.txData.data;
	  				var jsonData = JSON.parse(txData);
	  				var resultCount = jsonData.resultCount;
	  				var resultData = jsonData.resultData;
	  				var dataList = JSON.parse(resultData);
	  
	  				var html = "";
	  				html += "<h1>결과코드 : "+ resultCode +"</h1>";
	  				html += "<h1>결과메세지 : "+ resultMessage +"</h1>";
	  				html += "<h1>결과건수 : "+ resultCount +"</h1>";
	  				html += "<table border=1>"
	  				for(var i = 0; i < dataList.length; i ++) {
	  				  if(i == 0) {
	  					html += "<tr>";
	  					html += "<td align='center' width='100'>A</td>";
	  					html += "<td align='center' width='100'>B</td>";
	  					html += "<td align='center' width='100'>C</td>";
	  					html += "<td align='center' width='100'>D</td>";
	  					html += "</tr>";
	  				  }
	  					html += "<tr>";
	  					html += "<td>" + dataList[i].creditAmount + "</td>";
	  					html += "<td>" + dataList[i].creditRmnAmt + "</td>";
	  					html += "<td>" + dataList[i].bondAmt + "</td>";
	  					html += "<td>" + dataList[i].creditCtrlYn + "</td>";
	  					html += "</tr>";
	  				}
	  				html += "</table>";
	  				$("#result").append(html);
				}
				else {
	  				var ehtml = "";
	  				ehtml += "<h1>결과코드 : "+ resultCode +"</h1>";
	  				ehtml += "<h1>결과메세지 : "+ resultMessage +"</h1>";
	  				$("#result").append(ehtml);
				}
		    }
		    , error : function(request) {
		    	alert("API 요청 오류");
		    }
		});
	});
	
	$("#btn3").bind("click", function() {
		$("#result").empty();
        var sdata = "";
        sdata += "{                                           ";
        sdata += "    'txHeader': {                           ";
        sdata += "        'txDiv': 'SelectUpjangInfo',        ";
        sdata += "        'txId': 'IF_MAIN_SERVICE',          ";
        sdata += "        'encoding': 'utf-8',                ";
        sdata += "        'encYn': 'false'                    ";
        sdata += "    },                                      ";
        sdata += "    'txData': {                             ";
        sdata += "        'data':                             ";
        sdata += "        {                                   ";
        sdata += "            'upjangCd': '100751',           ";
        sdata += "            'poType': ''                    ";
        sdata += "        }                                   ";
        sdata += "    },                                      ";
        sdata += "    'txResult': {                           ";
        sdata += "        'resultDateTime': '',               ";
        sdata += "        'resultCode': '',                   ";
        sdata += "        'resultMessage': ''                 ";
        sdata += "    }                                       ";
        sdata += "}                                           ";
		$.ajax({
			  type : "POST"
			, url : "http://172.16.1.121:8091/mobileApp/jsonCommon.jDo"
			, dataType : "json"
			, contentType : "application/json"
			, data : sdata
			, success : function (data) {
				var txResult = data.txResult;
				var resultCode = txResult.resultCode;
				var resultMessage = txResult.resultMessage;

				if(resultCode == 0) {
	  				var txData = data.txData.data;
	  				var jsonData = JSON.parse(txData);
	  				var resultCount = jsonData.resultCount;
	  				var resultData = jsonData.resultData;
	  				var dataList = JSON.parse(resultData);
	  
	  				var html = "";
	  				html += "<h1>결과코드 : "+ resultCode +"</h1>";
	  				html += "<h1>결과메세지 : "+ resultMessage +"</h1>";
	  				html += "<h1>결과건수 : "+ resultCount +"</h1>";
	  				html += "<table border=1>"
	  				for(var i = 0; i < dataList.length; i ++) {
	  				  if(i == 0) {
	  					html += "<tr>";
	  					html += "<td align='center' width='100'>A</td>";
	  					html += "<td align='center' width='100'>B</td>";
	  					html += "<td align='center' width='100'>C</td>";
	  					html += "<td align='center' width='100'>D</td>";
	  					html += "<td align='center' width='100'>E</td>";
	  					html += "<td align='center' width='100'>F</td>";
	  					html += "<td align='center' width='100'>G</td>";
	  					html += "<td align='center' width='100'>H</td>";
	  					html += "</tr>";
	  				  }
	  					html += "<tr>";
	  					html += "<td>" + dataList[i].salesNm + "</td>";
	  					html += "<td>" + dataList[i].salesTelno + "</td>";
	  					html += "<td>" + dataList[i].csNm + "</td>";
	  					html += "<td>" + dataList[i].csTelno + "</td>";
	  					html += "<td>" + dataList[i].bankNm + "</td>";
	  					html += "<td>" + dataList[i].centerCode + "</td>";
	  					html += "<td>" + dataList[i].operOrgSnPurc + "</td>";
	  					html += "<td>" + dataList[i].apUnitpriceUpjang + "</td>";
	  					html += "</tr>";
	  				}
	  				html += "</table>";
	  				$("#result").append(html);
				}
				else {
	  				var ehtml = "";
	  				ehtml += "<h1>결과코드 : "+ resultCode +"</h1>";
	  				ehtml += "<h1>결과메세지 : "+ resultMessage +"</h1>";
	  				$("#result").append(ehtml);
				}
		    }
		    , error : function(request) {
		    	alert("API 요청 오류");
		    }
		});
	});
	
	$("#btn4").bind("click", function() {
		$("#result").empty();
        var sdata = "";
        sdata += "{                                           ";
        sdata += "    'txHeader': {                           ";
        sdata += "        'txDiv': 'SelectNeeddtInfo',        ";
        sdata += "        'txId': 'IF_MAIN_SERVICE',          ";
        sdata += "        'encoding': 'utf-8',                ";
        sdata += "        'encYn': 'false'                    ";
        sdata += "    },                                      ";
        sdata += "    'txData': {                             ";
        sdata += "        'data':                             ";
        sdata += "        {                                   ";
        sdata += "            'upjangCd': '160571',           ";
        sdata += "            'subinvCd': 'S115012790',       ";
        sdata += "            'needDate': '20221006'          ";
        sdata += "        }                                   ";
        sdata += "    },                                      ";
        sdata += "    'txResult': {                           ";
        sdata += "        'resultDateTime': '',               ";
        sdata += "        'resultCode': '',                   ";
        sdata += "        'resultMessage': ''                 ";
        sdata += "    }                                       ";
        sdata += "}                                           ";
		$.ajax({
			  type : "POST"
			, url : "http://172.16.1.121:8091/mobileApp/jsonCommon.jDo"
			, dataType : "json"
			, contentType : "application/json"
			, data : sdata
			, success : function (data) {
				var txResult = data.txResult;
				var resultCode = txResult.resultCode;
				var resultMessage = txResult.resultMessage;

				if(resultCode == 0) {
	  				var txData = data.txData.data;
	  				var jsonData = JSON.parse(txData);
	  				var resultCount = jsonData.resultCount;
	  				var resultData = jsonData.resultData;
	  				var dataList = JSON.parse(resultData);
	  
	  				var html = "";
	  				html += "<h1>결과코드 : "+ resultCode +"</h1>";
	  				html += "<h1>결과메세지 : "+ resultMessage +"</h1>";
	  				html += "<h1>결과건수 : "+ resultCount +"</h1>";
	  				html += "<table border=1>"
	  				for(var i = 0; i < dataList.length; i ++) {
	  				  if(i == 0) {
	  					html += "<tr>";
	  					html += "<td align='center' width='100'>A</td>";
	  					html += "<td align='center' width='100'>B</td>";
	  					html += "<td align='center' width='100'>C</td>";
	  					html += "</tr>";
	  				  }
	  					html += "<tr>";
	  					html += "<td>" + dataList[i].creditRmnAmt + "</td>";
	  					html += "<td>" + dataList[i].bondAmt + "</td>";
	  					html += "<td>" + dataList[i].creditCtrlYn + "</td>";
	  					html += "</tr>";
	  				}
	  				html += "</table>";
	  				$("#result").append(html);
				}
				else {
	  				var ehtml = "";
	  				ehtml += "<h1>결과코드 : "+ resultCode +"</h1>";
	  				ehtml += "<h1>결과메세지 : "+ resultMessage +"</h1>";
	  				$("#result").append(ehtml);
				}
		    }
		    , error : function(request) {
		    	alert("API 요청 오류");
		    }
		});
	});
	
	$("#btn5").bind("click", function() {
		$("#result").empty();
        var sdata = "";
        sdata += "{                                           ";
        sdata += "    'txHeader': {                           ";
        sdata += "        'txDiv': 'SelectInventoryInfo',     ";
        sdata += "        'txId': 'IF_INVENTORY_SERVICE',     ";
        sdata += "        'encoding': 'utf-8',                ";
        sdata += "        'encYn': 'false'                    ";
        sdata += "    },                                      ";
        sdata += "    'txData': {                             ";
        sdata += "        'data':                             ";
        sdata += "        {                                   ";
        sdata += "            'centerCode': '300008',         ";
        sdata += "            'searchText': 'F',              ";
        sdata += "            'sortCondition': '3',           ";
        sdata += "            'sortStandard': 'DSC',          ";
        sdata += "            'pageNum': '1',                 ";
        sdata += "            'listCnt': '20'                 ";
        sdata += "        }                                   ";
        sdata += "    },                                      ";
        sdata += "    'txResult': {                           ";
        sdata += "        'resultDateTime': '',               ";
        sdata += "        'resultCode': '',                   ";
        sdata += "        'resultMessage': ''                 ";
        sdata += "    }                                       ";
        sdata += "}                                           ";
		$.ajax({
			  type : "POST"
			, url : "http://172.16.1.121:8091/mobileApp/jsonCommon.jDo"
			, dataType : "json"
			, contentType : "application/json"
			, data : sdata
			, success : function (data) {
				var txResult = data.txResult;
				var resultCode = txResult.resultCode;
				var resultMessage = txResult.resultMessage;

				if(resultCode == 0) {
	  				var txData = data.txData.data;
	  				var jsonData = JSON.parse(txData);
	  				var resultCount = jsonData.resultCount;
	  				var resultData = jsonData.resultData;
	  				var dataList = JSON.parse(resultData);
	  
	  				var html = "";
	  				html += "<h1>결과코드 : "+ resultCode +"</h1>";
	  				html += "<h1>결과메세지 : "+ resultMessage +"</h1>";
	  				html += "<h1>결과건수 : "+ resultCount +"</h1>";
	  				html += "<table border=1>"
	  				for(var i = 0; i < dataList.length; i ++) {
	  				  if(i == 0) {
	  					html += "<tr>";
	  					html += "<td align='center' width='100'>A</td>";
	  					html += "<td align='center' width='100'>B</td>";
	  					html += "<td align='center' width='100'>C</td>";
	  					html += "<td align='center' width='100'>D</td>";
	  					html += "<td align='center' width='100'>E</td>";
	  					html += "</tr>";
	  				  }
	  					html += "<tr>";
	  					html += "<td>" + dataList[i].itemCode + "</td>";
	  					html += "<td>" + dataList[i].itemName + "</td>";
	  					html += "<td>" + dataList[i].qty + "</td>";
	  					html += "<td>" + dataList[i].listnum + "</td>";
	  					html += "<td>" + dataList[i].rowcnt + "</td>";
	  					html += "</tr>";
	  				}
	  				html += "</table>";
	  				$("#result").append(html);
				}
				else {
	  				var ehtml = "";
	  				ehtml += "<h1>결과코드 : "+ resultCode +"</h1>";
	  				ehtml += "<h1>결과메세지 : "+ resultMessage +"</h1>";
	  				$("#result").append(ehtml);
				}
		    }
		    , error : function(request) {
		    	alert("API 요청 오류");
		    }
		});
	});

	$("#btn6").bind("click", function() {
		$("#result").empty();
        var sdata = "";
        sdata += "{                                       ";
        sdata += "    'txHeader': {                       ";
        sdata += "        'txDiv': 'SelectPreOrder',      ";
        sdata += "        'txId': 'IF_ORDER_SERVICE',     ";
        sdata += "        'encoding': 'utf-8',            ";
        sdata += "        'encYn': 'false'                ";
        sdata += "    },                                  ";
        sdata += "    'txData': {                         ";
        sdata += "        'data':                         ";
        sdata += "          {                             ";
        sdata += "            'upjangCd': '198846',       ";
        sdata += "            'subinvCd': 'S121011899',   ";
        sdata += "            'startDt': '20220901',      ";
        sdata += "            'endDt': '20220930'         ";
        sdata += "          }                             ";
        sdata += "    },                                  ";
        sdata += "    'txResult': {                       ";
        sdata += "        'resultDateTime': '',           ";
        sdata += "        'resultCode': '',               ";
        sdata += "        'resultMessage': ''             ";
        sdata += "    }                                   ";
        sdata += "}                                       ";
		$.ajax({
			  type : "POST"
			, url : "http://172.16.1.121:8091/mobileApp/jsonCommon.jDo"
			, dataType : "json"
			, contentType : "application/json"
			, data : sdata
			, success : function (data) {
				var txResult = data.txResult;
				var resultCode = txResult.resultCode;
				var resultMessage = txResult.resultMessage;

				if(resultCode == 0) {
	  				var txData = data.txData.data;
	  				var jsonData = JSON.parse(txData);
	  				var resultCount = jsonData.resultCount;
	  				var resultData = jsonData.resultData;
	  				var dataList = JSON.parse(resultData);
	  
	  				var html = "";
	  				html += "<h1>결과코드 : "+ resultCode +"</h1>";
	  				html += "<h1>결과메세지 : "+ resultMessage +"</h1>";
	  				html += "<h1>결과건수 : "+ resultCount +"</h1>";
	  				html += "<table border=1>"
	  				for(var i = 0; i < dataList.length; i ++) {
	  				  if(i == 0) {
	  					html += "<tr>";
	  					html += "<td align='center' width='100'>A</td>";
	  					html += "</tr>";
	  				  }
	  					html += "<tr>";
	  					html += "<td>" + dataList[i].itemCode + "</td>";
	  					html += "</tr>";
	  				}
	  				html += "</table>";
	  				$("#result").append(html);
				}
				else {
	  				var ehtml = "";
	  				ehtml += "<h1>결과코드 : "+ resultCode +"</h1>";
	  				ehtml += "<h1>결과메세지 : "+ resultMessage +"</h1>";
	  				$("#result").append(ehtml);
				}
		    }
		    , error : function(request) {
		    	alert("API 요청 오류");
		    }
		});
	});

	$("#btn7").bind("click", function() {
		$("#result").empty();
        var sdata = "";
        sdata += "{                                        ";
        sdata += "    'txHeader': {                        ";
        sdata += "        'txDiv': 'SelectOrderInfo',      ";
        sdata += "        'txId': 'IF_ORDER_SERVICE',      ";
        sdata += "        'encoding': 'utf-8',             ";
        sdata += "        'encYn': 'false'                 ";
        sdata += "    },                                   ";
        sdata += "    'txData': {                          ";
        sdata += "        'data':                          ";
        sdata += "          {                              ";
        sdata += "            'subinvCode': 'S121011899',  ";
        sdata += "            'needDate': '20220901',      ";
        sdata += "            'qtyControlYn': 'Y'          ";
        sdata += "          }                              ";
        sdata += "    },                                   ";
        sdata += "    'txResult': {                        ";
        sdata += "        'resultDateTime': '',            ";
        sdata += "        'resultCode': '',                ";
        sdata += "        'resultMessage': ''              ";
        sdata += "    }                                    ";
        sdata += "}                                        ";
		$.ajax({
			  type : "POST"
			, url : "http://172.16.1.121:8091/mobileApp/jsonCommon.jDo"
			, dataType : "json"
			, contentType : "application/json"
			, data : sdata
			, success : function (data) {
				var txResult = data.txResult;
				var resultCode = txResult.resultCode;
				var resultMessage = txResult.resultMessage;

				if(resultCode == 0) {
	  				var txData = data.txData.data;
	  				var jsonData = JSON.parse(txData);
	  				var resultCount = jsonData.resultCount;
	  				var resultData = jsonData.resultData;
	  				var dataList = JSON.parse(resultData);
	  
	  				var html = "";
	  				html += "<h1>결과코드 : "+ resultCode +"</h1>";
	  				html += "<h1>결과메세지 : "+ resultMessage +"</h1>";
	  				html += "<h1>결과건수 : "+ resultCount +"</h1>";
	  				html += "<table border=1>"
	  				for(var i = 0; i < dataList.length; i ++) {
	  				  if(i == 0) {
	  					html += "<tr>";
	  					html += "<td align='center' width='100'>A</td>";
	  					html += "<td align='center' width='100'>A</td>";
	  					html += "<td align='center' width='100'>A</td>";
	  					html += "<td align='center' width='100'>A</td>";
	  					html += "<td align='center' width='100'>A</td>";
	  					html += "<td align='center' width='100'>A</td>";
	  					html += "<td align='center' width='100'>A</td>";
	  					html += "<td align='center' width='100'>A</td>";
	  					html += "<td align='center' width='100'>A</td>";
	  					html += "<td align='center' width='100'>A</td>";
	  					html += "<td align='center' width='100'>A</td>";
	  					html += "<td align='center' width='100'>A</td>";
	  					html += "<td align='center' width='100'>A</td>";
	  					html += "<td align='center' width='100'>A</td>";
	  					html += "<td align='center' width='100'>A</td>";
	  					html += "<td align='center' width='100'>A</td>";
	  					html += "<td align='center' width='100'>A</td>";
	  					html += "<td align='center' width='100'>A</td>";
	  					html += "<td align='center' width='100'>A</td>";
	  					html += "<td align='center' width='100'>A</td>";
	  					html += "<td align='center' width='100'>A</td>";
	  					html += "</tr>";
	  				  }
	  					html += "<tr>";
	  					html += "<td>" + dataList[i].itemCode + "</td>";
	  					html += "<td>" + dataList[i].itemName + "</td>";
	  					html += "<td>" + dataList[i].itemSize + "</td>";
	  					html += "<td>" + dataList[i].originType + "</td>";
	  					html += "<td>" + dataList[i].poUom + "</td>";
	  					html += "<td>" + dataList[i].keepingType + "</td>";
	  					html += "<td>" + dataList[i].opPrice + "</td>";
	  					html += "<td>" + dataList[i].prQty + "</td>";
	  					html += "<td>" + dataList[i].totWght + "</td>";
	  					html += "<td>" + dataList[i].opAmount + "</td>";
	  					html += "<td>" + dataList[i].taxCode + "</td>";
	  					html += "<td>" + dataList[i].prRemark + "</td>";
	  					html += "<td>" + dataList[i].poLineStatus + "</td>";
	  					html += "<td>" + dataList[i].clsStatus + "</td>";
	  					html += "<td>" + dataList[i].dDayDisp + "</td>";
	  					html += "<td>" + dataList[i].vcYn + "</td>";
	  					html += "<td>" + dataList[i].prNum + "</td>";
	  					html += "<td>" + dataList[i].docuGb + "</td>";
	  					html += "<td>" + dataList[i].approveTime + "</td>";
	  					html += "<td>" + dataList[i].prId + "</td>";
	  					html += "<td>" + dataList[i].approveNum + "</td>";
	  					html += "</tr>";
	  				}
	  				html += "</table>";
	  				$("#result").append(html);
				}
				else {
	  				var ehtml = "";
	  				ehtml += "<h1>결과코드 : "+ resultCode +"</h1>";
	  				ehtml += "<h1>결과메세지 : "+ resultMessage +"</h1>";
	  				$("#result").append(ehtml);
				}
		    }
		    , error : function(request) {
		    	alert("API 요청 오류");
		    }
		});
	});

	$("#btn8").bind("click", function() {
		$("#result").empty();
        var sdata = "";
        sdata += "{                                         ";
        sdata += "    'txHeader': {                         ";
        sdata += "        'txDiv': 'SelectOrderHistInfo',   ";
        sdata += "        'txId': 'IF_ORDER_SERVICE',       ";
        sdata += "        'encoding': 'utf-8',              ";
        sdata += "        'encYn': 'false'                  ";
        sdata += "    },                                    ";
        sdata += "    'txData': {                           ";
        sdata += "        'data':                           ";
        sdata += "          {                               ";
        sdata += "            'upjangCd': '189843',         ";
        sdata += "            'startDt': '20220801',        ";
        sdata += "            'endDt': '20220831'           ";
        sdata += "          }                               ";
        sdata += "    },                                    ";
        sdata += "    'txResult': {                         ";
        sdata += "        'resultDateTime': '',             ";
        sdata += "        'resultCode': '',                 ";
        sdata += "        'resultMessage': ''               ";
        sdata += "    }                                     ";
        sdata += "}                                         ";
		$.ajax({
			  type : "POST"
			, url : "http://172.16.1.121:8091/mobileApp/jsonCommon.jDo"
			, dataType : "json"
			, contentType : "application/json"
			, data : sdata
			, success : function (data) {
				var txResult = data.txResult;
				var resultCode = txResult.resultCode;
				var resultMessage = txResult.resultMessage;

				if(resultCode == 0) {
	  				var txData = data.txData.data;
	  				var jsonData = JSON.parse(txData);
	  				var resultCount = jsonData.resultCount;
	  				var resultData = jsonData.resultData;
	  				var dataList = JSON.parse(resultData);
	  
	  				var html = "";
	  				html += "<h1>결과코드 : "+ resultCode +"</h1>";
	  				html += "<h1>결과메세지 : "+ resultMessage +"</h1>";
	  				html += "<h1>결과건수 : "+ resultCount +"</h1>";
	  				html += "<table border=1>"
	  				for(var i = 0; i < dataList.length; i ++) {
	  				  if(i == 0) {
	  					html += "<tr>";
	  					html += "<td align='center' width='100'>A</td>";
	  					html += "<td align='center' width='100'>A</td>";
	  					html += "<td align='center' width='100'>A</td>";
	  					html += "<td align='center' width='100'>A</td>";
	  					html += "<td align='center' width='100'>A</td>";
	  					html += "<td align='center' width='100'>A</td>";
	  					html += "<td align='center' width='100'>A</td>";
	  					html += "<td align='center' width='100'>A</td>";
	  					html += "<td align='center' width='100'>A</td>";
	  					html += "</tr>";
	  				  }
	  					html += "<tr>";
	  					html += "<td>" + dataList[i].prNum + "</td>";
	  					html += "<td>" + dataList[i].needDate + "</td>";
	  					html += "<td>" + dataList[i].centerCode + "</td>";
	  					html += "<td>" + dataList[i].poType + "</td>";
	  					html += "<td>" + dataList[i].poTypeName + "</td>";
	  					html += "<td>" + dataList[i].poLineStatusCd + "</td>";
	  					html += "<td>" + dataList[i].poLineStatus + "</td>";
	  					html += "<td>" + dataList[i].tot + "</td>";
	  					html += "<td>" + dataList[i].title + "</td>";
	  					html += "</tr>";
	  				}
	  				html += "</table>";
	  				$("#result").append(html);
				}
				else {
	  				var ehtml = "";
	  				ehtml += "<h1>결과코드 : "+ resultCode +"</h1>";
	  				ehtml += "<h1>결과메세지 : "+ resultMessage +"</h1>";
	  				$("#result").append(ehtml);
				}
		    }
		    , error : function(request) {
		    	alert("API 요청 오류");
		    }
		});
	});

	$("#btn9").bind("click", function() {
		$("#result").empty();
        var sdata = "";
        sdata += "{                                         ";
        sdata += "    'txHeader': {                         ";
        sdata += "        'txDiv': 'SelectDelvHistInfo',    ";
        sdata += "        'txId': 'IF_ORDER_SERVICE',       ";
        sdata += "        'encoding': 'utf-8',              ";
        sdata += "        'encYn': 'false'                  ";
        sdata += "    },                                    ";
        sdata += "    'txData': {                           ";
        sdata += "        'data':                           ";
        sdata += "          {                               ";
        sdata += "            'upjangCd': '195950',         ";
        sdata += "            'subinvCd':'S121007538',      ";
        sdata += "            'startDt': '20220701',        ";
        sdata += "            'endDt': '20220930'           ";
        sdata += "          }                               ";
        sdata += "    },                                    ";
        sdata += "    'txResult': {                         ";
        sdata += "        'resultDateTime': '',             ";
        sdata += "        'resultCode': '',                 ";
        sdata += "        'resultMessage': ''               ";
        sdata += "    }                                     ";
        sdata += "}                                         ";
		$.ajax({
			  type : "POST"
			, url : "http://172.16.1.121:8091/mobileApp/jsonCommon.jDo"
			, dataType : "json"
			, contentType : "application/json"
			, data : sdata
			, success : function (data) {
				var txResult = data.txResult;
				var resultCode = txResult.resultCode;
				var resultMessage = txResult.resultMessage;

				if(resultCode == 0) {
	  				var txData = data.txData.data;
	  				var jsonData = JSON.parse(txData);
	  				var resultCount = jsonData.resultCount;
	  				var resultData = jsonData.resultData;
	  				var dataList = JSON.parse(resultData);
	  
	  				var html = "";
	  				html += "<h1>결과코드 : "+ resultCode +"</h1>";
	  				html += "<h1>결과메세지 : "+ resultMessage +"</h1>";
	  				html += "<h1>결과건수 : "+ resultCount +"</h1>";
	  				html += "<table border=1>"
	  				for(var i = 0; i < dataList.length; i ++) {
	  				  if(i == 0) {
	  					html += "<tr>";
	  					html += "<td align='center' width='100'>A</td>";
	  					html += "<td align='center' width='100'>A</td>";
	  					html += "<td align='center' width='100'>A</td>";
	  					html += "<td align='center' width='100'>A</td>";
	  					html += "<td align='center' width='100'>A</td>";
	  					html += "<td align='center' width='100'>A</td>";
	  					html += "<td align='center' width='100'>A</td>";
	  					html += "<td align='center' width='100'>A</td>";
	  					html += "<td align='center' width='100'>A</td>";
	  					html += "<td align='center' width='100'>A</td>";
	  					html += "<td align='center' width='100'>A</td>";
	  					html += "<td align='center' width='100'>A</td>";
	  					html += "</tr>";
	  				  }
	  					html += "<tr>";
	  					html += "<td>" + dataList[i].prNum + "</td>";
	  					html += "<td>" + dataList[i].needDate + "</td>";
	  					html += "<td>" + dataList[i].poType + "</td>";
	  					html += "<td>" + dataList[i].poTypeName + "</td>";
	  					html += "<td>" + dataList[i].poLineStatusCd + "</td>";
	  					html += "<td>" + dataList[i].deliStatus + "</td>";
	  					html += "<td>" + dataList[i].tot + "</td>";
	  					html += "<td>" + dataList[i].title + "</td>";
	  					html += "<td>" + dataList[i].itemQtyTot + "</td>";
	  					html += "<td>" + dataList[i].grQtyTot + "</td>";
	  					html += "<td>" + dataList[i].undeliveredQtyTot + "</td>";
	  					html += "<td>" + dataList[i].mTransDate + "</td>";
	  					html += "</tr>";
	  				}
	  				html += "</table>";
	  				$("#result").append(html);
				}
				else {
	  				var ehtml = "";
	  				ehtml += "<h1>결과코드 : "+ resultCode +"</h1>";
	  				ehtml += "<h1>결과메세지 : "+ resultMessage +"</h1>";
	  				$("#result").append(ehtml);
				}
		    }
		    , error : function(request) {
		    	alert("API 요청 오류");
		    }
		});
	});

	$("#btn10").bind("click", function() {
		$("#result").empty();
        var sdata = "";
        sdata += "{                                         ";
        sdata += "    'txHeader': {                         ";
        sdata += "        'txDiv': 'SelectInfo',            ";
        sdata += "        'txId': 'IF_CONSUMABLE_SERVICE',  ";
        sdata += "        'encoding': 'utf-8',              ";
        sdata += "        'encYn': 'false'                  ";
        sdata += "    },                                    ";
        sdata += "    'txData': {                           ";
        sdata += "        'data': {                         ";
        sdata += "            'upjangCd': '100751',         ";
        sdata += "            'subinvCode': 'E1000031',     ";
        sdata += "            'needSdate': '20220801',      ";
        sdata += "            'needEdate': '20220831',      ";
        sdata += "            'pageNum': '1',               ";
        sdata += "            'listCnt': '10'               ";
        sdata += "        }                                 ";
        sdata += "    },                                    ";
        sdata += "    'txResult': {                         ";
        sdata += "        'resultDateTime': '',             ";
        sdata += "        'resultCode': '',                 ";
        sdata += "        'resultMessage': ''               ";
        sdata += "    }                                     ";
        sdata += "}                                         ";
		$.ajax({
			  type : "POST"
			, url : "http://172.16.1.121:8091/mobileApp/jsonCommon.jDo"
			, dataType : "json"
			, contentType : "application/json"
			, data : sdata
			, success : function (data) {
				var txResult = data.txResult;
				var resultCode = txResult.resultCode;
				var resultMessage = txResult.resultMessage;

				if(resultCode == 0) {
	  				var txData = data.txData.data;
	  				var jsonData = JSON.parse(txData);
	  				var resultCount = jsonData.resultCount;
	  				var resultData = jsonData.resultData;
	  				var dataList = JSON.parse(resultData);
	  
	  				var html = "";
	  				html += "<h1>결과코드 : "+ resultCode +"</h1>";
	  				html += "<h1>결과메세지 : "+ resultMessage +"</h1>";
	  				html += "<h1>결과건수 : "+ resultCount +"</h1>";
	  				html += "<table border=1>"
	  				for(var i = 0; i < dataList.length; i ++) {
	  				  if(i == 0) {
	  					html += "<tr>";
	  					html += "<td align='center' width='100'>A</td>";
	  					html += "<td align='center' width='100'>A</td>";
	  					html += "<td align='center' width='100'>A</td>";
	  					html += "<td align='center' width='100'>A</td>";
	  					html += "<td align='center' width='100'>A</td>";
	  					html += "<td align='center' width='100'>A</td>";
	  					html += "<td align='center' width='100'>A</td>";
	  					html += "<td align='center' width='100'>A</td>";
	  					html += "<td align='center' width='100'>A</td>";
	  					html += "<td align='center' width='100'>A</td>";
	  					html += "<td align='center' width='100'>A</td>";
	  					html += "</tr>";
	  				  }
	  					html += "<tr>";
	  					html += "<td>" + dataList[i].listnum + "</td>";
	  					html += "<td>" + dataList[i].rowcnt + "</td>";
	  					html += "<td>" + dataList[i].prNo + "</td>";
	  					html += "<td>" + dataList[i].itemCd + "</td>";
	  					html += "<td>" + dataList[i].itemDt + "</td>";
	  					html += "<td>" + dataList[i].prTit + "</td>";
	  					html += "<td>" + dataList[i].purcReqTyp + "</td>";
	  					html += "<td>" + dataList[i].prReqDate + "</td>";
	  					html += "<td>" + dataList[i].grExptDate + "</td>";
	  					html += "<td>" + dataList[i].mgtPriceAmt + "</td>";
	  					html += "<td>" + dataList[i].prRem + "</td>";
	  					html += "</tr>";
	  				}
	  				html += "</table>";
	  				$("#result").append(html);
				}
				else {
	  				var ehtml = "";
	  				ehtml += "<h1>결과코드 : "+ resultCode +"</h1>";
	  				ehtml += "<h1>결과메세지 : "+ resultMessage +"</h1>";
	  				$("#result").append(ehtml);
				}
		    }
		    , error : function(request) {
		    	alert("API 요청 오류");
		    }
		});
	});

	$("#btn11").bind("click", function() {
		$("#result").empty();
        var sdata = "";
        sdata += "{                                         "; 
        sdata += "    'txHeader': {                         ";
        sdata += "        'txDiv': 'UpjangInventoryInfo',   ";
        sdata += "        'txId': 'IF_INVENTORY_SERVICE',   ";
        sdata += "        'encoding': 'utf-8',              ";
        sdata += "        'encYn': 'false'                  ";
        sdata += "    },                                    ";
        sdata += "    'txData': {                           ";
        sdata += "        'data': {                         ";
        sdata += "            'upjangCd': '189053',         ";
        sdata += "            'subinvCode': 'C120009160',   ";
        sdata += "            'reqDate': '20220820',        ";
        sdata += "            'chkPoUom': '2',              ";
        sdata += "            'sortCondition': '1',         ";
        sdata += "            'pageNum': '1',               ";
        sdata += "            'listCnt': '10'               ";
        sdata += "        }                                 ";
        sdata += "    },                                    ";
        sdata += "    'txResult': {                         ";
        sdata += "        'resultDateTime': '',             ";
        sdata += "        'resultCode': '',                 ";
        sdata += "        'resultMessage': ''               ";
        sdata += "    }                                     ";
        sdata += "}                                         ";
		$.ajax({
			  type : "POST"
			, url : "http://172.16.1.121:8091/mobileApp/jsonCommon.jDo"
			, dataType : "json"
			, contentType : "application/json"
			, data : sdata
			, success : function (data) {
				var txResult = data.txResult;
				var resultCode = txResult.resultCode;
				var resultMessage = txResult.resultMessage;

				if(resultCode == 0) {
	  				var txData = data.txData.data;
	  				var jsonData = JSON.parse(txData);
	  				var resultCount = jsonData.resultCount;
	  				var resultData = jsonData.resultData;
	  				var dataList = JSON.parse(resultData);
	  
	  				var html = "";
	  				html += "<h1>결과코드 : "+ resultCode +"</h1>";
	  				html += "<h1>결과메세지 : "+ resultMessage +"</h1>";
	  				html += "<h1>결과건수 : "+ resultCount +"</h1>";
	  				html += "<table border=1>"
	  				for(var i = 0; i < dataList.length; i ++) {
	  				  if(i == 0) {
	  					html += "<tr>";
	  					html += "<td align='center' width='100'>A</td>";
	  					html += "<td align='center' width='100'>A</td>";
	  					html += "<td align='center' width='100'>A</td>";
	  					html += "<td align='center' width='100'>A</td>";
	  					html += "<td align='center' width='100'>A</td>";
	  					html += "<td align='center' width='100'>A</td>";
	  					html += "<td align='center' width='100'>A</td>";
	  					html += "<td align='center' width='100'>A</td>";
	  					html += "<td align='center' width='100'>A</td>";
	  					html += "<td align='center' width='100'>A</td>";
	  					html += "<td align='center' width='100'>A</td>";
	  					html += "</tr>";
	  				  }
	  					html += "<tr>";
	  					html += "<td>" + dataList[i].lClassName + "</td>";
	  					html += "<td>" + dataList[i].mClassName + "</td>";
	  					html += "<td>" + dataList[i].lClassCode + "</td>";
	  					html += "<td>" + dataList[i].mClassCode + "</td>";
	  					html += "<td>" + dataList[i].itemCode + "</td>";
	  					html += "<td>" + dataList[i].barcode + "</td>";
	  					html += "<td>" + dataList[i].itemName + "</td>";
	  					html += "<td>" + dataList[i].itemSize + "</td>";
	  					html += "<td>" + dataList[i].uomCode + "</td>";
	  					html += "<td>" + dataList[i].poUom + "</td>";
	  					html += "<td>" + dataList[i].mStkPrice + "</td>";
	  					html += "</tr>";
	  				}
	  				html += "</table>";
	  				$("#result").append(html);
				}
				else {
	  				var ehtml = "";
	  				ehtml += "<h1>결과코드 : "+ resultCode +"</h1>";
	  				ehtml += "<h1>결과메세지 : "+ resultMessage +"</h1>";
	  				$("#result").append(ehtml);
				}
		    }
		    , error : function(request) {
		    	alert("API 요청 오류");
		    }
		});
	});

	$("#btn12").bind("click", function() {
		$("#result").empty();
        var sdata = "";
        sdata += "{                                           ";
        sdata += "    'txHeader': {                           ";
        sdata += "        'txDiv': 'SelectDepositInfo',       ";
        sdata += "        'txId': 'IF_TRANSACTION_SERVICE',   ";
        sdata += "        'encoding': 'utf-8',                ";
        sdata += "        'encYn': 'false'                    ";
        sdata += "    },                                      ";
        sdata += "    'txData': {                             ";
        sdata += "        'data':                             ";
        sdata += "          {                                 ";
        sdata += "            'mainUpjangCd': '194326',       ";
        sdata += "            'upjangCd': '195950',           ";
        sdata += "            'startDt': '20220101',          ";
        sdata += "            'endDt': '20220930'             ";
        sdata += "          }                                 ";
        sdata += "    },                                      ";
        sdata += "    'txResult': {                           ";
        sdata += "        'resultDateTime': '',               ";
        sdata += "        'resultCode': '',                   ";
        sdata += "        'resultMessage': ''                 ";
        sdata += "    }                                       ";
        sdata += "}                                           ";
		$.ajax({
			  type : "POST"
			, url : "http://172.16.1.121:8091/mobileApp/jsonCommon.jDo"
			, dataType : "json"
			, contentType : "application/json"
			, data : sdata
			, success : function (data) {
				var txResult = data.txResult;
				var resultCode = txResult.resultCode;
				var resultMessage = txResult.resultMessage;

				if(resultCode == 0) {
	  				var txData = data.txData.data;
	  				var jsonData = JSON.parse(txData);
	  				var resultCount = jsonData.resultCount;
	  				var resultData = jsonData.resultData;
	  				var dataList = JSON.parse(resultData);
	  
	  				var html = "";
	  				html += "<h1>결과코드 : "+ resultCode +"</h1>";
	  				html += "<h1>결과메세지 : "+ resultMessage +"</h1>";
	  				html += "<h1>결과건수 : "+ resultCount +"</h1>";
	  				html += "<table border=1>"
	  				for(var i = 0; i < dataList.length; i ++) {
	  				  if(i == 0) {
	  					html += "<tr>";
	  					html += "<td align='center' width='100'>A</td>";
	  					html += "<td align='center' width='100'>A</td>";
	  					html += "<td align='center' width='100'>A</td>";
	  					html += "<td align='center' width='100'>A</td>";
	  					html += "<td align='center' width='100'>A</td>";
	  					html += "<td align='center' width='100'>A</td>";
	  					html += "</tr>";
	  				  }
	  					html += "<tr>";
	  					html += "<td>" + dataList[i].upjangCd + "</td>";
	  					html += "<td>" + dataList[i].upjangNm + "</td>";
	  					html += "<td>" + dataList[i].vacctNo + "</td>";
	  					html += "<td>" + dataList[i].addtime + "</td>";
	  					html += "<td>" + dataList[i].occurAmt + "</td>";
	  					html += "<td>" + dataList[i].remark + "</td>";
	  					html += "</tr>";
	  				}
	  				html += "</table>";
	  				$("#result").append(html);
				}
				else {
	  				var ehtml = "";
	  				ehtml += "<h1>결과코드 : "+ resultCode +"</h1>";
	  				ehtml += "<h1>결과메세지 : "+ resultMessage +"</h1>";
	  				$("#result").append(ehtml);
				}
		    }
		    , error : function(request) {
		    	alert("API 요청 오류");
		    }
		});
	});

	$("#btn13").bind("click", function() {
		$("#result").empty();
        var sdata = "";
        sdata += "{                                             ";
        sdata += "    'txHeader': {                             ";
        sdata += "        'txDiv': 'SelectCreditInfo',          ";
        sdata += "        'txId': 'IF_TRANSACTION_SERVICE',     ";
        sdata += "        'encoding': 'utf-8',                  ";
        sdata += "        'encYn': 'false'                      ";
        sdata += "    },                                        ";
        sdata += "    'txData': {                               ";
        sdata += "        'data':                               ";
        sdata += "          {                                   ";
        sdata += "            'mainUpjangCd': '194326',         ";
        sdata += "            'upjangCd': '195950',             ";
        sdata += "            'schDt': '20220630'               ";
        sdata += "          }                                   ";
        sdata += "    },                                        ";
        sdata += "    'txResult': {                             ";
        sdata += "        'resultDateTime': '',                 ";
        sdata += "        'resultCode': '',                     ";
        sdata += "        'resultMessage': ''                   ";
        sdata += "    }                                         ";
        sdata += "}                                             ";
		$.ajax({
			  type : "POST"
			, url : "http://172.16.1.121:8091/mobileApp/jsonCommon.jDo"
			, dataType : "json"
			, contentType : "application/json"
			, data : sdata
			, success : function (data) {
				var txResult = data.txResult;
				var resultCode = txResult.resultCode;
				var resultMessage = txResult.resultMessage;

				if(resultCode == 0) {
	  				var txData = data.txData.data;
	  				var jsonData = JSON.parse(txData);
	  				var resultCount = jsonData.resultCount;
	  				var resultData = jsonData.resultData;
	  				var dataList = JSON.parse(resultData);
	  
	  				var html = "";
	  				html += "<h1>결과코드 : "+ resultCode +"</h1>";
	  				html += "<h1>결과메세지 : "+ resultMessage +"</h1>";
	  				html += "<h1>결과건수 : "+ resultCount +"</h1>";
	  				html += "<table border=1>"
	  				for(var i = 0; i < dataList.length; i ++) {
	  				  if(i == 0) {
	  					html += "<tr>";
	  					html += "<td align='center' width='100'>A</td>";
	  					html += "<td align='center' width='100'>A</td>";
	  					html += "<td align='center' width='100'>A</td>";
	  					html += "<td align='center' width='100'>A</td>";
	  					html += "<td align='center' width='100'>A</td>";
	  					html += "<td align='center' width='100'>A</td>";
	  					html += "</tr>";
	  				  }
	  					html += "<tr>";
	  					html += "<td>" + dataList[i].date1 + "</td>";
	  					html += "<td>" + dataList[i].gichoAmtBefore + "</td>";
	  					html += "<td>" + dataList[i].machuAmtBefore + "</td>";
	  					html += "<td>" + dataList[i].rcpAmtBefore + "</td>";
	  					html += "<td>" + dataList[i].gimalAmtBefore + "</td>";
	  					html += "<td>" + dataList[i].gichoAmt01 + "</td>";
	  					html += "</tr>";
	  				}
	  				html += "</table>";
	  				$("#result").append(html);
				}
				else {
	  				var ehtml = "";
	  				ehtml += "<h1>결과코드 : "+ resultCode +"</h1>";
	  				ehtml += "<h1>결과메세지 : "+ resultMessage +"</h1>";
	  				$("#result").append(ehtml);
				}
		    }
		    , error : function(request) {
		    	alert("API 요청 오류");
		    }
		});
	});

	$("#btn14").bind("click", function() {
		$("#result").empty();
        var sdata = "";
        sdata += "{                                             ";
        sdata += "    'txHeader': {                             ";
        sdata += "        'txDiv': 'SelectTransactionInfo',     ";
        sdata += "        'txId': 'IF_TRANSACTION_SERVICE',     ";
        sdata += "        'encoding': 'utf-8',                  ";
        sdata += "        'encYn': 'false'                      ";
        sdata += "    },                                        ";
        sdata += "    'txData': {                               ";
        sdata += "        'data': {                             ";
        sdata += "            'upjangCd': '503923',             ";
        sdata += "            'subinvCd':'S122006931',          ";
        sdata += "            'startDt':'20220801',             ";
        sdata += "            'endDt':'20220830',               ";
        sdata += "            'itemName':'양파'                 ";
        sdata += "                                              ";
        sdata += "        }                                     ";
        sdata += "    },                                        ";
        sdata += "    'txResult': {                             ";
        sdata += "        'resultDateTime': '',                 ";
        sdata += "        'resultCode': '',                     ";
        sdata += "        'resultMessage': ''                   ";
        sdata += "    }                                         ";
        sdata += "}                                             ";
		$.ajax({
			  type : "POST"
			, url : "http://172.16.1.121:8091/mobileApp/jsonCommon.jDo"
			, dataType : "json"
			, contentType : "application/json"
			, data : sdata
			, success : function (data) {
				var txResult = data.txResult;
				var resultCode = txResult.resultCode;
				var resultMessage = txResult.resultMessage;

				if(resultCode == 0) {
	  				var txData = data.txData.data;
	  				var jsonData = JSON.parse(txData);
	  				var resultCount = jsonData.resultCount;
	  				var resultData = jsonData.resultData;
	  				var dataList = JSON.parse(resultData);
	  
	  				var html = "";
	  				html += "<h1>결과코드 : "+ resultCode +"</h1>";
	  				html += "<h1>결과메세지 : "+ resultMessage +"</h1>";
	  				html += "<h1>결과건수 : "+ resultCount +"</h1>";
	  				html += "<table border=1>"
	  				for(var i = 0; i < dataList.length; i ++) {
	  				  if(i == 0) {
	  					html += "<tr>";
	  					html += "<td align='center' width='100'>A</td>";
	  					html += "<td align='center' width='100'>A</td>";
	  					html += "</tr>";
	  				  }
	  					html += "<tr>";
	  					html += "<td>" + dataList[i].transDate2 + "</td>";
	  					html += "<td>" + dataList[i].transSum + "</td>";
	  					html += "</tr>";
	  				}
	  				html += "</table>";
	  				$("#result").append(html);
				}
				else {
	  				var ehtml = "";
	  				ehtml += "<h1>결과코드 : "+ resultCode +"</h1>";
	  				ehtml += "<h1>결과메세지 : "+ resultMessage +"</h1>";
	  				$("#result").append(ehtml);
				}
		    }
		    , error : function(request) {
		    	alert("API 요청 오류");
		    }
		});
	});

});
</script>
</head>
<body>
<form>
<input type="button" id="btn1" name="btn1" value="구매소모품상품검색" /><p>
<input type="button" id="btn2" name="btn2" value="발주가능금액조회" /><p>
<input type="button" id="btn3" name="btn3" value="업장정보조회" /><p>
<input type="button" id="btn4" name="btn4" value="업장추가정보조회" /><p>
<input type="button" id="btn5" name="btn5" value="물류센터재고조회" /><p>
<input type="button" id="btn6" name="btn6" value="지난발주상품조회" /><p>
<input type="button" id="btn7" name="btn7" value="발주내역조회" /><p>
<input type="button" id="btn8" name="btn8" value="발주이력조회" /><p>
<input type="button" id="btn9" name="btn9" value="배송이력조회" /><p>
<input type="button" id="btn10" name="btn10" value="소모품발주내역조회" /><p>
<input type="button" id="btn11" name="btn11" value="사업장관리자재조회" /><p>
<input type="button" id="btn12" name="btn12" value="입금정보조회" /><p>
<input type="button" id="btn13" name="btn13" value="월별매출채권정보조회" /><p>
<input type="button" id="btn14" name="btn14" value="입고현황조회" /><p>
<div id="result"></div>
</form>
</body>
</html>