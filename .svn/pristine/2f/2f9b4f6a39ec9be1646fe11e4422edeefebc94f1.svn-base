<%
    /*-----------------------------------------------------------------------------
    ■ 시스템명     : 메뉴관리/위생관리
    ■ 프로그램ID   : FSC00020E_T001.jsp
    ■ 프로그램명   : 정검결과등록 - 리스트조회
    ■ 작성일자     : 2008-03-20
    ■ 작성자       : 박지영
    ■ 이력관리     : 2008-03-20
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

        String strUpjang = nullToBlank(ds_input.getString(0, "UPJANG"));
        String strFromDt = nullToBlank(ds_input.getString(0, "FROM_DT"));
        String strToDt = nullToBlank(ds_input.getString(0, "TO_DT"));

        //out 데이타
        DataSet ds_list;

        //sql문 버퍼생성
        StringBuffer sbSql = new StringBuffer();

        // 정검양식조회
        sbSql.delete(0, sbSql.length());
        sbSql.append("SELECT A.TABLE_TYPE \n");
        sbSql.append("     , A.FORM_CD \n");
        sbSql.append("     , A.UPJANG \n");
        sbSql.append("     , A.CHECK_DATE \n");
        sbSql.append("     , A.CHECK_TYPE \n");
        sbSql.append("     , (SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0042' AND A.CHECK_TYPE = CODE) AS CHECK_TYPE_NM \n");
        sbSql.append("     , A.LEAD_CHECK_TYPE \n");
        sbSql.append("     , A.CHECK_SABUN \n");
        sbSql.append("     , (SELECT NM_KOR FROM SCO_FS_HR_PERSONAL_V WHERE A.CHECK_SABUN = SABUN) AS CHECK_SABUN_NM \n");
        sbSql.append("     , ROUND(A.SCORE, 1 ) AS SCORE \n");
        sbSql.append("     , A.NOT_FIT_YN \n");
        sbSql.append("     , A.CONFIRM_YN \n");
        sbSql.append("     , NVL2(A.IMPROV_RPT_DATE,'Y','N') AS WRITE_YN \n");
        sbSql.append("     , (SELECT NM_KOR FROM HLDC_HR_PERSONAL WHERE SABUN =  A.CHARGE_SABUN) AS CHARGE_NM \n");
        sbSql.append("     , A.SIGN_INSTANCE_ID1  /* 점검결재ID */ \n");
        sbSql.append("     , CASE WHEN A.SIGN_INSTANCE_ID1 IS NOT NULL THEN NVL(SCC_SIGN_STATUS_FUN(A.SIGN_INSTANCE_ID1), 'DRAFT') END AS SIGN_PROGRESS_STATUS1 \n");
        sbSql.append("     , A.SIGN_INSTANCE_ID2  /* 개선결재ID */ \n");
        sbSql.append("     , CASE WHEN A.SIGN_INSTANCE_ID2 IS NOT NULL THEN NVL(SCC_SIGN_STATUS_FUN(A.SIGN_INSTANCE_ID2), 'DRAFT') END AS SIGN_PROGRESS_STATUS2 \n");
        sbSql.append("  FROM FSC_SAFE_RESULT_MST A \n");
        sbSql.append(" WHERE A.CONFIRM_YN = 'Y' \n");
        sbSql.append("   AND UPJANG = " + strUpjang + " \n");
        sbSql.append("   AND CHECK_DATE BETWEEN '" + strFromDt + "' AND '" + strToDt + "' \n");
        sbSql.append(" ORDER BY A.CHECK_DATE, A.CHECK_TYPE \n");

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