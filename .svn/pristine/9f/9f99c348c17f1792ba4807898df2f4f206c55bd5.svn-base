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

		String v_SubinvCode 	= in_vl.getString("v_SubinvCode");
		String v_Date 			= in_vl.getString("v_Date");
		String v_chkPoUom 		= in_vl.getString("v_chkPoUom");
		String g_EmpNo 			= in_vl.getString("g_EmpNo");

		String sPhysic_date			= "";
		String sOnhandMonth			= "000101";
		
		DataSet ds_stock;
		StringBuffer sbSelSql = new StringBuffer();
		
		sPhysic_date = v_Date;
		
		sbSelSql.delete(0, sbSelSql.length());
		sbSelSql.append("/* 수불 마감월 조회 */ \n");
		sbSelSql.append( "SELECT MAX(A.CLS_YM) AS CLS_YM \n");
		sbSelSql.append( "  FROM HLDC_PO_CLOSING A \n");
		sbSelSql.append( " WHERE A.CLS_YM      < SUBSTR('" + sPhysic_date + "', 1, 6) \n");
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
		sbSelSql.append(" /* 재고내역 조회 */                                                                                                                          \n");                                                                                                                           
		sbSelSql.append(" SELECT '" + v_Date + "' AS TRANS_DATE                                                                                                              \n");
		sbSelSql.append("      , (SELECT SUBINV_NAME FROM HLDC_PO_SUBINVENTORY Z WHERE Z.SUBINV_CODE = 'C1001358') AS SUBINV_NAME                                      \n");
		sbSelSql.append("      , C.CLASS_NAME AS L_CLASS_NAME                                                                                                          \n");
		sbSelSql.append("      , D.CLASS_NAME AS M_CLASS_NAME                                                                                                          \n");
		sbSelSql.append("      , C.CLASS_CODE AS L_CLASS_CODE                                                                                                          \n");
		sbSelSql.append("      , D.CLASS_CODE AS M_CLASS_CODE                                                                                                          \n");
		sbSelSql.append("      , A.ITEM_CODE AS ITEM_CODE                                                                                                              \n");
		sbSelSql.append("      , A.BARCODE AS BARCODE                                                                                                                  \n");
		sbSelSql.append("      , A.ITEM_NAME AS ITEM_NAME                                                                                                              \n");
		sbSelSql.append("      , A.ITEM_SIZE AS ITEM_SIZE                                                                                                              \n");
		sbSelSql.append("      , A.UOM_CODE AS UOM_CODE                                                                                                                \n");
		sbSelSql.append("      , A.PO_UOM AS PO_UOM                                                                                                                    \n");
		//구매단위
		if( v_chkPoUom.equals("Y") )
		{
				
			sbSelSql.append("      , DECODE(B.UNIT_QTY, 0, 0, ROUND(B.MARGIN_AMT / (B.UNIT_QTY / A.UOM_CONVERT_RATE), 5)) AS M_STK_PRICE  -- 재고단가    (출하)(구매)      \n");
			sbSelSql.append("      , ROUND(B.UNIT_QTY / A.UOM_CONVERT_RATE, 5) AS M_STK_QTY                                               -- 재고량            (구매)      \n");
			sbSelSql.append("      , ROUND(B.OUT_QTY / A.UOM_CONVERT_RATE, 5) AS M_USE_QTY                                                -- 사용금액    (출하)(구매/수불) \n");
		}
		else
		{
			sbSelSql.append("      , DECODE(B.UNIT_QTY, 0, 0, ROUND(B.MARGIN_AMT / B.UNIT_QTY, 5)) AS M_STK_PRICE                       -- 재고단가    (출하)(수불)      \n");
			sbSelSql.append("      , B.UNIT_QTY AS M_STK_QTY                                                                            -- 재고량            (수불)      \n");
			sbSelSql.append("      , B.OUT_QTY AS M_USE_QTY                                                                             -- 사용량            (수불)      \n");
		}
		
		sbSelSql.append("      , B.MARGIN_AMT AS M_STK_AMT                                                                            -- 재고금액    (출하)(구매/수불) \n");
		sbSelSql.append("      , ROUND(B.UNIT_QTY / A.UOM_CONVERT_RATE, 5) - ROUND(B.OUT_QTY / A.UOM_CONVERT_RATE, 5) AS M_REAL_QTY   -- 실사재고량        (구매)      \n");
		sbSelSql.append("      , B.MARGIN_AMT - B.OUT_AMT AS M_REAL_AMT                                                               -- 실사재고금액(출하)(구매)      \n");
		sbSelSql.append("      , DECODE(A.TAX_CODE, '100', ROUND((B.MARGIN_AMT - B.OUT_AMT)/10),0) AS M_REAL_VAT                      -- 실사부가세액(출하)(구매)      \n");
		sbSelSql.append("      , B.OUT_AMT AS M_USE_AMT                                                                               -- 사용금액    (출하)(구매/수불) \n");
		sbSelSql.append("      , DECODE(A.TAX_CODE, '100', ROUND(B.OUT_AMT/10),0) AS M_USE_VAT                                        -- 사용부가세액(출하)(구매/수불) \n");
		sbSelSql.append("      , A.UOM_CONVERT_RATE AS UOM_CONVERT_RATE                                                                                                \n");
		sbSelSql.append("      , A.TAX_CODE AS TAX_CODE                                                                                                                \n");
		sbSelSql.append("      , CASE WHEN INSTR(E.VALUE_DATE, '-') > 0 THEN '' ELSE E.VALUE_DATE END AS VALUE_DATE                                                    \n");
		sbSelSql.append("      , E.MAKER_DATE AS MAKER_DATE                                                                                                            \n");
		sbSelSql.append("      , E.VALUE_DATE_INFO AS VALUE_DATE_INFO                                                                                                  \n");
		sbSelSql.append("   FROM HLDC_PO_ITEM_MST A                                                                                                                    \n");
		sbSelSql.append("      , HLDC_PO_ITEM_CLASS_HLDC_V C                                                                                                           \n");
		sbSelSql.append("      , HLDC_PO_ITEM_CLASS_HLDC_V D                                                                                                           \n");
		sbSelSql.append("      , (                                                                                                                                     \n");
		sbSelSql.append("         SELECT ITEM_CODE       AS ITEM_CODE                                                                                                  \n");
		sbSelSql.append("              , SUM(UNIT_QTY)   AS UNIT_QTY                                                                                                   \n");
		sbSelSql.append("              , SUM(MARGIN_AMT) AS MARGIN_AMT                                                                                                 \n");
		sbSelSql.append("              , SUM(OUT_QTY)    AS OUT_QTY                                                                                                    \n");
		sbSelSql.append("              , SUM(OUT_AMT)    AS OUT_AMT                                                                                                    \n");
		sbSelSql.append("           FROM (                                                                                                                             \n");
		sbSelSql.append("                 SELECT C.ITEM_CODE      AS ITEM_CODE                                                                                         \n");
		sbSelSql.append("                      , C.ONHAND_QTY     AS UNIT_QTY                                                                                          \n");
		sbSelSql.append("                      , C.MARGIN_AMOUNT  AS MARGIN_AMT                                                                                        \n");
		sbSelSql.append("                      , 0                AS OUT_QTY                                                                                           \n");
		sbSelSql.append("                      , 0                AS OUT_AMT                                                                                           \n");
		sbSelSql.append("                   FROM HLDC_PO_ONHAND_MONTH C                                                                                                \n");
		sbSelSql.append("                  WHERE C.ONHAND_YM   = '" + sOnhandMonth + "'                                                                                            \n");
		sbSelSql.append("                    AND C.SUBINV_CODE = '" + v_SubinvCode + "'                                                                                       \n");
		sbSelSql.append("                  UNION ALL                                                                                                                   \n");
		sbSelSql.append("                 SELECT D.ITEM_CODE          AS ITEM_CODE                                                                                     \n");
		sbSelSql.append("                      , SUM(D.UOM_QTY)       AS UNIT_QTY                                                                                      \n");
		sbSelSql.append("                      --, SUM(D.MARGIN_AMOUNT) AS MARGIN_AMT                                                                                  \n");
		sbSelSql.append("                      , SUM(D.TRANS_MAMOUNT) AS MARGIN_AMT                                                                                    \n");
		sbSelSql.append("                      , 0                    AS OUT_QTY                                                                                       \n");
		sbSelSql.append("                      , 0                    AS OUT_AMT                                                                                       \n");
		sbSelSql.append("                   FROM HLDC_PO_TRANSACTION D                                                                                                 \n");
		sbSelSql.append("                  WHERE D.TRANS_DATE BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE('" + sOnhandMonth + "'||'01','YYYYMMDD'),1),'YYYYMMDD') AND '" + v_Date + "'  \n");
		sbSelSql.append("                    AND D.SUBINV_CODE = '" + v_SubinvCode + "'                                                                                \n");
		sbSelSql.append("                    AND D.TRANS_TYPE  LIKE 'I%'                                                                                               \n");
		sbSelSql.append("                  GROUP BY D.ITEM_CODE                                                                                                        \n");
		sbSelSql.append("                  UNION ALL                                                                                                                   \n");
		sbSelSql.append("                 SELECT D.ITEM_CODE             AS ITEM_CODE                                                                                  \n");
		sbSelSql.append("                      , SUM(D.UOM_QTY*-1)       AS UNIT_QTY                                                                                   \n");
		sbSelSql.append("                      , SUM(D.TRANS_MAMOUNT*-1) AS MARGIN_AMT                                                                                 \n");
		sbSelSql.append("                      , 0                       AS OUT_QTY                                                                                    \n");
		sbSelSql.append("                      , 0                       AS OUT_AMT                                                                                    \n");
		sbSelSql.append("                   FROM HLDC_PO_TRANSACTION D                                                                                                 \n");
		sbSelSql.append("                  WHERE D.TRANS_DATE BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE('" + sOnhandMonth + "'||'01','YYYYMMDD'),1),'YYYYMMDD') AND TO_CHAR(TO_DATE('" + v_Date + "') -1,'YYYYMMDD')   \n");
		sbSelSql.append("                    AND D.SUBINV_CODE = '" + v_SubinvCode + "'                                                                                \n");
		sbSelSql.append("                    AND D.TRANS_TYPE  LIKE 'O%'                                                                                               \n");
		sbSelSql.append("                  GROUP BY D.ITEM_CODE                                                                                                        \n");
		sbSelSql.append("                  UNION ALL                                                                                                                   \n");
		sbSelSql.append("                 SELECT D.ITEM_CODE          AS ITEM_CODE                                                                                     \n");
		sbSelSql.append("                      , 0                    AS UNIT_QTY                                                                                      \n");
		sbSelSql.append("                      , 0                    AS MARGIN_AMT                                                                                    \n");
		sbSelSql.append("                      , SUM(D.UOM_QTY)       AS OUT_QTY                                                                                       \n");
		sbSelSql.append("                      , SUM(D.TRANS_MAMOUNT) AS OUT_AMT                                                                                       \n");
		sbSelSql.append("                   FROM HLDC_PO_TRANSACTION D                                                                                                 \n");
		sbSelSql.append("                  WHERE D.TRANS_DATE  = '" + v_Date + "'                                                                                      \n");
		sbSelSql.append("                    AND D.SUBINV_CODE = '" + v_SubinvCode + "'                                                                                \n");
		sbSelSql.append("                    AND D.TRANS_TYPE  LIKE 'O%'                                                                                               \n");
		sbSelSql.append("                  GROUP BY D.ITEM_CODE                                                                                                        \n");
		sbSelSql.append("                )                                                                                                                             \n");
		sbSelSql.append("          GROUP BY ITEM_CODE                                                                                                                  \n");
		sbSelSql.append("        ) B                                                                                                                                   \n");
		sbSelSql.append("      , (SELECT DISTINCT A.ITEM_CODE, A.VALUE_DATE, A.MAKER_DATE, A.VALUE_DATE_INFO                                                           \n");
		sbSelSql.append("           FROM HLDC_PO_PHYSICAL_INVENTORY A                                                                                                  \n");
		sbSelSql.append("              , (SELECT ITEM_CODE AS ITEM_CODE                                                                                                \n");
		sbSelSql.append("                      , MAX(UPDATE_DATE) AS UPDATE_DATE                                                                                       \n");
		sbSelSql.append("                   FROM HLDC_PO_PHYSICAL_INVENTORY                                                                                            \n");
		sbSelSql.append("                  WHERE PHYSIC_DATE = '" + v_Date + "'                                                                                             \n");
		sbSelSql.append("                    AND SUBINV_CODE = '" + v_SubinvCode + "'                                                                                            \n");
		sbSelSql.append("                  GROUP BY ITEM_CODE) B                                                                                                       \n");
		sbSelSql.append("          WHERE A.ITEM_CODE   = B.ITEM_CODE                                                                                                   \n");
		sbSelSql.append("            AND A.UPDATE_DATE = B.UPDATE_DATE                                                                                                 \n");
		sbSelSql.append("            AND A.PHYSIC_DATE = '" + v_Date + "'                                                                                                 \n");
		sbSelSql.append("            AND A.SUBINV_CODE = '" + v_SubinvCode + "'                                                                                                \n");
		sbSelSql.append("        ) E                                                                                                                                   \n");
		sbSelSql.append("  WHERE C.CLASS_CODE = A.ITEM_CLASS2                                                                                                          \n");
		sbSelSql.append("    AND C.CLASS_TYPE = 'M'                                                                                                                    \n");
		sbSelSql.append("    AND D.CLASS_CODE = A.ITEM_CLASS3                                                                                                          \n");
		sbSelSql.append("    AND D.CLASS_TYPE = 'S'                                                                                                                    \n");
		sbSelSql.append("    AND A.ITEM_CODE  = B.ITEM_CODE                                                                                                            \n");
		sbSelSql.append("    AND A.ITEM_CODE  = E.ITEM_CODE(+)                                                                                                         \n");
		sbSelSql.append("    AND (B.UNIT_QTY   <> 0                                                                                                                    \n");
		sbSelSql.append("     OR  B.OUT_QTY    <> 0                                                                                                                    \n");
		sbSelSql.append("     OR  B.MARGIN_AMT <> 0                                                                                                                    \n");
		sbSelSql.append("     OR  B.OUT_AMT    <> 0 )                                                                                                                  \n");
		sbSelSql.append("  ORDER BY C.CLASS_CODE, D.CLASS_CODE, A.ITEM_CODE                                                                                           \n");

		pstmt = conn.prepareStatement(sbSelSql.toString());
		rs = pstmt.executeQuery();

		ds_stock = this.makeDataSet(rs, "ds_stock");
		out_dl.add(ds_stock);

	   	this.setResultMessage(0, "OK", out_vl);

	}
	catch( Exception ex )
	{
		//jsp 로그남기기
		logger.debug(ex.getMessage(), ex);
	    this.setResultMessage(-1, ex.toString(), out_vl);
	}
	finally
	{
		if( rs != null )
		{
			try {
				rs.close();
			}catch(Exception e) {}
		}
		if( pstmt != null )
		{
			try {
				pstmt.close();
			}catch(Exception e) {}
		}
		if( conn != null )
		{
			try {
				conn.close();
			}catch(Exception e) {}
		}

		//jsp log 서비스 닫기
		try {
			logger.endIndividualLog();
		} catch( Exception logE ) {
			logE.printStackTrace();
		}
	}

	proc_output(response, out, out_vl, out_dl);
%>