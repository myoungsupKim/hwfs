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

		DataSet ds_cond     = in_dl.get("ds_cond");
		DataSet ds_list     = in_dl.get("ds_list");
		DataSet ds_saveList = in_dl.get("ds_saveList");

		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		String sSeason      = nullToBlank(in_vl.getString("nCbSeason"));

		StringBuffer sbSql = new StringBuffer();

		for( int i = 0; i < ds_list.getRemovedRowCount(); i++ )
		{
			sbSql.delete(0, sbSql.length());
			sbSql.append("/* 판촉상품 삭제 */ \n");
			sbSql.append("DELETE FROM FSP_PO_SPECIAL_ITEM \n");
			sbSql.append(" WHERE ITEM_CODE = '" + ds_list.getRemovedData(i, "ITEM_CODE").toString() + "' \n");
			sbSql.append("   AND SEASON_NUM = '" + sSeason + "' \n");

			pstmt = conn.prepareStatement(sbSql.toString());
			pstmt.executeUpdate();
		}

		if( pstmt != null )
		{
			pstmt.close();
		}

		for( int i = 0; i < ds_saveList.getRowCount(); i++ )
		{
			sbSql.delete(0, sbSql.length());
			sbSql.append("/* 판촉상품 등록 */ \n");
			sbSql.append("MERGE INTO FSP_PO_SPECIAL_ITEM A \n");
			sbSql.append("USING (SELECT ITEM_CODE \n");
			sbSql.append("            , '" + nullToBlank(ds_saveList.getString(i, "SEASON_NUM")) + "' AS SEASON_NUM \n");
			sbSql.append("            , '" + nullToBlank(ds_saveList.getString(i, "ITEM_NUM")) + "' AS ITEM_NUM \n");
			sbSql.append("            , NVL('" + nullToBlank(ds_saveList.getString(i, "UNIT_PRICE")) + "', 0) AS UNIT_PRICE \n");
			sbSql.append("            , NVL('" + nullToBlank(ds_saveList.getString(i, "SALE_AMT")) + "', 0) AS SALE_PRICE \n");
			sbSql.append("            , " + nullToBlank(ds_saveList.getString(i, "CUSTCD")) + " AS CUSTCD \n");
			sbSql.append("            , NVL('" + nullToBlank(ds_saveList.getString(i, "STOCK_QTY")) + "', 0) AS STOCK_QTY \n");
			sbSql.append("            , NVL('" + nullToBlank(ds_saveList.getString(i, "QTY_DC_STD")) + "', 0) AS QTY_DC_STD \n");
			sbSql.append("            , NVL('" + nullToBlank(ds_saveList.getString(i, "QTY_DC_RATE")) + "', 0) AS QTY_DC_RATE \n");
			sbSql.append("            , NVL('" + nullToBlank(ds_saveList.getString(i, "AMT_DC_STD")) + "', 0) AS AMT_DC_STD \n");
			sbSql.append("            , NVL('" + nullToBlank(ds_saveList.getString(i, "AMT_DC_RATE")) + "', 0) AS AMT_DC_RATE \n");
			sbSql.append("            , '" + nullToBlank(ds_saveList.getString(i, "OPER_ORG_SN")) + "' AS OPER_ORG_SN \n");
			sbSql.append("            , '" + nullToBlank(ds_saveList.getString(i, "VD_SN")) + "' AS VD_SN \n");
			sbSql.append("            , '" + nullToBlank(ds_saveList.getString(i, "CONTRACT_START")) + "' AS CONTRACT_START \n");
			sbSql.append("            , '" + g_EmpNo + "' AS CREATE_BY \n");
			sbSql.append("            , SYSDATE AS CREATE_DATE \n");
			sbSql.append("            , '" + g_EmpNo + "' AS UPDATE_BY \n");
			sbSql.append("            , SYSDATE AS UPDATE_DATE \n");
			sbSql.append("         FROM HLDC_PO_ITEM_MST \n");
			sbSql.append("        WHERE ITEM_CODE = '" + nullToBlank(ds_saveList.getString(i, "ITEM_CODE")) + "') B \n");
			sbSql.append("ON (    A.ITEM_CODE  = B.ITEM_CODE \n");
			sbSql.append("    AND A.SEASON_NUM = B.SEASON_NUM) \n");
			sbSql.append("WHEN MATCHED THEN \n");
			sbSql.append("UPDATE \n");
			sbSql.append("   SET A.ITEM_NUM       = B.ITEM_NUM \n");
			sbSql.append("     , A.SALE_PRICE     = B.SALE_PRICE \n");
			sbSql.append("     , A.CUSTCD         = B.CUSTCD \n");
			sbSql.append("     , A.STOCK_QTY      = B.STOCK_QTY \n");
			sbSql.append("     , A.QTY_DC_STD     = B.QTY_DC_STD \n");
			sbSql.append("     , A.QTY_DC_RATE    = B.QTY_DC_RATE \n");
			sbSql.append("     , A.AMT_DC_STD     = B.AMT_DC_STD \n");
			sbSql.append("     , A.AMT_DC_RATE    = B.AMT_DC_RATE \n");
			sbSql.append("     , A.UPDATE_BY      = B.UPDATE_BY \n");
			sbSql.append("     , A.UPDATE_DATE    = B.UPDATE_DATE \n");
			sbSql.append("WHEN NOT MATCHED THEN \n");
			sbSql.append("INSERT \n");
			sbSql.append("     ( A.ITEM_CODE \n");
			sbSql.append("     , A.ITEM_NUM \n");
			sbSql.append("     , A.UNIT_PRICE \n");
			sbSql.append("     , A.SALE_PRICE \n");
			sbSql.append("     , A.CUSTCD \n");
			sbSql.append("     , A.STOCK_QTY \n");
			sbSql.append("     , A.QTY_DC_STD \n");
			sbSql.append("     , A.QTY_DC_RATE \n");
			sbSql.append("     , A.AMT_DC_STD \n");
			sbSql.append("     , A.AMT_DC_RATE \n");
			sbSql.append("     , A.OPER_ORG_SN \n");
			sbSql.append("     , A.VD_SN \n");
			sbSql.append("     , A.CONTRACT_START \n");
			sbSql.append("     , A.CREATE_BY \n");
			sbSql.append("     , A.CREATE_DATE \n");
			sbSql.append("     , A.UPDATE_BY \n");
			sbSql.append("     , A.UPDATE_DATE \n");
			sbSql.append("     , A.SEASON_NUM ) \n");
			sbSql.append("VALUES \n");
			sbSql.append("     ( B.ITEM_CODE \n");
			sbSql.append("     , B.ITEM_NUM \n");
			sbSql.append("     , B.UNIT_PRICE \n");
			sbSql.append("     , B.SALE_PRICE \n");
			sbSql.append("     , B.CUSTCD \n");
			sbSql.append("     , B.STOCK_QTY \n");
			sbSql.append("     , B.QTY_DC_STD \n");
			sbSql.append("     , B.QTY_DC_RATE \n");
			sbSql.append("     , B.AMT_DC_STD \n");
			sbSql.append("     , B.AMT_DC_RATE \n");
			sbSql.append("     , B.OPER_ORG_SN \n");
			sbSql.append("     , B.VD_SN \n");
			sbSql.append("     , B.CONTRACT_START \n");
			sbSql.append("     , B.CREATE_BY \n");
			sbSql.append("     , B.CREATE_DATE \n");
			sbSql.append("     , B.UPDATE_BY \n");
			sbSql.append("     , B.UPDATE_DATE \n");
			sbSql.append("     , B.SEASON_NUM ) \n");

			pstmt = conn.prepareStatement(sbSql.toString());
			pstmt.executeUpdate();
		}

		conn.commit();
		this.setResultMessage(0, "OK", out_vl);
	}
	catch( Exception ex )
	{
		conn.rollback();

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