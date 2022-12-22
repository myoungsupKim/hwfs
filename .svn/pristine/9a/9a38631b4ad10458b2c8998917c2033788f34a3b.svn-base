
<%
    /*-----------------------------------------------------------------------------
    ■ 시스템명     : 메뉴관리/위생관리
    ■ 프로그램ID   : FSC00043V_T001.jsp
    ■ 프로그램명   : 부적합 사업장
    ■ 작성일자     : 2012-10-22
    ■ 작성자       : 박은규
    ■ 이력관리     : 2012-10-22
    1)박은규 2012-10-22 CSR#(CH201210_00118) 요청자:홍호준(식품연구소)
    최초 작성
    -----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="../../sc/main/common.jsp"%>
<%
    try {
        PlatformRequest platformRequest = this.proc_input(request);
        in_vl = platformRequest.getData().getVariableList();
        in_dl = platformRequest.getData().getDataSetList();

        //jsp log 서비스 시작
        logger.startIndividualLog(in_vl.getString("titLogId"));

        //입력 데이타
        DataSet ds_input = in_dl.get("ds_input");

        String strTableType = nullToBlank(ds_input.getString(0, "TABLE_TYPE"));
        String strCheckType = nullToBlank(ds_input.getString(0, "CHECK_TYPE"));
        String strMuCD = nullToBlank(ds_input.getString(0, "MU_CD"));
        String strTmCD = nullToBlank(ds_input.getString(0, "TM_CD"));
        //String strYear				= nullToBlank(ds_input.getString(0, "YEAR"));
        String strFromDate = nullToBlank(ds_input.getString(0, "FROM_DATE"));
        String strToDate = nullToBlank(ds_input.getString(0, "TO_DATE"));
        String strTeamMstSabun = nullToBlank(ds_input.getString(0, "TEAM_MST_SABUN"));
        String strSubteamMstSabun = nullToBlank(ds_input.getString(0, "SUBTEAM_MST_SABUN"));

        //out 데이타
        DataSet ds_list;

        //sql문 버퍼생성
        StringBuffer sbSql = new StringBuffer();

        sbSql.delete(0, sbSql.length());
        sbSql.append(
                "SELECT (SELECT Z.CODE_NAME FROM SCC_COMMON_CODE Z WHERE Z.GROUP_CODE = 'FS0042' AND Z.CODE = A.CHECK_TYPE) AS CHECK_TYPE \n");
        sbSql.append("     , TO_CHAR(TO_DATE(A.CHECK_DATE,'YYYYMMDD'),'YYYY-MM-DD') AS CHECK_DATE \n");
        sbSql.append("     , (SELECT DISTINCT MU_CD FROM HLDC_SC_DEPT_V WHERE A.TM_CD = TM_CD AND ROWNUM = 1) AS MU_CD \n");
        sbSql.append("     , (SELECT DISTINCT MU_NM FROM HLDC_SC_DEPT_V WHERE A.TM_CD = TM_CD AND ROWNUM = 1) AS MU_NM \n");
        sbSql.append("     , A.TM_CD \n");
        sbSql.append("     , (SELECT Z.TM_NM FROM HLDC_SC_TM Z WHERE Z.TM_CD = A.TM_CD AND ROWNUM = 1) AS TM_NM \n");
        sbSql.append("     , A.TEAM_MST_SABUN \n");
        sbSql.append(
                "     , (SELECT Z.NM_KOR FROM HLDC_HR_PERSONAL Z WHERE Z.SABUN =  A.TEAM_MST_SABUN) AS TEAM_MST_NM \n");
        sbSql.append("     , A.SUBTEAM_MST_SABUN \n");
        sbSql.append(
                "     , (SELECT Z.NM_KOR FROM HLDC_HR_PERSONAL Z WHERE Z.SABUN =  A.SUBTEAM_MST_SABUN) AS SUBTEAM_MST_NM \n");
        sbSql.append("     , A.UPJANG \n");
        sbSql.append("     , (SELECT Z.UPJANGNM FROM HLDC_ST_UPJANG Z WHERE Z.UPJANG = A.UPJANG) AS UPJANGNM \n");
        sbSql.append("     , A.CHARGE_SABUN \n");
        sbSql.append("     , (SELECT Z.NM_KOR FROM HLDC_HR_PERSONAL Z WHERE Z.SABUN =  A.CHARGE_SABUN) AS CHARGE_NM \n");
        sbSql.append("     , ROUND(A.SCORE, 1) AS SCORE \n");
        sbSql.append("     , A.ATTR01 AS NOT_FIT_REASON \n");
        sbSql.append("     , (SELECT COUNT(1) FROM FSC_RESULT_MST Z \n");
        sbSql.append("         WHERE Z.UPJANG = A.UPJANG \n");
        sbSql.append("           AND Z.CHECK_TYPE = A.CHECK_TYPE \n");
        //sbSql.append("           AND Z.CHECK_DATE BETWEEN '" + strYear + "'||'0101' AND A.CHECK_DATE \n");
        //sbSql.append("           AND Z.CHECK_DATE BETWEEN SUBSTR('" + strFromDate + "',1,4)||'0101' AND A.CHECK_DATE \n");
        sbSql.append("           AND Z.CHECK_DATE BETWEEN '" + strFromDate + "' AND A.CHECK_DATE \n");
        sbSql.append("           AND Z.CONFIRM_YN = 'Y' \n");
        sbSql.append("           AND Z.NOT_FIT_YN = 1) AS NOT_FIT_TOT \n");
        sbSql.append("  FROM FSC_RESULT_MST A \n");
        sbSql.append(" WHERE A.CONFIRM_YN = 'Y' \n");
        sbSql.append("   AND A.NOT_FIT_YN = 1 \n");
        if (!strTableType.equals(""))
            sbSql.append("   AND A.TABLE_TYPE = '" + strTableType + "' \n");
        //sbSql.append("   AND SUBSTR(A.CHECK_DATE,1,4) = '" + strYear + "' \n");
        sbSql.append("   AND A.CHECK_DATE BETWEEN '" + strFromDate + "' AND '" + strToDate + "' \n");
        sbSql.append("   AND A.CHECK_TYPE IN (" + strCheckType + ") \n");
        if (strMuCD.length() != 0)
            sbSql.append("           AND (SELECT DISTINCT MU_CD FROM HLDC_SC_DEPT_V WHERE A.TM_CD = TM_CD AND ROWNUM = 1) = '" + strMuCD + "' \n");
        if (strTmCD.length() != 0)
            sbSql.append("   AND A.TM_CD = '" + strTmCD + "' \n");
        if (strTeamMstSabun.length() != 0)
            sbSql.append("   AND A.TEAM_MST_SABUN ='" + strTeamMstSabun + "' \n");
        if (strSubteamMstSabun.length() != 0)
            sbSql.append("   AND A.SUBTEAM_MST_SABUN ='" + strSubteamMstSabun + "' \n");
        sbSql.append(" ORDER BY A.CHECK_TYPE, A.CHECK_DATE, A.TM_CD, A.TEAM_MST_SABUN, A.SUBTEAM_MST_SABUN, A.UPJANG \n");

        //System.out.println(sbSql.toString());
        pstmt = conn.prepareStatement(sbSql.toString());
        rs = pstmt.executeQuery();
        ds_list = this.makeDataSet(rs, "ds_list");

        rs.close();
        pstmt.close();

        /**종료**/
        out_dl.add(ds_list);
        this.setResultMessage(0, "OK", out_vl);

    } catch (Exception ex) {
        //ex.printStackTrace();
        //jsp 로그남기기
        logger.debug(ex.getMessage(), ex);
        this.setResultMessage(-1, ex.toString(), out_vl);
    } finally {
        if (rs != null) {
            try {
                rs.close();
            } catch (Exception e) {
            }
        }
        if (pstmt != null) {
            try {
                pstmt.close();
            } catch (Exception e) {
            }
        }
        if (conn != null) {
            try {
                conn.close();
            } catch (Exception e) {
            }
        }

        //jsp log 서비스 닫기
        try {
            logger.endIndividualLog();
        } catch (Exception logE) {
            logE.printStackTrace();
        }
    }

    proc_output(response, out, out_vl, out_dl);
%>