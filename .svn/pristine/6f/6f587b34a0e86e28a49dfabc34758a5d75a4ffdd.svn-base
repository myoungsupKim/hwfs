<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/수불관리
■ 프로그램ID   : FMP00250V_T001.jsp
■ 프로그램명   : 입고내역서 출력
■ 작성일자     : 2008.01.23
■ 작성자       : 박은규
■ 이력관리     : 2008.01.23
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
	
		//FileLog.println("d:\\aaa.txt", ds_cond);


		//out 데이타
		DataSet ds_list;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		//내역조회
		sbSql.append("SELECT A.OTCUSTCD, A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM, A.OP_PRICE \n");
		sbSql.append("     , A.STATUS_CODE, A.STATUS \n"); 
		sbSql.append("     , A.ORIGIN_TYPE \n"); 
		sbSql.append("     , SUM(A.PR_QTY) AS PR_QTY \n");
		sbSql.append("     , SUM(A.RTN_QTY) AS RTN_QTY \n");
		sbSql.append("     , SUM(A.IN_QTY) AS IN_QTY \n");
		sbSql.append("     , SUM(A.OP_AMOUNT) AS OP_AMOUNT \n");
		sbSql.append("     , SUM(A.OP_VAT) AS OP_VAT \n");
		sbSql.append("     , SUM(A.OP_TOT) AS OP_TOT \n");
		sbSql.append("  FROM \n");
		sbSql.append("( \n");
			sbSql.append("SELECT OTCUSTCD, ITEM_CODE, ITEM_NAME, ITEM_SIZE, PO_UOM, OP_PRICE, SALE_PRICE \n");
			sbSql.append("     , STATUS_CODE, STATUS \n");
			sbSql.append("     , ORIGIN_TYPE \n");
			sbSql.append("     , SUM(PR_QTY) AS PR_QTY \n");
			sbSql.append("     , SUM(RTN_QTY) AS RTN_QTY \n");
			sbSql.append("     , SUM(IN_QTY) AS IN_QTY \n");
			sbSql.append("     , SUM(ROUND(DELIVERED_QTY * OP_PRICE)) AS OP_AMOUNT \n");
			sbSql.append("     , SUM(ROUND(DECODE(TAX_CODE,'100',0.1,0) * ROUND(DELIVERED_QTY * OP_PRICE))) AS OP_VAT \n");
			sbSql.append("     , SUM(ROUND(DECODE(TAX_CODE,'100',1.1,1) * ROUND(DELIVERED_QTY * OP_PRICE))) AS OP_TOT \n");
			sbSql.append("  FROM \n");
			sbSql.append("( \n");
				sbSql.append("SELECT '0000' AS OTCUSTCD \n");
				sbSql.append("     , A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM \n");
				sbSql.append("     , B.CODE AS STATUS_CODE, B.CODE_NAME AS STATUS \n");
				sbSql.append("     , SUM(A.ADJUST_QTY + A.PO_QTY) AS PR_QTY \n");
				sbSql.append("     , SUM(A.ADJUST_QTY + A.CENTER_UNDELI_QTY + A.UNDELIVERED_QTY + A.RETURNED_QTY) AS RTN_QTY \n");
				sbSql.append("     , SUM(A.DELIVERED_QTY) AS IN_QTY  \n");
				sbSql.append("     , SUM(A.DELIVERED_QTY) AS DELIVERED_QTY \n");
				sbSql.append("     , SUM(A.SALE_PRICE) AS SALE_PRICE \n");
				sbSql.append("     , CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
				sbSql.append("            THEN DECODE(SIGN(NVL(C.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE) \n");
				sbSql.append("            WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL \n");
				sbSql.append("            THEN DECODE(SIGN(NVL(D.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL), D.OP_PRICE) \n");
				sbSql.append("       ELSE A.SALE_PRICE END AS OP_PRICE --운영단가 \n");
				sbSql.append("     , A.TAX_CODE \n");
				sbSql.append("     , A.ORIGIN_TYPE \n");
				sbSql.append("  FROM (SELECT A.*, B.ITEM_CLASS4, B.ORIGIN_TYPE FROM HLDC_PO_PO A, FMS_ITEM_V B WHERE A.ITEM_CODE = B.ITEM_CODE) A \n");
				sbSql.append("     , (SELECT CODE, CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FM0037') B \n");
				sbSql.append("     , ( \n");   
				sbSql.append("         SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE, UPJANG  \n");
				sbSql.append("           FROM FMU_OP_RATE \n");
				sbSql.append("          WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
				sbSql.append("            AND USE_YN = 'Y' \n");
				sbSql.append("            AND ITEM_TYPE = 'M' \n");
				sbSql.append("       ) C \n");
				sbSql.append("     , ( \n");        
				sbSql.append("         SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE, UPJANG \n");
				sbSql.append("           FROM FMU_OP_RATE \n");
				sbSql.append("          WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
				sbSql.append("            AND USE_YN = 'Y' \n");
				sbSql.append("            AND ITEM_TYPE = 'C' \n");
				sbSql.append("       ) D \n");
				sbSql.append(" WHERE 1=1 \n");
				sbSql.append("   AND A.LINE_STATUS = B.CODE \n");
				sbSql.append("   AND A.RC_UPJANG = C.UPJANG(+) \n");
				sbSql.append("   AND A.RC_UPJANG = D.UPJANG(+) \n");
				sbSql.append("   AND A.ITEM_CODE = C.ITEM_CODE(+) \n");
				sbSql.append("   AND A.ITEM_CLASS4 = D.ITEM_CODE(+) \n");
				sbSql.append("   AND A.NEED_DATE BETWEEN C.SDATE(+) AND C.EDATE(+) \n");
				sbSql.append("   AND A.NEED_DATE BETWEEN D.SDATE(+) AND D.EDATE(+) \n");
				sbSql.append("   AND A.RC_UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
				sbSql.append("   AND A.SUBINV_CODE LIKE '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) + "%' \n");
				sbSql.append("   AND A.NEED_DATE BETWEEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATET")) + "' \n");
				sbSql.append("   AND '0000' LIKE '" + nullToBlank(ds_cond.getString(0, "OTCUSTCD")) + "%' \n");
				sbSql.append("   AND '003' != '" + nullToBlank(ds_cond.getString(0, "GB")) + "' \n");
				sbSql.append("   AND A.DELIVERED_QTY > 0 \n");
				sbSql.append(" GROUP BY A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM, A.ORIGIN_TYPE,  \n");
				sbSql.append(" 			B.CODE_NAME, B.CODE, \n");
				sbSql.append(" 			A.ADJUST_QTY, A.PO_QTY, A.CENTER_UNDELI_QTY, A.TAX_CODE ,\n");
				sbSql.append(" 			A.UNDELIVERED_QTY, A.RETURNED_QTY, A.DELIVERED_QTY, A.SALE_PRICE, \n");
				sbSql.append("			C.OP_PRICE, C.OP_RATE, C.CEIL_VAL, D.OP_PRICE, D.OP_RATE, D.CEIL_VAL \n");
			sbSql.append(")  GROUP BY OTCUSTCD, ITEM_CODE, ITEM_NAME, ITEM_SIZE, PO_UOM, ORIGIN_TYPE,  	  \n");
	        sbSql.append("            STATUS_CODE, STATUS,  \n");
	        sbSql.append("            OP_PRICE, SALE_PRICE, PR_QTY, RTN_QTY, IN_QTY,          \n");
	        sbSql.append("            DELIVERED_QTY, OP_PRICE, TAX_CODE						  \n");		
			sbSql.append("----------- \n");
			sbSql.append(" UNION ALL  \n");
			sbSql.append("----------- \n");
		
			sbSql.append("SELECT OTCUSTCD, ITEM_CODE, ITEM_NAME, ITEM_SIZE, PO_UOM, OP_PRICE, SALE_PRICE \n");
			sbSql.append("     , STATUS_CODE, STATUS \n");
			sbSql.append("     , ORIGIN_TYPE  \n");
			sbSql.append("     , SUM(PR_QTY) AS PR_QTY \n");
			sbSql.append("     , SUM(RTN_QTY) AS RTN_QTY \n");
			sbSql.append("     , SUM(IN_QTY) AS IN_QTY \n");
			sbSql.append("     , SUM(ROUND(PR_QTY * OP_PRICE)) AS OP_AMOUNT \n");
			sbSql.append("     , SUM(ROUND(DECODE(TAX_CODE,'100',0.1,0) * ROUND(PR_QTY * OP_PRICE))) AS OP_VAT \n");
			sbSql.append("     , SUM(ROUND(DECODE(TAX_CODE,'100',1.1,1) * ROUND(PR_QTY * OP_PRICE))) AS OP_TOT \n");
			sbSql.append("  FROM \n");
			sbSql.append("( \n");			
				sbSql.append("SELECT A.OTCUSTCD \n");
				sbSql.append("     , A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM \n");
				sbSql.append("     , A.LINE_STATUS AS STATUS_CODE, B.OTCUSTNM AS STATUS \n");
				sbSql.append("     , SUM(A.PR_QTY) AS PR_QTY \n");
				sbSql.append("     , 0 AS RTN_QTY \n");
				sbSql.append("     , SUM(A.PR_QTY) AS IN_QTY \n");
				sbSql.append("     , A.SALE_PRICE \n");
				sbSql.append("     , A.TAX_CODE \n");
				sbSql.append("     , A.ORIGIN_TYPE \n");
				
				//2015-10-01 이규훈 FMU_OP_RATE -> FMP_OTCUST_PR
		        //sbSql.append("     , CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");              
		        //sbSql.append("           THEN DECODE(SIGN(NVL(C.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE) \n"); 
		        //sbSql.append("           WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL \n");
		        //sbSql.append("           THEN DECODE(SIGN(NVL(D.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL), D.OP_PRICE) \n"); 
		        //sbSql.append("           ELSE A.SALE_PRICE \n");
		        //sbSql.append("       END AS OP_PRICE \n");
		        sbSql.append("     , DECODE(A.OP_PRICE, 0, A.SALE_PRICE, A.OP_PRICE) AS OP_PRICE --운영단가 \n");
				sbSql.append("     FROM (SELECT A.*, B.ITEM_CLASS2, B.ITEM_CLASS4, B.ORIGIN_TYPE FROM FMP_OTCUST_PR A, FMS_ITEM_V B WHERE A.ITEM_CODE = B.ITEM_CODE) A \n");
				sbSql.append("     		, FMP_OTHER_CUST B \n");
				//sbSql.append("     		, ( \n");   
				//sbSql.append("         		SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE, UPJANG  \n");
				//sbSql.append("           		FROM FMU_OP_RATE \n");
				//sbSql.append("          		WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
				//sbSql.append("            		AND USE_YN = 'Y' \n");
				//sbSql.append("            		AND ITEM_TYPE = 'M' \n");
				//sbSql.append("       	  ) C \n");
				//sbSql.append("     		, ( \n");        
				//sbSql.append("         		SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE, UPJANG \n");
				//sbSql.append("           		FROM FMU_OP_RATE \n");
				//sbSql.append("          		WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
				//sbSql.append("            		AND USE_YN = 'Y' \n");
				//sbSql.append("            		AND ITEM_TYPE = 'C' \n");
				//sbSql.append("       	  ) D \n");
				sbSql.append(" WHERE A.OTCUSTCD = B.OTCUSTCD \n");
				//sbSql.append("   AND A.UPJANG = C.UPJANG(+) \n");
				//sbSql.append("   AND A.UPJANG = D.UPJANG(+) \n");
				//sbSql.append("   AND A.ITEM_CODE = C.ITEM_CODE(+) \n");  
				//sbSql.append("   AND A.ITEM_CLASS4 = D.ITEM_CODE(+) \n");
				//sbSql.append("   AND A.NEED_DATE BETWEEN C.SDATE(+) AND C.EDATE(+) \n");
				//sbSql.append("   AND A.NEED_DATE BETWEEN D.SDATE(+) AND D.EDATE(+) \n");
				sbSql.append("   AND A.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
				sbSql.append("   AND A.SUBINV_CODE LIKE '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) + "%' \n");
				sbSql.append("   AND A.NEED_DATE BETWEEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATET")) + "' \n");
				sbSql.append("   AND A.OTCUSTCD LIKE '" + nullToBlank(ds_cond.getString(0, "OTCUSTCD")) + "%' \n");
				sbSql.append("   AND A.LINE_STATUS NOT IN ('003','005')");    //09.02.04일 김진희씨 요청에 의한 추가(신청취소,결의반려 항목 제외)
				sbSql.append("   AND '003' != '" + nullToBlank(ds_cond.getString(0, "GB")) + "' \n");
				sbSql.append(" GROUP BY A.OTCUSTCD, A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM, A.ORIGIN_TYPE,  \n");
				sbSql.append("          A.LINE_STATUS, B.OTCUSTNM, ");
				sbSql.append(" 			A.PR_QTY, A.SALE_PRICE, TAX_CODE, A.OP_PRICE \n");
				//sbSql.append("			C.OP_PRICE, C.OP_RATE, C.CEIL_VAL, D.OP_PRICE, D.OP_RATE, D.CEIL_VAL \n");
			sbSql.append("  ) \n");	
			sbSql.append("  GROUP BY OTCUSTCD, ITEM_CODE, ITEM_NAME, ITEM_SIZE, ORIGIN_TYPE,        	\n");
            sbSql.append("           PO_UOM , OP_PRICE, SALE_PRICE, PR_QTY,           	\n");
            sbSql.append("           RTN_QTY, IN_QTY, PR_QTY, OP_PRICE, TAX_CODE, STATUS_CODE, STATUS       \n");
			sbSql.append("----------- \n");
			sbSql.append(" UNION ALL \n");
			sbSql.append("----------- \n");
		
			sbSql.append("SELECT OTCUSTCD, ITEM_CODE, ITEM_NAME, ITEM_SIZE, PO_UOM, OP_PRICE, SALE_PRICE \n");
			sbSql.append("     , STATUS_CODE, STATUS \n");
			sbSql.append("     , ORIGIN_TYPE  \n");
			sbSql.append("     , SUM(PR_QTY) AS PR_QTY \n");
			sbSql.append("     , SUM(RTN_QTY) AS RTN_QTY \n");
			sbSql.append("     , SUM(IN_QTY) AS IN_QTY \n");
			sbSql.append("     , SUM(ROUND(PR_QTY * OP_PRICE)) AS OP_AMOUNT \n");
			sbSql.append("     , SUM(ROUND(OP_VAT)) AS OP_VAT \n");
			sbSql.append("     , SUM(ROUND(OP_TOT)) AS OP_TOT \n");			
			sbSql.append("  FROM \n");
			sbSql.append("( \n");
				sbSql.append("SELECT 'ZZZZ' AS OTCUSTCD \n");
				sbSql.append("     , A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.UOM_CODE AS PO_UOM \n");
				sbSql.append("     , 'ZZZZ' AS STATUS_CODE, '현지구매' AS STATUS \n");
				sbSql.append("     , SUM(A.QTY) AS PR_QTY \n");
				sbSql.append("     , 0 AS RTN_QTY \n");
				sbSql.append("     , '' AS ORIGIN_TYPE \n");
				sbSql.append("     , SUM(A.QTY) AS IN_QTY \n");
				sbSql.append("     , A.PRICE AS SALE_PRICE \n");
				sbSql.append("     , A.PRICE AS OP_PRICE \n");
				sbSql.append("     , SUM(A.SUPPLYAMT) AS OP_AMOUNT \n");
				sbSql.append("     , SUM(A.VAT) AS OP_VAT \n");
				sbSql.append("     , SUM(A.AMOUNT) AS OP_TOT \n");
				sbSql.append("  FROM FMP_LOCALPO A \n");
				sbSql.append(" WHERE A.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
				sbSql.append("   AND A.SUBINV_CODE LIKE '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) + "%' \n");
				sbSql.append("   AND A.NEED_DATE BETWEEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATET")) + "' \n");
				sbSql.append("   AND '001' != '" + nullToBlank(ds_cond.getString(0, "GB")) + "' \n");
				sbSql.append(" GROUP BY A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.UOM_CODE, A.PRICE \n");
			sbSql.append(") \n");
			sbSql.append("	 GROUP BY OTCUSTCD, ITEM_CODE, ITEM_NAME, ITEM_SIZE, PO_UOM, OP_PRICE, STATUS_CODE, STATUS, ORIGIN_TYPE	\n");		
			sbSql.append(") A \n");
		sbSql.append(" GROUP BY A.OTCUSTCD, A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM, A.OP_PRICE \n");
		sbSql.append("          ,A.STATUS_CODE, A.STATUS, ORIGIN_TYPE  \n");

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

%>