<%                                                                                                                                                                                                      
/*-----------------------------------------------------------------------------                                                                                                                         
■ 시스템명     : 메뉴관리/위생관리                                                                                                                                                                     
■ 프로그램ID   : FSC00020E_T001.jsp                                                                                                                                                                    
■ 프로그램명   : 정검결과등록 - 평가항목리스트                                                                                                                                               
■ 작성일자     : 2008-03-20                                                                                                                                                                            
■ 작성자       : 박지영                                                                                                                                                                                
■ 이력관리     : 2008-03-20                                                                                                                                                                            
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
		String strUpjang 		= nullToBlank(ds_input.getString(0, "MST_UPJANG"));
		String strCheckDate 	= nullToBlank(ds_input.getString(0, "CHECK_DATE"));
                                                                                                                                                                                                        
                                                                                                                                                                                                     
		//out 데이타                                                                                                                                                                                        
		DataSet ds_list;                                                                                                                                                                                    
		                                                                                                                                                                                                    
		//sql문 버퍼생성                                                                                                                                                                                    
		StringBuffer sbSql = new StringBuffer();                                                                                                                                                            
         
		// 정검양식조회
		sbSql.delete(0, sbSql.length());
		sbSql.append("SELECT A.TABLE_TYPE \n");
		sbSql.append("     , A.FORM_CD \n");
		sbSql.append("     , A.CLASS_CD \n");
		sbSql.append("     , A.LRG_CLASS_CD \n");
		sbSql.append("     , A.LRG_CLASS_NAME \n");
		sbSql.append("     , A.MIDDLE_CLASS_CD \n");
		sbSql.append("     , A.MIDDLE_CLASS_NAME \n");
		sbSql.append("     , A.CLASS_NAME \n");
		sbSql.append("     , A.MARK_1 \n");
		sbSql.append("     , A.MARK_2 \n");
		sbSql.append("     , A.MARK_3 \n");
		sbSql.append("     , A.MINUS_YN \n");
		sbSql.append("     , A.NOT_FIT_YN \n");
		sbSql.append("     , B.UPJANG \n");
		sbSql.append("     , B.CHECK_DATE \n");
		sbSql.append("     , B.MARK \n");
		sbSql.append("     , B.INDICATE_CNT \n");
		sbSql.append("     , B.NOT_FIT_CNT \n");
		sbSql.append("     , B.EVAL_CONTENTS \n");
		sbSql.append("     , B.MAX_YN \n");
		sbSql.append("     , B.INDICATE_PHOTO \n");
		sbSql.append("     , B.SINDICATE_PHOTO \n");
		sbSql.append("     , B.IMPROV_MGMT \n");
		sbSql.append("     , B.MGMT_DATE \n");
		sbSql.append("     , B.IMPROV_PHOTO \n");
		sbSql.append("     , B.SIMPROV_PHOTO \n");
		sbSql.append("     , '' AS PHOTO_URL \n");
		sbSql.append("     , ( SELECT COUNT(*) \n");
		sbSql.append("           FROM FSC_CHK_IMGE \n");
		sbSql.append("          WHERE TABLE_TYPE = B.TABLE_TYPE \n");
		sbSql.append("            AND FORM_CD = B.FORM_CD \n");
		sbSql.append("            AND UPJANG = B.UPJANG \n");
		sbSql.append("            AND CHK_DD = B.CHECK_DATE \n");
		sbSql.append("            AND CLASS_CD = B.CLASS_CD \n");
		sbSql.append("       ) AS IMGE_CNT \n");
		sbSql.append("  FROM FSC_FORM_DTL A \n");
		sbSql.append("     , FSC_RESULT_DTL B \n");
		sbSql.append(" WHERE A.TABLE_TYPE = B.TABLE_TYPE \n");
		sbSql.append("   AND A.FORM_CD = B.FORM_CD \n");
		sbSql.append("   AND A.CLASS_CD = B.CLASS_CD \n");
		//sbSql.append("   AND B.MAX_YN = 'N' \n");
		//최고점이 아닌 배점을 받은 항목 OR 부적합관리 소분류항목 중 지적체크된 항목
		sbSql.append("   AND (B.MAX_YN = 'N' OR (A.NOT_FIT_YN = 'Y' AND NVL(B.INDICATE_CNT,0) > 0)) \n");
		sbSql.append("   AND A.TABLE_TYPE = '" + strTableType + "' \n");
		sbSql.append("   AND A.FORM_CD = '" + strFormCD + "' \n");
		sbSql.append("   AND B.UPJANG = " + strUpjang + " \n");
		sbSql.append("   AND B.CHECK_DATE = '" + strCheckDate + "' \n");
		sbSql.append(" ORDER BY A.CLASS_CD \n");
		
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