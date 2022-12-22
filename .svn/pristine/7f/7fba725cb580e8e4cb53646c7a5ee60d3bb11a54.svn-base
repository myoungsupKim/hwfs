<%@page import="com.sz.util.AppDataUtility"%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	try	{
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));		
	
		String  g_Upjang			= in_vl.getString("g_Upjang");
		String  MENU_CD				= in_vl.getString("MENU_CD");
	
		DataSet ds_out;
		StringBuffer sbSql = new StringBuffer();
	
		sbSql.delete(0, sbSql.length());
		sbSql.append("SELECT D.IN_SEQ2,D.IN_SEQ,D.UPJANG, \n");
		sbSql.append("       D.MENU_CD, \n");
		sbSql.append("       D.RECIPE_CD, \n");
		sbSql.append("       D.RECIPE_NAME, \n");
		sbSql.append("       D.ORI_TYPE, \n");
		sbSql.append("       SUM(ROUND( D.NEED_QTY * (NVL(E.OP_PRICE,0) / E.KG_CONVERT_RATE / 1000) ) ) OP_PRICE, \n");
		sbSql.append("       SUM(NVL(F.CAL,0) ) CAL, \n");
		sbSql.append("       ROUND(SUM(NVL(F.CAL* D.NEED_QTY * (100-F.DISUSE_RATE) / 100,0) )/100,2) CAL_CALC \n");
		sbSql.append("  FROM \n");
		sbSql.append("       ( \n");
		sbSql.append("       SELECT B.IN_SEQ2,B.IN_SEQ,B.UPJANG, \n");
		sbSql.append("              B.MENU_CD, \n");
		sbSql.append("              B.RECIPE_CD, \n");
		sbSql.append("              B.RECIPE_NAME, \n");
		sbSql.append("              B.ORI_TYPE, \n");
		sbSql.append("              C.ITEM_CODE, \n");
		sbSql.append("              C.NEED_QTY \n");
		sbSql.append("         FROM FMM_STD_MENU A, \n");
		sbSql.append("              ( \n");
		sbSql.append("              SELECT B.CDATE IN_SEQ2,B.ROWID IN_SEQ,B.UPJANG, \n");
		sbSql.append("                     B.MENU_CD, \n");
		sbSql.append("                     B.RECIPE_CD, \n");
		sbSql.append("                     B.ORI_TYPE, \n");
		sbSql.append("                     D.RECIPE_NAME \n");
		sbSql.append("                FROM FMM_STD_MENU_RECIPE B , \n");
		sbSql.append("                     FMR_STD_RECIPE_MST D \n");
		sbSql.append("               WHERE B.RECIPE_CD=D.RECIPE_CD \n");
		sbSql.append("                 AND B.ORI_TYPE = 'FS' \n");
		sbSql.append("                 AND B.MENU_CD='"+MENU_CD+"' \n");
		sbSql.append("               UNION ALL \n");
		sbSql.append("              SELECT B.CDATE IN_SEQ2,B.ROWID IN_SEQ,B.UPJANG, \n");
		sbSql.append("                     B.MENU_CD, \n");
		sbSql.append("                     B.RECIPE_CD, \n");
		sbSql.append("                     B.ORI_TYPE, \n");
		sbSql.append("                     D.RECIPE_NAME \n");
		sbSql.append("                FROM FMM_STD_MENU_RECIPE B , \n");
		sbSql.append("                     FMM_STD_RECIPE_MST D \n");
		sbSql.append("               WHERE B.RECIPE_CD=D.RECIPE_CD \n");
		sbSql.append("                 AND B.UPJANG =D.UPJANG \n");
		sbSql.append("                 AND B.ORI_TYPE = 'FM' \n");
		sbSql.append("                 AND B.UPJANG="+g_Upjang+" \n");
		sbSql.append("                 AND B.MENU_CD='"+MENU_CD+"' \n");
		sbSql.append("              ) B, \n");
		sbSql.append("              ( \n");
		sbSql.append("              SELECT 0 AS UPJANG, \n");
		sbSql.append("                     RECIPE_CD, \n");
		sbSql.append("                     ITEM_CODE, \n");
		sbSql.append("                     NEED_QTY \n");
		sbSql.append("                FROM FMR_STD_RECIPE_ITEM \n");
		sbSql.append("               UNION ALL \n"); 
		sbSql.append("              SELECT UPJANG, \n");
		sbSql.append("                     RECIPE_CD, \n");
		sbSql.append("                     ITEM_CODE, \n");
		sbSql.append("                     NEED_QTY \n");
		sbSql.append("                FROM FMM_STD_RECIPE_ITEM \n");
		sbSql.append("               WHERE UPJANG="+g_Upjang+" \n");
		sbSql.append("              ) C, \n");
		sbSql.append("              FMS_ITEM_V D \n");
		sbSql.append("        WHERE A.UPJANG=B.UPJANG \n");
		sbSql.append("          AND A.MENU_CD=B.MENU_CD \n");
		sbSql.append("          AND B.RECIPE_CD=C.RECIPE_CD \n");
		sbSql.append("          AND A.UPJANG="+g_Upjang+" \n");
		sbSql.append("          AND A.MENU_CD='"+MENU_CD+"' \n");
		sbSql.append("          AND C.ITEM_CODE = D.ITEM_CODE \n");
		sbSql.append("       ) D, \n");
		sbSql.append("       ( \n");
		sbSql.append("       SELECT \n");
		sbSql.append("              A.UPJANG, A.ITEM_CODE, A.SALE_PRICE, A.KG_CONVERT_RATE, \n");
		sbSql.append("              NVL(NVL(C.OP_RATE, D.OP_RATE), 0) AS OP_RATE, --운영율 \n");
		sbSql.append("              CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
    	sbSql.append("                   THEN DECODE(SIGN(NVL(C.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE) \n");
    	sbSql.append("                   WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL \n");
    	sbSql.append("                   THEN DECODE(SIGN(NVL(D.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL), D.OP_PRICE) \n");
    	sbSql.append("              ELSE A.SALE_PRICE END AS OP_PRICE --운영단가 \n");
    	sbSql.append("         FROM \n");
		sbSql.append("              ( \n");
		sbSql.append("              SELECT \n");
		sbSql.append("              		"+g_Upjang+" AS UPJANG, \n");
		sbSql.append("              		TO_CHAR(SYSDATE,'YYYYMMDD') AS NEED_DATE , \n");
		sbSql.append("                      A.ITEM_CODE, \n");
		sbSql.append("                      A.SALE_PRICE, \n");
		sbSql.append("                      B.ITEM_CLASS4, \n");
		sbSql.append("                      B.KG_CONVERT_RATE \n");
		sbSql.append("                 FROM HLDC_PO_CONTRACT_FSALE A, HLDC_PO_ITEM_MST B, HLDC_ST_UPJANG C \n");
		sbSql.append("                WHERE A.ITEM_CODE = B.ITEM_CODE \n");
		sbSql.append("                  AND A.UPJANG = C.AP_UNITPRICE_UPJANG \n");
		sbSql.append("                  AND C.UPJANG = "+g_Upjang+" \n");
		sbSql.append("                  AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN A.CONTRACT_START AND NVL(A.CONTRACT_END, '99999999') \n");
		sbSql.append("                  AND A.SALE_PRICE > 0 \n");
		sbSql.append("                  AND A.USE_YN = 'Y' \n");
		sbSql.append("               ----------- \n");
		sbSql.append("                UNION ALL \n");
		sbSql.append("               ----------- \n");
		sbSql.append("               SELECT "+g_Upjang+" AS UPJANG, TO_CHAR(SYSDATE,'YYYYMMDD') AS NEED_DATE, A.ITEM_CODE, A.SALE_PRICE, \n");
		sbSql.append("                      B.ITEM_CLASS4, B.KG_CONVERT_RATE \n");
		sbSql.append("                 FROM FMP_OTCUST_PRICE_AVA_V A, FMP_OTCUST_ITEM B, \n");
		sbSql.append("                      ( \n");
		sbSql.append("                      SELECT UPJANG, ITEM_CODE, MAX(SDATE) AS SDATE \n");
		sbSql.append("                        FROM FMP_OTCUST_PRICE_AVA_V \n");
		sbSql.append("                       WHERE UPJANG = \n");
		sbSql.append("                             ( \n");
		sbSql.append("                             SELECT OTCUST_PRICE_UPJANG \n");
		sbSql.append("                               FROM FMS_UPJANG \n");
		sbSql.append("                              WHERE UPJANG = "+g_Upjang+" \n");
		sbSql.append("                             ) \n");
		sbSql.append("                         AND SDATE <= TO_CHAR(SYSDATE,'YYYYMMDD') \n");
		sbSql.append("                       GROUP BY UPJANG, ITEM_CODE \n");
		sbSql.append("                      ) C \n");
		sbSql.append("                WHERE A.ITEM_CODE = B.ITEM_CODE \n");
		sbSql.append("                  AND A.UPJANG = C.UPJANG \n");
		sbSql.append("                  AND A.SDATE = C.SDATE \n");
		sbSql.append("                  AND A.ITEM_CODE = C.ITEM_CODE \n");
		sbSql.append("                  AND A.SDATE = C.SDATE \n");
		sbSql.append("                  AND A.SALE_PRICE > 0 \n");
		sbSql.append("                  AND A.USE_YN = 'Y' \n");
		sbSql.append("              ) A, \n");
		sbSql.append("             ( \n");        
		sbSql.append("             SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL \n");
		sbSql.append("               FROM FMU_OP_RATE \n");
		sbSql.append("              WHERE UPJANG = "+g_Upjang+" \n");
		sbSql.append("                AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN SDATE AND EDATE \n");
		sbSql.append("                AND USE_YN = 'Y' \n");
		sbSql.append("                AND ITEM_TYPE = 'M' \n");
		sbSql.append("             ) C, \n");
		sbSql.append("             ( \n");        
		sbSql.append("             SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL \n");
		sbSql.append("               FROM FMU_OP_RATE \n");
		sbSql.append("              WHERE UPJANG = "+g_Upjang+" \n");
		sbSql.append("                AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN SDATE AND EDATE \n");
		sbSql.append("                AND USE_YN = 'Y' \n");
		sbSql.append("                AND ITEM_TYPE = 'C' \n");
		sbSql.append("             ) D \n");
		sbSql.append("        WHERE A.ITEM_CODE = C.ITEM_CODE(+) \n");
		sbSql.append("          AND A.ITEM_CLASS4 = D.ITEM_CODE(+) \n");
		sbSql.append("       ) E, ----원가 \n");
		sbSql.append("       ( \n");
		sbSql.append("       SELECT ITEM_CODE, CAL, WATER, PROT, FAT, CARBO, FIBER, ASH, CA, P, FE, NA, K, VITA_A, RETIN, B_CAROT, THIA, RIBO, NIACIN, VITA_C, CHOLE, DISUSE_RATE \n");
		sbSql.append("         FROM FMP_ITEM_NUT \n");
		sbSql.append("        WHERE UPJANG = "+g_Upjang+" \n");
		sbSql.append("        UNION ALL \n");
		sbSql.append("       SELECT ITEM_CODE, CAL, WATER, PROT, FAT, CARBO, FIBER, ASH, CA, P, FE, NA, K, VITA_A, RETIN, B_CAROT, THIA, RIBO, NIACIN, VITA_C, CHOLE, DISUSE_RATE \n");
		sbSql.append("         FROM FSI_ITEM_NUT \n");
		sbSql.append("        WHERE ITEM_CODE IN \n");
		sbSql.append("            ( \n");
		sbSql.append("            SELECT	ITEM_CODE \n");
		sbSql.append("              FROM	FSI_ITEM_NUT MINUS \n");
		sbSql.append("            SELECT	ITEM_CODE \n");
		sbSql.append("              FROM	FMP_ITEM_NUT \n");
		sbSql.append("             WHERE	UPJANG = "+g_Upjang+" \n");
		sbSql.append("            ) \n");
		sbSql.append("       ) F ---열량 \n");		
		sbSql.append(" WHERE D.ITEM_CODE=E.ITEM_CODE(+) \n");
		sbSql.append("   AND D.ITEM_CODE=F.ITEM_CODE(+) \n");
		sbSql.append(" GROUP BY D.IN_SEQ2,D.IN_SEQ,D.UPJANG, \n");
		sbSql.append("       D.MENU_CD, \n");
		sbSql.append("       D.RECIPE_CD, \n");
		sbSql.append("       D.RECIPE_NAME, \n");
		sbSql.append("       D.ORI_TYPE \n");
		sbSql.append(" ORDER BY D.IN_SEQ2,D.IN_SEQ \n");
		
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 

		DataSet ds_RecipeList = this.makeDataSet(rs,"ds_RecipeList");
		out_dl.add(ds_RecipeList);
		rs.close();
		pstmt.close();
	   	this.setResultMessage(0, "OK",out_vl);
	} catch(Exception ex) {
		//ex.printStackTrace();
		//jsp 로그남기기
		logger.debug(ex.getMessage(), ex);
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

<%--
	try	{
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));		
	
		String  g_Upjang			= in_vl.getString("g_Upjang");
		String  MENU_CD				= in_vl.getString("MENU_CD");
	
		DataSet ds_out;
		StringBuffer sbSql = new StringBuffer();
	
		sbSql.delete(0, sbSql.length());
		sbSql.append("SELECT D.IN_SEQ2,D.IN_SEQ,D.UPJANG, \n");
		sbSql.append("       D.MENU_CD, \n");
		sbSql.append("       D.RECIPE_CD, \n");
		sbSql.append("       D.RECIPE_NAME, \n");
		sbSql.append("       D.ORI_TYPE, \n");
		sbSql.append("       SUM(ROUND( D.NEED_QTY * (NVL(E.OP_PRICE,0) / E.KG_CONVERT_RATE / 1000) ) ) OP_PRICE, \n");
		sbSql.append("       SUM(NVL(F.CAL,0) ) CAL, \n");
		sbSql.append("       ROUND(SUM(NVL(F.CAL* D.NEED_QTY * (100-F.DISUSE_RATE) / 100,0) ),2) CAL_CALC \n");
		sbSql.append("  FROM \n");
		sbSql.append("       ( \n");
		sbSql.append("       SELECT B.IN_SEQ2,B.IN_SEQ,B.UPJANG, \n");
		sbSql.append("              B.MENU_CD, \n");
		sbSql.append("              B.RECIPE_CD, \n");
		sbSql.append("              B.RECIPE_NAME, \n");
		sbSql.append("              B.ORI_TYPE, \n");
		sbSql.append("              C.ITEM_CODE, \n");
		sbSql.append("              C.NEED_QTY \n");
		sbSql.append("         FROM FMM_STD_MENU A, \n");
		sbSql.append("              ( \n");
		sbSql.append("              SELECT B.CDATE IN_SEQ2,B.ROWID IN_SEQ,B.UPJANG, \n");
		sbSql.append("                     B.MENU_CD, \n");
		sbSql.append("                     B.RECIPE_CD, \n");
		sbSql.append("                     B.ORI_TYPE, \n");
		sbSql.append("                     D.RECIPE_NAME \n");
		sbSql.append("                FROM FMM_STD_MENU_RECIPE B , \n");
		sbSql.append("                     FMR_STD_RECIPE_MST D \n");
		sbSql.append("               WHERE B.RECIPE_CD=D.RECIPE_CD \n");
		sbSql.append("                 AND B.ORI_TYPE = 'FS' \n");
		sbSql.append("                 AND B.UPJANG="+g_Upjang+" \n");
		sbSql.append("                 AND B.MENU_CD='"+MENU_CD+"' \n");
		sbSql.append("               UNION ALL \n");
		sbSql.append("              SELECT B.CDATE IN_SEQ2,B.ROWID IN_SEQ,B.UPJANG, \n");
		sbSql.append("                     B.MENU_CD, \n");
		sbSql.append("                     B.RECIPE_CD, \n");
		sbSql.append("                     B.ORI_TYPE, \n");
		sbSql.append("                     D.RECIPE_NAME \n");
		sbSql.append("                FROM FMM_STD_MENU_RECIPE B , \n");
		sbSql.append("                     FMM_STD_RECIPE_MST D \n");
		sbSql.append("               WHERE B.RECIPE_CD=D.RECIPE_CD \n");
		sbSql.append("                 AND B.UPJANG =D.UPJANG \n");
		sbSql.append("                 AND B.ORI_TYPE = 'FM' \n");
		sbSql.append("                 AND B.UPJANG="+g_Upjang+" \n");
		sbSql.append("                 AND B.MENU_CD='"+MENU_CD+"' \n");
		sbSql.append("              ) B, \n");
		sbSql.append("              ( \n");
		sbSql.append("              SELECT UPJANG, \n");
		sbSql.append("                     RECIPE_CD, \n");
		sbSql.append("                     ITEM_CODE, \n");
		sbSql.append("                     NEED_QTY \n");
		sbSql.append("                FROM FMM_STD_RECIPE_ITEM \n");
		sbSql.append("               WHERE UPJANG="+g_Upjang+" \n");
		sbSql.append("               UNION ALL \n");
		sbSql.append("              SELECT "+g_Upjang+" UPJANG,                                      	\n");
		sbSql.append("                     A.RECIPE_CD,                                        	\n");
		sbSql.append("                     FMM_CHGITEM_FUN("+g_Upjang+", A.ITEM_CODE) ITEM_CODE,     	\n");
		sbSql.append("                     SUM(A.NEED_QTY) NEED_QTY                            	\n");
		sbSql.append("              FROM   FMR_STD_RECIPE_ITEM A,                              	\n");
		sbSql.append("                     FMM_STD_MENU_RECIPE B                               	\n");
		sbSql.append("              WHERE B.UPJANG="+g_Upjang+"                                      	\n");
		sbSql.append("              AND   A.RECIPE_CD=B.RECIPE_CD                              	\n");
		sbSql.append("              GROUP BY A.RECIPE_CD,FMM_CHGITEM_FUN("+g_Upjang+", A.ITEM_CODE)  	\n");
		sbSql.append("              ) C \n");
		sbSql.append("        WHERE A.UPJANG=B.UPJANG \n");
		sbSql.append("          AND A.MENU_CD=B.MENU_CD \n");
		sbSql.append("          AND B.RECIPE_CD=C.RECIPE_CD \n");
		sbSql.append("          AND A.UPJANG="+g_Upjang+" \n");
		sbSql.append("          AND A.MENU_CD='"+MENU_CD+"' \n");
		sbSql.append("       ) D, \n");
		sbSql.append("       ( \n");
		sbSql.append("       SELECT \n");
		sbSql.append("              A.UPJANG, A.ITEM_CODE, A.SALE_PRICE, A.KG_CONVERT_RATE, \n");
		sbSql.append("              NVL(NVL(C.OP_RATE, D.OP_RATE), 0) AS OP_RATE, --운영율 \n");
		sbSql.append("              CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
    	sbSql.append("                   THEN DECODE(SIGN(NVL(C.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE) \n");
    	sbSql.append("                   WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL \n");
    	sbSql.append("                   THEN DECODE(SIGN(NVL(D.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL), D.OP_PRICE) \n");
    	sbSql.append("              ELSE A.SALE_PRICE END AS OP_PRICE --운영단가 \n");
    	sbSql.append("         FROM \n");
		sbSql.append("              ( \n");
		sbSql.append("              SELECT \n");
		sbSql.append("              		"+g_Upjang+" AS UPJANG, \n");
		sbSql.append("              		TO_CHAR(SYSDATE,'YYYYMMDD') AS NEED_DATE , \n");
		sbSql.append("                      A.ITEM_CODE, \n");
		sbSql.append("                      A.SALE_PRICE, \n");
		sbSql.append("                      B.ITEM_CLASS4, \n");
		sbSql.append("                      B.KG_CONVERT_RATE \n");
		sbSql.append("                 FROM HLDC_PO_CONTRACT_FSALE A, HLDC_PO_ITEM_MST B, HLDC_ST_UPJANG C \n");
		sbSql.append("                WHERE A.ITEM_CODE = B.ITEM_CODE \n");
		sbSql.append("                  AND A.UPJANG = C.AP_UNITPRICE_UPJANG \n");
		sbSql.append("                  AND C.UPJANG = "+g_Upjang+" \n");
		sbSql.append("                  AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN A.CONTRACT_START AND NVL(A.CONTRACT_END, '99991231') \n");
		sbSql.append("                  AND A.SALE_PRICE > 0 \n");
		sbSql.append("                  AND A.USE_YN = 'Y' \n");
		sbSql.append("               ----------- \n");
		sbSql.append("                UNION ALL \n");
		sbSql.append("               ----------- \n");
		sbSql.append("               SELECT "+g_Upjang+" AS UPJANG, TO_CHAR(SYSDATE,'YYYYMMDD') AS NEED_DATE, A.ITEM_CODE, A.SALE_PRICE, \n");
		sbSql.append("                      B.ITEM_CLASS4, B.KG_CONVERT_RATE \n");
		sbSql.append("                 FROM FMP_OTCUST_PRICE_AVA_V A, FMP_OTCUST_ITEM B, \n");
		sbSql.append("                      ( \n");
		sbSql.append("                      SELECT UPJANG, ITEM_CODE, MAX(SDATE) AS SDATE \n");
		sbSql.append("                        FROM FMP_OTCUST_PRICE_AVA_V \n");
		sbSql.append("                       WHERE UPJANG = \n");
		sbSql.append("                             ( \n");
		sbSql.append("                             SELECT OTCUST_PRICE_UPJANG \n");
		sbSql.append("                               FROM FMS_UPJANG \n");
		sbSql.append("                              WHERE UPJANG = "+g_Upjang+" \n");
		sbSql.append("                             ) \n");
		sbSql.append("                         AND SDATE <= TO_CHAR(SYSDATE,'YYYYMMDD') \n");
		sbSql.append("                       GROUP BY UPJANG, ITEM_CODE \n");
		sbSql.append("                      ) C \n");
		sbSql.append("                WHERE A.ITEM_CODE = B.ITEM_CODE \n");
		sbSql.append("                  AND A.UPJANG = C.UPJANG \n");
		sbSql.append("                  AND A.SDATE = C.SDATE \n");
		sbSql.append("                  AND A.ITEM_CODE = C.ITEM_CODE \n");
		sbSql.append("                  AND A.SDATE = C.SDATE \n");
		sbSql.append("                  AND A.SALE_PRICE > 0 \n");
		sbSql.append("                  AND A.USE_YN = 'Y' \n");
		sbSql.append("              ) A, \n");
		sbSql.append("             ( \n");        
		sbSql.append("             SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL \n");
		sbSql.append("               FROM FMU_OP_RATE \n");
		sbSql.append("              WHERE UPJANG = "+g_Upjang+" \n");
		sbSql.append("                AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN SDATE AND EDATE \n");
		sbSql.append("                AND USE_YN = 'Y' \n");
		sbSql.append("                AND ITEM_TYPE = 'M' \n");
		sbSql.append("             ) C, \n");
		sbSql.append("             ( \n");        
		sbSql.append("             SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL \n");
		sbSql.append("               FROM FMU_OP_RATE \n");
		sbSql.append("              WHERE UPJANG = "+g_Upjang+" \n");
		sbSql.append("                AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN SDATE AND EDATE \n");
		sbSql.append("                AND USE_YN = 'Y' \n");
		sbSql.append("                AND ITEM_TYPE = 'C' \n");
		sbSql.append("             ) D \n");
		sbSql.append("        WHERE A.ITEM_CODE = C.ITEM_CODE(+) \n");
		sbSql.append("          AND A.ITEM_CLASS4 = D.ITEM_CODE(+) \n");
		sbSql.append("       ) E, ----원가 \n");
		sbSql.append("       ( \n");
		sbSql.append("       SELECT ITEM_CODE, CAL, WATER, PROT, FAT, CARBO, FIBER, ASH, CA, P, FE, NA, K, VITA_A, RETIN, B_CAROT, THIA, RIBO, NIACIN, VITA_C, CHOLE, DISUSE_RATE \n");
		sbSql.append("         FROM FMP_ITEM_NUT \n");
		sbSql.append("        WHERE UPJANG = "+g_Upjang+" \n");
		sbSql.append("        UNION ALL \n");
		sbSql.append("       SELECT ITEM_CODE, CAL, WATER, PROT, FAT, CARBO, FIBER, ASH, CA, P, FE, NA, K, VITA_A, RETIN, B_CAROT, THIA, RIBO, NIACIN, VITA_C, CHOLE, DISUSE_RATE \n");
		sbSql.append("         FROM FSI_ITEM_NUT \n");
		sbSql.append("        WHERE ITEM_CODE IN \n");
		sbSql.append("            ( \n");
		sbSql.append("            SELECT	ITEM_CODE \n");
		sbSql.append("              FROM	FSI_ITEM_NUT MINUS \n");
		sbSql.append("            SELECT	ITEM_CODE \n");
		sbSql.append("              FROM	FMP_ITEM_NUT \n");
		sbSql.append("             WHERE	UPJANG = "+g_Upjang+" \n");
		sbSql.append("            ) \n");
		sbSql.append("       ) F ---열량 \n");		
		sbSql.append(" WHERE D.ITEM_CODE=E.ITEM_CODE(+) \n");
		sbSql.append("   AND D.ITEM_CODE=F.ITEM_CODE(+) \n");
		sbSql.append(" GROUP BY D.IN_SEQ2,D.IN_SEQ,D.UPJANG, \n");
		sbSql.append("       D.MENU_CD, \n");
		sbSql.append("       D.RECIPE_CD, \n");
		sbSql.append("       D.RECIPE_NAME, \n");
		sbSql.append("       D.ORI_TYPE \n");
		sbSql.append(" ORDER BY D.IN_SEQ2,D.IN_SEQ \n");
		
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 

		DataSet ds_RecipeList = this.makeDataSet(rs,"ds_RecipeList");
		out_dl.add(ds_RecipeList);
		rs.close();
		pstmt.close();
	   	this.setResultMessage(0, "OK",out_vl);
	} catch(Exception ex) {
		//ex.printStackTrace();
		//jsp 로그남기기
		logger.debug(ex.getMessage(), ex);
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

--%>