<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/단가관리/공급업체관리
■ 프로그램ID   : FMU00241P_T001.jsp
■ 프로그램명   : 운영율 등록관리/분류별 운영률(저장)
■ 작성일자     : 2008.08.04
■ 작성자       : 박은규
■ 이력관리     : [고도화]_운영율 관련 수정_김경은
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
		
		//오토커밋 강제 false
		conn.setAutoCommit(false);
	
		//입력 데이타
		DataSet ds_List2   = in_dl.get("ds_List2");
		DataSet ds_List3   = in_dl.get("ds_List3");
		DataSet ds_List4   = in_dl.get("ds_List4");
	
		//입력 파라메터
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		String sUpjang      = nullToBlank(in_vl.getString("sUpjang"));


		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		//기존자료 삭제
		sbSql.append("DELETE FROM FMU_OP_RATE A \n");
		sbSql.append(" WHERE A.UPJANG = " + sUpjang + " \n");
		sbSql.append("   AND A.SDATE  = '00000000' \n");
		
out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());
		pstmt.executeUpdate();
		
		pstmt.close();

		//입력
		String sSql;
		sSql = "INSERT INTO FMU_OP_RATE(UPJANG, ITEM_TYPE, SDATE, ITEM_CODE, EDATE, OP_RATE, CUSER, CDATE, UUSER, UDATE, ATTR01)" +
               "VALUES (?,'C','00000000',?,'00000000',?,?,SYSDATE,?,SYSDATE,'P')";
		pstmt = conn.prepareStatement(sSql);
		for ( int iRow = 0; iRow < ds_List2.getRowCount(); iRow++ )
		{
			pstmt.setString(1, sUpjang);
			pstmt.setString(2, nullToBlank(ds_List2.getString(iRow, "CLASS_CODE")));
			pstmt.setString(3, nullToBlank(ds_List2.getString(iRow, "OP_RATE")));
			pstmt.setString(4, g_EmpNo);
			pstmt.setString(5, g_EmpNo);
			//차례로 sql문의 ? 위치에 맞게 변수를 대입하세요.
			pstmt.addBatch(); //변수대입이 끝나면 다음 배치추가
		}
		for ( int iRow = 0; iRow < ds_List3.getRowCount(); iRow++ )
		{
			pstmt.setString(1, sUpjang);
			pstmt.setString(2, nullToBlank(ds_List3.getString(iRow, "CLASS_CODE")));
			pstmt.setString(3, nullToBlank(ds_List3.getString(iRow, "OP_RATE")));
			pstmt.setString(4, g_EmpNo);
			pstmt.setString(5, g_EmpNo);
			//차례로 sql문의 ? 위치에 맞게 변수를 대입하세요.
			pstmt.addBatch(); //변수대입이 끝나면 다음 배치추가
		}
		for ( int iRow = 0; iRow < ds_List4.getRowCount(); iRow++ )
		{
			pstmt.setString(1, sUpjang);
			pstmt.setString(2, nullToBlank(ds_List4.getString(iRow, "CLASS_CODE")));
			pstmt.setString(3, nullToBlank(ds_List4.getString(iRow, "OP_RATE")));
			pstmt.setString(4, g_EmpNo);
			pstmt.setString(5, g_EmpNo);
			//차례로 sql문의 ? 위치에 맞게 변수를 대입하세요.
			pstmt.addBatch(); //변수대입이 끝나면 다음 배치추가
		}
		pstmt.executeBatch(); //배치처리
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

<%--
	try	{
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));		
		
		//오토커밋 강제 false
		conn.setAutoCommit(false);
	
		//입력 데이타
		DataSet ds_List2   = in_dl.get("ds_List2");
		DataSet ds_List3   = in_dl.get("ds_List3");
		DataSet ds_List4   = in_dl.get("ds_List4");
	
		//입력 파라메터
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		String sUpjang      = nullToBlank(in_vl.getString("sUpjang"));


		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		//기존자료 삭제
		sbSql.append("DELETE FROM FMU_OP_RATE A \n");
		sbSql.append(" WHERE A.UPJANG = " + sUpjang + " \n");
		sbSql.append("   AND A.SDATE  = '00000000' \n");
		
out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());
		pstmt.executeUpdate();
		
		pstmt.close();

		//입력
		String sSql;
		sSql = "INSERT INTO FMU_OP_RATE(UPJANG, SDATE, ITEM_CODE, EDATE, OP_RATE, CUSER, CDATE, UUSER, UDATE)" +
               "VALUES (?,'00000000',?,'00000000',?,?,SYSDATE,?,SYSDATE)";
		pstmt = conn.prepareStatement(sSql);
		for ( int iRow = 0; iRow < ds_List2.getRowCount(); iRow++ )
		{
			pstmt.setString(1, sUpjang);
			pstmt.setString(2, nullToBlank(ds_List2.getString(iRow, "CLASS_CODE")));
			pstmt.setString(3, nullToBlank(ds_List2.getString(iRow, "OP_RATE")));
			pstmt.setString(4, g_EmpNo);
			pstmt.setString(5, g_EmpNo);
			//차례로 sql문의 ? 위치에 맞게 변수를 대입하세요.
			pstmt.addBatch(); //변수대입이 끝나면 다음 배치추가
		}
		for ( int iRow = 0; iRow < ds_List3.getRowCount(); iRow++ )
		{
			pstmt.setString(1, sUpjang);
			pstmt.setString(2, nullToBlank(ds_List3.getString(iRow, "CLASS_CODE")));
			pstmt.setString(3, nullToBlank(ds_List3.getString(iRow, "OP_RATE")));
			pstmt.setString(4, g_EmpNo);
			pstmt.setString(5, g_EmpNo);
			//차례로 sql문의 ? 위치에 맞게 변수를 대입하세요.
			pstmt.addBatch(); //변수대입이 끝나면 다음 배치추가
		}
		for ( int iRow = 0; iRow < ds_List4.getRowCount(); iRow++ )
		{
			pstmt.setString(1, sUpjang);
			pstmt.setString(2, nullToBlank(ds_List4.getString(iRow, "CLASS_CODE")));
			pstmt.setString(3, nullToBlank(ds_List4.getString(iRow, "OP_RATE")));
			pstmt.setString(4, g_EmpNo);
			pstmt.setString(5, g_EmpNo);
			//차례로 sql문의 ? 위치에 맞게 변수를 대입하세요.
			pstmt.addBatch(); //변수대입이 끝나면 다음 배치추가
		}
		pstmt.executeBatch(); //배치처리
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

--%>