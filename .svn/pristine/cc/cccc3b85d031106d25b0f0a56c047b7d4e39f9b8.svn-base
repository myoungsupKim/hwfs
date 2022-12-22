<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업
■ 프로그램ID   : FMP01150E_T001.jsp
■ 프로그램명   : 공휴일 입고일 제외업장 팝업
■ 작성일자     : 2015-11-27
■ 작성자       : 박용대
■ 이력관리     : 신규생성
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	PlatformRequest platformRequest = this.proc_input(request);
	in_vl = platformRequest.getData().getVariableList();	//파라미터 받는 객체
	in_dl = platformRequest.getData().getDataSetList();		//데이터셋 받는 객체

	// jsp log 서비스 시작
	logger.startIndividualLog(in_vl.getString("titLogId"));

	//입력 데이타셋
	DataSet ds_cond   = in_dl.get("ds_cond");

	//입력 파라미터
	String g_Mu  		= nullToBlank(ds_cond.getString(0, "MU"));
	String g_NeedDate  	= nullToBlank(ds_cond.getString(0, "NEED_DATE"));
	
	try
	{
		StringBuffer sbSql = new StringBuffer();
		sbSql.delete(0, sbSql.length());

		sbSql.append("SELECT B.MU_NM \n");
		sbSql.append("     , A.TM_CD \n");
		sbSql.append("     , B.TM_NM \n");
		sbSql.append("     , A.UPJANG \n");
		sbSql.append("     , (SELECT Z.UPJANGNM FROM ST_UPJANG Z WHERE Z.UPJANG = A.UPJANG) AS UPJANGNM \n");
		sbSql.append("  FROM FSP_HOLIDAY_UPJANG A \n");
		sbSql.append("     , HLDC_SC_TM B \n");
		sbSql.append(" WHERE A.TM_CD = B.TM_CD \n");
		sbSql.append("   AND A.NEED_DATE = '" + g_NeedDate + "' \n");
		//sbSql.append("   AND B.MU_CD = '" + g_Mu + "' \n");
		sbSql.append(" ORDER BY B.MU_CD, A.TM_CD, UPJANG \n");
	 
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		DataSet ds_list = this.makeDataSet(rs, "ds_list");

		out_dl.add(ds_list);
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