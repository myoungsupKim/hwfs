<%                                                                                                                                                                                                      
/*-----------------------------------------------------------------------------                                                                                                                         
■ 시스템명     : EIS                                                                                                                                                                     
■ 프로그램ID   : EIS10002P_S001.jsp                                                                                                                                                                    
■ 프로그램명   : 매출일보                                                                                                                                                 
■ 작성일자     : 2010-02-22                                                                                                                                                                           
■ 작성자       : 황승한                                                                                                                                                                                
■ 이력관리     : 2010-02-22                                                                                                                                                                            
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
		DataSet ds_Cond	= in_dl.get("ds_Cond");                                                                                                                                                  
	                                                                                                                                                                                                        
	  	String str_STD_DATE 		= nullToBlank(ds_Cond.getString(0, "STD_DATE"));	  	
	  	String str_QueryGubun 		= nullToBlank(ds_Cond.getString(0, "QueryGubun"));
	  	String str_UnitGubun 		= nullToBlank(ds_Cond.getString(0, "UnitGubun"));

		if(conn != null && !conn.isClosed()) conn.close();
		
		conn = getIRISConn();
		
		
		//out 데이타
		DataSet ds_List;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		

		//내역조회
		if (str_QueryGubun.equals("전사")){
			
	        sbSql.append("    SELECT RESULT_DATE,   \n");
	        sbSql.append("           ALL_CODE,      \n");
	        sbSql.append("           ALL_NAME,      \n");
	        sbSql.append("           LEVEL1_CODE,   \n");
	        sbSql.append("           LEVEL1_NAME,   \n");
	        sbSql.append("           LEVEL2_CODE,   \n");
	        sbSql.append("           LEVEL2_NAME,   \n");
	        sbSql.append("           LEVEL4_CODE,   \n");
	        sbSql.append("           LEVEL4_NAME,   \n");
	        sbSql.append("           CURR_PLAN,     \n");
	        sbSql.append("           CURR_RLT,      \n");
	        sbSql.append("           CURR_PLAN_RATIO, \n");
	        sbSql.append("           CURR_RLT_BEFORE, \n");
	        sbSql.append("           CURR_RLT_BEFORE_RATIO, \n");
	        sbSql.append("           ACCUM_PLAN,ACCUM_RLT, \n");
	        sbSql.append("           ACCUM_PLAN_RATIO, \n");
	        sbSql.append("           ACCUM_RLT_BEFORE, \n");
	        sbSql.append("           ACCUM_RLT_BEFORE_RATIO, \n");
	        sbSql.append("           SORT_GUBUN     \n");
	        sbSql.append("      FROM (              \n");	
	        sbSql.append("SELECT    '" + nullToBlank(ds_Cond.getString(0, "STD_DATE")) + "' RESULT_DATE,                                                                                         \n");
	        sbSql.append("           'A' ALL_CODE,                                                                                              \n");
	        sbSql.append("           'A' ALL_NAME,                                                                                              \n");
			sbSql.append("           V.LEVEL1_CODE,                                                                                              \n");
	        sbSql.append("           V.LEVEL1_NAME,                                                                                              \n");
	        sbSql.append("           V.LEVEL2_CODE,                                                                                              \n");
	        sbSql.append("           V.LEVEL2_NAME,                                                                                              \n");
	        sbSql.append("           V.LEVEL4_CODE,                                                                                              \n");
	        sbSql.append("           V.LEVEL4_NAME,                                                                                              \n");
	        sbSql.append("           NVL(SUM(A.NUM_COL1), 0)/" + nullToBlank(str_UnitGubun) + " CURR_PLAN,                                                                          \n");
	        sbSql.append("           NVL(SUM(A.NUM_COL2), 0)/" + nullToBlank(str_UnitGubun) + " CURR_RLT,                                                                           \n");
	        sbSql.append("           DECODE(NVL(SUM(A.NUM_COL1), 0), 0, 0, NVL(SUM(A.NUM_COL2), 0)/NVL(SUM(A.NUM_COL1), 0)) * 100 CURR_PLAN_RATIO, \n");
	        sbSql.append("           NVL(SUM(A.NUM_COL3), 0)/" + nullToBlank(str_UnitGubun) + " CURR_RLT_BEFORE,                                                                    \n");
	        sbSql.append("           DECODE(NVL(SUM(A.NUM_COL3), 0), 0, 0, NVL(SUM(A.NUM_COL2), 0)/NVL(SUM(A.NUM_COL3), 0)) * 100 CURR_RLT_BEFORE_RATIO, \n");
	        sbSql.append("           NVL(SUM(A.NUM_COL4), 0)/" + nullToBlank(str_UnitGubun) + " ACCUM_PLAN,                                                                         \n");
	        sbSql.append("           NVL(SUM(A.NUM_COL5), 0)/" + nullToBlank(str_UnitGubun) + " ACCUM_RLT,                                                                          \n");
	        sbSql.append("           DECODE(NVL(SUM(A.NUM_COL4), 0), 0, 0, NVL(SUM(A.NUM_COL5), 0)/NVL(SUM(A.NUM_COL4), 0)) * 100 ACCUM_PLAN_RATIO, \n");
	        sbSql.append("           NVL(SUM(A.NUM_COL6), 0)/" + nullToBlank(str_UnitGubun) + " ACCUM_RLT_BEFORE,                                                                   \n");
	        sbSql.append("           DECODE(NVL(SUM(A.NUM_COL6), 0), 0, 0, NVL(SUM(A.NUM_COL5), 0)/NVL(SUM(A.NUM_COL6), 0)) * 100 ACCUM_RLT_BEFORE_RATIO, \n");
	        sbSql.append("           MAX(V.SORT_GUBUN) SORT_GUBUN                                                                                 \n");
	        sbSql.append("      FROM (                                                                                                           \n");
	        sbSql.append("            SELECT ITEM_CD,                                                                                            \n");
	        sbSql.append("                   DESCRIPTION1 LEVEL1_CODE,                                                                           \n");
	        sbSql.append("                   DESCRIPTION2 LEVEL1_NAME,                                                                           \n");
	        sbSql.append("                   DESCRIPTION3 LEVEL2_CODE,                                                                           \n");
	        sbSql.append("                   DESCRIPTION4 LEVEL2_NAME,                                                                           \n");
	        sbSql.append("                   DESCRIPTION5 LEVEL3_CODE,                                                                           \n");
	        sbSql.append("                   DESCRIPTION6 LEVEL3_NAME,                                                                           \n");
	        sbSql.append("                   DESCRIPTION7 LEVEL4_CODE,                                                                           \n");
	        sbSql.append("                   DESCRIPTION8 LEVEL4_NAME                                                                            \n");
	        sbSql.append("            FROM AL_BAEBU_CODE                                                                                         \n");
	        sbSql.append("            WHERE HEADER_CD = '101'                                                                                    \n");
	        sbSql.append("            AND   USE_YN    = 'Y'                                                                                      \n");
	        sbSql.append("           ) V_1,                                                                                                      \n");
	        sbSql.append("          (                                                                                                            \n");
	        sbSql.append("            SELECT ITEM_CD,                                                                                            \n");
	        sbSql.append("                   DESCRIPTION1 LEVEL1_CODE,                                                                           \n");
	        sbSql.append("                   DESCRIPTION2 LEVEL1_NAME,                                                                           \n");
	        sbSql.append("                   DESCRIPTION3 LEVEL2_CODE,                                                                           \n");
	        sbSql.append("                   DESCRIPTION4 LEVEL2_NAME,                                                                           \n");
	        sbSql.append("                   DESCRIPTION5 LEVEL3_CODE,                                                                           \n");
	        sbSql.append("                   DESCRIPTION6 LEVEL3_NAME,                                                                           \n");
	        sbSql.append("                   DESCRIPTION7 LEVEL4_CODE,                                                                           \n");
	        sbSql.append("                   DESCRIPTION8 LEVEL4_NAME,                                                                           \n");
	        sbSql.append("                   DESCRIPTION10 SORT_GUBUN                                                                            \n");
	        sbSql.append("            FROM AL_BAEBU_CODE                                                                                         \n");
	        sbSql.append("            WHERE HEADER_CD = '102'                                                                                    \n");
	        sbSql.append("            AND   USE_YN    = 'Y'                                                                                      \n");
	        sbSql.append("           ) V,                                                                                                        \n");	        
	        sbSql.append("           (SELECT * FROM EIS_SOURCE_RESULT WHERE  RESULT_DATE = '" + nullToBlank(ds_Cond.getString(0, "STD_DATE")) + "') A                                         \n");
	        sbSql.append("      WHERE (V_1.ITEM_CD     = V.ITEM_CD)                                                                         \n");
	        sbSql.append("      AND   (V_1.LEVEL1_CODE = A.LEVEL1_CODE(+))                                                                         \n");
	        sbSql.append("      AND   (V_1.LEVEL2_CODE = A.LEVEL2_CODE(+))                                                                         \n");
	        sbSql.append("      AND   (V_1.LEVEL3_CODE = A.LEVEL3_CODE(+))                                                                         \n");
	        sbSql.append("      AND   (V_1.LEVEL4_CODE = A.LEVEL4_CODE(+))                                                                         \n");
	        sbSql.append("      AND   (V.LEVEL1_CODE = 'A')                                                                                      \n");
	        sbSql.append("      GROUP BY V.LEVEL1_CODE, V.LEVEL1_NAME, V.LEVEL2_CODE, V.LEVEL2_NAME, V.LEVEL4_CODE, V.LEVEL4_NAME                \n");
	        sbSql.append("    UNION ALL                                                                                                          \n");
	        sbSql.append("    SELECT '" + nullToBlank(ds_Cond.getString(0, "STD_DATE")) + "' RESULT_DATE,                                                                                     \n");
	        sbSql.append("           'A' ALL_CODE,                                                                                              \n");
	        sbSql.append("           'A' ALL_NAME,                                                                                              \n");
	        sbSql.append("           V.LEVEL1_CODE,                                                                                              \n");
	        sbSql.append("           V.LEVEL1_NAME,                                                                                              \n");
	        sbSql.append("           V.LEVEL2_CODE,                                                                                              \n");
	        sbSql.append("           V.LEVEL2_NAME,                                                                                              \n");
	        sbSql.append("           '' LEVEL4_CODE,                                                                                             \n");
	        sbSql.append("           '' LEVEL4_NAME,                                                                                             \n");
	        sbSql.append("           NVL(SUM(A.NUM_COL1), 0)/" + nullToBlank(str_UnitGubun) + " 월계획,                                                                             \n");
	        sbSql.append("           NVL(SUM(A.NUM_COL2), 0)/" + nullToBlank(str_UnitGubun) + " 월실적누계,                                                                         \n");
	        sbSql.append("           DECODE(NVL(SUM(A.NUM_COL1), 0), 0, 0, NVL(SUM(A.NUM_COL2), 0)/NVL(SUM(A.NUM_COL1), 0)) * 100 월진도율,      \n");
	        sbSql.append("           NVL(SUM(A.NUM_COL3), 0)/" + nullToBlank(str_UnitGubun) + " 전년월실적누계,                                                                     \n");
	        sbSql.append("           DECODE(NVL(SUM(A.NUM_COL3), 0), 0, 0, NVL(SUM(A.NUM_COL2), 0)/NVL(SUM(A.NUM_COL3), 0)) * 100 월전년비,      \n");
	        sbSql.append("           NVL(SUM(A.NUM_COL4), 0)/" + nullToBlank(str_UnitGubun) + " 년누계계획,                                                                         \n");
	        sbSql.append("           NVL(SUM(A.NUM_COL5), 0)/" + nullToBlank(str_UnitGubun) + " 년누계실적,                                                                         \n");
	        sbSql.append("           DECODE(NVL(SUM(A.NUM_COL4), 0), 0, 0, NVL(SUM(A.NUM_COL5), 0)/NVL(SUM(A.NUM_COL4), 0)) * 100 년진도율,      \n");
	        sbSql.append("           NVL(SUM(A.NUM_COL6), 0)/" + nullToBlank(str_UnitGubun) + " 전년년누계실적,                                                                     \n");
	        sbSql.append("           DECODE(NVL(SUM(A.NUM_COL6), 0), 0, 0, NVL(SUM(A.NUM_COL5), 0)/NVL(SUM(A.NUM_COL6), 0)) * 100 년전년비,      \n");
	        sbSql.append("           MAX(V.SORT_GUBUN) SORT_GUBUN                                                                                \n");
	        sbSql.append("      FROM (                                                                                                           \n");
	        sbSql.append("            SELECT ITEM_CD,                                                                                            \n");
	        sbSql.append("                   DESCRIPTION1 LEVEL1_CODE,                                                                           \n");
	        sbSql.append("                   DESCRIPTION2 LEVEL1_NAME,                                                                           \n");
	        sbSql.append("                   DESCRIPTION3 LEVEL2_CODE,                                                                           \n");
	        sbSql.append("                   DESCRIPTION4 LEVEL2_NAME,                                                                           \n");
	        sbSql.append("                   DESCRIPTION5 LEVEL3_CODE,                                                                           \n");
	        sbSql.append("                   DESCRIPTION6 LEVEL3_NAME,                                                                           \n");
	        sbSql.append("                   DESCRIPTION7 LEVEL4_CODE,                                                                           \n");
	        sbSql.append("                   DESCRIPTION8 LEVEL4_NAME                                                                           \n");
	        sbSql.append("            FROM AL_BAEBU_CODE                                                                                         \n");
	        sbSql.append("            WHERE HEADER_CD = '101'                                                                                    \n");
	        sbSql.append("            AND   USE_YN    = 'Y'                                                                                      \n");
	        sbSql.append("           ) V_1,                                                                                                      \n");
	        sbSql.append("          (                                                                                                            \n");
	        sbSql.append("            SELECT ITEM_CD,                                                                                            \n");
	        sbSql.append("                   DESCRIPTION1 LEVEL1_CODE,                                                                           \n");
	        sbSql.append("                   DESCRIPTION2 LEVEL1_NAME,                                                                           \n");
	        sbSql.append("                   DESCRIPTION3 LEVEL2_CODE,                                                                           \n");
	        sbSql.append("                   DESCRIPTION4 LEVEL2_NAME,                                                                           \n");
	        sbSql.append("                   DESCRIPTION5 LEVEL3_CODE,                                                                           \n");
	        sbSql.append("                   DESCRIPTION6 LEVEL3_NAME,                                                                           \n");
	        sbSql.append("                   DESCRIPTION7 LEVEL4_CODE,                                                                           \n");
	        sbSql.append("                   DESCRIPTION8 LEVEL4_NAME,                                                                           \n");
	        sbSql.append("                   DESCRIPTION10 SORT_GUBUN                                                                            \n");
	        sbSql.append("            FROM AL_BAEBU_CODE                                                                                         \n");
	        sbSql.append("            WHERE HEADER_CD = '102'                                                                                    \n");
	        sbSql.append("            AND   USE_YN    = 'Y'                                                                                      \n");
	        sbSql.append("           ) V,                                                                                                        \n");	        
	        sbSql.append("           (SELECT * FROM EIS_SOURCE_RESULT WHERE  RESULT_DATE = '" + nullToBlank(ds_Cond.getString(0, "STD_DATE")) + "') A                                         \n");
	        sbSql.append("      WHERE (V_1.ITEM_CD     = V.ITEM_CD)                                                                         \n");
	        sbSql.append("      AND   (V_1.LEVEL1_CODE = A.LEVEL1_CODE(+))                                                                         \n");
	        sbSql.append("      AND   (V_1.LEVEL2_CODE = A.LEVEL2_CODE(+))                                                                         \n");
	        sbSql.append("      AND   (V_1.LEVEL3_CODE = A.LEVEL3_CODE(+))                                                                         \n");
	        sbSql.append("      AND   (V_1.LEVEL4_CODE = A.LEVEL4_CODE(+))                                                                         \n");
	        sbSql.append("      AND   (V.LEVEL1_CODE = 'C')                                                                                      \n");
	        sbSql.append("      GROUP BY V.LEVEL1_CODE, V.LEVEL1_NAME, V.LEVEL2_CODE, V.LEVEL2_NAME                                              \n");
	        sbSql.append("    UNION ALL                                                                                                          \n");
	        sbSql.append("    SELECT '" + nullToBlank(ds_Cond.getString(0, "STD_DATE")) + "' RESULT_DATE,                                                                                     \n");
	        sbSql.append("           'A' ALL_CODE,                                                                                              \n");
	        sbSql.append("           'A' ALL_NAME,                                                                                              \n");
	        sbSql.append("           V.LEVEL1_CODE,                                                                                              \n");
	        sbSql.append("           V.LEVEL1_NAME,                                                                                              \n");
	        sbSql.append("           V.LEVEL2_CODE,                                                                                              \n");
	        sbSql.append("           V.LEVEL2_NAME,                                                                                              \n");
	        sbSql.append("           '' LEVEL4_CODE,                                                                                             \n");
	        sbSql.append("           '' LEVEL4_NAME,                                                                                             \n");
	        sbSql.append("           NVL(SUM(A.NUM_COL1), 0)/" + nullToBlank(str_UnitGubun) + " 월계획,                                                                             \n");
	        sbSql.append("           NVL(SUM(A.NUM_COL2), 0)/" + nullToBlank(str_UnitGubun) + " 월실적누계,                                                                         \n");
	        sbSql.append("           DECODE(NVL(SUM(A.NUM_COL1), 0), 0, 0, NVL(SUM(A.NUM_COL2), 0)/NVL(SUM(A.NUM_COL1), 0)) * 100 월진도율,      \n");
	        sbSql.append("           NVL(SUM(A.NUM_COL3), 0)/" + nullToBlank(str_UnitGubun) + " 전년월실적누계,                                                                     \n");
	        sbSql.append("           DECODE(NVL(SUM(A.NUM_COL3), 0), 0, 0, NVL(SUM(A.NUM_COL2), 0)/NVL(SUM(A.NUM_COL3), 0)) * 100 월전년비,      \n");
	        sbSql.append("           NVL(SUM(A.NUM_COL4), 0)/" + nullToBlank(str_UnitGubun) + " 년누계계획,                                                                         \n");
	        sbSql.append("           NVL(SUM(A.NUM_COL5), 0)/" + nullToBlank(str_UnitGubun) + " 년누계실적,                                                                         \n");
	        sbSql.append("           DECODE(NVL(SUM(A.NUM_COL4), 0), 0, 0, NVL(SUM(A.NUM_COL5), 0)/NVL(SUM(A.NUM_COL4), 0)) * 100 년진도율,      \n");
	        sbSql.append("           NVL(SUM(A.NUM_COL6), 0)/" + nullToBlank(str_UnitGubun) + " 전년년누계실적,                                                                     \n");
	        sbSql.append("           DECODE(NVL(SUM(A.NUM_COL6), 0), 0, 0, NVL(SUM(A.NUM_COL5), 0)/NVL(SUM(A.NUM_COL6), 0)) * 100 년전년비,      \n");
	        sbSql.append("           MAX(V.SORT_GUBUN) SORT_GUBUN                                                                                \n");
	        sbSql.append("      FROM (                                                                                                           \n");
	        sbSql.append("            SELECT ITEM_CD,                                                                                            \n");
	        sbSql.append("                   DESCRIPTION1 LEVEL1_CODE,                                                                           \n");
	        sbSql.append("                   DESCRIPTION2 LEVEL1_NAME,                                                                           \n");
	        sbSql.append("                   DESCRIPTION3 LEVEL2_CODE,                                                                           \n");
	        sbSql.append("                   DESCRIPTION4 LEVEL2_NAME,                                                                           \n");
	        sbSql.append("                   DESCRIPTION5 LEVEL3_CODE,                                                                           \n");
	        sbSql.append("                   DESCRIPTION6 LEVEL3_NAME,                                                                           \n");
	        sbSql.append("                   DESCRIPTION7 LEVEL4_CODE,                                                                           \n");
	        sbSql.append("                   DESCRIPTION8 LEVEL4_NAME                                                                           \n");
	        sbSql.append("            FROM AL_BAEBU_CODE                                                                                         \n");
	        sbSql.append("            WHERE HEADER_CD = '101'                                                                                    \n");
	        sbSql.append("            AND   USE_YN    = 'Y'                                                                                      \n");
	        sbSql.append("           ) V_1,                                                                                                      \n");
	        sbSql.append("          (                                                                                                            \n");
	        sbSql.append("            SELECT ITEM_CD,                                                                                            \n");
	        sbSql.append("                   DESCRIPTION1 LEVEL1_CODE,                                                                           \n");
	        sbSql.append("                   DESCRIPTION2 LEVEL1_NAME,                                                                           \n");
	        sbSql.append("                   DESCRIPTION3 LEVEL2_CODE,                                                                           \n");
	        sbSql.append("                   DESCRIPTION4 LEVEL2_NAME,                                                                           \n");
	        sbSql.append("                   DESCRIPTION5 LEVEL3_CODE,                                                                           \n");
	        sbSql.append("                   DESCRIPTION6 LEVEL3_NAME,                                                                           \n");
	        sbSql.append("                   DESCRIPTION7 LEVEL4_CODE,                                                                           \n");
	        sbSql.append("                   DESCRIPTION8 LEVEL4_NAME,                                                                           \n");
	        sbSql.append("                   DESCRIPTION10 SORT_GUBUN                                                                            \n");
	        sbSql.append("            FROM AL_BAEBU_CODE                                                                                         \n");
	        sbSql.append("            WHERE HEADER_CD = '102'                                                                                    \n");
	        sbSql.append("            AND   USE_YN    = 'Y'                                                                                      \n");
	        sbSql.append("           ) V,                                                                                                        \n");	        
	        sbSql.append("           (SELECT * FROM EIS_SOURCE_RESULT WHERE  RESULT_DATE = '" + nullToBlank(ds_Cond.getString(0, "STD_DATE")) + "') A                                         \n");
	        sbSql.append("      WHERE (V_1.ITEM_CD     = V.ITEM_CD)                                                                         \n");
	        sbSql.append("      AND   (V_1.LEVEL1_CODE = A.LEVEL1_CODE(+))                                                                         \n");
	        sbSql.append("      AND   (V_1.LEVEL2_CODE = A.LEVEL2_CODE(+))                                                                         \n");
	        sbSql.append("      AND   (V_1.LEVEL3_CODE = A.LEVEL3_CODE(+))                                                                         \n");
	        sbSql.append("      AND   (V_1.LEVEL4_CODE = A.LEVEL4_CODE(+))                                                                         \n");
	        sbSql.append("      AND   (V.LEVEL1_CODE = 'B')                                                                                      \n");
	        sbSql.append("      GROUP BY V.LEVEL1_CODE, V.LEVEL1_NAME, V.LEVEL2_CODE, V.LEVEL2_NAME                                              \n");		
	        sbSql.append("      )                                       \n");
	        sbSql.append("      ORDER BY LEVEL1_CODE, TO_NUMBER(SORT_GUBUN) \n");
	        
		}		
		else if (str_QueryGubun.equals("리조트부문")){
			
	
	        sbSql.append("SELECT    '" + nullToBlank(ds_Cond.getString(0, "STD_DATE")) + "' RESULT_DATE,                                                                                         \n");
	        sbSql.append("           'A' ALL_CODE,                                                                                              \n");
	        sbSql.append("           'A' ALL_NAME,                                                                                              \n");
			sbSql.append("           V.LEVEL1_CODE,                                                                                              \n");
	        sbSql.append("           V.LEVEL1_NAME,                                                                                              \n");
	        sbSql.append("           V.LEVEL2_CODE,                                                                                              \n");
	        sbSql.append("           V.LEVEL2_NAME,                                                                                              \n");
	        sbSql.append("           V.LEVEL3_CODE,                                                                                              \n");
	        sbSql.append("           V.LEVEL3_NAME,                                                                                              \n");
	        sbSql.append("           V.LEVEL4_CODE,                                                                                              \n");
	        sbSql.append("           V.LEVEL4_NAME,                                                                                              \n");
	        sbSql.append("           NVL(SUM(A.NUM_COL1), 0)/" + nullToBlank(str_UnitGubun) + " CURR_PLAN,                                                                          \n");
	        sbSql.append("           NVL(SUM(A.NUM_COL2), 0)/" + nullToBlank(str_UnitGubun) + " CURR_RLT,                                                                           \n");
	        sbSql.append("           DECODE(NVL(SUM(A.NUM_COL1), 0), 0, 0, NVL(SUM(A.NUM_COL2), 0)/NVL(SUM(A.NUM_COL1), 0)) * 100 CURR_PLAN_RATIO, \n");
	        sbSql.append("           NVL(SUM(A.NUM_COL3), 0)/" + nullToBlank(str_UnitGubun) + " CURR_RLT_BEFORE,                                                                    \n");
	        sbSql.append("           DECODE(NVL(SUM(A.NUM_COL3), 0), 0, 0, NVL(SUM(A.NUM_COL2), 0)/NVL(SUM(A.NUM_COL3), 0)) * 100 CURR_RLT_BEFORE_RATIO, \n");
	        sbSql.append("           NVL(SUM(A.NUM_COL4), 0)/" + nullToBlank(str_UnitGubun) + " ACCUM_PLAN,                                                                         \n");
	        sbSql.append("           NVL(SUM(A.NUM_COL5), 0)/" + nullToBlank(str_UnitGubun) + " ACCUM_RLT,                                                                          \n");
	        sbSql.append("           DECODE(NVL(SUM(A.NUM_COL4), 0), 0, 0, NVL(SUM(A.NUM_COL5), 0)/NVL(SUM(A.NUM_COL4), 0)) * 100 ACCUM_PLAN_RATIO, \n");
	        sbSql.append("           NVL(SUM(A.NUM_COL6), 0)/" + nullToBlank(str_UnitGubun) + " ACCUM_RLT_BEFORE,                                                                   \n");
	        sbSql.append("           DECODE(NVL(SUM(A.NUM_COL6), 0), 0, 0, NVL(SUM(A.NUM_COL5), 0)/NVL(SUM(A.NUM_COL6), 0)) * 100 ACCUM_RLT_BEFORE_RATIO, \n");
	        sbSql.append("           MAX(V.SORT_GUBUN) SORT_GUBUN,                                                                                 \n");
	        sbSql.append("           V.LEVEL1_CODE||'-'||V.LEVEL2_CODE||'-'||V.LEVEL3_CODE||'-'||V.LEVEL4_CODE PL_CD, \n");
	        sbSql.append("           '1' PL_UP_CD,                           \n");
	        sbSql.append("           '0' BL_SHOW,                            \n");
	        sbSql.append("           3 LEVEL_NO,                             \n");
	        sbSql.append("           '+' BL_PLUS                             \n");	
	        sbSql.append("      FROM (                                                                                                           \n");
	        sbSql.append("            SELECT ITEM_CD,                                                                                            \n");
	        sbSql.append("                   DESCRIPTION1 LEVEL1_CODE,                                                                           \n");
	        sbSql.append("                   DESCRIPTION2 LEVEL1_NAME,                                                                           \n");
	        sbSql.append("                   DESCRIPTION3 LEVEL2_CODE,                                                                           \n");
	        sbSql.append("                   DESCRIPTION4 LEVEL2_NAME,                                                                           \n");
	        sbSql.append("                   DESCRIPTION5 LEVEL3_CODE,                                                                           \n");
	        sbSql.append("                   DESCRIPTION6 LEVEL3_NAME,                                                                           \n");
	        sbSql.append("                   DESCRIPTION7 LEVEL4_CODE,                                                                           \n");
	        sbSql.append("                   DESCRIPTION8 LEVEL4_NAME                                                                           \n");
	        sbSql.append("            FROM AL_BAEBU_CODE                                                                                         \n");
	        sbSql.append("            WHERE HEADER_CD = '101'                                                                                    \n");
	        sbSql.append("            AND   USE_YN    = 'Y'                                                                                      \n");
	        sbSql.append("           ) V_1,                                                                                                      \n");
	        sbSql.append("          (                                                                                                            \n");
	        sbSql.append("            SELECT ITEM_CD,                                                                                            \n");
	        sbSql.append("                   DESCRIPTION1 LEVEL1_CODE,                                                                           \n");
	        sbSql.append("                   DESCRIPTION2 LEVEL1_NAME,                                                                           \n");
	        sbSql.append("                   DESCRIPTION3 LEVEL2_CODE,                                                                           \n");
	        sbSql.append("                   DESCRIPTION4 LEVEL2_NAME,                                                                           \n");
	        sbSql.append("                   DESCRIPTION5 LEVEL3_CODE,                                                                           \n");
	        sbSql.append("                   DESCRIPTION6 LEVEL3_NAME,                                                                           \n");
	        sbSql.append("                   DESCRIPTION7 LEVEL4_CODE,                                                                           \n");
	        sbSql.append("                   DESCRIPTION8 LEVEL4_NAME,                                                                           \n");
	        sbSql.append("                   DESCRIPTION10 SORT_GUBUN                                                                            \n");
	        sbSql.append("            FROM AL_BAEBU_CODE                                                                                         \n");
	        sbSql.append("            WHERE HEADER_CD = '102'                                                                                    \n");
	        sbSql.append("            AND   USE_YN    = 'Y'                                                                                      \n");
	        sbSql.append("           ) V,                                                                                                        \n");	        
	        sbSql.append("           (SELECT * FROM EIS_SOURCE_RESULT WHERE  RESULT_DATE = '" + nullToBlank(ds_Cond.getString(0, "STD_DATE")) + "') A                                         \n");
	        sbSql.append("      WHERE (V_1.ITEM_CD     = V.ITEM_CD)                                                                         \n");
	        sbSql.append("      AND   (V_1.LEVEL1_CODE = A.LEVEL1_CODE(+))                                                                         \n");
	        sbSql.append("      AND   (V_1.LEVEL2_CODE = A.LEVEL2_CODE(+))                                                                         \n");
	        sbSql.append("      AND   (V_1.LEVEL3_CODE = A.LEVEL3_CODE(+))                                                                         \n");
	        sbSql.append("      AND   (V_1.LEVEL4_CODE = A.LEVEL4_CODE(+))                                                                         \n");
	        sbSql.append("      AND   (V.LEVEL1_CODE = 'A')                                                                                      \n");
	        sbSql.append("      GROUP BY V.LEVEL1_CODE, V.LEVEL1_NAME, V.LEVEL2_CODE, V.LEVEL2_NAME, V.LEVEL3_CODE, V.LEVEL3_NAME,  V.LEVEL4_CODE, V.LEVEL4_NAME                \n");
	        sbSql.append("      ORDER BY TO_NUMBER(SORT_GUBUN)                \n");	
		}		
		else if (str_QueryGubun.equals("FS부문")){
			
			
	        sbSql.append("SELECT    '" + nullToBlank(ds_Cond.getString(0, "STD_DATE")) + "' RESULT_DATE,                                                                                         \n");
	        sbSql.append("           'A' ALL_CODE,                                                                                              \n");
	        sbSql.append("           'A' ALL_NAME,                                                                                              \n");
			sbSql.append("           V.LEVEL1_CODE,                                                                                              \n");
	        sbSql.append("           V.LEVEL1_NAME,                                                                                              \n");
	        sbSql.append("           V.LEVEL2_CODE,                                                                                              \n");
	        sbSql.append("           V.LEVEL2_NAME,                                                                                              \n");
	        sbSql.append("           V.LEVEL3_CODE,                                                                                              \n");
	        sbSql.append("           V.LEVEL3_NAME,                                                                                              \n");
	        sbSql.append("           V.LEVEL4_CODE,                                                                                              \n");
	        sbSql.append("           V.LEVEL4_NAME,                                                                                              \n");
	        sbSql.append("           NVL(SUM(A.NUM_COL1), 0)/" + nullToBlank(str_UnitGubun) + " CURR_PLAN,                                                                          \n");
	        sbSql.append("           NVL(SUM(A.NUM_COL2), 0)/" + nullToBlank(str_UnitGubun) + " CURR_RLT,                                                                           \n");
	        sbSql.append("           DECODE(NVL(SUM(A.NUM_COL1), 0), 0, 0, NVL(SUM(A.NUM_COL2), 0)/NVL(SUM(A.NUM_COL1), 0)) * 100 CURR_PLAN_RATIO, \n");
	        sbSql.append("           NVL(SUM(A.NUM_COL3), 0)/" + nullToBlank(str_UnitGubun) + " CURR_RLT_BEFORE,                                                                    \n");
	        sbSql.append("           DECODE(NVL(SUM(A.NUM_COL3), 0), 0, 0, NVL(SUM(A.NUM_COL2), 0)/NVL(SUM(A.NUM_COL3), 0)) * 100 CURR_RLT_BEFORE_RATIO, \n");
	        sbSql.append("           NVL(SUM(A.NUM_COL4), 0)/" + nullToBlank(str_UnitGubun) + " ACCUM_PLAN,                                                                         \n");
	        sbSql.append("           NVL(SUM(A.NUM_COL5), 0)/" + nullToBlank(str_UnitGubun) + " ACCUM_RLT,                                                                          \n");
	        sbSql.append("           DECODE(NVL(SUM(A.NUM_COL4), 0), 0, 0, NVL(SUM(A.NUM_COL5), 0)/NVL(SUM(A.NUM_COL4), 0)) * 100 ACCUM_PLAN_RATIO, \n");
	        sbSql.append("           NVL(SUM(A.NUM_COL6), 0)/" + nullToBlank(str_UnitGubun) + " ACCUM_RLT_BEFORE,                                                                   \n");
	        sbSql.append("           DECODE(NVL(SUM(A.NUM_COL6), 0), 0, 0, NVL(SUM(A.NUM_COL5), 0)/NVL(SUM(A.NUM_COL6), 0)) * 100 ACCUM_RLT_BEFORE_RATIO, \n");
	        sbSql.append("           MAX(V.SORT_GUBUN) SORT_GUBUN,                                                                                 \n");
	        sbSql.append("           V.LEVEL1_CODE||'-'||V.LEVEL2_CODE||'-'||V.LEVEL3_CODE||'-'||V.LEVEL4_CODE PL_CD, \n");
	        sbSql.append("           '1' PL_UP_CD,                           \n");
	        sbSql.append("           '0' BL_SHOW,                            \n");
	        sbSql.append("           3 LEVEL_NO,                             \n");
	        sbSql.append("           '+' BL_PLUS                             \n");	
	        sbSql.append("      FROM (                                                                                                           \n");
	        sbSql.append("            SELECT ITEM_CD,                                                                                            \n");
	        sbSql.append("                   DESCRIPTION1 LEVEL1_CODE,                                                                           \n");
	        sbSql.append("                   DESCRIPTION2 LEVEL1_NAME,                                                                           \n");
	        sbSql.append("                   DESCRIPTION3 LEVEL2_CODE,                                                                           \n");
	        sbSql.append("                   DESCRIPTION4 LEVEL2_NAME,                                                                           \n");
	        sbSql.append("                   DESCRIPTION5 LEVEL3_CODE,                                                                           \n");
	        sbSql.append("                   DESCRIPTION6 LEVEL3_NAME,                                                                           \n");
	        sbSql.append("                   DESCRIPTION7 LEVEL4_CODE,                                                                           \n");
	        sbSql.append("                   DESCRIPTION8 LEVEL4_NAME                                                                           \n");
	        sbSql.append("            FROM AL_BAEBU_CODE                                                                                         \n");
	        sbSql.append("            WHERE HEADER_CD = '101'                                                                                    \n");
	        sbSql.append("            AND   USE_YN    = 'Y'                                                                                      \n");
	        sbSql.append("           ) V_1,                                                                                                      \n");
	        sbSql.append("          (                                                                                                            \n");
	        sbSql.append("            SELECT ITEM_CD,                                                                                            \n");
	        sbSql.append("                   DESCRIPTION1 LEVEL1_CODE,                                                                           \n");
	        sbSql.append("                   DESCRIPTION2 LEVEL1_NAME,                                                                           \n");
	        sbSql.append("                   DESCRIPTION3 LEVEL2_CODE,                                                                           \n");
	        sbSql.append("                   DESCRIPTION4 LEVEL2_NAME,                                                                           \n");
	        sbSql.append("                   DESCRIPTION5 LEVEL3_CODE,                                                                           \n");
	        sbSql.append("                   DESCRIPTION6 LEVEL3_NAME,                                                                           \n");
	        sbSql.append("                   DESCRIPTION7 LEVEL4_CODE,                                                                           \n");
	        sbSql.append("                   DESCRIPTION8 LEVEL4_NAME,                                                                           \n");
	        sbSql.append("                   DESCRIPTION10 SORT_GUBUN                                                                            \n");
	        sbSql.append("            FROM AL_BAEBU_CODE                                                                                         \n");
	        sbSql.append("            WHERE HEADER_CD = '102'                                                                                    \n");
	        sbSql.append("            AND   USE_YN    = 'Y'                                                                                      \n");
	        sbSql.append("           ) V,                                                                                                        \n");	        
	        sbSql.append("           (SELECT * FROM EIS_SOURCE_RESULT WHERE  RESULT_DATE = '" + nullToBlank(ds_Cond.getString(0, "STD_DATE")) + "') A                                         \n");
	        sbSql.append("      WHERE (V_1.ITEM_CD     = V.ITEM_CD)                                                                         \n");
	        sbSql.append("      AND   (V_1.LEVEL1_CODE = A.LEVEL1_CODE(+))                                                                         \n");
	        sbSql.append("      AND   (V_1.LEVEL2_CODE = A.LEVEL2_CODE(+))                                                                         \n");
	        sbSql.append("      AND   (V_1.LEVEL3_CODE = A.LEVEL3_CODE(+))                                                                         \n");
	        sbSql.append("      AND   (V_1.LEVEL4_CODE = A.LEVEL4_CODE(+))                                                                         \n");
	        sbSql.append("      AND   (V.LEVEL1_CODE = 'C')                                                                                      \n");
	        sbSql.append("      GROUP BY V.LEVEL1_CODE, V.LEVEL1_NAME, V.LEVEL2_CODE, V.LEVEL2_NAME, V.LEVEL3_CODE, V.LEVEL3_NAME,  V.LEVEL4_CODE, V.LEVEL4_NAME                \n");
	        sbSql.append("      ORDER BY TO_NUMBER(SORT_GUBUN)                \n");	
		}		
		else if (str_QueryGubun.equals("호텔부문")){
			
			
	        sbSql.append("SELECT    '" + nullToBlank(ds_Cond.getString(0, "STD_DATE")) + "' RESULT_DATE,                                                                                         \n");
	        sbSql.append("           'A' ALL_CODE,                                                                                              \n");
	        sbSql.append("           'A' ALL_NAME,                                                                                              \n");
			sbSql.append("           V.LEVEL1_CODE,                                                                                              \n");
	        sbSql.append("           V.LEVEL1_NAME,                                                                                              \n");
	        sbSql.append("           V.LEVEL2_CODE,                                                                                              \n");
	        sbSql.append("           V.LEVEL2_NAME,                                                                                              \n");
	        sbSql.append("           V.LEVEL3_CODE,                                                                                              \n");
	        sbSql.append("           V.LEVEL3_NAME,                                                                                              \n");
	        sbSql.append("           V.LEVEL4_CODE,                                                                                              \n");
	        sbSql.append("           V.LEVEL4_NAME,                                                                                              \n");
	        sbSql.append("           NVL(SUM(A.NUM_COL1), 0)/" + nullToBlank(str_UnitGubun) + " CURR_PLAN,                                                                          \n");
	        sbSql.append("           NVL(SUM(A.NUM_COL2), 0)/" + nullToBlank(str_UnitGubun) + " CURR_RLT,                                                                           \n");
	        sbSql.append("           DECODE(NVL(SUM(A.NUM_COL1), 0), 0, 0, NVL(SUM(A.NUM_COL2), 0)/NVL(SUM(A.NUM_COL1), 0)) * 100 CURR_PLAN_RATIO, \n");
	        sbSql.append("           NVL(SUM(A.NUM_COL3), 0)/" + nullToBlank(str_UnitGubun) + " CURR_RLT_BEFORE,                                                                    \n");
	        sbSql.append("           DECODE(NVL(SUM(A.NUM_COL3), 0), 0, 0, NVL(SUM(A.NUM_COL2), 0)/NVL(SUM(A.NUM_COL3), 0)) * 100 CURR_RLT_BEFORE_RATIO, \n");
	        sbSql.append("           NVL(SUM(A.NUM_COL4), 0)/" + nullToBlank(str_UnitGubun) + " ACCUM_PLAN,                                                                         \n");
	        sbSql.append("           NVL(SUM(A.NUM_COL5), 0)/" + nullToBlank(str_UnitGubun) + " ACCUM_RLT,                                                                          \n");
	        sbSql.append("           DECODE(NVL(SUM(A.NUM_COL4), 0), 0, 0, NVL(SUM(A.NUM_COL5), 0)/NVL(SUM(A.NUM_COL4), 0)) * 100 ACCUM_PLAN_RATIO, \n");
	        sbSql.append("           NVL(SUM(A.NUM_COL6), 0)/" + nullToBlank(str_UnitGubun) + " ACCUM_RLT_BEFORE,                                                                   \n");
	        sbSql.append("           DECODE(NVL(SUM(A.NUM_COL6), 0), 0, 0, NVL(SUM(A.NUM_COL5), 0)/NVL(SUM(A.NUM_COL6), 0)) * 100 ACCUM_RLT_BEFORE_RATIO, \n");
	        sbSql.append("           MAX(V.SORT_GUBUN) SORT_GUBUN,                                                                                 \n");
	        sbSql.append("           V.LEVEL1_CODE||'-'||V.LEVEL2_CODE||'-'||V.LEVEL3_CODE||'-'||V.LEVEL4_CODE PL_CD, \n");
	        sbSql.append("           '1' PL_UP_CD,                           \n");
	        sbSql.append("           '0' BL_SHOW,                            \n");
	        sbSql.append("           3 LEVEL_NO,                             \n");
	        sbSql.append("           '+' BL_PLUS                             \n");	        
	        
	        sbSql.append("      FROM (                                                                                                           \n");
	        sbSql.append("            SELECT ITEM_CD,                                                                                            \n");
	        sbSql.append("                   DESCRIPTION1 LEVEL1_CODE,                                                                           \n");
	        sbSql.append("                   DESCRIPTION2 LEVEL1_NAME,                                                                           \n");
	        sbSql.append("                   DESCRIPTION3 LEVEL2_CODE,                                                                           \n");
	        sbSql.append("                   DESCRIPTION4 LEVEL2_NAME,                                                                           \n");
	        sbSql.append("                   DESCRIPTION5 LEVEL3_CODE,                                                                           \n");
	        sbSql.append("                   DESCRIPTION6 LEVEL3_NAME,                                                                           \n");
	        sbSql.append("                   DESCRIPTION7 LEVEL4_CODE,                                                                           \n");
	        sbSql.append("                   DESCRIPTION8 LEVEL4_NAME                                                                           \n");
	        sbSql.append("            FROM AL_BAEBU_CODE                                                                                         \n");
	        sbSql.append("            WHERE HEADER_CD = '101'                                                                                    \n");
	        sbSql.append("            AND   USE_YN    = 'Y'                                                                                      \n");
	        sbSql.append("           ) V_1,                                                                                                      \n");
	        sbSql.append("          (                                                                                                            \n");
	        sbSql.append("            SELECT ITEM_CD,                                                                                            \n");
	        sbSql.append("                   DESCRIPTION1 LEVEL1_CODE,                                                                           \n");
	        sbSql.append("                   DESCRIPTION2 LEVEL1_NAME,                                                                           \n");
	        sbSql.append("                   DESCRIPTION3 LEVEL2_CODE,                                                                           \n");
	        sbSql.append("                   DESCRIPTION4 LEVEL2_NAME,                                                                           \n");
	        sbSql.append("                   DESCRIPTION5 LEVEL3_CODE,                                                                           \n");
	        sbSql.append("                   DESCRIPTION6 LEVEL3_NAME,                                                                           \n");
	        sbSql.append("                   DESCRIPTION7 LEVEL4_CODE,                                                                           \n");
	        sbSql.append("                   DESCRIPTION8 LEVEL4_NAME,                                                                           \n");
	        sbSql.append("                   DESCRIPTION10 SORT_GUBUN                                                                            \n");
	        sbSql.append("            FROM AL_BAEBU_CODE                                                                                         \n");
	        sbSql.append("            WHERE HEADER_CD = '102'                                                                                    \n");
	        sbSql.append("            AND   USE_YN    = 'Y'                                                                                      \n");
	        sbSql.append("           ) V,                                                                                                        \n");	        
	        sbSql.append("           (SELECT * FROM EIS_SOURCE_RESULT WHERE  RESULT_DATE = '" + nullToBlank(ds_Cond.getString(0, "STD_DATE")) + "') A                                         \n");
	        sbSql.append("      WHERE (V_1.ITEM_CD     = V.ITEM_CD)                                                                         \n");
	        sbSql.append("      AND   (V_1.LEVEL1_CODE = A.LEVEL1_CODE(+))                                                                         \n");
	        sbSql.append("      AND   (V_1.LEVEL2_CODE = A.LEVEL2_CODE(+))                                                                         \n");
	        sbSql.append("      AND   (V_1.LEVEL3_CODE = A.LEVEL3_CODE(+))                                                                         \n");
	        sbSql.append("      AND   (V_1.LEVEL4_CODE = A.LEVEL4_CODE(+))                                                                         \n");
	        sbSql.append("      AND   (V.LEVEL1_CODE = 'B')                                                                                      \n");
	        sbSql.append("      GROUP BY V.LEVEL1_CODE, V.LEVEL1_NAME, V.LEVEL2_CODE, V.LEVEL2_NAME, V.LEVEL3_CODE, V.LEVEL3_NAME,  V.LEVEL4_CODE, V.LEVEL4_NAME                \n");
	        sbSql.append("      ORDER BY TO_NUMBER(SORT_GUBUN)                \n");	
		}		
		else if (str_QueryGubun.equals("매출추이")){
			
/*			
	        sbSql.append("SELECT    SUBSTR(V.LAST_DATE, 1, 6) RESULT_DATE,                                                                                         \n");
	        sbSql.append("           'A' ALL_CODE,                                                                                              \n");
	        sbSql.append("           'A' ALL_NAME,                                                                                              \n");
			sbSql.append("           V.LEVEL1_CODE,                                                                                              \n");
	        sbSql.append("           V.LEVEL1_NAME,                                                                                              \n");
	        sbSql.append("           V.LEVEL2_CODE,                                                                                              \n");
	        sbSql.append("           V.LEVEL2_NAME,                                                                                              \n");
	        sbSql.append("           V.LEVEL3_CODE,                                                                                              \n");
	        sbSql.append("           V.LEVEL3_NAME,                                                                                              \n");
	        sbSql.append("           V.LEVEL4_CODE,                                                                                              \n");
	        sbSql.append("           V.LEVEL4_NAME,                                                                                              \n");
	        sbSql.append("           NVL(SUM(A.NUM_COL1), 0)/" + nullToBlank(str_UnitGubun) + " CURR_PLAN,                                                                          \n");
	        sbSql.append("           NVL(SUM(A.NUM_COL2), 0)/" + nullToBlank(str_UnitGubun) + " CURR_RLT,                                                                           \n");
	        sbSql.append("           DECODE(NVL(SUM(A.NUM_COL1), 0), 0, 0, NVL(SUM(A.NUM_COL2), 0)/NVL(SUM(A.NUM_COL1), 0)) * 100 CURR_PLAN_RATIO, \n");
	        sbSql.append("           NVL(SUM(A.NUM_COL3), 0)/" + nullToBlank(str_UnitGubun) + " CURR_RLT_BEFORE,                                                                    \n");
	        sbSql.append("           DECODE(NVL(SUM(A.NUM_COL3), 0), 0, 0, NVL(SUM(A.NUM_COL2), 0)/NVL(SUM(A.NUM_COL3), 0)) * 100 CURR_RLT_BEFORE_RATIO, \n");
	        sbSql.append("           NVL(SUM(A.NUM_COL4), 0)/" + nullToBlank(str_UnitGubun) + " ACCUM_PLAN,                                                                         \n");
	        sbSql.append("           NVL(SUM(A.NUM_COL5), 0)/" + nullToBlank(str_UnitGubun) + " ACCUM_RLT,                                                                          \n");
	        sbSql.append("           DECODE(NVL(SUM(A.NUM_COL4), 0), 0, 0, NVL(SUM(A.NUM_COL5), 0)/NVL(SUM(A.NUM_COL4), 0)) * 100 ACCUM_PLAN_RATIO, \n");
	        sbSql.append("           NVL(SUM(A.NUM_COL6), 0)/" + nullToBlank(str_UnitGubun) + " ACCUM_RLT_BEFORE,                                                                   \n");
	        sbSql.append("           DECODE(NVL(SUM(A.NUM_COL6), 0), 0, 0, NVL(SUM(A.NUM_COL5), 0)/NVL(SUM(A.NUM_COL6), 0)) * 100 ACCUM_RLT_BEFORE_RATIO, \n");
	        sbSql.append("           MAX(V.SORT_GUBUN) SORT_GUBUN,                                                                                 \n");
	        sbSql.append("           V.LEVEL1_CODE||'-'||V.LEVEL2_CODE||'-'||V.LEVEL3_CODE||'-'||V.LEVEL4_CODE PL_CD, \n");
	        sbSql.append("           '1' PL_UP_CD,                           \n");
	        sbSql.append("           '0' BL_SHOW,                            \n");
	        sbSql.append("           3 LEVEL_NO,                             \n");
	        sbSql.append("           '+' BL_PLUS                             \n");	        
	        
	        sbSql.append("      FROM (                                                                                                                           \n");
	        sbSql.append("            SELECT LEVEL1_CODE, LEVEL1_NAME, LEVEL2_CODE, LEVEL2_NAME, LEVEL3_CODE, LEVEL3_NAME, LEVEL4_CODE, LEVEL4_NAME, SORT_GUBUN, LAST_DATE \n");
	        sbSql.append("            FROM                                                                                                                       \n");
	        sbSql.append("                   (                                                                                                                   \n");
	        sbSql.append("                    SELECT ITEM_CD,                                                                                            \n");
	        sbSql.append("                           DESCRIPTION1 LEVEL1_CODE,                                                                           \n");
	        sbSql.append("                           DESCRIPTION2 LEVEL1_NAME,                                                                                   \n");
	        sbSql.append("                           DESCRIPTION3 LEVEL2_CODE,                                                                                   \n");
	        sbSql.append("                           DESCRIPTION4 LEVEL2_NAME,                                                                                   \n");
	        sbSql.append("                           DESCRIPTION5 LEVEL3_CODE,                                                                                   \n");
	        sbSql.append("                           DESCRIPTION6 LEVEL3_NAME,                                                                                   \n");
	        sbSql.append("                           DESCRIPTION7 LEVEL4_CODE,                                                                                   \n");
	        sbSql.append("                           DESCRIPTION8 LEVEL4_NAME,                                                                                   \n");
	        sbSql.append("                           DESCRIPTION10 SORT_GUBUN                                                                                    \n");
	        sbSql.append("                    FROM AL_BAEBU_CODE                                                                                                 \n");
	        sbSql.append("                    WHERE HEADER_CD = '101'                                                                                            \n");
	        sbSql.append("                    AND   USE_YN    = 'Y'                                                                                              \n");
	        sbSql.append("                   ),                                                                                                                  \n");
	        sbSql.append("                   (                                                                                                                   \n");
	        sbSql.append("                    SELECT TO_CHAR(LAST_DAY(TO_DATE('" + nullToBlank(ds_Cond.getString(0, "STD_DATE")) + "'||LPAD(ROWNUM,2,'0')||'01', 'YYYYMMDD')), 'YYYYMMDD') LAST_DATE              \n");
	        sbSql.append("                    FROM DICT                                                                                                          \n");
	        sbSql.append("                    WHERE ROWNUM <= 12                                                                                                 \n");
	        sbSql.append("                   )                                                                                                                   \n");
	        sbSql.append("           ) V_1,                                                                                                                        \n");
	        sbSql.append("          (                                                                                                            \n");
	        sbSql.append("            SELECT ITEM_CD,                                                                                            \n");
	        sbSql.append("                   DESCRIPTION1 LEVEL1_CODE,                                                                           \n");
	        sbSql.append("                   DESCRIPTION2 LEVEL1_NAME,                                                                           \n");
	        sbSql.append("                   DESCRIPTION3 LEVEL2_CODE,                                                                           \n");
	        sbSql.append("                   DESCRIPTION4 LEVEL2_NAME,                                                                           \n");
	        sbSql.append("                   DESCRIPTION5 LEVEL3_CODE,                                                                           \n");
	        sbSql.append("                   DESCRIPTION6 LEVEL3_NAME,                                                                           \n");
	        sbSql.append("                   DESCRIPTION7 LEVEL4_CODE,                                                                           \n");
	        sbSql.append("                   DESCRIPTION8 LEVEL4_NAME,                                                                           \n");
	        sbSql.append("                   DESCRIPTION10 SORT_GUBUN                                                                            \n");
	        sbSql.append("            FROM AL_BAEBU_CODE                                                                                         \n");
	        sbSql.append("            WHERE HEADER_CD = '102'                                                                                    \n");
	        sbSql.append("            AND   USE_YN    = 'Y'                                                                                      \n");
	        sbSql.append("           ) V,                                                                                                        \n");	        	     
	        sbSql.append("           (SELECT * FROM EIS_SOURCE_RESULT WHERE  RESULT_DATE BETWEEN '" + nullToBlank(ds_Cond.getString(0, "STD_DATE")) + "'||'0101' AND '" + nullToBlank(ds_Cond.getString(0, "STD_DATE")) + "'||'1231') A                            \n");
	        sbSql.append("      WHERE (V_1.ITEM_CD     = V.ITEM_CD)                                                                         \n");
	        sbSql.append("      AND   (V_1.LEVEL1_CODE = A.LEVEL1_CODE(+))                                                                         \n");
	        sbSql.append("      AND   (V_1.LEVEL2_CODE = A.LEVEL2_CODE(+))                                                                         \n");
	        sbSql.append("      AND   (V_1.LEVEL3_CODE = A.LEVEL3_CODE(+))                                                                         \n");
	        sbSql.append("      AND   (V_1.LEVEL4_CODE = A.LEVEL4_CODE(+))                                                                         \n");	 
	        sbSql.append("      AND   (V_1.LAST_DATE   = A.RESULT_DATE(+))                                                                                         \n");
	        sbSql.append("      AND   (V.LEVEL2_CODE = '01')                                                                                                     \n");
	        sbSql.append("      AND   (V.LEVEL3_CODE = '01')                                                                                                     \n");
	        sbSql.append("      AND   (V.LEVEL4_CODE = '01')                                                                                                     \n");
	        sbSql.append("      GROUP BY SUBSTR(V.LAST_DATE, 1, 6), V.LEVEL1_CODE, V.LEVEL1_NAME, V.LEVEL2_CODE, V.LEVEL2_NAME, V.LEVEL4_CODE, V.LEVEL4_NAME                   \n");

	    */

	        sbSql.append("SELECT     SUBSTR(V_1.LAST_DATE, 1, 6) RESULT_DATE,                                                                                         \n");
	        sbSql.append("           NVL(SUM(A.NUM_COL1), 0)/" + nullToBlank(str_UnitGubun) + " CURR_PLAN,                                                                          \n");
	        sbSql.append("           NVL(SUM(A.NUM_COL2), 0)/" + nullToBlank(str_UnitGubun) + " CURR_RLT,                                                                           \n");
	        sbSql.append("           DECODE(NVL(SUM(A.NUM_COL1), 0), 0, 0, NVL(SUM(A.NUM_COL2), 0)/NVL(SUM(A.NUM_COL1), 0)) * 100 CURR_PLAN_RATIO, \n");
	        sbSql.append("           NVL(SUM(A.NUM_COL3), 0)/" + nullToBlank(str_UnitGubun) + " CURR_RLT_BEFORE,                                                                    \n");
	        sbSql.append("           DECODE(NVL(SUM(A.NUM_COL3), 0), 0, 0, NVL(SUM(A.NUM_COL2), 0)/NVL(SUM(A.NUM_COL3), 0)) * 100 CURR_RLT_BEFORE_RATIO, \n");
	        sbSql.append("           NVL(SUM(A.NUM_COL4), 0)/" + nullToBlank(str_UnitGubun) + " ACCUM_PLAN,                                                                         \n");
	        sbSql.append("           NVL(SUM(A.NUM_COL5), 0)/" + nullToBlank(str_UnitGubun) + " ACCUM_RLT,                                                                          \n");
	        sbSql.append("           DECODE(NVL(SUM(A.NUM_COL4), 0), 0, 0, NVL(SUM(A.NUM_COL5), 0)/NVL(SUM(A.NUM_COL4), 0)) * 100 ACCUM_PLAN_RATIO, \n");
	        sbSql.append("           NVL(SUM(A.NUM_COL6), 0)/" + nullToBlank(str_UnitGubun) + " ACCUM_RLT_BEFORE,                                                                   \n");
	        sbSql.append("           DECODE(NVL(SUM(A.NUM_COL6), 0), 0, 0, NVL(SUM(A.NUM_COL5), 0)/NVL(SUM(A.NUM_COL6), 0)) * 100 ACCUM_RLT_BEFORE_RATIO \n");        
	        
	        sbSql.append("      FROM (                                                                                                                           \n");
	        sbSql.append("            SELECT ITEM_CD, LEVEL1_CODE, LEVEL1_NAME, LEVEL2_CODE, LEVEL2_NAME, LEVEL3_CODE, LEVEL3_NAME, LEVEL4_CODE, LEVEL4_NAME, SORT_GUBUN, LAST_DATE \n");
	        sbSql.append("            FROM                                                                                                                       \n");
	        sbSql.append("                   (                                                                                                                   \n");
	        sbSql.append("                    SELECT ITEM_CD,                                                                                            \n");
	        sbSql.append("                           DESCRIPTION1 LEVEL1_CODE,                                                                           \n");
	        sbSql.append("                           DESCRIPTION2 LEVEL1_NAME,                                                                                   \n");
	        sbSql.append("                           DESCRIPTION3 LEVEL2_CODE,                                                                                   \n");
	        sbSql.append("                           DESCRIPTION4 LEVEL2_NAME,                                                                                   \n");
	        sbSql.append("                           DESCRIPTION5 LEVEL3_CODE,                                                                                   \n");
	        sbSql.append("                           DESCRIPTION6 LEVEL3_NAME,                                                                                   \n");
	        sbSql.append("                           DESCRIPTION7 LEVEL4_CODE,                                                                                   \n");
	        sbSql.append("                           DESCRIPTION8 LEVEL4_NAME,                                                                                   \n");
	        sbSql.append("                           DESCRIPTION10 SORT_GUBUN                                                                                    \n");
	        sbSql.append("                    FROM AL_BAEBU_CODE                                                                                                 \n");
	        sbSql.append("                    WHERE HEADER_CD = '101'                                                                                            \n");
	        sbSql.append("                    AND   USE_YN    = 'Y'                                                                                              \n");
	        sbSql.append("                   ),                                                                                                                  \n");
	        sbSql.append("                   (                                                                                                                   \n");
	        sbSql.append("                    SELECT TO_CHAR(LAST_DAY(TO_DATE('" + nullToBlank(ds_Cond.getString(0, "STD_DATE")) + "'||LPAD(ROWNUM,2,'0')||'01', 'YYYYMMDD')), 'YYYYMMDD') LAST_DATE              \n");
	        sbSql.append("                    FROM DICT                                                                                                          \n");
	        sbSql.append("                    WHERE ROWNUM <= 12                                                                                                 \n");
	        sbSql.append("                   )                                                                                                                   \n");
	        sbSql.append("           ) V_1,                                                                                                                        \n");
	        sbSql.append("          (                                                                                                            \n");
	        sbSql.append("            SELECT ITEM_CD,                                                                                            \n");
	        sbSql.append("                   DESCRIPTION1 LEVEL1_CODE,                                                                           \n");
	        sbSql.append("                   DESCRIPTION2 LEVEL1_NAME,                                                                           \n");
	        sbSql.append("                   DESCRIPTION3 LEVEL2_CODE,                                                                           \n");
	        sbSql.append("                   DESCRIPTION4 LEVEL2_NAME,                                                                           \n");
	        sbSql.append("                   DESCRIPTION5 LEVEL3_CODE,                                                                           \n");
	        sbSql.append("                   DESCRIPTION6 LEVEL3_NAME,                                                                           \n");
	        sbSql.append("                   DESCRIPTION7 LEVEL4_CODE,                                                                           \n");
	        sbSql.append("                   DESCRIPTION8 LEVEL4_NAME,                                                                           \n");
	        sbSql.append("                   DESCRIPTION10 SORT_GUBUN                                                                            \n");
	        sbSql.append("            FROM AL_BAEBU_CODE                                                                                         \n");
	        sbSql.append("            WHERE HEADER_CD = '102'                                                                                    \n");
	        sbSql.append("            AND   USE_YN    = 'Y'                                                                                      \n");
	        sbSql.append("           ) V,                                                                                                        \n");	        	     
	        sbSql.append("           (SELECT * FROM EIS_SOURCE_RESULT WHERE  RESULT_DATE BETWEEN '" + nullToBlank(ds_Cond.getString(0, "STD_DATE")) + "'||'0101' AND '" + nullToBlank(ds_Cond.getString(0, "STD_DATE")) + "'||'1231') A                            \n");
	        sbSql.append("      WHERE (V_1.ITEM_CD     = V.ITEM_CD)                                                                         \n");
	        sbSql.append("      AND   (V_1.LEVEL1_CODE = A.LEVEL1_CODE(+))                                                                         \n");
	        sbSql.append("      AND   (V_1.LEVEL2_CODE = A.LEVEL2_CODE(+))                                                                         \n");
	        sbSql.append("      AND   (V_1.LEVEL3_CODE = A.LEVEL3_CODE(+))                                                                         \n");
	        sbSql.append("      AND   (V_1.LEVEL4_CODE = A.LEVEL4_CODE(+))                                                                         \n");	 
	        sbSql.append("      AND   (V_1.LAST_DATE   = A.RESULT_DATE(+))                                                                                         \n");	        //sbSql.append("      AND   (V.LEVEL2_CODE = '01')                                                                                                     \n");
	        //sbSql.append("      AND   (V.LEVEL3_CODE = '01')                                                                                                     \n");
	        //sbSql.append("      AND   (V.LEVEL4_CODE = '01')                                                                                                     \n");
	        if (nullToBlank(ds_Cond.getString(0, "BUGubun")).equals("X")){
	        	
	        	
	        }
	        else {
	        	
	        	sbSql.append("      AND   (V.LEVEL1_CODE = '" + nullToBlank(ds_Cond.getString(0, "BUGubun")) + "')                                         \n");	        	
	        }
	              
	        sbSql.append("      GROUP BY SUBSTR(V_1.LAST_DATE, 1, 6)                                                                                                      \n");
	    
	        
	        
		}	
		
		
		
		
		
out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_List = this.makeDataSet(rs, "ds_List");
		
		pstmt.close();
		rs.close();
		
		/**종료**/
		out_dl.add(ds_List);
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