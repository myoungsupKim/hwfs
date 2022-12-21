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
		
		//����Ÿ               
		String g_EmpNo    = in_vl.getString("g_EmpNo");
		String SRLNUM     = nullToBlank(in_vl.getString("SRLNUM"));		
		
		int RowStatus;
		StringBuffer sbSql 	= new StringBuffer();		//sql�� ���ۻ���
		
		sbSql.delete(0, sbSql.length());
		sbSql.append("UPDATE FSC_PATL_CHK_IMGE   \n");
		sbSql.append("   SET IMPROV_ORGNL_IMGE = ''   \n");
		sbSql.append("     , IMPROV_SVR_IMGE = ''   \n");
		sbSql.append("     , IMPROV_FILE_SIZE = ''   \n");
		sbSql.append(" WHERE SRLNUM = '" + SRLNUM  + "' \n");
				
		stmt = conn.createStatement();
		stmt.execute(sbSql.toString());
		stmt.close();
		
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