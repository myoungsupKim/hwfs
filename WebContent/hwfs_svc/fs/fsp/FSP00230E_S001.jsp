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

		String v_SubinvCode	= in_vl.getString("v_SubinvCode");

		StringBuffer sbSelSql = new StringBuffer();

		sbSelSql.delete(0, sbSelSql.length());
		sbSelSql.append("SELECT A.PHYSICAL_FLAG \n");
		sbSelSql.append("     , A.LOSS_IN_TYPE \n");
		sbSelSql.append("  FROM HLDC_PO_SUBINVENTORY A \n");
		sbSelSql.append(" WHERE A.SUBINV_CODE = '" + v_SubinvCode + "' \n");

		pstmt = conn.prepareStatement(sbSelSql.toString());
		rs = pstmt.executeQuery();

		DataSet ds_type = this.makeDataSet(rs,"ds_type");
		out_dl.add(ds_type);

	   	this.setResultMessage(0, "OK",out_vl);
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