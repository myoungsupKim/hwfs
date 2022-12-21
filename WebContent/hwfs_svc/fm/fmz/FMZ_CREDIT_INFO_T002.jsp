<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/공통
■ 프로그램ID   : FMZ_CREDIT_INFO_T002.jsp
■ 프로그램명   : 가상계좌 입금확인 처리
■ 작성일자     : 2008.01.30
■ 작성자       : 박은규
■ 이력관리     : 2008.01.30
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

		//HLDC유저 접속
		conn = getIRISConn();
		//오토커밋 강제 false
		conn.setAutoCommit(false);

		//입력 데이타
		DataSet ds_Cond     = in_dl.get("ds_Cond");
		//입력 파라메터
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		//FileLog.println("d:\\aaa.txt", ds_Cond);

		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		String strOutMsg1 = "";
		String strOutMsg2 = ""; 

		//실행
		cstmt = conn.prepareCall( "{call TR_VIR_ACCOUNT_LIST_PRO(?, ?, ?, ?)}" );		
		
		cstmt.setString(1, ds_Cond.getString(0,"RCP_DATEF"));
		cstmt.setString(2, ds_Cond.getString(0,"RCP_DATET"));
		cstmt.registerOutParameter(3, Types.VARCHAR);
		cstmt.registerOutParameter(4, Types.VARCHAR);
		cstmt.execute();
		System.out.println(cstmt.getString(4));
		
		if(cstmt.getString(4).equals("N"))	
		{
			conn.rollback();
			this.setResultMessage(-1, cstmt.getString(3), out_vl);
			//throw new Exception();
			proc_output(response,out,out_vl,out_dl);
			return;			
		}
		cstmt.close();

/*
		sbSql.delete(0, sbSql.length());
		sbSql.append("BEGIN \n");
		//sbSql.append("  TR_VIR_ACCOUNT_LIST_PRO('" + ds_Cond.getString(0,"RCP_DATEF") + "', '" + ds_Cond.getString(0,"RCP_DATET") + "', '" + strOutMsg1 + "', '" + strOutMsg2 + "'); \n");
		sbSql.append("  TR_VIR_ACCOUNT_LIST_PRO('" + ds_Cond.getString(0,"RCP_DATEF") + "', '" + ds_Cond.getString(0,"RCP_DATET") + "'); \n");
		sbSql.append("END; ");
		pstmt = conn.prepareStatement(sbSql.toString());		
		pstmt.executeQuery(); 
		//pstmt.executeUpdate();
		pstmt.close();
*/

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