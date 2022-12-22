
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

		String strUpjang        = ds_input.getString(0, "UPJANG");
		String strVisitDt       = ds_input.getString(0, "VISIT_DT");
		String strSeqNo         = ds_input.getString(0, "SEQNO");
		String strCheckSeq      = ds_input.getString(0, "CHECKSEQ");
		String strImgeSeq = "";
		String strOrgImge = "";
		String strSvrImge = "";
		String strImprovOrgImge = "";
		String strImprovSvrImge = "";
		
		int RowStatus;
		StringBuffer sbSql 	= new StringBuffer();		//sql문 버퍼생성
		
		int RowCnt = ds_imgeList.getRowCount();
		for ( int i = 0 ; i < RowCnt ; i++ )
		{
			RowStatus = ds_imgeList.getRowType(i);
			if ( RowStatus == DataSet.ROW_TYPE_INSERTED )
			{ 
				strOrgImge        = nullToBlank(ds_imgeList.getString(i, "ORG_IMGE"));          
				strSvrImge        = nullToBlank(ds_imgeList.getString(i, "SVR_IMGE"));
				strImprovOrgImge  = nullToBlank(ds_imgeList.getString(i, "IMPROV_ORG_IMGE"));
				strImprovSvrImge  = nullToBlank(ds_imgeList.getString(i, "IMPROV_SVR_IMGE"));          
				
				sbSql.delete(0, sbSql.length());
				sbSql.append("INSERT INTO FSC_TEST_EXTERNAL_IMGE ( 	\n");
				sbSql.append("       UPJANG                        	\n");			
				sbSql.append("     , VISIT_DT                 		\n");
				sbSql.append("     , SEQNO                    		\n");
				sbSql.append("     , CHECKSEQ                     	\n");
				sbSql.append("     , IMGESEQ                     	\n");
				sbSql.append("     , ORG_IMGE                   	\n");
				sbSql.append("     , SVR_IMGE                 		\n");
				sbSql.append("     , IMPROV_ORG_IMGE              	\n");
				sbSql.append("     , IMPROV_SVR_IMGE               	\n");
				sbSql.append("     , CUSER                      	\n");
				sbSql.append("     , CDATE                      	\n");
				sbSql.append("     , UUSER                      	\n");
				sbSql.append("     , UDATE                      	\n");
				sbSql.append(") VALUES (                        	\n");
				sbSql.append("       '" + strUpjang       	+ "' \n");
				sbSql.append("     ,  '" + strVisitDt       	+ "' \n");
				sbSql.append("     ,  " + strSeqNo       	+ " \n");
				sbSql.append("     ,  " + strCheckSeq       	+ " \n");
				sbSql.append("     ,  (SELECT NVL(MAX(IMGESEQ), 0) + 1 FROM FSC_TEST_EXTERNAL_IMGE \n");
				sbSql.append("         WHERE UPJANG = '" 	+ strUpjang  + "' \n");
				sbSql.append("           AND VISIT_DT = '" 	+ strVisitDt  + "' \n");
				sbSql.append("           AND SEQNO = " 		+ strSeqNo  + " \n");
				sbSql.append("           AND CHECKSEQ = " 	+ strCheckSeq  + " \n");
				sbSql.append("       ) \n");
				sbSql.append("     , '" + strOrgImge       	+ "' \n");
				sbSql.append("     , '" + strSvrImge        + "' \n");
				sbSql.append("     , '" + strImprovOrgImge  + "' \n");
				sbSql.append("     , '" + strImprovSvrImge  + "' \n");
				sbSql.append("     , '" + g_EmpNo          	+ "' \n");
				sbSql.append("     , SYSDATE                     \n");
				sbSql.append("     , '" + g_EmpNo          	+ "' \n");
				sbSql.append("     , SYSDATE                     \n");
				sbSql.append(")                                  \n");			
				
				stmt = conn.createStatement();
				stmt.execute(sbSql.toString());
				stmt.close();
			}
			else if ( RowStatus == DataSet.ROW_TYPE_UPDATED ) {
				strImgeSeq        = ds_imgeList.getString(i, "IMGESEQ");
				strOrgImge        = nullToBlank(ds_imgeList.getString(i, "ORG_IMGE"));          
				strSvrImge        = nullToBlank(ds_imgeList.getString(i, "SVR_IMGE"));
				strImprovOrgImge  = nullToBlank(ds_imgeList.getString(i, "IMPROV_ORG_IMGE"));
				strImprovSvrImge  = nullToBlank(ds_imgeList.getString(i, "IMPROV_SVR_IMGE"));          
				
				sbSql.delete(0, sbSql.length());
				sbSql.append("UPDATE FSC_TEST_EXTERNAL_IMGE                        \n");
				sbSql.append("   SET ORG_IMGE        = '" + strOrgImge        + "' \n");
				sbSql.append("     , SVR_IMGE        = '" + strSvrImge        + "' \n");
				sbSql.append("     , IMPROV_ORG_IMGE = '" + strImprovOrgImge  + "' \n");
				sbSql.append("     , IMPROV_SVR_IMGE = '" + strImprovSvrImge  + "' \n");
				sbSql.append("     , UUSER           = '" + g_EmpNo           + "' \n"); 
				sbSql.append("     , UDATE           = SYSDATE                     \n");
				sbSql.append(" WHERE UPJANG = '" 		  + strUpjang  		  + "' \n");
				sbSql.append("   AND VISIT_DT = '" 		  + strVisitDt  	  + "' \n");
				sbSql.append("   AND SEQNO = " 			  + strSeqNo  		  + "  \n");
				sbSql.append("   AND CHECKSEQ = " 		  + strCheckSeq  	  + "  \n");
				sbSql.append("   AND IMGESEQ = " 		  + strImgeSeq  	  + "  \n");
				
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