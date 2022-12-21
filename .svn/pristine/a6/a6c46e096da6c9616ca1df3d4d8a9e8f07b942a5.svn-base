<%
/*-----------------------------------------------------------------------------
■ 시스템명     : FS구매관리/특판상품마감
■ 프로그램ID   : FSP00016E_T002.jsp
■ 프로그램명   : 특판상품조회 - 주문삭제
■ 작성일자     : 2010.06.14
■ 작성자       : 박은규
■ 이력관리     : 2010.06.14
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

		//입력 파라메터
		String strSpID      = nullToBlank(in_vl.getString("strSpID"));
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		String g_Name       = nullToBlank(in_vl.getString("g_Name"));

		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		//삭제 전 백업처리
		sbSql.delete(0, sbSql.length());
		sbSql.append("INSERT INTO FSP_PO_SPECIAL_SALE_DELETED \n");
		sbSql.append("(  SP_ID \n");
		sbSql.append(" , SP_TYPE \n");
		sbSql.append(" , SP_DATE \n");
		sbSql.append(" , ITEM_CODE \n");
		sbSql.append(" , SALE_PRICE \n");
		sbSql.append(" , PR_QTY \n");
		sbSql.append(" , SALE_AMOUNT \n");
		sbSql.append(" , DC_AMOUNT \n");
		sbSql.append(" , CONTENT \n");
		sbSql.append(" , SALE_TYPE \n");
		sbSql.append(" , LINE_STATUS \n");
		sbSql.append(" , PR_SABUN \n");
		sbSql.append(" , RQ_SABUN \n");
		sbSql.append(" , RQ_TEL \n");
		sbSql.append(" , SEND_NAME \n");
		sbSql.append(" , SEND_TEL \n");
		sbSql.append(" , SEND_POSTNO \n");
		sbSql.append(" , SEND_ADDR \n");
		sbSql.append(" , RECE_NAME \n");
		sbSql.append(" , RECE_TEL \n");
		sbSql.append(" , RECE_HP \n");
		sbSql.append(" , RECE_POSTNO \n");
		sbSql.append(" , RECE_ADDR \n");
		sbSql.append(" , AR_SAUPNO \n");
		sbSql.append(" , AR_POSTNO \n");
		sbSql.append(" , AR_ADDR \n");
		sbSql.append(" , AR_NAME \n");
		sbSql.append(" , AR_TEL \n");
		sbSql.append(" , AR_EMAIL \n");
		sbSql.append(" , PAY_METHOD \n");
		sbSql.append(" , INST_PERIOD \n");
		sbSql.append(" , CARD_COMP \n");
		sbSql.append(" , CARD_NUM \n");
		sbSql.append(" , VALID_THRU_YY \n");
		sbSql.append(" , VALID_THRU_MM \n");
		sbSql.append(" , PAY_TIME \n");
		sbSql.append(" , PAY_SABUN \n");
		sbSql.append(" , BILL_NO \n");
		sbSql.append(" , CANCEL_TIME \n");
		sbSql.append(" , CANCEL_SABUN \n");
		sbSql.append(" , CANCEL_BILL_NO \n");
		sbSql.append(" , DELI_TYPE \n");
		sbSql.append(" , DELI_COMP \n");
		sbSql.append(" , DELI_TIME \n");
		sbSql.append(" , DELI_SABUN \n");
		sbSql.append(" , INVOICE_NUM \n");
		sbSql.append(" , CREATE_DATE \n");
		sbSql.append(" , CREATE_BY \n");
		sbSql.append(" , UPDATE_DATE \n");
		sbSql.append(" , UPDATE_BY \n");
		sbSql.append(" , REMARK ) \n");
		sbSql.append("SELECT SP_ID \n");
		sbSql.append("     , SP_TYPE \n");
		sbSql.append("	 , SP_DATE \n");
		sbSql.append("	 , ITEM_CODE \n");
		sbSql.append("	 , SALE_PRICE \n");
		sbSql.append("	 , PR_QTY \n");
		sbSql.append("	 , SALE_AMOUNT \n");
		sbSql.append("	 , DC_AMOUNT \n");
		sbSql.append("	 , CONTENT \n");
		sbSql.append("	 , SALE_TYPE \n");
		sbSql.append("	 , LINE_STATUS \n");
		sbSql.append("	 , PR_SABUN \n");
		sbSql.append("	 , RQ_SABUN \n");
		sbSql.append("	 , RQ_TEL \n");
		sbSql.append("	 , SEND_NAME \n");
		sbSql.append("	 , SEND_TEL \n");
		sbSql.append("	 , SEND_POSTNO \n");
		sbSql.append("	 , SEND_ADDR \n");
		sbSql.append("	 , RECE_NAME \n");
		sbSql.append("	 , RECE_TEL \n");
		sbSql.append("	 , RECE_HP \n");
		sbSql.append("	 , RECE_POSTNO \n");
		sbSql.append("	 , RECE_ADDR \n");
		sbSql.append("	 , AR_SAUPNO \n");
		sbSql.append("	 , AR_POSTNO \n");
		sbSql.append("	 , AR_ADDR \n");
		sbSql.append("	 , AR_NAME \n");
		sbSql.append("	 , AR_TEL \n");
		sbSql.append("	 , AR_EMAIL \n");
		sbSql.append("	 , PAY_METHOD \n");
		sbSql.append("	 , INST_PERIOD \n");
		sbSql.append("	 , CARD_COMP \n");
		sbSql.append("	 , CARD_NUM \n");
		sbSql.append("	 , VALID_THRU_YY \n");
		sbSql.append("	 , VALID_THRU_MM \n");
		sbSql.append("	 , PAY_TIME \n");
		sbSql.append("	 , PAY_SABUN \n");
		sbSql.append("	 , BILL_NO \n");
		sbSql.append("	 , CANCEL_TIME \n");
		sbSql.append("	 , CANCEL_SABUN \n");
		sbSql.append("	 , CANCEL_BILL_NO \n");
		sbSql.append("	 , DELI_TYPE \n");
		sbSql.append("	 , DELI_COMP \n");
		sbSql.append("	 , DELI_TIME \n");
		sbSql.append("	 , DELI_SABUN \n");
		sbSql.append("	 , INVOICE_NUM \n");
		sbSql.append("	 , CREATE_DATE \n");
		sbSql.append("	 , CREATE_BY \n");
		sbSql.append("	 , UPDATE_DATE \n");
		sbSql.append("	 , UPDATE_BY \n");
		sbSql.append("     , SUBSTRB('(삭제 '||TO_CHAR(SYSDATE,'YYYY-MM-DD HH24:MI')||' " + g_EmpNo + "'||' '||'" + g_Name + "'||') '||A.REMARK, 1, 300) AS REMARK \n");
		sbSql.append("  FROM FSP_PO_SPECIAL_SALE A \n");
		sbSql.append(" WHERE A.SP_ID = " + strSpID + " \n");
		sbSql.append("   AND A.LINE_STATUS IN ('정산','배송') \n");

		pstmt = conn.prepareStatement(sbSql.toString());
		pstmt.executeUpdate();
		pstmt.close();

		//트랜젝션 삭제처리
		sbSql.delete(0, sbSql.length());
		sbSql.append("INSERT INTO FSP_PO_SPECIAL_TRANS \n");
        sbSql.append("(  SEASON_NUM \n");
        sbSql.append(" , ITEM_CODE \n");
        sbSql.append(" , TRANS_DATE \n");
        sbSql.append(" , INOUT \n");
        sbSql.append(" , PRICE \n");
        sbSql.append(" , QTY \n");
        sbSql.append(" , AMOUNT \n");
        sbSql.append(" , SP_ID \n");
        sbSql.append(" , REMARK \n");
        sbSql.append(" , CREATE_BY \n");
        sbSql.append(" , CREATE_DATE \n");
        sbSql.append(" , UPDATE_BY \n");
        sbSql.append(" , UPDATE_DATE ) \n");
        sbSql.append("SELECT SEASON_NUM \n");
        sbSql.append("     , ITEM_CODE \n");
        sbSql.append("     , TO_CHAR(SYSDATE, 'YYYYMMDD') AS TRANS_DATE \n");
        sbSql.append("     , 'I' AS INOUT \n");
        sbSql.append("     , SALE_PRICE AS PRICE \n");
        sbSql.append("     , PR_QTY AS QTY \n");
        sbSql.append("     , SALE_AMOUNT AS AMOUNT \n");
        sbSql.append("     , SP_ID \n");
        sbSql.append("     , '상품조회(삭제)' AS REMARK \n");
        sbSql.append("     , '" + g_EmpNo + "' AS CREATE_BY \n");
		sbSql.append("     , SYSDATE AS CREATE_DATE \n");
		sbSql.append("     , '" + g_EmpNo + "' AS UPDATE_BY \n");
		sbSql.append("     , SYSDATE AS UPDATE_DATE \n");
        sbSql.append("  FROM FSP_PO_SPECIAL_SALE \n");
        sbSql.append(" WHERE SP_ID = " + strSpID + " \n");

		//out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());
		pstmt.executeUpdate();
		pstmt.close();

		//삭제처리
		sbSql.delete(0, sbSql.length());
		sbSql.append("DELETE FROM FSP_PO_SPECIAL_SALE A \n");
		sbSql.append(" WHERE A.SP_ID = " + strSpID + " \n");
		sbSql.append("   AND A.LINE_STATUS IN ('정산','배송') \n");

		//out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());
		pstmt.executeUpdate();
		pstmt.close();

		/**종료**/
		conn.commit();
		this.setResultMessage(0, "OK", out_vl);
	}
	catch( Exception ex )
	{
		conn.rollback();
		//ex.printStackTrace();
		//jsp 로그남기기
		logger.debug(ex.getMessage(), ex);
		this.setResultMessage(-1, ex.toString(),out_vl);
	}
	finally
	{
		if( rs != null )
		{
			try {
				rs.close();
			} catch(Exception e) {}
		}
		if( pstmt != null )
		{
			try {
				pstmt.close();
			} catch(Exception e) {}
		}
		if( conn != null )
		{
			try {
				conn.close();
			} catch(Exception e) {}
		}
		//jsp log 서비스 닫기
		try {
			logger.endIndividualLog();
		} catch( Exception logE ) {
			logE.printStackTrace();
		}
	}

	proc_output(response,out,out_vl,out_dl);
%>