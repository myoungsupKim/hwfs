<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="../../sc/main/common.jsp"%>
<%
	CallableStatement cstmt = null;

	try {
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();

		//jsp log 서비스 시작
		logger.startIndividualLog(in_vl.getString("titLogId"));

		DataSet ds_stock = in_dl.get("ds_stock");

		String v_SubinvCode = nullToBlank(in_vl.getString("v_SubinvCode"));
		String v_Date = nullToBlank(in_vl.getString("v_Date"));
		String v_chkPoUom = nullToBlank(in_vl.getString("v_chkPoUom"));
		String g_EmpNo = nullToBlank(in_vl.getString("g_EmpNo"));
		String v_status = nullToBlank(in_vl.getString("v_status"));
		String v_trType = nullToBlank(in_vl.getString("v_trType"));

		conn.setAutoCommit(false);

		StringBuffer sbSelSql = new StringBuffer();

        sbSelSql.delete(0, sbSelSql.length());
        sbSelSql.append("SELECT CASE WHEN TO_CHAR(SYSDATE, 'YYYYMMDD') < '" + v_Date + "' \n");
        sbSelSql.append("            THEN 'Y' \n");
        sbSelSql.append("            ELSE 'N' END DATE_YN \n");
        sbSelSql.append("  FROM DUAL \n");

        pstmt = conn.prepareStatement(sbSelSql.toString());
        rs = pstmt.executeQuery();
		rs.next();
		String dateYn = rs.getString("DATE_YN");

		if( dateYn.equals("Y") )
		{
			out_vl.add("v_StockClose", "재고취소일은 현재일보다 작거나 같아야 합니다.");
		   	this.setResultMessage(0, "OK", out_vl);
		   	proc_output(response, out, out_vl, out_dl);
		   	return;
		}

		rs.close();
        pstmt.close();

		sbSelSql.delete(0, sbSelSql.length());
		sbSelSql.append("/* 일마감여부 확인 */ \n");
		sbSelSql.append("SELECT 1 \n");
		sbSelSql.append("  FROM MAS_CLOSE_MGMT \n");
		sbSelSql.append(" WHERE UPJANG = (SELECT UPJANG FROM HLDC_PO_SUBINVENTORY WHERE SUBINV_CODE = '" + v_SubinvCode + "') \n");
		sbSelSql.append("   AND CLOSE_GUBUN = '004' \n");
		sbSelSql.append("   AND CLOSE_DATE = '" + v_Date + "' \n");

		pstmt = conn.prepareStatement(sbSelSql.toString());
		rs = pstmt.executeQuery();

		if (rs.next()) {
			out_vl.add("v_StockClose", "반영일에 재고마감이 이루어져 반영취소가 불가합니다.\n재고마감관리자에게 연락하세요.");
			this.setResultMessage(0, "OK", out_vl);
			proc_output(response, out, out_vl, out_dl);
			return;
		}

		rs.close();
		pstmt.close();

		sbSelSql.delete(0, sbSelSql.length());
		sbSelSql.append("/* 월마감 확인 */ \n");
		sbSelSql.append("SELECT TO_CHAR(TO_DATE(A.CLS_YM,'YYYYMM'),'YYYY\"년\"MM\"월\"') AS CLS_YYYYMM \n");
		sbSelSql.append("  FROM HLDC_PO_CLOSING A \n");
		sbSelSql.append(" WHERE A.CLS_YM     >= SUBSTR('" + v_Date	+ "',1,6) \n");
		sbSelSql.append("   AND A.SUBINV_CODE = '" + v_SubinvCode + "' \n");
		sbSelSql.append("   AND A.CLS_FLAG    = 'Y' \n");
		sbSelSql.append("   AND ROWNUM        = 1 \n");

		pstmt = conn.prepareStatement(sbSelSql.toString());
		rs = pstmt.executeQuery();

		if (rs.next()) {
			out_vl.add("v_SubulClose", "현창고는 수불마감(" + rs.getString("CLS_YYYYMM") + ")이 \n완료되어 본작업이 불가합니다!");
			this.setResultMessage(0, "OK", out_vl);
			proc_output(response, out, out_vl, out_dl);
			return;
		}

		rs.close();
		pstmt.close();

        int stockCnt = 0;

        // 재고등록 실사확인
        sbSelSql.delete(0, sbSelSql.length());
        sbSelSql.append("/* 재고 취소건 존재여부 확인 */                                 \n");
        sbSelSql.append("SELECT COUNT(*) AS STOCK_CNT                                    \n");
        sbSelSql.append("  FROM FSP_PHYSICAL_INVENTORY_STOCK                             \n");
        sbSelSql.append(" WHERE PHYSIC_DATE = '" + v_Date + "'                           \n");
        sbSelSql.append("   AND SUBINV_CODE = '" + v_SubinvCode + "'                     \n");
        sbSelSql.append("   AND GRP_NO = (SELECT MAX(TO_NUMBER(GRP_NO))                  \n");
        sbSelSql.append("                   FROM FSP_PHYSICAL_INVENTORY_STOCK            \n");
        sbSelSql.append("                  WHERE PHYSIC_DATE = '" + v_Date + "'          \n");
        sbSelSql.append("                    AND SUBINV_CODE = '" + v_SubinvCode + "')   \n");
        sbSelSql.append("   AND TR_TYPE = 'C'                                            \n");
        sbSelSql.append("   AND STATUS = 'Y'                                             \n");

        pstmt = conn.prepareStatement(sbSelSql.toString());
        rs = pstmt.executeQuery();

        if ( rs != null )
        {
            rs.next();
            stockCnt = rs.getInt("STOCK_CNT");
        }

        rs.close();
        pstmt.close();

        if( stockCnt > 0 )
        {
            out_vl.add("v_StockConfirm", "현창고는 재고 취소가 반영되어 본작업이 불가합니다!");
            this.setResultMessage(0, "OK", out_vl);
            proc_output(response, out, out_vl, out_dl);
            return;
        }

		// 실사 취소시 한번 더 조회해서 가장 최근에 재고 실사한 데이트를 가지고 처리한다.
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
        sbSelSql.append("     , B.UOM_CODE AS UOM_CODE \n");
		// 구매단위
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
		// 수불단위
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
        sbSelSql.append(" WHERE A.ITEM_CODE   = B.ITEM_CODE \n");
        sbSelSql.append("   AND A.PHYSIC_ID   = C.PHYSIC_ID \n");
        sbSelSql.append("   AND A.ITEM_CODE   = C.ITEM_CODE \n");
        sbSelSql.append("   AND B.ITEM_CLASS2 = D.CLASS_CODE \n");
        sbSelSql.append("   AND B.ITEM_CLASS3 = E.CLASS_CODE \n");
        sbSelSql.append("   AND A.SUBINV_CODE = '" + v_SubinvCode + "' -- 창고코드 \n");
        sbSelSql.append("   AND A.PHYSIC_DATE = '" + v_Date + "' -- 조사일 \n");
		if( v_SubinvCode.substring(0,1).equals("C") )
			sbSelSql.append("   AND B.ITEM_CODE   = F.ITEM_CODE(+) \n");

		sbSelSql.append("   AND (A.PHYSIC_QTY <> 0 OR A.LOSS_QTY <> 0) \n");
		sbSelSql.append("   AND C.CANCEL_YN = 'N' \n");
		sbSelSql.append(" ORDER BY CASE WHEN A.VALUE_DATE <= TO_CHAR(TRUNC(TO_DATE('" + v_Date + "','YYYYMMDD') + 7), 'YYYYMMDD') THEN 1 ELSE 2 END \n");
		sbSelSql.append("        , D.CLASS_CODE, E.CLASS_CODE, A.ITEM_CODE \n");

		pstmt = conn.prepareStatement(sbSelSql.toString());
		rs = pstmt.executeQuery();

		DataSet ds_list = this.makeDataSet(rs, "ds_list");

		if( ds_list.getRowCount() == 0 )
		{
            out_vl.add("v_StockConfirm", "현창고는 재고 취소가 반영되어 본작업이 불가합니다!");
            this.setResultMessage(0, "OK", out_vl);
            proc_output(response, out, out_vl, out_dl);
            return;
		}

		sbSelSql.delete(0, sbSelSql.length());
		sbSelSql.append( "SELECT FSP_PHYSICAL_INVENTORY_S.NEXTVAL AS GRP_NO FROM DUAL\n");
		pstmt = conn.prepareStatement(sbSelSql.toString());
		rs = pstmt.executeQuery();
		rs.next();

		int grpNo = rs.getInt("GRP_NO");

		rs.close();
		pstmt.close();

		StringBuffer sbInsSql = new StringBuffer();
		sbInsSql.delete(0, sbInsSql.length());
		sbInsSql.append("MERGE INTO FSP_PHYSICAL_INVENTORY_STOCK A \n");
		sbInsSql.append("USING ( SELECT ? AS PHYSIC_ID \n");
		sbInsSql.append("             , ? AS PHYSIC_DATE \n");
		sbInsSql.append("             , ? AS SUBINV_CODE \n");
		sbInsSql.append("             , ? AS ITEM_CODE \n");
		sbInsSql.append("             , ? AS ONHAND_QTY \n");
		sbInsSql.append("             , ? AS UNIT_PRICE \n");
		sbInsSql.append("             , ? AS ONHAND_UAMOUNT \n");
		sbInsSql.append("             , ? AS MARGIN_PRICE \n");
		sbInsSql.append("             , ? AS ONHAND_MAMOUNT \n");
		sbInsSql.append("             , ? AS PHYSIC_QTY \n");
		sbInsSql.append("             , ? AS LOSS_QTY \n");
		sbInsSql.append("             , ? AS LOSS_UAMOUNT \n");
		sbInsSql.append("             , ? AS LOSS_MAMOUNT \n");
		sbInsSql.append("             , ? AS VALUE_DATE_INFO \n");
		sbInsSql.append("             , ? AS VALUE_DATE \n");
		sbInsSql.append("             , ? AS MAKER_DATE \n");
		sbInsSql.append("             , ? AS GRP_NO \n");
		sbInsSql.append("             , ? AS STATUS \n");
		sbInsSql.append("             , ? AS TR_TYPE \n");
		sbInsSql.append("             , TO_CHAR(SYSDATE, 'YYYYMMDD') AS APPLY_DATE \n");
		sbInsSql.append("             , SYSDATE AS CREATE_DATE \n");
		sbInsSql.append("             , ? AS CREATE_BY \n");
		sbInsSql.append("             , SYSDATE AS UPDATE_DATE \n");
		sbInsSql.append("             , ? AS UPDATE_BY \n");
		sbInsSql.append("          FROM DUAL \n");
		sbInsSql.append("      ) B \n");
		sbInsSql.append("   ON (    A.PHYSIC_DATE = B.PHYSIC_DATE \n");
		sbInsSql.append("       AND A.SUBINV_CODE = B.SUBINV_CODE \n");
		sbInsSql.append("       AND A.ITEM_CODE   = B.ITEM_CODE \n");
		sbInsSql.append("      ) \n");
		sbInsSql.append("WHEN MATCHED THEN \n");
		sbInsSql.append("UPDATE \n");
		sbInsSql.append("   SET A.PHYSIC_ID       = B.PHYSIC_ID \n");
		sbInsSql.append("     , A.ONHAND_QTY      = B.ONHAND_QTY \n");
		sbInsSql.append("     , A.UNIT_PRICE      = B.UNIT_PRICE \n");
		sbInsSql.append("     , A.ONHAND_UAMOUNT  = B.ONHAND_UAMOUNT \n");
		sbInsSql.append("     , A.MARGIN_PRICE    = B.MARGIN_PRICE \n");
		sbInsSql.append("     , A.ONHAND_MAMOUNT  = B.ONHAND_MAMOUNT \n");
		sbInsSql.append("     , A.PHYSIC_QTY      = B.PHYSIC_QTY \n");
		sbInsSql.append("     , A.LOSS_QTY        = B.LOSS_QTY \n");
		sbInsSql.append("     , A.LOSS_UAMOUNT    = B.LOSS_UAMOUNT \n");
		sbInsSql.append("     , A.LOSS_MAMOUNT    = B.LOSS_MAMOUNT \n");
		sbInsSql.append("     , A.VALUE_DATE_INFO = B.VALUE_DATE_INFO \n");
		sbInsSql.append("     , A.VALUE_DATE      = B.VALUE_DATE \n");
		sbInsSql.append("     , A.MAKER_DATE      = B.MAKER_DATE \n");
		sbInsSql.append("     , A.GRP_NO          = B.GRP_NO \n");
		sbInsSql.append("     , A.STATUS          = B.STATUS \n");
		sbInsSql.append("     , A.TR_TYPE         = B.TR_TYPE \n");
		sbInsSql.append("     , A.APPLY_DATE      = B.APPLY_DATE \n");
		sbInsSql.append("     , A.UPDATE_DATE     = B.UPDATE_DATE \n");
		sbInsSql.append("     , A.UPDATE_BY       = B.UPDATE_BY \n");
		sbInsSql.append("WHEN NOT MATCHED THEN \n");
		sbInsSql.append("INSERT \n");
		sbInsSql.append("( \n");
		sbInsSql.append("   A.PHYSIC_ID \n");
		sbInsSql.append(" , A.PHYSIC_DATE \n");
		sbInsSql.append(" , A.SUBINV_CODE \n");
		sbInsSql.append(" , A.ITEM_CODE \n");
		sbInsSql.append(" , A.ONHAND_QTY \n");
		sbInsSql.append(" , A.UNIT_PRICE \n");
		sbInsSql.append(" , A.ONHAND_UAMOUNT \n");
		sbInsSql.append(" , A.MARGIN_PRICE \n");
		sbInsSql.append(" , A.ONHAND_MAMOUNT \n");
		sbInsSql.append(" , A.PHYSIC_QTY \n");
		sbInsSql.append(" , A.LOSS_QTY \n");
		sbInsSql.append(" , A.LOSS_UAMOUNT \n");
		sbInsSql.append(" , A.LOSS_MAMOUNT \n");
		sbInsSql.append(" , A.VALUE_DATE_INFO \n");
		sbInsSql.append(" , A.VALUE_DATE \n");
		sbInsSql.append(" , A.MAKER_DATE \n");
		sbInsSql.append(" , A.GRP_NO \n");
		sbInsSql.append(" , A.STATUS \n");
		sbInsSql.append(" , A.TR_TYPE \n");
		sbInsSql.append(" , A.APPLY_DATE \n");
		sbInsSql.append(" , A.CREATE_DATE \n");
		sbInsSql.append(" , A.CREATE_BY \n");
		sbInsSql.append(" , A.UPDATE_DATE \n");
		sbInsSql.append(" , A.UPDATE_BY \n");
		sbInsSql.append(") \n");
		sbInsSql.append("VALUES \n");
		sbInsSql.append("( \n");
		sbInsSql.append("   B.PHYSIC_ID \n");
		sbInsSql.append(" , B.PHYSIC_DATE \n");
		sbInsSql.append(" , B.SUBINV_CODE \n");
		sbInsSql.append(" , B.ITEM_CODE \n");
		sbInsSql.append(" , B.ONHAND_QTY \n");
		sbInsSql.append(" , B.UNIT_PRICE \n");
		sbInsSql.append(" , B.ONHAND_UAMOUNT \n");
		sbInsSql.append(" , B.MARGIN_PRICE \n");
		sbInsSql.append(" , B.ONHAND_MAMOUNT \n");
		sbInsSql.append(" , B.PHYSIC_QTY \n");
		sbInsSql.append(" , B.LOSS_QTY \n");
		sbInsSql.append(" , B.LOSS_UAMOUNT \n");
		sbInsSql.append(" , B.LOSS_MAMOUNT \n");
		sbInsSql.append(" , B.VALUE_DATE_INFO \n");
		sbInsSql.append(" , B.VALUE_DATE \n");
		sbInsSql.append(" , B.MAKER_DATE \n");
		sbInsSql.append(" , B.GRP_NO \n");
		sbInsSql.append(" , B.STATUS \n");
		sbInsSql.append(" , B.TR_TYPE \n");
		sbInsSql.append(" , B.APPLY_DATE \n");
		sbInsSql.append(" , B.CREATE_DATE \n");
		sbInsSql.append(" , B.CREATE_BY \n");
		sbInsSql.append(" , B.UPDATE_DATE \n");
		sbInsSql.append(" , B.UPDATE_BY \n");
		sbInsSql.append(") \n");

		pstmt = conn.prepareStatement(sbInsSql.toString());

		int iPhysicCnt = 0;

		for (int i = 0; i < ds_list.getRowCount(); i++) 
		{
			double dblM_STK_QTY = 0;
			double dblUOM_CONVERT_RATE = 0;
			double dblU_STK_PRICE = 0;
			double dblM_STK_PRICE = 0;
			double dblM_REAL_QTY = 0;
			double dblM_USE_QTY = 0;

			double dblONHAND_QTY = 0;
			double dblUNIT_PRICE = 0;
			double dblUNIT_VAT = 0;
			double dblMARGIN_PRICE = 0;
			double dblMARGIN_VAT = 0;
			double dblPHYSIC_QTY = 0;
			double dblLOSS_QTY = 0;

			dblM_STK_QTY = Double.parseDouble(ds_list.getString(i, "M_STK_QTY"));
			dblU_STK_PRICE = Double.parseDouble(ds_list.getString(i, "U_STK_PRICE"));
			dblM_STK_PRICE = Double.parseDouble(ds_list.getString(i, "M_STK_PRICE"));
			dblM_REAL_QTY = Double.parseDouble(ds_list.getString(i, "M_REAL_QTY"));
			dblM_USE_QTY = Double.parseDouble(ds_list.getString(i,	"M_USE_QTY"));

			if (v_chkPoUom.equals("Y"))
			{
				dblUOM_CONVERT_RATE = Double.parseDouble(ds_list.getString(i, "UOM_CONVERT_RATE"));
				dblONHAND_QTY = dblM_STK_QTY * dblUOM_CONVERT_RATE;
				dblUNIT_PRICE = dblU_STK_PRICE / dblUOM_CONVERT_RATE;
				dblMARGIN_PRICE = dblM_STK_PRICE / dblUOM_CONVERT_RATE;
				dblPHYSIC_QTY = dblM_REAL_QTY * dblUOM_CONVERT_RATE;
				dblLOSS_QTY = dblM_USE_QTY * dblUOM_CONVERT_RATE;
			}
			else
			{
				dblONHAND_QTY = dblM_STK_QTY;
				dblUNIT_PRICE = dblU_STK_PRICE;
				dblMARGIN_PRICE = dblM_STK_PRICE;
				dblPHYSIC_QTY = dblM_REAL_QTY;
				dblLOSS_QTY = dblM_USE_QTY;
			}
			if (ds_list.getString(i, "TAX_CODE").equals("100"))
			{
				dblUNIT_VAT = 0.1 * dblUNIT_PRICE;
				dblMARGIN_VAT = 0.1 * dblMARGIN_PRICE;
			}
			else
			{
				dblUNIT_VAT = 0;
				dblMARGIN_VAT = 0;
			}

			pstmt.setString(1, nullToBlank(ds_list.getString(i, "PHYSIC_ID")));
			pstmt.setString(2, v_Date);
			pstmt.setString(3, nullToBlank(ds_list.getString(i, "SUBINV_CODE")));
			pstmt.setString(4, nullToBlank(ds_list.getString(i, "ITEM_CODE")));
			pstmt.setString(5, Double.toString(dblONHAND_QTY));
			pstmt.setString(6, Double.toString(dblUNIT_PRICE));
			pstmt.setString(7, nullToBlank(ds_list.getString(i, "U_STK_AMT")));
			pstmt.setString(8, Double.toString(dblMARGIN_PRICE));
			pstmt.setString(9, nullToBlank(ds_list.getString(i, "M_STK_AMT")));
			pstmt.setString(10, Double.toString(dblPHYSIC_QTY));
			pstmt.setString(11, Double.toString(dblLOSS_QTY));
			pstmt.setString(12, nullToBlank(ds_list.getString(i, "U_USE_AMT")));
			pstmt.setString(13, nullToBlank(ds_list.getString(i, "M_USE_AMT")));
			pstmt.setString(14, nullToBlank(ds_list.getString(i, "VALUE_DATE_INFO")));
			pstmt.setString(15, nullToBlank(ds_list.getString(i, "VALUE_DATE")));
			pstmt.setString(16, nullToBlank(ds_list.getString(i, "MAKER_DATE")));
			pstmt.setString(17, Integer.toString(grpNo));
			pstmt.setString(18, "N");
			pstmt.setString(19, v_trType);
			pstmt.setString(20, nullToBlank(g_EmpNo));
			pstmt.setString(21, nullToBlank(g_EmpNo));

			iPhysicCnt++;

			pstmt.executeUpdate();
		}

		pstmt.close();

		// 실사취소 P/S 호출
		if (iPhysicCnt > 0)
		{
			cstmt = conn.prepareCall("{call EPROCUSR.PK_IF_FCUS_INSP_EXCUTE.PK_CANCEL_EXCUTE(?, ?, ?, ?)}");

			cstmt.setString(1, Integer.toString(grpNo));
			cstmt.setString(2, g_EmpNo);
			cstmt.registerOutParameter(3, Types.VARCHAR);
			cstmt.registerOutParameter(4, Types.VARCHAR);

			cstmt.execute();

			if (cstmt.getString(3).equals("E"))
			{
				String strMsg = "";

				if (nullToBlank(cstmt.getString(4)).equals(""))
					strMsg = "시스템오류! 전산 담당자에게 문의 하세요.";
				else
					strMsg = nullToBlank(cstmt.getString(4));

				out_vl.add("v_PO_PHYSICUPD_PRO", strMsg);
				this.setResultMessage(0, "OK", out_vl);
				conn.rollback();
				proc_output(response, out, out_vl, out_dl);
				return;
			}
			
			cstmt.close();
		}

		// 실사취소 이력 등록
		sbInsSql.delete(0, sbInsSql.length());
		sbInsSql.append("INSERT INTO FSP_PHYSICAL_INVENTORY_HIS \n");
		sbInsSql.append("( \n");
		sbInsSql.append("   PHYSIC_ID \n");
		sbInsSql.append(" , PHYSIC_DATE \n");
		sbInsSql.append(" , SUBINV_CODE \n");
		sbInsSql.append(" , ITEM_CODE \n");
		sbInsSql.append(" , ONHAND_QTY \n");
		sbInsSql.append(" , UNIT_PRICE \n");
		sbInsSql.append(" , ONHAND_UAMOUNT \n");
		sbInsSql.append(" , MARGIN_PRICE \n");
		sbInsSql.append(" , ONHAND_MAMOUNT \n");
		sbInsSql.append(" , PHYSIC_QTY \n");
		sbInsSql.append(" , LOSS_QTY \n");
		sbInsSql.append(" , LOSS_UAMOUNT \n");
		sbInsSql.append(" , LOSS_MAMOUNT \n");
		sbInsSql.append(" , VALUE_DATE_INFO \n");
		sbInsSql.append(" , VALUE_DATE \n");
		sbInsSql.append(" , MAKER_DATE \n");
		sbInsSql.append(" , GRP_NO \n");
		sbInsSql.append(" , STATUS \n");
		sbInsSql.append(" , TR_TYPE \n");
		sbInsSql.append(" , APPLY_DATE \n");
		sbInsSql.append(" , CREATE_DATE \n");
		sbInsSql.append(" , CREATE_BY \n");
		sbInsSql.append(" , UPDATE_DATE \n");
		sbInsSql.append(" , UPDATE_BY \n");
		sbInsSql.append(") \n");
		sbInsSql.append("VALUES \n");
		sbInsSql.append("( \n");
		sbInsSql.append("   ? \n");
		sbInsSql.append(" , ? \n");
		sbInsSql.append(" , ? \n");
		sbInsSql.append(" , ? \n");
		sbInsSql.append(" , ? \n");
		sbInsSql.append(" , ? \n");
		sbInsSql.append(" , ? \n");
		sbInsSql.append(" , ? \n");
		sbInsSql.append(" , ? \n");
		sbInsSql.append(" , ? \n");
		sbInsSql.append(" , ? \n");
		sbInsSql.append(" , ? \n");
		sbInsSql.append(" , ? \n");
		sbInsSql.append(" , ? \n");
		sbInsSql.append(" , ? \n");
		sbInsSql.append(" , ? \n");
		sbInsSql.append(" , ? \n");
		sbInsSql.append(" , ? \n");
		sbInsSql.append(" , ? \n");
		sbInsSql.append(" , TO_CHAR(SYSDATE, 'YYYYMMDD') \n");
		sbInsSql.append(" , SYSDATE \n");
		sbInsSql.append(" , ? \n");
		sbInsSql.append(" , SYSDATE \n");
		sbInsSql.append(" , ? \n");
		sbInsSql.append(") \n");

		pstmt = conn.prepareStatement(sbInsSql.toString());

		for (int i = 0; i < ds_list.getRowCount(); i++) 
		{
			double dblM_STK_QTY = 0;
			double dblUOM_CONVERT_RATE = 0;
			double dblU_STK_PRICE = 0;
			double dblM_STK_PRICE = 0;
			double dblM_REAL_QTY = 0;
			double dblM_USE_QTY = 0;

			double dblONHAND_QTY = 0;
			double dblUNIT_PRICE = 0;
			double dblUNIT_VAT = 0;
			double dblMARGIN_PRICE = 0;
			double dblMARGIN_VAT = 0;
			double dblPHYSIC_QTY = 0;
			double dblLOSS_QTY = 0;

			dblM_STK_QTY = Double.parseDouble(ds_list.getString(i, "M_STK_QTY"));
			dblU_STK_PRICE = Double.parseDouble(ds_list.getString(i, "U_STK_PRICE"));
			dblM_STK_PRICE = Double.parseDouble(ds_list.getString(i, "M_STK_PRICE"));
			dblM_REAL_QTY = Double.parseDouble(ds_list.getString(i, "M_REAL_QTY"));
			dblM_USE_QTY = Double.parseDouble(ds_list.getString(i,	"M_USE_QTY"));

			if (v_chkPoUom.equals("Y"))
			{
				dblUOM_CONVERT_RATE = Double.parseDouble(ds_list.getString(i, "UOM_CONVERT_RATE"));
				dblONHAND_QTY = dblM_STK_QTY * dblUOM_CONVERT_RATE;
				dblUNIT_PRICE = dblU_STK_PRICE / dblUOM_CONVERT_RATE;
				dblMARGIN_PRICE = dblM_STK_PRICE / dblUOM_CONVERT_RATE;
				dblPHYSIC_QTY = dblM_REAL_QTY * dblUOM_CONVERT_RATE;
				dblLOSS_QTY = dblM_USE_QTY * dblUOM_CONVERT_RATE;
			}
			else
			{
				dblONHAND_QTY = dblM_STK_QTY;
				dblUNIT_PRICE = dblU_STK_PRICE;
				dblMARGIN_PRICE = dblM_STK_PRICE;
				dblPHYSIC_QTY = dblM_REAL_QTY;
				dblLOSS_QTY = dblM_USE_QTY;
			}
			if (ds_list.getString(i, "TAX_CODE").equals("100"))
			{
				dblUNIT_VAT = 0.1 * dblUNIT_PRICE;
				dblMARGIN_VAT = 0.1 * dblMARGIN_PRICE;
			}
			else
			{
				dblUNIT_VAT = 0;
				dblMARGIN_VAT = 0;
			}

			pstmt.setString(1, nullToBlank(ds_list.getString(i, "PHYSIC_ID")));
			pstmt.setString(2, v_Date);
			pstmt.setString(3, nullToBlank(ds_list.getString(i, "SUBINV_CODE")));
			pstmt.setString(4, nullToBlank(ds_list.getString(i, "ITEM_CODE")));
			pstmt.setString(5, Double.toString(dblONHAND_QTY));
			pstmt.setString(6, Double.toString(dblUNIT_PRICE));
			pstmt.setString(7, nullToBlank(ds_list.getString(i, "U_STK_AMT")));
			pstmt.setString(8, Double.toString(dblMARGIN_PRICE));
			pstmt.setString(9, nullToBlank(ds_list.getString(i, "M_STK_AMT")));
			pstmt.setString(10, Double.toString(dblPHYSIC_QTY));
			pstmt.setString(11, Double.toString(dblLOSS_QTY));
			pstmt.setString(12, nullToBlank(ds_list.getString(i, "U_USE_AMT")));
			pstmt.setString(13, nullToBlank(ds_list.getString(i, "M_USE_AMT")));
			pstmt.setString(14, nullToBlank(ds_list.getString(i, "VALUE_DATE_INFO")));
			pstmt.setString(15, nullToBlank(ds_list.getString(i, "VALUE_DATE")));
			pstmt.setString(16, nullToBlank(ds_list.getString(i, "MAKER_DATE")));
			pstmt.setString(17, Integer.toString(grpNo));
			pstmt.setString(18, "N");
			pstmt.setString(19, v_trType);
			pstmt.setString(20, nullToBlank(g_EmpNo));
			pstmt.setString(21, nullToBlank(g_EmpNo));

			pstmt.executeUpdate();
		}

		pstmt.close();
		conn.commit();

		this.setResultMessage(0, "OK", out_vl);
	} catch (Exception ex) {
		conn.rollback();
		//ex.printStackTrace();
		//jsp 로그남기기
		logger.debug(ex.getMessage(), ex);
		this.setResultMessage(-1, ex.toString(), out_vl);
	} finally {
		if (rs != null)
		{
			try {
				rs.close();
			} catch (Exception e) {
			}
		}
		if (pstmt != null)
		{
			try {
				pstmt.close();
			} catch (Exception e) {
			}
		}
		if (cstmt != null)
		{
			try {
				cstmt.close();
			} catch (Exception e) {
			}
		}
		if (conn != null)
		{
			try {
				conn.close();
			} catch (Exception e) {
			}
		}
		//jsp log 서비스 닫기
		try {
			logger.endIndividualLog();
		} catch (Exception logE) {
			logE.printStackTrace();
		}
	}

	proc_output(response, out, out_vl, out_dl);
%>