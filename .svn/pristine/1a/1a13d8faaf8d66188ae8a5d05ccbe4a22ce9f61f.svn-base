
<%
    /*-----------------------------------------------------------------------------
    ■ 시스템명     : 메뉴관리/위생관리
    ■ 프로그램ID   : FSC00060V_T003.jsp
    ■ 프로그램명   : 점검자별 점검결과 조회
    ■ 작성일자     : 2008-03-26
    ■ 작성자       : 박지영
    ■ 이력관리     : 2008-03-26
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
        String strCheckSabun = nullToBlank(ds_input.getString(0, "MST_CHECK_SABUN"));
        String strUpjang = nullToBlank(ds_input.getString(0, "UPJANG"));

        //out 데이타
        DataSet ds_list;

        //sql문 버퍼생성
        StringBuffer sbSql = new StringBuffer();

        // 정검양식조회
        sbSql.delete(0, sbSql.length());
        sbSql.append("SELECT A.CHECK_SABUN \n");
        sbSql.append("     , A.UPJANG \n");
        sbSql.append("     , A.CHECK_DATE \n");
        sbSql.append("     , ROUND(A.SCORE, 1) AS SCORE \n");
        sbSql.append("     , CASE WHEN A.SCORE >= 90 THEN 'A' \n");
        sbSql.append("            WHEN A.SCORE >= 80 THEN 'B' \n");
        sbSql.append("            WHEN A.SCORE >= 70 THEN 'C' \n");
        sbSql.append("            WHEN A.SCORE >= 60 THEN 'D' \n");
        sbSql.append("            ELSE 'E' \n");
        sbSql.append("       END GRADE \n");
        sbSql.append("     , NOT_FIT_YN NOT_FIT_TOT_CNT \n");
        sbSql.append("  FROM FSC_SAFE_RESULT_MST A \n");
        sbSql.append(" WHERE CONFIRM_YN = 'Y' \n");
        if (strTableType.length() != 0)
            sbSql.append("   AND TABLE_TYPE = '" + strTableType + "' \n");
        sbSql.append("   AND CHECK_DATE BETWEEN '" + strFromDt + "' AND '" + strToDt + "' \n");
        sbSql.append("   AND CHECK_TYPE IN (" + strCheckType + ") \n");
        sbSql.append("   AND CHECK_SABUN = '" + strCheckSabun + "' \n");
        sbSql.append("   AND UPJANG = " + strUpjang + " \n");

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