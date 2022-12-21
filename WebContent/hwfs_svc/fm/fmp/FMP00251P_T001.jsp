<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/수불관리
■ 프로그램ID   : FMP00251P_T001.jsp
■ 프로그램명   : 입고내역 상세
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

		String sOtCust = nullToBlank(ds_cond.getString(0, "OTCUSTCD"));
		//내역조회
		if (sOtCust.equals("0000"))
		{                                                                                                                                                                               
			sbSql.append("     SELECT	NEED_DATE                                                                                                                                       \n");
		    sbSql.append("           , SUBINV_CODE                                                                                                                                      \n");
			sbSql.append("           , SUBINV_NAME_DISP                                                                                                                                 \n");
			sbSql.append("           , PR_QTY                                                                                                                                           \n");
			sbSql.append("           , RTN_QTY                                                                                                                                          \n");
			sbSql.append("           , IN_QTY                                                                                                                                           \n");
			sbSql.append("           , SALE_PRICE                                                                                                                                       \n");
			sbSql.append("           , OP_PRICE                                                                                                                                         \n");
			sbSql.append("           , ROUND(DELIVERED_QTY * OP_PRICE) AS OP_AMOUNT                                                                                                     \n");
			sbSql.append("           , ROUND(DECODE(TAX_CODE,'100',0.1,0) * ROUND(DELIVERED_QTY * OP_PRICE)) AS OP_VAT                                                                  \n");
			sbSql.append("           , ROUND(DECODE(TAX_CODE,'100',1.1,1) * ROUND(DELIVERED_QTY * OP_PRICE)) AS OP_TOT                                                                  \n");
			sbSql.append("     FROM	(                                                                                                                                                   \n");
			sbSql.append("     	SELECT TO_CHAR(TO_DATE(A.NEED_DATE,'YYYYMMDD'),'YYYY-MM-DD') AS NEED_DATE                                                                               \n");
			sbSql.append("     	     , A.SUBINV_CODE, B.SUBINV_NAME_DISP                                                                                                                \n");
			sbSql.append("     	     , (A.ADJUST_QTY + A.PO_QTY) AS PR_QTY                                                                                                              \n");
			sbSql.append("     	     , (A.ADJUST_QTY + A.CENTER_UNDELI_QTY + A.UNDELIVERED_QTY + A.RETURNED_QTY) AS RTN_QTY                                                             \n");
			sbSql.append("     	     , A.DELIVERED_QTY AS IN_QTY                                                                                                                        \n");
			sbSql.append("     	     , A.SALE_PRICE                                                                                                                                     \n");
			sbSql.append("     	     , A.DELIVERED_QTY                                                                                                                                  \n");
			sbSql.append("     	     , CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL                                                                                        \n");
			sbSql.append("     		    THEN DECODE(SIGN(NVL(C.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE)                \n");
			sbSql.append("     		    WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL                                                                                            \n");
			sbSql.append("     		    THEN DECODE(SIGN(NVL(D.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL), D.OP_PRICE)                \n");
			sbSql.append("     	       ELSE A.SALE_PRICE END AS OP_PRICE --운영단가                                                                                                     \n");
			sbSql.append("     	     , A.TAX_CODE                                                                                                                                       \n");
			sbSql.append("     	  FROM (SELECT A.*, B.ITEM_CLASS4 FROM HLDC_PO_PO A, HLDC_PO_ITEM_MST B WHERE A.ITEM_CODE = B.ITEM_CODE) A                                                   \n");
			sbSql.append("     		    , FMS_SUBINVENTORY B                                                                                                                            \n");
			sbSql.append("     		    , (                                                                                                                                             \n");
			sbSql.append("     			SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE, UPJANG                                                                             \n");
			sbSql.append("     			  FROM FMU_OP_RATE                                                                                                                              \n");
			sbSql.append("     			WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + "                                                                              \n");
			sbSql.append("     			     AND USE_YN = 'Y'                                                                                                                           \n");
			sbSql.append("     			     AND ITEM_TYPE = 'M'                                                                                                                        \n");
			sbSql.append("     		      ) C                                                                                                                                           \n");
			sbSql.append("     		    , (                                                                                                                                             \n");
			sbSql.append("     			SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE, UPJANG                                                                             \n");
			sbSql.append("     			  FROM FMU_OP_RATE                                                                                                                              \n");
			sbSql.append("     			WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + "                                                                              \n");
			sbSql.append("     			      AND USE_YN = 'Y'                                                                                                                          \n");
			sbSql.append("     			      AND ITEM_TYPE = 'C'                                                                                                                       \n");
			sbSql.append("     		      ) D                                                                                                                                           \n");
			sbSql.append("                                                                                                                                                              \n");
			sbSql.append("     	 WHERE A.SUBINV_CODE = B.SUBINV_CODE                                                                                                                    \n");
			sbSql.append("     	   AND A.RC_UPJANG = C.UPJANG(+)                                                                                                                        \n");
			sbSql.append("     	   AND A.RC_UPJANG = D.UPJANG(+)                                                                                                                        \n");
			sbSql.append("     	   AND A.NEED_DATE BETWEEN C.SDATE(+) AND C.EDATE(+)                                                                                                    \n");
			sbSql.append("     	   AND A.NEED_DATE BETWEEN D.SDATE(+) AND D.EDATE(+)                                                                                                    \n");
			sbSql.append("     	   AND A.ITEM_CODE = C.ITEM_CODE(+)                                                                                                                     \n");
			sbSql.append("     	   AND A.ITEM_CLASS4 = D.ITEM_CODE(+)                                                                                                                   \n");
			sbSql.append("     	   AND A.RC_UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + "                                                                                \n");
			sbSql.append("     	   AND A.SUBINV_CODE LIKE '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) + "%'                                                                   \n");
			sbSql.append("     	   AND A.NEED_DATE BETWEEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATET")) + "'       \n");
			sbSql.append("     	   AND A.ITEM_CODE = '" + nullToBlank(ds_cond.getString(0, "ITEM_CODE")) + "'                                                                           \n");
			sbSql.append("     	   AND A.LINE_STATUS = '" + nullToBlank(ds_cond.getString(0, "STATUS_CODE")) + "'                                                                       \n");
			sbSql.append("     	   AND A.DELIVERED_QTY > 0                                                                                                                              \n");
			sbSql.append("     	   )                                                                                                                                                    \n");
			sbSql.append("     WHERE OP_PRICE = " + nullToBlank(ds_cond.getString(0, "OP_PRICE")) + "                                                                                 \n");
		    sbSql.append("     GROUP BY NEED_DATE, SUBINV_CODE, SUBINV_NAME_DISP, PR_QTY, RTN_QTY, IN_QTY, SALE_PRICE, OP_PRICE, TAX_CODE                                               \n");
		    sbSql.append("     ORDER BY NEED_DATE, SUBINV_CODE                                                                                                                          \n");
			/* sbSql.append("SELECT TO_CHAR(TO_DATE(A.NEED_DATE,'YYYYMMDD'),'YYYY-MM-DD') AS NEED_DATE \n");
			sbSql.append("     , A.SUBINV_CODE, B.SUBINV_NAME_DISP \n");
			sbSql.append("     , (A.ADJUST_QTY + A.PO_QTY) AS PR_QTY \n");
			sbSql.append("     , (A.ADJUST_QTY + A.CENTER_UNDELI_QTY + A.UNDELIVERED_QTY + A.RETURNED_QTY) AS RTN_QTY \n");
			sbSql.append("     , A.DELIVERED_QTY AS IN_QTY \n");
			sbSql.append("     , A.SALE_PRICE \n");
			sbSql.append("     , DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE) AS OP_PRICE \n");
			sbSql.append("     , ROUND(A.DELIVERED_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)) AS OP_AMOUNT \n");
			sbSql.append("     , ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * ROUND(A.DELIVERED_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))) AS OP_VAT \n");
			sbSql.append("     , ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.DELIVERED_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))) AS OP_TOT \n");
			sbSql.append("  FROM HLDC_PO_PO A, FMS_SUBINVENTORY B, FMU_OP_RATE C \n");
			sbSql.append(" WHERE A.SUBINV_CODE = B.SUBINV_CODE \n");
			sbSql.append("   AND A.RC_UPJANG = C.UPJANG(+) \n");
			sbSql.append("   AND A.NEED_DATE BETWEEN C.SDATE(+) AND C.EDATE(+) \n");
			sbSql.append("   AND A.ITEM_CODE BETWEEN C.ITEM_CODE(+) AND C.ITEM_CODE(+)||'9999' \n");
			sbSql.append("   AND C.USE_YN(+) = 'Y' \n");
			sbSql.append("   AND A.RC_UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
			sbSql.append("   AND A.SUBINV_CODE LIKE '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) + "%' \n");
			sbSql.append("   AND A.NEED_DATE BETWEEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATET")) + "' \n");
			sbSql.append("   AND A.ITEM_CODE = '" + nullToBlank(ds_cond.getString(0, "ITEM_CODE")) + "' \n");
			sbSql.append("   AND A.LINE_STATUS = '" + nullToBlank(ds_cond.getString(0, "STATUS_CODE")) + "' \n");
			sbSql.append("   AND DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE) = " + nullToBlank(ds_cond.getString(0, "OP_PRICE")) + " \n");
			sbSql.append("   AND A.DELIVERED_QTY > 0 \n");
			sbSql.append(" ORDER BY A.NEED_DATE, A.SUBINV_CODE \n"); */
		}
		else if (sOtCust.equals("ZZZZ"))
		{
			sbSql.append("SELECT TO_CHAR(TO_DATE(A.NEED_DATE,'YYYYMMDD'),'YYYY-MM-DD') AS NEED_DATE \n");
			sbSql.append("     , A.SUBINV_CODE, B.SUBINV_NAME_DISP \n");
			sbSql.append("     , A.QTY AS PR_QTY \n");
			sbSql.append("     , 0 AS RTN_QTY \n");
			sbSql.append("     , A.QTY AS IN_QTY \n");
			sbSql.append("     , A.PRICE AS SALE_PRICE \n");
			sbSql.append("     , A.PRICE AS OP_PRICE \n");
			sbSql.append("     , A.SUPPLYAMT AS OP_AMOUNT \n");
			sbSql.append("     , A.VAT AS OP_VAT \n");
			sbSql.append("     , A.AMOUNT AS OP_TOT \n");
			sbSql.append("  FROM FMP_LOCALPO A, FMS_SUBINVENTORY B \n");
			sbSql.append(" WHERE A.SUBINV_CODE = B.SUBINV_CODE \n");
			sbSql.append("   AND A.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
			sbSql.append("   AND A.SUBINV_CODE LIKE '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) + "%' \n");
			sbSql.append("   AND A.NEED_DATE BETWEEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATET")) + "' \n");
			sbSql.append("   AND A.ITEM_CODE = '" + nullToBlank(ds_cond.getString(0, "ITEM_CODE")) + "' \n");
			sbSql.append(" ORDER BY A.NEED_DATE, A.SUBINV_CODE \n");
		}
		else
		{
			sbSql.append("     SELECT	NEED_DATE                                                                                                                                \n");
			sbSql.append("           , SUBINV_CODE                                                                                                                               \n");
			sbSql.append("           , SUBINV_NAME_DISP                                                                                                                          \n");
			sbSql.append("           , PR_QTY                                                                                                                                    \n");
			sbSql.append("           , 0 AS RTN_QTY                                                                                                                              \n");
			sbSql.append("           , PR_QTY AS IN_QTY                                                                                                                          \n");
			sbSql.append("           , SALE_PRICE                                                                                                                                \n");
			sbSql.append("           , OP_PRICE                                                                                                                                  \n");
			sbSql.append("           , ROUND(PR_QTY * OP_PRICE) AS OP_AMOUNT                                                                                                     \n");
			sbSql.append("           , ROUND(DECODE(TAX_CODE,'100',0.1,0) * ROUND(PR_QTY * OP_PRICE)) AS OP_VAT                                                                  \n");
			sbSql.append("           , ROUND(DECODE(TAX_CODE,'100',1.1,1) * ROUND(PR_QTY * OP_PRICE)) AS OP_TOT                                                                  \n");
			sbSql.append("     FROM	(	                                                                                                                                         \n");
			sbSql.append("     	SELECT TO_CHAR(TO_DATE(A.NEED_DATE,'YYYYMMDD'),'YYYY-MM-DD') AS NEED_DATE                                                                        \n");
			sbSql.append("     	     , A.SUBINV_CODE, B.SUBINV_NAME_DISP                                                                                                         \n");
			sbSql.append("     	     , A.PR_QTY                                                                                                                                  \n");
			sbSql.append("     	     , 0 AS RTN_QTY                                                                                                                              \n");
			sbSql.append("     	     , A.PR_QTY AS IN_QTY                                                                                                                        \n");
			sbSql.append("     	     , A.SALE_PRICE                                                                                                                              \n");
			sbSql.append("     	     , A.TAX_CODE                                                                                                                                \n");
			sbSql.append("     	     , CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL                                                                                 \n");
			sbSql.append("     		      THEN DECODE(SIGN(NVL(C.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE)       \n");
			sbSql.append("     		      WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL                                                                                   \n");
			sbSql.append("     		      THEN DECODE(SIGN(NVL(D.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL), D.OP_PRICE)       \n");
			sbSql.append("     		      ELSE A.SALE_PRICE                                                                                                                      \n");
			sbSql.append("     		  END AS OP_PRICE                                                                                                                            \n");
			sbSql.append("     	  FROM    (SELECT A.*, B.ITEM_CLASS4 FROM FMP_OTCUST_PR A, FMS_ITEM_V B WHERE A.ITEM_CODE = B.ITEM_CODE) A                        				 \n");
			sbSql.append("     			, FMS_SUBINVENTORY B                                                                                                                     \n");
			sbSql.append("     			, (                                                                                                                                      \n");
			sbSql.append("     					SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE, UPJANG                                                              \n");
			sbSql.append("     					FROM FMU_OP_RATE                                                                                                                 \n");
			sbSql.append("     					WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + "                                                               \n");
			sbSql.append("     					AND USE_YN = 'Y'                                                                                                                 \n");
			sbSql.append("     					AND ITEM_TYPE = 'M'                                                                                                              \n");
			sbSql.append("     			   ) C                                                                                                                                   \n");
			sbSql.append("     			, (                                                                                                                                      \n");
			sbSql.append("     					SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE, UPJANG                                                              \n");
			sbSql.append("     					FROM FMU_OP_RATE                                                                                                                 \n");
			sbSql.append("     					WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + "                                                               \n");
			sbSql.append("     					AND USE_YN = 'Y'                                                                                                                 \n");
			sbSql.append("     					AND ITEM_TYPE = 'C'                                                                                                              \n");
			sbSql.append("     			   ) D                                                                                                                                   \n");
			sbSql.append("     	 WHERE A.SUBINV_CODE = B.SUBINV_CODE                                                                                                             \n");
			sbSql.append("     	   AND A.UPJANG = C.UPJANG(+)                                                                                                                    \n");
			sbSql.append("     	   AND A.UPJANG = D.UPJANG(+)                                                                                                                    \n");
			sbSql.append("         AND A.ITEM_CODE = C.ITEM_CODE(+)                                                                                                      		 \n");
			sbSql.append("     	   AND A.ITEM_CLASS4 = D.ITEM_CODE(+)                                                                                                            \n");
			sbSql.append("     	   AND A.NEED_DATE BETWEEN C.SDATE(+) AND C.EDATE(+)                                                                                             \n");
			sbSql.append("     	   AND A.NEED_DATE BETWEEN D.SDATE(+) AND D.EDATE(+)                                                                                             \n");
			sbSql.append("     	   AND A.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + "                                                                            \n");
			sbSql.append("     	   AND A.SUBINV_CODE LIKE '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) + "%'                                                            \n");
			sbSql.append("     	   AND A.NEED_DATE BETWEEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATET")) + "'\n"); 
			sbSql.append("     	   AND A.OTCUSTCD = '" + nullToBlank(ds_cond.getString(0, "OTCUSTCD")) + "'                                                                      \n");
			sbSql.append("     	   AND A.ITEM_CODE = '" + nullToBlank(ds_cond.getString(0, "ITEM_CODE")) + "'                                                                    \n");
			sbSql.append("     	   AND A.LINE_STATUS = '" + nullToBlank(ds_cond.getString(0, "STATUS_CODE")) + "'                                                                \n");
			sbSql.append("      )                                                                                                                                                \n");
			sbSql.append("     GROUP BY NEED_DATE , SUBINV_CODE, SUBINV_NAME_DISP , PR_QTY, SALE_PRICE , OP_PRICE, TAX_CODE                                                      \n");
			sbSql.append("     ORDER BY A.NEED_DATE, A.SUBINV_CODE                                                                                                               \n");
			/* sbSql.append("SELECT TO_CHAR(TO_DATE(A.NEED_DATE,'YYYYMMDD'),'YYYY-MM-DD') AS NEED_DATE \n");
			sbSql.append("     , A.SUBINV_CODE, B.SUBINV_NAME_DISP \n");
			sbSql.append("     , A.PR_QTY \n");
			sbSql.append("     , 0 AS RTN_QTY \n");
			sbSql.append("     , A.PR_QTY AS IN_QTY \n");
			sbSql.append("     , A.SALE_PRICE \n");
			sbSql.append("     , DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE) AS OP_PRICE \n");
			sbSql.append("     , ROUND(A.PR_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)) AS OP_AMOUNT \n");
			sbSql.append("     , ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * ROUND(A.PR_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))) AS OP_VAT \n");
			sbSql.append("     , ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.PR_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))) AS OP_TOT \n");
			sbSql.append("  FROM FMP_OTCUST_PR A, FMS_SUBINVENTORY B, FMU_OP_RATE C \n");
			sbSql.append(" WHERE A.SUBINV_CODE = B.SUBINV_CODE \n");
			sbSql.append("   AND A.UPJANG = C.UPJANG(+) \n");
			sbSql.append("   AND A.NEED_DATE BETWEEN C.SDATE(+) AND C.EDATE(+) \n");
			sbSql.append("   AND A.ITEM_CODE BETWEEN C.ITEM_CODE(+) AND C.ITEM_CODE(+)||'9999' \n");
			sbSql.append("   AND C.USE_YN(+) = 'Y' \n");
			sbSql.append("   AND A.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
			sbSql.append("   AND A.SUBINV_CODE LIKE '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) + "%' \n");
			sbSql.append("   AND A.NEED_DATE BETWEEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATET")) + "' \n");
			sbSql.append("   AND A.OTCUSTCD = '" + nullToBlank(ds_cond.getString(0, "OTCUSTCD")) + "' \n");
			sbSql.append("   AND A.ITEM_CODE = '" + nullToBlank(ds_cond.getString(0, "ITEM_CODE")) + "' \n");
			sbSql.append("   AND A.LINE_STATUS = '" + nullToBlank(ds_cond.getString(0, "STATUS_CODE")) + "' \n");
			sbSql.append(" ORDER BY A.NEED_DATE, A.SUBINV_CODE \n"); */
		}

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
