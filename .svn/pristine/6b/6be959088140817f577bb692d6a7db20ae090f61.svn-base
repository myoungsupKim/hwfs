<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/메뉴관리/레시피관리
■ 프로그램ID   : FMM00110E_T001.jsp
■ 프로그램명   : 레시피 대체상품 등록(저장)
■ 작성일자     : 2008-03-25
■ 작성자       : 박은규
■ 이력관리     : 2008-03-25 - 최초작성
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	try
	{
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));		
		
		//오토커밋 강제 false
		conn.setAutoCommit(false);
	
		//입력 데이타
		DataSet ds_MultiUpj = in_dl.get("ds_MultiUpj");
		DataSet ds_List   = in_dl.get("ds_List");
		//FileLog.println("d:\\aaa.txt", ds_list);
	
		//입력 파라메터
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		String sMainUpjang  = nullToBlank(in_vl.getString("sMainUpjang"));
		String sUpjang      = nullToBlank(in_vl.getString("sUpjang"));

		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		String sSql, sChk;
		sSql = "INSERT INTO FMM_CHG_ITEM_LIST(UPJANG, ITEM_CODE, ITEM_CODE_TO, CUSER, CDATE, UUSER, UDATE)" +
        "VALUES (?,?,?,?,SYSDATE,?,SYSDATE)";
		for ( int iUpj = 0; iUpj < ds_MultiUpj.getRowCount(); iUpj++ )
		{
			sChk = nullToBlank(ds_MultiUpj.getString(iUpj, "CHK"));
			if (sChk.equals("0")) continue;
			
			sUpjang = nullToBlank(ds_MultiUpj.getString(iUpj, "UPJANG"));
			//기존자료 삭제
			sbSql.delete(0, sbSql.length());
			sbSql.append("DELETE FROM FMM_CHG_ITEM_LIST A \n");
			sbSql.append(" WHERE A.UPJANG = " + sUpjang + " \n");
out_vl.add("fa_Sql", sbSql.toString());
			//System.out.println(sbSql.toString());
			pstmt = conn.prepareStatement(sbSql.toString());
			pstmt.executeUpdate();
			pstmt.close();

			//입력
			pstmt = conn.prepareStatement(sSql);
			for ( int iRow = 0; iRow < ds_List.getRowCount(); iRow++ )
			{
				pstmt.setString(1, sUpjang);
				pstmt.setString(2, nullToBlank(ds_List.getString(iRow, "ITEM_CODE")));
				pstmt.setString(3, nullToBlank(ds_List.getString(iRow, "ITEM_CODE_TO")));
				pstmt.setString(4, g_EmpNo);
				pstmt.setString(5, g_EmpNo);
				//차례로 sql문의 ? 위치에 맞게 변수를 대입하세요.
				pstmt.addBatch(); //변수대입이 끝나면 다음 배치추가
			}
			pstmt.executeBatch(); //배치처리
			pstmt.close();
		}

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