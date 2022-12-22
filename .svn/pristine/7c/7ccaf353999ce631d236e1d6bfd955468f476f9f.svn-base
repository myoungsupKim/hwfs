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

		StringBuffer sbSql = new StringBuffer();

		sbSql.delete(0, sbSql.length());
		sbSql.append("/* 입출고 유형 조회 */ \n");
		sbSql.append("SELECT '%%' AS TRANS_TYPE \n");
		sbSql.append("     , '전체;전체' AS TRANS_NAME \n");
		sbSql.append("  FROM DUAL \n");
		sbSql.append(" UNION ALL \n");
		sbSql.append("SELECT 'I%' AS TRANS_TYPE \n");
		sbSql.append("     , '입고전체;입고' AS TRANS_NAME \n");
		sbSql.append("  FROM DUAL \n");
		sbSql.append(" UNION ALL \n");
		sbSql.append("SELECT 'O%'AS TRANS_TYPE \n");
		sbSql.append("     , '출고전체;출고'AS TRANS_NAME \n");
		sbSql.append("  FROM DUAL \n");
		sbSql.append(" UNION ALL \n");
		sbSql.append("SELECT A.CODE AS TRANS_TYPE \n");
		sbSql.append("     , A.CODE_NAME || ';' || DECODE(SUBSTR(A.CODE, 0, 1), 'I', '입고', '출고') AS TRANS_NAME \n");
		sbSql.append("  FROM SCC_COMMON_CODE A \n");
		sbSql.append(" WHERE A.GROUP_CODE = 'FS0131' \n");
		sbSql.append("   AND A.USE_YN = 'Y' \n");

		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		DataSet ds_trans = this.makeDataSet(rs, "ds_trans");

		out_dl.add(ds_trans);
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