
<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	try	{
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();

		//jsp log 서비스 시작
		logger.startIndividualLog(in_vl.getString("titLogId"));

		String g_EmpNo      = in_vl.getString("g_EmpNo");
		String gcAuthType = in_vl.getString("gcAuthType");

		StringBuffer sbSql = new StringBuffer();

		sbSql.delete(0, sbSql.length());
		sbSql.append("/* 자재 대분류 조회 */ \n");
        sbSql.append("SELECT CLASS_CODE AS CLASS_CODE \n");
        sbSql.append("     , CLASS_NAME AS CLASS_NAME \n");
        sbSql.append("  FROM HLDC_PO_ITEM_CLASS_HLDC_V \n");
        sbSql.append(" WHERE CLASS_TYPE = 'L' \n");
        sbSql.append("   AND CLASS_CODE IN ('F', 'M', 'G') \n");
        sbSql.append("   AND USE_YN = 'Y' \n");
        sbSql.append("ORDER BY CLASS_CODE \n");

		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		DataSet ds_item_class = this.makeDataSet(rs, "ds_item_class");

		out_dl.add(ds_item_class);
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