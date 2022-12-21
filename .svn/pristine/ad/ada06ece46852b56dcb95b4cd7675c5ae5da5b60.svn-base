<%                                                                                                                                                                                                      
/*-----------------------------------------------------------------------------                                                                                                                         
■ 시스템명     : 위생관리/테스트관리                                                                                                                                                                     
■ 프로그램ID   : FSC91010E_T002.jsp                                                                                                                                                                    
■ 프로그램명   : 테스트관리                                                                                                                                                 
■ 작성일자     : 2019-07-04                                                                                                                                                                            
■ 작성자       : 김명섭                                                                                                                                                                                
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
	                                                                                                                                                                                                        
	  	String strTestType		= nullToBlank(ds_input.getString(0, "TEST_TYPE"));
	  	String strFormCD 		= nullToBlank(ds_input.getString(0, "FORM_CD"));
                                                                                                                                                                                                        
                                                                                                                                                                                                     
		//out 데이타                                                                                                                                                                                        
		DataSet ds_Detail1;
		                                                                                                                                                                                                    
		//sql문 버퍼생성                                                                                                                                                                                    
		StringBuffer sbSql = new StringBuffer();                                                                                                                                                            
         
		// 분류조회
		sbSql.delete(0, sbSql.length());
		sbSql.append("SELECT TEST_TYPE \n");
		sbSql.append("     , FORM_CD \n");
		sbSql.append("     , SEQ \n");
		sbSql.append("     , TEST \n");
		sbSql.append("     , EXAMPLE1 \n");
		sbSql.append("     , EXAMPLE2 \n");
		sbSql.append("     , EXAMPLE3 \n");
		sbSql.append("     , EXAMPLE4 \n");
		sbSql.append("     , APPEND_FILENM \n");
		sbSql.append("     , SERVER_FILENM \n");
		sbSql.append("     , DISTRIBUTION \n");
		sbSql.append("     , ANSWER \n");
		sbSql.append("     , '' AS IMG_FILE \n");
		sbSql.append("     , '' AS ISUPLOAD \n");
		sbSql.append("  FROM FSC_TEST_FORM_DTL \n");
		sbSql.append(" WHERE TEST_TYPE = '" + strTestType + "' \n");
		sbSql.append("   AND FORM_CD = '" + strFormCD + "' \n");
		sbSql.append("ORDER BY TEST_TYPE, FORM_CD, SEQ \n");
		
		//System.out.println(sbSql.toString());                                                                                                                                                             
		pstmt = conn.prepareStatement(sbSql.toString());		                                                                                                                                                
		rs = pstmt.executeQuery();                                                                                                                                                                          
		ds_Detail1 = this.makeDataSet(rs, "ds_Detail1"); 
		
		rs.close();
		pstmt.close();
                                                                                                                                                                                                        
		/**종료**/                                                                                                                                                                                          
		out_dl.add(ds_Detail1); 
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