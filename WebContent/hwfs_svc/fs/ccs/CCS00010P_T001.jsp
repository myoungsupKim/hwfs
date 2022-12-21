
<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	Statement stmt = null;
	try {
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));
		
		//오토커밋 강제 false
		conn.setAutoCommit(false);
		
		//입력 데이타               
		DataSet ds_input    = in_dl.get("ds_input");		    // 입력마스터값
		DataSet ds_imgeList = in_dl.get("ds_imgeList");
		String g_EmpNo      = in_vl.getString("g_EmpNo");

		String SRLNUM            = "";		
		String UPJANG            = ds_input.getString(0, "UPJANG");
		String EDU_SEQ           = ds_input.getString(0, "EDU_SEQ");
		String ORGNL_IMGE        = "";
		String SVR_IMGE          = "";
		String FILE_SIZE         = "";
		
		int RowStatus;
		StringBuffer sbSql 	= new StringBuffer();		//sql문 버퍼생성
		
		int RowCnt = ds_imgeList.getRowCount();
		for ( int i = 0 ; i < RowCnt ; i++ )
		{
			RowStatus = ds_imgeList.getRowType(i);
			if ( RowStatus == DataSet.ROW_TYPE_INSERTED )
			{ 
				ORGNL_IMGE        = nullToBlank(ds_imgeList.getString(i, "ORGNL_IMGE"));          
				SVR_IMGE          = nullToBlank(ds_imgeList.getString(i, "SVR_IMGE"));
				FILE_SIZE         = nullToBlank(ds_imgeList.getString(i, "FILE_SIZE"));
				
				sbSql.delete(0, sbSql.length());
				sbSql.append("INSERT INTO FCUS.CCS_EDU_MGMT_IMGE ( \n");
				sbSql.append("       SRLNUM                     \n");	
				sbSql.append("     , UPJANG                     \n");
				sbSql.append("     , EDU_SEQ                    \n");
				sbSql.append("     , ORGNL_IMGE                 \n");
				sbSql.append("     , SVR_IMGE                   \n");
				sbSql.append("     , FILE_SIZE                  \n");
				sbSql.append("     , CUSER                      \n");
				sbSql.append("     , CDATE                      \n");
				sbSql.append("     , UUSER                      \n");
				sbSql.append("     , UDATE                      \n");
				sbSql.append(") VALUES (                        \n");
				sbSql.append("       (SELECT NVL(MAX(SRLNUM), 0) + 1 FROM FCUS.CCS_EDU_MGMT_IMGE) \n");
				sbSql.append("     , '" + UPJANG           + "' \n");
				sbSql.append("     , '" + EDU_SEQ          + "' \n");
				sbSql.append("     , '" + ORGNL_IMGE       + "' \n");
				sbSql.append("     , '" + SVR_IMGE         + "' \n");
				sbSql.append("     , '" + FILE_SIZE        + "' \n");
				sbSql.append("     , '" + g_EmpNo          + "' \n");
				sbSql.append("     , SYSDATE                    \n");
				sbSql.append("     , '" + g_EmpNo          + "' \n");
				sbSql.append("     , SYSDATE                    \n");
				sbSql.append(")                                 \n");			
				
				stmt = conn.createStatement();
				stmt.execute(sbSql.toString());
				stmt.close();
			}
			else if ( RowStatus == DataSet.ROW_TYPE_UPDATED ) {
				SRLNUM            = nullToBlank(ds_imgeList.getString(i, "SRLNUM"));          
				ORGNL_IMGE = nullToBlank(ds_imgeList.getString(i, "ORGNL_IMGE"));          
				SVR_IMGE   = nullToBlank(ds_imgeList.getString(i, "SVR_IMGE"));
				FILE_SIZE  = nullToBlank(ds_imgeList.getString(i, "FILE_SIZE"));
				
				sbSql.delete(0, sbSql.length());
				sbSql.append("UPDATE FCUS.CCS_EDU_MGMT_IMGE                            \n");
				sbSql.append("   SET ORGNL_IMGE= '" + ORGNL_IMGE + "' \n");
				sbSql.append("     , SVR_IMGE  = '" + SVR_IMGE   + "' \n");
				sbSql.append("     , FILE_SIZE = '" + FILE_SIZE  + "' \n");
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
		//jsp 로그남기기
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
		
		//jsp log 서비스 닫기 
		try {
			logger.endIndividualLog();
		} catch( Exception logE) {
			logE.printStackTrace();
		}
	}
		
	proc_output(response,out,out_vl,out_dl);
	
%>	