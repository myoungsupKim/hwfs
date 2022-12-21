<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/단가관리/공급업체관리
■ 프로그램ID   : FMU00060V_T001.jsp
■ 프로그램명   : 운영단가 이력조회
■ 작성일자     : 2008.02.21
■ 작성자       : 박은규
■ 이력관리     : [고도화]_운영율 관련 수정_김경은
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	try	{
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));		
	
		//입력 데이타
		DataSet ds_cond     = in_dl.get("ds_Cond");
		//입력 파라메터
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		
		String sOtcust     = nullToBlank(ds_cond.getString(0, "OTCUSTCD"));
		
		//out 데이타
		DataSet ds_list;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		
		//내역조회
		sbSql.append("SELECT A.OTCUSTCD \n");
		sbSql.append("     ,(SELECT Z.OTCUSTNM FROM FMP_OTHER_CUST Z WHERE Z.OTCUSTCD = A.OTCUSTCD) OTCUSTNM \n");
		sbSql.append("     , A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM, A.ORIGIN_TYPE \n");
		sbSql.append("     , A.SALE_PRICE \n");
		sbSql.append("     , NVL(NVL(C.OP_RATE, D.OP_RATE), 0) AS OP_RATE  --운영율             \n");
		sbSql.append("     , CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL              \n");
		sbSql.append("            THEN DECODE(SIGN(NVL(C.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE) \n");
		sbSql.append("            WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL              \n");
		sbSql.append("            THEN DECODE(SIGN(NVL(D.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL), D.OP_PRICE) \n");
		sbSql.append("            ELSE A.SALE_PRICE END AS OP_PRICE                                            \n");
		sbSql.append("     , E.ITEM_CODE AS FIXED_ITEM \n");
		sbSql.append("  FROM  \n");
		sbSql.append("      ( \n");
		if (sOtcust.equals("0000") || sOtcust.equals(""))			
		{
			sbSql.append("       SELECT \n");
			sbSql.append("              " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " AS UPJANG \n");
			sbSql.append("            , '" + nullToBlank(ds_cond.getString(0, "JDATE")) + "' AS JDATE \n");
			sbSql.append("            , A.ITEM_CODE, B.ITEM_CLASS4, B.ITEM_NAME, B.ITEM_SIZE, B.PO_UOM, B.ORIGIN_TYPE \n");
			sbSql.append("            , A.SALE_PRICE \n");
			sbSql.append("            , '0000' AS OTCUSTCD \n");
			sbSql.append("         FROM HLDC_PO_CONTRACT_FSALE A, HLDC_PO_ITEM_MST B, HLDC_ST_UPJANG C \n");
			sbSql.append("        WHERE A.ITEM_CODE = B.ITEM_CODE \n");
			sbSql.append("          AND A.UPJANG = C.AP_UNITPRICE_UPJANG \n");
			sbSql.append("          AND C.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
			sbSql.append("          AND '" + nullToBlank(ds_cond.getString(0, "JDATE")) + "' BETWEEN A.CONTRACT_START AND NVL(A.CONTRACT_END,'99999999') \n");
			sbSql.append("          AND A.SALE_PRICE > 0 \n");
			sbSql.append("          AND A.USE_YN = 'Y' AND B.USE_YN = 'Y' \n");
			sbSql.append("          AND B.ITEM_CLASS1 = 'F' \n");
		}
		if (sOtcust.equals(""))
		{
			sbSql.append("       ----------- \n");
			sbSql.append("        UNION ALL \n");
			sbSql.append("       ----------- \n");
		}
		if (! sOtcust.equals("0000"))
		{
			sbSql.append("       SELECT " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " AS UPJANG \n");
			sbSql.append("            , '" + nullToBlank(ds_cond.getString(0, "JDATE")) + "' AS JDATE \n");
			sbSql.append("            , A.ITEM_CODE, B.ITEM_CLASS4, B.ITEM_NAME, B.ITEM_SIZE, B.PO_UOM, B.ORIGIN_TYPE \n");
			sbSql.append("            , A.SALE_PRICE \n");
			sbSql.append("            , B.OTCUSTCD \n");
			sbSql.append("         FROM FMP_OTCUST_PRICE_AVA_V A, FMP_OTCUST_ITEM B, HLDC_ST_UPJANG C \n");
			sbSql.append("        WHERE A.ITEM_CODE = B.ITEM_CODE \n");
			sbSql.append("          AND A.UPJANG = C.AP_UNITPRICE_UPJANG \n");
			sbSql.append("          AND C.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
			
			if (! sOtcust.equals("")) 
			{
				sbSql.append("          AND A.ITEM_CODE LIKE '" + nullToBlank(ds_cond.getString(0, "OTCUSTCD")) + "%' \n");
			}	
			sbSql.append("          AND '" + nullToBlank(ds_cond.getString(0, "JDATE")) + "' BETWEEN A.SDATE AND NVL(A.EDATE,'99999999') \n");
			sbSql.append("          AND A.SALE_PRICE > 0 \n");
			sbSql.append("          AND A.USE_YN = 'Y' AND B.USE_YN = 'Y' \n");
			
		}
		sbSql.append("      ) A \n");
		
		sbSql.append("     , ( \n");        
		sbSql.append("        SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL \n");
		sbSql.append("          FROM FMU_OP_RATE \n");
		sbSql.append("         WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
		sbSql.append("           AND '" + nullToBlank(ds_cond.getString(0, "JDATE")) + "' BETWEEN SDATE AND EDATE \n");
		sbSql.append("           AND USE_YN = 'Y' \n");
		sbSql.append("           AND ITEM_TYPE = 'M' \n");
		sbSql.append("        ) C \n");
		sbSql.append("     , ( \n");        
		sbSql.append("        SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL \n");
		sbSql.append("          FROM FMU_OP_RATE \n");
		sbSql.append("         WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
		sbSql.append("           AND '" + nullToBlank(ds_cond.getString(0, "JDATE")) + "' BETWEEN SDATE AND EDATE \n");
		sbSql.append("           AND USE_YN = 'Y' \n");
		sbSql.append("           AND ITEM_TYPE = 'C' \n");
		sbSql.append("        ) D \n");
		
        sbSql.append("     , FMU_OP_FIX_LIST E \n");
		sbSql.append(" WHERE A.UPJANG = E.UPJANG(+) \n");
		sbSql.append("   AND A.ITEM_CODE = E.ITEM_CODE(+) \n");
		sbSql.append("   AND A.ITEM_CODE = C.ITEM_CODE(+) \n");
		sbSql.append("   AND A.ITEM_CLASS4 = D.ITEM_CODE(+) \n");
		sbSql.append("   AND E.USE_YN(+) = 'Y' \n");
		
		out_vl.add("fa_Sql", sbSql.toString());
		
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery(); 
		
		ds_list = this.makeDataSet(rs, "ds_List");	

		pstmt.close();
		rs.close();
		
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

<%--
	try	{
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));		
	
		//입력 데이타
		DataSet ds_cond     = in_dl.get("ds_Cond");
		//입력 파라메터
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		//FileLog.println("d:\\aaa.txt", ds_cond);

		String sOtcust     = nullToBlank(ds_cond.getString(0, "OTCUSTCD"));
		
		//out 데이타
		DataSet ds_list;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		

		//내역조회
		sbSql.append("SELECT /*+ USE_HASH(C) */ A.OTCUSTCD \n");
		sbSql.append("     ,(SELECT Z.OTCUSTNM FROM FMP_OTHER_CUST Z WHERE Z.OTCUSTCD = A.OTCUSTCD) OTCUSTNM \n");
		sbSql.append("     , A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM \n");
		sbSql.append("     , A.SALE_PRICE \n");
		sbSql.append("     , DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE) AS OP_PRICE \n");
		sbSql.append("     , NVL(C.OP_RATE,0) AS OP_RATE \n");
		sbSql.append("     , E.ITEM_CODE AS FIXED_ITEM \n");
		sbSql.append("  FROM  \n");
		sbSql.append("      ( \n");
		if (sOtcust.equals("0000") || sOtcust.equals(""))			
		{
			sbSql.append("       SELECT /*+-- INDEX(A PO_CONTRACT_FSALE_PK) */ \n");
			sbSql.append("              " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " AS UPJANG \n");
			sbSql.append("            , '" + nullToBlank(ds_cond.getString(0, "JDATE")) + "' AS JDATE \n");
			sbSql.append("            , A.ITEM_CODE, B.ITEM_NAME, B.ITEM_SIZE, B.PO_UOM \n");
			sbSql.append("            , A.SALE_PRICE \n");
			sbSql.append("            , '0000' AS OTCUSTCD \n");
			sbSql.append("         FROM HLDC_PO_CONTRACT_FSALE A, HLDC_PO_ITEM_MST B \n");
			sbSql.append("        WHERE A.ITEM_CODE = B.ITEM_CODE \n");
			sbSql.append("          AND A.CENTER_CODE = (SELECT Z.CENTER_CODE FROM HLDC_PO_UPJANG_CENTER Z, HLDC_ST_UPJANG X WHERE Z.UPJANG = X.AP_UNITPRICE_UPJANG AND X.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + ") \n");
			sbSql.append("          AND A.UPJANG = (SELECT X.AP_UNITPRICE_UPJANG FROM HLDC_ST_UPJANG X WHERE X.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + ") \n");
			sbSql.append("          AND A.ITEM_CODE > ' ' \n");
			sbSql.append("          AND '" + nullToBlank(ds_cond.getString(0, "JDATE")) + "' BETWEEN A.CONTRACT_START AND NVL(A.CONTRACT_END,'99999999') \n");
			sbSql.append("          AND EXISTS (SELECT 1 FROM HLDC_PO_TREAT_UPJANG X WHERE X.ITEM_CODE = A.ITEM_CODE AND UPJANG = (SELECT X.AP_UNITPRICE_UPJANG FROM HLDC_ST_UPJANG X WHERE X.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + ")) \n");
			sbSql.append("          AND A.SALE_PRICE > 0 \n");
			sbSql.append("          AND A.USE_YN = 'Y' AND B.USE_YN = 'Y' \n");
			sbSql.append("          AND B.ITEM_CODE BETWEEN '010000000000' AND '019999999999' \n");
		}
		if (sOtcust.equals(""))
		{
			sbSql.append("       ----------- \n");
			sbSql.append("        UNION ALL \n");
			sbSql.append("       ----------- \n");
		}
		if (! sOtcust.equals("0000"))
		{
			sbSql.append("       SELECT " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " AS UPJANG \n");
			sbSql.append("            , '" + nullToBlank(ds_cond.getString(0, "JDATE")) + "' AS JDATE \n");
			sbSql.append("            , A.ITEM_CODE, B.ITEM_NAME, B.ITEM_SIZE, B.PO_UOM \n");
			sbSql.append("            , A.SALE_PRICE \n");
			sbSql.append("            , B.OTCUSTCD \n");
			sbSql.append("         FROM FMP_OTCUST_PRICE_AVA_V A, FMP_OTCUST_ITEM B \n");
			sbSql.append("        WHERE A.ITEM_CODE = B.ITEM_CODE \n");
			sbSql.append("          AND A.UPJANG = (SELECT X.AP_UNITPRICE_UPJANG FROM HLDC_ST_UPJANG X WHERE X.UPJANG = '" + nullToBlank(ds_cond.getString(0, "UPJANG")) + "') \n");
			if (sOtcust.equals(""))
				sbSql.append("          AND A.ITEM_CODE > ' ' \n");
			else
				sbSql.append("          AND A.ITEM_CODE LIKE '" + nullToBlank(ds_cond.getString(0, "OTCUSTCD")) + "%' \n");
			sbSql.append("          AND '" + nullToBlank(ds_cond.getString(0, "JDATE")) + "' BETWEEN A.SDATE AND NVL(A.EDATE,'99999999') \n");
			sbSql.append("          AND A.SALE_PRICE > 0 \n");
			sbSql.append("          AND A.USE_YN = 'Y' AND B.USE_YN = 'Y' \n");
		}
		sbSql.append("      ) A \n");
        sbSql.append("     , (SELECT A.ITEM_CODE, OP_RATE, OP_PRICE, A.CEIL_VAL, UPJANG \n");
        sbSql.append("          FROM FMU_OP_RATE A              \n");
        sbSql.append("         WHERE UPJANG = '" + nullToBlank(ds_cond.getString(0, "UPJANG")) + "'   \n");
        sbSql.append("           AND '" + nullToBlank(ds_cond.getString(0, "JDATE")) + "' BETWEEN SDATE AND EDATE \n");
        sbSql.append("           AND A.USE_YN = 'Y'             \n");
        sbSql.append("       ) C \n");
		sbSql.append("     , FMU_OP_FIX_LIST E \n");
		sbSql.append(" WHERE A.ITEM_CODE BETWEEN C.ITEM_CODE(+) AND C.ITEM_CODE(+)||'9999' \n");
		sbSql.append("   AND A.UPJANG = E.UPJANG(+) \n");
		sbSql.append("   AND A.ITEM_CODE = E.ITEM_CODE(+) \n");
		sbSql.append("   AND E.USE_YN(+) = 'Y' \n");
		sbSql.append("   AND A.UPJANG = C.UPJANG(+) \n");

out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery(); 
		
		ds_list = this.makeDataSet(rs, "ds_List");	

		pstmt.close();
		rs.close();
		
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

--%>
