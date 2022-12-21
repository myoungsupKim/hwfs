<%                                                                                                                                                                                                      
/*-----------------------------------------------------------------------------                                                                                                                         
■ 시스템명     : 메뉴관리/레시피관리                                                                                                                                                                     
■ 프로그램ID   : FSR00110V_T002.jsp                                                                                                                                                                    
■ 프로그램명   : 사업장 레시피 제공이력 - 레시피상세                                                                                                                                              
■ 작성일자     : 2008.02.28                                                                                                                                                                            
■ 작성자       : 박지영                                                                                                                                                                                
■ 이력관리     : 2008.02.28                                                                                                                                                                            
-----------------------------------------------------------------------------*/                                                                                                                         
%>                                                                                                                                                                                                      
                                                                                                                                                                    
<%@ page contentType="text/html; charset=EUC-KR" %>                                                                                                                                                     
<%@ include file = "../../sc/main/common.jsp" %>                                                                                                                                                        
<%
	try {
		PlatformRequest platformRequest = this.proc_input(request);                                                                                                                                           
		in_vl = platformRequest.getData().getVariableList();                                                                                                                                                            
		in_dl = platformRequest.getData().getDataSetList();  
		
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));
	                                                                                                                                                                                                        
		//입력 데이타                                                                                                                                                                                         
		DataSet ds_input     = in_dl.get("ds_input");                                                                                                                                                  
	                                                                                                                                                                                                        
	  	String strUpjang 		= nullToBlank(ds_input.getString(0, "UPJANG"));                                                                                                                                                                                                        
		String strMenuCD 		= nullToBlank(ds_input.getString(0, "MENU_CD")); 
		String strRecipeCD 		= nullToBlank(ds_input.getString(0, "RECIPE_CD")); 
                                                                                                                                                                                                        
                                                                                                                                                                                                     
		//out 데이타                                                                                                                                                                                        
		DataSet ds_list;                                                                                                                                                                                    
		                                                                                                                                                                                                    
		//sql문 버퍼생성                                                                                                                                                                                    
		StringBuffer sbSql = new StringBuffer();                                                                                                                                                            
         
		// 사업장레시피 제공이력
		sbSql.delete(0, sbSql.length());
		sbSql.append("SELECT A.UPJANG \n");
		sbSql.append("     , A.MENU_CD \n");
		sbSql.append("     , A.RECIPE_CD \n");
		sbSql.append("     , A.ITEM_CODE \n");
		sbSql.append("     , B.ITEM_NAME \n");
		sbSql.append("     , A.NEED_QTY \n");
		sbSql.append("  FROM FSM_REAL_RECIPE_ITEM A \n");
		sbSql.append("       ,( \n");
		sbSql.append("       SELECT ITEM_CODE, \n");
		sbSql.append("              ITEM_NAME, \n");
		sbSql.append("              ITEM_SIZE, \n");
		sbSql.append("              PO_UOM, \n");
		sbSql.append("              KG_CONVERT_RATE \n");
		sbSql.append("         FROM HLDC_PO_ITEM_MST \n");
		sbSql.append("        WHERE ITEM_CLASS1 = 'F' \n");
		sbSql.append("       ) B \n");
		sbSql.append("  WHERE A.ITEM_CODE = B.ITEM_CODE \n");
		sbSql.append("    AND A.UPJANG    = " + strUpjang + " \n");
		sbSql.append("    AND A.MENU_CD   = '" + strMenuCD + "' \n");
		sbSql.append("    AND A.RECIPE_CD = '" + strRecipeCD + "' \n");
		sbSql.append("ORDER BY A.ITEM_CODE \n");
		
		//System.out.println(sbSql.toString());                                                                                                                                                             
		pstmt = conn.prepareStatement(sbSql.toString());		                                                                                                                                                
		rs = pstmt.executeQuery();                                                                                                                                                                          
		ds_list = this.makeDataSet(rs, "ds_list");   
		
		rs.close();
		pstmt.close();
                                                                                                                                                                                                        
		/**종료**/                                                                                                                                                                                          
		out_dl.add(ds_list);                                                                                                                                                          
		this.setResultMessage(0, "OK", out_vl);                                                                                                                                                             
                                                                                                                                                                                                        
	}                                                                                                                                                                                                     
	catch(Exception ex)                                                                                                                                                                                   
	{                                                                                                                                                                                                     
		//ex.printStackTrace();
		//jsp 로그남기기
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
		
		//jsp log 서비스 닫기 
		try {
			logger.endIndividualLog();
		} catch( Exception logE) {
			logE.printStackTrace();
		}
	}                                                                                                                                                                                                     
                                                                                                                                                                                                        
	proc_output(response,out,out_vl,out_dl);                                                                                                                                                              
                                                                                                                                                                                                        
%>