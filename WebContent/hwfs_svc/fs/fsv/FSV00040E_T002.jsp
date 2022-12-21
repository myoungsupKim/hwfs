<%
/*-----------------------------------------------------------------------------
�� �ý��۸�     : ���ּ�/�����������ȸ
�� ���α׷�ID   : FSV00040E_T002.jsp
�� ���α׷���   : ��������� ����
�� �ۼ�����     : 2011.04.25
�� �ۼ���       : ������
�� �̷°���     : 2011.04.25
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
    Statement stmt             =  null;
	try	{
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();

		//jsp log ���� ���� 
		logger.startIndividualLog(in_vl.getString("titLogId"));		
	
		//�Է� ����Ÿ
		DataSet ds_List     = in_dl.get("ds_List");
		//�Է� �Ķ����
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		String g_CustCd     = nullToBlank(in_vl.getString("g_CustCd"));
	
		//FileLog.println("d:\\aaa.txt", ds_List);
		if(conn != null && !conn.isClosed()) conn.close();
		conn = getIRISConn();
		stmt =  conn.createStatement();
	
		//��������
		int sRowStatus;
		
		//sql�� ���ۻ���
		StringBuffer sbSql = new StringBuffer();

		//�Է�,����
		for ( int i = 0 ; i < ds_List.getRowCount() ; i++ )
		{
			sRowStatus = ds_List.getRowType(i);
			
			if (sRowStatus == DataSet.ROW_TYPE_NORMAL)
			{
				continue;
			}

			sbSql.delete(0, sbSql.length());
			sbSql.append("UPDATE PO_PO \n");
			sbSql.append("   SET DELI_TIME = SYSDATE \n");
			sbSql.append("     , DELI_COMP = '" + nullToBlank(ds_List.getString(i, "DELI_COMP")) + "' \n");
			sbSql.append("     , INVOICE_NUM = '" + nullToBlank(ds_List.getString(i, "INVOICE_NUM")) + "' \n");
			sbSql.append("     , UPDATE_DATE = SYSDATE \n");
			sbSql.append("     , UPDATE_BY = '" + g_EmpNo + "' \n");
			sbSql.append(" WHERE PO_ID = '" + nullToBlank(ds_List.getString(i, "PO_ID")) + "' \n");

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
	catch(Exception ex) {
	//ex.printStackTrace();
	//jsp �α׳����
	logger.debug(ex.getMessage(), ex);
	this.setResultMessage(-1, ex.toString(),out_vl); 
	} finally {
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
		if(stmt != null) {
			try {
				stmt.close();
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