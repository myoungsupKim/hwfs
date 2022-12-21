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
	                                                                                                                                                                                                        
		//입력 데이타                                                                                                                                                                                         
		DataSet ds_input     	= in_dl.get("ds_input");                                                                                                                                                  
	                                                                                                                                                                                                        
	  	String strUpjang 		= nullToBlank(ds_input.getString(0, "UPJANG"));
	  	String strRecipeCD		= nullToBlank(ds_input.getString(0, "RECIPE_CD"));
	  	String strMenuCD		= nullToBlank(ds_input.getString(0, "MENU_CD"));                                                                                                                                                                                             
                                                                                                                                                                                                     
		//out 데이타                                                                                                                                                                                        
		DataSet ds_list;                                                                                                                                                                                    
		                                                                                                                                                                                                    
		//sql문 버퍼생성                                                                                                                                                                                    
		StringBuffer sbSql = new StringBuffer();                                                                                                                                                            
        
		sbSql.append("SELECT A.RECIPE_CD \n");
		sbSql.append("     , A.RECIPE_NAME \n");
		sbSql.append("     , A.ITEM_CODE \n");
		sbSql.append("     , A.ITEM_NAME \n");
		sbSql.append("     , A.FEATURE_NAME \n");
		sbSql.append("     , A.ITEM_SIZE \n");
		sbSql.append("     , A.PO_UOM \n");
		sbSql.append("     , A.NEED_QTY \n");
		sbSql.append("     , A.PAST_PRICE \n");
		sbSql.append("     , NVL(ROUND( (A.NEED_QTY * NVL(G_ITEM_PRICE,0))),0) CUR_PRICE \n");
		sbSql.append("     , A.UPJANG \n");
		sbSql.append("     , A.MENU_CD \n");
		sbSql.append("     , A.ITEM_SEQ \n");
		sbSql.append("     , A.EDIBLE_QTY \n");
		sbSql.append("     , A.CUT_SPEC \n");
		sbSql.append("     , A.ORDER_YN \n");
		sbSql.append("     , A.PR_ID \n");
		sbSql.append("     , A.PR_NUM \n");
		sbSql.append("     , A.PR_QTY \n");
		sbSql.append("     , A.NEED_DATE \n");
		sbSql.append("     , A.UNIT_PRICE \n");
		sbSql.append("     , A.OP_RATE \n");
		sbSql.append("     , A.OP_PRICE \n");
		sbSql.append("  FROM \n");
		sbSql.append("       ( \n");
		sbSql.append("         SELECT A.RECIPE_TYPE, A.CUISINE_TYPE, A.RECIPE_CD, A.RECIPE_NAME, \n");
		//sbSql.append("                C.ITEM_NAME, D.FEATURE_NAME, C.ITEM_SIZE, C.PO_UOM, \n");
		sbSql.append("	    		  FMS_ITEM_FEATURE_FUN("+strUpjang+", TO_CHAR(SYSDATE,'YYYYMMDD'), B.ITEM_CODE, 'N') AS FEATURE_NAME, --자재특성 \n");
		sbSql.append("                C.ITEM_NAME, C.ITEM_SIZE, C.PO_UOM, \n");
		sbSql.append("                B.UPJANG, B.MENU_CD, B.ITEM_CODE, B.ITEM_SEQ, B.NEED_QTY, B.EDIBLE_QTY, B.CUT_SPEC, B.ORDER_YN, \n");
		sbSql.append("                B.PR_ID, B.PR_NUM, B.PR_QTY, B.NEED_DATE, B.UNIT_PRICE, B.OP_RATE, B.OP_PRICE, \n");
		sbSql.append("                NVL(ROUND((B.NEED_QTY * NVL((B.OP_PRICE / C.KG_CONVERT_RATE / 1000),0))),0) AS PAST_PRICE \n");
		sbSql.append("           FROM FMM_RECIPE A \n");
		sbSql.append("               ,FMM_RECIPE_ITEM B \n");
		sbSql.append("               ,( \n");
		sbSql.append("                  SELECT A.ITEM_CODE,A.ITEM_NAME,A.ITEM_SIZE,A.PO_UOM,A.KG_CONVERT_RATE \n");
		sbSql.append("                       , B.CAL, B.WATER, B.PROT, B.FAT, B.CARBO, B.FIBER, B.ASH, B.CA, B.P \n");
		sbSql.append("                       , B.FE, B.NA, B.K, B.VITA_A, B.RETIN, B.B_CAROT, B.THIA, B.RIBO, B.NIACIN \n");
		sbSql.append("                       , B.VITA_C, B.CHOLE, B.DISUSE_RATE \n");
		sbSql.append("                  FROM (SELECT B.ITEM_CODE, B.ITEM_NAME, B.ITEM_SIZE, B.PO_UOM, B.TAX_CODE,B.KG_CONVERT_RATE \n");
		sbSql.append("                          FROM HLDC_PO_ITEM_MST B, HLDC_PO_CONTRACT_FSALE A, HLDC_ST_UPJANG C \n");
		sbSql.append("                         WHERE A.ITEM_CODE = B.ITEM_CODE \n");
		sbSql.append("                           AND A.UPJANG = C.AP_UNITPRICE_UPJANG \n");
		sbSql.append("                           AND C.UPJANG = " + strUpjang + " \n");
		sbSql.append("                           AND B.ITEM_CLASS1 = 'F' \n");
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
		sbSql.append("	              )C --자재 리스트 \n");
// 		sbSql.append("              ,( \n");
// 		sbSql.append("			      SELECT ITEM_CODE, \n");
// 		sbSql.append("			      	    (SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0033' AND CODE = ITEM_FEATURE) AS FEATURE_NAME \n");
// 		sbSql.append("			        FROM FSI_ITEM_FEATURE \n");
// 		sbSql.append("			       WHERE (ITEM_CODE, CDATE) IN ( \n");
// 		sbSql.append("			      			                    SELECT ITEM_CODE, MAX(CDATE) AS CDATE \n");
// 		sbSql.append("			      			                      FROM FSI_ITEM_FEATURE \n");
// 		sbSql.append("			      			                     WHERE (1=1) \n");
// 		sbSql.append("			      			                       AND (CENTER_CODE, CUSTCD, ITEM_CODE, APPLY_DATE) IN ( \n");
// 		sbSql.append("			      				  	            					   SELECT CENTER_CODE, \n");
// 		sbSql.append("			      				  	            						      CUSTCD, \n");
// 		sbSql.append("			      				  	            						      ITEM_CODE, \n");
// 		sbSql.append("			      				  	            						      MAX(APPLY_DATE) AS APPLY_DATE \n");
// 		sbSql.append("			      				  	            					     FROM FSI_ITEM_FEATURE \n");
// 		sbSql.append("			      				  	            					    WHERE CENTER_CODE  = '300001' \n");
// 		sbSql.append("			      				  	            					      AND APPLY_DATE BETWEEN TO_CHAR(SYSDATE,'YYYYMMDD') AND TO_CHAR(ADD_MONTHS(SYSDATE,1),'YYYYMMDD')-1 \n");
// 		sbSql.append("			      				  	            					    GROUP BY CENTER_CODE, CUSTCD, ITEM_CODE \n");
// 		sbSql.append("                                                                            ) \n");
// 		sbSql.append("			      				                GROUP BY ITEM_CODE \n");
// 		sbSql.append("			      				               ) \n");
// 		sbSql.append("		          ) D -- 자재 특성 \n");
		sbSql.append("          WHERE A.UPJANG = B.UPJANG \n");
		sbSql.append("            AND A.MENU_CD = B.MENU_CD \n");
		sbSql.append("            AND A.RECIPE_CD = B.RECIPE_CD \n");
		sbSql.append("            AND B.ITEM_CODE = C.ITEM_CODE \n");
// 		sbSql.append("            AND B.ITEM_CODE = D.ITEM_CODE(+) \n");
		sbSql.append("            AND A.UPJANG  = " + strUpjang + " \n");
		sbSql.append("            AND A.MENU_CD = '" + strMenuCD + "' \n");
		sbSql.append("            AND A.RECIPE_CD = '" + strRecipeCD + "' \n");
		sbSql.append("       ) A \n");
		sbSql.append("      ,( \n");
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
		sbSql.append("              FROM  \n");
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
		sbSql.append("                   SELECT " + strUpjang + " AS UPJANG, NVL('',TO_CHAR(SYSDATE,'YYYYMMDD')) AS NEED_DATE \n");
		sbSql.append("                        , A.ITEM_CODE, A.UNIT_PRICE, A.SALE_PRICE,0 CENTER_CODE,0 CUSTCD \n");
		sbSql.append("                     FROM FMP_OTCUST_PRICE_AVA_V A \n");
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
		sbSql.append("                   ) A \n");
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
		sbSql.append("       ) B --단가 \n");
		sbSql.append(" WHERE A.ITEM_CODE = B.ITEM_CODE(+) \n");
		sbSql.append(" ORDER BY  A.RECIPE_TYPE, A.CUISINE_TYPE, A.RECIPE_CD \n");
		
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