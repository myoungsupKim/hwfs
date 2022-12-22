<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/단가관리/공급업체관리
■ 프로그램ID   : FMU00240E_T002.jsp
■ 프로그램명   : 운영율 등록관리 예외자재(저장)
■ 작성일자     : 2008.04.15
■ 작성자       : 박은규
■ 이력관리     : 2008.04.15
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	PreparedStatement pstmt2 = null;	
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
		String sOtcust     = nullToBlank(ds_Cond.getString(0, "OTCUSTCD"));

		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		
		//기존자료 삭제
		sbSql.append("DELETE FROM FMU_OP_RATE A \n");
		sbSql.append(" WHERE A.UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + " \n");
		sbSql.append("   AND A.ITEM_CODE  = ? \n");
		sbSql.append("   AND A.ITEM_TYPE  = 'M' \n");
		sbSql.append("   AND A.SDATE  = ? \n");
		sbSql.append("   AND A.EDATE  = ? \n");
		if (! sOtcust.equals(""))
			sbSql.append("   AND EXISTS (SELECT 1 FROM FMS_ITEM_V B WHERE B.ITEM_CODE = A.ITEM_CODE AND B.OTCUSTCD = '" + nullToBlank(ds_Cond.getString(0, "OTCUSTCD")) + "') \n");
		
		pstmt = conn.prepareStatement(sbSql.toString());
		for ( int iRow = 0; iRow < ds_List.getRowCount(); iRow++ )
		{
			pstmt.setString(1, nullToBlank(ds_List.getString(iRow, "ITEM_CODE")));
			pstmt.setString(2, nullToBlank(ds_List.getString(iRow, "SDATE")));
			pstmt.setString(3, nullToBlank(ds_List.getString(iRow, "EDATE")));
			
			//차례로 sql문의 ? 위치에 맞게 변수를 대입하세요.
			pstmt.addBatch(); //변수대입이 끝나면 다음 배치추가
		}	
		pstmt.executeBatch(); //배치처리
		pstmt.close();
		
		//입력처리Sql
		sbSql.delete(0, sbSql.length());
		sbSql.append("INSERT INTO FMU_OP_RATE \n");
		sbSql.append("( UPJANG \n");
		sbSql.append(", ITEM_TYPE \n");
		sbSql.append(", SDATE \n");
		sbSql.append(", ITEM_CODE \n");
		sbSql.append(", EDATE \n");
		sbSql.append(", OP_RATE \n");
		sbSql.append(", OP_PRICE \n");
		sbSql.append(", CEIL_VAL \n");
		sbSql.append(", CUSER \n");
		sbSql.append(", CDATE \n");
		sbSql.append(", UUSER \n");
		sbSql.append(", UDATE \n");
		sbSql.append(") VALUES \n");
		sbSql.append("( ? \n");
		sbSql.append(", 'M' \n");
		sbSql.append(", ? \n");
		sbSql.append(", ? \n");
		//현 운영율 이후 일자의 운영율 조회(종료일 세팅)
		sbSql.append(", NVL((SELECT /*+ INDEX_ASC(Z FMU_OP_RATE_PK) */ \n");
		sbSql.append("              TO_CHAR(TO_DATE(Z.SDATE,'YYYYMMDD')-1,'YYYYMMDD') \n");
		sbSql.append("         FROM FMU_OP_RATE Z \n");
		sbSql.append("        WHERE Z.UPJANG = ? \n");
		sbSql.append("          AND Z.SDATE > ? \n");
		sbSql.append("          AND Z.ITEM_CODE = ? \n");
		sbSql.append("          AND Z.ITEM_TYPE = 'M' \n");
		sbSql.append("          AND ROWNUM <= 1), '99991231') \n");
		sbSql.append(", ? \n");
		sbSql.append(", ? \n");
		sbSql.append(", ? \n");
		sbSql.append(", ? \n");
		sbSql.append(", SYSDATE \n");
		sbSql.append(", ? \n");
		sbSql.append(", SYSDATE \n");
		sbSql.append(") \n");
		pstmt = conn.prepareStatement(sbSql.toString());
		
		//현 운영율 이전 종료일 세팅
		sbSql.delete(0, sbSql.length());
		sbSql.append("UPDATE FMU_OP_RATE A \n");
		sbSql.append("   SET A.EDATE = TO_CHAR(TO_DATE(?,'YYYYMMDD')-1,'YYYYMMDD') \n");
		sbSql.append(" WHERE A.UPJANG = ? \n");
		//sbSql.append("   AND A.SDATE < ? \n");
		sbSql.append("   AND A.SDATE = (SELECT MAX(SDATE) FROM FMU_OP_RATE WHERE UPJANG = A.UPJANG AND ITEM_CODE = A.ITEM_CODE AND ITEM_TYPE = 'M' AND SDATE < ?) \n");
		sbSql.append("   AND A.SDATE <> '00000000' \n");
		sbSql.append("   AND A.ITEM_CODE = ? \n");
		sbSql.append("   AND A.ITEM_TYPE = 'M' \n");
		//sbSql.append("   AND ROWNUM <= 1 \n");
		pstmt2 = conn.prepareStatement(sbSql.toString());
		
		//입력
		for ( int iRow = 0; iRow < ds_List.getRowCount(); iRow++ )
		{
			//입력처리
			pstmt.setString(1, nullToBlank(ds_Cond.getString(0, "UPJANG")));
			pstmt.setString(2, nullToBlank(ds_List.getString(iRow, "SDATE")));
			pstmt.setString(3, nullToBlank(ds_List.getString(iRow, "ITEM_CODE")));
			pstmt.setString(4, nullToBlank(ds_Cond.getString(0, "UPJANG")));
			pstmt.setString(5, nullToBlank(ds_List.getString(iRow, "SDATE")));
			pstmt.setString(6, nullToBlank(ds_List.getString(iRow, "ITEM_CODE")));
			pstmt.setString(7, nullToBlank(ds_List.getString(iRow, "OP_RATE")));
			pstmt.setString(8, nullToBlank(ds_List.getString(iRow, "OP_PRICE")));
			pstmt.setString(9, nullToBlank(ds_List.getString(iRow, "CEIL_VAL")));
			pstmt.setString(10, g_EmpNo);
			pstmt.setString(11, g_EmpNo);
			//차례로 sql문의 ? 위치에 맞게 변수를 대입하세요.
			pstmt.addBatch(); //변수대입이 끝나면 다음 배치추가

			//현 운영율 이전 종료일 세팅
			pstmt2.setString(1, nullToBlank(ds_List.getString(iRow, "SDATE")));
			pstmt2.setString(2, nullToBlank(ds_Cond.getString(0, "UPJANG")));
			pstmt2.setString(3, nullToBlank(ds_List.getString(iRow, "SDATE")));
			pstmt2.setString(4, nullToBlank(ds_List.getString(iRow, "ITEM_CODE")));
			//차례로 sql문의 ? 위치에 맞게 변수를 대입하세요.
			pstmt2.addBatch(); //변수대입이 끝나면 다음 배치추가
		}
		
		pstmt.executeBatch(); //배치처리
		pstmt2.executeBatch(); //배치처리
		pstmt.close();
		pstmt2.close();

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
		if(pstmt2 != null) {
			try {
				pstmt2.close();
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
		DataSet ds_Cond   = in_dl.get("ds_Cond");
		DataSet ds_List   = in_dl.get("ds_List");
		//FileLog.println("d:\\aaa.txt", ds_list);
	
		//입력 파라메터
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));


		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		String sOtcust     = nullToBlank(ds_Cond.getString(0, "OTCUSTCD"));

		/*
		//기존자료 삭제
		sbSql.append("DELETE FROM FMU_OP_RATE A \n");
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
		*/
		
		
		//sql문 버퍼생성
		//StringBuffer sbSql = new StringBuffer();

		//기존자료 삭제
		sbSql.append("DELETE FROM FMU_OP_RATE A \n");
		sbSql.append(" WHERE A.UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + " \n");
		sbSql.append("   AND A.ITEM_CODE  = ? \n");
		sbSql.append("   AND A.ITEM_TYPE  = 'M' \n");
		sbSql.append("   AND A.SDATE  = ? \n");
		sbSql.append("   AND A.EDATE  = ? \n");
		if (! sOtcust.equals(""))
			sbSql.append("   AND EXISTS (SELECT 1 FROM FMS_ITEM_V B WHERE B.ITEM_CODE = A.ITEM_CODE AND B.OTCUSTCD = '" + nullToBlank(ds_Cond.getString(0, "OTCUSTCD")) + "') \n");
		
		pstmt = conn.prepareStatement(sbSql.toString());
		for ( int iRow = 0; iRow < ds_List.getRowCount(); iRow++ )
		{
			pstmt.setString(1, nullToBlank(ds_List.getString(iRow, "ITEM_CODE")));
			pstmt.setString(2, nullToBlank(ds_List.getString(iRow, "SDATE")));
			pstmt.setString(3, nullToBlank(ds_List.getString(iRow, "EDATE")));
			
			//차례로 sql문의 ? 위치에 맞게 변수를 대입하세요.
			pstmt.addBatch(); //변수대입이 끝나면 다음 배치추가
		}	
		pstmt.executeBatch(); //배치처리
		pstmt.close();
		
		//입력
		String sSql;
		sSql = "INSERT INTO FMU_OP_RATE(UPJANG, ITEM_TYPE, SDATE, EDATE, ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, CUSER, CDATE, UUSER, UDATE) " +
               "VALUES (?,'M',?,?,?,?,?,?,?,SYSDATE,?,SYSDATE)";
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
			pstmt.setString(2, nullToBlank(ds_List.getString(iRow, "SDATE")));
			pstmt.setString(3, nullToBlank(ds_List.getString(iRow, "EDATE")));
			pstmt.setString(4, nullToBlank(ds_List.getString(iRow, "ITEM_CODE")));
			pstmt.setString(5, nullToBlank(ds_List.getString(iRow, "OP_RATE")));
			pstmt.setString(6, nullToBlank(ds_List.getString(iRow, "OP_PRICE")));
			pstmt.setString(7, nullToBlank(ds_List.getString(iRow, "CEIL_VAL")));
			pstmt.setString(8, g_EmpNo);
			pstmt.setString(9, g_EmpNo);
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