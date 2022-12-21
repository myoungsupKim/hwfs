
<%
  /*-----------------------------------------------------------------------------
    ■ 시스템명     : 메뉴관리/위생관리
    ■ 프로그램ID   : FSC00060V_T001.jsp
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
        String strFormCD = nullToBlank(ds_input.getString(0, "FORM_CD"));
        String strCheckType = nullToBlank(ds_input.getString(0, "CHECK_TYPE"));
        String strLrgClassCD = nullToBlank(ds_input.getString(0, "LRG_CLASS_CD"));
        String strMuCD = nullToBlank(ds_input.getString(0, "MU_CD"));
        String strTmCD = nullToBlank(ds_input.getString(0, "TM_CD"));
        String strJob = nullToBlank(ds_input.getString(0, "JOB"));
        String strSubJob = nullToBlank(ds_input.getString(0, "SUB_JOB"));
        String strUpjang = nullToBlank(ds_input.getString(0, "UPJANG"));
        String strCheckSabun = nullToBlank(ds_input.getString(0, "CHECK_SABUN"));

        //out 데이타
        DataSet ds_list;

        //sql문 버퍼생성
        StringBuffer sbSql = new StringBuffer();

        sbSql.delete(0, sbSql.length());
        sbSql.append("SELECT A.MIDDLE_CLASS_CD AS PL_UP_CD \n");
        sbSql.append("     , A.MIDDLE_CLASS_NAME \n");
        sbSql.append("     , A.CLASS_CD AS PL_CD \n");
        sbSql.append("     , A.CLASS_NAME \n"); 
        sbSql.append("     , COUNT(*) AS CNT \n");
        sbSql.append("     , '0' BL_SHOW \n");
        sbSql.append("     , 2 LEVEL_NO \n");
        sbSql.append("     , '+' BL_PLUS \n");
        sbSql.append("  FROM FSC_FORM_DTL A \n");
        sbSql.append("     , FSC_RESULT_MST B \n");
        sbSql.append("     , FSC_RESULT_DTL C \n");
        sbSql.append("     , ( \n");
        sbSql.append("       SELECT UPJANG \n");
        sbSql.append("         FROM FSA_UPJANG_V \n");
        sbSql.append("        WHERE 1=1 \n");

        if (!strMuCD.equals("")) {
            sbSql.append("      AND    MU_CD='" + strMuCD + "' \n");
        }
        if (!strTmCD.equals("")) {
            sbSql.append("      AND    TM_CD='" + strTmCD + "' \n");
        }
        if (!strUpjang.equals("")) {
            sbSql.append("      AND    UPJANG=" + strUpjang + " \n");
        }
        if (!strJob.equals("")) {
            sbSql.append("      AND    JOB_CD='" + strJob + "' \n");
        }
        if (!strSubJob.equals("")) {
            sbSql.append("      AND    SUB_JOB_CD='" + strSubJob + "' \n");
        }
        sbSql.append("       ) D \n");
        sbSql.append(" WHERE A.TABLE_TYPE = C.TABLE_TYPE \n");
        sbSql.append("   AND A.FORM_CD = C.FORM_CD \n");
        sbSql.append("   AND A.CLASS_CD = C.CLASS_CD \n");
        sbSql.append("   AND B.TABLE_TYPE = C.TABLE_TYPE \n");
        sbSql.append("   AND B.FORM_CD = C.FORM_CD \n");
        sbSql.append("   AND B.CHECK_DATE = C.CHECK_DATE \n");
        sbSql.append("   AND B.UPJANG = C.UPJANG \n");
        sbSql.append("   AND B.UPJANG = D.UPJANG \n");
        sbSql.append("   AND B.CONFIRM_YN = 'Y' \n");
        //최대배점이 아니거나 지적건이 있는것
        sbSql.append("   AND (C.MAX_YN = 'N' OR C.INDICATE_CNT > 0) \n");
        sbSql.append("   AND A.TABLE_TYPE = '" + strTableType + "' \n");
        sbSql.append("   AND B.CHECK_DATE BETWEEN '" + strFromDt + "' AND '" + strToDt + "' \n");
        sbSql.append("   AND A.FORM_CD = '" + strFormCD + "' \n");
        sbSql.append("   AND B.CHECK_TYPE IN (" + strCheckType + ") \n");
        sbSql.append("   AND A.LRG_CLASS_CD = '" + strLrgClassCD + "' \n");

        if (strCheckSabun.length() != 0)
            sbSql.append("   AND B.CHECK_SABUN = " + strCheckSabun + " \n");

        sbSql.append(" GROUP BY A.MIDDLE_CLASS_CD, A.MIDDLE_CLASS_NAME, A.CLASS_CD, A.CLASS_NAME \n");
        sbSql.append(" ORDER BY A.CLASS_CD \n");

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