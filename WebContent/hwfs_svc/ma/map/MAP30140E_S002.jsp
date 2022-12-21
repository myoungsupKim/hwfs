<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="../../sc/main/common.jsp"%>
<%
	try	{
			PlatformRequest platformRequest = this.proc_input(request);
			in_vl = platformRequest.getData().getVariableList();
			in_dl = platformRequest.getData().getDataSetList();

			// jsp log 서비스 시작
			logger.startIndividualLog(in_vl.getString("titLogId"));

			DataSet ds_cond  = in_dl.get("ds_cond");
			String TM_CD     = nullToBlank(ds_cond.getString(0, "TM_CD"));
			String UPJANG_CD = nullToBlank(ds_cond.getString(0, "UPJANG_CD"));
			String FR_MONTH  = nullToBlank(ds_cond.getString(0, "FR_MONTH"));
			String COST_TYPE = nullToBlank(ds_cond.getString(0, "COST_TYPE"));
			String AN_TARGET = nullToBlank(ds_cond.getString(0, "AN_TARGET"));
			String BIZ_CLASS = nullToBlank(ds_cond.getString(0, "BIZ_CLASS"));

			StringBuffer sbSql = new StringBuffer();

			sbSql.delete(0, sbSql.length());
			sbSql.append("SELECT BIZ_CLASS AS CODE \n");
			sbSql.append("     , BIZ_CLASS AS CODE_NAME \n");
			sbSql.append("  FROM MAP_BIZ_LOG_MGMT \n");
			sbSql.append(" WHERE YY = SUBSTR('" + FR_MONTH + "', 0, 4) \n");
			sbSql.append("   AND UPJANG = " + UPJANG_CD + "  \n");
			sbSql.append("   AND ORGIN_YN = 'N' \n");

			pstmt = conn.prepareStatement(sbSql.toString());
			rs = pstmt.executeQuery();

			DataSet ds_bizClass = this.makeDataSet(rs, "ds_bizClass");
			out_dl.add(ds_bizClass);

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