<%                                                                                                                                                                                                      
/*-----------------------------------------------------------------------------                                                                                                                         
■ 시스템명     : 메뉴관리/위생관리                                                                                                                                                                     
■ 프로그램ID   : FSC00022P_T001.jsp                                                                                                                                                                    
■ 프로그램명   : 정검결과등록 - 사진리스트조회                                                                                                                                               
■ 작성일자     : 2008-03-21                                                                                                                                                                            
■ 작성자       : 박지영                                                                                                                                                                                
■ 이력관리     : 2008-03-21                                                                                                                                                                            
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
	                                                                                                                                                                                                        
	
		String strTableType 	= nullToBlank(ds_input.getString(0, "TABLE_TYPE"));
		String strFormCD 		= nullToBlank(ds_input.getString(0, "FORM_CD"));
		String strUpjang 		= nullToBlank(ds_input.getString(0, "MST_UPJANG"));
		String strCheckDate 	= nullToBlank(ds_input.getString(0, "CHECK_DATE"));
                                                                                                                                                                                                        
                                                                                                                                                                                                     
		//out 데이타                                                                                                                                                                                        
		DataSet ds_list;                                                                                                                                                                                    
		                                                                                                                                                                                                    
		//sql문 버퍼생성                                                                                                                                                                                    
		StringBuffer sbSql = new StringBuffer();                                                                                                                                                            
         
		// 사진리스트조회
		sbSql.delete(0, sbSql.length());
		sbSql.append("SELECT TABLE_TYPE \n");
		sbSql.append("     , FORM_CD \n");
		sbSql.append("     , UPJANG \n");
		sbSql.append("     , CHECK_DATE \n");
		sbSql.append("     , CLASS_CD \n");
		sbSql.append("     , SUBSTR(CLASS_CD,0,2) || '000000' AS LRG_CLASS_CD \n");
		sbSql.append("     , SUBSTR(CLASS_CD,0,5) || '000' AS MIDDLE_CLASS_CD \n");
		sbSql.append("     , SEQ \n");
		sbSql.append("     , PHOTO_TYPE \n");
		sbSql.append("     , '' PHOTO_URL \n");
		sbSql.append("     , PHOTO \n");
		sbSql.append("     , SPHOTO \n");
		sbSql.append("  FROM FSC_SAFE_CHK_IMGE \n");
		sbSql.append(" WHERE TABLE_TYPE = '" + strTableType + "' \n");
		sbSql.append("   AND FORM_CD = '" + strFormCD + "' \n");
		sbSql.append("   AND UPJANG = " + strUpjang + " \n");
		sbSql.append("   AND CHK_DD = '" + strCheckDate + "' \n");
		
		//=========================================================================================
		// (2013-08-06 추가) 시작
		// 김장욱 2013-08-06 FC 식품연구소 이재우 매니저 
		// 점검결과의 지적항목 사진에 대응하는 개선사항 사진을 1:1로 첨부 할수 있게 변경.
		//=========================================================================================			
		sbSql.append("   AND INPT_GUBUN = 'IN' \n");
		//=========================================================================================
		// (2013-08-06 추가) 끝
		//=========================================================================================			
		sbSql.append(" ORDER BY SEQ \n");
		
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