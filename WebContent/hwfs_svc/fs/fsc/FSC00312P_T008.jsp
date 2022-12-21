
<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	Statement stmt = null;
	try {
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		//jsp log ���� ���� 
		logger.startIndividualLog(in_vl.getString("titLogId"));
		
		//����Ŀ�� ���� false
		conn.setAutoCommit(false);
		
		//�Է� ����Ÿ               
		DataSet ds_input    = in_dl.get("ds_input");		    // �Է¸����Ͱ�
		DataSet ds_imgeList = in_dl.get("ds_imgeList");
		String g_EmpNo      = in_vl.getString("g_EmpNo");

		String SRLNUM            = "";		
		String VISIBLE_YN  = "";
		
		int RowStatus;
		StringBuffer sbSql 	= new StringBuffer();		//sql�� ���ۻ���
		
		int RowCnt = ds_imgeList.getRowCount();
		for ( int i = 0 ; i < RowCnt ; i++ )
		{
			RowStatus = ds_imgeList.getRowType(i);
			if ( RowStatus == DataSet.ROW_TYPE_UPDATED ) {
				SRLNUM            = nullToBlank(ds_imgeList.getString(i, "SRLNUM"));          
				VISIBLE_YN        = ds_imgeList.getString(i, "VISIBLE_YN");
				
				sbSql.delete(0, sbSql.length());
				sbSql.append("UPDATE FSC_CONTRT_CHK_IMGE                            \n");
				sbSql.append("   SET VISIBLE_YN       = '" + VISIBLE_YN        + "' \n");
				sbSql.append("     , UUSER            = '" + g_EmpNo           + "' \n"); 
				sbSql.append("     , UDATE            = SYSDATE                     \n"); 
				sbSql.append(" WHERE SRLNUM = '" + SRLNUM  + "' \n");
				
				stmt = conn.createStatement();
				stmt.execute(sbSql.toString());
				stmt.close();				
			}
		}
		
		conn.commit();
	   	this.setResultMessage(0, "OK", out_vl);
		
	} catch(Exception ex) {
		conn.rollback();
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