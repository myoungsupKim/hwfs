
<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
//	Statement stmt             =  null;
	try {
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));
		
		//입력 데이타                                                                                                                                                                                         
		DataSet ds_input     	= in_dl.get("ds_input"); 
		
	  	String strUpjang 		= nullToBlank(ds_input.getString(0, "UPJANG"));                                                                                                                                                                                                        
		String strSubinvCode	= nullToBlank(ds_input.getString(0, "SUBINV_CODE"));
		String strYear			= nullToBlank(ds_input.getString(0, "FROM_DT2")).substring(0,4);
		String strFromDt		= nullToBlank(ds_input.getString(0, "FROM_DT2")).substring(4,6);
	  	String strToDt 			= nullToBlank(ds_input.getString(0, "TO_DT2")).substring(4,6); 
	  	int nFromDt 			= Integer.parseInt(strFromDt);
	  	int nToDt 				= Integer.parseInt(strToDt);
		
//		if(conn != null && !conn.isClosed()) conn.close();		
//		conn = getIRISConn();
//		stmt 		=  conn.createStatement();
	
	
		//out 데이타                                                                                                                                                                                        
		DataSet ds_list;                                                                                                                                                                                    
		                                                                                                                                                                                                    
		//sql문 버퍼생성                                                                                                                                                                                    
		StringBuffer sbSql = new StringBuffer();   
        
		// 식자재사용패턴조회-연누계
		sbSql.delete(0, sbSql.length());
		sbSql.append("\n");
		sbSql.append("SELECT A.CLASS_CODE AS CLASS_CODE1 -- 대분류 \n");
		sbSql.append("     , B.CLASS_CODE AS CLASS_CODE2 -- 중분류 \n");
		sbSql.append("     , A.CLASS_NAME AS CLASS_NAME1 -- 대분류 \n");
		sbSql.append("     , B.CLASS_NAME AS CLASS_NAME2 -- 중분류 \n");
		sbSql.append("     , ROUND(SUM(D.AMT01)) AS AMT01 \n");
		sbSql.append("     , ROUND(SUM(D.AMT02)) AS AMT02 \n");
		sbSql.append("     , ROUND(SUM(D.AMT03)) AS AMT03 \n");
		sbSql.append("     , ROUND(SUM(D.AMT04)) AS AMT04 \n");
		sbSql.append("     , ROUND(SUM(D.AMT05)) AS AMT05 \n");
		sbSql.append("     , ROUND(SUM(D.AMT06)) AS AMT06 \n");
		sbSql.append("     , ROUND(SUM(D.AMT07)) AS AMT07 \n");
		sbSql.append("     , ROUND(SUM(D.AMT08)) AS AMT08 \n");
		sbSql.append("     , ROUND(SUM(D.AMT09)) AS AMT09 \n");
		sbSql.append("     , ROUND(SUM(D.AMT10)) AS AMT10 \n");
		sbSql.append("     , ROUND(SUM(D.AMT11)) AS AMT11 \n");
		sbSql.append("     , ROUND(SUM(D.AMT12)) AS AMT12 \n");
		sbSql.append("     , ROUND(SUM(D.AMT01 + D.AMT02 + D.AMT03 + D.AMT04 + D.AMT05 + D.AMT06 + D.AMT07 + D.AMT08 + D.AMT09 + D.AMT10 + D.AMT11 + D.AMT12)) AS AMT13 \n");
		sbSql.append("     , 0 RATE01, 0 RATE02, 0 RATE03, 0 RATE04 \n");
		sbSql.append("     , 0 RATE05, 0 RATE06, 0 RATE07, 0 RATE08 \n");
		sbSql.append("     , 0 RATE09, 0 RATE10, 0 RATE11, 0 RATE12 \n");
		sbSql.append("     , 0 RATE13 \n");
		sbSql.append("     , A.CLASS_CODE AS PL_UP_CD \n");
		sbSql.append("     , B.CLASS_CODE AS PL_CD \n");
		sbSql.append("     , '0' BL_SHOW \n");
		sbSql.append("     , 2 LEVEL_NO \n");
		sbSql.append("     , '+' BL_PLUS \n");
		sbSql.append("  FROM HLDC_PO_ITEM_CLASS_HLDC_V A \n");
		sbSql.append("     , HLDC_PO_ITEM_CLASS_HLDC_V B \n");
		sbSql.append("     , HLDC_PO_ITEM_MST C \n");
		sbSql.append("     , ( \n");
		
		// 1월
		if (1 >= nFromDt && 1 <= nToDt)
		{
			sbSql.append("        SELECT A.ITEM_CODE \n");
			sbSql.append("            , SUM(MARGIN_AMOUNT) AMT01 \n");
			sbSql.append("            , 0 AMT02 \n");
			sbSql.append("            , 0 AMT03 \n");
			sbSql.append("            , 0 AMT04 \n");
			sbSql.append("            , 0 AMT05 \n");
			sbSql.append("            , 0 AMT06 \n");
			sbSql.append("            , 0 AMT07 \n");
			sbSql.append("            , 0 AMT08 \n");
			sbSql.append("            , 0 AMT09 \n");
			sbSql.append("            , 0 AMT10 \n");
			sbSql.append("            , 0 AMT11 \n");
			sbSql.append("            , 0 AMT12 \n");
			sbSql.append("          FROM HLDC_PO_TRANSACTION A \n");
			sbSql.append("             , HLDC_PO_ITEM_MST B \n");
			sbSql.append("         WHERE A.ITEM_CODE = B.ITEM_CODE \n");
			sbSql.append("           AND TRANS_DATE BETWEEN '" + strYear + "' || '0101' AND '" + strYear + "' || '0131' -- [기간] \n");
			if (strSubinvCode.length() != 0) sbSql.append("           AND SUBINV_CODE = '" + strSubinvCode + "'    -- [창고 지정] \n");
			sbSql.append("           AND TRANS_UPJANG = " + strUpjang + " -- [업장지정] \n");
			sbSql.append("           AND B.ITEM_CLASS1 = 'F' \n");
			sbSql.append("           AND TRANS_TYPE LIKE 'O%' \n");
			//이관을 제외할 경우
			//sbSql.append("           AND TRANS_TYPE <> 'O002' \n");
			sbSql.append("         GROUP BY A.ITEM_CODE \n");
		}
		
		// 2월
		if (2 >= nFromDt && 2 <= nToDt)
		{
			if (nFromDt != 2) sbSql.append("        UNION ALL \n");
			sbSql.append("        SELECT A.ITEM_CODE \n");
			sbSql.append("            , 0 AMT01 \n");
			sbSql.append("            , SUM(MARGIN_AMOUNT) AMT02 \n");
			sbSql.append("            , 0 AMT03 \n");
			sbSql.append("            , 0 AMT04 \n");
			sbSql.append("            , 0 AMT05 \n");
			sbSql.append("            , 0 AMT06 \n");
			sbSql.append("            , 0 AMT07 \n");
			sbSql.append("            , 0 AMT08 \n");
			sbSql.append("            , 0 AMT09 \n");
			sbSql.append("            , 0 AMT10 \n");
			sbSql.append("            , 0 AMT11 \n");
			sbSql.append("            , 0 AMT12 \n");
			sbSql.append("          FROM HLDC_PO_TRANSACTION A \n");
			sbSql.append("             , HLDC_PO_ITEM_MST B \n");
			sbSql.append("         WHERE A.ITEM_CODE = B.ITEM_CODE \n");
			sbSql.append("           AND TRANS_DATE BETWEEN '" + strYear + "' || '0201' AND '" + strYear + "' || '0231' -- [기간] \n");
			if (strSubinvCode.length() != 0) sbSql.append("           AND SUBINV_CODE = '" + strSubinvCode + "'    -- [창고 지정] \n");
			sbSql.append("           AND TRANS_UPJANG = " + strUpjang + " -- [업장지정] \n");
			sbSql.append("           AND B.ITEM_CLASS1 = 'F' \n");
			sbSql.append("           AND TRANS_TYPE LIKE 'O%' \n");
			//이관을 제외할 경우
			//sbSql.append("           AND TRANS_TYPE <> 'O002' \n");
			sbSql.append("         GROUP BY A.ITEM_CODE \n");
		}
		
		// 3월
		if (3 >= nFromDt && 3 <= nToDt)
		{
			if (nFromDt != 3) sbSql.append("        UNION ALL \n");
			sbSql.append("        SELECT A.ITEM_CODE \n");
			sbSql.append("            , 0 AMT01 \n");
			sbSql.append("            , 0 AMT02 \n");
			sbSql.append("            , SUM(MARGIN_AMOUNT) AMT03 \n");
			sbSql.append("            , 0 AMT04 \n");
			sbSql.append("            , 0 AMT05 \n");
			sbSql.append("            , 0 AMT06 \n");
			sbSql.append("            , 0 AMT07 \n");
			sbSql.append("            , 0 AMT08 \n");
			sbSql.append("            , 0 AMT09 \n");
			sbSql.append("            , 0 AMT10 \n");
			sbSql.append("            , 0 AMT11 \n");
			sbSql.append("            , 0 AMT12 \n");
			sbSql.append("          FROM HLDC_PO_TRANSACTION A \n");
			sbSql.append("             , HLDC_PO_ITEM_MST B \n");
			sbSql.append("         WHERE A.ITEM_CODE = B.ITEM_CODE \n");
			sbSql.append("           AND TRANS_DATE BETWEEN '" + strYear + "' || '0301' AND '" + strYear + "' || '0331' -- [기간] \n");
			if (strSubinvCode.length() != 0) sbSql.append("           AND SUBINV_CODE = '" + strSubinvCode + "'    -- [창고 지정] \n");
			sbSql.append("           AND TRANS_UPJANG = " + strUpjang + " -- [업장지정] \n");
			sbSql.append("           AND B.ITEM_CLASS1 = 'F' \n");
			sbSql.append("           AND TRANS_TYPE LIKE 'O%' \n");
			//이관을 제외할 경우
			//sbSql.append("           AND TRANS_TYPE <> 'O002' \n");
			sbSql.append("         GROUP BY A.ITEM_CODE \n");
		}
		
		// 4월
		if (4 >= nFromDt && 4 <= nToDt)
		{
			if (nFromDt != 4) sbSql.append("        UNION ALL \n");
			sbSql.append("        SELECT A.ITEM_CODE \n");
			sbSql.append("            , 0 AMT01 \n");
			sbSql.append("            , 0 AMT02 \n");
			sbSql.append("            , 0 AMT03 \n");
			sbSql.append("            , SUM(MARGIN_AMOUNT) AMT04 \n");
			sbSql.append("            , 0 AMT05 \n");
			sbSql.append("            , 0 AMT06 \n");
			sbSql.append("            , 0 AMT07 \n");
			sbSql.append("            , 0 AMT08 \n");
			sbSql.append("            , 0 AMT09 \n");
			sbSql.append("            , 0 AMT10 \n");
			sbSql.append("            , 0 AMT11 \n");
			sbSql.append("            , 0 AMT12 \n");
			sbSql.append("          FROM HLDC_PO_TRANSACTION A \n");
			sbSql.append("             , HLDC_PO_ITEM_MST B \n");
			sbSql.append("         WHERE A.ITEM_CODE = B.ITEM_CODE \n");
			sbSql.append("           AND TRANS_DATE BETWEEN '" + strYear + "' || '0401' AND '" + strYear + "' || '0431' -- [기간] \n");
			if (strSubinvCode.length() != 0) sbSql.append("           AND SUBINV_CODE = '" + strSubinvCode + "'    -- [창고 지정] \n");
			sbSql.append("           AND TRANS_UPJANG = " + strUpjang + " -- [업장지정] \n");
			sbSql.append("           AND B.ITEM_CLASS1 = 'F' \n");
			sbSql.append("           AND TRANS_TYPE LIKE 'O%' \n");
			//이관을 제외할 경우
			//sbSql.append("           AND TRANS_TYPE <> 'O002' \n");
			sbSql.append("         GROUP BY A.ITEM_CODE \n");
		}
		
		// 5월
		if (5 >= nFromDt && 5 <= nToDt)
		{
			if (nFromDt != 5) sbSql.append("        UNION ALL \n");
			sbSql.append("        SELECT A.ITEM_CODE \n");
			sbSql.append("            , 0 AMT01 \n");
			sbSql.append("            , 0 AMT02 \n");
			sbSql.append("            , 0 AMT03 \n");
			sbSql.append("            , 0 AMT04 \n");
			sbSql.append("            , SUM(MARGIN_AMOUNT) AMT05 \n");
			sbSql.append("            , 0 AMT06 \n");
			sbSql.append("            , 0 AMT07 \n");
			sbSql.append("            , 0 AMT08 \n");
			sbSql.append("            , 0 AMT09 \n");
			sbSql.append("            , 0 AMT10 \n");
			sbSql.append("            , 0 AMT11 \n");
			sbSql.append("            , 0 AMT12 \n");
			sbSql.append("          FROM HLDC_PO_TRANSACTION A \n");
			sbSql.append("             , HLDC_PO_ITEM_MST B \n");
			sbSql.append("         WHERE A.ITEM_CODE = B.ITEM_CODE \n");
			sbSql.append("           AND TRANS_DATE BETWEEN '" + strYear + "' || '0501' AND '" + strYear + "' || '0531' -- [기간] \n");
			if (strSubinvCode.length() != 0) sbSql.append("           AND SUBINV_CODE = '" + strSubinvCode + "'    -- [창고 지정] \n");
			sbSql.append("           AND TRANS_UPJANG = " + strUpjang + " -- [업장지정] \n");
			sbSql.append("           AND B.ITEM_CLASS1 = 'F' \n");
			sbSql.append("           AND TRANS_TYPE LIKE 'O%' \n");
			//이관을 제외할 경우
			//sbSql.append("           AND TRANS_TYPE <> 'O002' \n");
			sbSql.append("         GROUP BY A.ITEM_CODE \n");
		}
		
		// 6월
		if (6 >= nFromDt && 6 <= nToDt)
		{
			if (nFromDt != 6) sbSql.append("        UNION ALL \n");
			sbSql.append("        SELECT A.ITEM_CODE \n");
			sbSql.append("            , 0 AMT01 \n");
			sbSql.append("            , 0 AMT02 \n");
			sbSql.append("            , 0 AMT03 \n");
			sbSql.append("            , 0 AMT04 \n");
			sbSql.append("            , 0 AMT05 \n");
			sbSql.append("            , SUM(MARGIN_AMOUNT) AMT06 \n");
			sbSql.append("            , 0 AMT07 \n");
			sbSql.append("            , 0 AMT08 \n");
			sbSql.append("            , 0 AMT09 \n");
			sbSql.append("            , 0 AMT10 \n");
			sbSql.append("            , 0 AMT11 \n");
			sbSql.append("            , 0 AMT12 \n");
			sbSql.append("          FROM HLDC_PO_TRANSACTION A \n");
			sbSql.append("             , HLDC_PO_ITEM_MST B \n");
			sbSql.append("         WHERE A.ITEM_CODE = B.ITEM_CODE \n");
			sbSql.append("           AND TRANS_DATE BETWEEN '" + strYear + "' || '0601' AND '" + strYear + "' || '0631' -- [기간] \n");
			if (strSubinvCode.length() != 0) sbSql.append("           AND SUBINV_CODE = '" + strSubinvCode + "'    -- [창고 지정] \n");
			sbSql.append("           AND TRANS_UPJANG = " + strUpjang + " -- [업장지정] \n");
			sbSql.append("           AND B.ITEM_CLASS1 = 'F' \n");
			sbSql.append("           AND TRANS_TYPE LIKE 'O%' \n");
			//이관을 제외할 경우
			//sbSql.append("           AND TRANS_TYPE <> 'O002' \n");
			sbSql.append("         GROUP BY A.ITEM_CODE \n");
		}
		
		// 7월
		if (7 >= nFromDt && 7 <= nToDt)
		{
			if (nFromDt != 7) sbSql.append("        UNION ALL \n");
			sbSql.append("        SELECT A.ITEM_CODE \n");
			sbSql.append("            , 0 AMT01 \n");
			sbSql.append("            , 0 AMT02 \n");
			sbSql.append("            , 0 AMT03 \n");
			sbSql.append("            , 0 AMT04 \n");
			sbSql.append("            , 0 AMT05 \n");
			sbSql.append("            , 0 AMT06 \n");
			sbSql.append("            , SUM(MARGIN_AMOUNT) AMT07 \n");
			sbSql.append("            , 0 AMT08 \n");
			sbSql.append("            , 0 AMT09 \n");
			sbSql.append("            , 0 AMT10 \n");
			sbSql.append("            , 0 AMT11 \n");
			sbSql.append("            , 0 AMT12 \n");
			sbSql.append("          FROM HLDC_PO_TRANSACTION A \n");
			sbSql.append("             , HLDC_PO_ITEM_MST B \n");
			sbSql.append("         WHERE A.ITEM_CODE = B.ITEM_CODE \n");
			sbSql.append("           AND TRANS_DATE BETWEEN '" + strYear + "' || '0701' AND '" + strYear + "' || '0731' -- [기간] \n");
			if (strSubinvCode.length() != 0) sbSql.append("           AND SUBINV_CODE = '" + strSubinvCode + "'    -- [창고 지정] \n");
			sbSql.append("           AND TRANS_UPJANG = " + strUpjang + " -- [업장지정] \n");
			sbSql.append("           AND B.ITEM_CLASS1 = 'F' \n");
			sbSql.append("           AND TRANS_TYPE LIKE 'O%' \n");
			//이관을 제외할 경우
			//sbSql.append("           AND TRANS_TYPE <> 'O002' \n");
			sbSql.append("         GROUP BY A.ITEM_CODE \n");
		}
		
		// 8월
		if (8 >= nFromDt && 8 <= nToDt)
		{
			if (nFromDt != 8)sbSql.append("        UNION ALL \n");
			sbSql.append("        SELECT A.ITEM_CODE \n");
			sbSql.append("            , 0 AMT01 \n");
			sbSql.append("            , 0 AMT02 \n");
			sbSql.append("            , 0 AMT03 \n");
			sbSql.append("            , 0 AMT04 \n");
			sbSql.append("            , 0 AMT05 \n");
			sbSql.append("            , 0 AMT06 \n");
			sbSql.append("            , 0 AMT07 \n");
			sbSql.append("            , SUM(MARGIN_AMOUNT) AMT08 \n");
			sbSql.append("            , 0 AMT09 \n");
			sbSql.append("            , 0 AMT10 \n");
			sbSql.append("            , 0 AMT11 \n");
			sbSql.append("            , 0 AMT12 \n");
			sbSql.append("          FROM HLDC_PO_TRANSACTION A \n");
			sbSql.append("             , HLDC_PO_ITEM_MST B \n");
			sbSql.append("         WHERE A.ITEM_CODE = B.ITEM_CODE \n");
			sbSql.append("           AND TRANS_DATE BETWEEN '" + strYear + "' || '0801' AND '" + strYear + "' || '0831' -- [기간] \n");
			if (strSubinvCode.length() != 0) sbSql.append("           AND SUBINV_CODE = '" + strSubinvCode + "'    -- [창고 지정] \n");
			sbSql.append("           AND TRANS_UPJANG = " + strUpjang + " -- [업장지정] \n");
			sbSql.append("           AND B.ITEM_CLASS1 = 'F' \n");
			sbSql.append("           AND TRANS_TYPE LIKE 'O%' \n");
			//이관을 제외할 경우
			//sbSql.append("           AND TRANS_TYPE <> 'O002' \n");
			sbSql.append("         GROUP BY A.ITEM_CODE \n");
		}
		
		// 9월
		if (9 >= nFromDt && 9 <= nToDt)
		{
			if (nFromDt != 9) sbSql.append("        UNION ALL \n");
			sbSql.append("        SELECT A.ITEM_CODE \n");
			sbSql.append("            , 0 AMT01 \n");
			sbSql.append("            , 0 AMT02 \n");
			sbSql.append("            , 0 AMT03 \n");
			sbSql.append("            , 0 AMT04 \n");
			sbSql.append("            , 0 AMT05 \n");
			sbSql.append("            , 0 AMT06 \n");
			sbSql.append("            , 0 AMT07 \n");
			sbSql.append("            , 0 AMT08 \n");
			sbSql.append("            , SUM(MARGIN_AMOUNT) AMT09 \n");
			sbSql.append("            , 0 AMT10 \n");
			sbSql.append("            , 0 AMT11 \n");
			sbSql.append("            , 0 AMT12 \n");
			sbSql.append("          FROM HLDC_PO_TRANSACTION A \n");
			sbSql.append("             , HLDC_PO_ITEM_MST B \n");
			sbSql.append("         WHERE A.ITEM_CODE = B.ITEM_CODE \n");
			sbSql.append("           AND TRANS_DATE BETWEEN '" + strYear + "' || '0901' AND '" + strYear + "' || '0931' -- [기간] \n");
			if (strSubinvCode.length() != 0) sbSql.append("           AND SUBINV_CODE = '" + strSubinvCode + "'    -- [창고 지정] \n");
			sbSql.append("           AND TRANS_UPJANG = " + strUpjang + " -- [업장지정] \n");
			sbSql.append("           AND B.ITEM_CLASS1 = 'F' \n");
			sbSql.append("           AND TRANS_TYPE LIKE 'O%' \n");
			//이관을 제외할 경우
			//sbSql.append("           AND TRANS_TYPE <> 'O002' \n");
			sbSql.append("         GROUP BY A.ITEM_CODE \n");
		}
		
		// 10월
		if (10 >= nFromDt && 10 <= nToDt)
		{
			if (nFromDt != 10) sbSql.append("        UNION ALL \n");
			sbSql.append("        SELECT A.ITEM_CODE \n");
			sbSql.append("            , 0 AMT01 \n");
			sbSql.append("            , 0 AMT02 \n");
			sbSql.append("            , 0 AMT03 \n");
			sbSql.append("            , 0 AMT04 \n");
			sbSql.append("            , 0 AMT05 \n");
			sbSql.append("            , 0 AMT06 \n");
			sbSql.append("            , 0 AMT07 \n");
			sbSql.append("            , 0 AMT08 \n");
			sbSql.append("            , 0 AMT09 \n");
			sbSql.append("            , SUM(MARGIN_AMOUNT) AMT10 \n");
			sbSql.append("            , 0 AMT11 \n");
			sbSql.append("            , 0 AMT12 \n");
			sbSql.append("          FROM HLDC_PO_TRANSACTION A \n");
			sbSql.append("             , HLDC_PO_ITEM_MST B \n");
			sbSql.append("         WHERE A.ITEM_CODE = B.ITEM_CODE \n");
			sbSql.append("           AND TRANS_DATE BETWEEN '" + strYear + "' || '1001' AND '" + strYear + "' || '1031' -- [기간] \n");
			if (strSubinvCode.length() != 0) sbSql.append("           AND SUBINV_CODE = '" + strSubinvCode + "'    -- [창고 지정] \n");
			sbSql.append("           AND TRANS_UPJANG = " + strUpjang + " -- [업장지정] \n");
			sbSql.append("           AND B.ITEM_CLASS1 = 'F' \n");
			sbSql.append("           AND TRANS_TYPE LIKE 'O%' \n");
			//이관을 제외할 경우
			//sbSql.append("           AND TRANS_TYPE <> 'O002' \n");
			sbSql.append("         GROUP BY A.ITEM_CODE \n");
		}
		
		// 11월
		if (11 >= nFromDt && 11 <= nToDt)
		{
			if (nFromDt != 11) sbSql.append("        UNION ALL \n");
			sbSql.append("        SELECT A.ITEM_CODE \n");
			sbSql.append("            , 0 AMT01 \n");
			sbSql.append("            , 0 AMT02 \n");
			sbSql.append("            , 0 AMT03 \n");
			sbSql.append("            , 0 AMT04 \n");
			sbSql.append("            , 0 AMT05 \n");
			sbSql.append("            , 0 AMT06 \n");
			sbSql.append("            , 0 AMT07 \n");
			sbSql.append("            , 0 AMT08 \n");
			sbSql.append("            , 0 AMT09 \n");
			sbSql.append("            , 0 AMT10 \n");
			sbSql.append("            , SUM(MARGIN_AMOUNT) AMT11 \n");
			sbSql.append("            , 0 AMT12 \n");
			sbSql.append("          FROM HLDC_PO_TRANSACTION A \n");
			sbSql.append("             , HLDC_PO_ITEM_MST B \n");
			sbSql.append("         WHERE A.ITEM_CODE = B.ITEM_CODE \n");
			sbSql.append("           AND TRANS_DATE BETWEEN '" + strYear + "' || '1101' AND '" + strYear + "' || '1131' -- [기간] \n");
			if (strSubinvCode.length() != 0) sbSql.append("           AND SUBINV_CODE = '" + strSubinvCode + "'    -- [창고 지정] \n");
			sbSql.append("           AND TRANS_UPJANG = " + strUpjang + " -- [업장지정] \n");
			sbSql.append("           AND B.ITEM_CLASS1 = 'F' \n");
			sbSql.append("           AND TRANS_TYPE LIKE 'O%' \n");
			//이관을 제외할 경우
			//sbSql.append("           AND TRANS_TYPE <> 'O002' \n");
			sbSql.append("         GROUP BY A.ITEM_CODE \n");
		}
		
		// 12월
		if (12 >= nFromDt && 12 <= nToDt)
		{
			if (nFromDt != 12) sbSql.append("        UNION ALL \n");
			sbSql.append("        SELECT A.ITEM_CODE \n");
			sbSql.append("            , 0 AMT01 \n");
			sbSql.append("            , 0 AMT02 \n");
			sbSql.append("            , 0 AMT03 \n");
			sbSql.append("            , 0 AMT04 \n");
			sbSql.append("            , 0 AMT05 \n");
			sbSql.append("            , 0 AMT06 \n");
			sbSql.append("            , 0 AMT07 \n");
			sbSql.append("            , 0 AMT08 \n");
			sbSql.append("            , 0 AMT09 \n");
			sbSql.append("            , 0 AMT10 \n");
			sbSql.append("            , 0 AMT11 \n");
			sbSql.append("            , SUM(MARGIN_AMOUNT) AMT12 \n");
			sbSql.append("          FROM HLDC_PO_TRANSACTION A \n");
			sbSql.append("             , HLDC_PO_ITEM_MST B \n");
			sbSql.append("         WHERE A.ITEM_CODE = B.ITEM_CODE \n");
			sbSql.append("           AND TRANS_DATE BETWEEN '" + strYear + "' || '1201' AND '" + strYear + "' || '1231' -- [기간] \n");
			if (strSubinvCode.length() != 0) sbSql.append("           AND SUBINV_CODE = '" + strSubinvCode + "'    -- [창고 지정] \n");
			sbSql.append("           AND TRANS_UPJANG = " + strUpjang + " -- [업장지정] \n");
			sbSql.append("           AND B.ITEM_CLASS1 = 'F' \n");
			sbSql.append("           AND TRANS_TYPE LIKE 'O%' \n");
			//이관을 제외할 경우
			//sbSql.append("           AND TRANS_TYPE <> 'O002' \n");
			sbSql.append("         GROUP BY A.ITEM_CODE \n");
		}
		sbSql.append("       ) D \n");
		sbSql.append("  WHERE D.ITEM_CODE = C.ITEM_CODE \n");
		sbSql.append("    AND C.ITEM_CLASS2 = A.CLASS_CODE \n");
		sbSql.append("    AND C.ITEM_CLASS3 = B.CLASS_CODE  \n");
		sbSql.append(" GROUP BY A.CLASS_CODE, B.CLASS_CODE, A.CLASS_NAME, B.CLASS_NAME \n");
		sbSql.append(" ORDER BY A.CLASS_CODE, B.CLASS_CODE \n");
		
		//System.out.println(sbSql.toString());                                                                                                                                                             
		pstmt = conn.prepareStatement(sbSql.toString());		                                                                                                                                                
		rs = pstmt.executeQuery();                                                                                                                                                                          
		ds_list = this.makeDataSet(rs, "ds_list");  
		
		rs.close();
		pstmt.close();
                                                                                                                                                                                                        
		/**종료**/                                                                                                                                                                                          
		out_dl.add(ds_list);                                                                                                                                                          
		this.setResultMessage(0, "OK", out_vl);  
		
	} catch(Exception ex) {
		//ex.printStackTrace();
		//jsp 로그남기기
		logger.debug(ex.getMessage(), ex);
		this.setResultMessage(-1, ex.toString(),out_vl); 
		} finally {
			if(rs != null) {
				try {
					rs.close();
				}catch(Exception e) {}
			}
			if(pstmt != null) {
				try {
					pstmt.close();
				}catch(Exception e) {}
			}
//			if(stmt != null) {
//				try {
//					stmt.close();
//				}catch(Exception e) {}
//			}
			if(conn != null) {
				try {
					conn.close();
				}catch(Exception e) {}
			}
			//jsp log 서비스 닫기 
			try {
				logger.endIndividualLog();
			} catch( Exception logE) {
				logE.printStackTrace();
			}
		}
		
	  proc_output(response,out,out_vl,out_dl);
	
%>