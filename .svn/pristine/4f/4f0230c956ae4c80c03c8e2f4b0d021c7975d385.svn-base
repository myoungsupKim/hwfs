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

		DataSet ds_stock = in_dl.get("ds_stock");

		String g_EmpNo = nullToBlank(in_vl.getString("g_EmpNo"));

		StringBuffer sbInsSql = new StringBuffer();

		for( int i = 0; i < ds_stock.getRowCount(); i++ )
		{
			sbInsSql.delete(0, sbInsSql.length());
			sbInsSql.append("/* 적정재고내역 조회 */ \n");
			sbInsSql.append("MERGE INTO FSP_PHYSICAL_INVENTORY_OPTIMUM A \n");
			sbInsSql.append("USING (SELECT '" + nullToBlank(ds_stock.getString(i, "UPJANG")) + "' AS UPJANG \n");
			sbInsSql.append("            , '" + nullToBlank(ds_stock.getString(i, "SUBINV_CODE")) + "' AS SUBINV_CODE \n");
			sbInsSql.append("            , '" + nullToBlank(ds_stock.getString(i, "ITEM_CODE")) + "' AS ITEM_CODE \n");
			sbInsSql.append("            , '" + nullToBlank(ds_stock.getString(i, "OPTIMUM_DAY")) + "' AS OPTIMUM_DAY \n");
			sbInsSql.append("         FROM DUAL) B \n");
			sbInsSql.append("ON (    A.UPJANG = B.UPJANG \n");
			sbInsSql.append("    AND A.SUBINV_CODE = B.SUBINV_CODE \n");
			sbInsSql.append("    AND A.ITEM_CODE = B.ITEM_CODE ) \n");
			sbInsSql.append("WHEN MATCHED THEN \n");
			sbInsSql.append("UPDATE \n");
			sbInsSql.append("   SET A.OPTIMUM_DAY = B.OPTIMUM_DAY \n");
			sbInsSql.append("     , A.UPDATE_DATE = SYSDATE \n");
			sbInsSql.append("     , A.UPDATE_BY = '" + g_EmpNo + "' \n");
			sbInsSql.append("WHEN NOT MATCHED THEN \n");
			sbInsSql.append("INSERT \n");
			sbInsSql.append("( \n");
			sbInsSql.append("   A.UPJANG \n");
			sbInsSql.append(" , A.SUBINV_CODE \n");
			sbInsSql.append(" , A.ITEM_CODE \n");
			sbInsSql.append(" , A.OPTIMUM_DAY \n");
			sbInsSql.append(" , A.CREATE_DATE \n");
			sbInsSql.append(" , A.CREATE_BY \n");
			sbInsSql.append(" , A.UPDATE_DATE \n");
			sbInsSql.append(" , A.UPDATE_BY \n");
			sbInsSql.append(") \n");
			sbInsSql.append("VALUES \n");
			sbInsSql.append("( \n");
			sbInsSql.append("   B.UPJANG \n");
			sbInsSql.append(" , B.SUBINV_CODE \n");
			sbInsSql.append(" , B.ITEM_CODE \n");
			sbInsSql.append(" , B.OPTIMUM_DAY \n");
			sbInsSql.append(" , SYSDATE \n");
			sbInsSql.append(" , '" + g_EmpNo + "' \n");
			sbInsSql.append(" , SYSDATE \n");
			sbInsSql.append(" , '" + g_EmpNo + "' \n");
			sbInsSql.append(") \n");

			pstmt = conn.prepareStatement(sbInsSql.toString());
			pstmt.executeUpdate();
		}

		conn.commit();
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