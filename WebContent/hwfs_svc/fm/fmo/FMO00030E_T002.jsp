<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/운영관리
■ 프로그램ID   : FMO00030E_T001.jsp
■ 프로그램명   : 가맹점메뉴 매출인원수 저장
■ 작성일자     : 2010.06.14
■ 작성자       : 박은규
■ 이력관리     : 2010.06.14
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
	
		//입력 데이타
		DataSet ds_Cond     = in_dl.get("ds_Cond");
		DataSet ds_List     = in_dl.get("ds_List");
		//입력 파라메터
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));

		//FileLog.println("d:\\aaa.txt", ds_List);
		
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		//입력,수정
		for ( int i = 0 ; i < ds_List.getRowCount() ; i++ )
		{
			sbSql.delete(0, sbSql.length());

			if (nullToBlank(ds_List.getString(i, "EXI_YN")).equals("N"))
			{
				sbSql.append("INSERT INTO FMO_MENU_SALE \n");
				sbSql.append("    ( UPJANG \n");
				sbSql.append("    , SALE_YM \n");
				sbSql.append("    , MENU_ID \n");
				sbSql.append("    , SALE_QTY \n");
				sbSql.append("    , CUSER \n");
				sbSql.append("    , CDATE \n");
				sbSql.append("    , UUSER \n");
				sbSql.append("    , UDATE ) \n");
				sbSql.append("SELECT '" + nullToBlank(ds_List.getString(i, "UPJANG")) + "' AS UPJANG \n");
				sbSql.append("     , '" + nullToBlank(ds_List.getString(i, "SALE_YM")) + "' AS SALE_YM \n");
				sbSql.append("     , " + nullToBlank(ds_List.getString(i, "MENU_ID")) + " AS MENU_ID \n");
				sbSql.append("     , " + nullToBlank(ds_List.getString(i, "SALE_QTY")) + " AS SALE_QTY \n");
				sbSql.append("     , '" + g_EmpNo + "' AS CUSER \n");
				sbSql.append("     , SYSDATE AS CDATE \n");
				sbSql.append("     , '" + g_EmpNo + "' AS UUSER \n");
				sbSql.append("     , SYSDATE AS UDATE \n");
				sbSql.append("  FROM DUAL \n");
			}
			else
			{
				sbSql.append("UPDATE FMO_MENU_SALE \n");
				sbSql.append("   SET SALE_QTY = " + nullToBlank(ds_List.getString(i, "SALE_QTY")) + " \n");
				sbSql.append("     , UUSER = '" + g_EmpNo + "' \n");
				sbSql.append("     , UDATE = SYSDATE \n");
				sbSql.append(" WHERE UPJANG = " + nullToBlank(ds_List.getString(i, "UPJANG")) + " \n");
				sbSql.append("   AND SALE_YM = '" + nullToBlank(ds_List.getString(i, "SALE_YM")) + "' \n");
				sbSql.append("   AND MENU_ID = " + nullToBlank(ds_List.getString(i, "MENU_ID")) + " \n");
			}
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