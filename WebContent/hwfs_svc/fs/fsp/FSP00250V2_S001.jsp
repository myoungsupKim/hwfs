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

		DataSet ds_input = in_dl.get("ds_input");
		DataSet ds_list;

	    String START_DATE  = nullToBlank(ds_input.getString(0, "START_DATE"));
		String END_DATE    = nullToBlank(ds_input.getString(0, "END_DATE"));
		String TRANS_TYPE  = nullToBlank(ds_input.getString(0, "TRANS_TYPE"));
		String SUBINV_CODE = nullToBlank(ds_input.getString(0, "SUBINV_CODE"));
		String ITEM_CODE   = nullToBlank(ds_input.getString(0, "ITEM_CODE"));
		String CUSTCD      = nullToBlank(ds_input.getString(0, "CUSTCD"));
		String CHK_01      = nullToBlank(ds_input.getString(0, "CHK_01"));
		String CHK_05      = nullToBlank(ds_input.getString(0, "CHK_05"));
		String CHK_06      = nullToBlank(ds_input.getString(0, "CHK_06"));
		String CHK_08      = nullToBlank(ds_input.getString(0, "CHK_08"));

		StringBuffer sbSql = new StringBuffer();

		sbSql.delete(0, sbSql.length());
		sbSql.append("/* 기간별 집계내역 - 자재 */ \n");

		// [1] 구매단위 표시 체크시
		if( CHK_01.equals("1") )
		{
			sbSql.append("SELECT B.CODE_NAME AS TRANS_NAME \n");
			//sbSql.append("SELECT B.TRANS_NAME AS TRANS_NAME \n");
			sbSql.append("     , A.ITEM_CODE AS ITEM_CODE \n");
			sbSql.append("     , A.ITEM_NAME AS ITEM_NAME \n");
			sbSql.append("     , A.ITEM_SIZE AS ITEM_SIZE \n");
			sbSql.append("     , DECODE(A.TAX_CODE, '100', '과세', '210', '면세', '영세') AS TAX_CODE \n");
			sbSql.append("     , F.PO_UOM  AS UOM_CODE \n");
			sbSql.append("     , DECODE(SUM(A.UOM_QTY), 0, 0, SUM(ROUND(A.MARGIN_AMOUNT)) / SUM(A.UOM_QTY / F.UOM_CONVERT_RATE)) AS UOM_MARGIN_AMOUNT \n");

   			// [6]출고(-)표시언체크
			if( CHK_06.equals("0") )
			{
				sbSql.append("     , SUM(A.UOM_QTY / F.UOM_CONVERT_RATE) AS UOM_QTY \n");
				sbSql.append("     , SUM(ROUND(A.MARGIN_AMOUNT)) AS MARGIN_AMOUNT \n");
//				sbSql.append("       ,SUM(A.SALE_AMOUNT) AS SALE_AMOUNT \n");
			}
			// [6]출고(-)표시체크
			else
			{
				sbSql.append("     , SUM(A.UOM_QTY / F.UOM_CONVERT_RATE) * DECODE(SUBSTR(A.TRANS_TYPE, 1, 1), 'I', 1, -1) AS UOM_QTY \n");
				sbSql.append("     , SUM(ROUND(A.MARGIN_AMOUNT)) * DECODE(SUBSTR(A.TRANS_TYPE, 1, 1), 'I', 1, -1) AS MARGIN_AMOUNT \n");
//				sbSql.append("       ,SUM(A.SALE_AMOUNT) * DECODE(SUBSTR(A.TRANS_TYPE, 1, 1), 'I', 1, -1) AS SALE_AMOUNT \n");
			}

			sbSql.append("  FROM HLDC_PO_TRANSACTION A \n");
			sbSql.append("     , SCC_COMMON_CODE B \n");
			sbSql.append("     , HLDC_PO_ITEM_CLASS_HLDC_V C \n");
			sbSql.append("     , HLDC_PO_ITEM_CLASS_HLDC_V D \n");
			sbSql.append("     , HLDC_PO_ITEM_MST F \n");
			sbSql.append(" WHERE A.TRANS_TYPE = B.CODE \n");
			sbSql.append("   AND A.ITEM_CODE = F.ITEM_CODE \n");
			sbSql.append("   AND C.CLASS_CODE = F.ITEM_CLASS2 \n");
			sbSql.append("   AND C.CLASS_TYPE = 'M' \n");
			sbSql.append("   AND D.CLASS_CODE = F.ITEM_CLASS3 \n");
			sbSql.append("   AND D.CLASS_TYPE = 'S' \n");
			sbSql.append("   AND A.TRANS_DATE BETWEEN '" + START_DATE + "' AND '" + END_DATE + "' \n");
			sbSql.append("   AND A.TRANS_TYPE LIKE '" + TRANS_TYPE + "' \n");
			sbSql.append("   AND A.SUBINV_CODE = '" + SUBINV_CODE + "' \n");
			sbSql.append("   AND B.GROUP_CODE = 'FS0131' \n");
			sbSql.append("   AND B.USE_YN = 'Y' \n");
			// 아이템코드가 있을때
			if( !ITEM_CODE.equals("") )
			{
				sbSql.append("   AND A.ITEM_CODE = '" + ITEM_CODE + "' \n");
			}
			// 거래처코드가있을때
			if( !CUSTCD.equals("") )
			{
//				sbSql.append("   AND PO_ITEMCUST_FUN(TO_CHAR(SYSDATE,'YYYYMMDD'),A.SUBINV_CODE,A.ITEM_CODE) LIKE '"+ CUSTCD +"#%' \n");
				sbSql.append("   AND A.CUSTCD LIKE '" + CUSTCD + "%' \n");
			}
			// [5]재고단가 제로체크시
			if( CHK_05.equals("1") )
			{
				sbSql.append("   AND A.MARGIN_PRICE = 0 \n");
			}
			sbSql.append(" GROUP BY SUBSTR(A.TRANS_TYPE, 1, 1), B.CODE_NAME, A.ITEM_CODE, C.CLASS_CODE, D.CLASS_CODE, A.ITEM_NAME, A.ITEM_SIZE, DECODE(A.TAX_CODE, '100', '과세', '210', '면세', '영세'), F.PO_UOM \n");
			sbSql.append(" ORDER BY B.CODE_NAME, C.CLASS_CODE, D.CLASS_CODE, A.ITEM_CODE \n");
		}
		// [1]구매단위 언체크시
		else
		{
			sbSql.append("SELECT B.CODE_NAME AS TRANS_NAME \n");
			//sbSql.append("SELECT B.TRANS_NAME AS TRANS_NAME \n");
			sbSql.append("     , A.ITEM_CODE AS ITEM_CODE \n");
			sbSql.append("     , A.ITEM_NAME AS ITEM_NAME \n");
			sbSql.append("     , A.ITEM_SIZE AS ITEM_SIZE \n");
			sbSql.append("     , DECODE(A.TAX_CODE, '100', '과세', '210', '면세', '영세') AS TAX_CODE \n");
			sbSql.append("     , A.UOM_CODE  AS UOM_CODE \n");
			sbSql.append("     , DECODE(SUM(A.UOM_QTY), 0, 0, SUM(ROUND(A.MARGIN_AMOUNT)) / SUM(A.UOM_QTY )) AS UOM_MARGIN_AMOUNT \n");

			System.out.println("CHK_06 : " + CHK_06);
			
            // [6]출고(-)표시언체크
			if( CHK_06.equals("0") )
			{
				sbSql.append("     , SUM(A.UOM_QTY) AS UOM_QTY \n");
				sbSql.append("     , SUM(ROUND(A.MARGIN_AMOUNT)) AS MARGIN_AMOUNT \n");
//				sbSql.append("     , SUM(A.SALE_AMOUNT) AS SALE_AMOUNT \n");
			}
			// [6]출고(-)표시체크
			else
			{
				sbSql.append("     , SUM(A.UOM_QTY) * DECODE(SUBSTR(A.TRANS_TYPE, 1, 1), 'I', 1, -1) AS UOM_QTY \n");
				sbSql.append("     , SUM(ROUND(A.MARGIN_AMOUNT)) * DECODE(SUBSTR(A.TRANS_TYPE, 1, 1), 'I', 1, -1) AS MARGIN_AMOUNT \n");
//				sbSql.append("     , SUM(A.SALE_AMOUNT) * DECODE(SUBSTR(A.TRANS_TYPE, 1, 1), 'I', 1, -1) AS SALE_AMOUNT \n");
			}

			sbSql.append("  FROM HLDC_PO_TRANSACTION A \n");
			sbSql.append("     , SCC_COMMON_CODE B \n");
			sbSql.append("     , HLDC_PO_ITEM_MST C \n");
			sbSql.append("     , HLDC_PO_ITEM_CLASS_HLDC_V D \n");
			sbSql.append("     , HLDC_PO_ITEM_CLASS_HLDC_V E \n");
			sbSql.append(" WHERE A.TRANS_TYPE = B.CODE \n");
			sbSql.append("   AND A.ITEM_CODE  = C.ITEM_CODE \n");
			sbSql.append("   AND D.CLASS_CODE = C.ITEM_CLASS2 \n");
			sbSql.append("   AND D.CLASS_TYPE = 'M' \n");
			sbSql.append("   AND E.CLASS_CODE = C.ITEM_CLASS3 \n");
			sbSql.append("   AND E.CLASS_TYPE = 'S' \n");
			sbSql.append("   AND A.TRANS_DATE BETWEEN '" + START_DATE + "' AND '" + END_DATE + "' \n");
			sbSql.append("   AND A.TRANS_TYPE LIKE '" + TRANS_TYPE + "' \n");
			sbSql.append("   AND A.SUBINV_CODE = '" + SUBINV_CODE + "' \n");
			sbSql.append("   AND B.GROUP_CODE = 'FS0131' \n");
			sbSql.append("   AND B.USE_YN = 'Y' \n");
			// 아이템코드가 있을때
			if( !ITEM_CODE.equals("") )
			{
				sbSql.append("   AND A.ITEM_CODE = '" + ITEM_CODE + "' \n");
			}
			// 거래처코드가있을때
			if( !CUSTCD.equals("") )
			{
				sbSql.append("   AND A.CUSTCD LIKE '"+ CUSTCD +"%' \n");
			}
			// [5]재고단가 제로체크시
			if( CHK_05.equals("1") )
			{
				sbSql.append("   AND A.MARGIN_PRICE = 0 \n");
			}
			sbSql.append(" GROUP BY SUBSTR(A.TRANS_TYPE, 1, 1), B.CODE_NAME, A.ITEM_CODE, D.CLASS_CODE, E.CLASS_CODE, A.ITEM_NAME, A.ITEM_SIZE, DECODE(A.TAX_CODE, '100', '과세', '210', '면세', '영세'), A.UOM_CODE \n");
			sbSql.append(" ORDER BY B.CODE_NAME, D.CLASS_CODE, E.CLASS_CODE, A.ITEM_CODE \n");
		}

		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		DataSet ds_list1 = this.makeDataSet(rs, "ds_list1");

		out_dl.add(ds_list1);
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