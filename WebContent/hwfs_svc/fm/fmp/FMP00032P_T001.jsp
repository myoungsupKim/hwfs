<%
/*-----------------------------------------------------------------------------
�� �ý��۸�     : ���翵��
�� ���α׷�ID   : FMP00032P_T001.jsp
�� ���α׷���   : ������ ��ȸ(�˾���ȸ)
�� �ۼ�����     : 2015-11-22
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
	
		//FileLog.println("d:\\aaa.txt", ds_Cond);

		//out ����Ÿ
		DataSet ds_List;
		//sql�� ���ۻ���
		StringBuffer sbSql = new StringBuffer();
		String sItemName = nullToBlank(ds_Cond.getString(0, "ITEM_NAME"));

		//������ȸ
        sbSql.append("SELECT A.ITEM_CODE,                                    \n");
        sbSql.append("       A.ITEM_NAME,                               \n");
        sbSql.append("       A.ITEM_SIZE, \n");
        sbSql.append("       A.UOM_CODE \n");
        sbSql.append("  FROM HLDC_PO_ITEM_MST A                                \n");
        sbSql.append(" WHERE 1=1                                               \n");
        if(!sItemName.isEmpty())
        {
        	sbSql.append("   AND A.ITEM_NAME LIKE '%"+sItemName+"%'                \n");
        }
        

		out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		//�α׳����
		logger.debug(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_List = this.makeDataSet(rs, "ds_List");
		
		pstmt.close();
		rs.close();

		/**����**/
		out_dl.add(ds_List);
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
