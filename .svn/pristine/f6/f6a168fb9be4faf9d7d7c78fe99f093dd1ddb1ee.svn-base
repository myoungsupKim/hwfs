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
		
		DataSet ds_input = in_dl.get("ds_input");

	    String START_DATE  = nullToBlank(ds_input.getString(0, "START_DATE"));
		String END_DATE    = nullToBlank(ds_input.getString(0, "END_DATE"));
		String SUBINV_CODE = nullToBlank(ds_input.getString(0, "SUBINV_CODE"));
		
		String CLOSE_MM = START_DATE.substring(0, 6);

		StringBuffer sbSql = new StringBuffer();

		sbSql.delete(0, sbSql.length());
		sbSql.append("/* 마감여부 조회 */ \n");
		sbSql.append("SELECT BUY_CLOSE_YN AS CLOSE_YN  \n");
		sbSql.append("  FROM EPROCUSR.ESICLSE \n");
		sbSql.append("WHERE SYS_ID='100' \n");
		sbSql.append("   AND COMP_CD = 'HFC' \n");
		sbSql.append("   AND WH_CD = '" + SUBINV_CODE + "'    \n");  //SUBINV_CODE
		sbSql.append("   AND CLOSE_YM LIKE '" + CLOSE_MM + "%' \n");  //START_DATE

		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		DataSet ds_output = this.makeDataSet(rs, "ds_output");

		out_dl.add(ds_output);
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