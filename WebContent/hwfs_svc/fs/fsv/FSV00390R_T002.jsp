<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 협력업체 > 발주서 > 배송분류표
■ 프로그램ID   : FSV00390R_T002.jsp
■ 프로그램명   : 배송분류표 출력(저장)
■ 작성일자     : 2008-08-29
■ 작성자       : 박은규
■ 이력관리     : 2008-08-29 - 최초작성
               2009-06-02 박은규 Incident#(115984) 요청자:박량우(경인물류센터)
               PO라인별 출력여부 설정 및 출력ID생성, 출력항목 설정
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%

	Statement stmt             =  null;
	try	{
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));

		//IRIS DB연결
		if(conn != null && !conn.isClosed()) conn.close();
		conn = getIRISConn();

		//오토커밋 강제 false
		conn.setAutoCommit(false);

		//입력 데이타
		DataSet ds_Cond      = in_dl.get("ds_Cond");
		DataSet ds_Detail    = in_dl.get("ds_Detail");
		//입력 파라메터
		String g_CustCd     = nullToBlank(in_vl.getString("g_CustCd"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));

		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		//기존확인 초기화
		sbSql.delete(0, sbSql.length());
		sbSql.append("/*----- 기존확인 초기화 -----*/ \n");
		sbSql.append("DELETE FROM PO_ORDER_PRT A \n");
		//sbSql.append(" WHERE A.NEED_DATE = '" + nullToBlank(ds_Cond.getString(0, "NEED_DATE")) + "' \n");
		//sbSql.append("   AND (A.CENTER_CODE,A.ORDER_NUM) IN (" + nullToBlank(ds_Cond.getString(0, "ORDER_NUM")) + ") \n");
		sbSql.append(" WHERE (A.ORDER_NUM,A.NEED_DATE,A.CENTER_CODE) IN \n");
		sbSql.append("( \n");
		sbSql.append("SELECT A.ORDER_NUM \n");
		sbSql.append("     , A.NEED_DATE \n");
		sbSql.append("     , A.CENTER_CODE \n");
		sbSql.append("  FROM PO_PO A \n");
		sbSql.append(" WHERE A.NEED_DATE = '" + nullToBlank(ds_Cond.getString(0, "NEED_DATE")) + "' \n");
		sbSql.append("   AND (A.CENTER_CODE,A.ORDER_NUM) IN (" + nullToBlank(ds_Cond.getString(0, "ORDER_NUM")) + ") \n");
		sbSql.append("   AND A.CUSTCD = '" + g_CustCd + "' \n");
		if (! nullToBlank(ds_Cond.getString(0, "ITEM_NAME")).equals(""))
			sbSql.append("   AND A.ITEM_NAME LIKE '%" + nullToBlank(ds_Cond.getString(0, "ITEM_NAME")) + "%' \n");
		sbSql.append("   AND A.LINE_STATUS = DECODE(A.CENTER_FLAG,'Y','008','009') \n");
		sbSql.append("   AND (A.CENTER_DELI_QTY + A.DIRECT_DELI_QTY) <> 0 \n");
		sbSql.append(" GROUP BY A.ORDER_NUM, A.NEED_DATE, A.CENTER_CODE \n");
		sbSql.append(") \n");
out_vl.add("fa_Sql", sbSql.toString());
		stmt = conn.createStatement();		
		rs = stmt.executeQuery(sbSql.toString()); 		
		stmt.close();
		rs.close();

		//확인
		sbSql.delete(0, sbSql.length());
		sbSql.append("/*----- 확인 -----*/ \n");
		sbSql.append("INSERT INTO PO_ORDER_PRT \n");
		sbSql.append("(ORDER_NUM, NEED_DATE, CENTER_CODE, CUSTCD, ORDER_DISP, ORDER_AMOUNT, PRT_FLAG, PRT_TIME, PRT_SABUN, CREATE_DATE, CREATE_BY, UPDATE_DATE, UPDATE_BY) \n");
		sbSql.append("SELECT A.ORDER_NUM \n");
		sbSql.append("     , A.NEED_DATE \n");
		sbSql.append("     , A.CENTER_CODE \n");
		sbSql.append("     , A.CUSTCD \n");
		sbSql.append("     , MAX(A.ITEM_NAME)||DECODE(SIGN(COUNT(*) - 1),1,' 외 '||TO_CHAR(COUNT(*) - 1)||'종') \n");
		sbSql.append("     , SUM(ROUND(A.UNIT_PRICE * (A.CENTER_DELI_QTY + A.DIRECT_DELI_QTY))) \n");
		sbSql.append("     , 'Y' \n");
		sbSql.append("     , SYSDATE \n");
		sbSql.append("     , '" + g_EmpNo + "' \n");
		sbSql.append("     , SYSDATE \n");
		sbSql.append("     , '" + g_EmpNo + "' \n");
		sbSql.append("     , SYSDATE \n");
		sbSql.append("     , '" + g_EmpNo + "' \n");
		sbSql.append("  FROM PO_PO A \n");
		sbSql.append(" WHERE A.NEED_DATE = '" + nullToBlank(ds_Cond.getString(0, "NEED_DATE")) + "' \n");
		sbSql.append("   AND (A.CENTER_CODE,A.ORDER_NUM) IN (" + nullToBlank(ds_Cond.getString(0, "ORDER_NUM")) + ") \n");
		sbSql.append("   AND A.CUSTCD = '" + g_CustCd + "' \n");
		if (! nullToBlank(ds_Cond.getString(0, "ITEM_NAME")).equals(""))
			sbSql.append("   AND A.ITEM_NAME LIKE '%" + nullToBlank(ds_Cond.getString(0, "ITEM_NAME")) + "%' \n");
		sbSql.append("   AND A.LINE_STATUS = DECODE(A.CENTER_FLAG,'Y','008','009') \n");
		sbSql.append("   AND (A.CENTER_DELI_QTY + A.DIRECT_DELI_QTY) <> 0 \n");
		sbSql.append(" GROUP BY A.ORDER_NUM, A.NEED_DATE, A.CENTER_CODE, A.CUSTCD \n");
out_vl.add("fa_Sql", sbSql.toString());
		stmt = conn.createStatement();		
		rs = stmt.executeQuery(sbSql.toString()); 		
		stmt.close();
		rs.close();
		
//============================================================================================
//(2009-06-02 추가) 시작
// 2009-06-02 박은규 Incident#(115984) 요청자:박량우(경인물류센터)
// PO라인별 출력여부 설정 및 출력ID생성, 출력항목 설정
//============================================================================================
		//JOB_ID생성
		sbSql.delete(0, sbSql.length());
		sbSql.append("SELECT PO_PRINT_JOB_S.NEXTVAL AS JOB_ID FROM DUAL \n");
		stmt = conn.createStatement();
		rs = stmt.executeQuery(sbSql.toString()); 
		rs.next();
		String sJOB_ID = rs.getString("JOB_ID");
		stmt.close();
		rs.close();
		//
		for ( int i = 0 ; i < ds_Detail.getRowCount() ; i++ )
		{
			if (nullToBlank(ds_Detail.getString(i,"CHK")).equals("0")) continue;

			//PO라인별 출력여부 설정
/*
  		sbSql.delete(0, sbSql.length());
	  	sbSql.append("SELECT 1 FROM PO_ORDERLINE_PRT A \n");
			sbSql.append(" WHERE A.PO_ID = " + nullToBlank(ds_Detail.getString(i,"PO_ID")) + " \n");
		  stmt = conn.createStatement();
  		rs = stmt.executeQuery(sbSql.toString()); 
  		if (rs.next())
  		{
    		sbSql.delete(0, sbSql.length());
  			sbSql.append("UPDATE PO_ORDERLINE_PRT A \n");
	  		sbSql.append("   SET A.USE_YN = 'Y' \n");
	  		sbSql.append("     , A.UPDATE_BY = '" + g_EmpNo + "' \n");
		  	sbSql.append("     , A.UPDATE_DATE = SYSDATE \n");
  			sbSql.append(" WHERE A.PO_ID = " + nullToBlank(ds_Detail.getString(i,"PO_ID")) + " \n");
  		}
  		else
  		{
    		sbSql.delete(0, sbSql.length());
  			sbSql.append("INSERT INTO PO_ORDERLINE_PRT A \n");
  			sbSql.append("( A.PO_ID \n");
	  		sbSql.append(", A.USE_YN \n");
		  	sbSql.append(", A.CREATE_BY \n");
			  sbSql.append(", A.CREATE_DATE \n");
  			sbSql.append(", A.UPDATE_BY \n");
	  		sbSql.append(", A.UPDATE_DATE ) \n");
		  	sbSql.append("VALUES \n");
		  	sbSql.append("( B.PO_ID \n");
			  sbSql.append(", 'Y' \n");
  			sbSql.append(", '" + g_EmpNo + "' \n");
	  		sbSql.append(", SYSDATE \n");
		  	sbSql.append(", '" + g_EmpNo + "' \n");
			  sbSql.append(", SYSDATE ) \n");
  		}
*/
			sbSql.delete(0, sbSql.length());
			sbSql.append("/*----- 출력여부설정 -----*/ \n");
			sbSql.append("MERGE INTO PO_ORDERLINE_PRT A \n");
			sbSql.append("USING (SELECT " + nullToBlank(ds_Detail.getString(i,"PO_ID")) + " AS PO_ID FROM DUAL) B \n");
			sbSql.append("   ON (A.PO_ID = B.PO_ID) \n");
			sbSql.append(" WHEN MATCHED THEN \n");
			sbSql.append("      UPDATE \n");
	 		sbSql.append("         SET A.USE_YN = 'Y' \n");
			sbSql.append("           , A.UPDATE_BY = '" + g_EmpNo + "' \n");
			sbSql.append("           , A.UPDATE_DATE = SYSDATE \n");
			sbSql.append(" WHEN NOT MATCHED THEN \n");
			sbSql.append("      INSERT ( A.PO_ID \n");
			sbSql.append("             , A.USE_YN \n");
			sbSql.append("             , A.CREATE_BY \n");
			sbSql.append("             , A.CREATE_DATE \n");
			sbSql.append("             , A.UPDATE_BY \n");
			sbSql.append("             , A.UPDATE_DATE ) \n");
			sbSql.append("      VALUES ( B.PO_ID \n");
			sbSql.append("             , 'Y' \n");
			sbSql.append("             , '" + g_EmpNo + "' \n");
			sbSql.append("             , SYSDATE \n");
			sbSql.append("             , '" + g_EmpNo + "' \n");
			sbSql.append("             , SYSDATE ) \n");
out_vl.add("fa_Sql", sbSql.toString());
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sbSql.toString());
			stmt.close();
			rs.close();

			//출력항목 설정
			sbSql.delete(0, sbSql.length());
			sbSql.append("/*----- 출력항목설정 -----*/ \n");
			sbSql.append("INSERT INTO PO_PRINT_JOB \n");
			sbSql.append("     ( JOB_ID \n");
			sbSql.append("     , PRT_ID \n");
			sbSql.append("     , ALTER_KEY \n");
			sbSql.append("     , PRT_TYPE \n");
			sbSql.append("     , USE_YN \n");
			sbSql.append("     , CREATE_BY \n");
			sbSql.append("     , CREATE_DATE \n");
			sbSql.append("     , UPDATE_BY \n");
			sbSql.append("     , UPDATE_DATE ) \n");
			sbSql.append("VALUES \n");
			sbSql.append("     ( " + sJOB_ID + " \n");
			sbSql.append("     , " + nullToBlank(ds_Detail.getString(i,"PO_ID")) + " \n");
			sbSql.append("     , '" + nullToBlank(ds_Detail.getString(i,"PO_ID")) + "' \n");
			sbSql.append("     , '배송분류표' \n");
			sbSql.append("     , 'Y' \n");
			sbSql.append("     , '" + g_EmpNo + "' \n");
			sbSql.append("     , SYSDATE \n");
			sbSql.append("     , '" + g_EmpNo + "' \n");
			sbSql.append("     , SYSDATE ) \n");
out_vl.add("fa_Sql", sbSql.toString());
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sbSql.toString());
			stmt.close();
			rs.close();
		}
		out_vl.add("faJobID", sJOB_ID);
//============================================================================================
//(2009-06-02 추가) 끝
//============================================================================================

		/**종료**/
		conn.commit();
		this.setResultMessage(0, "OK", out_vl);

	}
	catch(Exception ex)
	{
		conn.rollback();
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
		if(stmt != null) {
			try {
				stmt.close();
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