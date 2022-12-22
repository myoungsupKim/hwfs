<%                                                                                                                                                                                                      
/*-----------------------------------------------------------------------------                                                                                                                         
■ 시스템명     : 동업계 실적 비교/경영지표                                                                                                                                                                     
■ 프로그램ID   : MAS20026P_S001.jsp                                                                                                                                                                    
■ 프로그램명   : 경영지표                                                                                                                                                 
■ 작성일자     : 2008-07-01                                                                                                                                                                           
■ 작성자       : 박지영                                                                                                                                                                                
■ 이력관리     : 2008-07-01                                                                                                                                                                            
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
		sbSql.append("     , '0' AS ALLY_CD \n");
		sbSql.append("     , '업계평균' AS ALLY_NM \n");
		sbSql.append("     , ROUND(AVG(DECODE(A.ASSET_AMT,0,NULL,A.ASSET_AMT))) AS ASSET_AMT \n");
		sbSql.append("     , ROUND(AVG(DECODE(A.DEBT_AMT,0,NULL,A.DEBT_AMT))) AS DEBT_AMT \n");
		sbSql.append("     , ROUND(AVG(DECODE(A.CAPITAL_AMT,0,NULL,A.CAPITAL_AMT))) AS CAPITAL_AMT \n");
		sbSql.append("     , ROUND(AVG(DECODE(A.CAPITAL,0,NULL,A.CAPITAL))) AS CAPITAL \n");
		sbSql.append("     , ROUND(AVG(CASE WHEN A.DEBT_AMT = 0 OR A.CAPITAL_AMT = 0 THEN NULL ELSE A.DEBT_AMT/A.CAPITAL_AMT*100 END ) ,1) AS AMT_1    -- 부채비율         = 부채/자본 \n");
		sbSql.append("     , ROUND(AVG(CASE WHEN A.CAPITAL_AMT = 0 OR A.ASSET_AMT = 0 THEN NULL ELSE A.CAPITAL_AMT/A.ASSET_AMT*100 END ) ,1) AS AMT_2  -- 자기자본비율     = 자본/자산 \n");
		sbSql.append("     , ROUND(AVG(CASE WHEN C.AMT_800 = 0 OR A.ASSET_AMT = 0 THEN NULL ELSE C.AMT_800/A.ASSET_AMT*100 END ) ,1) AS AMT_3			 -- 총자본경상이익율 = 경상이익/자산 \n");
		sbSql.append("     , ROUND(AVG(CASE WHEN C.AMT_800 = 0 OR C.AMT_100 = 0 THEN NULL ELSE C.AMT_800/C.AMT_100*100 END ) ,1) AS AMT_4				 -- 경상이익율       = 경상이익/매출액 \n");
		sbSql.append("     , ROUND(AVG(CASE WHEN C.AMT_100 = 0 OR A.ASSET_AMT = 0 THEN NULL ELSE C.AMT_100/A.ASSET_AMT*100 END ) ,1) AS AMT_5			 -- 총자본회전율     = 매출액/자산 \n");
		sbSql.append("  FROM MAS_EIS_B A \n");
		sbSql.append("     , ( \n");
		sbSql.append("          SELECT A.YYYY \n");
		sbSql.append("               , A.QUATER \n");
		sbSql.append("               , A.ALLY_CD \n");
		sbSql.append("               , SUM(DECODE(A.GUBUN,'100',MEAL_AMT+FICS_AMT+HMR_AMT+GITA_AMT)) AS AMT_100 \n");
		sbSql.append("               , SUM(DECODE(A.GUBUN,'800',MEAL_AMT+FICS_AMT+HMR_AMT+GITA_AMT)) AS AMT_800 \n");
		sbSql.append("            FROM MAS_EIS_A A \n");
		sbSql.append("          WHERE A.YYYY = '" + strYYYY + "' \n");
		sbSql.append("            AND A.QUATER = '" + strQuater + "' \n");
		sbSql.append("            AND A.GUBUN IN ('100','800') \n");
		sbSql.append("          GROUP BY A.YYYY,A.QUATER,A.ALLY_CD \n");
		sbSql.append("       ) C \n");
		sbSql.append(" WHERE A.YYYY = C.YYYY \n");
		sbSql.append("   AND A.QUATER = C.QUATER \n");
		sbSql.append("   AND A.ALLY_CD = C.ALLY_CD \n");
		sbSql.append("   AND A.YYYY = '" + strYYYY + "' \n");
		sbSql.append("   AND A.QUATER = '" + strQuater + "' \n");
		sbSql.append(" GROUP BY A.YYYY, A.QUATER \n");
		sbSql.append("UNION ALL \n");
		sbSql.append("SELECT A.YYYY \n");
		sbSql.append("     , A.QUATER \n");
		sbSql.append("     , B.SORT_SEQ \n");
		sbSql.append("     , A.ALLY_CD \n");
		sbSql.append("     , B.CODE_NAME AS ALLY_NM \n");
		sbSql.append("     , A.ASSET_AMT \n");
		sbSql.append("     , A.DEBT_AMT \n");
		sbSql.append("     , A.CAPITAL_AMT \n");
		sbSql.append("     , A.CAPITAL \n");
		sbSql.append("     , DECODE(A.CAPITAL_AMT,0,0,ROUND(A.DEBT_AMT/A.CAPITAL_AMT*100)) AS AMT_1				-- 부채비율         = 부채/자본 \n");
		sbSql.append("     , DECODE(A.ASSET_AMT,0,0,ROUND(A.CAPITAL_AMT/A.ASSET_AMT*100)) AS AMT_2				-- 자기자본비율     = 자본/자산 \n");
		sbSql.append("     , DECODE(A.ASSET_AMT,0,0,ROUND(C.AMT_800/A.ASSET_AMT*100)) AS AMT_3					-- 총자본경상이익율 = 경상이익/자산 \n");
		sbSql.append("     , DECODE(C.AMT_100,0,0,ROUND(C.AMT_800/C.AMT_100*100)) AS AMT_4						-- 경상이익율       = 경상이익/매출액 \n");
		sbSql.append("     , DECODE(A.ASSET_AMT,0,0,ROUND(C.AMT_100/A.ASSET_AMT*100)) AS AMT_5					-- 총자본회전율     = 매출액/자산 \n");
		sbSql.append("  FROM MAS_EIS_B A \n");
		sbSql.append("     , ( \n");
		sbSql.append("         SELECT CODE, CODE_NAME, SORT_SEQ \n");
		sbSql.append("           FROM SCC_COMMON_CODE \n");
		sbSql.append("          WHERE GROUP_CODE = 'MA2001' \n");
		sbSql.append("       ) B \n");
		sbSql.append("     , ( \n");
		sbSql.append("          SELECT A.YYYY \n");
		sbSql.append("               , A.QUATER \n");
		sbSql.append("               , A.ALLY_CD \n");
		sbSql.append("               , SUM(DECODE(A.GUBUN,'100',MEAL_AMT+FICS_AMT+HMR_AMT+GITA_AMT)) AS AMT_100 \n");
		sbSql.append("               , SUM(DECODE(A.GUBUN,'800',MEAL_AMT+FICS_AMT+HMR_AMT+GITA_AMT)) AS AMT_800 \n");
		sbSql.append("            FROM MAS_EIS_A A \n");
		sbSql.append("          WHERE A.YYYY = '" + strYYYY + "' \n");
		sbSql.append("            AND A.QUATER = '" + strQuater + "' \n");
		sbSql.append("            AND A.GUBUN IN ('100','800') \n");
		sbSql.append("          GROUP BY A.YYYY,A.QUATER,A.ALLY_CD \n");
		sbSql.append("       ) C \n");
		sbSql.append(" WHERE A.ALLY_CD = B.CODE \n");
		sbSql.append("   AND A.YYYY = C.YYYY \n");
		sbSql.append("   AND A.QUATER = C.QUATER \n");
		sbSql.append("   AND A.ALLY_CD = C.ALLY_CD \n");
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