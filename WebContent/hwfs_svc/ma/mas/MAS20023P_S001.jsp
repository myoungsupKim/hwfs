<%                                                                                                                                                                                                      
/*-----------------------------------------------------------------------------                                                                                                                         
■ 시스템명     : 동업계 실적 비교/업장수 및 인력현황                                                                                                                                                                     
■ 프로그램ID   : MAS20023P_S001.jsp                                                                                                                                                                    
■ 프로그램명   : 업장수 및 인력현황                                                                                                                                                 
■ 작성일자     : 2008-06-27                                                                                                                                                                            
■ 작성자       : 박지영                                                                                                                                                                                
■ 이력관리     : 2008-06-27                                                                                                                                                                            
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
		DataSet ds_input	= in_dl.get("ds_input");                                                                                                                                                  
	                                                                                                                                                                                                        
	  	String strYYYY 		= nullToBlank(ds_input.getString(0, "YYYY"));
	  	String strQuater 	= nullToBlank(ds_input.getString(0, "QUATER"));
                                                                                                                                                                                                        
                                                                                                                                                                                                     
		//out 데이타                                                                                                                                                                                        
		DataSet ds_list;                                                                                                                                                                                    
		                                                                                                                                                                                                    
		//sql문 버퍼생성                                                                                                                                                                                    
		StringBuffer sbSql = new StringBuffer();                                                                                                                                                            
         
		sbSql.delete(0, sbSql.length());
		sbSql.append("SELECT A.YYYY \n");
		sbSql.append("     , A.QUATER \n");
		sbSql.append("     , 0 AS SORT_SEQ \n");
		sbSql.append("     , '999' AS ALLY_CD \n");
		sbSql.append("     , '업계평균' AS ALLY_NM \n");
		sbSql.append("     , ROUND(AVG(DECODE(A.UPJANG_CNT,0,NULL,A.UPJANG_CNT))) AS UPJANG_CNT \n");
		sbSql.append("     , ROUND(AVG(DECODE(A.UPJANG_CNT,0,NULL,A.UPJANG_CNT) - (SELECT UPJANG_CNT FROM MAS_EIS_B WHERE YYYY = (A.YYYY -1) AND QUATER = A.QUATER AND ALLY_CD = A.ALLY_CD))) AS UPJANG_CNT2 \n");
		sbSql.append("     , ROUND(AVG(CASE WHEN C.MEAL_AMT + C.HMR_AMT = 0 OR A.UPJANG_CNT = 0 THEN NULL ELSE (C.MEAL_AMT + C.HMR_AMT)/A.UPJANG_CNT END ) ,1) AS UPJANG_AMT \n");
		sbSql.append("     , ROUND(AVG(DECODE(A.PERSON_NUM_A + A.PERSON_NUM_B + A.PERSON_NUM_C + A.PERSON_NUM_D + A.PERSON_NUM_E + A.PERSON_NUM_F + A.PERSON_NUM_G,0,NULL,A.PERSON_NUM_A + A.PERSON_NUM_B + A.PERSON_NUM_C + A.PERSON_NUM_D + A.PERSON_NUM_E + A.PERSON_NUM_F + A.PERSON_NUM_G))) AS PERSON_NUM_SUM \n");
		sbSql.append("     , ROUND(AVG(DECODE(A.PERSON_NUM_A + A.PERSON_NUM_B + A.PERSON_NUM_C,0,NULL,A.PERSON_NUM_A + A.PERSON_NUM_B + A.PERSON_NUM_C))) AS PERSON_NUM_ABC \n");
		sbSql.append("     , ROUND(AVG(DECODE(A.PERSON_NUM_D + A.PERSON_NUM_E + A.PERSON_NUM_F + A.PERSON_NUM_G,0,NULL,A.PERSON_NUM_D + A.PERSON_NUM_E + A.PERSON_NUM_F + A.PERSON_NUM_G))) AS PERSON_NUM_DEFG \n");
		sbSql.append("     , ROUND(AVG(DECODE(A.PERSON_NUM_D,0,NULL,A.PERSON_NUM_D))) AS PERSON_NUM_D \n");
		sbSql.append("     , ROUND(AVG(DECODE(A.PERSON_NUM_E,0,NULL,A.PERSON_NUM_E))) AS PERSON_NUM_E \n");
		sbSql.append("     , ROUND(AVG(DECODE(A.PERSON_NUM_F,0,NULL,A.PERSON_NUM_F))) AS PERSON_NUM_F \n");
		sbSql.append("     , ROUND(AVG(DECODE(A.PERSON_NUM_G,0,NULL,A.PERSON_NUM_G))) AS PERSON_NUM_G \n");
		sbSql.append("     , ROUND(AVG(CASE WHEN A.PERSON_NUM_E = 0 OR A.UPJANG_CNT = 0 THEN NULL ELSE A.PERSON_NUM_E/A.UPJANG_CNT END ) ,1) AS PERSON_NUM_E2 \n");
		sbSql.append("     , ROUND(AVG(CASE WHEN A.PERSON_NUM_F = 0 OR A.UPJANG_CNT = 0 THEN NULL ELSE A.PERSON_NUM_F/A.UPJANG_CNT END ) ,1) AS PERSON_NUM_F2 \n");
		sbSql.append("     , ROUND(AVG(CASE WHEN A.PERSON_NUM_G = 0 OR A.UPJANG_CNT = 0 THEN NULL ELSE A.PERSON_NUM_G/A.UPJANG_CNT END ) ,1) AS PERSON_NUM_G2 \n");
		sbSql.append("  FROM MAS_EIS_B A \n");
		sbSql.append("     , MAS_EIS_A C \n");
		sbSql.append(" WHERE A.YYYY = C.YYYY \n");
		sbSql.append("   AND A.QUATER = C.QUATER \n");
		sbSql.append("   AND A.ALLY_CD = C.ALLY_CD \n");
		sbSql.append("   AND C.GUBUN = '100'  -- 매출액 \n");
		sbSql.append("   AND A.YYYY = '" + strYYYY + "' \n");
		sbSql.append("   AND A.QUATER = '" + strQuater + "' \n");
		sbSql.append(" GROUP BY A.YYYY, A.QUATER \n");
		sbSql.append("UNION ALL \n");
		sbSql.append("SELECT A.YYYY \n");
		sbSql.append("     , A.QUATER \n");
		sbSql.append("     , B.SORT_SEQ \n");
		sbSql.append("     , A.ALLY_CD \n");
		sbSql.append("     , B.CODE_NAME AS ALLY_NM \n");
		sbSql.append("     , A.UPJANG_CNT \n");
		sbSql.append("     , A.UPJANG_CNT - NVL((SELECT UPJANG_CNT FROM MAS_EIS_B WHERE A.QUATER = QUATER AND A.ALLY_CD = ALLY_CD AND YYYY = (A.YYYY -1)),0) AS UPJANG_CNT2 \n");
		sbSql.append("     , DECODE(A.UPJANG_CNT,0,0,ROUND((C.MEAL_AMT + C.HMR_AMT)/A.UPJANG_CNT,1)) AS UPJANG_AMT \n");
		sbSql.append("     , A.PERSON_NUM_A + A.PERSON_NUM_B + A.PERSON_NUM_C + A.PERSON_NUM_D + A.PERSON_NUM_E + A.PERSON_NUM_F + A.PERSON_NUM_G AS PERSON_NUM_SUM \n");
		sbSql.append("     , A.PERSON_NUM_A + A.PERSON_NUM_B + A.PERSON_NUM_C AS PERSON_NUM_ABC \n");
		sbSql.append("     , A.PERSON_NUM_D + A.PERSON_NUM_E + A.PERSON_NUM_F + A.PERSON_NUM_G AS PERSON_NUM_DEFG \n");
		sbSql.append("     , A.PERSON_NUM_D \n");
		sbSql.append("     , A.PERSON_NUM_E \n");
		sbSql.append("     , A.PERSON_NUM_F \n");
		sbSql.append("     , A.PERSON_NUM_G \n");
		sbSql.append("     , DECODE(A.UPJANG_CNT,0,0,ROUND(A.PERSON_NUM_E / A.UPJANG_CNT,1)) AS PERSON_NUM_E2 \n");
		sbSql.append("     , DECODE(A.UPJANG_CNT,0,0,ROUND(A.PERSON_NUM_F / A.UPJANG_CNT,1)) AS PERSON_NUM_F2 \n");
		sbSql.append("     , DECODE(A.UPJANG_CNT,0,0,ROUND(A.PERSON_NUM_G / A.UPJANG_CNT,1)) AS PERSON_NUM_G2 \n");
		sbSql.append("  FROM MAS_EIS_B A \n");
		sbSql.append("     , ( \n");
		sbSql.append("         SELECT CODE, CODE_NAME, SORT_SEQ \n");
		sbSql.append("           FROM SCC_COMMON_CODE \n");
		sbSql.append("          WHERE GROUP_CODE = 'MA2001' \n");
		sbSql.append("       ) B \n");
		sbSql.append("     , MAS_EIS_A C \n");
		sbSql.append(" WHERE A.ALLY_CD = B.CODE \n");
		sbSql.append("   AND A.YYYY = C.YYYY \n");
		sbSql.append("   AND A.QUATER = C.QUATER \n");
		sbSql.append("   AND A.ALLY_CD = C.ALLY_CD \n");
		sbSql.append("   AND C.GUBUN = '100'  -- 매출액 \n");
		sbSql.append("   AND A.YYYY = '" + strYYYY + "' \n");
		sbSql.append("   AND A.QUATER = '" + strQuater + "' \n");
		sbSql.append(" ORDER BY SORT_SEQ \n");
		
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