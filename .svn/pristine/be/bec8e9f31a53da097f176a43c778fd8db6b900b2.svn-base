
<%
    /*-----------------------------------------------------------------------------
    ■ 시스템명     : 메뉴관리/위생관리
    ■ 프로그램ID   : FSC00060V_T001.jsp
    ■ 프로그램명   : 점검자별 점검결과 조회
    ■ 작성일자     : 2008-03-26
    ■ 작성자       : 박지영
    ■ 이력관리     : 2008-03-26 최초작성
      : 박은규 2009-01-14 CSR#(23819) 요청자:이명희(건강관리센터)
        폐점업장 제외 추가 및 식재업장 조회제외.

      : 김장욱 2013-08-02 CSR#(SR201308_00561) 요청자:홍호준(식품연구소)

        수검자의 동명이인 증가로 수검자에 사번을 추가로 보여준다.
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
        String strFromDt = nullToBlank(ds_input.getString(0, "FROM_DT"));
        String strToDt = nullToBlank(ds_input.getString(0, "TO_DT"));
        String strCheckType = nullToBlank(ds_input.getString(0, "CHECK_TYPE"));
        String strCheckAll = nullToBlank(ds_input.getString(0, "CHECK_ALL"));
        String strCheckExc = nullToBlank(ds_input.getString(0, "CHECK_EXC"));
        String strMuCD = nullToBlank(ds_input.getString(0, "MU_CD"));
        String strTmCD = nullToBlank(ds_input.getString(0, "TM_CD"));
        String strJob = nullToBlank(ds_input.getString(0, "JOB"));
        String strSubJob = nullToBlank(ds_input.getString(0, "SUB_JOB"));
        String strUpjang = nullToBlank(ds_input.getString(0, "UPJANG"));
        String strFromScore = nullToBlank(ds_input.getString(0, "FROM_SCORE"));
        String strToScore = nullToBlank(ds_input.getString(0, "TO_SCORE"));
        String strFromAvgMealQty = nullToBlank(ds_input.getString(0, "FROM_AVG_MEAL_QTY"));
        String strToAvgMealQty = nullToBlank(ds_input.getString(0, "TO_AVG_MEAL_QTY"));
        String strFromMealCnt = nullToBlank(ds_input.getString(0, "FROM_MEAL_CNT"));
        String strToMealCnt = nullToBlank(ds_input.getString(0, "TO_MEAL_CNT"));
        String strFromMenuCnt = nullToBlank(ds_input.getString(0, "FROM_MENU_CNT"));
        String strToMenuCnt = nullToBlank(ds_input.getString(0, "TO_MENU_CNT"));
        String strDistType = nullToBlank(ds_input.getString(0, "DIST_TYPE"));
        String strChkSub = nullToBlank(ds_input.getString(0, "CHK_SUB_YN"));
        String strFromCnt = nullToBlank(ds_input.getString(0, "FROM_CNT"));
        String strToCnt = nullToBlank(ds_input.getString(0, "TO_CNT"));
        String strCheckSabun = nullToBlank(ds_input.getString(0, "CHECK_SABUN"));
        
        //out 데이타
        DataSet ds_list;

        //sql문 버퍼생성
        StringBuffer sbSql = new StringBuffer();

        sbSql.delete(0, sbSql.length());
        sbSql.append("SELECT A.* \n");
        sbSql.append("     , B.UPJANG \n");
        sbSql.append("     , B.UPJANGNM \n");
        sbSql.append("     , (SELECT COUNT(*) FROM FSC_RESULT_MST Z \n");
        sbSql.append("         WHERE Z.CONFIRM_YN = 'Y' \n");
        if (strTableType.length() != 0)
            sbSql.append("           AND Z.TABLE_TYPE = '" + strTableType + "' \n");
        sbSql.append("           AND Z.CHECK_DATE BETWEEN '" + strFromDt + "' AND '" + strToDt + "' \n");
        sbSql.append("           AND Z.CHECK_TYPE IN (" + strCheckType + ") \n");
        sbSql.append("           AND Z.UPJANG = A.UPJANG_A \n");
        sbSql.append("           AND Z.TABLE_TYPE = A.TABLE_TYPE) AS CNT \n");
        sbSql.append("     , B.JOB_CD \n");
        sbSql.append("     , B.JOB_NAME \n");
        sbSql.append("     , B.SUB_JOB_CD \n");
        sbSql.append("     , B.SUB_JOB_NAME \n");
        sbSql.append("     , B.MU_NAME AS MU_NM \n");
        sbSql.append("     , B.TM_NAME AS TM_NM \n");        
        sbSql.append("  FROM \n");
        sbSql.append("( \n");
        sbSql.append("SELECT A.TABLE_TYPE \n");
        sbSql.append(
                "     , (SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0041' AND A.TABLE_TYPE = CODE) AS TABLE_TYPE_NM \n");
        sbSql.append("     , A.FORM_CD \n");
        sbSql.append("     , A.UPJANG AS UPJANG_A \n");
        sbSql.append("     , A.CHECK_DATE \n");
        sbSql.append("     , A.CHECK_TYPE \n");
        sbSql.append("     , (SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0042' AND A.CHECK_TYPE = CODE) AS CHECK_TYPE_NM \n");
        sbSql.append("     , A.LEAD_CHECK_TYPE \n");
        sbSql.append("     , A.CHECK_SABUN \n");
        sbSql.append("     , (SELECT NM_KOR FROM SCO_FS_HR_PERSONAL_V WHERE A.CHECK_SABUN = SABUN) AS CHECK_SABUN_NM \n");
        sbSql.append("     , (SELECT DISTINCT MU_CD FROM HLDC_SC_DEPT_V WHERE A.TM_CD = TM_CD AND ROWNUM = 1) AS MU_CD \n");
        sbSql.append("     , A.TM_CD \n");
        sbSql.append("     , A.TEAM_MST_SABUN \n");
        sbSql.append("     , A.SUBTEAM_MST_SABUN \n");
        sbSql.append("     , A.LEADER_SABUN \n");
        sbSql.append("     , A.CHARGE_SABUN \n");
        //============================================================================================
        //(2013-08-02 변경) 시작
        // 김장욱 2013-08-02 CSR#(SR201308_00561) 요청자:홍호준(식품연구소)
        // 수검자의 동명이인 증가로 수검자에 사번을 추가로 보여준다.
        //============================================================================================
        //sbSql.append("     , (SELECT Z.NM_KOR FROM HLDC_HR_PERSONAL Z WHERE Z.SABUN =  A.CHARGE_SABUN) AS CHARGE_NM \n");

        sbSql.append(
                "     , (SELECT Z.NM_KOR FROM HLDC_HR_PERSONAL Z WHERE Z.SABUN =  A.CHARGE_SABUN) || ' (' || A.CHARGE_SABUN || ')' AS CHARGE_NM \n");
        //============================================================================================
        //(2013-08-02 변경) 끝
        //============================================================================================

        sbSql.append(
                "     , (SELECT Z.NM_KOR FROM HLDC_HR_PERSONAL Z WHERE Z.SABUN =  A.TEAM_MST_SABUN) AS TEAM_MST_NM \n");
        sbSql.append(
                "     , (SELECT Z.NM_KOR FROM HLDC_HR_PERSONAL Z WHERE Z.SABUN =  A.SUBTEAM_MST_SABUN) AS SUBTEAM_MST_NM \n");
        sbSql.append("     , A.KUNSOK \n");
        sbSql.append("     , A.WATER_IRRIGATION \n");
        sbSql.append("     , A.OPEN_DATE \n");
        sbSql.append("     , A.PERMISSION_TYPE \n");
        sbSql.append("     , A.PERSON_CNT \n");
        sbSql.append("     , A.DIST_TYPE \n");
        sbSql.append(
                "     , (SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'MA0005' AND CODE = A.DIST_TYPE) AS DIST_TYPE_NM \n");
        sbSql.append("     , A.AVG_MEAL_QTY \n");
        sbSql.append("     , A.MEAL_CNT \n");
        sbSql.append("     , A.MENU_CNT \n");
        sbSql.append("     , A.SPECIAL_FACT \n");
        sbSql.append("     , ROUND(A.SCORE, 1) AS SCORE \n");
        sbSql.append("     , FSC_GETPATROL_FUN(A.TABLE_TYPE, A.FORM_CD, A.UPJANG, A.CHECK_DATE, 'N') AS PATROL \n");
        sbSql.append("     , FSC_GETPATROL_FUN(A.TABLE_TYPE, A.FORM_CD, A.UPJANG, A.CHECK_DATE, 'Y') AS PATROL_100 \n");
        sbSql.append("     , FSC_GETPATROL_AVG_FUN(A.TABLE_TYPE, A.UPJANG, '" + strFromDt + "', '" + strToDt
                + "') AS PATROL_AVG \n");
        sbSql.append("     , A.NOT_FIT_TOT_CNT \n");
        sbSql.append("     , A.INDICATE_CNT \n");
        sbSql.append("     , A.CONFIRM_YN \n");
        sbSql.append("     , CASE WHEN A.SCORE >= 90 THEN 'A' \n");
        sbSql.append("	        WHEN A.SCORE >= 80 THEN 'B' \n");
        sbSql.append("	        WHEN A.SCORE >= 70 THEN 'C' \n");
        sbSql.append("		    WHEN A.SCORE >= 60 THEN 'D' \n");
        sbSql.append("	        ELSE 'E' \n");
        sbSql.append("	   END GRADE \n");
        sbSql.append("     , NOT_FIT_YN NOT_FIT \n");
        sbSql.append("     , NVL2(A.IMPROV_RPT_DATE,'Y','N') AS WRITE_YN \n");
        sbSql.append("     , IMPROV_CONFIRM_DATE \n");
        sbSql.append("     , CONFIRM_SABUN \n");
        sbSql.append(
                "     , (SELECT NM_KOR FROM SCO_FS_HR_PERSONAL_V WHERE A.CONFIRM_SABUN = SABUN) CONFIRM_SABUN_NM \n");
        sbSql.append("     , RESP_SABUN1 \n");
        sbSql.append("     , RESP_SABUN2 \n");
        sbSql.append("     , RESP_SABUN3 \n");
        sbSql.append("     , DECODE(A.RESP_SABUN1, NULL, '', (SELECT NM_KOR FROM HLDC_HR_PERSONAL WHERE SABUN = A.RESP_SABUN1)  || ' (' || A.RESP_SABUN1 || ')') AS RESP_SABUN1_NM \n");
        sbSql.append("     , DECODE(A.RESP_SABUN2, NULL, '', (SELECT NM_KOR FROM HLDC_HR_PERSONAL WHERE SABUN = A.RESP_SABUN2)  || ' (' || A.RESP_SABUN2 || ')') AS RESP_SABUN2_NM \n");
        sbSql.append("     , DECODE(A.RESP_SABUN3, NULL, '', (SELECT NM_KOR FROM HLDC_HR_PERSONAL WHERE SABUN = A.RESP_SABUN3)  || ' (' || A.RESP_SABUN3 || ')') AS RESP_SABUN3_NM \n");
        sbSql.append("  FROM FSC_RESULT_MST A \n");
        sbSql.append(" WHERE A.CONFIRM_YN = 'Y' \n");
        if (strTableType.length() != 0)
            sbSql.append("   AND A.TABLE_TYPE = '" + strTableType + "' \n");
        sbSql.append("   AND A.CHECK_DATE BETWEEN '" + strFromDt + "' AND '" + strToDt + "' \n");
        sbSql.append("   AND A.CHECK_TYPE IN (" + strCheckType + ") \n");
        if (strMuCD.length() != 0)
            //sbSql.append("   AND (SELECT DISTINCT MU_CD FROM HLDC_SC_DEPT_V WHERE A.TM_CD = TM_CD AND ROWNUM = 1) = '" + strMuCD + "' \n");
        	//과거 데이터 조회를 위해 MU의 업장을 기준으로 조회
        	sbSql.append("   AND A.UPJANG IN (SELECT B.UPJANG FROM HLDC_SC_DEPT_V A, ST_UPJANG B WHERE A.DEPT_ID = B.DEPT_ID AND A.MU_CD = '" + strMuCD + "') \n");
        if (strTmCD.length() != 0)
            //sbSql.append("   AND A.TM_CD = '" + strTmCD + "' \n");
        	//과거 데이터 조회를 위해 팀의 업장을 기준으로 조회
        	sbSql.append("   AND A.UPJANG IN (SELECT B.UPJANG FROM HLDC_SC_DEPT_V A, ST_UPJANG B WHERE A.DEPT_ID = B.DEPT_ID AND A.TM_CD = '" + strTmCD + "') \n");
        if (strUpjang.length() != 0)
            sbSql.append("   AND A.UPJANG = " + strUpjang + " \n");
        if (strFromScore.length() != 0)
            sbSql.append("   AND A.SCORE >= " + strFromScore + " \n");
        if (strToScore.length() != 0)
            sbSql.append("   AND A.SCORE <= " + strToScore + " \n");
        if (strFromAvgMealQty.length() != 0)
            sbSql.append("   AND A.AVG_MEAL_QTY >= " + strFromAvgMealQty + " \n");
        if (strToAvgMealQty.length() != 0)
            sbSql.append("   AND A.AVG_MEAL_QTY <= " + strToAvgMealQty + " \n");
        if (strFromMealCnt.length() != 0)
            sbSql.append("   AND A.MEAL_CNT >= " + strFromMealCnt + " \n");
        if (strToMealCnt.length() != 0)
            sbSql.append("   AND A.MEAL_CNT <= " + strToMealCnt + " \n");
        if (strFromMenuCnt.length() != 0)
            sbSql.append("   AND A.MENU_CNT >= " + strFromMenuCnt + " \n");
        if (strToMenuCnt.length() != 0)
            sbSql.append("   AND A.MENU_CNT <= " + strToMenuCnt + " \n");
        if (strDistType.length() != 0)
            sbSql.append("   AND A.DIST_TYPE = '" + strDistType + "' \n");
        if (strCheckSabun.length() != 0)
            sbSql.append("   AND A.CHECK_SABUN = '" + strCheckSabun + "' \n");
        if (strChkSub.equals("Y")) {
            sbSql.append("   AND EXISTS ( \n");
            sbSql.append("                 SELECT 1 \n");
            sbSql.append("                   FROM FSC_RESULT_MST X \n");
            sbSql.append("                  WHERE X.CONFIRM_YN = 'Y' \n");
            if (strTableType.length() != 0)
                sbSql.append("                    AND X.TABLE_TYPE = '" + strTableType + "' \n");
            sbSql.append("                    AND X.CHECK_DATE BETWEEN '" + strFromDt + "' AND '" + strToDt + "' \n");
            sbSql.append("                    AND X.CHECK_TYPE IN (" + strCheckType + ") \n");
            sbSql.append("                    AND X.UPJANG = A.UPJANG \n");
            sbSql.append("                  GROUP BY X.UPJANG \n");
            sbSql.append("                 HAVING 1=1  \n");
            if (strFromCnt.length() != 0)
                sbSql.append("                    AND COUNT(*) >= " + strFromCnt + " \n");
            if (strToCnt.length() != 0)
                sbSql.append("                    AND COUNT(*) <= " + strToCnt + " \n");
            sbSql.append("               ) \n");
        }
        sbSql.append(") A, MAC_UPJANG_V B \n");
        if (strCheckAll.equals("Y")) {
        	sbSql.append(" , SCO_UPJANG_MST_V C \n");
            sbSql.append(" WHERE A.UPJANG_A(+) = B.UPJANG \n");
            sbSql.append("   AND B.UPJANG = C.UPJANG \n");
            sbSql.append("   AND B.MU_CD IN ('2002', '2003') \n");
            if (strMuCD.length() != 0)
                sbSql.append("   AND (SELECT DISTINCT MU_CD FROM HLDC_SC_DEPT_V WHERE A.TM_CD = TM_CD AND ROWNUM = 1) = '" + strMuCD
                        + "' \n");
//            if (strTmCD.length() != 0)
//                sbSql.append("   AND B.TM_CD = '" + strTmCD + "' \n");
        } else
            sbSql.append(" WHERE A.UPJANG_A = B.UPJANG \n");
        //============================================================================================
        //(2009-01-14 추가) 시작
        // 박은규 2009-01-14 CSR#(23819) 요청자:이명희(건강관리센터)
        // 폐점업장 제외 추가 및 식재업장 조회제외.
        //============================================================================================
        //		sbSql.append("   AND B.SAUP_TYPE <> '004' \n");
        if (strCheckExc.equals("Y"))
            sbSql.append("   AND B.CLOSE_DATE IS NULL \n");
        //============================================================================================
        //(2009-01-14 추가) 끝
        //============================================================================================
        if (strUpjang.length() != 0)
            sbSql.append("   AND B.UPJANG = " + strUpjang + " \n");
        if (strJob.length() != 0)
            sbSql.append("   AND B.JOB_CD = '" + strJob + "' \n");
        if (strSubJob.length() != 0)
            sbSql.append("   AND B.SUB_JOB_CD = '" + strSubJob + "' \n");
        sbSql.append(" ORDER BY B.MU_NAME, B.TM_NAME, B.JOB_CD, B.SUB_JOB_CD, B.UPJANG, A.CHECK_DATE\n");

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