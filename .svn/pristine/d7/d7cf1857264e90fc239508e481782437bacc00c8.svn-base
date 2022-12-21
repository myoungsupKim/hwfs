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

		DataSet ds_list     = in_dl.get("ds_list");
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));

		StringBuffer sbSql = new StringBuffer();

		int sRowStatus;
		for( int i = 0; i < ds_list.getRowCount(); i++ )
		{
			sbSql.delete(0, sbSql.length());
			sRowStatus = ds_list.getRowType(i);

			if( sRowStatus == DataSet.ROW_TYPE_NORMAL )
			{
				continue;
			}
			else if( sRowStatus == DataSet.ROW_TYPE_INSERTED )
			{
				sbSql.append("/* 특판 시즌정보 저장 */                                           \n");
		        sbSql.append("INSERT INTO FSP_PO_SEASON_LIST                                     \n");
		        sbSql.append("(  SID                                                             \n");
		        sbSql.append(" , STITLE                                                          \n");
		        sbSql.append(" , START_DATE                                                      \n");
		        sbSql.append(" , END_DATE                                                        \n");
		        sbSql.append(" , SDATE                                                           \n");
		        sbSql.append(" , SDATE_DISP                                                      \n");
		        sbSql.append(" , STIME                                                           \n");
		        sbSql.append(" , STIME_DISP                                                      \n");
		        sbSql.append(" , REMARK                                                          \n");
		        sbSql.append(" , USE_YN                                                          \n");
		        sbSql.append(" , ATTR01                                                          \n");
		        sbSql.append(" , ATTR02                                                          \n");
		        sbSql.append(" , ATTR03                                                          \n");
		        sbSql.append(" , ATTR04                                                          \n");
		        sbSql.append(" , ATTR05                                                          \n");
		        sbSql.append(" , CUSER                                                           \n");
		        sbSql.append(" , CDATE                                                           \n");
		        sbSql.append(" , UUSER                                                           \n");
		        sbSql.append(" , UDATE                                                           \n");
		        sbSql.append(" , UPJANG )                                                        \n");
		        sbSql.append("VALUES                                                             \n");
		        sbSql.append("(  (SELECT NVL(MAX(SID + 1), 1) FROM FSP_PO_SEASON_LIST)           \n");
		        sbSql.append(" , '" + nullToBlank(ds_list.getString(i, "STITLE")) + "'           \n");
		        sbSql.append(" , '" + nullToBlank(ds_list.getString(i, "START_DATE")) + "'       \n");
		        sbSql.append(" , '" + nullToBlank(ds_list.getString(i, "END_DATE")) + "'         \n");
		        sbSql.append(" , '" + nullToBlank(ds_list.getString(i, "SDATE")) + "'            \n");
		        sbSql.append(" , '" + nullToBlank(ds_list.getString(i, "SDATE_DISP")) + "'       \n");
		        sbSql.append(" , '" + nullToBlank(ds_list.getString(i, "STIME")) + "'            \n");
		        sbSql.append(" , '" + nullToBlank(ds_list.getString(i, "STIME_DISP")) + "'       \n");
		        sbSql.append(" , '" + nullToBlank(ds_list.getString(i, "REMARK")) + "'           \n");
		        sbSql.append(" , 'Y'                                                             \n");
		        sbSql.append(" , '" + nullToBlank(ds_list.getString(i, "ATTR01")) + "'           \n");
		        sbSql.append(" , '" + nullToBlank(ds_list.getString(i, "ATTR02")) + "'           \n");
		        sbSql.append(" , NVL('" + nullToBlank(ds_list.getString(i, "ATTR03")) + "', 0)   \n");
		        sbSql.append(" , ''                                                              \n");
		        sbSql.append(" , ''                                                              \n");
		        sbSql.append(" , '" + g_EmpNo + "'                                               \n");
		        sbSql.append(" , SYSDATE                                                         \n");
		        sbSql.append(" , '" + g_EmpNo + "'                                               \n");
		        sbSql.append(" , SYSDATE                                                         \n");
		        sbSql.append(" , '" + nullToBlank(ds_list.getString(i,"UPJANG")) + "' )          \n");

		        pstmt = conn.prepareStatement(sbSql.toString());
				pstmt.executeUpdate();
			}
			else if( sRowStatus == DataSet.ROW_TYPE_UPDATED )
			{
				sbSql.append("/* 특판 시즌정보 수정 */                                                              \n");
		        sbSql.append("UPDATE FSP_PO_SEASON_LIST                                                             \n");
				sbSql.append("   SET STITLE     = '" + nullToBlank(ds_list.getString(i, "STITLE")) + "'             \n");
				sbSql.append("     , START_DATE = '" + nullToBlank(ds_list.getString(i, "START_DATE")) + "'         \n");
		        sbSql.append("     , END_DATE   = '" + nullToBlank(ds_list.getString(i, "END_DATE")) + "'           \n");
		        sbSql.append("     , SDATE      = '" + nullToBlank(ds_list.getString(i, "SDATE")) + "'              \n");
		        sbSql.append("     , SDATE_DISP = '" + nullToBlank(ds_list.getString(i, "SDATE_DISP")) + "'         \n");
		        sbSql.append("     , STIME      = '" + nullToBlank(ds_list.getString(i, "STIME")) + "'              \n");
				sbSql.append("     , STIME_DISP = '" + nullToBlank(ds_list.getString(i, "STIME_DISP")) + "'         \n");
		        sbSql.append("     , REMARK     = '" + nullToBlank(ds_list.getString(i, "REMARK")) + "'             \n");
		        sbSql.append("     , ATTR01     = '" + nullToBlank(ds_list.getString(i, "ATTR01")) + "'             \n");
		        sbSql.append("     , ATTR02     = '" + nullToBlank(ds_list.getString(i, "ATTR02")) + "'             \n");
		        sbSql.append("     , ATTR03     = NVL('" + nullToBlank(ds_list.getString(i, "ATTR03")) + "', 0)     \n");
		        sbSql.append("     , UUSER      = '" + g_EmpNo + "'                                                 \n");
		        sbSql.append("     , UDATE      = SYSDATE                                                           \n");
		        sbSql.append("     , UPJANG     = '" + nullToBlank(ds_list.getString(i, "UPJANG")) + "'             \n");
		        sbSql.append(" WHERE 1 = 1                                                                          \n");
		        sbSql.append("   AND SID = '" + nullToBlank(ds_list.getString(i, "SID")) + "'                       \n");

		        pstmt = conn.prepareStatement(sbSql.toString());
				pstmt.executeUpdate();
			}
		}

		if( pstmt != null )	pstmt.close();

		for( int i = 0; i < ds_list.getRemovedRowCount(); i++ )
		{
			sbSql.delete(0, sbSql.length());
			sbSql.append("/* 특판 시즌정보 삭제 */                                           \n");
	        sbSql.append("DELETE FSP_PO_SEASON_LIST                                          \n");
	        sbSql.append(" WHERE SID = '" + ds_list.getRemovedData(i, "SID").toString() + "' \n");

	        pstmt = conn.prepareStatement(sbSql.toString());
			pstmt.executeUpdate();
		}

		conn.commit();
		this.setResultMessage(0, "OK", out_vl);

	}
	catch( Exception ex )
	{
		conn.rollback();

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