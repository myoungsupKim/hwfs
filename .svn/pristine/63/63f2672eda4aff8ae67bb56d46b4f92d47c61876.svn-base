<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 통합영업
■ 프로그램ID   : FMS00700E_S001.jsp
■ 프로그램명   : 식재 공휴일 제어 조회
■ 작성일자     : 2016-01-19
■ 작성자       : 강대성
■ 이력관리     : 2016-01-19
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	try	{
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));	
		
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
	
		//입력 데이타
		DataSet ds_input     = in_dl.get("ds_input");
		//입력 파라메터
		//String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		//FileLog.println("d:\\aaa.txt", ds_cond);

		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();	
		
		// 사업계획 완전 초기화
        sbSql.append("DELETE SCC_COMMON_CODE    	     \n");
        sbSql.append(" WHERE GROUP_CODE = 'HOLIDAY_TIME' \n");
        sbSql.append("   AND CODE       = "+ds_input.getString(0, "HOLIDAY_DATE")+" \n");
        sbSql.append("   AND USE_YN     = 'Y'  	         \n");
        
        pstmt = conn.prepareStatement(sbSql.toString());
        pstmt.executeUpdate();
        pstmt.close();
	
        /**종료**/
        conn.commit();
        this.setResultMessage(0, "OK", out_vl);

	}
	catch(Exception ex)
	{
		//ex.printStackTrace();
		//jsp 로그남기기
		logger.debug(ex.getMessage(), ex);		
		this.setResultMessage(-1, ex.toString(),out_vl);
	}
	finally
	{
		if(rs != null) {
			try {
				rs.close();
			}catch(Exception e) {}
		}
		if(pstmt != null) {
			try {
				pstmt.close();
			}catch(Exception e) {}
		}
		if(conn != null) {
			try {
				conn.close();
			}catch(Exception e) {}
		}
		//jsp log 서비스 닫기 
		try {
			logger.endIndividualLog();
		} catch( Exception logE) {
			logE.printStackTrace();
		}		
	}

	proc_output(response,out,out_vl,out_dl);

%>
