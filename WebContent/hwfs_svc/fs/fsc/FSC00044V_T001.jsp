
<%
    /*-----------------------------------------------------------------------------
    ■ 시스템명     : 메뉴관리/위생관리
    ■ 프로그램ID   : FSC00041V_T001.jsp
    ■ 프로그램명   : 분기별 점검결과조회
    ■ 작성일자     : 2008-03-31
    ■ 작성자       : 박지영
    ■ 이력관리     : 2008-03-31
    1)박은규 2012-04-16 CSR#(SR201204_09204) 요청자:김희선(건강관리센터)
    특별점검구분 추가 : 결과조회/출력에서 평균점수에서 제외
    2)박은규 2012-10-22 CSR#(CH201210_00118) 요청자:홍호준(식품연구소)
    운영사업장 전체갯수, 부적합사업장 갯수 표시
    기존 년별 조회에서 기간으로 조회
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
        //============================================================================================
        //(2012-10-22 수정) 시작
        // 박은규 2012-10-22 CSR#(CH201210_00118) 요청자:홍호준(식품연구소)
        // 년도조회에서 기간조회로 변경
        //============================================================================================
        //String strYear				= nullToBlank(ds_input.getString(0, "YEAR"));
        //String strPreYear 			= nullToBlank(ds_input.getString(0, "PRE_YEAR"));
        String strFromDate = nullToBlank(ds_input.getString(0, "FROM_DATE"));
        String strToDate = nullToBlank(ds_input.getString(0, "TO_DATE"));
        //============================================================================================
        //(2012-10-22 수정) 끝
        //============================================================================================
        String strTeamMstSabun = nullToBlank(ds_input.getString(0, "TEAM_MST_SABUN"));
        String strSubteamMstSabun = nullToBlank(ds_input.getString(0, "SUBTEAM_MST_SABUN"));

        //out 데이타
        DataSet ds_list;

        //sql문 버퍼생성
        StringBuffer sbSql = new StringBuffer();

        sbSql.delete(0, sbSql.length());
        sbSql.append("SELECT (SELECT DISTINCT MU_CD FROM HLDC_SC_DEPT_V WHERE A.TM_CD = TM_CD AND ROWNUM = 1) AS MU_CD \n");
        sbSql.append("     , (SELECT DISTINCT MU_NM FROM HLDC_SC_DEPT_V WHERE A.TM_CD = TM_CD AND ROWNUM = 1) AS MU_NM \n");
        sbSql.append("     , TM_CD \n");
        sbSql.append("     , (SELECT DISTINCT TM_NM FROM HLDC_SC_DEPT_V WHERE A.TM_CD = TM_CD) AS TM_NM \n");
        sbSql.append("     , TEAM_MST_SABUN \n");
        sbSql.append("     , (SELECT NM_KOR FROM HLDC_HR_PERSONAL WHERE SABUN =  A.TEAM_MST_SABUN) AS TEAM_MST_NM \n");
        sbSql.append("     , SUBTEAM_MST_SABUN \n");
        sbSql.append(
                "     , (SELECT NM_KOR FROM HLDC_HR_PERSONAL WHERE SABUN = A.SUBTEAM_MST_SABUN) AS SUBTEAM_MST_NM \n");
        //============================================================================================
        //(2012-10-22 추가) 시작
        // 박은규 2012-10-22 CSR#(CH201210_00118) 요청자:홍호준(식품연구소)
        // 운영사업장 전체갯수, 부적합사업장 갯수 표시
        //============================================================================================
        sbSql.append("     , (SELECT COUNT(1) FROM SCO_UPJANG_MST_V Z \n");
        sbSql.append("         WHERE Z.TM_CD = A.TM_CD \n");
        sbSql.append("           AND Z.TEAM_MST_SABUN = A.TEAM_MST_SABUN \n");
        sbSql.append("           AND Z.SUBTEAM_MST_SABUN = A.SUBTEAM_MST_SABUN \n");
        //sbSql.append("           AND '" + strYear + "' BETWEEN SUBSTR(Z.OPEN_DATE,1,4) AND NVL(SUBSTR(Z.CLOSE_DATE,1,4),'9999') \n");
        sbSql.append("           AND Z.OPEN_DATE <= '" + strToDate + "' \n");
        sbSql.append("           AND NVL(Z.CLOSE_DATE,'99999999') >= '" + strFromDate + "' \n");
        sbSql.append("       ) AS UPJ_TOT \n");
        //============================================================================================
        //(2012-10-22 추가) 끝
        //============================================================================================
        sbSql.append("     , SUM(CNT1+CNT2+CNT3+CNT4) AS CNT_TOT \n");
        //============================================================================================
        //(2012-04-16 추가) 시작
        // 박은규 2012-04-16 CSR#(SR201204_09204) 요청자:김희선(건강관리센터)
        // 특별점검 여부 추가 : 결과조회/출력에서 평균점수에서 제외
        //============================================================================================
        sbSql.append("     , SUM(DECODE(SP_FLAG,'Y',0,CNT1+CNT2+CNT3+CNT4)) AS CNT_TOTR \n");
        //============================================================================================
        //(2012-04-16 추가) 시작
        //============================================================================================
        sbSql.append("     , SUM(DECODE(SP_FLAG,'Y',0,SCORE)) AS SCORE_TOT \n");
        sbSql.append("     , SUM(NOT_FIT) AS NOT_FIT_TOT \n");
        //특별점검은 점수에서 제외
        sbSql.append("     , SUM(DECODE(SP_FLAG,'Y',0,SCORE0)) AS SCORE0 \n");
        sbSql.append("     , SUM(DECODE(SP_FLAG,'Y',0,SCORE1)) AS SCORE1 \n");
        sbSql.append("     , SUM(DECODE(SP_FLAG,'Y',0,SCORE2)) AS SCORE2 \n");
        sbSql.append("     , SUM(DECODE(SP_FLAG,'Y',0,SCORE3)) AS SCORE3 \n");
        sbSql.append("     , SUM(DECODE(SP_FLAG,'Y',0,SCORE4)) AS SCORE4 \n");
        sbSql.append("     , SUM(NOT_FIT0) AS NOT_FIT0 \n");
        sbSql.append("     , SUM(NOT_FIT1) AS NOT_FIT1 \n");
        sbSql.append("     , SUM(NOT_FIT2) AS NOT_FIT2 \n");
        sbSql.append("     , SUM(NOT_FIT3) AS NOT_FIT3 \n");
        sbSql.append("     , SUM(NOT_FIT4) AS NOT_FIT4 \n");
        sbSql.append("     , SUM(CNT0) AS CNT0 \n");
        sbSql.append("     , SUM(CNT1) AS CNT1 \n");
        sbSql.append("     , SUM(CNT2) AS CNT2 \n");
        sbSql.append("     , SUM(CNT3) AS CNT3 \n");
        sbSql.append("     , SUM(CNT4) AS CNT4 \n");
        //============================================================================================
        //(2012-04-16 추가) 시작
        // 박은규 2012-04-16 CSR#(SR201204_09204) 요청자:김희선(건강관리센터)
        // 특별점검 여부 추가 : 결과조회/출력에서 평균점수에서 제외
        //============================================================================================
        sbSql.append("     , SUM(DECODE(SP_FLAG,'Y',0,CNT0)) AS CNTR0 \n");
        sbSql.append("     , SUM(DECODE(SP_FLAG,'Y',0,CNT1)) AS CNTR1 \n");
        sbSql.append("     , SUM(DECODE(SP_FLAG,'Y',0,CNT2)) AS CNTR2 \n");
        sbSql.append("     , SUM(DECODE(SP_FLAG,'Y',0,CNT3)) AS CNTR3 \n");
        sbSql.append("     , SUM(DECODE(SP_FLAG,'Y',0,CNT4)) AS CNTR4 \n");
        //============================================================================================
        //(2012-04-16 추가) 시작
        //============================================================================================
        sbSql.append("  FROM ( \n");
        //============================================================================================
        //(2012-10-22 삭제) 시작
        // 박은규 2012-10-22 CSR#(CH201210_00118) 요청자:홍호준(식품연구소)
        // 년도조회에서 기간조회로 변경
        //============================================================================================
        /*
                sbSql.append("        SELECT TM_CD \n");
                sbSql.append("             , TEAM_MST_SABUN \n");
                sbSql.append("             , SUBTEAM_MST_SABUN \n");
                sbSql.append("             , 0 SCORE \n");
                sbSql.append("             , SCORE AS SCORE0 \n");
                sbSql.append("             , 0 SCORE1 \n");
                sbSql.append("             , 0 SCORE2 \n");
                sbSql.append("             , 0 SCORE3 \n");
                sbSql.append("             , 0 SCORE4 \n");
                sbSql.append("             , 0 NOT_FIT \n");
                sbSql.append("             , NOT_FIT_YN NOT_FIT0 \n");
                sbSql.append("             , 0 NOT_FIT1 \n");
                sbSql.append("             , 0 NOT_FIT2 \n");
                sbSql.append("             , 0 NOT_FIT3 \n");
                sbSql.append("             , 0 NOT_FIT4 \n");
                sbSql.append("             , 1 CNT0 \n");
                sbSql.append("             , 0 CNT1 \n");
                sbSql.append("             , 0 CNT2 \n");
                sbSql.append("             , 0 CNT3 \n");
                sbSql.append("             , 0 CNT4 \n");
                sbSql.append("             , (SELECT NVL(Z.SET1,'N') FROM SCC_COMMON_CODE Z WHERE Z.GROUP_CODE = 'FS0042' AND Z.CODE = A.CHECK_TYPE) AS SP_FLAG \n");
                sbSql.append("          FROM FSC_RESULT_MST A \n");
                sbSql.append("         WHERE CONFIRM_YN = 'Y' \n");
                if (! strTableType.equals(""))
                    sbSql.append("           AND TABLE_TYPE = '" + strTableType + "' \n");
                sbSql.append("           AND SUBSTR(CHECK_DATE,1,6) BETWEEN '" + strPreYear + "10' AND '" + strPreYear + "12' \n");
                sbSql.append("           AND CHECK_TYPE IN (" + strCheckType + ") \n");
                if (strTmCD.length() != 0)				sbSql.append("           AND TM_CD = '" + strTmCD + "' \n");
                if (strTeamMstSabun.length() != 0)		sbSql.append("           AND TEAM_MST_SABUN ='" + strTeamMstSabun + "' \n");
                if (strSubteamMstSabun.length() != 0)	sbSql.append("           AND SUBTEAM_MST_SABUN ='" + strSubteamMstSabun + "' \n");
                sbSql.append("        UNION ALL \n");
        */
        //============================================================================================
        //(2012-10-22 삭제) 끝
        //============================================================================================
        sbSql.append("        SELECT TM_CD \n");
        sbSql.append("             , TEAM_MST_SABUN \n");
        sbSql.append("             , SUBTEAM_MST_SABUN \n");
        sbSql.append("             , SCORE \n");
        sbSql.append("             , 0 SCORE0 \n");
        sbSql.append("             , SCORE AS SCORE1 \n");
        sbSql.append("             , 0 SCORE2 \n");
        sbSql.append("             , 0 SCORE3 \n");
        sbSql.append("             , 0 SCORE4 \n");
        sbSql.append("             , NOT_FIT_YN NOT_FIT \n");
        sbSql.append("             , 0 NOT_FIT0 \n");
        sbSql.append("             , NOT_FIT_YN  NOT_FIT1 \n");
        sbSql.append("             , 0 NOT_FIT2 \n");
        sbSql.append("             , 0 NOT_FIT3 \n");
        sbSql.append("             , 0 NOT_FIT4 \n");
        sbSql.append("             , 0 CNT0 \n");
        sbSql.append("             , 1 CNT1 \n");
        sbSql.append("             , 0 CNT2 \n");
        sbSql.append("             , 0 CNT3 \n");
        sbSql.append("             , 0 CNT4 \n");
        sbSql.append(
                "             , (SELECT NVL(Z.SET1,'N') FROM SCC_COMMON_CODE Z WHERE Z.GROUP_CODE = 'FS0042' AND Z.CODE = A.CHECK_TYPE) AS SP_FLAG \n");
        sbSql.append("          FROM FSC_RESULT_MST A \n");
        sbSql.append("         WHERE CONFIRM_YN = 'Y' \n");
        if (!strTableType.equals(""))
            sbSql.append("           AND TABLE_TYPE = '" + strTableType + "' \n");
        //============================================================================================
        //(2012-10-22 수정) 시작
        // 박은규 2012-10-22 CSR#(CH201210_00118) 요청자:홍호준(식품연구소)
        // 년도조회에서 기간조회로 변경
        //============================================================================================
        //sbSql.append("           AND SUBSTR(CHECK_DATE,1,6) BETWEEN '" + strYear + "01' AND '" + strYear + "03' \n");
        sbSql.append("           AND CHECK_DATE BETWEEN SUBSTR('" + strFromDate + "',1,4)||'0101' AND SUBSTR('"
                + strToDate + "',1,4)||'0631' \n");
        //============================================================================================
        //(2012-10-22 수정) 끝
        //============================================================================================
        sbSql.append("           AND CHECK_TYPE IN (" + strCheckType + ") \n");
        if (strMuCD.length() != 0)
            sbSql.append("           AND (SELECT DISTINCT MU_CD FROM HLDC_SC_DEPT_V WHERE A.TM_CD = TM_CD AND ROWNUM = 1) = '" + strMuCD + "' \n");
        if (strTmCD.length() != 0)
            sbSql.append("           AND TM_CD = '" + strTmCD + "' \n");
        if (strTeamMstSabun.length() != 0)
            sbSql.append("           AND TEAM_MST_SABUN ='" + strTeamMstSabun + "' \n");
        if (strSubteamMstSabun.length() != 0)
            sbSql.append("           AND SUBTEAM_MST_SABUN ='" + strSubteamMstSabun + "' \n");
        sbSql.append("        UNION ALL \n");
        sbSql.append("        SELECT TM_CD \n");
        sbSql.append("             , TEAM_MST_SABUN \n");
        sbSql.append("             , SUBTEAM_MST_SABUN \n");
        sbSql.append("             , SCORE \n");
        sbSql.append("             , 0 SCORE0 \n");
        sbSql.append("             , 0 SCORE1 \n");
        sbSql.append("             , 0 SCORE2 \n");
        sbSql.append("             , 0 SCORE3 \n");
        sbSql.append("             , SCORE AS SCORE4 \n");
        sbSql.append("             , NOT_FIT_YN NOT_FIT \n");
        sbSql.append("             , 0 NOT_FIT0 \n");
        sbSql.append("             , 0 NOT_FIT1 \n");
        sbSql.append("             , 0 NOT_FIT2 \n");
        sbSql.append("             , 0 NOT_FIT3 \n");
        sbSql.append("             , NOT_FIT_YN NOT_FIT4 \n");
        sbSql.append("             , 0 CNT0 \n");
        sbSql.append("             , 0 CNT1 \n");
        sbSql.append("             , 0 CNT2 \n");
        sbSql.append("             , 0 CNT3 \n");
        sbSql.append("             , 1 CNT4 \n");
        sbSql.append(
                "             , (SELECT NVL(Z.SET1,'N') FROM SCC_COMMON_CODE Z WHERE Z.GROUP_CODE = 'FS0042' AND Z.CODE = A.CHECK_TYPE) AS SP_FLAG \n");
        sbSql.append("          FROM FSC_RESULT_MST A \n");
        sbSql.append("         WHERE CONFIRM_YN = 'Y' \n");
        if (!strTableType.equals(""))
            sbSql.append("           AND TABLE_TYPE = '" + strTableType + "' \n");
        //============================================================================================
        //(2012-10-22 수정) 시작
        // 박은규 2012-10-22 CSR#(CH201210_00118) 요청자:홍호준(식품연구소)
        // 년도조회에서 기간조회로 변경
        //============================================================================================
        //sbSql.append("           AND SUBSTR(CHECK_DATE,1,6) BETWEEN '" + strYear + "10' AND '" + strYear + "12' \n");
        sbSql.append("           AND CHECK_DATE BETWEEN SUBSTR('" + strFromDate + "',1,4)||'0701' AND SUBSTR('"
                + strToDate + "',1,4)||'1231' \n");
        //============================================================================================
        //(2012-10-22 수정) 끝
        //============================================================================================
        sbSql.append("           AND CHECK_TYPE IN (" + strCheckType + ") \n");
        if (strMuCD.length() != 0)
            sbSql.append("           AND (SELECT DISTINCT MU_CD FROM HLDC_SC_DEPT_V WHERE A.TM_CD = TM_CD AND ROWNUM = 1) = '" + strMuCD + "' \n");
        if (strTmCD.length() != 0)
            sbSql.append("           AND TM_CD = '" + strTmCD + "' \n");
        if (strTeamMstSabun.length() != 0)
            sbSql.append("           AND TEAM_MST_SABUN ='" + strTeamMstSabun + "' \n");
        if (strSubteamMstSabun.length() != 0)
            sbSql.append("           AND SUBTEAM_MST_SABUN ='" + strSubteamMstSabun + "' \n");
        sbSql.append("       ) A \n");
        sbSql.append("GROUP BY TM_CD, TEAM_MST_SABUN, SUBTEAM_MST_SABUN \n");

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