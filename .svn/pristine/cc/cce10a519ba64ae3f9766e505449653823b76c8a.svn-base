<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 위생관리/외부기관점검결과관리
■ 프로그램ID   : FSC92030E_T001.jsp
■ 프로그램명   : 외부기간점검결과조회
■ 작성일자     : 2019-07-08
■ 작성자       : 김명섭
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
    try {
        PlatformRequest platformRequest = this.proc_input(request);
        in_vl = platformRequest.getData().getVariableList();
        in_dl = platformRequest.getData().getDataSetList();

        //jsp log 서비스 시작
        logger.startIndividualLog(in_vl.getString("titLogId"));

        //입력 데이타
        DataSet ds_input     = in_dl.get("ds_input");

        String strUpjang 		= nullToBlank(ds_input.getString(0, "UPJANG"));
        String strFromDt		= nullToBlank(ds_input.getString(0, "FROM_DT"));
        String strToDt 			= nullToBlank(ds_input.getString(0, "TO_DT"));
        
        //out 데이타
        DataSet ds_list;

        //sql문 버퍼생성
        StringBuffer sbSql = new StringBuffer();

        // 정검양식조회
        sbSql.delete(0, sbSql.length());
        sbSql.append("SELECT UPJANG,                                                                                                \n");
        sbSql.append("       (SELECT UPJANGNM FROM ST_UPJANG WHERE A.UPJANG = UPJANG) AS UPJANG_NM,                                 \n");
        sbSql.append("       VISIT_DT,                                                                                              \n");
        sbSql.append("       SEQNO,                                                                                                 \n");
        sbSql.append("       TM_CD,                                                                                                 \n");
        sbSql.append("       (SELECT TM_NM FROM HLDC_SC_DEPT_V WHERE A.TM_CD = TM_CD AND ROWNUM = 1) AS TM_NM,                      \n");
        sbSql.append("       TEAM_MST_SABUN,                                                                                        \n");
        sbSql.append("       (SELECT NM_KOR FROM SCO_FS_HR_PERSONAL_V WHERE SABUN = A.TEAM_MST_SABUN) TEAM_MST_SABUN_NM,            \n");
        sbSql.append("       SUBTEAM_MST_SABUN,                                                                                     \n");
        sbSql.append("       (SELECT NM_KOR FROM SCO_FS_HR_PERSONAL_V WHERE SABUN = A.SUBTEAM_MST_SABUN) SUBTEAM_MST_SABUN_NM,      \n");
        sbSql.append("       CHARGE_SABUN,                                                                                          \n");
        sbSql.append("       (SELECT NM_KOR FROM SCO_FS_HR_PERSONAL_V WHERE SABUN = A.CHARGE_SABUN) CHARGE_SABUN_NM,                \n");
        sbSql.append("       PERMISSION_TYPE,                                                                                       \n");
        sbSql.append("       SCC_CODE_NM('MA0004',A.PERMISSION_TYPE) AS PERMISSION_TYPE_NM,                                         \n");
        sbSql.append("       AGENCY_TYPE,                                                                                           \n");
        sbSql.append("       SCC_CODE_NM('FS9110',A.AGENCY_TYPE) AS AGENCY_TYPE_NM,                                                 \n");
        sbSql.append("       CHECK_TYPE,                                                                                            \n");
        sbSql.append("       SCC_CODE_NM('FS9120',A.CHECK_TYPE) AS CHECK_TYPE_NM,                                                   \n");
        sbSql.append("       AGENCY_NM,                                                                                             \n");
        sbSql.append("       VISIT_NM,                                                                                              \n");
        sbSql.append("       CONFIRM_YN,                                                                                            \n");
        sbSql.append("       EXPOSE_YN,                                                                                             \n");
        sbSql.append("       PICK_CHECK_YN,                                                                                         \n");
        sbSql.append("       CHECK_CONTENTS,                                                                                        \n");
        sbSql.append("       ETC_CONTENTS,                                                                                          \n");
        sbSql.append("       SIGN_INSTANCE_ID,                                                                                      \n");
        sbSql.append("       CASE WHEN A.SIGN_INSTANCE_ID IS NOT NULL THEN NVL(SCC_SIGN_STATUS_FUN(A.SIGN_INSTANCE_ID), 'DRAFT') END AS SIGN_PROGRESS_STATUS,  \n");
        sbSql.append("       (SELECT NM_KOR FROM SCO_FS_HR_PERSONAL_V WHERE SABUN = A.UUSER) UUSER                                  \n");
        sbSql.append("  FROM FSC_TEST_EXTERNAL_MST A                                                                                \n");
        sbSql.append(" WHERE A.UPJANG LIKE '" + strUpjang + "'||'%' \n");
        sbSql.append("   AND A.VISIT_DT BETWEEN '" + strFromDt + "' AND '" + strToDt + "' \n");
        sbSql.append(" ORDER BY A.VISIT_DT DESC, A.UPJANG, A.SEQNO \n");

        //System.out.println(sbSql.toString());
        pstmt = conn.prepareStatement(sbSql.toString());
        rs = pstmt.executeQuery();
        ds_list = this.makeDataSet(rs, "ds_list");

        rs.close();
        pstmt.close();

        /**종료**/
        out_dl.add(ds_list);
        this.setResultMessage(0, "OK", out_vl);

    }
    catch(Exception ex)
    {
        //ex.printStackTrace();
        //jsp 로그남기기
        logger.debug(ex.getMessage(), ex);
        this.setResultMessage(-1, ex.toString(),out_vl);
    }
    finally
    {
        if(rs != null) {
            try {
                rs.close();
            }catch(Exception e) {}
        }
        if(pstmt != null) {
            try {
                pstmt.close();
            }catch(Exception e) {}
        }
        if(conn != null) {
            try {
                conn.close();
            }catch(Exception e) {}
        }

        //jsp log 서비스 닫기
        try {
            logger.endIndividualLog();
        } catch( Exception logE) {
            logE.printStackTrace();
        }
    }

    proc_output(response,out,out_vl,out_dl);

%>