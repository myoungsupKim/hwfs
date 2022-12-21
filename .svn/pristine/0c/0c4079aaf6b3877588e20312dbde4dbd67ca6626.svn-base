<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/단가관리
■ 프로그램ID   : FMU00270E_T004.jsp
■ 프로그램명   : 운영율 초기화
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

		//현 운영율 이전 종료일 세팅
		sbSql.delete(0, sbSql.length());
		sbSql.append("UPDATE FMU_OP_RATE A \n");
		sbSql.append("   SET A.EDATE \n");
		//현 운영율 이후 일자의 운영율 조회(종료일 세팅)
		sbSql.append("     = NVL((SELECT /*+ INDEX_ASC(Z FMU_OP_RATE_PK) */ \n");
		sbSql.append("                   TO_CHAR(TO_DATE(Z.SDATE,'YYYYMMDD')-1,'YYYYMMDD') \n");
		sbSql.append("              FROM FMU_OP_RATE Z \n");
		sbSql.append("             WHERE Z.UPJANG = ? \n");
		sbSql.append("               AND Z.SDATE > ? \n");
		sbSql.append("               AND Z.ITEM_CODE = ? \n");
		sbSql.append("               AND ROWNUM <= 1), '99991231') \n");
		sbSql.append(" WHERE A.UPJANG = ? \n");
		//sbSql.append("   AND A.SDATE < ? \n");
		sbSql.append("   AND A.SDATE = (SELECT MAX(SDATE) FROM FMU_OP_RATE WHERE UPJANG = A.UPJANG AND ITEM_CODE = A.ITEM_CODE AND ITEM_TYPE = 'C' AND SDATE < ?) \n");
		sbSql.append("   AND A.ITEM_CODE = ? \n");
		//sbSql.append("   AND ROWNUM <= 1 \n");
		pstmt = conn.prepareStatement(sbSql.toString());
		
		for ( int iRow = 0; iRow < ds_List.getRowCount(); iRow++ )
		{
			pstmt.setString(1, nullToBlank(ds_Cond.getString(0, "UPJANG")));
			pstmt.setString(2, nullToBlank(ds_Cond.getString(0, "SDATE")));
			pstmt.setString(3, nullToBlank(ds_List.getString(iRow, "ITEM_CLASS4")));
			pstmt.setString(4, nullToBlank(ds_Cond.getString(0, "UPJANG")));
			pstmt.setString(5, nullToBlank(ds_Cond.getString(0, "SDATE")));
			pstmt.setString(6, nullToBlank(ds_List.getString(iRow, "ITEM_CLASS4")));
			//차례로 sql문의 ? 위치에 맞게 변수를 대입하세요.
			pstmt.addBatch(); //변수대입이 끝나면 다음 배치추가
		}
		pstmt.executeBatch(); //배치처리
		pstmt.close();

		//현 운영율 삭제
		sbSql.delete(0, sbSql.length());
		sbSql.append("DELETE FMU_OP_RATE A \n");
		sbSql.append(" WHERE A.UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + " \n");
		sbSql.append("   AND A.SDATE = '" + nullToBlank(ds_Cond.getString(0, "SDATE")) + "' \n");
		
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