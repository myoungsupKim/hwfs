<%@page import="com.sz.util.AppDataUtility"%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	try {
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));
		
		String  MENU_CLASS			= in_vl.getString("MENU_CLASS");			
		String  MENU_NAME			= in_vl.getString("MENU_NAME");		
		String  FROM_COST			= in_vl.getString("FROM_COST");	
		String  TO_COST				= in_vl.getString("TO_COST");		
		String  RECIPE_NAME			= in_vl.getString("RECIPE_NAME");	
		String  g_Upjang			= in_vl.getString("g_Upjang");
	
		DataSet ds_out;
		StringBuffer sbSql = new StringBuffer();
	
		sbSql.delete(0, sbSql.length());
		sbSql.append("SELECT AA.* \n");
		sbSql.append("FROM ( \n");
		sbSql.append("SELECT A.UPJANG \n");
		sbSql.append("      ,A.MENU_CD \n");
		sbSql.append("      ,A.MENU_NAME \n");
		sbSql.append("      ,A.MENU_CLASS \n");
		sbSql.append("      ,(SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0028' AND CODE = A.MENU_CLASS) MENU_CLASS_NM \n");
		sbSql.append("      ,SUM(ROUND( E.NEED_QTY * (NVL(F.OP_PRICE,0) / F.KG_CONVERT_RATE / 1000) ) ) AS RECIPE_COST  -- 가식부량 적용 여부 결정 \n");
		sbSql.append("      ,FMM_RECIPENAME_FUN(A.UPJANG,A.MENU_CD,'0') AS RECIPE_NAMES --레시피구성 \n");
		sbSql.append("  FROM FMM_STD_MENU A \n");
		sbSql.append("      ,FMM_STD_MENU_RECIPE B \n");
		// 본사표준레시피만 조회 되게 수정
// 		sbSql.append("      ,( \n");	
// 		sbSql.append("         SELECT UPJANG,RECIPE_CD, ITEM_CODE,  NEED_QTY \n");
// 		sbSql.append("           FROM FMM_STD_RECIPE_ITEM \n");
// 		sbSql.append("          WHERE UPJANG = "+g_Upjang+" \n");
// 		sbSql.append("       ) E \n");
		sbSql.append("      ,( \n");	
		sbSql.append("         SELECT "+g_Upjang+" UPJANG,A.RECIPE_CD,FMM_CHGITEM_FUN("+g_Upjang+", A.ITEM_CODE) ITEM_CODE, SUM(A.NEED_QTY) NEED_QTY \n");
		sbSql.append("           FROM FMR_STD_RECIPE_ITEM A, \n");
		sbSql.append("                FMM_STD_MENU_RECIPE B \n");
		sbSql.append("          WHERE B.UPJANG = "+g_Upjang+" \n");
		sbSql.append("            AND A.RECIPE_CD = B.RECIPE_CD \n");
		sbSql.append("          GROUP BY A.RECIPE_CD,FMM_CHGITEM_FUN("+g_Upjang+", A.ITEM_CODE) \n");
		sbSql.append("          UNION ALL \n");
		sbSql.append("         SELECT UPJANG,RECIPE_CD, ITEM_CODE,  NEED_QTY \n");
		sbSql.append("           FROM FMM_STD_RECIPE_ITEM \n");
		sbSql.append("          WHERE UPJANG = "+g_Upjang+" \n");
		sbSql.append("       ) E \n");
		sbSql.append("      ,( \n");
		sbSql.append("      SELECT \n");
		sbSql.append("             A.UPJANG, A.ITEM_CODE \n");
		sbSql.append("           , A.SALE_PRICE, A.KG_CONVERT_RATE \n");
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
		sbSql.append("   AND B.RECIPE_CD = E.RECIPE_CD \n");
		sbSql.append("   AND B.UPJANG = E.UPJANG \n");
		sbSql.append("   AND E.UPJANG = F.UPJANG(+) \n");
		sbSql.append("   AND E.ITEM_CODE = F.ITEM_CODE(+) \n");
		
		sbSql.append("   AND B.UPJANG = "+g_Upjang+" \n");
		if(!MENU_CLASS.equals(""))
		{
		sbSql.append("   AND A.MENU_CLASS ='"+MENU_CLASS+"' \n");
		}
		if(!MENU_NAME.equals(""))
		{
		sbSql.append("   AND A.MENU_NAME LIKE '%'||'"+MENU_NAME+"'||'%' \n");
		}
		if(!RECIPE_NAME.equals(""))
		{
		sbSql.append("   AND FMM_RECIPENAME_FUN(A.UPJANG,A.MENU_CD,'0') LIKE '%'||'"+RECIPE_NAME+"'||'%' \n");
		}
		sbSql.append("   GROUP BY A.UPJANG, A.MENU_CD,A.MENU_NAME,A.MENU_CLASS \n");
		sbSql.append(") AA \n");
		sbSql.append("WHERE 1=1 \n");
		if(!FROM_COST.equals(""))
		{
		sbSql.append("   AND AA.RECIPE_COST >= "+FROM_COST+" \n");
		}
		if(!TO_COST.equals(""))
		{
		sbSql.append("   AND AA.RECIPE_COST <= "+TO_COST+" \n");
		}
		sbSql.append(" ORDER BY AA.MENU_CD \n");	
		
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 

		DataSet ds_list = this.makeDataSet(rs,"ds_list");
		out_dl.add( ds_list );
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