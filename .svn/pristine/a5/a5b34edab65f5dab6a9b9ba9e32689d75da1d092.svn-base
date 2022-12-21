<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/주문관리
■ 프로그램ID   : FMP00360R_T001.jsp
■ 프로그램명   : 거래명세서 본사일괄출력
■ 작성일자     : 2012-12-05
■ 작성자       : 문형광
■ 이력관리     : 2012-12-05 문형광 - 최초개발 ()
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
		//FileLog.println("d:\\aaa.txt", ds_list);
	
		//입력 파라메터
		String sDate        = nullToBlank(in_vl.getString("sDate"));

		//sql문 버퍼생성
		//StringBuffer sbSql = new StringBuffer();

		//실행
		cstmt = conn.prepareCall( "{call FMS_CRTCRDINFO_PRO(?, ?, ?, ?)}" );		
		
		cstmt.setString(1,sDate);
		cstmt.registerOutParameter(2, Types.VARCHAR);
		cstmt.registerOutParameter(3, Types.INTEGER);
		cstmt.registerOutParameter(4, Types.VARCHAR);

		cstmt.execute();
		//System.out.println(cstmt.getString(5));
		
		if(cstmt.getString(2).equals("FALSE"))	
		{
			conn.rollback();
			this.setResultMessage(cstmt.getInt(3), cstmt.getString(4), out_vl);
			//throw new Exception();
			proc_output(response,out,out_vl,out_dl);
			return;			
		}

		/**종료**/
		conn.commit();
		//this.setResultMessage(0, "OK", out_vl);
		this.setResultMessage(0, cstmt.getString(2), out_vl);
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