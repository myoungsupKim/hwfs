<%                                                                                                                                                                                                      
/*-----------------------------------------------------------------------------                                                                                                                         
■ 시스템명     :                                                                                                                                                                
■ 프로그램ID  : FSA00090E_S002.jsp                                                                                                                                                                  
■ 프로그램명   : 추가구매 승인 신청                                                                                                                                              
■ 작성일자     : 2008-07-21                                                                                                                                                                        
■ 작성자       : 박지영
■ 수정자       : 정영철
■ 이력관리     : 2015-06-10                                                                                                                                     
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
		DataSet ds_input     = in_dl.get("ds_check_input");  
		
		String strUpjang 	= nullToBlank(ds_input.getString(0, "UPJANG"));                                                                                                                                                                                                        
		String strStartDate	= nullToBlank(ds_input.getString(0, "FROM_DT"));
	  	String strEndDate 	= nullToBlank(ds_input.getString(0, "TO_DT")); 
                                                                                                                                                                                                     
		//out 데이타                                                                                                                                                                                        
		DataSet ds_check;                                                                                                                                                                                    
		                                                                                                                                                                                                    
		//sql문 버퍼생성                                                                                                                                                                                    
		StringBuffer sbSql = new StringBuffer();                                                                                                                                                            
         
		// 중복체크
		sbSql.delete(0, sbSql.length());
		sbSql.append("SELECT UPJANG, START_DATE, END_DATE \n");
		sbSql.append("  FROM FSA_PR_CHECK \n");
		sbSql.append(" WHERE UPJANG     = '" + strUpjang + "' \n");
		sbSql.append("   AND START_DATE <= '" + strEndDate + "' \n");
		sbSql.append("   AND END_DATE   >= '" + strStartDate + "' \n");
		
		pstmt = conn.prepareStatement(sbSql.toString());		                                                                                                                                                
		rs = pstmt.executeQuery();                                                                                                                                                                          
		ds_check = this.makeDataSet(rs, "ds_check"); 
		
		rs.close();
		pstmt.close();
                                                                                                                                                                                                        
		/**종료**/                                                                                                                                                                                          
		out_dl.add(ds_check);                                                                                                                                                          
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