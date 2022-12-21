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

		DataSet ds_in     = in_dl.get("ds_list");

		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		String sSeason      = nullToBlank(in_vl.getString("nCbSeason"));
		String sType		= nullToBlank(in_vl.getString("sType"));
		String sCcCd		= nullToBlank(in_vl.getString("sCcCd"));
		String sUpjang      = nullToBlank(in_vl.getString("sUpjang"));
				
		
		StringBuffer sbSql = new StringBuffer();
		StringBuffer inSql = new StringBuffer();
		
		if( sType.equals("search") )
		{
			sbSql.delete(0, sbSql.length());
			sbSql.append("/* 특판 귀속부서 조회 */ \n");
	        sbSql.append("SELECT A.SEASON_NUM \n");
	        sbSql.append("     , A.OCCUR_CC_CD \n");
	        sbSql.append("     , (SELECT CC_NM FROM SCC_CC WHERE CC_CD =  A.OCCUR_CC_CD) AS OCCUR_CC_NM \n");
	        sbSql.append("     , A.ATTR_CC_CD \n");
	        sbSql.append("     , (SELECT CC_NM FROM SCC_CC WHERE CC_CD =  A.ATTR_CC_CD) AS ATTR_CC_NM \n");
	        sbSql.append("     , A.UPJANG \n");
	        sbSql.append("     , (SELECT UPJANGNM FROM ST_UPJANG WHERE UPJANG =  A.UPJANG) AS UPJANGNM \n");
	        sbSql.append("     , 'R' AS ROW_STATUS \n");
	        sbSql.append("  FROM FSP_PO_SPECIAL_UPJANG A \n");
	        sbSql.append(" WHERE 1 = 1 \n");
	        sbSql.append("   AND A.SEASON_NUM = '" + sSeason + "' \n");
	        sbSql.append("ORDER BY A.OCCUR_CC_CD, ATTR_CC_CD \n");

			pstmt = conn.prepareStatement(sbSql.toString());
			rs = pstmt.executeQuery();

			DataSet ds_list = this.makeDataSet(rs, "ds_list");

			out_dl.add(ds_list);
		}
		if( sType.equals("upjang") )
		{
			sbSql.delete(0, sbSql.length());
			sbSql.append("/* 특판 귀속부서 조회 */ \n");
	        sbSql.append("SELECT UPJANG \n");
	        sbSql.append("     , UPJANGNM \n");
	        sbSql.append("  FROM ST_UPJANG A \n");
	        sbSql.append(" WHERE 1 = 1 \n");
	        if( !sCcCd.equals("") )
	        	sbSql.append("   AND CC_CD = '" + sCcCd + "' \n");
	        if( !sUpjang.equals("") )
	        	sbSql.append("   AND UPJANG = " + sUpjang + " \n");

			pstmt = conn.prepareStatement(sbSql.toString());
			rs = pstmt.executeQuery();

			DataSet ds_upjang = this.makeDataSet(rs, "ds_upjang");

			out_dl.add(ds_upjang);
		}
		else if( sType.equals("save") )
		{
			int sRowStatus;
			for( int i = 0; i < ds_in.getRowCount(); i++ )
			{
				inSql.delete(0, inSql.length());
				sRowStatus = ds_in.getRowType(i);

				if( sRowStatus == DataSet.ROW_TYPE_NORMAL )
				{
					continue;
				}
				else if( sRowStatus == DataSet.ROW_TYPE_INSERTED )
				{
					inSql.append("/* 특판 귀속부서 저장 */ \n");
					inSql.append("INSERT INTO FSP_PO_SPECIAL_UPJANG \n");
					inSql.append("( \n");
					inSql.append("   SEASON_NUM \n");
					inSql.append(" , OCCUR_CC_CD \n");
					inSql.append(" , ATTR_CC_CD \n");
					inSql.append(" , UPJANG \n");
					inSql.append(" , CREATE_DATE \n");
					inSql.append(" , CREATE_BY \n");
					inSql.append(" , UPDATE_DATE \n");
					inSql.append(" , UPDATE_BY \n");
					inSql.append(") \n");
					inSql.append("VALUES \n");
					inSql.append("( \n");
					inSql.append("  '" + nullToBlank(ds_in.getString(i, "SEASON_NUM")) + "' \n");
					inSql.append(" ,'" + nullToBlank(ds_in.getString(i, "OCCUR_CC_CD")) + "' \n");
					inSql.append(" ,'" + nullToBlank(ds_in.getString(i, "ATTR_CC_CD")) + "' \n");
					inSql.append(" ,'" + nullToBlank(ds_in.getString(i, "UPJANG")) + "' \n");
					inSql.append(" ,SYSDATE \n");
					inSql.append(" ,'" + g_EmpNo + "' \n");
					inSql.append(" ,SYSDATE \n");
					inSql.append(" ,'" + g_EmpNo + "' \n");
					inSql.append(") \n");
				}
				else if( sRowStatus == DataSet.ROW_TYPE_UPDATED )
				{
					inSql.append("/* 특판 귀속부서 수정 */ \n");
					inSql.append("UPDATE FSP_PO_SPECIAL_UPJANG \n");
					inSql.append("  SET ATTR_CC_CD = '" + nullToBlank(ds_in.getString(i, "ATTR_CC_CD")) + "' \n");
					inSql.append("    , UPJANG = '" + nullToBlank(ds_in.getString(i, "UPJANG")) + "' \n");
					inSql.append("    , UPDATE_DATE = SYSDATE \n");
					inSql.append("    , UPDATE_BY = '" + g_EmpNo + "' \n");
					inSql.append(" WHERE SEASON_NUM = '" + nullToBlank(ds_in.getString(i, "SEASON_NUM")) + "' \n");
					inSql.append("   AND OCCUR_CC_CD = '" + nullToBlank(ds_in.getString(i, "OCCUR_CC_CD")) + "' \n");
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
				inSql.append("DELETE FROM FSP_PO_SPECIAL_UPJANG \n");
				inSql.append(" WHERE SEASON_NUM = '" + ds_in.getRemovedData(i, "SEASON_NUM").toString() + "' \n");
				inSql.append("   AND OCCUR_CC_CD = '" + ds_in.getRemovedData(i, "OCCUR_CC_CD").toString() + "' \n");
				inSql.append("   AND ATTR_CC_CD = '" + ds_in.getRemovedData(i, "ATTR_CC_CD").toString() + "' \n");

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