<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/운영관리/급식운영관리/운영일지등록 및 출력
■ 프로그램ID   : FMO00300E_T002.jsp
■ 프로그램명   : 운영일지 저장
■ 작성일자     : 2008.05.09
■ 작성자       : 박은규
■ 이력관리     : 2008.05.09
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
		DataSet ds_Cond     = in_dl.get("ds_Cond");
		DataSet ds_List     = in_dl.get("ds_List");
		DataSet ds_List1    = in_dl.get("ds_List1");
		DataSet ds_List3    = in_dl.get("ds_List3");
		//입력 파라메터
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
	

		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		//운영일지 기존등록여부
		sbSql.delete(0, sbSql.length());
		sbSql.append( "SELECT 'OK' AS CHK \n");
		sbSql.append( "  FROM FMO_OP_DIARY \n");
		sbSql.append( " WHERE UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + " \n");
		sbSql.append( "   AND OP_DATE = '" + nullToBlank(ds_Cond.getString(0, "SDATE")) + "' \n");
out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery();		
		
		//이미 등록된 자료가 있다면 초기화
		if(rs.next())
		{
			//운영일지
			sbSql.delete(0, sbSql.length());
			sbSql.append("DELETE FROM FMO_OP_DIARY \n");
			sbSql.append(" WHERE UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + " \n");
			sbSql.append("   AND OP_DATE = '" + nullToBlank(ds_Cond.getString(0, "SDATE")) + "' \n");
out_vl.add("fa_Sql", sbSql.toString());
			//System.out.println(sbSql.toString());
			pstmt = conn.prepareStatement(sbSql.toString());
			pstmt.executeUpdate();
			pstmt.close();			

			//메뉴
			sbSql.delete(0, sbSql.length());
			sbSql.append("DELETE FROM FMO_OP_MENU \n");
			sbSql.append(" WHERE UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + " \n");
			sbSql.append("   AND OP_DATE = '" + nullToBlank(ds_Cond.getString(0, "SDATE")) + "' \n");
out_vl.add("fa_Sql", sbSql.toString());
			//System.out.println(sbSql.toString());
			pstmt = conn.prepareStatement(sbSql.toString());
			pstmt.executeUpdate();
			pstmt.close();

			//모니터링
			sbSql.delete(0, sbSql.length());
			sbSql.append("DELETE FROM FMO_OP_MONITORING \n");
			sbSql.append(" WHERE UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + " \n");
			sbSql.append("   AND OP_DATE = '" + nullToBlank(ds_Cond.getString(0, "SDATE")) + "' \n");
out_vl.add("fa_Sql", sbSql.toString());
			//System.out.println(sbSql.toString());
			pstmt = conn.prepareStatement(sbSql.toString());
			pstmt.executeUpdate();
			pstmt.close();
		}
		rs.close();
		
		//운영일지 입력
		sbSql.delete(0, sbSql.length());
		
		sbSql.append("INSERT INTO FMO_OP_DIARY( \n");
		sbSql.append("      UPJANG \n");
		sbSql.append("    , OP_DATE \n");
		sbSql.append("    , LEAVING_QTY \n");
		sbSql.append("    , OVER_QTY \n");
		//sbSql.append("    , LEAVING_MM_TOT \n");
		sbSql.append("    , SPECIAL_DESC \n");
		sbSql.append("    , PARTNERS_DISC \n");
		sbSql.append("    , REQUEST_DISC \n");
		sbSql.append("    , PRE_STOCK \n");
		sbSql.append("    , DD_DELIVER \n");
		sbSql.append("    , DD_USE \n");
		sbSql.append("    , DD_STOCK \n");
		sbSql.append("    , RAW_AMT \n");
		sbSql.append("    , MAN_AVG_QTY \n");
		sbSql.append("    , SALE_PLAN_AMT \n");
		sbSql.append("    , SALE_TOT_PLAN_M \n");
		sbSql.append("    , SALE_ACT_AMT \n");
		sbSql.append("    , SALE_TOT_ACT_M \n");
		sbSql.append("    , GOAL_RATE \n");
		sbSql.append("    , PRE_NO_RCV_AMT \n");
		sbSql.append("    , RCV_AMT \n");
		sbSql.append("    , RCV_IN_AMT \n");
		sbSql.append("    , NO_RCV_AMT \n");
		sbSql.append("    , PREPAY_AMT \n");
		sbSql.append("    , PREPAY_BALANCE \n");
		sbSql.append("    , CUSER \n");
		sbSql.append("    , CDATE \n");
		sbSql.append("    , UUSER \n");
		sbSql.append("    , UDATE \n");
		sbSql.append(" ) VALUES ( \n");
		sbSql.append("	 " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + " \n");
		sbSql.append(" , '" + nullToBlank(ds_Cond.getString(0, "SDATE")) + "' \n");
		sbSql.append(" , NVL('" + nullToBlank(ds_List1.getString(0, "LEAVING_QTY")) + "',0) \n");
		sbSql.append(" , NVL('" + nullToBlank(ds_List1.getString(0, "OVER_QTY")) + "',0) \n");
		//sbSql.append(" , NVL('" + nullToBlank(ds_List1.getString(0, "LEAVING_MM_TOT")) + "',0) \n");
		sbSql.append(" , SUBSTRB('" + nullToBlank(ds_List1.getString(0, "SPECIAL_DESC")) + "',1,300) \n");
		sbSql.append(" , SUBSTRB('" + nullToBlank(ds_List1.getString(0, "PARTNERS_DISC")) + "',1,300) \n");
		sbSql.append(" , SUBSTRB('" + nullToBlank(ds_List1.getString(0, "REQUEST_DISC")) + "',1,300) \n");
		sbSql.append(" , NVL('" + nullToBlank(ds_List1.getString(0, "PRE_STOCK")) + "',0) \n");
		sbSql.append(" , NVL('" + nullToBlank(ds_List1.getString(0, "DD_DELIVER")) + "',0) \n");
		sbSql.append(" , NVL('" + nullToBlank(ds_List1.getString(0, "DD_USE")) + "',0) \n");
		sbSql.append(" , NVL('" + nullToBlank(ds_List1.getString(0, "DD_STOCK")) + "',0) \n");
		sbSql.append(" , NVL('" + nullToBlank(ds_List1.getString(0, "RAW_AMT")) + "',0) \n");
		sbSql.append(" , NVL('" + nullToBlank(ds_List1.getString(0, "MAN_AVG_QTY")) + "',0) \n");
		sbSql.append(" , NVL('" + nullToBlank(ds_List1.getString(0, "SALE_PLAN_AMT")) + "',0) \n");
		sbSql.append(" , NVL('" + nullToBlank(ds_List1.getString(0, "SALE_TOT_PLAN_M")) + "',0) \n");
		sbSql.append(" , NVL('" + nullToBlank(ds_List1.getString(0, "SALE_ACT_AMT")) + "',0) \n");
		sbSql.append(" , NVL('" + nullToBlank(ds_List1.getString(0, "SALE_TOT_ACT_M")) + "',0) \n");
		sbSql.append(" , NVL('" + nullToBlank(ds_List1.getString(0, "GOAL_RATE")) + "',0) \n");
		sbSql.append(" , NVL('" + nullToBlank(ds_List1.getString(0, "PRE_NO_RCV_AMT")) + "',0) \n");
		sbSql.append(" , NVL('" + nullToBlank(ds_List1.getString(0, "RCV_AMT")) + "',0) \n");
		sbSql.append(" , NVL('" + nullToBlank(ds_List1.getString(0, "RCV_IN_AMT")) + "',0) \n");
		sbSql.append(" , NVL('" + nullToBlank(ds_List1.getString(0, "NO_RCV_AMT")) + "',0) \n");
		sbSql.append(" , NVL('" + nullToBlank(ds_List1.getString(0, "PREPAY_AMT")) + "',0) \n");
		sbSql.append(" , NVL('" + nullToBlank(ds_List1.getString(0, "PREPAY_BALANCE")) + "',0) \n");
		sbSql.append(" , '" + g_EmpNo + "' \n");
		sbSql.append(" , SYSDATE \n");
		sbSql.append(" , '" + g_EmpNo + "' \n");
		sbSql.append(" , SYSDATE \n");
		sbSql.append(" ) \n");
		
out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());
		pstmt.executeUpdate();
		pstmt.close();
		//메뉴 입력
		for ( int i = 0 ; i < ds_List.getRowCount() ; i++ )
		{
			sbSql.delete(0, sbSql.length());
			
			sbSql.append("INSERT INTO FMO_OP_MENU( \n");
			sbSql.append("      UPJANG \n");
			sbSql.append("    , OP_DATE \n");
			sbSql.append("    , SUBINV_CODE \n");
			sbSql.append("    , MEAL \n");
			sbSql.append("    , CORNER \n");
			sbSql.append("    , OFFER_MENU \n");
			sbSql.append("    , EXPECT_MEAL_QTY \n");
			sbSql.append("    , REAL_MEAL_QTY \n");
			sbSql.append("    , GOAL_COST_RATE \n");
			sbSql.append("    , MEAL_TOT \n");
			sbSql.append("    , CUSER \n");
			sbSql.append("    , CDATE \n");
			sbSql.append("    , UUSER \n");
			sbSql.append("    , UDATE \n");
			sbSql.append(" ) VALUES ( \n");
			sbSql.append("	 " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + " \n");
			sbSql.append(" , '" + nullToBlank(ds_Cond.getString(0, "SDATE")) + "' \n");
			sbSql.append(" , '" + nullToBlank(ds_List.getString(i, "SUBINV_CODE")) + "' \n");
			sbSql.append(" , '" + nullToBlank(ds_List.getString(i, "MEAL")) + "' \n");
			sbSql.append(" , '" + nullToBlank(ds_List.getString(i, "CORNER")) + "' \n");
			sbSql.append(" , '" + nullToBlank(ds_List.getString(i, "OFFER_MENU")) + "' \n");
			sbSql.append(" , NVL('" + nullToBlank(ds_List.getString(i, "EXPECT_MEAL_QTY")) + "',0) \n");
			sbSql.append(" , NVL('" + nullToBlank(ds_List.getString(i, "REAL_MEAL_QTY")) + "',0) \n");
			sbSql.append(" , NVL('" + nullToBlank(ds_List.getString(i, "GOAL_COST_RATE")) + "',0) \n");
			sbSql.append(" , NVL('" + nullToBlank(ds_List.getString(i, "MEAL_TOT")) + "',0) \n");
			sbSql.append(" , '" + g_EmpNo + "' \n");
			sbSql.append(" , SYSDATE \n");
			sbSql.append(" , '" + g_EmpNo + "' \n");
			sbSql.append(" , SYSDATE \n");
			sbSql.append(" ) \n");
			
out_vl.add("fa_Sql", sbSql.toString());
			//System.out.println(sbSql.toString());
			pstmt = conn.prepareStatement(sbSql.toString());
			pstmt.executeUpdate();
			pstmt.close();
		}

		//모니터링  입력
		for ( int i = 0 ; i < ds_List3.getRowCount() ; i++ )
		{
			sbSql.delete(0, sbSql.length());
			
			sbSql.append("INSERT INTO FMO_OP_MONITORING( \n");
			sbSql.append("      UPJANG \n");
			sbSql.append("    , OP_DATE \n");
			sbSql.append("    , SEQ \n");
			sbSql.append("    , MEAL \n");
			sbSql.append("    , GUBUN \n");
			sbSql.append("    , CLASS \n");
			sbSql.append("    , CONTENTS \n");
			sbSql.append("    , MGMT_DISC \n");
			sbSql.append("    , CUSER \n");
			sbSql.append("    , CDATE \n");
			sbSql.append("    , UUSER \n");
			sbSql.append("    , UDATE \n");
			sbSql.append(" ) VALUES ( \n");
			sbSql.append("	 " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + " \n");
			sbSql.append(" , '" + nullToBlank(ds_Cond.getString(0, "SDATE")) + "' \n");
			sbSql.append(" , " + Integer.toString(i+1) + " \n");
			sbSql.append(" , '" + nullToBlank(ds_List3.getString(i, "MEAL")) + "' \n");
			sbSql.append(" , '" + nullToBlank(ds_List3.getString(i, "GUBUN")) + "' \n");
			sbSql.append(" , '" + nullToBlank(ds_List3.getString(i, "CLASS")) + "' \n");
			sbSql.append(" , SUBSTRB('" + nullToBlank(ds_List3.getString(i, "CONTENTS")) + "',1,300) \n");
			sbSql.append(" , SUBSTRB('" + nullToBlank(ds_List3.getString(i, "MGMT_DISC")) + "',1,300) \n");
			sbSql.append(" , '" + g_EmpNo + "' \n");
			sbSql.append(" , SYSDATE \n");
			sbSql.append(" , '" + g_EmpNo + "' \n");
			sbSql.append(" , SYSDATE \n");
			sbSql.append(" ) \n");
			
out_vl.add("fa_Sql", sbSql.toString());
			//System.out.println(sbSql.toString());
			pstmt = conn.prepareStatement(sbSql.toString());
			pstmt.executeUpdate();
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