<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%@ page import="java.math.BigDecimal" %>
<%
	CallableStatement cstmt = null;

	try
	{
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();

		// jsp log 서비스 시작
		logger.startIndividualLog(in_vl.getString("titLogId"));

		DataSet ds_list     = in_dl.get("ds_list_detail");

		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		String g_Deptid     = nullToBlank(in_vl.getString("g_Deptid"));
		String sType        = nullToBlank(in_vl.getString("sType"));

		StringBuffer sbSql = new StringBuffer();
				
		for( int i = 0; i < ds_list.getRowCount(); i++ )
		{
			sbSql.delete(0, sbSql.length());
			sbSql.append("/* 특판발송정보 수정 */ \n");
			sbSql.append("UPDATE FSP_PO_SPECIAL_SALE \n");
			sbSql.append("   SET RECE_NAME    = '" + ds_list.getString(i, "RECE_NAME") + "' \n");
			sbSql.append("     , RECE_TEL_ENC = SC_CRYPTO_FUN('ENC', '" + ds_list.getString(i, "RECE_TEL") + "', '4') \n");
			sbSql.append("     , RECE_HP_ENC  = SC_CRYPTO_FUN('ENC', '"  + ds_list.getString(i, "RECE_HP") + "', '4') \n");
			sbSql.append("     , RECE_ADDR_ENC= SC_CRYPTO_FUN('ENC', '" + ds_list.getString(i, "RECE_ADDR") + "', '6') \n");
			sbSql.append(" WHERE SP_ID        = " + ds_list.getString(i, "SP_ID") + " \n");

			pstmt = conn.prepareStatement(sbSql.toString());
			pstmt.executeUpdate();

			if( pstmt != null)	pstmt.close();
		}

		conn.commit();
		this.setResultMessage(0, "OK", out_vl);

	}
	catch( Exception ex )
	{
		conn.rollback();

		// jsp 로그남기기
		logger.debug(ex.getMessage(), ex);
		this.setResultMessage(-1, ex.toString(),out_vl);
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
		if( cstmt != null )
		{
			try {
				cstmt.close();
			} catch( Exception e ) {}
		}
		if( conn != null )
		{
			try {
				conn.close();
			} catch(Exception e) {}
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