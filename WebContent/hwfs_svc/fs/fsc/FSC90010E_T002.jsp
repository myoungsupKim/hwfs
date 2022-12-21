<%                                                                                                                                                                                                      
/*-----------------------------------------------------------------------------                                                                                                                         
■ 시스템명     : 메뉴관리/위생관리                                                                                                                                                                     
■ 프로그램ID   : FSC00010E_T002.jsp                                                                                                                                                                    
■ 프로그램명   : 점검양식관리                                                                                                                                                 
■ 작성일자     : 2008-03-18                                                                                                                                                                            
■ 작성자       : 박지영                                                                                                                                                                                
■ 이력관리     : 2008-03-18                                                                                                                                                                            
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
	                                                                                                                                                                                                        
	  	String strTableType		= nullToBlank(ds_input.getString(0, "TABLE_TYPE"));
	  	String strFormCD 		= nullToBlank(ds_input.getString(0, "FORM_CD"));
                                                                                                                                                                                                        
                                                                                                                                                                                                     
		//out 데이타                                                                                                                                                                                        
		DataSet ds_list;
		                                                                                                                                                                                                    
		//sql문 버퍼생성                                                                                                                                                                                    
		StringBuffer sbSql = new StringBuffer();                                                                                                                                                            
         
		// 분류조회
		sbSql.delete(0, sbSql.length());
		sbSql.append("SELECT A.TABLE_TYPE \n");
		sbSql.append("     , A.FORM_CD \n");
		sbSql.append("     , A.CLASS_CD \n");
		sbSql.append("     , A.CLASS_NAME \n");
		sbSql.append("     , A.CLASS_TYPE \n");
		sbSql.append("     , B.LRG_CLASS_CD \n");
		sbSql.append("     , B.LRG_CLASS_NAME \n");
		sbSql.append("     , B.MIDDLE_CLASS_CD \n");
		sbSql.append("     , B.MIDDLE_CLASS_NAME \n");
		sbSql.append("     , B.MARK_1 \n");
		sbSql.append("     , B.MARK_2 \n");
		sbSql.append("     , B.MARK_3 \n");
		sbSql.append("     , B.MARK_4 \n");
		sbSql.append("     , DECODE(B.MINUS_YN,'Y',1,0) AS MINUS_YN \n");
		sbSql.append("     , DECODE(B.NOT_FIT_YN,'Y',1,0) AS NOT_FIT_YN \n");
		sbSql.append("     , DECODE(A.CLASS_TYPE,'S',TO_CHAR(B.UDATE,'YYYY.MM.DD'),TO_CHAR(A.UDATE,'YYYY.MM.DD')) AS UDATE \n");
		sbSql.append("     , SCC_YN_FUN(A.MNGM_FLAG,'S') AS MNGM_FLAG, A.MNGM_CNT \n");
		sbSql.append("  FROM FSC_SAFE_CLASS_MST A \n");
		sbSql.append("     , FSC_SAFE_FORM_DTL B \n");
		sbSql.append(" WHERE A.TABLE_TYPE = B.TABLE_TYPE(+) \n");
		sbSql.append("   AND A.FORM_CD = B.FORM_CD(+) \n");
		sbSql.append("   AND A.CLASS_CD =B.CLASS_CD(+) \n");
		sbSql.append("   AND A.TABLE_TYPE = '" + strTableType + "' \n");
		sbSql.append("   AND A.FORM_CD = '" + strFormCD + "' \n");
		sbSql.append("ORDER BY A.TABLE_TYPE,A.FORM_CD,A.CLASS_CD \n");
		
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