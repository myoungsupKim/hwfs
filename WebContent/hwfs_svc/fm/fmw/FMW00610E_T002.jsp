<%
//*-----------------------------------------------------------------------------
//�� �ý��۸�     : ��������/���ݰ�꼭��Ϲ����
//�� ���α׷�ID   : FMW00610E_T002.jsp
//�� ���α׷���   : ���ݰ�꼭��Ϲ����(�����þ�����Ʈ)
//�� �ۼ�����     : 2011.01.20
//�� �ۼ���       : �ͼ���
//�� �̷°���     :  
//-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%

	try	{
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		 
		// log ���� ���� 
		logger.startIndividualLog(in_vl.getString("titLogId"));

		//����Ŀ�� ���� false
		conn.setAutoCommit(false);		
		
		//�Է� ����Ÿ
		DataSet ds_list     	= in_dl.get("ds_list");

		String g_EmpNo       =  nullToBlank(in_vl.getString("g_EmpNo"));
		
		//sql�� ���ۻ���
		StringBuffer sbSql = new StringBuffer();
		 
		//rs.close();
		//pstmt.close();		
		
		//�����ڷ� ����
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
