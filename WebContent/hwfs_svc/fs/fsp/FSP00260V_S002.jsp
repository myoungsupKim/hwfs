
<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	try	{
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();

		//jsp log 서비스 시작
		logger.startIndividualLog(in_vl.getString("titLogId"));

		DataSet ds_input = in_dl.get("ds_input");

		String UPJANG      = nullToBlank(ds_input.getString(0, "UPJANG"));
		String CUSTCD      =  nullToBlank(ds_input.getString(0, "CUSTCD"));
		String START_DATE  = nullToBlank(ds_input.getString(0, "START_DATE"));
		String END_DATE    = nullToBlank(ds_input.getString(0, "END_DATE"));
		String ITEM_CODE   = nullToBlank(ds_input.getString(0, "ITEM_CODE"));
		String SUBINV_CODE = nullToBlank(ds_input.getString(0, "SUBINV_CODE"));

		StringBuffer sbSql = new StringBuffer();

		sbSql.delete(0, sbSql.length());
		sbSql.append("/* 업체별 집계 상세 */ \n");
		sbSql.append("SELECT A.NEED_DATE \n");
		sbSql.append("     , MAX((SELECT C.SUBINV_NAME FROM HLDC_PO_SUBINVENTORY C WHERE A.SUBINV_CODE = C.SUBINV_CODE)) AS SUBINV_NAME \n");
		sbSql.append("     , ITEM_CODE \n");
		sbSql.append("     , ITEM_NAME \n");
		sbSql.append("     , ITEM_SIZE \n");
		sbSql.append("     , PO_UOM \n");
		sbSql.append("     , TAX \n");
		sbSql.append("     , MARGIN_PRICE AS MARGIN_PRICE \n");
		sbSql.append("     , SUM(PO_QTY) AS SUM_PO_QTY \n");
		sbSql.append("     , ROUND(SUM(PO_AMT)) AS SUM_PO_AMT \n");
		sbSql.append("     , SUM(CENTER_IN_QTY) AS SUM_CENTER_IN_QTY \n");
		sbSql.append("     , ROUND(SUM(CENTER_IN_AMT)) AS SUM_CENTER_IN_AMT \n");
		sbSql.append("     , SUM(CENTER_OUT_QTY)AS SUM_CENTER_OUT_QTY \n");
		sbSql.append("     , ROUND(SUM(CENTER_OUT_AMT)) AS SUM_CENTER_OUT_AMT \n");
		sbSql.append("     , SUM(DELIVERED_QTY) AS SUM_DELIVERED_QTY \n");
		sbSql.append("     , ROUND(SUM(DELIVERED_AMT)) AS SUM_DELIVERED_AMT \n");
		sbSql.append("     , SUM(NODELIVERED_QTY) AS  SUM_NODELIVERED_QTY \n");
		sbSql.append("     , ROUND(SUM(NODELIVERED_AMT)) AS SUM_NODELIVERED_AMT \n");
		sbSql.append("     , SUM(UNDELIVERED_QTY) AS SUM_UNDELIVERED_QTY \n");
		sbSql.append("     , ROUND(SUM(UNDELIVERED_AMT)) AS SUM_UNDELIVERED_AMT \n");
		sbSql.append("     , SUM(RETURNED_QTY) AS SUM_RETURNED_QTY \n");
		sbSql.append("     , ROUND(SUM(RETURNED_AMT)) AS SUM_RETURNED_AMT \n");
		sbSql.append("     , SUM(DELIVERED_QTY)-SUM(RETURNED_QTY) AS TOT_QTY \n");
		sbSql.append("     , ROUND(SUM(DELIVERED_AMT)-SUM(RETURNED_AMT)) AS TOT_AMT \n");
		sbSql.append("  FROM ( \n");
		sbSql.append("        SELECT NEED_DATE \n");
		sbSql.append("             , PO_TYPE \n");
		sbSql.append("             , RC_UPJANG \n");
		sbSql.append("             , SUBINV_CODE \n");
		sbSql.append("             , CUSTCD \n");
		sbSql.append("             , ITEM_CODE \n");
		sbSql.append("             , ITEM_NAME \n");
		sbSql.append("             , ITEM_SIZE \n");
		sbSql.append("             , PO_UOM  \n");
		sbSql.append("             , DECODE(A.TAX_CODE, '100', '과세', '210', '면세', '220', '영세') AS TAX \n");
		sbSql.append("             , A.MARGIN_PRICE \n");
		sbSql.append("             , (A.PO_QTY) AS PO_QTY \n");
		sbSql.append("             , (A.PO_QTY * A.MARGIN_PRICE) AS PO_AMT \n");
		sbSql.append("             , (A.CENTER_DELI_QTY + A.CENTER_UNDELI_QTY) AS CENTER_IN_QTY \n");
		sbSql.append("             , ((A.CENTER_DELI_QTY + A.CENTER_UNDELI_QTY) * A.MARGIN_PRICE) AS CENTER_IN_AMT \n");
		sbSql.append("             , (A.CENTER_DELI_QTY) AS CENTER_OUT_QTY \n");
		sbSql.append("             , (A.CENTER_DELI_QTY * A.MARGIN_PRICE) AS CENTER_OUT_AMT \n");
		sbSql.append("             , 0 AS DELIVERED_QTY \n");
		sbSql.append("             , 0 AS DELIVERED_AMT \n");
		sbSql.append("             , (A.CENTER_DELI_QTY+DIRECT_DELI_QTY-A.DELIVERED_QTY) AS NODELIVERED_QTY \n");
		sbSql.append("             , ((A.CENTER_DELI_QTY+DIRECT_DELI_QTY-A.DELIVERED_QTY)*A.MARGIN_PRICE) AS NODELIVERED_AMT \n");
		sbSql.append("             , (A.UNDELIVERED_QTY) AS UNDELIVERED_QTY \n");
		sbSql.append("             , (A.UNDELIVERED_QTY*A.MARGIN_PRICE) AS UNDELIVERED_AMT \n");
		sbSql.append("             , A.RETURNED_QTY AS RETURNED_QTY \n");
		sbSql.append("             , (A.RETURNED_QTY*A.MARGIN_PRICE) AS RETURNED_AMT \n");
		sbSql.append("          FROM HLDC_PO_PO A \n");
		sbSql.append("         WHERE LINE_STATUS IN('DL', 'GC', 'IV') \n");
		sbSql.append("           AND NEED_DATE BETWEEN '" + START_DATE + "' AND '" + END_DATE + "' \n");
		sbSql.append("           AND A.CUSTCD  = '" + CUSTCD + "' \n");
		sbSql.append("           AND A.RC_UPJANG = '" + UPJANG + "' \n");
		if(!SUBINV_CODE.equals(""))
		{
			sbSql.append("           AND    A.SUBINV_CODE = '" + SUBINV_CODE + "' \n");
		}
		sbSql.append("         UNION ALL \n");
		sbSql.append("        SELECT TRANS_DATE \n");
		sbSql.append("             , PO_TYPE \n");
		sbSql.append("             , TRANS_UPJANG \n");
		sbSql.append("             , SUBINV_CODE \n");
		sbSql.append("             , CUSTCD \n");
		sbSql.append("             , ITEM_CODE \n");
		sbSql.append("             , ITEM_NAME \n");
		sbSql.append("             , ITEM_SIZE \n");
		sbSql.append("             , TRANS_UOM \n");
		sbSql.append("             , DECODE(TAX_CODE, '100', '과세', '210', '면세', '220', '영세') AS TAX \n");
		sbSql.append("             , TRANS_MPRICE \n");
		sbSql.append("             , 0 \n");
		sbSql.append("             , 0 \n");
		sbSql.append("             , 0 \n");
		sbSql.append("             , 0 \n");
		sbSql.append("             , 0 \n");
		sbSql.append("             , 0 \n");
		sbSql.append("             , (DECODE(SIGN(TRANS_QTY), -1, 0, ABS(TRANS_QTY))) \n");
		sbSql.append("             , (DECODE(SIGN(TRANS_MAMOUNT), -1, 0, ABS(TRANS_MAMOUNT))) \n");
		sbSql.append("             , 0 \n");
		sbSql.append("             , 0 \n");
		sbSql.append("             , 0 \n");
		sbSql.append("             , 0 \n");
		sbSql.append("             , 0 \n");
		sbSql.append("             , 0 \n");
		sbSql.append("          FROM HLDC_PO_TRANSACTION A \n");
		sbSql.append("         WHERE A.TRANS_DATE BETWEEN '" + START_DATE + "' AND '" + END_DATE + "' \n");
		sbSql.append("           AND A.CUSTCD  = '"+ CUSTCD +"' \n");
		sbSql.append("           AND A.TRANS_TYPE BETWEEN 'I001' AND 'I002' \n");
		sbSql.append("           AND A.SOURCE_TYPE = 'PO' \n");
		sbSql.append("           AND A.TRANS_UPJANG = '" + UPJANG + "' \n");
		if( !SUBINV_CODE.equals("") )
		{
			sbSql.append( "           AND A.SUBINV_CODE = '" + SUBINV_CODE + "' \n");
		}
		sbSql.append("       ) A \n");
		sbSql.append(" GROUP BY NEED_DATE, ITEM_CODE, ITEM_NAME, ITEM_SIZE, PO_UOM, TAX, MARGIN_PRICE \n");

		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		DataSet ds_list2 = this.makeDataSet(rs, "ds_list");

		out_dl.add(ds_list2);
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