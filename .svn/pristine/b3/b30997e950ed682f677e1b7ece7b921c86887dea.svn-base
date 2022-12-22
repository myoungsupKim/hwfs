
<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	Statement stmt             =  null;
	try {
		PlatformRequest platformRequest = this.proc_input(request);  
		// 입력 데이터셋리스트
		in_dl = platformRequest.getData().getDataSetList();
		// 입력  변수리스트
		in_vl = platformRequest.getData().getVariableList();
		
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));
				
		//입력 데이타셋 선언
		DataSet ds_input     = in_dl.get("ds_input");
		
		//출력 데이타셋 선언
		DataSet ds_list;
		
		String UPJANG = ds_input.getString(0,"UPJANG");
		String START_DATE = ds_input.getString(0,"START_DATE");
		String END_DATE = ds_input.getString(0,"END_DATE");

		StringBuffer sbSql = new StringBuffer();		
		sbSql.append(" SELECT NVL(SUM(PLAN_AMT),0)      AS PLAN_AMT      --월계획_매출액                                                                                                                                                                 \n  "); 
		sbSql.append("      , NVL(SUM(PLAN_COST),0)     AS PLAN_COST     --월계획_식재료비                                                                                                                                                               \n  "); 
		sbSql.append("      , NVL(SUM(PLAN_RATE),0)     AS PLAN_RATE     --월계획_식재료율                                                                                                                                                               \n  "); 
		sbSql.append("      , NVL(SUM(PLAN_STOCK),0)    AS PLAN_STOCK    --월계획_재고비율                                                                                                                                                               \n  "); 
		sbSql.append("      , NVL(SUM(PROSPECT_COST),0) AS PROSPECT_COST -- 식재료비기간전망                                                                                                                                                                     \n  "); 
		sbSql.append("      , 0 AS PROSPECT_TRX_AMT                      -- 매출액기간전망(DUMMY)                                                                                                                                                                     \n  "); 
		sbSql.append("      , 0 AS PROSPECT_RATE                         -- 식재료율기간전망(DUMMY)                                                                                                                                                                    \n  "); 
		sbSql.append("      , 0 AS RESULT_TRX_AMT                        -- 실적누계 매출액(DUMMY)                                                                                                                                                                    \n  "); 
		sbSql.append("      , 0 AS TOTAL_COST                            -- 실적누계 식재료비 (DUMMY)                                                                                                                                                                    \n  "); 
		sbSql.append("      , 0 AS RESULT_RATE                           -- 실적누계 식재료율(DUMMY)                                                                                                                                                                    \n  "); 
		sbSql.append("      , 0 AS STOCK_RATE                           -- 실적누계 재고비율(DUMMY)                                                                                                                                                                    \n  "); 
		
		sbSql.append("      , 0 AS PLAN_AMT_DIFF                           -- 매출액 계획대비 차이(DUMMY)                                                                                                                                                                    \n  "); 
		sbSql.append("      , 0 AS PLAN_COST_DIFF                          -- 식재료비 계획대비 차이(DUMMY)                                                                                                                                                                    \n  "); 
		sbSql.append("      , 0 AS PLAN_RATE_DIFF                          -- 계획대비 식재료율 차이(DUMMY)                                                                                                                                                                    \n  "); 
		sbSql.append("      , 0 AS PLAN_STOCK_DIFF                         -- 계획대비 재고비율차이(DUMMY)                                                                                                                                                                    \n  "); 
		sbSql.append("      , 0 AS PLAN_AMT_RATE                           -- 계획대비 매출액 달성율(DUMMY)                                                                                                                                                                    \n  "); 
		sbSql.append("      , 0 AS PLAN_COST_RATE                          -- 계획대비 식재료비 달성율(DUMMY)                                                                                                                                                                    \n  "); 
			
		sbSql.append("      , 0 AS PROSPECT_AMT_DIFF                       -- 전망대비 매출액 차이(DUMMY)                                                                                                                                                                    \n  "); 
		sbSql.append("      , 0 AS PROSPECT_COST_DIFF                      -- 전망대비 식재료비 차이(DUMMY)                                                                                                                                                                    \n  "); 
		sbSql.append("      , 0 AS PROSPECT_RATE_DIFF                      -- 전망대비 식재료율 차이(DUMMY)                                                                                                                                                                    \n  "); 
		sbSql.append("      , 0 AS PROSPECT_AMT_RATE                       -- 전망대비 매출액 달성율(DUMMY)                                                                                                                                                                    \n  "); 
		sbSql.append("      , 0 AS PROSPECT_COST_RATE                      -- 전망대비 식재료비 달성율(DUMMY)                                                                                                                                                                    \n  "); 
		sbSql.append("   FROM                                                                                                                                                                                                                            \n  "); 
		sbSql.append("        (                                                                                                                                                                                                                          \n  "); 
		sbSql.append("         -- 당월계획                                                                                                                                                                                                               \n  "); 
		sbSql.append("         SELECT                                                                                                                                                                                                                    \n  "); 
		sbSql.append("                SUM(DECODE(MGMT_ACCT_CD,'PLA10000', AMT, 'PLA30000', AMT, 0)) PLAN_AMT                                                                                                                                             \n  "); 
		sbSql.append("              , SUM(DECODE(MGMT_ACCT_CD,'PLB11000', AMT, 0)) PLAN_COST                                                                                                                                                             \n  "); 
		sbSql.append("              , ROUND(DECODE(SUM(DECODE(MGMT_ACCT_CD,'PLA10000', AMT, 'PLA30000', AMT, 0)),0,0, SUM(DECODE(MGMT_ACCT_CD,'PLB11000', AMT, 0))/SUM(DECODE(MGMT_ACCT_CD,'PLA10000', AMT, 'PLA30000', AMT, 0))*100),1) PLAN_RATE       \n  "); 
		sbSql.append("              , 0 PLAN_STOCK                                                                                                                                                                                                       \n  "); 
		sbSql.append("              , 0 PROSPECT_COST                                                                                                                                                                                                    \n  "); 
		sbSql.append("           FROM MAM_FS_PL_V                                                                                                                                                                                                        \n  "); 
		sbSql.append("          WHERE DATA_CLASS = 'P'                                                                                                                                                                                                   \n  "); 
		sbSql.append("            AND YYMM = SUBSTR('"+ START_DATE +"',1,6)                                                                                                                                                                                      \n  "); 
		sbSql.append("            AND UPJANG = "+ UPJANG +"                                                                                                                                                                                                    \n  "); 
		sbSql.append("         UNION ALL                                                                                                                                                                                                                 \n  "); 
		sbSql.append("         -- 재고목표                                                                                                                                                                                                               \n  "); 
		sbSql.append("         SELECT 0 PLAN_AMT                                                                                                                                                                                                         \n  "); 
		sbSql.append("              , 0 PLAN_COST                                                                                                                                                                                                        \n  "); 
		sbSql.append("              , 0 PLAN_RATE                                                                                                                                                                                                        \n  "); 
		sbSql.append("              , GOAL_RATE PLAN_STOCK                                                                                                                                                                                               \n  "); 
		sbSql.append("              , 0 PROSPECT_COST                                                                                                                                                                                                    \n  "); 
		sbSql.append("           FROM FSA_STOCK_GOAL_SET                                                                                                                                                                                                 \n  "); 
		sbSql.append("          WHERE GOAL_MM = SUBSTR('"+ START_DATE +"',1,6)                                                                                                                                                                                   \n  "); 
		sbSql.append("            AND UPJANG = "+ UPJANG +"                                                                                                                                                                                                  \n  "); 
		sbSql.append("         UNION ALL                                                                                                                                                                                                                 \n  "); 
		sbSql.append("         -- 식재료비 기간전망                                                                                                                                                                                                      \n  "); 
		sbSql.append("         SELECT 0 PLAN_AMT                                                                                                                                                                                                         \n  "); 
		sbSql.append("              , 0 PLAN_COST                                                                                                                                                                                                        \n  "); 
		sbSql.append("              , 0 PLAN_RATE                                                                                                                                                                                                        \n  "); 
		sbSql.append("              , 0 PLAN_STOCK                                                                                                                                                                                                       \n  "); 
		sbSql.append("              , SUM(NVL(RAWCOST,0)) PROSPECT_COST                                                                                                                                                                                  \n  "); 
		sbSql.append("           FROM MAF_FS_SALE_V                                                                                                                                                                                                      \n  "); 
		sbSql.append("          WHERE SALE_DATE BETWEEN '"+ START_DATE +"' AND '"+ END_DATE +"'                                                                                                                                                                        \n  "); 
		sbSql.append("            AND UPJANG = "+ UPJANG +"                                                                                                                                                                                                  \n  "); 
		sbSql.append("        )                                                                                                                                                                                                                          \n  ");
			
	    //SQL 실행
	    pstmt = conn.prepareStatement(sbSql.toString());
	    //RecordSet에 데이터 담기
	    rs = pstmt.executeQuery();
		//데이터셋만들기
		DataSet ds_list2 = this.makeDataSet(rs, "ds_list2"); //ds_list

		/**종료**/
		out_dl.add(ds_list2);
		this.setResultMessage(0, "OK", out_vl);
	}
	catch(Exception ex)
	{
		//jsp 로그남기기
		logger.debug(ex.getMessage(), ex);
		//메세지반환
		this.setResultMessage(-1, ex.toString(),out_vl);  
	}
	finally {
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
		if(stmt != null) {
			try {
				stmt.close();
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
