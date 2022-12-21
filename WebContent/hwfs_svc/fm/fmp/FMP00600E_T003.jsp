<%
//-----------------------------------------------------------------------------
//�� �ý��۸�     : �ܰ�����/���޾�ü ����/ ���޾�ü ���ֳ��� ����(����)
//�� ���α׷�ID   : FMP00600E_T003.jsp
//�� ���α׷���   : ���޾�ü ���ֳ��� ����
//�� �ۼ�����     : 2010.06.02
//�� �ۼ���       : ������
//�� �̷°���     : 2010.06.02
//-----------------------------------------------------------------------------*/
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
		//DataSet ds_cond     = in_dl.get("ds_cond");
		//�Է� �Ķ����
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		String sPrID        = nullToBlank(in_vl.getString("sPrID"));

		//FileLog.println("d:\\aaa.txt", ds_cond);

		//out ����Ÿ
		//DataSet ds_list;
		//sql�� ���ۻ���
		StringBuffer sbSql = new StringBuffer();
		//

		//����(��������)
//		sbSql.append( "DELETE FROM FMP_OTCUST_PR A \n");
//		sbSql.append( " WHERE A.PR_ID = " + sPrID + " \n");
		//����(���λ��¸� ��ҷ�...)
		sbSql.append( "UPDATE FMP_OTCUST_PR A \n");
		sbSql.append( "   SET PO_QTY = 0 \n");
		sbSql.append( "     , LINE_STATUS = '003' \n");
		sbSql.append( " WHERE A.PR_ID = " + sPrID + " \n");
		
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
