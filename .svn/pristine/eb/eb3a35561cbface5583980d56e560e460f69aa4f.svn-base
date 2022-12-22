<%                                                                                                                                                                                                      
/*-----------------------------------------------------------------------------                                                                                                                         
■ 시스템명     :                                                                                                                                                                
■ 프로그램ID  : FSA00090E_T001.jsp                                                                                                                                                                  
■ 프로그램명   : 추가구매 승인 신청                                                                                                                                              
■ 작성일자     : 2008-07-21                                                                                                                                                                        
■ 작성자       : 박지영
■ 수정자       : 정영철
■ 이력관리     : 2015-06-10                                                                                                                                     
-----------------------------------------------------------------------------*/                                                                                                                         
%>   
<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	Statement stmt             =  null;
	try	{
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));
		
		//오토커밋 강제 false
		conn.setAutoCommit(false);
		
		//입력 데이타                                                                                                                                                                                         
		DataSet ds_list  	= in_dl.get("ds_list");
		
		String g_EmpNo 		= in_vl.getString("g_EmpNo");
		
		StringBuffer sbSql 	= new StringBuffer();	//sql문 버퍼생성
		
		int RowCnt;
		int i;
		int RowStatus;
	
		// 2.Detail
		RowCnt = ds_list.getRowCount();
		
		for ( i = 0 ; i < RowCnt ; i++ )
		{
			RowStatus 	= ds_list.getRowType(i);
			
			if ( RowStatus == DataSet.ROW_TYPE_INSERTED )
			{
				sbSql.delete(0, sbSql.length());
				sbSql.append("INSERT INTO FSA_PR_CHECK ( \n");
				sbSql.append("  UPJANG, START_DATE, END_DATE, PR_REASON, ATTR01, CUSER, UUSER \n");
				sbSql.append(" ) VALUES ( \n");
				sbSql.append("    '"	+	nullToBlank(ds_list.getString(i,"UPJANG"))		+"' \n");
				sbSql.append("  , '"	+	nullToBlank(ds_list.getString(i,"START_DATE"))	+"' \n");
				sbSql.append("  , '"	+	nullToBlank(ds_list.getString(i,"END_DATE"))	+"' \n");
				sbSql.append("  , '"	+	nullToBlank(ds_list.getString(i,"PR_REASON"))	+"' \n");
				sbSql.append("  , '"	+	nullToBlank(ds_list.getString(i,"REASON_CD"))	+"' \n");

				sbSql.append("  , '" + g_EmpNo + "' \n");
				sbSql.append("  , '" + g_EmpNo + "' \n");
				sbSql.append(" ) \n");
				
				stmt 		=  conn.createStatement();
				stmt.execute(sbSql.toString());
				stmt.close();
			}
			else if ( RowStatus == DataSet.ROW_TYPE_UPDATED )
			{
				sbSql.delete(0, sbSql.length());
				sbSql.append("UPDATE FSA_PR_CHECK \n");
				sbSql.append("   SET PR_REASON = '"		+	nullToBlank(ds_list.getString(i,"PR_REASON"))	+"' \n");
				sbSql.append("	 , ATTR01 = '"          +   nullToBlank(ds_list.getString(i,"REASON_CD"))	+"' \n");
				sbSql.append("	 , UUSER = '"           +   g_EmpNo + "' \n");
				sbSql.append("	 , UDATE = SYSDATE \n");
				sbSql.append(" WHERE UPJANG = '"		+	nullToBlank(ds_list.getString(i,"UPJANG"))		+"' \n");
				sbSql.append("   AND START_DATE = '"	+	nullToBlank(ds_list.getString(i,"START_DATE"))	+"' \n");
				sbSql.append("   AND END_DATE = '"		+	nullToBlank(ds_list.getString(i,"END_DATE"))	+"' \n");
				
				stmt 		=  conn.createStatement();
				stmt.execute(sbSql.toString());
				stmt.close();
			}
		}
		
		conn.commit();
	   	this.setResultMessage(0, "OK",out_vl);
		
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