<%                                                                                                                                                                                                      
/*-----------------------------------------------------------------------------                                                                                                                         
■ 시스템명     : 메뉴관리/식단관리                                                                                                                                                                     
■ 프로그램ID   : FMM00207E_S002.jsp                                                                                                                                                                    
■ 프로그램명   : 식단복사조회-상세                                                                                                                          
■ 작성일자     : 2008-04-18                                                                                                                                                                            
■ 작성자       : 박지영                                                                                                                                                                                
■ 이력관리     : 2008-04-18                                                                                                                                                                            
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
		String strGBN 			= in_vl.getString("GBN");
		String fa_UPJANG		= in_vl.getString("fa_UPJANG");
		String strMenuCD		= in_vl.getString("MENU_CD");
                                                                                                                                                                                                     
		//out 데이타                                                                                                                                                                                        
		DataSet ds_list;                                                                                                                                                                                    
		                                                                                                                                                                                                    
		//sql문 버퍼생성                                                                                                                                                                                    
		StringBuffer sbSql = new StringBuffer();                                                                                                                                                            
        
		sbSql.delete(0, sbSql.length());
		if (strGBN.equals("0"))				// 사업장레시피
		{
			String strUpjang		= in_vl.getString("UPJANG");
			
			//sbSql.append("-- 상세조회 \n");
			sbSql.append("SELECT A.RECIPE_TYPE, A.CUISINE_TYPE, A.RECIPE_CD, A.RECIPE_NAME, \n");
			sbSql.append("       B.ITEM_CODE, C.ITEM_NAME, C.ITEM_SIZE, C.PO_UOM,B.NEED_QTY, \n");
			//sbSql.append("       B.ITEM_CODE, C.ITEM_NAME, D.FEATURE_NAME, C.ITEM_SIZE, C.PO_UOM,B.NEED_QTY, \n");
			sbSql.append("       CASE WHEN NVL(E.OP_PRICE,0) = 0 THEN 'N' ELSE 'Y' END RESTRICT_YN, -- 금지여부 \n");
			sbSql.append("       NVL(ROUND((B.NEED_QTY * NVL((B.OP_PRICE / C.KG_CONVERT_RATE / 1000),0))),0) AS PAST_PRICE, \n");
			sbSql.append("       NVL(ROUND((B.NEED_QTY * NVL((E.OP_PRICE / C.KG_CONVERT_RATE / 1000),0))),0) AS CUR_PRICE, \n");
			sbSql.append("	     FMS_ITEM_FEATURE_FUN("+fa_UPJANG+", TO_CHAR(SYSDATE, 'YYYYMMDD'), B.ITEM_CODE, 'N') AS FEATURE_NAME --자재특성 \n");
			sbSql.append("   FROM FMM_RECIPE A \n");
			sbSql.append("       ,FMM_RECIPE_ITEM B \n");
			sbSql.append("       ,FMS_ITEM_V C \n");
// 			sbSql.append("       ,( \n");
// 			sbSql.append("            SELECT A.ITEM_CODE, \n");
// 			sbSql.append("                   (SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0033' AND CODE = A.ITEM_FEATURE) AS FEATURE_NAME \n");
// 			sbSql.append("              FROM \n");
// 			sbSql.append("                   ( \n");
// 			sbSql.append("                    SELECT CENTER_CODE, CUSTCD, ITEM_CODE, ITEM_FEATURE \n");
// 			sbSql.append("                      FROM FSI_ITEM_FEATURE \n");
// 			sbSql.append("                     WHERE (1=1) \n");
// 			sbSql.append("                      AND  (CENTER_CODE, CUSTCD, ITEM_CODE, APPLY_DATE) IN ( \n");
// 			sbSql.append("                            SELECT \n");
// 			sbSql.append("                                   CENTER_CODE, CUSTCD, ITEM_CODE, MAX(APPLY_DATE) AS APPLY_DATE \n");
// 			sbSql.append("                              FROM  FSI_ITEM_FEATURE \n");
// 			sbSql.append("                             WHERE  CENTER_CODE  = (SELECT CENTER_CODE FROM HLDC_PO_UPJANG_CENTER WHERE UPJANG = " + fa_UPJANG + ") \n");
// 			sbSql.append("                               AND  TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN APPLY_DATE AND TO_CHAR(ADD_MONTHS(TO_DATE(APPLY_DATE,'YYYYMMDD'),1)-1,'YYYYMMDD') \n");
// 			sbSql.append("                             GROUP BY CENTER_CODE, CUSTCD, ITEM_CODE \n");
// 			sbSql.append("                           ) \n");
// 			sbSql.append("                    ) A, \n");
// 			sbSql.append("                    ( \n");
// 			sbSql.append("                    SELECT A.CENTER_CODE, A.CUSTCD, A.ITEM_CODE \n");
// 			sbSql.append("                      FROM HLDC_PO_CONTRACT_FSALE A, HLDC_ST_UPJANG B \n");
// 			sbSql.append("                     WHERE A.UPJANG = B.AP_UNITPRICE_UPJANG \n");
// 			sbSql.append("                       AND B.UPJANG = " + fa_UPJANG + " \n");
// 			sbSql.append("                    ) B \n");
// 			sbSql.append("             WHERE A.CENTER_CODE = B.CENTER_CODE \n");
// 			sbSql.append("               AND A.CUSTCD = B.CUSTCD \n");
// 			sbSql.append("               AND A.ITEM_CODE = B.ITEM_CODE \n");
// 			sbSql.append("       ) D \n");
			sbSql.append("       ,( \n");
			sbSql.append("      SELECT A.UPJANG, A.ITEM_CODE, A.SALE_PRICE, \n");
			sbSql.append("             NVL(NVL(C.OP_RATE, D.OP_RATE), 0) AS OP_RATE, --운영율 \n");
			sbSql.append("             CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
			sbSql.append("                  THEN DECODE(SIGN(NVL(C.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE) \n");
			sbSql.append("                  WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL \n");
			sbSql.append("                  THEN DECODE(SIGN(NVL(D.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL), D.OP_PRICE) \n");
			sbSql.append("             ELSE A.SALE_PRICE END AS OP_PRICE --운영단가(1인원가) \n");
			sbSql.append("        FROM \n");
			sbSql.append("             FMS_ITEM_V B, \n");
			sbSql.append("             ( \n");   
			sbSql.append("               SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL \n");
			sbSql.append("                 FROM FMU_OP_RATE \n");
			sbSql.append("                WHERE UPJANG = " + fa_UPJANG + " \n");
			sbSql.append("                  AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN SDATE AND EDATE \n");
			sbSql.append("                  AND USE_YN = 'Y' \n");
			sbSql.append("                  AND ITEM_TYPE = 'M' \n");
			sbSql.append("             ) C, \n");
			sbSql.append("             ( \n");        
			sbSql.append("               SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL \n");
			sbSql.append("                 FROM FMU_OP_RATE \n");
			sbSql.append("                WHERE UPJANG = " + fa_UPJANG + " \n");
			sbSql.append("                  AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN SDATE AND EDATE \n");
			sbSql.append("                  AND USE_YN = 'Y' \n");
			sbSql.append("                  AND ITEM_TYPE = 'C' \n");
			sbSql.append("             ) D, \n");
			sbSql.append("             ( \n");
			sbSql.append("              SELECT \n");
			sbSql.append("                     " + fa_UPJANG + " AS UPJANG , \n");
			sbSql.append("                     TO_CHAR(SYSDATE,'YYYYMMDD') AS NEED_DATE , \n");
			sbSql.append("                     A.ITEM_CODE, A.SALE_PRICE \n");
			sbSql.append("                FROM HLDC_PO_CONTRACT_FSALE A, HLDC_ST_UPJANG B \n");
			sbSql.append("               WHERE A.UPJANG = B.AP_UNITPRICE_UPJANG \n");
			sbSql.append("                 AND B.UPJANG = " + fa_UPJANG + " \n");
			sbSql.append("                 AND A.ITEM_CODE > ' ' \n");
			sbSql.append("                 AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN A.CONTRACT_START AND NVL(A.CONTRACT_END,'99999999') \n");
			sbSql.append("                 AND A.SALE_PRICE > 0 \n");
			sbSql.append("                 AND A.USE_YN = 'Y' \n");
			sbSql.append("             ----------- \n");
			sbSql.append("              UNION ALL \n");
			sbSql.append("             ----------- \n");
			sbSql.append("             SELECT " + fa_UPJANG + " AS UPJANG, TO_CHAR(SYSDATE,'YYYYMMDD') AS NEED_DATE, A.ITEM_CODE, A.SALE_PRICE \n");
			sbSql.append("               FROM FMP_OTCUST_PRICE_AVA_V A , \n");
			sbSql.append("                    ( \n");
			sbSql.append("                    SELECT UPJANG, ITEM_CODE, MAX(SDATE) AS SDATE \n");
			sbSql.append("                      FROM FMP_OTCUST_PRICE_AVA_V \n");
			sbSql.append("                     WHERE UPJANG = \n");
			sbSql.append("                           ( \n");
			sbSql.append("                           SELECT OTCUST_PRICE_UPJANG \n");
			sbSql.append("                             FROM FMS_UPJANG \n");
			sbSql.append("                            WHERE UPJANG = " + fa_UPJANG + " \n");
			sbSql.append("                           ) \n");
			sbSql.append("                       AND SDATE <= TO_CHAR(SYSDATE,'YYYYMMDD') \n");
			sbSql.append("                     GROUP BY UPJANG, ITEM_CODE \n");
			sbSql.append("                    ) B \n");
			sbSql.append("              WHERE A.UPJANG = B.UPJANG \n");
			sbSql.append("                AND A.SDATE = B.SDATE \n");
			sbSql.append("                AND A.ITEM_CODE = B.ITEM_CODE \n");
			sbSql.append("                AND A.SALE_PRICE > 0 \n");
			sbSql.append("                AND A.USE_YN = 'Y' \n");
			sbSql.append("             ) A \n");
			sbSql.append("       WHERE A.ITEM_CODE = B.ITEM_CODE \n");
			sbSql.append("         AND B.ITEM_CODE = C.ITEM_CODE(+) \n");
			sbSql.append("         AND B.ITEM_CLASS4 = D.ITEM_CODE(+) \n");
			sbSql.append("       ) E \n");
			sbSql.append("WHERE A.UPJANG = B.UPJANG \n");
			sbSql.append("  AND A.MENU_CD = B.MENU_CD \n");
			sbSql.append("  AND A.RECIPE_CD = B.RECIPE_CD \n");
			sbSql.append("  AND B.ITEM_CODE = C.ITEM_CODE \n");
			sbSql.append("  AND B.ITEM_CODE = E.ITEM_CODE(+) \n");
// 			sbSql.append("  AND B.ITEM_CODE = D.ITEM_CODE(+) \n");
			sbSql.append("  AND C.ITEM_CLASS1 = 'F' \n");
			sbSql.append("  AND A.UPJANG  = " + strUpjang + " \n");
			sbSql.append("  AND A.MENU_CD = '" + strMenuCD + "' \n");
			sbSql.append("ORDER BY A.RECIPE_TYPE, A.CUISINE_TYPE, A.RECIPE_CD \n");
		}
		else if (strGBN.equals("1"))		// 한화표준식단
		{
			sbSql.delete(0, sbSql.length());
			sbSql.append("SELECT A.SINGLE_MENU_CD AS MENU_CD \n");
			sbSql.append("      ,A.RECIPE_CD \n");
			sbSql.append("      ,A.RECIPE_SEQ \n");
			sbSql.append("      ,C.RECIPE_NAME \n");
			sbSql.append("      ,CASE WHEN NVL(E.OP_PRICE,0) = 0 THEN 'N' ELSE 'Y' END ORDER_YN -- 금지여부 \n");
			sbSql.append("      ,D.ITEM_CODE \n");
			sbSql.append("      ,F.ITEM_NAME \n");
			sbSql.append("      ,F.ITEM_SIZE --규격 \n");
			sbSql.append("      ,F.PO_UOM    --구매단위 \n");
			//sbSql.append("      ,I.FEATURE_NAME AS ITEM_SPEC --자재특성 \n");
			sbSql.append("	    ,FMS_ITEM_FEATURE_FUN("+fa_UPJANG+", TO_CHAR(SYSDATE, 'YYYYMMDD'), D.ITEM_CODE, 'N') AS ITEM_SPEC --자재특성 \n");
			sbSql.append("      ,NVL(E.OP_PRICE,0) AS OP_PRICE --구매단가 \n");
			sbSql.append("      ,D.NEED_QTY  --표준1인소요량 \n");
			sbSql.append("      ,D.CUT_SPEC  --커팅규격 \n");
			sbSql.append("--      ,(SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0017' AND CODE = D.CUT_SPEC) CUT_SPEC_NAME --커팅규격명 \n");
			sbSql.append("      ,ROUND(D.NEED_QTY * (NVL(E.OP_PRICE,0) / F.KG_CONVERT_RATE / 1000) ) AS UNIT_COST -- 1인원가 \n");
			sbSql.append("      ,ROUND(D.NEED_QTY * (NVL(E.OP_PRICE,0) / F.KG_CONVERT_RATE / 1000) ) AS ITEM_COST -- 1인원가 \n");
			sbSql.append("      ,DISH_INFO --구성요소 \n");
			sbSql.append("      ,C.CUISINE_TYPE --조리법유형 \n");
			sbSql.append("  FROM \n");
			sbSql.append("       FMM_SINGLE_MENU_RECIPE A \n");
			sbSql.append("      ,FMR_STD_RECIPE_MST C \n");
			sbSql.append("      ,(SELECT NVL(B.ITEM_CODE_TO,A.ITEM_CODE) AS ITEM_CODE \n");
			sbSql.append("             , A.RECIPE_CD \n");
			sbSql.append("             , SUM(A.NEED_QTY) AS NEED_QTY \n");
			sbSql.append("             , SUM(A.EDIBLE_QTY) AS EDIBLE_QTY \n");
			sbSql.append("             , MAX(A.CUT_SPEC) AS CUT_SPEC \n");
			sbSql.append("          FROM FMR_STD_RECIPE_ITEM A \n");
			sbSql.append("             ,(SELECT * FROM FMM_CHG_ITEM_LIST B WHERE UPJANG = " + fa_UPJANG + " AND USE_YN = 'Y') B \n");
			sbSql.append("         WHERE A.ITEM_CODE = B.ITEM_CODE(+) \n");
			sbSql.append("         GROUP BY NVL(B.ITEM_CODE_TO,A.ITEM_CODE), A.RECIPE_CD \n");
			sbSql.append("       ) D \n");
			sbSql.append("      ,( \n");
			sbSql.append("      SELECT A.UPJANG, A.ITEM_CODE, A.SALE_PRICE, \n");
			sbSql.append("             NVL(NVL(C.OP_RATE, D.OP_RATE), 0) AS OP_RATE, --운영율 \n");
			sbSql.append("             CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
			sbSql.append("                  THEN DECODE(SIGN(NVL(C.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE) \n");
			sbSql.append("                  WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL \n");
			sbSql.append("                  THEN DECODE(SIGN(NVL(D.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL), D.OP_PRICE) \n");
			sbSql.append("             ELSE A.SALE_PRICE END AS OP_PRICE --운영단가(1인원가) \n");
			sbSql.append("        FROM \n");
			sbSql.append("             FMS_ITEM_V B, \n");
			sbSql.append("             ( \n");   
			sbSql.append("               SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL \n");
			sbSql.append("                 FROM FMU_OP_RATE \n");
			sbSql.append("                WHERE UPJANG = " + fa_UPJANG + " \n");
			sbSql.append("                  AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN SDATE AND EDATE \n");
			sbSql.append("                  AND USE_YN = 'Y' \n");
			sbSql.append("                  AND ITEM_TYPE = 'M' \n");
			sbSql.append("             ) C, \n");
			sbSql.append("             ( \n");        
			sbSql.append("               SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL \n");
			sbSql.append("                 FROM FMU_OP_RATE \n");
			sbSql.append("                WHERE UPJANG = " + fa_UPJANG + " \n");
			sbSql.append("                  AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN SDATE AND EDATE \n");
			sbSql.append("                  AND USE_YN = 'Y' \n");
			sbSql.append("                  AND ITEM_TYPE = 'C' \n");
			sbSql.append("             ) D, \n");
			sbSql.append("             ( \n");
			sbSql.append("              SELECT \n");
			sbSql.append("                     " + fa_UPJANG + " AS UPJANG , \n");
			sbSql.append("                     TO_CHAR(SYSDATE,'YYYYMMDD') AS NEED_DATE , \n");
			sbSql.append("                     A.ITEM_CODE, A.SALE_PRICE \n");
			sbSql.append("                FROM HLDC_PO_CONTRACT_FSALE A, HLDC_ST_UPJANG B \n");
			sbSql.append("               WHERE A.UPJANG = B.AP_UNITPRICE_UPJANG \n");
			sbSql.append("                 AND B.UPJANG = " + fa_UPJANG + " \n");
			sbSql.append("                 AND A.ITEM_CODE > ' ' \n");
			sbSql.append("                 AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN A.CONTRACT_START AND NVL(A.CONTRACT_END,'99999999') \n");
			sbSql.append("                 AND A.SALE_PRICE > 0 \n");
			sbSql.append("                 AND A.USE_YN = 'Y' \n");
			sbSql.append("             ----------- \n");
			sbSql.append("              UNION ALL \n");
			sbSql.append("             ----------- \n");
			sbSql.append("             SELECT " + fa_UPJANG + " AS UPJANG, TO_CHAR(SYSDATE,'YYYYMMDD') AS NEED_DATE, A.ITEM_CODE, A.SALE_PRICE \n");
			sbSql.append("               FROM FMP_OTCUST_PRICE_AVA_V A , \n");
			sbSql.append("                    ( \n");
			sbSql.append("                    SELECT UPJANG, ITEM_CODE, MAX(SDATE) AS SDATE \n");
			sbSql.append("                      FROM FMP_OTCUST_PRICE_AVA_V \n");
			sbSql.append("                     WHERE UPJANG = \n");
			sbSql.append("                           ( \n");
			sbSql.append("                           SELECT OTCUST_PRICE_UPJANG \n");
			sbSql.append("                             FROM FMS_UPJANG \n");
			sbSql.append("                            WHERE UPJANG = " + fa_UPJANG + " \n");
			sbSql.append("                           ) \n");
			sbSql.append("                       AND SDATE <= TO_CHAR(SYSDATE,'YYYYMMDD') \n");
			sbSql.append("                     GROUP BY UPJANG, ITEM_CODE \n");
			sbSql.append("                    ) B \n");
			sbSql.append("              WHERE A.UPJANG = B.UPJANG \n");
			sbSql.append("                AND A.SDATE = B.SDATE \n");
			sbSql.append("                AND A.ITEM_CODE = B.ITEM_CODE \n");
			sbSql.append("                AND A.SALE_PRICE > 0 \n");
			sbSql.append("                AND A.USE_YN = 'Y' \n");
			sbSql.append("             ) A \n");
			sbSql.append("       WHERE A.ITEM_CODE = B.ITEM_CODE \n");
			sbSql.append("         AND B.ITEM_CODE = C.ITEM_CODE(+) \n");
			sbSql.append("         AND B.ITEM_CLASS4 = D.ITEM_CODE(+) \n");
			sbSql.append("       ) E \n");
			sbSql.append("      ,( \n");
			sbSql.append("       SELECT ITEM_CODE, \n");
			sbSql.append("              ITEM_NAME, \n");
			sbSql.append("              ITEM_SIZE, \n");
			sbSql.append("              PO_UOM, \n");
			sbSql.append("              KG_CONVERT_RATE \n");
			sbSql.append("         FROM FMS_ITEM_V \n");
			sbSql.append("        WHERE ITEM_CLASS1 = 'F' \n");
			sbSql.append("       ) F \n");
			sbSql.append("      ,(SELECT RESTRICT_SEQ, ITEM_CODE \n");
			sbSql.append("          FROM FSI_RESTRICT_MST \n");
			sbSql.append("         WHERE TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN RESTRICT_START AND RESTRICT_END \n");
			sbSql.append("           AND USE_YN = 'Y' \n");
			sbSql.append("       ) G \n");
// 			sbSql.append("      ,( \n");
// 			sbSql.append("            SELECT A.ITEM_CODE, \n");
// 			sbSql.append("                   (SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0033' AND CODE = A.ITEM_FEATURE) AS FEATURE_NAME \n");
// 			sbSql.append("              FROM \n");
// 			sbSql.append("                   ( \n");
// 			sbSql.append("                    SELECT CENTER_CODE, CUSTCD, ITEM_CODE, ITEM_FEATURE \n");
// 			sbSql.append("                      FROM FSI_ITEM_FEATURE \n");
// 			sbSql.append("                     WHERE (1=1) \n");
// 			sbSql.append("                      AND  (CENTER_CODE, CUSTCD, ITEM_CODE, APPLY_DATE) IN ( \n");
// 			sbSql.append("                            SELECT \n");
// 			sbSql.append("                                   CENTER_CODE, CUSTCD, ITEM_CODE, MAX(APPLY_DATE) AS APPLY_DATE \n");
// 			sbSql.append("                              FROM FSI_ITEM_FEATURE \n");
// 			sbSql.append("                             WHERE CENTER_CODE  = (SELECT CENTER_CODE FROM HLDC_PO_UPJANG_CENTER WHERE UPJANG = " + fa_UPJANG + ") \n");
// 			sbSql.append("                               AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN APPLY_DATE AND TO_CHAR(ADD_MONTHS(TO_DATE(APPLY_DATE,'YYYYMMDD'),1)-1,'YYYYMMDD') \n");
// 			sbSql.append("                             GROUP BY CENTER_CODE, CUSTCD, ITEM_CODE \n");
// 			sbSql.append("                           ) \n");
// 			sbSql.append("                    ) A, \n");
// 			sbSql.append("                    ( \n");
// 			sbSql.append("                    SELECT A.CENTER_CODE, A.CUSTCD, A.ITEM_CODE \n");
// 			sbSql.append("                      FROM HLDC_PO_CONTRACT_FSALE A, HLDC_ST_UPJANG B \n");
// 			sbSql.append("                     WHERE A.UPJANG = B.AP_UNITPRICE_UPJANG \n");
// 			sbSql.append("                       AND B.UPJANG = " + fa_UPJANG + " \n");
// 			sbSql.append("                    ) B \n");
// 			sbSql.append("             WHERE A.CENTER_CODE = B.CENTER_CODE \n");
// 			sbSql.append("               AND A.CUSTCD = B.CUSTCD \n");
// 			sbSql.append("               AND A.ITEM_CODE = B.ITEM_CODE \n");
// 			sbSql.append("       ) I \n");
			sbSql.append(" WHERE A.RECIPE_CD = C.RECIPE_CD \n");
			sbSql.append("   AND C.RECIPE_CD = D.RECIPE_CD \n");
			sbSql.append("   AND D.ITEM_CODE = E.ITEM_CODE(+) \n");
			sbSql.append("   AND D.ITEM_CODE = F.ITEM_CODE \n");
			sbSql.append("   AND D.ITEM_CODE = G.ITEM_CODE(+) \n");
// 			sbSql.append("   AND D.ITEM_CODE = I.ITEM_CODE(+) \n");
			sbSql.append("   AND A.SINGLE_MENU_CD = '" + strMenuCD + "' \n");
			sbSql.append(" ORDER BY A.RECIPE_SEQ, C.RECIPE_TYPE, C.CUISINE_TYPE, A.RECIPE_CD, D.NEED_QTY DESC \n");

		}
		else if (strGBN.equals("2"))		// 기간표준식단
		{
			sbSql.append("SELECT A.RECIPE_CD \n");
			sbSql.append("      ,C.RECIPE_NAME \n");
			sbSql.append("      ,CASE WHEN NVL(E.OP_PRICE,0) = 0 THEN 'N' ELSE 'Y' END RESTRICT_YN -- 금지여부 \n");
			sbSql.append("      ,D.ITEM_CODE \n");
			//sbSql.append("      ,I.FEATURE_NAME --자재특성 \n");
			sbSql.append("	    ,FMS_ITEM_FEATURE_FUN("+fa_UPJANG+", TO_CHAR(SYSDATE, 'YYYYMMDD'), D.ITEM_CODE, 'N') AS FEATURE_NAME --자재특성 \n");
			sbSql.append("      ,F.ITEM_NAME \n");
			sbSql.append("      ,F.ITEM_SIZE --규격 \n");
			sbSql.append("      ,F.PO_UOM    --구매단위 \n");
			sbSql.append("      ,D.NEED_QTY  --표준1인소요량 \n");
			sbSql.append("      ,ROUND((D.NEED_QTY) * (NVL(E.OP_PRICE,0) / F.KG_CONVERT_RATE / 1000) ) AS UNIT_COST -- 1인원가 \n");
			sbSql.append("  FROM \n");
			sbSql.append("       FMM_TERM_MENU_RECIPE A \n");
			sbSql.append("      ,FMR_STD_RECIPE_MST C \n");
			sbSql.append("      ,(SELECT NVL(B.ITEM_CODE_TO,A.ITEM_CODE) AS ITEM_CODE \n");
			sbSql.append("             , A.RECIPE_CD \n");
			sbSql.append("             , SUM(A.NEED_QTY) AS NEED_QTY \n");
			sbSql.append("             , SUM(A.EDIBLE_QTY) AS EDIBLE_QTY \n");
			sbSql.append("             , MAX(A.CUT_SPEC) AS CUT_SPEC \n");
			sbSql.append("          FROM FMR_STD_RECIPE_ITEM A \n");
			sbSql.append("             ,(SELECT * FROM FMM_CHG_ITEM_LIST B WHERE UPJANG = " + fa_UPJANG + " AND USE_YN = 'Y') B \n");
			sbSql.append("         WHERE A.ITEM_CODE = B.ITEM_CODE(+) \n");
			sbSql.append("         GROUP BY NVL(B.ITEM_CODE_TO,A.ITEM_CODE), A.RECIPE_CD \n");
			sbSql.append("       ) D \n");
			sbSql.append("      ,( \n");
			sbSql.append("      SELECT A.UPJANG, A.ITEM_CODE, A.SALE_PRICE, \n");
			sbSql.append("             NVL(NVL(C.OP_RATE, D.OP_RATE), 0) AS OP_RATE, --운영율 \n");
			sbSql.append("             CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
			sbSql.append("                  THEN DECODE(SIGN(NVL(C.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE) \n");
			sbSql.append("                  WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL \n");
			sbSql.append("                  THEN DECODE(SIGN(NVL(D.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL), D.OP_PRICE) \n");
			sbSql.append("             ELSE A.SALE_PRICE END AS OP_PRICE --운영단가(1인원가) \n");
			sbSql.append("        FROM \n");
			sbSql.append("             FMS_ITEM_V B, \n");
			sbSql.append("             ( \n");   
			sbSql.append("               SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL \n");
			sbSql.append("                 FROM FMU_OP_RATE \n");
			sbSql.append("                WHERE UPJANG = " + fa_UPJANG + " \n");
			sbSql.append("                  AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN SDATE AND EDATE \n");
			sbSql.append("                  AND USE_YN = 'Y' \n");
			sbSql.append("                  AND ITEM_TYPE = 'M' \n");
			sbSql.append("             ) C, \n");
			sbSql.append("             ( \n");        
			sbSql.append("               SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL \n");
			sbSql.append("                 FROM FMU_OP_RATE \n");
			sbSql.append("                WHERE UPJANG = " + fa_UPJANG + " \n");
			sbSql.append("                  AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN SDATE AND EDATE \n");
			sbSql.append("                  AND USE_YN = 'Y' \n");
			sbSql.append("                  AND ITEM_TYPE = 'C' \n");
			sbSql.append("             ) D, \n");
			sbSql.append("             ( \n");
			sbSql.append("              SELECT \n");
			sbSql.append("                     " + fa_UPJANG + " AS UPJANG , \n");
			sbSql.append("                     TO_CHAR(SYSDATE,'YYYYMMDD') AS NEED_DATE , \n");
			sbSql.append("                     A.ITEM_CODE, A.SALE_PRICE \n");
			sbSql.append("                FROM HLDC_PO_CONTRACT_FSALE A, HLDC_ST_UPJANG B \n");
			sbSql.append("               WHERE A.UPJANG = B.AP_UNITPRICE_UPJANG \n");
			sbSql.append("                 AND B.UPJANG = " + fa_UPJANG + " \n");
			sbSql.append("                 AND A.ITEM_CODE > ' ' \n");
			sbSql.append("                 AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN A.CONTRACT_START AND NVL(A.CONTRACT_END,'99999999') \n");
			sbSql.append("                 AND A.SALE_PRICE > 0 \n");
			sbSql.append("                 AND A.USE_YN = 'Y' \n");
			sbSql.append("             ----------- \n");
			sbSql.append("              UNION ALL \n");
			sbSql.append("             ----------- \n");
			sbSql.append("             SELECT " + fa_UPJANG + " AS UPJANG, TO_CHAR(SYSDATE,'YYYYMMDD') AS NEED_DATE, A.ITEM_CODE, A.SALE_PRICE \n");
			sbSql.append("               FROM FMP_OTCUST_PRICE_AVA_V A , \n");
			sbSql.append("                    ( \n");
			sbSql.append("                    SELECT UPJANG, ITEM_CODE, MAX(SDATE) AS SDATE \n");
			sbSql.append("                      FROM FMP_OTCUST_PRICE_AVA_V \n");
			sbSql.append("                     WHERE UPJANG = \n");
			sbSql.append("                           ( \n");
			sbSql.append("                           SELECT OTCUST_PRICE_UPJANG \n");
			sbSql.append("                             FROM FMS_UPJANG \n");
			sbSql.append("                            WHERE UPJANG = " + fa_UPJANG + " \n");
			sbSql.append("                           ) \n");
			sbSql.append("                       AND SDATE <= TO_CHAR(SYSDATE,'YYYYMMDD') \n");
			sbSql.append("                     GROUP BY UPJANG, ITEM_CODE \n");
			sbSql.append("                    ) B \n");
			sbSql.append("              WHERE A.UPJANG = B.UPJANG \n");
			sbSql.append("                AND A.SDATE = B.SDATE \n");
			sbSql.append("                AND A.ITEM_CODE = B.ITEM_CODE \n");
			sbSql.append("                AND A.SALE_PRICE > 0 \n");
			sbSql.append("                AND A.USE_YN = 'Y' \n");
			sbSql.append("             ) A \n");
			sbSql.append("       WHERE A.ITEM_CODE = B.ITEM_CODE \n");
			sbSql.append("         AND B.ITEM_CODE = C.ITEM_CODE(+) \n");
			sbSql.append("         AND B.ITEM_CLASS4 = D.ITEM_CODE(+) \n");
			sbSql.append("       ) E \n");
			sbSql.append("      ,( \n");
			sbSql.append("       SELECT ITEM_CODE, \n");
			sbSql.append("              ITEM_NAME, \n");
			sbSql.append("              ITEM_SIZE, \n");
			sbSql.append("              PO_UOM, \n");
			sbSql.append("              KG_CONVERT_RATE \n");
			sbSql.append("         FROM HLDC_PO_ITEM_MST \n");
			sbSql.append("        WHERE ITEM_CLASS1 = 'F' \n");
			sbSql.append("       ) F \n");
// 			sbSql.append("       ,( \n");
// 			sbSql.append("            SELECT A.ITEM_CODE, \n");
// 			sbSql.append("                   (SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0033' AND CODE = A.ITEM_FEATURE) AS FEATURE_NAME \n");
// 			sbSql.append("              FROM \n");
// 			sbSql.append("                   ( \n");
// 			sbSql.append("                    SELECT CENTER_CODE, CUSTCD, ITEM_CODE, ITEM_FEATURE \n");
// 			sbSql.append("                      FROM FSI_ITEM_FEATURE \n");
// 			sbSql.append("                     WHERE (1=1) \n");
// 			sbSql.append("                      AND  (CENTER_CODE, CUSTCD, ITEM_CODE, APPLY_DATE) IN ( \n");
// 			sbSql.append("                            SELECT \n");
// 			sbSql.append("                                   CENTER_CODE, CUSTCD, ITEM_CODE, MAX(APPLY_DATE) AS APPLY_DATE \n");
// 			sbSql.append("                              FROM FSI_ITEM_FEATURE \n");
// 			sbSql.append("                             WHERE CENTER_CODE  = (SELECT CENTER_CODE FROM HLDC_PO_UPJANG_CENTER WHERE UPJANG = " + fa_UPJANG + ") \n");
// 			sbSql.append("                               AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN APPLY_DATE AND TO_CHAR(ADD_MONTHS(TO_DATE(APPLY_DATE,'YYYYMMDD'),1)-1,'YYYYMMDD') \n");
// 			sbSql.append("                             GROUP BY CENTER_CODE, CUSTCD, ITEM_CODE \n");
// 			sbSql.append("                           ) \n");
// 			sbSql.append("                    ) A, \n");
// 			sbSql.append("                    ( \n");
// 			sbSql.append("                    SELECT A.CENTER_CODE, A.CUSTCD, A.ITEM_CODE \n");
// 			sbSql.append("                      FROM HLDC_PO_CONTRACT_FSALE A, HLDC_ST_UPJANG B \n");
// 			sbSql.append("                     WHERE A.UPJANG = B.AP_UNITPRICE_UPJANG \n");
// 			sbSql.append("                       AND B.UPJANG = " + fa_UPJANG + " \n");
// 			sbSql.append("                    ) B \n");
// 			sbSql.append("             WHERE A.CENTER_CODE = B.CENTER_CODE \n");
// 			sbSql.append("               AND A.CUSTCD = B.CUSTCD \n");
// 			sbSql.append("               AND A.ITEM_CODE = B.ITEM_CODE \n");
// 			sbSql.append("       ) I \n");
			sbSql.append(" WHERE A.RECIPE_CD = C.RECIPE_CD \n");
			sbSql.append("   AND C.RECIPE_CD = D.RECIPE_CD \n");
			sbSql.append("   AND D.ITEM_CODE = E.ITEM_CODE(+) \n");
// 			sbSql.append("   AND D.ITEM_CODE = I.ITEM_CODE(+) \n");
			sbSql.append("   AND D.ITEM_CODE = F.ITEM_CODE \n");
			sbSql.append("   AND A.TERM_MENU_CD = '" + strMenuCD + "' \n");
			sbSql.append(" ORDER BY A.RECIPE_SEQ, C.RECIPE_TYPE, C.CUISINE_TYPE, A.RECIPE_CD, D.NEED_QTY DESC \n");
		}
		else								// 본사표준식단
		{
		  	String  fa_MainUpjang;
		  	
		  	sbSql.delete(0, sbSql.length());
		  	sbSql.append("SELECT MAIN_UPJANG 						\n");
		  	sbSql.append("  FROM FMS_UPJANG 						\n");
		  	sbSql.append(" WHERE UPJANG = " + fa_UPJANG + " 		\n");
			
			pstmt = conn.prepareStatement(sbSql.toString());
			rs = pstmt.executeQuery(); 		
			
			if(rs.next())	
			{
				fa_MainUpjang = rs.getString("MAIN_UPJANG");
				
				sbSql.delete(0, sbSql.length());
				sbSql.append("SELECT A.MENU_CD \n");
				sbSql.append("      ,A.RECIPE_CD \n");
				sbSql.append("      ,A.RECIPE_SEQ \n");
				sbSql.append("      ,C.RECIPE_NAME \n");
				sbSql.append("      ,CASE WHEN NVL(E.OP_PRICE,0) = 0 THEN 'N' ELSE 'Y' END ORDER_YN -- 금지여부 \n");
				sbSql.append("      ,D.ITEM_CODE \n");
				sbSql.append("      ,F.ITEM_NAME \n");
				sbSql.append("      ,F.ITEM_SIZE --규격 \n");
				sbSql.append("      ,F.PO_UOM    --구매단위 \n");
				//sbSql.append("      ,I.FEATURE_NAME AS ITEM_SPEC --자재특성 \n");
				sbSql.append("	    ,FMS_ITEM_FEATURE_FUN("+fa_MainUpjang+", TO_CHAR(SYSDATE, 'YYYYMMDD'), D.ITEM_CODE, 'N') AS FEATURE_NAME --자재특성 \n");
				sbSql.append("      ,E.OP_PRICE --구매단가 \n");
				sbSql.append("      ,D.NEED_QTY  --표준1인소요량 \n");
				sbSql.append("      ,D.CUT_SPEC  --커팅규격 \n");
				sbSql.append("      ,(SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0017' AND CODE = D.CUT_SPEC) CUT_SPEC_NAME --커팅규격명 \n");
				sbSql.append("      ,ROUND(D.NEED_QTY * (NVL(E.OP_PRICE,0) / F.KG_CONVERT_RATE / 1000) ) AS UNIT_COST -- 1인원가 \n");
				sbSql.append("      ,C.CUISINE_TYPE --조리법유형 \n");
				sbSql.append("  FROM \n");
				sbSql.append("       FMM_STD_MENU_RECIPE A \n");
				sbSql.append("      ,( \n");
				sbSql.append("         SELECT RECIPE_CD, RECIPE_NAME, RECIPE_CLASS, RECIPE_TYPE, CUISINE_TYPE \n");
				sbSql.append("           FROM FMM_STD_RECIPE_MST \n");
				sbSql.append("          WHERE UPJANG = " + fa_MainUpjang + " \n");
				sbSql.append("       ) C \n");
				sbSql.append("      ,( \n");
				sbSql.append("         SELECT RECIPE_CD, ITEM_CODE, ITEM_SEQ, NEED_QTY, EDIBLE_QTY, CUT_SPEC \n");
				sbSql.append("           FROM FMM_STD_RECIPE_ITEM \n");
				sbSql.append("          WHERE UPJANG = " + fa_MainUpjang + " \n");
				sbSql.append("       ) D \n");
				sbSql.append("      ,( \n");
				sbSql.append("        SELECT A.UPJANG, A.ITEM_CODE, A.UNIT_PRICE, A.SALE_PRICE \n");
				sbSql.append("             , CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
				sbSql.append("                    THEN DECODE(SIGN(NVL(C.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE) \n");
				sbSql.append("                    WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL \n");
				sbSql.append("                    THEN DECODE(SIGN(NVL(D.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL), D.OP_PRICE) \n");
				sbSql.append("               ELSE A.SALE_PRICE END AS OP_PRICE --운영단가(1인원가) \n");
				sbSql.append("          FROM \n");
				sbSql.append("               FMS_ITEM_V B \n");
				sbSql.append("             ,( \n");   
				sbSql.append("                SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL \n");
				sbSql.append("                  FROM FMU_OP_RATE \n");
				sbSql.append("                 WHERE UPJANG = " + fa_UPJANG + " \n");
				sbSql.append("                   AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN SDATE AND EDATE \n");
				sbSql.append("                   AND USE_YN = 'Y' \n");
				sbSql.append("                   AND ITEM_TYPE = 'M' \n");
				sbSql.append("              ) C \n");
				sbSql.append("             ,( \n");        
				sbSql.append("                SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL \n");
				sbSql.append("                  FROM FMU_OP_RATE \n");
				sbSql.append("                 WHERE UPJANG = " + fa_UPJANG + " \n");
				sbSql.append("                   AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN SDATE AND EDATE \n");
				sbSql.append("                   AND USE_YN = 'Y' \n");
				sbSql.append("                   AND ITEM_TYPE = 'C' \n");
				sbSql.append("              ) D \n");
				sbSql.append("             ,( \n");
				sbSql.append("               SELECT \n");
				sbSql.append("                      " + fa_UPJANG + " AS UPJANG , \n");
				sbSql.append("                      TO_CHAR(SYSDATE,'YYYYMMDD') AS NEED_DATE , \n");
				sbSql.append("                      A.ITEM_CODE, A.CONTRACT_PRICE AS UNIT_PRICE, A.SALE_PRICE \n");
				sbSql.append("                 FROM HLDC_PO_CONTRACT_FSALE A, HLDC_ST_UPJANG B \n");
				sbSql.append("                WHERE A.UPJANG = B.AP_UNITPRICE_UPJANG \n");
				sbSql.append("                  AND B.UPJANG = " + fa_UPJANG + " \n");
				sbSql.append("                  AND A.ITEM_CODE > ' ' \n");
				sbSql.append("                  AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN A.CONTRACT_START AND NVL(A.CONTRACT_END,'99999999') \n");
				sbSql.append("                  AND A.SALE_PRICE > 0 \n");
				sbSql.append("                  AND A.USE_YN = 'Y' \n");
				sbSql.append("               ----------- \n");
				sbSql.append("                UNION ALL \n");
				sbSql.append("               ----------- \n");
				sbSql.append("               SELECT " + fa_UPJANG + " AS UPJANG, NVL('',TO_CHAR(SYSDATE,'YYYYMMDD')) AS NEED_DATE \n");
				sbSql.append("                    , A.ITEM_CODE, A.UNIT_PRICE, A.SALE_PRICE \n");
				sbSql.append("                 FROM FMP_OTCUST_PRICE_AVA_V A \n");
				sbSql.append("                    ,(SELECT UPJANG, ITEM_CODE, MAX(SDATE) AS SDATE \n");
				sbSql.append("                        FROM FMP_OTCUST_PRICE_AVA_V \n");
				sbSql.append("                       WHERE UPJANG = (SELECT OTCUST_PRICE_UPJANG FROM FMS_UPJANG WHERE UPJANG = " + fa_UPJANG + ") \n");
				sbSql.append("                         AND SDATE <= NVL('',TO_CHAR(SYSDATE,'YYYYMMDD')) \n");
				sbSql.append("                       GROUP BY UPJANG, ITEM_CODE) B \n");
				sbSql.append("                WHERE A.UPJANG = B.UPJANG \n");
				sbSql.append("                  AND A.SDATE = B.SDATE \n");
				sbSql.append("                  AND A.ITEM_CODE = B.ITEM_CODE \n");
				sbSql.append("                  AND A.SALE_PRICE > 0 \n");
				sbSql.append("                  AND A.USE_YN = 'Y' \n");
				sbSql.append("              ) A \n");
				sbSql.append("        WHERE A.ITEM_CODE = B.ITEM_CODE \n");
				sbSql.append("          AND B.ITEM_CODE = C.ITEM_CODE(+) \n");
				sbSql.append("          AND B.ITEM_CLASS4 = D.ITEM_CODE(+) \n");
				sbSql.append("       ) E \n");
				sbSql.append("      ,( \n");
				sbSql.append("       SELECT ITEM_CODE, \n");
				sbSql.append("              ITEM_NAME, \n");
				sbSql.append("              ITEM_SIZE, \n");
				sbSql.append("              PO_UOM, \n");
				sbSql.append("              KG_CONVERT_RATE \n");
				sbSql.append("         FROM FMS_ITEM_V \n");
				sbSql.append("        WHERE ITEM_CLASS1 = 'F' \n");
				sbSql.append("       ) F \n");
// 				sbSql.append("      ,( \n");
// 				sbSql.append("            SELECT A.ITEM_CODE, \n");
// 				sbSql.append("                   (SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0033' AND CODE = A.ITEM_FEATURE) AS FEATURE_NAME \n");
// 				sbSql.append("              FROM \n");
// 				sbSql.append("                   ( \n");
// 				sbSql.append("                    SELECT CENTER_CODE, CUSTCD, ITEM_CODE, ITEM_FEATURE \n");
// 				sbSql.append("                      FROM FSI_ITEM_FEATURE \n");
// 				sbSql.append("                     WHERE (1=1) \n");
// 				sbSql.append("                      AND  (CENTER_CODE, CUSTCD, ITEM_CODE, APPLY_DATE) IN ( \n");
// 				sbSql.append("                            SELECT \n");
// 				sbSql.append("                                   CENTER_CODE, CUSTCD, ITEM_CODE, MAX(APPLY_DATE) AS APPLY_DATE \n");
// 				sbSql.append("                              FROM FSI_ITEM_FEATURE \n");
// 				sbSql.append("                             WHERE CENTER_CODE  = (SELECT CENTER_CODE FROM HLDC_PO_UPJANG_CENTER WHERE UPJANG = " + fa_UPJANG + ") \n");
// 				sbSql.append("                               AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN APPLY_DATE AND TO_CHAR(ADD_MONTHS(TO_DATE(APPLY_DATE,'YYYYMMDD'),1)-1,'YYYYMMDD') \n");
// 				sbSql.append("                             GROUP BY CENTER_CODE, CUSTCD, ITEM_CODE \n");
// 				sbSql.append("                           ) \n");
// 				sbSql.append("                    ) A, \n");
// 				sbSql.append("                    ( \n");
// 				sbSql.append("                    SELECT A.CENTER_CODE, A.CUSTCD, A.ITEM_CODE \n");
// 				sbSql.append("                      FROM HLDC_PO_CONTRACT_FSALE A, HLDC_ST_UPJANG B \n");
// 				sbSql.append("                     WHERE A.UPJANG = B.AP_UNITPRICE_UPJANG \n");
// 				sbSql.append("                       AND B.UPJANG = " + fa_UPJANG + " \n");
// 				sbSql.append("                    ) B \n");
// 				sbSql.append("             WHERE A.CENTER_CODE = B.CENTER_CODE \n");
// 				sbSql.append("               AND A.CUSTCD = B.CUSTCD \n");
// 				sbSql.append("               AND A.ITEM_CODE = B.ITEM_CODE \n");
// 				sbSql.append("       ) I \n");
				sbSql.append(" WHERE A.RECIPE_CD = C.RECIPE_CD \n");
				sbSql.append("   AND C.RECIPE_CD = D.RECIPE_CD \n");
				sbSql.append("   AND D.ITEM_CODE = E.ITEM_CODE(+) \n");
				sbSql.append("   AND D.ITEM_CODE = F.ITEM_CODE \n");
// 				sbSql.append("   AND D.ITEM_CODE = I.ITEM_CODE(+) \n");
				sbSql.append("   AND A.UPJANG = " + fa_MainUpjang + " \n");
				sbSql.append("   AND A.MENU_CD = '" + strMenuCD + "' \n");
				sbSql.append(" ORDER BY A.RECIPE_SEQ, C.RECIPE_TYPE, C.CUISINE_TYPE, A.RECIPE_CD, D.NEED_QTY DESC \n");
			}
		}
		                                                                                                                                                             
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
		ex.printStackTrace();                                                                                                                                                                               
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
	}                                                                                                                                                                                                     
                                                                                                                                                                                                        
	proc_output(response,out,out_vl,out_dl);                                                                                                                                                              
                                                                                                                                                                                                        
%>