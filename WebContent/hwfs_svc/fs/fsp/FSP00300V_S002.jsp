<%@page import="com.sz.util.AppDataUtility"%>
<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>

<%
	try
	{
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();

		//jsp log ���� ����
		logger.startIndividualLog(in_vl.getString("titLogId"));

		String UPJANG 	= in_vl.getString("UPJANG");
		String SUBINV 	= in_vl.getString("SUBINV");
		String FROM 	= in_vl.getString("FROM");
		String TO 		= in_vl.getString("TO");
		String CLASS2 	= in_vl.getString("CLASS2");
		String ITEMGBN 	= in_vl.getString("ITEMGBN");

		StringBuffer sbSql = new StringBuffer();

		sbSql.delete(0, sbSql.length());
		sbSql.append("/* �ߺз��� ���� */ \n");
		sbSql.append("SELECT A.PHYSIC_DATE AS PHYSIC_DATE -- ������\n");
		sbSql.append("     , B.CLASS_NAME AS CLASS2_NAME -- ��з� \n");
		sbSql.append("     , C.CLASS_NAME AS CLASS3_NAME -- �ߺз� \n");
		sbSql.append("     , SUM(A.ONHAND_QTY) AS ONHAND_QTY -- ������� \n");
		sbSql.append("     , SUM(ROUND(A.ONHAND_MAMOUNT)) AS ONHAND_MAMOUNT -- �������ݾ� \n");
		sbSql.append("     , SUM(A.PHYSIC_QTY) AS PHYSIC_QTY -- �ǻ緮 \n");
		sbSql.append("     , SUM(ROUND(A.ONHAND_MAMOUNT - A.LOSS_MAMOUNT)) AS PHYSIC_MAMOUNT -- �ǻ�ݾ� \n");
		sbSql.append("     , CASE WHEN D.TAX_CODE = '100' \n");
		sbSql.append("            THEN SUM(ROUND(0.1 * ROUND(A.ONHAND_MAMOUNT - A.LOSS_MAMOUNT))) \n");
		sbSql.append("            ELSE 0 END AS PHYSIC_MVAT -- VAT \n");
		sbSql.append("     , SUM(A.LOSS_QTY) AS LOSS_QTY -- ��뷮 \n");
		sbSql.append("     , SUM(ROUND(A.LOSS_MAMOUNT)) AS LOSS_MAMOUNT -- ���ݾ� \n");
		sbSql.append("     , CASE WHEN D.TAX_CODE = '100' \n");
		sbSql.append("            THEN SUM(ROUND(0.1 * A.LOSS_MAMOUNT)) \n");
		sbSql.append("            ELSE 0 END AS LOSS_MVAT -- VAT \n");
		sbSql.append("     , (SELECT Z.SUBINV_NAME FROM HLDC_PO_SUBINVENTORY Z WHERE A.SUBINV_CODE = Z.SUBINV_CODE) AS SUBINV_NAME -- â�� \n");
		sbSql.append("  FROM HLDC_PO_PHYSICAL_INVENTORY A \n");
		sbSql.append("     , HLDC_PO_ITEM_CLASS_HLDC_V B \n");
		sbSql.append("     , HLDC_PO_ITEM_CLASS_HLDC_V C \n");
		sbSql.append("     , HLDC_PO_ITEM_MST D \n");
		sbSql.append("     , (SELECT DISTINCT A.* \n");
		sbSql.append("          FROM HLDC_PO_PHYSICAL_INVENTORY A \n");
		sbSql.append("             , (SELECT PHYSIC_DATE, SUBINV_CODE, ITEM_CODE, MAX(UPDATE_DATE) AS UPDATE_DATE \n");
		sbSql.append("                  FROM HLDC_PO_PHYSICAL_INVENTORY \n");
		sbSql.append("                 WHERE PHYSIC_DATE BETWEEN '" + FROM + "' AND '" + TO + "' \n");
		if( !SUBINV.equals("") )
		{
			sbSql.append("                   AND SUBINV_CODE = '" + SUBINV + "' -- â�������� \n");
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
    	sbSql.append("       ) Z \n");
		sbSql.append(" WHERE A.PHYSIC_ID = Z.PHYSIC_ID \n");
		sbSql.append("   AND A.ITEM_CODE = D.ITEM_CODE \n");
		sbSql.append("   AND B.CLASS_CODE = D.ITEM_CLASS2 \n");
		sbSql.append("   AND C.CLASS_CODE = D.ITEM_CLASS3 \n");
		sbSql.append("   AND A.PHYSIC_DATE BETWEEN '" + FROM + "' AND '" + TO + "' \n");
		if( !SUBINV.equals("") )
		{
			sbSql.append("   AND A.SUBINV_CODE = '" + SUBINV + "' --â�������� \n");
		}
		else
		{
			sbSql.append("   AND A.SUBINV_CODE IN (SELECT SUBINV_CODE FROM HLDC_PO_SUBINVENTORY WHERE UPJANG = '" + UPJANG + "') \n");
		}
		if( !CLASS2.equals("") )
		{
			sbSql.append("   AND D.ITEM_CLASS2 = '" + CLASS2 + "' \n");
		}
		sbSql.append("   AND D.ITEM_CLASS1 = '" + ITEMGBN +  "' -- �з����ý� \n");
		sbSql.append("   AND Z.CANCEL_YN = 'N' \n");
		if( !SUBINV.equals("") )
		{
			sbSql.append("GROUP BY A.PHYSIC_DATE, A.SUBINV_CODE, B.CLASS_CODE, B.CLASS_NAME, C.CLASS_CODE, C.CLASS_NAME, D.TAX_CODE \n");
			sbSql.append("HAVING (    SUM(A.ONHAND_QTY) <> 0 OR SUM(ROUND(A.ONHAND_MAMOUNT)) <> 0 \n");
			sbSql.append("         OR SUM(A.PHYSIC_QTY) <> 0 OR SUM(ROUND(A.ONHAND_MAMOUNT - A.LOSS_MAMOUNT)) <> 0 \n");
			sbSql.append("         OR SUM(A.LOSS_QTY)   <> 0 OR SUM(ROUND(A.LOSS_MAMOUNT)) <> 0) \n");
			sbSql.append("ORDER BY A.PHYSIC_DATE, B.CLASS_CODE, C.CLASS_CODE \n");
		}
		else
		{
			sbSql.append("GROUP BY A.PHYSIC_DATE, A.SUBINV_CODE, B.CLASS_CODE, B.CLASS_NAME, C.CLASS_CODE, C.CLASS_NAME, D.TAX_CODE \n");
			sbSql.append("HAVING (    SUM(A.ONHAND_QTY) <> 0 OR SUM(ROUND(A.ONHAND_MAMOUNT)) <> 0 \n");
			sbSql.append("         OR SUM(A.PHYSIC_QTY) <> 0 OR SUM(ROUND(A.ONHAND_MAMOUNT - A.LOSS_MAMOUNT)) <> 0 \n");
			sbSql.append("         OR SUM(A.LOSS_QTY)   <> 0 OR SUM(ROUND(A.LOSS_MAMOUNT)) <> 0) \n");
			sbSql.append("ORDER BY A.PHYSIC_DATE \n");
			sbSql.append("       , CASE WHEN SUBSTR(A.SUBINV_CODE, 1, 1) = 'C' THEN 0 \n");
			sbSql.append("              WHEN SUBSTR(A.SUBINV_CODE, 1, 1) = 'E' THEN 1 \n");
			sbSql.append("              WHEN SUBSTR(A.SUBINV_CODE, 1, 1) = 'A' THEN 2 \n");
			sbSql.append("              ELSE 3 END\n");
			sbSql.append("       , A.SUBINV_CODE \n");
			sbSql.append("       , B.CLASS_CODE \n");
			sbSql.append("       , C.CLASS_CODE \n");
		}

		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();

		DataSet ds_Class3 = this.makeDataSet(rs, "ds_Class3");
		out_dl.add(ds_Class3);

	   	this.setResultMessage(0, "OK", out_vl);
	}
	catch (Exception ex )
	{
		// jsp �α׳����
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

		// jsp log ���� �ݱ�
		try {
			logger.endIndividualLog();
		} catch( Exception logE ) {
			logE.printStackTrace();
		}
	}

	  proc_output(response, out, out_vl, out_dl);
%>