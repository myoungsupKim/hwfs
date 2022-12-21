<%                                                                                                                                                                                                      
/*-----------------------------------------------------------------------------                                                                                                                         
■ 시스템명     : 메뉴관리/레시피관리                                                                                                                                                                     
■ 프로그램ID   : FSR00110V_T001.jsp                                                                                                                                                                    
■ 프로그램명   : 사업장 레시피 제공이력                                                                                                                                                 
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
		String strHallCD 		= nullToBlank(ds_input.getString(0, "HALL_CD")); 
		String strMeal 			= nullToBlank(ds_input.getString(0, "MEAL")); 
	  	String strCorner 		= nullToBlank(ds_input.getString(0, "CORNER"));                                                                                                                                                                                                        
		String strRecipeClass	= nullToBlank(ds_input.getString(0, "RECIPE_CLASS")); 
		String strRecipeType	= nullToBlank(ds_input.getString(0, "RECIPE_TYPE")); 
	  	String strCuisineType	= nullToBlank(ds_input.getString(0, "CUISINE_TYPE"));                                                                                                                                                                                                        
		String strRecipeName	= nullToBlank(ds_input.getString(0, "RECIPE_NAME")); 
		String strFromDT		= nullToBlank(ds_input.getString(0, "FROM_MENU_DATE"));
		String strToDT 			= nullToBlank(ds_input.getString(0, "TO_MENU_DATE")); 
                                                                                                                                                                                                        
                                                                                                                                                                                                     
		//out 데이타                                                                                                                                                                                        
		DataSet ds_list;                                                                                                                                                                                    
		                                                                                                                                                                                                    
		//sql문 버퍼생성                                                                                                                                                                                    
		StringBuffer sbSql = new StringBuffer();                                                                                                                                                            
         
		// 사업장레시피 제공이력
		sbSql.delete(0, sbSql.length());
		sbSql.append("SELECT A.UPJANG \n");
		sbSql.append("       ,A.MENU_CD \n");
		sbSql.append("       ,A.MENU_DATE \n");
		sbSql.append("       ,A.HALL_CD \n");
		sbSql.append("       ,D.HALL_NAME \n");
		sbSql.append("       ,A.MEAL \n");
		sbSql.append("       ,(SELECT CODE_NAME FROM SCC_COMMON_CODE X WHERE X.GROUP_CODE = 'FS0023' AND X.CODE = A.MEAL) AS MEAL_NM \n");
		sbSql.append("       ,A.CORNER \n");
		sbSql.append("       ,(SELECT CODE_NAME FROM SCC_COMMON_CODE X WHERE X.GROUP_CODE = 'FS0022' AND X.CODE = A.CORNER) AS CORNER_NM \n");
		sbSql.append("       ,B.RECIPE_CD \n");
		sbSql.append("       ,B.RECIPE_NAME \n");
		sbSql.append("       ,B.RECIPE_CLASS \n");
		sbSql.append("       ,(SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE ='FS0001'AND CODE = B.RECIPE_CLASS) AS RECIPE_CLASS_NM \n");
		sbSql.append("       ,B.RECIPE_TYPE \n");
		sbSql.append("       ,(SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE ='FS0002'AND CODE = B.RECIPE_TYPE) AS RECIPE_TYPE_NM \n");
		sbSql.append("       ,B.CUISINE_TYPE \n");
		sbSql.append("       ,(SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE ='FS0003'AND CODE = B.CUISINE_TYPE) AS CUISINE_TYPE_NM \n");
		sbSql.append("  FROM FSM_REAL_MENU_MST A \n");
		sbSql.append("       ,FSM_REAL_RECIPE_MST B \n");
		sbSql.append("       ,FSA_HALL_MST D \n");
		sbSql.append("  WHERE A.UPJANG = B.UPJANG \n");
		sbSql.append("    AND A.MENU_CD = B.MENU_CD \n");
		sbSql.append("    AND A.UPJANG = " + strUpjang + " \n");
		sbSql.append("    AND A.UPJANG = D.UPJANG \n");
		sbSql.append("    AND A.HALL_CD = D.HALL_CD \n");
		if (strHallCD.length() != 0) sbSql.append("    AND A.HALL_CD = '" + strHallCD + "' \n");
		if (strMeal.length() != 0) sbSql.append("    AND A.MEAL = '" + strMeal + "' \n");
		if (strCorner.length() != 0) sbSql.append("    AND A.CORNER = '" + strCorner + "' \n");
		if (strRecipeClass.length() != 0) sbSql.append("    AND B.RECIPE_CLASS = '" + strRecipeClass + "' \n");
		if (strRecipeType.length() != 0) sbSql.append("    AND B.RECIPE_TYPE = '" + strRecipeType + "' \n");
		if (strCuisineType.length() != 0) sbSql.append("    AND B.CUISINE_TYPE = '" + strCuisineType + "' \n");
		if (strRecipeName.length() != 0) sbSql.append("    AND B.RECIPE_NAME LIKE '%' || '" + strRecipeName + "' || '%' \n");
		sbSql.append("    AND A.MENU_DATE BETWEEN '" + strFromDT + "' AND '" + strToDT + "' \n");
		sbSql.append("ORDER BY A.MENU_DATE,A.HALL_CD,A.MEAL,A.CORNER,B.RECIPE_CD \n");
		
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