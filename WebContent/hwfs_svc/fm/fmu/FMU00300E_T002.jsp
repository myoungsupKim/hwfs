<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/단가관리/공급업체관리
■ 프로그램ID   : FMU00300E_T002.jsp
■ 프로그램명   : 제출단가 등록관리(저장)
■ 작성일자     : 2008.04.15
■ 작성자       : 박은규
■ 이력관리     : 2008.04.15
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
		DataSet ds_Cond   = in_dl.get("ds_Cond");
		DataSet ds_List   = in_dl.get("ds_List");
		//FileLog.println("d:\\aaa.txt", ds_list);
	
		//입력 파라메터
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));

		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		String sOtcust     = nullToBlank(ds_Cond.getString(0, "OTCUSTCD"));

		//기존자료 삭제
		sbSql.append("DELETE FROM FMU_SB_PRICE A \n");
		sbSql.append(" WHERE A.UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + " \n");
		sbSql.append("   AND A.SDATE  = '" + nullToBlank(ds_Cond.getString(0, "SDATE")) + "' \n");
		sbSql.append("   AND A.EDATE  = '" + nullToBlank(ds_Cond.getString(0, "EDATE")) + "' \n");
		if (! sOtcust.equals(""))
			sbSql.append("   AND EXISTS (SELECT 1 FROM FMS_ITEM_V B WHERE B.ITEM_CODE = A.ITEM_CODE AND B.OTCUSTCD = '" + nullToBlank(ds_Cond.getString(0, "OTCUSTCD")) + "') \n");
		
out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());
		pstmt.executeUpdate();
		
		pstmt.close();

		//입력
		String sSql;
		sSql = "INSERT INTO FMU_SB_PRICE(UPJANG, SDATE, EDATE, ITEM_CODE, SB_PRICE, CUSER, CDATE, UUSER, UDATE)" +
               "VALUES (?,?,?,?,?,?,SYSDATE,?,SYSDATE)";
		pstmt = conn.prepareStatement(sSql);
		for ( int iRow = 0; iRow < ds_List.getRowCount(); iRow++ )
		{
			//if ((Double.parseDouble(ds_List.getString(iRow, "OP_RATE")) == 0) &&
			//	(Double.parseDouble(ds_List.getString(iRow, "OP_PRICE")) == 0)) continue;

			//입력
			//pstmt.setString(1, nullToBlank(ds_List.getString(iRow, "UPJANG")));
			//pstmt.setString(2, nullToBlank(ds_List.getString(iRow, "SDATE")));
			//pstmt.setString(3, nullToBlank(ds_List.getString(iRow, "EDATE")));
			pstmt.setString(1, nullToBlank(ds_Cond.getString(0, "UPJANG")));
			pstmt.setString(2, nullToBlank(ds_Cond.getString(0, "SDATE")));
			pstmt.setString(3, nullToBlank(ds_Cond.getString(0, "EDATE")));
			pstmt.setString(4, nullToBlank(ds_List.getString(iRow, "ITEM_CODE")));
			pstmt.setString(5, nullToBlank(ds_List.getString(iRow, "SB_PRICE")));
			pstmt.setString(6, g_EmpNo);
			pstmt.setString(7, g_EmpNo);
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