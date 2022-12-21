<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/매출통계
■ 프로그램ID   : MAO00010E_T002.jsp
■ 프로그램명   : 영업일 등록관리(저장)
■ 작성일자     : 2012-03-09
■ 작성자       : 박은규
■ 이력관리     : 2012-03-09 박은규 - 최초개발 (CH201203_00081)
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
		
		//오토커밋 강제 false
		conn.setAutoCommit(false);
	
		//입력 데이타
		DataSet ds_Cond   = in_dl.get("ds_Cond");
		DataSet ds_List   = in_dl.get("ds_List");
		//FileLog.println("d:\\aaa.txt", ds_list);
	
		//입력 파라메터
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));

		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		//입력
		for ( int iRow = 0; iRow < ds_List.getRowCount(); iRow++ )
		{
			sbSql.delete(0, sbSql.length());
			sbSql.append("MERGE INTO FMB_BIZDAY A \n");
			sbSql.append("USING (SELECT '" + nullToBlank(ds_List.getString(iRow, "YYYYMM")) + "' AS YYYYMM \n");
			sbSql.append("            , '" + nullToBlank(ds_List.getString(iRow, "TEAM_CODE")) + "' AS TEAM_CODE \n");
			sbSql.append("            , '" + nullToBlank(ds_List.getString(iRow, "DD_DAYS")) + "' AS DD_DAYS \n");
			sbSql.append("         FROM DUAL) B \n");
			sbSql.append("   ON (A.YYYYMM = B.YYYYMM AND A.TEAM_CODE = B.TEAM_CODE AND A.DD_DAYS = B.DD_DAYS)\n");
			sbSql.append(" WHEN MATCHED THEN \n");
			sbSql.append("      UPDATE \n");
			sbSql.append("         SET A.BIZDAYS = '" + nullToBlank(ds_List.getString(iRow, "BIZDAYS")) + "' \n");
			sbSql.append("           , A.CONTENTS = '" + nullToBlank(ds_List.getString(iRow, "CONTENTS")) + "' \n");
			sbSql.append("           , A.UDATE = SYSDATE \n");
			sbSql.append("           , A.UUSER = '" + g_EmpNo + "' \n");
			sbSql.append(" WHEN NOT MATCHED THEN \n");
			sbSql.append("      INSERT ( A.YYYYMM \n");
			sbSql.append("             , A.TEAM_CODE \n");
			sbSql.append("             , A.DD_DAYS \n");
			sbSql.append("             , A.BIZDAYS \n");
			sbSql.append("             , A.CONTENTS \n");
			sbSql.append("             , A.CDATE \n");
			sbSql.append("             , A.CUSER \n");
			sbSql.append("             , A.UDATE \n");
			sbSql.append("             , A.UUSER ) \n");
			sbSql.append("      VALUES ( B.YYYYMM \n");
			sbSql.append("             , B.TEAM_CODE \n");
			sbSql.append("             , '" + nullToBlank(ds_List.getString(iRow, "DD_DAYS")) + "' \n");
			sbSql.append("             , '" + nullToBlank(ds_List.getString(iRow, "BIZDAYS")) + "' \n");
			sbSql.append("             , '" + nullToBlank(ds_List.getString(iRow, "CONTENTS")) + "' \n");
			sbSql.append("             , SYSDATE \n");
			sbSql.append("             , '" + g_EmpNo + "' \n");
			sbSql.append("             , SYSDATE \n");
			sbSql.append("             , '" + g_EmpNo + "' \n");
			sbSql.append("             ) \n");
	
			out_vl.add("fa_Sql", sbSql.toString());
			//System.out.println(sbSql.toString());
			pstmt = conn.prepareStatement(sbSql.toString());
			pstmt.executeUpdate();
			pstmt.close();
		}

		/**종료**/
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