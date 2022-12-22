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
	
		String RECIPE_NAME		= in_vl.getString("RECIPE_NAME");	
		String RECIPE_CLASS		= in_vl.getString("RECIPE_CLASS");	
		String RECIPE_TYPE		= in_vl.getString("RECIPE_TYPE");	
		String CUISINE_TYPE		= in_vl.getString("CUISINE_TYPE");	
		String MAIN_ITEM_CODE1	= in_vl.getString("MAIN_ITEM_CODE1");	
		String RESP_NUT1		= in_vl.getString("RESP_NUT1");	
		String CHKSTD			= in_vl.getString("CHKSTD");		
		String CHKUPJANG		= in_vl.getString("CHKUPJANG");	
		String UPJANG			= in_vl.getString("UPJANG");
	
		DataSet ds_out;
		StringBuffer sbSql = new StringBuffer();
		
		sbSql.append(" SELECT A.GBN,           A.UPJANG,          A.RECIPE_CD,       A.RECIPE_NAME,   A.RECIPE_CLASS,   A.RECIPE_TYPE, \n");
		sbSql.append("        A.CUISINE_TYPE,  trim(A.MAIN_ITEM_CODE1) MAIN_ITEM_CODE1, A.MAIN_ITEM_CODE2, A.COOK_TOOL1,    A.COOK_TOOL2,     A.RECIPE_COLOR, \n");
		sbSql.append("        A.RECIPE_SHAPE,  A.RECIPE_TASTE,    A.RECIPE_FEEL,     A.RECIPE_TEMPER, A.SPRING_YN,      A.SUMMER_YN, \n");
		sbSql.append("        A.AUTUMN_YN,     A.WINTER_YN,       trim(A.RESP_NUT1)  RESP_NUT1,       A.RESP_NUT2,     A.USE_TOOL,       A.VALID_TIME, \n");
		sbSql.append("        A.DISPLAY_METHOD,A.SALE_UOM,        A.SALE_PRICE,      A.COST_RATE,     A.CORE_TEMPER_YN, A.GOODS_FEATURE, \n");
		sbSql.append("        A.PHF_MGMT1,     A.PHF_MGMT2,       A.PHF_MGMT3,       A.PHF_MGMT4,     A.PHF_MGMT5,      A.COOK_OPRN, \n");
		sbSql.append("        A.PHOTO_PATH,    A.SPHOTO_PATH,     A.USE_YN,          A.CUSER,         A.NM_KOR,         TO_CHAR(A.CDATE,'yyyymmdd') CDATE, \n");
		sbSql.append("        A.UUSER,         TO_CHAR(A.UDATE,'yyyymmdd') UDATE,           A.PHF,             ROUND(SUM(NVL(B.G_ITEM_PRICE,0)*A.NEED_QTY )) RECIPE_WONGA \n");
		sbSql.append("  FROM \n");
		sbSql.append("       ( \n");
		sbSql.append("       --표준레시피 보기 \n");
		sbSql.append("       SELECT /*+ USE_HASH(A E) */ 0 AS GBN,        "+UPJANG+" AS UPJANG,  A.RECIPE_CD,       A.RECIPE_NAME,   A.RECIPE_CLASS,   A.RECIPE_TYPE, \n");
		sbSql.append("              A.CUISINE_TYPE,  A.MAIN_ITEM_CODE1, A.MAIN_ITEM_CODE2, A.COOK_TOOL1,    A.COOK_TOOL2,     A.RECIPE_COLOR, \n");
		sbSql.append("              A.RECIPE_SHAPE,  A.RECIPE_TASTE,    A.RECIPE_FEEL,     A.RECIPE_TEMPER, A.SPRING_YN,      A.SUMMER_YN, \n");
		sbSql.append("              A.AUTUMN_YN,     A.WINTER_YN,       A.RESP_NUT1,       A.RESP_NUT2,     A.USE_TOOL,       A.VALID_TIME, \n");
		sbSql.append("              A.DISPLAY_METHOD,A.SALE_UOM,        A.SALE_PRICE,      A.COST_RATE,     A.CORE_TEMPER_YN, A.GOODS_FEATURE, \n");
		sbSql.append("              A.PHF_MGMT1,     A.PHF_MGMT2,       A.PHF_MGMT3,       A.PHF_MGMT4,     A.PHF_MGMT5,      A.COOK_OPRN, \n");
		sbSql.append("              A.PHOTO_PATH,    A.SPHOTO_PATH,     A.USE_YN,          A.CUSER,         E.NM_KOR,         A.CDATE, \n");
		sbSql.append("              A.UUSER,         A.UDATE,           A.PHF,             B.ITEM_CODE,     B.NEED_QTY \n");
		sbSql.append("         FROM FMR_STD_RECIPE_MST A, \n");
		sbSql.append("              (                                                                                             				\n");
		sbSql.append("                  SELECT /*+ USE_HASH(A B C) */B.RECIPE_CD,NVL(C.ITEM_CODE, B.ITEM_CODE) ITEM_CODE,SUM(B.NEED_QTY) NEED_QTY				\n");
		sbSql.append("                  FROM   FMR_STD_RECIPE_MST A,                                                              				\n");
		sbSql.append("                         FMR_STD_RECIPE_ITEM B,                                                              				\n");
		sbSql.append("                         FMM_CHG_ITEM_LIST C                                                              				\n");
		sbSql.append("                  WHERE  A.RECIPE_CD = B.RECIPE_CD                                                          				\n");
		sbSql.append("                  AND  A.RECIPE_CLASS != 'H'                                                                  				\n");
		//sbSql.append("                  AND A.RECIPE_NAME LIKE '%'||'"+RECIPE_NAME+"'||'%'                                             				\n");
		sbSql.append("                  AND C.UPJANG(+) = '"+UPJANG+"'                                             				\n");
		sbSql.append("                  AND B.ITEM_CODE = C.ITEM_CODE(+)                                             				\n");
		sbSql.append("                  GROUP BY B.RECIPE_CD,NVL(C.ITEM_CODE, B.ITEM_CODE)                                				\n");
		sbSql.append("              ) B,                                                                                          				\n");
		sbSql.append("              SCC_USERINFO E \n");
		sbSql.append("        WHERE	A.RECIPE_CD = B.RECIPE_CD \n");
		sbSql.append("          AND A.RECIPE_CLASS != 'H' \n");
		sbSql.append("          AND A.CUSER= E.SABUN(+) \n");
		if(CHKSTD.equals("0"))
		{
			sbSql.append("          AND A.RECIPE_CD = 'AAAAAA'   --표준레시피 미조회시  \n");
		}
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
		sbSql.append("          AND A.RECIPE_CLASS='"+RECIPE_CLASS+"' \n");
		}
		if(!RECIPE_TYPE.equals(""))
		{
		sbSql.append("          AND A.RECIPE_TYPE='"+RECIPE_TYPE+"' \n");
		}
		if(!CUISINE_TYPE.equals(""))
		{
		sbSql.append("          AND A.CUISINE_TYPE='"+CUISINE_TYPE+"' \n");
		}
		if(!MAIN_ITEM_CODE1.equals(""))
		{
		sbSql.append("          AND A.MAIN_ITEM_CODE1 ='"+MAIN_ITEM_CODE1+"' \n");
		}
		if(!RESP_NUT1.equals(""))
		{
		sbSql.append("          AND A.RESP_NUT1 ='"+RESP_NUT1+"' \n");
		}
		sbSql.append("        UNION \n");
		sbSql.append("       --본사표준레시피 보기 \n");
		sbSql.append("       SELECT 1 AS GBN,        A.UPJANG,          A.RECIPE_CD,       A.RECIPE_NAME,   A.RECIPE_CLASS,   A.RECIPE_TYPE, \n");
		sbSql.append("              A.CUISINE_TYPE,  A.MAIN_ITEM_CODE1, A.MAIN_ITEM_CODE2, A.COOK_TOOL1,    A.COOK_TOOL2,     A.RECIPE_COLOR, \n");
		sbSql.append("              A.RECIPE_SHAPE,  A.RECIPE_TASTE,    A.RECIPE_FEEL,     A.RECIPE_TEMPER, A.SPRING_YN,      A.SUMMER_YN, \n");
		sbSql.append("              A.AUTUMN_YN,     A.WINTER_YN,       A.RESP_NUT1,       A.RESP_NUT2,     A.USE_TOOL,       A.VALID_TIME, \n");
		sbSql.append("              A.DISPLAY_METHOD,A.SALE_UOM,        A.SALE_PRICE,      A.COST_RATE,     A.CORE_TEMPER_YN, A.GOODS_FEATURE, \n");
		sbSql.append("              A.PHF_MGMT1,     A.PHF_MGMT2,       A.PHF_MGMT3,       A.PHF_MGMT4,     A.PHF_MGMT5,      A.COOK_OPRN, \n");
		sbSql.append("              A.PHOTO_PATH,    A.SPHOTO_PATH,     A.USE_YN,          A.CUSER,         E.NM_KOR,         A.CDATE, \n");
		sbSql.append("              A.UUSER,         A.UDATE,           A.PHF,             B.ITEM_CODE,     B.NEED_QTY \n");
		sbSql.append("         FROM	FMM_STD_RECIPE_MST A , \n");
		sbSql.append("              FMM_STD_RECIPE_ITEM B , \n");
		sbSql.append("              SCC_USERINFO E \n");
		sbSql.append("        WHERE	A.RECIPE_CD = B.RECIPE_CD \n");
		sbSql.append("          AND A.RECIPE_CLASS != 'H' \n");
		sbSql.append("          AND A.UPJANG=B.UPJANG \n");
		sbSql.append("          AND A.CUSER= E.SABUN(+) \n");
		if(CHKUPJANG.equals("0"))
		{
			sbSql.append("          AND A.RECIPE_CD = 'AAAAAA'   --본사 표준레시피 미조회시  \n");
		}
		if(!UPJANG.equals(""))
		{
		sbSql.append("          AND A.UPJANG = "+UPJANG+" \n");
		}
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
		sbSql.append("          AND A.RECIPE_CLASS='"+RECIPE_CLASS+"' \n");
		}
		if(!RECIPE_TYPE.equals(""))
		{
		sbSql.append("          AND A.RECIPE_TYPE='"+RECIPE_TYPE+"' \n");
		}
		if(!CUISINE_TYPE.equals(""))
		{
		sbSql.append("          AND A.CUISINE_TYPE='"+CUISINE_TYPE+"' \n");
		}
		if(!MAIN_ITEM_CODE1.equals(""))
		{
		sbSql.append("          AND A.MAIN_ITEM_CODE1 ='"+MAIN_ITEM_CODE1+"' \n");
		}
		if(!RESP_NUT1.equals(""))
		{
		sbSql.append("          AND A.RESP_NUT1 ='"+RESP_NUT1+"' \n");
		}
		sbSql.append("       ) A, \n");
		sbSql.append("       ( \n");
		sbSql.append("        SELECT \n");
		sbSql.append("               A.UPJANG, A.ITEM_CODE, A.SALE_PRICE, KG_CONVERT_RATE,                  \n");
		sbSql.append("               CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL              \n");
		sbSql.append("                    THEN DECODE(SIGN(NVL(C.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE) / A.KG_CONVERT_RATE / 1000 \n");
		sbSql.append("                    WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL              \n");
		sbSql.append("                    THEN DECODE(SIGN(NVL(D.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL), D.OP_PRICE) / A.KG_CONVERT_RATE / 1000 \n");
		sbSql.append("                    ELSE A.SALE_PRICE / A.KG_CONVERT_RATE / 1000 END AS G_ITEM_PRICE                                        \n");
		
		sbSql.append("          FROM \n");
		sbSql.append("              ( \n");		
		sbSql.append("              SELECT 	/*+ LEADING(C A B) USE_NL(B) */\n");
		sbSql.append("              		"+UPJANG+" AS UPJANG, \n");
		sbSql.append("              		TO_CHAR(SYSDATE,'YYYYMMDD') AS NEED_DATE , \n");
		sbSql.append("                      A.ITEM_CODE, \n");
		sbSql.append("                      A.SALE_PRICE, \n");
		sbSql.append("                      B.ITEM_CLASS4, \n");
		sbSql.append("                      B.KG_CONVERT_RATE \n");
		sbSql.append("               FROM   HLDC_PO_CONTRACT_FSALE A, HLDC_PO_ITEM_MST B, HLDC_ST_UPJANG C \n");
		sbSql.append("               WHERE  A.ITEM_CODE = B.ITEM_CODE \n");
		sbSql.append("               AND    A.UPJANG = C.AP_UNITPRICE_UPJANG \n");
		sbSql.append("               AND    C.UPJANG = "+UPJANG+" \n");
		sbSql.append("               AND    TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN A.CONTRACT_START AND NVL(A.CONTRACT_END, '99999999') \n");
		sbSql.append("               AND    A.SALE_PRICE > 0 \n");
		sbSql.append("               AND    A.USE_YN = 'Y' \n");
		sbSql.append("             ----------- \n");
		sbSql.append("              UNION ALL \n");
		sbSql.append("             ----------- \n");
		sbSql.append("             SELECT "+UPJANG+" AS UPJANG, TO_CHAR(SYSDATE,'YYYYMMDD') AS NEED_DATE, A.ITEM_CODE, A.SALE_PRICE, \n");
		sbSql.append("                      B.ITEM_CLASS4, B.KG_CONVERT_RATE \n");
		sbSql.append("               FROM FMP_OTCUST_PRICE_AVA_V A, FMP_OTCUST_ITEM B, \n");
		sbSql.append("                    ( \n");
		sbSql.append("                    SELECT UPJANG, ITEM_CODE, MAX(SDATE) AS SDATE \n");
		sbSql.append("                      FROM FMP_OTCUST_PRICE_AVA_V \n");
		sbSql.append("                     WHERE UPJANG = \n");
		sbSql.append("                           ( \n");
		sbSql.append("                           SELECT OTCUST_PRICE_UPJANG \n");
		sbSql.append("                             FROM FMS_UPJANG \n");
		sbSql.append("                            WHERE UPJANG = "+UPJANG+" \n");
		sbSql.append("                           ) \n");
		sbSql.append("                       AND SDATE <= TO_CHAR(SYSDATE,'YYYYMMDD') \n");
		sbSql.append("                     GROUP BY UPJANG, ITEM_CODE \n");
		sbSql.append("                    ) C \n");
		sbSql.append("              WHERE A.ITEM_CODE = B.ITEM_CODE \n");
		sbSql.append("                AND A.UPJANG = C.UPJANG \n");
		sbSql.append("                AND A.SDATE = C.SDATE \n");
		sbSql.append("                AND A.ITEM_CODE = C.ITEM_CODE \n");
		sbSql.append("                AND A.SDATE = C.SDATE \n");
		sbSql.append("                AND A.SALE_PRICE > 0 \n");
		sbSql.append("                AND A.USE_YN = 'Y' \n");
		sbSql.append("             ) A, \n");
		
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
		
		sbSql.append("      WHERE A.ITEM_CODE = C.ITEM_CODE(+) \n");
		sbSql.append("        AND A.ITEM_CLASS4 = D.ITEM_CODE(+) \n");
		
		sbSql.append("     ) B \n");
		sbSql.append(" WHERE A.ITEM_CODE = B.ITEM_CODE(+) \n");
		sbSql.append(" GROUP BY A.GBN,        A.UPJANG,          A.RECIPE_CD,       A.RECIPE_NAME,   A.RECIPE_CLASS,   A.RECIPE_TYPE, \n");
		sbSql.append("       A.CUISINE_TYPE,  A.MAIN_ITEM_CODE1, A.MAIN_ITEM_CODE2, A.COOK_TOOL1,    A.COOK_TOOL2,     A.RECIPE_COLOR, \n");
		sbSql.append("       A.RECIPE_SHAPE,  A.RECIPE_TASTE,    A.RECIPE_FEEL,     A.RECIPE_TEMPER, A.SPRING_YN,      A.SUMMER_YN, \n");
		sbSql.append("       A.AUTUMN_YN,     A.WINTER_YN,       A.RESP_NUT1,       A.RESP_NUT2,     A.USE_TOOL,       A.VALID_TIME, \n");
		sbSql.append("       A.DISPLAY_METHOD,A.SALE_UOM,        A.SALE_PRICE,      A.COST_RATE,     A.CORE_TEMPER_YN, A.GOODS_FEATURE, \n");
		sbSql.append("       A.PHF_MGMT1,     A.PHF_MGMT2,       A.PHF_MGMT3,       A.PHF_MGMT4,     A.PHF_MGMT5,      A.COOK_OPRN, \n");
		sbSql.append("       A.PHOTO_PATH,    A.SPHOTO_PATH,     A.USE_YN,          A.CUSER,         A.NM_KOR,         A.CDATE, \n");
		sbSql.append("       A.UUSER,         A.UDATE,           A.PHF \n");
		
		sbSql.append(" ORDER BY A.GBN, A.UPJANG, A.RECIPE_CD, A.RECIPE_NAME, A.RECIPE_CLASS, A.RECIPE_TYPE \n");
		
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 

		DataSet ds_MainRecipeList = this.makeDataSet(rs,"ds_MainRecipeList");
		out_dl.add(ds_MainRecipeList);
		
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
		
	//	String v_EmpNo 		= in_vl.getString("g_EmpNo");	
	//	DataSet in_ds  =  in_dl.get("ds_Input");
	//	String sCode = in_ds.getString(0, "CD");
	// 	System.out.println("==>FMM00010E_S007 \n");
	
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));
	
		String RECIPE_NAME		= in_vl.getString("RECIPE_NAME");	
		String RECIPE_CLASS		= in_vl.getString("RECIPE_CLASS");	
		String RECIPE_TYPE		= in_vl.getString("RECIPE_TYPE");	
		String CUISINE_TYPE		= in_vl.getString("CUISINE_TYPE");	
		String MAIN_ITEM_CODE1	= in_vl.getString("MAIN_ITEM_CODE1");	
		String RESP_NUT1		= in_vl.getString("RESP_NUT1");	
		String CHKSTD			= in_vl.getString("CHKSTD");		
		String CHKUPJANG		= in_vl.getString("CHKUPJANG");	
		String UPJANG			= in_vl.getString("UPJANG");
			
	//	if(conn != null && !conn.isClosed()) conn.close();
		
	//	conn = getIRISConn();
	
	
		DataSet ds_out;
		StringBuffer sbSql = new StringBuffer();
		
		//운영율 설정조회
		sbSql.delete(0, sbSql.length());
		sbSql.append("SELECT FMS_OPRATEINFO_FUN('" + UPJANG + "') AS OP_LEN FROM DUAL \n");
		pstmt = conn.prepareStatement(sbSql.toString());		                                                                                                                                                
		rs = pstmt.executeQuery();
		rs.next();
		String strOpLen = rs.getString("OP_LEN");
		rs.close();
		pstmt.close();

		sbSql.delete(0, sbSql.length());
		sbSql.append(" SELECT A.GBN,           A.UPJANG,          A.RECIPE_CD,       A.RECIPE_NAME,   A.RECIPE_CLASS,   A.RECIPE_TYPE, \n");
		sbSql.append("       A.CUISINE_TYPE,  trim(A.MAIN_ITEM_CODE1) MAIN_ITEM_CODE1, A.MAIN_ITEM_CODE2, A.COOK_TOOL1,    A.COOK_TOOL2,     A.RECIPE_COLOR, \n");
		sbSql.append("       A.RECIPE_SHAPE,  A.RECIPE_TASTE,    A.RECIPE_FEEL,     A.RECIPE_TEMPER, A.SPRING_YN,      A.SUMMER_YN, \n");
		sbSql.append("       A.AUTUMN_YN,     A.WINTER_YN,       trim(A.RESP_NUT1)  RESP_NUT1,       A.RESP_NUT2,     A.USE_TOOL,       A.VALID_TIME, \n");
		sbSql.append("       A.DISPLAY_METHOD,A.SALE_UOM,        A.SALE_PRICE,      A.COST_RATE,     A.CORE_TEMPER_YN, A.GOODS_FEATURE, \n");
		sbSql.append("       A.PHF_MGMT1,     A.PHF_MGMT2,       A.PHF_MGMT3,       A.PHF_MGMT4,     A.PHF_MGMT5,      A.COOK_OPRN, \n");
		sbSql.append("       A.PHOTO_PATH,    A.SPHOTO_PATH,     A.USE_YN,          A.CUSER,         A.NM_KOR,         TO_CHAR(A.CDATE,'yyyymmdd') CDATE, \n");
		sbSql.append("       A.UUSER,         TO_CHAR(A.UDATE,'yyyymmdd') UDATE,           A.PHF,             ROUND(SUM(NVL(B.G_ITEM_PRICE,0)*A.NEED_QTY )) RECIPE_WONGA \n");
		sbSql.append("  FROM \n");
		sbSql.append("       ( \n");
		sbSql.append("       --표준레시피 보기 \n");
		sbSql.append("       SELECT 0 AS GBN,        "+UPJANG+" AS UPJANG,  A.RECIPE_CD,       A.RECIPE_NAME,   A.RECIPE_CLASS,   A.RECIPE_TYPE, \n");
		sbSql.append("              A.CUISINE_TYPE,  A.MAIN_ITEM_CODE1, A.MAIN_ITEM_CODE2, A.COOK_TOOL1,    A.COOK_TOOL2,     A.RECIPE_COLOR, \n");
		sbSql.append("              A.RECIPE_SHAPE,  A.RECIPE_TASTE,    A.RECIPE_FEEL,     A.RECIPE_TEMPER, A.SPRING_YN,      A.SUMMER_YN, \n");
		sbSql.append("              A.AUTUMN_YN,     A.WINTER_YN,       A.RESP_NUT1,       A.RESP_NUT2,     A.USE_TOOL,       A.VALID_TIME, \n");
		sbSql.append("              A.DISPLAY_METHOD,A.SALE_UOM,        A.SALE_PRICE,      A.COST_RATE,     A.CORE_TEMPER_YN, A.GOODS_FEATURE, \n");
		sbSql.append("              A.PHF_MGMT1,     A.PHF_MGMT2,       A.PHF_MGMT3,       A.PHF_MGMT4,     A.PHF_MGMT5,      A.COOK_OPRN, \n");
		sbSql.append("              A.PHOTO_PATH,    A.SPHOTO_PATH,     A.USE_YN,          A.CUSER,         E.NM_KOR,         A.CDATE, \n");
		sbSql.append("              A.UUSER,         A.UDATE,           A.PHF,             B.ITEM_CODE,     B.NEED_QTY \n");
		sbSql.append("         FROM FSR_STD_RECIPE_MST A , \n");
		
		sbSql.append("              (                                                                                             				\n");
		
		sbSql.append("                  SELECT B.RECIPE_CD,NVL(C.ITEM_CODE, B.ITEM_CODE) ITEM_CODE,SUM(B.NEED_QTY) NEED_QTY				\n");
		sbSql.append("                  FROM   FSR_STD_RECIPE_MST A,                                                              				\n");
		sbSql.append("                         FSR_STD_RECIPE_ITEM B,                                                              				\n");
		sbSql.append("                         FMM_CHG_ITEM_LIST C                                                              				\n");
		sbSql.append("                  WHERE  A.RECIPE_CD = B.RECIPE_CD                                                          				\n");
		sbSql.append("                  AND  A.RECIPE_CLASS<>'H'                                                                  				\n");
		sbSql.append("                  AND A.RECIPE_NAME LIKE '%'||'"+RECIPE_NAME+"'||'%'                                             				\n");
		sbSql.append("                  AND C.UPJANG(+) = '"+UPJANG+"'                                             				\n");
		sbSql.append("                  AND B.ITEM_CODE = C.ITEM_CODE(+)                                             				\n");
		sbSql.append("                  GROUP BY B.RECIPE_CD,NVL(C.ITEM_CODE, B.ITEM_CODE)                                				\n");
		
		//sbSql.append("                  SELECT B.RECIPE_CD,FMM_CHGITEM_FUN("+UPJANG+", B.ITEM_CODE) ITEM_CODE,SUM(B.NEED_QTY) NEED_QTY				\n");
		//sbSql.append("                  FROM   FSR_STD_RECIPE_MST A,                                                              				\n");
		//sbSql.append("                         FSR_STD_RECIPE_ITEM B                                                              				\n");
		//sbSql.append("                  WHERE  A.RECIPE_CD = B.RECIPE_CD                                                          				\n");
		//sbSql.append("                  AND  A.RECIPE_CLASS<>'H'                                                                  				\n");
		//sbSql.append("                  AND A.RECIPE_NAME LIKE '%'||'"+RECIPE_NAME+"'||'%'                                             				\n");
		//sbSql.append("                  GROUP BY B.RECIPE_CD,FMM_CHGITEM_FUN("+UPJANG+", B.ITEM_CODE)                                 				\n");
		
		
		
		
		sbSql.append("              ) B,                                                                                          				\n");
		
		sbSql.append("              SCC_USERINFO E \n");
		sbSql.append("        WHERE	A.RECIPE_CD = B.RECIPE_CD \n");
		sbSql.append("          AND A.RECIPE_CLASS !='H' \n");
		sbSql.append("          AND A.CUSER= E.SABUN(+) \n");
		if(CHKSTD.equals("0"))
		{
			sbSql.append("          AND A.RECIPE_CD = 'AAAAAA'   --표준레시피 미조회시  \n");
		}
		if(!RECIPE_NAME.equals(""))
		{
		sbSql.append("          AND A.RECIPE_NAME LIKE '%'||'"+RECIPE_NAME+"'||'%' \n");
		}
		if(!RECIPE_CLASS.equals(""))
		{
		sbSql.append("          AND A.RECIPE_CLASS='"+RECIPE_CLASS+"' \n");
		}
		if(!RECIPE_TYPE.equals(""))
		{
		sbSql.append("          AND A.RECIPE_TYPE='"+RECIPE_TYPE+"' \n");
		}
		if(!CUISINE_TYPE.equals(""))
		{
		sbSql.append("          AND A.CUISINE_TYPE='"+CUISINE_TYPE+"' \n");
		}
		if(!MAIN_ITEM_CODE1.equals(""))
		{
		sbSql.append("          AND A.MAIN_ITEM_CODE1 ='"+MAIN_ITEM_CODE1+"' \n");
		}
		if(!RESP_NUT1.equals(""))
		{
		sbSql.append("          AND A.RESP_NUT1 ='"+RESP_NUT1+"' \n");
		}
		sbSql.append("        UNION ALL \n");
		sbSql.append("       --본사표준레시피 보기 \n");
		sbSql.append("       SELECT 1 AS GBN,        A.UPJANG,          A.RECIPE_CD,       A.RECIPE_NAME,   A.RECIPE_CLASS,   A.RECIPE_TYPE, \n");
		sbSql.append("              A.CUISINE_TYPE,  A.MAIN_ITEM_CODE1, A.MAIN_ITEM_CODE2, A.COOK_TOOL1,    A.COOK_TOOL2,     A.RECIPE_COLOR, \n");
		sbSql.append("              A.RECIPE_SHAPE,  A.RECIPE_TASTE,    A.RECIPE_FEEL,     A.RECIPE_TEMPER, A.SPRING_YN,      A.SUMMER_YN, \n");
		sbSql.append("              A.AUTUMN_YN,     A.WINTER_YN,       A.RESP_NUT1,       A.RESP_NUT2,     A.USE_TOOL,       A.VALID_TIME, \n");
		sbSql.append("              A.DISPLAY_METHOD,A.SALE_UOM,        A.SALE_PRICE,      A.COST_RATE,     A.CORE_TEMPER_YN, A.GOODS_FEATURE, \n");
		sbSql.append("              A.PHF_MGMT1,     A.PHF_MGMT2,       A.PHF_MGMT3,       A.PHF_MGMT4,     A.PHF_MGMT5,      A.COOK_OPRN, \n");
		sbSql.append("              A.PHOTO_PATH,    A.SPHOTO_PATH,     A.USE_YN,          A.CUSER,         E.NM_KOR,         A.CDATE, \n");
		sbSql.append("              A.UUSER,         A.UDATE,           A.PHF,             B.ITEM_CODE,     B.NEED_QTY \n");
		sbSql.append("         FROM	FMM_STD_RECIPE_MST A , \n");
		sbSql.append("              FMM_STD_RECIPE_ITEM B , \n");
		sbSql.append("              SCC_USERINFO E \n");
		sbSql.append("        WHERE	A.RECIPE_CD = B.RECIPE_CD \n");
		sbSql.append("          AND A.RECIPE_CLASS !='H' \n");
		sbSql.append("          AND A.UPJANG=B.UPJANG \n");
		sbSql.append("          AND A.CUSER= E.SABUN(+) \n");
		if(CHKUPJANG.equals("0"))
		{
			sbSql.append("          AND A.RECIPE_CD = 'AAAAAA'   --본사 표준레시피 미조회시  \n");
		}
		if(!UPJANG.equals(""))
		{
		sbSql.append("          AND A.UPJANG = "+UPJANG+" \n");
		}
		if(!RECIPE_NAME.equals(""))
		{
		sbSql.append("          AND A.RECIPE_NAME LIKE '%'||'"+RECIPE_NAME+"'||'%' \n");
		}
		if(!RECIPE_CLASS.equals(""))
		{
		sbSql.append("          AND A.RECIPE_CLASS='"+RECIPE_CLASS+"' \n");
		}
		if(!RECIPE_TYPE.equals(""))
		{
		sbSql.append("          AND A.RECIPE_TYPE='"+RECIPE_TYPE+"' \n");
		}
		if(!CUISINE_TYPE.equals(""))
		{
		sbSql.append("          AND A.CUISINE_TYPE='"+CUISINE_TYPE+"' \n");
		}
		if(!MAIN_ITEM_CODE1.equals(""))
		{
		sbSql.append("          AND A.MAIN_ITEM_CODE1 ='"+MAIN_ITEM_CODE1+"' \n");
		}
		if(!RESP_NUT1.equals(""))
		{
		sbSql.append("          AND A.RESP_NUT1 ='"+RESP_NUT1+"' \n");
		}
		sbSql.append("       ) A, \n");
		sbSql.append("       ( \n");
		sbSql.append("        SELECT /*+-- ORDERED USE_HASH (A B) */ \n");
		sbSql.append("               A.UPJANG, A.ITEM_CODE, A.SALE_PRICE, NVL(C.OP_RATE,0) AS OP_RATE, KG_CONVERT_RATE,                  --운영율 \n");
		sbSql.append("               DECODE(SIGN(NVL(C.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE) AS OP_PRICE, --운영단가(1인원가) \n");
		sbSql.append("               DECODE(SIGN(NVL(C.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE) / B.KG_CONVERT_RATE / 1000 AS G_ITEM_PRICE  --G당단가 \n");
		sbSql.append("          FROM \n");
		sbSql.append("              ( \n");		
		sbSql.append("              SELECT 	/*+ INDEX(A PO_CONTRACT_FSALE_I2) */ \n");
		sbSql.append("              		"+UPJANG+" AS UPJANG, \n");
		sbSql.append("              		TO_CHAR(SYSDATE,'YYYYMMDD') AS NEED_DATE , \n");
		sbSql.append("                      A.ITEM_CODE, \n");
		sbSql.append("                      A.SALE_PRICE \n");
		sbSql.append("               FROM   HLDC_PO_CONTRACT_FSALE A \n");
		sbSql.append("               WHERE  A.CENTER_CODE = (SELECT A.CENTER_CODE \n");
		sbSql.append("                       				FROM   HLDC_PO_UPJANG_CENTER A, \n");
		sbSql.append("                              				HLDC_ST_UPJANG B \n");
		sbSql.append("                       				WHERE  A.UPJANG = B.AP_UNITPRICE_UPJANG \n");
		sbSql.append("                       				AND    B.UPJANG = "+UPJANG+") \n");
		sbSql.append("               AND    A.UPJANG = (SELECT AP_UNITPRICE_UPJANG \n");
		sbSql.append("                       			FROM   HLDC_ST_UPJANG \n");
		sbSql.append("                       			WHERE  UPJANG = "+UPJANG+" ) \n");
		sbSql.append("               AND    A.ITEM_CODE > ' ' \n");
		sbSql.append("               AND    TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN A.CONTRACT_START AND NVL(A.CONTRACT_END, '99999999') \n");
		sbSql.append("               AND    A.SALE_PRICE > 0 \n");
		sbSql.append("               AND    A.USE_YN = 'Y' \n");
		sbSql.append("               AND    EXISTS (SELECT 1 \n");
		sbSql.append("                       		FROM   HLDC_PO_TREAT_UPJANG X \n");
		sbSql.append("                       		WHERE  X.ITEM_CODE = A.ITEM_CODE \n");
		sbSql.append("                       		AND    X.UPJANG = A.UPJANG)		 \n");		
		sbSql.append("             ----------- \n");
		sbSql.append("              UNION ALL \n");
		sbSql.append("             ----------- \n");
		sbSql.append("             SELECT "+UPJANG+" AS UPJANG, TO_CHAR(SYSDATE,'YYYYMMDD') AS NEED_DATE, A.ITEM_CODE, A.SALE_PRICE \n");
		sbSql.append("               FROM FMP_OTCUST_PRICE_AVA_V A , \n");
		sbSql.append("                    ( \n");
		sbSql.append("                    SELECT UPJANG, ITEM_CODE, MAX(SDATE) AS SDATE \n");
		sbSql.append("                      FROM FMP_OTCUST_PRICE_AVA_V \n");
		sbSql.append("                     WHERE UPJANG = \n");
		sbSql.append("                           ( \n");
		sbSql.append("                           SELECT OTCUST_PRICE_UPJANG \n");
		sbSql.append("                             FROM FMS_UPJANG \n");
		sbSql.append("                            WHERE UPJANG = "+UPJANG+" \n");
		sbSql.append("                           ) \n");
		sbSql.append("                       AND SDATE <= TO_CHAR(SYSDATE,'YYYYMMDD') \n");
		sbSql.append("                     GROUP BY UPJANG, ITEM_CODE \n");
		sbSql.append("                    ) B \n");
		sbSql.append("              WHERE A.UPJANG = B.UPJANG \n");
		sbSql.append("                AND A.SDATE = B.SDATE \n");
		sbSql.append("                AND A.ITEM_CODE = B.ITEM_CODE \n");
		sbSql.append("                AND A.SALE_PRICE > 0 \n");
		sbSql.append("                AND A.USE_YN = 'Y' \n");
		sbSql.append("             ) A, \n");
		sbSql.append("             FMS_ITEM_V B, \n");
		sbSql.append("             ( \n");        
		sbSql.append("             SELECT A.ITEM_CODE, OP_RATE, OP_PRICE, A.CEIL_VAL \n");
		sbSql.append("               FROM FMU_OP_RATE A \n");
		sbSql.append("              WHERE UPJANG = "+UPJANG+" \n");
		sbSql.append("                AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN SDATE AND EDATE \n");
		sbSql.append("                AND A.USE_YN = 'Y' \n");
		sbSql.append("             ) C \n");
//		sbSql.append("        WHERE A.ITEM_CODE BETWEEN C.ITEM_CODE(+) AND C.ITEM_CODE(+)||'9999' \n");
		sbSql.append("      WHERE SUBSTR(A.ITEM_CODE,1," + strOpLen + ") = C.ITEM_CODE(+) \n");
		sbSql.append("          AND A.ITEM_CODE = B.ITEM_CODE \n");
		sbSql.append("     ) B \n");
		sbSql.append(" WHERE A.ITEM_CODE = B.ITEM_CODE(+) \n");
		sbSql.append(" GROUP BY A.GBN,        A.UPJANG,          A.RECIPE_CD,       A.RECIPE_NAME,   A.RECIPE_CLASS,   A.RECIPE_TYPE, \n");
		sbSql.append("       A.CUISINE_TYPE,  A.MAIN_ITEM_CODE1, A.MAIN_ITEM_CODE2, A.COOK_TOOL1,    A.COOK_TOOL2,     A.RECIPE_COLOR, \n");
		sbSql.append("       A.RECIPE_SHAPE,  A.RECIPE_TASTE,    A.RECIPE_FEEL,     A.RECIPE_TEMPER, A.SPRING_YN,      A.SUMMER_YN, \n");
		sbSql.append("       A.AUTUMN_YN,     A.WINTER_YN,       A.RESP_NUT1,       A.RESP_NUT2,     A.USE_TOOL,       A.VALID_TIME, \n");
		sbSql.append("       A.DISPLAY_METHOD,A.SALE_UOM,        A.SALE_PRICE,      A.COST_RATE,     A.CORE_TEMPER_YN, A.GOODS_FEATURE, \n");
		sbSql.append("       A.PHF_MGMT1,     A.PHF_MGMT2,       A.PHF_MGMT3,       A.PHF_MGMT4,     A.PHF_MGMT5,      A.COOK_OPRN, \n");
		sbSql.append("       A.PHOTO_PATH,    A.SPHOTO_PATH,     A.USE_YN,          A.CUSER,         A.NM_KOR,         A.CDATE, \n");
		sbSql.append("       A.UUSER,         A.UDATE,           A.PHF \n");
		
		//System.out.println(sbSql);
		
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 

		DataSet ds_MainRecipeList = this.makeDataSet(rs,"ds_MainRecipeList");
		out_dl.add(ds_MainRecipeList);
		
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