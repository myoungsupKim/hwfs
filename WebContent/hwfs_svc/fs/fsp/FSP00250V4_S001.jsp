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

		DataSet ds_input     	= in_dl.get("ds_input");

	    String START_DATE  = nullToBlank(ds_input.getString(0, "START_DATE"));
		String END_DATE    = nullToBlank(ds_input.getString(0, "END_DATE"));
		String SUBINV_CODE = nullToBlank(ds_input.getString(0, "SUBINV_CODE"));
		String ITEM_CODE   = nullToBlank(ds_input.getString(0, "ITEM_CODE"));
		String CUSTCD      = nullToBlank(ds_input.getString(0, "CUSTCD"));
		String CHK_01      = nullToBlank(ds_input.getString(0, "CHK_01"));
		String CHK_09      = nullToBlank(ds_input.getString(0, "CHK_09"));

		String ONHAND_YM   = "";

		int i;
		int j;

		StringBuffer sbSql = new StringBuffer();
		
		sbSql.delete(0, sbSql.length());
		sbSql.append("/* 창고 월마감 조회 */ \n");
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
		sbSql.append("/* 기간별 입출고내역 조회 */ \n");

		// [1] 구매단위 표시 체크시
		if( CHK_01.equals("1") )
		{
			// [9] 이관인수별도표시
			if( CHK_09.equals("1") )
			{
				sbSql.append("SELECT A.ITEM_CODE AS ITEM_CODE \n");
				sbSql.append("     , A.ITEM_NAME AS ITEM_NAME \n");
				sbSql.append("     , A.PO_UOM AS PO_UOM \n");
				sbSql.append("     , A.ITEM_SIZE AS ITEM_SIZE \n");
				sbSql.append("     , DECODE(A.TAX_CODE, '100', '과세', '210', '면세', '영세') AS TAX_NAME \n");
				sbSql.append("     , SUM(B.TRANS_QTY / A.UOM_CONVERT_RATE) AS PRE_QTY \n");
				sbSql.append("     , ROUND(SUM(B.TRANS_AMT)) AS PRE_AMT \n");

				j=1;
				// 시작일부터 시작하여서 하루씩 증가시킨다.[달이 교차되는 건 허용하지 않음-20070228--20080301은 입력되진않는다.]
				for( i = Integer.parseInt(START_DATE); i <= Integer.parseInt(END_DATE); i++ )
				{
					sbSql.append("     , ROUND(SUM(DECODE(B.TRANS_DATE, '" + changeDateFormat(Integer.toString(i)) + "', B.IN_AMT, 0))) AS IN_AMT" + Integer.toString(j-1) +" \n");
					sbSql.append("     , SUM(DECODE(B.TRANS_DATE, '" + changeDateFormat(Integer.toString(i)) + "', B.IN_QTY / A.UOM_CONVERT_RATE, 0)) AS IN_QTY" + Integer.toString(j-1) + " \n");
					sbSql.append("     , ROUND(SUM(DECODE(B.TRANS_DATE, '" + changeDateFormat(Integer.toString(i)) + "', B.PO_AMT, 0))) AS PO_AMT" + Integer.toString(j-1) +" \n");
					sbSql.append("     , SUM(DECODE(B.TRANS_DATE, '" + changeDateFormat(Integer.toString(i)) + "', B.PO_QTY / A.UOM_CONVERT_RATE, 0)) AS PO_QTY"+ Integer.toString(j-1) + " \n");
					sbSql.append("     , ROUND(SUM(DECODE(B.TRANS_DATE, '" + changeDateFormat(Integer.toString(i)) + "', B.OUT_AMT, 0))) AS OUT_AMT" + Integer.toString(j-1) +" \n");
					sbSql.append("     , SUM(DECODE(B.TRANS_DATE, '" + changeDateFormat(Integer.toString(i)) + "', B.OUT_QTY / A.UOM_CONVERT_RATE, 0)) AS OUT_QTY" + Integer.toString(j-1) + " \n");
					sbSql.append("     , ROUND(SUM(DECODE(B.TRANS_DATE, '" + changeDateFormat(Integer.toString(i)) + "', B.INV_AMT, 0))) AS INV_AMT" + Integer.toString(j-1) +" \n");
					sbSql.append("     , SUM(DECODE(B.TRANS_DATE, '" + changeDateFormat(Integer.toString(i)) + "', B.INV_QTY / A.UOM_CONVERT_RATE,0)) AS INV_QTY" + Integer.toString(j-1) + " \n");

					j=j+1;
				}

				sbSql.append("     , ROUND(NVL(SUM(TRANS_AMT), 0) + NVL(SUM(PO_AMT), 0) + NVL(SUM(IN_AMT), 0) - NVL(SUM(INV_AMT), 0) - NVL(SUM(OUT_AMT), 0)) AS LAST_AMT \n");
				sbSql.append("     , NVL(SUM(TRANS_QTY / A.UOM_CONVERT_RATE), 0) + NVL(SUM(PO_QTY / A.UOM_CONVERT_RATE), 0) + NVL(SUM(IN_QTY / A.UOM_CONVERT_RATE), 0) - NVL(SUM(INV_QTY / A.UOM_CONVERT_RATE), 0) - NVL(SUM(OUT_QTY / A.UOM_CONVERT_RATE), 0) AS LAST_QTY \n");
				sbSql.append("  FROM HLDC_PO_ITEM_MST A \n");
				sbSql.append("      , HLDC_PO_ITEM_CLASS_HLDC_V C \n");
				sbSql.append("      , HLDC_PO_ITEM_CLASS_HLDC_V D \n");
				sbSql.append("     , ( SELECT '" + changeDateFormat(START_DATE) + "' AS TRANS_DATE \n");
				sbSql.append("              , ITEM_CODE AS ITEM_CODE \n");
				sbSql.append("              , ONHAND_QTY    AS TRANS_QTY \n");
				sbSql.append("              , MARGIN_AMOUNT AS TRANS_AMT \n");
				sbSql.append("              , 0             AS PO_QTY \n");
				sbSql.append("              , 0             AS PO_AMT \n");
				sbSql.append("              , 0             AS IN_QTY \n");
				sbSql.append("              , 0             AS IN_AMT \n");
				sbSql.append("              , 0             AS INV_QTY \n");
				sbSql.append("              , 0             AS INV_AMT \n");
				sbSql.append("              , 0             AS OUT_QTY \n");
				sbSql.append("              , 0             AS OUT_AMT \n");
				sbSql.append("           FROM HLDC_PO_ONHAND_MONTH \n");
				sbSql.append("          WHERE ONHAND_YM   = '" + ONHAND_YM + "' \n");
				sbSql.append("            AND SUBINV_CODE = '" + SUBINV_CODE + "' \n");
				if( !ITEM_CODE.equals("") )
				{
					sbSql.append("            AND ITEM_CODE = '" + ITEM_CODE + "' \n");
				}
				sbSql.append("          UNION ALL \n");
				sbSql.append("         SELECT '" + changeDateFormat(START_DATE) + "' AS TRANS_DATE \n");
				sbSql.append("              , ITEM_CODE \n");
				sbSql.append("              , SUM(DECODE(SUBSTR(TRANS_TYPE, 1, 1), 'I', 1, -1) * UOM_QTY)       AS TRANS_QTY \n");
				sbSql.append("              , SUM(DECODE(SUBSTR(TRANS_TYPE, 1, 1), 'I', 1, -1) * MARGIN_AMOUNT) AS TRANS_AMT \n");
				sbSql.append("              , 0             AS PO_QTY \n");
				sbSql.append("              , 0             AS PO_AMT \n");
				sbSql.append("              , 0             AS IN_QTY \n");
				sbSql.append("              , 0             AS IN_AMT \n");
				sbSql.append("              , 0             AS INV_QTY \n");
				sbSql.append("              , 0             AS INV_AMT \n");
				sbSql.append("              , 0             AS OUT_QTY \n");
				sbSql.append("              , 0             AS OUT_AMT \n");
				//sbSql.append("           FROM HLDC_PO_TRANSACTION \n");	TUNING POINT
				sbSql.append("           FROM HLDC_PO_TRANSACTION2 \n");
				sbSql.append("          WHERE TRANS_DATE BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE('" + ONHAND_YM + "'||'01', 'YYYYMMDD'), 1), 'YYYYMMDD') AND TO_CHAR(TO_DATE('" + START_DATE + "', 'YYYYMMDD') - 1, 'YYYYMMDD') \n");
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
				sbSql.append("         SELECT TO_CHAR(TO_DATE(TRANS_DATE, 'YYYYMMDD'), 'YYYYMMDD') AS TRANS_DATE \n");
				sbSql.append("              , ITEM_CODE \n");
				sbSql.append("              , 0                  AS TRANS_QTY \n");
				sbSql.append("              , 0                  AS TRANS_AMT \n");
				sbSql.append("              , SUM(UOM_QTY)       AS PO_QTY \n");
				sbSql.append("              , SUM(MARGIN_AMOUNT) AS PO_AMT \n");
				sbSql.append("              , 0                  AS IN_QTY \n");
				sbSql.append("              , 0                  AS IN_AMT \n");
				sbSql.append("              , 0                  AS INV_QTY \n");
				sbSql.append("              , 0                  AS INV_AMT \n");
				sbSql.append("              , 0                  AS OUT_QTY \n");
				sbSql.append("              , 0                  AS OUT_AMT \n");
				//sbSql.append("           FROM HLDC_PO_TRANSACTION \n");	// TUNING POINT
				sbSql.append("           FROM HLDC_PO_TRANSACTION2 \n");
				sbSql.append("          WHERE TRANS_DATE BETWEEN '" + START_DATE + "' AND '" + END_DATE + "' \n");
				sbSql.append("            AND SUBINV_CODE = '" + SUBINV_CODE + "' \n");
				if( !ITEM_CODE.equals("") )
				{
					sbSql.append("            AND ITEM_CODE = '" + ITEM_CODE + "' \n");
				}

				if( !CUSTCD.equals("") )
				{
					sbSql.append("            AND CUSTCD LIKE '" + CUSTCD + "%' \n");
				}
				sbSql.append("            AND TRANS_TYPE LIKE 'I%' \n");
				sbSql.append("            AND TRANS_TYPE <> 'I002' \n");
				sbSql.append("          GROUP BY TRANS_DATE, ITEM_CODE \n");
				sbSql.append("          UNION ALL             \n   ");
				sbSql.append("         SELECT TO_CHAR(TO_DATE(TRANS_DATE, 'YYYYMMDD'), 'YYYYMMDD') AS TRANS_DATE \n");
				sbSql.append("              , ITEM_CODE          AS ITEM_CODE \n");
				sbSql.append("              , 0                  AS TRANS_QTY \n");
				sbSql.append("              , 0                  AS TRANS_AMT \n");
				sbSql.append("              , 0                  AS PO_QTY \n");
				sbSql.append("              , 0                  AS PO_AMT \n");
				sbSql.append("              , 0                  AS IN_QTY \n");
				sbSql.append("              , 0                  AS IN_AMT \n");
				sbSql.append("              , SUM(UOM_QTY)       AS INV_QTY \n");
				sbSql.append("              , SUM(MARGIN_AMOUNT) AS INV_AMT \n");
				sbSql.append("              , 0                  AS OUT_QTY \n");
				sbSql.append("              , 0                  AS OUT_AMT \n");
				//sbSql.append("           FROM  HLDC_PO_TRANSACTION \n");	// TUNING POINT
				sbSql.append("           FROM  HLDC_PO_TRANSACTION2 \n");
				sbSql.append("          WHERE TRANS_DATE BETWEEN '" + START_DATE + "' AND '" + END_DATE + "'\n");
				sbSql.append("            AND SUBINV_CODE = '" + SUBINV_CODE + "' \n");
				if( !ITEM_CODE.equals("") )
				{
					sbSql.append("           AND ITEM_CODE = '" + ITEM_CODE + "' \n ");
				}
				if( !CUSTCD.equals("") )
				{
					sbSql.append("           AND CUSTCD LIKE '" + CUSTCD + "%' \n");
				}
				sbSql.append("            AND TRANS_TYPE LIKE 'O%' \n");
				sbSql.append("            AND TRANS_TYPE <> 'O002' \n");
				sbSql.append("          GROUP BY TRANS_DATE, ITEM_CODE \n");
				sbSql.append("          UNION ALL \n");
				sbSql.append("         SELECT TO_CHAR(TO_DATE(TRANS_DATE, 'YYYYMMDD'), 'YYYYMMDD') AS TRANS_DATE \n");
				sbSql.append("              , ITEM_CODE          AS ITEM_CODE \n");
				sbSql.append("              , 0                  AS TRANS_QTY \n");
				sbSql.append("              , 0                  AS TRANS_AMT \n");
				sbSql.append("              , 0                  AS PO_QTY \n");
				sbSql.append("              , 0                  AS PO_AMT \n");
				sbSql.append("              , SUM(UOM_QTY)       AS IN_QTY \n");
				sbSql.append("              , SUM(MARGIN_AMOUNT) AS IN_AMT \n");
				sbSql.append("              , 0                  AS INV_QTY \n");
				sbSql.append("              , 0                  AS INV_AMT \n");
				sbSql.append("              , 0                  AS OUT_QTY \n");
				sbSql.append("              , 0                  AS OUT_AM \n");
				//sbSql.append("           FROM HLDC_PO_TRANSACTION \n");	// TUNING POINT
				sbSql.append("           FROM HLDC_PO_TRANSACTION2 \n");
				sbSql.append("          WHERE TRANS_DATE BETWEEN '" + START_DATE + "' AND '" + END_DATE + "' \n");
				sbSql.append("            AND SUBINV_CODE = '" + SUBINV_CODE + "' \n");
				if( !ITEM_CODE.equals("") )
				{
					sbSql.append("            AND ITEM_CODE = '" + ITEM_CODE + "' \n");
				}
				if( !CUSTCD.equals("") )
				{
					sbSql.append("            AND CUSTCD LIKE '" + CUSTCD + "%' \n");
				}
				sbSql.append("            AND TRANS_TYPE  = 'I002' \n");
				sbSql.append("          GROUP BY TRANS_DATE, ITEM_CODE \n");
				sbSql.append("          UNION ALL \n");
				sbSql.append("         SELECT TO_CHAR(TO_DATE(TRANS_DATE, 'YYYYMMDD'), 'YYYYMMDD') AS TRANS_DATE \n");
				sbSql.append("              , ITEM_CODE          AS ITEM_CODE \n");
				sbSql.append("              , 0                  AS TRANS_QTY \n");
				sbSql.append("              , 0                  AS TRANS_AMT \n");
				sbSql.append("              , 0                  AS PO_QTY \n");
				sbSql.append("              , 0                  AS PO_AMT \n");
				sbSql.append("              , 0                  AS IN_QTY \n");
				sbSql.append("              , 0                  AS IN_AMT \n");
				sbSql.append("              , 0                  AS INV_QTY \n");
				sbSql.append("              , 0                  AS INV_AMT \n");
				sbSql.append("              , SUM(UOM_QTY)       AS OUT_QTY \n");
				sbSql.append("              , SUM(MARGIN_AMOUNT) AS OUT_AMT \n");
				//sbSql.append("           FROM HLDC_PO_TRANSACTION \n");	// TUNING POINT
				sbSql.append("           FROM HLDC_PO_TRANSACTION2 \n");
				sbSql.append("          WHERE TRANS_DATE BETWEEN '" + START_DATE + "' AND '" + END_DATE + "' \n");
				sbSql.append("            AND SUBINV_CODE = '" + SUBINV_CODE + "' \n");
				if( !ITEM_CODE.equals("") )
				{
					sbSql.append("            AND ITEM_CODE = '" + ITEM_CODE + "' \n");
				}
				if( !CUSTCD.equals("") )
				{
					sbSql.append("            AND CUSTCD LIKE '" + CUSTCD + "%' \n");
				}
				sbSql.append("            AND TRANS_TYPE  = 'O002' \n");
				sbSql.append("          GROUP BY TRANS_DATE, ITEM_CODE \n");
				sbSql.append("       ) B \n");
				sbSql.append("  WHERE A.ITEM_CODE = B.ITEM_CODE \n");
				sbSql.append("    AND C.CLASS_CODE = A.ITEM_CLASS2 \n");
				sbSql.append("    AND C.CLASS_TYPE = 'M' \n");
				sbSql.append("    AND D.CLASS_CODE = A.ITEM_CLASS3 \n");
				sbSql.append("    AND D.CLASS_TYPE = 'S' \n");
				sbSql.append("  GROUP BY A.ITEM_CODE, C.CLASS_CODE, D.CLASS_CODE, A.ITEM_NAME, A.PO_UOM, A.ITEM_SIZE, DECODE(A.TAX_CODE, '100', '과세', '210', '면세', '영세') \n");
				sbSql.append("  ORDER BY D.CLASS_CODE, C.CLASS_CODE, A.ITEM_CODE, A.ITEM_NAME \n");
			}
			// [9] 이관인수별도표시안함
			else
			{
				// 시작일부터 시작하여서 하루씩 증가시킨다.[달이 교차되는 건 허용하지 않음-20070228--20080301은 입력되진않는다.]
				sbSql.append(" SELECT A.ITEM_CODE AS ITEM_CODE \n");
				sbSql.append("      , A.ITEM_NAME AS ITEM_NAME \n");
				sbSql.append("      , A.PO_UOM AS PO_UOM \n");
				sbSql.append("      , A.ITEM_SIZE AS ITEM_SIZE \n");
				sbSql.append("      , DECODE(A.TAX_CODE,'100', '과세', '210', '면세', '영세') AS TAX_NAME \n");
				sbSql.append("      , SUM(B.TRANS_QTY / A.UOM_CONVERT_RATE) AS PRE_QTY \n");
				sbSql.append("      , ROUND(SUM(B.TRANS_AMT)) AS PRE_AMT \n");

	 			j = 1;
                for( i = Integer.parseInt(START_DATE); i <= Integer.parseInt(END_DATE); i++ )
				{
                    sbSql.append("      , ROUND(SUM(DECODE(B.TRANS_DATE, '" + changeDateFormat(Integer.toString(i)) + "', B.PO_AMT, 0))) AS PO_AMT"+ Integer.toString(j - 1) + " \n");
                    sbSql.append("      , SUM(DECODE(B.TRANS_DATE, '" + changeDateFormat(Integer.toString(i)) + "', B.PO_QTY / A.UOM_CONVERT_RATE, 0)) AS PO_QTY" + Integer.toString(j - 1) + " \n");
                    sbSql.append("      , ROUND(SUM(DECODE(B.TRANS_DATE, '" + changeDateFormat(Integer.toString(i)) + "', B.INV_AMT, 0))) AS INV_AMT" + Integer.toString(j - 1) + " \n");
                    sbSql.append("      , SUM(DECODE(B.TRANS_DATE, '" + changeDateFormat(Integer.toString(i)) + "', B.INV_QTY / A.UOM_CONVERT_RATE, 0)) AS INV_QTY" + Integer.toString(j - 1) + " \n");

                    j = j+1;
				}

                sbSql.append("      , ROUND(NVL(SUM(TRANS_AMT), 0) + NVL(SUM(PO_AMT), 0) + NVL(SUM(IN_AMT), 0) - NVL(SUM(INV_AMT), 0) - NVL(SUM(OUT_AMT), 0))   AS LAST_AMT \n");
                sbSql.append("      , NVL(SUM(TRANS_QTY / A.UOM_CONVERT_RATE),0) + NVL(SUM(PO_QTY / A.UOM_CONVERT_RATE),0) + NVL(SUM(IN_QTY / A.UOM_CONVERT_RATE),0) - NVL(SUM(INV_QTY / A.UOM_CONVERT_RATE),0) - NVL(SUM(OUT_QTY / A.UOM_CONVERT_RATE),0) AS LAST_QTY     \n    ");

                sbSql.append("   FROM HLDC_PO_ITEM_MST A \n");
    			sbSql.append("      , HLDC_PO_ITEM_CLASS_HLDC_V C \n");
    			sbSql.append("      , HLDC_PO_ITEM_CLASS_HLDC_V D \n");
                sbSql.append("      ,(SELECT '" + changeDateFormat(START_DATE) + "' AS TRANS_DATE \n");
                sbSql.append("             , ITEM_CODE     AS ITEM_CODE \n");
                sbSql.append("             , ONHAND_QTY    AS TRANS_QTY \n");
                sbSql.append("             , MARGIN_AMOUNT AS TRANS_AMT \n");
                sbSql.append("             , 0             AS PO_QTY \n");
                sbSql.append("             , 0             AS PO_AMT \n");
                sbSql.append("             , 0             AS IN_QTY \n");
                sbSql.append("             , 0             AS IN_AMT \n");
                sbSql.append("             , 0             AS INV_QTY \n");
                sbSql.append("             , 0             AS INV_AMT \n");
                sbSql.append("             , 0             AS OUT_QTY \n");
                sbSql.append("             , 0             AS OUT_AMT \n");
                sbSql.append("          FROM HLDC_PO_ONHAND_MONTH \n");
                sbSql.append("         WHERE ONHAND_YM   = '" + ONHAND_YM + "' \n");
				sbSql.append("           AND SUBINV_CODE = '" + SUBINV_CODE + "' \n");
				
				if( !ITEM_CODE.equals("") )
				{
					sbSql.append("           AND ITEM_CODE = '"+ ITEM_CODE +"' \n");
				}
				sbSql.append("         UNION ALL \n");
                sbSql.append("        SELECT '" + changeDateFormat(START_DATE) + "' AS TRANS_DATE \n");
                sbSql.append("             , ITEM_CODE     AS ITEM_CODE \n");
                sbSql.append("             , SUM(DECODE(SUBSTR(TRANS_TYPE, 1, 1), 'I', 1, -1) * UOM_QTY)       AS TRANS_QTY \n");
                sbSql.append("             , SUM(DECODE(SUBSTR(TRANS_TYPE, 1, 1), 'I', 1, -1) * MARGIN_AMOUNT) AS TRANS_AMT \n");
                sbSql.append("             , 0             AS PO_QTY \n");
                sbSql.append("             , 0             AS PO_AMT \n");
                sbSql.append("             , 0             AS IN_QTY \n");
                sbSql.append("             , 0             AS IN_AMT \n");
                sbSql.append("             , 0             AS INV_QTY \n");
                sbSql.append("             , 0             AS INV_AMT \n");
                sbSql.append("             , 0             AS OUT_QTY \n");
                sbSql.append("             , 0             AS OUT_AMT \n");
                //sbSql.append("          FROM HLDC_PO_TRANSACTION \n");	// TUNING POINT
                sbSql.append("          FROM HLDC_PO_TRANSACTION2 \n");
                sbSql.append("         WHERE TRANS_DATE BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE('" + ONHAND_YM + "' || '01', 'YYYYMMDD'), 1), 'YYYYMMDD') \n"); 
				sbSql.append("                              AND TO_CHAR(TO_DATE('" + START_DATE + "', 'YYYYMMDD') -1, 'YYYYMMDD') \n");
				sbSql.append("           AND SUBINV_CODE = '" + SUBINV_CODE + "' \n");
				if( !ITEM_CODE.equals("") )
				{
					sbSql.append("           AND ITEM_CODE = '" + ITEM_CODE + "' \n");
				}
				if( !CUSTCD.equals("") )
				{
					sbSql.append("           AND CUSTCD LIKE '"+ CUSTCD +"%' \n");
				}
                sbSql.append("         GROUP BY ITEM_CODE \n");
                sbSql.append("         UNION ALL \n");
                sbSql.append("        SELECT TO_CHAR(TO_DATE(TRANS_DATE,'YYYYMMDD'),'YYYYMMDD') AS TRANS_DATE \n");
                sbSql.append("             , ITEM_CODE          AS ITEM_CODE \n");
                sbSql.append("             , 0                  AS TRANS_QTY \n");
                sbSql.append("             , 0                  AS TRANS_AMT \n");
                sbSql.append("             , SUM(UOM_QTY)       AS PO_QTY \n");
                sbSql.append("             , SUM(MARGIN_AMOUNT) AS PO_AMT \n");
                sbSql.append("             , 0                  AS IN_QTY \n");
                sbSql.append("             , 0                  AS IN_AMT \n");
                sbSql.append("             , 0                  AS INV_QTY \n");
                sbSql.append("             , 0                  AS INV_AMT \n");
                sbSql.append("             , 0                  AS OUT_QTY \n");
                sbSql.append("             , 0                  AS OUT_AMT \n");
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
                sbSql.append("           AND TRANS_TYPE LIKE 'I%' \n");
                sbSql.append("         GROUP BY TRANS_DATE, ITEM_CODE \n");
                sbSql.append("         UNION ALL \n");
                sbSql.append("        SELECT TO_CHAR(TO_DATE(TRANS_DATE,'YYYYMMDD'),'YYYYMMDD') AS TRANS_DATE \n");
                sbSql.append("             , ITEM_CODE          AS ITEM_CODE \n");
                sbSql.append("             , 0                  AS TRANS_QTY \n");
                sbSql.append("             , 0                  AS TRANS_AMT \n");
                sbSql.append("             , 0                  AS PO_QTY \n");
                sbSql.append("             , 0                  AS PO_AMT \n");
                sbSql.append("             , 0                  AS IN_QTY \n");
                sbSql.append("             , 0                  AS IN_AMT \n");
                sbSql.append("             , SUM(UOM_QTY)       AS INV_QTY \n");
                sbSql.append("             , SUM(MARGIN_AMOUNT) AS INV_AMT \n");
                sbSql.append("             , 0                  AS OUT_QTY \n");
                sbSql.append("             , 0                  AS OUT_AMT \n");
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
                sbSql.append("         GROUP BY TRANS_DATE, ITEM_CODE \n");
                sbSql.append("       ) B \n");
                sbSql.append("  WHERE A.ITEM_CODE = B.ITEM_CODE \n");
				sbSql.append("    AND C.CLASS_CODE = A.ITEM_CLASS2 \n");
				sbSql.append("    AND C.CLASS_TYPE = 'M' \n");
				sbSql.append("    AND D.CLASS_CODE = A.ITEM_CLASS3 \n");
				sbSql.append("    AND D.CLASS_TYPE = 'S' \n");
                sbSql.append("  GROUP BY A.ITEM_CODE, C.CLASS_CODE, D.CLASS_CODE, A.ITEM_NAME, A.PO_UOM, A.ITEM_SIZE, DECODE(A.TAX_CODE, '100', '과세', '210', '면세', '영세') \n");
                sbSql.append("  ORDER BY C.CLASS_CODE, D.CLASS_CODE, A.ITEM_CODE, A.ITEM_NAME \n");
			}
		}
		// [1]구매단위 언체크시
		else
		{
			// [9] 이관인수별도표시
			if(CHK_09.equals("1"))
			{

				sbSql.append(" SELECT A.ITEM_CODE AS ITEM_CODE \n");
				sbSql.append("      , A.ITEM_NAME AS ITEM_NAME \n");
				sbSql.append("      , A.UOM_CODE AS PO_UOM \n");
				sbSql.append("      , A.ITEM_SIZE AS ITEM_SIZE \n");
				sbSql.append("      , DECODE(A.TAX_CODE, '100', '과세', '210', '면세', '영세') AS TAX_NAME \n");
				sbSql.append("      , SUM(B.TRANS_QTY) AS PRE_QTY \n");
				sbSql.append("      , ROUND(SUM(B.TRANS_AMT)) AS PRE_AMT \n");

				// 시작일부터 시작하여서 하루씩 증가시킨다.[달이 교차되는 건 허용하지 않음-20070228--20080301은 입력되진않는다.]
				j = 1;
				for( i = Integer.parseInt(START_DATE); i <= Integer.parseInt(END_DATE); i++ )
				{
					sbSql.append("      , ROUND(SUM(DECODE(B.TRANS_DATE, '" + changeDateFormat(Integer.toString(i)) + "', B.IN_AMT, 0))) AS IN_AMT" + Integer.toString(j - 1) + " \n");
					sbSql.append("      , SUM(DECODE(B.TRANS_DATE, '" + changeDateFormat(Integer.toString(i)) + "', B.IN_QTY, 0)) AS IN_QTY" + Integer.toString(j - 1) + " \n");
					sbSql.append("      , ROUND(SUM(DECODE(B.TRANS_DATE, '" + changeDateFormat(Integer.toString(i)) + "', B.PO_AMT, 0))) AS PO_AMT" + Integer.toString(j - 1) + " \n");
					sbSql.append("      , SUM(DECODE(B.TRANS_DATE, '" + changeDateFormat(Integer.toString(i)) + "', B.PO_QTY, 0)) AS PO_QTY" + Integer.toString(j - 1) + " \n");
					sbSql.append("      , ROUND(SUM(DECODE(B.TRANS_DATE, '" + changeDateFormat(Integer.toString(i)) + "', B.OUT_AMT, 0))) AS OUT_AMT" + Integer.toString(j - 1) + " \n");
					sbSql.append("      , SUM(DECODE(B.TRANS_DATE, '" + changeDateFormat(Integer.toString(i)) + "', B.OUT_QTY, 0)) AS OUT_QTY" + Integer.toString(j - 1) + " \n");
					sbSql.append("      , ROUND(SUM(DECODE(B.TRANS_DATE, '" + changeDateFormat(Integer.toString(i)) + "', B.INV_AMT, 0))) AS INV_AMT" + Integer.toString(j - 1) + " \n");
					sbSql.append("      , SUM(DECODE(B.TRANS_DATE, '" + changeDateFormat(Integer.toString(i)) + "', B.INV_QTY, 0)) AS INV_QTY" + Integer.toString(j - 1) + " \n");

					j=j+1;
				}

				sbSql.append("      , ROUND(NVL(SUM(TRANS_AMT), 0) + NVL(SUM(PO_AMT), 0) + NVL(SUM(IN_AMT), 0) - NVL(SUM(INV_AMT), 0) - NVL(SUM(OUT_AMT), 0)) AS LAST_AMT \n");
				sbSql.append("      , NVL(SUM(TRANS_QTY), 0) + NVL(SUM(PO_QTY), 0) + NVL(SUM(IN_QTY), 0) - NVL(SUM(INV_QTY), 0) - NVL(SUM(OUT_QTY), 0) AS LAST_QTY \n");
				sbSql.append("   FROM HLDC_PO_ITEM_MST A \n");
				sbSql.append("      , HLDC_PO_ITEM_CLASS_HLDC_V C \n");
				sbSql.append("      , HLDC_PO_ITEM_CLASS_HLDC_V D \n");
				sbSql.append("      ,(SELECT '" + changeDateFormat(START_DATE) + "' AS TRANS_DATE \n");
				sbSql.append("             , ITEM_CODE     AS ITEM_CODE \n");
				sbSql.append("             , ONHAND_QTY    AS TRANS_QTY \n");
				sbSql.append("             , MARGIN_AMOUNT AS TRANS_AMT \n");
				sbSql.append("             , 0             AS PO_QTY \n");
				sbSql.append("             , 0             AS PO_AMT \n");
				sbSql.append("             , 0             AS IN_QTY \n");
				sbSql.append("             , 0             AS IN_AMT \n");
				sbSql.append("             , 0             AS INV_QTY \n");
				sbSql.append("             , 0             AS INV_AMT \n");
				sbSql.append("             , 0             AS OUT_QTY \n");
				sbSql.append("             , 0             AS OUT_AMT \n");
				sbSql.append("          FROM HLDC_PO_ONHAND_MONTH \n");
				sbSql.append("         WHERE ONHAND_YM   = '" + ONHAND_YM + "' \n");
				sbSql.append("           AND SUBINV_CODE = '" + SUBINV_CODE + "' \n");
				if( !ITEM_CODE.equals("") )
				{
					sbSql.append("           AND ITEM_CODE = '" + ITEM_CODE + "' \n");
				}
				sbSql.append("         UNION ALL \n");
				sbSql.append("        SELECT '" + changeDateFormat(START_DATE) + "' AS TRANS_DATE \n");
				sbSql.append("             , ITEM_CODE AS ITEM_CODE \n");
				sbSql.append("             , SUM(DECODE(SUBSTR(TRANS_TYPE, 1, 1), 'I', 1, -1) * UOM_QTY)  AS TRANS_QTY \n");
				sbSql.append("             , SUM(DECODE(SUBSTR(TRANS_TYPE, 1, 1), 'I', 1, -1) * MARGIN_AMOUNT) AS TRANS_AMT \n");
				sbSql.append("             , 0             AS PO_QTY \n");
				sbSql.append("             , 0             AS PO_AMT \n");
				sbSql.append("             , 0             AS IN_QTY \n");
				sbSql.append("             , 0             AS IN_AMT \n");
				sbSql.append("             , 0             AS INV_QTY \n");
				sbSql.append("             , 0             AS INV_AMT \n");
				sbSql.append("             , 0             AS OUT_QTY \n");
				sbSql.append("             , 0             AS OUT_AMT \n");
				//sbSql.append("          FROM HLDC_PO_TRANSACTION \n");	// TUNING POINT
                sbSql.append("          FROM HLDC_PO_TRANSACTION2 \n");
				sbSql.append("         WHERE TRANS_DATE BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE('" + ONHAND_YM + "' || '01', 'YYYYMMDD'), 1), 'YYYYMMDD') \n");
				sbSql.append("                              AND TO_CHAR(TO_DATE('" + START_DATE + "','YYYYMMDD') -1, 'YYYYMMDD') \n");
				sbSql.append("           AND SUBINV_CODE = '" + SUBINV_CODE + "' \n");
				if( !ITEM_CODE.equals("") )
				{
					sbSql.append("           AND ITEM_CODE = '"+ ITEM_CODE +"' \n");
				}
				if( !CUSTCD.equals("") )
				{
					sbSql.append("           AND CUSTCD LIKE '" + CUSTCD + "%' \n");
				}
				sbSql.append("         GROUP BY ITEM_CODE \n");
				sbSql.append("         UNION ALL \n");
				sbSql.append("        SELECT TO_CHAR(TO_DATE(TRANS_DATE, 'YYYYMMDD'), 'YYYYMMDD') AS TRANS_DATE \n");
				sbSql.append("             , ITEM_CODE          AS ITEM_CODE \n");
				sbSql.append("             , 0                  AS TRANS_QTY \n");
				sbSql.append("             , 0                  AS TRANS_AMT \n");
				sbSql.append("             , SUM(UOM_QTY)       AS PO_QTY \n");
				sbSql.append("             , SUM(MARGIN_AMOUNT) AS PO_AMT \n");
				sbSql.append("             , 0                  AS IN_QTY \n");
				sbSql.append("             , 0                  AS IN_AMT \n");
				sbSql.append("             , 0                  AS INV_QTY \n");
				sbSql.append("             , 0                  AS INV_AMT \n");
				sbSql.append("             , 0                  AS OUT_QTY \n");
				sbSql.append("             , 0                  AS OUT_AMT \n");
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
				sbSql.append("           AND TRANS_TYPE LIKE 'I%' \n");
				sbSql.append("           AND TRANS_TYPE <> 'I002' \n");
				sbSql.append("         GROUP BY TRANS_DATE, ITEM_CODE \n");
				sbSql.append("         UNION ALL \n");
				sbSql.append("        SELECT TO_CHAR(TO_DATE(TRANS_DATE,'YYYYMMDD'),'YYYYMMDD') AS TRANS_DATE \n");
				sbSql.append("             , ITEM_CODE          AS ITEM_CODE \n");
				sbSql.append("             , 0                  AS TRANS_QTY \n");
				sbSql.append("             , 0                  AS TRANS_AMT \n");
				sbSql.append("             , 0                  AS PO_QTY \n");
				sbSql.append("             , 0                  AS PO_AMT \n");
				sbSql.append("             , 0                  AS IN_QTY \n");
				sbSql.append("             , 0                  AS IN_AMT \n");
				sbSql.append("             , SUM(UOM_QTY)       AS INV_QTY \n");
				sbSql.append("             , SUM(MARGIN_AMOUNT) AS INV_AMT \n");
				sbSql.append("             , 0                  AS OUT_QTY \n");
				sbSql.append("             , 0                  AS OUT_AMT \n");
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
				sbSql.append("         GROUP BY TRANS_DATE, ITEM_CODE \n");
				sbSql.append("         UNION ALL \n");
				sbSql.append("        SELECT TO_CHAR(TO_DATE(TRANS_DATE, 'YYYYMMDD'), 'YYYYMMDD') AS TRANS_DATE \n");
				sbSql.append("             , ITEM_CODE          AS ITEM_CODE \n");
				sbSql.append("             , 0                  AS TRANS_QTY \n");
				sbSql.append("             , 0                  AS TRANS_AMT \n");
				sbSql.append("             , 0                  AS PO_QTY \n");
				sbSql.append("             , 0                  AS PO_AMT \n");
				sbSql.append("             , SUM(UOM_QTY)       AS IN_QTY \n");
				sbSql.append("             , SUM(MARGIN_AMOUNT) AS IN_AMT \n");
				sbSql.append("             , 0                  AS INV_QTY \n");
				sbSql.append("             , 0                  AS INV_AMT \n");
				sbSql.append("             , 0                  AS OUT_QTY \n");
				sbSql.append("             , 0                  AS OUT_AMT \n");
				//sbSql.append("          FROM HLDC_PO_TRANSACTION \n");	// TUNING POINT
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
				sbSql.append("           AND TRANS_TYPE  = 'I002' \n");
				sbSql.append("         GROUP BY TRANS_DATE, ITEM_CODE \n");
				sbSql.append("         UNION ALL \n");
				sbSql.append("        SELECT TO_CHAR(TO_DATE(TRANS_DATE, 'YYYYMMDD'), 'YYYYMMDD') AS TRANS_DATE \n");
				sbSql.append("             , ITEM_CODE AS ITEM_CODE \n");
				sbSql.append("             , 0                  AS TRANS_QTY \n");
				sbSql.append("             , 0                  AS TRANS_AMT \n");
				sbSql.append("             , 0                  AS PO_QTY \n");
				sbSql.append("             , 0                  AS PO_AMT \n");
				sbSql.append("             , 0                  AS IN_QTY \n");
				sbSql.append("             , 0                  AS IN_AMT \n");
				sbSql.append("             , 0                  AS INV_QTY \n");
				sbSql.append("             , 0                  AS INV_AMT \n");
				sbSql.append("             , SUM(UOM_QTY)       AS OUT_QTY \n");
				sbSql.append("             , SUM(MARGIN_AMOUNT) AS OUT_AMT \n");
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
					sbSql.append("           AND CUSTCD LIKE '"+ CUSTCD +"%' \n");
				}
				sbSql.append("           AND TRANS_TYPE  = 'O002' \n");
				sbSql.append("         GROUP BY TRANS_DATE, ITEM_CODE \n");
				sbSql.append("       ) B \n");
				sbSql.append("  WHERE A.ITEM_CODE = B.ITEM_CODE \n");
				sbSql.append("    AND C.CLASS_CODE = A.ITEM_CLASS2 \n");
				sbSql.append("    AND C.CLASS_TYPE = 'M' \n");
				sbSql.append("    AND D.CLASS_CODE = A.ITEM_CLASS3 \n");
				sbSql.append("    AND D.CLASS_TYPE = 'S' \n");
				sbSql.append("  GROUP BY A.ITEM_CODE, C.CLASS_CODE, D.CLASS_CODE, A.ITEM_NAME, A.UOM_CODE, A.ITEM_SIZE, DECODE(A.TAX_CODE, '100', '과세', '210', '면세', '영세') \n");
				sbSql.append("  ORDER BY C.CLASS_CODE, D.CLASS_CODE, A.ITEM_CODE, A.ITEM_NAME \n");
			}
			// [9] 이관인수별도표시안함
			else
			{
				sbSql.append("SELECT A.ITEM_CODE AS ITEM_CODE \n");
				sbSql.append("     , A.ITEM_NAME AS ITEM_NAME \n");
				sbSql.append("     , A.UOM_CODE AS PO_UOM \n");
				sbSql.append("     , A.ITEM_SIZE AS ITEM_SIZE \n");
				sbSql.append("     , DECODE(A.TAX_CODE, '100', '과세', '210', '면세', '영세') AS TAX_NAME \n");
				sbSql.append("     , SUM(B.TRANS_QTY) AS PRE_QTY \n");
				sbSql.append("     , ROUND(SUM(B.TRANS_AMT)) AS PRE_AMT \n");

				// 시작일부터 시작하여서 하루씩 증가시킨다.[달이 교차되는 건 허용하지 않음-20070228--20080301은 입력되진않는다.]
				j = 1;
				for( i = Integer.parseInt(START_DATE); i <= Integer.parseInt(END_DATE); i++ )
				{
					 sbSql.append("     , ROUND(SUM(DECODE(B.TRANS_DATE, '" + changeDateFormat(Integer.toString(i)) + "', B.PO_AMT, 0))) AS PO_AMT" + Integer.toString(j - 1) + " \n");
					 sbSql.append("     , SUM(DECODE(B.TRANS_DATE, '" + changeDateFormat(Integer.toString(i)) + "', B.PO_QTY, 0)) AS PO_QTY" + Integer.toString(j - 1) + " \n");
					 sbSql.append("     , ROUND(SUM(DECODE(B.TRANS_DATE, '" + changeDateFormat(Integer.toString(i)) + "', B.INV_AMT, 0))) AS INV_AMT" + Integer.toString(j - 1) + " \n");
					 sbSql.append("     , SUM(DECODE(B.TRANS_DATE, '" + changeDateFormat(Integer.toString(i)) + "', B.INV_QTY, 0)) AS INV_QTY" + Integer.toString(j - 1) + " \n");

					j=j+1;
				}
				sbSql.append("     , ROUND(NVL(SUM(TRANS_AMT), 0) + NVL(SUM(PO_AMT), 0) + NVL(SUM(IN_AMT), 0) - NVL(SUM(INV_AMT), 0) - NVL(SUM(OUT_AMT), 0)) AS LAST_AMT \n");
				sbSql.append("     , NVL(SUM(TRANS_QTY), 0) + NVL(SUM(PO_QTY), 0) + NVL(SUM(IN_QTY), 0) - NVL(SUM(INV_QTY), 0) - NVL(SUM(OUT_QTY), 0) AS LAST_QTY \n");
				sbSql.append("  FROM HLDC_PO_ITEM_MST A \n");
				sbSql.append("      , HLDC_PO_ITEM_CLASS_HLDC_V C \n");
				sbSql.append("      , HLDC_PO_ITEM_CLASS_HLDC_V D \n");
				sbSql.append("     , (SELECT '" + changeDateFormat(START_DATE) + "' AS TRANS_DATE \n");
				sbSql.append("             , ITEM_CODE     AS ITEM_CODE \n");
				sbSql.append("             , ONHAND_QTY    AS TRANS_QTY \n");
				sbSql.append("             , MARGIN_AMOUNT AS TRANS_AMT \n");
				sbSql.append("             , 0             AS PO_QTY \n");
				sbSql.append("             , 0             AS PO_AMT \n");
				sbSql.append("             , 0             AS IN_QTY \n");
				sbSql.append("             , 0             AS IN_AMT \n");
				sbSql.append("             , 0             AS INV_QTY \n");
				sbSql.append("             , 0             AS INV_AMT \n");
				sbSql.append("             , 0             AS OUT_QTY \n");
				sbSql.append("             , 0             AS OUT_AMT \n");
				sbSql.append("          FROM HLDC_PO_ONHAND_MONTH \n");
				sbSql.append("         WHERE ONHAND_YM   = '" + ONHAND_YM + "' \n");
				sbSql.append("           AND SUBINV_CODE = '" + SUBINV_CODE + "' \n");
				if( !ITEM_CODE.equals("") )
				{
					sbSql.append("           AND ITEM_CODE = '"+ ITEM_CODE +"' \n");
				}
				sbSql.append("         UNION ALL \n");
				sbSql.append("        SELECT '"+ changeDateFormat(START_DATE) +"' AS TRANS_DATE \n");
				sbSql.append("             , ITEM_CODE     AS ITEM_CODE \n");
				sbSql.append("             , SUM(DECODE(SUBSTR(TRANS_TYPE, 1, 1), 'I', 1, -1) * UOM_QTY)       AS TRANS_QTY \n");
				sbSql.append("             , SUM(DECODE(SUBSTR(TRANS_TYPE, 1, 1), 'I', 1, -1) * MARGIN_AMOUNT) AS TRANS_AMT \n");
				sbSql.append("             , 0             AS PO_QTY \n");
				sbSql.append("             , 0             AS PO_AMT \n");
				sbSql.append("             , 0             AS IN_QTY \n");
				sbSql.append("             , 0             AS IN_AMT \n");
				sbSql.append("             , 0             AS INV_QTY \n");
				sbSql.append("             , 0             AS INV_AMT \n");
				sbSql.append("             , 0             AS OUT_QTY \n");
				sbSql.append("             , 0             AS OUT_AMT \n");
				//sbSql.append("          FROM HLDC_PO_TRANSACTION \n");	// TUNING POINT
                sbSql.append("          FROM HLDC_PO_TRANSACTION2 \n");
				sbSql.append("         WHERE TRANS_DATE BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE('" + ONHAND_YM + "' || '01', 'YYYYMMDD'), 1), 'YYYYMMDD') \n");
				sbSql.append("                              AND TO_CHAR(TO_DATE('" + START_DATE + "', 'YYYYMMDD') -1, 'YYYYMMDD') \n");
				sbSql.append("           AND SUBINV_CODE = '" + SUBINV_CODE + "' \n");
				if(!ITEM_CODE.equals(""))
				{
					sbSql.append("           AND ITEM_CODE = '" + ITEM_CODE + "' \n");
				}
				if(!CUSTCD.equals(""))
				{
					sbSql.append("           AND CUSTCD LIKE '" + CUSTCD + "%' \n");
				}
				sbSql.append("         GROUP BY ITEM_CODE     \n    ");
				sbSql.append("         UNION ALL     \n    ");
				sbSql.append("        SELECT TO_CHAR(TO_DATE(TRANS_DATE, 'YYYYMMDD'), 'YYYYMMDD') AS TRANS_DATE \n");
				sbSql.append("             , ITEM_CODE          AS ITEM_CODE \n");
				sbSql.append("             , 0                  AS TRANS_QTY \n");
				sbSql.append("             , 0                  AS TRANS_AMT \n");
				sbSql.append("             , SUM(UOM_QTY)       AS PO_QTY \n");
				sbSql.append("             , SUM(MARGIN_AMOUNT) AS PO_AMT \n");
				sbSql.append("             , 0                  AS IN_QTY \n");
				sbSql.append("             , 0                  AS IN_AMT \n");
				sbSql.append("             , 0                  AS INV_QTY \n");
				sbSql.append("             , 0                  AS INV_AMT \n");
				sbSql.append("             , 0                  AS OUT_QTY \n");
				sbSql.append("             , 0                  AS OUT_AMT \n");
				//sbSql.append("          FROM HLDC_PO_TRANSACTION \n");	// TUNING POINT
                sbSql.append("          FROM HLDC_PO_TRANSACTION2 \n");
				sbSql.append("         WHERE TRANS_DATE BETWEEN '" + START_DATE + "' AND '" + END_DATE + "' \n");
				sbSql.append("           AND SUBINV_CODE = '" + SUBINV_CODE + "' \n");
				if(!ITEM_CODE.equals(""))
				{
					sbSql.append("           AND ITEM_CODE = '" + ITEM_CODE + "' \n");
				}
				if( !CUSTCD.equals("") )
				{
					sbSql.append("           AND CUSTCD LIKE '" + CUSTCD + "%' \n");
				}
				sbSql.append("           AND TRANS_TYPE LIKE 'I%' \n");
				sbSql.append("         GROUP BY TRANS_DATE, ITEM_CODE \n");
				sbSql.append("         UNION ALL \n");
				sbSql.append("        SELECT TO_CHAR(TO_DATE(TRANS_DATE, 'YYYYMMDD'), 'YYYYMMDD') AS TRANS_DATE \n");
				sbSql.append("             , ITEM_CODE         AS ITEM_CODE \n");         
				sbSql.append("             , 0                  AS TRANS_QTY \n");
				sbSql.append("             , 0                  AS TRANS_AMT \n");
				sbSql.append("             , 0                  AS PO_QTY \n");
				sbSql.append("             , 0                  AS PO_AMT \n");
				sbSql.append("             , 0                  AS IN_QTY \n");
				sbSql.append("             , 0                  AS IN_AMT \n");
				sbSql.append("             , SUM(UOM_QTY)       AS INV_QTY \n");
				sbSql.append("             , SUM(MARGIN_AMOUNT) AS INV_AMT \n");
				sbSql.append("             , 0                  AS OUT_QTY \n");
				sbSql.append("             , 0                  AS OUT_AMT \n");
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
				sbSql.append("         GROUP BY TRANS_DATE, ITEM_CODE \n");
				sbSql.append("      ) B \n");
				sbSql.append(" WHERE A.ITEM_CODE = B.ITEM_CODE \n");
				sbSql.append("    AND C.CLASS_CODE = A.ITEM_CLASS2 \n");
				sbSql.append("    AND C.CLASS_TYPE = 'M' \n");
				sbSql.append("    AND D.CLASS_CODE = A.ITEM_CLASS3 \n");
				sbSql.append("    AND D.CLASS_TYPE = 'S' \n");
				sbSql.append(" GROUP BY A.ITEM_CODE, C.CLASS_CODE, D.CLASS_CODE, A.ITEM_NAME, A.UOM_CODE, A.ITEM_SIZE, DECODE(A.TAX_CODE, '100', '과세', '210', '면세', '영세') \n");
				sbSql.append(" ORDER BY C.CLASS_CODE, D.CLASS_CODE, A.ITEM_CODE, A.ITEM_NAME \n");
			}
		}

		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		DataSet ds_list = this.makeDataSet(rs, "ds_list"); //ds_list

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
		if(rs != null)
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

<%!
public String changeDateFormat(String str)
{
	if( str == null || str.equals("") ) str = "20040401";
	else str = str.substring(0, 4) + str.substring(4, 6) + str.substring(6);

	return str;
}
%>