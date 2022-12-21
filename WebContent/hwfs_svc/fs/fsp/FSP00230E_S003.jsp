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

		String sPhysic_date     = "";
		String sOnhandMonth     = "000101";
		String sUpjangName      = "";
		sPhysic_date	 		= v_Date;

		StringBuffer sbSelSql = new StringBuffer();

		sbSelSql.delete(0, sbSelSql.length());
		sbSelSql.append("/* 수불 마감월 조회 */ \n");
		sbSelSql.append( "SELECT MAX(TO_NUMBER(A.CLS_YM)) AS CLS_YM \n");
		sbSelSql.append( "  FROM HLDC_PO_CLOSING A \n");
		sbSelSql.append( " WHERE A.CLS_YM      < SUBSTR('" + sPhysic_date + "', 1, 6) \n");
		sbSelSql.append( "   AND A.SUBINV_CODE = '" + v_SubinvCode + "' \n");
		sbSelSql.append( "   AND A.CLS_FLAG    = 'Y' \n");

		pstmt = conn.prepareStatement(sbSelSql.toString());
		rs = pstmt.executeQuery();
		rs.next();

		if( nullToBlank(rs.getString("CLS_YM")).equals("") )
			sOnhandMonth = "000101";
		else
			sOnhandMonth = nullToBlank(rs.getString("CLS_YM"));

		sbSelSql.delete(0, sbSelSql.length());
		sbSelSql.append( " SELECT REPLACE(B.UPJANGNM, '단체급식 ') ||'('||A.SUBINV_NAME||')' UPJANG_NAME \n");
		sbSelSql.append( "   FROM HLDC_PO_SUBINVENTORY A, \n");
		sbSelSql.append( "        ST_UPJANG B \n");
		sbSelSql.append( " WHERE A.UPJANG = B.UPJANG \n");
		sbSelSql.append( "   AND A.SUBINV_CODE = '" + v_SubinvCode + "' \n");

		pstmt = conn.prepareStatement(sbSelSql.toString());
		rs = pstmt.executeQuery();
		rs.next();

		sUpjangName = rs.getString("UPJANG_NAME");

		out_vl.add("sPhysic_date", sPhysic_date);
		out_vl.add("sOnhandMonth", sOnhandMonth);
		out_vl.add("sUpjangName", sUpjangName);

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