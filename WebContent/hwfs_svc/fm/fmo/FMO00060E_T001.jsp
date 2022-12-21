<%
/*-----------------------------------------------------------------------------
�� �ý��۸�     : ���翵��/�޽Ŀ����
�� ���α׷�ID   : FMO00060E_T001.jsp
�� ���α׷���   : ������/�ڰ��� ��ϰ���(��ȸ)
�� �ۼ�����     : 2008-02-25
�� �ۼ���       : ������
�� �̷°���     : 2008-02-25
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
		//DataSet ds_cond     = in_dl.get("ds_Cond");
		//�Է� �Ķ����
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		String sUpjang      = nullToBlank(in_vl.getString("sUpjang"));
		//FileLog.println("d:\\aaa.txt", ds_cond);


		//out ����Ÿ
		DataSet ds_list;
		//sql�� ���ۻ���
		StringBuffer sbSql = new StringBuffer();

		//������ȸ
		sbSql.append("SELECT A.MGMT_ID, A.UPJANG, B.UPJANGNM_DISP \n");
		sbSql.append("     , A.LICENCER \n");
		sbSql.append("     , A.DUTY \n");
		sbSql.append("     , A.LICEN_NAME \n");
		sbSql.append("     , A.LICEN_NUM, A.LICEN_DATE, A.EXPIRE_DATE \n");
		sbSql.append("     , DECODE(A.EXPIRE_DATE,NULL,NULL,SCC_CEIL((TO_DATE(A.EXPIRE_DATE,'YYYYMMDD') - SYSDATE))) AS D_DAYS \n");
		sbSql.append("     , A.CONTENTS \n");
		sbSql.append("  FROM FMO_LICEN_MGMT A, FMS_UPJANG B \n");
		sbSql.append(" WHERE A.UPJANG = B.UPJANG \n");
		sbSql.append("   AND A.UPJANG = " + sUpjang + " \n");

out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery();
		
		ds_list = this.makeDataSet(rs, "ds_List");
		//FileLog.println("d:\\aaa.txt", ds_list);
		rs.close();
		pstmt.close();		

		/**����**/
		out_dl.add(ds_list);
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
