<%                                                                                                                                                                                                      
/*-----------------------------------------------------------------------------                                                                                                                         
■ 시스템명     : 메뉴관리/위생관리                                                                                                                                                                     
■ 프로그램ID   : FSC00020E_T003.jsp                                                                                                                                                                    
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
		sbSql.append("     , A.MARK_4 \n");
		sbSql.append("     , A.MINUS_YN \n");
		sbSql.append("     , A.NOT_FIT_YN \n");
		sbSql.append("     , B.UPJANG \n");
		sbSql.append("     , B.CHECK_DATE \n");
		sbSql.append("     , B.MARK \n");
		sbSql.append("     , B.INDICATE_CNT \n");
		sbSql.append("     , B.NOT_FIT_CNT \n");
		sbSql.append("     , B.EVAL_CONTENTS \n");
		//sbSql.append("     , DECODE(B.MARK,A.MARK_1,'1',A.MARK_2,'2',A.MARK_3,'3',A.MARK_4,'4','') AS CHK \n");
		//아직 체크안한 경우(B.MARK=null) 배점이 없는 첫번째 항목에(A.MARK=null) 체크된 것처럼 보인다. 
		sbSql.append("     , DECODE(B.MARK, NULL, NULL, A.MARK_1, '1', A.MARK_2, '2', A.MARK_3, '3', A.MARK_4, '4', '') AS CHK \n");
		//sbSql.append("     , DECODE(A.MINUS_YN,'Y',B.MARK * NVL(B.INDICATE_CNT,0),B.MARK) AS CHK_POINT \n");
		sbSql.append("     , B.SCORE AS CHK_POINT \n");
		sbSql.append("     , GREATEST(NVL(A.MARK_1,-999), NVL(A.MARK_2,-999), NVL(A.MARK_3,-999), NVL(A.MARK_4,-999)) MAX_MARK \n");
		sbSql.append("     , LEAST(NVL(A.MARK_1,999), NVL(A.MARK_2,999), NVL(A.MARK_3,999), NVL(A.MARK_4,999)) MIN_MARK \n");
		sbSql.append("     , B.MAX_YN \n");
		sbSql.append("     , SIMPROV_PHOTO \n");
        sbSql.append("     , (SELECT COUNT(1)                              \n");
        sbSql.append("          FROM FSC_SAFE_CHK_IMGE                          \n");
        sbSql.append("         WHERE TABLE_TYPE = B.TABLE_TYPE             \n");
        sbSql.append("           AND FORM_CD = B.FORM_CD                   \n");
        sbSql.append("           AND UPJANG = B.UPJANG                     \n");
        sbSql.append("           AND CHK_DD = B.CHECK_DATE                 \n");
        sbSql.append("           AND CLASS_CD = B.CLASS_CD) AS IMGE_CNT    \n");    
		sbSql.append("  FROM FSC_SAFE_FORM_DTL A \n");
		sbSql.append("     , FSC_SAFE_RESULT_DTL B \n");
		sbSql.append(" WHERE A.TABLE_TYPE = B.TABLE_TYPE \n");
		sbSql.append("   AND A.FORM_CD = B.FORM_CD \n");
		sbSql.append("   AND A.CLASS_CD = B.CLASS_CD \n");
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