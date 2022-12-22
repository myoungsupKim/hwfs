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

		String v_Upjang			= nullToBlank(in_vl.getString("v_Upjang"));
		String v_SubinvCode		= nullToBlank(in_vl.getString("v_SubinvCode"));
		String v_Date			= nullToBlank(in_vl.getString("v_Date"));
		
		String sOnhandMonth			= "000101";

		DataSet ds_stock;

		StringBuffer sbSelSql = new StringBuffer();

		sbSelSql.delete(0, sbSelSql.length());
		sbSelSql.append("/* 수불 마감월 조회 */ \n");
		sbSelSql.append( "SELECT MAX(A.CLS_YM) AS CLS_YM \n");
		sbSelSql.append( "  FROM HLDC_PO_CLOSING A \n");
		sbSelSql.append( " WHERE A.CLS_YM      < SUBSTR('" + v_Date + "', 1, 6) \n");
		sbSelSql.append( "   AND A.SUBINV_CODE = '" + v_SubinvCode + "' \n");
		sbSelSql.append( "   AND A.CLS_FLAG    = 'Y' \n");

		pstmt = conn.prepareStatement(sbSelSql.toString());
		rs = pstmt.executeQuery();
		rs.next();

		if( nullToBlank(rs.getString("CLS_YM")).equals("") )
			sOnhandMonth = "000101";
		else
			sOnhandMonth = nullToBlank(rs.getString("CLS_YM"));

		rs.close();
		pstmt.close();

		sbSelSql.delete(0, sbSelSql.length());
		sbSelSql.append("/* 적정재고내역 조회 */ \n");
		sbSelSql.append("SELECT '" + v_Upjang + "' AS UPJANG \n");
		sbSelSql.append("     , '" + v_SubinvCode + "' AS SUBINV_CODE \n");
		sbSelSql.append("     , C.CLASS_NAME AS L_CLASS_NAME \n");
		sbSelSql.append("     , D.CLASS_NAME AS M_CLASS_NAME \n");
		sbSelSql.append("     , C.CLASS_CODE AS L_CLASS_CODE \n");
		sbSelSql.append("     , D.CLASS_CODE AS M_CLASS_CODE \n");
		sbSelSql.append("     , A.ITEM_CODE AS ITEM_CODE \n");
		sbSelSql.append("     , A.ITEM_NAME AS ITEM_NAME \n");
		sbSelSql.append("     , A.ITEM_SIZE AS ITEM_SIZE \n");
		sbSelSql.append("     , A.PO_UOM AS PO_UOM \n");
		sbSelSql.append("     , NVL(E.OPTIMUM_DAY, 3) AS OPTIMUM_DAY \n");
		sbSelSql.append("  FROM HLDC_PO_ITEM_MST A \n");
		sbSelSql.append("     , HLDC_PO_ITEM_CLASS_HLDC_V C \n");
		sbSelSql.append("     , HLDC_PO_ITEM_CLASS_HLDC_V D \n");
		sbSelSql.append("     , ( \n");
		sbSelSql.append("        SELECT ITEM_CODE       AS ITEM_CODE \n");
		sbSelSql.append("             , SUM(UNIT_AMT)   AS UNIT_AMT \n");
		sbSelSql.append("             , SUM(MARGIN_AMT) AS MARGIN_AMT \n");
		sbSelSql.append("             , SUM(UNIT_QTY)   AS UNIT_QTY \n");
		sbSelSql.append("             , SUM(TRANS_QTY)  AS TRANS_QTY \n");
		sbSelSql.append("             , SUM(TRANS_UAMT) AS TRANS_UAMT \n");
		sbSelSql.append("             , SUM(TRANS_MAMT) AS TRANS_MAMT \n");
		sbSelSql.append("             , SUM(KG_QTY)     AS KG_QTY \n");
		sbSelSql.append("             , SUM(PO_QTY)     AS PO_QTY \n");
		sbSelSql.append("             , SUM(UOM_QTY)    AS UOM_QTY \n");
		sbSelSql.append("          FROM ( \n");
		sbSelSql.append("                SELECT C.ITEM_CODE          AS ITEM_CODE \n");
		sbSelSql.append("                     , ABS(C.UNIT_AMOUNT)   AS UNIT_AMT \n");
		sbSelSql.append("                     , ABS(C.MARGIN_AMOUNT) AS MARGIN_AMT \n");
		sbSelSql.append("                     , ABS(C.ONHAND_QTY)    AS UNIT_QTY \n");
		sbSelSql.append("                     , C.ONHAND_QTY         AS TRANS_QTY \n");
		sbSelSql.append("                     , C.UNIT_AMOUNT        AS TRANS_UAMT \n");
		sbSelSql.append("                     , C.MARGIN_AMOUNT      AS TRANS_MAMT \n");
		sbSelSql.append("                     , 0                    AS KG_QTY \n");
		sbSelSql.append("                     , 0                    AS PO_QTY \n");
		sbSelSql.append("                     , 0                    AS UOM_QTY \n");
		sbSelSql.append("                  FROM HLDC_PO_ONHAND_MONTH C \n");
		sbSelSql.append("                 WHERE C.ONHAND_YM   = '" + sOnhandMonth + "' \n");
		sbSelSql.append("                   AND C.SUBINV_CODE = '" + v_SubinvCode + "' \n");
		sbSelSql.append("                 UNION ALL \n");
		sbSelSql.append("                SELECT D.ITEM_CODE               AS ITEM_CODE \n");
		sbSelSql.append("                     , SUM(ABS(D.UNIT_AMOUNT))   AS UNIT_AMT \n");
		sbSelSql.append("                     , SUM(ABS(D.TRANS_MAMOUNT)) AS MARGIN_AMT \n");
		sbSelSql.append("                     , SUM(ABS(D.UOM_QTY))       AS UNIT_QTY \n");
		sbSelSql.append("                     , 0                         AS TRANS_QTY \n");
		sbSelSql.append("                     , 0                         AS TRANS_UAMT \n");
		sbSelSql.append("                     , 0                         AS TRANS_MAMT \n");
		sbSelSql.append("                     , 0                         AS KG_QTY \n");
		sbSelSql.append("                     , 0                         AS PO_QTY \n");
		sbSelSql.append("                     , 0                         AS UOM_QTY \n");
		sbSelSql.append("                  FROM HLDC_PO_TRANSACTION D \n");
		sbSelSql.append("                 WHERE D.TRANS_DATE BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE('" + sOnhandMonth + "'||'01','YYYYMMDD'),1),'YYYYMMDD') AND '" + v_Date + "' \n");
		sbSelSql.append("                   AND D.SUBINV_CODE = '" + v_SubinvCode + "' \n");
		sbSelSql.append("                   AND D.TRANS_TYPE  LIKE 'I%' \n");
		sbSelSql.append("                 GROUP BY D.ITEM_CODE \n");
		sbSelSql.append("                 UNION ALL \n");
		sbSelSql.append("                SELECT D.ITEM_CODE                                                           AS ITEM_CODE\n");
		sbSelSql.append("                     , 0                                                                     AS UNIT_AMT \n");
		sbSelSql.append("                     , 0                                                                     AS MARGIN_AMT \n");
		sbSelSql.append("                     , 0                                                                     AS UNIT_QTY \n");
		sbSelSql.append("                     , SUM(DECODE(SUBSTR(D.TRANS_TYPE, 1, 1), 'I', 1, -1) * D.UOM_QTY)       AS TRANS_QTY \n");
		sbSelSql.append("                     , SUM(DECODE(SUBSTR(D.TRANS_TYPE, 1, 1), 'I', 1, -1) * D.UNIT_AMOUNT)   AS TRANS_UAMT \n");
		sbSelSql.append("                     , SUM(DECODE(SUBSTR(D.TRANS_TYPE, 1, 1), 'I', 1, -1) * D.MARGIN_AMOUNT) AS TRANS_MAMT \n");
		sbSelSql.append("                     , 0                                                                     AS KG_QTY \n");
		sbSelSql.append("                     , 0                                                                     AS PO_QTY \n");
		sbSelSql.append("                     , 0                                                                     AS UOM_QTY \n");
		sbSelSql.append("                  FROM HLDC_PO_TRANSACTION D \n");
		sbSelSql.append("                 WHERE D.TRANS_DATE BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE('" + sOnhandMonth + "'||'01','YYYYMMDD'),1),'YYYYMMDD') AND '" + v_Date + "' \n");
		sbSelSql.append("                   AND D.SUBINV_CODE = '" + v_SubinvCode + "' \n");
		sbSelSql.append("                 GROUP BY D.ITEM_CODE \n");
		sbSelSql.append("               ) \n");
		sbSelSql.append("         GROUP BY ITEM_CODE \n");
		sbSelSql.append("       ) B \n");
		sbSelSql.append("     , ( \n");
		sbSelSql.append("        SELECT ITEM_CODE \n");
		sbSelSql.append("             , OPTIMUM_DAY \n");
		sbSelSql.append("          FROM FSP_PHYSICAL_INVENTORY_OPTIMUM \n");
		sbSelSql.append("         WHERE UPJANG = '" + v_Upjang + "' \n");
		sbSelSql.append("           AND SUBINV_CODE = '" + v_SubinvCode + "' \n");
		sbSelSql.append("       ) E \n");
		sbSelSql.append(" WHERE C.CLASS_CODE = A.ITEM_CLASS2 \n");
		sbSelSql.append("   AND C.CLASS_TYPE = 'M' \n");
		sbSelSql.append("   AND D.CLASS_CODE = A.ITEM_CLASS3 \n");
		sbSelSql.append("   AND D.CLASS_TYPE = 'S' \n");
		sbSelSql.append("   AND A.ITEM_CODE  = B.ITEM_CODE \n");
		sbSelSql.append("   AND A.ITEM_CODE  = E.ITEM_CODE(+) \n");
		// 재고량이 0이 아닌 자재만 뽑아온다.
		sbSelSql.append("   AND B.TRANS_QTY  <> 0 \n");
		sbSelSql.append(" ORDER BY C.CLASS_CODE, D.CLASS_CODE, A.ITEM_CODE \n");

		pstmt = conn.prepareStatement(sbSelSql.toString());
		rs = pstmt.executeQuery();

		ds_stock = this.makeDataSet(rs, "ds_stock");
		out_dl.add(ds_stock);

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