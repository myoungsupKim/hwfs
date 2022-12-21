<%                                                                                                                                                                                                      
/*-----------------------------------------------------------------------------                                                                                                                         
■ 시스템명     : 메뉴관리/식단관리                                                                                                                                                                     
■ 프로그램ID   : FMM00190V_S001.jsp                                                                                                                                                                    
■ 프로그램명   : 표준 식단 조회                                                                                                                                      
■ 작성일자     : 2008-04-11                                                                                                                                                                            
■ 작성자       : 박지영                                                                                                                                                                                
■ 이력관리     : 2008-04-11                                                                                                                                                                            
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
		DataSet ds_input     	= in_dl.get("ds_input");                                                                                                                                                  
	                                                                                                                                                                                                        
	  	String strSType 		= nullToBlank(ds_input.getString(0, "STYPE"));
	  	String strMenuClass		= nullToBlank(ds_input.getString(0, "MENU_CLASS"));
	  	String strMenuName 		= nullToBlank(ds_input.getString(0, "MENU_NAME"));
	  	String strRecipeName	= nullToBlank(ds_input.getString(0, "RECIPE_NAME"));
	  	String strFileURL1 		= nullToBlank(ds_input.getString(0, "FILEURL1"));
	  	String strFileURL2 		= nullToBlank(ds_input.getString(0, "FILEURL2"));
	  	
	  	String  g_Upjang			= in_vl.getString("g_Upjang");
	  	String  g_Main_Upjang		= in_vl.getString("g_Main_Upjang");
                                                                                                                                                                                                     
		//out 데이타                                                                                                                                                                                        
		DataSet ds_list;                                                                                                                                                                                    
		                                                                                                                                                                                                    
		//sql문 버퍼생성                                                                                                                                                                                    
		StringBuffer sbSql = new StringBuffer();                                                                                                                                                            
        
		sbSql.delete(0, sbSql.length());
		if (strSType.equals("1"))
		{
			sbSql.delete(0, sbSql.length());
			sbSql.append("SELECT '1' AS GBN, A.SINGLE_MENU_CD AS MENU_CD \n");
			sbSql.append("      ,A.MENU_NAME \n");
			sbSql.append("      ,A.MENU_CLASS \n");
			sbSql.append("      ,(SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0028' AND CODE = A.MENU_CLASS) MENU_CLASS_NM \n");
			sbSql.append("      ,SUM(ROUND( E.NEED_QTY * (NVL(F.OP_PRICE,0) / F.KG_CONVERT_RATE / 1000) ) ) AS MENU_COST  -- 가식부량 적용 여부 결정 \n");
			sbSql.append("      ,FMM_SINGLE_RECIPE_NAME_FUN(A.SINGLE_MENU_CD) AS RECIPE_INFO --레시피구성 \n");
// 			sbSql.append("      ,SUBSTR(MAX(V1.RECIPE_INFO),1,2000) RECIPE_INFO \n");
			sbSql.append("      ,PHOTO_TITLE_1 \n");
			sbSql.append("      ,PHOTO_PATH_1 \n");
			sbSql.append("      ,SPHOTO_PATH_1 \n");
			sbSql.append("      ,'" + strFileURL1 + "' AS PHOTO_URL_1 \n");
			sbSql.append("      ,PHOTO_TITLE_2 \n");
			sbSql.append("      ,PHOTO_PATH_2 \n");
			sbSql.append("      ,SPHOTO_PATH_2 \n");
			sbSql.append("      ,'" + strFileURL1 + "' AS PHOTO_URL_2 \n");
			sbSql.append("  FROM FMM_SINGLE_MENU_MST A \n");
			sbSql.append("      ,FMM_SINGLE_MENU_RECIPE B \n");
			sbSql.append("      ,FMR_STD_RECIPE_MST D \n");
			sbSql.append("     ,(SELECT NVL(B.ITEM_CODE_TO,A.ITEM_CODE) AS ITEM_CODE \n");
			sbSql.append("             , A.RECIPE_CD, A.ITEM_SEQ, A.NEED_QTY, A.EDIBLE_QTY, A.CUT_SPEC, A.USE_YN \n");
			sbSql.append("          FROM FMR_STD_RECIPE_ITEM A \n");
			sbSql.append("             ,(SELECT * FROM FMM_CHG_ITEM_LIST B WHERE UPJANG = " + g_Upjang + " AND USE_YN = 'Y') B \n");
			sbSql.append("         WHERE A.ITEM_CODE = B.ITEM_CODE(+) \n");
			sbSql.append("       ) E \n");
			sbSql.append("      ,( \n");
			sbSql.append("      SELECT \n");
			sbSql.append("             A.UPJANG, A.ITEM_CODE, A.SALE_PRICE, A.KG_CONVERT_RATE \n");
			sbSql.append("           , CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
	    	sbSql.append("                  THEN DECODE(SIGN(NVL(C.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE) \n");
	    	sbSql.append("                  WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL \n");
	    	sbSql.append("                  THEN DECODE(SIGN(NVL(D.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL), D.OP_PRICE) \n");
	    	sbSql.append("             ELSE A.SALE_PRICE END AS OP_PRICE --운영단가 \n");
	    	sbSql.append("        FROM ( \n");
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
			sbSql.append("             ) A, \n");
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
			sbSql.append("       WHERE A.ITEM_CODE = C.ITEM_CODE(+) \n");
			sbSql.append("         AND A.ITEM_CLASS4 = D.ITEM_CODE(+) \n");
			sbSql.append("       ) F \n");
// 			sbSql.append("       ,( \n");
// 			sbSql.append("       SELECT A.SINGLE_MENU_CD , \n");
// 			sbSql.append("              LISTAGG(RECIPE_NAME, ',') WITHIN GROUP (ORDER BY A.RECIPE_SEQ, B.RECIPE_TYPE, B.CUISINE_TYPE, A.RECIPE_CD) RECIPE_INFO \n");
// 			sbSql.append("         FROM FMM_SINGLE_MENU_RECIPE A, FMR_STD_RECIPE_MST B \n");
// 			sbSql.append("        WHERE A.RECIPE_CD = B.RECIPE_CD \n");
// 			sbSql.append("        GROUP BY A.SINGLE_MENU_CD \n");
// 			sbSql.append("       ) V1 \n");
			sbSql.append(" WHERE A.SINGLE_MENU_CD = B.SINGLE_MENU_CD \n");
			sbSql.append("   AND B.RECIPE_CD = D.RECIPE_CD \n");
			sbSql.append("   AND B.RECIPE_CD = E.RECIPE_CD \n");
			sbSql.append("   AND E.ITEM_CODE = F.ITEM_CODE(+) \n");
// 			sbSql.append("   AND V1.SINGLE_MENU_CD(+)  = A.SINGLE_MENU_CD \n");
			if (strMenuClass.length() != 0)				sbSql.append("   AND A.MENU_CLASS= '" + strMenuClass + "' \n");
			if (strMenuName.length() != 0)				sbSql.append("   AND A.MENU_NAME LIKE '%' || '" + strMenuName + "' || '%' \n");
			if (strRecipeName.length() != 0)			sbSql.append("   AND D.RECIPE_NAME LIKE '%' || '" + strRecipeName + "' || '%' \n");
			sbSql.append("  GROUP BY A.SINGLE_MENU_CD \n");
			sbSql.append("        ,A.MENU_NAME \n");
			sbSql.append("        ,A.MENU_CLASS \n");
			sbSql.append("        ,PHOTO_TITLE_1 \n");
			sbSql.append("        ,PHOTO_PATH_1 \n");
			sbSql.append("        ,SPHOTO_PATH_1 \n");
			sbSql.append("        ,PHOTO_TITLE_2 \n");
			sbSql.append("        ,PHOTO_PATH_2 \n");
			sbSql.append("        ,SPHOTO_PATH_2 \n");
		}
		else if (strSType.equals("2"))
		{
			sbSql.delete(0, sbSql.length());
			sbSql.append("SELECT '2' AS GBN, A.UPJANG \n");
			sbSql.append("      ,A.MENU_CD \n");
			sbSql.append("      ,A.MENU_NAME \n");
			sbSql.append("      ,A.MENU_CLASS \n");
			sbSql.append("      ,(SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0028' AND CODE = A.MENU_CLASS) MENU_CLASS_NM \n");
			sbSql.append("      ,SUM(ROUND( E.NEED_QTY * (NVL(F.OP_PRICE,0) / F.KG_CONVERT_RATE / 1000) ) ) AS MENU_COST  -- 가식부량 적용 여부 결정 \n");
			sbSql.append("      ,FMM_RECIPENAME_FUN(A.UPJANG,A.MENU_CD,'0') AS RECIPE_INFO --레시피구성 \n");
			sbSql.append("      ,'' AS SPHOTO_PATH_1 \n");
			sbSql.append("      ,'' AS SPHOTO_PATH_2 \n");
			sbSql.append("  FROM FMM_STD_MENU A \n");
			sbSql.append("      ,FMM_STD_MENU_RECIPE B \n");
			sbSql.append("      ,FMM_STD_RECIPE_MST D \n");
			sbSql.append("      ,( \n");
			sbSql.append("         SELECT RECIPE_CD, ITEM_CODE, ITEM_SEQ, NEED_QTY, EDIBLE_QTY, CUT_SPEC \n");
			sbSql.append("           FROM FMR_STD_RECIPE_ITEM \n");
			if (g_Main_Upjang.length() != 0)
			{
				sbSql.append("          UNION ALL \n");
				sbSql.append("         SELECT RECIPE_CD, ITEM_CODE, ITEM_SEQ, NEED_QTY, EDIBLE_QTY, CUT_SPEC \n");
				sbSql.append("           FROM FMM_STD_RECIPE_ITEM \n");
				sbSql.append("          WHERE UPJANG = " + g_Main_Upjang + " \n");
			}	
			
			sbSql.append("       ) E \n");
			sbSql.append("      ,( \n");
			sbSql.append("      SELECT \n");
			sbSql.append("             A.UPJANG, A.ITEM_CODE, A.SALE_PRICE, A.KG_CONVERT_RATE \n");
			sbSql.append("           , CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
	    	sbSql.append("                  THEN DECODE(SIGN(NVL(C.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE) \n");
	    	sbSql.append("                  WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL \n");
	    	sbSql.append("                  THEN DECODE(SIGN(NVL(D.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL), D.OP_PRICE) \n");
	    	sbSql.append("             ELSE A.SALE_PRICE END AS OP_PRICE --운영단가 \n");
	    	sbSql.append("        FROM ( \n");
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
			sbSql.append("             ) A, \n");
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
			sbSql.append("       WHERE A.ITEM_CODE = C.ITEM_CODE(+) \n");
			sbSql.append("         AND A.ITEM_CLASS4 = D.ITEM_CODE(+) \n");
			sbSql.append("       ) F \n");
			sbSql.append("  WHERE A.MENU_CD = B.MENU_CD \n");
			sbSql.append("   AND A.UPJANG = B.UPJANG \n");
			sbSql.append("   AND B.RECIPE_CD = D.RECIPE_CD \n");
			//sbSql.append("   AND B.ORI_TYPE = 'FM' \n"); 
			sbSql.append("   AND B.RECIPE_CD = E.RECIPE_CD \n");
			sbSql.append("   AND E.ITEM_CODE = F.ITEM_CODE(+) \n");
			if (g_Main_Upjang.length() != 0)
			{
				sbSql.append("   AND B.UPJANG = " + g_Main_Upjang + " \n");
			} else {
				sbSql.append("   AND 1 = 2 \n");
			}	
			if (strMenuClass.length() != 0)				sbSql.append("   AND A.MENU_CLASS= '" + strMenuClass + "' \n");
			if (strMenuName.length() != 0)				sbSql.append("   AND A.MENU_NAME LIKE '%' || '" + strMenuName + "' || '%' \n");
			if (strRecipeName.length() != 0)			sbSql.append("   AND D.RECIPE_NAME LIKE '%' || '" + strRecipeName + "' || '%' \n");
			sbSql.append("  GROUP BY A.UPJANG, A.MENU_CD,A.MENU_NAME,A.MENU_CLASS \n");
		}else
		{
			sbSql.delete(0, sbSql.length());
			
			sbSql.append("SELECT '1' AS GBN, 0 AS UPJANG, A.SINGLE_MENU_CD AS MENU_CD \n");
			sbSql.append("      ,A.MENU_NAME \n");
			sbSql.append("      ,A.MENU_CLASS \n");
			sbSql.append("      ,(SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0028' AND CODE = A.MENU_CLASS) MENU_CLASS_NM \n");
			sbSql.append("      ,SUM(ROUND( E.NEED_QTY * (NVL(F.OP_PRICE,0) / F.KG_CONVERT_RATE / 1000) ) ) AS MENU_COST  -- 가식부량 적용 여부 결정 \n");
			sbSql.append("      ,FMM_SINGLE_RECIPE_NAME_FUN(A.SINGLE_MENU_CD) AS RECIPE_INFO --레시피구성 \n");
			sbSql.append("      ,PHOTO_TITLE_1 \n");
			sbSql.append("      ,PHOTO_PATH_1 \n");
			sbSql.append("      ,SPHOTO_PATH_1 \n");
			sbSql.append("      ,'" + strFileURL1 + "' AS PHOTO_URL_1 \n");
			sbSql.append("      ,PHOTO_TITLE_2 \n");
			sbSql.append("      ,PHOTO_PATH_2 \n");
			sbSql.append("      ,SPHOTO_PATH_2 \n");
			sbSql.append("      ,'" + strFileURL1 + "' AS PHOTO_URL_2 \n");
			sbSql.append("  FROM FMM_SINGLE_MENU_MST A \n");
			sbSql.append("      ,FMM_SINGLE_MENU_RECIPE B \n");
			sbSql.append("      ,FMR_STD_RECIPE_MST D \n");
			sbSql.append("     ,(SELECT NVL(B.ITEM_CODE_TO,A.ITEM_CODE) AS ITEM_CODE \n");
			sbSql.append("             , A.RECIPE_CD, A.ITEM_SEQ, A.NEED_QTY, A.EDIBLE_QTY, A.CUT_SPEC, A.USE_YN \n");
			sbSql.append("          FROM FMR_STD_RECIPE_ITEM A \n");
			sbSql.append("             ,(SELECT * FROM FMM_CHG_ITEM_LIST B WHERE UPJANG = " + g_Upjang + " AND USE_YN = 'Y') B \n");
			sbSql.append("         WHERE A.ITEM_CODE = B.ITEM_CODE(+) \n");
			sbSql.append("       ) E \n");
			sbSql.append("      ,( \n");
			sbSql.append("      SELECT \n");
			sbSql.append("             A.UPJANG, A.ITEM_CODE, A.SALE_PRICE, A.KG_CONVERT_RATE \n");
			sbSql.append("           , CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
	    	sbSql.append("                  THEN DECODE(SIGN(NVL(C.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE) \n");
	    	sbSql.append("                  WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL \n");
	    	sbSql.append("                  THEN DECODE(SIGN(NVL(D.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL), D.OP_PRICE) \n");
	    	sbSql.append("             ELSE A.SALE_PRICE END AS OP_PRICE --운영단가 \n");
	    	sbSql.append("        FROM ( \n");
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
			sbSql.append("             ) A, \n");
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
			sbSql.append("       WHERE A.ITEM_CODE = C.ITEM_CODE(+) \n");
			sbSql.append("         AND A.ITEM_CLASS4 = D.ITEM_CODE(+) \n");
			sbSql.append("       ) F \n");
			sbSql.append(" WHERE A.SINGLE_MENU_CD = B.SINGLE_MENU_CD \n");
			sbSql.append("   AND B.RECIPE_CD = D.RECIPE_CD \n");
			sbSql.append("   AND B.RECIPE_CD = E.RECIPE_CD \n");
			sbSql.append("   AND E.ITEM_CODE = F.ITEM_CODE(+) \n");
			if (strMenuClass.length() != 0)				sbSql.append("   AND A.MENU_CLASS= '" + strMenuClass + "' \n");
			if (strMenuName.length() != 0)				sbSql.append("   AND A.MENU_NAME LIKE '%' || '" + strMenuName + "' || '%' \n");
			if (strRecipeName.length() != 0)			sbSql.append("   AND D.RECIPE_NAME LIKE '%' || '" + strRecipeName + "' || '%' \n");
			sbSql.append("  GROUP BY A.SINGLE_MENU_CD \n");
			sbSql.append("        ,A.MENU_NAME \n");
			sbSql.append("        ,A.MENU_CLASS \n");
			sbSql.append("        ,PHOTO_TITLE_1 \n");
			sbSql.append("        ,PHOTO_PATH_1 \n");
			sbSql.append("        ,SPHOTO_PATH_1 \n");
			sbSql.append("        ,PHOTO_TITLE_2 \n");
			sbSql.append("        ,PHOTO_PATH_2 \n");
			sbSql.append("        ,SPHOTO_PATH_2 \n");
			
			sbSql.append("  UNION ALL \n");
			
			sbSql.append("SELECT '2' AS GBN, A.UPJANG \n");
			sbSql.append("      ,A.MENU_CD \n");
			sbSql.append("      ,A.MENU_NAME \n");
			sbSql.append("      ,A.MENU_CLASS \n");
			sbSql.append("      ,(SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0028' AND CODE = A.MENU_CLASS) MENU_CLASS_NM \n");
			sbSql.append("      ,SUM(ROUND( E.NEED_QTY * (NVL(F.OP_PRICE,0) / F.KG_CONVERT_RATE / 1000) ) ) AS MENU_COST  -- 가식부량 적용 여부 결정 \n");
			sbSql.append("      ,FMM_RECIPENAME_FUN(A.UPJANG,A.MENU_CD,'0') AS RECIPE_INFO --레시피구성 \n");
			sbSql.append("      ,'' AS PHOTO_TITLE_1 \n");
			sbSql.append("      ,'' AS PHOTO_PATH_1 \n");
			sbSql.append("      ,'' AS SPHOTO_PATH_1 \n");
			sbSql.append("      ,'' AS PHOTO_URL_1 \n");
			sbSql.append("      ,'' AS PHOTO_TITLE_2 \n");
			sbSql.append("      ,'' AS PHOTO_PATH_2 \n");
			sbSql.append("      ,'' AS SPHOTO_PATH_2 \n");
			sbSql.append("      ,'' AS PHOTO_URL_2 \n");
			sbSql.append("  FROM FMM_STD_MENU A \n");
			sbSql.append("      ,FMM_STD_MENU_RECIPE B \n");
		    sbSql.append("      ,FMM_STD_RECIPE_MST D \n");
			sbSql.append("      ,( \n");
			sbSql.append("         SELECT RECIPE_CD, ITEM_CODE, ITEM_SEQ, NEED_QTY, EDIBLE_QTY, CUT_SPEC \n");
			sbSql.append("           FROM FMR_STD_RECIPE_ITEM \n");
			if (g_Main_Upjang.length() != 0) 
			{
				sbSql.append("          UNION ALL \n");
				sbSql.append("         SELECT RECIPE_CD, ITEM_CODE, ITEM_SEQ, NEED_QTY, EDIBLE_QTY, CUT_SPEC \n");
				sbSql.append("           FROM FMM_STD_RECIPE_ITEM \n");
				sbSql.append("          WHERE UPJANG = " + g_Main_Upjang + " \n");	
			}
			
			sbSql.append("       ) E \n");
			sbSql.append("      ,( \n");
			sbSql.append("      SELECT \n");
			sbSql.append("             A.UPJANG, A.ITEM_CODE, A.SALE_PRICE, A.KG_CONVERT_RATE \n");
			sbSql.append("           , CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
	    	sbSql.append("                  THEN DECODE(SIGN(NVL(C.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE) \n");
	    	sbSql.append("                  WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL \n");
	    	sbSql.append("                  THEN DECODE(SIGN(NVL(D.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL), D.OP_PRICE) \n");
	    	sbSql.append("             ELSE A.SALE_PRICE END AS OP_PRICE --운영단가 \n");
	    	sbSql.append("        FROM ( \n");
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
			sbSql.append("             ) A, \n");
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
			sbSql.append("       WHERE A.ITEM_CODE = C.ITEM_CODE(+) \n");
			sbSql.append("         AND A.ITEM_CLASS4 = D.ITEM_CODE(+) \n");
			sbSql.append("       ) F \n");
			sbSql.append("  WHERE A.MENU_CD = B.MENU_CD \n");
			sbSql.append("   AND A.UPJANG = B.UPJANG \n");
			sbSql.append("   AND B.RECIPE_CD = D.RECIPE_CD \n");
			//sbSql.append("   AND B.ORI_TYPE = 'FM' \n"); 
			sbSql.append("   AND B.RECIPE_CD = E.RECIPE_CD \n");
			sbSql.append("   AND E.ITEM_CODE = F.ITEM_CODE(+) \n");
			
			if (g_Main_Upjang.length() != 0)
			{
				sbSql.append("   AND B.UPJANG = " + g_Main_Upjang + " \n");
			} else {
				sbSql.append("   AND 1 = 2 \n");
			}	
			
			if (strMenuClass.length() != 0)				sbSql.append("   AND A.MENU_CLASS= '" + strMenuClass + "' \n");
			if (strMenuName.length() != 0)				sbSql.append("   AND A.MENU_NAME LIKE '%' || '" + strMenuName + "' || '%' \n");
			if (strRecipeName.length() != 0)			sbSql.append("   AND D.RECIPE_NAME LIKE '%' || '" + strRecipeName + "' || '%' \n");
			sbSql.append("  GROUP BY A.UPJANG, A.MENU_CD,A.MENU_NAME,A.MENU_CLASS \n");
		}
		
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