
<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	try
	{
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();

		//입력 데이타
		DataSet ds_input     	= in_dl.get("ds_input");

	  	String strUpjang 		= nullToBlank(ds_input.getString(0, "UPJANG"));
		String strSubinvCode	= nullToBlank(ds_input.getString(0, "SUBINV_CODE"));
		String strFromDt		= nullToBlank(ds_input.getString(0, "FROM_DT1"));
	  	String strToDt 			= nullToBlank(ds_input.getString(0, "TO_DT1"));
	  	String strClassCode		= nullToBlank(ds_input.getString(0, "CLASS_CODE"));
	  	String strSCode			= nullToBlank(ds_input.getString(0, "SCODE"));

		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		// 식자재사용패턴조회-기간
		sbSql.delete(0, sbSql.length());
		sbSql.append("SELECT B.CLASS_NAME -- 분류 \n");
		sbSql.append("     , ROUND(SUM( (UOM_QTY / F.UOM_CONVERT_RATE) * F.KG_CONVERT_RATE) / DECODE(E.CNT, 0, 1, E.CNT), 2) AS UOM_QTY --기간평균사용량 --[수정] \n");
		sbSql.append("     , ABS(ROUND(SUM(OUT_AMT)/DECODE(E.CNT,0,1,E.CNT))) AS OUT_AMT   --기간평균사용금액 \n");
		sbSql.append("     , ROUND(SUM( (PHYSIC_QTY / F.UOM_CONVERT_RATE)*F.KG_CONVERT_RATE)/DECODE(E.CNT,0,1,E.CNT),2) AS PHYSIC_QTY --기간평균실사량--[수정] \n");
		sbSql.append("     , ABS(ROUND(SUM(PHYSIC_MAMOUNT) / DECODE(E.CNT, 0, 1, E.CNT))) AS PHYSIC_MAMOUNT --기간평균실사금액 \n");
		sbSql.append("     , 0 RATE \n");
		sbSql.append("  FROM ( SELECT A.ITEM_CODE \n");
		sbSql.append("              , SUM(A.UOM_QTY) AS UOM_QTY \n");
		sbSql.append("              , SUM(A.MARGIN_AMOUNT) AS OUT_AMT \n");
		sbSql.append("              , 0 PHYSIC_QTY \n");
		sbSql.append("              , 0 PHYSIC_MAMOUNT \n");
		sbSql.append("           FROM HLDC_PO_TRANSACTION A \n");
		sbSql.append("              , HLDC_PO_ITEM_MST B \n");
		sbSql.append("          WHERE A.ITEM_CODE = B.ITEM_CODE \n");
		sbSql.append("            AND A.TRANS_DATE BETWEEN '" + strFromDt + "' AND '" + strToDt + "' -- [기간] \n");
		if( strSubinvCode.length() != 0 )
		{
			sbSql.append("            AND A.SUBINV_CODE = '" + strSubinvCode + "'    -- [창고 지정] \n");	
		}
		sbSql.append("            AND A.TRANS_UPJANG = '" + strUpjang + "' -- [업장지정] \n");
		sbSql.append("            AND B.ITEM_CLASS1 = 'F' \n");
		sbSql.append("            AND A.TRANS_TYPE LIKE 'O%' \n");
		sbSql.append("            AND A.TRANS_TYPE <> 'O002' \n");
		sbSql.append("         GROUP BY A.ITEM_CODE \n");
		sbSql.append("         UNION ALL \n");
		sbSql.append("         SELECT A.ITEM_CODE \n");
		sbSql.append("              , 0 UOM_QTY \n");
		sbSql.append("              , 0 OUT_AMT \n");
		sbSql.append("              , SUM(A.PHYSIC_QTY) AS PHYSIC_QTY \n");
		sbSql.append("              , SUM(A.PHYSIC_QTY * A.MARGIN_PRICE) AS PHYSIC_MAMOUNT \n");
		sbSql.append("           FROM HLDC_PO_PHYSICAL_INVENTORY A \n");
		sbSql.append("              , (SELECT DISTINCT A.* \n");
		sbSql.append("                   FROM HLDC_PO_PHYSICAL_INVENTORY A \n");
		sbSql.append("                      , (SELECT D.ITEM_CODE AS ITEM_CODE \n");
    	sbSql.append("                              , MAX(D.UPDATE_DATE) AS UPDATE_DATE \n");
    	sbSql.append("                           FROM HLDC_PO_PHYSICAL_INVENTORY D \n");
    	sbSql.append("                          WHERE D.PHYSIC_DATE BETWEEN '" + strFromDt + "' AND '" + strToDt + "' -- [기간] \n");
		if (strSubinvCode.length() != 0)
		{
			sbSql.append("                            AND D.SUBINV_CODE = '" + strSubinvCode + "' -- [창고 지정] \n");
		}
		sbSql.append("                            AND EXISTS ( SELECT 1 FROM HLDC_PO_SUBINVENTORY Y WHERE Y.SUBINV_CODE = D.SUBINV_CODE AND Y.UPJANG = '" + strUpjang + "' ) -- [업장지정] \n");
    	sbSql.append("                          GROUP BY ITEM_CODE) B \n");
    	sbSql.append("                          WHERE A.ITEM_CODE = B.ITEM_CODE \n");
    	sbSql.append("                            AND A.UPDATE_DATE = B.UPDATE_DATE \n");
    	sbSql.append("                            AND A.PHYSIC_DATE BETWEEN '" + strFromDt + "' AND '" + strToDt + "' -- [기간] \n");
		if (strSubinvCode.length() != 0)
		{
			sbSql.append("                            AND A.SUBINV_CODE = '" + strSubinvCode + "' -- [창고 지정] \n");
		}
		sbSql.append("                            AND EXISTS (SELECT 1 FROM HLDC_PO_SUBINVENTORY Y WHERE Y.SUBINV_CODE = A.SUBINV_CODE AND Y.UPJANG = '" + strUpjang + "' ) -- [업장지정] \n");
		sbSql.append("                ) B \n");		
		sbSql.append("          WHERE A.PHYSIC_ID = B.PHYSIC_ID \n");
		sbSql.append("            AND A.ITEM_CODE = B.ITEM_CODE \n");
		sbSql.append("            AND A.PHYSIC_DATE BETWEEN '" + strFromDt + "' AND '" + strToDt + "' -- [기간] \n");
		if (strSubinvCode.length() != 0)
		{
			sbSql.append("           AND A.SUBINV_CODE = '" + strSubinvCode + "' -- [창고 지정] \n");	
		}
		sbSql.append("            AND EXISTS (SELECT 1 FROM HLDC_PO_SUBINVENTORY Y WHERE Y.SUBINV_CODE = A.SUBINV_CODE AND Y.UPJANG = '" + strUpjang + "' ) -- [업장지정] \n");
		sbSql.append("            AND B.CANCEL_YN = 'N' \n");
		sbSql.append("         GROUP BY A.ITEM_CODE \n");
		sbSql.append("       ) A \n");
		sbSql.append("     , HLDC_PO_ITEM_CLASS_HLDC_V B \n");
		sbSql.append("     , ( SELECT COUNT(*) CNT \n");
		sbSql.append("           FROM MAF_OP_CALENDAR \n");
		sbSql.append("          WHERE UPJANG = '" + strUpjang + "' -- [업장지정] \n");
		sbSql.append("            AND OP_DATE BETWEEN '" + strFromDt + "' AND '" + strToDt + "' -- [기간] \n");
		sbSql.append("            AND OP_YN = 'Y' \n");
		sbSql.append("       ) E \n");
		sbSql.append("     , HLDC_PO_ITEM_MST F --[수정] \n");
		sbSql.append(" WHERE 1 = 1 \n");
		sbSql.append("   AND A.ITEM_CODE = F.ITEM_CODE --[수정] \n");
		if (strSCode.equals("1"))		// 대분류
		{
			sbSql.append("   AND B.CLASS_CODE = F.ITEM_CLASS2 \n");
		}
		else if (strSCode.equals("2"))	// 중분류
		{
			sbSql.append("   AND B.CLASS_CODE = F.ITEM_CLASS3 \n");
		}
		else							// 소분류
		{
			sbSql.append("   AND B.CLASS_CODE = F.ITEM_CLASS4 \n");
		}
		if (strClassCode.length() != 0)
		{
			sbSql.append("   AND SUBSTR(B.CLASS_CODE, 1, " + strClassCode.length() + ")  = '" + strClassCode + "' \n");	
		}
		sbSql.append("GROUP BY B.CLASS_CODE, B.CLASS_NAME, E.CNT \n");

		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		DataSet ds_list = this.makeDataSet(rs, "ds_list");

		/**종료**/
		out_dl.add(ds_list);
		this.setResultMessage(0, "OK", out_vl);

	}
	catch( Exception ex )
	{
		ex.printStackTrace();
		this.setResultMessage(-1, ex.toString(),out_vl);
	}
	finally
	{
		if( rs != null )
		{
			try{
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
	}

	proc_output(response,out,out_vl,out_dl);
%>