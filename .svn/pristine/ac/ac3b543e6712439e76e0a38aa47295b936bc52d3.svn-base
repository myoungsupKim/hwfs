<%                                                                                                                                                                                                      
/*-----------------------------------------------------------------------------                                                                                                                         
■ 시스템명     : 메뉴관리/식단관리                                                                                                                                                                     
■ 프로그램ID   : FMM00215P_S001.jsp                                                                                                                                                                    
■ 프로그램명   : 업장과거레시피                                                                                                                                      
■ 작성일자     : 2008-06-30                                                                                                                                                                            
■ 작성자       : 박지영                                                                                                                                                                                
■ 이력관리     : 2008-06-30                                                                                                                                                                            
-----------------------------------------------------------------------------*/                                                                                                                         
%>                                                                                                                                                                                                      
                                                                                                                                                                    
<%@ page contentType="text/html; charset=EUC-KR" %>                                                                                                                                                     
<%@ include file = "../../sc/main/common.jsp" %>                                                                                                                                                        
<%
	try {
		PlatformRequest platformRequest = this.proc_input(request);                                                                                                                                           
		in_vl = platformRequest.getData().getVariableList();                                                                                                                                                            
		in_dl = platformRequest.getData().getDataSetList();                                                                                                                                                             
	                                                                                                                                                                                                        
		//입력 데이타                                                                                                                                                                                         
		DataSet ds_input     	= in_dl.get("ds_input");                                                                                                                                                  
	                                                                                                                                                                                                        
	  	String strUpjang 		= nullToBlank(ds_input.getString(0, "UPJANG"));
	  	String strRecipeCD		= nullToBlank(ds_input.getString(0, "RECIPE_CD"));
	  	String strMenuFDate		= nullToBlank(ds_input.getString(0, "MENU_F_DATE"));
	  	String strMenuTDate		= nullToBlank(ds_input.getString(0, "MENU_T_DATE"));
	  	String strMeal 			= nullToBlank(ds_input.getString(0, "MEAL"));
	  	String strCorner 		= nullToBlank(ds_input.getString(0, "CORNER"));                                                                                                                                                                                              
                                                                                                                                                                                                     
		//out 데이타                                                                                                                                                                                        
		DataSet ds_list;                                                                                                                                                                                    
		                                                                                                                                                                                                    
		//sql문 버퍼생성                                                                                                                                                                                    
		StringBuffer sbSql = new StringBuffer();                                                                                                                                                            
        
		sbSql.append("SELECT A.UPJANG \n");
		sbSql.append("     , A.MENU_CD \n");
		sbSql.append("     , SUM(PAST_PRICE) AS PAST_PRICE --과거원가 \n");
		sbSql.append("     , NVL(ROUND(SUM( (A.NEED_QTY * NVL(G_ITEM_PRICE,0)))),0) CUR_PRICE --현재원가 \n");
		sbSql.append("     , A.MENU_DATE       --제공일 \n");
		sbSql.append("     , A.SUBINV_CODE         --식당코드 \n");
		sbSql.append("     , A.SUBINV_NAME_DISP       --식당 \n");
		sbSql.append("     , A.MEAL            --끼니코드 \n");
		sbSql.append("     , (SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0023' AND CODE = A.MEAL) MEAL_NAME --끼니명 \n");
		sbSql.append("     , A.CORNER          --코너코드 \n");
		sbSql.append("     , (SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0022' AND CODE = A.CORNER) CORNER_NAME --코너명 \n");
		sbSql.append("     , A.UPJANG ||  A.MENU_CD AS MENU_ID --ID \n");
		sbSql.append("  FROM \n");
		sbSql.append("       ( \n");
		sbSql.append("        SELECT A.UPJANG, A.MENU_CD, A.MENU_DATE, A.SUBINV_CODE, D.SUBINV_NAME_DISP, A.MEAL, A.CORNER, C.ITEM_CODE, C.NEED_QTY, \n");
		sbSql.append("               NVL(ROUND((C.NEED_QTY * NVL((C.OP_PRICE / F.KG_CONVERT_RATE / 1000),0))),0) AS PAST_PRICE \n");
		sbSql.append("          FROM \n");
		sbSql.append("               FMM_MENU A \n");
		sbSql.append("             , FMM_RECIPE B \n");
		sbSql.append("             , FMM_RECIPE_ITEM C \n");
		sbSql.append("             , FMS_SUBINVENTORY D \n");
		sbSql.append("             , ( \n");
		sbSql.append("                  SELECT A.ITEM_CODE,A.ITEM_NAME,A.ITEM_SIZE,A.PO_UOM,A.KG_CONVERT_RATE \n");
		sbSql.append("                       , B.CAL, B.WATER, B.PROT, B.FAT, B.CARBO, B.FIBER, B.ASH, B.CA, B.P \n");
		sbSql.append("                       , B.FE, B.NA, B.K, B.VITA_A, B.RETIN, B.B_CAROT, B.THIA, B.RIBO, B.NIACIN \n");
		sbSql.append("                       , B.VITA_C, B.CHOLE, B.DISUSE_RATE \n");
		sbSql.append("                    FROM (SELECT B.ITEM_CODE, B.ITEM_NAME, B.ITEM_SIZE, B.PO_UOM, B.TAX_CODE, B.KG_CONVERT_RATE \n");
		sbSql.append("                            FROM HLDC_PO_ITEM_MST B, HLDC_PO_CONTRACT_FSALE A, HLDC_ST_UPJANG C \n");
		sbSql.append("                           WHERE A.ITEM_CODE = B.ITEM_CODE \n");
		sbSql.append("                             AND A.UPJANG = C.AP_UNITPRICE_UPJANG \n");
		sbSql.append("                             AND C.UPJANG = " + strUpjang + " \n");
		sbSql.append("                             AND B.ITEM_CLASS1 = 'F' \n");
		sbSql.append("                             AND A.USE_YN = 'Y' AND B.USE_YN = 'Y' \n");
		sbSql.append("                           UNION ALL \n");
		sbSql.append("                          SELECT A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM, A.TAX_CODE,A.KG_CONVERT_RATE \n");
		sbSql.append("                            FROM FMP_OTCUST_ITEM A, FMP_OTCUST_PRICE_AVA_V B \n");
		sbSql.append("                               ,(SELECT UPJANG, ITEM_CODE, MAX(SDATE) AS SDATE \n");
		sbSql.append("                                   FROM FMP_OTCUST_PRICE_AVA_V \n");
		sbSql.append("                                  WHERE UPJANG = (SELECT Z.OTCUST_PRICE_UPJANG FROM FMS_UPJANG Z WHERE Z.UPJANG = " + strUpjang + ") \n");
		sbSql.append("                                    AND SDATE <= NVL('',TO_CHAR(SYSDATE,'YYYYMMDD')) \n");
		sbSql.append("                                  GROUP BY UPJANG, ITEM_CODE) C \n");
		sbSql.append("                           WHERE A.ITEM_CODE = B.ITEM_CODE \n");
		sbSql.append("                             AND B.UPJANG = C.UPJANG \n");
		sbSql.append("                             AND B.SDATE = C.SDATE \n");
		sbSql.append("                             AND B.ITEM_CODE = C.ITEM_CODE \n");
		sbSql.append("                             AND A.USE_YN = 'Y' AND B.USE_YN = 'Y') A, \n");
		sbSql.append("                         (SELECT ITEM_CODE, CAL, WATER, PROT, FAT, CARBO, FIBER, ASH, CA, P, FE, NA, K, VITA_A, RETIN, B_CAROT, THIA, RIBO, NIACIN, VITA_C, CHOLE, DISUSE_RATE \n");
		sbSql.append("                            FROM FMP_ITEM_NUT WHERE UPJANG = (SELECT MAIN_UPJANG FROM FMS_UPJANG WHERE UPJANG = " + strUpjang + ") \n");
		sbSql.append("                           UNION ALL \n");
		sbSql.append("                          SELECT X.ITEM_CODE, CAL, WATER, PROT, FAT, CARBO, FIBER, ASH, CA, P, FE, NA, K, VITA_A, RETIN, B_CAROT, THIA, RIBO, NIACIN, VITA_C, CHOLE, DISUSE_RATE \n");
		sbSql.append("                            FROM FSI_ITEM_NUT X \n");
		sbSql.append("                               ,(SELECT ITEM_CODE FROM FSI_ITEM_NUT \n");
		sbSql.append("                                 MINUS \n");
		sbSql.append("                                 SELECT ITEM_CODE FROM FMP_ITEM_NUT WHERE UPJANG = (SELECT MAIN_UPJANG FROM FMS_UPJANG WHERE UPJANG = " + strUpjang + ")) Y \n");
		sbSql.append("                           WHERE X.ITEM_CODE = Y.ITEM_CODE) B \n");
		sbSql.append("                    WHERE A.ITEM_CODE = B.ITEM_CODE \n");
		sbSql.append("                ) F \n");
		sbSql.append("         WHERE A.UPJANG = B.UPJANG \n");
		sbSql.append("           AND A.MENU_CD = B.MENU_CD \n");
		sbSql.append("           AND B.UPJANG = C.UPJANG \n");
		sbSql.append("           AND B.MENU_CD = C.MENU_CD \n");
		sbSql.append("           AND B.RECIPE_CD = C.RECIPE_CD \n");
		sbSql.append("           AND A.UPJANG = D.UPJANG \n");
		sbSql.append("           AND A.SUBINV_CODE = D.SUBINV_CODE \n");
		sbSql.append("           AND C.ITEM_CODE = F.ITEM_CODE \n");
		sbSql.append("           AND A.UPJANG = " + strUpjang + "        --사업장 \n");
		sbSql.append("           AND B.RECIPE_CD = '" + strRecipeCD + "'   --레시피코드 \n");
		sbSql.append("           AND A.MENU_DATE BETWEEN '" + strMenuFDate + "' AND '" + strMenuTDate + "' --기간 \n");
		if(strMeal.length()>0)		sbSql.append("           AND A.MEAL = '" + strMeal + "'     --끼니 \n");
		if(strCorner.length()>0)	sbSql.append("           AND A.CORNER = '" + strCorner + "'     --코너 \n");
		sbSql.append("        ) A, \n");
		sbSql.append("        ( \n");
		sbSql.append("           SELECT A.UPJANG, A.ITEM_CODE,A.CENTER_CODE,A.CUSTCD \n");
		sbSql.append("                , A.UNIT_PRICE, A.SALE_PRICE \n");
		sbSql.append("                , NVL(NVL(C.OP_RATE, D.OP_RATE), 0) AS OP_RATE --운영율 \n"); 
        sbSql.append("                , CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");  
        sbSql.append("                       THEN DECODE(SIGN(NVL(C.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE) \n"); 
        sbSql.append("                       WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL \n");  
        sbSql.append("                       THEN DECODE(SIGN(NVL(D.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL), D.OP_PRICE) \n"); 
        sbSql.append("                  ELSE A.SALE_PRICE END AS OP_PRICE --운영단가 \n");
        sbSql.append("                , CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");              
        sbSql.append("                       THEN DECODE(SIGN(NVL(C.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE) / B.KG_CONVERT_RATE / 1000 \n"); 
        sbSql.append("                       WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL \n");              
        sbSql.append("                       THEN DECODE(SIGN(NVL(D.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL), D.OP_PRICE) / B.KG_CONVERT_RATE / 1000 \n"); 
        sbSql.append("                  ELSE A.SALE_PRICE / B.KG_CONVERT_RATE / 1000 END AS G_ITEM_PRICE \n"); 
		sbSql.append("             FROM  \n");
		sbSql.append("                  (SELECT \n");
		sbSql.append("                          " + strUpjang + " AS UPJANG, NVL('',TO_CHAR(SYSDATE,'YYYYMMDD')) AS NEED_DATE \n");
		sbSql.append("                        , A.ITEM_CODE, A.CONTRACT_PRICE AS UNIT_PRICE, A.SALE_PRICE, A.CENTER_CODE,A.CUSTCD \n");
		sbSql.append("                     FROM HLDC_PO_CONTRACT_FSALE A, HLDC_ST_UPJANG B \n");
		sbSql.append("                    WHERE A.UPJANG = B.AP_UNITPRICE_UPJANG \n");
		sbSql.append("                      AND B.UPJANG = " + strUpjang + " \n");
		sbSql.append("                      AND A.ITEM_CODE > ' ' \n");
		sbSql.append("                      AND NVL('',TO_CHAR(SYSDATE,'YYYYMMDD')) BETWEEN A.CONTRACT_START AND NVL(A.CONTRACT_END,'99999999') \n");
		sbSql.append("                      AND A.SALE_PRICE > 0 \n");
		sbSql.append("                      AND A.USE_YN = 'Y' \n");
		sbSql.append("                   ----------- \n");
		sbSql.append("                    UNION ALL \n");
		sbSql.append("                   ----------- \n");
		sbSql.append("                       SELECT " + strUpjang + " AS UPJANG, NVL('',TO_CHAR(SYSDATE,'YYYYMMDD')) AS NEED_DATE \n");
		sbSql.append("                            , A.ITEM_CODE, A.UNIT_PRICE, A.SALE_PRICE, '0' CENTER_CODE, 0 CUSTCD \n");
		sbSql.append("                         FROM FMP_OTCUST_PRICE_AVA_V A \n");
		sbSql.append("                            ,(SELECT UPJANG, ITEM_CODE, MAX(SDATE) AS SDATE \n");
		sbSql.append("                                FROM FMP_OTCUST_PRICE_AVA_V \n");
		sbSql.append("                               WHERE UPJANG = (SELECT OTCUST_PRICE_UPJANG FROM FMS_UPJANG WHERE UPJANG = " + strUpjang + ") \n");
		sbSql.append("                                 AND SDATE <= NVL('',TO_CHAR(SYSDATE,'YYYYMMDD')) \n");
		sbSql.append("                               GROUP BY UPJANG, ITEM_CODE) B \n");
		sbSql.append("                        WHERE A.UPJANG = B.UPJANG \n");
		sbSql.append("                          AND A.SDATE = B.SDATE \n");
		sbSql.append("                          AND A.ITEM_CODE = B.ITEM_CODE \n");
		sbSql.append("                          AND A.SALE_PRICE > 0 \n");
		sbSql.append("                          AND A.USE_YN = 'Y' \n");
		sbSql.append("                      ) A \n");
		sbSql.append("                 , FMS_ITEM_V B \n");
		sbSql.append("                 , ( \n");         
        sbSql.append("                    SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL \n"); 
        sbSql.append("                      FROM FMU_OP_RATE \n");
        sbSql.append("                     WHERE UPJANG = " + strUpjang + " \n");
        sbSql.append("                       AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN SDATE AND EDATE \n"); 
        sbSql.append("                       AND USE_YN = 'Y' \n");
        sbSql.append("                       AND ITEM_TYPE = 'M' \n");
        sbSql.append("                    ) C \n");
        sbSql.append("                  , ( \n");        
        sbSql.append("                     SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL \n"); 
        sbSql.append("                       FROM FMU_OP_RATE \n");
        sbSql.append("                      WHERE UPJANG = " + strUpjang + " \n");
        sbSql.append("                        AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN SDATE AND EDATE \n"); 
        sbSql.append("                        AND USE_YN = 'Y' \n");
        sbSql.append("                        AND ITEM_TYPE = 'C' \n");
        sbSql.append("                    ) D \n");
		sbSql.append("                 WHERE A.ITEM_CODE = B.ITEM_CODE \n");
		sbSql.append("                   AND B.ITEM_CODE = C.ITEM_CODE(+) \n");
		sbSql.append("                   AND B.ITEM_CLASS4 = D.ITEM_CODE(+) \n");
		sbSql.append("        ) B \n");
		sbSql.append(" WHERE A.ITEM_CODE = B.ITEM_CODE(+) \n");
		sbSql.append("   AND A.UPJANG = B.UPJANG(+) \n");
		sbSql.append(" GROUP BY A.UPJANG \n");
		sbSql.append("         ,A.MENU_CD \n");
		sbSql.append("         ,A.MENU_DATE \n");
		sbSql.append("         ,A.SUBINV_CODE \n");
		sbSql.append("         ,A.SUBINV_NAME_DISP \n");
		sbSql.append("         ,A.MEAL \n");
		sbSql.append("         ,A.CORNER \n");
		
		//System.out.println(sbSql.toString());                                                                                                                                                             
		pstmt = conn.prepareStatement(sbSql.toString());		                                                                                                                                                
		rs = pstmt.executeQuery();                                                                                                                                                                          
		ds_list = this.makeDataSet(rs, "ds_list");                                                                                                                                                          
                                                                                                                                                                                                        
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

<%--
	try {
		PlatformRequest platformRequest = this.proc_input(request);                                                                                                                                           
		in_vl = platformRequest.getData().getVariableList();                                                                                                                                                            
		in_dl = platformRequest.getData().getDataSetList();                                                                                                                                                             
	                                                                                                                                                                                                        
		//입력 데이타                                                                                                                                                                                         
		DataSet ds_input     	= in_dl.get("ds_input");                                                                                                                                                  
	                                                                                                                                                                                                        
	  	String strUpjang 		= nullToBlank(ds_input.getString(0, "UPJANG"));
	  	String strRecipeCD		= nullToBlank(ds_input.getString(0, "RECIPE_CD"));
	  	String strMenuFDate		= nullToBlank(ds_input.getString(0, "MENU_F_DATE"));
	  	String strMenuTDate		= nullToBlank(ds_input.getString(0, "MENU_T_DATE"));
	  	String strMeal 			= nullToBlank(ds_input.getString(0, "MEAL"));
	  	String strCorner 		= nullToBlank(ds_input.getString(0, "CORNER"));                                                                                                                                                                                              
                                                                                                                                                                                                     
		//out 데이타                                                                                                                                                                                        
		DataSet ds_list;                                                                                                                                                                                    
		                                                                                                                                                                                                    
		//sql문 버퍼생성                                                                                                                                                                                    
		StringBuffer sbSql = new StringBuffer();                                                                                                                                                            
        
		sbSql.append("SELECT A.UPJANG \n");
		sbSql.append("      ,A.MENU_CD \n");
		sbSql.append("      ,SUM(PAST_PRICE) AS PAST_PRICE --과거원가 \n");
		sbSql.append("      ,NVL(ROUND(SUM( (A.NEED_QTY * NVL(G_ITEM_PRICE,0)))),0) CUR_PRICE --현재원가 \n");
		sbSql.append("      ,A.MENU_DATE       --제공일 \n");
		sbSql.append("      ,A.SUBINV_CODE         --식당코드 \n");
		sbSql.append("      ,A.SUBINV_NAME_DISP       --식당 \n");
		sbSql.append("      ,A.MEAL            --끼니코드 \n");
		sbSql.append("      ,(SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0023' AND CODE = A.MEAL) MEAL_NAME --끼니명 \n");
		sbSql.append("      ,A.CORNER          --코너코드 \n");
		sbSql.append("      ,(SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0022' AND CODE = A.CORNER) CORNER_NAME --코너명 \n");
		sbSql.append("      ,A.UPJANG ||  A.MENU_CD AS MENU_ID --ID \n");
		sbSql.append("  FROM \n");
		sbSql.append("       ( \n");
		sbSql.append("        SELECT A.UPJANG, A.MENU_CD, A.MENU_DATE, A.SUBINV_CODE, D.SUBINV_NAME_DISP, A.MEAL, A.CORNER, C.ITEM_CODE, C.NEED_QTY, \n");
		sbSql.append("               NVL(ROUND((C.NEED_QTY * NVL((C.OP_PRICE / F.KG_CONVERT_RATE / 1000),0))),0) AS PAST_PRICE \n");
		sbSql.append("          FROM \n");
		sbSql.append("               FMM_MENU A \n");
		sbSql.append("              ,FMM_RECIPE B \n");
		sbSql.append("              ,FMM_RECIPE_ITEM C \n");
		sbSql.append("              ,FMS_SUBINVENTORY D \n");
		sbSql.append("              ,( \n");
		sbSql.append("                  SELECT A.ITEM_CODE,A.ITEM_NAME,A.ITEM_SIZE,A.PO_UOM,A.KG_CONVERT_RATE \n");
		sbSql.append("                         ,B.CAL, B.WATER, B.PROT, B.FAT, B.CARBO, B.FIBER, B.ASH, B.CA, B.P \n");
		sbSql.append("                         ,B.FE, B.NA, B.K, B.VITA_A, B.RETIN, B.B_CAROT, B.THIA, B.RIBO, B.NIACIN \n");
		sbSql.append("                         , B.VITA_C, B.CHOLE, B.DISUSE_RATE \n");
		sbSql.append("                  FROM (SELECT B.ITEM_CODE, B.ITEM_NAME, B.ITEM_SIZE, B.PO_UOM, B.TAX_CODE,B.KG_CONVERT_RATE \n");
		sbSql.append("                          FROM HLDC_PO_ITEM_MST B, HLDC_PO_TREAT_UPJANG A \n");
		sbSql.append("                         WHERE A.ITEM_CODE = B.ITEM_CODE \n");
		sbSql.append("                           AND B.ITEM_CODE BETWEEN '010000000000' AND '019999999999' \n");
		sbSql.append("                           AND A.UPJANG = (SELECT C.AP_UNITPRICE_UPJANG FROM HLDC_ST_UPJANG C WHERE C.UPJANG = " + strUpjang + ") \n");
		sbSql.append("                           AND A.USE_YN = 'Y' AND B.USE_YN = 'Y' \n");
		sbSql.append("                         UNION ALL \n");
		sbSql.append("                        SELECT A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM, A.TAX_CODE,A.KG_CONVERT_RATE \n");
		sbSql.append("                          FROM FMP_OTCUST_ITEM A, FMP_OTCUST_PRICE_AVA_V B \n");
		sbSql.append("                             ,(SELECT UPJANG, ITEM_CODE, MAX(SDATE) AS SDATE \n");
		sbSql.append("                                 FROM FMP_OTCUST_PRICE_AVA_V \n");
		sbSql.append("                                WHERE UPJANG = (SELECT Z.OTCUST_PRICE_UPJANG FROM FMS_UPJANG Z WHERE Z.UPJANG = " + strUpjang + ") \n");
		sbSql.append("                                  AND SDATE <= NVL('',TO_CHAR(SYSDATE,'YYYYMMDD')) \n");
		sbSql.append("                                GROUP BY UPJANG, ITEM_CODE) C \n");
		sbSql.append("                         WHERE A.ITEM_CODE = B.ITEM_CODE \n");
		sbSql.append("                           AND B.UPJANG = C.UPJANG \n");
		sbSql.append("                           AND B.SDATE = C.SDATE \n");
		sbSql.append("                           AND B.ITEM_CODE = C.ITEM_CODE \n");
		sbSql.append("                           AND A.USE_YN = 'Y' AND B.USE_YN = 'Y') A, \n");
		sbSql.append("                       (SELECT ITEM_CODE, CAL, WATER, PROT, FAT, CARBO, FIBER, ASH, CA, P, FE, NA, K, VITA_A, RETIN, B_CAROT, THIA, RIBO, NIACIN, VITA_C, CHOLE, DISUSE_RATE \n");
		sbSql.append("                          FROM FMP_ITEM_NUT WHERE UPJANG = (SELECT MAIN_UPJANG FROM FMS_UPJANG WHERE UPJANG = " + strUpjang + ") \n");
		sbSql.append("                         UNION ALL \n");
		sbSql.append("                        SELECT X.ITEM_CODE, CAL, WATER, PROT, FAT, CARBO, FIBER, ASH, CA, P, FE, NA, K, VITA_A, RETIN, B_CAROT, THIA, RIBO, NIACIN, VITA_C, CHOLE, DISUSE_RATE \n");
		sbSql.append("                          FROM FSI_ITEM_NUT X \n");
		sbSql.append("                             ,(SELECT ITEM_CODE FROM FSI_ITEM_NUT \n");
		sbSql.append("                                MINUS \n");
		sbSql.append("                               SELECT ITEM_CODE FROM FMP_ITEM_NUT WHERE UPJANG = (SELECT MAIN_UPJANG FROM FMS_UPJANG WHERE UPJANG = " + strUpjang + ")) Y \n");
		sbSql.append("                         WHERE X.ITEM_CODE = Y.ITEM_CODE) B \n");
		sbSql.append("                    WHERE A.ITEM_CODE = B.ITEM_CODE \n");
		sbSql.append("                ) F \n");
		sbSql.append("         WHERE A.UPJANG = B.UPJANG \n");
		sbSql.append("           AND A.MENU_CD = B.MENU_CD \n");
		sbSql.append("           AND B.UPJANG = C.UPJANG \n");
		sbSql.append("           AND B.MENU_CD = C.MENU_CD \n");
		sbSql.append("           AND B.RECIPE_CD = C.RECIPE_CD \n");
		sbSql.append("           AND A.UPJANG = D.UPJANG \n");
		sbSql.append("           AND A.SUBINV_CODE = D.SUBINV_CODE \n");
		sbSql.append("           AND C.ITEM_CODE = F.ITEM_CODE \n");
		sbSql.append("           AND A.UPJANG = " + strUpjang + "        --사업장 \n");
		sbSql.append("           AND B.RECIPE_CD = '" + strRecipeCD + "'   --레시피코드 \n");
		sbSql.append("           AND A.MENU_DATE BETWEEN '" + strMenuFDate + "' AND '" + strMenuTDate + "' --기간 \n");
		if(strMeal.length()>0)		sbSql.append("           AND A.MEAL = '" + strMeal + "'     --끼니 \n");
		if(strCorner.length()>0)	sbSql.append("           AND A.CORNER = '" + strCorner + "'     --코너 \n");
		sbSql.append("                 ) A, \n");
		sbSql.append("        ( \n");
		sbSql.append("           SELECT /*+ NO_MERGE(A) LEADING(A B C) USE_HASH(B) USE_HASH(C) INDEX(C FMU_OP_RATE_PK) */ A.UPJANG, A.ITEM_CODE,A.CENTER_CODE,A.CUSTCD \n");
		sbSql.append("           , A.UNIT_PRICE, A.SALE_PRICE, NVL(C.OP_RATE,0) AS OP_RATE --운영율 \n");
		sbSql.append("            , DECODE(SIGN(NVL(C.OP_PRICE,0)),0, SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE) AS OP_PRICE --운영단가(1인원가) \n");
		sbSql.append("            , ROUND(DECODE(SIGN(NVL(C.OP_PRICE,0)),0, SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE) / (B.KG_CONVERT_RATE * 1000), 1) AS G_ITEM_PRICE--g당단가 \n");
		sbSql.append("              FROM  \n");
		sbSql.append("                  (SELECT \n");
		sbSql.append("                          " + strUpjang + " AS UPJANG, NVL('',TO_CHAR(SYSDATE,'YYYYMMDD')) AS NEED_DATE \n");
		sbSql.append("                        , A.ITEM_CODE, A.CONTRACT_PRICE AS UNIT_PRICE, A.SALE_PRICE, A.CENTER_CODE,A.CUSTCD \n");
		sbSql.append("                     FROM HLDC_PO_CONTRACT_FSALE A \n");
		sbSql.append("                    WHERE A.CENTER_CODE = (SELECT A.CENTER_CODE FROM HLDC_PO_UPJANG_CENTER A, HLDC_ST_UPJANG B WHERE A.UPJANG = B.AP_UNITPRICE_UPJANG AND B.UPJANG = " + strUpjang + ") \n");
		sbSql.append("                      AND A.UPJANG = (SELECT AP_UNITPRICE_UPJANG FROM HLDC_ST_UPJANG WHERE UPJANG = " + strUpjang + ") \n");
		sbSql.append("                      AND A.ITEM_CODE > ' ' \n");
		sbSql.append("                      AND NVL('',TO_CHAR(SYSDATE,'YYYYMMDD')) BETWEEN A.CONTRACT_START AND NVL(A.CONTRACT_END,'99999999') \n");
		sbSql.append("                      AND A.SALE_PRICE > 0 \n");
		sbSql.append("                      AND A.USE_YN = 'Y' \n");
		sbSql.append("                      AND EXISTS (SELECT 1 FROM HLDC_PO_TREAT_UPJANG X WHERE X.ITEM_CODE = A.ITEM_CODE AND X.UPJANG = A.UPJANG) \n");
		sbSql.append("                   ----------- \n");
		sbSql.append("                    UNION ALL \n");
		sbSql.append("                   ----------- \n");
		sbSql.append("                       SELECT " + strUpjang + " AS UPJANG, NVL('',TO_CHAR(SYSDATE,'YYYYMMDD')) AS NEED_DATE \n");
		sbSql.append("                            , A.ITEM_CODE, A.UNIT_PRICE, A.SALE_PRICE,0 CENTER_CODE,0 CUSTCD \n");
		sbSql.append("                         FROM FMP_OTCUST_PRICE_AVA_V A \n");
		sbSql.append("                            ,(SELECT UPJANG, ITEM_CODE, MAX(SDATE) AS SDATE \n");
		sbSql.append("                                FROM FMP_OTCUST_PRICE_AVA_V \n");
		sbSql.append("                               WHERE UPJANG = (SELECT OTCUST_PRICE_UPJANG FROM FMS_UPJANG WHERE UPJANG = " + strUpjang + ") \n");
		sbSql.append("                                 AND SDATE <= NVL('',TO_CHAR(SYSDATE,'YYYYMMDD')) \n");
		sbSql.append("                               GROUP BY UPJANG, ITEM_CODE) B \n");
		sbSql.append("                        WHERE A.UPJANG = B.UPJANG \n");
		sbSql.append("                          AND A.SDATE = B.SDATE \n");
		sbSql.append("                          AND A.ITEM_CODE = B.ITEM_CODE \n");
		sbSql.append("                          AND A.SALE_PRICE > 0 \n");
		sbSql.append("                          AND A.USE_YN = 'Y' \n");
		sbSql.append("                      ) A \n");
		sbSql.append("                 , FMS_ITEM_V B, FMU_OP_RATE C \n");		
		sbSql.append("                 WHERE A.ITEM_CODE = B.ITEM_CODE \n");
		sbSql.append("                   AND A.UPJANG = C.UPJANG(+) \n");
		sbSql.append("                   AND A.ITEM_CODE BETWEEN C.ITEM_CODE(+) AND C.ITEM_CODE(+)||'9999' \n");
		sbSql.append("                   AND A.ITEM_CODE = C.ITEM_CODE(+) \n");
		sbSql.append("                   AND C.USE_YN(+) = 'Y' \n");
		sbSql.append("                   AND C.UPJANG(+) = "+strUpjang+" \n");
		sbSql.append("        ) B \n");
		sbSql.append(" WHERE A.ITEM_CODE = B.ITEM_CODE(+) \n");
		sbSql.append("   AND A.UPJANG = B.UPJANG(+) \n");
		sbSql.append(" GROUP BY A.UPJANG \n");
		sbSql.append("         ,A.MENU_CD \n");
		sbSql.append("         ,A.MENU_DATE \n");
		sbSql.append("         ,A.SUBINV_CODE \n");
		sbSql.append("         ,A.SUBINV_NAME_DISP \n");
		sbSql.append("         ,A.MEAL \n");
		sbSql.append("         ,A.CORNER \n");
		
		//System.out.println(sbSql.toString());                                                                                                                                                             
		pstmt = conn.prepareStatement(sbSql.toString());		                                                                                                                                                
		rs = pstmt.executeQuery();                                                                                                                                                                          
		ds_list = this.makeDataSet(rs, "ds_list");                                                                                                                                                          
                                                                                                                                                                                                        
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
                                                                                                                                                                                                        
--%>