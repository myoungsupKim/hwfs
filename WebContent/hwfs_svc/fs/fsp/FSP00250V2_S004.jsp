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

	    String START_DATE	= nullToBlank(ds_input.getString(0, "START_DATE"));
		String END_DATE		= nullToBlank(ds_input.getString(0, "END_DATE"));
		String TRANS_TYPE	= nullToBlank(ds_input.getString(0, "TRANS_TYPE"));
		String SUBINV_CODE	= nullToBlank(ds_input.getString(0, "SUBINV_CODE"));
		String ITEM_CODE	= nullToBlank(ds_input.getString(0, "ITEM_CODE"));
		String CUSTCD		= nullToBlank(ds_input.getString(0, "CUSTCD"));
		String CHK_01		= nullToBlank(ds_input.getString(0, "CHK_01"));
		String CHK_05		= nullToBlank(ds_input.getString(0, "CHK_05"));
		String CHK_06		= nullToBlank(ds_input.getString(0, "CHK_06"));
		String CHK_08		= nullToBlank(ds_input.getString(0, "CHK_08"));
		String ONHAND_YM	= nullToBlank(in_vl.getString("v_OnhandYm"));

		StringBuffer sbSql = new StringBuffer();

//		sbSql.delete(0, sbSql.length());
//		sbSql.append("/* 창고 월마감 조회 */ \n");
//		sbSql.append("SELECT MAX(A.CLS_YM) AS CLS_YM \n");
//		sbSql.append("  FROM HLDC_PO_CLOSING A \n");
//		sbSql.append(" WHERE A.CLS_YM < SUBSTR('" + START_DATE + "', 1, 6) \n");
//		sbSql.append("   AND A.SUBINV_CODE = '" + SUBINV_CODE + "' \n");
//		sbSql.append("   AND A.CLS_FLAG = 'Y' \n");

//		pstmt = conn.prepareStatement(sbSql.toString());
//		rs = pstmt.executeQuery();
//		rs.next();

//		ONHAND_YM = rs.getString("CLS_YM");


		System.out.println(CHK_01);

		sbSql.delete(0, sbSql.length());
		sbSql.append("/* 월재고현황 */ \n");
		sbSql.append("SELECT A.ITEM_CODE AS ITEM_CODE \n");
		sbSql.append("     , B.ITEM_NAME AS ITEM_NAME \n");
		sbSql.append("     , B.ITEM_SIZE AS ITEM_SIZE \n");
		sbSql.append("     , DECODE(B.TAX_CODE, '100', '과세', '210', '면세', '영세') AS TAX_CODE \n");
		if( CHK_01.equals("1") )
		{
			sbSql.append("     , B.PO_UOM AS UOM_CODE \n");
			sbSql.append("     , (A.ONHAND_QTY/B.UOM_CONVERT_RATE) AS ONHAND_QTY \n");			
		}
		else
		{
			sbSql.append("     , B.UOM_CODE AS UOM_CODE \n");
			sbSql.append("     , A.ONHAND_QTY AS ONHAND_QTY \n");			
		}
		sbSql.append("     , ROUND(A.MARGIN_PRICE) AS MARGIN_PRICE \n");
		sbSql.append("     , ROUND(A.MARGIN_AMOUNT) AS MARGIN_AMOUNT \n");
		sbSql.append("     , TO_CHAR(TO_DATE(A.CREATE_DATE, 'YYYYMMDDHH24:MI:SS'), 'YYYY-MM-DD HH24:MI') AS CREATE_DATE \n");
		sbSql.append("  FROM HLDC_PO_ONHAND_MONTH A \n");
		sbSql.append("     , HLDC_PO_ITEM_MST B \n");
		sbSql.append("     , HLDC_PO_ITEM_CLASS_HLDC_V C \n");
		sbSql.append("     , HLDC_PO_ITEM_CLASS_HLDC_V D \n");
		sbSql.append("     , HLDC_PO_SUBINVENTORY G \n");
		sbSql.append(" WHERE A.ITEM_CODE   = B.ITEM_CODE \n");
		sbSql.append("   AND A.SUBINV_CODE = G.SUBINV_CODE \n");
		sbSql.append("   AND C.CLASS_CODE  = B.ITEM_CLASS2 \n");
		sbSql.append("   AND C.CLASS_TYPE  = 'M' \n");
		sbSql.append("   AND D.CLASS_CODE  = B.ITEM_CLASS3 \n");
		sbSql.append("   AND D.CLASS_TYPE = 'S' \n");
		sbSql.append("   AND A.ONHAND_YM   = '" + ONHAND_YM + "' \n");
		sbSql.append("   AND A.SUBINV_CODE = '" + SUBINV_CODE + "' \n");
		sbSql.append(" ORDER BY C.CLASS_CODE, D.CLASS_CODE, B.ITEM_CODE, B.ITEM_NAME \n");

		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		DataSet ds_list4 = this.makeDataSet(rs, "ds_list4");

		out_dl.add(ds_list4);
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