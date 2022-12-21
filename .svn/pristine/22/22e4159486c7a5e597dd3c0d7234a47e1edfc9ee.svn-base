<%                                                                                                                                                                                                      
/*-----------------------------------------------------------------------------                                                                                                                         
■ 시스템명     : 메뉴관리/위생관리                                                                                                                                                                     
■ 프로그램ID   : FSC00060V_T001.jsp                                                                                                                                                                    
■ 프로그램명   : 점검자별 점검결과 조회                                                                                                                                               
■ 작성일자     : 2008-03-26                                                                                                                                                                            
■ 작성자       : 박지영                                                                                                                                                                                
■ 이력관리     : 2008-03-26                                                                                                                                                                            
: 박은규 2012-04-16 CSR#(SR201204_09204) 요청자:김희선(건강관리센터)
특별점검 여부 추가 : 결과조회/출력에서 평균점수에서 제외
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
		String strFromDt		= nullToBlank(ds_input.getString(0, "FROM_DT"));
	  	String strToDt 			= nullToBlank(ds_input.getString(0, "TO_DT")); 
	  	String strCheckType		= nullToBlank(ds_input.getString(0, "CHECK_TYPE"));
	  	String strCheckSabun	= nullToBlank(ds_input.getString(0, "CHECK_SABUN"));
                                                                                                                                                                                                        
                                                                                                                                                                                                     
		//out 데이타                                                                                                                                                                                        
		DataSet ds_list;                                                                                                                                                                                    
		                                                                                                                                                                                                    
		//sql문 버퍼생성                                                                                                                                                                                    
		StringBuffer sbSql = new StringBuffer();                                                                                                                                                            
         
		sbSql.delete(0, sbSql.length());
		sbSql.append("SELECT A.CHECK_SABUN \n");
		sbSql.append("     , (SELECT NM_KOR FROM SCO_FS_HR_PERSONAL_V WHERE A.CHECK_SABUN = SABUN) AS CHECK_SABUN_NM \n");
		sbSql.append("     , COUNT(DISTINCT A.UPJANG) AS UPJANG_CNT \n");
		sbSql.append("     , COUNT(*) AS CHECK_CNT \n");
		//============================================================================================
		//(2012-04-16 수정) 시작
		// 박은규 2012-04-16 CSR#(SR201204_09204) 요청자:김희선(건강관리센터)
		// 특별점검 여부 추가 : 결과조회/출력에서 평균점수에서 제외
		//============================================================================================
//		sbSql.append("     , ROUND(AVG(A.SCORE),1) AS AVG_SCORE \n");
		sbSql.append("     , ROUND(AVG(DECODE(C.SET1,'Y',NULL,A.SCORE)),1) AS AVG_SCORE \n");
		//============================================================================================
		//(2012-04-16 수정) 끝
		//============================================================================================
		sbSql.append("     , SUM(NOT_FIT_YN) AS NOT_FIT_TOT_CNT \n");
		sbSql.append("     , ROUND(SUM(NOT_FIT_YN)/COUNT(*) * 100,1) AS NOT_FIT_RATE \n");
		sbSql.append("  FROM FSC_SAFE_RESULT_MST A \n");
		sbSql.append("     , (SELECT Z.CODE, Z.SET1 FROM SCC_COMMON_CODE Z WHERE Z.GROUP_CODE = 'FS0042') C \n");
		sbSql.append(" WHERE A.CHECK_TYPE = C.CODE \n");
		sbSql.append("   AND A.CONFIRM_YN = 'Y' \n");
		if (strTableType.length() != 0)
			sbSql.append("   AND A.TABLE_TYPE = '" + strTableType + "' \n");
		sbSql.append("   AND A.CHECK_DATE BETWEEN '" + strFromDt + "' AND '" + strToDt + "' \n");
		sbSql.append("   AND A.CHECK_TYPE IN (" + strCheckType + ") \n");
		if (strCheckSabun.length() != 0)	sbSql.append("   AND A.CHECK_SABUN = '" + strCheckSabun + "' \n");
		sbSql.append(" GROUP BY A.CHECK_SABUN \n");
		
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