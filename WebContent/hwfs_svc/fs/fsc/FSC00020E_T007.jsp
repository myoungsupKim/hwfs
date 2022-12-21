<%
/*-----------------------------------------------------------------------------
�� �ý��۸�     : �޴�����/��������
�� ���α׷�ID   : FSC00020E_T007.jsp
�� ���α׷���   : ���˰����� - ���� �ټ����� keyüũ
�� �ۼ�����     : 2008-03-20
�� �ۼ���       : ������
�� �̷°���     : 2008-03-20
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
    try {
        PlatformRequest platformRequest = this.proc_input(request);
        in_vl = platformRequest.getData().getVariableList();
        in_dl = platformRequest.getData().getDataSetList();

        //jsp log ���� ����
        logger.startIndividualLog(in_vl.getString("titLogId"));

        //�Է� ����Ÿ
        String strSabun 	= in_vl.getString("SABUN");



        //out ����Ÿ
        DataSet ds_list;

        //sql�� ���ۻ���
        StringBuffer sbSql = new StringBuffer();

        // ���˾����ȸ
        sbSql.delete(0, sbSql.length());
        sbSql.append("SELECT 	(CASE WHEN B.PER_DTA IS NULL AND B.PER_DTB IS NULL THEN \n");
        sbSql.append("                  '' \n");
        sbSql.append("           ELSE \n");
        sbSql.append("                 SCC_KUNSOK_YMD_FUN(DECODE(B.PER_DTA,NULL,B.PER_DTB,B.PER_DTA), TO_CHAR(SYSDATE,'YYYYMMDD')) \n");
        sbSql.append("           END)    AS KUNSOK \n");
        sbSql.append("  FROM SCO_FS_HR_PERSONAL_V B \n");
        sbSql.append(" WHERE SABUN ='" + strSabun + "' \n");

        //System.out.println(sbSql.toString());
        pstmt = conn.prepareStatement(sbSql.toString());
        rs = pstmt.executeQuery();
        ds_list = this.makeDataSet(rs, "ds_list");

        rs.close();
        pstmt.close();

        /**����**/
        out_dl.add(ds_list);
        this.setResultMessage(0, "OK", out_vl);

    }
    catch(Exception ex)
    {
        //ex.printStackTrace();
        //jsp �α׳����
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

        //jsp log ���� �ݱ�
        try {
            logger.endIndividualLog();
        } catch( Exception logE) {
            logE.printStackTrace();
        }
    }

    proc_output(response,out,out_vl,out_dl);

%>