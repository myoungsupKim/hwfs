<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	try {
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();

		//입력 데이타
		DataSet ds_input     	= in_dl.get("ds_input");

		String strTmCD			= nullToBlank(ds_input.getString(0, "TM_CD"));
	  	String strUpjang 		= nullToBlank(ds_input.getString(0, "UPJANG"));
		String strFromDt		= nullToBlank(ds_input.getString(0, "FROM_DT2"));
	  	String strToDt 			= nullToBlank(ds_input.getString(0, "TO_DT2"));
	  	String strCloseYN 		= nullToBlank(ds_input.getString(0, "CLOSE_YN"));

		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		sbSql.delete(0, sbSql.length());
		sbSql.append("SELECT TO_CHAR(SYSDATE, 'YYYYMMDD') AS TO_DATE \n");
		sbSql.append("     , TO_CHAR(LAST_DAY(TO_DATE('"+ strToDt +"','YYYYMM')), 'YYYYMMDD') AS LAST_DATE \n");
		sbSql.append("  FROM DUAL \n");
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		rs.next();
		
		String toDt = rs.getString("TO_DATE");
		String lastDt = rs.getString("LAST_DATE");
		String strDt = "";

		if( !strToDt.equals(toDt.substring(0, 6)) )
			strDt = lastDt;
		else
			strDt = toDt;

		// 식자재사용패턴조회-기간
		sbSql.delete(0, sbSql.length());
		sbSql.append("SELECT A.JOB_NAME AS JOB_NAME \n");
		sbSql.append("     , A.SUB_JOB_NAME AS SUB_JOB_NAME \n");
		sbSql.append("     , A.UPJANGNM AS UPJANGNM \n");
		sbSql.append("     , SUBSTR(A.YYYYMM, 5, 2) || '월' AS MM \n");
		sbSql.append("     , B.GOAL_RATE AS GOAL_RATE \n");
		sbSql.append("     , ROUND(DECODE(NVL(C.COST_AMT, 0), 0, NULL, B.STOCK_AMT/C.COST_AMT*100), 1) AS RST_RATE \n");
		sbSql.append("     , DECODE(C.COST_AMT \n");
		sbSql.append("              , NULL \n");
		sbSql.append("              , DECODE(B.STOCK_AMT \n");
		sbSql.append("                       , NULL \n");
		sbSql.append("                       , DECODE(B.GOAL_RATE \n");
		sbSql.append("                                , NULL \n");
		sbSql.append("                                , NULL \n");
		sbSql.append("                                , ROUND(DECODE(NVL(C.COST_AMT, 0), 0, 0, NVL(B.STOCK_AMT, 0) / NVL(C.COST_AMT, 0) * 100), 1) - NVL(B.GOAL_RATE, 0)) \n");
		sbSql.append("                       , ROUND(DECODE(NVL(C.COST_AMT, 0), 0, 0, NVL(B.STOCK_AMT, 0) / NVL(C.COST_AMT, 0) * 100), 1) - NVL(B.GOAL_RATE, 0)) \n");
		sbSql.append("              , ROUND(DECODE(NVL(C.COST_AMT, 0), 0, 0, NVL(B.STOCK_AMT, 0) / NVL(C.COST_AMT, 0) * 100), 1) - NVL(B.GOAL_RATE, 0) \n");
		sbSql.append("             ) RATE_GAP \n");
		sbSql.append("     , B.STOCK_AMT \n");
		sbSql.append("     , C.COST_AMT \n");
		sbSql.append("  FROM ( \n");
		sbSql.append("        SELECT * \n");
		sbSql.append("          FROM MAC_UPJANG_V A \n");
		sbSql.append("             , ( \n");
		sbSql.append("                SELECT SUBSTR('" + strToDt + "', 1, 4) || LPAD(ROWNUM,2, '0') YYYYMM \n");
		sbSql.append("                  FROM DICT \n");
		sbSql.append("                 WHERE ROWNUM <= TO_NUMBER(SUBSTR('" + strToDt + "', 5, 2)) \n");
		sbSql.append("               ) \n");

		if (strCloseYN.equals("Y"))
			sbSql.append("         WHERE A.CLOSE_DATE IS NULL \n");

		sbSql.append("       ) A \n");
		sbSql.append("      ,( \n");
		sbSql.append("        SELECT UPJANG AS UPJANG \n");
		sbSql.append("             , GOAL_MM AS GOAL_MM \n");
		sbSql.append("             , SUM(GOAL_RATE) AS GOAL_RATE \n");
		sbSql.append("             , SUM(COST_AMT) AS COST_AMT \n");
		sbSql.append("             , SUM(STOCK_AMT) AS STOCK_AMT \n");
		sbSql.append("          FROM ( \n");
		sbSql.append("                SELECT UPJANG AS UPJANG \n");
		sbSql.append("                     , GOAL_MM AS GOAL_MM \n");
		sbSql.append("                     , GOAL_RATE AS GOAL_RATE \n");
		sbSql.append("                     , 0 AS COST_AMT \n");
		sbSql.append("                     , 0 AS STOCK_AMT \n");
		sbSql.append("                  FROM FSA_STOCK_GOAL_SET \n");
		sbSql.append("                 WHERE GOAL_MM BETWEEN '" + strFromDt + "' AND '" + strToDt + "' \n");
		sbSql.append("                UNION ALL \n");
		sbSql.append("                SELECT UPJANG AS UPJANG \n");
		sbSql.append("                     , GOAL_MM AS GOAL_MM \n");
		sbSql.append("                     , 0 AS GOAL_RATE \n");
		sbSql.append("                     , 0 AS COST_AMT \n");
		sbSql.append("                     , SUM(STOCK_AMT) AS STOCK_AMT \n");
		sbSql.append("                  FROM ( \n");
		sbSql.append("                        SELECT UPJANG AS UPJANG \n");
		sbSql.append("                             , ONHAND_YM AS GOAL_MM \n");
		sbSql.append("                             , DECODE(B.OUTVAT_FLAG, 'Y', ROUND( SUM( MARGIN_AMOUNT * DECODE( TAX_CODE, '100', DECODE( B.MATERIAL_ACCTCD, '11402000', 1.1, 1), 1) ) ), SUM( MARGIN_AMOUNT ) ) AS STOCK_AMT \n");
		sbSql.append("                          FROM  HLDC_PO_ONHAND_MONTH A \n");
		sbSql.append("                             , HLDC_PO_SUBINVENTORY B \n");
		sbSql.append("                             , HLDC_PO_ITEM_MST C \n");
		sbSql.append("                         WHERE A.SUBINV_CODE = B.SUBINV_CODE \n");
		sbSql.append("                           AND A.ITEM_CODE = C.ITEM_CODE \n");
		sbSql.append("                           AND A.ONHAND_YM BETWEEN '" + strFromDt + "' AND '" + strToDt + "' \n");
		sbSql.append("                           AND B.MATERIAL_ACCTCD = '11402000' \n");
		sbSql.append("                           AND B.SUBINV_CODE LIKE 'C%' \n");
		sbSql.append("                         GROUP BY UPJANG, B.OUTVAT_FLAG, ONHAND_YM \n");
		sbSql.append("                         UNION ALL \n");
		sbSql.append("                        SELECT TO_NUMBER(A.TRANS_UPJANG) AS UPJANG \n");
		sbSql.append("                             , SUBSTR(A.TRANS_DATE, 0, 6) AS GOAL_MM \n");
		sbSql.append("                             , DECODE(SUBSTR(A.TRANS_TYPE, 1, 1), 'I', 1, -1) * NVL( DECODE(B.OUTVAT_FLAG, 'Y', ROUND( SUM( UNIT_AMOUNT * DECODE( A.TAX_CODE, '100', DECODE( MATERIAL_ACCTCD, '11402000', 1.1, 1), 1) ) ), SUM( UNIT_AMOUNT ) ), 0) STOCK_AMT \n");
		sbSql.append("                          FROM HLDC_PO_TRANSACTION A \n");
		sbSql.append("                             , HLDC_PO_SUBINVENTORY B \n");
		sbSql.append("                             , HLDC_PO_ITEM_MST C \n");
		sbSql.append("                         WHERE A.SUBINV_CODE = B.SUBINV_CODE \n");
		sbSql.append("                           AND A.ITEM_CODE = C.ITEM_CODE \n");
		sbSql.append("                           AND A.TRANS_DATE BETWEEN '" + strFromDt + "' || '01' AND '" + strDt + "' \n");

		if (strUpjang.length() != 0)
			sbSql.append("                           AND A.TRANS_UPJANG = '" + strUpjang + "' \n");

		sbSql.append("                           AND B.MATERIAL_ACCTCD = '11402000' \n");
		sbSql.append("                         GROUP BY A.TRANS_UPJANG, SUBSTR(A.TRANS_DATE, 0, 6), B.OUTVAT_FLAG, SUBSTR(A.TRANS_TYPE, 1, 1) \n");
		sbSql.append("                       ) \n");
		sbSql.append("                 GROUP BY UPJANG, GOAL_MM \n");
		sbSql.append("               ) \n");
		sbSql.append("         GROUP BY UPJANG, GOAL_MM \n");
		sbSql.append("       ) B \n");
		sbSql.append("     , ( \n");
		sbSql.append("        SELECT UPJANG AS UPJANG \n");
		sbSql.append("             , GOAL_MM AS GOAL_MM \n");
		sbSql.append("             , NVL(SUM(MS_AMT1), 0) + NVL(SUM(MS_AMT2), 0) - NVL(SUM(MS_AMT3), 0) AS COST_AMT \n");
		sbSql.append("          FROM ( \n");
		sbSql.append("                SELECT TO_NUMBER(A.TRANS_UPJANG) AS UPJANG \n");
		sbSql.append("                     , SUBSTR(A.TRANS_DATE, 0, 6) AS GOAL_MM \n");
		sbSql.append("                     , NVL( DECODE(B.OUTVAT_FLAG, 'Y', ROUND( SUM( A.MARGIN_AMOUNT * DECODE( A.TAX_CODE, '100', DECODE( B.MATERIAL_ACCTCD, '11402000', 1.1, 1), 1) ) ), SUM( A.MARGIN_AMOUNT ) ), 0) AS MS_AMT1 \n");
		sbSql.append("                     , 0 AS MS_AMT2 \n");
		sbSql.append("                     , 0 AS MS_AMT3 \n");
		sbSql.append("                  FROM HLDC_PO_TRANSACTION A \n");
		sbSql.append("                     , HLDC_PO_SUBINVENTORY B \n");
		sbSql.append("                 WHERE A.SUBINV_CODE = B.SUBINV_CODE \n");
		sbSql.append("                   AND A.TRANS_DATE BETWEEN '" + strFromDt + "' || '01' AND '" + strDt + "' \n");

		if (strUpjang.length() != 0)
			sbSql.append("                   AND A.TRANS_UPJANG = '" + strUpjang + "' \n");

		sbSql.append("                   AND A.TRANS_TYPE LIKE 'O%' \n");
		sbSql.append("                   AND A.TRANS_TYPE <> 'O002' \n");
		sbSql.append("                 GROUP BY A.TRANS_UPJANG, SUBSTR(A.TRANS_DATE, 0, 6), B.OUTVAT_FLAG \n");     
		sbSql.append("                 UNION ALL \n");
		sbSql.append("                SELECT B.UPJANG AS UPJANG \n");
		sbSql.append("                     , SUBSTR(A.BASIS_DATE, 0, 6) AS GOAL_MM \n");
		sbSql.append("                     , 0 AS MS_AMT1 \n");
		sbSql.append("                     , NVL(SUM(A.AMT), 0) AS MS_AMT2 \n");
		sbSql.append("                     , 0 AS MS_AMT3 \n");
		sbSql.append("                  FROM MAP_PREPAY_ADJUST A \n");
		sbSql.append("                     , SCO_UPJANG_MST_V B \n");
		sbSql.append("                 WHERE A.CC_CD = B.CC_CD \n");
		sbSql.append("                   AND A.BASIS_DATE BETWEEN '" + strFromDt + "' || '01' AND '" + strDt + "' \n");
		sbSql.append("                   AND ACCT_CD = '41203010' \n");

		if (strUpjang.length() != 0)
			sbSql.append("                   AND B.UPJANG = " + strUpjang + " \n");

		sbSql.append("                 GROUP BY B.UPJANG, SUBSTR(A.BASIS_DATE, 0, 6) \n");
		sbSql.append("                 UNION ALL \n");
		sbSql.append("                SELECT UPJANG AS UPJANG \n");
		sbSql.append("                     , SUBSTR(TO_CHAR(CDATE, 'YYYYMMDD'), 0, 6) AS GOAL_MM \n");
		sbSql.append("                     , 0 AS MS_AMT1 \n");
		sbSql.append("                     , 0 AS MS_AMT2 \n");
		sbSql.append("                     , NVL(SUM(AMT), 0) AS MS_AMT3 \n");
		sbSql.append("                  FROM MAS_WELFARE \n");
		sbSql.append("                 WHERE 1 = 1 \n");

		if (strUpjang.length() != 0)
			sbSql.append("                   AND UPJANG = " + strUpjang + " \n");

		sbSql.append("                   AND TO_CHAR(CDATE, 'YYYYMMDD') BETWEEN '" + strFromDt + "' || '01' AND '" + strDt + "' \n");
		sbSql.append("                 GROUP BY UPJANG, SUBSTR(TO_CHAR(CDATE, 'YYYYMMDD'), 0, 6) \n");
		sbSql.append("               ) \n");
		sbSql.append("         GROUP BY UPJANG, GOAL_MM \n");
        sbSql.append("       ) C \n");
		sbSql.append(" WHERE A.UPJANG = B.UPJANG(+) \n");
		sbSql.append("   AND A.YYYYMM = B.GOAL_MM(+) \n");
		sbSql.append("   AND A.UPJANG = C.UPJANG(+) \n");
		sbSql.append("   AND A.YYYYMM = C.GOAL_MM(+) \n");

		if (strUpjang.length() != 0)
			sbSql.append("   AND A.UPJANG = " + strUpjang + " \n");

		sbSql.append("   AND A.TM_CD = '" + strTmCD + "' -- [운영부서] \n");
		sbSql.append(" ORDER BY A.JOB_NAME \n");
		sbSql.append("        , A.SUB_JOB_NAME \n");
		sbSql.append("        , A.UPJANGNM \n");
		sbSql.append("        , A.YYYYMM \n");

		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		DataSet ds_list = this.makeDataSet(rs, "ds_list");

		/**종료**/
		out_dl.add(ds_list);
		this.setResultMessage(0, "OK", out_vl);

	}
	catch( Exception ex )
	{
		ex.printStackTrace();
		this.setResultMessage(-1, ex.toString(), out_vl);
	}
	finally
	{
		if( rs != null )
		{
			try {
				rs.close();
			} catch( Exception e ) {}
		}
		if( pstmt != null )
		{
			try {
				pstmt.close();
			} catch( Exception e ) {}
		}
		if( conn != null )
		{
			try {
				conn.close();
			} catch( Exception e ) {}
		}
	}

	proc_output(response,out,out_vl,out_dl);
%>