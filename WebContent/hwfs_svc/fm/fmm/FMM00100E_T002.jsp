<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	Statement stmt             =  null;
	try {
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		//jsp log ���� ���� 
		logger.startIndividualLog(in_vl.getString("titLogId"));
		
		//����Ŀ�� ���� false
		conn.setAutoCommit(false);
		
		//�Է� ����Ÿ                                                                                                                                                                                         
		DataSet ds_list  		= in_dl.get("ds_Save");
		
		StringBuffer sbSql 	= new StringBuffer();	//sql�� ���ۻ���
		
		int nCnt,DelRowCnt;
	
	
		DelRowCnt = ds_list.getRemovedRowCount();
		
		for ( int i = 0 ; i < DelRowCnt ; i++ )
		{
			String strUpjang 		= ds_list.getRemovedData(i, "UPJANG").toString();
			String strSubinvClass	= ds_list.getRemovedData(i, "SUBINV_CLASS").toString();
			String strRecipeCD		= ds_list.getRemovedData(i, "RECIPE_CD").toString();
			
			//  1-1. ������ ����                                                  
			sbSql.delete(0, sbSql.length());                                    
			sbSql.append("DELETE FROM FMM_UPJANG_RECIPE_MST				\n");                   
			sbSql.append(" WHERE UPJANG = " + strUpjang + "           	\n");        
			sbSql.append("   AND SUBINV_CLASS = '" + strSubinvClass + "'	\n");
			sbSql.append("   AND RECIPE_CD = '" + strRecipeCD + "'     	\n");

			stmt 		=  conn.createStatement();
			stmt.execute(sbSql.toString());
			stmt.close();
			
			//  1-2. ������ ����                                                  
			sbSql.delete(0, sbSql.length());                                    
			sbSql.append("DELETE FROM FMM_UPJANG_RECIPE_CUISINE			\n");                   
			sbSql.append(" WHERE UPJANG = " + strUpjang + "           	\n"); 
			sbSql.append("   AND SUBINV_CLASS = '" + strSubinvClass + "'	\n");
			sbSql.append("   AND RECIPE_CD = '" + strRecipeCD + "'     	\n");

			stmt 		=  conn.createStatement();
			stmt.execute(sbSql.toString());
			stmt.close();
			
			//  1-3. Ư�̻���  ����                                                
// 			sbSql.delete(0, sbSql.length());                                    
// 			sbSql.append("DELETE FROM FMM_UPJANG_RECIPE_SPECIAL			\n");                   
// 			sbSql.append(" WHERE UPJANG = " + strUpjang + "           	\n");
// 			sbSql.append("   AND SUBINV_CLASS = '" + strSubinvClass + "'	\n");
// 			sbSql.append("   AND RECIPE_CD = '" + strRecipeCD + "'     	\n");
			
// 			stmt 		=  conn.createStatement();
// 			stmt.execute(sbSql.toString());
// 			stmt.close();
			
			//  1-4. ��������  ����                                                
			sbSql.delete(0, sbSql.length());                                    
			sbSql.append("DELETE FROM FMM_UPJANG_RECIPE_NUT				\n");                   
			sbSql.append(" WHERE UPJANG = " + strUpjang + "           	\n");
			sbSql.append("   AND SUBINV_CLASS = '" + strSubinvClass + "'	\n");
			sbSql.append("   AND RECIPE_CD = '" + strRecipeCD + "'     	\n");

			stmt 		=  conn.createStatement();
			stmt.execute(sbSql.toString());
			stmt.close();
			
			//  1-5. ������  ����                                                
			sbSql.delete(0, sbSql.length());                                    
			sbSql.append("DELETE FROM FMM_UPJANG_RECIPE_ITEM				\n");                   
			sbSql.append(" WHERE UPJANG = " + strUpjang + "           	\n");
			sbSql.append("   AND SUBINV_CLASS = '" + strSubinvClass + "'	\n");
			sbSql.append("   AND RECIPE_CD = '" + strRecipeCD + "'     	\n");

			stmt 		=  conn.createStatement();
			stmt.execute(sbSql.toString());
			stmt.close();
		}
		
		conn.commit();
	   	this.setResultMessage(0, "OK",out_vl);
		
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