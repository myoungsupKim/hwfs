<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 협력업체 > 운영관리
■ 프로그램ID   : FSV00310V_T001.jsp
■ 프로그램명   : 전자세금계산서담당자관리
■ 작성일자     : 2010-05-20
■ 작성자       : 문형광
■ 이력관리     : 2010-05-20 - 최초작성 문형광 CSR#(00000)
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	Statement stmt             =  null;
	try {
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		//입력 데이타                                                                                                                                                                                         
		DataSet ds_List  		= in_dl.get("ds_List"); 
		
		if(conn != null && !conn.isClosed()) conn.close();
		
		conn = getIRISConn();
		
		stmt 		=  conn.createStatement();
	
	
		//out 데이타                                                                                                                                                                                        
		//DataSet ds_list;                                                                                                                                                                                    
		                                                                                                                                                                                                    
		//sql문 버퍼생성                                                                                                                                                                                    
		StringBuffer sbSql = new StringBuffer();                                                                                                                                                            
                                                                                                                                                              
		for ( int i = 0 ; i < ds_List.getRowCount() ; i++ )
		{
			sbSql.delete(0, sbSql.length());

			//IF_SEND_MST_PRO 기준에 따라 UPDATE/INSERT
			sbSql.delete(0, sbSql.length());
        	//sbSql.append("SELECT MAX(SEQ) AS SEQ, CMP_ID, CRAT_USER                   							       				\n");
        	sbSql.append("SELECT SEQ, CMP_ID, CRAT_USER                   							       				\n");
        	sbSql.append("  FROM IF_CMP_MEM_INFO             												   				\n");
        	sbSql.append(" WHERE CMP_ID = '" + nullToBlank(ds_List.getString(i,"CMP_ID")) + "'         				\n");
        	sbSql.append("   AND MEM_NAME = '" + nullToBlank(ds_List.getString(i,"MEM_NAME")) + "'    				\n");
        	sbSql.append("   AND SC_CRYPTO_FUN('DEC',MEM_EMAIL_ENC,5) = '" + nullToBlank(ds_List.getString(i,"MEM_EMAIL")) + "'   				\n");
	        sbSql.append("   AND CRAT_USER = '" + nullToBlank(ds_List.getString(i,"SABUN")) + "'       				\n");
	        sbSql.append("   AND SEQ = '" + nullToBlank(ds_List.getString(i,"SEQ")) + "'       				\n");
	        sbSql.append("   AND ROWNUM <= 1       				\n");
//out_vl.add("fa_Sql", sbSql.toString());
			pstmt = conn.prepareStatement(sbSql.toString()); //미리 담아놓는 곳이라네
			rs = pstmt.executeQuery(); //쿼리실행한다
	
			if(rs.next())	// UPDATE
			{
				sbSql.delete(0, sbSql.length());
				sbSql.append("UPDATE IF_CMP_MEM_INFO 																		\n");
				sbSql.append("   SET CMP_ID = '"			+	nullToBlank(ds_List.getString(i,"CMP_ID")) +"' 		\n");
				//sbSql.append("	   , CMP_NAME = '"			+	nullToBlank(ds_list.getString(0,"CMP_NAME")) +"' 	\n");
				//sbSql.append("	   , MEM_NAME = '"			+	nullToBlank(ds_list.getString(0,"MEM_NAME")) +"' 	\n");
				sbSql.append("	   , MEM_TEL_NO = '"		+	nullToBlank(ds_List.getString(i,"MEM_TEL_NO")) +"' 	\n");
				sbSql.append("	   , MEM_CP_NO = '"			+	nullToBlank(ds_List.getString(i,"MEM_CP_NO")) +"' 	\n");
				sbSql.append("	   , MEM_EMAIL = '"			+	nullToBlank(ds_List.getString(i,"MEM_EMAIL")) +"' 	\n");
				sbSql.append("	   , MEM_DEPT = '"			+	nullToBlank(ds_List.getString(i,"MEM_DEPT")) +"' 	\n");
				sbSql.append("	   , UPDT_USER = '"			+	nullToBlank(ds_List.getString(i,"SABUN")) +"' 		\n");
				sbSql.append("	   , UPDT_DATE = SYSDATE 																	\n");
				sbSql.append(" WHERE SEQ = '" +	nullToBlank(rs.getString("SEQ")) +"' 								    	\n");
				sbSql.append("   AND CMP_ID ='" + nullToBlank(rs.getString("CMP_ID")) +"' 		                			\n");
				sbSql.append("   AND CRAT_USER = '" + nullToBlank(rs.getString("CRAT_USER")) + "' 			            	\n");
			}
			else							
			{
				// INSERT
   				sbSql.delete(0, sbSql.length());
				sbSql.append("INSERT INTO IF_CMP_MEM_INFO(                                          					\n");
				sbSql.append("	     CMP_ID 																			\n");
				sbSql.append("	   , SEQ 																				\n");
				sbSql.append("	   , CMP_NAME 																			\n");
				sbSql.append("	   , MEM_NAME 																			\n");
				sbSql.append("	   , MEM_TEL_NO 																		\n");
				sbSql.append("	   , MEM_CP_NO 																			\n");
				sbSql.append("	   , MEM_EMAIL 																			\n");
				sbSql.append("	   , MEM_DEPT																			\n");
				sbSql.append("	   , CRAT_USER 																			\n");
				sbSql.append("	   , CRAT_DATE 																			\n");
				sbSql.append("	   , UPDT_USER 																			\n");
				sbSql.append("	   , UPDT_DATE 																			\n");
				sbSql.append("     ) VALUES                                           									\n");
				sbSql.append("     ( '" + nullToBlank(ds_List.getString(i,"CMP_ID")) + "'   					\n");
				sbSql.append("     , ( SELECT NVL(MAX(SEQ), 0) + 1 AS SEQ                           					\n");
				sbSql.append("           FROM IF_CMP_MEM_INFO                                       					\n");
				sbSql.append("          WHERE CMP_ID = '" + nullToBlank(ds_List.getString(i,"CMP_ID")) + "' )   \n");
				sbSql.append("	   , '" + nullToBlank(ds_List.getString(i,"CMP_NAME")) + "' 					\n");
				sbSql.append("	   , '" + nullToBlank(ds_List.getString(i,"MEM_NAME")) + "' 					\n");
				sbSql.append("	   , '" + nullToBlank(ds_List.getString(i,"MEM_TEL_NO")) +"'					\n");
				sbSql.append("	   , '" + nullToBlank(ds_List.getString(i,"MEM_CP_NO")) +"' 					\n");
				sbSql.append("	   , '" + nullToBlank(ds_List.getString(i,"MEM_EMAIL")) +"' 					\n");
				sbSql.append("	   , '" + nullToBlank(ds_List.getString(i,"MEM_DEPT")) +"'  					\n");
				sbSql.append("	   , '" + nullToBlank(ds_List.getString(i,"SABUN")) +"'     					\n");	
				sbSql.append("	   , SYSDATE 																			\n");
				sbSql.append("	   , '" + nullToBlank(ds_List.getString(i,"SABUN")) +"' 						\n");	
				sbSql.append("	   , SYSDATE ) 																			\n");
			}        
out_vl.add("fa_Sql", sbSql.toString());		
			System.out.println(sbSql.toString());
			stmt.execute(sbSql.toString());
		
			/**종료**/       			
			conn.commit();
		   	this.setResultMessage(0, "OK",out_vl);		
		}
				
		
	}	
		
	catch(Exception ex) {
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