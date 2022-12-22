<%@page import="com.sz.util.AppDataUtility"%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	Statement stmt             =  null;
	try {
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
	//	String v_EmpNo 		= in_vl.getString("g_EmpNo");	
	//	DataSet in_ds  =  in_dl.get("ds_Input");
	//	String sCode = in_ds.getString(0, "CD");
						
		String TM 			= nullToBlank(in_vl.getString("TM"));		
		String TEAM 		= nullToBlank(in_vl.getString("TEAM"));
		String LEADER 		= nullToBlank(in_vl.getString("LEADER"));
		String UPJANG 		= nullToBlank(in_vl.getString("UPJANG"));
		String FROM			= nullToBlank(in_vl.getString("FROM"));
		String TO			= nullToBlank(in_vl.getString("TO"));
	
		String YYYY = FROM.substring(0, 4);
		String MM = FROM.substring(4, 6);
		
	//	if(conn != null && !conn.isClosed()) conn.close();
		
	//	conn = getIRISConn();
		
		stmt 		=  conn.createStatement();
	
		DataSet ds_out;
		StringBuffer sbSql = new StringBuffer();
		sbSql.delete(0, sbSql.length());
		sbSql.append("WITH SQL1 AS                                                                                                                                                                              \n");
		sbSql.append("(                                                                                                                                                                              \n");
		sbSql.append("  SELECT /*+ MATERIALIZE LEADING(E A B C D) USE_HASH(E A) USE_NL(B) USE_NL(C) USE_HASH(D) */ A.UPJANG                                                                                                                                                                                  \n");
		sbSql.append("       ,A.MENU_CD                                                                                                                                                                                  \n");
		sbSql.append("       ,A.MENU_DATE                                                                                                                                                                                  \n");
		sbSql.append("       ,A.HALL_CD                                                                                                                                                                                  \n");
		sbSql.append("       ,B.RECIPE_CD                                                                                                                                                                                  \n");
		sbSql.append("       ,E.ATTR02                                                                                                                                                                                 \n");
		sbSql.append("       ,B.EXPECT_SALE_QTY                                                                                                                                                                                 \n");
		sbSql.append("       ,E.SET3                                                                                                                                                                                 \n");
		sbSql.append("       ,A.EXPECT_MEAL_QTY                                                                                                                                                                                 \n");
		sbSql.append("       ,C.NEED_QTY                                                                                                                                                                                 \n");
		sbSql.append("       ,C.MARGIN_PRICE                                                                                                                                                                                 \n");
		sbSql.append("       ,D.KG_CONVERT_RATE                                                                                                                                                                                 \n");
		sbSql.append("    FROM FSM_REAL_MENU_MST A                                                                                                                                                                                  \n");
		sbSql.append("       , FSM_REAL_RECIPE_MST B                                                                                                                                                                                  \n");
		sbSql.append("       , FSM_REAL_RECIPE_ITEM C                                                                                                                                                                                  \n");
		sbSql.append("       , HLDC_PO_ITEM_MST D                                                                                                                                                                                  \n");
		sbSql.append("       , SCC_COMMON_CODE E                                                                                                                                                                                  \n");
		sbSql.append("   WHERE A.UPJANG    = B.UPJANG                                                                                                                                                                                  \n");
		sbSql.append("     AND A.MENU_CD   = B.MENU_CD                                                                                                                                                                                  \n");
		sbSql.append("     AND B.UPJANG    = C.UPJANG                                                                                                                                                                                  \n");
		sbSql.append("     AND B.MENU_CD   = C.MENU_CD                                                                                                                                                                                  \n");
		sbSql.append("     AND B.RECIPE_CD = C.RECIPE_CD                                                                                                                                                                                  \n");
		sbSql.append("     AND C.ITEM_CODE = D.ITEM_CODE                                                                                                                                                                                  \n");
		sbSql.append("AND SUBSTR(A.HALL_CD,1,3) = E.CODE                                                                                                                                                                                  \n");
		sbSql.append("AND E.GROUP_CODE= 'FS0019'                                                                                                                                                                                  \n");
		sbSql.append("AND A.MENU_DATE BETWEEN '"+FROM+"' AND '"+TO+"'                                                                                                                                                                        \n");
		sbSql.append("),                                                                                                                                                                                 \n");
		sbSql.append("SQL2 AS                                                                           \n");
		sbSql.append("(  \n");
		sbSql.append(" SELECT /*+ MATERIALIZE LEADING(A F) USE_HASH(F) */ A.UPJANG  \n");
		sbSql.append("       ,A.MENU_CD                                              \n");
		sbSql.append("       ,A.MENU_DATE                                              \n");
		sbSql.append("       ,A.HALL_CD                                              \n");
		sbSql.append("       ,A.RECIPE_CD                                              \n");
		sbSql.append("       ,A.ATTR02                                            \n");
		sbSql.append("       ,A.EXPECT_SALE_QTY                                             \n");
		sbSql.append("       ,A.SET3                                            \n");
		sbSql.append("       ,A.EXPECT_MEAL_QTY                                             \n");
		sbSql.append("       ,A.NEED_QTY                                             \n");
		sbSql.append("       ,A.MARGIN_PRICE                                            \n");
		sbSql.append("       ,A.KG_CONVERT_RATE                                             \n");
		sbSql.append("       ,F.HALL_NAME || F.REMARK HALL_NAME                                              \n");
		sbSql.append("  FROM SQL1 A                                             \n");
		sbSql.append("     , FSA_HALL_MST F                                             \n");
		sbSql.append(" WHERE A.UPJANG    = F.UPJANG                                               \n");
		sbSql.append("   AND A.HALL_CD   = F.HALL_CD                                              \n");
		sbSql.append(")                                             \n");
		sbSql.append("SELECT /*+ LEADING(B C A) USE_HASH(C) USE_HASH(A) NO_MERGE(A) NO_MERGE(B) */  C.UPJANG                                                                                                                                                                                 \n");
		sbSql.append("     , B.HALL_CD                                                                                                                                                                                \n");
		sbSql.append("     , (SELECT NM_KOR FROM HLDC_HR_PERSONAL X WHERE X.SABUN = C.SUBTEAM_MST_SABUN) NM_KOR --소팀장                                                                                         \n");
		sbSql.append("     , (SELECT NM_KOR FROM HLDC_HR_PERSONAL X WHERE X.SABUN = C.LEADER_SABUN) NM_LEADER --리더                                                                                                     \n");
		sbSql.append("     , C.UPJANGNM -- 사업장                                                                                                                                                                     \n");
		sbSql.append("     , B.HALL_NAME --변경                                                                                                                                                                             	\n");
		sbSql.append("     , NVL(A.PLAN,0) PLAN -- 월계획                                                                                                                                                             \n");
		sbSql.append("     , B.GOAL --기간목표                                                                                                                                                                        \n");
		sbSql.append("     , B.EXPECT --기간예상                                                                                                                                                                      \n");
		sbSql.append("     , DECODE(B.HALL_CD,'99999', nvl(B.EXPECT-A.PLAN,0), 0) PLAN_RATIO --계획대비                                                                                                                      \n");
		sbSql.append("  FROM (                                                                                                                                       \n");
        sbSql.append("        SELECT UPJANG                                                                                                                          \n");                                         
        sbSql.append("             , ROUND(DECODE(SUM(S_AMT),0,0,SUM(C_AMT)/SUM(S_AMT))*100,1) PLAN                                                                  \n");
        sbSql.append("             , 0 PROSPECT                                                                                                                      \n");
        sbSql.append("          FROM (                                                                                                                               \n");                                           
        sbSql.append("                SELECT A.UPJANG                                                                                                                \n");                                           
        sbSql.append("                     , CASE WHEN ACCT_CD IN ('41203010', '41203020') THEN MM_AMT_" + MM + " ELSE 0 END AS S_AMT                                        \n");                                           
        sbSql.append("                     , CASE WHEN ACCT_CD IN ('42203010', '42203020') THEN MM_AMT_" + MM + " ELSE 0 END AS C_AMT                                        \n");                                           
        sbSql.append("                  FROM MAP_MON_PLAN A                                                                                                          \n");                                           
        sbSql.append("                     , MAP_MON_LOG_MGMT B                                                                                                      \n");                                           
        sbSql.append("                     , (SELECT UPJANG                                                                                                          \n");                                           
        sbSql.append("                             , YY                                                                                                              \n");                                           
        sbSql.append("                             , MAX(BIZ_CLASS) KEEP(DENSE_RANK FIRST ORDER BY UDATE DESC) AS BIZ_CLASS                                          \n");                                           
        sbSql.append("                          FROM MAP_MON_LOG_MGMT                                                                                                \n");                                           
        sbSql.append("                         WHERE CONFIRM_YN = 'Y'                                                                                                \n");                                           
        sbSql.append("                           AND YY = '" + YYYY + "'                                                                                                     \n");                                           
        sbSql.append("                         GROUP BY UPJANG, YY)                                                                                                  \n");                                           
        sbSql.append("                 WHERE A.UPJANG = B.UPJANG                                                                                                     \n");                                           
        sbSql.append("                   AND A.YY = B.YY                                                                                                             \n");                                           
        sbSql.append("                   AND A.BIZ_CLASS = B.BIZ_CLASS                                                                                               \n");                                           
        sbSql.append("                   AND ACCT_CD IN ('41203010', '41203020', '42203010', '42203020')                                                             \n");                                           
        sbSql.append("               )                                                                                                                               \n");                                           
        sbSql.append("         GROUP BY UPJANG    		                                                                                                             \n");
		sbSql.append("       ) A                                                                                                                                                                                      \n");
		sbSql.append("     , (                                                                                                                                                                                        \n");
		sbSql.append("         SELECT UPJANG, HALL_CD, HALL_NAME --추가                                                                                                                                               \n");
		sbSql.append("             , ROUND(DECODE(SUM(SALE_AMT),0,0,SUM(GOAL_COST) / SUM(SALE_AMT))*100,1) GOAL                                                                                                       \n");
		sbSql.append("             , ROUND(DECODE(SUM(SALE_AMT),0,0,SUM(EXPECT_COST) / SUM(SALE_AMT))*100,1) EXPECT                                                                                                   \n");
		sbSql.append("          FROM (                                                                                                                                                                                \n");
		sbSql.append("                SELECT /*+ LEADING(A B F) USE_HASH(A B F) USE_HASH(V1) USE_HASH(V2) FULL(V2) USE_NL(V3) */ A.UPJANG, A.HALL_CD, F.HALL_NAME || F.REMARK HALL_NAME --추가                                                                                                            \n");
		sbSql.append("                     , SUM(A.SALE_PRICE * A.EXPECT_MEAL_QTY) SALE_AMT                                                                                                                           \n");
		//sbSql.append("                     , SUM((A.SALE_PRICE*FSM_GOAL_COST_RATE_FUN(A.UPJANG,A.HALL_CD,A.MENU_DATE,A.MENU_CD)/100)*A.EXPECT_MEAL_QTY) GOAL_COST                                                     \n");
		sbSql.append("                     , SUM((A.SALE_PRICE*CASE WHEN NVL(V1.CATER_YN,'N') = 'N' THEN NVL(V2.GOAL_COST_RATE,0) ELSE NVL(V3.GOAL_COST_RATE,0) END /100)*A.EXPECT_MEAL_QTY) GOAL_COST                                                     \n");
		sbSql.append("                     , 0 EXPECT_COST                                                                                                                                                            \n");
		sbSql.append("                  FROM FSM_REAL_MENU_MST A                                                                                                                                                      \n");
		sbSql.append("                     , SCC_COMMON_CODE B                                                                                                                                                        \n");
		sbSql.append("                     , FSA_HALL_MST F  --추가                                                                                                                                                   \n");
		sbSql.append("                     , FSA_HALL_MST V1                                                                                                                                                   \n");
		sbSql.append("                     , FSM_GOAL_COST_RATE V2                                                                                                                                                   \n");
		sbSql.append("                     , FSM_REAL_MENU_MST V3                                                                                                                                      \n");
		sbSql.append("                 WHERE SUBSTR(A.HALL_CD,1,3) = B.CODE                                                                                                                                           \n");
		sbSql.append("                   AND A.UPJANG    = F.UPJANG  --추가                                                                                                                                           \n");
		sbSql.append("                   AND A.HALL_CD = F.HALL_CD                                                                                                                                                    \n");
		sbSql.append("                   AND B.GROUP_CODE= 'FS0019'                                                                                                                                                   \n");
		sbSql.append("                   AND A.MENU_DATE BETWEEN '"+FROM+"' AND '"+TO+"'                                                                                                                            	\n");
		sbSql.append("                   AND (B.ATTR02 <> 'Y' )                                                                                                                                                          \n");
		//식단의 자재가 있을 경우에 한해 예상 매출액 산출
		//sbSql.append("                   AND EXISTS (SELECT 1 FROM FSM_REAL_RECIPE_ITEM X WHERE X.UPJANG = A.UPJANG AND X.MENU_CD = A.MENU_CD AND ROWNUM = 1)                                                  \n   ");
		sbSql.append("                   AND EXISTS (SELECT 1 FROM FSM_REAL_RECIPE_ITEM X WHERE X.UPJANG = A.UPJANG AND X.MENU_CD = A.MENU_CD)                 \n   ");
		sbSql.append("                   AND V1.UPJANG(+) = A.UPJANG                 \n   ");
		sbSql.append("                   AND V1.HALL_CD(+) = A.HALL_CD                 \n   ");
		sbSql.append("                   AND V2.UPJANG(+) = A.UPJANG                 \n   ");
		sbSql.append("                   AND V2.HALL_CD(+) = A.HALL_CD                 \n   ");
		sbSql.append("                   AND V2.MENU_DATE(+) = A.MENU_DATE                 \n   ");
		sbSql.append("                   AND V3.UPJANG(+) = A.UPJANG            \n   ");
		sbSql.append("                   AND V3.MENU_CD(+) = A.MENU_CD               \n   ");
		sbSql.append("                 GROUP BY A.UPJANG, A.HALL_CD, F.HALL_NAME, F.REMARK --추가                                                                                                                     \n");
		sbSql.append("                UNION ALL                                                                                                                                                                       \n");
		sbSql.append("                SELECT /*+ LEADING(A B F) USE_HASH(A B F) USE_HASH(V1) USE_HASH(V2) USE_HASH(V3) */ A.UPJANG, A.HALL_CD, F.HALL_NAME || F.REMARK HALL_NAME --추가                                                                                                                                  \n");
		sbSql.append("                     , SUM(C.SALE_PRICE*C.EXPECT_SALE_QTY) SALE_AMT                                                                                                                             \n");
		//sbSql.append("                     , SUM((C.SALE_PRICE*FSM_GOAL_COST_RATE_FUN(A.UPJANG,A.HALL_CD,A.MENU_DATE,A.MENU_CD)/100)*C.EXPECT_SALE_QTY) GOAL_COST                                                                                                     \n");
		sbSql.append("                     , SUM((C.SALE_PRICE*CASE WHEN NVL(V1.CATER_YN,'N') = 'N' THEN NVL(V2.GOAL_COST_RATE,0) ELSE NVL(V3.GOAL_COST_RATE,0) END /100)*C.EXPECT_SALE_QTY) GOAL_COST                     \n");
		sbSql.append("                     , 0 EXPECT_COST                                                                                                                                                            \n");
		sbSql.append("                  FROM FSM_REAL_MENU_MST A                                                                                                                                                      \n");
		sbSql.append("                     , SCC_COMMON_CODE B                                                                                                                                                        \n");
		sbSql.append("                     , FSM_REAL_RECIPE_MST C                                                                                                                                                    \n");
		sbSql.append("                     , FSA_HALL_MST F  --추가                                                                                                                                                   \n");
		
		sbSql.append("                     , FSA_HALL_MST V1                                                                                                                                                   \n");
		sbSql.append("                     , FSM_GOAL_COST_RATE V2                                                                                                                                                 \n");
		sbSql.append("                     , FSM_REAL_MENU_MST V3                                                                                                                                             \n");
		sbSql.append("                 WHERE SUBSTR(A.HALL_CD,1,3) = B.CODE                                                                                                                                           \n");
		sbSql.append("                   AND A.UPJANG    = C.UPJANG                                                                                                                                                   \n");
		sbSql.append("                   AND A.MENU_CD   = C.MENU_CD                                                                                                                                                  \n");
		sbSql.append("                   AND A.UPJANG    = F.UPJANG  --추가                                                                                                                                           \n");
		sbSql.append("                   AND A.HALL_CD   = F.HALL_CD --추가                                                                                                                                           \n");
		sbSql.append("                   AND B.GROUP_CODE= 'FS0019'                                                                                                                                                   \n");
		sbSql.append("                   AND A.MENU_DATE BETWEEN '"+FROM+"' AND '"+TO+"'                                                                                                                            		\n");
		sbSql.append("                   AND (B.ATTR02 = 'Y' )                                                                                                                                                        \n");
		//식단의 자재가 있을 경우에 한해 예상 매출액 산출
		sbSql.append("                   AND EXISTS (SELECT 1 FROM FSM_REAL_RECIPE_ITEM X WHERE X.UPJANG = A.UPJANG AND X.MENU_CD = A.MENU_CD AND ROWNUM = 1)                                                  \n   ");
		sbSql.append("                   AND V1.UPJANG(+) = A.UPJANG                                                  \n   ");
		sbSql.append("                   AND V1.HALL_CD(+) = A.HALL_CD                                                 \n   ");
		sbSql.append("                   AND V2.UPJANG(+) = A.UPJANG                                                  \n   ");
		sbSql.append("                   AND V2.HALL_CD(+) = A.HALL_CD                                                  \n   ");
		sbSql.append("                   AND V2.MENU_DATE(+) = A.MENU_DATE                                                  \n   ");
		sbSql.append("                   AND V3.UPJANG(+) = A.UPJANG                                              \n   ");
		sbSql.append("                   AND V3.MENU_CD(+) = A.MENU_CD                                                 \n   ");
		sbSql.append("                 GROUP BY A.UPJANG, A.HALL_CD, F.HALL_NAME, F.REMARK --추가                                                                                                                     \n");
		sbSql.append("                UNION ALL                                                                                                                                                                       \n");
		sbSql.append("                SELECT UPJANG \n");
		sbSql.append("                     , HALL_CD \n");
		sbSql.append("                     , HALL_NAME \n");
		sbSql.append("                     , 0 SALE_AMT \n");
		sbSql.append("                     , 0 GOAL_COST \n");
		sbSql.append("                     , SUM(EXPECT_COST) EXPECT_COST \n");
		sbSql.append("                  FROM ( \n");
		sbSql.append("                        SELECT UPJANG \n");
		sbSql.append("                             , MENU_DATE \n");
		sbSql.append("                             , HALL_CD \n");
		sbSql.append("                             , HALL_NAME \n");
		sbSql.append("                             , MENU_CD \n");
		sbSql.append("                             , RECIPE_CD \n");
		sbSql.append("                             , ROUND(SUM(EXPECT_COST)) * QTY EXPECT_COST \n");
		sbSql.append("                          FROM ( \n");
		sbSql.append("                                SELECT A.UPJANG \n");
		sbSql.append("                                     , A.MENU_CD \n");
		sbSql.append("                                     , A.MENU_DATE \n");
		sbSql.append("                                     , A.HALL_CD, A.HALL_NAME \n");
		sbSql.append("                                     , A.RECIPE_CD \n");
		sbSql.append("                                     , DECODE(A.ATTR02,'Y', A.EXPECT_SALE_QTY, DECODE(A.SET3, 'Y', A.EXPECT_SALE_QTY, A.EXPECT_MEAL_QTY)) QTY \n");
		sbSql.append("                                     , A.NEED_QTY*ROUND((A.MARGIN_PRICE/A.KG_CONVERT_RATE/1000),2) EXPECT_COST \n");
		sbSql.append("                                  FROM SQL2 A \n");
		sbSql.append("                               ) \n");
		sbSql.append("                        GROUP BY UPJANG, MENU_DATE, HALL_CD, HALL_NAME, MENU_CD, RECIPE_CD, QTY \n");
		sbSql.append("                       ) \n");
		sbSql.append("                 GROUP BY UPJANG, HALL_CD, HALL_NAME \n");
		sbSql.append("                )                                                                                                                                                                               \n");
		sbSql.append("         GROUP BY UPJANG, HALL_CD, HALL_NAME                                                                                                                                                    \n");
		//sbSql.append("         HAVING DECODE(SUM(SALE_AMT),0,0,SUM(EXPECT_COST) / SUM(SALE_AMT)) > 0                                                                                                                             	\n");
		sbSql.append("         UNION ALL                                                                                                                                                                              \n");
		sbSql.append("         SELECT UPJANG, '99999' HALL_CD, '평균' HALL_NAME                                                                                                                                       \n");
		sbSql.append("             , ROUND(DECODE(SUM(SALE_AMT),0,0,SUM(GOAL_COST) / SUM(SALE_AMT))*100,1) GOAL                                                                                                       \n");
		sbSql.append("             , ROUND(DECODE(SUM(SALE_AMT),0,0,SUM(EXPECT_COST) / SUM(SALE_AMT))*100,1) EXPECT                                                                                                   \n");
		sbSql.append("          FROM (                                                                                                                                                                                \n");
		sbSql.append("                SELECT /*+ LEADING(A B) USE_HASH(A B) USE_HASH(V1) USE_HASH(V2) USE_HASH(V3)  */ A.UPJANG, A.MENU_CD                                                                                                                                                      \n");
		sbSql.append("                     , SUM(A.SALE_PRICE * A.EXPECT_MEAL_QTY) SALE_AMT                                                                                                                           \n");
		//sbSql.append("                     , SUM((A.SALE_PRICE*FSM_GOAL_COST_RATE_FUN(A.UPJANG,A.HALL_CD,A.MENU_DATE,A.MENU_CD)/100)*A.EXPECT_MEAL_QTY) GOAL_COST                                                                                                     \n");
		
		sbSql.append("                     , SUM((A.SALE_PRICE*CASE WHEN NVL(V1.CATER_YN,'N') = 'N' THEN NVL(V2.GOAL_COST_RATE,0) ELSE NVL(V3.GOAL_COST_RATE,0) END /100)*A.EXPECT_MEAL_QTY) GOAL_COST  \n");
		sbSql.append("                     , 0 EXPECT_COST                                                                                                                                                            \n");
		sbSql.append("                  FROM FSM_REAL_MENU_MST A                                                                                                                                                      \n");
		sbSql.append("                     , SCC_COMMON_CODE B                                                                                                                                                        \n");
		
		sbSql.append("                     , FSA_HALL_MST V1                                                                                                                                                       \n");
		sbSql.append("                     , FSM_GOAL_COST_RATE V2                                                                                                                                                        \n");
		sbSql.append("                     , FSM_REAL_MENU_MST V3                                                                                                                                                        \n");
		
		sbSql.append("                 WHERE SUBSTR(A.HALL_CD,1,3) = B.CODE                                                                                                                                           \n");
		sbSql.append("                   AND B.GROUP_CODE= 'FS0019'                                                                                                                                                   \n");
		sbSql.append("                   AND A.MENU_DATE BETWEEN '"+FROM+"' AND '"+TO+"'                                                                                                                            \n");
		sbSql.append("                   AND (B.ATTR02 <> 'Y' )                                                                                                                                                          \n");
		//식단의 자재가 있을 경우에 한해 예상 매출액 산출
		sbSql.append("                   AND EXISTS (SELECT 1 FROM FSM_REAL_RECIPE_ITEM X WHERE X.UPJANG = A.UPJANG AND X.MENU_CD = A.MENU_CD )                                                  \n   ");
		sbSql.append("                   AND V1.UPJANG(+) = A.UPJANG                                                                                                                                                          \n");
		sbSql.append("                   AND V1.HALL_CD(+) = A.HALL_CD                                                                                                                                                         \n");
		sbSql.append("                   AND V2.UPJANG(+) = A.UPJANG                                                                                                                                                          \n");
		sbSql.append("                   AND V2.HALL_CD(+) = A.HALL_CD                                                                                                                                                         \n");
		sbSql.append("                   AND V2.MENU_DATE(+) = A.MENU_DATE                                                                                                                                                        \n");
		sbSql.append("                   AND V3.UPJANG(+) = A.UPJANG                                                                                                                                                   \n");
		sbSql.append("                   AND V3.MENU_CD(+) = A.MENU_CD                                                                                                                                                        \n");
		sbSql.append("                 GROUP BY A.UPJANG, A.MENU_CD                                                                                                                                                   \n");
		sbSql.append("                UNION ALL                                                                                                                                                                       \n");
		sbSql.append("                SELECT /*+ LEADING(A B C) USE_HASH(A B) USE_NL(C) USE_HASH(V1) USE_HASH(V2) USE_HASH(V3) */ A.UPJANG, A.MENU_CD                                                                                                                                                      \n");
		sbSql.append("                     , SUM(C.SALE_PRICE*C.EXPECT_SALE_QTY) SALE_AMT                                                                                                                             \n");
		//sbSql.append("                     , SUM((C.SALE_PRICE*FSM_GOAL_COST_RATE_FUN(A.UPJANG,A.HALL_CD,A.MENU_DATE,A.MENU_CD)/100)*C.EXPECT_SALE_QTY) GOAL_COST                                                                                                     \n");
		sbSql.append("                     , SUM((C.SALE_PRICE*CASE WHEN NVL(V1.CATER_YN,'N') = 'N' THEN NVL(V2.GOAL_COST_RATE,0) ELSE NVL(V3.GOAL_COST_RATE,0) END /100)*C.EXPECT_SALE_QTY) GOAL_COST    \n");
		sbSql.append("                     , 0 EXPECT_COST                                                                                                                                                            \n");
		sbSql.append("                  FROM FSM_REAL_MENU_MST A                                                                                                                                                      \n");
		sbSql.append("                     , SCC_COMMON_CODE B                                                                                                                                                        \n");
		sbSql.append("                     , FSM_REAL_RECIPE_MST C                                                                                                                                                    \n");
		sbSql.append("                     , FSA_HALL_MST V1                                                                                                                                                   \n");
		sbSql.append("                     , FSM_GOAL_COST_RATE V2                                                                                                                                                   \n");
		sbSql.append("                     , FSM_REAL_MENU_MST V3                                                                                                                                                   \n");
		sbSql.append("                 WHERE SUBSTR(A.HALL_CD,1,3) = B.CODE                                                                                                                                           \n");
		sbSql.append("                   AND A.UPJANG    = C.UPJANG                                                                                                                                                   \n");
		sbSql.append("                   AND A.MENU_CD   = C.MENU_CD                                                                                                                                                  \n");
		sbSql.append("                   AND B.GROUP_CODE= 'FS0019'                                                                                                                                                   \n");
		sbSql.append("                   AND A.MENU_DATE BETWEEN '"+FROM+"' AND '"+TO+"'                                                                                                                            	\n");
		sbSql.append("                   AND (B.ATTR02 = 'Y' )                                                                                                                                                        \n");
		//식단의 자재가 있을 경우에 한해 예상 매출액 산출
		sbSql.append("                   AND EXISTS (SELECT 1 FROM FSM_REAL_RECIPE_ITEM X WHERE X.UPJANG = A.UPJANG AND X.MENU_CD = A.MENU_CD AND ROWNUM = 1)                                                  \n   ");
		sbSql.append("                 AND V1.UPJANG(+) = A.UPJANG                                                                                                                                                  \n");
		sbSql.append("                 AND V1.HALL_CD(+) = A.HALL_CD                                                                                                                                                  \n");
		sbSql.append("                 AND V2.UPJANG(+) = A.UPJANG                                                                                                                                                   \n");
		sbSql.append("                 AND V2.HALL_CD(+) = A.HALL_CD                                                                                                                                                   \n");
		sbSql.append("                 AND V2.MENU_DATE(+) = A.MENU_DATE                                                                                                                                                 \n");
		sbSql.append("                 AND V3.UPJANG(+) = A.UPJANG                                                                                                                                                 \n");
		sbSql.append("                 AND V3.MENU_CD(+) = A.MENU_CD                                                                                                                                                   \n");
		sbSql.append("                 GROUP BY A.UPJANG, A.MENU_CD                                                                                                                                                   \n");
		sbSql.append("                UNION ALL                                                                                                                                                                       \n");
		sbSql.append("                SELECT UPJANG \n  ");
		sbSql.append("                     , MENU_CD \n  ");
		sbSql.append("                     , 0 SALE_AMT \n  ");
		sbSql.append("                     , 0 GOAL_COST \n  ");
		sbSql.append("                     , SUM(EXPECT_COST) EXPECT_COST \n  ");
		sbSql.append("                  FROM ( \n  ");
		sbSql.append("                        SELECT UPJANG \n  ");
		sbSql.append("                             , MENU_DATE \n  ");
		sbSql.append("                             , MENU_CD \n  ");
		sbSql.append("                             , RECIPE_CD \n  ");
		sbSql.append("                             , ROUND(SUM(EXPECT_COST)) * QTY EXPECT_COST \n  ");
		sbSql.append("                          FROM ( \n  ");
		sbSql.append("                                SELECT A.UPJANG \n  ");
		sbSql.append("                                     , A.MENU_CD \n  ");
		sbSql.append("                                     , A.MENU_DATE \n  ");
		sbSql.append("                                     , A.HALL_CD \n  ");
		sbSql.append("                                     , A.RECIPE_CD \n  ");
		sbSql.append("                                     , DECODE(A.ATTR02,'Y',A.EXPECT_SALE_QTY, DECODE(A.SET3, 'Y', A.EXPECT_SALE_QTY, A.EXPECT_MEAL_QTY)) QTY \n  ");
		sbSql.append("                                     , A.NEED_QTY*ROUND((A.MARGIN_PRICE/A.KG_CONVERT_RATE/1000),2) EXPECT_COST \n  ");
		sbSql.append("                                  FROM SQL1 A \n  ");
		sbSql.append("                               ) \n  ");
		sbSql.append("                        GROUP BY UPJANG, MENU_DATE, MENU_CD, RECIPE_CD, QTY \n  ");
		sbSql.append("                       ) \n  ");
		sbSql.append("                 GROUP BY UPJANG, MENU_CD \n  ");		
		sbSql.append("                 )                                                                                                                                                                        	\n");                                                                                                                                                     
		sbSql.append("          GROUP BY UPJANG                                                                                                                                                       			\n");                                                                                                                                                               
		sbSql.append("          HAVING DECODE(SUM(SALE_AMT),0,0,SUM(EXPECT_COST) / SUM(SALE_AMT)) > 0															\n");
		sbSql.append("         ) B       		\n");                                                                                                                                                                               
		sbSql.append("       , FSA_UPJANG_V C     		\n");                                                                                                                                                                      
		sbSql.append("  WHERE C.UPJANG = A.UPJANG(+)  		\n");                                                                                                                                                                  
		sbSql.append("    AND C.UPJANG = B.UPJANG   		\n");
		sbSql.append("    AND (C.TM_CD = '" + TM + "' OR C.PT_CD = '" + TM + "')		\n");
		if(!TEAM.equals(""))
		{
		sbSql.append("   AND C.SUBTEAM_MST_SABUN='"+TEAM+"'                                                                                                			\n");
		}
		if(!UPJANG.equals(""))
		{
		sbSql.append("   AND C.UPJANG='"+UPJANG+"'                                                                                             						\n");
		}
		if(!LEADER.equals(""))
		{
		sbSql.append("   AND C.LEADER_SABUN='"+LEADER+"'                                                                                               				\n");
		}
		sbSql.append("  ORDER BY NM_KOR, NM_LEADER, UPJANGNM, HALL_CD			\n"); 
		
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 

		DataSet ds_List = this.makeDataSet(rs,"ds_List");
		out_dl.add(ds_List);

	   	this.setResultMessage(0, "OK",out_vl);
	} catch(Exception ex) {
		   ex.printStackTrace();
	       this.setResultMessage(-1, ex.toString(),out_vl);
		} finally {
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
		}
		
	  proc_output(response,out,out_vl,out_dl);

%>