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

		String v_CopyDate	= nullToBlank(in_vl.getString("v_CopyDate"));
		String v_SubinvCode = nullToBlank(in_vl.getString("v_SubinvCode"));
		String v_Upjang		= nullToBlank(in_vl.getString("v_Upjang"));

		DataSet ds_physic_value;		

		StringBuffer sbSelSql = new StringBuffer();
		sbSelSql.delete(0, sbSelSql.length());
		sbSelSql.append("/* 전일 반영된 제조일, 유통기한, 비고 조회 */ \n");
		sbSelSql.append("SELECT A.ITEM_CODE \n");
		sbSelSql.append("     , A.MAKER_DATE \n");
		sbSelSql.append("     , A.VALUE_DATE \n");
		sbSelSql.append("     , A.VALUE_DATE_INFO \n");
		sbSelSql.append("  FROM FSP_PHYSICAL_INVENTORY_STOCK A \n");
		sbSelSql.append("     , ( SELECT ITEM_CODE \n");
		sbSelSql.append("              , DECODE(VALUE_DATE_INFO || VALUE_DATE || MAKER_DATE, NULL, 'N', 'Y') AS VALUE_YN \n");
		sbSelSql.append("           FROM FSP_PHYSICAL_INVENTORY_STOCK \n");
		sbSelSql.append("          WHERE SUBINV_CODE = '" + v_SubinvCode + "' \n");
		sbSelSql.append("            AND PHYSIC_DATE = '" + v_CopyDate + "' \n");
		sbSelSql.append("       ) B \n");
		sbSelSql.append(" WHERE A.ITEM_CODE = B.ITEM_CODE \n");
		sbSelSql.append("   AND A.SUBINV_CODE = '" + v_SubinvCode + "' \n");
		sbSelSql.append("   AND PHYSIC_DATE = '" + v_CopyDate + "' \n");
		sbSelSql.append("   AND B.VALUE_YN = 'Y' \n");

		pstmt = conn.prepareStatement(sbSelSql.toString());
		rs = pstmt.executeQuery();

		ds_physic_value = this.makeDataSet(rs, "ds_physic_value");
		out_dl.add(ds_physic_value);

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