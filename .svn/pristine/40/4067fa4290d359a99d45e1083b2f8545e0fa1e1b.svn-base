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

		StringBuffer sbSql = new StringBuffer();

		sbSql.append("/* 시즌 정보 조회 */ \n");
        sbSql.append("SELECT A.SID \n");
        sbSql.append("     , A.STITLE \n");
        sbSql.append("     , A.START_DATE \n");
        sbSql.append("     , A.END_DATE \n");
		sbSql.append("     , A.SDATE \n");
        sbSql.append("     , A.SDATE_DISP \n");
        sbSql.append("     , A.STIME \n");
        sbSql.append("     , A.STIME_DISP \n");
        sbSql.append("     , A.REMARK \n");
        sbSql.append("     , A.USE_YN \n");
        sbSql.append("     , A.UPJANG \n");
        sbSql.append("     , (SELECT B.UPJANGNM \n");
        sbSql.append("          FROM SCO_UPJANG_MST_V B \n");
		sbSql.append("         WHERE A.UPJANG = B.UPJANG \n");
		sbSql.append("           AND B.FICS_YN = 'N') AS UPJANGNM \n");
		sbSql.append("     , A.ATTR01 \n");
		sbSql.append("     , A.ATTR02 \n");
		sbSql.append("     , NVL(A.ATTR03, 0) AS ATTR03 \n");
        sbSql.append("  FROM FSP_PO_SEASON_LIST A \n");
        sbSql.append(" WHERE A.USE_YN = 'Y' \n");
        sbSql.append("ORDER BY A.SID DESC \n");

		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();

		DataSet ds_season = this.makeDataSet(rs, "ds_season");

		out_dl.add(ds_season);
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
			}catch( Exception e ) {}
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