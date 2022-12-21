<%
/*-----------------------------------------------------------------------------
�� �ý��۸�     : ���Ű���/���Ž�û/�԰��ϼ���
�� ���α׷�ID   : FSP00030E_T005.jsp
�� ���α׷���   : �԰��ϼ���
�� �ۼ�����     : 2015-08-14
�� �ۼ���       : ����ö
�� �̷°���     : 2008-01-28
1)�԰��� ���ý� ���������� d-days, d-times�� ��ȸ
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

		String p_potype = in_vl.getString("p_potype");

		DataSet ds_potype;
		StringBuffer sbSelSql = new StringBuffer();

		sbSelSql.delete(0, sbSelSql.length());

		//sbSelSql.append("SELECT D_DAYS, D_TIMES, PO_TYPE, TYPE_NAME    \n");		
		//�Ͽ����� �ڽ��� �����ϰ� ����ϵ��� ���� 2018.03.15 ��ȣ��(���������� ��û)
		//sbSelSql.append("SELECT CASE WHEN TO_CHAR(TO_DATE(TO_CHAR(SYSDATE,'YYYYMMDD'), 'YYYYMMDD') ,'d') = '1' THEN D_DAYS + 1 ELSE D_DAYS END AS D_DAYS, D_TIMES, PO_TYPE, TYPE_NAME    \n");
		//�Ͽ��� ������ �Ĵܹ��� �ȵǴ� ������ ���� 20181116 ��ȣ��(������� ��û)
		sbSelSql.append("SELECT D_DAYS, D_TIMES, PO_TYPE, TYPE_NAME    \n");		
		sbSelSql.append("  FROM HLDC_PO_TYPE_FS \n"); 
		sbSelSql.append(" WHERE PO_TYPE = '" + p_potype + "'\n");

		stmt = conn.createStatement();
		rs = stmt.executeQuery(sbSelSql.toString());

		ds_potype = this.makeDataSet(rs, "ds_potype");
		out_dl.add(ds_potype);

		rs.close();
		stmt.close();
		
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
