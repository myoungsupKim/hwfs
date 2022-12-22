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
		sbSql.append("/* 기간별 상세내역 */ \n ");

		// [1] 구매단위 표시 체크시
		if( CHK_01.equals("1") )
		{
			sbSql.append("SELECT TO_CHAR(TO_DATE(A.TRANS_DATE, 'YYYYMMDD'), 'YYYY-MM-DD') AS TRANS_DATE \n ");
//			sbSql.append("     , A.TR_NUM AS TR_NUM \n");
			sbSql.append("     , A.TRANS_ID AS TR_NUM \n");
//			sbSql.append("     , B.TRANS_NAME AS TRANS_NAME \n");
			sbSql.append("     , B.CODE_NAME AS TRANS_NAME \n");
			sbSql.append("     , A.SOURCE_TYPE AS SOURCE_TYPE \n");
			sbSql.append("     , A.ITEM_CODE AS ITEM_CODE \n");
			sbSql.append("     , A.ITEM_NAME AS ITEM_NAME \n");
			sbSql.append("     , A.ITEM_SIZE AS ITEM_SIZE \n");
			sbSql.append("     , DECODE(A.TAX_CODE, '100', '과세', '210', '면세', '영세') AS TAX_CODE \n");
			sbSql.append("     , F.PO_UOM AS UOM_CODE \n");
			sbSql.append("     , A.MARGIN_PRICE * F.UOM_CONVERT_RATE AS MARGIN_PRICE \n");

			// [6]출고(-)표시언체크
			if( CHK_06.equals("0") )
			{
				sbSql.append("     , A.UOM_QTY / F.UOM_CONVERT_RATE AS UOM_QTY \n");
				sbSql.append("     , ROUND(A.MARGIN_AMOUNT) AS MARGIN_AMOUNT \n");
//				sbSql.append("     , A.SALE_AMOUNT AS SALE_AMOUNT \n");
			}
			// [6]출고(-)표시체크
			else
			{
				sbSql.append("     , A.UOM_QTY * DECODE(SUBSTR(A.TRANS_TYPE, 1, 1), 'I', 1, -1) / F.UOM_CONVERT_RATE AS UOM_QTY \n");
				sbSql.append("     , ROUND(A.MARGIN_AMOUNT) * DECODE(SUBSTR(A.TRANS_TYPE, 1, 1), 'I', 1, -1) AS MARGIN_AMOUNT \n");
//				sbSql.append("     , A.SALE_AMOUNT * DECODE(SUBSTR(A.TRANS_TYPE, 1, 1), 'I', 1, -1) AS SALE_AMOUNT \n");
			}

//			sbSql.append("     , A.REMARK AS REMARK \n");
//			sbSql.append("     , DECODE(A.GANO, -1, NULL, A.GAMU||'-'||A.GADATE||'-'||LPAD(TO_CHAR(A.GANO), 4, '0')) AS GANO \n");
//			sbSql.append("     , A.CREATE_BY||' '||C.NM_KOR AS CUSER \n");
//			sbSql.append("     , TO_CHAR(A.CREATE_DATE, 'YYYY-MM-DD HH24:MI:SS') AS CDATE \n");
//			sbSql.append("     , A.UPDATE_BY||' '||D.NM_KOR AS UUSER \n");
//			sbSql.append("     , TO_CHAR(A.UPDATE_DATE, 'YYYY-MM-DD HH24:MI:SS') AS UDATE \n");
			sbSql.append("     , A.ACCTCD AS ACCTCD \n");
			sbSql.append("     , E.ACCTNM4||' '||E.ACCTNM6 AS ACCTNM \n");

			// [8]이관인수내역언체크
			if( CHK_08.equals("0") )
			{
				sbSql.append("     , NULL AS MOV_DATA \n");
			}
			// [8]이관인수내역체크
			else
			{
/* 확인중				sbSql.append("     , DECODE(A.TRANS_TYPE \n");
				sbSql.append("               ,'I002' \n");
				sbSql.append("               ,( SELECT '◀ '||X.SUBINV_CODE||' '||Y.SUBINV_NAME||' '||X.ITEM_CODE||' '||X.ITEM_NAME||' '||X.ITEM_SIZE \n");
				sbSql.append("                    FROM HLDC_PO_TRANSACTION X, HLDC_PO_SUBINVENTORY Y \n");
				sbSql.append("                   WHERE X.SUBINV_CODE = Y.SUBINV_CODE \n");
				sbSql.append("                     AND X.TRANS_ID = A.PARENT_TRANS_ID ) \n");
				sbSql.append("               ,'O002' \n");
				sbSql.append("               ,( SELECT '▶ '||X.SUBINV_CODE||' '||Y.SUBINV_NAME||' '||X.ITEM_CODE||' '||X.ITEM_NAME||' '||X.ITEM_SIZE \n");
				sbSql.append("                    FROM HLDC_PO_TRANSACTION X, HLDC_PO_SUBINVENTORY Y \n");
				sbSql.append("                   WHERE X.SUBINV_CODE = Y.SUBINV_CODE \n");
				sbSql.append("                     AND X.PARENT_TRANS_ID = A.TRANS_ID ) \n");
				sbSql.append("               ,NULL) AS MOV_DATA \n");
*/
			}

			//sbSql.append("  FROM HLDC_PO_TRANSACTION A \n");
			sbSql.append("  FROM HLDC_PO_TRANSACTION2 A \n");	// TUNING POINT
			sbSql.append("     , SCC_COMMON_CODE B \n");
			sbSql.append("     , ST_ACCOUNT E \n");
			sbSql.append("     , HLDC_PO_ITEM_MST F \n");
			sbSql.append(" WHERE A.TRANS_TYPE = B.CODE \n");
			sbSql.append("   AND A.ACCTCD = E.ACCTCD \n");
			sbSql.append("   AND A.ITEM_CODE = F.ITEM_CODE \n");
			sbSql.append("   AND A.TRANS_DATE BETWEEN '"+ START_DATE+"' AND '"+ END_DATE +"' \n");
			sbSql.append("   AND A.TRANS_TYPE LIKE '"+ TRANS_TYPE +"' \n");
			sbSql.append("   AND A.SUBINV_CODE = '"+ SUBINV_CODE +"' \n");
			sbSql.append("   AND B.GROUP_CODE = 'FS0131' \n");
			sbSql.append("   AND B.USE_YN = 'Y' \n");
			sbSql.append("   AND E.BU_CD = '2000' \n");

			// 아이템코드가 있을때
			if( !ITEM_CODE.equals("") )
			{
				sbSql.append("   AND A.ITEM_CODE = '"+ ITEM_CODE +"' \n");
			}

			 // 거래처코드가있을때
			if( !CUSTCD.equals("") )
			{
//				sbSql.append("   AND PO_ITEMCUST_FUN(TO_CHAR(SYSDATE, 'YYYYMMDD'), A.SUBINV_CODE, A.ITEM_CODE) LIKE '"+ CUSTCD +"#%' \n");
				sbSql.append("   AND A.CUSTCD LIKE '"+ CUSTCD +"%' \n");
			}

			// [5]재고단가 제로체크시
			if( CHK_05.equals("1") )
			{
				sbSql.append("   AND A.MARGIN_PRICE = 0 \n");
			}
//			sbSql.append(" ORDER BY A.TRANS_DATE, A.TR_NUM, A.TRANS_TYPE, A.ITEM_CODE ");
			sbSql.append(" ORDER BY A.TRANS_DATE, A.TRANS_ID, A.TRANS_TYPE, A.ITEM_CODE ");
		}
		// [1]구매단위 언체크시
		else
		{
			sbSql.append("SELECT TO_CHAR(TO_DATE(A.TRANS_DATE, 'YYYYMMDD'), 'YYYY-MM-DD') AS TRANS_DATE \n");
//			sbSql.append("     , A.TR_NUM AS TR_NUM \n");
			sbSql.append("     , A.TRANS_ID AS TR_NUM \n");
			sbSql.append("     , B.CODE_NAME AS TRANS_NAME \n");
			sbSql.append("     , A.SOURCE_TYPE AS SOURCE_TYPE \n");
			sbSql.append("     , A.ITEM_CODE AS ITEM_CODE \n");
			sbSql.append("     , A.ITEM_NAME AS ITEM_NAME \n");
			sbSql.append("     , A.ITEM_SIZE AS ITEM_SIZE \n");
			sbSql.append("     , DECODE(A.TAX_CODE, '100', '과세', '210', '면세', '영세') AS TAX_CODE \n");
			sbSql.append("     , A.UOM_CODE AS UOM_CODE \n");
			sbSql.append("     , A.MARGIN_PRICE AS MARGIN_PRICE \n");

		    // [6]출고(-)표시언체크
			if( CHK_06.equals("0") )
			{
				sbSql.append("     , A.UOM_QTY AS UOM_QTY \n");
				sbSql.append("     , ROUND(A.MARGIN_AMOUNT) AS MARGIN_AMOUNT \n");
//				sbSql.append("     , A.SALE_AMOUNT AS SALE_AMOUNT \n");
			}
			// [6]출고(-)표시체크
			else
			{
				sbSql.append("     , A.UOM_QTY * DECODE(SUBSTR(A.TRANS_TYPE, 1, 1), 'I', 1, -1) AS UOM_QTY \n");
				sbSql.append("     , ROUND(A.MARGIN_AMOUNT) * DECODE(SUBSTR(A.TRANS_TYPE, 1, 1), 'I', 1, -1) AS MARGIN_AMOUNT \n");
//				sbSql.append("     , A.SALE_AMOUNT * DECODE(SUBSTR(A.TRANS_TYPE, 1, 1), 'I', 1, -1) AS SALE_AMOUNT \n");
			}

//			sbSql.append("     , A.REMARK AS REMARK \n");
//			sbSql.append("     , DECODE(A.GANO, -1, NULL, A.GAMU||'-'||A.GADATE||'-'||LPAD(TO_CHAR(A.GANO), 4, '0')) AS GANO \n");
//			sbSql.append("     , A.CREATE_BY||' '||C.NM_KOR AS CUSER \n");
//			sbSql.append("     , TO_CHAR(A.CREATE_DATE, 'YYYY-MM-DD HH24:MI:SS') AS CDATE \n");
//			sbSql.append("     , A.UPDATE_BY||' '||D.NM_KOR AS UUSER \n");
//			sbSql.append("     , TO_CHAR(A.UPDATE_DATE, 'YYYY-MM-DD HH24:MI:SS') AS UDATE \n");
			sbSql.append("     , A.ACCTCD AS ACCTCD \n");
			sbSql.append("     , E.ACCTNM4||' '||E.ACCTNM6 AS ACCTNM \n");

			// [8]이관인수내역언체크
			if( CHK_08.equals("0") )
			{
			    sbSql.append("     , NULL AS MOV_DATA \n");
			}
			// [8]이관인수내역체크
			else
			{
/* 확인중
				sbSql.append("     , DECODE(A.TRANS_TYPE \n");
				sbSql.append("               ,'I002' \n");
				sbSql.append("               ,(SELECT '◀ '||X.SUBINV_CODE||' '||Y.SUBINV_NAME||' '||X.ITEM_CODE||' '||X.ITEM_NAME||' '||X.ITEM_SIZE \n");
				sbSql.append("                   FROM HLDC_PO_TRANSACTION X, HLDC_PO_SUBINVENTORY Y \n");
				sbSql.append("                  WHERE X.SUBINV_CODE = Y.SUBINV_CODE \n");
				sbSql.append("                    AND X.TRANS_ID = A.PARENT_TRANS_ID) \n");
				sbSql.append("               ,'O002' \n");
				sbSql.append("               ,(SELECT '▶ '||X.SUBINV_CODE||' '||Y.SUBINV_NAME||' '||X.ITEM_CODE||' '||X.ITEM_NAME||' '||X.ITEM_SIZE \n");
				sbSql.append("                   FROM HLDC_PO_TRANSACTION X, HLDC_PO_SUBINVENTORY Y \n");
				sbSql.append("                  WHERE X.SUBINV_CODE = Y.SUBINV_CODE \n");
				sbSql.append("                    AND X.PARENT_TRANS_ID = A.TRANS_ID) \n");
				sbSql.append("               ,NULL) AS MOV_DATA \n");
*/
			}

			//sbSql.append("  FROM HLDC_PO_TRANSACTION A \n");	// TUNING POINT
			sbSql.append("  FROM HLDC_PO_TRANSACTION2 A \n");
			sbSql.append("     , SCC_COMMON_CODE B \n");
//			sbSql.append("     , HR_PERSONAL C \n");
//			sbSql.append("     , HR_PERSONAL D \n");
			sbSql.append("     , ST_ACCOUNT E \n");

			// [8]이관인수내역체크
			if( CHK_08.equals("1") )
			{
				sbSql.append("       ,HLDC_PO_ITEM_MST F \n");
			}

			sbSql.append(" WHERE A.TRANS_TYPE = B.CODE \n");
//			sbSql.append("   AND A.CREATE_BY = C.SABUN(+) \n");
//			sbSql.append("   AND A.UPDATE_BY = D.SABUN(+) \n");
			sbSql.append("   AND A.ACCTCD = E.ACCTCD \n");

			// [8]이관인수내역체크
			if( CHK_08.equals("1") )
			{
				sbSql.append("   AND A.ITEM_CODE = F.ITEM_CODE \n");
			}

			sbSql.append("   AND A.TRANS_DATE BETWEEN '"+ START_DATE+"' AND '"+ END_DATE +"' \n");
			sbSql.append("   AND A.TRANS_TYPE LIKE '"+ TRANS_TYPE +"' \n");
			sbSql.append("   AND A.SUBINV_CODE = '"+ SUBINV_CODE +"' \n");
			sbSql.append("   AND B.GROUP_CODE = 'FS0131' \n");
			sbSql.append("   AND B.USE_YN = 'Y' \n");
			sbSql.append("   AND E.BU_CD = '2000' \n");

			// 아이템코드가 있을때
			if( !ITEM_CODE.equals("") )
			{
				sbSql.append("   AND A.ITEM_CODE = '"+ ITEM_CODE +"' \n");
			}

			 // 거래처코드가있을때
			if( !CUSTCD.equals("") )
			{
//				sbSql.append("   AND PO_ITEMCUST_FUN(TO_CHAR(SYSDATE, 'YYYYMMDD'), A.SUBINV_CODE, A.ITEM_CODE) LIKE '"+ CUSTCD +"#%' \n");
				sbSql.append("   AND A.CUSTCD LIKE '"+ CUSTCD +"%' \n");
			}

			// [5]재고단가 제로체크시
			if( CHK_05.equals("1") )
			{
				sbSql.append("   AND A.MARGIN_PRICE = 0 \n");
			}
//			sbSql.append(" ORDER BY A.TRANS_DATE, A.TR_NUM, A.TRANS_TYPE, A.ITEM_CODE ");
			sbSql.append(" ORDER BY A.TRANS_DATE, A.TRANS_ID, A.TRANS_TYPE, A.ITEM_CODE ");
		}

		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		DataSet ds_list = this.makeDataSet(rs, "ds_list");

		out_dl.add(ds_list);
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