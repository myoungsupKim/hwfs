<%
/*-----------------------------------------------------------------------------
�� �ý��۸�     : ���翵��/����
�� ���α׷�ID   : FMZ_CREDIT_INFO_T002.jsp
�� ���α׷���   : ������� �Ա�Ȯ�� ó��
�� �ۼ�����     : 2008.01.30
�� �ۼ���       : ������
�� �̷°���     : 2008.01.30
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	CallableStatement cstmt = null;
	try	{
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
	
		//jsp log ���� ���� 
		logger.startIndividualLog(in_vl.getString("titLogId"));		

		//HLDC���� ����
		conn = getIRISConn();
		//����Ŀ�� ���� false
		conn.setAutoCommit(false);

		//�Է� ����Ÿ
		DataSet ds_Cond     = in_dl.get("ds_Cond");
		//�Է� �Ķ����
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		//FileLog.println("d:\\aaa.txt", ds_Cond);

		//sql�� ���ۻ���
		StringBuffer sbSql = new StringBuffer();
		String strOutMsg1 = "";
		String strOutMsg2 = ""; 

		//����
		cstmt = conn.prepareCall( "{call TR_VIR_ACCOUNT_LIST_PRO(?, ?, ?, ?)}" );		
		
		cstmt.setString(1, ds_Cond.getString(0,"RCP_DATEF"));
		cstmt.setString(2, ds_Cond.getString(0,"RCP_DATET"));
		cstmt.registerOutParameter(3, Types.VARCHAR);
		cstmt.registerOutParameter(4, Types.VARCHAR);
		cstmt.execute();
		System.out.println(cstmt.getString(4));
		
		if(cstmt.getString(4).equals("N"))	
		{
			conn.rollback();
			this.setResultMessage(-1, cstmt.getString(3), out_vl);
			//throw new Exception();
			proc_output(response,out,out_vl,out_dl);
			return;			
		}
		cstmt.close();

/*
		sbSql.delete(0, sbSql.length());
		sbSql.append("BEGIN \n");
		//sbSql.append("  TR_VIR_ACCOUNT_LIST_PRO('" + ds_Cond.getString(0,"RCP_DATEF") + "', '" + ds_Cond.getString(0,"RCP_DATET") + "', '" + strOutMsg1 + "', '" + strOutMsg2 + "'); \n");
		sbSql.append("  TR_VIR_ACCOUNT_LIST_PRO('" + ds_Cond.getString(0,"RCP_DATEF") + "', '" + ds_Cond.getString(0,"RCP_DATET") + "'); \n");
		sbSql.append("END; ");
		pstmt = conn.prepareStatement(sbSql.toString());		
		pstmt.executeQuery(); 
		//pstmt.executeUpdate();
		pstmt.close();
*/

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
		if(cstmt != null) {
			try {
				cstmt.close();
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