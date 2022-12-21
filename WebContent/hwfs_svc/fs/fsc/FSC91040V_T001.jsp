
<%
    /*-----------------------------------------------------------------------------
    ■ 시스템명     : 위생관리/외부기관점검결과조회
    ■ 프로그램ID   : FSC91040V_T001.jsp
    ■ 프로그램명   : 외부기관점검결과조회
    ■ 작성일자     : 2009-07-26
    ■ 작성자       : 김명섭
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
        DataSet ds_input = in_dl.get("ds_search");

        String strFromDay    = nullToBlank(ds_input.getString(0, "fromDay"));
        String strToDay      = nullToBlank(ds_input.getString(0, "toDay"));
        String strAgencyType = nullToBlank(ds_input.getString(0, "agencyType"));

        //out 데이타
        DataSet ds_list;

        //sql문 버퍼생성
        StringBuffer sbSql = new StringBuffer();

        // 정검양식조회
        sbSql.delete(0, sbSql.length());
        sbSql.append("SELECT VISIT_DT, UPJANG, SEQNO, \n");
        sbSql.append("       (SELECT TM_NM FROM HLDC_SC_DEPT_V WHERE A.TM_CD = TM_CD AND ROWNUM = 1) AS TM_NM,                      \n");
        sbSql.append("       (SELECT NM_KOR FROM SCO_FS_HR_PERSONAL_V WHERE SABUN = A.TEAM_MST_SABUN) TEAM_MST_SABUN_NM,            \n");
        sbSql.append("       (SELECT NM_KOR FROM SCO_FS_HR_PERSONAL_V WHERE SABUN = A.SUBTEAM_MST_SABUN) SUBTEAM_MST_SABUN_NM,      \n");
        sbSql.append("       (SELECT UPJANGNM FROM ST_UPJANG WHERE A.UPJANG = UPJANG) AS UPJANG_NM,                                 \n");
        sbSql.append("       (SELECT NM_KOR FROM SCO_FS_HR_PERSONAL_V WHERE SABUN = A.CHARGE_SABUN) CHARGE_SABUN_NM,                \n");
        sbSql.append("       SCC_CODE_NM('MA0004',A.PERMISSION_TYPE) AS PERMISSION_TYPE_NM,                                         \n");
        sbSql.append("       SCC_CODE_NM('FS9110',A.AGENCY_TYPE) AS AGENCY_TYPE_NM,                                                 \n");
        sbSql.append("       AGENCY_NM,                                                                                             \n");
        sbSql.append("       SCC_CODE_NM('FS9120',A.CHECK_TYPE) AS CHECK_TYPE_NM,                                                   \n");
        sbSql.append("       EXPOSE_YN,                                                                                             \n");
        sbSql.append("       CHECK_CONTENTS,                                                                                        \n");
        sbSql.append("       CONFIRM_YN,                                                                                            \n");
        sbSql.append("       PICK_CHECK_YN, \n");
        sbSql.append("       CASE WHEN A.SIGN_INSTANCE_ID IS NOT NULL THEN NVL(SCC_SIGN_STATUS_FUN(A.SIGN_INSTANCE_ID), 'DRAFT') END AS SIGN_PROGRESS_STATUS  \n");
        sbSql.append("  FROM FSC_TEST_EXTERNAL_MST A \n");
        sbSql.append(" WHERE 1 = 1 \n");
        sbSql.append("   AND VISIT_DT BETWEEN '" + strFromDay + "' AND '" + strToDay + "' \n");
        if (!strAgencyType.equals(""))
            sbSql.append("  AND AGENCY_TYPE = '" + strAgencyType + "' \n");
        sbSql.append("ORDER BY VISIT_DT DESC, UPJANG, SEQNO \n");

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