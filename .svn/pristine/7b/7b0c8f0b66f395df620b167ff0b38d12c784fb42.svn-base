<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
    CallableStatement cstmt = null;

	try
    {
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();

		// jsp log 서비스 시작
		logger.startIndividualLog(in_vl.getString("titLogId"));

		DataSet ds_stock  	    = in_dl.get("ds_stock");

		String v_SubinvCode 	= nullToBlank(in_vl.getString("v_SubinvCode"));
		String v_Date 			= nullToBlank(in_vl.getString("v_Date"));
		String v_chkPoUom	  	= nullToBlank(in_vl.getString("v_chkPoUom"));
		String g_EmpNo 			= nullToBlank(in_vl.getString("g_EmpNo"));
		String v_status			= nullToBlank(in_vl.getString("v_status"));
		String v_trType			= nullToBlank(in_vl.getString("v_trType"));
		String sPhysic_date		= v_Date;

        StringBuffer sbSelSql = new StringBuffer();
        StringBuffer sbInsSql = new StringBuffer();
        StringBuffer sbLogSql = new StringBuffer();

        sbSelSql.delete(0, sbSelSql.length());
        sbSelSql.append("SELECT CASE WHEN TO_CHAR(SYSDATE, 'YYYYMMDD') < '" + sPhysic_date + "' \n");
        sbSelSql.append("            THEN 'Y' \n");
        sbSelSql.append("            ELSE 'N' END DATE_YN \n");
        sbSelSql.append("  FROM DUAL \n");

        pstmt = conn.prepareStatement(sbSelSql.toString());
        rs = pstmt.executeQuery();
		rs.next();
		String dateYn = rs.getString("DATE_YN");

		if( dateYn.equals("Y") )
		{
			out_vl.add("v_ChkDate", "재고 조사일은 현재일보다 작거나 같아야 합니다.");
		   	this.setResultMessage(0, "OK", out_vl);
		   	proc_output(response, out, out_vl, out_dl);
		   	return;
		}

		rs.close();
        pstmt.close();

		if( v_trType.equals("I") )
        {
            sbSelSql.delete(0, sbSelSql.length());
            sbSelSql.append("/* 수불 마감월 확인 */ \n");
            sbSelSql.append( "SELECT TO_CHAR(TO_DATE(A.CLS_YM, 'YYYYMM'), 'YYYY\"년\"MM\"월\"') AS CLS_YYYYMM \n");
            sbSelSql.append("  FROM HLDC_PO_CLOSING A \n");
            sbSelSql.append(" WHERE A.CLS_YM     >= SUBSTR('" + sPhysic_date + "', 1, 6) \n");
            sbSelSql.append("   AND A.SUBINV_CODE = '" + v_SubinvCode + "' \n");
            sbSelSql.append("   AND A.CLS_FLAG    = 'Y' \n");
            sbSelSql.append(" ORDER BY A.CLS_YM \n");

            pstmt = conn.prepareStatement(sbSelSql.toString());
            rs = pstmt.executeQuery();

            while( rs.next() )
            {
                out_vl.add("v_SubulClose", "현창고는 수불마감(" + nullToBlank(rs.getString("CLS_YYYYMM")) + ")이 \n완료되어 본작업이 불가합니다!");
                this.setResultMessage(0, "OK", out_vl);
                proc_output(response, out, out_vl, out_dl);
                return;
            }

            rs.close();
            pstmt.close();

            int cnt = 0;

            sbSelSql.delete(0, sbSelSql.length());
            sbSelSql.append("/* 일마감여부 확인 */ \n");
            sbSelSql.append("SELECT COUNT(1) AS CNT \n");
            sbSelSql.append("  FROM MAS_CLOSE_MGMT \n");
            sbSelSql.append(" WHERE UPJANG = (SELECT UPJANG FROM HLDC_PO_SUBINVENTORY WHERE SUBINV_CODE = '" + v_SubinvCode + "') \n");
            sbSelSql.append("   AND CLOSE_GUBUN = '004' \n");	// 일마감구분 - 재고마감
            sbSelSql.append("   AND CLOSE_DATE = '" + sPhysic_date + "' \n");

            pstmt = conn.prepareStatement(sbSelSql.toString());
            rs = pstmt.executeQuery();

            if ( rs != null )
            {
                rs.next();
                cnt = rs.getInt("CNT");
            }

            rs.close();
            pstmt.close();

            if( cnt > 0 )
            {
                out_vl.add("v_StockConfirm", "재고마감되어 등록할 수 없습니다.\n재고마감관리자에게 연락하세요.");
                this.setResultMessage(0, "OK", out_vl);
                proc_output(response, out, out_vl, out_dl);
                return;
            }
        }

        int stockCnt = 0;

        sbSelSql.delete(0, sbSelSql.length());
        sbSelSql.append("/* 재고실사 확인 */ \n");
        sbSelSql.append("SELECT COUNT(*) AS STOCK_CNT \n");
        sbSelSql.append("  FROM HLDC_PO_PHYSICAL_INVENTORY A \n");
        sbSelSql.append("      , ( SELECT DISTINCT A.* \n");
        sbSelSql.append("            FROM HLDC_PO_PHYSICAL_INVENTORY A \n");
        sbSelSql.append("               , ( SELECT ITEM_CODE AS ITEM_CODE \n");
        sbSelSql.append("                        , MAX(UPDATE_DATE) AS UPDATE_DATE \n");
        sbSelSql.append("                     FROM HLDC_PO_PHYSICAL_INVENTORY \n");
		sbSelSql.append("                    WHERE PHYSIC_DATE = '" + sPhysic_date + "' \n");
		sbSelSql.append("                      AND SUBINV_CODE = '" + v_SubinvCode + "' \n");
		sbSelSql.append("                    GROUP BY ITEM_CODE \n");
		sbSelSql.append("                 ) B \n");
		sbSelSql.append("           WHERE A.ITEM_CODE   = B.ITEM_CODE \n");
		sbSelSql.append("             AND A.UPDATE_DATE = B.UPDATE_DATE \n");
		sbSelSql.append("             AND A.PHYSIC_DATE = '" + sPhysic_date + "' \n");
		sbSelSql.append("             AND A.SUBINV_CODE = '" + v_SubinvCode + "' \n");
		sbSelSql.append("        ) B \n");
		sbSelSql.append(" WHERE A.PHYSIC_ID   = B.PHYSIC_ID \n");
		sbSelSql.append("   AND A.ITEM_CODE   = B.ITEM_CODE \n");
		sbSelSql.append("   AND A.PHYSIC_DATE = '" + sPhysic_date + "' \n");
		sbSelSql.append("   AND A.SUBINV_CODE = '" + v_SubinvCode + "' \n");
		sbSelSql.append("   AND B.CANCEL_YN   = 'N' \n");

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
            out_vl.add("v_StockConfirm", "현창고는 재고 조사가 반영되어 본작업이 불가합니다!");
            this.setResultMessage(0, "OK", out_vl);
            proc_output(response, out, out_vl, out_dl);
            return;
        }

        int grpNo = 0;

        sbSelSql.delete(0, sbSelSql.length());
        sbSelSql.append("/* 재고실사 그룹키 생성 */ \n");
        sbSelSql.append( "SELECT FSP_PHYSICAL_INVENTORY_S.NEXTVAL AS GRP_NO FROM DUAL\n");
        pstmt = conn.prepareStatement(sbSelSql.toString());
        rs = pstmt.executeQuery();

        if( rs != null )
        {
            rs.next();
            grpNo = rs.getInt("GRP_NO");
        }

        rs.close();
        pstmt.close();

        sbInsSql.delete(0, sbInsSql.length());
        sbInsSql.append("/* 재고실사 등록 */ \n");
        sbInsSql.append("MERGE INTO FSP_PHYSICAL_INVENTORY_STOCK A \n");
        sbInsSql.append("USING ( SELECT ? AS PHYSIC_DATE \n");
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
        sbInsSql.append("   SET A.ONHAND_QTY      = B.ONHAND_QTY \n");
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
        sbInsSql.append("     , A.UPDATE_DATE     = B.UPDATE_DATE \n");
        sbInsSql.append("     , A.UPDATE_BY       = B.UPDATE_BY \n");
        sbInsSql.append("WHEN NOT MATCHED THEN \n");
        sbInsSql.append("INSERT \n");
        sbInsSql.append("( \n");
        sbInsSql.append("   A.PHYSIC_DATE \n");
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
        sbInsSql.append(" , A.CREATE_DATE \n");
        sbInsSql.append(" , A.CREATE_BY \n");
        sbInsSql.append(" , A.UPDATE_DATE \n");
        sbInsSql.append(" , A.UPDATE_BY \n");
        sbInsSql.append(") \n");
        sbInsSql.append("VALUES \n");
        sbInsSql.append("( \n");
        sbInsSql.append("   B.PHYSIC_DATE \n");
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
        sbInsSql.append(" , B.CREATE_DATE \n");
        sbInsSql.append(" , B.CREATE_BY \n");
        sbInsSql.append(" , B.UPDATE_DATE \n");
        sbInsSql.append(" , B.UPDATE_BY \n");
        sbInsSql.append(") \n");

        pstmt = conn.prepareStatement(sbInsSql.toString());

        int iPhysicCnt = 0;

        for( int i = 0; i < ds_stock.getRowCount(); i++ )
        {
			String ITEM_CODE			= nullToBlank(ds_stock.getString(i,"ITEM_CODE"));
			String UOM_CONVERT_RATE		= nullToZero(ds_stock.getString(i,"UOM_CONVERT_RATE"));
			String M_STK_QTY			= nullToZero(ds_stock.getString(i,"M_STK_QTY"));
			String M_STK_QTY_ORG		= nullToZero(ds_stock.getString(i,"M_STK_QTY_ORG"));
			String U_STK_PRICE			= nullToZero(ds_stock.getString(i,"U_STK_PRICE"));
			String M_STK_PRICE			= nullToZero(ds_stock.getString(i,"M_STK_PRICE"));
			String M_REAL_QTY			= nullToZero(ds_stock.getString(i,"M_REAL_QTY"));
			String M_USE_QTY			= nullToZero(ds_stock.getString(i,"M_USE_QTY"));
			String U_STK_AMT			= nullToZero(ds_stock.getString(i,"U_STK_AMT"));
			String M_STK_AMT			= nullToZero(ds_stock.getString(i,"M_STK_AMT"));
			String U_USE_AMT			= nullToZero(ds_stock.getString(i,"U_USE_AMT"));
			String M_USE_AMT			= nullToZero(ds_stock.getString(i,"M_USE_AMT"));
			String VALUE_DATE_INFO		= nullToBlank(ds_stock.getString(i,"VALUE_DATE_INFO"));
            String VALUE_DATE			= nullToBlank(ds_stock.getString(i,"VALUE_DATE"));
            String MAKER_DATE			= nullToBlank(ds_stock.getString(i,"MAKER_DATE"));
			String TAX_CODE				= nullToBlank(ds_stock.getString(i,"TAX_CODE"));

            double dblM_STK_QTY = 0;
            double dblM_STK_QTY_ORG = 0;
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

            dblM_STK_QTY		= Double.parseDouble(M_STK_QTY);
            dblM_STK_QTY_ORG	= Double.parseDouble(M_STK_QTY_ORG);
            dblU_STK_PRICE 		= Double.parseDouble(U_STK_PRICE);
            dblM_STK_PRICE 		= Double.parseDouble(M_STK_PRICE);
            dblM_REAL_QTY  		= Double.parseDouble(M_REAL_QTY);
			dblM_USE_QTY   		= Double.parseDouble(M_USE_QTY);

			// 재고량에 0인 데이터 제외
            if( dblM_STK_QTY == 0 )
            {
            	continue;	
            }

            if( v_chkPoUom.equals("Y") )
            {
                dblUOM_CONVERT_RATE = Double.parseDouble(UOM_CONVERT_RATE);
                dblONHAND_QTY = dblM_STK_QTY_ORG * dblUOM_CONVERT_RATE;
                dblUNIT_PRICE = dblU_STK_PRICE / dblUOM_CONVERT_RATE;
                dblMARGIN_PRICE = dblM_STK_PRICE / dblUOM_CONVERT_RATE;
                dblPHYSIC_QTY = dblM_REAL_QTY * dblUOM_CONVERT_RATE;
                // 실사량이 0 이면 반올림하지 않은 재고수량을 사용수량으로 한다.
                if( dblM_REAL_QTY == 0 )
                	dblLOSS_QTY = dblM_STK_QTY_ORG *  dblUOM_CONVERT_RATE;
                else
                	dblLOSS_QTY = dblM_USE_QTY *  dblUOM_CONVERT_RATE;
            }
            else
            {
                dblONHAND_QTY = dblM_STK_QTY_ORG;
                dblUNIT_PRICE = dblU_STK_PRICE;
                dblMARGIN_PRICE = dblM_STK_PRICE;
                dblPHYSIC_QTY = dblM_REAL_QTY;
                dblLOSS_QTY = dblM_USE_QTY;
            }

            if( TAX_CODE.equals("100") )
            {
                dblUNIT_VAT = 0.1 * dblUNIT_PRICE;
                dblMARGIN_VAT = 0.1 * dblMARGIN_PRICE;
            }
            else
            {
                dblUNIT_VAT = 0;
                dblMARGIN_VAT = 0;
            }
            
            pstmt.setString(1, sPhysic_date);
            pstmt.setString(2, v_SubinvCode);
            pstmt.setString(3, ITEM_CODE);
            pstmt.setString(4, Double.toString(dblONHAND_QTY));
            pstmt.setString(5, Double.toString(dblUNIT_PRICE));
            pstmt.setString(6, U_STK_AMT);
            pstmt.setString(7, Double.toString(dblMARGIN_PRICE));
            pstmt.setString(8, M_STK_AMT);
            pstmt.setString(9, Double.toString(dblPHYSIC_QTY));
            pstmt.setString(10, Double.toString(dblLOSS_QTY));
            pstmt.setString(11, U_USE_AMT);
            pstmt.setString(12, M_USE_AMT);
            pstmt.setString(13, VALUE_DATE_INFO);
            pstmt.setString(14, VALUE_DATE);
            pstmt.setString(15, MAKER_DATE);
            pstmt.setString(16, Integer.toString(grpNo));
            pstmt.setString(17, "N");
            pstmt.setString(18, v_trType);
            pstmt.setString(19, nullToBlank(g_EmpNo));
            pstmt.setString(20, nullToBlank(g_EmpNo));
            iPhysicCnt++;
            
            pstmt.executeUpdate();
        }

		pstmt.close();
		
        // 재고실사 P/S 호출
        if( v_trType.equals("I") && iPhysicCnt > 0 )
        {
            cstmt = conn.prepareCall( "{call EPROCUSR.PK_IF_FCUS_INSP_EXCUTE.PK_EXCUTE(?, ?, ?, ?)}" );

            cstmt.setString(1, Integer.toString(grpNo));
            cstmt.setString(2, g_EmpNo);
            cstmt.registerOutParameter(3, Types.VARCHAR);
            cstmt.registerOutParameter(4, Types.VARCHAR);

            cstmt.execute();

            if( nullToBlank(cstmt.getString(3)).equals("E") )
            {
                String strMsg = "";

                if( nullToBlank(cstmt.getString(4)).equals("") )
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

		// 재고실사 이력 등록
		if( v_trType.equals("I") )
		{
			sbInsSql.delete(0, sbInsSql.length());
			sbInsSql.append("/* 재고실사 이력 등록 */ \n");
			sbInsSql.append("INSERT INTO FSP_PHYSICAL_INVENTORY_HIS \n");
			sbInsSql.append("( \n");
			sbInsSql.append("   PHYSIC_DATE \n");
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
			sbInsSql.append(" , SYSDATE \n");
			sbInsSql.append(" , ? \n");
			sbInsSql.append(" , SYSDATE \n");
			sbInsSql.append(" , ? \n");
			sbInsSql.append(") \n");
	
			pstmt = conn.prepareStatement(sbInsSql.toString());
	
			for( int i = 0; i < ds_stock.getRowCount(); i++ )
			{
				String ITEM_CODE			= nullToBlank(ds_stock.getString(i,"ITEM_CODE"));
				String UOM_CONVERT_RATE		= nullToZero(ds_stock.getString(i,"UOM_CONVERT_RATE"));
				String M_STK_QTY			= nullToZero(ds_stock.getString(i,"M_STK_QTY"));
				String M_STK_QTY_ORG		= nullToZero(ds_stock.getString(i,"M_STK_QTY_ORG"));
				String U_STK_PRICE			= nullToZero(ds_stock.getString(i,"U_STK_PRICE"));
				String M_STK_PRICE			= nullToZero(ds_stock.getString(i,"M_STK_PRICE"));
				String M_REAL_QTY			= nullToZero(ds_stock.getString(i,"M_REAL_QTY"));
				String M_USE_QTY			= nullToZero(ds_stock.getString(i,"M_USE_QTY"));
				String U_STK_AMT			= nullToZero(ds_stock.getString(i,"U_STK_AMT"));
				String M_STK_AMT			= nullToZero(ds_stock.getString(i,"M_STK_AMT"));
				String U_USE_AMT			= nullToZero(ds_stock.getString(i,"U_USE_AMT"));
				String M_USE_AMT			= nullToZero(ds_stock.getString(i,"M_USE_AMT"));
				String VALUE_DATE_INFO		= nullToBlank(ds_stock.getString(i,"VALUE_DATE_INFO"));
				String VALUE_DATE			= nullToBlank(ds_stock.getString(i,"VALUE_DATE"));
				String MAKER_DATE			= nullToBlank(ds_stock.getString(i,"MAKER_DATE"));
				String TAX_CODE				= nullToBlank(ds_stock.getString(i,"TAX_CODE"));
				
				double dblM_STK_QTY = 0;
				double dblM_STK_QTY_ORG = 0;
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
				
				dblM_STK_QTY		= Double.parseDouble(M_STK_QTY);
				dblM_STK_QTY_ORG	= Double.parseDouble(M_STK_QTY_ORG);
				dblU_STK_PRICE 		= Double.parseDouble(U_STK_PRICE);
				dblM_STK_PRICE 		= Double.parseDouble(M_STK_PRICE);
				dblM_REAL_QTY  		= Double.parseDouble(M_REAL_QTY);
				dblM_USE_QTY   		= Double.parseDouble(M_USE_QTY);
				
				// 재고량에 0인 데이터 제외
				if( dblM_STK_QTY == 0 )
				{
					continue;	
				}
				
				if( v_chkPoUom.equals("Y") )
				{
					dblUOM_CONVERT_RATE = Double.parseDouble(UOM_CONVERT_RATE);
					dblONHAND_QTY = dblM_STK_QTY_ORG * dblUOM_CONVERT_RATE;
					dblUNIT_PRICE = dblU_STK_PRICE / dblUOM_CONVERT_RATE;
					dblMARGIN_PRICE = dblM_STK_PRICE / dblUOM_CONVERT_RATE;
					dblPHYSIC_QTY = dblM_REAL_QTY * dblUOM_CONVERT_RATE;
					// 실사량이 0 이면 반올림하지 않은 재고수량을 사용수량으로 한다.
					if( dblM_REAL_QTY == 0 )
						dblLOSS_QTY = dblM_STK_QTY_ORG *  dblUOM_CONVERT_RATE;
					else
						dblLOSS_QTY = dblM_USE_QTY *  dblUOM_CONVERT_RATE;
				}
				else
				{
					dblONHAND_QTY = dblM_STK_QTY_ORG;
					dblUNIT_PRICE = dblU_STK_PRICE;
					dblMARGIN_PRICE = dblM_STK_PRICE;
					dblPHYSIC_QTY = dblM_REAL_QTY;
					dblLOSS_QTY = dblM_USE_QTY;
				}
				if( TAX_CODE.equals("100") )
				{
					dblUNIT_VAT = 0.1 * dblUNIT_PRICE;
					dblMARGIN_VAT = 0.1 * dblMARGIN_PRICE;
				}
				else
				{
					dblUNIT_VAT = 0;
					dblMARGIN_VAT = 0;
				}
				         
				pstmt.setString(1, sPhysic_date);
				pstmt.setString(2, v_SubinvCode);
				pstmt.setString(3, ITEM_CODE);
				pstmt.setString(4, Double.toString(dblONHAND_QTY));
				pstmt.setString(5, Double.toString(dblUNIT_PRICE));
				pstmt.setString(6, U_STK_AMT);
				pstmt.setString(7, Double.toString(dblMARGIN_PRICE));
				pstmt.setString(8, M_STK_AMT);
				pstmt.setString(9, Double.toString(dblPHYSIC_QTY));
				pstmt.setString(10, Double.toString(dblLOSS_QTY));
				pstmt.setString(11, U_USE_AMT);
				pstmt.setString(12, M_USE_AMT);
				pstmt.setString(13, VALUE_DATE_INFO);
				pstmt.setString(14, VALUE_DATE);
				pstmt.setString(15, MAKER_DATE);
				pstmt.setString(16, Integer.toString(grpNo));
				pstmt.setString(17, "N");
				pstmt.setString(18, v_trType);
				pstmt.setString(19, nullToBlank(g_EmpNo));
				pstmt.setString(20, nullToBlank(g_EmpNo));
				         
				pstmt.executeUpdate();
			}
	
			pstmt.close();
		}

		conn.commit();
		this.setResultMessage(0, "OK", out_vl);
    }
    catch( Exception ex )
    {
        conn.rollback();

        //jsp 로그남기기
        logger.debug(ex.getMessage(), ex);
        this.setResultMessage(-1, ex.toString(),out_vl);
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
        if( cstmt != null )
        {
            try {
                cstmt.close();
            } catch( Exception e ) {}
        }
        if( conn != null )
        {
            try {
                conn.close();
            } catch( Exception e ) {}
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