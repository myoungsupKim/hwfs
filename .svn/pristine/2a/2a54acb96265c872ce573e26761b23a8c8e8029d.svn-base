<%                                                                                                                                                                                                      
/*-----------------------------------------------------------------------------                                                                                                                         
■ 시스템명     : 메뉴관리/위생관리                                                                                                                                                                     
■ 프로그램ID   : FSC00041V_T002.jsp                                                                                                                                                                    
■ 프로그램명   : 분기별 점검결과조회 - 상세                                                                                                                                               
■ 작성일자     : 2008-03-26                                                                                                                                                                            
■ 작성자       : 박지영                                                                                                                                                                                
■ 이력관리     : 2008-03-26                                                                                                                                                                            
■ 이력관리     : 2008-03-31                                                                                                                                                                            
    1)박은규 2012-04-16 CSR#(SR201204_09204) 요청자:김희선(건강관리센터)
	특별점검 여부 추가 : 결과조회/출력에서 평균점수에서 제외
	2)박은규 2012-10-22 CSR#(CH201210_00118) 요청자:홍호준(식품연구소)
	사업장별 누적 점검횟수 표시
	기존 년별 조회에서 기간으로 조회
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
	                                                                                                                                                                                                        
		String strTableType			= nullToBlank(ds_input.getString(0, "TABLE_TYPE")); 
		//============================================================================================
		//(2012-10-22 수정) 시작
		// 박은규 2012-10-22 CSR#(CH201210_00118) 요청자:홍호준(식품연구소)
		// 년도조회에서 기간조회로 변경
		//============================================================================================
		//String strYear				= nullToBlank(ds_input.getString(0, "YEAR"));
		String strFromDate      = nullToBlank(ds_input.getString(0, "FROM_DATE"));
		String strToDate        = nullToBlank(ds_input.getString(0, "TO_DATE"));
		//============================================================================================
		//(2012-10-22 수정) 끝
		//============================================================================================
	  	String strCheckType			= nullToBlank(ds_input.getString(0, "CHECK_TYPE"));
	  	String strTmCD				= nullToBlank(ds_input.getString(0, "MST_TM_CD"));
	  	String strTeamMstSabun		= nullToBlank(ds_input.getString(0, "MST_TEAM_MST_SABUN"));
	  	String strSubteamMstSabun	= nullToBlank(ds_input.getString(0, "MST_SUBTEAM_MST_SABUN"));
                                                                                                                                                                                                        
                                                                                                                                                                                                     
		//out 데이타                                                                                                                                                                                        
		DataSet ds_list;                                                                                                                                                                                    
		                                                                                                                                                                                                    
		//sql문 버퍼생성                                                                                                                                                                                    
		StringBuffer sbSql = new StringBuffer();                                                                                                                                                            
         
		sbSql.delete(0, sbSql.length());
		sbSql.append("SELECT B.JOB_CD \n");
		sbSql.append("     , B.JOB_NAME \n");
		sbSql.append("     , B.SUB_JOB_CD \n");
		sbSql.append("     , B.SUB_JOB_NAME \n");
		sbSql.append("     , A.UPJANG \n");
		sbSql.append("     , (SELECT UPJANGNM FROM HLDC_ST_UPJANG WHERE A.UPJANG = UPJANG) AS UPJANGNM \n");
		sbSql.append("     , SUBSTR(CHECK_DATE,1,6) AS CHECK_DATE \n");
		//============================================================================================
		//(2012-04-16 수정) 시작
		// 박은규 2012-04-16 CSR#(SR201204_09204) 요청자:김희선(건강관리센터)
		// 특별점검 여부 추가 : 결과조회/출력에서 평균점수에서 제외
		//============================================================================================
/*
		sbSql.append("     , ROUND(AVG(SCORE),1) AS SCORE \n");
		sbSql.append("     , CASE WHEN ROUND(AVG(SCORE),1) >= 90 THEN 'A' \n");
		sbSql.append("	        WHEN ROUND(AVG(SCORE),1) >= 80 THEN 'B' \n");
		sbSql.append("	        WHEN ROUND(AVG(SCORE),1) >= 70 THEN 'C' \n");
		sbSql.append("		    WHEN ROUND(AVG(SCORE),1) >= 60 THEN 'D' \n");
		sbSql.append("	        ELSE 'E' \n");
		sbSql.append("	     END GRADE \n");
		sbSql.append("     , SUM(SCORE) AS TOT_SCORE \n");
		sbSql.append("     , COUNT(*) AS CNT \n");
*/
		sbSql.append("     , ROUND(AVG(DECODE(C.SET1,'Y',NULL,SCORE)),1) AS SCORE \n");
		sbSql.append("     , CASE WHEN ROUND(AVG(DECODE(C.SET1,'Y',NULL,SCORE)),1) >= 90 THEN 'A' \n");
		sbSql.append("	        WHEN ROUND(AVG(DECODE(C.SET1,'Y',NULL,SCORE)),1) >= 80 THEN 'B' \n");
		sbSql.append("	        WHEN ROUND(AVG(DECODE(C.SET1,'Y',NULL,SCORE)),1) >= 70 THEN 'C' \n");
		sbSql.append("		    WHEN ROUND(AVG(DECODE(C.SET1,'Y',NULL,SCORE)),1) >= 60 THEN 'D' \n");
		sbSql.append("	        ELSE 'E' \n");
		sbSql.append("	     END GRADE \n");
		sbSql.append("     , SUM(DECODE(C.SET1,'Y',0,SCORE)) AS TOT_SCORE \n");
		sbSql.append("     , SUM(DECODE(C.SET1,'Y',0,1)) AS RST_CNT \n");
		//============================================================================================
		//(2012-10-22 추가) 시작
		// 박은규 2012-10-22 CSR#(CH201210_00118) 요청자:홍호준(식품연구소)
		// 사업장별 누적 점검횟수 표시
		//============================================================================================
		sbSql.append("     , COUNT(1) AS CNT \n");
		//============================================================================================
		//(2012-10-22 추가) 끝
		//============================================================================================
		//============================================================================================
		//(2012-04-16 수정) 끝
		//============================================================================================
		sbSql.append("     , SUM(NOT_FIT_YN) AS NOT_FIT \n");
		sbSql.append("  FROM FSC_SAFE_RESULT_MST A \n");
		sbSql.append("     , MAC_UPJANG_V B \n");
		sbSql.append("     , (SELECT Z.CODE, Z.SET1 FROM SCC_COMMON_CODE Z WHERE Z.GROUP_CODE = 'FS0042') C \n");
		sbSql.append(" WHERE A.UPJANG = B.UPJANG \n");
		sbSql.append("   AND A.CHECK_TYPE = C.CODE \n");
		sbSql.append("   AND A.CONFIRM_YN = 'Y' \n");
		if (! strTableType.equals(""))
			sbSql.append("   AND A.TABLE_TYPE = '" + strTableType + "' \n");
		//============================================================================================
		//(2012-10-22 수정) 시작
		// 박은규 2012-10-22 CSR#(CH201210_00118) 요청자:홍호준(식품연구소)
		// 년도조회에서 기간조회로 변경
		//============================================================================================
		//sbSql.append("   AND SUBSTR(A.CHECK_DATE,1,4) = '" + strYear + "' \n");
		sbSql.append("   AND A.CHECK_DATE BETWEEN '" + strFromDate + "' AND '" + strToDate + "' \n");
		//============================================================================================
		//(2012-10-22 수정) 끝
		//============================================================================================
		sbSql.append("   AND A.CHECK_TYPE IN (" + strCheckType + ") \n");
		if (strTmCD.length() != 0)				sbSql.append("   AND A.TM_CD = '" + strTmCD + "' \n");
		if (strTeamMstSabun.length() != 0)		sbSql.append("   AND A.TEAM_MST_SABUN = '" + strTeamMstSabun + "' \n");
		if (strSubteamMstSabun.length() != 0)	sbSql.append("   AND A.SUBTEAM_MST_SABUN = '" + strSubteamMstSabun + "' \n");
		
		sbSql.append(" GROUP BY B.JOB_CD, B.JOB_NAME, B.SUB_JOB_CD, B.SUB_JOB_NAME, A.UPJANG, SUBSTR(CHECK_DATE,1,6) \n");
		sbSql.append(" ORDER BY B.JOB_CD, B.SUB_JOB_CD, A.UPJANG \n");
		
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