<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/수불관리
■ 프로그램ID   : FMP00630V_T001.jsp
■ 프로그램명   : 거래실적집계
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
		String sType        = nullToBlank(in_vl.getString("sType"));
		String sAll         = nullToBlank(in_vl.getString("sAll"));
		String sExc         = nullToBlank(in_vl.getString("sExc"));
		//FileLog.println("d:\\aaa.txt", ds_cond);


		//out 데이타
		DataSet ds_list;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		//
		String sOtCust = nullToBlank(ds_cond.getString(0, "OTCUSTCD"));
		String sSubinv = nullToBlank(ds_cond.getString(0, "SUBINV_CODE"));
		//내역조회
		if (sOtCust.equals(""))
		{
			sbSql.append("SELECT A.NEED_DATE, A.SUBINV_CODE, A.SUBINV_NAME_DISP \n");
			sbSql.append("     , SUM(OP_AMOUNT) AS OP_AMOUNT \n");
			sbSql.append("     , SUM(OP_NOTAX) AS OP_NOTAX \n");
			sbSql.append("     , SUM(OP_TAX) AS OP_TAX \n");
			sbSql.append("     , SUM(OP_VAT) AS OP_VAT \n");
			sbSql.append("     , SUM(OP_TOT) AS OP_TOT \n");
			sbSql.append("  FROM \n");
			sbSql.append("( \n");
		}
		if (sOtCust.equals("0000") || sOtCust.equals(""))
		{
			if (sType.equals("001"))
				sbSql.append("SELECT TO_CHAR(TO_DATE(A.TRANS_DATE2,'YYYYMMDD'),'YYYY-MM-DD') AS NEED_DATE \n");
			else
				sbSql.append("SELECT TO_CHAR(TO_DATE(SUBSTR(A.TRANS_DATE2,1,6),'YYYYMM'),'YYYY-MM') AS NEED_DATE \n");
			
			if (sAll.equals("FALSE") && sSubinv.equals("%"))
				sbSql.append("     , '%' AS SUBINV_CODE, '식당 전체' AS SUBINV_NAME_DISP \n");
			else
				sbSql.append("     , A.SUBINV_CODE, Z.SUBINV_NAME_DISP \n");
			
			if (sExc.equals("TRUE")) {
				sbSql.append("         ,SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.SALE_PRICE*A.TRANS_QTY)) AS OP_AMOUNT \n");
				sbSql.append("         ,SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.TAX_CODE,'100',0,ROUND(A.SALE_PRICE*A.TRANS_QTY))) AS OP_NOTAX \n");
				sbSql.append("         ,SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.TAX_CODE,'100',ROUND(A.SALE_PRICE*A.TRANS_QTY),0)) AS OP_TAX \n");
				//sbSql.append("         ,SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * ROUND(A.SALE_PRICE*A.TRANS_QTY))) AS OP_VAT \n");	
				//sbSql.append("         ,SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.SALE_PRICE*A.TRANS_QTY))) AS OP_TOT \n");
				//운영율 미적용 부과세
				sbSql.append("     , SUM(DECODE(A.FLAG,1  \n");
				sbSql.append("     			,DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * ROUND(A.TRANS_QTY * A.SALE_PRICE))  \n");
				sbSql.append("     			,DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(SALE_VAT)  \n");
				sbSql.append("     ))  AS OP_VAT  \n");
				//운영율 미적용 토탈금액
				sbSql.append("     , SUM(DECODE(A.FLAG,1   \n");
				sbSql.append("     			,DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.TRANS_QTY * A.SALE_PRICE))\n");
				sbSql.append("     			,DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.TRANS_QTY * A.SAL_OPER_PRICE + SALE_VAT)  \n");
				sbSql.append("     ))  AS OP_TOT  \n");
			}else{
				sbSql.append("         ,SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.SAL_OPER_PRICE, 0, ROUND(A.SALE_PRICE*A.TRANS_QTY), ROUND(A.SAL_OPER_PRICE*A.TRANS_QTY))) AS OP_AMOUNT \n");
				sbSql.append("         ,SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.TAX_CODE,'100',0,DECODE(A.SAL_OPER_PRICE, 0, ROUND(A.SALE_PRICE*A.TRANS_QTY), ROUND(A.SAL_OPER_PRICE*A.TRANS_QTY)))) AS OP_NOTAX \n");
				sbSql.append("         ,SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.TAX_CODE,'100',DECODE(A.SAL_OPER_PRICE, 0, ROUND(A.SALE_PRICE*A.TRANS_QTY), ROUND(A.SAL_OPER_PRICE*A.TRANS_QTY)),0)) AS OP_TAX \n");
				//sbSql.append("         ,SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * DECODE(A.SAL_OPER_PRICE, 0, ROUND(A.SALE_PRICE*A.TRANS_QTY), ROUND(A.SAL_OPER_PRICE*A.TRANS_QTY)))) AS OP_VAT \n");	
				//sbSql.append("         ,SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * DECODE(A.SAL_OPER_PRICE, 0, ROUND(A.SALE_PRICE*A.TRANS_QTY), ROUND(A.SAL_OPER_PRICE*A.TRANS_QTY)))) AS OP_TOT \n");
				//운영율 적용 부과세
				sbSql.append("     , SUM(DECODE(A.FLAG,1  \n");
				sbSql.append("     			,DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * ROUND(A.TRANS_QTY * A.SAL_OPER_PRICE))\n");
				sbSql.append("     			,DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(SALE_VAT)  \n");
				sbSql.append("     ))  AS OP_VAT  \n");
				//운영율 적용 토탈금액
				sbSql.append("     , SUM(DECODE(A.FLAG,1   \n");
				sbSql.append("     			,DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.TRANS_QTY * A.SAL_OPER_PRICE))\n");
				sbSql.append("     			,DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.TRANS_QTY * A.SALE_PRICE) + SALE_VAT  \n");
				sbSql.append("     ))  AS OP_TOT  \n");
			}
			
			//sbSql.append("           FROM (SELECT A.* , DECODE(SUBSTR(A.TRANS_DATE,1,6), SUBSTR(A.MG_DATE,1,6), A.TRANS_DATE, MG_DATE) AS AA_DATE, B.ITEM_CLASS4, B.CONSUM_YN FROM FMS_TRANSACTION_V A, FMS_ITEM_V B WHERE A.ITEM_CODE = B.ITEM_CODE) A, FMS_SUBINVENTORY Z \n");
			//속도개선 : 불필요 필드 및 조인 삭제 김호석 2017.11.06
			sbSql.append("           FROM  FMS_TRANSACTION_V A, FMS_SUBINVENTORY Z \n");
			
			/* if (sExc.equals("TRUE")) {
				sbSql.append("     ,(SELECT 0 AS UPJANG, 0 AS CEIL_VAL, NULL AS SDATE, NULL AS EDATE, NULL AS ITEM_CODE, 0 AS OP_PRICE, 0 AS OP_RATE, NULL AS USE_YN FROM DUAL) C \n");
				sbSql.append("     ,(SELECT 0 AS UPJANG, 0 AS CEIL_VAL, NULL AS SDATE, NULL AS EDATE, NULL AS ITEM_CODE, 0 AS OP_PRICE, 0 AS OP_RATE, NULL AS USE_YN FROM DUAL) D \n");
			}	 */	
			
			sbSql.append(" WHERE A.SUBINV_CODE = Z.SUBINV_CODE \n");			
			sbSql.append("   AND A.TRANS_DATE2 BETWEEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATET")) + "' \n");
			sbSql.append("   AND (A.TRANS_TYPE = 'I001' OR (A.TRANS_TYPE LIKE '_002' AND A.SOURCE_TYPE = 'PO')) \n");
			
			if (sAll.equals("FALSE"))
				sbSql.append("   AND A.SUBINV_CODE LIKE '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) + "' \n");
			
			sbSql.append("   AND A.TRANS_UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
			
			if (sType.equals("001"))
				sbSql.append(" GROUP BY A.TRANS_DATE2 \n");			
			else
				sbSql.append(" GROUP BY SUBSTR(A.TRANS_DATE2,1,6) \n");
			
			if (!(sAll.equals("FALSE") && sSubinv.equals("%")))
				sbSql.append("        , A.SUBINV_CODE, Z.SUBINV_NAME_DISP \n");
			
			if (sAll.equals("TRUE"))
			{
				sbSql.append("----------- \n");
				sbSql.append(" UNION ALL \n");
				sbSql.append("----------- \n");
				sbSql.append("SELECT '소계' AS NEED_DATE \n");
				sbSql.append("     , A.SUBINV_CODE, Z.SUBINV_NAME_DISP \n");			
				
				if (sExc.equals("TRUE")) {
					sbSql.append("         ,SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.SALE_PRICE*A.TRANS_QTY)) AS OP_AMOUNT \n");
					sbSql.append("         ,SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.TAX_CODE,'100',0,ROUND(A.SALE_PRICE*A.TRANS_QTY))) AS OP_NOTAX \n");
					sbSql.append("         ,SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.TAX_CODE,'100',ROUND(A.SALE_PRICE*A.TRANS_QTY),0)) AS OP_TAX \n");
					sbSql.append("         ,SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * ROUND(A.SALE_PRICE*A.TRANS_QTY))) AS OP_VAT \n");	
					sbSql.append("         ,SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.SALE_PRICE*A.TRANS_QTY))) AS OP_TOT \n");
					
				}else{
					sbSql.append("         ,SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.SAL_OPER_PRICE, 0, ROUND(A.SALE_PRICE*A.TRANS_QTY), ROUND(A.SAL_OPER_PRICE*A.TRANS_QTY))) AS OP_AMOUNT \n");
					sbSql.append("         ,SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.TAX_CODE,'100',0,DECODE(A.SAL_OPER_PRICE, 0, ROUND(A.SALE_PRICE*A.TRANS_QTY), ROUND(A.SAL_OPER_PRICE*A.TRANS_QTY)))) AS OP_NOTAX \n");
					sbSql.append("         ,SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.TAX_CODE,'100',DECODE(A.SAL_OPER_PRICE, 0, ROUND(A.SALE_PRICE*A.TRANS_QTY), ROUND(A.SAL_OPER_PRICE*A.TRANS_QTY)),0)) AS OP_TAX \n");
					sbSql.append("         ,SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * DECODE(A.SAL_OPER_PRICE, 0, ROUND(A.SALE_PRICE*A.TRANS_QTY), ROUND(A.SAL_OPER_PRICE*A.TRANS_QTY)))) AS OP_VAT \n");	
					sbSql.append("         ,SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * DECODE(A.SAL_OPER_PRICE, 0, ROUND(A.SALE_PRICE*A.TRANS_QTY), ROUND(A.SAL_OPER_PRICE*A.TRANS_QTY)))) AS OP_TOT \n");
				}
				
				//sbSql.append("           FROM (SELECT A.* , DECODE(SUBSTR(A.TRANS_DATE,1,6), SUBSTR(A.MG_DATE,1,6), A.TRANS_DATE, MG_DATE) AS AA_DATE, B.ITEM_CLASS4, B.CONSUM_YN FROM FMS_TRANSACTION_V A, FMS_ITEM_V B WHERE A.ITEM_CODE = B.ITEM_CODE) A, FMS_SUBINVENTORY Z \n");
				//속도개선 : 불필요 필드 및 조인 삭제 김호석 2017.11.06
				sbSql.append("           FROM FMS_TRANSACTION_V A, FMS_SUBINVENTORY Z \n");
				
				sbSql.append(" WHERE A.SUBINV_CODE = Z.SUBINV_CODE \n");	
		        sbSql.append("   AND A.TRANS_DATE2 BETWEEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATET")) + "' \n");
				sbSql.append("   AND (A.TRANS_TYPE = 'I001' OR (A.TRANS_TYPE LIKE '_002' AND A.SOURCE_TYPE = 'PO')) \n");
				
				if (sAll.equals("FALSE"))
					sbSql.append("   AND A.SUBINV_CODE LIKE '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) + "' \n");
				
				sbSql.append("   AND A.TRANS_UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
				sbSql.append(" GROUP BY A.SUBINV_CODE, Z.SUBINV_NAME_DISP \n");
			}
		}
		
		if (sOtCust.equals(""))
			sbSql.append(" UNION ALL \n");
		
		if ((! sOtCust.equals("0000")) || sOtCust.equals(""))
		{
			if (sType.equals("001"))
				sbSql.append("SELECT TO_CHAR(TO_DATE(A.NEED_DATE,'YYYYMMDD'),'YYYY-MM-DD') AS NEED_DATE \n");
			else
				sbSql.append("SELECT TO_CHAR(TO_DATE(SUBSTR(A.NEED_DATE,1,6),'YYYYMM'),'YYYY-MM') AS NEED_DATE \n");
			
			if (sAll.equals("FALSE") && sSubinv.equals("%"))
				sbSql.append("     , '%' AS SUBINV_CODE, '식당 전체' AS SUBINV_NAME_DISP \n");
			else
				sbSql.append("     , A.SUBINV_CODE, Z.SUBINV_NAME_DISP \n");
			
			if (sExc.equals("TRUE")) {
				sbSql.append("         ,SUM(A.OP_AMOUNT) AS OP_AMOUNT \n");				
				sbSql.append("         ,SUM(DECODE(A.TAX_CODE,'100',0,A.OP_AMOUNT)) AS OP_NOTAX \n");				
				sbSql.append("         ,SUM(DECODE(A.TAX_CODE,'100',A.OP_AMOUNT,0)) AS OP_TAX \n");				
				sbSql.append("         ,SUM(ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * A.OP_AMOUNT,0)) AS OP_VAT \n");				
				sbSql.append("         ,SUM(ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * A.OP_AMOUNT,0)) AS OP_TOT \n");
			} else {
				sbSql.append("         ,SUM(A.OP_AMOUNT) AS OP_AMOUNT \n");				
				sbSql.append("         ,SUM(DECODE(A.TAX_CODE,'100',0,A.OP_AMOUNT)) AS OP_NOTAX \n");				
				sbSql.append("         ,SUM(DECODE(A.TAX_CODE,'100',A.OP_AMOUNT,0)) AS OP_TAX \n");				
				sbSql.append("         ,SUM(ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * A.OP_AMOUNT,0)) AS OP_VAT \n");				
				sbSql.append("         ,SUM(ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * A.OP_AMOUNT,0)) AS OP_TOT \n");
			}	
			
			sbSql.append("          FROM (SELECT A.* , B.ITEM_CLASS4, B.CONSUM_YN FROM FMP_OTCUST_PR A, FMS_ITEM_V B WHERE A.ITEM_CODE = B.ITEM_CODE) A, FMS_SUBINVENTORY Z \n");
			
			/* if (sExc.equals("TRUE")) {
				sbSql.append("     ,(SELECT 0 AS UPJANG, 0 AS CEIL_VAL, NULL AS SDATE, NULL AS EDATE, NULL AS ITEM_CODE, 0 AS OP_PRICE, 0 AS OP_RATE, NULL AS USE_YN FROM DUAL) C \n");
				sbSql.append("     ,(SELECT 0 AS UPJANG, 0 AS CEIL_VAL, NULL AS SDATE, NULL AS EDATE, NULL AS ITEM_CODE, 0 AS OP_PRICE, 0 AS OP_RATE, NULL AS USE_YN FROM DUAL) D \n");
			} */
			
			sbSql.append(" WHERE A.SUBINV_CODE = Z.SUBINV_CODE \n");
			sbSql.append("   AND A.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
			
			if (sAll.equals("FALSE"))
				sbSql.append("   AND A.SUBINV_CODE LIKE '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) + "' \n");
			
			sbSql.append("   AND A.NEED_DATE BETWEEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATET")) + "' \n");
			
			if (! sOtCust.equals(""))
				sbSql.append("   AND A.OTCUSTCD = '" + nullToBlank(ds_cond.getString(0, "OTCUSTCD")) + "' \n");
			
			sbSql.append("   AND A.LINE_STATUS <> '003' \n");
			
			if (sType.equals("001"))
				sbSql.append(" GROUP BY A.NEED_DATE \n");
			else
				sbSql.append(" GROUP BY SUBSTR(A.NEED_DATE,1,6) \n");
			
			if (!(sAll.equals("FALSE") && sSubinv.equals("%")))
				sbSql.append("        , A.SUBINV_CODE, Z.SUBINV_NAME_DISP \n");
			
			if (sAll.equals("TRUE"))
			{
				sbSql.append("----------- \n");
				sbSql.append(" UNION ALL \n");
				sbSql.append("----------- \n");
				sbSql.append("SELECT '소계' AS NEED_DATE \n");
				sbSql.append("     , A.SUBINV_CODE, Z.SUBINV_NAME_DISP \n");
				
				//////////////////////////////////////////////////////////////////////////////////////////////////
				if (sExc.equals("TRUE")) {
					sbSql.append("         ,SUM(A.OP_AMOUNT) AS OP_AMOUNT \n");				
					sbSql.append("         ,SUM(DECODE(A.TAX_CODE,'100',0,A.OP_AMOUNT)) AS OP_NOTAX \n");				
					sbSql.append("         ,SUM(DECODE(A.TAX_CODE,'100',A.OP_AMOUNT,0)) AS OP_TAX \n");				
					sbSql.append("         ,SUM(ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * A.OP_AMOUNT,0)) AS OP_VAT \n");				
					sbSql.append("         ,SUM(ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * A.OP_AMOUNT,0)) AS OP_TOT \n");
				} else {
					sbSql.append("         ,SUM(A.OP_AMOUNT) AS OP_AMOUNT \n");				
					sbSql.append("         ,SUM(DECODE(A.TAX_CODE,'100',0,A.OP_AMOUNT)) AS OP_NOTAX \n");				
					sbSql.append("         ,SUM(DECODE(A.TAX_CODE,'100',A.OP_AMOUNT,0)) AS OP_TAX \n");				
					sbSql.append("         ,SUM(ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * A.OP_AMOUNT,0)) AS OP_VAT \n");				
					sbSql.append("         ,SUM(ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * A.OP_AMOUNT,0)) AS OP_TOT \n");
				}		
				//////////////////////////////////////////////////////////////////////////////////////////////////	
				
				sbSql.append("           FROM (SELECT A.* , B.ITEM_CLASS4, B.CONSUM_YN FROM FMP_OTCUST_PR A, FMS_ITEM_V B WHERE A.ITEM_CODE = B.ITEM_CODE) A, FMS_SUBINVENTORY Z \n");
				
				/* if (sExc.equals("TRUE")) {
					sbSql.append("     ,(SELECT 0 AS UPJANG, 0 AS CEIL_VAL, NULL AS SDATE, NULL AS EDATE, NULL AS ITEM_CODE, 0 AS OP_PRICE, 0 AS OP_RATE, NULL AS USE_YN FROM DUAL) C \n");
					sbSql.append("     ,(SELECT 0 AS UPJANG, 0 AS CEIL_VAL, NULL AS SDATE, NULL AS EDATE, NULL AS ITEM_CODE, 0 AS OP_PRICE, 0 AS OP_RATE, NULL AS USE_YN FROM DUAL) D \n");
				} */
				
				sbSql.append(" WHERE A.SUBINV_CODE = Z.SUBINV_CODE \n");
				sbSql.append("   AND A.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
				
				if (sAll.equals("FALSE"))
					sbSql.append("   AND A.SUBINV_CODE LIKE '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) + "' \n");
				
				sbSql.append("   AND A.NEED_DATE BETWEEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATET")) + "' \n");
				
				if (! sOtCust.equals(""))
					sbSql.append("   AND A.OTCUSTCD = '" + nullToBlank(ds_cond.getString(0, "OTCUSTCD")) + "' \n");
				
				sbSql.append("   AND A.LINE_STATUS <> '003' \n");
				sbSql.append(" GROUP BY A.SUBINV_CODE, Z.SUBINV_NAME_DISP \n");
			}
		}
		
		if (sOtCust.equals(""))
		{
			sbSql.append(") A \n");
			sbSql.append(" GROUP BY A.SUBINV_CODE, A.SUBINV_NAME_DISP, A.NEED_DATE \n");
			sbSql.append(" ORDER BY A.NEED_DATE, A.SUBINV_CODE, A.SUBINV_NAME_DISP \n");
		}

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
		String sType        = nullToBlank(in_vl.getString("sType"));
		String sAll         = nullToBlank(in_vl.getString("sAll"));
		String sExc         = nullToBlank(in_vl.getString("sExc"));
		//FileLog.println("d:\\aaa.txt", ds_cond);


		//out 데이타
		DataSet ds_list;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		//
		String sOtCust = nullToBlank(ds_cond.getString(0, "OTCUSTCD"));
		String sSubinv = nullToBlank(ds_cond.getString(0, "SUBINV_CODE"));
		//내역조회
		if (sOtCust.equals(""))
		{
			sbSql.append("SELECT A.NEED_DATE, A.SUBINV_CODE, A.SUBINV_NAME_DISP \n");
			sbSql.append("     , SUM(OP_AMOUNT) AS OP_AMOUNT \n");
			sbSql.append("     , SUM(OP_NOTAX) AS OP_NOTAX \n");
			sbSql.append("     , SUM(OP_TAX) AS OP_TAX \n");
			sbSql.append("     , SUM(OP_VAT) AS OP_VAT \n");
			sbSql.append("     , SUM(OP_TOT) AS OP_TOT \n");
			sbSql.append("  FROM \n");
			sbSql.append("( \n");
		}
		if (sOtCust.equals("0000") || sOtCust.equals(""))
		{
			if (sType.equals("001"))
				sbSql.append("SELECT TO_CHAR(TO_DATE(A.TRANS_DATE,'YYYYMMDD'),'YYYY-MM-DD') AS NEED_DATE \n");
			else
				sbSql.append("SELECT TO_CHAR(TO_DATE(SUBSTR(A.TRANS_DATE,1,6),'YYYYMM'),'YYYY-MM') AS NEED_DATE \n");
			if (sAll.equals("FALSE") && sSubinv.equals("%"))
				sbSql.append("     , '%' AS SUBINV_CODE, '식당 전체' AS SUBINV_NAME_DISP \n");
			else
			sbSql.append("     , A.SUBINV_CODE, Z.SUBINV_NAME_DISP \n");
			//sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.TRANS_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))) AS OP_AMOUNT \n");
			//운영율 FMU_OP_RATE -> FMS_TRANSACTION_V 수정 강대성 20150919 시작
			/*
			sbSql.append("         ,SUM( CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
			sbSql.append("                    THEN DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.TRANS_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)) \n");
			sbSql.append("                    WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL\n");
			sbSql.append("                    THEN DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.TRANS_QTY * DECODE(NVL(D.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL),D.OP_PRICE)) \n");
			sbSql.append("               ELSE DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.TRANS_QTY * A.SALE_PRICE ) END\n");
			// 아래방식으로 수정필요
			//sbSql.append("               ELSE DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.TRANS_QTY * A.SALE_PRICE)) END\n");
			
			sbSql.append("              ) AS OP_AMOUNT\n");		
			*/
			//운영율 FMU_OP_RATE -> FMS_TRANSACTION_V 수정 강대성 20150919 끝
			sbSql.append("         ,SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.SAL_OPER_PRICE, 0, ROUND(A.SALE_PRICE*A.TRANS_QTY), ROUND(A.SAL_OPER_PRICE*A.TRANS_QTY))) AS OP_AMOUNT \n");
			
			//sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',0,A.TRANS_QTY) * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))) AS OP_NOTAX \n");
			//운영율 FMU_OP_RATE -> FMS_TRANSACTION_V 수정 강대성 20150919 시작
			/*
			sbSql.append("         ,SUM( CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
			sbSql.append("                    THEN DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',0,A.TRANS_QTY) * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)) \n");
			sbSql.append("                    WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL\n");
			sbSql.append("                    THEN DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',0,A.TRANS_QTY) * DECODE(NVL(D.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL),D.OP_PRICE)) \n");
			sbSql.append("               ELSE DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',0,A.TRANS_QTY) * A.SALE_PRICE) END\n");
			sbSql.append("              ) AS OP_NOTAX\n");		
			*/
			//운영율 FMU_OP_RATE -> FMS_TRANSACTION_V 수정 강대성 20150919 끝
			sbSql.append("         ,SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.TAX_CODE,'100',0,DECODE(A.SAL_OPER_PRICE, 0, ROUND(A.SALE_PRICE*A.TRANS_QTY), ROUND(A.SAL_OPER_PRICE*A.TRANS_QTY)))) AS OP_NOTAX \n");
			
			//sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',A.TRANS_QTY,0) * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))) AS OP_TAX \n");
			//운영율 FMU_OP_RATE -> FMS_TRANSACTION_V 수정 강대성 20150919 시작
			/*
			sbSql.append("         ,SUM( CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
			sbSql.append("                    THEN DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',A.TRANS_QTY,0) * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)) \n");
			sbSql.append("                    WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL\n");
			sbSql.append("                    THEN DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',A.TRANS_QTY,0) * DECODE(NVL(D.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL),D.OP_PRICE)) \n");
			sbSql.append("               ELSE DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',A.TRANS_QTY,0) * A.SALE_PRICE) END\n");
			sbSql.append("              ) AS OP_TAX\n");		
			*/
			//운영율 FMU_OP_RATE -> FMS_TRANSACTION_V 수정 강대성 20150919 끝
			sbSql.append("         ,SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.TAX_CODE,'100',0,DECODE(A.SAL_OPER_PRICE, 0, ROUND(A.SALE_PRICE*A.TRANS_QTY), ROUND(A.SAL_OPER_PRICE*A.TRANS_QTY)),0)) AS OP_TAX \n");
			
			//sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * ROUND(A.TRANS_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)))) AS OP_VAT \n");
			//운영율 FMU_OP_RATE -> FMS_TRANSACTION_V 수정 강대성 20150919 시작
			/*
			sbSql.append("         ,SUM( CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
			sbSql.append("                    THEN DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * ROUND(A.TRANS_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))) \n");
			sbSql.append("                    WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL\n");
			sbSql.append("                    THEN DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * ROUND(A.TRANS_QTY * DECODE(NVL(D.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL),D.OP_PRICE))) \n");
			sbSql.append("               ELSE DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * ROUND(A.TRANS_QTY * A.SALE_PRICE)) END\n");
			sbSql.append("              ) AS OP_VAT\n");		
			*/
			//운영율 FMU_OP_RATE -> FMS_TRANSACTION_V 수정 강대성 20150919 끝
			sbSql.append("         , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * DECODE(A.SAL_OPER_PRICE, 0, ROUND(A.SALE_PRICE*A.TRANS_QTY), ROUND(A.SAL_OPER_PRICE*A.TRANS_QTY)))) AS OP_VAT \n");	
			
			//sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.TRANS_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)))) AS OP_TOT \n");
			//운영율 FMU_OP_RATE -> FMS_TRANSACTION_V 수정 강대성 20150919 시작
			/*
			sbSql.append("         ,SUM( CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
			sbSql.append("                    THEN DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.TRANS_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))) \n");
			sbSql.append("                    WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL\n");
			sbSql.append("                    THEN DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.TRANS_QTY * DECODE(NVL(D.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL),D.OP_PRICE))) \n");
			sbSql.append("               ELSE DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.TRANS_QTY * A.SALE_PRICE)) END\n");
			sbSql.append("              ) AS OP_TOT\n");		
			*/
			//운영율 FMU_OP_RATE -> FMS_TRANSACTION_V 수정 강대성 20150919 끝
			sbSql.append("         ,SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * DECODE(A.SAL_OPER_PRICE, 0, ROUND(A.SALE_PRICE*A.TRANS_QTY), ROUND(A.SAL_OPER_PRICE*A.TRANS_QTY)))) AS OP_TOT \n");
			
			//sbSql.append("  FROM HLDC_PO_TRANSACTION A, FMS_SUBINVENTORY Z \n");
			sbSql.append("           FROM (SELECT A.* , B.ITEM_CLASS4, B.CONSUM_YN FROM FMS_TRANSACTION_V A, FMS_ITEM_V B WHERE A.ITEM_CODE = B.ITEM_CODE) A, FMS_SUBINVENTORY Z \n");
			if (sExc.equals("FALSE")) {
				//sbSql.append("     , FMU_OP_RATE C \n");
				//운영율 FMU_OP_RATE -> FMS_TRANSACTION_V 수정 강대성 20150919 시작
				/*
				sbSql.append("     ,( SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE											\n");
			    sbSql.append("          FROM FMU_OP_RATE 																					\n");
			    sbSql.append("         WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " 									\n");
			    sbSql.append("           AND USE_YN = 'Y'																					\n");
			    sbSql.append("           AND ITEM_TYPE = 'M'																				\n");
			    sbSql.append("       ) C																									\n");
			    sbSql.append("      ,( SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE											\n");
			    sbSql.append("           FROM FMU_OP_RATE 																					\n");
			    sbSql.append("          WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " 									\n");
			    sbSql.append("            AND USE_YN = 'Y'																					\n");
			    sbSql.append("            AND ITEM_TYPE = 'C'																				\n");
			    sbSql.append("        ) D																									\n");
				*/
				//운영율 FMU_OP_RATE -> FMS_TRANSACTION_V 수정 강대성 20150919 끝
				
			}else{
				sbSql.append("     ,(SELECT 0 AS UPJANG, 0 AS CEIL_VAL, NULL AS SDATE, NULL AS EDATE, NULL AS ITEM_CODE, 0 AS OP_PRICE, 0 AS OP_RATE, NULL AS USE_YN FROM DUAL) C \n");
				sbSql.append("     ,(SELECT 0 AS UPJANG, 0 AS CEIL_VAL, NULL AS SDATE, NULL AS EDATE, NULL AS ITEM_CODE, 0 AS OP_PRICE, 0 AS OP_RATE, NULL AS USE_YN FROM DUAL) D \n");
			}
			
			sbSql.append(" WHERE A.SUBINV_CODE = Z.SUBINV_CODE \n");
			//sbSql.append("   AND A.TRANS_UPJANG = C.UPJANG(+) \n");
			//sbSql.append("   AND A.TRANS_DATE BETWEEN C.SDATE(+) AND C.EDATE(+) \n");
			//sbSql.append("   AND A.ITEM_CODE BETWEEN C.ITEM_CODE(+) AND C.ITEM_CODE(+)||'9999' \n");
			//sbSql.append("   AND C.USE_YN(+) = 'Y' \n");
			//운영율 FMU_OP_RATE -> FMS_TRANSACTION_V 수정 강대성 20150919 시작
			/*
			sbSql.append("   AND A.ITEM_CODE = C.ITEM_CODE(+) \n");
	        sbSql.append("   AND A.ITEM_CLASS4 = D.ITEM_CODE(+) \n");
	        sbSql.append("   AND A.TRANS_DATE BETWEEN C.SDATE(+) AND C.EDATE(+) \n");
	        sbSql.append("   AND A.TRANS_DATE BETWEEN D.SDATE(+) AND D.EDATE(+) \n");
	        */
			//운영율 FMU_OP_RATE -> FMS_TRANSACTION_V 수정 강대성 20150919 끝
			
			sbSql.append("   AND A.TRANS_DATE BETWEEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATET")) + "' \n");
			sbSql.append("   AND (A.TRANS_TYPE = 'I001' OR (A.TRANS_TYPE LIKE '_002' AND A.SOURCE_TYPE = 'PO')) \n");
			if (sAll.equals("FALSE"))
				sbSql.append("   AND A.SUBINV_CODE LIKE '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) + "' \n");
			sbSql.append("   AND A.TRANS_UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
			if (sType.equals("001"))
				sbSql.append(" GROUP BY A.TRANS_DATE \n");
			else
				sbSql.append(" GROUP BY SUBSTR(A.TRANS_DATE,1,6) \n");
			if (!(sAll.equals("FALSE") && sSubinv.equals("%")))
				sbSql.append("        , A.SUBINV_CODE, Z.SUBINV_NAME_DISP \n");
			if (sAll.equals("TRUE"))
			{
				sbSql.append("----------- \n");
				sbSql.append(" UNION ALL \n");
				sbSql.append("----------- \n");
				sbSql.append("SELECT '소계' AS NEED_DATE \n");
				sbSql.append("     , A.SUBINV_CODE, Z.SUBINV_NAME_DISP \n");
				//sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.TRANS_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))) AS OP_AMOUNT \n");
				//운영율 FMU_OP_RATE -> FMS_TRANSACTION_V 수정 강대성 20150919 시작
				/*
				sbSql.append("         ,SUM( CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
				sbSql.append("                    THEN DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.TRANS_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)) \n");
				sbSql.append("                    WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL\n");
				sbSql.append("                    THEN DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.TRANS_QTY * DECODE(NVL(D.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL),D.OP_PRICE)) \n");
				sbSql.append("               ELSE DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.TRANS_QTY * A.SALE_PRICE) END\n");
				sbSql.append("              ) AS OP_AMOUNT\n");		
				*/
				//운영율 FMU_OP_RATE -> FMS_TRANSACTION_V 수정 강대성 20150919 끝
				sbSql.append("         ,SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.SAL_OPER_PRICE, 0, ROUND(A.SALE_PRICE*A.TRANS_QTY), ROUND(A.SAL_OPER_PRICE*A.TRANS_QTY))) AS OP_AMOUNT \n");
				
				//sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',0,A.TRANS_QTY) * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))) AS OP_NOTAX \n");
				//운영율 FMU_OP_RATE -> FMS_TRANSACTION_V 수정 강대성 20150919 시작
				/*
				sbSql.append("         ,SUM( CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
				sbSql.append("                    THEN DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',0,A.TRANS_QTY) * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)) \n");
				sbSql.append("                    WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL\n");
				sbSql.append("                    THEN DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',0,A.TRANS_QTY) * DECODE(NVL(D.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL),D.OP_PRICE)) \n");
				sbSql.append("               ELSE DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',0,A.TRANS_QTY) * A.SALE_PRICE) END\n");
				sbSql.append("              ) AS OP_NOTAX\n");		
				*/
				//운영율 FMU_OP_RATE -> FMS_TRANSACTION_V 수정 강대성 20150919 끝
				sbSql.append("         ,SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.TAX_CODE,'100',0,DECODE(A.SAL_OPER_PRICE, 0, ROUND(A.SALE_PRICE*A.TRANS_QTY), ROUND(A.SAL_OPER_PRICE*A.TRANS_QTY)))) AS OP_NOTAX \n");
			
				//sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',A.TRANS_QTY,0) * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))) AS OP_TAX \n");
				//운영율 FMU_OP_RATE -> FMS_TRANSACTION_V 수정 강대성 20150919 시작
				/*
				sbSql.append("         ,SUM( CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
				sbSql.append("                    THEN DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',A.TRANS_QTY,0) * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)) \n");
				sbSql.append("                    WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL\n");
				sbSql.append("                    THEN DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',A.TRANS_QTY,0) * DECODE(NVL(D.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL),D.OP_PRICE)) \n");
				sbSql.append("               ELSE DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',A.TRANS_QTY,0) * A.SALE_PRICE) END\n");
				sbSql.append("              ) AS OP_TAX\n");		
				*/
				//운영율 FMU_OP_RATE -> FMS_TRANSACTION_V 수정 강대성 20150919 끝
				sbSql.append("         ,SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.TAX_CODE,'100',0,DECODE(A.SAL_OPER_PRICE, 0, ROUND(A.SALE_PRICE*A.TRANS_QTY), ROUND(A.SAL_OPER_PRICE*A.TRANS_QTY)),0)) AS OP_TAX \n");
			
				//sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * ROUND(A.TRANS_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)))) AS OP_VAT \n");
				//운영율 FMU_OP_RATE -> FMS_TRANSACTION_V 수정 강대성 20150919 시작
				/*
				sbSql.append("         ,SUM( CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
				sbSql.append("                    THEN DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * ROUND(A.TRANS_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))) \n");
				sbSql.append("                    WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL\n");
				sbSql.append("                    THEN DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * ROUND(A.TRANS_QTY * DECODE(NVL(D.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL),D.OP_PRICE))) \n");
				sbSql.append("               ELSE DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * ROUND(A.TRANS_QTY * A.SALE_PRICE)) END\n");
				sbSql.append("              ) AS OP_VAT\n");		
				*/
				//운영율 FMU_OP_RATE -> FMS_TRANSACTION_V 수정 강대성 20150919 끝
				sbSql.append("         , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * DECODE(A.SAL_OPER_PRICE, 0, ROUND(A.SALE_PRICE*A.TRANS_QTY), ROUND(A.SAL_OPER_PRICE*A.TRANS_QTY)))) AS OP_VAT \n");	
			
				//sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.TRANS_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)))) AS OP_TOT \n");
				//운영율 FMU_OP_RATE -> FMS_TRANSACTION_V 수정 강대성 20150919 시작
				/*
				sbSql.append("         ,SUM( CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
				sbSql.append("                    THEN DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.TRANS_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))) \n");
				sbSql.append("                    WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL\n");
				sbSql.append("                    THEN DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.TRANS_QTY * DECODE(NVL(D.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL),D.OP_PRICE))) \n");
				sbSql.append("               ELSE DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.TRANS_QTY * A.SALE_PRICE)) END\n");
				sbSql.append("              ) AS OP_TOT\n");		
				*/
				//운영율 FMU_OP_RATE -> FMS_TRANSACTION_V 수정 강대성 20150919 끝
				sbSql.append("         ,SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * DECODE(A.SAL_OPER_PRICE, 0, ROUND(A.SALE_PRICE*A.TRANS_QTY), ROUND(A.SAL_OPER_PRICE*A.TRANS_QTY)))) AS OP_TOT \n");
			
				//sbSql.append("  FROM HLDC_PO_TRANSACTION A, FMS_SUBINVENTORY Z \n");
				sbSql.append("           FROM (SELECT A.* , B.ITEM_CLASS4, B.CONSUM_YN FROM FMS_TRANSACTION_V A, FMS_ITEM_V B WHERE A.ITEM_CODE = B.ITEM_CODE) A, FMS_SUBINVENTORY Z \n");
				if (sExc.equals("FALSE")) {
					//sbSql.append("     , FMU_OP_RATE C \n");
					//운영율 FMU_OP_RATE -> FMS_TRANSACTION_V 수정 강대성 20150919 시작
					/*
					sbSql.append("     ,( SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE											\n");
				    sbSql.append("          FROM FMU_OP_RATE 																					\n");
				    sbSql.append("         WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " 									\n");
				    sbSql.append("           AND USE_YN = 'Y'																					\n");
				    sbSql.append("           AND ITEM_TYPE = 'M'																				\n");
				    sbSql.append("       ) C																									\n");
				    sbSql.append("      ,( SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE											\n");
				    sbSql.append("           FROM FMU_OP_RATE 																					\n");
				    sbSql.append("          WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " 									\n");
				    sbSql.append("            AND USE_YN = 'Y'																					\n");
				    sbSql.append("            AND ITEM_TYPE = 'C'																				\n");
				    sbSql.append("        ) D																									\n");
					*/
					//운영율 FMU_OP_RATE -> FMS_TRANSACTION_V 수정 강대성 20150919 끝
					
				}else{
					sbSql.append("     ,(SELECT 0 AS UPJANG, 0 AS CEIL_VAL, NULL AS SDATE, NULL AS EDATE, NULL AS ITEM_CODE, 0 AS OP_PRICE, 0 AS OP_RATE, NULL AS USE_YN FROM DUAL) C \n");
					sbSql.append("     ,(SELECT 0 AS UPJANG, 0 AS CEIL_VAL, NULL AS SDATE, NULL AS EDATE, NULL AS ITEM_CODE, 0 AS OP_PRICE, 0 AS OP_RATE, NULL AS USE_YN FROM DUAL) D \n");
				}
				sbSql.append(" WHERE A.SUBINV_CODE = Z.SUBINV_CODE \n");
				//sbSql.append("   AND A.TRANS_UPJANG = C.UPJANG(+) \n");
				//sbSql.append("   AND A.TRANS_DATE BETWEEN C.SDATE(+) AND C.EDATE(+) \n");
				//sbSql.append("   AND A.ITEM_CODE BETWEEN C.ITEM_CODE(+) AND C.ITEM_CODE(+)||'9999' \n");
				//sbSql.append("   AND C.USE_YN(+) = 'Y' \n");
				//운영율 FMU_OP_RATE -> FMS_TRANSACTION_V 수정 강대성 20150919 시작
				/*
				sbSql.append("   AND A.ITEM_CODE = C.ITEM_CODE(+) \n");
		        sbSql.append("   AND A.ITEM_CLASS4 = D.ITEM_CODE(+) \n");
		        sbSql.append("   AND A.TRANS_DATE BETWEEN C.SDATE(+) AND C.EDATE(+) \n");
		        sbSql.append("   AND A.TRANS_DATE BETWEEN D.SDATE(+) AND D.EDATE(+) \n");
		        */
				//운영율 FMU_OP_RATE -> FMS_TRANSACTION_V 수정 강대성 20150919 끝
		        sbSql.append("   AND A.TRANS_DATE BETWEEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATET")) + "' \n");
				sbSql.append("   AND (A.TRANS_TYPE = 'I001' OR (A.TRANS_TYPE LIKE '_002' AND A.SOURCE_TYPE = 'PO')) \n");
				if (sAll.equals("FALSE"))
					sbSql.append("   AND A.SUBINV_CODE LIKE '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) + "' \n");
				sbSql.append("   AND A.TRANS_UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
				sbSql.append(" GROUP BY A.SUBINV_CODE, Z.SUBINV_NAME_DISP \n");
			}
		}
		if (sOtCust.equals(""))
			sbSql.append(" UNION ALL \n");
		if ((! sOtCust.equals("0000")) || sOtCust.equals(""))
		{
			if (sType.equals("001"))
				sbSql.append("SELECT TO_CHAR(TO_DATE(A.NEED_DATE,'YYYYMMDD'),'YYYY-MM-DD') AS NEED_DATE \n");
			else
				sbSql.append("SELECT TO_CHAR(TO_DATE(SUBSTR(A.NEED_DATE,1,6),'YYYYMM'),'YYYY-MM') AS NEED_DATE \n");
			if (sAll.equals("FALSE") && sSubinv.equals("%"))
				sbSql.append("     , '%' AS SUBINV_CODE, '식당 전체' AS SUBINV_NAME_DISP \n");
			else
				sbSql.append("     , A.SUBINV_CODE, Z.SUBINV_NAME_DISP \n");
			//sbSql.append("     , SUM(ROUND(A.PR_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))) AS OP_AMOUNT \n");
			//운영율 FMU_OP_RATE -> FMS_TRANSACTION_V 수정 강대성 20150919 시작
			/*
			sbSql.append("         ,SUM( CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
			sbSql.append("                    THEN ROUND(A.PR_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)) \n");
			sbSql.append("                    WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL\n");
			sbSql.append("                    THEN ROUND(A.PR_QTY * DECODE(NVL(D.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL),D.OP_PRICE)) \n");
			sbSql.append("               ELSE ROUND(A.PR_QTY * A.SALE_PRICE) END\n");
			sbSql.append("              ) AS OP_AMOUNT\n");		
			*/
			//운영율 FMU_OP_RATE -> FMS_TRANSACTION_V 수정 강대성 20150919 끝
			sbSql.append("         ,SUM(A.OP_AMOUNT) AS OP_AMOUNT \n");
			
		    //sbSql.append("     , SUM(ROUND(DECODE(A.TAX_CODE,'100',0,A.PR_QTY) * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))) AS OP_NOTAX \n");
			//운영율 FMU_OP_RATE -> FMS_TRANSACTION_V 수정 강대성 20150919 시작
			/*
			sbSql.append("         ,SUM( CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
			sbSql.append("                    THEN ROUND(DECODE(A.TAX_CODE,'100',0,A.PR_QTY) * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)) \n");
			sbSql.append("                    WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL\n");
			sbSql.append("                    THEN ROUND(DECODE(A.TAX_CODE,'100',0,A.PR_QTY) * DECODE(NVL(D.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL),D.OP_PRICE)) \n");
			sbSql.append("               ELSE ROUND(DECODE(A.TAX_CODE,'100',0,A.PR_QTY) * A.SALE_PRICE) END\n");
			sbSql.append("              ) AS OP_NOTAX\n");		
			*/
			//운영율 FMU_OP_RATE -> FMS_TRANSACTION_V 수정 강대성 20150919 끝
			sbSql.append("         ,SUM(DECODE(A.TAX_CODE,'100',0,A.OP_AMOUNT)) AS OP_NOTAX \n");
			
			//sbSql.append("     , SUM(ROUND(DECODE(A.TAX_CODE,'100',A.PR_QTY,0) * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))) AS OP_TAX \n");
			//운영율 FMU_OP_RATE -> FMS_TRANSACTION_V 수정 강대성 20150919 시작
			/*
			sbSql.append("         ,SUM( CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
			sbSql.append("                    THEN ROUND(DECODE(A.TAX_CODE,'100',A.PR_QTY,0) * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)) \n");
			sbSql.append("                    WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL\n");
			sbSql.append("                    THEN ROUND(DECODE(A.TAX_CODE,'100',A.PR_QTY,0) * DECODE(NVL(D.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL),D.OP_PRICE)) \n");
			sbSql.append("               ELSE ROUND(DECODE(A.TAX_CODE,'100',A.PR_QTY,0) * A.SALE_PRICE) END\n");
			sbSql.append("              ) AS OP_TAX\n");		
			*/
			//운영율 FMU_OP_RATE -> FMS_TRANSACTION_V 수정 강대성 20150919 끝
			sbSql.append("         ,SUM(DECODE(A.TAX_CODE,'100',A.OP_AMOUNT,0)) AS OP_TAX \n");
			
			//sbSql.append("     , SUM(ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * ROUND(A.PR_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)))) AS OP_VAT \n");
			//운영율 FMU_OP_RATE -> FMS_TRANSACTION_V 수정 강대성 20150919 시작
			/*
			sbSql.append("         ,SUM( CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
			sbSql.append("                    THEN ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * ROUND(A.PR_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))) \n");
			sbSql.append("                    WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL\n");
			sbSql.append("                    THEN ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * ROUND(A.PR_QTY * DECODE(NVL(D.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL),D.OP_PRICE))) \n");
			sbSql.append("               ELSE ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * ROUND(A.PR_QTY * A.SALE_PRICE)) END\n");
			sbSql.append("              ) AS OP_VAT\n");		
			*/
			//운영율 FMU_OP_RATE -> FMS_TRANSACTION_V 수정 강대성 20150919 끝
			sbSql.append("         ,SUM(ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * A.OP_AMOUNT,0)) AS OP_VAT \n");
			
			//sbSql.append("     , SUM(ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.PR_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)))) AS OP_TOT \n");
			//운영율 FMU_OP_RATE -> FMS_TRANSACTION_V 수정 강대성 20150919 시작
			/*
			sbSql.append("         ,SUM(ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * A.OP_AMOUNT,0)) AS OP_VAT \n");sbSql.append("         ,SUM( CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
			sbSql.append("                    THEN ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.PR_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))) \n");
			sbSql.append("                    WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL\n");
			sbSql.append("                    THEN ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.PR_QTY * DECODE(NVL(D.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL),D.OP_PRICE))) \n");
			sbSql.append("               ELSE ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.PR_QTY * A.SALE_PRICE)) END\n");
			sbSql.append("              ) AS OP_TOT\n");		
			*/
			//운영율 FMU_OP_RATE -> FMS_TRANSACTION_V 수정 강대성 20150919 끝
			sbSql.append("         ,SUM(ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * A.OP_AMOUNT,0)) AS OP_TOT \n");
			
			//sbSql.append("  FROM FMP_OTCUST_PR A, FMS_SUBINVENTORY Z \n");
			sbSql.append("           FROM (SELECT A.* , B.ITEM_CLASS4, B.CONSUM_YN FROM FMP_OTCUST_PR A, FMS_ITEM_V B WHERE A.ITEM_CODE = B.ITEM_CODE) A, FMS_SUBINVENTORY Z \n");
			if (sExc.equals("FALSE")) {
				//sbSql.append("     , FMU_OP_RATE C \n");
				//운영율 FMU_OP_RATE -> FMS_TRANSACTION_V 수정 강대성 20150919 시작
				/*
				sbSql.append("     ,( SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE											\n");
			    sbSql.append("          FROM FMU_OP_RATE 																					\n");
			    sbSql.append("         WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " 									\n");
			    sbSql.append("           AND USE_YN = 'Y'																					\n");
			    sbSql.append("           AND ITEM_TYPE = 'M'																				\n");
			    sbSql.append("       ) C																									\n");
			    sbSql.append("      ,( SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE											\n");
			    sbSql.append("           FROM FMU_OP_RATE 																					\n");
			    sbSql.append("          WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " 									\n");
			    sbSql.append("            AND USE_YN = 'Y'																					\n");
			    sbSql.append("            AND ITEM_TYPE = 'C'																				\n");
			    sbSql.append("        ) D																									\n");
				*/
				//운영율 FMU_OP_RATE -> FMS_TRANSACTION_V 수정 강대성 20150919 끝
				
			}else{
				sbSql.append("     ,(SELECT 0 AS UPJANG, 0 AS CEIL_VAL, NULL AS SDATE, NULL AS EDATE, NULL AS ITEM_CODE, 0 AS OP_PRICE, 0 AS OP_RATE, NULL AS USE_YN FROM DUAL) C \n");
				sbSql.append("     ,(SELECT 0 AS UPJANG, 0 AS CEIL_VAL, NULL AS SDATE, NULL AS EDATE, NULL AS ITEM_CODE, 0 AS OP_PRICE, 0 AS OP_RATE, NULL AS USE_YN FROM DUAL) D \n");
			}
			sbSql.append(" WHERE A.SUBINV_CODE = Z.SUBINV_CODE \n");
			//sbSql.append("   AND A.UPJANG = C.UPJANG(+) \n");
			//sbSql.append("   AND A.NEED_DATE BETWEEN C.SDATE(+) AND C.EDATE(+) \n");
			//sbSql.append("   AND A.ITEM_CODE BETWEEN C.ITEM_CODE(+) AND C.ITEM_CODE(+)||'9999' \n");
			//sbSql.append("   AND C.USE_YN(+) = 'Y' \n");
			//운영율 FMU_OP_RATE -> FMS_TRANSACTION_V 수정 강대성 20150919 시작
			/*
			sbSql.append("   AND A.ITEM_CODE = C.ITEM_CODE(+) \n");
	        sbSql.append("   AND A.ITEM_CLASS4 = D.ITEM_CODE(+) \n");
	        sbSql.append("   AND A.NEED_DATE BETWEEN C.SDATE(+) AND C.EDATE(+) \n");
	        sbSql.append("   AND A.NEED_DATE BETWEEN D.SDATE(+) AND D.EDATE(+) \n");
	        */
			//운영율 FMU_OP_RATE -> FMS_TRANSACTION_V 수정 강대성 20150919 끝	
			
			sbSql.append("   AND A.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
			if (sAll.equals("FALSE"))
				sbSql.append("   AND A.SUBINV_CODE LIKE '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) + "' \n");
			sbSql.append("   AND A.NEED_DATE BETWEEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATET")) + "' \n");
			if (! sOtCust.equals(""))
				sbSql.append("   AND A.OTCUSTCD = '" + nullToBlank(ds_cond.getString(0, "OTCUSTCD")) + "' \n");
			sbSql.append("   AND A.LINE_STATUS <> '003' \n");
			if (sType.equals("001"))
				sbSql.append(" GROUP BY A.NEED_DATE \n");
			else
				sbSql.append(" GROUP BY SUBSTR(A.NEED_DATE,1,6) \n");
			
			if (!(sAll.equals("FALSE") && sSubinv.equals("%")))
				sbSql.append("        , A.SUBINV_CODE, Z.SUBINV_NAME_DISP \n");
			
			if (sAll.equals("TRUE"))
			{
				sbSql.append("----------- \n");
				sbSql.append(" UNION ALL \n");
				sbSql.append("----------- \n");
				sbSql.append("SELECT '소계' AS NEED_DATE \n");
				sbSql.append("     , A.SUBINV_CODE, Z.SUBINV_NAME_DISP \n");
				//sbSql.append("     , SUM(ROUND(A.PR_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))) AS OP_AMOUNT \n");
				//운영율 FMU_OP_RATE -> FMS_TRANSACTION_V 수정 강대성 20150919 시작
				/*
				sbSql.append("         ,SUM( CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
				sbSql.append("                    THEN ROUND(A.PR_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)) \n");
				sbSql.append("                    WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL\n");
				sbSql.append("                    THEN ROUND(A.PR_QTY * DECODE(NVL(D.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL),D.OP_PRICE)) \n");
				sbSql.append("               ELSE ROUND(A.PR_QTY * A.SALE_PRICE) END\n");
				sbSql.append("              ) AS OP_AMOUNT\n");		
				*/
				//운영율 FMU_OP_RATE -> FMS_TRANSACTION_V 수정 강대성 20150919 끝
				sbSql.append("         ,SUM(A.OP_AMOUNT) AS OP_AMOUNT \n");
				
				//sbSql.append("     , SUM(ROUND(DECODE(A.TAX_CODE,'100',0,A.PR_QTY) * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))) AS OP_NOTAX \n");
				//운영율 FMU_OP_RATE -> FMS_TRANSACTION_V 수정 강대성 20150919 시작
				/*
				sbSql.append("         ,SUM( CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
				sbSql.append("                    THEN ROUND(DECODE(A.TAX_CODE,'100',0,A.PR_QTY) * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)) \n");
				sbSql.append("                    WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL\n");
				sbSql.append("                    THEN ROUND(DECODE(A.TAX_CODE,'100',0,A.PR_QTY) * DECODE(NVL(D.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL),D.OP_PRICE)) \n");
				sbSql.append("               ELSE ROUND(DECODE(A.TAX_CODE,'100',0,A.PR_QTY) * A.SALE_PRICE) END\n");
				sbSql.append("              ) AS OP_NOTAX\n");		
				*/
				//운영율 FMU_OP_RATE -> FMS_TRANSACTION_V 수정 강대성 20150919 끝
				sbSql.append("         ,SUM(DECODE(A.TAX_CODE,'100',0,A.OP_AMOUNT)) AS OP_NOTAX \n");
				
				//sbSql.append("     , SUM(ROUND(DECODE(A.TAX_CODE,'100',A.PR_QTY,0) * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))) AS OP_TAX \n");
				//운영율 FMU_OP_RATE -> FMS_TRANSACTION_V 수정 강대성 20150919 시작
				/*
				sbSql.append("         ,SUM( CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
				sbSql.append("                    THEN ROUND(DECODE(A.TAX_CODE,'100',A.PR_QTY,0) * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)) \n");
				sbSql.append("                    WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL\n");
				sbSql.append("                    THEN ROUND(DECODE(A.TAX_CODE,'100',A.PR_QTY,0) * DECODE(NVL(D.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL),D.OP_PRICE)) \n");
				sbSql.append("               ELSE ROUND(DECODE(A.TAX_CODE,'100',A.PR_QTY,0) * A.SALE_PRICE) END\n");
				sbSql.append("              ) AS OP_TAX\n");		
				*/
				//운영율 FMU_OP_RATE -> FMS_TRANSACTION_V 수정 강대성 20150919 끝
				sbSql.append("         ,SUM(DECODE(A.TAX_CODE,'100',A.OP_AMOUNT,0)) AS OP_TAX \n");
				
				//sbSql.append("     , SUM(ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * ROUND(A.PR_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)))) AS OP_VAT \n");
				//운영율 FMU_OP_RATE -> FMS_TRANSACTION_V 수정 강대성 20150919 시작
				/*
				sbSql.append("         ,SUM( CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
				sbSql.append("                    THEN ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * ROUND(A.PR_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))) \n");
				sbSql.append("                    WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL\n");
				sbSql.append("                    THEN ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * ROUND(A.PR_QTY * DECODE(NVL(D.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL),D.OP_PRICE))) \n");
				sbSql.append("               ELSE ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * ROUND(A.PR_QTY * A.SALE_PRICE)) END\n");
				sbSql.append("              ) AS OP_VAT\n");		
				*/
				//운영율 FMU_OP_RATE -> FMS_TRANSACTION_V 수정 강대성 20150919 끝
				sbSql.append("         ,SUM(ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * A.OP_AMOUNT,0)) AS OP_VAT \n");
				
				//sbSql.append("     , SUM(ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.PR_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)))) AS OP_TOT \n");
				//운영율 FMU_OP_RATE -> FMS_TRANSACTION_V 수정 강대성 20150919 시작
				/*
				sbSql.append("         ,SUM( CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
				sbSql.append("                    THEN ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.PR_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))) \n");
				sbSql.append("                    WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL\n");
				sbSql.append("                    THEN ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.PR_QTY * DECODE(NVL(D.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL),D.OP_PRICE))) \n");
				sbSql.append("               ELSE ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.PR_QTY * A.SALE_PRICE)) END\n");
				sbSql.append("              ) AS OP_TOT\n");		
				*/
				//운영율 FMU_OP_RATE -> FMS_TRANSACTION_V 수정 강대성 20150919 끝
				sbSql.append("         ,SUM(ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * A.OP_AMOUNT,0)) AS OP_TOT \n");
				
				//sbSql.append("  FROM FMP_OTCUST_PR A, FMS_SUBINVENTORY Z \n");
				sbSql.append("           FROM (SELECT A.* , B.ITEM_CLASS4, B.CONSUM_YN FROM FMP_OTCUST_PR A, FMS_ITEM_V B WHERE A.ITEM_CODE = B.ITEM_CODE) A, FMS_SUBINVENTORY Z \n");
				if (sExc.equals("FALSE")) {
					//sbSql.append("     , FMU_OP_RATE C \n");
					//운영율 FMU_OP_RATE -> FMS_TRANSACTION_V 수정 강대성 20150919 시작
					/*
					sbSql.append("     ,( SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE											\n");
				    sbSql.append("          FROM FMU_OP_RATE 																					\n");
				    sbSql.append("         WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " 									\n");
				    sbSql.append("           AND USE_YN = 'Y'																					\n");
				    sbSql.append("           AND ITEM_TYPE = 'M'																				\n");
				    sbSql.append("       ) C																									\n");
				    sbSql.append("      ,( SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE											\n");
				    sbSql.append("           FROM FMU_OP_RATE 																					\n");
				    sbSql.append("          WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " 									\n");
				    sbSql.append("            AND USE_YN = 'Y'																					\n");
				    sbSql.append("            AND ITEM_TYPE = 'C'																				\n");
				    sbSql.append("        ) D																									\n");
					*/
					//운영율 FMU_OP_RATE -> FMS_TRANSACTION_V 수정 강대성 20150919 끝
					
				}else{
					sbSql.append("     ,(SELECT 0 AS UPJANG, 0 AS CEIL_VAL, NULL AS SDATE, NULL AS EDATE, NULL AS ITEM_CODE, 0 AS OP_PRICE, 0 AS OP_RATE, NULL AS USE_YN FROM DUAL) C \n");
					sbSql.append("     ,(SELECT 0 AS UPJANG, 0 AS CEIL_VAL, NULL AS SDATE, NULL AS EDATE, NULL AS ITEM_CODE, 0 AS OP_PRICE, 0 AS OP_RATE, NULL AS USE_YN FROM DUAL) D \n");
				}
				sbSql.append(" WHERE A.SUBINV_CODE = Z.SUBINV_CODE \n");
				//sbSql.append("   AND A.UPJANG = C.UPJANG(+) \n");
				//sbSql.append("   AND A.NEED_DATE BETWEEN C.SDATE(+) AND C.EDATE(+) \n");
				//sbSql.append("   AND A.ITEM_CODE BETWEEN C.ITEM_CODE(+) AND C.ITEM_CODE(+)||'9999' \n");
				//sbSql.append("   AND C.USE_YN(+) = 'Y' \n");
				//운영율 FMU_OP_RATE -> FMS_TRANSACTION_V 수정 강대성 20150919 시작
				/*
				sbSql.append("   AND A.ITEM_CODE = C.ITEM_CODE(+) \n");
		        sbSql.append("   AND A.ITEM_CLASS4 = D.ITEM_CODE(+) \n");
		        sbSql.append("   AND A.NEED_DATE BETWEEN C.SDATE(+) AND C.EDATE(+) \n");
		        sbSql.append("   AND A.NEED_DATE BETWEEN D.SDATE(+) AND D.EDATE(+) \n");
		        */
				//운영율 FMU_OP_RATE -> FMS_TRANSACTION_V 수정 강대성 20150919 끝
				
				sbSql.append("   AND A.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
				if (sAll.equals("FALSE"))
					sbSql.append("   AND A.SUBINV_CODE LIKE '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) + "' \n");
				sbSql.append("   AND A.NEED_DATE BETWEEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATET")) + "' \n");
				if (! sOtCust.equals(""))
					sbSql.append("   AND A.OTCUSTCD = '" + nullToBlank(ds_cond.getString(0, "OTCUSTCD")) + "' \n");
				sbSql.append("   AND A.LINE_STATUS <> '003' \n");
				sbSql.append(" GROUP BY A.SUBINV_CODE, Z.SUBINV_NAME_DISP \n");
			}
			
		}
		if (sOtCust.equals(""))
		{
			sbSql.append(") A \n");
			sbSql.append(" GROUP BY A.SUBINV_CODE, A.SUBINV_NAME_DISP, A.NEED_DATE \n");
			sbSql.append(" ORDER BY A.NEED_DATE, A.SUBINV_CODE, A.SUBINV_NAME_DISP \n");
		}

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
