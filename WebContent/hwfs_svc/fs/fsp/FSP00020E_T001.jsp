<%
/*-----------------------------------------------------------------------------
�� �ý��۸�     : ���Ű���/�������
�� ���α׷�ID   : FSP00020E_T001.jsp
�� ���α׷���   : ����Ư��(BO) ����
�� �ۼ�����     : 2009.07.30
�� �ۼ���       : ������
�� �̷°���     : 2009.07.30 ������ CSR#(29455) ��û��:������(���Ź�����)
               ���� �ۼ�
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
	
		//����Ŀ�� ���� false
		conn.setAutoCommit(false);		

		//�Է� ����Ÿ
		//DataSet ds_List     = in_dl.get("ds_List");
		//�Է� �Ķ����
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		String CENTER_CODE  = nullToBlank(in_vl.getString("CENTER_CODE"));
		String CUSTCD       = nullToBlank(in_vl.getString("CUSTCD"));
		String ITEM_CODE    = nullToBlank(in_vl.getString("ITEM_CODE"));
		String APPLY_DATE   = nullToBlank(in_vl.getString("APPLY_DATE"));

		//sql�� ���ۻ���
		StringBuffer sbSql = new StringBuffer();

		//�����۾�
		sbSql.delete(0, sbSql.length());
		sbSql.append("DELETE  FROM FSI_ITEM_FEATURE A \n");
		sbSql.append(" WHERE A.CENTER_CODE = " + CENTER_CODE + " \n");
		sbSql.append("   AND A.CUSTCD = " + CUSTCD + " \n");
		sbSql.append("   AND A.ITEM_CODE = '" + ITEM_CODE + "' \n");
		sbSql.append("   AND A.APPLY_DATE = '" + APPLY_DATE + "' \n");
		sbSql.append("   AND A.WORK_TYPE <> 'M' \n");
out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());
		pstmt.executeUpdate();
		pstmt.close();

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