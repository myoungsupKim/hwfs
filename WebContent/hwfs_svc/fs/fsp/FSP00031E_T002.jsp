<%
/*-----------------------------------------------------------------------------
�� �ý��۸�     : ���翵��
�� ���α׷�ID   : FSP00031E_T002.jsp
�� ���α׷���   : ������ �԰��� ���ܾ������ üũ����(��ȸ)
�� �ۼ�����     : 2015-11-27
�� �ۼ���       : �ڿ��
�� �̷°���     : �űԻ���
-----------------------------------------------------------------------------*/
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

		//�Է� ����Ÿ
		DataSet ds_Cond     = in_dl.get("ds_Cond");
		//�Է� �Ķ����
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		String g_NeedDate   = nullToBlank(in_vl.getString("g_NeedDate"));
	
		//FileLog.println("d:\\aaa.txt", ds_Cond);

		//out ����Ÿ
		DataSet ds_List;
		//sql�� ���ۻ���
		StringBuffer sbSql = new StringBuffer();
		/*
		String sMuCode = nullToBlank(ds_Cond.getString(0, "MU"));
		String sTmCode = nullToBlank(ds_Cond.getString(0, "TM"));
		String sDate   = nullToBlank(ds_Cond.getString(0, "DT"));
		*/

		//������ȸ
        sbSql.append("SELECT COUNT(1) AS TOT_CNT     \n");
        sbSql.append("  FROM FSP_HOLIDAY_UPJANG      \n");
        sbSql.append(" WHERE NEED_DATE = '"+g_NeedDate+"'  \n");
		//�α׳����
		logger.debug(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_List = this.makeDataSet(rs, "ds_List");
		
		pstmt.close();
		rs.close();
		
		//out ����Ÿ
		DataSet ds_List1;
		//sql�� ���ۻ���
		StringBuffer sbSql1 = new StringBuffer();
        sbSql1.append("SELECT COUNT(1) AS CNT         \n");
        sbSql1.append("  FROM FSP_HOLIDAY_UPJANG      \n");
        sbSql1.append(" WHERE NEED_DATE = '"+g_NeedDate+"'  \n");
        sbSql1.append("   AND UPJANG = '"+g_Upjang+"'         \n");

        //������ȸ

		//�α׳����
		logger.debug(sbSql1.toString());
		pstmt = conn.prepareStatement(sbSql1.toString());		
		rs = pstmt.executeQuery(); 
		ds_List1 = this.makeDataSet(rs, "ds_List1");
				
		pstmt.close();
		rs.close();

		/**����**/
		out_dl.add(ds_List);
		out_dl.add(ds_List1);
		this.setResultMessage(0, "OK", out_vl);

	}
	catch(Exception ex)
	{
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
