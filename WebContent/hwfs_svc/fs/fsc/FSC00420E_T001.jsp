
<%
    /*-----------------------------------------------------------------------------
    �� �ý��۸�     : ��������/CS���ܰ��� - ���ڰ��� ���
    �� ���α׷�ID   : FSC00420E_T001.jsp
    �� ���α׷���   : ��������/CS���ܰ��� - ���ڰ��� ���
    �� �ۼ�����     : 2015-05-28
    �� �ۼ���       : jshoon
    �� �̷°���     :
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

        //jsp log ���� ����
        logger.startIndividualLog(in_vl.getString("titLogId"));

        //����Ŀ�� ���� false
        conn.setAutoCommit(false);

        //����Ÿ
        DataSet ds_resultMst = in_dl.get("ds_cond");

        int RowStatus;
        StringBuffer sbSql = new StringBuffer(); //sql�� ���ۻ���

        String TABLE_TYPE = nullToBlank(ds_resultMst.getString(0, "TABLE_TYPE"));
        String FORM_CD = nullToBlank(ds_resultMst.getString(0, "FORM_CD"));
        String UPJANG = nullToBlank(ds_resultMst.getString(0, "UPJANG"));
        String CHK_DD = nullToBlank(ds_resultMst.getString(0, "CHK_DD"));
        String DRAFT_GUBUN = nullToBlank(ds_resultMst.getString(0, "DRAFT_GUBUN"));
        String SIGN_INSTANCE_ID1 = nullToBlank(ds_resultMst.getString(0, "SIGN_INSTANCE_ID1"));
        String SIGN_INSTANCE_ID2 = nullToBlank(ds_resultMst.getString(0, "SIGN_INSTANCE_ID2"));

        sbSql.delete(0, sbSql.length());
        sbSql.append("UPDATE FSC_PATL_RESULT                 \n");

        // ���˰��
        if (DRAFT_GUBUN.equals("5"))
            sbSql.append("   SET SIGN_INSTANCE_ID1 = '" + SIGN_INSTANCE_ID1 + "'           \n");
        // �������
        if (DRAFT_GUBUN.equals("6"))
            sbSql.append("   SET SIGN_INSTANCE_ID2 = '" + SIGN_INSTANCE_ID2 + "'           \n");

        sbSql.append(" WHERE TABLE_TYPE = '" + TABLE_TYPE + "' \n");
        sbSql.append("   AND FORM_CD    = '" + FORM_CD + "' \n");
        sbSql.append("   AND UPJANG     = '" + UPJANG + "' \n");
        sbSql.append("   AND CHK_DD     = '" + CHK_DD + "' \n");

        stmt = conn.createStatement();
        stmt.execute(sbSql.toString());
        stmt.close();

        conn.commit();
        this.setResultMessage(0, "OK", out_vl);

    } catch (Exception ex) {
        conn.rollback();
        //ex.printStackTrace();
        //jsp �α׳����
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

        //jsp log ���� �ݱ�
        try {
            logger.endIndividualLog();
        } catch (Exception logE) {
            logE.printStackTrace();
        }
    }

    proc_output(response, out, out_vl, out_dl);
%>