<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 경영관리/주간실적관리
■ 프로그램ID   : MAS40010E_T002.jsp
■ 프로그램명   : 월별손익계획삭제
■ 작성일자     : 2013-12-11
■ 작성자       : 김장욱
■ 이력관리     : 
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
		DataSet ds_Cond     = in_dl.get("ds_Cond");
		DataSet ds_List     = in_dl.get("ds_List");
		//입력 파라메터
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));

		//FileLog.println("d:\\aaa.txt", ds_List);

		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		//저장
		sbSql.delete(0, sbSql.length());
		sbSql.append("      DELETE MAS_DAILY_PL_REPORT A                       \n");
		sbSql.append("       WHERE A.INPUT_YM     = '" + nullToBlank(ds_Cond.getString(0, "INPUT_YM")) + "'  \n");
		sbSql.append("         AND A.DOC_CD       = '" + nullToBlank(ds_Cond.getString(0, "DOC_CD")) + "'    \n");
		sbSql.append("         AND A.DOC_GUBUN    = 'P'         \n");


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