
<%
    /*-----------------------------------------------------------------------------
    ■ 시스템명     : 메뉴관리/위생관리
    ■ 프로그램ID   : FSC00042V_T001.jsp
    ■ 프로그램명   : 월별 점검결과
    ■ 작성일자     : 2008-04-01
    ■ 작성자       : 박지영
    ■ 이력관리     : 2008-04-01
    1)박은규 2012-04-16 CSR#(SR201204_09204) 요청자:김희선(건강관리센터)
    특별점검 여부 추가 : 결과조회/출력에서 평균점수에서 제외
    2)박은규 2012-10-22 CSR#(CH201210_00118) 요청자:홍호준(식품연구소)
    운영업장수, 부적합수 표시
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
                "     , (SELECT NM_KOR FROM HLDC_HR_PERSONAL WHERE SABUN =  A.SUBTEAM_MST_SABUN) AS SUBTEAM_MST_NM \n");
        //============================================================================================
        //(2012-04-16 수정) 시작
        // 박은규 2012-04-16 CSR#(SR201204_09204) 요청자:김희선(건강관리센터)
        // 특별점검 여부 추가 : 결과조회/출력에서 평균점수에서 제외
        //============================================================================================
        sbSql.append("     , COUNT(*) AS CNT_TOT \n");
        sbSql.append("     , SUM(DECODE(A.SP_FLAG,'Y',0,1)) AS CNT_TOTR \n");
        sbSql.append("     , SUM(NOT_FIT) AS NOT_FIT_TOT \n");
        /*
                sbSql.append("     , SUM(SCORE) AS SCORE_TOT \n");
                sbSql.append("     , SUM(SCORE1) AS SCORE1 \n");
                sbSql.append("     , SUM(SCORE2) AS SCORE2 \n");
                sbSql.append("     , SUM(SCORE3) AS SCORE3 \n");
                sbSql.append("     , SUM(SCORE4) AS SCORE4 \n");
                sbSql.append("     , SUM(SCORE5) AS SCORE5 \n");
                sbSql.append("     , SUM(SCORE6) AS SCORE6 \n");
                sbSql.append("     , SUM(SCORE7) AS SCORE7 \n");
                sbSql.append("     , SUM(SCORE8) AS SCORE8 \n");
                sbSql.append("     , SUM(SCORE9) AS SCORE9 \n");
                sbSql.append("     , SUM(SCORE10) AS SCORE10 \n");
                sbSql.append("     , SUM(SCORE11) AS SCORE11 \n");
                sbSql.append("     , SUM(SCORE12) AS SCORE12 \n");
        */
        sbSql.append("     , SUM(DECODE(A.SP_FLAG,'Y',0,SCORE)) AS SCORE_TOT \n");
        sbSql.append("     , SUM(DECODE(A.SP_FLAG,'Y',0,SCORE1)) AS SCORE1 \n");
        sbSql.append("     , SUM(DECODE(A.SP_FLAG,'Y',0,SCORE2)) AS SCORE2 \n");
        sbSql.append("     , SUM(DECODE(A.SP_FLAG,'Y',0,SCORE3)) AS SCORE3 \n");
        sbSql.append("     , SUM(DECODE(A.SP_FLAG,'Y',0,SCORE4)) AS SCORE4 \n");
        sbSql.append("     , SUM(DECODE(A.SP_FLAG,'Y',0,SCORE5)) AS SCORE5 \n");
        sbSql.append("     , SUM(DECODE(A.SP_FLAG,'Y',0,SCORE6)) AS SCORE6 \n");
        sbSql.append("     , SUM(DECODE(A.SP_FLAG,'Y',0,SCORE7)) AS SCORE7 \n");
        sbSql.append("     , SUM(DECODE(A.SP_FLAG,'Y',0,SCORE8)) AS SCORE8 \n");
        sbSql.append("     , SUM(DECODE(A.SP_FLAG,'Y',0,SCORE9)) AS SCORE9 \n");
        sbSql.append("     , SUM(DECODE(A.SP_FLAG,'Y',0,SCORE10)) AS SCORE10 \n");
        sbSql.append("     , SUM(DECODE(A.SP_FLAG,'Y',0,SCORE11)) AS SCORE11 \n");
        sbSql.append("     , SUM(DECODE(A.SP_FLAG,'Y',0,SCORE12)) AS SCORE12 \n");
        sbSql.append("     , SUM(NOT_FIT1) AS NOT_FIT1 \n");
        sbSql.append("     , SUM(NOT_FIT2) AS NOT_FIT2 \n");
        sbSql.append("     , SUM(NOT_FIT3) AS NOT_FIT3 \n");
        sbSql.append("     , SUM(NOT_FIT4) AS NOT_FIT4 \n");
        sbSql.append("     , SUM(NOT_FIT5) AS NOT_FIT5 \n");
        sbSql.append("     , SUM(NOT_FIT6) AS NOT_FIT6 \n");
        sbSql.append("     , SUM(NOT_FIT7) AS NOT_FIT7 \n");
        sbSql.append("     , SUM(NOT_FIT8) AS NOT_FIT8 \n");
        sbSql.append("     , SUM(NOT_FIT9) AS NOT_FIT9 \n");
        sbSql.append("     , SUM(NOT_FIT10) AS NOT_FIT10 \n");
        sbSql.append("     , SUM(NOT_FIT11) AS NOT_FIT11 \n");
        sbSql.append("     , SUM(NOT_FIT12) AS NOT_FIT12 \n");
        sbSql.append("     , SUM(CNT1) AS CNT1 \n");
        sbSql.append("     , SUM(CNT2) AS CNT2 \n");
        sbSql.append("     , SUM(CNT3) AS CNT3 \n");
        sbSql.append("     , SUM(CNT4) AS CNT4 \n");
        sbSql.append("     , SUM(CNT5) AS CNT5 \n");
        sbSql.append("     , SUM(CNT6) AS CNT6 \n");
        sbSql.append("     , SUM(CNT7) AS CNT7 \n");
        sbSql.append("     , SUM(CNT8) AS CNT8 \n");
        sbSql.append("     , SUM(CNT9) AS CNT9 \n");
        sbSql.append("     , SUM(CNT10) AS CNT10 \n");
        sbSql.append("     , SUM(CNT11) AS CNT11 \n");
        sbSql.append("     , SUM(CNT12) AS CNT12 \n");
        sbSql.append("     , SUM(DECODE(A.SP_FLAG,'Y',0,CNT1)) AS CNTR1 \n");
        sbSql.append("     , SUM(DECODE(A.SP_FLAG,'Y',0,CNT2)) AS CNTR2 \n");
        sbSql.append("     , SUM(DECODE(A.SP_FLAG,'Y',0,CNT3)) AS CNTR3 \n");
        sbSql.append("     , SUM(DECODE(A.SP_FLAG,'Y',0,CNT4)) AS CNTR4 \n");
        sbSql.append("     , SUM(DECODE(A.SP_FLAG,'Y',0,CNT5)) AS CNTR5 \n");
        sbSql.append("     , SUM(DECODE(A.SP_FLAG,'Y',0,CNT6)) AS CNTR6 \n");
        sbSql.append("     , SUM(DECODE(A.SP_FLAG,'Y',0,CNT7)) AS CNTR7 \n");
        sbSql.append("     , SUM(DECODE(A.SP_FLAG,'Y',0,CNT8)) AS CNTR8 \n");
        sbSql.append("     , SUM(DECODE(A.SP_FLAG,'Y',0,CNT9)) AS CNTR9 \n");
        sbSql.append("     , SUM(DECODE(A.SP_FLAG,'Y',0,CNT10)) AS CNTR10 \n");
        sbSql.append("     , SUM(DECODE(A.SP_FLAG,'Y',0,CNT11)) AS CNTR11 \n");
        sbSql.append("     , SUM(DECODE(A.SP_FLAG,'Y',0,CNT12)) AS CNTR12 \n");
        //============================================================================================
        //(2012-04-16 수정) 끝
        //============================================================================================
        //============================================================================================
        //(2012-10-22 추가) 시작
        // 박은규 2012-10-22 CSR#(CH201210_00118) 요청자:홍호준(식품연구소)
        // 운영업장수 표시
        //============================================================================================
        sbSql.append("     , (SELECT COUNT(1) FROM SCO_UPJANG_MST_V Z \n");
        sbSql.append("         WHERE Z.TM_CD = A.TM_CD \n");
        sbSql.append("           AND Z.TEAM_MST_SABUN = A.TEAM_MST_SABUN \n");
        sbSql.append("           AND Z.SUBTEAM_MST_SABUN = A.SUBTEAM_MST_SABUN \n");
        //sbSql.append("           AND '" + strYear + "||01' BETWEEN SUBSTR(Z.OPEN_DATE,1,6) AND NVL(SUBSTR(Z.CLOSE_DATE,1,6),'999999') \n");
        sbSql.append("           AND Z.OPEN_DATE <= SUBSTR('" + strToDate + "',1,4)||'0131' \n");
        sbSql.append("           AND NVL(Z.CLOSE_DATE,'99999999') >= SUBSTR('" + strFromDate + "',1,4)||'0101' \n");
        sbSql.append("       ) AS UPJ_CNT1 \n");
        sbSql.append("     , (SELECT COUNT(1) FROM SCO_UPJANG_MST_V Z \n");
        sbSql.append("         WHERE Z.TM_CD = A.TM_CD \n");
        sbSql.append("           AND Z.TEAM_MST_SABUN = A.TEAM_MST_SABUN \n");
        sbSql.append("           AND Z.SUBTEAM_MST_SABUN = A.SUBTEAM_MST_SABUN \n");
        //sbSql.append("           AND '" + strYear + "||02' BETWEEN SUBSTR(Z.OPEN_DATE,1,6) AND NVL(SUBSTR(Z.CLOSE_DATE,1,6),'999999') \n");
        sbSql.append("           AND Z.OPEN_DATE <= SUBSTR('" + strToDate + "',1,4)||'0231' \n");
        sbSql.append("           AND NVL(Z.CLOSE_DATE,'99999999') >= SUBSTR('" + strFromDate + "',1,4)||'0201' \n");
        sbSql.append("       ) AS UPJ_CNT2 \n");
        sbSql.append("     , (SELECT COUNT(1) FROM SCO_UPJANG_MST_V Z \n");
        sbSql.append("         WHERE Z.TM_CD = A.TM_CD \n");
        sbSql.append("           AND Z.TEAM_MST_SABUN = A.TEAM_MST_SABUN \n");
        sbSql.append("           AND Z.SUBTEAM_MST_SABUN = A.SUBTEAM_MST_SABUN \n");
        //sbSql.append("           AND '" + strYear + "||03' BETWEEN SUBSTR(Z.OPEN_DATE,1,6) AND NVL(SUBSTR(Z.CLOSE_DATE,1,6),'999999') \n");
        sbSql.append("           AND Z.OPEN_DATE <= SUBSTR('" + strToDate + "',1,4)||'0331' \n");
        sbSql.append("           AND NVL(Z.CLOSE_DATE,'99999999') >= SUBSTR('" + strFromDate + "',1,4)||'0301' \n");
        sbSql.append("       ) AS UPJ_CNT3 \n");
        sbSql.append("     , (SELECT COUNT(1) FROM SCO_UPJANG_MST_V Z \n");
        sbSql.append("         WHERE Z.TM_CD = A.TM_CD \n");
        sbSql.append("           AND Z.TEAM_MST_SABUN = A.TEAM_MST_SABUN \n");
        sbSql.append("           AND Z.SUBTEAM_MST_SABUN = A.SUBTEAM_MST_SABUN \n");
        //sbSql.append("           AND '" + strYear + "||04' BETWEEN SUBSTR(Z.OPEN_DATE,1,6) AND NVL(SUBSTR(Z.CLOSE_DATE,1,6),'999999') \n");
        sbSql.append("           AND Z.OPEN_DATE <= SUBSTR('" + strToDate + "',1,4)||'0431' \n");
        sbSql.append("           AND NVL(Z.CLOSE_DATE,'99999999') >= SUBSTR('" + strFromDate + "',1,4)||'0401' \n");
        sbSql.append("       ) AS UPJ_CNT4 \n");
        sbSql.append("     , (SELECT COUNT(1) FROM SCO_UPJANG_MST_V Z \n");
        sbSql.append("         WHERE Z.TM_CD = A.TM_CD \n");
        sbSql.append("           AND Z.TEAM_MST_SABUN = A.TEAM_MST_SABUN \n");
        sbSql.append("           AND Z.SUBTEAM_MST_SABUN = A.SUBTEAM_MST_SABUN \n");
        //sbSql.append("           AND '" + strYear + "||05' BETWEEN SUBSTR(Z.OPEN_DATE,1,6) AND NVL(SUBSTR(Z.CLOSE_DATE,1,6),'999999') \n");
        sbSql.append("           AND Z.OPEN_DATE <= SUBSTR('" + strToDate + "',1,4)||'0531' \n");
        sbSql.append("           AND NVL(Z.CLOSE_DATE,'99999999') >= SUBSTR('" + strFromDate + "',1,4)||'0501' \n");
        sbSql.append("       ) AS UPJ_CNT5 \n");
        sbSql.append("     , (SELECT COUNT(1) FROM SCO_UPJANG_MST_V Z \n");
        sbSql.append("         WHERE Z.TM_CD = A.TM_CD \n");
        sbSql.append("           AND Z.TEAM_MST_SABUN = A.TEAM_MST_SABUN \n");
        sbSql.append("           AND Z.SUBTEAM_MST_SABUN = A.SUBTEAM_MST_SABUN \n");
        //sbSql.append("           AND '" + strYear + "||06' BETWEEN SUBSTR(Z.OPEN_DATE,1,6) AND NVL(SUBSTR(Z.CLOSE_DATE,1,6),'999999') \n");
        sbSql.append("           AND Z.OPEN_DATE <= SUBSTR('" + strToDate + "',1,4)||'0631' \n");
        sbSql.append("           AND NVL(Z.CLOSE_DATE,'99999999') >= SUBSTR('" + strFromDate + "',1,4)||'0601' \n");
        sbSql.append("       ) AS UPJ_CNT6 \n");
        sbSql.append("     , (SELECT COUNT(1) FROM SCO_UPJANG_MST_V Z \n");
        sbSql.append("         WHERE Z.TM_CD = A.TM_CD \n");
        sbSql.append("           AND Z.TEAM_MST_SABUN = A.TEAM_MST_SABUN \n");
        sbSql.append("           AND Z.SUBTEAM_MST_SABUN = A.SUBTEAM_MST_SABUN \n");
        //sbSql.append("           AND '" + strYear + "||07' BETWEEN SUBSTR(Z.OPEN_DATE,1,6) AND NVL(SUBSTR(Z.CLOSE_DATE,1,6),'999999') \n");
        sbSql.append("           AND Z.OPEN_DATE <= SUBSTR('" + strToDate + "',1,4)||'0731' \n");
        sbSql.append("           AND NVL(Z.CLOSE_DATE,'99999999') >= SUBSTR('" + strFromDate + "',1,4)||'0701' \n");
        sbSql.append("       ) AS UPJ_CNT7 \n");
        sbSql.append("     , (SELECT COUNT(1) FROM SCO_UPJANG_MST_V Z \n");
        sbSql.append("         WHERE Z.TM_CD = A.TM_CD \n");
        sbSql.append("           AND Z.TEAM_MST_SABUN = A.TEAM_MST_SABUN \n");
        sbSql.append("           AND Z.SUBTEAM_MST_SABUN = A.SUBTEAM_MST_SABUN \n");
        //sbSql.append("           AND '" + strYear + "||08' BETWEEN SUBSTR(Z.OPEN_DATE,1,6) AND NVL(SUBSTR(Z.CLOSE_DATE,1,6),'999999') \n");
        sbSql.append("           AND Z.OPEN_DATE <= SUBSTR('" + strToDate + "',1,4)||'0831' \n");
        sbSql.append("           AND NVL(Z.CLOSE_DATE,'99999999') >= SUBSTR('" + strFromDate + "',1,4)||'0801' \n");
        sbSql.append("       ) AS UPJ_CNT8 \n");
        sbSql.append("     , (SELECT COUNT(1) FROM SCO_UPJANG_MST_V Z \n");
        sbSql.append("         WHERE Z.TM_CD = A.TM_CD \n");
        sbSql.append("           AND Z.TEAM_MST_SABUN = A.TEAM_MST_SABUN \n");
        sbSql.append("           AND Z.SUBTEAM_MST_SABUN = A.SUBTEAM_MST_SABUN \n");
        //sbSql.append("           AND '" + strYear + "||09' BETWEEN SUBSTR(Z.OPEN_DATE,1,6) AND NVL(SUBSTR(Z.CLOSE_DATE,1,6),'999999') \n");
        sbSql.append("           AND Z.OPEN_DATE <= SUBSTR('" + strToDate + "',1,4)||'0931' \n");
        sbSql.append("           AND NVL(Z.CLOSE_DATE,'99999999') >= SUBSTR('" + strFromDate + "',1,4)||'0901' \n");
        sbSql.append("       ) AS UPJ_CNT9 \n");
        sbSql.append("     , (SELECT COUNT(1) FROM SCO_UPJANG_MST_V Z \n");
        sbSql.append("         WHERE Z.TM_CD = A.TM_CD \n");
        sbSql.append("           AND Z.TEAM_MST_SABUN = A.TEAM_MST_SABUN \n");
        sbSql.append("           AND Z.SUBTEAM_MST_SABUN = A.SUBTEAM_MST_SABUN \n");
        //sbSql.append("           AND '" + strYear + "||10' BETWEEN SUBSTR(Z.OPEN_DATE,1,6) AND NVL(SUBSTR(Z.CLOSE_DATE,1,6),'999999') \n");
        sbSql.append("           AND Z.OPEN_DATE <= SUBSTR('" + strToDate + "',1,4)||'1031' \n");
        sbSql.append("           AND NVL(Z.CLOSE_DATE,'99999999') >= SUBSTR('" + strFromDate + "',1,4)||'1001' \n");
        sbSql.append("       ) AS UPJ_CNT10 \n");
        sbSql.append("     , (SELECT COUNT(1) FROM SCO_UPJANG_MST_V Z \n");
        sbSql.append("         WHERE Z.TM_CD = A.TM_CD \n");
        sbSql.append("           AND Z.TEAM_MST_SABUN = A.TEAM_MST_SABUN \n");
        sbSql.append("           AND Z.SUBTEAM_MST_SABUN = A.SUBTEAM_MST_SABUN \n");
        //sbSql.append("           AND '" + strYear + "||11' BETWEEN SUBSTR(Z.OPEN_DATE,1,6) AND NVL(SUBSTR(Z.CLOSE_DATE,1,6),'999999') \n");
        sbSql.append("           AND Z.OPEN_DATE <= SUBSTR('" + strToDate + "',1,4)||'1131' \n");
        sbSql.append("           AND NVL(Z.CLOSE_DATE,'99999999') >= SUBSTR('" + strFromDate + "',1,4)||'1101' \n");
        sbSql.append("       ) AS UPJ_CNT11 \n");
        sbSql.append("     , (SELECT COUNT(1) FROM SCO_UPJANG_MST_V Z \n");
        sbSql.append("         WHERE Z.TM_CD = A.TM_CD \n");
        sbSql.append("           AND Z.TEAM_MST_SABUN = A.TEAM_MST_SABUN \n");
        sbSql.append("           AND Z.SUBTEAM_MST_SABUN = A.SUBTEAM_MST_SABUN \n");
        //sbSql.append("           AND '" + strYear + "||12' BETWEEN SUBSTR(Z.OPEN_DATE,1,6) AND NVL(SUBSTR(Z.CLOSE_DATE,1,6),'999999') \n");
        sbSql.append("           AND Z.OPEN_DATE <= SUBSTR('" + strToDate + "',1,4)||'1231' \n");
        sbSql.append("           AND NVL(Z.CLOSE_DATE,'99999999') >= SUBSTR('" + strFromDate + "',1,4)||'1201' \n");
        sbSql.append("       ) AS UPJ_CNT12 \n");
        //============================================================================================
        //(2012-10-22 추가) 끝
        //============================================================================================
        sbSql.append("  FROM ( \n");
        sbSql.append("        SELECT TM_CD \n");
        sbSql.append("             , TEAM_MST_SABUN \n");
        sbSql.append("             , SUBTEAM_MST_SABUN \n");
        sbSql.append("             , SCORE \n");
        sbSql.append("             , NOT_FIT_YN NOT_FIT \n");
        sbSql.append("             , CASE WHEN SUBSTR(CHECK_DATE,5,2) = '01' THEN SCORE ELSE 0 END SCORE1 \n");
        sbSql.append("             , CASE WHEN SUBSTR(CHECK_DATE,5,2) = '02' THEN SCORE ELSE 0 END SCORE2 \n");
        sbSql.append("             , CASE WHEN SUBSTR(CHECK_DATE,5,2) = '03' THEN SCORE ELSE 0 END SCORE3 \n");
        sbSql.append("             , CASE WHEN SUBSTR(CHECK_DATE,5,2) = '04' THEN SCORE ELSE 0 END SCORE4 \n");
        sbSql.append("             , CASE WHEN SUBSTR(CHECK_DATE,5,2) = '05' THEN SCORE ELSE 0 END SCORE5 \n");
        sbSql.append("             , CASE WHEN SUBSTR(CHECK_DATE,5,2) = '06' THEN SCORE ELSE 0 END SCORE6 \n");
        sbSql.append("             , CASE WHEN SUBSTR(CHECK_DATE,5,2) = '07' THEN SCORE ELSE 0 END SCORE7 \n");
        sbSql.append("             , CASE WHEN SUBSTR(CHECK_DATE,5,2) = '08' THEN SCORE ELSE 0 END SCORE8 \n");
        sbSql.append("             , CASE WHEN SUBSTR(CHECK_DATE,5,2) = '09' THEN SCORE ELSE 0 END SCORE9 \n");
        sbSql.append("             , CASE WHEN SUBSTR(CHECK_DATE,5,2) = '10' THEN SCORE ELSE 0 END SCORE10 \n");
        sbSql.append("             , CASE WHEN SUBSTR(CHECK_DATE,5,2) = '11' THEN SCORE ELSE 0 END SCORE11 \n");
        sbSql.append("             , CASE WHEN SUBSTR(CHECK_DATE,5,2) = '12' THEN SCORE ELSE 0 END SCORE12 \n");
        sbSql.append("             , CASE WHEN SUBSTR(CHECK_DATE,5,2) = '01' THEN NOT_FIT_YN ELSE 0 END NOT_FIT1 \n");
        sbSql.append("             , CASE WHEN SUBSTR(CHECK_DATE,5,2) = '02' THEN NOT_FIT_YN ELSE 0 END  NOT_FIT2 \n");
        sbSql.append("             , CASE WHEN SUBSTR(CHECK_DATE,5,2) = '03' THEN NOT_FIT_YN ELSE 0 END  NOT_FIT3 \n");
        sbSql.append("             , CASE WHEN SUBSTR(CHECK_DATE,5,2) = '04' THEN NOT_FIT_YN ELSE 0 END  NOT_FIT4 \n");
        sbSql.append("             , CASE WHEN SUBSTR(CHECK_DATE,5,2) = '05' THEN NOT_FIT_YN ELSE 0 END  NOT_FIT5 \n");
        sbSql.append("             , CASE WHEN SUBSTR(CHECK_DATE,5,2) = '06' THEN NOT_FIT_YN ELSE 0 END  NOT_FIT6 \n");
        sbSql.append("             , CASE WHEN SUBSTR(CHECK_DATE,5,2) = '07' THEN NOT_FIT_YN ELSE 0 END  NOT_FIT7 \n");
        sbSql.append("             , CASE WHEN SUBSTR(CHECK_DATE,5,2) = '08' THEN NOT_FIT_YN ELSE 0 END  NOT_FIT8 \n");
        sbSql.append("             , CASE WHEN SUBSTR(CHECK_DATE,5,2) = '09' THEN NOT_FIT_YN ELSE 0 END  NOT_FIT9 \n");
        sbSql.append("             , CASE WHEN SUBSTR(CHECK_DATE,5,2) = '10' THEN NOT_FIT_YN ELSE 0 END  NOT_FIT10 \n");
        sbSql.append("             , CASE WHEN SUBSTR(CHECK_DATE,5,2) = '11' THEN NOT_FIT_YN ELSE 0 END  NOT_FIT11 \n");
        sbSql.append("             , CASE WHEN SUBSTR(CHECK_DATE,5,2) = '12' THEN NOT_FIT_YN ELSE 0 END  NOT_FIT12 \n");
        sbSql.append("             , CASE WHEN SUBSTR(CHECK_DATE,5,2) = '01' THEN 1 ELSE 0 END CNT1 \n");
        sbSql.append("             , CASE WHEN SUBSTR(CHECK_DATE,5,2) = '02' THEN 1 ELSE 0 END CNT2 \n");
        sbSql.append("             , CASE WHEN SUBSTR(CHECK_DATE,5,2) = '03' THEN 1 ELSE 0 END CNT3 \n");
        sbSql.append("             , CASE WHEN SUBSTR(CHECK_DATE,5,2) = '04' THEN 1 ELSE 0 END CNT4 \n");
        sbSql.append("             , CASE WHEN SUBSTR(CHECK_DATE,5,2) = '05' THEN 1 ELSE 0 END CNT5 \n");
        sbSql.append("             , CASE WHEN SUBSTR(CHECK_DATE,5,2) = '06' THEN 1 ELSE 0 END CNT6 \n");
        sbSql.append("             , CASE WHEN SUBSTR(CHECK_DATE,5,2) = '07' THEN 1 ELSE 0 END CNT7 \n");
        sbSql.append("             , CASE WHEN SUBSTR(CHECK_DATE,5,2) = '08' THEN 1 ELSE 0 END CNT8 \n");
        sbSql.append("             , CASE WHEN SUBSTR(CHECK_DATE,5,2) = '09' THEN 1 ELSE 0 END CNT9 \n");
        sbSql.append("             , CASE WHEN SUBSTR(CHECK_DATE,5,2) = '10' THEN 1 ELSE 0 END CNT10 \n");
        sbSql.append("             , CASE WHEN SUBSTR(CHECK_DATE,5,2) = '11' THEN 1 ELSE 0 END CNT11 \n");
        sbSql.append("             , CASE WHEN SUBSTR(CHECK_DATE,5,2) = '12' THEN 1 ELSE 0 END CNT12 \n");
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
        //sbSql.append("           AND SUBSTR(CHECK_DATE,1,4) = '" + strYear + "' \n");
        sbSql.append("           AND CHECK_DATE BETWEEN '" + strFromDate + "' AND '" + strToDate + "' \n");
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