<%
//-----------------------------------------------------------------------------
//■ 시스템명     : 단가관리/공급업체 관리/ 공급업체 발주내역 수정(삭제)
//■ 프로그램ID   : FMP00600E_T003.jsp
//■ 프로그램명   : 공급업체 발주내역 수정
//■ 작성일자     : 2010.06.02
//■ 작성자       : 박은규
//■ 이력관리     : 2010.06.02
//-----------------------------------------------------------------------------*/
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

		//오토커밋 강제 false
		conn.setAutoCommit(false);		

		//입력 데이타
		//DataSet ds_cond     = in_dl.get("ds_cond");
		//입력 파라메터
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		String sPrID        = nullToBlank(in_vl.getString("sPrID"));

		//FileLog.println("d:\\aaa.txt", ds_cond);

		//out 데이타
		//DataSet ds_list;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		//

		//삭제(완전삭제)
//		sbSql.append( "DELETE FROM FMP_OTCUST_PR A \n");
//		sbSql.append( " WHERE A.PR_ID = " + sPrID + " \n");
		//삭제(라인상태만 취소로...)
		sbSql.append( "UPDATE FMP_OTCUST_PR A \n");
		sbSql.append( "   SET PO_QTY = 0 \n");
		sbSql.append( "     , LINE_STATUS = '003' \n");
		sbSql.append( " WHERE A.PR_ID = " + sPrID + " \n");
		
out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());
		pstmt.executeUpdate();
		pstmt.close();

		/**종료**/
		conn.commit();
		this.setResultMessage(0, "OK", out_vl);

	}
	catch(Exception ex)
	{
		conn.rollback();
		//ex.printStackTrace();
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
