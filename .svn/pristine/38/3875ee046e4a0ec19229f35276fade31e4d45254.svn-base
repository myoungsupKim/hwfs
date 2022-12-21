<%                                                                                                                                                                                                      
/*-----------------------------------------------------------------------------                                                                                                                         
■ 시스템명     : 메뉴관리/식단관리                                                                                                                                                                     
■ 프로그램ID   : FSR00102V_T001.jsp                                                                                                                                                                    
■ 프로그램명   : 레시피목록 및 보유수량 조회-레시피보유수량1                                                                                                                                                 
■ 작성일자     : 2008.02.21                                                                                                                                                                            
■ 작성자       : 박지영                                                                                                                                                                                
■ 이력관리     : 2008.02.21                                                                                                                                                                            
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
	                                                                                                                                                                                                        
		//FileLog.println("d:\\aaa.txt", ds_cond);                                                                                                                                                            
		                                                                                                                                                                                                      
	  	String strSType 			= nullToBlank(ds_input.getString(0, "STYPE"));                                                                                                                                                                                                        
		String strUpjang 			= nullToBlank(ds_input.getString(0, "UPJANG"));                                                                                                                           
		String strHallClass			= nullToBlank(ds_input.getString(0, "HALL_CLASS"));                                                                                                                          
		//String strRecipeClass		= nullToBlank(ds_input.getString(0, "RECIPE_CLASS"));
		//String strRecipeType		= nullToBlank(ds_input.getString(0, "RECIPE_TYPE"));
		//String strCuisineType		= nullToBlank(ds_input.getString(0, "CUISINE_TYPE"));
		//String strRecipeName		= nullToBlank(ds_input.getString(0, "RECIPE_NAME"));
                                                                                                                                                                                                        
                                                                                                                                                                                                     
		//out 데이타                                                                                                                                                                                        
		DataSet ds_list;                                                                                                                                                                                    
		                                                                                                                                                                                                    
		//sql문 버퍼생성                                                                                                                                                                                    
		StringBuffer sbSql = new StringBuffer();                                                                                                                                                            
         
		if (strSType.equals("1"))
		{
			// 표준레시피                                                                                                                                                                       
			sbSql.delete(0, sbSql.length()); 
			sbSql.append("SELECT A.RECIPE_CLASS \n");
			sbSql.append("     , (SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE ='FS0001'AND CODE = A.RECIPE_CLASS) AS RECIPE_CLASS_NM \n");
			sbSql.append("     , A.RECIPE_TYPE \n");
			sbSql.append("     , (SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE ='FS0002'AND CODE = A.RECIPE_TYPE) AS RECIPE_TYPE_NM \n");
			sbSql.append("     , A.CUISINE_TYPE \n");
			sbSql.append("     , (SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE ='FS0003'AND CODE = A.CUISINE_TYPE) AS CUISINE_TYPE_NM \n");
			sbSql.append("     , COUNT(*) AS CNT \n");
			sbSql.append("     , DECODE(A.RECIPE_CLASS,'H',2,1) AS GBN \n");
			sbSql.append("  FROM FMR_STD_RECIPE_MST A \n");
			sbSql.append(" WHERE A.RECIPE_CLASS != 'H' \n");
			//sbSql.append(" WHERE 1=1 \n");
			//if (strRecipeClass.length() != 0)	sbSql.append("   AND A.RECIPE_CLASS = '" + strRecipeClass + "' \n");
			//if (strRecipeType.length() != 0)	sbSql.append("   AND A.RECIPE_TYPE = '" + strRecipeType + "' \n");
			//if (strCuisineType.length() != 0)	sbSql.append("   AND A.CUISINE_TYPE = '" + strCuisineType + "' \n");
			//if (strRecipeName.length() != 0)	sbSql.append("   AND A.RECIPE_NAME LIKE '%' || '" + strRecipeName + "' || '%' \n");
			sbSql.append("GROUP BY A.RECIPE_CLASS,A.RECIPE_TYPE,A.CUISINE_TYPE \n"); 
			sbSql.append("ORDER BY GBN,A.RECIPE_CLASS,A.RECIPE_TYPE,A.CUISINE_TYPE \n");                                                                                                                                          
		}
		else
		{
			// 업장표준레시피
			sbSql.delete(0, sbSql.length()); 
			sbSql.append("SELECT A.RECIPE_CLASS \n");
			sbSql.append("     , (SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE ='FS0001'AND CODE = A.RECIPE_CLASS) AS RECIPE_CLASS_NM \n");
			sbSql.append("     , A.RECIPE_TYPE \n");
			sbSql.append("     , (SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE ='FS0002'AND CODE = A.RECIPE_TYPE) AS RECIPE_TYPE_NM \n");
			sbSql.append("     , A.CUISINE_TYPE \n");
			sbSql.append("     , (SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE ='FS0003'AND CODE = A.CUISINE_TYPE) AS CUISINE_TYPE_NM \n");
			sbSql.append("     , COUNT(*) AS CNT \n");
			sbSql.append("     , DECODE(A.RECIPE_CLASS,'H',2,1) AS GBN \n");
			sbSql.append("  FROM FSR_UPJANG_RECIPE_MST A \n");
			sbSql.append(" WHERE A.UPJANG = " + strUpjang + " \n");
			sbSql.append("   AND A.HALL_CLASS = '" + strHallClass + "' \n");
			//sbSql.append(" WHERE 1=1 \n");
			//if (strRecipeClass.length() != 0)	sbSql.append("   AND A.RECIPE_CLASS = '" + strRecipeClass + "' \n");
			//if (strRecipeType.length() != 0)	sbSql.append("   AND A.RECIPE_TYPE = '" + strRecipeType + "' \n");
			//if (strCuisineType.length() != 0)	sbSql.append("   AND A.CUISINE_TYPE = '" + strCuisineType + "' \n");
			//if (strRecipeName.length() != 0)	sbSql.append("   AND A.RECIPE_NAME LIKE '%' || '" + strRecipeName + "' || '%' \n");
			sbSql.append("GROUP BY A.RECIPE_CLASS,A.RECIPE_TYPE,A.CUISINE_TYPE \n"); 
			sbSql.append("ORDER BY GBN,A.RECIPE_CLASS,A.RECIPE_TYPE,A.CUISINE_TYPE \n"); 
		}
		
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