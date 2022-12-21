<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/수불관리
■ 프로그램ID   : FMP00740V_T001.jsp
■ 프로그램명   : 식재료비 현황
■ 작성일자     : 2008-02-04
■ 작성자       : 박은규
■ 이력관리     : 2008-02-04 - 최초작성
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
		DataSet ds_list, ds_list1;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
				
		//내역조회   1) 상단총액 조회
		sbSql.append("SELECT '매출액' AS STYPE \n");
		sbSql.append("     , SUM(EXP_AMT) AS PLAN_AMT \n");
		sbSql.append("     , SUM(OCCUR_AMT) AS REAL_AMT \n");
		sbSql.append("  FROM (SELECT SUM(A.EXP_AMT) AS EXP_AMT \n");
		sbSql.append("             , 0 AS OCCUR_AMT \n");
		sbSql.append("          FROM FMO_MONTH_PLAN_DTL A \n");
		sbSql.append("         WHERE A.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
		sbSql.append("           AND A.YYMM = SUBSTR('" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "',1,6) \n");
		sbSql.append("        ----------- \n");
		sbSql.append("         UNION ALL \n");
		sbSql.append("        ----------- \n");
		sbSql.append("        SELECT 0 AS EXP_AMT \n");
		sbSql.append("             , SUM(B.OCCUR_AMT) AS REAL_AMT \n");
		sbSql.append("          FROM FMO_ACCT_OCCUR B, FMS_UPJANG C, FMO_ACCOUNT D \n");
		sbSql.append("         WHERE B.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
		sbSql.append("           AND B.OCCUR_DATE BETWEEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATET")) + "' \n");
		sbSql.append("           AND B.UPJANG = C.UPJANG \n");
		sbSql.append("           AND C.MAIN_UPJANG = C.UPJANG \n");
		sbSql.append("           AND B.ACCTCD = D.ACCTCD \n");
		sbSql.append("           AND D.ACCT_TYPE = '001' \n");
		sbSql.append("        ----------- \n");
		sbSql.append("         UNION ALL \n");
		sbSql.append("        ----------- \n");
		sbSql.append("        SELECT 0, 0 FROM DUAL) \n");
		sbSql.append("----------- \n");
		sbSql.append(" UNION ALL \n");
		sbSql.append("----------- \n");
		sbSql.append("SELECT '식재료비' AS STYPE \n");
		sbSql.append("     , SUM(EXP_AMT) AS PLAN_AMT \n");
		sbSql.append("     , SUM(OCCUR_AMT) AS REAL_AMT \n");
		sbSql.append("  FROM (SELECT SUM(ROUND(EXP_AMT * EXP_RATE / 100)) AS EXP_AMT \n");
		sbSql.append("             , 0 AS OCCUR_AMT \n");
		sbSql.append("          FROM FMO_MONTH_PLAN_DTL \n");
		sbSql.append("         WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
		sbSql.append("           AND YYMM = SUBSTR('" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "',1,6) \n");
		sbSql.append("        ----------- \n");
		sbSql.append("         UNION ALL \n");
		sbSql.append("        ----------- \n");
		sbSql.append("        SELECT 0 AS EXP_AMT \n");
		//sbSql.append("             , SUM(ROUND(A.OUT_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.PRICE + ROUND(A.PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))) AS OCCUR_AMT \n");
		//운영율 FMU_OP_RATE -> FMP_SUBUL 수정 문형광 20150919 시작
		/*
		sbSql.append("               ,SUM( CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
		sbSql.append("                          THEN ROUND(A.OUT_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.PRICE + ROUND(A.PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)) \n");
		sbSql.append("                          WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL\n");
		sbSql.append("                          THEN ROUND(A.OUT_QTY * DECODE(NVL(D.OP_PRICE,0),0,SCC_CEIL(A.PRICE + ROUND(A.PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL),D.OP_PRICE)) \n");
		sbSql.append("                     ELSE ROUND(A.OUT_QTY * A.PRICE) END");
		sbSql.append("                ) AS OCCUR_AMT");
		*/
		sbSql.append("               ,SUM(A.OUT_OPAMOUNT) AS OCCUR_AMT  \n");
	    //sbSql.append("          FROM FMP_SUBUL A, FMS_ITEM_V B, FMU_OP_RATE C, FMS_SUBINVENTORY Z \n");
		sbSql.append("           FROM (SELECT A.* , B.ITEM_CLASS4, B.CONSUM_YN, B.OTCUSTCD FROM FMP_SUBUL A, FMS_ITEM_V B WHERE A.ITEM_CODE = B.ITEM_CODE) A \n");
		/*
	    sbSql.append("               ,( SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE												\n");
	    sbSql.append("                    FROM FMU_OP_RATE 																						\n");
	    sbSql.append("           		 WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " 									\n");
	    sbSql.append("                     AND USE_YN = 'Y'																						\n");
	    sbSql.append("           		   AND ITEM_TYPE = 'M'																				\n");
	    sbSql.append("           		) C																										\n");
	    sbSql.append("               ,( SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE												\n");
	    sbSql.append("                    FROM FMU_OP_RATE 																						\n");
	    sbSql.append("           		 WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " 									\n");
	    sbSql.append("                     AND USE_YN = 'Y'																						\n");
	    sbSql.append("           		   AND ITEM_TYPE = 'C'																				\n");
	    sbSql.append("           		) D																									    \n");
	    */
	    sbSql.append("           	 ,FMS_SUBINVENTORY Z																						\n");
		sbSql.append("         WHERE 1 = 1 \n");
		//sbSql.append("           AND A.UPJANG = C.UPJANG(+) \n");
		//sbSql.append("           AND A.SDATE BETWEEN C.SDATE(+) AND C.EDATE(+) \n");
		//sbSql.append("           AND A.ITEM_CODE BETWEEN C.ITEM_CODE(+) AND C.ITEM_CODE(+)||'9999' \n");
		//sbSql.append("           AND C.USE_YN(+) = 'Y' \n");
		/*
		sbSql.append("           AND A.SDATE BETWEEN C.SDATE(+) AND C.EDATE(+)                                                             		\n");
        sbSql.append("           AND A.SDATE BETWEEN D.SDATE(+) AND D.EDATE(+)                                                             		\n");
        sbSql.append("           AND A.ITEM_CODE = C.ITEM_CODE(+)																				\n");
		sbSql.append("           AND A.ITEM_CLASS4 = D.ITEM_CODE(+)																			    \n");
		*/
		sbSql.append("           AND A.SDATE BETWEEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATET")) + "' \n");
		sbSql.append("           AND A.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
		sbSql.append("           AND A.CONSUM_YN = 'N' \n");
		sbSql.append("           AND Z.SUBINV_CODE = A.SUBINV_CODE\n");
		sbSql.append("           AND Z.STOCK_YN = 'Y' \n");
		sbSql.append("        ----------- \n");
		sbSql.append("         UNION ALL \n");
		sbSql.append("        ----------- \n");
		sbSql.append("        SELECT 0 AS EXP_AMT \n");
		//sbSql.append("             , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.TRANS_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))) AS OCCUR_AMT \n");
		/*
		sbSql.append("              , SUM( CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
		sbSql.append("                          THEN DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.TRANS_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)) \n");
		sbSql.append("                          WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL\n");
		sbSql.append("                          THEN DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.TRANS_QTY * DECODE(NVL(D.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL),D.OP_PRICE)) \n");
		sbSql.append("                     ELSE DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.TRANS_QTY * A.SALE_PRICE) END");
		sbSql.append("                ) AS OCCUR_AMT ");
		*/
		sbSql.append("              , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.SAL_OPER_PRICE, 0, ROUND(A.SALE_PRICE*A.TRANS_QTY), ROUND(A.SAL_OPER_PRICE*A.TRANS_QTY))) AS OCCUR_AMT \n");
	    //sbSql.append("          FROM HLDC_PO_TRANSACTION A, FMS_ITEM_V B, FMU_OP_RATE C, FMS_SUBINVENTORY Z \n");
		sbSql.append("           FROM (SELECT A.* , B.ITEM_CLASS4, B.CONSUM_YN, B.OTCUSTCD FROM FMS_TRANSACTION_V A, FMS_ITEM_V B WHERE A.ITEM_CODE = B.ITEM_CODE) A \n");
		/*
	    sbSql.append("               ,( SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE												\n");
	    sbSql.append("                    FROM FMU_OP_RATE 																						\n");
	    sbSql.append("           	     WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " 									\n");
	    sbSql.append("                     AND USE_YN = 'Y'																						\n");
	    sbSql.append("           		   AND ITEM_TYPE = 'M'																				\n");
	    sbSql.append("           		) C																										\n");
	    sbSql.append("               ,( SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE												\n");
	    sbSql.append("                    FROM FMU_OP_RATE 																						\n");
	    sbSql.append("           	     WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " 									\n");
	    sbSql.append("                     AND USE_YN = 'Y'																						\n");
	    sbSql.append("           		   AND ITEM_TYPE = 'C'																				\n");
	    sbSql.append("           		) D																									    \n");
	    */
	    sbSql.append("           	 ,FMS_SUBINVENTORY Z																						\n");
		sbSql.append("         WHERE 1 = 1 \n");
		//sbSql.append("           AND A.TRANS_UPJANG = C.UPJANG(+) \n");
		//sbSql.append("           AND A.TRANS_DATE BETWEEN C.SDATE(+) AND C.EDATE(+) \n");
		//sbSql.append("           AND A.ITEM_CODE BETWEEN C.ITEM_CODE(+) AND C.ITEM_CODE(+)||'9999' \n");
		//sbSql.append("           AND C.USE_YN(+) = 'Y' \n");
		/*
		sbSql.append("           AND A.TRANS_DATE BETWEEN C.SDATE(+) AND C.EDATE(+)                                                             		\n");
        sbSql.append("           AND A.TRANS_DATE BETWEEN D.SDATE(+) AND D.EDATE(+)                                                             		\n");
        sbSql.append("           AND A.ITEM_CODE = C.ITEM_CODE(+)																				\n");
		sbSql.append("           AND A.ITEM_CLASS4 = D.ITEM_CODE(+)																			    \n");
		*/
		sbSql.append("           AND A.TRANS_DATE BETWEEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATET")) + "' \n");
		sbSql.append("           AND A.TRANS_UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
		sbSql.append("           AND (A.TRANS_TYPE = 'I001' OR (A.TRANS_TYPE LIKE '_002' AND A.SOURCE_TYPE = 'PO')) \n");
		sbSql.append("           AND A.CONSUM_YN = 'N' \n");
		sbSql.append("           AND Z.SUBINV_CODE = A.SUBINV_CODE\n");
		sbSql.append("           AND Z.STOCK_YN = 'N' \n");
        sbSql.append("        -----------                                                                                                                                             \n");
        sbSql.append("         UNION ALL                                                                                                                                              \n");
        sbSql.append("        -----------                                                                                                                                             \n");
        sbSql.append("        SELECT 0 AS EXP_AMT                                                                                                                                     \n");
        //sbSql.append("             , SUM(ROUND(A.PO_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))) AS OCCUR_AMT \n");
        /*
        sbSql.append("               ,SUM( CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
		sbSql.append("                          THEN ROUND(A.PO_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)) \n");
		sbSql.append("                          WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL\n");
		sbSql.append("                          THEN ROUND(A.PO_QTY * DECODE(NVL(D.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL),D.OP_PRICE)) \n");
		sbSql.append("                     ELSE ROUND(A.PO_QTY * A.SALE_PRICE) END");
		sbSql.append("                ) AS OCCUR_AMT");
        */
		sbSql.append("               , SUM(A.OP_AMOUNT) AS OCCUR_AMT \n");
	    //sbSql.append("          FROM FMP_OTCUST_PR A, FMU_OP_RATE C, FMS_ITEM_V D, FMS_SUBINVENTORY Z                                                                                                     \n");
        sbSql.append("           FROM (SELECT A.* , B.ITEM_CLASS4, B.CONSUM_YN, B.OTCUSTCD FROM FMP_OTCUST_PR A, FMS_ITEM_V B WHERE A.ITEM_CODE = B.ITEM_CODE) A \n");
        /*
	    sbSql.append("               ,( SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE												\n");
	    sbSql.append("                    FROM FMU_OP_RATE 																						\n");
	    sbSql.append("           	     WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " 									\n");
	    sbSql.append("                     AND USE_YN = 'Y'																						\n");
	    sbSql.append("           		   AND ITEM_TYPE = 'M'																				\n");
	    sbSql.append("           		) C																										\n");
	    sbSql.append("               ,( SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE												\n");
	    sbSql.append("                    FROM FMU_OP_RATE 																						\n");
	    sbSql.append("           	     WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " 									\n");
	    sbSql.append("                     AND USE_YN = 'Y'																						\n");
	    sbSql.append("           		   AND ITEM_TYPE = 'C'																				\n");
	    sbSql.append("           		) D																									    \n");
	    */
	    sbSql.append("           	 ,FMS_SUBINVENTORY Z																						\n");
		sbSql.append("         WHERE 1 = 1                                                                                                                        \n");
        //sbSql.append("           AND A.UPJANG = C.UPJANG(+)                                                                                                                           \n");
        //sbSql.append("           AND A.NEED_DATE BETWEEN C.SDATE(+) AND C.EDATE(+)                                                                                                    \n");
        //sbSql.append("           AND A.ITEM_CODE BETWEEN C.ITEM_CODE(+) AND C.ITEM_CODE(+)||'9999'                                                                                    \n");
        //sbSql.append("           AND C.USE_YN(+) = 'Y'                                                                                                                                \n");
        /*
        sbSql.append("           AND A.NEED_DATE BETWEEN C.SDATE(+) AND C.EDATE(+)                                                             		\n");
        sbSql.append("           AND A.NEED_DATE BETWEEN D.SDATE(+) AND D.EDATE(+)                                                             		\n");
        sbSql.append("           AND A.ITEM_CODE = C.ITEM_CODE(+)																				\n");
		sbSql.append("           AND A.ITEM_CLASS4 = D.ITEM_CODE(+)																			    \n");
		*/
        sbSql.append("           AND A.NEED_DATE BETWEEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATET")) + "' \n");
        sbSql.append("           AND A.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
        sbSql.append("           AND A.CONSUM_YN = 'N'                                                                                                                                \n");
        sbSql.append("           AND A.LINE_STATUS <> '003'                                                                                                                           \n");
		sbSql.append("           AND Z.SUBINV_CODE = A.SUBINV_CODE\n");
		sbSql.append("           AND Z.STOCK_YN = 'N' \n");
        sbSql.append("         GROUP BY A.NEED_DATE                                                                                                                                   \n");
        sbSql.append("        -----------                                                                                                                                             \n");
		sbSql.append("        ----------- \n");
		sbSql.append("         UNION ALL \n");
		sbSql.append("        ----------- \n");
		sbSql.append("        SELECT 0 AS EXP_AMT \n");
		sbSql.append("             , SUM(A.SUPPLYAMT) AS OCCUR_AMT \n");
		sbSql.append("          FROM FMP_LOCALPO A, FMS_ITEM_V B \n");
		sbSql.append("         WHERE A.ITEM_CODE = B.ITEM_CODE \n");
		sbSql.append("           AND A.NEED_DATE BETWEEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATET")) + "' \n");
		sbSql.append("           AND A.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
		sbSql.append("           AND B.CONSUM_YN = 'N' \n");
		sbSql.append("        ----------- \n");
		sbSql.append("         UNION ALL \n");
		sbSql.append("        ----------- \n");
		sbSql.append("        SELECT 0 AS EXP_AMT \n");
		sbSql.append("             , SUM(EMP_QTY * EMP_UPRICE * -1) AS OCCUR_AMT \n");
		sbSql.append("          FROM FMO_MONTH_PLAN_DTL \n");
		sbSql.append("         WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
		sbSql.append("           AND YYMM = SUBSTR('" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "',1,6) \n");
		sbSql.append("           AND DD BETWEEN SUBSTR('" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "',7) AND SUBSTR('" + nullToBlank(ds_cond.getString(0, "NEED_DATET")) + "',7) \n");
		sbSql.append("        ----------- \n");
		sbSql.append("         UNION ALL \n");
		sbSql.append("        ----------- \n");
		sbSql.append("        SELECT 0, 0 FROM DUAL) \n");
		sbSql.append("----------- \n");
		sbSql.append(" UNION ALL \n");
		sbSql.append("----------- \n");
		sbSql.append("SELECT '소모품비' AS STYPE \n");
		sbSql.append("     , SUM(EXP_AMT) AS PLAN_AMT \n");
		sbSql.append("     , SUM(OCCUR_AMT) AS REAL_AMT \n");
		sbSql.append("  FROM (SELECT SUM(ROUND(EXP_AMT * EXP_RATE / 100)) AS EXP_AMT \n");
		sbSql.append("             , 0 AS OCCUR_AMT \n");
		sbSql.append("          FROM FMO_MONTH_PLAN_DTL \n");
		sbSql.append("         WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
		sbSql.append("           AND YYMM = SUBSTR('" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "',1,6) \n");
		sbSql.append("        ----------- \n");
		sbSql.append("         UNION ALL \n");
		sbSql.append("        ----------- \n");
		sbSql.append("        SELECT 0 AS EXP_AMT \n");
		//sbSql.append("             , SUM(ROUND(A.OUT_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.PRICE + ROUND(A.PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))) AS OCCUR_AMT \n");
		/*
		sbSql.append("               ,SUM( CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
		sbSql.append("                          THEN ROUND(A.OUT_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.PRICE + ROUND(A.PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)) \n");
		sbSql.append("                          WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL\n");
		sbSql.append("                          THEN ROUND(A.OUT_QTY * DECODE(NVL(D.OP_PRICE,0),0,SCC_CEIL(A.PRICE + ROUND(A.PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL),D.OP_PRICE)) \n");
		sbSql.append("                     ELSE ROUND(A.OUT_QTY * A.PRICE) END");
		sbSql.append("                ) AS OCCUR_AMT ");
		*/
		sbSql.append("               ,SUM(A.OUT_OPAMOUNT) AS OCCUR_AMT  \n");
	    //sbSql.append("          FROM FMP_SUBUL A, FMS_ITEM_V B, FMU_OP_RATE C, FMS_SUBINVENTORY Z \n");
		sbSql.append("           FROM (SELECT A.* , B.ITEM_CLASS4, B.CONSUM_YN, B.OTCUSTCD FROM FMP_SUBUL A, FMS_ITEM_V B WHERE A.ITEM_CODE = B.ITEM_CODE) A \n");
		/*
	    sbSql.append("               ,( SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE												\n");
	    sbSql.append("                    FROM FMU_OP_RATE 																						\n");
	    sbSql.append("           	     WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " 									\n");
	    sbSql.append("                     AND USE_YN = 'Y'																						\n");
	    sbSql.append("           		   AND ITEM_TYPE = 'M'																				\n");
	    sbSql.append("           		) C																										\n");
	    sbSql.append("               ,( SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE												\n");
	    sbSql.append("                    FROM FMU_OP_RATE 																						\n");
	    sbSql.append("           	     WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " 									\n");
	    sbSql.append("                     AND USE_YN = 'Y'																						\n");
	    sbSql.append("           		   AND ITEM_TYPE = 'C'																				\n");
	    sbSql.append("           		) D																									    \n");
	    */
	    sbSql.append("           	 ,FMS_SUBINVENTORY Z																						\n");
		sbSql.append("         WHERE 1 = 1 \n");
		//sbSql.append("           AND A.UPJANG = C.UPJANG(+) \n");
		//sbSql.append("           AND A.SDATE BETWEEN C.SDATE(+) AND C.EDATE(+) \n");
		//sbSql.append("           AND A.ITEM_CODE BETWEEN C.ITEM_CODE(+) AND C.ITEM_CODE(+)||'9999' \n");
		//sbSql.append("           AND C.USE_YN(+) = 'Y' \n");
		/*
		sbSql.append("           AND A.SDATE BETWEEN C.SDATE(+) AND C.EDATE(+)                                                             		\n");
        sbSql.append("           AND A.SDATE BETWEEN D.SDATE(+) AND D.EDATE(+)                                                             		\n");
        sbSql.append("           AND A.ITEM_CODE = C.ITEM_CODE(+)																				\n");
		sbSql.append("           AND A.ITEM_CLASS4 = D.ITEM_CODE(+)																			    \n");
		*/
		sbSql.append("           AND A.SDATE BETWEEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATET")) + "' \n");
		sbSql.append("           AND A.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
		sbSql.append("           AND A.CONSUM_YN = 'Y' \n");
		sbSql.append("           AND Z.SUBINV_CODE = A.SUBINV_CODE\n");
		sbSql.append("           AND Z.STOCK_YN = 'Y' \n");
		sbSql.append("        ----------- \n");
		sbSql.append("         UNION ALL \n");
		sbSql.append("        ----------- \n");
		sbSql.append("        SELECT 0 AS EXP_AMT \n");
		//sbSql.append("             , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.TRANS_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))) AS OCCUR_AMT \n");
		/*
		sbSql.append("              , SUM( CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
		sbSql.append("                          THEN DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.TRANS_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)) \n");
		sbSql.append("                          WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL\n");
		sbSql.append("                          THEN DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.TRANS_QTY * DECODE(NVL(D.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL),D.OP_PRICE)) \n");
		sbSql.append("                     ELSE DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.TRANS_QTY * A.SALE_PRICE) END");
		sbSql.append("                ) AS OCCUR_AMT");
		*/
		sbSql.append("              , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.SAL_OPER_PRICE, 0, ROUND(A.SALE_PRICE*A.TRANS_QTY), ROUND(A.SAL_OPER_PRICE*A.TRANS_QTY))) AS OCCUR_AMT \n");
	    //sbSql.append("          FROM HLDC_PO_TRANSACTION A, FMS_ITEM_V B, FMU_OP_RATE C, FMS_SUBINVENTORY Z \n");
		sbSql.append("           FROM (SELECT A.* , B.ITEM_CLASS4, B.CONSUM_YN, B.OTCUSTCD FROM FMS_TRANSACTION_V A, FMS_ITEM_V B WHERE A.ITEM_CODE = B.ITEM_CODE) A \n");
		/*
	    sbSql.append("               ,( SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE												\n");
	    sbSql.append("                    FROM FMU_OP_RATE 																						\n");
	    sbSql.append("           	     WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " 									\n");
	    sbSql.append("                     AND USE_YN = 'Y'																						\n");
	    sbSql.append("           		   AND ITEM_TYPE = 'M'																				\n");
	    sbSql.append("           		) C																										\n");
	    sbSql.append("               ,( SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE												\n");
	    sbSql.append("                    FROM FMU_OP_RATE 																						\n");
	    sbSql.append("           	     WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " 									\n");
	    sbSql.append("                     AND USE_YN = 'Y'																						\n");
	    sbSql.append("           		   AND ITEM_TYPE = 'C'																				\n");
	    sbSql.append("           		) D																									    \n");
	    */
	    sbSql.append("           	 ,FMS_SUBINVENTORY Z																						\n");
		sbSql.append("         WHERE 1 = 1 \n");
		//sbSql.append("           AND A.TRANS_UPJANG = C.UPJANG(+) \n");
		//sbSql.append("           AND A.TRANS_DATE BETWEEN C.SDATE(+) AND C.EDATE(+) \n");
		//sbSql.append("           AND A.ITEM_CODE BETWEEN C.ITEM_CODE(+) AND C.ITEM_CODE(+)||'9999' \n");
		//sbSql.append("           AND C.USE_YN(+) = 'Y' \n");
		/*
		sbSql.append("           AND A.TRANS_DATE BETWEEN C.SDATE(+) AND C.EDATE(+)                                                             		\n");
        sbSql.append("           AND A.TRANS_DATE BETWEEN D.SDATE(+) AND D.EDATE(+)                                                             		\n");
        sbSql.append("           AND A.ITEM_CODE = C.ITEM_CODE(+)																				\n");
		sbSql.append("           AND A.ITEM_CLASS4 = D.ITEM_CODE(+)																			    \n");
		*/
		sbSql.append("           AND A.TRANS_DATE BETWEEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATET")) + "' \n");
		sbSql.append("           AND A.TRANS_UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
		sbSql.append("           AND (A.TRANS_TYPE = 'I001' OR (A.TRANS_TYPE LIKE '_002' AND A.SOURCE_TYPE = 'PO')) \n");
		sbSql.append("           AND A.CONSUM_YN = 'Y' \n");
		sbSql.append("           AND Z.SUBINV_CODE = A.SUBINV_CODE\n");
		sbSql.append("           AND Z.STOCK_YN = 'N' \n");
        sbSql.append("        -----------                                                                                                                                             \n");
        sbSql.append("         UNION ALL                                                                                                                                              \n");
        sbSql.append("        -----------                                                                                                                                             \n");
        sbSql.append("        SELECT 0 AS EXP_AMT                                                                                                                                     \n");
        //sbSql.append("             , SUM(ROUND(A.PO_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))) AS OCCUR_AMT \n");
        /*
        sbSql.append("               ,SUM( CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
		sbSql.append("                          THEN ROUND(A.PO_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)) \n");
		sbSql.append("                          WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL\n");
		sbSql.append("                          THEN ROUND(A.PO_QTY * DECODE(NVL(D.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL),D.OP_PRICE)) \n");
		sbSql.append("                     ELSE ROUND(A.PO_QTY * A.SALE_PRICE) END");
		sbSql.append("                ) AS OCCUR_AMT ");
		*/
        sbSql.append("               , SUM(A.OP_AMOUNT) AS OCCUR_AMT \n");
	    //sbSql.append("          FROM FMP_OTCUST_PR A, FMU_OP_RATE C, FMS_ITEM_V D, FMS_SUBINVENTORY Z                                                                                                     \n");
        sbSql.append("           FROM (SELECT A.* , B.ITEM_CLASS4, B.CONSUM_YN, B.OTCUSTCD FROM FMP_OTCUST_PR A, FMS_ITEM_V B WHERE A.ITEM_CODE = B.ITEM_CODE) A \n");
        /*
	    sbSql.append("               ,( SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE												\n");
	    sbSql.append("                    FROM FMU_OP_RATE 																						\n");
	    sbSql.append("           	     WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " 									\n");
	    sbSql.append("                     AND USE_YN = 'Y'																						\n");
	    sbSql.append("           		   AND ITEM_TYPE = 'M'																				\n");
	    sbSql.append("           		) C																										\n");
	    sbSql.append("               ,( SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE												\n");
	    sbSql.append("                    FROM FMU_OP_RATE 																						\n");
	    sbSql.append("           	     WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " 									\n");
	    sbSql.append("                     AND USE_YN = 'Y'																						\n");
	    sbSql.append("           		   AND ITEM_TYPE = 'C'																				\n");
	    sbSql.append("           		) D																									    \n");
	    */
	    sbSql.append("           	 ,FMS_SUBINVENTORY Z																						\n");
		sbSql.append("         WHERE 1 = 1                                                                                                                        \n");
        //sbSql.append("           AND A.UPJANG = C.UPJANG(+)                                                                                                                           \n");
        //sbSql.append("           AND A.NEED_DATE BETWEEN C.SDATE(+) AND C.EDATE(+)                                                                                                    \n");
        //sbSql.append("           AND A.ITEM_CODE BETWEEN C.ITEM_CODE(+) AND C.ITEM_CODE(+)||'9999'                                                                                    \n");
        //sbSql.append("           AND C.USE_YN(+) = 'Y'                                                                                                                                \n");
        /*
        sbSql.append("           AND A.NEED_DATE BETWEEN C.SDATE(+) AND C.EDATE(+)                                                             		\n");
        sbSql.append("           AND A.NEED_DATE BETWEEN D.SDATE(+) AND D.EDATE(+)                                                             		\n");
        sbSql.append("           AND A.ITEM_CODE = C.ITEM_CODE(+)																				\n");
		sbSql.append("           AND A.ITEM_CLASS4 = D.ITEM_CODE(+)																			    \n");
		*/
        sbSql.append("           AND A.NEED_DATE BETWEEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATET")) + "' \n");
        sbSql.append("           AND A.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
        sbSql.append("           AND A.CONSUM_YN = 'Y'                                                                                                                                \n");
        sbSql.append("           AND A.LINE_STATUS <> '003'                                                                                                                           \n");
		sbSql.append("           AND Z.SUBINV_CODE = A.SUBINV_CODE\n");
		sbSql.append("           AND Z.STOCK_YN = 'N' \n");
        sbSql.append("         GROUP BY A.NEED_DATE                                                                                                                                   \n");
        sbSql.append("        -----------                                                                                                                                             \n");
		sbSql.append("        ----------- \n");
		sbSql.append("         UNION ALL \n");
		sbSql.append("        ----------- \n");
		sbSql.append("        SELECT 0 AS EXP_AMT \n");
		sbSql.append("             , SUM(A.SUPPLYAMT) AS OCCUR_AMT \n");
		sbSql.append("          FROM FMP_LOCALPO A, FMS_ITEM_V B \n");
		sbSql.append("         WHERE A.ITEM_CODE = B.ITEM_CODE \n");
		sbSql.append("           AND A.NEED_DATE BETWEEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATET")) + "' \n");
		sbSql.append("           AND A.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
		sbSql.append("           AND B.CONSUM_YN = 'Y' \n");
		sbSql.append("        ----------- \n");
		sbSql.append("         UNION ALL \n");
		sbSql.append("        ----------- \n");
		sbSql.append("        SELECT 0 AS EXP_AMT \n");
		sbSql.append("             , SUM(EMP_QTY * EMP_UPRICE * -1) AS OCCUR_AMT \n");
		sbSql.append("          FROM FMO_MONTH_PLAN_DTL \n");
		sbSql.append("         WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
		sbSql.append("           AND YYMM = SUBSTR('" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "',1,6) \n");
		sbSql.append("           AND DD BETWEEN SUBSTR('" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "',7) AND SUBSTR('" + nullToBlank(ds_cond.getString(0, "NEED_DATET")) + "',7) \n");
		sbSql.append("        ----------- \n");
		sbSql.append("         UNION ALL \n");
		sbSql.append("        ----------- \n");
		sbSql.append("        SELECT 0, 0 FROM DUAL) \n");		

out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_list1 = this.makeDataSet(rs, "ds_List1");
		
		pstmt.close();
		rs.close();
		
		//FileLog.println("d:\\aaa.txt", ds_list1);
		out_dl.add(ds_list1);
		
		//내역조회   2) 하단상세 조회
		sbSql.delete(0,sbSql.length());
		sbSql.append("SELECT TO_CHAR(TO_DATE(SDATE,'YYYYMMDD'),'YYYY-MM-DD') AS SDATE \n");
		sbSql.append("     , SUM(AMT1) AS AMT1 \n");
		sbSql.append("     , SUM(AMT2) + SUM(AMT3) + SUM(AMT4) + SUM(AMT5) AS AMT2_0 \n");
		sbSql.append("     , SUM(AMT2) AS AMT2 \n");
		sbSql.append("     , SUM(AMT3) AS AMT3 \n");
		sbSql.append("     , SUM(AMT4) AS AMT4 \n");
		sbSql.append("     , SUM(AMT5) AS AMT5 \n");
		sbSql.append("     , SUM(AMT6) AS AMT6 \n");
		sbSql.append("     , SUM(EXP_RATE) AS RATE1 \n");
		sbSql.append("     , DECODE(SUM(AMT1),0,0,ROUND(100*(SUM(AMT2) + SUM(AMT3) + SUM(AMT4) + SUM(AMT5))/SUM(AMT1),1)) AS RATE2 \n");
		sbSql.append("     , DECODE(SUM(AMT1),0,0,ROUND(100*(SUM(AMT2) + SUM(AMT3) + SUM(AMT4) + SUM(AMT5))/SUM(AMT1),1)) \n");
		sbSql.append("              - SUM(EXP_RATE) AS RATE3 \n");
		sbSql.append("     , DECODE(SIGN(DECODE(SUM(AMT1),0,0,ROUND(100*(SUM(AMT2) + SUM(AMT3) + SUM(AMT4) + SUM(AMT5))/SUM(AMT1),1)) \n");
		sbSql.append("                   - SUM(EXP_RATE) \n");
		sbSql.append("                  ), 1, '▲',-1,'▼') \n");
		sbSql.append("       ||TRIM(TO_CHAR(ABS( DECODE(SUM(AMT1),0,0,ROUND(100*(SUM(AMT2) + SUM(AMT3) + SUM(AMT4) + SUM(AMT5))/SUM(AMT1),1)) \n");
		sbSql.append("                           - SUM(EXP_RATE) \n");
		sbSql.append("                         ) \n");
		sbSql.append("                     , '999,999,999,990.0' )) AS RATE3_DISP \n");
		sbSql.append("     , SUBSTR(SDATE,7)||'일' AS SDAY \n");
		sbSql.append("  FROM (SELECT B.OCCUR_DATE AS SDATE \n");
		sbSql.append("             , SUM(B.OCCUR_AMT) AS AMT1 \n");
		sbSql.append("             , 0 AS AMT2 \n");
		sbSql.append("             , 0 AS AMT3 \n");
		sbSql.append("             , 0 AS AMT4 \n");
		sbSql.append("             , 0 AS AMT5 \n");
		sbSql.append("             , 0 AS AMT6 \n");
		sbSql.append("             , 0 AS EXP_RATE \n");
		sbSql.append("          FROM FMO_ACCT_OCCUR B, FMS_UPJANG C, FMO_ACCOUNT D \n");
		sbSql.append("         WHERE B.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
		sbSql.append("           AND B.OCCUR_DATE BETWEEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATET")) + "' \n");
		sbSql.append("           AND B.UPJANG = C.UPJANG \n");
		sbSql.append("           AND C.MAIN_UPJANG = D.UPJANG \n");
		sbSql.append("           AND B.ACCTCD = D.ACCTCD \n");
		sbSql.append("           AND D.ACCT_TYPE = '001' \n");
		sbSql.append("         GROUP BY B.OCCUR_DATE \n");
		sbSql.append("        ----------- \n");
		sbSql.append("         UNION ALL --재고업장이면 한화, 공급업체 모두 SUBUL에서 가져옴(소모품아님)\n");
		sbSql.append("        ----------- \n");
		sbSql.append("        SELECT A.SDATE \n");
		sbSql.append("             , 0 AS AMT1 \n");
		//sbSql.append("             , SUM(DECODE(D.OTCUSTCD,'0000',ROUND(A.OUT_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.PRICE + ROUND(A.PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)),0)) AS AMT2 \n");
		/*
		sbSql.append("              , SUM( CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
		sbSql.append("                          THEN DECODE(A.OTCUSTCD,'0000',ROUND(A.OUT_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.PRICE + ROUND(A.PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)),0) \n");
		sbSql.append("                          WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL\n");
		sbSql.append("                          THEN DECODE(A.OTCUSTCD,'0000',ROUND(A.OUT_QTY * DECODE(NVL(D.OP_PRICE,0),0,SCC_CEIL(A.PRICE + ROUND(A.PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL),D.OP_PRICE)),0) \n");
		sbSql.append("                     ELSE 0 END");
		sbSql.append("                ) AS AMT2");
		*/
		sbSql.append("               ,SUM(DECODE(A.OTCUSTCD,'0000',A.OUT_OPAMOUNT,0)) AS AMT2  \n");
	    //sbSql.append("             , SUM(DECODE(D.OTCUSTCD,'0000',0,ROUND(A.OUT_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.PRICE + ROUND(A.PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)))) AS AMT3 \n");
	    /*
		sbSql.append("              , SUM( CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
		sbSql.append("                          THEN DECODE(A.OTCUSTCD,'0000',0,ROUND(A.OUT_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.PRICE + ROUND(A.PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))) \n");
		sbSql.append("                          WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL\n");
		sbSql.append("                          THEN DECODE(A.OTCUSTCD,'0000',0,ROUND(A.OUT_QTY * DECODE(NVL(D.OP_PRICE,0),0,SCC_CEIL(A.PRICE + ROUND(A.PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL),D.OP_PRICE))) \n");
		sbSql.append("                     ELSE DECODE(A.OTCUSTCD,'0000',0,ROUND(A.OUT_QTY * A.PRICE)) END");
		sbSql.append("                ) AS AMT3 ");
	    */
		sbSql.append("               ,SUM(DECODE(A.OTCUSTCD,'0000',0,A.OUT_OPAMOUNT)) AS AMT3  \n");
	    sbSql.append("             , 0 AS AMT4 \n");
		sbSql.append("             , 0 AS AMT5 \n");
		sbSql.append("             , 0 AS AMT6 \n");
		sbSql.append("             , 0 AS EXP_RATE \n");
		//sbSql.append("          FROM FMP_SUBUL A, FMU_OP_RATE C, FMS_ITEM_V D, FMS_SUBINVENTORY Z \n");
		sbSql.append("           FROM (SELECT A.* , B.ITEM_CLASS4, B.CONSUM_YN, B.OTCUSTCD FROM FMP_SUBUL A, FMS_ITEM_V B WHERE A.ITEM_CODE = B.ITEM_CODE) A \n");
		/*
	    sbSql.append("               ,( SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE												\n");
	    sbSql.append("                    FROM FMU_OP_RATE 																						\n");
	    sbSql.append("           	     WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " 									\n");
	    sbSql.append("                     AND USE_YN = 'Y'																						\n");
	    sbSql.append("           		   AND ITEM_TYPE = 'M'																				\n");
	    sbSql.append("           		) C																										\n");
	    sbSql.append("               ,( SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE												\n");
	    sbSql.append("                    FROM FMU_OP_RATE 																						\n");
	    sbSql.append("           	     WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " 									\n");
	    sbSql.append("                     AND USE_YN = 'Y'																						\n");
	    sbSql.append("           		   AND ITEM_TYPE = 'C'																				\n");
	    sbSql.append("           		) D																									    \n");
	    */
	    sbSql.append("           	 ,FMS_SUBINVENTORY Z																						\n");
		sbSql.append("         WHERE 1 = 1 \n");
		//sbSql.append("           AND A.SDATE BETWEEN C.SDATE(+) AND C.EDATE(+) \n");
		//sbSql.append("           AND A.ITEM_CODE BETWEEN C.ITEM_CODE(+) AND C.ITEM_CODE(+)||'9999' \n");
		//sbSql.append("           AND C.USE_YN(+) = 'Y' \n");
		//sbSql.append("           AND A.ITEM_CODE = D.ITEM_CODE \n");
		/*
		sbSql.append("           AND A.SDATE BETWEEN C.SDATE(+) AND C.EDATE(+)                                                             		\n");
        sbSql.append("           AND A.SDATE BETWEEN D.SDATE(+) AND D.EDATE(+)                                                             		\n");
        sbSql.append("           AND A.ITEM_CODE = C.ITEM_CODE(+)																				\n");
		sbSql.append("           AND A.ITEM_CLASS4 = D.ITEM_CODE(+)																			    \n");
		*/
		sbSql.append("           AND A.SDATE BETWEEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATET")) + "' \n");
		sbSql.append("           AND A.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
		sbSql.append("           AND A.CONSUM_YN = 'N' \n");
		sbSql.append("           AND Z.SUBINV_CODE = A.SUBINV_CODE\n");
		sbSql.append("           AND Z.STOCK_YN = 'Y' \n");
		sbSql.append("         GROUP BY A.SDATE \n");
		sbSql.append("        ----------- \n");
		sbSql.append("         UNION ALL --재고업장이 아니면 한화품목은 FMS_TRANSACTION_V 에서 가져옴(소모품아님)\n");
		sbSql.append("        ----------- \n");
		sbSql.append("        SELECT A.TRANS_DATE \n");
		sbSql.append("             , 0 AS AMT1 \n");
		//sbSql.append("             , SUM(DECODE(D.OTCUSTCD,'0000',DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.TRANS_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)),0)) AS AMT2 \n");
		/*
		sbSql.append("              , SUM( CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
		sbSql.append("                          THEN DECODE(A.OTCUSTCD,'0000',DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.TRANS_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)),0) \n");
		sbSql.append("                          WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL\n");
		sbSql.append("                          THEN DECODE(A.OTCUSTCD,'0000',DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.TRANS_QTY * DECODE(NVL(D.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL),D.OP_PRICE)),0) \n");
		sbSql.append("                     ELSE DECODE(A.OTCUSTCD,'0000',DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.TRANS_QTY * A.SALE_PRICE),0) END");
		sbSql.append("                ) AS AMT2");
		*/
		sbSql.append("             , SUM(DECODE(A.OTCUSTCD,'0000',DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.SAL_OPER_PRICE, 0, ROUND(A.SALE_PRICE*A.TRANS_QTY), ROUND(A.SAL_OPER_PRICE*A.TRANS_QTY)),0)) AS AMT2 \n");
		sbSql.append("             , 0 AS AMT3 \n");
		sbSql.append("             , 0 AS AMT4 \n");
		sbSql.append("             , 0 AS AMT5 \n");
		sbSql.append("             , 0 AS AMT6 \n");
		sbSql.append("             , 0 AS EXP_RATE \n");
		//sbSql.append("          FROM HLDC_PO_TRANSACTION A, FMU_OP_RATE C, FMS_ITEM_V D, FMS_SUBINVENTORY Z \n");
		sbSql.append("           FROM (SELECT A.* , B.ITEM_CLASS4, B.CONSUM_YN, B.OTCUSTCD FROM FMS_TRANSACTION_V A, FMS_ITEM_V B WHERE A.ITEM_CODE = B.ITEM_CODE) A \n");
		/*
	    sbSql.append("               ,( SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE												\n");
	    sbSql.append("                    FROM FMU_OP_RATE 																						\n");
	    sbSql.append("           	     WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " 									\n");
	    sbSql.append("                     AND USE_YN = 'Y'																						\n");
	    sbSql.append("           		   AND ITEM_TYPE = 'M'																				\n");
	    sbSql.append("           		) C																										\n");
	    sbSql.append("               ,( SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE												\n");
	    sbSql.append("                    FROM FMU_OP_RATE 																						\n");
	    sbSql.append("           	     WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " 									\n");
	    sbSql.append("                     AND USE_YN = 'Y'																						\n");
	    sbSql.append("           		   AND ITEM_TYPE = 'C'																				\n");
	    sbSql.append("           		) D																									    \n");
	    */
	    sbSql.append("           	 ,FMS_SUBINVENTORY Z																						\n");
		sbSql.append("         WHERE 1 = 1 \n");
		//sbSql.append("           AND A.TRANS_UPJANG = C.UPJANG(+) \n");
		//sbSql.append("           AND A.TRANS_DATE BETWEEN C.SDATE(+) AND C.EDATE(+) \n");
		//sbSql.append("           AND A.ITEM_CODE BETWEEN C.ITEM_CODE(+) AND C.ITEM_CODE(+)||'9999' \n");
		//sbSql.append("           AND C.USE_YN(+) = 'Y' \n");
		/*
		sbSql.append("           AND A.TRANS_DATE BETWEEN C.SDATE(+) AND C.EDATE(+)                                                             		\n");
        sbSql.append("           AND A.TRANS_DATE BETWEEN D.SDATE(+) AND D.EDATE(+)                                                             		\n");
        sbSql.append("           AND A.ITEM_CODE = C.ITEM_CODE(+)																				\n");
		sbSql.append("           AND A.ITEM_CLASS4 = D.ITEM_CODE(+)																			    \n");
		*/
		sbSql.append("           AND A.TRANS_DATE BETWEEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATET")) + "' \n");
		sbSql.append("           AND A.TRANS_UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
		sbSql.append("           AND (A.TRANS_TYPE = 'I001' OR (A.TRANS_TYPE LIKE '_002' AND A.SOURCE_TYPE = 'PO')) \n");
		sbSql.append("           AND A.CONSUM_YN = 'N' \n");
		sbSql.append("           AND Z.SUBINV_CODE = A.SUBINV_CODE\n");
		sbSql.append("           AND Z.STOCK_YN = 'N' \n");
		sbSql.append("         GROUP BY A.TRANS_DATE \n");
		sbSql.append("        ----------- \n");
		sbSql.append("         UNION ALL --재고업장이 아니면 공급업체품목은 FMP_OTCUST_PR 에서 가져옴(소모품아님)\n");
		sbSql.append("        ----------- \n");
        sbSql.append("        SELECT A.NEED_DATE AS SDATE                                                                                                                        \n");
        sbSql.append("             , 0 AS AMT1                                                                                                                                   \n");
        sbSql.append("             , 0 AS AMT2                                                                                                                                   \n");
        //sbSql.append("             , SUM(ROUND(A.PO_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))) AS AMT3 \n");
        /*
        sbSql.append("              , SUM( CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
		sbSql.append("                          THEN ROUND(A.PO_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)) \n");
		sbSql.append("                          WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL\n");
		sbSql.append("                          THEN ROUND(A.PO_QTY * DECODE(NVL(D.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL),D.OP_PRICE)) \n");
		sbSql.append("                     ELSE ROUND(A.PO_QTY * A.SALE_PRICE) END");
		sbSql.append("                ) AS AMT3");
		*/
        sbSql.append("             , SUM(A.OP_AMOUNT) AS AMT3 \n");
		sbSql.append("             , 0 AS AMT4                                                                                                                                   \n");
        sbSql.append("             , 0 AS AMT5                                                                                                                                   \n");
        sbSql.append("             , 0 AS AMT6 \n");
        sbSql.append("             , 0 AS EXP_RATE                                                                                                                               \n");
        //sbSql.append("          FROM FMP_OTCUST_PR A, FMU_OP_RATE C, FMS_ITEM_V D, FMS_SUBINVENTORY Z                                                                                                \n");
        sbSql.append("           FROM (SELECT A.* , B.ITEM_CLASS4, B.CONSUM_YN, B.OTCUSTCD FROM FMP_OTCUST_PR A, FMS_ITEM_V B WHERE A.ITEM_CODE = B.ITEM_CODE) A \n");
        /*
	    sbSql.append("               ,( SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE												\n");
	    sbSql.append("                    FROM FMU_OP_RATE 																						\n");
	    sbSql.append("           	     WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " 									\n");
	    sbSql.append("                     AND USE_YN = 'Y'																						\n");
	    sbSql.append("           		   AND ITEM_TYPE = 'M'																				\n");
	    sbSql.append("           		) C																										\n");
	    sbSql.append("               ,( SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE												\n");
	    sbSql.append("                    FROM FMU_OP_RATE 																						\n");
	    sbSql.append("           	     WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " 									\n");
	    sbSql.append("                     AND USE_YN = 'Y'																						\n");
	    sbSql.append("           		   AND ITEM_TYPE = 'C'																				\n");
	    sbSql.append("           		) D																									    \n");
	    */
	    sbSql.append("           	 ,FMS_SUBINVENTORY Z																						\n");
		sbSql.append("         WHERE 1 = 1                                                                                                                   \n");
        //sbSql.append("           AND A.UPJANG = C.UPJANG(+)                                                                                                                      \n");
        //sbSql.append("           AND A.NEED_DATE BETWEEN C.SDATE(+) AND C.EDATE(+)                                                                                               \n");
        //sbSql.append("           AND A.ITEM_CODE BETWEEN C.ITEM_CODE(+) AND C.ITEM_CODE(+)||'9999'                                                                               \n");
        //sbSql.append("           AND C.USE_YN(+) = 'Y'                                                                                                                           \n");
        /*
        sbSql.append("           AND A.NEED_DATE BETWEEN C.SDATE(+) AND C.EDATE(+)                                                             		\n");
        sbSql.append("           AND A.NEED_DATE BETWEEN D.SDATE(+) AND D.EDATE(+)                                                             		\n");
        sbSql.append("           AND A.ITEM_CODE = C.ITEM_CODE(+)																				\n");
		sbSql.append("           AND A.ITEM_CLASS4 = D.ITEM_CODE(+)																			    \n");
		*/
        sbSql.append("           AND A.NEED_DATE BETWEEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATET")) + "' \n");
        sbSql.append("           AND A.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
        sbSql.append("           AND A.CONSUM_YN = 'N'                                                                                                                           \n");
        sbSql.append("           AND A.LINE_STATUS <> '003'                                                                                                                           \n");        
		sbSql.append("           AND Z.SUBINV_CODE = A.SUBINV_CODE\n");
		sbSql.append("           AND Z.STOCK_YN = 'N' \n");
        sbSql.append("         GROUP BY A.NEED_DATE                                                                                                                              \n");
		sbSql.append("        ----------- \n");
		sbSql.append("         UNION ALL --재고업장이면 한화, 공급업체 모두 SUBUL에서 가져옴(소모품)\n");
		sbSql.append("        ----------- \n");
		sbSql.append("        SELECT A.SDATE \n");
		sbSql.append("             , 0 AS AMT1 \n");
		sbSql.append("             , 0 AS AMT2 \n");
		sbSql.append("             , 0 AS AMT3 \n");
		sbSql.append("             , 0 AS AMT4 \n");
		sbSql.append("             , 0 AS AMT5 \n");
		//sbSql.append("             , SUM(ROUND(A.OUT_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.PRICE + ROUND(A.PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))) AS AMT6 \n");
		/*
		sbSql.append("              , SUM( CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
		sbSql.append("                          THEN ROUND(A.OUT_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.PRICE + ROUND(A.PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)) \n");
		sbSql.append("                          WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL\n");
		sbSql.append("                          THEN ROUND(A.OUT_QTY * DECODE(NVL(D.OP_PRICE,0),0,SCC_CEIL(A.PRICE + ROUND(A.PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL),D.OP_PRICE)) \n");
		sbSql.append("                     ELSE ROUND(A.OUT_QTY * A.PRICE) END");
		sbSql.append("                ) AS AMT6");
		*/
		sbSql.append("               ,SUM(A.OUT_OPAMOUNT) AS AMT6  \n");
		sbSql.append("             , 0 AS EXP_RATE \n");
		//sbSql.append("          FROM FMP_SUBUL A, FMU_OP_RATE C, FMS_ITEM_V D, FMS_SUBINVENTORY Z \n");
		sbSql.append("           FROM (SELECT A.* , B.ITEM_CLASS4, B.CONSUM_YN, B.OTCUSTCD FROM FMP_SUBUL A, FMS_ITEM_V B WHERE A.ITEM_CODE = B.ITEM_CODE) A \n");
		/*
	    sbSql.append("               ,( SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE												\n");
	    sbSql.append("                    FROM FMU_OP_RATE 																						\n");
	    sbSql.append("           	     WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " 									\n");
	    sbSql.append("                     AND USE_YN = 'Y'																						\n");
	    sbSql.append("           		   AND ITEM_TYPE = 'M'																				\n");
	    sbSql.append("           		) C																										\n");
	    sbSql.append("               ,( SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE												\n");
	    sbSql.append("                    FROM FMU_OP_RATE 																						\n");
	    sbSql.append("           	     WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " 									\n");
	    sbSql.append("                     AND USE_YN = 'Y'																						\n");
	    sbSql.append("           		   AND ITEM_TYPE = 'C'																				\n");
	    sbSql.append("           		) D																									    \n");
	    */
	    sbSql.append("           	 ,FMS_SUBINVENTORY Z																						\n");
		sbSql.append("         WHERE 1 = 1 \n");
		//sbSql.append("           AND A.SDATE BETWEEN C.SDATE(+) AND C.EDATE(+) \n");
		//sbSql.append("           AND A.ITEM_CODE BETWEEN C.ITEM_CODE(+) AND C.ITEM_CODE(+)||'9999' \n");
		//sbSql.append("           AND C.USE_YN(+) = 'Y' \n");
		//sbSql.append("           AND A.ITEM_CODE = D.ITEM_CODE \n");
		/*
		sbSql.append("           AND A.SDATE BETWEEN C.SDATE(+) AND C.EDATE(+)                                                             		\n");
        sbSql.append("           AND A.SDATE BETWEEN D.SDATE(+) AND D.EDATE(+)                                                             		\n");
        sbSql.append("           AND A.ITEM_CODE = C.ITEM_CODE(+)																				\n");
		sbSql.append("           AND A.ITEM_CLASS4 = D.ITEM_CODE(+)																			    \n");
		*/
		sbSql.append("           AND A.SDATE BETWEEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATET")) + "' \n");
		sbSql.append("           AND A.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
		sbSql.append("           AND A.CONSUM_YN = 'Y' \n");
		sbSql.append("           AND Z.SUBINV_CODE = A.SUBINV_CODE\n");
		sbSql.append("           AND Z.STOCK_YN = 'Y' \n");
		sbSql.append("         GROUP BY A.SDATE \n");
		sbSql.append("        ----------- \n");
		sbSql.append("         UNION ALL --재고업장이 아니면 한화품목은 FMS_TRANSACTION_V 에서 가져옴(소모품)\n");
		sbSql.append("        ----------- \n");
		sbSql.append("        SELECT A.TRANS_DATE \n");
		sbSql.append("             , 0 AS AMT1 \n");
		sbSql.append("             , 0 AS AMT2 \n");
		sbSql.append("             , 0 AS AMT3 \n");
		sbSql.append("             , 0 AS AMT4 \n");
		sbSql.append("             , 0 AS AMT5 \n");
		//sbSql.append("             , SUM(DECODE(D.OTCUSTCD,'0000',DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.TRANS_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)),0)) AS AMT6  \n");
		/*
		sbSql.append("              , SUM( CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
		sbSql.append("                          THEN DECODE(A.OTCUSTCD,'0000',DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.TRANS_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)),0) \n");
		sbSql.append("                          WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL\n");
		sbSql.append("                          THEN DECODE(A.OTCUSTCD,'0000',DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.TRANS_QTY * DECODE(NVL(D.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL),D.OP_PRICE)),0) \n");
		sbSql.append("                     ELSE DECODE(A.OTCUSTCD,'0000',DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.TRANS_QTY * A.SALE_PRICE),0) END");
		sbSql.append("                ) AS AMT6");
		*/
		sbSql.append("             , SUM(DECODE(A.OTCUSTCD,'0000',DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.SAL_OPER_PRICE, 0, ROUND(A.SALE_PRICE*A.TRANS_QTY), ROUND(A.SAL_OPER_PRICE*A.TRANS_QTY)),0)) AS AMT6 \n");
		sbSql.append("             , 0 AS EXP_RATE \n");
		//sbSql.append("          FROM HLDC_PO_TRANSACTION A, FMU_OP_RATE C, FMS_ITEM_V D, FMS_SUBINVENTORY Z \n");
		sbSql.append("           FROM (SELECT A.* , B.ITEM_CLASS4, B.CONSUM_YN, B.OTCUSTCD FROM FMS_TRANSACTION_V A, FMS_ITEM_V B WHERE A.ITEM_CODE = B.ITEM_CODE) A \n");
		/*
	    sbSql.append("               ,( SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE												\n");
	    sbSql.append("                    FROM FMU_OP_RATE 																						\n");
	    sbSql.append("           	     WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " 									\n");
	    sbSql.append("                     AND USE_YN = 'Y'																						\n");
	    sbSql.append("           		   AND ITEM_TYPE = 'M'																				\n");
	    sbSql.append("           		) C																										\n");
	    sbSql.append("               ,( SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE												\n");
	    sbSql.append("                    FROM FMU_OP_RATE 																						\n");
	    sbSql.append("           	     WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " 									\n");
	    sbSql.append("                     AND USE_YN = 'Y'																						\n");
	    sbSql.append("           		   AND ITEM_TYPE = 'C'																				\n");
	    sbSql.append("           		) D																									    \n");
	    */
	    sbSql.append("           	 ,FMS_SUBINVENTORY Z																						\n");
		sbSql.append("         WHERE 1 = 1 \n");
		//sbSql.append("           AND A.TRANS_UPJANG = C.UPJANG(+) \n");
		//sbSql.append("           AND A.TRANS_DATE BETWEEN C.SDATE(+) AND C.EDATE(+) \n");
		//sbSql.append("           AND A.ITEM_CODE BETWEEN C.ITEM_CODE(+) AND C.ITEM_CODE(+)||'9999' \n");
		//sbSql.append("           AND C.USE_YN(+) = 'Y' \n");
		/*
		sbSql.append("           AND A.TRANS_DATE BETWEEN C.SDATE(+) AND C.EDATE(+)                                                             		\n");
        sbSql.append("           AND A.TRANS_DATE BETWEEN D.SDATE(+) AND D.EDATE(+)                                                             		\n");
        sbSql.append("           AND A.ITEM_CODE = C.ITEM_CODE(+)																				\n");
		sbSql.append("           AND A.ITEM_CLASS4 = D.ITEM_CODE(+)																			    \n");
		*/
		sbSql.append("           AND A.TRANS_DATE BETWEEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATET")) + "' \n");
		sbSql.append("           AND A.TRANS_UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
		sbSql.append("           AND (A.TRANS_TYPE = 'I001' OR (A.TRANS_TYPE LIKE '_002' AND A.SOURCE_TYPE = 'PO')) \n");
		sbSql.append("           AND A.CONSUM_YN = 'Y' \n");
		sbSql.append("           AND Z.SUBINV_CODE = A.SUBINV_CODE\n");
		sbSql.append("           AND Z.STOCK_YN = 'N' \n");
		sbSql.append("         GROUP BY A.TRANS_DATE \n");
		sbSql.append("        ----------- \n");
		sbSql.append("         UNION ALL --재고업장이 아니면 공급업체품목은 FMP_OTCUST_PR 에서 가져옴(소모품)\n");
		sbSql.append("        ----------- \n");
        sbSql.append("        SELECT A.NEED_DATE AS SDATE                                                                                                                        \n");
        sbSql.append("             , 0 AS AMT1                                                                                                                                   \n");
        sbSql.append("             , 0 AS AMT2                                                                                                                                   \n");
        sbSql.append("             , 0 AS AMT3 \n");
        sbSql.append("             , 0 AS AMT4                                                                                                                                   \n");
        sbSql.append("             , 0 AS AMT5                                                                                                                                   \n");
        //sbSql.append("             , SUM(ROUND(A.PO_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))) AS AMT6 \n");
        /*
        sbSql.append("              , SUM( CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
		sbSql.append("                          THEN ROUND(A.PO_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)) \n");
		sbSql.append("                          WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL\n");
		sbSql.append("                          THEN ROUND(A.PO_QTY * DECODE(NVL(D.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL),D.OP_PRICE)) \n");
		sbSql.append("                     ELSE ROUND(A.PO_QTY * A.SALE_PRICE) END");
		sbSql.append("                ) AS AMT6");
        */
		sbSql.append("             , SUM(A.OP_AMOUNT) AS AMT6 \n");
		sbSql.append("             , 0 AS EXP_RATE                                                                                                                               \n");
        //sbSql.append("          FROM FMP_OTCUST_PR A, FMU_OP_RATE C, FMS_ITEM_V D, FMS_SUBINVENTORY Z                                                                                                \n");
        sbSql.append("           FROM (SELECT A.* , B.ITEM_CLASS4, B.CONSUM_YN, B.OTCUSTCD FROM FMP_OTCUST_PR A, FMS_ITEM_V B WHERE A.ITEM_CODE = B.ITEM_CODE) A \n");
        /*
	    sbSql.append("               ,( SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE												\n");
	    sbSql.append("                    FROM FMU_OP_RATE 																						\n");
	    sbSql.append("           	     WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " 									\n");
	    sbSql.append("                     AND USE_YN = 'Y'																						\n");
	    sbSql.append("           		   AND ITEM_TYPE = 'M'																				\n");
	    sbSql.append("           		) C																										\n");
	    sbSql.append("               ,( SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE												\n");
	    sbSql.append("                    FROM FMU_OP_RATE 																						\n");
	    sbSql.append("           	     WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " 									\n");
	    sbSql.append("                     AND USE_YN = 'Y'																						\n");
	    sbSql.append("           		   AND ITEM_TYPE = 'C'																				\n");
	    sbSql.append("           		) D																									    \n");
	    */
	    sbSql.append("           	 ,FMS_SUBINVENTORY Z																						\n");
		sbSql.append("         WHERE 1 = 1                                                                                                                   \n");
        //sbSql.append("           AND A.UPJANG = C.UPJANG(+)                                                                                                                      \n");
        //sbSql.append("           AND A.NEED_DATE BETWEEN C.SDATE(+) AND C.EDATE(+)                                                                                               \n");
        //sbSql.append("           AND A.ITEM_CODE BETWEEN C.ITEM_CODE(+) AND C.ITEM_CODE(+)||'9999'                                                                               \n");
        //sbSql.append("           AND C.USE_YN(+) = 'Y'                                                                                                                           \n");
        /*
        sbSql.append("           AND A.NEED_DATE BETWEEN C.SDATE(+) AND C.EDATE(+)                                                             		\n");
        sbSql.append("           AND A.NEED_DATE BETWEEN D.SDATE(+) AND D.EDATE(+)                                                             		\n");
        sbSql.append("           AND A.ITEM_CODE = C.ITEM_CODE(+)																				\n");
		sbSql.append("           AND A.ITEM_CLASS4 = D.ITEM_CODE(+)																			    \n");
		*/
        sbSql.append("           AND A.NEED_DATE BETWEEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATET")) + "' \n");
        sbSql.append("           AND A.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
        sbSql.append("           AND A.CONSUM_YN = 'Y'                                                                                                                           \n");
        sbSql.append("           AND A.LINE_STATUS <> '003'                                                                                                                           \n");        
		sbSql.append("           AND Z.SUBINV_CODE = A.SUBINV_CODE\n");
		sbSql.append("           AND Z.STOCK_YN = 'N' \n");
        sbSql.append("         GROUP BY A.NEED_DATE                                                                                                                              \n");		        
		sbSql.append("        ----------- \n");
		sbSql.append("         UNION ALL \n");
		sbSql.append("        ----------- \n");
		sbSql.append("        SELECT A.NEED_DATE AS SDATE \n");
		sbSql.append("             , 0 AS AMT1 \n");
		sbSql.append("             , 0 AS AMT2 \n");
		sbSql.append("             , 0 AS AMT3 \n");
		sbSql.append("             , SUM(A.SUPPLYAMT) AS AMT4 \n");
		sbSql.append("             , 0 AS AMT5 \n");
		sbSql.append("             , 0 AS AMT6 \n");
		sbSql.append("             , 0 AS EXP_RATE \n");
		sbSql.append("          FROM FMP_LOCALPO A, FMS_ITEM_V B \n");
		sbSql.append("         WHERE A.ITEM_CODE = B.ITEM_CODE \n");
		sbSql.append("           AND A.NEED_DATE BETWEEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATET")) + "' \n");
		sbSql.append("           AND A.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
		sbSql.append("           AND B.CONSUM_YN = 'N' \n");
		sbSql.append("         GROUP BY A.NEED_DATE \n");
		sbSql.append("        ----------- \n");
		sbSql.append("         UNION ALL \n");
		sbSql.append("        ----------- \n");
		sbSql.append("        SELECT YYMM||DD AS SDATE \n");
		sbSql.append("             , 0 AS AMT1 \n");
		sbSql.append("             , 0 AS AMT2 \n");
		sbSql.append("             , 0 AS AMT3 \n");
		sbSql.append("             , 0 AS AMT4 \n");
		sbSql.append("             , EMP_QTY * EMP_UPRICE * -1 AS AMT5 \n");
		sbSql.append("             , 0 AS AMT6 \n");
		sbSql.append("             , EXP_RATE \n");
		sbSql.append("          FROM FMO_MONTH_PLAN_DTL \n");
		sbSql.append("         WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
		sbSql.append("           AND YYMM = SUBSTR('" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "',1,6) \n");
		sbSql.append("           AND DD BETWEEN SUBSTR('" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "',7) AND SUBSTR('" + nullToBlank(ds_cond.getString(0, "NEED_DATET")) + "',7) \n");
		sbSql.append(") GROUP BY SDATE \n");
		sbSql.append("  ORDER BY SDATE \n");
		
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
