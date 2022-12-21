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
        sbSql.append("INSERT INTO SCC_COMMON_CODE (  														\n");
        sbSql.append("       GROUP_CODE, 			\n");
        sbSql.append("       CODE, 		            \n");
        sbSql.append("       CODE_NAME,             \n");
        sbSql.append("       CONTENTS, 		        \n");
        sbSql.append("       SYSTEM_YN, 		    \n");
        sbSql.append("       SET1, 		            \n");
        sbSql.append("       USE_YN, 		        \n");
        sbSql.append("       CUSER, 		        \n");
        sbSql.append("       CDATE, 		        \n");
        sbSql.append("       UUSER, 		        \n");
        sbSql.append("       UDATE 		            \n");
        sbSql.append(" ) VALUES ( 		            \n");
        sbSql.append("       'HOLIDAY_TIME',        \n");
        sbSql.append("       "+ds_input.getString(0, "HOLIDAY_DATE")+", 		        \n");
        sbSql.append("       '������', 		        \n");
        sbSql.append("       '������', 		        \n");
        sbSql.append("       'Y', 		        \n");        
        sbSql.append("       "+ds_input.getString(0, "HOLIDAY_DATE_AFT")+", 		        \n");        
        sbSql.append("       'Y', 		        \n");        
        sbSql.append("       '" + g_EmpNo + "', \n");        
        sbSql.append("       SYSDATE,           \n");        
        sbSql.append("       '" + g_EmpNo + "', \n");        
        sbSql.append("       SYSDATE)		    \n");        
        
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
