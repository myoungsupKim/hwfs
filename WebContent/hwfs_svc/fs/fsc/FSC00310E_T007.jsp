<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 위생관리/협력업체위생관리 - 전자결재 등록
■ 프로그램ID   : FSC00310E_T007.jsp
■ 프로그램명   : 위생관리/협력업체위생관리 - 전자결재 등록
■ 작성일자     : 2015-05-28
■ 작성자       : jshoon
■ 이력관리     :
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="../../sc/main/common.jsp"%>
<%
    Statement stmt = null;

    try {

        PlatformRequest platformRequest = this.proc_input(request);
        in_vl = platformRequest.getData().getVariableList();
        in_dl = platformRequest.getData().getDataSetList();

        //jsp log 서비스 시작
        logger.startIndividualLog(in_vl.getString("titLogId"));

        //오토커밋 강제 false
        conn.setAutoCommit(false);

        //데이타
        DataSet ds_resultMst = in_dl.get("ds_cond");

        int RowStatus;
        StringBuffer sbSql = new StringBuffer(); //sql문 버퍼생성

        String TABLE_TYPE = nullToBlank(ds_resultMst.getString(0, "TABLE_TYPE"));
        String FORM_CD = nullToBlank(ds_resultMst.getString(0, "FORM_CD"));
        String CUSTCD = nullToBlank(ds_resultMst.getString(0, "CUSTCD"));
        String CHK_DD = nullToBlank(ds_resultMst.getString(0, "CHK_DD"));
        String SUB_COMP_NM = nullToBlank(ds_resultMst.getString(0, "SUB_COMP_NM"));
        String DRAFT_GUBUN = nullToBlank(ds_resultMst.getString(0, "DRAFT_GUBUN"));
        String SIGN_INSTANCE_ID1 = nullToBlank(ds_resultMst.getString(0, "SIGN_INSTANCE_ID1"));
        String SIGN_INSTANCE_ID2 = nullToBlank(ds_resultMst.getString(0, "SIGN_INSTANCE_ID2"));

        sbSql.delete(0, sbSql.length());
        sbSql.append("UPDATE FSC_CONTRT_RESULT                 \n");

        // 점검결과
        if (DRAFT_GUBUN.equals("1"))
            sbSql.append("   SET SIGN_INSTANCE_ID1 = '" + SIGN_INSTANCE_ID1 + "'           \n");
        // 개선결과
        if (DRAFT_GUBUN.equals("2"))
            sbSql.append("   SET SIGN_INSTANCE_ID2 = '" + SIGN_INSTANCE_ID2 + "'           \n");

        sbSql.append(" WHERE TABLE_TYPE = '" + TABLE_TYPE + "' \n");
        sbSql.append("   AND FORM_CD    = '" + FORM_CD + "' \n");
        sbSql.append("   AND CUSTCD     = '" + CUSTCD + "' \n");
        sbSql.append("   AND CHK_DD     = '" + CHK_DD + "' \n");
        sbSql.append("   AND SUB_COMP_NM= '" + SUB_COMP_NM + "' \n");

        stmt = conn.createStatement();
        stmt.execute(sbSql.toString());
        stmt.close();

        conn.commit();
        this.setResultMessage(0, "OK", out_vl);

    } catch (Exception ex) {
        conn.rollback();
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
        if (stmt != null) {
            try {
                stmt.close();
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