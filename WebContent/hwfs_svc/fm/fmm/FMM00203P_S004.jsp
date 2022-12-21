<%                                                                                                                                                                                                      
/*-----------------------------------------------------------------------------                                                                                                                         
■ 시스템명     : 메뉴관리/식단관리                                                                                                                                                                     
■ 프로그램ID   : FMM00203P_S004.jsp                                                                                                                                                                    
■ 프로그램명   : MY 레시피 그룹의 레시피 리스트 조회                                                                                                                                      
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
	  	String strUpjang 			= nullToBlank(in_vl.getString("UPJANG"));
	  	String strRecipeSet 		= nullToBlank(in_vl.getString("RECIPE_SET"));
	  	String strCostGbn 			= nullToBlank(in_vl.getString("CostGbn"));
                                                                                                                                                                                                     
		//out 데이타                                                                                                                                                                                        
		DataSet ds_list;                                                                                                                                                                                    
		                                                                                                                                                                                                    
		//sql문 버퍼생성                                                                                                                                                                                    
		StringBuffer sbSql = new StringBuffer();                                                                                                                                                            
        
		sbSql.append("SELECT A.UPJANG, \n");
		sbSql.append("       C.RECIPE_SET, \n");
		sbSql.append("       A.RECIPE_CD,  --레시피코드 \n");
		sbSql.append("       A.RECIPE_NAME, --레시피명 \n");
		sbSql.append("       A.SUBINV_CLASS, \n");
		sbSql.append("       (SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FM0006' AND CODE = A.SUBINV_CLASS) SUBINV_CLASS_NAME, --식당군 \n");
		if (strCostGbn.equals("0"))
		{
			sbSql.append("       0 OP_PRICE \n");
			sbSql.append("  FROM FMM_UPJANG_RECIPE_MST A , \n");
			sbSql.append("       FMM_MY_RECIPE C \n");
			sbSql.append(" WHERE A.UPJANG = C.UPJANG \n");
			sbSql.append("   AND A.RECIPE_CD = C.RECIPE_CD \n");
			sbSql.append("   AND A.SUBINV_CLASS = C.SUBINV_CLASS \n");
			sbSql.append("   AND C.UPJANG = " + strUpjang + " \n");
			sbSql.append("   AND C.RECIPE_SET = " + strRecipeSet + " \n");
			sbSql.append("ORDER BY A.SUBINV_CLASS,A.RECIPE_CD \n");
		}
		else
		{
			sbSql.append("       SUM(ROUND(B.NEED_QTY * (NVL(E.OP_PRICE,0) / E.KG_CONVERT_RATE / 1000) )) AS OP_PRICE --1인원가 \n");
			sbSql.append("  FROM FMM_UPJANG_RECIPE_MST A , \n");
			sbSql.append("       FMM_UPJANG_RECIPE_ITEM B , \n");
			sbSql.append("       FMM_MY_RECIPE C , \n");
			sbSql.append("       ( \n");
			sbSql.append("      SELECT \n");
			sbSql.append("             A.UPJANG, A.ITEM_CODE, A.SALE_PRICE, B.KG_CONVERT_RATE, \n");
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
			sbSql.append("                WHERE UPJANG = " + strUpjang + " \n");
			sbSql.append("                  AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN SDATE AND EDATE \n");
			sbSql.append("                  AND USE_YN = 'Y' \n");
			sbSql.append("                  AND ITEM_TYPE = 'M' \n");
			sbSql.append("             ) C, \n");
			sbSql.append("             ( \n");        
			sbSql.append("               SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL \n");
			sbSql.append("                 FROM FMU_OP_RATE \n");
			sbSql.append("                WHERE UPJANG = " + strUpjang + " \n");
			sbSql.append("                  AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN SDATE AND EDATE \n");
			sbSql.append("                  AND USE_YN = 'Y' \n");
			sbSql.append("                  AND ITEM_TYPE = 'C' \n");
			sbSql.append("             ) D, \n");
			sbSql.append("             ( \n");
			sbSql.append("			    SELECT  \n");
			sbSql.append("				   	   " + strUpjang + " AS UPJANG, \n");
			sbSql.append("				       TO_CHAR(SYSDATE,'YYYYMMDD') AS NEED_DATE , \n");
			sbSql.append("				       A.ITEM_CODE, \n");
			sbSql.append("				       A.SALE_PRICE \n");
			sbSql.append("			      FROM HLDC_PO_CONTRACT_FSALE A, HLDC_ST_UPJANG B \n");
			sbSql.append("			     WHERE A.UPJANG = B.AP_UNITPRICE_UPJANG \n");
			sbSql.append("			       AND B.UPJANG = " + strUpjang + " \n");
			sbSql.append("			       AND A.ITEM_CODE > ' ' \n");
			sbSql.append("			       AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN A.CONTRACT_START AND NVL(A.CONTRACT_END, '99999999') \n");
			sbSql.append("			       AND A.SALE_PRICE > 0 \n");
			sbSql.append("			       AND A.USE_YN = 'Y' \n");
			sbSql.append("             ----------- \n");
			sbSql.append("              UNION ALL \n");
			sbSql.append("             ----------- \n");
			sbSql.append("             SELECT " + strUpjang + " AS UPJANG, TO_CHAR(SYSDATE,'YYYYMMDD') AS NEED_DATE, A.ITEM_CODE, A.SALE_PRICE \n");
			sbSql.append("               FROM FMP_OTCUST_PRICE_AVA_V A , \n");
			sbSql.append("                    ( \n");
			sbSql.append("                    SELECT UPJANG, ITEM_CODE, MAX(SDATE) AS SDATE \n");
			sbSql.append("                      FROM FMP_OTCUST_PRICE_AVA_V \n");
			sbSql.append("                     WHERE UPJANG = \n");
			sbSql.append("                           ( \n");
			sbSql.append("                           SELECT OTCUST_PRICE_UPJANG \n");
			sbSql.append("                             FROM FMS_UPJANG \n");
			sbSql.append("                            WHERE UPJANG = " + strUpjang + " \n");
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
			sbSql.append("         ) E \n");
			sbSql.append(" WHERE A.UPJANG = B.UPJANG \n");
			sbSql.append("   AND A.RECIPE_CD = B.RECIPE_CD \n");
			sbSql.append("   AND A.UPJANG = C.UPJANG \n");
			sbSql.append("   AND A.RECIPE_CD = C.RECIPE_CD \n");
			sbSql.append("   AND A.SUBINV_CLASS = C.SUBINV_CLASS \n");
			sbSql.append("   AND B.ITEM_CODE = E.ITEM_CODE(+) \n");
			sbSql.append("   AND C.UPJANG = " + strUpjang + " \n");
			sbSql.append("   AND C.RECIPE_SET = " + strRecipeSet + " \n");
			sbSql.append("  GROUP BY  A.UPJANG,C.RECIPE_SET,A.RECIPE_CD, A.RECIPE_NAME, A.SUBINV_CLASS \n");
			sbSql.append("ORDER BY A.SUBINV_CLASS,A.RECIPE_CD \n");
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