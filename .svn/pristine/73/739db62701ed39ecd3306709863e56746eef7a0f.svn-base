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
	
		String  STD_CHK				= in_vl.getString("STD_CHK");			
		String  UPJANG_CHK			= in_vl.getString("UPJANG_CHK");		
		String  RECIPE_NAME			= in_vl.getString("RECIPE_NAME");	
		String  RECIPE_CLASS		= in_vl.getString("RECIPE_CLASS");		
		String  RECIPE_TYPE			= in_vl.getString("RECIPE_TYPE");	
		String  UPJANG				= in_vl.getString("UPJANG");
		
		DataSet ds_out;
		StringBuffer sbSql = new StringBuffer();
	
		sbSql.delete(0, sbSql.length());
		sbSql.append("SELECT \n");
		sbSql.append("       A.GUBUN, \n");
		sbSql.append("       A.RECIPE_CD, \n");
		sbSql.append("       A.RECIPE_NAME, \n");
		sbSql.append("       SUM(ROUND( A.NEED_QTY * NVL(C.G_ITEM_PRICE,0) )) RECIPE_COST, \n");
		sbSql.append("       ROUND(SUM(NVL(F.CAL* A.NEED_QTY * (100-F.DISUSE_RATE) / 100,0) )/100,2) CAL_CALC, \n");
		sbSql.append("       COST_RATE, \n");
		sbSql.append("       0 SALE_PRICE, \n");
		sbSql.append("       PREFER, \n");
		sbSql.append("       PREFER_LABEL, \n");
		sbSql.append("       RECIPE_CLASS, \n");
		sbSql.append("       RECIPE_TYPE, \n");
		sbSql.append("       CUISINE_TYPE, \n");
		sbSql.append("       PHF, \n");
		sbSql.append("       DI_MON, \n");
		sbSql.append("       SAME_WORD \n");
		sbSql.append("  FROM \n");
		sbSql.append("       ( \n");
		
		sbSql.append("       SELECT '0' GUBUN,       --한화 \n");
		sbSql.append("              A.RECIPE_CD,     --레시피코드 \n");
		sbSql.append("              A.RECIPE_NAME,   --레시피명 \n");
		sbSql.append("              NVL(C.ITEM_CODE_TO,B.ITEM_CODE) AS ITEM_CODE, \n");
		sbSql.append("              0 AS COST_RATE,  -- 수식으로 해결 => 판매가가 0이 아닐 경우 ROUND((레시피원가/판매가)*100) \n");
		sbSql.append("              A.SALE_PRICE,    -- 판매가 \n");
		sbSql.append("              '' AS PREFER, \n");
		sbSql.append("              '' AS PREFER_LABEL, \n");
		sbSql.append("              A.RECIPE_CLASS, \n");
		sbSql.append("              A.RECIPE_TYPE, \n");
		sbSql.append("              A.CUISINE_TYPE, \n");
		sbSql.append("              A.PHF, \n");
		sbSql.append("              SUM(B.NEED_QTY) AS NEED_QTY, \n");
		sbSql.append("              CASE WHEN MONTHS_BETWEEN( SYSDATE, DECODE(A.CDATE, NULL, SYSDATE, A.CDATE) )<= 1.0 THEN 1 ELSE 0 END DI_MON, \n");
		sbSql.append("              A.SAME_WORD \n");
		sbSql.append("         FROM FMR_STD_RECIPE_MST A , \n");
		sbSql.append("              FMR_STD_RECIPE_ITEM B, \n");		
		sbSql.append("              (SELECT * FROM FMM_CHG_ITEM_LIST WHERE UPJANG = "+UPJANG+") C,    	\n");
		sbSql.append("              FMS_ITEM_V D    	\n");
		
		sbSql.append("        WHERE A.RECIPE_CD = B.RECIPE_CD \n");
		sbSql.append("          AND B.ITEM_CODE = C.ITEM_CODE(+) \n");
		sbSql.append("          AND B.ITEM_CODE = D.ITEM_CODE \n");
		sbSql.append("          AND A.RECIPE_CLASS != 'H' \n");
		if(!RECIPE_NAME.equals(""))
		{
		//sbSql.append("          AND A.RECIPE_NAME LIKE '%'||'"+RECIPE_NAME+"'||'%' \n");
			String[] arrSameWord = RECIPE_NAME.split(" ");
			
			sbSql.append("  AND ( \n");
			for(int i=0; i<arrSameWord.length; i++) {
				sbSql.append("   A.SAME_WORD LIKE '%'||'"+arrSameWord[i]+"'||'%' \n");
				sbSql.append("OR A.RECIPE_NAME LIKE '%'||'"+arrSameWord[i]+"'||'%' \n");
				if(i < arrSameWord.length-1) {
					sbSql.append("  OR \n");
				}
			}
			sbSql.append("  ) \n");
		
		}
		if(!RECIPE_CLASS.equals(""))
		{
		sbSql.append("          AND A.RECIPE_CLASS = '"+RECIPE_CLASS+"' \n");
		}
		if(!RECIPE_TYPE.equals(""))
		{
		sbSql.append("          AND A.RECIPE_TYPE = '"+RECIPE_TYPE+"' \n");
		}
		if(STD_CHK.equals("0"))
		{
		sbSql.append("          AND to_char(A.CDATE,'yyyymmdd')='99999999'	-- 본사 레시피 미체크이면 데이타 없도록 \n");
		}
		sbSql.append("          GROUP BY A.RECIPE_CD, A.RECIPE_NAME, NVL(C.ITEM_CODE_TO,B.ITEM_CODE), A.SALE_PRICE, A.RECIPE_CLASS, A.RECIPE_TYPE, A.CUISINE_TYPE, A.PHF, A.CDATE, A.SAME_WORD \n");
		sbSql.append("        UNION ALL \n");
		
		sbSql.append("       SELECT '1' GUBUN,       --본사 \n");
		sbSql.append("              A.RECIPE_CD,     --레시피코드 \n");
		sbSql.append("              A.RECIPE_NAME,   --레시피명 \n");
		sbSql.append("              B.ITEM_CODE, \n");
		sbSql.append("              0 AS COST_RATE,  -- 수식으로 해결 => 판매가가 0이 아닐 경우 ROUND((레시피원가/판매가)*100) \n");
		sbSql.append("              A.SALE_PRICE,    -- 판매가 \n");
		sbSql.append("              '' AS PREFER, \n");
		sbSql.append("              '' AS PREFER_LABEL, \n");
		sbSql.append("              A.RECIPE_CLASS, \n");
		sbSql.append("              A.RECIPE_TYPE, \n");
		sbSql.append("              A.CUISINE_TYPE, \n");
		sbSql.append("              A.PHF, \n");
		sbSql.append("              B.NEED_QTY, \n");
		sbSql.append("              CASE WHEN MONTHS_BETWEEN( SYSDATE, DECODE(A.CDATE, NULL, SYSDATE, A.CDATE) )<= 1.0 THEN 1 ELSE 0 END DI_MON, \n");
		sbSql.append("              A.SAME_WORD \n");
		sbSql.append("         FROM FMM_STD_RECIPE_MST A , \n");
		sbSql.append("              FMM_STD_RECIPE_ITEM B, \n");
		sbSql.append("              FMS_ITEM_V D    	\n");
		sbSql.append("        WHERE A.RECIPE_CD = B.RECIPE_CD \n");
		sbSql.append("          AND A.RECIPE_CLASS != 'H' \n");		
		sbSql.append("          AND A.UPJANG = "+UPJANG+" \n");
		sbSql.append("          AND A.UPJANG = B.UPJANG \n");
		sbSql.append("          AND B.ITEM_CODE = D.ITEM_CODE \n");
		if(!RECIPE_NAME.equals(""))
		{
		//sbSql.append("          AND A.RECIPE_NAME LIKE '%'||'"+RECIPE_NAME+"'||'%' \n");
			String[] arrSameWord = RECIPE_NAME.split(" ");
			
			sbSql.append("  AND ( \n");
			for(int i=0; i<arrSameWord.length; i++) {
				sbSql.append("   A.SAME_WORD LIKE '%'||'"+arrSameWord[i]+"'||'%' \n");
				sbSql.append("OR A.RECIPE_NAME LIKE '%'||'"+arrSameWord[i]+"'||'%' \n");
				if(i < arrSameWord.length-1) {
					sbSql.append("  OR \n");
				}
			}
			sbSql.append("  ) \n");
		}
		if(!RECIPE_CLASS.equals(""))
		{
		sbSql.append("          AND A.RECIPE_CLASS = '"+RECIPE_CLASS+"' \n");
		}
		if(!RECIPE_TYPE.equals(""))
		{
		sbSql.append("          AND A.RECIPE_TYPE = '"+RECIPE_TYPE+"' \n");
		}
		if(UPJANG_CHK.equals("0"))
		{
		sbSql.append("          AND to_char(A.CDATE,'yyyymmdd')='99999999'	-- 본사 레시피 미체크이면 데이타 없도록 \n");
		}
		sbSql.append("       ) A, \n");
		sbSql.append("       ( \n");

		sbSql.append("		SELECT \n");
		sbSql.append("			   A.UPJANG, A.ITEM_CODE, A.SALE_PRICE, A.KG_CONVERT_RATE, \n");
		sbSql.append("             NVL(NVL(C.OP_RATE, D.OP_RATE), 0) AS OP_RATE, --운영율 \n");
		sbSql.append("             CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
    	sbSql.append("                  THEN DECODE(SIGN(NVL(C.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE) \n");
    	sbSql.append("                  WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL \n");
    	sbSql.append("                  THEN DECODE(SIGN(NVL(D.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL), D.OP_PRICE) \n");
    	sbSql.append("             ELSE A.SALE_PRICE END AS OP_PRICE, --운영단가 \n");
    	sbSql.append("             CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
		sbSql.append("                  THEN DECODE(SIGN(NVL(C.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE) / A.KG_CONVERT_RATE / 1000 \n");
		sbSql.append("                  WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL \n");
		sbSql.append("                  THEN DECODE(SIGN(NVL(D.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL), D.OP_PRICE) / A.KG_CONVERT_RATE / 1000 \n");
		sbSql.append("             ELSE A.SALE_PRICE / A.KG_CONVERT_RATE / 1000 END AS G_ITEM_PRICE \n");
		sbSql.append("		   FROM	\n");
		sbSql.append("		      (	\n");
		sbSql.append("              SELECT \n");
		sbSql.append("              		"+UPJANG+" AS UPJANG, \n");
		sbSql.append("              		TO_CHAR(SYSDATE,'YYYYMMDD') AS NEED_DATE , \n");
		sbSql.append("                      A.ITEM_CODE, \n");
		sbSql.append("                      A.SALE_PRICE, \n");
		sbSql.append("                      B.ITEM_CLASS4, \n");
		sbSql.append("                      B.KG_CONVERT_RATE \n");
		sbSql.append("                 FROM HLDC_PO_CONTRACT_FSALE A, HLDC_PO_ITEM_MST B, HLDC_ST_UPJANG C \n");
		sbSql.append("                WHERE A.ITEM_CODE = B.ITEM_CODE \n");
		sbSql.append("                  AND A.UPJANG = C.AP_UNITPRICE_UPJANG \n");
		sbSql.append("                  AND C.UPJANG = "+UPJANG+" \n");
		sbSql.append("                  AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN A.CONTRACT_START AND NVL(A.CONTRACT_END, '99999999') \n");
		sbSql.append("                  AND A.SALE_PRICE > 0 \n");
		sbSql.append("                  AND A.USE_YN = 'Y' \n");
		sbSql.append("               ----------- \n");
		sbSql.append("                UNION ALL \n");
		sbSql.append("               ----------- \n");
		sbSql.append("               SELECT "+UPJANG+" AS UPJANG, TO_CHAR(SYSDATE,'YYYYMMDD') AS NEED_DATE, A.ITEM_CODE, A.SALE_PRICE, \n");
		sbSql.append("                      B.ITEM_CLASS4, B.KG_CONVERT_RATE \n");
		sbSql.append("                 FROM FMP_OTCUST_PRICE_AVA_V A, FMP_OTCUST_ITEM B, \n");
		sbSql.append("                      ( \n");
		sbSql.append("                      SELECT UPJANG, ITEM_CODE, MAX(SDATE) AS SDATE \n");
		sbSql.append("                        FROM FMP_OTCUST_PRICE_AVA_V \n");
		sbSql.append("                       WHERE UPJANG = \n");
		sbSql.append("                             ( \n");
		sbSql.append("                             SELECT OTCUST_PRICE_UPJANG \n");
		sbSql.append("                               FROM FMS_UPJANG \n");
		sbSql.append("                              WHERE UPJANG = "+UPJANG+" \n");
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
		sbSql.append("		       ) A,	\n");
		sbSql.append("             ( \n");        
		sbSql.append("             SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL \n");
		sbSql.append("               FROM FMU_OP_RATE \n");
		sbSql.append("              WHERE UPJANG = "+UPJANG+" \n");
		sbSql.append("                AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN SDATE AND EDATE \n");
		sbSql.append("                AND USE_YN = 'Y' \n");
		sbSql.append("                AND ITEM_TYPE = 'M' \n");
		sbSql.append("             ) C, \n");
		sbSql.append("             ( \n");        
		sbSql.append("             SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL \n");
		sbSql.append("               FROM FMU_OP_RATE \n");
		sbSql.append("              WHERE UPJANG = "+UPJANG+" \n");
		sbSql.append("                AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN SDATE AND EDATE \n");
		sbSql.append("                AND USE_YN = 'Y' \n");
		sbSql.append("                AND ITEM_TYPE = 'C' \n");
		sbSql.append("             ) D \n");
		sbSql.append("       WHERE A.ITEM_CODE = C.ITEM_CODE(+) \n");
		sbSql.append("         AND A.ITEM_CLASS4 = D.ITEM_CODE(+) \n");
		sbSql.append("       ) C \n");
		sbSql.append("      ,( \n");
		sbSql.append("		 SELECT ITEM_CODE, CAL, WATER, PROT, FAT, CARBO, FIBER, ASH, CA, P, FE, NA, K, VITA_A, RETIN, B_CAROT, THIA, RIBO, NIACIN, VITA_C, CHOLE, DISUSE_RATE \n");
		sbSql.append("		   FROM FMP_ITEM_NUT \n");
		sbSql.append("		  WHERE UPJANG = "+UPJANG+" \n");
		sbSql.append("		  UNION ALL \n");
		sbSql.append("		 SELECT A.ITEM_CODE, CAL, WATER, PROT, FAT, CARBO, FIBER, ASH, CA, P, FE, NA, K, VITA_A, RETIN, B_CAROT, THIA, RIBO, NIACIN, VITA_C, CHOLE, DISUSE_RATE \n");
		sbSql.append("		   FROM FSI_ITEM_NUT A,	\n");
		sbSql.append("			 (			\n");
		sbSql.append("			 SELECT	ITEM_CODE	\n");
		sbSql.append("			   FROM	FSI_ITEM_NUT MINUS	\n");
		sbSql.append("			 SELECT	ITEM_CODE	\n");
		sbSql.append("			   FROM	FMP_ITEM_NUT	\n");
		sbSql.append("			  WHERE	UPJANG = "+UPJANG+"	\n");
		sbSql.append("			 ) B			\n");
		sbSql.append("		WHERE A.ITEM_CODE = B.ITEM_CODE		\n");	
		sbSql.append("       ) F ---열량 \n");
		sbSql.append(" WHERE   A.ITEM_CODE = C.ITEM_CODE(+) \n");
		sbSql.append("   AND A.ITEM_CODE = F.ITEM_CODE(+) \n");
		sbSql.append(" GROUP BY A.GUBUN, \n");
		sbSql.append("       A.RECIPE_CD, \n");
		sbSql.append("       A.RECIPE_NAME, \n");
		sbSql.append("       COST_RATE, \n");
		sbSql.append("       PREFER, \n");
		sbSql.append("       PREFER_LABEL, \n");
		sbSql.append("       RECIPE_CLASS, \n");
		sbSql.append("       RECIPE_TYPE, \n");
		sbSql.append("       CUISINE_TYPE, \n");
		sbSql.append("       PHF, \n");
		sbSql.append("       DI_MON, \n");
		sbSql.append("       SAME_WORD \n");
		sbSql.append(" ORDER BY GUBUN DESC, \n");
		sbSql.append("       RECIPE_CD \n"); 
		
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 

		DataSet ds_subList = this.makeDataSet(rs,"ds_subList");
		out_dl.add(ds_subList);
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
	
		String  STD_CHK				= in_vl.getString("STD_CHK");			
		String  UPJANG_CHK			= in_vl.getString("UPJANG_CHK");		
		String  RECIPE_NAME			= in_vl.getString("RECIPE_NAME");	
		String  RECIPE_CLASS		= in_vl.getString("RECIPE_CLASS");		
		String  RECIPE_TYPE			= in_vl.getString("RECIPE_TYPE");	
		String  UPJANG				= in_vl.getString("UPJANG");
		
		DataSet ds_out;
		StringBuffer sbSql = new StringBuffer();
	
		sbSql.delete(0, sbSql.length());
		sbSql.append("SELECT \n");
		sbSql.append("       A.GUBUN, \n");
		sbSql.append("       A.RECIPE_CD, \n");
		sbSql.append("       A.RECIPE_NAME, \n");
		sbSql.append("       SUM(ROUND( A.NEED_QTY * NVL(C.G_ITEM_PRICE,0) )) RECIPE_COST, \n");
		sbSql.append("       ROUND(SUM(NVL(F.CAL* A.NEED_QTY * (100-F.DISUSE_RATE) / 100,0) )/100,2) CAL_CALC, \n");
		sbSql.append("       COST_RATE, \n");
		sbSql.append("       0 SALE_PRICE, \n");
		sbSql.append("       PREFER, \n");
		sbSql.append("       PREFER_LABEL, \n");
		sbSql.append("       RECIPE_CLASS, \n");
		sbSql.append("       RECIPE_TYPE, \n");
		sbSql.append("       CUISINE_TYPE, \n");
		sbSql.append("       PHF, \n");
		sbSql.append("       DI_MON, \n");
		sbSql.append("       SAME_WORD \n");
		sbSql.append("  FROM \n");
		sbSql.append("       ( \n");
		sbSql.append("       SELECT '0' GUBUN,       --한화 \n");
		sbSql.append("              A.RECIPE_CD,     --레시피코드 \n");
		sbSql.append("              A.RECIPE_NAME,   --레시피명 \n");
		sbSql.append("              NVL(C.ITEM_CODE_TO,B.ITEM_CODE) AS ITEM_CODE, \n");
		sbSql.append("              0 AS COST_RATE,  -- 수식으로 해결 => 판매가가 0이 아닐 경우 ROUND((레시피원가/판매가)*100) \n");
		sbSql.append("              A.SALE_PRICE,    -- 판매가 \n");
		sbSql.append("              '' AS PREFER, \n");
		sbSql.append("              '' AS PREFER_LABEL, \n");
		sbSql.append("              A.RECIPE_CLASS, \n");
		sbSql.append("              A.RECIPE_TYPE, \n");
		sbSql.append("              A.CUISINE_TYPE, \n");
		sbSql.append("              A.PHF, \n");
		sbSql.append("              SUM(B.NEED_QTY) AS NEED_QTY, \n");
		sbSql.append("              CASE WHEN MONTHS_BETWEEN( SYSDATE, DECODE(A.CDATE, NULL, SYSDATE, A.CDATE) )<= 1.0 THEN 1 ELSE 0 END DI_MON, \n");
		sbSql.append("              A.SAME_WORD \n");
		sbSql.append("         FROM FMR_STD_RECIPE_MST A , \n");
		sbSql.append("              FMR_STD_RECIPE_ITEM B, \n");		
		sbSql.append("              (SELECT * FROM FMM_CHG_ITEM_LIST WHERE UPJANG = "+UPJANG+") C    	\n");
		
		sbSql.append("        WHERE A.RECIPE_CD = B.RECIPE_CD \n");
		sbSql.append("          AND B.ITEM_CODE = C.ITEM_CODE(+) \n");
		sbSql.append("          AND A.RECIPE_CLASS != 'H' \n");
		if(!RECIPE_NAME.equals(""))
		{
		//sbSql.append("          AND A.RECIPE_NAME LIKE '%'||'"+RECIPE_NAME+"'||'%' \n");
			String[] arrSameWord = RECIPE_NAME.split(" ");
			
			sbSql.append("  AND ( \n");
			for(int i=0; i<arrSameWord.length; i++) {
				sbSql.append("   A.SAME_WORD LIKE '%'||'"+arrSameWord[i]+"'||'%' \n");
				sbSql.append("OR A.RECIPE_NAME LIKE '%'||'"+arrSameWord[i]+"'||'%' \n");
				if(i < arrSameWord.length-1) {
					sbSql.append("  OR \n");
				}
			}
			sbSql.append("  ) \n");
		
		}
		if(!RECIPE_CLASS.equals(""))
		{
		sbSql.append("          AND A.RECIPE_CLASS = '"+RECIPE_CLASS+"' \n");
		}
		if(!RECIPE_TYPE.equals(""))
		{
		sbSql.append("          AND A.RECIPE_TYPE = '"+RECIPE_TYPE+"' \n");
		}
		if(STD_CHK.equals("0"))
		{
		sbSql.append("          AND to_char(A.CDATE,'yyyymmdd')='99999999'	-- 본사 레시피 미체크이면 데이타 없도록 \n");
		}
		sbSql.append("          GROUP BY A.RECIPE_CD, A.RECIPE_NAME, NVL(C.ITEM_CODE_TO,B.ITEM_CODE), A.SALE_PRICE, A.RECIPE_CLASS, A.RECIPE_TYPE, A.CUISINE_TYPE, A.PHF, A.CDATE, A.SAME_WORD \n");
		sbSql.append("        UNION ALL \n");
		sbSql.append("       SELECT '1' GUBUN,       --본사 \n");
		sbSql.append("              A.RECIPE_CD,     --레시피코드 \n");
		sbSql.append("              A.RECIPE_NAME,   --레시피명 \n");
		sbSql.append("              B.ITEM_CODE, \n");
		sbSql.append("              0 AS COST_RATE,  -- 수식으로 해결 => 판매가가 0이 아닐 경우 ROUND((레시피원가/판매가)*100) \n");
		sbSql.append("              A.SALE_PRICE,    -- 판매가 \n");
		sbSql.append("              '' AS PREFER, \n");
		sbSql.append("              '' AS PREFER_LABEL, \n");
		sbSql.append("              A.RECIPE_CLASS, \n");
		sbSql.append("              A.RECIPE_TYPE, \n");
		sbSql.append("              A.CUISINE_TYPE, \n");
		sbSql.append("              A.PHF, \n");
		sbSql.append("              B.NEED_QTY, \n");
		sbSql.append("              CASE WHEN MONTHS_BETWEEN( SYSDATE, DECODE(A.CDATE, NULL, SYSDATE, A.CDATE) )<= 1.0 THEN 1 ELSE 0 END DI_MON, \n");
		sbSql.append("              A.SAME_WORD \n");
		sbSql.append("         FROM FMM_STD_RECIPE_MST A , \n");
		sbSql.append("              FMM_STD_RECIPE_ITEM B \n");
		sbSql.append("        WHERE A.RECIPE_CD = B.RECIPE_CD \n");
		sbSql.append("          AND A.RECIPE_CLASS != 'H' \n");		
		sbSql.append("          AND A.UPJANG = "+UPJANG+" \n");
		if(!RECIPE_NAME.equals(""))
		{
		//sbSql.append("          AND A.RECIPE_NAME LIKE '%'||'"+RECIPE_NAME+"'||'%' \n");
			String[] arrSameWord = RECIPE_NAME.split(" ");
			
			sbSql.append("  AND ( \n");
			for(int i=0; i<arrSameWord.length; i++) {
				sbSql.append("   A.SAME_WORD LIKE '%'||'"+arrSameWord[i]+"'||'%' \n");
				sbSql.append("OR A.RECIPE_NAME LIKE '%'||'"+arrSameWord[i]+"'||'%' \n");
				if(i < arrSameWord.length-1) {
					sbSql.append("  OR \n");
				}
			}
			sbSql.append("  ) \n");
		}
		if(!RECIPE_CLASS.equals(""))
		{
		sbSql.append("          AND A.RECIPE_CLASS = '"+RECIPE_CLASS+"' \n");
		}
		if(!RECIPE_TYPE.equals(""))
		{
		sbSql.append("          AND A.RECIPE_TYPE = '"+RECIPE_TYPE+"' \n");
		}
		if(UPJANG_CHK.equals("0"))
		{
		sbSql.append("          AND to_char(A.CDATE,'yyyymmdd')='99999999'	-- 본사 레시피 미체크이면 데이타 없도록 \n");
		}
		sbSql.append("       ) A, \n");
		sbSql.append("       ( \n");

		sbSql.append("		SELECT \n");
		sbSql.append("			   A.UPJANG, A.ITEM_CODE, A.SALE_PRICE, A.KG_CONVERT_RATE, \n");
		sbSql.append("             NVL(NVL(C.OP_RATE, D.OP_RATE), 0) AS OP_RATE, --운영율 \n");
		sbSql.append("             CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
    	sbSql.append("                  THEN DECODE(SIGN(NVL(C.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE) \n");
    	sbSql.append("                  WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL \n");
    	sbSql.append("                  THEN DECODE(SIGN(NVL(D.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL), D.OP_PRICE) \n");
    	sbSql.append("             ELSE A.SALE_PRICE END AS OP_PRICE, --운영단가 \n");
    	sbSql.append("             CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
		sbSql.append("                  THEN DECODE(SIGN(NVL(C.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE) / A.KG_CONVERT_RATE / 1000 \n");
		sbSql.append("                  WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL \n");
		sbSql.append("                  THEN DECODE(SIGN(NVL(D.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL), D.OP_PRICE) / A.KG_CONVERT_RATE / 1000 \n");
		sbSql.append("             ELSE A.SALE_PRICE / A.KG_CONVERT_RATE / 1000 END AS G_ITEM_PRICE \n");
		sbSql.append("		   FROM	\n");
		sbSql.append("		      (	\n");
		sbSql.append("              SELECT \n");
		sbSql.append("              		"+UPJANG+" AS UPJANG, \n");
		sbSql.append("              		TO_CHAR(SYSDATE,'YYYYMMDD') AS NEED_DATE , \n");
		sbSql.append("                      A.ITEM_CODE, \n");
		sbSql.append("                      A.SALE_PRICE, \n");
		sbSql.append("                      B.ITEM_CLASS4, \n");
		sbSql.append("                      B.KG_CONVERT_RATE \n");
		sbSql.append("                 FROM HLDC_PO_CONTRACT_FSALE A, HLDC_PO_ITEM_MST B, HLDC_ST_UPJANG C \n");
		sbSql.append("                WHERE A.ITEM_CODE = B.ITEM_CODE \n");
		sbSql.append("                  AND A.UPJANG = C.AP_UNITPRICE_UPJANG \n");
		sbSql.append("                  AND C.UPJANG = "+UPJANG+" \n");
		sbSql.append("                  AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN A.CONTRACT_START AND NVL(A.CONTRACT_END, '99991231') \n");
		sbSql.append("                  AND A.SALE_PRICE > 0 \n");
		sbSql.append("                  AND A.USE_YN = 'Y' \n");
		sbSql.append("               ----------- \n");
		sbSql.append("                UNION ALL \n");
		sbSql.append("               ----------- \n");
		sbSql.append("               SELECT "+UPJANG+" AS UPJANG, TO_CHAR(SYSDATE,'YYYYMMDD') AS NEED_DATE, A.ITEM_CODE, A.SALE_PRICE, \n");
		sbSql.append("                      B.ITEM_CLASS4, B.KG_CONVERT_RATE \n");
		sbSql.append("                 FROM FMP_OTCUST_PRICE_AVA_V A, FMP_OTCUST_ITEM B, \n");
		sbSql.append("                      ( \n");
		sbSql.append("                      SELECT UPJANG, ITEM_CODE, MAX(SDATE) AS SDATE \n");
		sbSql.append("                        FROM FMP_OTCUST_PRICE_AVA_V \n");
		sbSql.append("                       WHERE UPJANG = \n");
		sbSql.append("                             ( \n");
		sbSql.append("                             SELECT OTCUST_PRICE_UPJANG \n");
		sbSql.append("                               FROM FMS_UPJANG \n");
		sbSql.append("                              WHERE UPJANG = "+UPJANG+" \n");
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
		sbSql.append("		       ) A,	\n");
		sbSql.append("             ( \n");        
		sbSql.append("             SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL \n");
		sbSql.append("               FROM FMU_OP_RATE \n");
		sbSql.append("              WHERE UPJANG = "+UPJANG+" \n");
		sbSql.append("                AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN SDATE AND EDATE \n");
		sbSql.append("                AND USE_YN = 'Y' \n");
		sbSql.append("                AND ITEM_TYPE = 'M' \n");
		sbSql.append("             ) C, \n");
		sbSql.append("             ( \n");        
		sbSql.append("             SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL \n");
		sbSql.append("               FROM FMU_OP_RATE \n");
		sbSql.append("              WHERE UPJANG = "+UPJANG+" \n");
		sbSql.append("                AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN SDATE AND EDATE \n");
		sbSql.append("                AND USE_YN = 'Y' \n");
		sbSql.append("                AND ITEM_TYPE = 'C' \n");
		sbSql.append("             ) D \n");
		sbSql.append("       WHERE A.ITEM_CODE = C.ITEM_CODE(+) \n");
		sbSql.append("         AND A.ITEM_CLASS4 = D.ITEM_CODE(+) \n");
		sbSql.append("       ) C \n");
		sbSql.append("      ,( \n");
		sbSql.append("		 SELECT ITEM_CODE, CAL, WATER, PROT, FAT, CARBO, FIBER, ASH, CA, P, FE, NA, K, VITA_A, RETIN, B_CAROT, THIA, RIBO, NIACIN, VITA_C, CHOLE, DISUSE_RATE \n");
		sbSql.append("		   FROM FMP_ITEM_NUT \n");
		sbSql.append("		  WHERE UPJANG = "+UPJANG+" \n");
		sbSql.append("		  UNION ALL \n");
		sbSql.append("		 SELECT A.ITEM_CODE, CAL, WATER, PROT, FAT, CARBO, FIBER, ASH, CA, P, FE, NA, K, VITA_A, RETIN, B_CAROT, THIA, RIBO, NIACIN, VITA_C, CHOLE, DISUSE_RATE \n");
		sbSql.append("		   FROM FSI_ITEM_NUT A,	\n");
		sbSql.append("			 (			\n");
		sbSql.append("			 SELECT	ITEM_CODE	\n");
		sbSql.append("			   FROM	FSI_ITEM_NUT MINUS	\n");
		sbSql.append("			 SELECT	ITEM_CODE	\n");
		sbSql.append("			   FROM	FMP_ITEM_NUT	\n");
		sbSql.append("			  WHERE	UPJANG = "+UPJANG+"	\n");
		sbSql.append("			 ) B			\n");
		sbSql.append("		WHERE A.ITEM_CODE = B.ITEM_CODE		\n");	
		sbSql.append("       ) F ---열량 \n");
		sbSql.append(" WHERE   A.ITEM_CODE = C.ITEM_CODE(+) \n");
		sbSql.append("   AND A.ITEM_CODE = F.ITEM_CODE(+) \n");
		sbSql.append(" GROUP BY A.GUBUN, \n");
		sbSql.append("       A.RECIPE_CD, \n");
		sbSql.append("       A.RECIPE_NAME, \n");
		sbSql.append("       COST_RATE, \n");
		sbSql.append("       PREFER, \n");
		sbSql.append("       PREFER_LABEL, \n");
		sbSql.append("       RECIPE_CLASS, \n");
		sbSql.append("       RECIPE_TYPE, \n");
		sbSql.append("       CUISINE_TYPE, \n");
		sbSql.append("       PHF, \n");
		sbSql.append("       DI_MON, \n");
		sbSql.append("       SAME_WORD \n");
		sbSql.append(" ORDER BY GUBUN DESC, \n");
		sbSql.append("       RECIPE_CD \n"); 
		
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 

		DataSet ds_subList = this.makeDataSet(rs,"ds_subList");
		out_dl.add(ds_subList);
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