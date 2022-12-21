
<%
    /*-----------------------------------------------------------------------------
    ■ 시스템명     : 위생관리/외부기관점검결과보고 - 전자결재 등록
    ■ 프로그램ID   : FSC91030E_T008.jsp
    ■ 프로그램명   : 위생관리/외부기관점검결과보고 - 전자결재 등록
    ■ 작성일자     : 2019.07.25
    ■ 작성자       : 김명섭
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
        DataSet ds_input = in_dl.get("ds_input");

        int RowStatus;
        StringBuffer sbSql = new StringBuffer(); //sql문 버퍼생성

        String strUpjang = ds_input.getString(0, "UPJANG");
        String strVisitDt = ds_input.getString(0, "VISIT_DT");
        String strSeqNo = ds_input.getString(0, "SEQNO");
        String strSignInstanceId = ds_input.getString(0, "SIGN_INSTANCE_ID");

        sbSql.delete(0, sbSql.length());
        sbSql.append("UPDATE FSC_TEST_EXTERNAL_MST                         \n");
        sbSql.append("   SET SIGN_INSTANCE_ID = " + strSignInstanceId + "  \n");
        sbSql.append(" WHERE UPJANG   = '" + strUpjang + "'                \n");
        sbSql.append("   AND VISIT_DT = '" + strVisitDt + "'               \n");
        sbSql.append("   AND SEQNO    = "  + strSeqNo + "                  \n");

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