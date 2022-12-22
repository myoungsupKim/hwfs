
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
		//DataSet ds_Master  	= in_dl.get("ds_Master");
		DataSet ds_list  	= in_dl.get("ds_list");
		String g_EmpNo 		= in_vl.getString("g_EmpNo");
		
		StringBuffer sbSql 	= new StringBuffer();	//sql문 버퍼생성		
		int RowCnt;
		int i;
		
		// 2.Detail
		RowCnt = ds_list.getRowCount();
		
		//System.out.println("RowCnt : " + RowCnt);
		
		for ( i = 0 ; i < RowCnt ; i++ ){
			sbSql.delete(0, sbSql.length());
			
			// 저장할 사전정보가 없으면 PASS
			if(!nullToBlank(ds_list.getString(i, "IM_SPHOTO")).equals("")){
		        sbSql.append("INSERT INTO FSC_RESULT_PHOTO(         			\n");
		        sbSql.append("      TABLE_TYPE                      			\n");
		        sbSql.append("    , FORM_CD                         			\n");
		        sbSql.append("    , UPJANG                          			\n");
		        sbSql.append("    , CHECK_DATE                      			\n");
		        sbSql.append("    , CLASS_CD                        			\n");
		        sbSql.append("    , SEQ                             			\n");
		        sbSql.append("    , PHOTO_TYPE                      			\n");
		        sbSql.append("    , PHOTO                           			\n");
		        sbSql.append("    , SPHOTO                          			\n");
		        sbSql.append("	  , INPT_GUBUN                         			\n");
		        sbSql.append("	  , MAP_SEQ                            			\n");
		        sbSql.append("    , CUSER                           			\n");
		        sbSql.append("    , CDATE                           			\n");
		        sbSql.append("	  , UUSER                             			\n");
		        sbSql.append("	  , UDATE                              			\n");
		        sbSql.append(")                                     			\n");
		        sbSql.append("SELECT A.TABLE_TYPE                   			\n");
		        sbSql.append("     , A.FORM_CD                      			\n");
		        sbSql.append("     , A.UPJANG                       			\n");
		        sbSql.append("     , A.CHECK_DATE                   			\n");
		        sbSql.append("     , A.CLASS_CD                     			\n");
		        sbSql.append("     , (SELECT MAX(SEQ)+1             			\n");
		        sbSql.append("          FROM FSC_RESULT_PHOTO       			\n");
		        sbSql.append("         WHERE TABLE_TYPE = A.TABLE_TYPE 			\n");
		        sbSql.append("           AND FORM_CD    = A.FORM_CD 			\n");
		        sbSql.append("           AND UPJANG     = A.UPJANG  			\n");
		        sbSql.append("           AND CHECK_DATE = A.CHECK_DATE 			\n");
		        sbSql.append("           AND CLASS_CD   = A.CLASS_CD) AS SEQ 	\n");
		        sbSql.append("     , A.PHOTO_TYPE                   			\n");
		        sbSql.append("     , '" + nullToBlank(ds_list.getString(i, "IM_PHOTO")) + "'                        			\n");
		        sbSql.append("     , '" + nullToBlank(ds_list.getString(i, "IM_SPHOTO")) + "'                       			\n");
		        sbSql.append("     , 'IM'                           			\n");
		        sbSql.append("     , A.SEQ AS MAP_SEQ               			\n");
		        sbSql.append("     , '" + g_EmpNo + "'              			\n");
		        sbSql.append("     , SYSDATE                        			\n");
		        sbSql.append("     , '" + g_EmpNo + "'              			\n");
		        sbSql.append("     , SYSDATE                        			\n");
		        sbSql.append("  FROM FSC_RESULT_PHOTO A             			\n");
		        sbSql.append(" WHERE A.TABLE_TYPE = '" + nullToBlank(ds_list.getString(i, "TABLE_TYPE")) + "'  \n");
		        sbSql.append("   AND A.FORM_CD    = '" + nullToBlank(ds_list.getString(i, "FORM_CD")) + "'     \n");
		        sbSql.append("   AND A.UPJANG     = " + nullToBlank(ds_list.getString(i, "UPJANG")) + "      \n");
		        sbSql.append("   AND A.CHECK_DATE = '" + nullToBlank(ds_list.getString(i, "CHECK_DATE")) + "'  \n");
		        sbSql.append("   AND A.CLASS_CD   = '" + nullToBlank(ds_list.getString(i, "CLASS_CD")) + "'    \n");
		        sbSql.append("   AND A.SEQ        = '" + nullToBlank(ds_list.getString(i, "SEQ")) + "'         \n");
	
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