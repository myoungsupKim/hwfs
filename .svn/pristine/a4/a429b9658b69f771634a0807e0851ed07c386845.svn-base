
<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	Statement stmt             =  null;
	try {
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));
		
		//오토커밋 강제 false
		conn.setAutoCommit(false);
		
		//입력 데이타                                                                                                                                                                                         
		DataSet ds_Master  	= in_dl.get("ds_Master");
		DataSet ds_Detail  	= in_dl.get("ds_Detail");
		
		String g_EmpNo 		= in_vl.getString("g_EmpNo");
		
		StringBuffer sbSql 	= new StringBuffer();	//sql문 버퍼생성
		
		int RowCnt;
		int i;
	
	
		// 1.Master
		RowCnt = ds_Master.getRowCount();
		
		if (RowCnt > 0)
		{
			// 2. update
			sbSql.delete(0, sbSql.length());
			sbSql.append("UPDATE FSC_RESULT_MST \n");
			sbSql.append("   SET IMPROV_RPT_DATE = '"	+	nullToBlank(ds_Master.getString(0,"IMPROV_RPT_DATE"))	+"' \n");
			sbSql.append("      ,ADD_REMARK = '"	+	nullToBlank(ds_Master.getString(0,"ADD_REMARK"))	+"' \n");			
			// 점검결과에서 최종수정자 때문에 저장 안하기로 함.
			//sbSql.append("	 , UUSER = '" 				+ 	g_EmpNo 														+"' \n");
			//sbSql.append("	 , UDATE = SYSDATE \n");
			sbSql.append(" WHERE TABLE_TYPE = '"		+	nullToBlank(ds_Master.getString(0,"TABLE_TYPE"))		+"' \n");
			sbSql.append("   AND FORM_CD = '"			+	nullToBlank(ds_Master.getString(0,"FORM_CD"))			+"' \n");
			sbSql.append("   AND UPJANG = '"			+	nullToBlank(ds_Master.getString(0,"UPJANG"))			+"' \n");
			sbSql.append("   AND CHECK_DATE = '"		+	nullToBlank(ds_Master.getString(0,"CHECK_DATE"))		+"' \n");						
			
			stmt 		=  conn.createStatement();
			stmt.execute(sbSql.toString());
			stmt.close();
		}

		// 2.Detail
		RowCnt = ds_Detail.getRowCount();
		
		for ( i = 0 ; i < RowCnt ; i++ )
		{
			sbSql.delete(0, sbSql.length());
			sbSql.append("UPDATE FSC_RESULT_DTL \n");
			sbSql.append("   SET INDICATE_PHOTO = '"	+	nullToBlank(ds_Detail.getString(i,"INDICATE_PHOTO"))	+"' \n");
			sbSql.append("	 , SINDICATE_PHOTO = '"		+	nullToBlank(ds_Detail.getString(i,"SINDICATE_PHOTO"))	+"' \n");
			sbSql.append("	 , IMPROV_MGMT = '"			+	nullToBlank(ds_Detail.getString(i,"IMPROV_MGMT")).replaceAll("'","''")		+"' \n");
			sbSql.append("	 , MGMT_DATE = '"			+	nullToBlank(ds_Detail.getString(i,"MGMT_DATE"))			+"' \n");
			sbSql.append("	 , IMPROV_PHOTO = '"		+	nullToBlank(ds_Detail.getString(i,"IMPROV_PHOTO"))		+"' \n");
			sbSql.append("	 , SIMPROV_PHOTO = '"		+	nullToBlank(ds_Detail.getString(i,"SIMPROV_PHOTO"))		+"' \n");
			//(헤깔릴것 같아서 같이 처리)
			//sbSql.append("	 , UUSER = '" 				+ 	g_EmpNo 														+ "' \n");
			//sbSql.append("	 , UDATE = SYSDATE \n");
			sbSql.append(" WHERE TABLE_TYPE = '"		+	nullToBlank(ds_Detail.getString(i,"TABLE_TYPE"))		+"' \n");
			sbSql.append("   AND FORM_CD = '"			+	nullToBlank(ds_Detail.getString(i,"FORM_CD"))			+"' \n");
			sbSql.append("   AND UPJANG = '"			+	nullToBlank(ds_Detail.getString(i,"UPJANG"))			+"' \n");
			sbSql.append("   AND CHECK_DATE = '"		+	nullToBlank(ds_Detail.getString(i,"CHECK_DATE"))		+"' \n");
			sbSql.append("   AND CLASS_CD = '"			+	nullToBlank(ds_Detail.getString(i,"CLASS_CD"))			+"' \n");
			
			stmt 		=  conn.createStatement();
			stmt.execute(sbSql.toString());
			stmt.close();
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