
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

		DataSet ds_cond = in_dl.get("ds_cond");
		
		String ITEM_CODE = ds_cond.getString(0, "ITEM_CODE");

		StringBuffer sbSelSql = new StringBuffer();

		sbSelSql.delete(0, sbSelSql.length());
		
		sbSelSql.append("SELECT A.ITEM_CODE							\n");
		sbSelSql.append("     , A.ITEM_NAME							\n");
		sbSelSql.append("     , B.IMG_PATH							\n");
		sbSelSql.append("  FROM HLDC_PO_ITEM_MST A 					\n");
		sbSelSql.append("     , HLDC_ITEM_IMG B 					\n");
		sbSelSql.append(" WHERE A.ITEM_CODE = '" + ITEM_CODE + "'	\n");
		sbSelSql.append("   AND A.ITEM_CODE = B.ITEM_CODE			\n");

		stmt = conn.createStatement();		
		rs = stmt.executeQuery(sbSelSql.toString());
		
		DataSet ds_out = this.makeDataSet(rs,"ds_out");
		out_dl.add(ds_out);
		
		this.setResultMessage(0, "OK",out_vl);

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
