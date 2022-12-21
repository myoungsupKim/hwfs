<%                                                                                                                                                                                                      
/*-----------------------------------------------------------------------------                                                                                                                         
�� �ý��۸�     : �޴�����/�Ĵܰ���                                                                                                                                                                     
�� ���α׷�ID   : FMR00101V_T001.jsp                                                                                                                                                                    
�� ���α׷���   : �����Ǹ�� �� �������� ��ȸ-�����Ǹ���Ʈ��ȸ                                                                                                                                                 
�� �ۼ�����     : 2008.02.20                                                                                                                                                                            
�� �ۼ���       : ������                                                                                                                                                                                
�� �̷°���     : 2008.02.20                                                                                                                                                                            
-----------------------------------------------------------------------------*/                                                                                                                         
%>                                                                                                                                                                                                      
                                                                                                                                                                    
<%@ page contentType="text/html; charset=EUC-KR" %>                                                                                                                                                     
<%@ include file = "../../sc/main/common.jsp" %>                                                                                                                                                        
<%           
	try {
		PlatformRequest platformRequest = this.proc_input(request);                                                                                                                                           
		in_vl = platformRequest.getData().getVariableList();                                                                                                                                                            
		in_dl = platformRequest.getData().getDataSetList();
		
		//jsp log ���� ���� 
		logger.startIndividualLog(in_vl.getString("titLogId"));
	                                                                                                                                                                                                        
		//�Է� ����Ÿ                                                                                                                                                                                         
		DataSet ds_input     = in_dl.get("ds_input");                                                                                                                                                  
	                                                                                                                                                                                                        
		//FileLog.println("d:\\aaa.txt", ds_cond);                                                                                                                                                            
		                                                                                                                                                                                                      
	  	String strSType 			= nullToBlank(ds_input.getString(0, "STYPE"));                                                                                                                                                                                                        
		String strUpjang 			= nullToBlank(ds_input.getString(0, "UPJANG"));                                                                                                                           
		String strHallClass			= nullToBlank(ds_input.getString(0, "HALL_CLASS"));                                                                                                                          
		String strRecipeClass		= nullToBlank(ds_input.getString(0, "RECIPE_CLASS"));
		String strRecipeType		= nullToBlank(ds_input.getString(0, "RECIPE_TYPE"));
		String strCuisineType		= nullToBlank(ds_input.getString(0, "CUISINE_TYPE"));
		String strRecipeName		= nullToBlank(ds_input.getString(0, "RECIPE_NAME"));
		String strMstRecipeName		= nullToBlank(ds_input.getString(0, "MST_RECIPE_NAME"));
                                                                                                                                                                                                        
                                                                                                                                                                                                     
		//out ����Ÿ                                                                                                                                                                                        
		DataSet ds_list;                                                                                                                                                                                    
		                                                                                                                                                                                                    
		//sql�� ���ۻ���                                                                                                                                                                                    
		StringBuffer sbSql = new StringBuffer();                                                                                                                                                            
         
		if (strSType.equals("1"))
		{
			// ǥ�ط�����                                                                                                                                                                       
			sbSql.delete(0, sbSql.length()); 	
			sbSql.append("SELECT   A.RECIPE_CD \n");
			sbSql.append("       , A.RECIPE_NAME \n");
			sbSql.append("       , A.RECIPE_CLASS \n");
			sbSql.append("       , (SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE ='FS0001'AND CODE = A.RECIPE_CLASS) AS RECIPE_CLASS_NM \n");
			sbSql.append("       , B.ITEM_CODE \n");
			sbSql.append("       , C.ITEM_NAME \n");
			sbSql.append("       , ITEM_SEQ \n");
			sbSql.append("       , NEED_QTY \n");
			sbSql.append("  FROM FMR_STD_RECIPE_MST A \n");
			sbSql.append("       , FMR_STD_RECIPE_ITEM B \n");
			sbSql.append("       ,( \n");
			sbSql.append("       SELECT ITEM_CODE, \n");
			sbSql.append("              ITEM_NAME, \n");
			sbSql.append("              ITEM_SIZE, \n");
			sbSql.append("              PO_UOM, \n");
			sbSql.append("              KG_CONVERT_RATE \n");
			sbSql.append("         FROM HLDC_PO_ITEM_MST \n");
			sbSql.append("        WHERE ITEM_CLASS1 = 'F' \n");
			sbSql.append("       ) C \n");
			sbSql.append(" WHERE A.RECIPE_CD = B.RECIPE_CD \n");
			sbSql.append("   AND B.ITEM_CODE = C.ITEM_CODE \n");
			if (strRecipeClass.length() != 0) sbSql.append("   AND RECIPE_CLASS = '" + strRecipeClass + "' \n");
			if (strRecipeType.length() != 0) sbSql.append("   AND RECIPE_TYPE = '" + strRecipeType + "' \n");
			if (strCuisineType.length() != 0) sbSql.append("   AND CUISINE_TYPE = '" + strCuisineType + "' \n");
			if (strRecipeName.length() != 0) sbSql.append("   AND RECIPE_NAME LIKE '%' || '" + strRecipeName + "' || '%' \n");
			sbSql.append("   AND A.RECIPE_NAME = '" + strMstRecipeName + "' \n");
			sbSql.append("ORDER BY RECIPE_CLASS,RECIPE_CD,ITEM_SEQ,ITEM_CODE \n");
		}
		else
		{
			// ����ǥ�ط�����
			sbSql.delete(0, sbSql.length()); 
			sbSql.append("SELECT   A.RECIPE_CD \n");
			sbSql.append("       , A.RECIPE_NAME \n");
			sbSql.append("       , A.RECIPE_CLASS \n");
			sbSql.append("       , (SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE ='FS0001'AND CODE = A.RECIPE_CLASS) AS RECIPE_CLASS_NM \n");
			sbSql.append("       , B.ITEM_CODE \n");
			sbSql.append("       , C.ITEM_NAME \n");
			sbSql.append("       , ITEM_SEQ \n");
			sbSql.append("       , NEED_QTY \n");
			sbSql.append("  FROM FSR_UPJANG_RECIPE_MST A \n");
			sbSql.append("       , FSR_UPJANG_RECIPE_ITEM B \n");
			sbSql.append("       ,( \n");
			sbSql.append("       SELECT ITEM_CODE, \n");
			sbSql.append("              ITEM_NAME, \n");
			sbSql.append("              ITEM_SIZE, \n");
			sbSql.append("              PO_UOM, \n");
			sbSql.append("              KG_CONVERT_RATE \n");
			sbSql.append("         FROM HLDC_PO_ITEM_MST \n");
			sbSql.append("        WHERE ITEM_CLASS1 = 'F' \n");
			sbSql.append("       ) C \n");
			sbSql.append(" WHERE A.UPJANG = " + strUpjang + " \n");
			sbSql.append("   AND A.HALL_CLASS = '" + strHallClass + "' \n");
			sbSql.append("   AND A.UPJANG = B.UPJANG \n");
			sbSql.append("   AND A.HALL_CLASS = B.HALL_CLASS \n");
			sbSql.append("   AND A.RECIPE_CD = B.RECIPE_CD \n");
			sbSql.append("   AND B.ITEM_CODE = C.ITEM_CODE \n");
			if (strRecipeClass.length() != 0) sbSql.append("   AND RECIPE_CLASS = '" + strRecipeClass + "' \n");
			if (strRecipeType.length() != 0) sbSql.append("   AND RECIPE_TYPE = '" + strRecipeType + "' \n");
			if (strCuisineType.length() != 0) sbSql.append("   AND CUISINE_TYPE = '" + strCuisineType + "' \n");
			if (strRecipeName.length() != 0) sbSql.append("   AND RECIPE_NAME LIKE '%' || '" + strRecipeName + "' || '%' \n");
			sbSql.append("   AND A.RECIPE_NAME = '" + strMstRecipeName + "' \n");
			sbSql.append("ORDER BY RECIPE_CLASS,RECIPE_CD,ITEM_SEQ,ITEM_CODE \n");
		}
		
		//System.out.println(sbSql.toString());                                                                                                                                                             
		pstmt = conn.prepareStatement(sbSql.toString());		                                                                                                                                                
		rs = pstmt.executeQuery();                                                                                                                                                                          
		DataSet ds_list2 = this.makeDataSet(rs, "ds_list");  
		
		rs.close();
		pstmt.close();
                                                                                                                                                                                                        
		/**����**/                                                                                                                                                                                          
		out_dl.add(ds_list2);                                                                                                                                                          
		this.setResultMessage(0, "OK", out_vl);                                                                                                                                                             
                                                                                                                                                                                                        
	}                                                                                                                                                                                                     
	catch(Exception ex)                                                                                                                                                                                   
	{                                                                                                                                                                                                     
		//ex.printStackTrace();
		//jsp �α׳����
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
		
		//jsp log ���� �ݱ� 
		try {
			logger.endIndividualLog();
		} catch( Exception logE) {
			logE.printStackTrace();
		}
	}                                                                                                                                                                                                     
                                                                                                                                                                                                        
	proc_output(response,out,out_vl,out_dl);                                                                                                                                                              
                                                                                                                                                                                                        
%>