<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/수불관리
■ 프로그램ID   : FMP00641P_T001.jsp
■ 프로그램명   : 사업장별 거래실적집계 상세조회
■ 작성일자     : 2008-07-21
■ 작성자       : 박은규
■ 이력관리     : 2008-07-21
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
		String sWhere       = nullToBlank(in_vl.getString("sWhere"));
		String sUpjang      = nullToBlank(in_vl.getString("sUpjang"));
		String sSubinvCode  = nullToBlank(in_vl.getString("sSubinvCode"));
		//FileLog.println("d:\\aaa.txt", ds_cond);

		if("undefined".equals(sSubinvCode))
		{
			sSubinvCode = "";
		}

		//out 데이타
		DataSet ds_list;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		//
		String sOtCust = nullToBlank(ds_cond.getString(0, "OTCUSTCD"));
		//String sSubinvCode = nullToBlank(ds_cond.getString(0, "SUBINV_CODE"));
		//String sUpjang = nullToBlank(ds_cond.getString(0, "UPJANG"));
		//내역조회
		sbSql.append("SELECT A.* FROM \n");
		sbSql.append("( \n");
		if (sOtCust.equals("0000") || sOtCust.equals(""))
		{

			//sbSql.append("SELECT /*+ INDEX(A PO_TRANSACTION_PT_I8) */ \n");
			sbSql.append("SELECT  \n");
			if (sType.equals("001"))
				sbSql.append("       A.TRANS_DATE AS NEED_DATE_ORI, TO_CHAR(TO_DATE(A.TRANS_DATE,'YYYYMMDD'),'YYYY-MM-DD') AS NEED_DATE \n");
			else
				sbSql.append("       TO_CHAR(A.TRANS_UPJANG) AS NEED_DATE_ORI, B.UPJANGNM_DISP AS NEED_DATE \n");
			sbSql.append("     , A.SUBINV_CODE, D.SUBINV_NAME_DISP \n");
			sbSql.append("     , A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.TRANS_UOM AS PO_UOM \n");
			sbSql.append("     , DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * A.TRANS_QTY AS TRANS_QTY \n");			
			/*
			sbSql.append("         , ( CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
			sbSql.append("                  THEN DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE) \n");
			sbSql.append("                  WHEN CC.OP_PRICE IS NOT NULL OR CC.OP_RATE IS NOT NULL\n");
			sbSql.append("                  THEN DECODE(NVL(CC.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(CC.OP_RATE,0) / 100),CC.CEIL_VAL),CC.OP_PRICE) \n");
			sbSql.append("             ELSE A.SALE_PRICE END\n");
			sbSql.append("            ) AS OP_PRICE\n");
			*/
			sbSql.append( "        , DECODE(A.SAL_OPER_PRICE, 0, A.SALE_PRICE, A.SAL_OPER_PRICE) AS OP_PRICE \n");
			/*
			sbSql.append("         , ( CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
			sbSql.append("                  THEN DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.TRANS_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)) \n");
			sbSql.append("                  WHEN CC.OP_PRICE IS NOT NULL OR CC.OP_RATE IS NOT NULL\n");
			sbSql.append("                  THEN DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.TRANS_QTY * DECODE(NVL(CC.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(CC.OP_RATE,0) / 100),CC.CEIL_VAL),CC.OP_PRICE)) \n");
			sbSql.append("             ELSE DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.TRANS_QTY * A.SALE_PRICE) END\n");
			sbSql.append("            ) AS OP_AMOUNT\n");		
			*/
			sbSql.append("         , DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.SAL_OPER_PRICE, 0, ROUND(A.SALE_PRICE*A.TRANS_QTY), ROUND(A.SAL_OPER_PRICE*A.TRANS_QTY)) AS OP_AMOUNT \n");
			/*
			sbSql.append("         , ( CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
			sbSql.append("                  THEN DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * ROUND(A.TRANS_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))) \n");
			sbSql.append("                  WHEN CC.OP_PRICE IS NOT NULL OR CC.OP_RATE IS NOT NULL\n");
			sbSql.append("                  THEN DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * ROUND(A.TRANS_QTY * DECODE(NVL(CC.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(CC.OP_RATE,0) / 100),CC.CEIL_VAL),CC.OP_PRICE))) \n");
			sbSql.append("             ELSE DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * ROUND(A.TRANS_QTY * A.SALE_PRICE)) END\n");
			sbSql.append("            ) AS OP_VAT\n");
			*/
			//sbSql.append("         , DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * DECODE(A.SAL_OPER_PRICE, 0, ROUND(A.SALE_PRICE*A.TRANS_QTY), ROUND(A.SAL_OPER_PRICE*A.TRANS_QTY))) AS OP_VAT \n");
			/*
			sbSql.append("         , ( CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
			sbSql.append("                  THEN DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.TRANS_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))) \n");
			sbSql.append("                  WHEN CC.OP_PRICE IS NOT NULL OR CC.OP_RATE IS NOT NULL\n");
			sbSql.append("                  THEN DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.TRANS_QTY * DECODE(NVL(CC.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(CC.OP_RATE,0) / 100),CC.CEIL_VAL),CC.OP_PRICE))) \n");
			sbSql.append("             ELSE DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.TRANS_QTY * A.SALE_PRICE)) END\n");
			sbSql.append("            ) AS OP_TOT\n");	
			*/
			//sbSql.append("         , DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * DECODE(A.SAL_OPER_PRICE, 0, ROUND(A.SALE_PRICE*A.TRANS_QTY), ROUND(A.SAL_OPER_PRICE*A.TRANS_QTY))) AS OP_TOT \n");
			//운영율 적용 부과세
			sbSql.append("     , DECODE(A.FLAG,1  \n");
			sbSql.append("     			,DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * ROUND(A.TRANS_QTY * A.SAL_OPER_PRICE))\n");
			sbSql.append("     			,DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.SALE_VAT)  \n");
			sbSql.append("     )  AS OP_VAT  \n");
			//sbSql.append("     , DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.TRANS_QTY * A.SAL_OPER_PRICE)) AS OP_TOT \n");
			//운영율 적용 토탈금액
			sbSql.append("     , DECODE(A.FLAG,1   \n");
			sbSql.append("     			,DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.TRANS_QTY * A.SAL_OPER_PRICE))\n");
			sbSql.append("     			,DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.TRANS_QTY * A.SAL_OPER_PRICE + SALE_VAT)  \n");
			sbSql.append("     )  AS OP_TOT  \n");
			sbSql.append("     , A.SALE_PRICE AS OP_PRICE1 \n");
			sbSql.append("     , DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.SALE_PRICE*A.TRANS_QTY) AS OP_AMOUNT1 \n");
			//sbSql.append("     , DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * ROUND(A.SALE_PRICE*A.TRANS_QTY)) AS OP_VAT1 \n");
			//sbSql.append("     , DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.SALE_PRICE*A.TRANS_QTY)) AS OP_TOT1 \n");
			//운영율 미적용 부과세
			sbSql.append("     , DECODE(A.FLAG,1  \n");
			sbSql.append("     			,DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * ROUND(A.TRANS_QTY * A.SALE_PRICE))\n");
			sbSql.append("     			,DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(SALE_VAT)  \n");
			sbSql.append("     ) AS OP_VAT1  \n");
			//운영율 미적용 토탈금액
			sbSql.append("     , DECODE(A.FLAG,1   \n");
			sbSql.append("     			,DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.TRANS_QTY * A.SALE_PRICE))\n");
			sbSql.append("     			,DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.TRANS_QTY * A.SAL_OPER_PRICE + SALE_VAT)  \n");
			sbSql.append("     )  AS OP_TOT1  \n");
			/*원산지 추가 -> 20150528 김진희 매니저 요청*/
			sbSql.append("     , A.ORIGIN_TYPE AS ORIGIN_TYPE \n");
			sbSql.append("  FROM (SELECT A.* , B.ORIGIN_TYPE, DECODE(SUBSTR(A.TRANS_DATE,1,6), SUBSTR(A.MG_DATE,1,6), A.TRANS_DATE, MG_DATE) AS AA_DATE ,B.ITEM_CLASS4 FROM FMS_TRANSACTION_V A, FMS_ITEM_V B WHERE A.ITEM_CODE = B.ITEM_CODE) A, FMS_UPJANG B, FMS_SUBINVENTORY D \n");
			/*
			sbSql.append("     ,( SELECT UPJANG, ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE											\n");
		    sbSql.append("          FROM FMU_OP_RATE 																					\n");
		    sbSql.append("         WHERE ITEM_TYPE = 'M' 									\n");
		    sbSql.append("           AND USE_YN = 'Y'																					\n");
		    //sbSql.append("           AND UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " 									\n");
		    sbSql.append("       ) C																									\n");
		    sbSql.append("      ,( SELECT UPJANG, ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE											\n");
		    sbSql.append("           FROM FMU_OP_RATE 																					\n");
		    sbSql.append("          WHERE ITEM_TYPE = 'C' 									\n");
		    sbSql.append("            AND USE_YN = 'Y'																					\n");
		    //sbSql.append("            AND UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " 									\n");
		    sbSql.append("        ) CC 		                                                                                            \n");
		    */
			sbSql.append(" WHERE A.TRANS_UPJANG = B.UPJANG \n");	
		    /*
			sbSql.append("   AND A.TRANS_UPJANG = C.UPJANG(+) \n");
			sbSql.append("   AND A.TRANS_UPJANG = CC.UPJANG(+) \n");
			sbSql.append("   AND A.ITEM_CODE = C.ITEM_CODE(+) \n");
	        sbSql.append("   AND A.ITEM_CLASS4 = CC.ITEM_CODE(+) \n");
	        sbSql.append("   AND A.TRANS_DATE BETWEEN C.SDATE(+) AND C.EDATE(+) \n");
	        sbSql.append("   AND A.TRANS_DATE BETWEEN CC.SDATE(+) AND CC.EDATE(+) \n");
	        */
	        sbSql.append("   AND A.SUBINV_CODE = D.SUBINV_CODE \n");
			sbSql.append("   AND A.AA_DATE BETWEEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATET")) + "' \n");
			sbSql.append("   AND (A.TRANS_TYPE = 'I001' OR (A.TRANS_TYPE LIKE '_002' AND A.SOURCE_TYPE = 'PO')) \n");
			sbSql.append("   AND B.MAIN_UPJANG = " + nullToBlank(ds_cond.getString(0, "MAIN_UPJANG")) + " \n");
			if (! sUpjang.equals(""))
				sbSql.append("   AND A.TRANS_UPJANG = " + sUpjang + " \n");
			if (sType.equals("001"))
				sbSql.append("   AND A.TRANS_UPJANG = " + sWhere + " \n");
			else
				sbSql.append("   AND A.TRANS_DATE = REPLACE('" + sWhere + "','-') \n");
			
			if(!sSubinvCode.equals(""))
				sbSql.append("   AND A.SUBINV_CODE = '" + sSubinvCode + "'\n");
		}
		if (sOtCust.equals(""))
			sbSql.append(" UNION ALL \n");
		if ((! sOtCust.equals("0000")) || sOtCust.equals(""))
		{
			if (sType.equals("001"))
				sbSql.append("SELECT A.NEED_DATE AS NEED_DATE_ORI, TO_CHAR(TO_DATE(A.NEED_DATE,'YYYYMMDD'),'YYYY-MM-DD') AS NEED_DATE \n");
			else
				sbSql.append("SELECT TO_CHAR(A.UPJANG) AS NEED_DATE_ORI, B.UPJANGNM_DISP AS NEED_DATE \n");
			sbSql.append("     , A.SUBINV_CODE, D.SUBINV_NAME_DISP \n");
			sbSql.append("     , A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM \n");
			sbSql.append("     , A.PR_QTY AS TRANS_QTY \n");
			/*
			sbSql.append("         , ( CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
			sbSql.append("                  THEN DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE) \n");
			sbSql.append("                  WHEN CC.OP_PRICE IS NOT NULL OR CC.OP_RATE IS NOT NULL\n");
			sbSql.append("                  THEN DECODE(NVL(CC.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(CC.OP_RATE,0) / 100),CC.CEIL_VAL),CC.OP_PRICE) \n");
			sbSql.append("             ELSE A.SALE_PRICE END\n");
			sbSql.append("            ) AS OP_PRICE\n");	
			*/
			sbSql.append("     , A.OP_PRICE AS OP_PRICE \n");
			/*
			sbSql.append("         , ( CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
			sbSql.append("                  THEN ROUND(A.PR_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)) \n");
			sbSql.append("                  WHEN CC.OP_PRICE IS NOT NULL OR CC.OP_RATE IS NOT NULL\n");
			sbSql.append("                  THEN ROUND(A.PR_QTY * DECODE(NVL(CC.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(CC.OP_RATE,0) / 100),CC.CEIL_VAL),CC.OP_PRICE)) \n");
			sbSql.append("             ELSE ROUND(A.PR_QTY * A.SALE_PRICE) END\n");
			sbSql.append("            ) AS OP_AMOUNT\n");		
			*/
			sbSql.append("         , ROUND(A.PR_QTY * A.OP_PRICE) AS OP_AMOUNT \n");
			/*
			sbSql.append("         , ( CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
			sbSql.append("                  THEN ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * ROUND(A.PR_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))) \n");
			sbSql.append("                  WHEN CC.OP_PRICE IS NOT NULL OR CC.OP_RATE IS NOT NULL\n");
			sbSql.append("                  THEN ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * ROUND(A.PR_QTY * DECODE(NVL(CC.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(CC.OP_RATE,0) / 100),CC.CEIL_VAL),CC.OP_PRICE))) \n");
			sbSql.append("             ELSE ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * ROUND(A.PR_QTY * A.SALE_PRICE)) END\n");
			sbSql.append("            ) AS OP_VAT\n");		
			*/
			sbSql.append("         , ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * ROUND(A.PR_QTY * A.OP_PRICE)) AS OP_VAT \n");
			/*
			sbSql.append("         , ( CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
			sbSql.append("                  THEN ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.PR_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))) \n");
			sbSql.append("                  WHEN CC.OP_PRICE IS NOT NULL OR CC.OP_RATE IS NOT NULL\n");
			sbSql.append("                  THEN ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.PR_QTY * DECODE(NVL(CC.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(CC.OP_RATE,0) / 100),CC.CEIL_VAL),CC.OP_PRICE))) \n");
			sbSql.append("             ELSE ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.PR_QTY * A.SALE_PRICE)) END\n");
			sbSql.append("            ) AS OP_TOT\n");		
			*/
			sbSql.append("         , ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.PR_QTY * A.OP_PRICE)) AS OP_TOT \n");
			sbSql.append("     , A.SALE_PRICE AS OP_PRICE1 \n");
			sbSql.append("     , A.SALE_AMOUNT AS OP_AMOUNT1 \n");
			sbSql.append("     , ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * A.SALE_AMOUNT) AS OP_VAT1 \n");
			sbSql.append("     , ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * A.SALE_AMOUNT) AS OP_TOT1 \n");
			/*원산지 추가 -> 20150528 김진희 매니저 요청*/
			sbSql.append("     , A.ORIGIN_TYPE AS ORIGIN_TYPE \n");
			sbSql.append("  FROM (SELECT A.* , B.ORIGIN_TYPE, B.ITEM_CLASS4 FROM FMP_OTCUST_PR A, FMS_ITEM_V B WHERE A.ITEM_CODE = B.ITEM_CODE) A, FMS_UPJANG B, FMS_SUBINVENTORY D \n");
			/*
			sbSql.append("     ,( SELECT UPJANG, ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE											\n");
		    sbSql.append("          FROM FMU_OP_RATE 																					\n");
		    sbSql.append("         WHERE ITEM_TYPE = 'M' 									\n");
		    sbSql.append("           AND USE_YN = 'Y'																					\n");
		    //sbSql.append("           AND UPJANG = " + nullToBlank(ds_cond.getString(0, "MAIN_UPJANG")) + " 									\n");
		    sbSql.append("       ) C																									\n");
		    sbSql.append("      ,( SELECT UPJANG, ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE											\n");
		    sbSql.append("           FROM FMU_OP_RATE 																					\n");
		    sbSql.append("          WHERE ITEM_TYPE = 'C'									\n");
		    sbSql.append("            AND USE_YN = 'Y'																					\n");
		    //sbSql.append("            AND UPJANG = " + nullToBlank(ds_cond.getString(0, "MAIN_UPJANG")) + " 									\n");
		    sbSql.append("        ) CC 																									\n");
		    */
			sbSql.append(" WHERE A.UPJANG = B.UPJANG \n");
		    /*
			sbSql.append("   AND A.UPJANG = C.UPJANG(+) \n");
			sbSql.append("   AND A.UPJANG = CC.UPJANG(+) \n");
			sbSql.append("   AND A.ITEM_CODE = C.ITEM_CODE(+) \n");
	        sbSql.append("   AND A.ITEM_CLASS4 = CC.ITEM_CODE(+) \n");
	        sbSql.append("   AND A.NEED_DATE BETWEEN C.SDATE(+) AND C.EDATE(+) \n");
	        sbSql.append("   AND A.NEED_DATE BETWEEN CC.SDATE(+) AND CC.EDATE(+) \n");
	        */
			sbSql.append("   AND A.SUBINV_CODE = D.SUBINV_CODE \n");			
			sbSql.append("   AND A.NEED_DATE BETWEEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATET")) + "' \n");
			sbSql.append("   AND B.MAIN_UPJANG = " + nullToBlank(ds_cond.getString(0, "MAIN_UPJANG")) + " \n");
			if (! sUpjang.equals(""))
				sbSql.append("   AND A.UPJANG = " + sUpjang + " \n");
			if (sType.equals("001"))
				sbSql.append("   AND A.UPJANG = " + sWhere + " \n");
			else
				sbSql.append("   AND A.NEED_DATE = REPLACE('" + sWhere + "','-') \n");
			if (! sOtCust.equals(""))
				sbSql.append("   AND A.OTCUSTCD = '" + nullToBlank(ds_cond.getString(0, "OTCUSTCD")) + "' \n");
			sbSql.append("   AND A.LINE_STATUS <> '003' \n");
		}
		sbSql.append(") A \n");
		sbSql.append(" ORDER BY A.NEED_DATE_ORI, A.SUBINV_CODE, A.ITEM_CODE \n");

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
