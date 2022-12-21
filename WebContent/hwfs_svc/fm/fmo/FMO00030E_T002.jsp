<%
/*-----------------------------------------------------------------------------
�� �ý��۸�     : ���翵��/�����
�� ���α׷�ID   : FMO00030E_T001.jsp
�� ���α׷���   : �������޴� �����ο��� ����
�� �ۼ�����     : 2010.06.14
�� �ۼ���       : ������
�� �̷°���     : 2010.06.14
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	try	{
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();

		//jsp log ���� ���� 
		logger.startIndividualLog(in_vl.getString("titLogId"));		
	
		//�Է� ����Ÿ
		DataSet ds_Cond     = in_dl.get("ds_Cond");
		DataSet ds_List     = in_dl.get("ds_List");
		//�Է� �Ķ����
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));

		//FileLog.println("d:\\aaa.txt", ds_List);
		
		//sql�� ���ۻ���
		StringBuffer sbSql = new StringBuffer();

		//�Է�,����
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

		/**����**/
		conn.commit();
		this.setResultMessage(0, "OK", out_vl);

	}
	catch(Exception ex)
	{
		conn.rollback();
		//ex.printStackTrace();
		//jsp �α׳����
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
		//jsp log ���� �ݱ� 
		try {
			logger.endIndividualLog();
		} catch( Exception logE) {
			logE.printStackTrace();
		}		
	}

	proc_output(response,out,out_vl,out_dl);

%>