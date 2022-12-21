<%
//*-----------------------------------------------------------------------------
//■ 시스템명     : 마감관리/세금계산서등록및출력
//■ 프로그램ID   : FMW00610E_T002.jsp
//■ 프로그램명   : 세금계산서등록및출력(삭제시업데이트)
//■ 작성일자     : 2011.01.20
//■ 작성자       : 맹수영
//■ 이력관리     :  
//-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%

	try	{
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		 
		// log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));

		//오토커밋 강제 false
		conn.setAutoCommit(false);		
		
		//입력 데이타
		DataSet ds_list     	= in_dl.get("ds_list");

		String g_EmpNo       =  nullToBlank(in_vl.getString("g_EmpNo"));
		
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		 
		//rs.close();
		//pstmt.close();		
		
		//기존자료 삭제
		//sbSql.delete(0, sbSql.length());
			
 
        sbSql.append("UPDATE FMW_SALE_BILL   \n");
        sbSql.append("SET USE_YN = 'N'             \n");
		sbSql.append("   , UUSER = '" + g_EmpNo + "' \n");
		sbSql.append("   , UDATE = SYSDATE \n");
        sbSql.append("WHERE BILL_ID = '" + nullToBlank(ds_list.getString(0, "BILL_ID")) + "'             \n");
		out_vl.add("fa_Sql", sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());
		pstmt.executeQuery();

		pstmt.close();	
		
		conn.commit();
		this.setResultMessage(0, "OK", out_vl);
		
	}		
	catch(Exception ex)
	{
		conn.rollback();
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
