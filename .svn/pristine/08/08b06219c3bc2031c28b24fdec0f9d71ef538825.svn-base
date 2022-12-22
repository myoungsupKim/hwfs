<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 협력업체 > 마감자료
■ 프로그램ID   : FSV00270V_T001.jsp
■ 프로그램명   : 결제내역조회
■ 작성일자     : 2012-08-20
■ 작성자       : 박은규
■ 이력관리     : 2012-08-20 - 최초작성 박은규 CSR#(?????) 최초작성 자금팀(유태석과장)
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	try	{
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
	
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));

		//입력 데이타
		//DataSet ds_Cond     = in_dl.get("ds_Cond");
		//입력 파라메터
		String strCustCd    = nullToBlank(in_vl.getString("strCustCd"));
		String strIDateF    = nullToBlank(in_vl.getString("strIDateF"));
		String strIDateT    = nullToBlank(in_vl.getString("strIDateT"));
		String strPDateF    = nullToBlank(in_vl.getString("strPDateF"));
		String strPDateT    = nullToBlank(in_vl.getString("strPDateT"));

		//IRIS DB연결
		if(conn != null && !conn.isClosed()) conn.close();
		conn = getIRISConn();

		//out 데이타
		DataSet ds_List;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		
		//내역조회
		sbSql.append("SELECT TO_CHAR(TO_DATE(A.RTN2_BALDATE,'YYYYMMDD'),'YYYY-MM-DD') AS IDATE \n");
		sbSql.append("     , A.RTN2_DEPTID AS CC_NM \n");
		sbSql.append("     , A.RTN2_DESCRIPTIONNM AS REMARK \n");
		sbSql.append("     , A.RTN2_BALAMT AS IAMT \n");
		sbSql.append("     , A.RTN2_JIGIBAMT AS PAMT \n");
		sbSql.append("     , A.RTN2_BALANCE AS RAMT \n");
		sbSql.append("     , RTN2_TOTALJIGIBAMT AS PTOT \n");
		sbSql.append("     , TO_CHAR(TO_DATE(A.RTN2_JIBULDATE,'YYYYMMDD'),'YYYY-MM-DD') AS PDATE \n");
		sbSql.append("     , A.RTN2_ACNTCD AS ACCOUNT \n");
		sbSql.append("  FROM TABLE (TR_MIJIGIB_REPORT_FUN('" + strIDateF + "', '" + strIDateT + "', '" + strCustCd + "', '" + strPDateF + "', '" + strPDateT + "')) A \n");
		sbSql.append(" ORDER BY 1, 2, 3, 4, 7 \n");
		
out_vl.add("fa_Sql", sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_List = this.makeDataSet(rs, "ds_List");
		
		rs.close();
		pstmt.close();

		/**종료**/
		out_dl.add(ds_List);
		this.setResultMessage(0, "OK", out_vl);

	}
	catch(Exception ex)
	{
		//jsp 로그남기기
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
		//jsp log 서비스 닫기 
		try {
			logger.endIndividualLog();
		} catch( Exception logE) {
			logE.printStackTrace();
		}
	}

	proc_output(response,out,out_vl,out_dl);

%>