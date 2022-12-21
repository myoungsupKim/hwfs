<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/매출통계
■ 프로그램ID   : MAO00010E_T003.jsp
■ 프로그램명   : 매출집계 데이타 강제생성
■ 작성일자     : 2012-03-09
■ 작성자       : 박은규
■ 이력관리     : 2012-03-09 박은규 - 최초개발 (CH201203_00081)
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	CallableStatement cstmt = null;
	try	{
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));
		
		//오토커밋 강제 false
		conn.setAutoCommit(false);
	
		//입력 데이타
		//DataSet ds_Cond   = in_dl.get("ds_Cond");
		//DataSet ds_List   = in_dl.get("ds_List");
		//FileLog.println("d:\\aaa.txt", ds_list);
	
		//입력 파라메터
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		String fDate        = nullToBlank(in_vl.getString("fDate"));
		String tDate        = nullToBlank(in_vl.getString("tDate"));

		//sql문 버퍼생성
		//StringBuffer sbSql = new StringBuffer();

		//실행
		cstmt = conn.prepareCall( "{call FMB_SETSALEDATA_PRO(?, ?, ?, ?, ?, ?, ?)}" );		
		
		cstmt.setString(1,fDate);
		cstmt.setString(2,tDate);
	    cstmt.setString(3,"");
	    cstmt.setString(4,g_EmpNo);
		cstmt.registerOutParameter(5, Types.VARCHAR);
		cstmt.registerOutParameter(6, Types.INTEGER);
		cstmt.registerOutParameter(7, Types.VARCHAR);

		cstmt.execute();
		//System.out.println(cstmt.getString(5));
		
		if(cstmt.getString(5).equals("FALSE"))	
		{
			conn.rollback();
			this.setResultMessage(-1, cstmt.getString(7), out_vl);
			//throw new Exception();
			proc_output(response,out,out_vl,out_dl);
			return;			
		}

		/**종료**/
		conn.commit();
		//this.setResultMessage(0, "OK", out_vl);
		this.setResultMessage(0, cstmt.getString(6), out_vl);
		cstmt.close();

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
		if(cstmt != null) {
			try {
				cstmt.close();
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