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
		String v_MenuQty		= in_vl.getString("v_MenuQty");
		String g_EmpNo 			= in_vl.getString("g_EmpNo");

		DataSet ds_stock;
		StringBuffer sbSelSql = new StringBuffer();

		sbSelSql.delete(0, sbSelSql.length());
		sbSelSql.append("/* 일마감여부 확인 */ \n");
		sbSelSql.append("SELECT 1 \n");
		sbSelSql.append("  FROM MAS_CLOSE_MGMT \n");
		sbSelSql.append(" WHERE UPJANG = (SELECT UPJANG FROM HLDC_PO_SUBINVENTORY WHERE SUBINV_CODE = '" + v_SubinvCode + "') \n");
		sbSelSql.append("   AND CLOSE_GUBUN = '004' \n");
		sbSelSql.append("   AND CLOSE_DATE = '" + v_Date + "' \n");

		pstmt = conn.prepareStatement(sbSelSql.toString());
		rs = pstmt.executeQuery();

		if( rs.next() )
		{
			out_vl.add("v_StockClose", "재고마감이 이루어져 반영취소가 불가합니다.\n재고마감관리자에게 연락하세요.(사업장일마감취소신청)");
		}

		rs.close();
		pstmt.close();

//		sbSelSql.delete(0, sbSelSql.length());
//		sbSelSql.append("/* 재고반영취소 일자 확인 */ \n");
//		sbSelSql.append("SELECT SUBSTR(A.SUBINV_CODE,1,1) SUBINV_KIND \n");
//		sbSelSql.append("     , NVL(( SELECT '1' FROM ST_COMMON_ITEM WHERE LCODE = 'F01' AND DESCRIPTION1 = '" + g_EmpNo + "'), '0') AS MST_CODE \n");
//		sbSelSql.append("     , DECODE(SIGN((TO_DATE('" + v_Date + "', 'YYYYMMDD') - (SYSDATE-4))), -1, 'N', 'Y') AS CHK_DATE \n");
//		sbSelSql.append("  FROM HLDC_PO_SUBINVENTORY A \n");
//		sbSelSql.append(" WHERE A.SUBINV_CODE = '" + v_SubinvCode + "' \n");

//		pstmt = conn.prepareStatement(sbSelSql.toString());
//		rs = pstmt.executeQuery();

//		if( rs.next() )
//		{
//			if( rs.getString("SUBINV_KIND").equals("C") && rs.getString("MST_CODE").equals("0") && rs.getString("CHK_DATE").equals("N") )
//			{
//				out_vl.add("v_ChkDate", "재고반영취소는 3일이내 일자만 가능합니다.");
//			}
//		}

		sbSelSql.delete(0, sbSelSql.length());
		sbSelSql.append("/* 월마감 확인 */ \n");
		sbSelSql.append("SELECT TO_CHAR(TO_DATE(A.CLS_YM,'YYYYMM'),'YYYY\"년\"MM\"월\"') AS CLS_YYYYMM \n");
		sbSelSql.append("  FROM HLDC_PO_CLOSING A \n");
		sbSelSql.append(" WHERE A.CLS_YM     >= SUBSTR('" + v_Date + "',1,6) \n");
		sbSelSql.append("   AND A.SUBINV_CODE = '" + v_SubinvCode + "' \n");
		sbSelSql.append("   AND A.CLS_FLAG    = 'Y' \n");
		sbSelSql.append("   AND ROWNUM        = 1 \n");

		pstmt = conn.prepareStatement(sbSelSql.toString());
		rs = pstmt.executeQuery();

		if( rs.next() )
		{
			out_vl.add("v_SubulClose", "현창고는 수불마감(" + rs.getString("CLS_YYYYMM") + ")이 \n완료되어 본작업이 불가합니다!(구매기획팀 문의)");
		}

		rs.close();
		pstmt.close();

/*
		sbSelSql.delete(0, sbSelSql.length());
		sbSelSql.append( "SELECT \n");
		sbSelSql.append( "       TO_CHAR(TO_DATE(MAX(A.PHYSIC_DATE), 'YYYYMMDD'), 'YYYY\"년\"MM\"월\"DD\"일\"') AS PHYSIC_DATE \n");
		sbSelSql.append( "  FROM HLDC_PO_PHYSICAL_INVENTORY A \n");
		sbSelSql.append( " WHERE A.PHYSIC_DATE  > '" + v_Date + "' \n");
		sbSelSql.append( "   AND A.SUBINV_CODE  = '" + v_SubinvCode + "' \n");
		sbSelSql.append( "   AND A.CLOSE_DATE   > ' ' \n");

		stmt = conn.createStatement();
		rs = stmt.executeQuery(sbSelSql.toString());

		if( rs.next() )
		{
			if( !nullToBlank(rs.getString("PHYSIC_DATE")).equals("") )
			{
				out_vl.add("v_StockConfirm", "재고반영취소는 마지막 반영일(" + rs.getString("PHYSIC_DATE") + ")\n에만 가능합니다.!");
			}
		}

		rs.close();
		stmt.close();
*/

		sbSelSql.delete(0, sbSelSql.length());
		sbSelSql.append("/* 재고내역 조회 */ \n");
        sbSelSql.append("SELECT 0 AS CHK \n");
        sbSelSql.append("     , A.PHYSIC_ID AS PHYSIC_ID \n");
        sbSelSql.append("     , A.PHYSIC_DATE AS PHYSIC_DATE \n");
        sbSelSql.append("     , A.SUBINV_CODE AS SUBINV_CODE \n");
        sbSelSql.append("     , D.CLASS_NAME AS L_CLASS_NAME \n");
        sbSelSql.append("     , E.CLASS_NAME AS M_CLASS_NAME \n");
        sbSelSql.append("     , B.ITEM_CODE AS ITEM_CODE \n");
        sbSelSql.append("     , B.ITEM_NAME AS ITEM_NAME \n");
        sbSelSql.append("     , B.ITEM_SIZE AS ITEM_SIZE \n");
        sbSelSql.append("     , B.PO_UOM AS PO_UOM \n");
        //2016.01.06 최학진 수불단위 추가
        sbSelSql.append("     , B.UOM_CODE AS UOM_CODE \n");
		//구매단위
		if( v_chkPoUom.equals("Y") )
		{
			sbSelSql.append("     , ROUND(A.MARGIN_PRICE * B.UOM_CONVERT_RATE) AS M_STK_PRICE  -- 재고단가 \n");
	        sbSelSql.append("     , (A.ONHAND_QTY / B.UOM_CONVERT_RATE) AS M_STK_QTY      -- 재고량 \n");
	        sbSelSql.append("     , ROUND(A.ONHAND_MAMOUNT) AS M_STK_AMT                         -- 재고금액(관리) \n");
	        sbSelSql.append("     , (A.PHYSIC_QTY / B.UOM_CONVERT_RATE) AS M_REAL_QTY     -- 실사재고량 \n");
	        sbSelSql.append("     , ROUND(A.ONHAND_MAMOUNT - A.LOSS_MAMOUNT) AS M_REAL_AMT     -- 실사재고금액 \n");
	        sbSelSql.append("     , (A.LOSS_QTY / B.UOM_CONVERT_RATE) AS M_USE_QTY        -- 사용량 \n");
	        sbSelSql.append("     , ROUND(A.LOSS_MAMOUNT) AS M_USE_AMT                           -- 사용금액(관리) \n");
	        sbSelSql.append("     , ROUND(A.UNIT_PRICE * B.UOM_CONVERT_RATE) AS U_STK_PRICE    -- 재고단가(매입) \n");
	        sbSelSql.append("     , ROUND(A.ONHAND_UAMOUNT) AS U_STK_AMT                         -- 재고금액(매입) \n");
	        sbSelSql.append("     , ROUND(A.ONHAND_UAMOUNT - A.LOSS_UAMOUNT) AS U_REAL_AMT     -- 실사금액(매입) \n");
	        sbSelSql.append("     , ROUND(A.LOSS_UAMOUNT) AS U_USE_AMT                           -- 사용금액(매입) \n");
			if( v_SubinvCode.substring(0,1).equals("C") )
				sbSelSql.append("     , F.PO_QTY AS MENU_QTY                                  -- 식단예상사용량 \n");
			else
				sbSelSql.append("     , 0 AS MENU_QTY                                         -- 식단예상사용량 \n");
		}
		else
		{
			sbSelSql.append("     , ROUND(A.MARGIN_PRICE) AS M_STK_PRICE                      -- 재고단가 \n");
	        sbSelSql.append("     , A.ONHAND_QTY AS M_STK_QTY                          -- 재고량 \n");
	        sbSelSql.append("     , ROUND(A.ONHAND_MAMOUNT) AS M_STK_AMT                      -- 재고금액(관리) \n");
	        sbSelSql.append("     , A.PHYSIC_QTY AS M_REAL_QTY                         -- 실사재고량 \n");
	        sbSelSql.append("     , ROUND(A.ONHAND_MAMOUNT - A.LOSS_MAMOUNT) AS M_REAL_AMT  -- 실사재고금액 \n");
	        sbSelSql.append("     , A.LOSS_QTY AS M_USE_QTY                            -- 사용량 \n");
	        sbSelSql.append("     , ROUND(A.LOSS_MAMOUNT) AS M_USE_AMT                        -- 사용금액(관리) \n");
	        sbSelSql.append("     , ROUND(A.UNIT_PRICE) AS U_STK_PRICE                        -- 재고단가(매입) \n");
	        sbSelSql.append("     , ROUND(A.ONHAND_UAMOUNT) AS U_STK_AMT                      -- 재고금액(매입) \n");
	        sbSelSql.append("     , ROUND(A.ONHAND_UAMOUNT - A.LOSS_UAMOUNT) AS U_REAL_AMT    -- 실사금액(매입) \n");
	        sbSelSql.append("     , ROUND(A.LOSS_UAMOUNT) AS U_USE_AMT                        -- 사용금액(매입) \n");
	        
			if( v_SubinvCode.substring(0,1).equals("C") )
				sbSelSql.append("     , F.UOM_QTY AS MENU_QTY                              -- 식단예상사용량 \n");		
			else
				sbSelSql.append("     , 0 AS MENU_QTY                                      -- 식단예상사용량 \n");
		}
		sbSelSql.append("     , CASE WHEN INSTR(A.VALUE_DATE, '-') > 0 THEN '' ELSE A.VALUE_DATE END AS VALUE_DATE \n");
		sbSelSql.append("     , CASE WHEN A.VALUE_DATE <= TO_CHAR(TRUNC(TO_DATE('"+ v_Date +"','YYYYMMDD') + 7), 'YYYYMMDD') \n");
		sbSelSql.append("	         THEN 'Y' \n");
		sbSelSql.append("	         ELSE 'N' END AS BG_YN \n");
        sbSelSql.append("     , A.MAKER_DATE AS MAKER_DATE \n");
        sbSelSql.append("     , A.VALUE_DATE_INFO AS VALUE_DATE_INFO \n");
        sbSelSql.append("     , B.UOM_CONVERT_RATE AS UOM_CONVERT_RATE \n");
        sbSelSql.append("     , B.TAX_CODE AS TAX_CODE \n");
        sbSelSql.append("  FROM HLDC_PO_PHYSICAL_INVENTORY A \n");
        sbSelSql.append("     , HLDC_PO_ITEM_MST B \n");
        sbSelSql.append("     , (SELECT DISTINCT A.* \n");
    	sbSelSql.append("          FROM HLDC_PO_PHYSICAL_INVENTORY A \n");
    	sbSelSql.append("             , (SELECT ITEM_CODE AS ITEM_CODE \n");
    	sbSelSql.append("                     , MAX(UPDATE_DATE) AS UPDATE_DATE \n");
    	sbSelSql.append("                  FROM HLDC_PO_PHYSICAL_INVENTORY \n");
    	sbSelSql.append("                 WHERE PHYSIC_DATE = '" + v_Date + "' \n");
    	sbSelSql.append("                   AND SUBINV_CODE = '" + v_SubinvCode + "' \n");
    	sbSelSql.append("                 GROUP BY ITEM_CODE) B \n");
    	sbSelSql.append("         WHERE A.ITEM_CODE   = B.ITEM_CODE \n");
    	sbSelSql.append("           AND A.UPDATE_DATE = B.UPDATE_DATE \n");
    	sbSelSql.append("           AND A.PHYSIC_DATE = '" + v_Date + "' \n");
    	sbSelSql.append("           AND A.SUBINV_CODE = '" + v_SubinvCode + "' \n");
    	sbSelSql.append("       ) C \n");
        sbSelSql.append("     , HLDC_PO_ITEM_CLASS_HLDC_V D \n");
        sbSelSql.append("     , HLDC_PO_ITEM_CLASS_HLDC_V E \n");
        if( v_MenuQty.equals("RSS") )
        {
			sbSelSql.append("     , (SELECT A.ITEM_CODE \n");
			sbSelSql.append("             , 0 AS KG_QTY \n");
			sbSelSql.append("             , ROUND((SUM(A.LOSS_QTY / B.UOM_CONVERT_RATE) / 30) * NVL(MAX(C.OPTIMUM_DAY), 3), 2) AS PO_QTY \n");
			sbSelSql.append("             , ROUND((SUM(A.LOSS_QTY) / 30) * NVL(MAX(C.OPTIMUM_DAY), 3), 2) AS UOM_QTY \n");
			sbSelSql.append("          FROM FSP_PHYSICAL_INVENTORY_STOCK A \n");
			sbSelSql.append("             , HLDC_PO_ITEM_MST B \n");
			sbSelSql.append("             , FSP_PHYSICAL_INVENTORY_OPTIMUM C \n");
			sbSelSql.append("         WHERE A.ITEM_CODE = B.ITEM_CODE \n");
			sbSelSql.append("           AND A.SUBINV_CODE = C.SUBINV_CODE(+) \n");
			sbSelSql.append("           AND A.ITEM_CODE = C.ITEM_CODE(+) \n");
			sbSelSql.append("           AND A.SUBINV_CODE = '" + v_SubinvCode + "' \n"); 
			sbSelSql.append("           AND A.PHYSIC_DATE BETWEEN TO_CHAR(TO_DATE('" + v_Date + "', 'YYYYMMDD') - 30, 'YYYYMMDD') AND TO_CHAR(TO_DATE('" + v_Date + "', 'YYYYMMDD') - 1, 'YYYYMMDD') \n");
			sbSelSql.append("           AND A.TR_TYPE = 'I' \n");
			sbSelSql.append("           AND A.STATUS = 'Y' \n");
			sbSelSql.append("         GROUP BY A.ITEM_CODE) F \n");
        }
        else
        {
    		if( v_SubinvCode.substring(0,1).equals("C") )
    		{
    			sbSelSql.append("     , (SELECT C.ITEM_CODE AS ITEM_CODE \n");
    			sbSelSql.append("             , ROUND(SUM(DECODE(D.CAFE_YN, 'Y', B.EXPECT_SALE_QTY, DECODE(D.CATER_YN, 'Y', B.EXPECT_SALE_QTY, A.EXPECT_MEAL_QTY)) * C.NEED_QTY / 1000), 2) AS KG_QTY \n");
    			sbSelSql.append("             , ROUND(SUM(DECODE(D.CAFE_YN, 'Y', B.EXPECT_SALE_QTY, DECODE(D.CATER_YN, 'Y', B.EXPECT_SALE_QTY, A.EXPECT_MEAL_QTY)) * C.NEED_QTY / 1000) / E.KG_CONVERT_RATE, 2) AS PO_QTY \n");
    			sbSelSql.append("             , ROUND(SUM(DECODE(D.CAFE_YN, 'Y', B.EXPECT_SALE_QTY, DECODE(D.CATER_YN, 'Y', B.EXPECT_SALE_QTY, A.EXPECT_MEAL_QTY)) * C.NEED_QTY / 1000) / E.KG_CONVERT_RATE * E.UOM_CONVERT_RATE, 2) AS UOM_QTY \n");
    			sbSelSql.append("          FROM FSM_REAL_MENU_MST A \n");
    			sbSelSql.append("             , FSM_REAL_RECIPE_MST B \n");
    			sbSelSql.append("             , FSM_REAL_RECIPE_ITEM C \n");
    			sbSelSql.append("             , FSA_HALL_MST D \n");
    			sbSelSql.append("             , HLDC_PO_ITEM_MST E \n");
    			sbSelSql.append("         WHERE A.UPJANG      = B.UPJANG \n");
    			sbSelSql.append("           AND A.MENU_CD     = B.MENU_CD \n");
    			sbSelSql.append("           AND B.UPJANG      = C.UPJANG \n");
    			sbSelSql.append("           AND B.MENU_CD     = C.MENU_CD \n");
    			sbSelSql.append("           AND B.RECIPE_CD   = C.RECIPE_CD \n");
    			sbSelSql.append("           AND A.UPJANG      = D.UPJANG \n");
    			sbSelSql.append("           AND A.HALL_CD     = D.HALL_CD \n");
    			sbSelSql.append("           AND C.ITEM_CODE   = E.ITEM_CODE \n");
    			sbSelSql.append("           AND A.UPJANG      = (SELECT UPJANG FROM HLDC_PO_SUBINVENTORY WHERE SUBINV_CODE = '" + v_SubinvCode + "') \n");
    			sbSelSql.append("           AND A.SUBINV_CODE = '" + v_SubinvCode + "' \n");
    			sbSelSql.append("           AND A.MENU_DATE   = '" + v_Date + "' \n");
    			sbSelSql.append("         GROUP BY C.ITEM_CODE, E.KG_CONVERT_RATE, E.UOM_CONVERT_RATE) F \n");
    		}
        }

        sbSelSql.append(" WHERE A.ITEM_CODE   = B.ITEM_CODE \n");
        sbSelSql.append("   AND A.PHYSIC_ID   = C.PHYSIC_ID \n");
        sbSelSql.append("   AND A.ITEM_CODE   = C.ITEM_CODE \n");
        sbSelSql.append("   AND B.ITEM_CLASS2 = D.CLASS_CODE \n");
        sbSelSql.append("   AND B.ITEM_CLASS3 = E.CLASS_CODE \n");
        sbSelSql.append("   AND A.SUBINV_CODE = '" + v_SubinvCode + "' -- 창고코드 \n");
        sbSelSql.append("   AND A.PHYSIC_DATE = '" + v_Date + "' -- 조사일 \n");
   		if( v_MenuQty.equals("RSS") || v_SubinvCode.substring(0,1).equals("C") )
			sbSelSql.append("   AND B.ITEM_CODE   = F.ITEM_CODE(+) \n");

		sbSelSql.append("   AND (A.PHYSIC_QTY <> 0 OR A.LOSS_QTY <> 0) \n");
		sbSelSql.append("   AND C.CANCEL_YN = 'N' \n");
		sbSelSql.append(" ORDER BY CASE WHEN A.VALUE_DATE <= TO_CHAR(TRUNC(TO_DATE('" + v_Date + "','YYYYMMDD') + 7), 'YYYYMMDD') THEN 1 ELSE 2 END \n");
		sbSelSql.append("        , D.CLASS_CODE, E.CLASS_CODE, A.ITEM_CODE \n");

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