<%@page import="com.sz.util.AppDataUtility"%>
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

		String UPJANG 	= in_vl.getString("UPJANG");
		String SUBINV 	= in_vl.getString("SUBINV");
		String FROM 	= in_vl.getString("FROM");
		String TO 		= in_vl.getString("TO");
		String CLASS4 	= in_vl.getString("CLASS4");
		String ITEM 	= in_vl.getString("ITEM");
		String ITEMGBN 	= in_vl.getString("ITEMGBN");

		StringBuffer sbSql = new StringBuffer();

		sbSql.delete(0, sbSql.length());
		sbSql.append("/*자재단품별 내역*/ \n");
		sbSql.append("SELECT A.PHYSIC_DATE AS PHYSIC_DATE -- 조사일 \n");
		sbSql.append("     , A.ITEM_CODE AS ITEM_CODE -- 자재코드 \n");
		sbSql.append("     , B.ITEM_NAME AS ITEM_NAME -- 자재명 \n");
		sbSql.append("     , B.ITEM_SIZE AS ITEM_SIZE -- 규격 \n");
		sbSql.append("     , B.UOM_CODE AS UOM_CODE -- 단위(수불단위) \n");
		sbSql.append("     , B.PO_UOM AS PO_UOM -- 단위(구매단위) \n");
		sbSql.append("     , ROUND(A.MARGIN_PRICE) AS MARGIN_PRICE -- 재고단가(수불단위) \n");
		sbSql.append("     , ROUND(A.MARGIN_PRICE * B.UOM_CONVERT_RATE) AS MARGIN_PRICE1 -- 재고단가(구매단위) \n");
		sbSql.append("     , A.ONHAND_QTY AS ONHAND_QTY -- 전산재고량(수불단위) \n");
		sbSql.append("     , A.ONHAND_QTY / B.UOM_CONVERT_RATE AS ONHAND_QTY1 -- 전산재고량(구매단위) \n");
		sbSql.append("     , ROUND(A.ONHAND_MAMOUNT) AS ONHAND_MAMOUNT -- 전산재고금액 \n");
		sbSql.append("     , A.PHYSIC_QTY AS PHYSIC_QTY -- 실사량(수불단위) \n");
		sbSql.append("     , A.PHYSIC_QTY / B.UOM_CONVERT_RATE AS PHYSIC_QTY1 -- 실사량(구매단위) \n");
		sbSql.append("     , ROUND(A.ONHAND_MAMOUNT - A.LOSS_MAMOUNT) AS PHYSIC_MAMOUNT -- 실사금액 \n");
		sbSql.append("     , CASE WHEN B.TAX_CODE = '100' \n");
		sbSql.append("            THEN ROUND(0.1 * ROUND(A.ONHAND_MAMOUNT - A.LOSS_MAMOUNT)) \n");
		sbSql.append("            ELSE 0 END AS PHYSIC_MVAT -- VAT \n");
		sbSql.append("     , A.LOSS_QTY AS LOSS_QTY -- 사용량(수불단위) \n");
		sbSql.append("     , A.LOSS_QTY / B.UOM_CONVERT_RATE AS LOSS_QTY1 -- 사용량(구매단위) \n");
		sbSql.append("     , ROUND(A.LOSS_MAMOUNT) AS LOSS_MAMOUNT -- 사용금액 \n");
		sbSql.append("     , CASE WHEN B.TAX_CODE = '100' \n");
		sbSql.append("            THEN ROUND(0.1 * A.LOSS_MAMOUNT) \n");
		sbSql.append("            ELSE 0 END AS LOSS_MVAT -- VAT \n");
		sbSql.append("     , A.CLOSE_DATE AS CLOSE_DATE -- 저장일 \n");
		sbSql.append("     , (SELECT Z.SUBINV_NAME FROM HLDC_PO_SUBINVENTORY Z WHERE A.SUBINV_CODE = Z.SUBINV_CODE) AS SUBINV_NAME -- 창고 \n");
		sbSql.append("  FROM HLDC_PO_PHYSICAL_INVENTORY A \n");
		sbSql.append("     , HLDC_PO_ITEM_MST B \n");
		sbSql.append("     , (SELECT DISTINCT A.* \n");
		sbSql.append("          FROM HLDC_PO_PHYSICAL_INVENTORY A \n");
		sbSql.append("             , (SELECT PHYSIC_DATE, SUBINV_CODE, ITEM_CODE, MAX(UPDATE_DATE) AS UPDATE_DATE \n");
		sbSql.append("                  FROM HLDC_PO_PHYSICAL_INVENTORY \n");
		sbSql.append("                 WHERE PHYSIC_DATE BETWEEN '" + FROM + "' AND '" + TO + "' \n");
		if( !SUBINV.equals("") )
		{
			sbSql.append("                   AND SUBINV_CODE = '" + SUBINV + "' -- 창고지정시 \n");
		}
		else
		{
			sbSql.append("                   AND SUBINV_CODE IN (SELECT SUBINV_CODE FROM HLDC_PO_SUBINVENTORY WHERE UPJANG = '" + UPJANG + "') \n");			
		}
    	sbSql.append("                 GROUP BY PHYSIC_DATE, SUBINV_CODE, ITEM_CODE) B \n");
    	sbSql.append("         WHERE A.PHYSIC_DATE = B.PHYSIC_DATE \n");
    	sbSql.append("           AND A.SUBINV_CODE = B.SUBINV_CODE \n");
    	sbSql.append("           AND A.ITEM_CODE = B.ITEM_CODE \n");
    	sbSql.append("           AND A.UPDATE_DATE = B.UPDATE_DATE \n");
    	sbSql.append("       ) C \n");
		sbSql.append(" WHERE A.PHYSIC_ID = C.PHYSIC_ID \n");
		sbSql.append("   AND A.ITEM_CODE = B.ITEM_CODE \n");
		sbSql.append("   AND A.PHYSIC_DATE BETWEEN '" + FROM + "' AND '" + TO + "' \n");
		if( !SUBINV.equals("") )
		{
			sbSql.append("   AND A.SUBINV_CODE = '" + SUBINV + "' --창고지정시 \n");
		}
		else
		{
			sbSql.append("   AND A.SUBINV_CODE IN (SELECT SUBINV_CODE FROM HLDC_PO_SUBINVENTORY WHERE UPJANG = '" + UPJANG + "') \n");			
		}
		if( !CLASS4.equals("") )
		{
			sbSql.append("   AND B.ITEM_CLASS4 = '" + CLASS4 + "' -- 소분류선택시 \n");
		}
		if( !ITEM.equals("") )
		{
			sbSql.append("   AND A.ITEM_CODE = '" + ITEM + "' -- 자재선택시 \n");
		}
		sbSql.append("   AND B.ITEM_CLASS1 = '" + ITEMGBN +  "' -- 분류선택시 \n");
		sbSql.append("   AND C.CANCEL_YN = 'N' \n");
		sbSql.append("   AND (A.MARGIN_PRICE <> 0 OR A.MARGIN_PRICE * B.UOM_CONVERT_RATE <> 0 OR A.ONHAND_QTY <> 0 \n");
		sbSql.append("        OR A.ONHAND_QTY / B.UOM_CONVERT_RATE <> 0 OR A.ONHAND_MAMOUNT <> 0 OR A.PHYSIC_QTY <> 0 \n");
		sbSql.append("        OR A.PHYSIC_QTY / B.UOM_CONVERT_RATE <> 0 OR ROUND(A.ONHAND_MAMOUNT - A.LOSS_MAMOUNT) <> 0 \n");
		sbSql.append("        OR A.LOSS_QTY <> 0 OR A.LOSS_QTY / B.UOM_CONVERT_RATE <> 0 OR ROUND(A.LOSS_MAMOUNT) <> 0 ) \n");
		sbSql.append("   AND (A.PHYSIC_QTY + A.ONHAND_QTY + A.LOSS_QTY) != 0 \n");  
		
		if( !SUBINV.equals("") )
		{
			sbSql.append(" ORDER BY A.PHYSIC_DATE, A.SUBINV_CODE, A.CLOSE_DATE, A.ITEM_CODE \n");
			
		}
		else
		{
			sbSql.append("ORDER BY A.PHYSIC_DATE \n");
			sbSql.append("       , CASE WHEN SUBSTR(A.SUBINV_CODE, 1, 1) = 'C' THEN 0 \n");
			sbSql.append("              WHEN SUBSTR(A.SUBINV_CODE, 1, 1) = 'E' THEN 1 \n");
			sbSql.append("              WHEN SUBSTR(A.SUBINV_CODE, 1, 1) = 'A' THEN 2 \n");
			sbSql.append("              ELSE 3 END\n");
			sbSql.append("       , A.SUBINV_CODE \n");
			sbSql.append("       , A.CLOSE_DATE \n");
			sbSql.append("       , A.ITEM_CODE \n");
		}

		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();

		DataSet ds_Item = this.makeDataSet(rs, "ds_Item");
		out_dl.add(ds_Item);

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