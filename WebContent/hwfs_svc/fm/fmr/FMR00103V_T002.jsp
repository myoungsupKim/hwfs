<%                                                                                                                                                                                                      
/*-----------------------------------------------------------------------------                                                                                                                         
�� �ý��۸�     : �޴�����/�Ĵܰ���                                                                                                                                                                     
�� ���α׷�ID   : FSR00103V_T002.jsp                                                                                                                                                                    
�� ���α׷���   : �����Ǹ�� �� �������� ��ȸ-�����Ǹ��(��):������                                                                                                                                                 
�� �ۼ�����     : 2008.02.21                                                                                                                                                                            
�� �ۼ���       : ������                                                                                                                                                                                
�� �̷°���     : 2008.02.21                                                                                                                                                                            
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
	  	String strMstRecipeCD 		= nullToBlank(ds_input.getString(0, "MST_RECIPE_CD"));                                                                                                                                                                                                        
                                                                                                                                                                                                        
                                                                                                                                                                                                     
		//out ����Ÿ                                                                                                                                                                                        
		DataSet ds_list;                                                                                                                                                                                    
		                                                                                                                                                                                                    
		//sql�� ���ۻ���                                                                                                                                                                                    
		StringBuffer sbSql = new StringBuffer();                                                                                                                                                            
         
		if (strSType.equals("1"))
		{
			// ǥ�ط�����                                                                                                                                                                       
			sbSql.delete(0, sbSql.length()); 	
			sbSql.append("SELECT RECIPE_CD \n");
			sbSql.append("     , CUISINE_SEQ \n");
			sbSql.append("     , CUISINE_DESC \n");
			sbSql.append("  FROM FMR_STD_RECIPE_CUISINE \n");
			sbSql.append(" WHERE RECIPE_CD = '" + strMstRecipeCD + "' \n");
			sbSql.append("ORDER BY CUISINE_SEQ \n");
		}
		else
		{
			// ����ǥ�ط�����
			sbSql.delete(0, sbSql.length()); 
			sbSql.append("SELECT RECIPE_CD \n");
			sbSql.append("     , CUISINE_SEQ \n");
			sbSql.append("     , CUISINE_DESC \n");
			sbSql.append("  FROM FSR_UPJANG_RECIPE_CUISINE \n");
			sbSql.append(" WHERE UPJANG = " + strUpjang + " \n");
			sbSql.append("   AND HALL_CLASS = '" + strHallClass + "' \n");
			sbSql.append("   AND RECIPE_CD = '" + strMstRecipeCD + "' \n");
			sbSql.append("ORDER BY CUISINE_SEQ \n");
			
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