<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Ready</title>
<%@ include file="/apagent/lib/config/config.jsp" %>
<script>
	var dw = new hanwha.approval.DraftWindow();

	function sendDraft() 
	{
		//============== 기본값 셋팅 시작 ================
		var eService = $("#eService").val().trim();
		if(eService == null || eService == "")
		{
			alert('결재서비스명을 입력하시기 바랍니다.');
			$("#eService").focus();
			return;
		}
				
		var eBodyUrl = $("#eBodyUrl").val().trim();
		if(eBodyUrl == null || eBodyUrl == "")
		{
			alert('본문 URL를 입력하시기 바랍니다.');
			$("#eBodyUrl").focus();
			return;
		}
		
		var eTitle		= $("#eTitle").val().trim();
		if(eTitle == null || eTitle == "")
		{
			alert('본문 제목를 입력하시기 바랍니다.');
			$("#eTitle").focus();
			return;
		}
		
		var eOtaId = $("#eOtaId").val().trim();
		if(eOtaId == null || eOtaId == "")
		{
			alert('OTA_ID를 입력하시기 바랍니다.');
			$("#eOtaId").focus();
			return;
		}
		
// 		var eRcv1 = $("#eRcv1").val().trim(); //참조자 사번
// 		var eRcv2 = $("#eRcv2").val().trim(); //수신자 사번
		
		var docPortraitType = $("#docPortraitType option:selected").val();
		if(docPortraitType == null || docPortraitType == "")
		{
			alert('양식구분을 선택하시기 바랍니다.');
			$("#docPortraitType").focus();
			return;
		}
		
		var sapId = getESapId(); //해당 web portal의 고유key
		//============== 기본값 셋팅 끝 ================
		
				
		//============== 실제 상신를 로직 처리 시작 ================
		//객체 초기화
		dw.init();
		//서비스명 
		dw.setService(eService); 	// [카드신청] 법인카드 신청서 양식
		//조회 : view, "" : 상신
		dw.setMode("");
		//결재문서의 SAP_ID (FC 에서 사용하는 id)
		dw.setId(sapId);
		//본문 내용 URL  ==> /apagent/sample/samplebody3.jsp
		dw.setBody(eBodyUrl);
		//문서제목
		dw.setTitle(eTitle + "-" + sapId);
		//가로 양식 - 인쇄시 가로양식으로 인쇄함
		dw.setDocPortraitType(docPortraitType); //horizontal : 가로양식 , vertical : 세로양식
		//otaId셋팅
		dw.setOtaId(eOtaId);
		
// 		//참조자 referer
// 		if(eRcv1 != "")
// 		{
// 			alert('참조자확인 - eRcv1 : ' + eRcv1);
// 			dw.addParam("RCV1", eRcv1);
// 		}
		
// 		//수신자 receiver
// 		if(eRcv2 != "")
// 		{
// 			alert('수신자확인 - eRcv2 : ' + eRcv2);
// 			dw.addParam("RCV2", eRcv2);
// 		}
		//=========================================================================================
			
		// ::::::::::::::::::::::::: 파일업로드 방식-2 - 첨부방식 :::::::::::::::::::::::::
		//파일업로드
// 		dw.addAttachFile("sample01.jpg", "D:\\\\attFilesTest\\\\sample01.jpg");
// 		dw.addAttachFile("sample02.jpg", "D:\\\\attFilesTest\\\\sample02.jpg");
		//----------------------------------------------------------------------------------------
		//dw.addAttachFile("h1_naver2.png", "C:\attFilesTest\h1_naver2.png"); ==> 오류
		//dw.addAttachFile("h1_naver2.png", "C:\\attFilesTest\\h1_naver2.png"); ==> 서버단에서 json 오류발생
		//=========================================================================================
			
		
	
		// 결재 정보 및 이벤트 queue 가 존재하는 DS 정보 입력 (단, value 는 결재 시스템의 DS 명 기준임)
		dw.addParam("connection_pool", "hwrcfc_IFISTEST");
		dw.addParam("company_work_id", "1000"); //외식,자재, 구매 구분
		//dw.addParam("house_code","111");
		//dw.addParam("company_code", "405");
		//dw.addParam("doc_type", "EX");
		//dw.addParam("doc_no", "AR120614000001");
		//dw.addParam("doc_seq", "1");
		//dw.addParam("subject","품의대상_2012061");

		//window open
		dw.open();
		//============== 실제 상신하를 로직 처리 끝 ================
	}
	
	function getESapId()
	{
		var d = new Date();
		var mySapId = "";
		
		mySapId =  d.getFullYear() 
			+ "" + (d.getMonth() + 1)
			+ "" + d.getDate()
			+ "" + d.getHours() 
			+ "" + d.getMinutes()
			+ "" + d.getSeconds();
		
		if(mySapId == "" || mySapId == null)
		{
			alert('SapId를 생성할수가 없습니다.');
			return false;
		}
		
		return mySapId;
	}//function getESapId()
	
</script>
</head>
<body>


<form id="frm" name="frm">
	1. 결재문서 서비스명 : 해당 결재의 서비스명 셋팅(Ex: HSNC_FI_XXXXXX)
	<br/><input type="text" id="eService" name="eService" value="HWRC_FC_SAMPLE01" size="50"/> 
	<br><br>
	2. 본문URL : 해당 본문 설정
	<br/><input type="text" id="eBodyUrl" name="eBodyUrl" value="/apagent/sample/bodyContentSample.jsp" size="50"/>
	<br><br>
	3. 본문제목 :
	<br/><input type="text" name="eTitle" id="eTitle" value="WebPortal-상신" size="50"/>
	<br><br>
	4. 기안자의 OTA_ID : 
	<br/><input type="text" name="eOtaId" id="eOtaId" value="" size="50"/>
	<br><br>
	5. 가로/세로양식 :
	<select id="docPortraitType" name="docPortraitType">
		<option value="">::: 선택하세요 :::</option>
		<option value="horizontal">가로양식</option>
		<option value="vertical" selected>세로양식</option>
	</select>
	<%--
	6. 참조자 사번 : 참조자를 추가할경우 해당 참조자의 사번을 콤마로 구분해서 설정한다.(Ex: 1111111,222222)
	<br/><input type="text" name="eRcv1" id="eRcv1" value="200800035,200300449" size="50"/>
	<br><br>
	7. 수신자 사번 : 수신자를 추가할경우 해당 수신자의 사번을 콤마로 구분해서 설정한다.(Ex: 1111111,222222)
	<br/><input type="text" name="eRcv2" id="eRcv2" value="11092304" size="50"/>
	<br><br>
 	--%>
</form>
<br><br>
<input type="button" value="상신" onclick="sendDraft();" />
</body>
</html>