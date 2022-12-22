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

		String v_Upjang = nullToBlank(ds_input.getString(0, "UPJANG"));
		String v_Date = nullToBlank(ds_input.getString(0, "START_DATE"));
		String v_chkPoUom = nullToBlank(ds_input.getString(0, "PO_UOM"));
		String sOnhandMonth = "000101";
		String v_SubinvCode = "";

		DataSet ds_stock;
		int intInvCnt = 0;
		int intCnt = 0;
		boolean bFlag = false;

		StringBuffer sbSelSql = new StringBuffer();
		StringBuffer sbInvSql = new StringBuffer();
		StringBuffer sbStkSql = new StringBuffer();

		sbStkSql.delete(0, sbStkSql.length());

		sbStkSql.append("/* 전체창고재고 조회 */\n");
		sbStkSql.append("SELECT M_CLASS AS M_CLASS \n");
		sbStkSql.append("     , S_CLASS AS S_CLASS \n");
		sbStkSql.append("     , SUBINV_NAME AS SUBINV_NAME \n");
		sbStkSql.append("     , ITEM_CODE AS ITEM_CODE \n");
		sbStkSql.append("     , ITEM_NAME AS ITEM_NAME \n");
		sbStkSql.append("     , ITEM_SIZE AS ITEM_SIZE \n");
		sbStkSql.append("     , UOM_CODE AS UOM_CODE \n");
		sbStkSql.append("     , PO_UOM AS PO_UOM \n");
		sbStkSql.append("     , UOM_STOCK_QTY AS UOM_STOCK_QTY \n");
		sbStkSql.append("     , PO_STOCK_QTY AS PO_STOCK_QTY \n");
		sbStkSql.append("     , UOM_PHYSIC_QTY AS UOM_PHYSIC_QTY \n");
		sbStkSql.append("     , PO_PHYSIC_QTY AS PO_PHYSIC_QTY \n");
		sbStkSql.append("     , VALUE_DATE_INFO AS VALUE_DATE_INFO \n");
		sbStkSql.append("  FROM ( \n");

		sbSelSql.delete(0, sbSelSql.length());
		sbSelSql.append("/* 사업장 창고 조회 */ \n");
		sbSelSql.append("SELECT SUBINV_CODE AS SUBINV_CODE \n");
		sbSelSql.append("     , ( SELECT COUNT(*) \n");
		sbSelSql.append("           FROM HLDC_PO_SUBINVENTORY \n");
		sbSelSql.append("          WHERE UPJANG = '" + v_Upjang + "' \n");
		sbSelSql.append("            AND SUBINV_CODE LIKE 'C%' \n");
		sbSelSql.append("            AND USE_YN = 'Y' \n");
		sbSelSql.append("       ) AS CNT \n");
		sbSelSql.append("  FROM HLDC_PO_SUBINVENTORY \n");
		sbSelSql.append(" WHERE UPJANG = '" + v_Upjang + "' \n");
		sbSelSql.append("   AND SUBINV_CODE LIKE 'C%' \n");
		sbSelSql.append("   AND USE_YN = 'Y' \n");

		pstmt = conn.prepareStatement(sbSelSql.toString());
		rs = pstmt.executeQuery();

		while( rs.next() )
		{
			if( !bFlag ) bFlag = true;

			v_SubinvCode = rs.getString("SUBINV_CODE");
			intInvCnt    = rs.getInt("CNT");

			++intCnt;

			PreparedStatement pstmt1= null;
			ResultSet rs1 = null;

			sbInvSql.delete(0, sbInvSql.length());

			sbInvSql.append("/* 최종 수불 마감월 확인 */\n");
			sbInvSql.append("SELECT MAX(A.CLS_YM) AS CLS_YM \n");
			sbInvSql.append("  FROM HLDC_PO_CLOSING A \n");
			sbInvSql.append(" WHERE A.CLS_YM      < SUBSTR('" + v_Date + "', 1, 6) \n");
			sbInvSql.append("   AND A.SUBINV_CODE = '" + v_SubinvCode + "' \n");
			sbInvSql.append("   AND A.CLS_FLAG    = 'Y' \n");

			pstmt1 = conn.prepareStatement(sbInvSql.toString());
			rs1 = pstmt1.executeQuery();
			rs1.next();

			if( nullToBlank(rs1.getString("CLS_YM")).equals("") )
				sOnhandMonth = "000101";
			else
				sOnhandMonth = nullToBlank(rs1.getString("CLS_YM"));	

			rs1.close();
			pstmt1.close();

			sbStkSql.append("SELECT D.CLASS_CODE AS M_CODE \n");
			sbStkSql.append("     , C.CLASS_CODE AS S_CODE \n");
			sbStkSql.append("     , D.CLASS_NAME AS M_CLASS \n");
			sbStkSql.append("     , C.CLASS_NAME AS S_CLASS \n");
			sbStkSql.append("     , E.SUBINV_NAME AS SUBINV_NAME \n");
			sbStkSql.append("     , A.ITEM_CODE AS ITEM_CODE \n");
			sbStkSql.append("     , A.ITEM_NAME AS ITEM_NAME \n");
			sbStkSql.append("     , A.ITEM_SIZE AS ITEM_SIZE \n");
			sbStkSql.append("     , A.UOM_CODE AS UOM_CODE\n");
			sbStkSql.append("     , A.PO_UOM AS PO_UOM \n");
			sbStkSql.append("     , SUM(B.TRANS_QTY) AS UOM_STOCK_QTY \n");
			sbStkSql.append("     , SUM(B.TRANS_QTY / A.UOM_CONVERT_RATE) AS PO_STOCK_QTY \n");
			sbStkSql.append("     , SUM(B.PHYSIC_QTY) AS UOM_PHYSIC_QTY \n");
			sbStkSql.append("     , SUM(B.PHYSIC_QTY / A.UOM_CONVERT_RATE) AS PO_PHYSIC_QTY \n");
			sbStkSql.append("     , MAX(B.VALUE_DATE_INFO) AS VALUE_DATE_INFO \n");
			sbStkSql.append("  FROM HLDC_PO_ITEM_MST A \n");
			sbStkSql.append("     , HLDC_PO_SUBINVENTORY E \n");
			sbStkSql.append("     , HLDC_PO_ITEM_CLASS_HLDC_V C \n");
			sbStkSql.append("     , HLDC_PO_ITEM_CLASS_HLDC_V D \n");
			sbStkSql.append("     , ( SELECT C.SUBINV_CODE AS SUBINV_CODE \n");
			sbStkSql.append("              , C.ITEM_CODE AS ITEM_CODE \n");
			sbStkSql.append("              , C.ONHAND_QTY AS TRANS_QTY \n");
			sbStkSql.append("              , 0 AS PHYSIC_QTY \n");
			sbStkSql.append("              , '' AS VALUE_DATE_INFO \n");
			sbStkSql.append("           FROM HLDC_PO_ONHAND_MONTH C \n");
			sbStkSql.append("          WHERE C.ONHAND_YM   = '" + sOnhandMonth + "' \n");
			sbStkSql.append("            AND C.SUBINV_CODE = '" + v_SubinvCode + "' \n");
			sbStkSql.append("         UNION ALL \n");
			sbStkSql.append("         SELECT D.SUBINV_CODE AS SUBINV_CODE \n");
			sbStkSql.append("              , D.ITEM_CODE AS ITEM_CODE \n");
			sbStkSql.append("              , SUM(DECODE(SUBSTR(D.TRANS_TYPE, 1, 1), 'I', 1, -1) * D.UOM_QTY) AS TRANS_QTY \n");
			sbStkSql.append("              , 0 AS PHYSIC_QTY \n");
			sbStkSql.append("              , '' AS VALUE_DATE_INFO \n");
			sbStkSql.append("           FROM HLDC_PO_TRANSACTION D \n");
			sbStkSql.append("          WHERE D.TRANS_DATE BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE('" + sOnhandMonth + "'||'01', 'YYYYMMDD'), 1), 'YYYYMMDD') AND '" + v_Date + "' \n");
			sbStkSql.append("            AND D.SUBINV_CODE = '" + v_SubinvCode + "' \n");
			sbStkSql.append("         GROUP BY D.SUBINV_CODE, D.ITEM_CODE \n");
			sbStkSql.append("         UNION ALL \n");
			sbStkSql.append("         SELECT A.SUBINV_CODE AS SUBINV_CODE \n");
			sbStkSql.append("              , A.ITEM_CODE AS ITEM_CODE \n");
			sbStkSql.append("              , 0 AS TRANS_QTY \n");
			sbStkSql.append("              , A.PHYSIC_QTY AS PHYSIC_QTY \n");
			sbStkSql.append("              , A.VALUE_DATE AS VALUE_DATE_INFO \n");
			sbStkSql.append("           FROM HLDC_PO_PHYSICAL_INVENTORY A \n");
			sbStkSql.append("              , (SELECT DISTINCT A.* \n");
			sbStkSql.append("                   FROM HLDC_PO_PHYSICAL_INVENTORY A \n");
			sbStkSql.append("                      , (SELECT ITEM_CODE AS ITEM_CODE \n");
			sbStkSql.append("                              , MAX(UPDATE_DATE) AS UPDATE_DATE \n");
			sbStkSql.append("                           FROM HLDC_PO_PHYSICAL_INVENTORY \n");
			sbStkSql.append("                          WHERE PHYSIC_DATE = '" + v_Date + "' \n");
			sbStkSql.append("                            AND SUBINV_CODE = '" + v_SubinvCode + "' \n");
			sbStkSql.append("                          GROUP BY ITEM_CODE) B \n");
			sbStkSql.append("                  WHERE A.ITEM_CODE   = B.ITEM_CODE \n");
			sbStkSql.append("                    AND A.UPDATE_DATE = B.UPDATE_DATE \n");
			sbStkSql.append("                    AND A.PHYSIC_DATE = '" + v_Date + "' \n");
			sbStkSql.append("                    AND A.SUBINV_CODE = '" + v_SubinvCode + "' \n");
			sbStkSql.append("                ) C \n");
			sbStkSql.append("          WHERE A.PHYSIC_ID   = C.PHYSIC_ID \n");
			sbStkSql.append("            AND A.ITEM_CODE   = C.ITEM_CODE \n");
			sbStkSql.append("            AND A.PHYSIC_DATE = '" + v_Date + "' \n");
			sbStkSql.append("            AND A.SUBINV_CODE = '" + v_SubinvCode + "' \n");
			sbStkSql.append("            AND C.CANCEL_YN   = 'N' ) B \n");
			sbStkSql.append(" WHERE C.CLASS_CODE =  A.ITEM_CLASS3 \n");
			sbStkSql.append("   AND C.CLASS_TYPE = 'S' \n");
			sbStkSql.append("   AND D.CLASS_CODE = A.ITEM_CLASS2 \n");
			sbStkSql.append("   AND D.CLASS_TYPE = 'M' \n");
			sbStkSql.append("   AND B.SUBINV_CODE = E.SUBINV_CODE \n");
			sbStkSql.append("   AND A.ITEM_CODE = B.ITEM_CODE \n");
			sbStkSql.append(" GROUP BY A.ITEM_CODE, D.CLASS_CODE, C.CLASS_CODE, D.CLASS_NAME, C.CLASS_NAME \n");
			sbStkSql.append("        , A.ITEM_NAME, E.SUBINV_NAME ,A.ITEM_SIZE, A.PO_UOM, A.UOM_CODE \n");
			sbStkSql.append("HAVING SUM(B.TRANS_QTY) <> 0 \n");

			if( intCnt < intInvCnt )
			{
				sbStkSql.append( "UNION ALL \n");
			}
		}

		sbStkSql.append("     ) \n");
		sbStkSql.append("ORDER BY M_CODE, S_CODE, ITEM_CODE, SUBINV_NAME \n");

		if( bFlag )
		{
			pstmt = conn.prepareStatement(sbStkSql.toString());
			rs = pstmt.executeQuery();

			ds_stock = this.makeDataSet(rs, "ds_stock");
			out_dl.add(ds_stock);

		   	this.setResultMessage(0, "OK", out_vl);
		}
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