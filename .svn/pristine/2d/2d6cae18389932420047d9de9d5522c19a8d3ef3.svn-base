
<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="../../sc/main/common.jsp"%>
<%
	Statement stmt = null;
	try {
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();

		DataSet in_ds = in_dl.get("ds_condi");
		
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));

		String LINE_STATUS    = nullToBlank(in_ds.getString(0, "LINE_STATUS"	));
		String PO_TYPE        = nullToBlank(in_ds.getString(0, "PO_TYPE"	));
		String PR_UPJANG      = nullToBlank(in_ds.getString(0, "PR_UPJANG"  ));
		
		DataSet ds_ibgo;
		StringBuffer sbSelSql = new StringBuffer();

		sbSelSql.delete(0, sbSelSql.length());
/* 
		//sbSelSql.append("SELECT PR_FLAG, PO_CLOSING_FLAG FROM PO_TYPE WHERE PO_TYPE = '" + p_PoType + "' \n");
		//sbSelSql.append("SELECT A.PR_FLAG                 		\n");
		//sbSelSql.append("     , A.PO_CLOSING_FLAG         		\n");
		sbSelSql.append("SELECT NVL(B.CODE, '00') AS PO_CODE 	\n");
		sbSelSql.append("     , B.ATTR01 AS CHK_MONTH     		\n");
		sbSelSql.append("     , B.ATTR02 AS CHK_TERM      		\n");
		sbSelSql.append("  FROM HLDC_PO_TYPE_FS A                  \n");
		sbSelSql.append("     , PO_CODE B                       \n");
		sbSelSql.append(" WHERE A.PO_TYPE = B.CODE(+)     		\n");
		sbSelSql.append("   AND A.PO_TYPE = '" + p_PoType + "'  \n");
		sbSelSql.append("   AND B.GROUP_CODE(+) = '031'   		\n");
		
		

		stmt = conn.createStatement();
		rs = stmt.executeQuery(sbSelSql.toString());

		rs.next();

		//String strPrFlag = rs.getString("PR_FLAG");
		//String strPoClosingFlag = rs.getString("PO_CLOSING_FLAG");
		String strPoCode = rs.getString("PO_CODE");
		String strChkMonth = rs.getString("CHK_MONTH");
		String strChkTerm = rs.getString("CHK_TERM");

		rs.close();
		stmt.close();

		//out_vl.add("v_PrFlag", strPrFlag);
		//out_vl.add("v_PoClosingFlag", strPoClosingFlag);

		//this.setResultMessage(0, "OK", out_vl);

		//if (strPrFlag.equals("N"))
		//	return;

		//if (strPoClosingFlag.equals("Y")) {
			 */
			sbSelSql.delete(0, sbSelSql.length());
			sbSelSql.append("SELECT TO_CHAR(TO_DATE(A.PR_DATE,'YYYYMMDD'),'YYYY-MM-DD') AS PR_DATE, A.PR_NUM, A.ITEM_CODE||' '||A.ITEM_NAME AS ITEM_NAME \n");
			sbSelSql.append("     , A.PR_QTY, (B.CENTER_DELI_QTY + B.DIRECT_DELI_QTY) AS ORDER_QTY \n");
			sbSelSql.append("     , B.DELIVERED_QTY, B.UNDELIVERED_QTY \n");
			sbSelSql.append("     , (B.CENTER_DELI_QTY + B.DIRECT_DELI_QTY - B.DELIVERED_QTY - B.UNDELIVERED_QTY) AS NONE_QTY \n");
			sbSelSql.append("     , TO_CHAR(TO_DATE(A.NEED_DATE,'YYYYMMDD'),'YYYY-MM-DD') AS NEED_DATE \n");
			sbSelSql.append("     , CASE WHEN A.SUBINV_CODE IS NULL THEN (SELECT A.RC_UPJANG||' '||Z.UPJANGNM FROM ST_UPJANG Z WHERE Z.UPJANG = A.RC_UPJANG) \n");
			sbSelSql.append("            ELSE                            (SELECT A.SUBINV_CODE||' '||Z.SUBINV_NAME FROM HLDC_PO_SUBINVENTORY Z WHERE Z.SUBINV_CODE = A.SUBINV_CODE) \n");
			sbSelSql.append("        END AS SUBINV_NAME \n");
			sbSelSql.append("  FROM HLDC_PO_PO B \n");
			sbSelSql.append("     ,(SELECT /*+ INDEX(PO_PR PO_PR_I5) */ *  \n");
			sbSelSql.append("         FROM SO_PR \n");
/* 			if (strPoCode.equals("00")) { */
				sbSelSql.append("        WHERE NEED_DATE BETWEEN TO_CHAR(SYSDATE - 15,'YYYYMMDD') AND TO_CHAR(SYSDATE - 1,'YYYYMMDD') \n");
/* 			} else {
				//sbSelSql.append("        WHERE NEED_DATE BETWEEN TO_CHAR(ADD_MONTHS(SYSDATE, -1 * (TO_NUMBER('" + strChkMonth + "') + TO_NUMBER('" + strChkTerm + "'))),'YYYYMMDD') AND TO_CHAR(ADD_MONTHS(SYSDATE, -1 * TO_NUMBER('" + strChkMonth + "')),'YYYYMMDD') \n");
				sbSelSql.append("        WHERE NEED_DATE BETWEEN TO_CHAR(ADD_MONTHS(SYSDATE, -1 * (TO_NUMBER('"
						+ strChkMonth
						+ "'))),'YYYYMMDD') AND TO_CHAR(SYSDATE -1 * TO_NUMBER('"
						+ strChkTerm + "'),'YYYYMMDD') \n");
			} */
			sbSelSql.append("          AND PO_TYPE   = '"     + PO_TYPE       + "' \n");
			sbSelSql.append("          AND RC_UPJANG  = "     + PR_UPJANG     + " \n");
			sbSelSql.append("          AND LINE_STATUS  >= '" + LINE_STATUS + "') A \n");
			sbSelSql.append(" WHERE B.PR_ID = A.PR_ID \n");
			sbSelSql.append("   AND B.LINE_STATUS >= '" + LINE_STATUS+ "' \n");
			sbSelSql.append("   AND ABS(B.CENTER_DELI_QTY + B.DIRECT_DELI_QTY) - ABS(B.DELIVERED_QTY + B.UNDELIVERED_QTY) > 0 \n");
			sbSelSql.append(" ORDER BY 1, 3 \n");

			stmt = conn.createStatement();
			rs = stmt.executeQuery(sbSelSql.toString());

			ds_ibgo = this.makeDataSet(rs, "ds_ibgo");
			out_dl.add(ds_ibgo);
		//}

		this.setResultMessage(0, "OK", out_vl);
	} catch (Exception ex) {
		ex.printStackTrace();
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
