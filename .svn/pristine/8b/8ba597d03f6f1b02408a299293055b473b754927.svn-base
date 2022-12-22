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
		String RECIPE_CD		= in_vl.getString("RECIPE_CD");	
		String UPJANG			= in_vl.getString("UPJANG");
			
		DataSet ds_out;
		StringBuffer sbSql = new StringBuffer();
		
		sbSql.append("SELECT \n");
		sbSql.append("       AA.UPJANG, \n");
		sbSql.append("       AA.RECIPE_CD,             --레시피코드 \n");
		sbSql.append("       AA.ITEM_SEQ,              --자재순번 \n");
		sbSql.append("       AA.ITEM_CODE,             --레시피명 \n");
		sbSql.append("       AA.ITEM_NAME,             --자재명 \n");
		sbSql.append("       AA.ITEM_SIZE,             --규격 \n");
		sbSql.append("       AA.PO_UOM,                --구매단위 \n");
		sbSql.append("       FMS_ITEM_FEATURE_FUN("+UPJANG+", TO_CHAR(SYSDATE, 'YYYYMMDD'), AA.ITEM_CODE, 'N') AS FEATURE_NAME,          --자재특성 \n");
		sbSql.append("       AA.NEED_QTY,              --1인소요량 \n");
		sbSql.append("       CC.OP_PRICE MARGIN_PRICE, --구매단가 \n");
		sbSql.append("       NVL(BB.DISUSE_RATE,0) DISUSE_RATE,           --페기율 \n");
		sbSql.append("       AA.CUT_SPEC,              --커팅규격 \n");
		sbSql.append("       NVL(BB.CAL,0) CAL,                   --100G당 에너지 \n");
		sbSql.append("       DECODE(NVL(CC.OP_PRICE,0) ,0, 'Y' , 'N' ) RESTRICT_YN,   --상태 \n");
		sbSql.append("       ROUND(AA.NEED_QTY*(100-NVL(BB.DISUSE_RATE,0))/100,2) EDIBLE_QTY,--가식부량 \n");
		sbSql.append("       CASE WHEN NVL(AA.KG_CONVERT_RATE,0)=0 THEN 0 ELSE ROUND(AA.NEED_QTY * (NVL(CC.OP_PRICE,0) / AA.KG_CONVERT_RATE / 1000) ) END PERSON_PRICE, --1인원가 \n");
		sbSql.append("       ROUND( NVL(BB.CAL,0) * ROUND(AA.NEED_QTY*(100-NVL(BB.DISUSE_RATE,0))/100,2) / 100,2) CAL_CALC, --가식부량에 대한 에너지 \n");
		sbSql.append("       CASE WHEN NVL(AA.KG_CONVERT_RATE,0)=0 THEN 0 ELSE ROUND(NVL(CC.OP_PRICE,0) / AA.KG_CONVERT_RATE / 1000,2) END GRAM_PRICE, --G당 단가 \n");
		sbSql.append("       AA.ORIGIN_TYPE, --원산지 \n");
		sbSql.append("       AA.ITEM_CLASS1, AA.ITEM_CLASS2, AA.ITEM_CLASS3, AA.ITEM_CLASS4 \n");
		sbSql.append("  FROM (SELECT /*+ INDEX(A FMM_STD_RECIPE_ITEM_PK) */  \n");
	    sbSql.append("               A.*, B.ITEM_NAME, B.ITEM_SIZE, B.PO_UOM, B.KG_CONVERT_RATE, B.ORIGIN_TYPE, \n");
	    sbSql.append("               B.ITEM_CLASS1, B.ITEM_CLASS2, B.ITEM_CLASS3, B.ITEM_CLASS4 \n");  
	    sbSql.append("          FROM FMM_STD_RECIPE_ITEM A, FMS_ITEM_V B \n"); 
	    sbSql.append("         WHERE A.ITEM_CODE = B.ITEM_CODE \n"); 
	    sbSql.append("        ) AA, \n"); 
		sbSql.append("       ( \n");
		sbSql.append("       SELECT B.ITEM_CODE, \n");
		sbSql.append("              B.CAL, \n");
		sbSql.append("              B.WATER, \n");
		sbSql.append("              B.PROT, \n");
		sbSql.append("              B.FAT, \n");
		sbSql.append("              B.CARBO, \n");
		sbSql.append("              B.FIBER, \n");
		sbSql.append("              B.ASH, \n");
		sbSql.append("              B.CA, \n");
		sbSql.append("              B.P , \n");
		sbSql.append("              B.FE, \n");
		sbSql.append("              B.NA, \n");
		sbSql.append("              B.K, \n");
		sbSql.append("              B.VITA_A, \n");
		sbSql.append("              B.RETIN, \n");
		sbSql.append("              B.B_CAROT, \n");
		sbSql.append("              B.THIA, \n");
		sbSql.append("              B.RIBO, \n");
		sbSql.append("              B.NIACIN , \n");
		sbSql.append("              B.VITA_C, \n");
		sbSql.append("              B.CHOLE, \n");
		sbSql.append("              B.DISUSE_RATE \n");
		sbSql.append("         FROM \n");
		sbSql.append("            ( \n");
		sbSql.append("             SELECT ITEM_CODE, CAL, WATER, PROT, FAT, CARBO, FIBER, ASH, CA, P, FE, NA, K, VITA_A, RETIN, B_CAROT, THIA, RIBO, NIACIN, VITA_C, CHOLE, DISUSE_RATE \n");
		sbSql.append("               FROM FMP_ITEM_NUT \n");
		sbSql.append("              WHERE UPJANG = "+UPJANG+" \n");
		sbSql.append("              UNION ALL \n");
		sbSql.append("             SELECT ITEM_CODE, CAL, WATER, PROT, FAT, CARBO, FIBER, ASH, CA, P, FE, NA, K, VITA_A, RETIN, B_CAROT, THIA, RIBO, NIACIN, VITA_C, CHOLE, DISUSE_RATE \n");
		sbSql.append("               FROM FSI_ITEM_NUT \n");
		sbSql.append("              WHERE ITEM_CODE IN \n");
		sbSql.append("                  ( \n");
		sbSql.append("                   SELECT	ITEM_CODE \n");
		sbSql.append("                     FROM	FSI_ITEM_NUT MINUS \n");
		sbSql.append("                   SELECT	ITEM_CODE \n");
		sbSql.append("                     FROM	FMP_ITEM_NUT \n");
		sbSql.append("                    WHERE	UPJANG = "+UPJANG+" \n");
		sbSql.append("                  ) \n");
		sbSql.append("             ) B \n");
		sbSql.append("       ) BB,  --자재리스트 \n");
		sbSql.append("       ( \n");
		sbSql.append("        SELECT  \n");
		sbSql.append("               A.UPJANG, A.ITEM_CODE, A.SALE_PRICE, \n");
		sbSql.append("               NVL(NVL(C.OP_RATE, D.OP_RATE), 0) AS OP_RATE, --운영율 \n");
		sbSql.append("               CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL  \n");
		sbSql.append("                    THEN DECODE(SIGN(NVL(C.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE) \n");
		sbSql.append("                    WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL  \n");
		sbSql.append("                    THEN DECODE(SIGN(NVL(D.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL), D.OP_PRICE) \n");
		sbSql.append("                    ELSE A.SALE_PRICE END AS OP_PRICE --운영단가(1인원가)            \n");
		sbSql.append("          FROM \n");
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
		sbSql.append("             ) D, \n");
		sbSql.append("             ( \n");
		sbSql.append("              SELECT  \n");
		sbSql.append("                     "+UPJANG+" AS UPJANG , \n");
		sbSql.append("                     TO_CHAR(SYSDATE,'YYYYMMDD') AS NEED_DATE , \n");
		sbSql.append("                     A.ITEM_CODE, A.SALE_PRICE, C.ITEM_CLASS4 \n");
		sbSql.append("                FROM HLDC_PO_CONTRACT_FSALE A, HLDC_ST_UPJANG B, HLDC_PO_ITEM_MST C \n");
		sbSql.append("               WHERE A.UPJANG = B.AP_UNITPRICE_UPJANG \n");
		sbSql.append("                 AND B.UPJANG = "+UPJANG+" \n");
		sbSql.append("                 AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN A.CONTRACT_START AND NVL(A.CONTRACT_END,'99999999') \n");
		sbSql.append("			       AND A.SALE_PRICE > 0 \n");
		sbSql.append("                 AND A.USE_YN = 'Y' \n");
		sbSql.append("                 AND A.ITEM_CODE = C.ITEM_CODE \n");
		sbSql.append("             ----------- \n");
		sbSql.append("              UNION ALL \n");
		sbSql.append("             ----------- \n");
		sbSql.append("             SELECT "+UPJANG+" AS UPJANG, TO_CHAR(SYSDATE,'YYYYMMDD') AS NEED_DATE, A.ITEM_CODE, A.SALE_PRICE, C.ITEM_CLASS4 \n");
		sbSql.append("               FROM FMP_OTCUST_PRICE_AVA_V A, FMP_OTCUST_ITEM C, \n");
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
		sbSql.append("                AND A.ITEM_CODE = C.ITEM_CODE \n");
		sbSql.append("             ) A \n");
		sbSql.append("      WHERE A.ITEM_CODE = C.ITEM_CODE(+) \n");
		sbSql.append("        AND A.ITEM_CLASS4 = D.ITEM_CODE(+) \n");
		sbSql.append("       ) CC --단가 \n");
		sbSql.append(" WHERE AA.UPJANG="+UPJANG+" \n");
		sbSql.append("   AND AA.RECIPE_CD ='"+RECIPE_CD+"' \n");
		sbSql.append("   AND AA.ITEM_CODE=BB.ITEM_CODE(+) \n");
		sbSql.append("   AND AA.ITEM_CODE=CC.ITEM_CODE(+) \n");
		sbSql.append(" ORDER BY AA.UPJANG, AA.RECIPE_CD, AA.ITEM_SEQ \n");
		
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 

		DataSet ds_ItemList = this.makeDataSet(rs,"ds_ItemList");
		out_dl.add(ds_ItemList);
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
	// 	System.out.println("==>FMM00010E_S010:: \n");
	
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));
	
	
		String RECIPE_NAME		= in_vl.getString("RECIPE_NAME");	
		String RECIPE_CD		= in_vl.getString("RECIPE_CD");	
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
		sbSql.append("SELECT /*+-- USE_HASH (AA CC) */ \n");
		sbSql.append("       AA.UPJANG, \n");
		sbSql.append("       AA.RECIPE_CD,             --레시피코드 \n");
		sbSql.append("       AA.ITEM_SEQ,              --자재순번 \n");
		sbSql.append("       AA.ITEM_CODE,             --레시피명 \n");
		sbSql.append("       BB.ITEM_NAME,             --자재명 \n");
		sbSql.append("       BB.ITEM_SIZE,             --규격 \n");
		sbSql.append("       BB.PO_UOM,                --구매단위 \n");
		sbSql.append("       DD.FEATURE_NAME,          --자재특성 \n");
		sbSql.append("       AA.NEED_QTY,              --1인소요량 \n");
		sbSql.append("       CC.OP_PRICE MARGIN_PRICE, --구매단가 \n");
		sbSql.append("       NVL(BB.DISUSE_RATE,0) DISUSE_RATE,           --페기율 \n");
		sbSql.append("       AA.CUT_SPEC,              --커팅규격 \n");
		sbSql.append("       NVL(BB.CAL,0) CAL,                   --100G당 에너지 \n");
		sbSql.append("       DECODE(NVL(CC.OP_PRICE,0) ,0, 'Y' , 'N' ) RESTRICT_YN,   --상태 \n");
		sbSql.append("       ROUND(AA.NEED_QTY*(100-NVL(BB.DISUSE_RATE,0))/100,2) EDIBLE_QTY,--가식부량 \n");
		sbSql.append("       CASE WHEN NVL(BB.KG_CONVERT_RATE,0)=0 THEN 0 ELSE ROUND(AA.NEED_QTY * (NVL(CC.OP_PRICE,0) / BB.KG_CONVERT_RATE / 1000) ) END PERSON_PRICE,    --1인원가 \n");
		sbSql.append("       ROUND( NVL(BB.CAL,0) * ROUND(AA.NEED_QTY*(100-NVL(BB.DISUSE_RATE,0))/100,2) / 100,2) CAL_CALC, --가식부량에 대한 에너지 \n");
		sbSql.append("       CASE WHEN NVL(BB.KG_CONVERT_RATE,0)=0 THEN 0 ELSE ROUND(NVL(CC.OP_PRICE,0) / BB.KG_CONVERT_RATE / 1000,2) END GRAM_PRICE                   --G당 단가 \n");
		sbSql.append("  FROM FMM_STD_RECIPE_ITEM AA , \n");
		sbSql.append("       ( \n");
		sbSql.append("       SELECT A.ITEM_CODE, \n");
		sbSql.append("              A.ITEM_NAME, \n");
		sbSql.append("              A.ITEM_SIZE, \n");
		sbSql.append("              A.PO_UOM, \n");
		sbSql.append("              A.KG_CONVERT_RATE , \n");
		sbSql.append("              B.CAL, \n");
		sbSql.append("              B.WATER, \n");
		sbSql.append("              B.PROT, \n");
		sbSql.append("              B.FAT, \n");
		sbSql.append("              B.CARBO, \n");
		sbSql.append("              B.FIBER, \n");
		sbSql.append("              B.ASH, \n");
		sbSql.append("              B.CA, \n");
		sbSql.append("              B.P , \n");
		sbSql.append("              B.FE, \n");
		sbSql.append("              B.NA, \n");
		sbSql.append("              B.K, \n");
		sbSql.append("              B.VITA_A, \n");
		sbSql.append("              B.RETIN, \n");
		sbSql.append("              B.B_CAROT, \n");
		sbSql.append("              B.THIA, \n");
		sbSql.append("              B.RIBO, \n");
		sbSql.append("              B.NIACIN , \n");
		sbSql.append("              B.VITA_C, \n");
		sbSql.append("              B.CHOLE, \n");
		sbSql.append("              B.DISUSE_RATE \n");
		sbSql.append("         FROM \n");
		sbSql.append("            ( \n");
		sbSql.append("             SELECT ITEM_CODE, CAL, WATER, PROT, FAT, CARBO, FIBER, ASH, CA, P, FE, NA, K, VITA_A, RETIN, B_CAROT, THIA, RIBO, NIACIN, VITA_C, CHOLE, DISUSE_RATE \n");
		sbSql.append("               FROM FMP_ITEM_NUT \n");
		sbSql.append("              WHERE UPJANG = "+UPJANG+" \n");
		sbSql.append("              UNION ALL \n");
		sbSql.append("             SELECT ITEM_CODE, CAL, WATER, PROT, FAT, CARBO, FIBER, ASH, CA, P, FE, NA, K, VITA_A, RETIN, B_CAROT, THIA, RIBO, NIACIN, VITA_C, CHOLE, DISUSE_RATE \n");
		sbSql.append("               FROM FSI_ITEM_NUT \n");
		sbSql.append("              WHERE ITEM_CODE IN \n");
		sbSql.append("                  ( \n");
		sbSql.append("                   SELECT	ITEM_CODE \n");
		sbSql.append("                     FROM	FSI_ITEM_NUT MINUS \n");
		sbSql.append("                   SELECT	ITEM_CODE \n");
		sbSql.append("                     FROM	FMP_ITEM_NUT \n");
		sbSql.append("                    WHERE	UPJANG = "+UPJANG+" \n");
		sbSql.append("                  ) \n");
		sbSql.append("             ) B, FMS_ITEM_V A \n");
		sbSql.append("         WHERE A.ITEM_CODE = B.ITEM_CODE(+) \n");
		sbSql.append("       ) BB,  --자재리스트 \n");
		sbSql.append("       ( \n");
		sbSql.append("        SELECT /*+-- USE_HASH (A C) */ \n");
		sbSql.append("               A.UPJANG, A.ITEM_CODE, A.SALE_PRICE, NVL(C.OP_RATE,0) AS OP_RATE,                  --운영율 \n");
		sbSql.append("               DECODE(SIGN(NVL(C.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE) AS OP_PRICE --운영단가(1인원가) \n");
		sbSql.append("          FROM \n");
		sbSql.append("             ( \n");
		sbSql.append("             SELECT A.ITEM_CODE, OP_RATE, OP_PRICE, A.CEIL_VAL \n");
		sbSql.append("               FROM FMU_OP_RATE A \n");
		sbSql.append("              WHERE UPJANG = "+UPJANG+" \n");
		sbSql.append("                AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN SDATE AND EDATE \n");
		sbSql.append("                AND A.USE_YN = 'Y' \n");
		sbSql.append("             ) C, \n");
		sbSql.append("             ( \n");
		sbSql.append("              SELECT /*+ INDEX_DESC(C PO_CONTRACT_FSALE_PK) */ \n");
		sbSql.append("                     "+UPJANG+" AS UPJANG , \n");
		sbSql.append("                     TO_CHAR(SYSDATE,'YYYYMMDD') AS NEED_DATE , \n");
		sbSql.append("                     C.ITEM_CODE, C.SALE_PRICE \n");
		sbSql.append("                FROM HLDC_PO_CONTRACT_FSALE C, HLDC_PO_UPJANG_CENTER D, HLDC_ST_UPJANG E \n");
		sbSql.append("                      WHERE C.CENTER_CODE = D.CENTER_CODE \n");
		sbSql.append("                        AND D.UPJANG = E.AP_UNITPRICE_UPJANG \n");
		sbSql.append("                        AND E.UPJANG = "+UPJANG+" \n");
		sbSql.append("                        AND C.UPJANG = E.AP_UNITPRICE_UPJANG \n");
		sbSql.append("                        AND C.ITEM_CODE > ' ' \n");
		sbSql.append("                        AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN C.CONTRACT_START AND NVL(C.CONTRACT_END,'99999999') \n");
		sbSql.append("			              AND C.SALE_PRICE > 0 \n");
		sbSql.append("                        AND C.USE_YN = 'Y' \n");
		sbSql.append("                        AND EXISTS \n");
		sbSql.append("                            ( \n");
		sbSql.append("                            SELECT 1 \n");
		sbSql.append("                              FROM HLDC_PO_TREAT_UPJANG X \n");
		sbSql.append("                             WHERE X.ITEM_CODE = C.ITEM_CODE \n");
		sbSql.append("                               AND X.UPJANG = C.UPJANG \n");
		sbSql.append("                            ) \n");
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
		sbSql.append("             ) A \n");
//		sbSql.append("        WHERE A.ITEM_CODE = C.ITEM_CODE(+) \n");
//  	sbSql.append("        WHERE A.ITEM_CODE BETWEEN C.ITEM_CODE(+) AND C.ITEM_CODE(+)||'9999' \n");
		sbSql.append("      WHERE SUBSTR(A.ITEM_CODE,1," + strOpLen + ") = C.ITEM_CODE(+) \n");
		sbSql.append("       ) CC, --단가 \n");
		sbSql.append("       ( \n");
		sbSql.append("       SELECT ITEM_CODE, \n");
		sbSql.append("              ( \n");
		sbSql.append("              SELECT CODE_NAME \n");
		sbSql.append("                FROM SCC_COMMON_CODE \n");
		sbSql.append("               WHERE GROUP_CODE = 'FS0033' \n");
		sbSql.append("                 AND CODE = ITEM_FEATURE \n");
		sbSql.append("              ) AS FEATURE_NAME \n");
		sbSql.append("         FROM FSI_ITEM_FEATURE \n");
		sbSql.append("        WHERE (ITEM_CODE, CDATE) IN \n");
		sbSql.append("              ( \n");
		sbSql.append("              SELECT ITEM_CODE, \n");
		sbSql.append("                     MAX(CDATE) AS CDATE \n");
		sbSql.append("                FROM FSI_ITEM_FEATURE \n");
		sbSql.append("               WHERE (1=1) \n");
		sbSql.append("                 AND (CENTER_CODE, CUSTCD, ITEM_CODE, APPLY_DATE) IN \n");
		sbSql.append("                     ( \n");
		sbSql.append("                     SELECT CENTER_CODE, \n");
		sbSql.append("                            CUSTCD, \n");
		sbSql.append("                            ITEM_CODE, \n");
		sbSql.append("                            MAX(APPLY_DATE) AS APPLY_DATE \n");
		sbSql.append("                       FROM FSI_ITEM_FEATURE \n");
		sbSql.append("                      WHERE CENTER_CODE = '300001' \n");
		sbSql.append("                        AND TO_CHAR(SYSDATE, 'YYYYMMDD' ) BETWEEN APPLY_DATE AND  TO_CHAR(ADD_MONTHS(TO_DATE(APPLY_DATE,'YYYYMMDD'),1)-1,'YYYYMMDD') \n");
		sbSql.append("                      GROUP BY CENTER_CODE, \n");
		sbSql.append("                            CUSTCD, \n");
		sbSql.append("                            ITEM_CODE \n");
		sbSql.append("                     ) \n");
		sbSql.append("               GROUP BY ITEM_CODE \n");
		sbSql.append("              ) \n");
		sbSql.append("       ) DD   -- 자재 특성 \n");
		sbSql.append(" WHERE AA.UPJANG="+UPJANG+" \n");
		sbSql.append("   AND AA.RECIPE_CD ='"+RECIPE_CD+"' \n");
		sbSql.append("   AND AA.ITEM_CODE=BB.ITEM_CODE(+) \n");
		sbSql.append("   AND AA.ITEM_CODE=CC.ITEM_CODE(+) \n");
		sbSql.append("   AND AA.ITEM_CODE=DD.ITEM_CODE(+) \n");
		sbSql.append(" ORDER BY AA.ITEM_SEQ, \n");
		sbSql.append("       AA.ITEM_CODE \n");

		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 

		DataSet ds_ItemList = this.makeDataSet(rs,"ds_ItemList");
		out_dl.add(ds_ItemList);
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