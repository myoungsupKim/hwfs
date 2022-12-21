<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/현황관리
■ 프로그램ID   : FMP00452V_T001.jsp
■ 프로그램명   : 검수서(본사)
■ 작성일자     : 2017-10-23
■ 작성자       : 유선미 
■ 이력관리     : 2017-10-23
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
	
		DataSet ds_cond	= in_dl.get("ds_Cond");
		
		String g_Upjang	= nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo 	= nullToBlank(in_vl.getString("g_EmpNo"));

		//out 데이타
		DataSet ds_list;
		
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		String strOtCust 		= nullToBlank(ds_cond.getString(0, "OTCUSTCD"));
		String strSort   		= ds_cond.getString(0, "SORT");
		String strMainUpjang	= nullToBlank(ds_cond.getString(0, "MAIN_UPJANG"));
		String strUpjang   		= nullToBlank(ds_cond.getString(0, "UPJANG"));
		String strSubinvCode	= nullToBlank(ds_cond.getString(0, "SUBINV_CODE"));
		String strNeedDate   	= nullToBlank(ds_cond.getString(0, "NEED_DATE"));
		
		//내역조회
		if (strOtCust.equals("0000")) 
		{
			sbSql.append("SELECT UPJANG	                                                                                                                                    	\n");
			sbSql.append("     , UPJANGNM_DISP		                                                                                                                            \n");
			sbSql.append("     , ITEM_CODE		                                                                                                                                \n");
			sbSql.append("     , ITEM_NAME		                                                                                                                                \n");
			sbSql.append("     , ITEM_SIZE		                                                                                                                                \n");
			sbSql.append("     , PO_UOM			                                                                                                                                \n");
			sbSql.append("     , KEEPING_TYPE	                                                                                                                                \n");
			sbSql.append("     , OP_PRICE		                                                                                                                                \n");
			sbSql.append("     , PR_QTY		                                                                                                                                    \n");
			sbSql.append("     , SUM(ROUND(DECODE(TAX_CODE,'100', 0.1, 0) * ROUND(PR_QTY * OP_PRICE))) AS OP_VAT		                                                        \n");
			sbSql.append("     , SUM(ROUND(PR_QTY * OP_PRICE)) AS OP_AMOUNT 		                                                                                            \n");
			sbSql.append("     , OTCUSTCD		                                                                                                                                \n");
			sbSql.append("     , OTCUSTNM		                                                                                                                                \n");
			sbSql.append("     , ORIGIN_TYPE		                                                                                                                            \n");
			sbSql.append("     , PR_ID		                                                                                                                                    \n");
			sbSql.append("  FROM (SELECT A.UPJANG	                                                                                                                        	\n");
			sbSql.append("             , A.UPJANGNM_DISP		                                                                                                                \n");
			sbSql.append("             , A.ITEM_CODE		                                                                                                                    \n");
			sbSql.append("             , A.ITEM_NAME		                                                                                                                    \n");
			sbSql.append("             , A.ITEM_SIZE		                                                                                                                    \n");
			sbSql.append("             , A.PO_UOM 			                                                                                                                    \n");
			sbSql.append("             , A.KEEPING_TYPE 	                                                                                                                    \n");
			sbSql.append("             , A.CENTER_DELI_QTY + A.DIRECT_DELI_QTY AS PR_QTY	                                                                                    \n");
			sbSql.append("             , DECODE(NVL(A.SAL_OPER_PRICE, 0), 0, A.SALE_PRICE, A.SAL_OPER_PRICE) AS OP_PRICE                                              		    \n");
			sbSql.append("             , A.TAX_CODE                                                                                                                             \n");
			sbSql.append("             , A.PO_QTY                                                                                                                               \n");
			sbSql.append("             , '0000' AS OTCUSTCD	                                                                                                                    \n");
			sbSql.append("             , (SELECT OTCUSTNM FROM FMP_OTHER_CUST WHERE OTCUSTCD = '0000') AS OTCUSTNM                                                              \n");
			sbSql.append("             , A.ORIGIN_TYPE                                                                                                                          \n");
			sbSql.append("             , A.PO_ID AS PR_ID  			                                                                                                            \n");
			sbSql.append("          FROM (SELECT C.UPJANG                                                                                                                       \n");
			sbSql.append("                     , A.PO_ID                                                                                                                        \n");
			sbSql.append("                     , A.ITEM_CODE                                                                                                                    \n");
			sbSql.append("                     , A.ITEM_NAME                                                                                                                    \n");
			sbSql.append("                     , A.ITEM_SIZE                                                                                                                    \n");
			sbSql.append("                     , A.PO_UOM                                                                                                                       \n");
			sbSql.append("                     , A.CENTER_DELI_QTY                                                                                                              \n");
			sbSql.append("                     , A.DIRECT_DELI_QTY                                                                                                              \n");
			sbSql.append("                     , A.SAL_OPER_PRICE                                                                                                               \n");
			sbSql.append("                     , A.PO_QTY                                                                                                                       \n");
			sbSql.append("                     , A.TAX_CODE                                                                                                                     \n");
			sbSql.append("                     , A.SALE_PRICE                                                                                                                   \n");
			sbSql.append("                     , Z.ORIGIN_INFO AS ORIGIN_TYPE                                                                                                   \n");
			sbSql.append("                     , B.KEEPING_TYPE                                                                                                                 \n");
			sbSql.append("                     , C.UPJANGNM_DISP                                                                                                                \n");
			sbSql.append("                  FROM HLDC_PO_PO A, HLDC_PO_ITEM_MST B, FMS_UPJANG C, HLDC_PO_PO_HIST Z                                            				    \n");
			sbSql.append("                 WHERE A.ITEM_CODE = B.ITEM_CODE                                                                                                      \n");
			sbSql.append("                   AND A.PO_ID = Z.PO_ID                                                                                                              \n");
			sbSql.append("                   AND C.UPJANG = A.RC_UPJANG                                                                                                         \n");
			sbSql.append("                   AND C.MAIN_UPJANG = :strMainUpjang                                                                                                 \n");
			sbSql.append("                   AND A.NEED_DATE = :strNeedDate                                                                                                     \n");
			if (!strUpjang.equals("") && !strUpjang.equals("0")) {
				sbSql.append("                   AND C.UPJANG = :strUpjang                                                                                                      \n");
			}
			if (!strSubinvCode.equals("")) {
				sbSql.append("                   AND A.SUBINV_CODE = :strSubinvCode                                                                                             \n");
			}
			sbSql.append("                   AND A.LINE_STATUS IN ('PC', 'DL', 'GC', 'IV')                                                                                      \n");
			sbSql.append("               ) A                                                                                                                                    \n");
			sbSql.append(" )                                                                                                                                                    \n");
			sbSql.append(" GROUP BY UPJANG, UPJANGNM_DISP, ITEM_CODE, ITEM_NAME, ITEM_SIZE, PO_UOM, KEEPING_TYPE, OP_PRICE, PR_QTY, OTCUSTCD, OTCUSTNM, ORIGIN_TYPE, PR_ID   	\n");
		}
		else if(strOtCust.equals(""))
		{
			sbSql.append("SELECT UPJANG                                                                                                                                              \n");
			sbSql.append("     , UPJANGNM_DISP                                                                                                                                       \n");
			sbSql.append("     , ITEM_CODE                                                                                                                                           \n");
			sbSql.append("     , ITEM_NAME                                                                                                                                           \n");
			sbSql.append("     , ITEM_SIZE                                                                                                                                           \n");
			sbSql.append("     , PO_UOM                                                                                                                                              \n");
			sbSql.append("     , PR_ID                                                                                                                                               \n");
			sbSql.append("     , KEEPING_TYPE                                                                                                                                        \n");
			sbSql.append("     , PR_QTY                                                                                                                                              \n");
			sbSql.append("     , OP_PRICE                                                                                                                                            \n");
			sbSql.append("     , SUM(ROUND(PR_QTY * OP_PRICE)) AS OP_AMOUNT                                                                                                          \n");
			sbSql.append("     , SUM(ROUND(DECODE(TAX_CODE, '100', 0.1, 0) * ROUND(PR_QTY * OP_PRICE))) AS OP_VAT                                                                    \n");
			sbSql.append("     , OTCUSTCD                                                                                                                                            \n");
			sbSql.append("     , OTCUSTNM                                                                                                                                            \n");
			sbSql.append("     , ORIGIN_TYPE                                                                                                                                         \n");
			sbSql.append("  FROM (SELECT A.UPJANG                                                                                                                                    \n");
			sbSql.append("             , A.UPJANGNM_DISP                                                                                                                             \n");
			sbSql.append("             , A.ITEM_CODE                                                                                                                                 \n");
			sbSql.append("             , A.ITEM_NAME                                                                                                                                 \n");
			sbSql.append("             , A.ITEM_SIZE                                                                                                                                 \n");
			sbSql.append("             , A.PO_UOM                                                                                                                                    \n");
			sbSql.append("             , A.PO_ID AS PR_ID                                                                                                                            \n");
			sbSql.append("             , A.KEEPING_TYPE                                                                                                                              \n");
			sbSql.append("             , (A.CENTER_DELI_QTY + A.DIRECT_DELI_QTY) AS PR_QTY                                                                                           \n");
			sbSql.append("             , CASE WHEN E.OP_PRICE IS NOT NULL OR E.OP_RATE IS NOT NULL                                                                                   \n");
			sbSql.append("                    THEN DECODE(SIGN(NVL(E.OP_PRICE, 0) ), 0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(E.OP_RATE,0) / 100), E.CEIL_VAL), E.OP_PRICE)    \n");
			sbSql.append("                    WHEN F.OP_PRICE IS NOT NULL OR F.OP_RATE IS NOT NULL                                                                                   \n");
			sbSql.append("                    THEN DECODE(SIGN(NVL(F.OP_PRICE, 0) ), 0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(F.OP_RATE,0) / 100), F.CEIL_VAL), F.OP_PRICE)    \n");
			sbSql.append("               ELSE A.SALE_PRICE END AS OP_PRICE                                                                                                           \n");
			sbSql.append("             , A.TAX_CODE                                                                                                                                  \n");
			sbSql.append("             , '0000' AS OTCUSTCD                                                                                                                          \n");
			sbSql.append("             , (SELECT OTCUSTNM FROM FMP_OTHER_CUST WHERE OTCUSTCD = '0000') AS OTCUSTNM                                                                   \n");
			sbSql.append("             , A.ORIGIN_TYPE                                                                                                                               \n");
			sbSql.append("          FROM (SELECT C.UPJANG                                                                                                                            \n");
			sbSql.append("                     , C.UPJANGNM_DISP                                                                                                                     \n");
			sbSql.append("                     , A.ITEM_CODE                                                                                                                         \n");
			sbSql.append("                     , A.ITEM_NAME                                                                                                                         \n");
			sbSql.append("                     , A.ITEM_SIZE                                                                                                                         \n");
			sbSql.append("                     , A.PO_UOM                                                                                                                            \n");
			sbSql.append("                     , A.PO_ID                                                                                                                             \n");
			sbSql.append("                     , A.CENTER_DELI_QTY                                                                                                                   \n");
			sbSql.append("                     , A.DIRECT_DELI_QTY                                                                                                                   \n");
			sbSql.append("                     , A.SALE_PRICE                                                                                                                        \n");
			sbSql.append("                     , A.TAX_CODE                                                                                                                          \n");
			sbSql.append("                     , A.NEED_DATE                                                                                                                         \n");
			sbSql.append("                     , Z.ORIGIN_INFO AS ORIGIN_TYPE                                                                                                        \n");
			sbSql.append("                     , B.ITEM_CLASS4                                                                                                                       \n");
			sbSql.append("                     , B.KEEPING_TYPE                                                                                                                      \n");
			sbSql.append("                  FROM HLDC_PO_PO A                                                                                                                        \n");
			sbSql.append("                     , HLDC_PO_ITEM_MST B                                                                                                                  \n");
			sbSql.append("                     , FMS_UPJANG C                                                                                                                        \n");
			sbSql.append("                     , HLDC_PO_PO_HIST Z                                                                                                                   \n");
			sbSql.append("                 WHERE A.ITEM_CODE = B.ITEM_CODE                                                                                                           \n");
			sbSql.append("                   AND C.UPJANG = A.RC_UPJANG                                                                                                              \n");
			sbSql.append("                   AND A.PO_ID = Z.PO_ID                                                                                                                   \n");
			sbSql.append("                   AND A.LINE_STATUS IN ('PC', 'DL', 'GC', 'IV')                                                                                           \n");
			sbSql.append("                   AND A.NEED_DATE = :strNeedDate                                                                                                          \n");
			sbSql.append("                   AND C.MAIN_UPJANG = :strMainUpjang                                                                                                      \n");
			if (!strUpjang.equals("") && !strUpjang.equals("0")) {
				sbSql.append("                   AND C.UPJANG = :strUpjang                                                                                                      \n");
			}
			if (!strSubinvCode.equals("")) {
				sbSql.append("                   AND A.SUBINV_CODE = :strSubinvCode                                                                                             \n");
			}
			sbSql.append("               ) A                                                                                                                                         \n");
			sbSql.append("             , (SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE, UPJANG                                                                        \n");
			sbSql.append("                  FROM FMU_OP_RATE                                                                                                                         \n");
			sbSql.append("                 WHERE USE_YN = 'Y'                                                                                                                        \n");
			sbSql.append("                   AND ITEM_TYPE = 'M'                                                                                                                     \n");
			sbSql.append("               ) E                                                                                                                                         \n");
			sbSql.append("             , (SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE, UPJANG                                                                        \n");
			sbSql.append("                  FROM FMU_OP_RATE                                                                                                                         \n");
			sbSql.append("                 WHERE USE_YN = 'Y'                                                                                                                        \n");
			sbSql.append("                   AND ITEM_TYPE = 'C'                                                                                                                     \n");
			sbSql.append("               ) F                                                                                                                                         \n");
			sbSql.append("         WHERE 1=1                                                                                                                                         \n");
			sbSql.append("           AND A.UPJANG = E.UPJANG(+)                                                                                                                      \n");
			sbSql.append("           AND A.UPJANG = F.UPJANG(+)                                                                                                                      \n");
			sbSql.append("           AND A.ITEM_CODE = E.ITEM_CODE(+)                                                                                                                \n");
			sbSql.append("           AND A.ITEM_CLASS4 = F.ITEM_CODE(+)                                                                                                              \n");
			sbSql.append("           AND A.NEED_DATE BETWEEN E.SDATE(+) AND E.EDATE(+)                                                                                               \n");
			sbSql.append("           AND A.NEED_DATE BETWEEN F.SDATE(+) AND F.EDATE(+)                                                                                               \n");
			sbSql.append("         UNION ALL                                                                                                                                         \n");
			sbSql.append("        SELECT A.UPJANG                                                                                                                                    \n");
			sbSql.append("             , A.UPJANGNM_DISP                                                                                                                             \n");
			sbSql.append("             , A.ITEM_CODE                                                                                                                                 \n");
			sbSql.append("             , A.ITEM_NAME                                                                                                                                 \n");
			sbSql.append("             , A.ITEM_SIZE                                                                                                                                 \n");
			sbSql.append("             , A.PO_UOM                                                                                                                                    \n");
			sbSql.append("             , A.PR_ID                                                                                                                                     \n");
			sbSql.append("             , A.KEEPING_TYPE                                                                                                                              \n");
			sbSql.append("             , A.PR_QTY                                                                                                                                    \n");
			sbSql.append("             , CASE WHEN E.OP_PRICE IS NOT NULL OR E.OP_RATE IS NOT NULL                                                                                   \n");
			sbSql.append("                    THEN DECODE(SIGN(NVL(E.OP_PRICE, 0)), 0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(E.OP_RATE, 0) / 100), E.CEIL_VAL), E.OP_PRICE)    \n");
			sbSql.append("                    WHEN F.OP_PRICE IS NOT NULL OR F.OP_RATE IS NOT NULL                                                                                   \n");
			sbSql.append("                    THEN DECODE(SIGN(NVL(F.OP_PRICE, 0)), 0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(F.OP_RATE, 0) / 100), F.CEIL_VAL), F.OP_PRICE)    \n");
			sbSql.append("               ELSE A.SALE_PRICE END AS OP_PRICE                                                                                                           \n");
			sbSql.append("             , A.TAX_CODE                                                                                                                                  \n");
			sbSql.append("             , A.OTCUSTCD                                                                                                                                  \n");
			sbSql.append("             , D.OTCUSTNM                                                                                                                                  \n");
			sbSql.append("             , A.ORIGIN_TYPE                                                                                                                               \n");
			sbSql.append("          FROM (SELECT C.UPJANG                                                                                                                            \n");
			sbSql.append("                     , C.UPJANGNM_DISP                                                                                                                     \n");
			sbSql.append("                     , A.ITEM_CODE                                                                                                                         \n");
			sbSql.append("                     , A.ITEM_NAME                                                                                                                         \n");
			sbSql.append("                     , A.ITEM_SIZE                                                                                                                         \n");
			sbSql.append("                     , A.PO_UOM                                                                                                                            \n");
			sbSql.append("                     , A.PR_ID                                                                                                                             \n");
			sbSql.append("                     , A.SALE_PRICE                                                                                                                        \n");
			sbSql.append("                     , A.TAX_CODE                                                                                                                          \n");
			sbSql.append("                     , A.NEED_DATE                                                                                                                         \n");
			sbSql.append("                     , A.PR_QTY                                                                                                                            \n");
			sbSql.append("                     , A.OTCUSTCD                                                                                                                          \n");
			sbSql.append("                     , B.ORIGIN_TYPE                                                                                                                       \n");
			sbSql.append("                     , B.ITEM_CLASS4                                                                                                                       \n");
			sbSql.append("                     , B.KEEPING_TYPE                                                                                                                      \n");
			sbSql.append("                  FROM FMP_OTCUST_PR A                                                                                                                     \n");
			sbSql.append("                     , FMP_OTCUST_ITEM B                                                                                                                   \n");
			sbSql.append("                     , FMS_UPJANG C                                                                                                                        \n");
			sbSql.append("                 WHERE A.ITEM_CODE = B.ITEM_CODE                                                                                                           \n");
			sbSql.append("                   AND C.UPJANG = A.UPJANG                                                                                                                 \n");
			sbSql.append("                   AND A.LINE_STATUS <> '003'                                                                                                              \n");
			sbSql.append("                   AND A.NEED_DATE = :strNeedDate                                                                                                          \n");
			sbSql.append("                   AND C.MAIN_UPJANG = :strMainUpjang                                                                                                      \n");
			if (!strUpjang.equals("") && !strUpjang.equals("0")) {
				sbSql.append("                   AND C.UPJANG = :strUpjang                                                                                                      	 \n");
			}
			if (!strSubinvCode.equals("")) {
				sbSql.append("                   AND A.SUBINV_CODE = :strSubinvCode                                                                                             	 \n");
			}
			sbSql.append("               ) A                                                                                                                                         \n");
			sbSql.append("             , FMP_OTHER_CUST D                                                                                                                            \n");
			sbSql.append("             , (SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE, UPJANG                                                                        \n");
			sbSql.append("                  FROM FMU_OP_RATE                                                                                                                         \n");
			sbSql.append("                 WHERE USE_YN = 'Y'                                                                                                                        \n");
			sbSql.append("                   AND ITEM_TYPE = 'M'                                                                                                                     \n");
			sbSql.append("               ) E                                                                                                                                         \n");
			sbSql.append("             , (SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE, UPJANG                                                                        \n");
			sbSql.append("                  FROM FMU_OP_RATE                                                                                                                         \n");
			sbSql.append("                 WHERE USE_YN = 'Y'                                                                                                                        \n");
			sbSql.append("                   AND ITEM_TYPE = 'C'                                                                                                                     \n");
			sbSql.append("               ) F                                                                                                                                         \n");
			sbSql.append("         WHERE 1=1                                                                                                                                         \n");
			sbSql.append("           AND A.UPJANG = E.UPJANG(+)                                                                                                                      \n");
			sbSql.append("           AND A.UPJANG = F.UPJANG(+)                                                                                                                      \n");
			sbSql.append("           AND A.ITEM_CODE = E.ITEM_CODE(+)                                                                                                                \n");
			sbSql.append("           AND A.ITEM_CLASS4 = F.ITEM_CODE(+)                                                                                                              \n");
			sbSql.append("           AND A.NEED_DATE BETWEEN E.SDATE(+) AND E.EDATE(+)                                                                                               \n");
			sbSql.append("           AND A.NEED_DATE BETWEEN F.SDATE(+) AND F.EDATE(+)                                                                                               \n");
			sbSql.append("           AND A.OTCUSTCD = D.OTCUSTCD                                                                                                                     \n");
			sbSql.append("       )                                                                                                                                                   \n");
			sbSql.append(" WHERE 1=1                                                                                                                                                 \n");
			sbSql.append(" GROUP BY UPJANG, UPJANGNM_DISP, ITEM_CODE, ITEM_NAME, ITEM_SIZE, PO_UOM, PR_ID, KEEPING_TYPE, PR_QTY, OP_PRICE, OTCUSTCD, OTCUSTNM, ORIGIN_TYPE			 \n");
		}
		else
		{
			sbSql.append("SELECT UPJANG                                                                                                                                          \n");
			sbSql.append("     , UPJANGNM_DISP                                                                                                                                   \n");
			sbSql.append("     , ITEM_CODE                                                                                                                                       \n");
			sbSql.append("     , ITEM_NAME                                                                                                                                       \n");
			sbSql.append("     , ITEM_SIZE                                                                                                                                       \n");
			sbSql.append("     , PO_UOM                                                                                                                                          \n");
			sbSql.append("     , KEEPING_TYPE                                                                                                                                    \n");
			sbSql.append("     , PR_QTY                                                                                                                                          \n");
			sbSql.append("     , OP_PRICE                                                                                                                                        \n");
			sbSql.append("     , SUM(ROUND(PR_QTY * OP_PRICE)) AS OP_AMOUNT                                                                                                      \n");
			sbSql.append("     , SUM(ROUND(DECODE(TAX_CODE, '100', 0.1, 0) * ROUND(PR_QTY * OP_PRICE))) AS OP_VAT                                                                \n");
			sbSql.append("     , OTCUSTCD                                                                                                                                        \n");
			sbSql.append("     , OTCUSTNM                                                                                                                                        \n");
			sbSql.append("     , ORIGIN_TYPE                                                                                                                                     \n");
			sbSql.append("     , PR_ID                                                                                                                                           \n");
			sbSql.append("  FROM (SELECT A.UPJANG                                                                                                                                \n");
			sbSql.append("             , A.UPJANGNM_DISP                                                                                                                         \n");
			sbSql.append("             , A.ITEM_CODE                                                                                                                             \n");
			sbSql.append("             , A.ITEM_NAME                                                                                                                             \n");
			sbSql.append("             , A.ITEM_SIZE                                                                                                                             \n");
			sbSql.append("             , A.PO_UOM                                                                                                                                \n");
			sbSql.append("             , A.KEEPING_TYPE                                                                                                                          \n");
			sbSql.append("             , A.PR_QTY                                                                                                                                \n");
			sbSql.append("             , CASE WHEN E.OP_PRICE IS NOT NULL OR E.OP_RATE IS NOT NULL                                                                               \n");
			sbSql.append("                    THEN DECODE(SIGN(NVL(E.OP_PRICE, 0)), 0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(E.OP_RATE, 0) / 100), E.CEIL_VAL), E.OP_PRICE)\n");
			sbSql.append("                    WHEN F.OP_PRICE IS NOT NULL OR F.OP_RATE IS NOT NULL                                                                               \n");
			sbSql.append("                    THEN DECODE(SIGN(NVL(F.OP_PRICE, 0)), 0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(F.OP_RATE, 0) / 100), F.CEIL_VAL), F.OP_PRICE)\n");
			sbSql.append("               ELSE A.SALE_PRICE END AS OP_PRICE                                                                                                       \n");
			sbSql.append("             , A.TAX_CODE                                                                                                                              \n");
			sbSql.append("             , A.OTCUSTCD                                                                                                                              \n");
			sbSql.append("             , D.OTCUSTNM                                                                                                                              \n");
			sbSql.append("             , A.ORIGIN_TYPE                                                                                                                           \n");
			sbSql.append("             , A.PR_ID                                                                                                                                 \n");
			sbSql.append("          FROM (SELECT C.UPJANG                                                                                                                        \n");
			sbSql.append("                     , C.UPJANGNM_DISP                                                                                                                 \n");
			sbSql.append("                     , A.ITEM_CODE                                                                                                                     \n");
			sbSql.append("                     , A.ITEM_NAME                                                                                                                     \n");
			sbSql.append("                     , A.ITEM_SIZE                                                                                                                     \n");
			sbSql.append("                     , A.PO_UOM                                                                                                                        \n");
			sbSql.append("                     , A.PR_QTY                                                                                                                        \n");
			sbSql.append("                     , A.SALE_PRICE                                                                                                                    \n");
			sbSql.append("                     , A.TAX_CODE                                                                                                                      \n");
			sbSql.append("                     , A.PR_ID                                                                                                                         \n");
			sbSql.append("                     , A.OTCUSTCD                                                                                                                      \n");
			sbSql.append("                     , A.NEED_DATE                                                                                                                     \n");
			sbSql.append("                     , B.ORIGIN_TYPE                                                                                                                   \n");
			sbSql.append("                     , B.ITEM_CLASS4                                                                                                                   \n");
			sbSql.append("                     , B.KEEPING_TYPE                                                                                                                  \n");
			sbSql.append("                  FROM FMP_OTCUST_PR A                                                                                                                 \n");
			sbSql.append("                     , FMP_OTCUST_ITEM B                                                                                                               \n");
			sbSql.append("                     , FMS_UPJANG C                                                                                                                    \n");
			sbSql.append("                 WHERE A.ITEM_CODE = B.ITEM_CODE                                                                                                       \n");
			sbSql.append("                   AND C.UPJANG = A.UPJANG                                                                                                             \n");
			sbSql.append("                   AND A.LINE_STATUS <> '003'                                                                                                          \n");
			sbSql.append("                   AND C.MAIN_UPJANG = :strMainUpjang                                                                                                  \n");
			sbSql.append("                   AND A.NEED_DATE = :strNeedDate                                                                                                      \n");
			if (!strUpjang.equals("") && !strUpjang.equals("0")) {
				sbSql.append("                   AND C.UPJANG = :strUpjang                                                                                                       \n");
			}
			if (!strSubinvCode.equals("")) {
				sbSql.append("                   AND A.SUBINV_CODE = :strSubinvCode                                                                                              \n");
			}
			sbSql.append("                   AND A.OTCUSTCD = '" + strOtCust + "'\n");
			sbSql.append("               ) A                                                                                                                                     \n");
			sbSql.append("             , FMP_OTHER_CUST D                                                                                                                        \n");
			sbSql.append("             , (SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE, UPJANG                                                                    \n");
			sbSql.append("                  FROM FMU_OP_RATE                                                                                                                     \n");
			sbSql.append("                 WHERE USE_YN = 'Y'                                                                                                                    \n");
			sbSql.append("                   AND ITEM_TYPE = 'M'                                                                                                                 \n");
			sbSql.append("               ) E                                                                                                                                     \n");
			sbSql.append("             , (SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE, UPJANG                                                                    \n");
			sbSql.append("                  FROM FMU_OP_RATE                                                                                                                     \n");
			sbSql.append("                 WHERE USE_YN = 'Y'                                                                                                                    \n");
			sbSql.append("                   AND ITEM_TYPE = 'C'                                                                                                                 \n");
			sbSql.append("               ) F                                                                                                                                     \n");
			sbSql.append("         WHERE 1=1                                                                                                                                     \n");
			sbSql.append("           AND A.UPJANG = E.UPJANG(+)                                                                                                                  \n");
			sbSql.append("           AND A.UPJANG = F.UPJANG(+)                                                                                                                  \n");
			sbSql.append("           AND A.ITEM_CODE = E.ITEM_CODE(+)                                                                                                            \n");
			sbSql.append("           AND A.ITEM_CLASS4 = F.ITEM_CODE(+)                                                                                                          \n");
			sbSql.append("           AND A.NEED_DATE BETWEEN E.SDATE(+) AND E.EDATE(+)                                                                                           \n");
			sbSql.append("           AND A.NEED_DATE BETWEEN F.SDATE(+) AND F.EDATE(+)                                                                                           \n");
			sbSql.append("           AND A.OTCUSTCD = D.OTCUSTCD                                                                                                                 \n");
			sbSql.append("       ) A                                                                                                                                             \n");
			sbSql.append(" GROUP BY UPJANG, UPJANGNM_DISP, ITEM_CODE, ITEM_NAME, ITEM_SIZE, PO_UOM, KEEPING_TYPE, PR_QTY, OP_PRICE, OTCUSTCD, OTCUSTNM, ORIGIN_TYPE, PR_ID		 \n");
		}
		sbSql.append(" ORDER BY UPJANG, " + strSort	+ "\n");

		out_vl.add("fa_Sql", sbSql.toString());

		npstmt = new NamedParameterStatement(conn, sbSql.toString());	

		npstmt.setString("strMainUpjang", strMainUpjang);
		npstmt.setString("strNeedDate", strNeedDate);
		if (!strUpjang.equals("") && !strUpjang.equals("0")) {
			npstmt.setString("strUpjang", strUpjang);
		}
		if (!strSubinvCode.equals("")) {
			npstmt.setString("strSubinvCode", strSubinvCode);
		}
		
		rs = npstmt.executeQuery(); 
		
		ds_list = this.makeDataSet(rs, "ds_List");
		
		npstmt.close();
		rs.close();

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
		if(npstmt != null) {
			try {
				npstmt.close();
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
