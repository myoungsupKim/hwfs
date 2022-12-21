
<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	try
	{
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();

		//jsp log 서비스 시작
		logger.startIndividualLog(in_vl.getString("titLogId"));

		DataSet ds_input	= in_dl.get("ds_input");

		//입력 데이타
	    String START_DATE	= nullToBlank(ds_input.getString(0, "START_DATE"));
		String END_DATE		= nullToBlank(ds_input.getString(0, "END_DATE"));
		String TRANS_TYPE	= nullToBlank(ds_input.getString(0, "TRANS_TYPE"));
		String SUBINV_CODE	= nullToBlank(ds_input.getString(0, "SUBINV_CODE"));
		String ITEM_CODE	= nullToBlank(ds_input.getString(0, "ITEM_CODE"));
		String CUSTCD		= nullToBlank(ds_input.getString(0, "CUSTCD"));
		String CHK_01		= nullToBlank(ds_input.getString(0, "CHK_01"));
		String CHK_VAT		= nullToBlank(ds_input.getString(0, "CHK_VAT"));
		String CHK_PAST		= nullToBlank(in_vl.getString("CHK_PAST"));

		String ONHAND_YM   = "";

		StringBuffer sbSql = new StringBuffer();
		sbSql.delete(0, sbSql.length());

		sbSql.append("SELECT MAX(A.CLS_YM) AS CLS_YM \n");
		sbSql.append("  FROM HLDC_PO_CLOSING A \n");
		sbSql.append(" WHERE A.CLS_YM < SUBSTR('" + START_DATE + "', 1, 6) \n");
		sbSql.append("   AND A.SUBINV_CODE = '" + SUBINV_CODE + "' \n");
		sbSql.append("   AND A.CLS_FLAG = 'Y' \n");

		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		rs.next();

		if( nullToBlank(rs.getString("CLS_YM")).equals("") )
		{
			ONHAND_YM = "000101";
		}
		else
		{
			ONHAND_YM = rs.getString("CLS_YM");
		}

		sbSql.delete(0, sbSql.length());

		// 소분류별 소계
		if( CHK_VAT.equals("1") )
		{
			sbSql.append("WITH A AS \n");
			sbSql.append("( \n");
		}

		// [1] 구매단위 표시 체크시
		if(CHK_01.equals("1"))
		{
			sbSql.append(" SELECT A.ITEM_CODE                                                              AS ITEM_CODE \n");
			sbSql.append("      , A.ITEM_NAME                                                              AS ITEM_NAME \n");
			sbSql.append("      , A.PO_UOM                                                                 AS UOM_CODE \n");
			sbSql.append("      , A.ITEM_SIZE                                                              AS ITEM_SIZE \n");
			sbSql.append("      , DECODE(A.TAX_CODE, '100', '과세', '210', '면세', '영세')                 AS TAX_NAME \n");
			sbSql.append("      , SUM(TRANS_QTY / A.UOM_CONVERT_RATE)                                      AS TRANS_QTY \n");
			sbSql.append("      , SUM(ROUND(TRANS_AMT))                                                    AS TRANS_AMT \n");
			sbSql.append("      , SUM(PO_QTY / A.UOM_CONVERT_RATE)                                         AS PO_QTY \n");
			sbSql.append("      , SUM(ROUND(PO_AMT))                                                       AS PO_AMT \n");
			sbSql.append("      , SUM(IN_QTY / A.UOM_CONVERT_RATE)                                         AS IN_QTY \n");
			sbSql.append("      , SUM(ROUND(IN_AMT))                                                       AS IN_AMT \n");
			sbSql.append("      , SUM(INV_QTY / A.UOM_CONVERT_RATE)                                        AS INV_QTY \n");
			sbSql.append("      , SUM(ROUND(INV_AMT))                                                      AS INV_AMT \n");
			sbSql.append("      , SUM(OUT_QTY / A.UOM_CONVERT_RATE)                                        AS OUT_QTY \n");
			sbSql.append("      , SUM(ROUND(OUT_AMT))                                                      AS OUT_AMT \n");
			sbSql.append("      , SUM(TRANS_QTY / A.UOM_CONVERT_RATE) \n");
			sbSql.append("	      + SUM(PO_QTY / A.UOM_CONVERT_RATE) \n");
			sbSql.append("	      + SUM(IN_QTY / A.UOM_CONVERT_RATE) \n");
			sbSql.append("        - SUM(INV_QTY / A.UOM_CONVERT_RATE) \n");
			sbSql.append("	      - SUM(OUT_QTY / A.UOM_CONVERT_RATE)                                      AS RMN_QTY \n");
			sbSql.append("      , SUM(ROUND(TRANS_AMT)) + SUM(ROUND(PO_AMT)) + SUM(ROUND(IN_AMT)) - SUM(ROUND(INV_AMT)) - SUM(ROUND(OUT_AMT)) AS RMN_AMT \n");
			sbSql.append("   FROM HLDC_PO_ITEM_MST A \n");
			sbSql.append("      , HLDC_PO_ITEM_CLASS_HLDC_V C \n");
			sbSql.append("      , HLDC_PO_ITEM_CLASS_HLDC_V D \n");
			sbSql.append("      , (SELECT ITEM_CODE AS ITEM_CODE \n");
			sbSql.append("              , ONHAND_QTY AS TRANS_QTY \n");
			sbSql.append("              , MARGIN_AMOUNT AS TRANS_AMT \n");
			sbSql.append("              , 0 AS PO_QTY \n");
			sbSql.append("              , 0 AS PO_AMT \n");
			sbSql.append("              , 0 AS IN_QTY \n");
			sbSql.append("              , 0 AS IN_AMT \n");
			sbSql.append("              , 0 AS INV_QTY \n");
			sbSql.append("              , 0 AS INV_AMT \n");
			sbSql.append("              , 0 AS OUT_QTY \n");
			sbSql.append("              , 0 AS OUT_AMT \n");
			// 2012년 전 과거자료를 조회할 때
			if( CHK_PAST.equals("1") )
			{
				sbSql.append("           FROM HIS_PO_ONHAND_MONTH_2013 \n");
			}
			else
			{
				sbSql.append("           FROM HLDC_PO_ONHAND_MONTH \n");
			}

			sbSql.append("          WHERE ONHAND_YM = '" + ONHAND_YM + "' \n");
			sbSql.append("            AND SUBINV_CODE = '" + SUBINV_CODE + "' \n");
			if( !ITEM_CODE.equals("") )
			{
				sbSql.append("            AND ITEM_CODE = '" + ITEM_CODE + "'\n");
			}
			if( !CUSTCD.equals("") )
			{
//				sbSql.append("            AND CUSTCD LIKE '" + CUSTCD + "%' \n");
			}

			sbSql.append("          UNION ALL \n");
			sbSql.append("         SELECT ITEM_CODE AS ITEM_CODE \n");
			sbSql.append("              , SUM(DECODE(SUBSTR(TRANS_TYPE, 1, 1), 'I', 1, -1) * UOM_QTY) AS TRANS_QTY \n");
			sbSql.append("              , SUM(DECODE(SUBSTR(TRANS_TYPE, 1, 1), 'I', 1, -1) * MARGIN_AMOUNT) AS TRANS_AMT \n");
			sbSql.append("              , 0 AS PO_QTY \n");
			sbSql.append("              , 0 AS PO_AMT \n");
			sbSql.append("              , 0 AS IN_QTY \n");
			sbSql.append("              , 0 AS IN_AMT \n");
			sbSql.append("              , 0 AS INV_QTY \n");
			sbSql.append("              , 0 AS INV_AMT \n");
			sbSql.append("              , 0 AS OUT_QTY \n");
			sbSql.append("              , 0 AS OUT_AMT \n");
			//sbSql.append("           FROM HLDC_PO_TRANSACTION \n");	// TUNING POINT
			sbSql.append("           FROM HLDC_PO_TRANSACTION2 \n");
			sbSql.append("          WHERE TRANS_DATE BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE('" + ONHAND_YM + "' || '01', 'YYYYMMDD'), 1), 'YYYYMMDD') \n");
			sbSql.append("                               AND TO_CHAR(TO_DATE('" + START_DATE + "', 'YYYYMMDD') - 1, 'YYYYMMDD') \n");
			sbSql.append("            AND SUBINV_CODE = '" + SUBINV_CODE + "' \n");
			if( !ITEM_CODE.equals("") )
			{
				sbSql.append("            AND ITEM_CODE = '" + ITEM_CODE + "' \n");
			}
			if( !CUSTCD.equals("") )
			{
				sbSql.append("            AND CUSTCD LIKE '" + CUSTCD + "%' \n");
			}
			sbSql.append("          GROUP BY ITEM_CODE \n");
			sbSql.append("          UNION ALL \n");
			sbSql.append("         SELECT ITEM_CODE AS ITEM_CODE \n");
			sbSql.append("              , 0 AS TRANS_QTY \n");
			sbSql.append("              , 0 AS TRANS_AMT \n");
			sbSql.append("              , SUM(UOM_QTY) AS PO_QTY \n");
			sbSql.append("              , SUM(MARGIN_AMOUNT) AS PO_AMT \n");
			sbSql.append("              , 0 AS IN_QTY \n");
			sbSql.append("              , 0 AS IN_AMT \n");
			sbSql.append("              , 0 AS INV_QTY \n");
			sbSql.append("              , 0 AS INV_AMT \n");
			sbSql.append("              , 0 AS OUT_QTY \n");
			sbSql.append("              , 0 AS OUT_AMT \n");
			//sbSql.append("          FROM HLDC_PO_TRANSACTION \n");	// TUNING POINT
			sbSql.append("          FROM HLDC_PO_TRANSACTION2 \n");
			sbSql.append("         WHERE TRANS_DATE BETWEEN '" + START_DATE + "' AND '" + END_DATE + "' \n");
			sbSql.append("           AND SUBINV_CODE = '" + SUBINV_CODE + "' \n");
			if(!ITEM_CODE.equals(""))
			{
				sbSql.append("           AND ITEM_CODE = '" + ITEM_CODE + "' \n");
			}
			if(!CUSTCD.equals(""))
			{
				sbSql.append("           AND CUSTCD LIKE '" + CUSTCD + "%' \n");
			}
			sbSql.append("           AND TRANS_TYPE LIKE 'I%' \n");
			sbSql.append("           AND TRANS_TYPE <> 'I002' \n");
			sbSql.append("         GROUP BY ITEM_CODE \n");
			sbSql.append("         UNION ALL \n");
			sbSql.append("        SELECT ITEM_CODE AS ITEM_CODE \n");
			sbSql.append("             , 0 AS TRANS_QTY \n");
			sbSql.append("             , 0 AS TRANS_AMT \n");
			sbSql.append("             , 0 AS PO_QTY \n");
			sbSql.append("             , 0 AS PO_AMT \n");
			sbSql.append("             , SUM(UOM_QTY) AS IN_QTY \n");
			sbSql.append("             , SUM(MARGIN_AMOUNT) AS IN_AMT \n");
			sbSql.append("             , 0 AS INV_QTY \n");
			sbSql.append("             , 0 AS INV_AMT \n");
			sbSql.append("             , 0 AS OUT_QTY \n");
			sbSql.append("             , 0 AS OUT_AMT \n");
			//sbSql.append("          FROM HLDC_PO_TRANSACTION \n");	// TUNING POINT
			sbSql.append("          FROM HLDC_PO_TRANSACTION2 \n");
			sbSql.append("         WHERE TRANS_DATE BETWEEN '" + START_DATE + "' AND '" + END_DATE + "' \n");
			sbSql.append("           AND SUBINV_CODE = '" + SUBINV_CODE + "' \n");
			if( !ITEM_CODE.equals("") )
			{
				sbSql.append("           AND ITEM_CODE = '" + ITEM_CODE + "' \n");
			}
			if( !CUSTCD.equals("") )
			{
				sbSql.append("           AND CUSTCD LIKE '" + CUSTCD + "%' \n");
			}
		    sbSql.append("           AND TRANS_TYPE  = 'I002' \n");
			sbSql.append("         GROUP BY ITEM_CODE \n");
			sbSql.append("         UNION ALL \n");
			sbSql.append("        SELECT ITEM_CODE AS ITEM_CODE \n");
			sbSql.append("             , 0 AS TRANS_QTY \n");
			sbSql.append("             , 0 AS TRANS_AMT \n");
			sbSql.append("             , 0 AS PO_QTY \n");
			sbSql.append("             , 0 AS PO_AMT \n");
			sbSql.append("             , 0 AS IN_QTY \n");
			sbSql.append("             , 0 AS IN_AMT \n");
			sbSql.append("             , SUM(UOM_QTY) AS INV_QTY \n");
			sbSql.append("             , SUM(MARGIN_AMOUNT) AS INV_AMT \n");
			sbSql.append("             , 0 AS OUT_QTY \n");
			sbSql.append("             , 0 AS OUT_AMT \n");
			//sbSql.append("          FROM HLDC_PO_TRANSACTION \n");	// TUNING POINT
			sbSql.append("          FROM HLDC_PO_TRANSACTION2 \n");
			sbSql.append("         WHERE TRANS_DATE BETWEEN '" + START_DATE + "' AND '" + END_DATE + "' \n");
			sbSql.append("           AND SUBINV_CODE = '" + SUBINV_CODE + "' \n");
			if( !ITEM_CODE.equals("") )
			{
				sbSql.append("           AND ITEM_CODE = '" + ITEM_CODE + "' \n");
			}
			if( !CUSTCD.equals("") )
			{
				sbSql.append("           AND CUSTCD LIKE '" + CUSTCD + "%' \n");
			}
			sbSql.append("           AND TRANS_TYPE LIKE 'O%' \n");
			sbSql.append("           AND TRANS_TYPE <> 'O002' \n");
			sbSql.append("         GROUP BY ITEM_CODE \n");
			sbSql.append("         UNION ALL \n");
			sbSql.append("        SELECT ITEM_CODE AS ITEM_CODE \n");
			sbSql.append("             , 0 AS TRANS_QTY \n");
			sbSql.append("             , 0 AS TRANS_AMT \n");
			sbSql.append("             , 0 AS PO_QTY \n");
			sbSql.append("             , 0 AS PO_AMT \n");
			sbSql.append("             , 0 AS IN_QTY \n");
			sbSql.append("             , 0 AS IN_AMT \n");
			sbSql.append("             , 0 AS INV_QTY \n");
			sbSql.append("             , 0 AS INV_AMT \n");
			sbSql.append("             , SUM(UOM_QTY) AS OUT_QTY \n");
			sbSql.append("             , SUM(MARGIN_AMOUNT) AS OUT_AMT \n");
			//sbSql.append("          FROM HLDC_PO_TRANSACTION \n");	// TUNING PONT
			sbSql.append("          FROM HLDC_PO_TRANSACTION2 \n");
			sbSql.append("         WHERE TRANS_DATE BETWEEN '" + START_DATE + "' AND '" + END_DATE + "' \n");
			sbSql.append("           AND SUBINV_CODE = '" + SUBINV_CODE + "' \n");
			if( !ITEM_CODE.equals("") )
			{
				sbSql.append("           AND ITEM_CODE = '" + ITEM_CODE + "' \n");
			}
			if(!CUSTCD.equals(""))
			{
				sbSql.append("           AND CUSTCD LIKE '" + CUSTCD + "%' \n");
			}
			sbSql.append("           AND TRANS_TYPE  = 'O002' \n");
			sbSql.append("         GROUP BY ITEM_CODE) B \n");
			sbSql.append("  WHERE A.ITEM_CODE = B.ITEM_CODE \n");
			sbSql.append("    AND C.CLASS_CODE = A.ITEM_CLASS2 \n");
			sbSql.append("    AND C.CLASS_TYPE = 'M' \n");
			sbSql.append("    AND D.CLASS_CODE = A.ITEM_CLASS3 \n");
			sbSql.append("    AND D.CLASS_TYPE = 'S' \n");
			sbSql.append("  GROUP BY A.ITEM_CODE, C.CLASS_CODE, D.CLASS_CODE, A.ITEM_NAME, A.PO_UOM, A.ITEM_SIZE, DECODE(A.TAX_CODE,'100','과세','210','면세','영세') \n");
			if( !CHK_VAT.equals("1") )
			{
				sbSql.append("  ORDER BY C.CLASS_CODE, D.CLASS_CODE, A.ITEM_CODE, A.ITEM_NAME \n");
			}
		}
		// [1]구매단위 언체크시
		else
		{
			sbSql.append(" SELECT A.ITEM_CODE                                                              AS ITEM_CODE \n");
			sbSql.append("      , A.ITEM_NAME                                                              AS ITEM_NAME \n");
			sbSql.append("      , A.UOM_CODE                                                               AS UOM_CODE \n");
			sbSql.append("      , A.ITEM_SIZE                                                              AS ITEM_SIZE \n");
			sbSql.append("      , DECODE(A.TAX_CODE, '100', '과세', '210', '면세', '영세')                 AS TAX_NAME \n");
			sbSql.append("      , SUM(TRANS_QTY)                                                           AS TRANS_QTY \n");
			sbSql.append("      , ROUND(SUM(TRANS_AMT))                                                    AS TRANS_AMT \n");
			sbSql.append("      , SUM(PO_QTY)                                                              AS PO_QTY \n");
			sbSql.append("      , ROUND(SUM(PO_AMT))                                                       AS PO_AMT \n");
			sbSql.append("      , SUM(IN_QTY)                                                              AS IN_QTY \n");
			sbSql.append("      , ROUND(SUM(IN_AMT))                                                       AS IN_AMT \n");
			sbSql.append("      , SUM(INV_QTY)                                                             AS INV_QTY \n");
			sbSql.append("      , ROUND(SUM(INV_AMT))                                                      AS INV_AMT \n");
			sbSql.append("      , SUM(OUT_QTY)                                                             AS OUT_QTY \n");
			sbSql.append("      , ROUND(SUM(OUT_AMT))                                                      AS OUT_AMT \n");
			sbSql.append("      , SUM(TRANS_QTY) + SUM(PO_QTY) + SUM(IN_QTY) - SUM(INV_QTY) - SUM(OUT_QTY) AS RMN_QTY \n");
			sbSql.append("      , ROUND(SUM(TRANS_AMT) + SUM(PO_AMT) + SUM(IN_AMT) - SUM(INV_AMT) - SUM(OUT_AMT)) AS RMN_AMT \n");
			sbSql.append("   FROM HLDC_PO_ITEM_MST A \n");
			sbSql.append("      , HLDC_PO_ITEM_CLASS_HLDC_V C \n");
			sbSql.append("      , HLDC_PO_ITEM_CLASS_HLDC_V D \n");
			sbSql.append("      ,(SELECT ITEM_CODE AS ITEM_CODE \n");
			sbSql.append("             , ONHAND_QTY AS TRANS_QTY \n");
			sbSql.append("             , MARGIN_AMOUNT AS TRANS_AMT \n");
			sbSql.append("             , 0 AS PO_QTY \n");
			sbSql.append("             , 0 AS PO_AMT \n");
			sbSql.append("             , 0 AS IN_QTY \n");
			sbSql.append("             , 0 AS IN_AMT \n");
			sbSql.append("             , 0 AS INV_QTY \n");
			sbSql.append("             , 0 AS INV_AMT \n");
			sbSql.append("             , 0 AS OUT_QTY \n");
			sbSql.append("             , 0 AS OUT_AMT \n");
			// 2012년 전 과거자료를 조회할 때
			if( CHK_PAST.equals("1") )
			{
				sbSql.append("          FROM HIS_PO_ONHAND_MONTH_201312 \n");
			}
			else
			{
				sbSql.append("          FROM HLDC_PO_ONHAND_MONTH \n");
			}

			sbSql.append("         WHERE ONHAND_YM   = '" + ONHAND_YM   + "' \n");
			sbSql.append("           AND SUBINV_CODE = '" + SUBINV_CODE + "' \n");
			if( !ITEM_CODE.equals("") )
			{
				sbSql.append("           AND ITEM_CODE = '" + ITEM_CODE + "' \n");
			}
			if( !CUSTCD.equals("") )
			{
				sbSql.append("           AND CUSTCD LIKE '" + CUSTCD + "%' \n");
			}
			sbSql.append("         UNION ALL \n");
			sbSql.append("        SELECT ITEM_CODE \n");
			sbSql.append("             , SUM(DECODE(SUBSTR(TRANS_TYPE, 1, 1), 'I', 1, -1) * UOM_QTY) AS TRANS_QTY \n");
			sbSql.append("             , SUM(DECODE(SUBSTR(TRANS_TYPE, 1, 1), 'I', 1, -1) * MARGIN_AMOUNT) AS TRANS_AMT \n");
			sbSql.append("             , 0 AS PO_QTY \n");
			sbSql.append("             , 0 AS PO_AMT \n");
			sbSql.append("             , 0 AS IN_QTY \n");
			sbSql.append("             , 0 AS IN_AMT \n");
			sbSql.append("             , 0 AS INV_QTY \n");
			sbSql.append("             , 0 AS INV_AMT \n");
			sbSql.append("             , 0 AS OUT_QTY \n");
			sbSql.append("             , 0 AS OUT_AMT \n");
			// 2012년 전 과거자료를 조회할 때
			if( CHK_PAST.equals("1") )
			{
				sbSql.append("          FROM HIS_PO_TRANSACTION_201312 \n");
			}
			else
			{
				//sbSql.append("          FROM HLDC_PO_TRANSACTION \n");	// TUNING POINT
				sbSql.append("          FROM HLDC_PO_TRANSACTION2 \n");
			}
			sbSql.append("         WHERE TRANS_DATE BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE('" + ONHAND_YM + "' || '01', 'YYYYMMDD'), 1), 'YYYYMMDD') \n");
			sbSql.append("                              AND TO_CHAR(TO_DATE('" + START_DATE + "', 'YYYYMMDD') -1, 'YYYYMMDD') \n");
			sbSql.append("           AND SUBINV_CODE = '" + SUBINV_CODE + "' \n");
			if( !ITEM_CODE.equals("") )
			{
				sbSql.append("           AND ITEM_CODE = '" + ITEM_CODE + "' \n");
			}
			if( !CUSTCD.equals("") )
			{
				sbSql.append("           AND CUSTCD LIKE '" + CUSTCD + "%' \n");
			}
			sbSql.append("         GROUP BY ITEM_CODE \n");
			sbSql.append("         UNION ALL \n");
			sbSql.append("        SELECT ITEM_CODE AS ITEM_CODE \n");
			sbSql.append("             , 0 AS TRANS_QTY \n");
			sbSql.append("             , 0 AS TRANS_AMT \n");
			sbSql.append("             , SUM(UOM_QTY) AS PO_QTY \n");
			sbSql.append("             , SUM(MARGIN_AMOUNT) AS PO_AMT \n");
			sbSql.append("             , 0 AS IN_QTY \n");
			sbSql.append("             , 0 AS IN_AMT \n");
			sbSql.append("             , 0 AS INV_QTY \n");
			sbSql.append("             , 0 AS INV_AMT \n");
			sbSql.append("             , 0 AS OUT_QTY \n");
			sbSql.append("             , 0 AS OUT_AMT \n");
			// 2012년 전 과거자료를 조회할 때
			if( CHK_PAST.equals("1") )
			{
				sbSql.append("          FROM HIS_PO_TRANSACTION_201312 \n");
			}
			else
			{
				//sbSql.append("          FROM HLDC_PO_TRANSACTION \n");	// TUNING POINT
				sbSql.append("          FROM HLDC_PO_TRANSACTION2 \n");
			}

			sbSql.append("         WHERE TRANS_DATE BETWEEN '" + START_DATE + "' AND '" + END_DATE + "' \n");
			sbSql.append("           AND SUBINV_CODE = '" + SUBINV_CODE + "' \n");
			if( !ITEM_CODE.equals("") )
			{
				sbSql.append("           AND ITEM_CODE = '" + ITEM_CODE + "' \n");
			}
			if( !CUSTCD.equals("") )
			{
				sbSql.append("           AND CUSTCD LIKE '" + CUSTCD + "%' \n");

			}
			sbSql.append("           AND TRANS_TYPE LIKE 'I%' \n");
			sbSql.append("           AND TRANS_TYPE <> 'I002' \n");
			sbSql.append("         GROUP BY ITEM_CODE \n");
			sbSql.append("         UNION ALL \n");
			sbSql.append("        SELECT ITEM_CODE AS ITEM_CODE \n");
			sbSql.append("             , 0 AS TRANS_QTY \n");
			sbSql.append("             , 0 AS TRANS_AMT \n");
			sbSql.append("             , 0 AS PO_QTY \n");
			sbSql.append("             , 0 AS PO_AMT \n");
			sbSql.append("             , SUM(UOM_QTY) AS IN_QTY \n");
			sbSql.append("             , SUM(MARGIN_AMOUNT) AS IN_AMT \n");
			sbSql.append("             , 0 AS INV_QTY \n");
			sbSql.append("             , 0 AS INV_AMT \n");
			sbSql.append("             , 0 AS OUT_QTY \n");
			sbSql.append("             , 0 AS OUT_AMT \n");
			// 2012년 전 과거자료를 조회할 때
			if( CHK_PAST.equals("1") )
			{
				sbSql.append("          FROM HIS_PO_TRANSACTION_201312 \n");
			}
			else
			{
				//sbSql.append("          FROM HLDC_PO_TRANSACTION \n");	// TUNING POINT
				sbSql.append("          FROM HLDC_PO_TRANSACTION2 \n");
			}

			sbSql.append("         WHERE TRANS_DATE BETWEEN '" + START_DATE + "' AND '" + END_DATE + "' \n");
			sbSql.append("           AND SUBINV_CODE = '" + SUBINV_CODE + "' \n");
			if( !ITEM_CODE.equals("") )
			{
				sbSql.append("           AND ITEM_CODE = '" + ITEM_CODE + "' \n");
			}
			if( !CUSTCD.equals("") )
			{
				sbSql.append("           AND CUSTCD LIKE '" + CUSTCD + "%' \n");
			}
            sbSql.append("           AND TRANS_TYPE  = 'I002'\n");
			sbSql.append("         GROUP BY ITEM_CODE \n");
			sbSql.append("         UNION ALL \n");
			sbSql.append("        SELECT ITEM_CODE AS ITEM_CODE \n");
			sbSql.append("             , 0 AS TRANS_QTY \n");
			sbSql.append("             , 0 AS TRANS_AMT \n");
			sbSql.append("             , 0 AS PO_QTY \n");
			sbSql.append("             , 0 AS PO_AMT \n");
			sbSql.append("             , 0 AS IN_QTY \n");
			sbSql.append("             , 0 AS IN_AMT \n");
			sbSql.append("             , SUM(UOM_QTY) AS INV_QTY \n");
			sbSql.append("             , SUM(MARGIN_AMOUNT) AS INV_AMT \n");
			sbSql.append("             , 0 AS OUT_QTY \n");
			sbSql.append("             , 0 AS OUT_AMT \n");
			// 2012년 전 과거자료를 조회할 때
			if( CHK_PAST.equals("1") )
			{
				sbSql.append("          FROM HIS_PO_TRANSACTION_201312 \n");
			}
			else
			{
				//sbSql.append("          FROM HLDC_PO_TRANSACTION \n");	// TUNING POINT
				sbSql.append("          FROM HLDC_PO_TRANSACTION2 \n");				
			}
			sbSql.append("         WHERE TRANS_DATE BETWEEN '" + START_DATE + "' AND '" + END_DATE + "' \n");
			sbSql.append("           AND SUBINV_CODE = '" + SUBINV_CODE + "' \n");
			if( !ITEM_CODE.equals("") )
			{
				sbSql.append("           AND ITEM_CODE = '" + ITEM_CODE + "' \n");
			}
			if( !CUSTCD.equals("") )
			{
				sbSql.append("           AND CUSTCD LIKE '" + CUSTCD + "%' \n");
			}
			sbSql.append("           AND TRANS_TYPE LIKE 'O%' \n");
			sbSql.append("           AND TRANS_TYPE <> 'O002' \n");
			sbSql.append("         GROUP BY ITEM_CODE \n");
			sbSql.append("         UNION ALL \n");
			sbSql.append("        SELECT ITEM_CODE AS ITEM_CODE \n");
			sbSql.append("             , 0 AS TRANS_QTY \n");
			sbSql.append("             , 0 AS TRANS_AMT \n");
			sbSql.append("             , 0 AS PO_QTY \n");
			sbSql.append("             , 0 AS PO_AMT \n");
			sbSql.append("             , 0 AS IN_QTY \n");
			sbSql.append("             , 0 AS IN_AMT \n");
			sbSql.append("             , 0 AS INV_QTY \n");
			sbSql.append("             , 0 AS INV_AMT \n");
			sbSql.append("             , SUM(UOM_QTY) AS OUT_QTY \n");
			sbSql.append("             , SUM(MARGIN_AMOUNT) AS OUT_AMT \n");
			// 2012년 전 과거자료를 조회할 때
			if( CHK_PAST.equals("1") )
			{
				sbSql.append("          FROM HIS_PO_TRANSACTION_201312 \n");
			}
			else
			{
				//sbSql.append("          FROM HLDC_PO_TRANSACTION \n");	// TUNING POINT
				sbSql.append("          FROM HLDC_PO_TRANSACTION2 \n");
			}
			sbSql.append("         WHERE TRANS_DATE BETWEEN '" + START_DATE + "' AND '"+ END_DATE +"' \n");
			sbSql.append("           AND SUBINV_CODE = '" + SUBINV_CODE + "' \n");
			if( !ITEM_CODE.equals("") )
			{
				sbSql.append("           AND ITEM_CODE = '" + ITEM_CODE + "' \n");
			}
			if(!CUSTCD.equals(""))
			{
				sbSql.append("           AND CUSTCD LIKE '" + CUSTCD + "%' \n");
			}
			sbSql.append("           AND TRANS_TYPE  = 'O002' \n");
			sbSql.append("         GROUP BY ITEM_CODE) B \n");
			sbSql.append("  WHERE A.ITEM_CODE = B.ITEM_CODE \n");
			sbSql.append("    AND C.CLASS_CODE = A.ITEM_CLASS2 \n");
			sbSql.append("    AND C.CLASS_TYPE = 'M' \n");
			sbSql.append("    AND D.CLASS_CODE = A.ITEM_CLASS3 \n");
			sbSql.append("    AND D.CLASS_TYPE = 'S' \n");
			sbSql.append("  GROUP BY A.ITEM_CODE, C.CLASS_CODE, D.CLASS_CODE, A.ITEM_NAME, A.UOM_CODE, A.ITEM_SIZE, DECODE(A.TAX_CODE, '100', '과세', '210', '면세', '영세') \n");
			if( !CHK_VAT.equals("1") )
			{
				sbSql.append("  ORDER BY C.CLASS_CODE, D.CLASS_CODE, A.ITEM_CODE, A.ITEM_NAME \n");
			}
		}

		// 소분류별 소계...
		if( CHK_VAT.equals("1") )
		{
			sbSql.append(") \n");
			sbSql.append("SELECT GROUPING(B.CLASS_CODE) + GROUPING(A.ITEM_CODE) AS GB \n");
			sbSql.append("     , B.CLASS_NAME \n");
			sbSql.append("     , CASE \n");
			sbSql.append("         WHEN GROUPING(B.CLASS_CODE) = 1 AND GROUPING(A.ITEM_CODE) = 1 THEN '합계' \n");
			sbSql.append("         WHEN GROUPING(B.CLASS_CODE) = 0 AND GROUPING(A.ITEM_CODE) = 1 THEN '소계' \n");
			sbSql.append("         ELSE A.ITEM_CODE \n");
			sbSql.append("       END AS ITEM_CODE \n");
			sbSql.append("     , A.ITEM_NAME \n");
			sbSql.append("     , A.UOM_CODE \n");
			sbSql.append("     , SUM(A.TRANS_QTY) AS TRANS_QTY \n");
			sbSql.append("     , SUM(A.TRANS_AMT) AS TRANS_AMT \n");
			sbSql.append("     , ROUND(SUM(DECODE(A.TAX_NAME, '과세', 0.1, 0) * A.TRANS_AMT)) AS TRANS_VAT \n");
			sbSql.append("     , SUM(A.PO_QTY + A.IN_QTY) AS PO_QTY \n");
			sbSql.append("     , SUM(A.PO_AMT + A.IN_AMT) AS PO_AMT \n");
			sbSql.append("     , ROUND(SUM(DECODE(A.TAX_NAME, '과세', 0.1, 0) * (A.PO_AMT + A.IN_AMT))) AS PO_VAT \n");
			sbSql.append("     , SUM(A.INV_QTY + A.OUT_QTY) AS INV_QTY \n");
			sbSql.append("     , SUM(A.INV_AMT + A.OUT_AMT) AS INV_AMT \n");
			sbSql.append("     , ROUND(SUM(DECODE(A.TAX_NAME, '과세', 0.1, 0) * (A.INV_AMT + A.OUT_AMT))) AS INV_VAT \n");
			sbSql.append("     , SUM(A.RMN_QTY) AS RMN_QTY \n");
			sbSql.append("     , SUM(A.RMN_AMT) AS RMN_AMT \n");
			sbSql.append("     , ROUND(SUM(DECODE(A.TAX_NAME, '과세', 0.1, 0) * A.RMN_AMT)) AS RMN_VAT \n");
			sbSql.append("  FROM A \n");
			sbSql.append("     , HLDC_PO_ITEM_CLASS B \n");
			sbSql.append("     , HLDC_PO_ITEM_MST C \n");
			sbSql.append(" WHERE A.ITEM_CODE = C.ITEM_CODE \n");
			sbSql.append("   AND B.CLASS_CODE = C.ITEM_CLASS4 \n");
			sbSql.append(" GROUP BY ROLLUP( (B.CLASS_CODE, B.CLASS_NAME), (A.ITEM_CODE, A.ITEM_NAME, A.UOM_CODE) ) \n");
			sbSql.append(" HAVING SUM(A.TRANS_QTY) <> 0 OR SUM(A.TRANS_AMT) <> 0 OR SUM(A.PO_QTY + A.IN_QTY) <> 0 OR SUM(A.PO_AMT + A.IN_AMT) <> 0 \n");
			sbSql.append("     OR SUM(A.INV_QTY + A.OUT_QTY) <> 0 OR SUM(A.INV_AMT + A.OUT_AMT) <> 0 OR SUM(A.RMN_QTY) <> 0 OR SUM(A.RMN_AMT) <> 0 \n");
			sbSql.append(" ORDER BY B.CLASS_CODE, A.ITEM_CODE \n");
		}

		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		DataSet ds_list = this.makeDataSet(rs, "ds_list");

		out_dl.add(ds_list);
		this.setResultMessage(0, "OK", out_vl);
	}
	catch( Exception ex )
	{
		// jsp 로그남기기
		logger.debug(ex.getMessage(), ex);
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

		// jsp log 서비스 닫기
		try {
			logger.endIndividualLog();
		} catch( Exception logE ) {
			logE.printStackTrace();
		}
	}

	proc_output(response, out, out_vl, out_dl);
%>