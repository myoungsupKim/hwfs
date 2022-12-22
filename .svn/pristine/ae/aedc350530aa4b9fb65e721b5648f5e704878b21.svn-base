<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>한화호텔앤드리조트 FC</title>
    <!-- 
    <link type="text/css" rel="stylesheet" href="https://www.hwrc.co.kr/hwrc/common/css/base.css">
    <link type="text/css" rel="stylesheet" href="https://www.hwrc.co.kr/hwrc/common/css/contents.css">
  	 -->
  	<script src="/js/barcode/JsBarcode.all.min.js"></script>
  	<!-- https://github.com/lindell/JsBarcode/wiki/Options -->
  	<style type="text/css"> 
  		html, body { width:100%;  } 
  		.w-div {width:96%; text-align: center; border:0px #f99 solid} 
  	</style>
  </head>
  <body>
  	<div class = "w-div">
		<!-- <p class="infoImg2"><img src="https://www.hwrc.co.kr/hwrc/images/business/fc_img09.jpg" width=860 alt="도원 STYLE 사진"></p>  -->
		<img id="barcode"/>
		<script>
			<% String couponStatus = request.getAttribute("attr01").toString(); %>
			var status = '<%=couponStatus%>';
			
			if ( status == "판매") {
				JsBarcode("#barcode"
								, <%=request.getParameter("code")%>
								, { format: "CODE39", width: 3.5, height: 300 }
								);
			} else {
				alert("invalid");
			}
		
		</script>
	</div>
	<div class = "w-div">
	<p><img src='<%=request.getAttribute("etc02").toString()%>' width=860></p>
	</div>			
  </body>
</html>