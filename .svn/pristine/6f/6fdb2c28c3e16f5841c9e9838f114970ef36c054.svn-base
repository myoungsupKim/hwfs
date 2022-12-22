<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	Statement stmt = null;
	try {
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();

		String UPJANG     = nullToBlank(in_vl.getString("UPJANG"));
		String START_DATE = nullToBlank(in_vl.getString("START_DATE"));
		String END_DATE   = nullToBlank(in_vl.getString("END_DATE"));

		String BASE_YY    = nullToBlank(in_vl.getString("START_DATE")).substring(0, 4);
		String BASE_MM    = nullToBlank(in_vl.getString("START_DATE")).substring(0, 6);
		String MM = BASE_MM.substring(4, 6);

		StringBuffer sbSql = new StringBuffer();
		sbSql.append("SELECT A.PLAN_RATE                                                                                                                                  \n");
		sbSql.append("     , B.RESULT_RATE                                                                                                                                \n");
		sbSql.append("     , A.PLAN_RATE - B.RESULT_RATE AS DIFF_RATE                                                                                                     \n");
		sbSql.append("  FROM (                                                                                                                                            \n");
		sbSql.append("        SELECT BASE_MM                                                                                                                              \n");
		sbSql.append("             , DECODE(SUM(SALE_PLAN_AMT), 0, 0, ROUND(SUM(COST_PLAN_AMT) / SUM(SALE_PLAN_AMT) * 100, 2)) AS PLAN_RATE                               \n");
		sbSql.append("          FROM (                                                                                                                                    \n");
		sbSql.append("                SELECT A.BASE_MM                                                                                                                    \n");
		sbSql.append("                     , NVL(B.SALE_PLAN_AMT, 0) AS SALE_PLAN_AMT                                                                                     \n");
		sbSql.append("                     , NVL(B.COST_PLAN_AMT, 0) AS COST_PLAN_AMT                                                                                     \n");
		sbSql.append("                  FROM (SELECT '" + BASE_MM + "' AS BASE_MM FROM DUAL) A                                                                            \n");
		sbSql.append("                     , (                                                                                                                            \n");
		sbSql.append("                        SELECT '" + BASE_MM + "' AS BASE_MM                                                                                         \n");
		sbSql.append("                             , CASE WHEN A.ACCT_CD = '41203030' THEN NVL(SUM(A.MM_AMT_" + MM + "), 0) END AS SALE_PLAN_AMT                          \n");
		sbSql.append("                             , CASE WHEN A.ACCT_CD = '42203030' THEN NVL(SUM(A.MM_AMT_" + MM + "), 0) END AS COST_PLAN_AMT                          \n");
		sbSql.append("                          FROM MAP_MON_PLAN A                                                                                                       \n");
		sbSql.append("                             , MAP_MON_LOG_MGMT B                                                                                                   \n");
		sbSql.append("                             , (SELECT UPJANG                                                                                                       \n");
		sbSql.append("                                     , YY                                                                                                           \n");
		sbSql.append("                                     , BIZ_CLASS                                                                                                    \n");
		sbSql.append("                                  FROM MAP_MON_LOG_MGMT                                                                                             \n");
		sbSql.append("                                 WHERE UDATE = (SELECT MAX(UDATE) UDATE                                                                             \n");
		sbSql.append("                                                  FROM MAP_MON_LOG_MGMT                                                                             \n");
		sbSql.append("                                                 WHERE UPJANG = '" + UPJANG + "'                                                                            \n");
		sbSql.append("                                                   AND YY = '" + BASE_YY + "'                                                                                  \n");
		sbSql.append("                                                   AND CONFIRM_YN = 'Y')                                                                            \n");
		sbSql.append("                               )  C                                                                                                                 \n");
		sbSql.append("                         WHERE A.UPJANG = B.UPJANG                                                                                                  \n");
		sbSql.append("                           AND A.YY = B.YY                                                                                                          \n");
		sbSql.append("                           AND A.BIZ_CLASS = B.BIZ_CLASS                                                                                            \n");
		sbSql.append("                           AND B.UPJANG = C.UPJANG                                                                                                  \n");
		sbSql.append("                           AND B.YY = C.YY                                                                                                          \n");
		sbSql.append("                           AND B.BIZ_CLASS = C.BIZ_CLASS                                                                                            \n");
		sbSql.append("                           AND A.UPJANG = '" + UPJANG + "'      		                                                                                      \n");
		sbSql.append("                           AND A.ACCT_CD IN ('41203010', '41203020', '41203030', '42203010', '42203020', '42203030')		                                                                          \n");
		sbSql.append("                         GROUP BY ACCT_CD                                                                                                           \n");
		sbSql.append("                       ) B                                                                                                                          \n");
		sbSql.append("                 WHERE A.BASE_MM = B.BASE_MM(+)                                                                                                     \n");
		sbSql.append("               )                                                                                                                                    \n");
		sbSql.append("         GROUP BY BASE_MM                                                                                                                           \n");
		sbSql.append("       ) A                                                                                                                                          \n");
		sbSql.append("     , (                                                                                                                                            \n");
		sbSql.append("        SELECT BASE_MM                                                                                                                              \n");
		sbSql.append("             , DECODE(SUM(SALE_RESULT_AMT), 0, 0, ROUND(SUM(COST_RESULT_AMT) / SUM(SALE_RESULT_AMT) * 100, 2)) AS RESULT_RATE                       \n");
		sbSql.append("          FROM (                                                                                                                                    \n");
		sbSql.append("                SELECT A.BASE_MM                                                                                                                    \n");
		sbSql.append("                     , SUM(NVL(B.SALE_RESULT_AMT, 0)) AS SALE_RESULT_AMT                                                                            \n");
		sbSql.append("                     , SUM(NVL(C.COST_RESULT_AMT1, 0)) - SUM(NVL(E.COST_RESULT_AMT3, 0)) AS COST_RESULT_AMT       \n");
		sbSql.append("                  FROM (SELECT '" + BASE_MM + "' AS BASE_MM FROM DUAL) A                                                                            \n");
		sbSql.append("                     , (                                                                                                                            \n");
        sbSql.append("                        /* 매출 - 식음료매출 실적 (내부이용포함) */                                                                                            \n");
        sbSql.append("                        SELECT '" + BASE_MM + "' AS BASE_MM                                                                                         \n");
        sbSql.append("                             , SUM(B.NET_AMT) AS SALE_RESULT_AMT                                                                                    \n");
        sbSql.append("                          FROM SLA_IF_UPJANG_SALS_MST A                                                                                             \n");
        sbSql.append("                             , SLA_IF_UPJANG_SALS_DETAIL B                                                                                          \n");
        sbSql.append("                         WHERE A.OCCUR_DATE = B.OCCUR_DATE                                                                                          \n");
        sbSql.append("                           AND A.SYS_CLASS = B.SYS_CLASS                                                                                            \n");
        sbSql.append("                           AND A.UPJANG_CD = B.UPJANG_CD                                                                                            \n");
        sbSql.append("                           AND A.UPJANG_CD = '" + UPJANG + "'                                                                                       \n");
        sbSql.append("                           AND A.OCCUR_DATE BETWEEN '" + START_DATE + "' AND '" + END_DATE + "'                                                     \n");
        sbSql.append("                           AND A.RECEIPT_NUM = B.RECEIPT_NUM                                                                                        \n");
        sbSql.append("                           AND B.SALS_CLASS IN ('1103', '2001', '2002', '1106', '1204', '1205', '2101', '2102') -- 1103 : 식음료매출_식료, 2001 : POS식음료매출_식료, 1106 : 기타매출-기타                                                                                 \n");
		sbSql.append("                       ) B                                                                                                                          \n");
		sbSql.append("                     , (                                                                                                                            \n");
		sbSql.append("                        /* 재료비 - 실적 - 전산구매 */                                                                                                     \n");
		sbSql.append("                        SELECT '" + BASE_MM + "' AS BASE_MM                                                                                         \n");
		sbSql.append("                             , NVL( DECODE(B.OUTVAT_FLAG, 'Y', ROUND( SUM( MARGIN_AMOUNT * DECODE( TAX_CODE, '100', DECODE( MATERIAL_ACCTCD, '11402000', 1.1, 1), 1) ) ), SUM( MARGIN_AMOUNT ) ), 0) AS COST_RESULT_AMT1 \n");
		sbSql.append("                          FROM HLDC_PO_TRANSACTION_NHASH A        --속도개선으로 HLDC_PO_TRANSACTION 테이블에서 변경 20160602 처리:맹수영                                                                                        \n");
		sbSql.append("                             , HLDC_PO_SUBINVENTORY B                                                                                               \n");
		sbSql.append("                         WHERE A.SUBINV_CODE = B.SUBINV_CODE                                                                                        \n");
		sbSql.append("                           AND A.TRANS_DATE BETWEEN '" + START_DATE + "' AND '" + END_DATE + "'                                                     \n");
		sbSql.append("                           AND A.TRANS_UPJANG = '" + UPJANG + "'                                                                                    \n");
		sbSql.append("                           AND A.TRANS_TYPE LIKE 'O%'                                                                                               \n");
		sbSql.append("                           AND A.TRANS_TYPE <> 'O002'                                                                                               \n");
		sbSql.append("                           AND A.ACCTCD IN ('42203010', '42203020', '42203030')         -- 식재료 (FS사업부 식음료 출고계정 : '42203030', 외식사업부 식음료 출고계정 : '42203010', '42203020')                                                                                             \n");
		sbSql.append("                         GROUP BY B.OUTVAT_FLAG                                                                                                     \n");
		sbSql.append("                       ) C                                                                                                                          \n");
		sbSql.append("                     , (                                                                                                                            \n");
		sbSql.append("                        /* 재료비 - 실적 - 복리후생식대비 */                                                                                                 \n");
		sbSql.append("                        SELECT '" + BASE_MM + "' AS BASE_MM                                                                                         \n");
		sbSql.append("                             , ROUND(NVL(SUM(AMT), 0) / TO_NUMBER(TO_CHAR(LAST_DAY(TO_DATE('" + START_DATE + "')), 'DD')), 0) * TO_NUMBER(SUBSTR(TO_CHAR(SYSDATE, 'YYYYMMDD'), 7, 2)) AS COST_RESULT_AMT3                                                                                  \n");
		sbSql.append("                          FROM MAS_WELFARE                                                                                                          \n");
		sbSql.append("                         WHERE UPJANG = '" + UPJANG + "'                                                                                            \n");
		sbSql.append("                           AND APPLY_MM = TO_CHAR(TO_DATE('" + START_DATE + "', 'YYYYMMDD'), 'YYYYMM')                                              \n");
		sbSql.append("                       ) E                                                                                                                          \n");
		sbSql.append("                 WHERE A.BASE_MM = B.BASE_MM(+)                                                                                                     \n");
		sbSql.append("                   AND A.BASE_MM = C.BASE_MM(+)                                                                                                     \n");
		sbSql.append("                   AND A.BASE_MM = E.BASE_MM(+)                                                                                                     \n");
		sbSql.append("               )                                                                                                                                    \n");
		sbSql.append("         GROUP BY BASE_MM                                                                                                                           \n");
		sbSql.append("       ) B                                                                                                                                          \n");

		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();

		DataSet ds_rateMonth = this.makeDataSet(rs, "ds_rateMonth");
		out_dl.add(ds_rateMonth);
		this.setResultMessage(0, "OK",out_vl);

	} catch(Exception ex) {
	   ex.printStackTrace();
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
		if(stmt != null) {
			try {
				stmt.close();
			}catch(Exception e) {}
		}
		if(conn != null) {
			try {
				conn.close();
			}catch(Exception e) {}
		}
		proc_output(response,out,out_vl,out_dl);
	}
%>