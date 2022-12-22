<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	try
	{
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();

		// jsp log 서비스 시작
		logger.startIndividualLog(in_vl.getString("titLogId"));

		DataSet ds_input     	= in_dl.get("ds_input");

	  	String strUpjang 		= nullToBlank(ds_input.getString(0, "UPJANG"));
		String strSubinvCode	= nullToBlank(ds_input.getString(0, "SUBINV_CODE"));
		String strFromDt		= nullToBlank(ds_input.getString(0, "FROM_DT1"));
	  	String strToDt 			= nullToBlank(ds_input.getString(0, "TO_DT1"));

	  	String ONHAND_YM   = "";

		StringBuffer sbSql = new StringBuffer();

		sbSql.delete(0, sbSql.length());
		sbSql.append("SELECT MAX(A.CLS_YM) AS CLS_YM \n");
		sbSql.append("  FROM HLDC_PO_CLOSING A   \n");
		sbSql.append(" WHERE A.CLS_YM < SUBSTR('" + strFromDt + "', 1, 6) \n");
		sbSql.append("   AND A.SUBINV_CODE = '" + strSubinvCode + "' \n");
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
		sbSql.append("/* 식자재사용패턴조회 - 기간 */ \n");
		sbSql.append("SELECT B.CLASS_CODE AS CLASS_CODE1 -- 대분류\n");
		sbSql.append("     , C.CLASS_CODE AS CLASS_CODE2 -- 대분류 \n");
		sbSql.append("     , B.CLASS_NAME AS CLASS_NAME1 -- 대분류 \n");
		sbSql.append("     , C.CLASS_NAME AS CLASS_NAME2 -- 중분류 \n");
		sbSql.append("     , ROUND(SUM(A.PHYSIC_MAMOUNT1)) AS PHYSIC_MAMOUNT1 -- 기간-1 실사금액 \n");
		sbSql.append("     , ROUND(SUM(A.IN_AMT)) AS IN_AMT  -- 기간 입고금액 \n");
		sbSql.append("     , ROUND(SUM(A.PHYSIC_MAMOUNT1) + SUM(A.IN_AMT) - SUM(A.OUT_AMT)) AS PHYSIC_MAMOUNT2 -- 기간종료일 실사금액 \n");
		sbSql.append("     , ROUND(SUM(A.OUT_AMT)) AS OUT_AMT -- 기간 사용금액 \n");
		sbSql.append("     , 0 AS RATE \n");
		sbSql.append("     , B.CLASS_CODE AS PL_UP_CD \n");
		sbSql.append("     , C.CLASS_CODE AS PL_CD \n");
		sbSql.append("     , '0' AS BL_SHOW \n");
		sbSql.append("     , 2 AS LEVEL_NO \n");
		sbSql.append("     , '+' AS BL_PLUS \n");
		sbSql.append("  FROM ( \n");
		sbSql.append("        --당기기초 \n");
		sbSql.append("        SELECT ITEM_CODE \n");
		sbSql.append("             , MARGIN_AMOUNT AS PHYSIC_MAMOUNT1 \n");
		sbSql.append("             , 0 AS IN_AMT \n");
		sbSql.append("             , 0 AS OUT_AMT \n");
		sbSql.append("          FROM HLDC_PO_ONHAND_MONTH \n");
		sbSql.append("         WHERE ONHAND_YM  = '" + ONHAND_YM + "' \n");
		sbSql.append("           AND SUBINV_CODE = '" + strSubinvCode + "' \n");
		sbSql.append("         UNION ALL \n");
		sbSql.append("        SELECT ITEM_CODE \n");
		sbSql.append("             , SUM(DECODE(SUBSTR(TRANS_TYPE, 1, 1), 'I', 1, -1) * ROUND(MARGIN_AMOUNT)) AS PHYSIC_MAMOUNT1 \n");
		sbSql.append("             , 0 AS IN_AMT \n");
		sbSql.append("             , 0 AS OUT_AMT \n");
		sbSql.append("          FROM HLDC_PO_TRANSACTION \n");
		sbSql.append("         WHERE TRANS_DATE BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE('" + ONHAND_YM + "' || '01', 'YYYYMMDD'), 1), 'YYYYMMDD') \n");
		sbSql.append("                              AND TO_CHAR(TO_DATE('" + strFromDt + "', 'YYYYMMDD') -1, 'YYYYMMDD') \n");
		sbSql.append("           AND SUBINV_CODE = '" + strSubinvCode + "' \n");
		sbSql.append("         GROUP BY ITEM_CODE \n");
		sbSql.append("         UNION ALL \n");
		sbSql.append("        --당기입고 \n");
		sbSql.append("        SELECT ITEM_CODE \n");
		sbSql.append("             , 0 AS PHYSIC_MAMOUNT1 \n");
		sbSql.append("             , SUM(MARGIN_AMOUNT) AS IN_AMT \n");
		sbSql.append("             , 0 AS OUT_AMT \n");
		sbSql.append("          FROM HLDC_PO_TRANSACTION \n");
		sbSql.append("         WHERE TRANS_DATE BETWEEN '" + strFromDt + "' AND '" + strToDt + "' \n");
		sbSql.append("           AND SUBINV_CODE = '" + strSubinvCode + "' \n");
		sbSql.append("           AND TRANS_TYPE LIKE 'I%' \n");
		//인수를 제외할 경우
		//sbSql.append("           AND TRANS_TYPE <> 'I002' \n");
		sbSql.append("         GROUP BY ITEM_CODE \n");
		sbSql.append("        --당기출고 \n");
		sbSql.append("         UNION ALL \n");
		sbSql.append("        SELECT ITEM_CODE \n");
		sbSql.append("             , 0 AS PHYSIC_MAMOUNT1 \n");
		sbSql.append("             , 0 AS IN_AMT \n");
		sbSql.append("             , SUM(ROUND(MARGIN_AMOUNT)) AS OUT_AMT \n");
		sbSql.append("          FROM HLDC_PO_TRANSACTION \n");
		sbSql.append("         WHERE TRANS_DATE BETWEEN '" + strFromDt + "' AND '" + strToDt + "' \n");
		sbSql.append("           AND SUBINV_CODE = '" + strSubinvCode + "' \n");
		sbSql.append("           AND TRANS_TYPE LIKE 'O%' \n");
		//이관을 제외할 경우
		//sbSql.append("           AND TRANS_TYPE <> 'O002' \n");
		sbSql.append("         GROUP BY ITEM_CODE \n");
		sbSql.append("      ) A \n");
		sbSql.append("     , HLDC_PO_ITEM_CLASS_HLDC_V B \n");
		sbSql.append("     , HLDC_PO_ITEM_CLASS_HLDC_V C \n");
	    sbSql.append("     , HLDC_PO_ITEM_MST D               \n");
	    sbSql.append(" WHERE A.ITEM_CODE = D.ITEM_CODE    \n");
	    sbSql.append("   AND D.ITEM_CLASS2 = B.CLASS_CODE \n");
	    sbSql.append("   AND D.ITEM_CLASS3 = C.CLASS_CODE \n");
		sbSql.append(" GROUP BY B.CLASS_CODE, C.CLASS_CODE, B.CLASS_NAME, C.CLASS_NAME \n");
		sbSql.append(" ORDER BY B.CLASS_CODE, C.CLASS_CODE \n");

		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();

		DataSet ds_list = this.makeDataSet(rs, "ds_list");
		DataSet ds_listtemp = this.makeDataSet(rs, "ds_listtemp");

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