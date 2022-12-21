
<%
    /*-----------------------------------------------------------------------------
    �� �ý��۸�     : �����ȹ����/���� ������ȸ
    �� ���α׷�ID   : MAP30070E_S001.jsp
    �� ���α׷���   : ���������� ����
    �� �ۼ�����     : 2015-07-14
    �� �ۼ���       : ������
    �� �̷°���     :
    -----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="../../sc/main/common.jsp"%>
<%
    try {
        PlatformRequest platformRequest = this.proc_input(request);
        in_vl = platformRequest.getData().getVariableList();
        in_dl = platformRequest.getData().getDataSetList();

        //jsp log ���� ����
        logger.startIndividualLog(in_vl.getString("titLogId"));

        //�Է� ����Ÿ
        DataSet ds_Cond = in_dl.get("ds_Cond");

        //�Է� �Ķ����
        //String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
        String g_EmpNo = nullToBlank(in_vl.getString("g_EmpNo"));

        String g_Upjang = nullToBlank(ds_Cond.getString(0, "UPJANG"));
        String g_Yy = nullToBlank(ds_Cond.getString(0, "INPUT_YY"));
        String g_Class = nullToBlank(ds_Cond.getString(0, "CLASS"));
        String g_MuCd = nullToBlank(ds_Cond.getString(0, "MU_CD"));
        String g_TmCd = nullToBlank(ds_Cond.getString(0, "TM_CD"));

        //out ����Ÿ
        DataSet ds_List;

        //sql�� ���ۻ���
        StringBuffer sbSql = new StringBuffer();

        sbSql.delete(0, sbSql.length());
        sbSql.append("	SELECT B.UPJANGNM                                          			\n");
        sbSql.append("	      ,B.UPJANG                                            			\n");
        sbSql.append("	      ,'" + g_Yy + "'YY                                     			\n");
        sbSql.append("	      ,DECODE('" + g_Class + "' , 'P', '��ȹ', '����') AS CLASS 	\n");
        sbSql.append("	      ,B.MU_CD		                                     			\n");
        sbSql.append("	      ,B.TM_CD		                                     			\n");
        sbSql.append("	      ,NVL(A.MM_MARGIN_RATE_01, 100) AS MM_MARGIN_RATE_01    		\n");
        sbSql.append("	      ,NVL(A.MM_MARGIN_RATE_02, 100) AS MM_MARGIN_RATE_02    		\n");
        sbSql.append("	      ,NVL(A.MM_MARGIN_RATE_03, 100) AS MM_MARGIN_RATE_03    		\n");
        sbSql.append("	      ,NVL(A.MM_MARGIN_RATE_04, 100) AS MM_MARGIN_RATE_04    		\n");
        sbSql.append("	      ,NVL(A.MM_MARGIN_RATE_05, 100) AS MM_MARGIN_RATE_05    		\n");
        sbSql.append("	      ,NVL(A.MM_MARGIN_RATE_06, 100) AS MM_MARGIN_RATE_06    		\n");
        sbSql.append("	      ,NVL(A.MM_MARGIN_RATE_07, 100) AS MM_MARGIN_RATE_07    		\n");
        sbSql.append("	      ,NVL(A.MM_MARGIN_RATE_08, 100) AS MM_MARGIN_RATE_08    		\n");
        sbSql.append("	      ,NVL(A.MM_MARGIN_RATE_09, 100) AS MM_MARGIN_RATE_09    		\n");
        sbSql.append("	      ,NVL(A.MM_MARGIN_RATE_10, 100) AS MM_MARGIN_RATE_10    		\n");
        sbSql.append("	      ,NVL(A.MM_MARGIN_RATE_11, 100) AS MM_MARGIN_RATE_11    		\n");
        sbSql.append("	      ,NVL(A.MM_MARGIN_RATE_12, 100) AS MM_MARGIN_RATE_12    		\n");
        sbSql.append("	  FROM MAP_MARGIN_RATE_MGMT A                              			\n");
        sbSql.append("	      ,SCO_UPJANG_MST_V B                                  			\n");
        sbSql.append("	 WHERE A.UPJANG(+) = B.UPJANG                                 		\n");
        sbSql.append("	   AND A.CLASS(+) = '" + g_Class + "'                          		\n");
        sbSql.append("	   AND A.YY(+) = '" + g_Yy + "'   									\n");
        sbSql.append("	   AND B.CLOSE_DATE IS NULL                       					\n");

        if (!"".equals(g_MuCd)) {
            sbSql.append("	   AND B.MU_CD = '" + g_MuCd + "'   								\n");
        }
        if (!"".equals(g_TmCd)) {
            sbSql.append("	   AND (B.TM_CD = '" + g_TmCd + "' OR PT_CD = '" + g_TmCd + "') 	\n");
        }
        if (!"".equals(g_Upjang)) {
            sbSql.append("	   AND B.UPJANG = " + g_Upjang + " 									\n");
        }
        sbSql.append("	 ORDER BY UPJANGNM 													\n");

        out_vl.add("fa_Sql", sbSql.toString());
        pstmt = conn.prepareStatement(sbSql.toString());
        rs = pstmt.executeQuery();
        ds_List = this.makeDataSet(rs, "ds_List");

        pstmt.close();
        rs.close();

        /**����**/
        out_dl.add(ds_List);
        this.setResultMessage(0, "OK", out_vl);

    } catch (Exception ex) {
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