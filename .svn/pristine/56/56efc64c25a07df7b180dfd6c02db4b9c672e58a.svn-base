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

		String v_Upjang			= nullToBlank(in_vl.getString("v_upjang"));
		String v_SubinvCode		= nullToBlank(in_vl.getString("v_subinvCode"));
		String v_Date			= nullToBlank(in_vl.getString("v_date"));
		String v_itemCode		= nullToBlank(in_vl.getString("v_itemCode"));
		String v_chkPoUom		= nullToBlank(in_vl.getString("v_chkPoUom"));
		String v_chkPhysicQty	= nullToBlank(in_vl.getString("v_chkPhysicQty"));
		String v_chkAmt			= nullToBlank(in_vl.getString("v_chkAmt"));
		String v_MenuQty		= nullToBlank(in_vl.getString("v_MenuQty"));
		String g_EmpNo			= nullToBlank(in_vl.getString("g_EmpNo"));
		
		String sPhysic_date			= "";
		String sPhysic_before_date	= "";
		String sOnhandMonth			= "000101";
		String sPhysic_month		= "";
		sPhysic_date = v_Date;

		DataSet ds_po, ds_list;

		StringBuffer sbSelSql = new StringBuffer();
		
		sbSelSql.delete(0, sbSelSql.length());
		sbSelSql.append("/* 수불 마감월 조회 */ \n");
		sbSelSql.append( "SELECT MAX(A.CLS_YM) AS CLS_YM \n");
		sbSelSql.append( "  FROM HLDC_PO_CLOSING A \n");
		sbSelSql.append( " WHERE A.CLS_YM      < SUBSTR('" + sPhysic_date + "', 1, 6) \n");
		sbSelSql.append( "   AND A.SUBINV_CODE = ? \n");
		sbSelSql.append( "   AND A.CLS_FLAG    = 'Y' \n");
		
        int idx0 = 1;
		pstmt = conn.prepareStatement(sbSelSql.toString());
		pstmt.setString(idx0++, v_SubinvCode);

		rs = pstmt.executeQuery();
		rs.next();

		if( nullToBlank(rs.getString("CLS_YM")).equals("") )
			sOnhandMonth = "000101";
		else
			sOnhandMonth = nullToBlank(rs.getString("CLS_YM"));

		rs.close();
		pstmt.close();
		
		sbSelSql.delete(0, sbSelSql.length());
		sbSelSql.append("/* 재고내역 조회 */ \n");
		sbSelSql.append("SELECT A.* \n");
		sbSelSql.append("FROM ( \n");
		sbSelSql.append("    SELECT A.ITEM_CODE AS ITEM_CODE \n");
		sbSelSql.append("     , A.BARCODE AS BARCODE \n");
		sbSelSql.append("     , A.ITEM_NAME AS ITEM_NAME \n");
		sbSelSql.append("     , A.ITEM_SIZE AS ITEM_SIZE \n");
		sbSelSql.append("     , A.UOM_CODE AS UOM_CODE \n");
		sbSelSql.append("     , A.PO_UOM AS PO_UOM \n");
		sbSelSql.append("     , B.MARGIN_AMT \n");
		sbSelSql.append("     , B.UNIT_QTY \n");
		sbSelSql.append("     , B.TRANS_DATE \n");
		sbSelSql.append("     , B.TRANS_TYPE_NM \n");				
		sbSelSql.append("     , A.UOM_CONVERT_RATE AS UOM_CONVERT_RATE \n");
		sbSelSql.append("     , A.TAX_CODE AS TAX_CODE \n");
		sbSelSql.append("     , 'N' AS EDIT_YN \n");
		sbSelSql.append("     , B.TRANS_ID \n");
		sbSelSql.append("     FROM ( \n");
		sbSelSql.append("               SELECT  C.ONHAND_YM 		   AS TRANS_DATE \n");
		sbSelSql.append("       		      , C.ITEM_CODE            AS ITEM_CODE \n");
		sbSelSql.append("                     , C.UNIT_AMOUNT   	   AS UNIT_AMT \n");
		sbSelSql.append("                     , C.MARGIN_AMOUNT 	   AS MARGIN_AMT \n");
		sbSelSql.append("                     , C.ONHAND_QTY    	   AS UNIT_QTY \n");
		sbSelSql.append("                     , C.ONHAND_QTY           AS TRANS_QTY \n");
		sbSelSql.append("                     , C.UNIT_AMOUNT          AS TRANS_UAMT \n");
		sbSelSql.append("                     , C.MARGIN_AMOUNT        AS TRANS_MAMT \n");
		sbSelSql.append("                     , 0                      AS KG_QTY \n");
		sbSelSql.append("                     , 0                      AS PO_QTY \n");
		sbSelSql.append("                     , 0                      AS UOM_QTY \n");
		sbSelSql.append("       			  , '' 					   AS SOURCE_TYPE \n");
		sbSelSql.append("     			      , '' 					   AS MVT \n");
		sbSelSql.append("     			      , '전월재고' 			   AS TRANS_TYPE_NM \n");
		sbSelSql.append("      			      , '' 					   AS PO_TYP \n");
		sbSelSql.append("     			      , '전월재고'  		   AS REMARK \n");
		sbSelSql.append("     			      , '' 					   AS TRANS_ID \n");
		sbSelSql.append("                  FROM HLDC_PO_ONHAND_MONTH C \n");
		sbSelSql.append("                 WHERE C.ONHAND_YM   = ?  \n");
		sbSelSql.append("                   AND C.SUBINV_CODE = ? \n");
		sbSelSql.append("                   AND C.ITEM_CODE = ? \n");
		sbSelSql.append("                 UNION ALL \n");
		sbSelSql.append("               SELECT  D.TRANS_DATE \n");
		sbSelSql.append("       		      , D.ITEM_CODE     		AS ITEM_CODE \n");		
		sbSelSql.append("                     , D.UNIT_AMOUNT   		AS UNIT_AMT \n");
		sbSelSql.append("                     , D.TRANS_MAMOUNT 		AS MARGIN_AMT \n");
		sbSelSql.append("                     , D.UOM_QTY       		AS UNIT_QTY \n");
		sbSelSql.append("                     , 0                       AS TRANS_QTY \n");
		sbSelSql.append("                     , 0                       AS TRANS_UAMT \n");
		sbSelSql.append("                     , 0                       AS TRANS_MAMT \n");
		sbSelSql.append("                     , 0                       AS KG_QTY \n");
		sbSelSql.append("                     , 0                       AS PO_QTY \n");
		sbSelSql.append("                     , 0                       AS UOM_QTY \n");
		sbSelSql.append("  					  , SOURCE_TYPE \n");
		sbSelSql.append(" 					  , MVT \n");
		sbSelSql.append("  					  , CASE \n");
		sbSelSql.append(" 						  WHEN TRANS_TYPE = 'O002' THEN '재고이동 - 이동출고' \n");
		sbSelSql.append("    					  WHEN TRANS_TYPE = 'I002' THEN '재고이동 - 이동입고' \n");
		sbSelSql.append("   					  WHEN TRANS_TYPE = 'O001' THEN 'POS 매출 유형' \n");
		sbSelSql.append("   					  WHEN TRANS_TYPE = 'O004' THEN '재고실사' \n");
		sbSelSql.append(" 					      WHEN TRANS_TYPE = 'O003' THEN '대표창고 수불 단수차 원가 처리' \n");
		sbSelSql.append("   					  WHEN TRANS_TYPE = 'I001' THEN '입고' \n");
		sbSelSql.append(" 						       END AS TRANS_TYPE_NM \n");
		sbSelSql.append("  					  , PO_TYP \n");
 		sbSelSql.append("  					  , ''					    AS REMARK \n");
 		sbSelSql.append(" 					  , TRANS_ID \n");         
		sbSelSql.append("                  FROM HLDC_PO_TRANSACTION2 D \n"); // TUNING POINT
		sbSelSql.append("                 WHERE D.TRANS_DATE BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE(?||'01','YYYYMMDD'),1),'YYYYMMDD') AND ? \n");
		sbSelSql.append("                   AND D.SUBINV_CODE = ? \n");
		sbSelSql.append("                   AND D.TRANS_TYPE  LIKE 'I%' \n"); ///입고만
		sbSelSql.append("                   AND D.ITEM_CODE = ? \n");		
		sbSelSql.append("        ) B \n");
		sbSelSql.append("     , HLDC_PO_ITEM_MST A \n");
		sbSelSql.append("   WHERE B.ITEM_CODE  = A.ITEM_CODE \n");
		sbSelSql.append("  ) A \n");
		sbSelSql.append(" ORDER BY TRANS_DATE, TRANS_ID \n"); 
	    out.println(sbSelSql.toString());	
        
        int idx = 1;
		pstmt = conn.prepareStatement(sbSelSql.toString());
		pstmt.setString(idx++, sOnhandMonth);
		pstmt.setString(idx++, v_SubinvCode);		
		pstmt.setString(idx++, v_itemCode);
		pstmt.setString(idx++, sOnhandMonth);
		pstmt.setString(idx++, sPhysic_date);
		pstmt.setString(idx++, v_SubinvCode);
		pstmt.setString(idx++, v_itemCode);
		
		rs = pstmt.executeQuery();                                                                                                                                                                          
		ds_list = this.makeDataSet(rs, "ds_list");
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