<%
/*-----------------------------------------------------------------------------
�� �ý��۸�     : ���տ���
�� ���α׷�ID   : FMS00700E_S001.jsp
�� ���α׷���   : ���� ������ ���� ��ȸ
�� �ۼ�����     : 2016-01-19
�� �ۼ���       : ���뼺
�� �̷°���     : 2016-01-19
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
		
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
	
		//�Է� ����Ÿ
		DataSet ds_input     = in_dl.get("ds_input");
		//�Է� �Ķ����
		//String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		//FileLog.println("d:\\aaa.txt", ds_cond);

		//sql�� ���ۻ���
		StringBuffer sbSql = new StringBuffer();	
		
		// �����ȹ ���� �ʱ�ȭ
        sbSql.append("DELETE SCC_COMMON_CODE    	     \n");
        sbSql.append(" WHERE GROUP_CODE = 'HOLIDAY_TIME' \n");
        sbSql.append("   AND CODE       = "+ds_input.getString(0, "HOLIDAY_DATE")+" \n");
        sbSql.append("   AND USE_YN     = 'Y'  	         \n");
        
        pstmt = conn.prepareStatement(sbSql.toString());
        pstmt.executeUpdate();
        pstmt.close();
	
        /**����**/
        conn.commit();
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
