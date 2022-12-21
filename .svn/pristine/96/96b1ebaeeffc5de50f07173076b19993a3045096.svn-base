<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 구매관리/구매신청/입고일선택
■ 프로그램ID   : FSP00030E_T005.jsp
■ 프로그램명   : 입고일선택
■ 작성일자     : 2015-08-14
■ 작성자       : 정영철
■ 이력관리     : 2008-01-28
1)입고일 선택시 구매유형별 d-days, d-times를 조회
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

		String p_potype = in_vl.getString("p_potype");

		DataSet ds_potype;
		StringBuffer sbSelSql = new StringBuffer();

		sbSelSql.delete(0, sbSelSql.length());

		//sbSelSql.append("SELECT D_DAYS, D_TIMES, PO_TYPE, TYPE_NAME    \n");		
		//일요일은 자신을 제외하고 계산하도록 수정 2018.03.15 김호석(이혜은과장 요청)
		//sbSelSql.append("SELECT CASE WHEN TO_CHAR(TO_DATE(TO_CHAR(SYSDATE,'YYYYMMDD'), 'YYYYMMDD') ,'d') = '1' THEN D_DAYS + 1 ELSE D_DAYS END AS D_DAYS, D_TIMES, PO_TYPE, TYPE_NAME    \n");
		//일요일 수요일 식단발주 안되는 문제로 원복 20181116 김호석(김경운과장 요청)
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
