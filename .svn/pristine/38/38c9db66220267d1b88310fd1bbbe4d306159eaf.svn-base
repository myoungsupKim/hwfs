
<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	try	{
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();

		//jsp log 서비스 시작
		logger.startIndividualLog(in_vl.getString("titLogId"));

		DataSet ds_search = in_dl.get("ds_search");

		String MU_CD		= nullToBlank(ds_search.getString(0, "MU_CD"));
		String TM_CD		= nullToBlank(ds_search.getString(0, "TM_CD"));
		String UPJANG_CODE	= nullToBlank(ds_search.getString(0, "UPJANG_CODE"));
		String UPJANG_NAME	= nullToBlank(ds_search.getString(0, "UPJANG_NAME"));
		String CLOSE_YN		= nullToBlank(ds_search.getString(0, "CLOSE_YN"));
		String OLD_DEPT_YN	= nullToBlank(ds_search.getString(0, "OLD_DEPT_YN"));

		StringBuffer sbSql = new StringBuffer();

		sbSql.delete(0, sbSql.length());
		sbSql.append("/* 사업장 조회 */ \n");
		sbSql.append("SELECT 0 AS CHK \n");
		sbSql.append("     , TO_CHAR(A.UPJANG) AS UPJANG_CODE \n");
		sbSql.append("     , A.UPJANGNM AS UPJANG_NAME \n");
		sbSql.append("     , A.UPJANG \n");
		sbSql.append("     , A.UPJANGNM \n");
		sbSql.append("     , A.CC_CD \n");
		sbSql.append("     , A.CC_NM \n");
		sbSql.append("     , A.TM_CD \n");
		sbSql.append("     , A.TM_NM \n");
		sbSql.append("     , A.MU_CD \n");
		sbSql.append("     , A.MU_NM \n");
		sbSql.append("     , NVL(A.CUSTCD, 0) AS CUSTCD \n");
		sbSql.append("     , A.CUSTNM \n");
		sbSql.append("     , A.SAP_CUST_CD \n");
		sbSql.append("     , A.JONGSAUPNO \n");
		sbSql.append("  FROM SCO_UPJANG_MST_V A \n");
		sbSql.append(" WHERE 1=1 \n");
		if( !UPJANG_CODE.equals(""))
			sbSql.append("   AND A.UPJANG LIKE '%' || '" + UPJANG_CODE + "' || '%' \n");
		if( !UPJANG_NAME.equals(""))
			sbSql.append("   AND A.UPJANGNM LIKE '%' || '" + UPJANG_NAME + "' || '%' \n");
		if( CLOSE_YN.equals("Y") )
			sbSql.append("   AND CASE WHEN A.CLOSE_DATE IS NULL THEN 'N' ELSE CASE WHEN A.CLOSE_DATE = '99991231' THEN 'N' ELSE 'Y' END END = 'N' \n");
		if( OLD_DEPT_YN.equals("Y") )
			sbSql.append("   AND A.CC_CD IN (SELECT CC_CD FROM SCC_CC WHERE ORG_LEVEL_CD10 NOT LIKE '%Z') \n");
		if( !MU_CD.equals("") )
			sbSql.append("   AND A.MU_CD = '" + MU_CD + "' \n");
		if( !TM_CD.equals("") )
			sbSql.append("   AND (A.TM_CD = '" + TM_CD + "' OR A.PT_CD = '" + TM_CD + "') \n");

		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		DataSet ds_list1 = this.makeDataSet(rs, "ds_list");

		out_dl.add(ds_list1);
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