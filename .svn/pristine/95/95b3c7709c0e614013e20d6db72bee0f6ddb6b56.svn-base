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

        String tableType	= nullToBlank(ds_input.getString(0, "TABLE_TYPE"));
		String fromDt 		= nullToBlank(ds_input.getString(0, "FROM_DT"));
		String toDt			= nullToBlank(ds_input.getString(0, "TO_DT"));
        String formCd		= nullToBlank(ds_input.getString(0, "FORM_CD"));
        String checkType	= nullToBlank(ds_input.getString(0, "CHECK_TYPE"));
        String lrgClassCd	= nullToBlank(ds_input.getString(0, "LRG_CLASS_CD"));
        String muCd			= nullToBlank(ds_input.getString(0, "MU_CD"));
        String tmCd			= nullToBlank(ds_input.getString(0, "TM_CD"));
        String job			= nullToBlank(ds_input.getString(0, "JOB"));
        String subJob		= nullToBlank(ds_input.getString(0, "SUB_JOB"));
        String upjang		= nullToBlank(ds_input.getString(0, "UPJANG"));
        String checkSabun	= nullToBlank(ds_input.getString(0, "CHECK_SABUN"));
        String classCd		= nullToBlank(ds_input.getString(0, "CLASS_CD"));
		String sType       	= nullToBlank(in_vl.getString("sType"));

		StringBuffer sbSql = new StringBuffer();
		sbSql.delete(0, sbSql.length());

		if( sType.equals("Search") )
		{
			sbSql.append("/* 메인 */ \n");
	        sbSql.append("SELECT A.HM_CLASS_CD AS PL_UP_CD \n");
	        sbSql.append("     , A.HM_CLASS_NM AS MIDDLE_CLASS_NAME \n");
	        sbSql.append("     , A.CLASS_CD AS PL_CD \n");
	        sbSql.append("     , A.CLASS_NM AS CLASS_NAME \n"); 
	        sbSql.append("     , COUNT(*) AS CNT \n");
	        sbSql.append("     , '0' BL_SHOW \n");
	        sbSql.append("     , 2 LEVEL_NO \n");
	        sbSql.append("     , '+' BL_PLUS \n");
	        sbSql.append("  FROM FSC_PATL_FORM_DTL A \n");
	        sbSql.append("     , FSC_PATL_RESULT B \n");
	        sbSql.append("     , FSC_PATL_RESULT_DTL C \n");
	        sbSql.append("     , ( \n");
	        sbSql.append("        SELECT UPJANG \n");
	        sbSql.append("          FROM FSA_UPJANG_V \n");
	        sbSql.append("         WHERE 1=1 \n");

	        if( !muCd.equals("") )
	            sbSql.append("           AND MU_CD='" + muCd + "' \n");

	        if( !tmCd.equals("") )
	            sbSql.append("           AND TM_CD='" + tmCd + "' \n");

	        if( !upjang.equals("") )
	            sbSql.append("           AND UPJANG=" + upjang + " \n");

	        if( !job.equals("") )
	            sbSql.append("           AND JOB_CD='" + job + "' \n");

	        if( !subJob.equals("") )
	            sbSql.append("           AND SUB_JOB_CD='" + subJob + "' \n");

	        sbSql.append("       ) D \n");
	        
	        sbSql.append(" WHERE A.TABLE_TYPE = C.TABLE_TYPE \n");
	        sbSql.append("   AND A.FORM_CD = C.FORM_CD \n");
	        sbSql.append("   AND A.CLASS_CD = C.CLASS_CD \n");
	        sbSql.append("   AND B.TABLE_TYPE = C.TABLE_TYPE \n");
	        sbSql.append("   AND B.FORM_CD = C.FORM_CD \n");
	        sbSql.append("   AND B.CHK_DD = C.CHK_DD \n");
	        sbSql.append("   AND B.UPJANG = C.UPJANG \n");
	        sbSql.append("   AND B.UPJANG = D.UPJANG \n");
	        sbSql.append("   AND B.CONFIRM_YN = 'Y' \n");
	        //최대배점이 아니거나 지적건이 있는것
//	        sbSql.append("   AND (C.MAX_YN = 'N' OR C.INDICATE_CNT > 0) \n"); -- 만점이 아니고 지적건수가 있는거
            sbSql.append("   AND DECODE(C.IMPROV_CHECK, 'Y', 1, 0) > 0 \n");
	        sbSql.append("   AND A.TABLE_TYPE = '" + tableType + "' \n");
	        sbSql.append("   AND B.CHK_DD BETWEEN '" + fromDt + "' AND '" + toDt + "' \n");
	        sbSql.append("   AND A.FORM_CD = '" + formCd + "' \n");
	        sbSql.append("   AND B.CHK_CLASS IN (" + checkType + ") \n");
	        if( lrgClassCd.length() != 0 )
	        	sbSql.append("   AND A.HL_CLASS_CD = '" + lrgClassCd + "' \n");

	        if( checkSabun.length() != 0 )
	            sbSql.append("   AND B.INSPECTOR = " + checkSabun + " \n");

	        sbSql.append(" GROUP BY A.HM_CLASS_CD, A.HM_CLASS_NM, A.CLASS_CD, A.CLASS_NM \n");
	        sbSql.append(" ORDER BY A.CLASS_CD \n");
		}
		else if( sType.equals("Detail") )
		{
			sbSql.append("/* 상세 */ \n");
			sbSql.append("SELECT C.TABLE_TYPE \n");
			sbSql.append("     , C.FORM_CD \n");
			sbSql.append("     , C.CLASS_CD \n");
			sbSql.append("     , D.JOB_CD \n");
			sbSql.append("     , D.JOB_NAME \n");
			sbSql.append("     , D.SUB_JOB_CD \n");
			sbSql.append("     , D.SUB_JOB_NAME \n");
			sbSql.append("     , B.UPJANG \n");
			sbSql.append("     , (SELECT UPJANGNM FROM MAC_UPJANG_V WHERE B.UPJANG = UPJANG) AS UPJANGNM \n");
			sbSql.append("     , B.CHK_DD AS CHECK_DATE \n");
			sbSql.append("     , B.INSPECTOR AS CHECK_SABUN \n");
			sbSql.append("     , (SELECT NM_KOR FROM HLDC_HR_PERSONAL WHERE SABUN = B.INSPECTOR) AS CHECK_SABUN_NM \n");
			sbSql.append("     , B.CHARGE_SABUN \n");
			sbSql.append("     , (SELECT NM_KOR FROM HLDC_HR_PERSONAL WHERE SABUN = B.CHARGE_SABUN) AS CHARGE_NM \n");
			sbSql.append("     , C.CHK_SCORE AS MARK \n");
			sbSql.append("     , C.CHK_CONTENTS AS EVAL_CONTENTS \n");
			sbSql.append("     , C.IMPROV_MRMT_CONTENTS AS IMPROV_MGMT \n");
			sbSql.append("     , ( SELECT COUNT(*) \n");
			sbSql.append("           FROM FSC_PATL_CHK_IMGE \n");
			sbSql.append("          WHERE TABLE_TYPE = C.TABLE_TYPE \n");
			sbSql.append("            AND FORM_CD = C.FORM_CD \n");
			sbSql.append("            AND UPJANG = C.UPJANG \n");
			sbSql.append("            AND CHK_DD = C.CHK_DD \n");
			sbSql.append("            AND CLASS_CD = C.CLASS_CD \n");
			sbSql.append("       ) AS PHOTO_CNT \n");
			sbSql.append("  FROM FSC_PATL_FORM_DTL A \n");
			sbSql.append("     , FSC_PATL_RESULT B \n");
			sbSql.append("     , FSC_PATL_RESULT_DTL C \n");
			sbSql.append("     , ( \n");
			sbSql.append("        SELECT UPJANG \n");
			sbSql.append("             , JOB_CD \n");
			sbSql.append("             , SUB_JOB_CD \n");
			sbSql.append("             , JOB_NAME \n");
			sbSql.append("             , SUB_JOB_NAME \n");
			sbSql.append("          FROM FSA_UPJANG_V \n");
			sbSql.append("         WHERE 1=1 \n");
	        if( !muCd.equals("") )
	            sbSql.append("           AND MU_CD='" + muCd + "' \n");

	        if( !tmCd.equals("") )
	            sbSql.append("           AND TM_CD='" + tmCd + "' \n");

	        if( !upjang.equals("") )
	            sbSql.append("           AND UPJANG=" + upjang + " \n");

	        if( !job.equals("") )
	            sbSql.append("           AND JOB_CD='" + job + "' \n");

	        if( !subJob.equals("") )
	            sbSql.append("           AND SUB_JOB_CD='" + subJob + "' \n");
			sbSql.append("       ) D \n");
			sbSql.append(" WHERE A.TABLE_TYPE = C.TABLE_TYPE \n");
			sbSql.append("   AND A.FORM_CD = C.FORM_CD \n");
			sbSql.append("   AND A.CLASS_CD = C.CLASS_CD \n");
			sbSql.append("   AND B.TABLE_TYPE = C.TABLE_TYPE \n");
			sbSql.append("   AND B.FORM_CD = C.FORM_CD \n");
			sbSql.append("   AND B.CHK_DD = C.CHK_DD \n");
			sbSql.append("   AND B.UPJANG = C.UPJANG \n");
			sbSql.append("   AND B.UPJANG = D.UPJANG \n");
			sbSql.append("   AND B.CONFIRM_YN = 'Y' \n");
			sbSql.append("   AND DECODE(C.IMPROV_CHECK, 'Y', 1, 0) > 0 \n");
			sbSql.append("   AND A.TABLE_TYPE = '" + tableType + "' \n");
			sbSql.append("   AND B.CHK_DD BETWEEN '" + fromDt + "' AND '" + toDt + "' \n");
			sbSql.append("   AND A.FORM_CD = '" + formCd + "' \n");
			sbSql.append("   AND B.CHK_CLASS IN (" + checkType + ") \n");
			sbSql.append("   AND C.CLASS_CD = '" + classCd + "' \n");
	        if( lrgClassCd.length() != 0 )
	        	sbSql.append("   AND A.HL_CLASS_CD = '" + lrgClassCd + "' \n");
	        if( checkSabun.length() != 0 )
	            sbSql.append("   AND B.INSPECTOR = " + checkSabun + " \n");
			sbSql.append(" ORDER BY D.JOB_CD, D.SUB_JOB_CD, B.UPJANG, B.CHK_DD \n");
		}
		else if( sType.equals("CheckSabun") )
		{
			sbSql.append("/* 점검자 조회 */ \n");
			sbSql.append("SELECT /*+ INDEX_SS(A) */ \n");
			sbSql.append("       DISTINCT A.INSPECTOR AS CHECK_SABUN \n");
			sbSql.append("     , V.NM_KOR || ' (' || V.MU_NM || ' ' || V.CC_NM || ')' AS CHECK_SABUN_NM \n");
			sbSql.append("  FROM FSC_PATL_RESULT A \n");
			sbSql.append("     , SCO_FS_HR_PERSONAL_V V \n");
			sbSql.append(" WHERE A.INSPECTOR = V.SABUN(+) \n");
			sbSql.append("   AND V.NM_KOR IS NOT NULL \n");
			sbSql.append("   AND A.CHK_DD BETWEEN '" + fromDt + "' AND '" + toDt + "' \n");
			sbSql.append(" ORDER BY 2, 1 \n");
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