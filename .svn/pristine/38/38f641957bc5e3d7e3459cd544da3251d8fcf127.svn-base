<%                                                                                                                                                                                                      
/*-----------------------------------------------------------------------------                                                                                                                         
■ 시스템명     : 메뉴관리/식단관리                                                                                                                                                                     
■ 프로그램ID   : FMM00207E_S001.jsp                                                                                                                                                                    
■ 프로그램명   : 식단복사조회                                                                                                                          
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
		DataSet ds_input     	= in_dl.get("ds_input");                                                                                                                                                  
	    
		String strGBN 			= nullToBlank(ds_input.getString(0, "GBN"));
		String fa_UPJANG		= in_vl.getString("fa_UPJANG");
                                                                                                                                                                                                     
		//out 데이타                                                                                                                                                                                        
		DataSet ds_list;                                                                                                                                                                                    
		                                                                                                                                                                                                    
		//sql문 버퍼생성                                                                                                                                                                                    
		StringBuffer sbSql = new StringBuffer();                                                                                                                                                            
        
		sbSql.delete(0, sbSql.length());
		if (strGBN.equals("0"))				// 사업장레시피
		{
			String strTopCnt 			= nullToBlank(ds_input.getString(0, "TOPCNT"));
		  	String strUpjang 			= nullToBlank(ds_input.getString(0, "UPJANG"));
		  	String strSubinvCode 		= nullToBlank(ds_input.getString(0, "SUBINV_CODE"));
		  	String strFromDt 			= nullToBlank(ds_input.getString(0, "MENU_F_DATE1"));
		  	String strToDt 				= nullToBlank(ds_input.getString(0, "MENU_T_DATE1"));
		  	String strMeal 				= nullToBlank(ds_input.getString(0, "MEAL1"));
		  	String strCorner 			= nullToBlank(ds_input.getString(0, "CORNER1"));
		  	String strRecipeName		= nullToBlank(ds_input.getString(0, "RECIPE_NAME1"));
		  	
		  	if (strTopCnt.length() > 0)
			{
				sbSql.append("SELECT * FROM ( \n");
			}
			sbSql.append("SELECT A.UPJANG \n");
			sbSql.append("      ,A.MENU_CD \n");
			sbSql.append("      ,SUM(PAST_PRICE) AS PAST_PRICE --과거원가 \n");
			sbSql.append("      ,SUM(CUR_PRICE) AS CUR_PRICE --현재원가 \n");
			sbSql.append("      ,FMM_RECIPENAME_FUN(A.UPJANG, A.MENU_CD,'1') AS RECIPE_INFO --구성 \n");
			sbSql.append("      ,A.MENU_DATE       --제공일 \n");
			sbSql.append("      ,A.WDESC           --날씨 \n");
			sbSql.append("      ,A.SUBINV_CODE         --식당코드 \n");
			sbSql.append("      ,A.MEAL            --끼니코드 \n");
			sbSql.append("      ,(SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0023' AND CODE = A.MEAL) MEAL_NAME --끼니명 \n");
			sbSql.append("      ,A.CORNER          --코너코드 \n");
			sbSql.append("      ,(SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0022' AND CODE = A.CORNER) CORNER_NAME --코너명 \n");
			sbSql.append("      ,0 AS CHK          --선택 \n");
			sbSql.append("      ,A.UPJANG ||  A.MENU_CD AS MENU_ID --코너코드 \n");
			sbSql.append("      ,'" + strGBN + "' AS GBN          --구분 \n");
			sbSql.append("  FROM \n");
			sbSql.append("       ( \n");
			sbSql.append("        SELECT A.UPJANG, A.MENU_CD, A.MENU_DATE, A.SUBINV_CODE, A.MEAL, A.CORNER, D.WDESC, C.ITEM_CODE, C.NEED_QTY, \n");
			sbSql.append("               NVL(ROUND((C.NEED_QTY * NVL((C.OP_PRICE / E.KG_CONVERT_RATE / 1000),0))),0) AS PAST_PRICE, \n");
			sbSql.append("               NVL(ROUND((C.NEED_QTY * NVL((E.OP_PRICE / E.KG_CONVERT_RATE / 1000),0))),0) AS CUR_PRICE \n");
			sbSql.append("          FROM \n");
			sbSql.append("               FMM_MENU A \n");
			sbSql.append("              ,FMM_RECIPE B \n");
			sbSql.append("              ,FMM_RECIPE_ITEM C \n");
			sbSql.append("              ,( \n");
			sbSql.append("                SELECT B.UPJANG, A.CUR_DATE, A.WDESC \n");
			sbSql.append("                  FROM UPOS_SC_WEATHER_INFO_V A, \n");
			sbSql.append("                       FMS_UPJANG B \n");
			sbSql.append("                 WHERE A.AREA_CODE = B.LOCAL1 \n");
			sbSql.append("               ) D \n");
			sbSql.append("              ,( \n");
			sbSql.append("                  SELECT \n");
			sbSql.append("                         A.UPJANG, A.ITEM_CODE, A.SALE_PRICE, B.KG_CONVERT_RATE, \n");
			sbSql.append("                         CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL              \n");
			sbSql.append("                              THEN DECODE(SIGN(NVL(C.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE) \n");
			sbSql.append("                              WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL              \n");
			sbSql.append("                              THEN DECODE(SIGN(NVL(D.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL), D.OP_PRICE) \n");
			sbSql.append("                         ELSE A.SALE_PRICE END AS OP_PRICE --운영단가(1인원가)                        \n");
			sbSql.append("                    FROM \n");
			sbSql.append("                         FMS_ITEM_V B, \n");
			sbSql.append("                         ( \n");   
			sbSql.append("                           SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL \n");
			sbSql.append("                             FROM FMU_OP_RATE \n");
			sbSql.append("                            WHERE UPJANG = " + fa_UPJANG + " \n");
			sbSql.append("                              AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN SDATE AND EDATE \n");
			sbSql.append("                              AND USE_YN = 'Y' \n");
			sbSql.append("                              AND ITEM_TYPE = 'M' \n");
			sbSql.append("                         ) C, \n");
			sbSql.append("                         ( \n");        
			sbSql.append("                           SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL \n");
			sbSql.append("                             FROM FMU_OP_RATE \n");
			sbSql.append("                            WHERE UPJANG = " + fa_UPJANG + " \n");
			sbSql.append("                              AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN SDATE AND EDATE \n");
			sbSql.append("                              AND USE_YN = 'Y' \n");
			sbSql.append("                              AND ITEM_TYPE = 'C' \n");
			sbSql.append("                         ) D, \n");
			sbSql.append("                         ( \n");
			sbSql.append("                          SELECT \n");
			sbSql.append("                                 " + fa_UPJANG + " AS UPJANG , \n");
			sbSql.append("                                 TO_CHAR(SYSDATE,'YYYYMMDD') AS NEED_DATE, \n");
			sbSql.append("                                 A.ITEM_CODE, A.SALE_PRICE \n");
			sbSql.append("                            FROM HLDC_PO_CONTRACT_FSALE A, HLDC_ST_UPJANG B \n");
			sbSql.append("                           WHERE A.UPJANG = B.AP_UNITPRICE_UPJANG \n");
			sbSql.append("                             AND B.UPJANG = " + fa_UPJANG + " \n");
			sbSql.append("                             AND A.ITEM_CODE > ' ' \n");
			sbSql.append("                             AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN A.CONTRACT_START AND NVL(A.CONTRACT_END,'99999999') \n");
			sbSql.append("                             AND A.SALE_PRICE > 0 \n");
			sbSql.append("                             AND A.USE_YN = 'Y' \n");
			sbSql.append("                         ----------- \n");
			sbSql.append("                          UNION ALL \n");
			sbSql.append("                         ----------- \n");
			sbSql.append("                         SELECT " + fa_UPJANG + " AS UPJANG, TO_CHAR(SYSDATE,'YYYYMMDD') AS NEED_DATE, A.ITEM_CODE, A.SALE_PRICE \n");
			sbSql.append("                           FROM FMP_OTCUST_PRICE_AVA_V A , \n");
			sbSql.append("                                ( \n");
			sbSql.append("                                SELECT UPJANG, ITEM_CODE, MAX(SDATE) AS SDATE \n");
			sbSql.append("                                  FROM FMP_OTCUST_PRICE_AVA_V \n");
			sbSql.append("                                 WHERE UPJANG = \n");
			sbSql.append("                                       ( \n");
			sbSql.append("                                       SELECT OTCUST_PRICE_UPJANG \n");
			sbSql.append("                                         FROM FMS_UPJANG \n");
			sbSql.append("                                        WHERE UPJANG = " + fa_UPJANG + " \n");
			sbSql.append("                                       ) \n");
			sbSql.append("                                   AND SDATE <= TO_CHAR(SYSDATE,'YYYYMMDD') \n");
			sbSql.append("                                 GROUP BY UPJANG, ITEM_CODE \n");
			sbSql.append("                                ) B \n");
			sbSql.append("                          WHERE A.UPJANG = B.UPJANG \n");
			sbSql.append("                            AND A.SDATE = B.SDATE \n");
			sbSql.append("                            AND A.ITEM_CODE = B.ITEM_CODE \n");
			sbSql.append("                            AND A.SALE_PRICE > 0 \n");
			sbSql.append("                            AND A.USE_YN = 'Y' \n");
			sbSql.append("                         ) A \n");
			sbSql.append("                   WHERE A.ITEM_CODE = B.ITEM_CODE \n");
			sbSql.append("                     AND B.ITEM_CODE = C.ITEM_CODE(+) \n");
			sbSql.append("                     AND B.ITEM_CLASS4 = D.ITEM_CODE(+) \n");
			sbSql.append("              ) E \n");
			sbSql.append("         WHERE A.UPJANG = B.UPJANG \n");
			sbSql.append("           AND A.MENU_CD = B.MENU_CD \n");
			sbSql.append("           AND B.UPJANG = C.UPJANG \n");
			sbSql.append("           AND B.MENU_CD = C.MENU_CD \n");
			sbSql.append("           AND B.RECIPE_CD = C.RECIPE_CD \n");
			sbSql.append("           AND A.UPJANG = D.UPJANG(+) \n");
			sbSql.append("           AND A.MENU_DATE = D.CUR_DATE(+) \n");
			sbSql.append("           AND C.ITEM_CODE = E.ITEM_CODE(+) \n");
			sbSql.append("           AND A.UPJANG = " + strUpjang + "        --사업장 \n");
			sbSql.append("           AND A.SUBINV_CODE = '" + strSubinvCode + "'      --식당코드 \n");
			sbSql.append("           AND A.MENU_DATE BETWEEN '" + strFromDt + "' AND '" + strToDt + "' --기간 \n");
			if (strMeal.length() != 0)			sbSql.append("           AND A.MEAL = '" + strMeal + "' \n");
			if (strCorner.length() != 0)		sbSql.append("           AND A.CORNER = '" + strCorner + "' \n");
			if (strRecipeName.length() != 0)	sbSql.append("           AND B.RECIPE_NAME LIKE '%' || '" + strRecipeName + "' || '%' \n");
			sbSql.append("        ) A \n");
			sbSql.append(" GROUP BY A.UPJANG \n");
			sbSql.append("         ,A.MENU_CD \n");
			sbSql.append("         ,A.MENU_DATE \n");
			sbSql.append("         ,A.SUBINV_CODE \n");
			sbSql.append("         ,A.MEAL \n");
			sbSql.append("         ,A.CORNER \n");
			sbSql.append("         ,A.WDESC \n");
			if (strTopCnt.length() > 0)
			{
				sbSql.append("ORDER BY A.MENU_DATE DESC,A.MEAL,A.CORNER \n");
				sbSql.append(")\n");
				sbSql.append(" WHERE ROWNUM <= " + strTopCnt + " \n");
			}
		}
		else if (strGBN.equals("1"))		// 한화표준식단
		{
		  	String strMenuClass		= nullToBlank(ds_input.getString(0, "MENU_CLASS"));
		  	String strMenuName 		= nullToBlank(ds_input.getString(0, "MENU_NAME"));
		  	String strRecipeName	= nullToBlank(ds_input.getString(0, "RECIPE_NAME2"));
		  	String strFileURL 		= nullToBlank(ds_input.getString(0, "FILEURL"));
		  	
		  	sbSql.delete(0, sbSql.length());
			sbSql.append("SELECT A.SINGLE_MENU_CD AS MENU_CD \n");
			sbSql.append("      ,A.MENU_NAME \n");
			sbSql.append("      ,A.MENU_CLASS \n");
			sbSql.append("      ,(SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0028' AND CODE = A.MENU_CLASS) MENU_CLASS_NM \n");
			sbSql.append("      ,SUM(ROUND( E.NEED_QTY * (NVL(F.OP_PRICE,0) / F.KG_CONVERT_RATE / 1000) ) ) AS MENU_COST  -- 가식부량 적용 여부 결정 \n");
			sbSql.append("      ,FMM_SINGLE_RECIPE_NAME_FUN(A.SINGLE_MENU_CD) AS RECIPE_INFO --레시피구성 \n");
			sbSql.append("      ,PHOTO_TITLE_1 \n");
			sbSql.append("      ,PHOTO_PATH_1 \n");
			sbSql.append("      ,SPHOTO_PATH_1 \n");
			sbSql.append("      ,'" + strFileURL + "' AS PHOTO_URL_1 \n");
			sbSql.append("      ,PHOTO_TITLE_2 \n");
			sbSql.append("      ,PHOTO_PATH_2 \n");
			sbSql.append("      ,SPHOTO_PATH_2 \n");
			sbSql.append("      ,'" + strFileURL + "' AS PHOTO_URL_2 \n");
			sbSql.append("      ,0 AS CHK          --선택 \n");
			sbSql.append("      ,A.SINGLE_MENU_CD AS MENU_ID \n");
			sbSql.append("      ,'" + strGBN + "' AS GBN          --구분 \n");
			sbSql.append("  FROM FMM_SINGLE_MENU_MST A \n");
			sbSql.append("      ,FMM_SINGLE_MENU_RECIPE B \n");
			sbSql.append("      ,FMR_STD_RECIPE_MST D \n");
			sbSql.append("      ,(SELECT NVL(B.ITEM_CODE_TO,A.ITEM_CODE) AS ITEM_CODE \n");
			sbSql.append("             , A.RECIPE_CD, A.ITEM_SEQ, A.NEED_QTY, A.EDIBLE_QTY, A.CUT_SPEC, A.USE_YN \n");
			sbSql.append("          FROM FMR_STD_RECIPE_ITEM A \n");
			sbSql.append("             ,(SELECT * FROM FMM_CHG_ITEM_LIST B WHERE UPJANG = " + fa_UPJANG + " AND USE_YN = 'Y') B \n");
			sbSql.append("         WHERE A.ITEM_CODE = B.ITEM_CODE(+) \n");
			sbSql.append("       ) E \n");
			sbSql.append("      ,( \n");
			sbSql.append("      SELECT \n");
			sbSql.append("             A.UPJANG, A.ITEM_CODE \n");
			sbSql.append("           , A.SALE_PRICE, B.KG_CONVERT_RATE \n");
			sbSql.append("           , CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL              \n");
			sbSql.append("                  THEN DECODE(SIGN(NVL(C.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE) \n");
			sbSql.append("                  WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL              \n");
			sbSql.append("                  THEN DECODE(SIGN(NVL(D.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL), D.OP_PRICE) \n");
			sbSql.append("             ELSE A.SALE_PRICE END AS OP_PRICE --운영단가(1인원가)                        \n");
			sbSql.append("        FROM \n");
			sbSql.append("              FMS_ITEM_V B, \n");
			sbSql.append("              ( \n");   
			sbSql.append("                SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL \n");
			sbSql.append("                  FROM FMU_OP_RATE \n");
			sbSql.append("                 WHERE UPJANG = " + fa_UPJANG + " \n");
			sbSql.append("                   AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN SDATE AND EDATE \n");
			sbSql.append("                   AND USE_YN = 'Y' \n");
			sbSql.append("                   AND ITEM_TYPE = 'M' \n");
			sbSql.append("              ) C, \n");
			sbSql.append("              ( \n");        
			sbSql.append("                SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL \n");
			sbSql.append("                  FROM FMU_OP_RATE \n");
			sbSql.append("                 WHERE UPJANG = " + fa_UPJANG + " \n");
			sbSql.append("                   AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN SDATE AND EDATE \n");
			sbSql.append("                   AND USE_YN = 'Y' \n");
			sbSql.append("                   AND ITEM_TYPE = 'C' \n");
			sbSql.append("              ) D, \n");
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
			sbSql.append("         WHERE A.ITEM_CODE = B.ITEM_CODE \n");
			sbSql.append("           AND B.ITEM_CODE = C.ITEM_CODE(+) \n");
			sbSql.append("           AND B.ITEM_CLASS4 = D.ITEM_CODE(+) \n");
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

		}
		else if (strGBN.equals("2"))		// 기간표준식단
		{
			String strMenuClass 		= nullToBlank(ds_input.getString(0, "MENU_CLASS"));
		  	String strCostType 			= nullToBlank(ds_input.getString(0, "COST_TYPE"));
		  	String strMenuType 			= nullToBlank(ds_input.getString(0, "MENU_TYPE"));
		  	String strCorner 			= nullToBlank(ds_input.getString(0, "CORNER2"));
		  	String strMeal 				= nullToBlank(ds_input.getString(0, "MEAL2"));
		  	String strFromDt 			= nullToBlank(ds_input.getString(0, "MENU_F_DATE2"));
		  	String strToDt 				= nullToBlank(ds_input.getString(0, "MENU_T_DATE2"));
			
			sbSql.append("SELECT A.TERM_MENU_CD \n");
			sbSql.append("      ,SUM(ROUND( E.NEED_QTY * (NVL(F.OP_PRICE,0) / F.KG_CONVERT_RATE / 1000) ) ) AS MENU_COST  -- 표준원가 \n");
			sbSql.append("      ,FMM_TERM_RECIPE_NAME_FUN(A.TERM_MENU_CD) AS RECIPE_INFO --레시피구성 \n");
			sbSql.append("      ,A.MENU_DATE --식단일자 \n");
			sbSql.append("      ,A.MEAL \n");
			sbSql.append("      ,(SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0023' AND CODE = A.MEAL) MEAL_NAME --끼니명 \n");
			sbSql.append("      ,A.CORNER \n");
			sbSql.append("      ,(SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0022' AND CODE = A.CORNER) CORNER_NAME --코너명 \n");
			sbSql.append("      ,0 AS CHK          --선택 \n");
			sbSql.append("      ,A.TERM_MENU_CD AS MENU_ID \n");
			sbSql.append("      ,A.TERM_MENU_CD AS MENU_CD \n");
			sbSql.append("      ,'" + strGBN + "' AS GBN          --구분 \n");
			sbSql.append("  FROM FMM_TERM_MENU_MST A \n");
			sbSql.append("      ,FMM_TERM_MENU_RECIPE B \n");
			sbSql.append("      ,FMR_STD_RECIPE_MST D \n");
			sbSql.append("      ,(SELECT NVL(B.ITEM_CODE_TO,A.ITEM_CODE) AS ITEM_CODE \n");
			sbSql.append("             , A.RECIPE_CD, A.ITEM_SEQ, A.NEED_QTY, A.EDIBLE_QTY, A.CUT_SPEC, A.USE_YN \n");
			sbSql.append("          FROM FMR_STD_RECIPE_ITEM A \n");
			sbSql.append("             ,(SELECT * FROM FMM_CHG_ITEM_LIST B WHERE UPJANG = " + fa_UPJANG + " AND USE_YN = 'Y') B \n");
			sbSql.append("         WHERE A.ITEM_CODE = B.ITEM_CODE(+) \n");
			sbSql.append("       ) E \n");
			sbSql.append("      ,( \n");
			sbSql.append("      SELECT \n");
			sbSql.append("             A.UPJANG, A.ITEM_CODE, A.SALE_PRICE, B.KG_CONVERT_RATE \n");
			sbSql.append("           , CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL              \n");
			sbSql.append("                  THEN DECODE(SIGN(NVL(C.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE) \n");
			sbSql.append("                  WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL              \n");
			sbSql.append("                  THEN DECODE(SIGN(NVL(D.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL), D.OP_PRICE) \n");
			sbSql.append("             ELSE A.SALE_PRICE END AS OP_PRICE --운영단가(1인원가)                        \n");
			sbSql.append("        FROM \n");
			sbSql.append("              FMS_ITEM_V B, \n");
			sbSql.append("              ( \n");   
			sbSql.append("                SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL \n");
			sbSql.append("                  FROM FMU_OP_RATE \n");
			sbSql.append("                 WHERE UPJANG = " + fa_UPJANG + " \n");
			sbSql.append("                   AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN SDATE AND EDATE \n");
			sbSql.append("                   AND USE_YN = 'Y' \n");
			sbSql.append("                   AND ITEM_TYPE = 'M' \n");
			sbSql.append("              ) C, \n");
			sbSql.append("              ( \n");        
			sbSql.append("                SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL \n");
			sbSql.append("                  FROM FMU_OP_RATE \n");
			sbSql.append("                 WHERE UPJANG = " + fa_UPJANG + " \n");
			sbSql.append("                   AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN SDATE AND EDATE \n");
			sbSql.append("                   AND USE_YN = 'Y' \n");
			sbSql.append("                   AND ITEM_TYPE = 'C' \n");
			sbSql.append("              ) D, \n");
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
			sbSql.append("       ) F \n");
			sbSql.append(" WHERE A.TERM_MENU_CD = B.TERM_MENU_CD \n");
			sbSql.append("   AND B.RECIPE_CD = D.RECIPE_CD \n");
			sbSql.append("   AND B.RECIPE_CD = E.RECIPE_CD \n");
			sbSql.append("   AND E.ITEM_CODE = F.ITEM_CODE(+) \n");
			sbSql.append("   AND A.MENU_CLASS= '" + strMenuClass + "' \n");
			sbSql.append("   AND A.COST_TYPE = '" + strCostType + "' \n");
			sbSql.append("   AND A.MENU_TYPE = '" + strMenuType + "' \n");
			sbSql.append("   AND A.MENU_DATE BETWEEN '" + strFromDt + "' AND '" + strToDt + "' \n");
			if (strMeal.length() != 0)			sbSql.append("           AND A.MEAL = '" + strMeal + "' \n");
			if (strCorner.length() != 0)		sbSql.append("           AND A.CORNER = '" + strCorner + "' \n");
			sbSql.append(" GROUP BY A.TERM_MENU_CD \n");
			sbSql.append("         ,A.MENU_DATE \n");
			sbSql.append("         ,A.MEAL \n");
			sbSql.append("         ,A.CORNER \n");
		}
		else								// 본사표준식단
		{
			String strMenuClass		= nullToBlank(ds_input.getString(0, "MENU_CLASS"));
		  	String strMenuName 		= nullToBlank(ds_input.getString(0, "MENU_NAME"));
		  	String strRecipeName	= nullToBlank(ds_input.getString(0, "RECIPE_NAME2"));
		  	
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
				sbSql.append("SELECT A.UPJANG \n");
				sbSql.append("      ,A.MENU_CD \n");
				sbSql.append("      ,A.MENU_NAME \n");
				sbSql.append("      ,A.MENU_CLASS \n");
				sbSql.append("      ,(SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0028' AND CODE = A.MENU_CLASS) MENU_CLASS_NM \n");
				sbSql.append("      ,SUM(ROUND( E.NEED_QTY * (NVL(F.OP_PRICE,0) / F.KG_CONVERT_RATE / 1000) ) ) AS MENU_COST  -- 가식부량 적용 여부 결정 \n");
				sbSql.append("      ,FMM_RECIPENAME_FUN(A.UPJANG,A.MENU_CD,'0') AS RECIPE_INFO --레시피구성 \n");
				sbSql.append("      ,'' AS SPHOTO_PATH_1 \n");
				sbSql.append("      ,'' AS SPHOTO_PATH_2 \n");
				sbSql.append("      ,0 AS CHK          --선택 \n");
				sbSql.append("      ,A.UPJANG || A.MENU_CD AS MENU_ID \n");
				sbSql.append("      ,'" + strGBN + "' AS GBN          --구분 \n");
				sbSql.append("  FROM FMM_STD_MENU A \n");
				sbSql.append("      ,FMM_STD_MENU_RECIPE B \n");
				sbSql.append("      ,( \n");
				sbSql.append("         SELECT RECIPE_CD, ITEM_CODE, ITEM_SEQ, NEED_QTY, EDIBLE_QTY, CUT_SPEC \n");
				sbSql.append("           FROM FMM_STD_RECIPE_ITEM \n");
				sbSql.append("          WHERE UPJANG = " + fa_MainUpjang + " \n");
				sbSql.append("       ) E \n");
				sbSql.append("      ,( \n");
				sbSql.append("      SELECT \n");
				sbSql.append("             A.UPJANG, A.ITEM_CODE, A.SALE_PRICE, B.KG_CONVERT_RATE \n");
				sbSql.append("           , CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL              \n");
				sbSql.append("                  THEN DECODE(SIGN(NVL(C.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE) \n");
				sbSql.append("                  WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL              \n");
				sbSql.append("                  THEN DECODE(SIGN(NVL(D.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL), D.OP_PRICE) \n");
				sbSql.append("             ELSE A.SALE_PRICE END AS OP_PRICE --운영단가(1인원가)                        \n");
				sbSql.append("        FROM \n");
				sbSql.append("              FMS_ITEM_V B, \n");
				sbSql.append("              ( \n");   
				sbSql.append("                SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL \n");
				sbSql.append("                  FROM FMU_OP_RATE \n");
				sbSql.append("                 WHERE UPJANG = " + fa_UPJANG + " \n");
				sbSql.append("                   AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN SDATE AND EDATE \n");
				sbSql.append("                   AND USE_YN = 'Y' \n");
				sbSql.append("                   AND ITEM_TYPE = 'M' \n");
				sbSql.append("              ) C, \n");
				sbSql.append("              ( \n");        
				sbSql.append("                SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL \n");
				sbSql.append("                  FROM FMU_OP_RATE \n");
				sbSql.append("                 WHERE UPJANG = " + fa_UPJANG + " \n");
				sbSql.append("                   AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN SDATE AND EDATE \n");
				sbSql.append("                   AND USE_YN = 'Y' \n");
				sbSql.append("                   AND ITEM_TYPE = 'C' \n");
				sbSql.append("              ) D, \n");
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
				sbSql.append("       ) F \n");
				sbSql.append("  WHERE A.MENU_CD = B.MENU_CD \n");
				sbSql.append("    AND A.UPJANG = B.UPJANG \n");
				sbSql.append("    AND B.RECIPE_CD = E.RECIPE_CD \n");
				sbSql.append("    AND E.ITEM_CODE = F.ITEM_CODE(+) \n");
				sbSql.append("    AND B.UPJANG = " + fa_MainUpjang + " \n");
				if (strMenuClass.length() != 0)				sbSql.append("   AND A.MENU_CLASS= '" + strMenuClass + "' \n");
				if (strMenuName.length() != 0)				sbSql.append("   AND A.MENU_NAME LIKE '%' || '" + strMenuName + "' || '%' \n");
				if (strRecipeName.length() != 0)			sbSql.append("   AND D.RECIPE_NAME LIKE '%' || '" + strRecipeName + "' || '%' \n");
				sbSql.append("  GROUP BY A.UPJANG, A.MENU_CD,A.MENU_NAME,A.MENU_CLASS \n");
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