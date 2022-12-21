<%
//-----------------------------------------------------------------------------
//■ 시스템명     : 식재영업/수불관리/실적관리/식재료비 현황
//■ 프로그램ID   : FMP00750V_T001.jsp
//■ 프로그램명   : 식재료비 현황 조회
//■ 작성일자     : 2008.02.05
//■ 작성자       : 노규완
//■ 이력관리     : 2008.02.05
//-----------------------------------------------------------------------------*/
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
		DataSet ds_cond     = in_dl.get("ds_cond");
		//입력 파라메터
	//	String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
	//	String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
	
	//FileLog.println("d:\\aaa.txt", ds_cond);


		//out 데이타
		DataSet ds_list;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		//
		String sUpjang = nullToBlank(ds_cond.getString(0, "MAIN_UPJANG"));		
		String sSdate = nullToBlank(ds_cond.getString(0, "SDATE"));
		String sEdate = nullToBlank(ds_cond.getString(0, "EDATE"));		

// alert기능	 System.out.println(nullToBlank(ds_cond.getString(0, "ITEM_DETAIL")));
//		sbSql.append( "      SELECT A.UPJANG, SUM(NVL(A.OCCUR_AMT,0)) AS TOT_SALE_AMT, 0 AS TOT_HANWHA, 0 AS TOT_SUPPLY,0 AS TOT_LOCALPO, 0 AS TOT_EMP, 0 AS EXP_RATE \n");
//		sbSql.append( "         FROM FMO_ACCT_OCCUR A, FMO_ACCOUNT B, FMS_SUBINVENTORY C, FMS_UPJANG D \n");
//		sbSql.append( "       WHERE (1=1) \n");
//		sbSql.append( "         AND A.UPJANG = B.UPJANG \n");
//		sbSql.append( "         AND A.ACCTCD = B.ACCTCD \n");
//		sbSql.append( "         AND B.MANAYN1 = 'Y' \n");
//		sbSql.append( "         AND A.SUBINV_CODE = C.SUBINV_CODE \n");
//		sbSql.append( "         AND C.CONSUM_YN = 'N' \n");
//		sbSql.append( "         AND A.UPJANG = D.UPJANG \n");
//		sbSql.append( "         AND D.MAIN_UPJANG = '" +sUpjang+ "' \n");
//		sbSql.append( "         AND A.OCCUR_DATE BETWEEN '" +sSdate+ "' AND '" +sEdate+ "' \n");
//		sbSql.append( "         GROUP BY A.UPJANG \n");

	
		//내역조회
		sbSql.append( " SELECT A.UPJANG \n");
		sbSql.append( "      , B.UPJANGNM_DISP \n");
		sbSql.append( "      , SUM(A.TOT_SALE_AMT) AS TOT_SALE \n");
		sbSql.append( "      , SUM(NVL(A.TOT_HANWHA,0) + NVL(A.TOT_SUPPLY,0) + NVL(A.TOT_LOCALPO,0) + NVL(A.TOT_EMP,0)) AS TOT_SUM \n");
		sbSql.append( "      , SUM(A.TOT_HANWHA)   AS HANWHA \n");
		sbSql.append( "      , SUM(A.TOT_SUPPLY)   AS SUPPLY \n");
		sbSql.append( "      , SUM(A.TOT_LOCALPO)  AS LOCALPO \n");
		sbSql.append( "      , SUM(A.TOT_EMP)      AS EMP \n");
		sbSql.append( "      , SUM(A.EXP_RATE)     AS EXP_RATE \n");				
		sbSql.append( "      , ROUND(DECODE(SUM(A.TOT_SALE_AMT),0,100,(SUM(A.TOT_HANWHA + A.TOT_SUPPLY + A.TOT_LOCALPO + A.TOT_EMP) / SUM(A.TOT_SALE_AMT)) * 100),1) AS REAL_RATE \n");
		sbSql.append( "      ,( ROUND(DECODE(SUM(A.TOT_SALE_AMT),0,100,(SUM(A.TOT_HANWHA + A.TOT_SUPPLY + A.TOT_LOCALPO + A.TOT_EMP) / SUM(A.TOT_SALE_AMT)) * 100),1) ) - SUM(A.EXP_RATE) AS FIN_RATE \n");
		sbSql.append( " FROM ( \n");		
		sbSql.append( "      SELECT TO_CHAR(A.UPJANG) AS UPJANG, SUM(NVL(A.OCCUR_AMT,0)) AS TOT_SALE_AMT, 0 AS TOT_HANWHA, 0 AS TOT_SUPPLY,0 AS TOT_LOCALPO, 0 AS TOT_EMP, 0 AS EXP_RATE \n");
		sbSql.append( "         FROM FMO_ACCT_OCCUR A, FMS_UPJANG D \n");
		sbSql.append( "       WHERE (1=1) \n");
		sbSql.append( "         AND A.UPJANG = D.UPJANG \n");
		sbSql.append( "         AND D.MAIN_UPJANG = '" +sUpjang+ "' \n");
		sbSql.append( "         AND A.OCCUR_DATE BETWEEN '" +sSdate+ "' AND '" +sEdate+ "' \n");
		sbSql.append( "         GROUP BY A.UPJANG \n");
		sbSql.append( "     UNION ALL \n");
		sbSql.append( "     SELECT TO_CHAR(A.UPJANG) AS UPJANG \n");
		sbSql.append( "          , 0 AS TOT_SALE_AMT \n");
		//sbSql.append( "          , SUM(DECODE(B.OTCUSTCD,'0000',ROUND(A.OUT_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.PRICE + ROUND(A.PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)),0)) AS TOT_HANWHA  \n");
        //운영율 FMU_OP_RATE -> FMP_SUBUL 수정 문형광 20150919 시작
        /*
		sbSql.append("               ,SUM( CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
		sbSql.append("                          THEN DECODE(A.OTCUSTCD,'0000',ROUND(A.OUT_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.PRICE + ROUND(A.PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)),0)\n");
		sbSql.append("                          WHEN CC.OP_PRICE IS NOT NULL OR CC.OP_RATE IS NOT NULL\n");
		sbSql.append("                          THEN DECODE(A.OTCUSTCD,'0000',ROUND(A.OUT_QTY * DECODE(NVL(CC.OP_PRICE,0),0,SCC_CEIL(A.PRICE + ROUND(A.PRICE * NVL(CC.OP_RATE,0) / 100),CC.CEIL_VAL),CC.OP_PRICE)),0)\n");
		sbSql.append("                     ELSE 0 END\n");
		sbSql.append("                ) AS TOT_HANWHA\n");
        */
        sbSql.append("               ,SUM(DECODE(A.OTCUSTCD,'0000',OUT_OPAMOUNT,0)) AS TOT_HANWHA  \n");
		//sbSql.append( "          , SUM(DECODE(B.OTCUSTCD,'0000',0,ROUND(A.OUT_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.PRICE + ROUND(A.PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)))) AS TOT_SUPPLY \n");
		/*
		sbSql.append("               ,SUM( CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
		sbSql.append("                          THEN DECODE(A.OTCUSTCD,'0000',0,ROUND(A.OUT_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.PRICE + ROUND(A.PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)))\n");
		sbSql.append("                          WHEN CC.OP_PRICE IS NOT NULL OR CC.OP_RATE IS NOT NULL\n");
		sbSql.append("                          THEN DECODE(A.OTCUSTCD,'0000',0,ROUND(A.OUT_QTY * DECODE(NVL(CC.OP_PRICE,0),0,SCC_CEIL(A.PRICE + ROUND(A.PRICE * NVL(CC.OP_RATE,0) / 100),CC.CEIL_VAL),CC.OP_PRICE)))\n");
		sbSql.append("                     ELSE DECODE(A.OTCUSTCD,'0000',0,ROUND(A.OUT_QTY * A.PRICE)) END\n");
		sbSql.append("                ) AS TOT_SUPPLY\n");		
        */
        sbSql.append("               ,SUM(DECODE(A.OTCUSTCD,'0000',0,OUT_OPAMOUNT)) AS TOT_SUPPLY  \n");
		
		sbSql.append( "          , 0 AS TOT_LOCALPO \n");
		sbSql.append( "          , 0 AS TOT_EMP \n");
		sbSql.append( "          , 0 AS EXP_RATE \n");
		//sbSql.append( "         FROM FMP_SUBUL A, FMS_ITEM_V B, FMU_OP_RATE C, FMS_UPJANG D \n");
		//sbSql.append("           FROM FMP_SUBUL A																								\n");
	    //sbSql.append("               ,FMS_ITEM_V B																								\n");
	    sbSql.append("           FROM (SELECT A.* , B.ITEM_CLASS4, B.CONSUM_YN, B.OTCUSTCD FROM FMP_SUBUL A, FMS_ITEM_V B WHERE A.ITEM_CODE = B.ITEM_CODE) A \n");
	    /*
	    sbSql.append("               ,( SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE												\n");
	    sbSql.append("                    FROM FMU_OP_RATE 																						\n");
	    sbSql.append("           		   WHERE UPJANG = " + sUpjang + " 																		\n");
	    sbSql.append("                     AND USE_YN = 'Y'																						\n");
	    sbSql.append("           			 AND ITEM_TYPE = 'M'																				\n");
	    sbSql.append("           		) C																										\n");
	    sbSql.append("               ,( SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE												\n");
	    sbSql.append("                    FROM FMU_OP_RATE 																						\n");
	    sbSql.append("           		   WHERE UPJANG = " + sUpjang + " 																		\n");
	    sbSql.append("                     AND USE_YN = 'Y'																						\n");
	    sbSql.append("           			 AND ITEM_TYPE = 'C'																				\n");
	    sbSql.append("           		) CC																									\n");
	    */
	    sbSql.append("           	   ,FMS_UPJANG D																							\n");
		sbSql.append( "       WHERE (1=1) \n");
		//sbSql.append( "         AND 1 = 1 \n");
		//sbSql.append( "         AND A.UPJANG = C.UPJANG(+) \n");
		/*
		sbSql.append( "         AND A.SDATE BETWEEN C.SDATE(+) AND C.EDATE(+) \n");
		sbSql.append( "         AND A.SDATE BETWEEN CC.SDATE(+) AND CC.EDATE(+) \n");
		sbSql.append("          AND A.ITEM_CODE = C.ITEM_CODE(+)																				\n");
		sbSql.append("          AND A.ITEM_CLASS4 = CC.ITEM_CODE(+)																				\n");
		*/
		//운영율 FMU_OP_RATE -> FMS_TRANSACTION_V 수정 문형광 20150919 끝
		
		
		//sbSql.append( "         AND A.ITEM_CODE BETWEEN C.ITEM_CODE(+) AND C.ITEM_CODE(+)||'9999' \n");
		sbSql.append( "         AND A.UPJANG = D.UPJANG \n");
		sbSql.append( "         AND D.MAIN_UPJANG = '" +sUpjang+ "' \n");
		sbSql.append( "         AND A.CONSUM_YN = 'N' \n");
		sbSql.append( "         AND A.SDATE BETWEEN '" +sSdate+ "' AND '" +sEdate+ "' \n");
		sbSql.append( "         AND EXISTS (SELECT 1 FROM FMS_SUBINVENTORY Z WHERE Z.SUBINV_CODE = A.SUBINV_CODE AND Z.STOCK_YN = 'Y') \n");
		//sbSql.append( "         GROUP BY A.UPJANG, A.OUT_QTY, C.OP_PRICE, A.PRICE, C.OP_RATE \n");
		sbSql.append( "         GROUP BY A.UPJANG, A.OUT_QTY \n");
        sbSql.append("     UNION ALL                                                                                                                                                                                                  \n");
        sbSql.append("     SELECT TO_CHAR(A.TRANS_UPJANG) AS UPJANG                                                                                                                                                                            \n");
        sbSql.append("          , 0 AS TOT_SALE_AMT                                                                                                                                                                                   \n");
        //sbSql.append("          , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.TRANS_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))) AS TOT_HANWHA \n");
        /*
        sbSql.append("               ,SUM( CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
		sbSql.append("                          THEN DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.TRANS_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))\n");
		sbSql.append("                          WHEN CC.OP_PRICE IS NOT NULL OR CC.OP_RATE IS NOT NULL\n");
		sbSql.append("                          THEN DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.TRANS_QTY * DECODE(NVL(CC.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(CC.OP_RATE,0) / 100),CC.CEIL_VAL),CC.OP_PRICE))\n");
		sbSql.append("                     ELSE DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.TRANS_QTY * A.SALE_PRICE) END\n");
		sbSql.append("                ) AS TOT_HANWHA\n");
        */
        sbSql.append("          , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.SAL_OPER_PRICE, 0, ROUND(A.SALE_PRICE*A.TRANS_QTY), ROUND(A.SAL_OPER_PRICE*A.TRANS_QTY))) AS TOT_HANWHA \n");
		sbSql.append("          , 0 AS TOT_SUPPLY                                                                                                                                                                                     \n");
        sbSql.append("          , 0 AS TOT_LOCALPO                                                                                                                                                                                    \n");
        sbSql.append("          , 0 AS TOT_EMP                                                                                                                                                                                        \n");
        sbSql.append("          , 0 AS EXP_RATE                                                                                                                                                                                       \n");
        //sbSql.append("         FROM HLDC_PO_TRANSACTION A, FMS_ITEM_V B, FMU_OP_RATE C, FMS_UPJANG D                                                                                                                                  \n");
        //sbSql.append("           FROM HLDC_PO_TRANSACTION A																						\n");
	    //sbSql.append("               ,FMS_ITEM_V B																								\n");
	    sbSql.append("           FROM (SELECT A.* , B.ITEM_CLASS4, B.CONSUM_YN, B.OTCUSTCD FROM FMS_TRANSACTION_V A, FMS_ITEM_V B WHERE A.ITEM_CODE = B.ITEM_CODE) A \n");
	    /*
	    sbSql.append("               ,( SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE												\n");
	    sbSql.append("                    FROM FMU_OP_RATE 																						\n");
	    sbSql.append("           		   WHERE UPJANG = " + sUpjang + " 																		\n");
	    sbSql.append("                     AND USE_YN = 'Y'																						\n");
	    sbSql.append("           			 AND ITEM_TYPE = 'M'																				\n");
	    sbSql.append("           		) C																										\n");
	    sbSql.append("               ,( SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE												\n");
	    sbSql.append("                    FROM FMU_OP_RATE 																						\n");
	    sbSql.append("           		   WHERE UPJANG = " + sUpjang + " 																		\n");
	    sbSql.append("                     AND USE_YN = 'Y'																						\n");
	    sbSql.append("           			 AND ITEM_TYPE = 'C'																				\n");
	    sbSql.append("           		) CC																									\n");
	    */
	    sbSql.append("           	   ,FMS_UPJANG D																							\n");
		sbSql.append("       WHERE (1=1)                                                                                                        \n");
        //sbSql.append("         AND A.ITEM_CODE = B.ITEM_CODE                                                                                    \n");
        //sbSql.append("         AND A.TRANS_UPJANG = C.UPJANG(+)                                                                               \n");
        /*
        sbSql.append("         AND A.TRANS_DATE BETWEEN C.SDATE(+) AND C.EDATE(+)                                                               \n");
        sbSql.append("         AND A.TRANS_DATE BETWEEN CC.SDATE(+) AND CC.EDATE(+)                                                               \n");
        sbSql.append("         AND A.ITEM_CODE = C.ITEM_CODE(+)																					\n");
		sbSql.append("         AND A.ITEM_CLASS4 = CC.ITEM_CODE(+)																				\n");
		*/
        //sbSql.append("         AND A.ITEM_CODE BETWEEN C.ITEM_CODE(+) AND C.ITEM_CODE(+)||'9999'                                                \n");
        sbSql.append("         AND A.TRANS_UPJANG = D.UPJANG                                                                                    \n");
        sbSql.append("         AND D.MAIN_UPJANG = '" +sUpjang+ "' \n");
        sbSql.append("         AND (A.TRANS_TYPE = 'I001' OR (A.TRANS_TYPE LIKE '_002' AND A.SOURCE_TYPE = 'PO')) \n");
        sbSql.append("         AND A.CONSUM_YN = 'N'                                                                                            \n");
        sbSql.append("         AND A.TRANS_DATE BETWEEN '" +sSdate+ "' AND '" +sEdate+ "' \n");
        sbSql.append("         AND EXISTS (SELECT 1 FROM FMS_SUBINVENTORY Z WHERE Z.SUBINV_CODE = A.SUBINV_CODE AND Z.STOCK_YN = 'N')           \n");
        //sbSql.append("         GROUP BY A.TRANS_UPJANG, A.TRANS_QTY, C.OP_PRICE, A.SALE_PRICE, C.OP_RATE                                        \n");
        sbSql.append("         GROUP BY A.TRANS_UPJANG, A.TRANS_QTY                                        \n");
		sbSql.append( "     UNION ALL \n");
        sbSql.append("     SELECT TO_CHAR(A.UPJANG) AS UPJANG, 0 AS TOT_SALE_AMT                                                                                                                                        \n");
        sbSql.append("         , 0 AS TOT_HANWHA                                                                                                                                                     \n");
        //sbSql.append("         , SUM(NVL(A.PO_QTY,0) * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(NVL(A.SALE_PRICE,0) + ROUND(NVL(A.SALE_PRICE,0) * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)) AS TOT_SUPPLY \n");
        /*
        sbSql.append("               ,SUM( CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
		sbSql.append("                          THEN NVL(A.PO_QTY,0) * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(NVL(A.SALE_PRICE,0) + ROUND(NVL(A.SALE_PRICE,0) * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)\n");
		sbSql.append("                          WHEN CC.OP_PRICE IS NOT NULL OR CC.OP_RATE IS NOT NULL\n");
		sbSql.append("                          THEN NVL(A.PO_QTY,0) * DECODE(NVL(CC.OP_PRICE,0),0,SCC_CEIL(NVL(A.SALE_PRICE,0) + ROUND(NVL(A.SALE_PRICE,0) * NVL(CC.OP_RATE,0) / 100),CC.CEIL_VAL),CC.OP_PRICE)\n");
		sbSql.append("                     ELSE NVL(A.PO_QTY,0) * A.SALE_PRICE END\n");
		sbSql.append("                ) AS TOT_SUPPLY\n");
        */
        sbSql.append("          , SUM(A.OP_AMOUNT) AS TOT_SUPPLY \n");
		sbSql.append("         , 0 AS TOT_LOCALPO                                                                                                                                                    \n");
        sbSql.append("         , 0 AS TOT_EMP                                                                                                                                                        \n");
        sbSql.append("         , 0 AS EXP_RATE                                                                                                                                                       \n");
        //sbSql.append("         FROM FMP_OTCUST_PR A, FMP_OTCUST_ITEM B, FMU_OP_RATE C, FMS_UPJANG D                                                                                                  \n");
        //sbSql.append("           FROM FMP_OTCUST_PR A																						\n");
	    //sbSql.append("               ,FMP_OTCUST_ITEM B																								\n");
	    sbSql.append("           FROM (SELECT A.* , B.ITEM_CLASS4, B.CONSUM_YN FROM FMP_OTCUST_PR A, FMS_ITEM_V B WHERE A.ITEM_CODE = B.ITEM_CODE) A \n");
	    /*
	    sbSql.append("               ,( SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE												\n");
	    sbSql.append("                    FROM FMU_OP_RATE 																						\n");
	    sbSql.append("           		   WHERE UPJANG = " + sUpjang + " 																		\n");
	    sbSql.append("                     AND USE_YN = 'Y'																						\n");
	    sbSql.append("           			 AND ITEM_TYPE = 'M'																				\n");
	    sbSql.append("           		) C																										\n");
	    sbSql.append("               ,( SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE												\n");
	    sbSql.append("                    FROM FMU_OP_RATE 																						\n");
	    sbSql.append("           		   WHERE UPJANG = " + sUpjang + " 																		\n");
	    sbSql.append("                     AND USE_YN = 'Y'																						\n");
	    sbSql.append("           			 AND ITEM_TYPE = 'C'																				\n");
	    sbSql.append("           		) CC																									\n");
	    */
	    sbSql.append("           	   ,FMS_UPJANG D																							\n");
		sbSql.append("       WHERE (1=1)                                                                                                                                                             \n");
        //sbSql.append("         AND A.ITEM_CODE = B.ITEM_CODE                                                                                                                                         \n");
        //sbSql.append("         AND A.UPJANG = C.UPJANG(+)                                                                                                                                            \n");
        /*
        sbSql.append("         AND A.NEED_DATE BETWEEN C.SDATE(+) AND C.EDATE(+)                                                                                                                     \n");
        sbSql.append("         AND A.NEED_DATE BETWEEN CC.SDATE(+) AND CC.EDATE(+)                                                                                                                     \n");
        sbSql.append("         AND A.ITEM_CODE = C.ITEM_CODE(+)																					\n");
		sbSql.append("         AND A.ITEM_CLASS4 = CC.ITEM_CODE(+)																				\n");
		*/
        //sbSql.append("         AND A.ITEM_CODE BETWEEN C.ITEM_CODE(+) AND C.ITEM_CODE(+)||'9999'                                                                                                     \n");
        sbSql.append("         AND A.UPJANG = D.UPJANG                                                                                                                                               \n");
        sbSql.append("         AND D.MAIN_UPJANG = '" +sUpjang+ "' \n");
        sbSql.append("         AND A.OTCUSTCD <> '0000'                                                                                                                                              \n");
        sbSql.append("         AND A.CONSUM_YN = 'N'                                                                                                                                                 \n");
        sbSql.append("         AND A.LINE_STATUS <> '003'                                                                                                                           \n");        
        sbSql.append("         AND A.NEED_DATE BETWEEN '" +sSdate+ "' AND '" +sEdate+ "' \n");
        sbSql.append("         AND EXISTS (SELECT 1 FROM FMS_SUBINVENTORY Z WHERE Z.SUBINV_CODE = A.SUBINV_CODE AND Z.STOCK_YN = 'N')                                                                \n");
        //sbSql.append("         GROUP BY A.UPJANG, A.PO_QTY, C.OP_PRICE, A.SALE_PRICE, C.OP_RATE                                                                                                      \n");		
        sbSql.append("         GROUP BY A.UPJANG, A.PO_QTY                                                                                                      \n");
		sbSql.append( "     UNION ALL \n");
		sbSql.append( "     SELECT TO_CHAR(A.UPJANG) AS UPJANG, 0 AS TOT_SALE_AMT, 0 AS TOT_HANWHA, 0 AS TOT_SUPPLY, SUM(NVL(A.AMOUNT,0)) AS TOT_LOCALPO, 0 AS TOT_EMP, 0 AS EXP_RATE \n");
		sbSql.append( "         FROM FMP_LOCALPO A, FMS_ITEM_V B, FMS_UPJANG D \n");
		sbSql.append( "       WHERE (1=1) \n");
		sbSql.append( "         AND A.ITEM_CODE = B.ITEM_CODE \n");
		sbSql.append( "         AND A.UPJANG = D.UPJANG \n");
		sbSql.append( "         AND D.MAIN_UPJANG = '" +sUpjang+ "' \n");
		sbSql.append( "         AND B.CONSUM_YN = 'N' \n");
		sbSql.append( "         AND A.NEED_DATE BETWEEN '" +sSdate+ "' AND '" +sEdate+ "' \n");
		sbSql.append( "         GROUP BY A.UPJANG \n");
		sbSql.append( "     UNION ALL \n");
		sbSql.append( "     SELECT TO_CHAR(A.UPJANG) AS UPJANG \n");
		sbSql.append( "           , 0 AS TOT_SALE_AMT, 0 AS TOT_HANWHA, 0 AS TOT_SUPPLY,0 AS TOT_LOCALPOM, SUM(A.EMP_QTY * A.EMP_UPRICE * -1) AS TOT_EMP \n");
		sbSql.append( "           , ROUND(AVG(A.EXP_RATE),1) AS EXP_RATE \n");
		sbSql.append( "         FROM FMO_MONTH_PLAN_DTL A, FMS_UPJANG D \n");
		sbSql.append( "       WHERE (1=1) \n");
		sbSql.append( "         AND A.UPJANG = D.UPJANG \n");
		sbSql.append( "         AND D.MAIN_UPJANG = '" +sUpjang+ "' \n");
		sbSql.append( "         AND A.YYMM BETWEEN SUBSTR('" +sSdate+ "',1,6) AND SUBSTR('" +sEdate+ "',1,6) \n");
		sbSql.append( "         AND A.DD BETWEEN SUBSTR('" +sSdate+ "',7,2) AND SUBSTR('" +sEdate+ "',7,2) \n");
		sbSql.append( "         GROUP BY A.UPJANG  ) A, FMS_UPJANG B \n");
		sbSql.append( " WHERE (1=1) \n");
		sbSql.append( "       AND A.UPJANG = B.UPJANG \n");
		sbSql.append( " GROUP BY A.UPJANG, B.UPJANGNM_DISP \n");		
		
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_list = this.makeDataSet(rs, "ds_list");
		
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
