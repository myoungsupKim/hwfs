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

		String v_SubinvCode 	= in_vl.getString("v_SubinvCode");
		String v_Date 			= in_vl.getString("v_Date");

		DataSet ds_physicCnt;
		StringBuffer sbSelSql = new StringBuffer();

		sbSelSql.delete(0, sbSelSql.length());
		sbSelSql.append("SELECT COUNT(*) AS PHYSIC_CNT \n");
		sbSelSql.append("  FROM FSP_PHYSICAL_INVENTORY_STOCK \n");
		sbSelSql.append(" WHERE PHYSIC_DATE > '" + v_Date + "' \n");
		sbSelSql.append("   AND SUBINV_CODE = '" + v_SubinvCode + "' \n");
		sbSelSql.append("   AND TR_TYPE = 'I' \n");

		pstmt = conn.prepareStatement(sbSelSql.toString());
		rs = pstmt.executeQuery();
		ds_physicCnt = this.makeDataSet(rs, "ds_physicCnt");
		out_dl.add(ds_physicCnt);

	   	this.setResultMessage(0, "OK", out_vl);
	}
	catch( Exception ex )
	{
		//jsp 로그남기기
		logger.debug(ex.getMessage(), ex);
	    this.setResultMessage(-1, ex.toString(), out_vl);
	}
	finally
	{
		if( rs != null )
		{
			try {
				rs.close();
			}catch(Exception e) {}
		}
		if( pstmt != null )
		{
			try {
				pstmt.close();
			}catch(Exception e) {}
		}
		if( conn != null )
		{
			try {
				conn.close();
			}catch(Exception e) {}
		}

		//jsp log 서비스 닫기
		try {
			logger.endIndividualLog();
		} catch( Exception logE ) {
			logE.printStackTrace();
		}
	}

	proc_output(response, out, out_vl, out_dl);
%>