<%                                                                                                                                                                                                      
/*-----------------------------------------------------------------------------                                                                                                                         
■ 시스템명     : 동업계 실적 비교/단체급식 원가구성                                                                                                                                                                     
■ 프로그램ID   : MAS20024P_S001.jsp                                                                                                                                                                    
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
		sbSql.append("     , '동종업계 평균' AS ALLY_NM \n");
		sbSql.append("     , ROUND(AVG(CASE WHEN A.MEAL_AMT_201 = 0 OR A.MEAL_AMT_100 = 0 THEN NULL ELSE A.MEAL_AMT_201/A.MEAL_AMT_100*100 END ) ,1) AS MEAL_AMT_201 \n");
		sbSql.append("     , ROUND(AVG(CASE WHEN A.MEAL_AMT_202 = 0 OR A.MEAL_AMT_100 = 0 THEN NULL ELSE A.MEAL_AMT_202/A.MEAL_AMT_100*100 END ) ,1) AS MEAL_AMT_202 \n");
		sbSql.append("     , ROUND(AVG(CASE WHEN A.MEAL_AMT_203 = 0 OR A.MEAL_AMT_100 = 0 THEN NULL ELSE A.MEAL_AMT_203/A.MEAL_AMT_100*100 END ) ,1) AS MEAL_AMT_203 \n");
		sbSql.append("  FROM ( \n");
		sbSql.append("          SELECT A.YYYY \n");
		sbSql.append("               , A.QUATER \n");
		sbSql.append("               , A.ALLY_CD \n");
		sbSql.append("               , SUM(DECODE(A.GUBUN,'100',A.MEAL_AMT)) AS MEAL_AMT_100 \n");
		sbSql.append("               , SUM(DECODE(A.GUBUN,'201',A.MEAL_AMT)) AS MEAL_AMT_201 \n");
		sbSql.append("               , SUM(DECODE(A.GUBUN,'202',A.MEAL_AMT)) AS MEAL_AMT_202 \n");
		sbSql.append("               , SUM(DECODE(A.GUBUN,'203',A.MEAL_AMT)) AS MEAL_AMT_203 \n");
		sbSql.append("            FROM MAS_EIS_A A \n");
		sbSql.append("          WHERE A.YYYY = '" + strYYYY + "' \n");
		sbSql.append("            AND A.QUATER = '" + strQuater + "' \n");
		sbSql.append("            AND A.GUBUN IN ('100','201','202','203') \n");
		sbSql.append("          GROUP BY A.YYYY, A.QUATER, A.ALLY_CD \n");
		sbSql.append("       ) A \n");
		sbSql.append(" GROUP BY A.YYYY, A.QUATER \n");
		sbSql.append("UNION ALL \n");
		sbSql.append("SELECT A.YYYY \n");
		sbSql.append("     , A.QUATER \n");
		sbSql.append("     , B.SORT_SEQ \n");
		sbSql.append("     , A.ALLY_CD \n");
		sbSql.append("     , B.CODE_NAME AS ALLY_NM \n");
		sbSql.append("     , DECODE(SUM(A.MEAL_AMT_100),0,0,ROUND(SUM(A.MEAL_AMT_201)/SUM(A.MEAL_AMT_100)*100,1)) AS MEAL_AMT_201 \n");
		sbSql.append("     , DECODE(SUM(A.MEAL_AMT_100),0,0,ROUND(SUM(A.MEAL_AMT_202)/SUM(A.MEAL_AMT_100)*100,1)) AS MEAL_AMT_202 \n");
		sbSql.append("     , DECODE(SUM(A.MEAL_AMT_100),0,0,ROUND(SUM(A.MEAL_AMT_203)/SUM(A.MEAL_AMT_100)*100,1)) AS MEAL_AMT_203 \n");
		sbSql.append("  FROM ( \n");
		sbSql.append("          SELECT A.YYYY \n");
		sbSql.append("               , A.QUATER \n");
		sbSql.append("               , A.ALLY_CD \n");
		sbSql.append("               , DECODE(A.GUBUN,'100',A.MEAL_AMT) AS MEAL_AMT_100 \n");
		sbSql.append("               , DECODE(A.GUBUN,'201',A.MEAL_AMT) AS MEAL_AMT_201 \n");
		sbSql.append("               , DECODE(A.GUBUN,'202',A.MEAL_AMT) AS MEAL_AMT_202 \n");
		sbSql.append("               , DECODE(A.GUBUN,'203',A.MEAL_AMT) AS MEAL_AMT_203 \n");
		sbSql.append("            FROM MAS_EIS_A A \n");
		sbSql.append("          WHERE A.YYYY = '" + strYYYY + "' \n");
		sbSql.append("            AND A.QUATER = '" + strQuater + "' \n");
		sbSql.append("            AND A.GUBUN IN ('100','201','202','203') \n");
		sbSql.append("       ) A \n");
		sbSql.append("     , ( \n");
		sbSql.append("         SELECT CODE, CODE_NAME, SORT_SEQ \n");
		sbSql.append("           FROM SCC_COMMON_CODE \n");
		sbSql.append("          WHERE GROUP_CODE = 'MA2001' \n");
		sbSql.append("       ) B \n");
		sbSql.append(" WHERE A.ALLY_CD = B.CODE \n");
		sbSql.append(" GROUP BY A.YYYY, A.QUATER, A.ALLY_CD, B.SORT_SEQ, B.CODE_NAME \n");
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