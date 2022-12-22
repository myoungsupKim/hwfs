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

		String s_SeasonNum 	= nullToBlank(ds_cond.getString(0,"SEASON_NUM"));
		String s_ItemCode 	= nullToBlank(ds_cond.getString(0,"ITEM_CODE"));

		StringBuffer sbSql = new StringBuffer();

		sbSql.append("/* 시즌별 상품의 재고량 조회 */ \n");
        sbSql.append("SELECT A.SEASON_NUM AS SEASON_NUM \n");
        sbSql.append("     , A.ITEM_CODE AS ITEM_CODE \n");
        sbSql.append("     , A.STOCK_QTY_ITEM AS STOCK_QTY_ITEM \n");
        sbSql.append("     , NVL(B.STOCK_QTY_TRANS, 0) STOCK_QTY_TRANS \n");
        sbSql.append("     , A.STOCK_QTY_ITEM - NVL(B.STOCK_QTY_TRANS, 0) AS STOCK_QTY \n");
        sbSql.append("  FROM (SELECT SEASON_NUM AS SEASON_NUM \n");
        sbSql.append("             , ITEM_CODE AS ITEM_CODE \n");
        sbSql.append("             , SUM(STOCK_QTY) AS STOCK_QTY_ITEM \n");
        sbSql.append("          FROM FSP_PO_SPECIAL_ITEM \n");
        sbSql.append("         GROUP BY SEASON_NUM, ITEM_CODE) A \n");
        sbSql.append("     , (SELECT A.SEASON_NUM AS SEASON_NUM \n");
        sbSql.append("             , A.ITEM_CODE AS ITEM_CODE \n");
        sbSql.append("             , SUM(A.PR_QTY) AS STOCK_QTY_TRANS \n");
        sbSql.append("          FROM FSP_PO_SPECIAL_SALE A \n");
        sbSql.append("         WHERE A.SEASON_NUM = '" + s_SeasonNum + "' \n");
        sbSql.append("           AND A.SP_TYPE = 'ING' \n");
        sbSql.append("           AND A.LINE_STATUS <> '취소' \n");
        sbSql.append("         GROUP BY A.SEASON_NUM, A.ITEM_CODE) B \n");
        sbSql.append(" WHERE A.SEASON_NUM = B.SEASON_NUM(+) \n");
        sbSql.append("   AND A.ITEM_CODE = B.ITEM_CODE(+) \n");
        sbSql.append("   AND A.SEASON_NUM = '" + s_SeasonNum + "' \n");
        sbSql.append("   AND A.ITEM_CODE = '" + s_ItemCode + "' \n");

		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();

		DataSet ds_list = this.makeDataSet(rs, "ds_list");

		out_dl.add(ds_list);
		this.setResultMessage(0, "OK", out_vl);
	}
	catch(Exception ex)
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