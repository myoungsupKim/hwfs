<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/기준정보/공급업체관리
■ 프로그램ID   : FMS00240E_T002.jsp
■ 프로그램명   : 단가사업장 공급업체 예외설정(저장)
■ 작성일자     : 2013-01-28
■ 작성자       : 박은규
■ 이력관리     : 2013-01-28
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
		DataSet ds_List     = in_dl.get("ds_List");
		//입력 파라메터
		String strUpjang    = nullToBlank(in_vl.getString("strUpjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		//FileLog.println("d:\\aaa.txt", ds_List);


		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		//초기화
		sbSql.append("DELETE FROM FMP_OTCUST_LINK A \n");
		sbSql.append(" WHERE A.UPJANG = " + strUpjang + " \n");
		
out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());
		pstmt.executeUpdate();
		pstmt.close();

		//재입력
		String sSql;
		sSql = "INSERT INTO FMP_OTCUST_LINK(UPJANG, OTCUSTCD, REMARK, USE_YN, CUSER, CDATE, UUSER, UDATE)" +
				"VALUES (?,?,?,SCC_YN_FUN(?,'U'),?,SYSDATE,?,SYSDATE)";
		pstmt = conn.prepareStatement(sSql);
		for ( int i = 0 ; i < ds_List.getRowCount() ; i++ )
		{
			//일단 'Y'(사용가능)인 것은 필요없으니 굳이 저장하지 말자...
			if (ds_List.getString(i, "USE_YN").equals("1")) continue;
			//
			pstmt.setString(1, strUpjang);
			pstmt.setString(2, nullToBlank(ds_List.getString(i, "OTCUSTCD")));
			pstmt.setString(3, "단가업장별 사용불가 공급업체 등록");
			pstmt.setString(4, nullToBlank(ds_List.getString(i, "USE_YN")));
			pstmt.setString(5, g_EmpNo);
			pstmt.setString(6, g_EmpNo);
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