
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

		DataSet ds_input	= in_dl.get("ds_input");

	    String START_DATE	= nullToBlank(ds_input.getString(0, "START_DATE"));
		String END_DATE		= nullToBlank(ds_input.getString(0, "END_DATE"));
		String TRANS_TYPE	= nullToBlank(ds_input.getString(0, "TRANS_TYPE"));
		String SUBINV_CODE	= nullToBlank(ds_input.getString(0, "SUBINV_CODE"));
		String ITEM_CODE	= nullToBlank(ds_input.getString(0, "ITEM_CODE"));
		String CUSTCD		= nullToBlank(ds_input.getString(0, "CUSTCD"));
		String CHK_01		= nullToBlank(ds_input.getString(0, "CHK_01"));
		String CHK_05		= nullToBlank(ds_input.getString(0, "CHK_05"));
		String CHK_06		= nullToBlank(ds_input.getString(0, "CHK_06"));
		String CHK_08		= nullToBlank(ds_input.getString(0, "CHK_08"));

		StringBuffer sbSql = new StringBuffer();

		sbSql.delete(0, sbSql.length());
		sbSql.append("/* 기간별 집계내역 - 계정과목 */ \n");

		// [1] 구매단위 표시 체크시
		if( CHK_01.equals("1") )
		{
			sbSql.append("SELECT SUBSTR(A.TRANS_TYPE,1,1) AS TRANS_TYPE \n");
			sbSql.append("     , A.ACCTCD || ' ' || B.ACCTNM6 || DECODE(A.TRANS_TYPE, 'O002', '(이관)') AS ACCTCD \n");
		    // [6]출고(-)표시언체크
			if( CHK_06.equals("0") )
			{
				sbSql.append("     , SUM(ROUND(A.MARGIN_AMOUNT)) AS MARGIN_AMOUNT \n");
			}
			// [6]출고(-)표시체크
			else
			{
				sbSql.append("     , SUM(ROUND(A.MARGIN_AMOUNT)) * DECODE(SUBSTR(A.TRANS_TYPE, 1, 1), 'I', 1, -1) AS MARGIN_AMOUNT \n");
			}
			sbSql.append("  FROM HLDC_PO_TRANSACTION A \n");
			sbSql.append("     , ST_ACCOUNT B  \n ");
			sbSql.append(" WHERE A.ACCTCD = B.ACCTCD \n");
			sbSql.append("   AND A.TRANS_DATE BETWEEN '" + START_DATE + "' AND '" + END_DATE + "' \n");
			sbSql.append("   AND A.TRANS_TYPE LIKE '" + TRANS_TYPE + "' \n");
			sbSql.append("   AND A.SUBINV_CODE = '" + SUBINV_CODE + "' \n");
//			sbSql.append("   AND A.ACCTCD IN ('11402000', '42203010', '42203020', '42203030') \n");
			sbSql.append("   AND B.BU_CD = '2000' \n");
			// 아이템코드가 있을때
			if( !ITEM_CODE.equals("") )
			{
				sbSql.append("   AND A.ITEM_CODE = '" + ITEM_CODE + "' \n");
			}
			 // 거래처코드가있을때
			if( !CUSTCD.equals("") )
			{
				sbSql.append("   AND A.CUSTCD LIKE '" + CUSTCD + "%' \n");
			}
			// [5]재고단가 제로체크시
			if( CHK_05.equals("1") )
			{
				sbSql.append("   AND A.MARGIN_PRICE = 0 \n");
			}
			sbSql.append(" GROUP BY SUBSTR(A.TRANS_TYPE, 1, 1), A.ACCTCD || ' ' || B.ACCTNM6 || DECODE(A.TRANS_TYPE, 'O002', '(이관)') \n");
		}
		// [1]구매단위 언체크시
		else
		{
			sbSql.append("SELECT SUBSTR(A.TRANS_TYPE, 1, 1) AS TRANS_TYPE \n");
			sbSql.append("     , A.ACCTCD || ' ' || B.ACCTNM6 || DECODE(A.TRANS_TYPE, 'O002', '(이관)') AS ACCTCD \n");
		    // [6]출고(-)표시언체크
			if( CHK_06.equals("0") )
			{
				sbSql.append("     , SUM(ROUND(A.MARGIN_AMOUNT)) AS MARGIN_AMOUNT \n");
			}
			// [6]출고(-)표시체크
			else
			{
				sbSql.append("     , SUM(ROUND(A.MARGIN_AMOUNT)) * DECODE(SUBSTR(A.TRANS_TYPE, 1, 1), 'I', 1, -1) AS MARGIN_AMOUNT \n");
			}
			sbSql.append("  FROM HLDC_PO_TRANSACTION A \n");
			sbSql.append("     , ST_ACCOUNT B \n");
			sbSql.append(" WHERE A.ACCTCD = B.ACCTCD \n");
      		sbSql.append("   AND A.TRANS_DATE BETWEEN '" + START_DATE + "' AND '" + END_DATE + "' \n");
			sbSql.append("   AND A.TRANS_TYPE LIKE '" + TRANS_TYPE + "' \n");
			sbSql.append("   AND A.SUBINV_CODE = '" + SUBINV_CODE + "' \n");
//			sbSql.append("   AND A.ACCTCD IN ('11402000', '42203010', '42203020', '42203030') \n");
			sbSql.append("   AND B.BU_CD = '2000' \n");
			// 아이템코드가 있을때
			if( !ITEM_CODE.equals("") )
			{
				sbSql.append("   AND A.ITEM_CODE = '" + ITEM_CODE + "' \n");
			}
			// 거래처코드가있을때
			if( !CUSTCD.equals("") )
			{
				sbSql.append("   AND A.CUSTCD LIKE '" + CUSTCD + "%' \n");
			}
			// [5]재고단가 제로체크시
			if( CHK_05.equals("1") )
			{
				sbSql.append("   AND A.MARGIN_PRICE = 0 \n");
			}
			sbSql.append(" GROUP BY SUBSTR(A.TRANS_TYPE, 1, 1), A.ACCTCD || ' ' || B.ACCTNM6 || DECODE(A.TRANS_TYPE, 'O002', '(이관)') \n");
		}

		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		DataSet ds_list3 = this.makeDataSet(rs, "ds_list3");

		out_dl.add(ds_list3);
		this.setResultMessage(0, "OK", out_vl);
	}
	catch( Exception ex )
	{
		// jsp 로그남기기
		logger.debug(ex.getMessage(), ex);
		this.setResultMessage(-1, ex.toString(), out_vl);
	}
	finally
	{
		if( rs != null )
		{
			try {
				rs.close();
			} catch( Exception e ) {}
		}
		if( pstmt != null )
		{
			try {
				pstmt.close();
			} catch( Exception e ) {}
		}
		if( conn != null )
		{
			try {
				conn.close();
			} catch( Exception e ) {}
		}
	
		// jsp log 서비스 닫기
		try {
			logger.endIndividualLog();
		} catch( Exception logE ) {
			logE.printStackTrace();
		}
	}
	
	proc_output(response, out, out_vl, out_dl);
%>