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

		DataSet ds_in	= in_dl.get("ds_list");
		String g_EmpNo	= nullToBlank(in_vl.getString("g_EmpNo"));
		String sType	= nullToBlank(in_vl.getString("sType"));

		StringBuffer sbSql = new StringBuffer();
		StringBuffer inSql = new StringBuffer();

		if( sType.equals("search") )
		{
			sbSql.delete(0, sbSql.length());
			sbSql.append("/* 특판 내부거래 사용자 조회 */ \n");
	        sbSql.append("SELECT 0 AS CHK \n");
	        sbSql.append("     , A.SABUN AS SABUN \n");
	        sbSql.append("     , B.NM_KOR||' ('||C.MU_NM||' '||C.CC_NM||')' AS NM_KOR \n");
	        sbSql.append("  FROM FSP_PO_SPECIAL_USER A \n");
	        sbSql.append("     , HLDC_HR_PERSONAL B \n");
	        sbSql.append("     , HLDC_SC_DEPT_V C \n");
	        sbSql.append(" WHERE A.SABUN = B.SABUN \n");
	        sbSql.append("   AND B.DEPT_ID = C.DEPT_ID \n");
	        sbSql.append("   AND B.GB_JAEJIK <> 'RA' \n");
	        sbSql.append("ORDER BY B.NM_KOR \n");

			pstmt = conn.prepareStatement(sbSql.toString());
			rs = pstmt.executeQuery();

			DataSet ds_list = this.makeDataSet(rs, "ds_list");

			out_dl.add(ds_list);
		}
		else if( sType.equals("save") )
		{
			int sRowStatus;
			String chk = "";
			String sabun = "";

			for( int i = 0; i < ds_in.getRowCount(); i++ )
			{
				inSql.delete(0, inSql.length());
				sRowStatus = ds_in.getRowType(i);
				chk = nullToBlank(ds_in.getString(i, "CHK"));
				sabun = nullToBlank(ds_in.getString(i, "SABUN"));

				if( chk.equals("0") )	continue;
				
				if( sabun.equals("") )	continue;

				if( sRowStatus == DataSet.ROW_TYPE_INSERTED )
				{
					inSql.append("/* 특판 내부거래 사용자 저장 */ \n");
					inSql.append("INSERT INTO FSP_PO_SPECIAL_USER \n");
					inSql.append("( \n");
					inSql.append("   SABUN \n");
					inSql.append(" , CREATE_DATE \n");
					inSql.append(" , CREATE_BY \n");
					inSql.append(" , UPDATE_DATE \n");
					inSql.append(" , UPDATE_BY \n");
					inSql.append(") \n");
					inSql.append("VALUES \n");
					inSql.append("( \n");
					inSql.append("  '" + nullToBlank(ds_in.getString(i, "SABUN")) + "' \n");
					inSql.append(" ,SYSDATE \n");
					inSql.append(" ,'" + g_EmpNo + "' \n");
					inSql.append(" ,SYSDATE \n");
					inSql.append(" ,'" + g_EmpNo + "' \n");
					inSql.append(") \n");
				}
		        pstmt = conn.prepareStatement(inSql.toString());
				pstmt.executeUpdate();
			}

			if( pstmt != null )	pstmt.close();
		}
		else if( sType.equals("delete") )
		{
			for( int i = 0; i < ds_in.getRemovedRowCount(); i++ )
			{
				inSql.delete(0, inSql.length());
				inSql.append("/* 특판 귀속부서 삭제 */ \n");
				inSql.append("DELETE FROM FSP_PO_SPECIAL_USER \n");
				inSql.append(" WHERE SABUN = '" + ds_in.getRemovedData(i, "SABUN").toString() + "' \n");

		        pstmt = conn.prepareStatement(inSql.toString());
				pstmt.executeUpdate();
			}
			
			if( pstmt != null )	pstmt.close();
		}

		if( !sType.equals("search") )	conn.commit();
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