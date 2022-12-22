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

		DataSet ds_input     = in_dl.get("ds_input");

        String tableType		= nullToBlank(ds_input.getString(0, "TABLE_TYPE"));
		String fromDt 			= nullToBlank(ds_input.getString(0, "FROM_DT"));
		String toDt				= nullToBlank(ds_input.getString(0, "TO_DT"));
        String checkType		= nullToBlank(ds_input.getString(0, "CHECK_TYPE"));
        String upjang			= nullToBlank(ds_input.getString(0, "UPJANG"));
        String checkSabun		= nullToBlank(ds_input.getString(0, "CHECK_SABUN"));
        String mstCheckSabun	= nullToBlank(ds_input.getString(0, "MST_CHECK_SABUN"));
        String sType       		= nullToBlank(in_vl.getString("sType"));

		StringBuffer sbSql = new StringBuffer();
		sbSql.delete(0, sbSql.length());

		if( sType.equals("Search") )
		{
			sbSql.append("/* 메인 */ \n");
			sbSql.append("SELECT A.INSPECTOR AS CHECK_SABUN \n");
			sbSql.append("     , (SELECT NM_KOR FROM SCO_FS_HR_PERSONAL_V WHERE A.INSPECTOR = SABUN) AS CHECK_SABUN_NM \n");
			sbSql.append("     , COUNT(DISTINCT A.UPJANG) AS UPJANG_CNT \n");
			sbSql.append("     , COUNT(*) AS CHECK_CNT \n");
			//============================================================================================
			//(2012-04-16 수정) 시작
			// 박은규 2012-04-16 CSR#(SR201204_09204) 요청자:김희선(건강관리센터)
			// 특별점검 여부 추가 : 결과조회/출력에서 평균점수에서 제외
			//============================================================================================
//			sbSql.append("     , ROUND(AVG(A.SCORE),1) AS AVG_SCORE \n");
			sbSql.append("     , ROUND(AVG(DECODE(C.SET1, 'Y', NULL, A.SCORE)), 1) AS AVG_SCORE \n");
			//============================================================================================
			//(2012-04-16 수정) 끝
			//============================================================================================
			sbSql.append("  FROM FSC_PATL_RESULT A \n");
			sbSql.append("     , (SELECT Z.CODE, Z.SET1 FROM SCC_COMMON_CODE Z WHERE Z.GROUP_CODE = 'FS0107') C \n");
			sbSql.append(" WHERE A.CHK_CLASS = C.CODE \n");
			sbSql.append("   AND A.CONFIRM_YN = 'Y' \n");
			if( tableType.length() != 0 )
				sbSql.append("   AND A.TABLE_TYPE = '" + tableType + "' \n");
			sbSql.append("   AND A.CHK_DD BETWEEN '" + fromDt + "' AND '" + toDt + "' \n");
			sbSql.append("   AND A.CHK_CLASS IN (" + checkType + ") \n");
			if (checkSabun.length() != 0)
				sbSql.append("   AND A.INSPECTOR = '" + checkSabun + "' \n");
			sbSql.append(" GROUP BY A.INSPECTOR \n");

		}
		else if( sType.equals("SearchSub1") )
		{
			sbSql.append("/* 상세 */ \n");
	        sbSql.append("SELECT A.INSPECTOR AS CHECK_SABUN \n");
	        sbSql.append("     , (SELECT DISTINCT MU_CD FROM HLDC_SC_DEPT_V WHERE A.TM_CD = TM_CD AND ROWNUM = 1) AS MU_CD \n");
	        sbSql.append("     , (SELECT DISTINCT MU_NM FROM HLDC_SC_DEPT_V WHERE A.TM_CD = TM_CD AND ROWNUM = 1) AS MU_NM \n");
	        sbSql.append("     , A.TM_CD \n");
	        sbSql.append("     , (SELECT DISTINCT TM_NM FROM HLDC_SC_DEPT_V WHERE A.TM_CD = TM_CD) AS TM_NM \n");
	        sbSql.append("     , A.UPJANG \n");
	        sbSql.append("     , (SELECT UPJANGNM FROM HLDC_ST_UPJANG WHERE A.UPJANG = UPJANG) AS UPJANGNM \n");
	        sbSql.append("     , COUNT(*) AS CHECK_CNT \n");
	        //============================================================================================
	        //(2012-04-16 수정) 시작
	        // 박은규 2012-04-16 CSR#(SR201204_09204) 요청자:김희선(건강관리센터)
	        // 특별점검 여부 추가 : 결과조회/출력에서 평균점수에서 제외
	        //============================================================================================
	        //		sbSql.append("     , ROUND(AVG(A.SCORE),1) AS AVG_SCORE \n");
	        sbSql.append("     , ROUND(AVG(DECODE(C.SET1, 'Y', NULL, A.SCORE)), 1) AS AVG_SCORE \n");
	        //============================================================================================
	        //(2012-04-16 수정) 끝
	        //============================================================================================
	        sbSql.append("  FROM FSC_PATL_RESULT A \n");
	        sbSql.append("     , (SELECT Z.CODE, Z.SET1 FROM SCC_COMMON_CODE Z WHERE Z.GROUP_CODE = 'FS0107') C \n");
	        sbSql.append(" WHERE A.CHK_CLASS = C.CODE \n");
	        sbSql.append("   AND A.CONFIRM_YN = 'Y' \n");
	        if( tableType.length() != 0 )
	            sbSql.append("   AND A.TABLE_TYPE = '" + tableType + "' \n");
	        sbSql.append("   AND A.CHK_DD BETWEEN '" + fromDt + "' AND '" + toDt + "' \n");
	        sbSql.append("   AND A.CHK_CLASS IN (" + checkType + ") \n");
	        sbSql.append("   AND A.INSPECTOR = '" + mstCheckSabun + "' \n");
	        sbSql.append(" GROUP BY A.INSPECTOR, A.TM_CD, A.UPJANG \n");
		}
		else if( sType.equals("SearchSub2") )
		{
			sbSql.append("/* 상세 */ \n");
	        sbSql.append("SELECT A.INSPECTOR AS CHECK_SABUN \n");
	        sbSql.append("     , A.UPJANG \n");
	        sbSql.append("     , A.CHK_DD AS CHECK_DATE \n");
	        sbSql.append("     , ROUND(A.SCORE, 1) AS SCORE \n");
	        sbSql.append("     , CASE WHEN A.SCORE >= 90 THEN 'A' \n");
	        sbSql.append("            WHEN A.SCORE >= 80 THEN 'B' \n");
	        sbSql.append("            WHEN A.SCORE >= 70 THEN 'C' \n");
	        sbSql.append("            WHEN A.SCORE >= 60 THEN 'D' \n");
	        sbSql.append("            ELSE 'E' \n");
	        sbSql.append("       END GRADE \n");
	        sbSql.append("  FROM FSC_PATL_RESULT A \n");
	        sbSql.append(" WHERE CONFIRM_YN = 'Y' \n");
	        if( tableType.length() != 0 )
	            sbSql.append("   AND TABLE_TYPE = '" + tableType + "' \n");
	        sbSql.append("   AND CHK_DD BETWEEN '" + fromDt + "' AND '" + toDt + "' \n");
	        sbSql.append("   AND CHK_CLASS IN (" + checkType + ") \n");
	        sbSql.append("   AND INSPECTOR = '" + mstCheckSabun + "' \n");
	        sbSql.append("   AND UPJANG = " + upjang + " \n");
		}
		
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