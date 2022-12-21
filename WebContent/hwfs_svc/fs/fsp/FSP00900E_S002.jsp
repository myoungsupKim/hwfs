<%
/*-----------------------------------------------------------------------------
�� �ý��۸�     : ���Ž�û/�����/����� �������/â����ȸ
�� ���α׷�ID   : FSP00900E_S001.jsp
�� ���α׷���   : â����ȸ
�� �ۼ�����     : 2015-10-29
�� �ۼ���       : ����ö
�� �̷°���     : 2015-10-29
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

		String strUpjang = in_vl.getString("p_upjang");

		DataSet ds_subinv;
		StringBuffer sbSelSql = new StringBuffer();

		sbSelSql.delete(0, sbSelSql.length());

        sbSelSql.append("SELECT SUBINV_CODE        		\n");
        sbSelSql.append("     , SUBINV_NAME         		\n");
        sbSelSql.append("  FROM HLDC_PO_SUBINVENTORY		\n");
        sbSelSql.append(" WHERE UPJANG = " + strUpjang + "	\n");
        sbSelSql.append(" ORDER BY 2                		\n");

		stmt = conn.createStatement();
		rs = stmt.executeQuery(sbSelSql.toString());

		ds_subinv = this.makeDataSet(rs, "ds_subinv");
		out_dl.add(ds_subinv);

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
