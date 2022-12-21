<%                                                                                                                                                                                                      
/*-----------------------------------------------------------------------------                                                                                                                         
■ 시스템명     : 메뉴관리/레시피관리                                                                                                                                                                     
■ 프로그램ID   : FMM00070V_S001.jsp                                                                                                                                                                    
■ 프로그램명   : 레시피조회                                                                                                                                   
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
	                                                                                                                                                                                                        
	  	String strSType1 			= nullToBlank(ds_input.getString(0, "STYPE1"));
	  	String strSType2 			= nullToBlank(ds_input.getString(0, "STYPE2"));
	  	String strMainUpjang		= nullToBlank(ds_input.getString(0, "MAIN_UPJANG"));
	  	String strUpjang 			= nullToBlank(ds_input.getString(0, "UPJANG"));
	  	String strSubinvClass		= nullToBlank(ds_input.getString(0, "SUBINV_CLASS"));
	  	String strRecipeClass 		= nullToBlank(ds_input.getString(0, "RECIPE_CLASS"));
	  	String strRecipeType 		= nullToBlank(ds_input.getString(0, "RECIPE_TYPE"));
	  	String strCusineType 		= nullToBlank(ds_input.getString(0, "CUISINE_TYPE"));
	  	String strRecipeName 		= nullToBlank(ds_input.getString(0, "RECIPE_NAME"));

		//out 데이타                                                                                                                                                                                        
		DataSet ds_list;                                                                                                                                                                                    

		//sql문 버퍼생성                                                                                                                                                                                    
		StringBuffer sbSql = new StringBuffer();       
		
		if (strSType1.equals("1"))	// 한화표준레시피
		{
			sbSql.delete(0, sbSql.length());
			sbSql.append("SELECT \n");
			sbSql.append("       A.RECIPE_CD,  --레시피코드 \n");
			sbSql.append("       A.RECIPE_NAME, --레시피명 \n");
			sbSql.append("       A.RECIPE_CLASS, \n");
			sbSql.append("       (SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0001' AND CODE = A.RECIPE_CLASS) CLASS_NAME, --레시피분류 \n");
			sbSql.append("       A.RECIPE_TYPE, \n");
			sbSql.append("       (SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0002' AND CODE = A.RECIPE_TYPE) TYPE_NAME, --레시피유형 \n");
			sbSql.append("       A.CUISINE_TYPE, \n");
			sbSql.append("       (SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0003' AND CODE = A.CUISINE_TYPE) CUISINE_NAME, --조리법유형 \n");
			sbSql.append("       A.MAIN_ITEM_CODE1, \n");
			sbSql.append("       (SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0006' AND CODE = A.MAIN_ITEM_CODE1) MAIN_ITEM_NAME, --주재료군 \n");
			sbSql.append("       A.RESP_NUT1, \n");
			sbSql.append("       (SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0004' AND CODE = A.RESP_NUT1) RESP_NUT_NAME, --대표영양성분 \n");
			sbSql.append("       SUM(ROUND( NVL(D.CAL,0) * B.NEED_QTY / 100,2) ) AS RECIPE_CAL,  -- 열량 \n");
			sbSql.append("       SUM(ROUND( NVL(D.PROT,0) * B.NEED_QTY / 100,2) ) AS RECIPE_PROT,  -- 단백질 \n");
			sbSql.append("       SUM(ROUND( NVL(D.CA,0) * B.NEED_QTY / 100,2) ) AS RECIPE_CA,  -- 칼슘 \n");
			sbSql.append("       SUM(ROUND( NVL(D.FE,0) * B.NEED_QTY / 100,2) ) AS RECIPE_FE  -- 철 \n");
			if (strSType2.equals("1"))	// 원가불포함
			{
				sbSql.append("       , 0 AS OP_PRICE \n");
				sbSql.append("   FROM FMR_STD_RECIPE_MST A , \n");
				sbSql.append("      (SELECT NVL(B.ITEM_CODE_TO,A.ITEM_CODE) AS ITEM_CODE \n");
				sbSql.append("             , A.RECIPE_CD, A.ITEM_SEQ, A.NEED_QTY, A.EDIBLE_QTY, A.CUT_SPEC, A.USE_YN \n");
				sbSql.append("          FROM FMR_STD_RECIPE_ITEM A \n");
				sbSql.append("             ,(SELECT * FROM FMM_CHG_ITEM_LIST B WHERE UPJANG = " + strUpjang + " AND USE_YN = 'Y') B \n");
				sbSql.append("         WHERE A.ITEM_CODE = B.ITEM_CODE(+) \n");
				sbSql.append("       ) B, \n");
				sbSql.append("       ( \n");
				sbSql.append("        SELECT ITEM_CODE, CAL, PROT, CA, FE \n");
				sbSql.append("          FROM FMP_ITEM_NUT \n");
				sbSql.append("         WHERE UPJANG = " + strMainUpjang + " \n");
				sbSql.append("         UNION ALL \n");
				sbSql.append("        SELECT ITEM_CODE, CAL, PROT, CA, FE \n");
				sbSql.append("          FROM FSI_ITEM_NUT \n");
				sbSql.append("         WHERE ITEM_CODE IN \n");
				sbSql.append("              ( \n");
				sbSql.append("               SELECT ITEM_CODE \n");
				sbSql.append("                 FROM FSI_ITEM_NUT MINUS \n");
				sbSql.append("               SELECT ITEM_CODE \n");
				sbSql.append("                 FROM FMP_ITEM_NUT \n");
				sbSql.append("                WHERE UPJANG = " + strMainUpjang + " \n");
				sbSql.append("              ) \n");
				sbSql.append("       ) D \n");
				sbSql.append(" WHERE A.RECIPE_CD = B.RECIPE_CD \n");
				sbSql.append("   AND B.ITEM_CODE = D.ITEM_CODE(+) \n");
			}
			else							// 원가포함
			{
				sbSql.append("       ,SUM(ROUND(B.NEED_QTY * (NVL(E.OP_PRICE,0) / F.KG_CONVERT_RATE / 1000) )) AS OP_PRICE --1인원가 \n");
				sbSql.append("   FROM FMR_STD_RECIPE_MST A , \n");
				sbSql.append("      (SELECT NVL(B.ITEM_CODE_TO,A.ITEM_CODE) AS ITEM_CODE \n");
				sbSql.append("             , A.RECIPE_CD, A.ITEM_SEQ, A.NEED_QTY, A.EDIBLE_QTY, A.CUT_SPEC, A.USE_YN \n");
				sbSql.append("          FROM FMR_STD_RECIPE_ITEM A \n");
				sbSql.append("             ,(SELECT * FROM FMM_CHG_ITEM_LIST B WHERE UPJANG = " + strUpjang + " AND USE_YN = 'Y') B \n");
				sbSql.append("         WHERE A.ITEM_CODE = B.ITEM_CODE(+) \n");
				sbSql.append("       ) B, \n");
				sbSql.append("       ( \n");
				sbSql.append("        SELECT ITEM_CODE, CAL, PROT, CA, FE \n");
				sbSql.append("          FROM FMP_ITEM_NUT \n");
				sbSql.append("         WHERE UPJANG = " + strMainUpjang + " \n");
				sbSql.append("         UNION ALL \n");
				sbSql.append("        SELECT ITEM_CODE, CAL, PROT, CA, FE \n");
				sbSql.append("          FROM FSI_ITEM_NUT \n");
				sbSql.append("         WHERE ITEM_CODE IN \n");
				sbSql.append("              ( \n");
				sbSql.append("               SELECT ITEM_CODE \n");
				sbSql.append("                 FROM FSI_ITEM_NUT MINUS \n");
				sbSql.append("               SELECT ITEM_CODE \n");
				sbSql.append("                 FROM FMP_ITEM_NUT \n");
				sbSql.append("                WHERE UPJANG = " + strMainUpjang + " \n");
				sbSql.append("              ) \n");
				sbSql.append("       ) D \n");
				sbSql.append("       , ( \n");
				sbSql.append("            SELECT \n");
				sbSql.append("                   A.UPJANG, A.ITEM_CODE \n");
				sbSql.append("                 , A.UNIT_PRICE, A.SALE_PRICE \n");
				
				sbSql.append("                 , CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL              \n");
		    	sbSql.append("                        THEN DECODE(SIGN(NVL(C.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE) \n");
		    	sbSql.append("                        WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL              \n");
		    	sbSql.append("                        THEN DECODE(SIGN(NVL(D.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL), D.OP_PRICE) \n");
		    	sbSql.append("                        ELSE A.SALE_PRICE END AS OP_PRICE --운영단가                                 \n");
				
				sbSql.append("              FROM \n");
				sbSql.append("                   ( \n");        
				sbSql.append("                   SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL \n");
				sbSql.append("                     FROM FMU_OP_RATE \n");
				sbSql.append("                    WHERE UPJANG = "+strUpjang+" \n");
				sbSql.append("                      AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN SDATE AND EDATE \n");
				sbSql.append("                      AND USE_YN = 'Y' \n");
				sbSql.append("                      AND ITEM_TYPE = 'M' \n");
				sbSql.append("                   ) C \n");
				sbSql.append("                 , ( \n");        
				sbSql.append("                   SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL \n");
				sbSql.append("                     FROM FMU_OP_RATE \n");
				sbSql.append("                    WHERE UPJANG = "+strUpjang+" \n");
				sbSql.append("                      AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN SDATE AND EDATE \n");
				sbSql.append("                      AND USE_YN = 'Y' \n");
				sbSql.append("                      AND ITEM_TYPE = 'C' \n");
				sbSql.append("                   ) D \n");
				
				sbSql.append("                 , ( \n");
				sbSql.append("                   SELECT \n");
				sbSql.append("                          " + strUpjang + " AS UPJANG, NVL('',TO_CHAR(SYSDATE,'YYYYMMDD')) AS NEED_DATE \n");
				sbSql.append("                        , A.ITEM_CODE, A.CONTRACT_PRICE AS UNIT_PRICE, A.SALE_PRICE, C.ITEM_CLASS4 \n");
				sbSql.append("                     FROM HLDC_PO_CONTRACT_FSALE A, HLDC_ST_UPJANG B, HLDC_PO_ITEM_MST C \n");
				sbSql.append("                    WHERE A.UPJANG = B.AP_UNITPRICE_UPJANG \n");
				sbSql.append("                      AND B.UPJANG = " + strUpjang + " \n");
				sbSql.append("                      AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN A.CONTRACT_START AND NVL(A.CONTRACT_END, '99999999') \n");
				
				sbSql.append("                      AND A.SALE_PRICE > 0 \n");
				sbSql.append("                      AND A.USE_YN = 'Y' \n");
				sbSql.append("                      AND A.ITEM_CODE = C.ITEM_CODE \n");
				sbSql.append("                   ----------- \n");
				sbSql.append("                    UNION ALL \n");
				sbSql.append("                   ----------- \n");
				sbSql.append("                   SELECT " + strUpjang + " AS UPJANG, NVL('',TO_CHAR(SYSDATE,'YYYYMMDD')) AS NEED_DATE \n");
				sbSql.append("                        , A.ITEM_CODE, A.UNIT_PRICE, A.SALE_PRICE, C.ITEM_CLASS4 \n");
				sbSql.append("                     FROM FMP_OTCUST_PRICE_AVA_V A, FMP_OTCUST_ITEM C \n");
				sbSql.append("                        ,(SELECT UPJANG, ITEM_CODE, MAX(SDATE) AS SDATE \n");
				sbSql.append("                            FROM FMP_OTCUST_PRICE_AVA_V \n");
				sbSql.append("                           WHERE UPJANG = (SELECT OTCUST_PRICE_UPJANG FROM FMS_UPJANG WHERE UPJANG = " + strUpjang + ") \n");
				sbSql.append("                             AND SDATE <= NVL('',TO_CHAR(SYSDATE,'YYYYMMDD')) \n");
				sbSql.append("                           GROUP BY UPJANG, ITEM_CODE) B \n");
				sbSql.append("                    WHERE A.UPJANG = B.UPJANG \n");
				sbSql.append("                      AND A.SDATE = B.SDATE \n");
				sbSql.append("                      AND A.ITEM_CODE = B.ITEM_CODE \n");
				sbSql.append("                      AND A.SALE_PRICE > 0 \n");
				sbSql.append("                      AND A.USE_YN = 'Y' \n");
				sbSql.append("                      AND A.ITEM_CODE = C.ITEM_CODE \n");
				sbSql.append("                  ) A \n");
				
			    sbSql.append("             WHERE A.ITEM_CODE = C.ITEM_CODE(+) \n");
    		    sbSql.append("               AND A.ITEM_CLASS4 = D.ITEM_CODE(+) \n");
				
				sbSql.append("         ) E, \n");
				sbSql.append("       ( \n");
				sbSql.append("       SELECT ITEM_CODE, \n");
				sbSql.append("              ITEM_NAME, \n");
				sbSql.append("              ITEM_SIZE, \n");
				sbSql.append("              PO_UOM, \n");
				sbSql.append("              KG_CONVERT_RATE \n");
				sbSql.append("         FROM FMS_ITEM_V \n");
				sbSql.append("        WHERE ITEM_CLASS1 = 'F' \n");
				sbSql.append("       ) F \n");
				sbSql.append(" WHERE A.RECIPE_CD = B.RECIPE_CD \n");
				sbSql.append("   AND B.ITEM_CODE = D.ITEM_CODE(+) \n");
				sbSql.append("   AND B.ITEM_CODE = F.ITEM_CODE \n");
				sbSql.append("   AND B.ITEM_CODE = E.ITEM_CODE(+) \n");
			}
			if (strRecipeName.length() != 0)	sbSql.append("   AND A.RECIPE_NAME LIKE '%' || '" + strRecipeName + "' ||  '%' \n");
			if (strRecipeClass.length() != 0)	sbSql.append("   AND A.RECIPE_CLASS = '" + strRecipeClass + "' \n");
			if (strRecipeType.length() != 0)	sbSql.append("   AND A.RECIPE_TYPE = '" + strRecipeType + "' \n");
			if (strCusineType.length() != 0)	sbSql.append("   AND A.CUISINE_TYPE = '" + strCusineType + "' \n");
			sbSql.append("  GROUP BY A.RECIPE_CD, \n");
			sbSql.append("       A.RECIPE_NAME, \n");
			sbSql.append("       A.RECIPE_CLASS, \n");
			sbSql.append("       A.RECIPE_TYPE, \n");
			sbSql.append("       A.CUISINE_TYPE, \n");
			sbSql.append("       A.MAIN_ITEM_CODE1, \n");
			sbSql.append("       A.RESP_NUT1, \n");
			sbSql.append("       A.CDATE \n");
			sbSql.append("ORDER BY A.RECIPE_CLASS, A.RECIPE_TYPE, A.CUISINE_TYPE, A.RECIPE_CD \n");
		}
		else if (strSType1.equals("2"))	// 본사표준레시피
		{
			sbSql.delete(0, sbSql.length());
			sbSql.append("SELECT A.RECIPE_CD,  --레시피코드 \n");
			sbSql.append("       A.RECIPE_NAME, --레시피명 \n");
			sbSql.append("       A.RECIPE_CLASS, \n");
			sbSql.append("       (SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0001' AND CODE = A.RECIPE_CLASS) CLASS_NAME, --레시피분류 \n");
			sbSql.append("       A.RECIPE_TYPE, \n");
			sbSql.append("       (SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0002' AND CODE = A.RECIPE_TYPE) TYPE_NAME, --레시피유형 \n");
			sbSql.append("       A.CUISINE_TYPE, \n");
			sbSql.append("       (SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0003' AND CODE = A.CUISINE_TYPE) CUISINE_NAME, --조리법유형 \n");
			sbSql.append("       A.MAIN_ITEM_CODE1, \n");
			sbSql.append("       (SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0006' AND CODE = A.MAIN_ITEM_CODE1) MAIN_ITEM_NAME, --주재료군 \n");
			sbSql.append("       A.RESP_NUT1, \n");
			sbSql.append("       (SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0004' AND CODE = A.RESP_NUT1) RESP_NUT_NAME, --대표영양성분 \n");
			sbSql.append("       SUM(ROUND( NVL(D.CAL,0) * B.NEED_QTY / 100,2) ) AS RECIPE_CAL,  -- 열량 \n");
			sbSql.append("       SUM(ROUND( NVL(D.PROT,0) * B.NEED_QTY / 100,2) ) AS RECIPE_PROT,  -- 단백질 \n");
			sbSql.append("       SUM(ROUND( NVL(D.CA,0) * B.NEED_QTY / 100,2) ) AS RECIPE_CA,  -- 칼슘 \n");
			sbSql.append("       SUM(ROUND( NVL(D.FE,0) * B.NEED_QTY / 100,2) ) AS RECIPE_FE  -- 철 \n");
			if (strSType2.equals("1"))	// 원가불포함
			{
				sbSql.append("       , 0 AS OP_PRICE \n");
				sbSql.append("  FROM FMM_STD_RECIPE_MST A , \n");
				sbSql.append("       FMM_STD_RECIPE_ITEM B , \n");
				sbSql.append("       ( \n");
				sbSql.append("        SELECT ITEM_CODE, CAL, PROT, CA, FE \n");
				sbSql.append("          FROM FMP_ITEM_NUT \n");
				sbSql.append("         WHERE UPJANG = " + strMainUpjang + " \n");
				sbSql.append("         UNION ALL \n");
				sbSql.append("        SELECT ITEM_CODE, CAL, PROT, CA, FE \n");
				sbSql.append("          FROM FSI_ITEM_NUT \n");
				sbSql.append("         WHERE ITEM_CODE IN \n");
				sbSql.append("              ( \n");
				sbSql.append("               SELECT ITEM_CODE \n");
				sbSql.append("                 FROM FSI_ITEM_NUT MINUS \n");
				sbSql.append("               SELECT ITEM_CODE \n");
				sbSql.append("                 FROM FMP_ITEM_NUT \n");
				sbSql.append("                WHERE UPJANG = " + strMainUpjang + " \n");
				sbSql.append("              ) \n");
				sbSql.append("       ) D \n");
				sbSql.append(" WHERE A.UPJANG = " + strMainUpjang + " \n");
				sbSql.append("   AND A.UPJANG = B.UPJANG \n");
				sbSql.append("   AND A.RECIPE_CD = B.RECIPE_CD \n");
				sbSql.append("   AND B.ITEM_CODE = D.ITEM_CODE(+) \n");
			}
			else
			{
				sbSql.append("       ,SUM(ROUND(B.NEED_QTY * (NVL(E.OP_PRICE,0) / F.KG_CONVERT_RATE / 1000) )) AS OP_PRICE --1인원가 \n");
				sbSql.append("  FROM FMM_STD_RECIPE_MST A , \n");
				sbSql.append("       FMM_STD_RECIPE_ITEM B , \n");
				sbSql.append("       ( \n");
				sbSql.append("        SELECT ITEM_CODE, CAL, PROT, CA, FE \n");
				sbSql.append("          FROM FMP_ITEM_NUT \n");
				sbSql.append("         WHERE UPJANG = " + strMainUpjang + " \n");
				sbSql.append("         UNION ALL \n");
				sbSql.append("        SELECT ITEM_CODE, CAL, PROT, CA, FE \n");
				sbSql.append("          FROM FSI_ITEM_NUT \n");
				sbSql.append("         WHERE ITEM_CODE IN \n");
				sbSql.append("              ( \n");
				sbSql.append("               SELECT ITEM_CODE \n");
				sbSql.append("                 FROM FSI_ITEM_NUT MINUS \n");
				sbSql.append("               SELECT ITEM_CODE \n");
				sbSql.append("                 FROM FMP_ITEM_NUT \n");
				sbSql.append("                WHERE UPJANG = " + strMainUpjang + " \n");
				sbSql.append("              ) \n");
				sbSql.append("       ) D \n");
				sbSql.append("        , ( \n");
				sbSql.append("        SELECT \n");
				sbSql.append("               A.UPJANG, A.ITEM_CODE \n");
				sbSql.append("             , A.UNIT_PRICE, A.SALE_PRICE \n");
				
				sbSql.append("             , CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL              \n");
		    	sbSql.append("                    THEN DECODE(SIGN(NVL(C.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE) \n");
		    	sbSql.append("                    WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL              \n");
		    	sbSql.append("                    THEN DECODE(SIGN(NVL(D.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL), D.OP_PRICE) \n");
		    	sbSql.append("                    ELSE A.SALE_PRICE END AS OP_PRICE --운영단가                                 \n");
					
				sbSql.append("          FROM \n");
				sbSql.append("               ( \n");        
				sbSql.append("               SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL \n");
				sbSql.append("                 FROM FMU_OP_RATE \n");
				sbSql.append("                WHERE UPJANG = "+strUpjang+" \n");
				sbSql.append("                  AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN SDATE AND EDATE \n");
				sbSql.append("                  AND USE_YN = 'Y' \n");
				sbSql.append("                  AND ITEM_TYPE = 'M' \n");
				sbSql.append("               ) C \n");
				sbSql.append("             , ( \n");        
				sbSql.append("               SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL \n");
				sbSql.append("                 FROM FMU_OP_RATE \n");
				sbSql.append("                WHERE UPJANG = "+strUpjang+" \n");
				sbSql.append("                  AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN SDATE AND EDATE \n");
				sbSql.append("                  AND USE_YN = 'Y' \n");
				sbSql.append("                  AND ITEM_TYPE = 'C' \n");
				sbSql.append("               ) D \n");
				
				sbSql.append("             ,( \n");
				sbSql.append("                   SELECT \n");
				sbSql.append("                          " + strUpjang + " AS UPJANG, NVL('',TO_CHAR(SYSDATE,'YYYYMMDD')) AS NEED_DATE \n");
				sbSql.append("                        , A.ITEM_CODE, A.CONTRACT_PRICE AS UNIT_PRICE, A.SALE_PRICE, C.ITEM_CLASS4 \n");
				sbSql.append("                     FROM HLDC_PO_CONTRACT_FSALE A, HLDC_ST_UPJANG B, HLDC_PO_ITEM_MST C \n");
				sbSql.append("                    WHERE A.UPJANG = B.AP_UNITPRICE_UPJANG \n");
				sbSql.append("                      AND B.UPJANG = " + strUpjang + " \n");
				sbSql.append("                      AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN A.CONTRACT_START AND NVL(A.CONTRACT_END, '99999999') \n");
				
				sbSql.append("                      AND A.SALE_PRICE > 0 \n");
				sbSql.append("                      AND A.USE_YN = 'Y' \n");
				sbSql.append("                      AND A.ITEM_CODE = C.ITEM_CODE \n");
				sbSql.append("               ----------- \n");
				sbSql.append("                UNION ALL \n");
				sbSql.append("               ----------- \n");
				sbSql.append("               SELECT " + strUpjang + " AS UPJANG, NVL('',TO_CHAR(SYSDATE,'YYYYMMDD')) AS NEED_DATE \n");
				sbSql.append("                    , A.ITEM_CODE, A.UNIT_PRICE, A.SALE_PRICE, C.ITEM_CLASS4 \n");
				sbSql.append("                 FROM FMP_OTCUST_PRICE_AVA_V A, FMP_OTCUST_ITEM C \n");
				sbSql.append("                    ,(SELECT UPJANG, ITEM_CODE, MAX(SDATE) AS SDATE \n");
				sbSql.append("                        FROM FMP_OTCUST_PRICE_AVA_V \n");
				sbSql.append("                       WHERE UPJANG = (SELECT OTCUST_PRICE_UPJANG FROM FMS_UPJANG WHERE UPJANG = " + strUpjang + ") \n");
				sbSql.append("                         AND SDATE <= NVL('',TO_CHAR(SYSDATE,'YYYYMMDD')) \n");
				sbSql.append("                       GROUP BY UPJANG, ITEM_CODE) B \n");
				sbSql.append("                WHERE A.UPJANG = B.UPJANG \n");
				sbSql.append("                  AND A.SDATE = B.SDATE \n");
				sbSql.append("                  AND A.ITEM_CODE = B.ITEM_CODE \n");
				sbSql.append("                  AND A.SALE_PRICE > 0 \n");
				sbSql.append("                  AND A.USE_YN = 'Y' \n");
				sbSql.append("                  AND A.ITEM_CODE = C.ITEM_CODE \n");
				sbSql.append("              ) A \n");
				
				sbSql.append("         WHERE A.ITEM_CODE = C.ITEM_CODE(+) \n");
    		    sbSql.append("           AND A.ITEM_CLASS4 = D.ITEM_CODE(+) \n");
				
				sbSql.append("       ) E, \n");
				sbSql.append("       ( \n");
				sbSql.append("       SELECT ITEM_CODE, \n");
				sbSql.append("              ITEM_NAME, \n");
				sbSql.append("              ITEM_SIZE, \n");
				sbSql.append("              PO_UOM, \n");
				sbSql.append("              KG_CONVERT_RATE \n");
				sbSql.append("         FROM FMS_ITEM_V \n");
				sbSql.append("        WHERE ITEM_CLASS1 = 'F' \n");
				sbSql.append("       ) F \n");
				sbSql.append(" WHERE A.UPJANG = " + strMainUpjang + " \n");
				sbSql.append("   AND A.UPJANG = B.UPJANG \n");
				sbSql.append("   AND A.RECIPE_CD = B.RECIPE_CD \n");
				sbSql.append("   AND B.ITEM_CODE = D.ITEM_CODE(+) \n");
				sbSql.append("   AND B.ITEM_CODE = F.ITEM_CODE \n");
				sbSql.append("   AND B.ITEM_CODE = E.ITEM_CODE(+) \n");
			}
			if (strRecipeName.length() != 0)	sbSql.append("   AND A.RECIPE_NAME LIKE '%' || '" + strRecipeName + "' ||  '%' \n");
			if (strRecipeClass.length() != 0)	sbSql.append("   AND A.RECIPE_CLASS = '" + strRecipeClass + "' \n");
			if (strRecipeType.length() != 0)	sbSql.append("   AND A.RECIPE_TYPE = '" + strRecipeType + "' \n");
			if (strCusineType.length() != 0)	sbSql.append("   AND A.CUISINE_TYPE = '" + strCusineType + "' \n");
			sbSql.append("  GROUP BY A.RECIPE_CD, \n");
			sbSql.append("       A.RECIPE_NAME, \n");
			sbSql.append("       A.RECIPE_CLASS, \n");
			sbSql.append("       A.RECIPE_TYPE, \n");
			sbSql.append("       A.CUISINE_TYPE, \n");
			sbSql.append("       A.MAIN_ITEM_CODE1, \n");
			sbSql.append("       A.RESP_NUT1, \n");
			sbSql.append("       A.CDATE \n");
			sbSql.append("ORDER BY A.RECIPE_CLASS, A.RECIPE_TYPE, A.CUISINE_TYPE, A.RECIPE_CD \n");
		}
		else					// 사업장레시피
		{
			sbSql.delete(0, sbSql.length());
			sbSql.append("SELECT A.RECIPE_CD,  --레시피코드 \n");
			sbSql.append("       A.RECIPE_NAME, --레시피명 \n");
			sbSql.append("       A.RECIPE_CLASS, \n");
			sbSql.append("       (SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0001' AND CODE = A.RECIPE_CLASS) CLASS_NAME, --레시피분류 \n");
			sbSql.append("       A.RECIPE_TYPE, \n");
			sbSql.append("       (SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0002' AND CODE = A.RECIPE_TYPE) TYPE_NAME, --레시피유형 \n");
			sbSql.append("       A.CUISINE_TYPE, \n");
			sbSql.append("       (SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0003' AND CODE = A.CUISINE_TYPE) CUISINE_NAME, --조리법유형 \n");
			sbSql.append("       A.MAIN_ITEM_CODE1, \n");
			sbSql.append("       (SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0006' AND CODE = A.MAIN_ITEM_CODE1) MAIN_ITEM_NAME, --주재료군 \n");
			sbSql.append("       A.RESP_NUT1, \n");
			sbSql.append("       (SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0004' AND CODE = A.RESP_NUT1) RESP_NUT_NAME, --대표영양성분 \n");
			sbSql.append("       SUM(ROUND( NVL(D.CAL,0) * B.NEED_QTY / 100,2) ) AS RECIPE_CAL,  -- 열량 \n");
			sbSql.append("       SUM(ROUND( NVL(D.PROT,0) * B.NEED_QTY / 100,2) ) AS RECIPE_PROT,  -- 단백질 \n");
			sbSql.append("       SUM(ROUND( NVL(D.CA,0) * B.NEED_QTY / 100,2) ) AS RECIPE_CA,  -- 칼슘 \n");
			sbSql.append("       SUM(ROUND( NVL(D.FE,0) * B.NEED_QTY / 100,2) ) AS RECIPE_FE  -- 철 \n");
			if (strSType2.equals("1"))	// 원가불포함
			{
				sbSql.append("       , 0 AS OP_PRICE \n");
				sbSql.append("  FROM FMM_UPJANG_RECIPE_MST A , \n");
				sbSql.append("       FMM_UPJANG_RECIPE_ITEM B , \n");
				sbSql.append("       ( \n");
				sbSql.append("        SELECT ITEM_CODE, CAL, PROT, CA, FE \n");
				sbSql.append("          FROM FMP_ITEM_NUT \n");
				sbSql.append("         WHERE UPJANG = " + strMainUpjang + " \n");
				sbSql.append("         UNION ALL \n");
				sbSql.append("        SELECT ITEM_CODE, CAL, PROT, CA, FE \n");
				sbSql.append("          FROM FSI_ITEM_NUT \n");
				sbSql.append("         WHERE ITEM_CODE IN \n");
				sbSql.append("              ( \n");
				sbSql.append("               SELECT ITEM_CODE \n");
				sbSql.append("                 FROM FSI_ITEM_NUT MINUS \n");
				sbSql.append("               SELECT ITEM_CODE \n");
				sbSql.append("                 FROM FMP_ITEM_NUT \n");
				sbSql.append("                WHERE UPJANG = " + strMainUpjang + " \n");
				sbSql.append("              ) \n");
				sbSql.append("       ) D \n");
				sbSql.append(" WHERE A.UPJANG = " + strUpjang + " \n");
				sbSql.append("   AND A.UPJANG = B.UPJANG \n");
				sbSql.append("   AND A.RECIPE_CD = B.RECIPE_CD \n");
				sbSql.append("   AND B.ITEM_CODE = D.ITEM_CODE(+) \n");
			}
			else
			{
				sbSql.append("       ,SUM(ROUND(B.NEED_QTY * (NVL(E.OP_PRICE,0) / F.KG_CONVERT_RATE / 1000) )) AS OP_PRICE --1인원가 \n");
				sbSql.append("  FROM FMM_UPJANG_RECIPE_MST A , \n");
				sbSql.append("       FMM_UPJANG_RECIPE_ITEM B , \n");
				sbSql.append("       ( \n");
				sbSql.append("        SELECT ITEM_CODE, CAL, PROT, CA, FE \n");
				sbSql.append("          FROM FMP_ITEM_NUT \n");
				sbSql.append("         WHERE UPJANG = " + strMainUpjang + " \n");
				sbSql.append("         UNION ALL \n");
				sbSql.append("        SELECT ITEM_CODE, CAL, PROT, CA, FE \n");
				sbSql.append("          FROM FSI_ITEM_NUT \n");
				sbSql.append("         WHERE ITEM_CODE IN \n");
				sbSql.append("              ( \n");
				sbSql.append("               SELECT ITEM_CODE \n");
				sbSql.append("                 FROM FSI_ITEM_NUT MINUS \n");
				sbSql.append("               SELECT ITEM_CODE \n");
				sbSql.append("                 FROM FMP_ITEM_NUT \n");
				sbSql.append("                WHERE UPJANG = " + strMainUpjang + " \n");
				sbSql.append("              ) \n");
				sbSql.append("       ) D \n");
				sbSql.append("        , ( \n");
				sbSql.append("        SELECT \n");
				sbSql.append("               A.UPJANG, A.ITEM_CODE \n");
				sbSql.append("             , A.UNIT_PRICE, A.SALE_PRICE \n");
				
				sbSql.append("             , CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL              \n");
		    	sbSql.append("                    THEN DECODE(SIGN(NVL(C.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE) \n");
		    	sbSql.append("                    WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL              \n");
		    	sbSql.append("                    THEN DECODE(SIGN(NVL(D.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL), D.OP_PRICE) \n");
		    	sbSql.append("                    ELSE A.SALE_PRICE END AS OP_PRICE --운영단가                                 \n");
					
				sbSql.append("          FROM \n");
				sbSql.append("               ( \n");        
				sbSql.append("               SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL \n");
				sbSql.append("                 FROM FMU_OP_RATE \n");
				sbSql.append("                WHERE UPJANG = "+strUpjang+" \n");
				sbSql.append("                  AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN SDATE AND EDATE \n");
				sbSql.append("                  AND USE_YN = 'Y' \n");
				sbSql.append("                  AND ITEM_TYPE = 'M' \n");
				sbSql.append("               ) C \n");
				sbSql.append("             , ( \n");        
				sbSql.append("               SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL \n");
				sbSql.append("                 FROM FMU_OP_RATE \n");
				sbSql.append("                WHERE UPJANG = "+strUpjang+" \n");
				sbSql.append("                  AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN SDATE AND EDATE \n");
				sbSql.append("                  AND USE_YN = 'Y' \n");
				sbSql.append("                  AND ITEM_TYPE = 'C' \n");
				sbSql.append("               ) D \n");
				
				sbSql.append("             ,( \n");
				sbSql.append("                   SELECT \n");
				sbSql.append("                          " + strUpjang + " AS UPJANG, NVL('',TO_CHAR(SYSDATE,'YYYYMMDD')) AS NEED_DATE \n");
				sbSql.append("                        , A.ITEM_CODE, A.CONTRACT_PRICE AS UNIT_PRICE, A.SALE_PRICE, C.ITEM_CLASS4 \n");
				sbSql.append("                     FROM HLDC_PO_CONTRACT_FSALE A, HLDC_ST_UPJANG B, HLDC_PO_ITEM_MST C \n");
				sbSql.append("                    WHERE A.UPJANG = B.AP_UNITPRICE_UPJANG \n");
				sbSql.append("                      AND B.UPJANG = " + strUpjang + " \n");
				sbSql.append("                      AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN A.CONTRACT_START AND NVL(A.CONTRACT_END, '99999999') \n");
				
				sbSql.append("                      AND A.SALE_PRICE > 0 \n");
				sbSql.append("                      AND A.USE_YN = 'Y' \n");
				sbSql.append("                      AND A.ITEM_CODE = C.ITEM_CODE \n");
				sbSql.append("               ----------- \n");
				sbSql.append("                UNION ALL \n");
				sbSql.append("               ----------- \n");
				sbSql.append("               SELECT " + strUpjang + " AS UPJANG, NVL('',TO_CHAR(SYSDATE,'YYYYMMDD')) AS NEED_DATE \n");
				sbSql.append("                    , A.ITEM_CODE, A.UNIT_PRICE, A.SALE_PRICE, C.ITEM_CLASS4 \n");
				sbSql.append("                 FROM FMP_OTCUST_PRICE_AVA_V A, FMP_OTCUST_ITEM C \n");
				sbSql.append("                    ,(SELECT UPJANG, ITEM_CODE, MAX(SDATE) AS SDATE \n");
				sbSql.append("                        FROM FMP_OTCUST_PRICE_AVA_V \n");
				sbSql.append("                       WHERE UPJANG = (SELECT OTCUST_PRICE_UPJANG FROM FMS_UPJANG WHERE UPJANG = " + strUpjang + ") \n");
				sbSql.append("                         AND SDATE <= NVL('',TO_CHAR(SYSDATE,'YYYYMMDD')) \n");
				sbSql.append("                       GROUP BY UPJANG, ITEM_CODE) B \n");
				sbSql.append("                WHERE A.UPJANG = B.UPJANG \n");
				sbSql.append("                  AND A.SDATE = B.SDATE \n");
				sbSql.append("                  AND A.ITEM_CODE = B.ITEM_CODE \n");
				sbSql.append("                  AND A.SALE_PRICE > 0 \n");
				sbSql.append("                  AND A.USE_YN = 'Y' \n");
				sbSql.append("                  AND A.ITEM_CODE = C.ITEM_CODE \n");
				sbSql.append("              ) A \n");
				
				sbSql.append("         WHERE A.ITEM_CODE = C.ITEM_CODE(+) \n");
    		    sbSql.append("           AND A.ITEM_CLASS4 = D.ITEM_CODE(+) \n");
				
				sbSql.append("         ) E, \n");
				sbSql.append("       ( \n");
				sbSql.append("       SELECT ITEM_CODE, \n");
				sbSql.append("              ITEM_NAME, \n");
				sbSql.append("              ITEM_SIZE, \n");
				sbSql.append("              PO_UOM, \n");
				sbSql.append("              KG_CONVERT_RATE \n");
				sbSql.append("         FROM FMS_ITEM_V \n");
				
				sbSql.append("        WHERE ITEM_CLASS1 = 'F' \n");
				
				sbSql.append("       ) F \n");
				sbSql.append(" WHERE A.UPJANG = " + strUpjang + " \n");
				sbSql.append("   AND A.UPJANG = B.UPJANG \n");
				sbSql.append("   AND A.RECIPE_CD = B.RECIPE_CD \n");
				sbSql.append("   AND B.ITEM_CODE = D.ITEM_CODE(+) \n");
				sbSql.append("   AND B.ITEM_CODE = F.ITEM_CODE \n");
				sbSql.append("   AND B.ITEM_CODE = E.ITEM_CODE(+) \n");
			}
			if (strRecipeName.length() != 0)	sbSql.append("   AND A.RECIPE_NAME LIKE '%' || '" + strRecipeName + "' ||  '%' \n");
			if (strRecipeClass.length() != 0)	sbSql.append("   AND A.RECIPE_CLASS = '" + strRecipeClass + "' \n");
			if (strRecipeType.length() != 0)	sbSql.append("   AND A.RECIPE_TYPE = '" + strRecipeType + "' \n");
			if (strCusineType.length() != 0)	sbSql.append("   AND A.CUISINE_TYPE = '" + strCusineType + "' \n");
			sbSql.append("   AND A.SUBINV_CLASS = '" + strSubinvClass + "' \n");
			sbSql.append("  GROUP BY A.RECIPE_CD, \n");
			sbSql.append("       A.RECIPE_NAME, \n");
			sbSql.append("       A.RECIPE_CLASS, \n");
			sbSql.append("       A.RECIPE_TYPE, \n");
			sbSql.append("       A.CUISINE_TYPE, \n");
			sbSql.append("       A.MAIN_ITEM_CODE1, \n");
			sbSql.append("       A.RESP_NUT1, \n");
			sbSql.append("       A.CDATE \n");
			sbSql.append("ORDER BY A.RECIPE_CLASS, A.RECIPE_TYPE, A.CUISINE_TYPE, A.RECIPE_CD \n");
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