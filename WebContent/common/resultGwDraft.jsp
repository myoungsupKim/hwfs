<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
  /**
   * 그룹웨어 상신 Instance ID 전달을 위한 Dummy JSP : (빈 페이지이며 XPLATFORM으로 결과를 반환)
   * @ClassName resultGwDraft.jsp
   * @Description resultGwDraft JSP
   * @Modification-Information
   *    수정일       수정자              수정내용
   *  ----------   ----------   -------------------------------
   *  2015.06.10.   kksoo        최초 생성
   *  
   * @author FC종합전산구축 : AA kksoo
   * @since 2015.03. 23.
   * @version 1.0
   * @see
   * 
   *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
   */
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>그룹웨어 상신 Instance ID 전달</title>
<script>
function open() {
	//XPLATFORM으로 결과를 반환한다.
	var param = "<%=request.getParameter("result_instanceId")%>";
	document.title = "hwfs_instanceId=" + param; 
}
</script>
<body onload="open()">
	<div id="divProcessing" style="visibility:show;" align="center">
		<div>
			<div>
				<h4>처리 중 입니다. 잠시만 기다려 주십시오.</h4>
			</div>
		</div>
	  
		<div>
			<img src="/images/cmn/processing.gif" />
		</div>
	</div> 
</body>
</html>