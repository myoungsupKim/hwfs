<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/수불관리
■ 프로그램ID   : FMP00570V_T001.jsp
■ 프로그램명   : 거래내역 조회
■ 작성일자     : 2008-01-31
■ 작성자       : 박은규
■ 이력관리     : 2008-01-31
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

		String sOtCust = nullToBlank(ds_cond.getString(0, "OTCUSTCD"));
		String sTaxCode = nullToBlank(ds_cond.getString(0, "TAX_CODE"));
		String sItemName = nullToBlank(ds_cond.getString(0, "ITEM_NAME"));
		String sDayType = nullToBlank(ds_cond.getString(0, "DAY_TYPE"));
		String sSubinv = nullToBlank(ds_cond.getString(0, "SUBINV_CODE"));
		//내역조회
		/*
		if (sOtCust.equals(""))
		{
			sbSql.append("SELECT T.* \n");
			sbSql.append("  FROM \n");
			sbSql.append("( \n");
		}
		*/
		if (sOtCust.equals("0000") || sOtCust.equals(""))
		{
			/*
			sbSql.append("SELECT TO_CHAR(TO_DATE(A.TRANS_DATE,'YYYYMMDD'),'YYYY-MM-DD') AS NEED_DATE, A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM \n");
			sbSql.append("     , DECODE(A.TAX_CODE, '100', '과세', '면세') AS TAX_CODE \n");
			sbSql.append("	   , SUM(A.PR_QTY) AS PR_QTY, SUM(A.SALE_PRICE) AS SALE_PRICE, A.OP_PRICE AS OP_PRICE \n");
			sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.TRANS_QTY * A.OP_PRICE)) AS OP_AMOUNT \n");
			sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * ROUND(A.TRANS_QTY * A.OP_PRICE))) AS OP_VAT \n");
			sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.TRANS_QTY * A.OP_PRICE))) AS OP_TOT \n");
			sbSql.append("     , A.ORIGIN_TYPE AS ORIGIN_TYPE \n");
			sbSql.append("  FROM \n");
			sbSql.append("( \n");
			*/
			
			if (sDayType.equals("001")) {
				sbSql.append("SELECT TO_CHAR(TO_DATE(A.TRANS_DATE2,'YYYYMMDD'),'YYYY-MM-DD') AS NEED_DATE \n");
			} else if (sDayType.equals("002")) {
				sbSql.append("SELECT TO_CHAR(TO_DATE(A.TRANS_DATE2,'YYYYMMDD'),'YYYY-MM') AS NEED_DATE \n");
			} else if (sDayType.equals("003")) {
				sbSql.append("SELECT TO_CHAR(TO_DATE(A.TRANS_DATE2,'YYYYMMDD'),'YYYY') AS NEED_DATE \n");
			}
			
			sbSql.append("     , A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.TRANS_UOM AS PO_UOM \n");
			//sbSql.append("     , A.TRANS_TYPE, A.TRANS_QTY \n");
			//sbSql.append("     , DECODE(A.TAX_CODE,'100','과세','면세') AS TAX_CODE \n");
			sbSql.append("     , DECODE(A.TAX_CODE, '100', '과세', '면세') AS TAX_CODE \n");
			sbSql.append("     , DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * A.TRANS_QTY AS PR_QTY \n");
			sbSql.append("     , A.SALE_PRICE \n");
			sbSql.append("      , ( SELECT ORIGIN_TYPE   FROM FMS_ITEM_V  WHERE (1=1)  AND ITEM_CODE = A.ITEM_CODE )  ORIGIN_TYPE \n");
  		//운영율 FMU_OP_RATE -> FMS_TRANSACTION_V 수정 문형광 20150919 시작
			/*
			sbSql.append("     , CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
			sbSql.append("            THEN DECODE(SIGN(NVL(C.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE) \n");
			sbSql.append("            WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL \n");
			sbSql.append("            THEN DECODE(SIGN(NVL(D.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL), D.OP_PRICE) \n");
			sbSql.append("       ELSE A.SALE_PRICE END AS OP_PRICE --운영단가 \n");
			*/
			sbSql.append("     , DECODE(NVL(A.SAL_OPER_PRICE,0), 0, A.SALE_PRICE, A.SAL_OPER_PRICE) AS OP_PRICE --운영단가 \n");
			sbSql.append("     , DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.TRANS_QTY * A.SAL_OPER_PRICE) AS OP_AMOUNT  \n");
			//sbSql.append("     , DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * ROUND(A.TRANS_QTY * A.SAL_OPER_PRICE)) AS OP_VAT \n");
			//운영율 적용 부과세
			sbSql.append("     , DECODE(A.FLAG,1  \n");
			sbSql.append("     			,DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * ROUND(A.TRANS_QTY * A.SAL_OPER_PRICE))  \n");
			sbSql.append("     			,DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.SALE_VAT)  \n");
			sbSql.append("     )  AS OP_VAT  \n");
			//sbSql.append("     , DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.TRANS_QTY * A.SAL_OPER_PRICE)) AS OP_TOT \n");
			//운영율 적용 토탈금액
			sbSql.append("     , DECODE(A.FLAG,1   \n");
			sbSql.append("     			,DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.TRANS_QTY * A.SAL_OPER_PRICE))\n");
			sbSql.append("     			,DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.TRANS_QTY * A.SAL_OPER_PRICE + SALE_VAT)  \n");
			sbSql.append("     )  AS OP_TOT  \n");
			sbSql.append("		,B.GRP_CD EPRO_FILE_GRP	 \n");
			sbSql.append("  FROM  FMS_TRANSACTION_V A  \n");

			
			/*
			sbSql.append("	, ( SELECT B.PO_NO,B.PO_LNO, C.GRP_CD	                \n");
			sbSql.append("	       FROM EPROCUSR.ESPPODT A,                         \n");
			sbSql.append("				EPROCUSR.ESPPODT_ESAATTH B,                 \n");
			sbSql.append("	            EPROCUSR.ESAATTH C                          \n");
			sbSql.append("	       WHERE A.SYS_ID = B.SYS_ID                        \n");
			sbSql.append("				 AND A.COMP_CD = B.COMP_CD                  \n");
			sbSql.append("				 AND A.PO_NO = B.PO_NO                      \n");
			sbSql.append("				 AND A.PO_LNO = B.PO_LNO                    \n");
			sbSql.append("				 AND B.SYS_ID = C.SYS_ID                    \n");
			sbSql.append("				 AND B.GRP_CD = C.GRP_CD                    \n");
			sbSql.append("				 AND A.SYS_ID = '100'                       \n");
			sbSql.append("				 AND A.COMP_CD = 'HFC'                      \n");
			sbSql.append("				 AND C.STS <> 'D'                           \n");
			sbSql.append("			GROUP BY B.PO_NO,B.PO_LNO,C.GRP_CD) B			\n");
			*/
			sbSql.append("			,EPROCUSR.ESPPODT_ESAATTH B			\n");
			
			//회계월과 입고월이 다르면 MG_DATE로 다른달을 조회하고 같으면 NEED_DATE로 조회
			/*
			sbSql.append("     , ( \n");   
			sbSql.append("         SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE  \n");
			sbSql.append("           FROM FMU_OP_RATE \n");
			sbSql.append("          WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
			sbSql.append("            AND USE_YN = 'Y' \n");
			sbSql.append("            AND ITEM_TYPE = 'M' \n");
			sbSql.append("       ) C \n");
			sbSql.append("     , ( \n");        
			sbSql.append("         SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE \n");
			sbSql.append("           FROM FMU_OP_RATE \n");
			sbSql.append("          WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
			sbSql.append("            AND USE_YN = 'Y' \n");
			sbSql.append("            AND ITEM_TYPE = 'C' \n");
			sbSql.append("       ) D \n");
			sbSql.append(" WHERE A.TRANS_DATE BETWEEN C.SDATE(+) AND C.EDATE(+) \n");
			sbSql.append("   AND A.TRANS_DATE BETWEEN D.SDATE(+) AND D.EDATE(+) \n");
			sbSql.append("   AND A.ITEM_CODE = C.ITEM_CODE(+) \n");
			sbSql.append("   AND A.ITEM_CLASS4 = D.ITEM_CODE(+) \n");
			*/
			sbSql.append(" WHERE 1 = 1 \n");			
			sbSql.append("		   AND A.PO_NO = B.PO_NO(+)                                                              \n");
			sbSql.append("		   AND A.PO_LNO = B.PO_LNO(+)                                                            \n");
			
			//운영율 FMU_OP_RATE -> FMS_TRANSACTION_V 수정 문형광 20150919 끝
			if (sDayType.equals("001")) {
				sbSql.append("   AND A.TRANS_DATE2 BETWEEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATET")) + "' \n");	
			} else if (sDayType.equals("002")) {
				sbSql.append("    AND TO_CHAR(TO_DATE(A.TRANS_DATE2, 'YYYYMMDD'), 'YYYYMM') BETWEEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATET")) + "' \n");	
			} else if (sDayType.equals("003")) {
				sbSql.append("   AND  TO_CHAR(TO_DATE(A.TRANS_DATE2, 'YYYYMMDD'), 'YYYY') BETWEEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATET")) + "' \n");	
			}			
			
			sbSql.append("   AND (A.TRANS_TYPE = 'I001' OR (A.TRANS_TYPE LIKE '_002' AND A.SOURCE_TYPE = 'PO')) \n");
			if (! sSubinv.equals(""))	
				sbSql.append("   AND A.SUBINV_CODE LIKE '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) + "%' \n");
			sbSql.append("   AND A.TRANS_UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
			if (! sTaxCode.equals(""))							
				sbSql.append("   AND A.TAX_CODE = '" + sTaxCode + "' \n");
			if (! sItemName.equals(""))							
				sbSql.append("   AND A.ITEM_NAME LIKE '%" + sItemName.replaceAll("'", "''") + "%' \n");
			//sbSql.append(") A \n");
			//sbSql.append(" GROUP BY A.NEED_DATE, A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM, A.TAX_CODE, A.ORIGIN_TYPE, A.OP_PRICE \n");
			
		}
		
		if (sOtCust.equals(""))
			sbSql.append(" UNION ALL \n");
		
		if ((! sOtCust.equals("0000")) || sOtCust.equals(""))
		{
			/*
			sbSql.append("SELECT A.NEED_DATE, A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM \n");
			sbSql.append("     , DECODE(A.TAX_CODE, '100', '과세', '면세') AS TAX_CODE \n");
			sbSql.append("	   , SUM(A.PR_QTY) AS PR_QTY, SUM(A.SALE_PRICE) AS SALE_PRICE, SUM(A.OP_PRICE) AS OP_PRICE \n");
			sbSql.append("     , SUM(ROUND(A.PR_QTY * A.OP_PRICE)) AS OP_AMOUNT \n");
			sbSql.append("     , SUM(ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * ROUND(A.PR_QTY * A.OP_PRICE))) AS OP_VAT \n");
			sbSql.append("     , SUM(ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.PR_QTY * A.OP_PRICE))) AS OP_TOT \n");
			sbSql.append("     , A.ORIGIN_TYPE \n");
			sbSql.append("  FROM \n");
			sbSql.append("( \n");
			*/
			
			if (sDayType.equals("001")) {
				sbSql.append("SELECT TO_CHAR(TO_DATE(A.NEED_DATE,'YYYYMMDD'),'YYYY-MM-DD') AS NEED_DATE \n");
			} else if (sDayType.equals("002")) {
				sbSql.append("SELECT TO_CHAR(TO_DATE(A.NEED_DATE,'YYYYMMDD'),'YYYY-MM') AS NEED_DATE \n");
			} else if (sDayType.equals("003")) {
				sbSql.append("SELECT TO_CHAR(TO_DATE(A.NEED_DATE,'YYYYMMDD'),'YYYY') AS NEED_DATE \n");
			}
			
			
			sbSql.append("     , A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM \n");
			//sbSql.append("     , DECODE(A.TAX_CODE,'100''과세','면세') AS TAX_CODE \n");
			sbSql.append("     , DECODE(A.TAX_CODE, '100', '과세', '면세') AS TAX_CODE \n");
			sbSql.append("     , A.PR_QTY \n");
			sbSql.append("     , A.SALE_PRICE \n");
			sbSql.append("     ,  ( SELECT ORIGIN_TYPE   FROM FMS_ITEM_V  WHERE (1=1)  AND ITEM_CODE = A.ITEM_CODE ) ORIGIN_TYPE \n");
  		//운영율 FMU_OP_RATE -> FMP_OTCUST_PR 수정 문형광 20150919 시작
			/*
			sbSql.append("     , CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
			sbSql.append("            THEN DECODE(SIGN(NVL(C.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE) \n");
			sbSql.append("            WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL \n");
			sbSql.append("            THEN DECODE(SIGN(NVL(D.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL), D.OP_PRICE) \n");
			sbSql.append("       ELSE A.SALE_PRICE END AS OP_PRICE --운영단가 \n");
			*/
			sbSql.append("     , DECODE(NVL(A.OP_PRICE,0), 0, A.SALE_PRICE, A.OP_PRICE) AS OP_PRICE --운영단가 \n");
			sbSql.append("     , ROUND(A.PR_QTY * A.OP_PRICE) AS OP_AMOUNT \n");
			sbSql.append("     , ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * ROUND(A.PR_QTY * A.OP_PRICE)) AS OP_VAT \n");
			sbSql.append("     , ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.PR_QTY * A.OP_PRICE)) AS OP_TOT \n");
			sbSql.append("     , NULL AS EPRO_FILE_GRP \n");
			sbSql.append("  FROM  FMP_OTCUST_PR A  \n");
			/*sbSql.append("     , ( \n");   			
			sbSql.append("         SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE \n");
			sbSql.append("           FROM FMU_OP_RATE \n");
			sbSql.append("          WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
			sbSql.append("            AND USE_YN = 'Y' \n");
			sbSql.append("            AND ITEM_TYPE = 'M' \n");
			sbSql.append("       ) C \n");
			sbSql.append("     , ( \n");        
			sbSql.append("         SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE \n");
			sbSql.append("           FROM FMU_OP_RATE \n");
			sbSql.append("          WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
			sbSql.append("            AND USE_YN = 'Y' \n");
			sbSql.append("            AND ITEM_TYPE = 'C' \n");
			sbSql.append("       ) D \n");
			sbSql.append(" WHERE A.NEED_DATE BETWEEN C.SDATE(+) AND C.EDATE(+) \n");
			sbSql.append("   AND A.NEED_DATE BETWEEN D.SDATE(+) AND D.EDATE(+) \n");
			sbSql.append("   AND A.ITEM_CODE = C.ITEM_CODE(+) \n");
			sbSql.append("   AND A.ITEM_CLASS4 = D.ITEM_CODE(+) \n");
      */
      sbSql.append(" WHERE 1=1 \n");
      //운영율 FMU_OP_RATE -> FMS_TRANSACTION_V 수정 문형광 20150919 끝
			sbSql.append("   AND A.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
			if (! sSubinv.equals(""))	
                sbSql.append("   AND A.SUBINV_CODE = '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) + "' \n");
			
			if (sDayType.equals("001")) {
				sbSql.append("   AND A.NEED_DATE BETWEEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATET")) + "' \n");	
			} else if (sDayType.equals("002")) {
				sbSql.append("   AND TO_CHAR(TO_DATE(A.NEED_DATE, 'YYYYMMDD'), 'YYYYMM') BETWEEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATET")) + "' \n");	
			} else if (sDayType.equals("003")) {
				sbSql.append("   AND TO_CHAR(TO_DATE(A.NEED_DATE, 'YYYYMMDD'), 'YYYY') BETWEEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATET")) + "' \n");	
			}			
			
			if (! sOtCust.equals(""))
				sbSql.append("   AND A.OTCUSTCD = '" + nullToBlank(ds_cond.getString(0, "OTCUSTCD")) + "' \n");
			if ( !sTaxCode.equals(""))							
				sbSql.append("   AND A.TAX_CODE = '" + sTaxCode + "' \n");
			if (! sItemName.equals(""))							
				sbSql.append("   AND A.ITEM_NAME LIKE '%" + sItemName.replaceAll("'", "''") + "%' \n");
			sbSql.append("   AND A.LINE_STATUS <> '003' \n");
			/*
			sbSql.append(") A \n");
			sbSql.append(" GROUP BY A.NEED_DATE, A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM, A.TAX_CODE, A.ORIGIN_TYPE \n");
			*/
		}
		/*
		if (sOtCust.equals(""))
			sbSql.append(") T \n");
			*/
		sbSql.append(" ORDER BY 1, 2 \n");

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


		//out 데이타
		DataSet ds_list;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		String sOtCust = nullToBlank(ds_cond.getString(0, "OTCUSTCD"));
		String sTaxCode = nullToBlank(ds_cond.getString(0, "TAX_CODE"));
		String sItemName = nullToBlank(ds_cond.getString(0, "ITEM_NAME"));
		
		//내역조회
		if (sOtCust.equals(""))
		{
			sbSql.append("SELECT A.* \n");
			sbSql.append("  FROM \n");
			sbSql.append("( \n");
		}
		if (sOtCust.equals("0000") || sOtCust.equals(""))
		{
			sbSql.append("SELECT TO_CHAR(TO_DATE(A.TRANS_DATE,'YYYYMMDD'),'YYYY-MM-DD') AS NEED_DATE \n");
			sbSql.append("     , A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.TRANS_UOM AS PO_UOM \n");
			sbSql.append("     , DECODE(A.TAX_CODE,'100','과세','면세') AS TAX_CODE \n");				
			sbSql.append("     , DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * A.TRANS_QTY AS PR_QTY \n");
			sbSql.append("     , A.SALE_PRICE \n");
			sbSql.append("     , DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE) AS OP_PRICE \n");
			sbSql.append("     , DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.TRANS_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)) AS OP_AMOUNT \n");
			sbSql.append("     , DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * ROUND(A.TRANS_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))) AS OP_VAT \n");
			sbSql.append("     , DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.TRANS_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))) AS OP_TOT \n");
			sbSql.append("  FROM HLDC_PO_TRANSACTION A, FMU_OP_RATE C \n");
			sbSql.append(" WHERE A.TRANS_UPJANG = C.UPJANG(+) \n");
			sbSql.append("   AND A.TRANS_DATE BETWEEN C.SDATE(+) AND C.EDATE(+) \n");
			sbSql.append("   AND A.ITEM_CODE BETWEEN C.ITEM_CODE(+) AND C.ITEM_CODE(+)||'9999' \n");
			sbSql.append("   AND C.USE_YN(+) = 'Y' \n");
			sbSql.append("   AND A.TRANS_DATE BETWEEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATET")) + "' \n");
			sbSql.append("   AND (A.TRANS_TYPE = 'I001' OR (A.TRANS_TYPE LIKE '_002' AND A.SOURCE_TYPE = 'PO')) \n");
			sbSql.append("   AND A.SUBINV_CODE = '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) + "' \n");
			sbSql.append("   AND A.TRANS_UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
			if (! sTaxCode.equals(""))							
				sbSql.append("   AND A.TAX_CODE = '" + sTaxCode + "' \n");
			if (! sItemName.equals(""))							
				sbSql.append("   AND A.ITEM_NAME LIKE '%" + sItemName + "%' \n");
		}
		if (sOtCust.equals(""))
			sbSql.append(" UNION ALL \n");
		if ((! sOtCust.equals("0000")) || sOtCust.equals(""))
		{
			sbSql.append("SELECT TO_CHAR(TO_DATE(A.NEED_DATE,'YYYYMMDD'),'YYYY-MM-DD') AS NEED_DATE \n");
			sbSql.append("     , A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM \n");
			sbSql.append("     , DECODE(A.TAX_CODE,'100''과세','면세') AS TAX_CODE \n");				
			sbSql.append("     , A.PR_QTY \n");
			sbSql.append("     , A.SALE_PRICE \n");
			sbSql.append("     , DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE) AS OP_PRICE \n");
			sbSql.append("     , ROUND(A.PR_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)) AS OP_AMOUNT \n");
			sbSql.append("     , ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * ROUND(A.PR_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))) AS OP_VAT \n");
			sbSql.append("     , ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.PR_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))) AS OP_TOT \n");
			sbSql.append("  FROM FMP_OTCUST_PR A, FMU_OP_RATE C \n");
			sbSql.append(" WHERE A.UPJANG = C.UPJANG(+) \n");
			sbSql.append("   AND A.NEED_DATE BETWEEN C.SDATE(+) AND C.EDATE(+) \n");
			sbSql.append("   AND A.ITEM_CODE BETWEEN C.ITEM_CODE(+) AND C.ITEM_CODE(+)||'9999' \n");
			sbSql.append("   AND C.USE_YN(+) = 'Y' \n");
			sbSql.append("   AND A.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
			sbSql.append("   AND A.SUBINV_CODE = '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) + "' \n");
			sbSql.append("   AND A.NEED_DATE BETWEEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATET")) + "' \n");
			if (! sOtCust.equals(""))
				sbSql.append("   AND A.OTCUSTCD = '" + nullToBlank(ds_cond.getString(0, "OTCUSTCD")) + "' \n");
			if ( !sTaxCode.equals(""))							
				sbSql.append("   AND A.TAX_CODE = '" + sTaxCode + "' \n");
			if (! sItemName.equals(""))							
				sbSql.append("   AND A.ITEM_NAME LIKE '%" + sItemName + "%' \n");
			sbSql.append("   AND A.LINE_STATUS <> '003' \n");
		}
		if (sOtCust.equals(""))
			sbSql.append(") A \n");
		sbSql.append(" ORDER BY 1, 2 \n");

out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_list = this.makeDataSet(rs, "ds_List");
		
		pstmt.close();
		rs.close();
		
		//FileLog.println("d:\\aaa.txt", ds_list);

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
