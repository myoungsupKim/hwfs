<%
/*-----------------------------------------------------------------------------
�� �ý��۸�     : FS�Ĵ�/���Ű��� / ���ã��
�� ���α׷�ID   : FSP90020E_S001.jsp
�� ���α׷���   : ���ã�� �׷���ȸ
�� �ۼ�����     : 2015-07-07
�� �ۼ���       : ����ö
�� �̷°���     : 2015-07-07 ����ö �����ۼ�
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
    Statement stmt             =  null;
    try {
        PlatformRequest platformRequest = this.proc_input(request);
        in_vl = platformRequest.getData().getVariableList();
        in_dl = platformRequest.getData().getDataSetList();

        //jsp log ���� ����
        logger.startIndividualLog(in_vl.getString("titLogId"));

        //�Է� ����Ÿ
        DataSet ds_cond     = in_dl.get("ds_cond");
        //�Է� �Ķ����
        String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"    ));
        String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"     ));
;
        String UPJANG       = nullToBlank(ds_cond.getString(0, "UPJANG"));
        
        //out ����Ÿ
        DataSet ds_out;
        //sql�� ���ۻ���
        StringBuffer sbSql = new StringBuffer();
        //������ȸ
        sbSql.delete(0, sbSql.length());
        sbSql.append("\n                                              \n");
        sbSql.append("SELECT                                          \n");
        sbSql.append("   FAVOR_GROUP AS FAVOR_GROUP                   \n");
        sbSql.append("  , UPJANG AS UPJANG                            \n");
        sbSql.append("  , FAVOR_NAME AS FAVOR_NAME                    \n");
        sbSql.append("  , SORT_SEQ AS SORT_SEQ                        \n");
        sbSql.append("  , FAVOR_TYPE AS FAVOR_TYPE                    \n");
        sbSql.append("  , CONTENTS AS CONTENTS                        \n");
        sbSql.append("  , REMARK AS REMARK                            \n");
        sbSql.append("  , USE_YN AS USE_YN                            \n");
        sbSql.append("  , CUSER AS CUSER                              \n");
        sbSql.append("  , CDATE AS CDATE                              \n");
        sbSql.append("  , UUSER AS UUSER                              \n");
        sbSql.append("  , UDATE AS UDATE                              \n");
        sbSql.append(" FROM FSP_FAVORITE_GROUP                        \n");
        sbSql.append("WHERE UPJANG = " + UPJANG + "                   \n");
        sbSql.append("  AND USE_YN = 'Y'                              \n");
        sbSql.append("ORDER BY SORT_SEQ                               \n");
        sbSql.append("\n                                              \n");

        stmt = conn.createStatement();		
		rs = stmt.executeQuery(sbSql.toString());
		
		ds_out = this.makeDataSet(rs,"ds_out");
		out_dl.add(ds_out);
		
	   	this.setResultMessage(0, "OK",out_vl);

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