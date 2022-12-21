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

		String v_Upjang			= nullToBlank(in_vl.getString("v_Upjang"));
		String v_SubinvCode		= nullToBlank(in_vl.getString("v_SubinvCode"));
		String v_Date			= nullToBlank(in_vl.getString("v_Date"));
		String v_chkPoUom		= nullToBlank(in_vl.getString("v_chkPoUom"));
		String v_chkPhysicQty	= nullToBlank(in_vl.getString("v_chkPhysicQty"));
		String v_chkAmt			= nullToBlank(in_vl.getString("v_chkAmt"));
		String v_MenuQty		= nullToBlank(in_vl.getString("v_MenuQty"));
		String g_EmpNo			= nullToBlank(in_vl.getString("g_EmpNo"));
		
		String sPhysic_date			= "";
		String sPhysic_before_date	= "";
		String sOnhandMonth			= "000101";
		String sPhysic_month		= "";

		DataSet ds_po, ds_stock;

		StringBuffer sbSelSql = new StringBuffer();

		// 재고조사일과 현재일을 비교해서 현재일보다 크면 리턴
		sbSelSql.delete(0, sbSelSql.length());
		sbSelSql.append("SELECT TO_CHAR(SYSDATE, 'YYYYMM') AS TO_MONTH \n");
		sbSelSql.append("     , TO_CHAR(SYSDATE, 'YYYYMMDD') AS TO_DATE \n");
		sbSelSql.append("  FROM DUAL \n");
		pstmt = conn.prepareStatement(sbSelSql.toString());
		rs = pstmt.executeQuery();
		rs.next();

		sPhysic_month = rs.getString("TO_MONTH");

		if( Integer.parseInt(rs.getString("TO_DATE")) < Integer.parseInt(v_Date) )
		{	
			out_vl.add("v_ChkDate", "재고 조사일은 현재일보다 작거나 같아야 합니다.");
		   	this.setResultMessage(0, "OK", out_vl);
		   	proc_output(response, out, out_vl, out_dl);
		   	return;
		}

		rs.close();
		pstmt.close();

		sPhysic_date = v_Date;
		sPhysic_before_date = sPhysic_date;

		sbSelSql.delete(0, sbSelSql.length());
		sbSelSql.append("/* 일마감여부 확인 */ \n");
		sbSelSql.append("SELECT 1 \n");
		sbSelSql.append("  FROM MAS_CLOSE_MGMT \n");
		sbSelSql.append(" WHERE UPJANG      = (SELECT UPJANG FROM HLDC_PO_SUBINVENTORY WHERE SUBINV_CODE = '" + v_SubinvCode + "') \n");
		sbSelSql.append("   AND CLOSE_GUBUN = '004' \n");	// 일마감구분 - 재고마감
		sbSelSql.append("   AND CLOSE_DATE  = '" + sPhysic_date + "' \n");

		pstmt = conn.prepareStatement(sbSelSql.toString());
		rs = pstmt.executeQuery();

		if( rs.next() )
		{
			out_vl.add("v_StockClose", "재고마감되어 등록할 수 없습니다.\n재고마감관리자에게 연락하세요.");
		   	this.setResultMessage(0, "OK", out_vl);
		   	proc_output(response, out, out_vl, out_dl);
		   	return;
		}

		rs.close();
		pstmt.close();

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

/*
		sbSelSql.delete(0, sbSelSql.length());
		sbSelSql.append("\n");
		sbSelSql.append("SELECT TO_CHAR(TO_DATE(A.PHYSIC_DATE, 'YYYYMMDD'), 'YYYY\"년\"MM\"월\"DD\"일\"') AS PHYSIC_DATE \n");
		sbSelSql.append("  FROM HLDC_PO_PHYSICAL_INVENTORY A \n");
		sbSelSql.append("     , ( \n");
		sbSelSql.append("         SELECT PHYSIC_ID \n");
		sbSelSql.append("           FROM HLDC_PO_PHYSICAL_INVENTORY \n");
		sbSelSql.append("          WHERE SUBINV_CODE = '" + v_SubinvCode + "' \n");
		sbSelSql.append("          GROUP BY PHYSIC_ID, PHYSIC_DATE \n");
		sbSelSql.append("          HAVING COUNT(1) = 1 \n");
		sbSelSql.append("       ) B \n");
		sbSelSql.append(" WHERE A.PHYSIC_ID = B.PHYSIC_ID \n");
		sbSelSql.append("   AND A.PHYSIC_DATE BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE('" + sOnhandMonth + "', 'YYYYMM'), 1), 'YYYYMM') || '01' AND TO_CHAR(TO_DATE('" + sPhysic_date + "', 'YYYYMMDD'), 'YYYYMMDD') \n");
		sbSelSql.append("   AND A.SUBINV_CODE = '" + v_SubinvCode + "' \n");
		sbSelSql.append("   AND A.CANCEL_YN = 'Y' \n");
		sbSqlSql.append(" ORDER BY PHYSIC_DATE \n");

		pstmt = conn.prepareStatement(sbSelSql.toString());
		rs = pstmt.executeQuery();

		if(rs.next())
		{
			out_vl.add("v_NoStockConfirm", rs.getString("PHYSIC_DATE") + "일 재고반영이 이루어 지지 않았습니다.\n" + rs.getString("PHYSIC_DATE") + "일자의 재고반영을 하시기 바랍니다.");
		  	this.setResultMessage(0, "OK", out_vl);
		   	proc_output(response, out, out_vl, out_dl);
		   	return;
		}
*/


		sbSelSql.delete(0, sbSelSql.length());
		sbSelSql.append("/* 전일 반영된 유통기한과 비고, 제조일자를 가져오기 위한 최종일 가져오기 */ \n");
		sbSelSql.append("SELECT MAX(PHYSIC_DATE) AS PHYSIC_DATE \n");
		sbSelSql.append("  FROM FSP_PHYSICAL_INVENTORY_STOCK \n");
		sbSelSql.append(" WHERE SUBINV_CODE = '" + v_SubinvCode + "' \n");
		sbSelSql.append("   AND PHYSIC_DATE BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE('" + sOnhandMonth + "', 'YYYYMM'), 1), 'YYYYMM') || '01' AND '" + sPhysic_date + "' \n");

		pstmt = conn.prepareStatement(sbSelSql.toString());
		rs = pstmt.executeQuery();

		if( rs.next() )	sPhysic_before_date = rs.getString("PHYSIC_DATE");

		rs.close();
		pstmt.close();

		sbSelSql.delete(0, sbSelSql.length());
		sbSelSql.append("/* 전일 재고조사여부 확인 */ \n");
		sbSelSql.append("SELECT DECODE(COUNT(1), 0, 'N', 'Y') AS STOCK_YN \n");
		sbSelSql.append("  FROM HLDC_PO_PHYSICAL_INVENTORY A \n");
		sbSelSql.append("     , (SELECT DISTINCT A.* \n");
		sbSelSql.append("          FROM HLDC_PO_PHYSICAL_INVENTORY A \n");
		sbSelSql.append("             , (SELECT ITEM_CODE AS ITEM_CODE \n");
		sbSelSql.append("                     , MAX(UPDATE_DATE) AS UPDATE_DATE \n");
		sbSelSql.append("                  FROM HLDC_PO_PHYSICAL_INVENTORY \n");
		sbSelSql.append("                 WHERE PHYSIC_DATE = TO_CHAR(TO_DATE('" + sPhysic_date + "', 'YYYYMMDD') - 1, 'YYYYMMDD') \n");
		sbSelSql.append("                   AND SUBINV_CODE = '" + v_SubinvCode + "' \n");
		sbSelSql.append("                 GROUP BY ITEM_CODE) B \n");
		sbSelSql.append("         WHERE A.ITEM_CODE   = B.ITEM_CODE \n");
		sbSelSql.append("           AND A.UPDATE_DATE = B.UPDATE_DATE \n");
		sbSelSql.append("           AND A.PHYSIC_DATE = TO_CHAR(TO_DATE('" + sPhysic_date + "', 'YYYYMMDD') - 1, 'YYYYMMDD') \n");
		sbSelSql.append("           AND A.SUBINV_CODE = '" + v_SubinvCode + "' \n");
		sbSelSql.append("       ) B \n");
		sbSelSql.append(" WHERE A.PHYSIC_ID   = B.PHYSIC_ID \n");
		sbSelSql.append("   AND A.ITEM_CODE   = B.ITEM_CODE \n");
		sbSelSql.append("   AND A.PHYSIC_DATE = TO_CHAR(TO_DATE('" + sPhysic_date + "', 'YYYYMMDD') - 1, 'YYYYMMDD') \n");
		sbSelSql.append("   AND A.SUBINV_CODE = '" + v_SubinvCode + "' \n");
		sbSelSql.append("   AND B.CANCEL_YN   = 'N' \n");

		pstmt = conn.prepareStatement(sbSelSql.toString());
		rs = pstmt.executeQuery();
		rs.next();

		if( rs.getString("STOCK_YN").equals("N") )
		{
			out_vl.add("v_PreStock", "전일 재고조사가 이루어 지지 않았습니다.\n먼저 전일자의 재고조사를 하시기 바랍니다.");
		   	this.setResultMessage(0, "OK", out_vl);
		}

		rs.close();
		pstmt.close();

		sbSelSql.delete(0, sbSelSql.length());
		sbSelSql.append("/* 수불마감 확인 */ \n");
		sbSelSql.append("SELECT TO_CHAR(TO_DATE(A.CLS_YM,'YYYYMM'),'YYYY\"년\"MM\"월\"') AS CLS_YYYYMM \n");
		sbSelSql.append("  FROM HLDC_PO_CLOSING A \n");
		sbSelSql.append(" WHERE A.CLS_YM      >= SUBSTR('" + sPhysic_date + "', 1, 6) \n");
		sbSelSql.append("   AND A.SUBINV_CODE  = '" + v_SubinvCode + "' \n");
		sbSelSql.append("   AND A.CLS_FLAG     = 'Y' \n");
		sbSelSql.append("ORDER BY TO_NUMBER(A.CLS_YM) DESC \n");

		pstmt = conn.prepareStatement(sbSelSql.toString());
		rs = pstmt.executeQuery();

		if( rs.next() )
		{
			out_vl.add("v_SubulClose", "현창고는 수불마감(" + rs.getString("CLS_YYYYMM") + ")이 \n완료되어 본작업이 불가합니다!");
		   	this.setResultMessage(0, "OK", out_vl);
		   	proc_output(response, out, out_vl, out_dl);
		   	return;
		}

		rs.close();
		pstmt.close();

		sbSelSql.delete(0, sbSelSql.length());
		sbSelSql.append("/* 해당 기간 이후 재고조사가 존재하는지 체크 */ \n");
		sbSelSql.append("SELECT TO_CHAR(TO_DATE(A.PHYSIC_DATE, 'YYYYMMDD'), 'YYYY\"년\"MM\"월\"DD\"일\"') AS PHYSIC_DATE \n");
		sbSelSql.append("  FROM HLDC_PO_PHYSICAL_INVENTORY A \n");
		sbSelSql.append("      , ( SELECT DISTINCT A.* \n");
		sbSelSql.append("            FROM HLDC_PO_PHYSICAL_INVENTORY A \n");
		sbSelSql.append("               , ( SELECT PHYSIC_DATE AS PHYSIC_DATE \n");
		sbSelSql.append("                        , ITEM_CODE AS ITEM_CODE \n");
		sbSelSql.append("                        , MAX(UPDATE_DATE) AS UPDATE_DATE \n");
		sbSelSql.append("                     FROM HLDC_PO_PHYSICAL_INVENTORY \n");
		sbSelSql.append("                    WHERE PHYSIC_DATE >= '" + sPhysic_date + "' \n");
		sbSelSql.append("                      AND SUBINV_CODE  = '" + v_SubinvCode + "' \n");
		sbSelSql.append("                    GROUP BY PHYSIC_DATE, ITEM_CODE \n");
		sbSelSql.append("                 ) B \n");
		sbSelSql.append("           WHERE A.PHYSIC_DATE  = B.PHYSIC_DATE \n");
		sbSelSql.append("             AND A.ITEM_CODE    = B.ITEM_CODE \n");
		sbSelSql.append("             AND A.UPDATE_DATE  = B.UPDATE_DATE \n");
		sbSelSql.append("             AND A.PHYSIC_DATE >= '" + sPhysic_date + "' \n");
		sbSelSql.append("             AND A.SUBINV_CODE  = '" + v_SubinvCode + "' \n");
		sbSelSql.append("        ) B \n");
		sbSelSql.append(" WHERE A.PHYSIC_ID    = B.PHYSIC_ID \n");
		sbSelSql.append("   AND A.ITEM_CODE    = B.ITEM_CODE \n");
		sbSelSql.append("   AND A.PHYSIC_DATE >= '" + sPhysic_date + "' \n");
		sbSelSql.append("   AND A.SUBINV_CODE  = '" + v_SubinvCode + "' \n");
		sbSelSql.append("   AND B.CANCEL_YN    = 'N' \n");
		sbSelSql.append(" ORDER BY PHYSIC_DATE DESC \n");
		
		pstmt = conn.prepareStatement(sbSelSql.toString());
		rs = pstmt.executeQuery();

		if( rs.next() )
		{
			out_vl.add("v_StockConfirm", "현창고는 재고조사(" + rs.getString("PHYSIC_DATE") + ")가\n 반영되어 본작업이 불가합니다!");
		   	this.setResultMessage(0, "OK", out_vl);
		   	proc_output(response, out, out_vl, out_dl);
		   	return;
		}
		//속도개선 뷰해체 20170704 김호석 
		sbSelSql.delete(0, sbSelSql.length());
		sbSelSql.append("/* 미입고 내역 확인 */ \n");
		sbSelSql.append(" SELECT COUNT(*) AS CNT \n");
		sbSelSql.append(" FROM ( \n");
		sbSelSql.append(" SELECT /*+ INDEX_DESC(PODT) */ \n");
		sbSelSql.append("        PODT.WH_CD               AS SUBINV_CODE  -- 입고창고 코드  \n");
		sbSelSql.append("      , PODT.SHOP_CD             AS RC_UPJANG   -- 입고업장 코드 \n");     
		sbSelSql.append("      , PODT.GR_REQ_DATE                AS NEED_DATE -- 입고희망일자 \n");
		sbSelSql.append("      , NVL(CASE WHEN POHD.PO_TYP = 'BP' THEN \n");
		sbSelSql.append("              CASE \n");
		sbSelSql.append("                WHEN PODT.GR_COMP_YN='N' AND POHD.APRV_STS = 'T'         THEN 'RW' --통합영업에서 뷰 불가 \n");
		sbSelSql.append("                WHEN PODT.GR_COMP_YN='N' AND POHD.APRV_STS = 'P'         THEN 'PW' \n");
		sbSelSql.append("                WHEN PODT.GR_COMP_YN='N' AND POHD.APRV_STS IN ('R', 'W') THEN 'PD' \n");
		sbSelSql.append("                WHEN PODT.GR_COMP_YN='N' AND POHD.APRV_STS = 'B'         THEN 'PD' \n");
		sbSelSql.append("                WHEN PODT.GR_COMP_YN='Y' AND POHD.APRV_STS = 'B'         THEN 'GC' \n");
		sbSelSql.append("                WHEN PODT.GR_COMP_YN='Y' AND POHD.APRV_STS IN ('C', 'K') THEN 'GC' \n");
		sbSelSql.append("              END \n");
		sbSelSql.append("           ELSE DECODE(PODT.GR_COMP_YN, 'Y', 'GC', NVL(PRDT.PR_PROG_STS,'PC')) \n");
		sbSelSql.append("        END,'PC') AS LINE_STATUS  -- 라인 상태 코드 \n");
		sbSelSql.append("      , PODT.GR_COMP_YN \n");
		sbSelSql.append("   FROM EPROCUSR.ESPPOHD POHD   -- PO 헤더 \n");
		sbSelSql.append("      , EPROCUSR.ESPPODT PODT   -- PO 상세(품목) \n");
		sbSelSql.append("      , EPROCUSR.ESPPRDT PRDT   -- PR 상세(품목) \n");
		sbSelSql.append("  WHERE PODT.SYS_ID  = POHD.SYS_ID (+) \n");
		sbSelSql.append("    AND PODT.COMP_CD = POHD.COMP_CD(+) \n");
		sbSelSql.append("    AND PODT.PO_NO   = POHD.PO_NO  (+) \n");
		sbSelSql.append("    AND PODT.PR_NO   = PRDT.PR_NO(+) \n");
		sbSelSql.append("    AND PODT.PR_LNO  = PRDT.PR_LNO(+) \n");
		sbSelSql.append("    AND PODT.SYS_ID  = PRDT.SYS_ID(+) \n");
		sbSelSql.append("    AND PODT.COMP_CD = PRDT.COMP_CD(+) \n");
		sbSelSql.append("    AND PODT.SHOP_TYP_CD <> '02' \n");
		sbSelSql.append("    AND PODT.SYS_ID  = '100' \n");
		sbSelSql.append("    AND PODT.COMP_CD = 'HFC' \n");
		sbSelSql.append("    -- AND POHD.STS    <> 'D' \n");
		sbSelSql.append("    AND PODT.STS    <> 'D' \n");
		sbSelSql.append("    AND PRDT.STS    <> 'D' \n");
		sbSelSql.append("    --AND PODT.REQ_SYS_CD = 'FR' \n");
		sbSelSql.append("  )  \n");
		//sbSelSql.append("SELECT COUNT(1) AS CNT \n");
		//sbSelSql.append("  FROM HLDC_PO_PO \n");
		sbSelSql.append(" WHERE RC_UPJANG   = TO_CHAR(" + v_Upjang + ") \n");
		sbSelSql.append("   AND SUBINV_CODE = '" + v_SubinvCode + "' \n");
		sbSelSql.append("   AND LINE_STATUS IN ('PC', 'DL') \n");
		sbSelSql.append("   AND NEED_DATE  <= '" + v_Date + "' \n");
		//속도개선 적용 최근 3달전 이후로 검색 추가 2017.09.05 김호석
		sbSelSql.append("   AND NEED_DATE  >= TO_CHAR(SYSDATE-90, 'YYYYMMDD') \n");
		sbSelSql.append("   AND ROWNUM  <= 1 \n");

		pstmt = conn.prepareStatement(sbSelSql.toString());
		rs = pstmt.executeQuery();
		rs.next();

		int cnt = rs.getInt("CNT");

		rs.close();
		pstmt.close();

		if( cnt > 0 )
		{
			sbSelSql.delete(0, sbSelSql.length());
			//속도개선 뷰해체 20170704 김호석 
			sbSelSql.append("/* 미입고 내역 조회 */ \n");
			sbSelSql.append("SELECT A.NEED_DATE \n");
			sbSelSql.append("     , A.ITEM_CODE || ' ' || A.ITEM_NAME AS ITEM_NAME \n");
			sbSelSql.append("     , (A.CENTER_DELI_QTY + A.DIRECT_DELI_QTY) AS ORDER_QTY \n");
			sbSelSql.append("     , A.DELIVERED_QTY \n");
			sbSelSql.append("     , A.UNDELIVERED_QTY \n");
			sbSelSql.append("     , (A.CENTER_DELI_QTY + A.DIRECT_DELI_QTY - A.DELIVERED_QTY - A.UNDELIVERED_QTY) AS NONE_QTY \n");
			//sbSelSql.append("  FROM HLDC_PO_PO A \n");
			sbSelSql.append(" FROM ( \n");
			sbSelSql.append(" SELECT /*+ INDEX_DESC(PODT) */ \n");
			sbSelSql.append("        PODT.WH_CD               AS SUBINV_CODE  -- 입고창고 코드  \n");
			sbSelSql.append(" 	   , PODT.ITEM_CD             AS ITEM_CODE   -- 자재코드 \n");
			sbSelSql.append("	   , MTGL.ITEM_NM             AS ITEM_NAME   -- 자재명 \n");
			sbSelSql.append("      , CASE WHEN PODT.PROC_TYP_CD IN('DC', 'TC') THEN PODT.ITEM_QTY ELSE 0 END  AS CENTER_DELI_QTY  -- 센터입고수량 \n");		     
			sbSelSql.append("      , CASE PODT.PROC_TYP_CD WHEN 'VC' THEN PODT.ITEM_QTY ELSE 0 END  AS DIRECT_DELI_QTY  -- 직송 수량  \n");
			sbSelSql.append("	   , CASE PODT.PROC_TYP_CD WHEN 'VC' THEN NVL(PODT.GR_QTY,0) ELSE NVL(PODT.GR_QTY_WMS,0) END  AS DELIVERED_QTY    --업장입고수량(센터출고) \n");
			sbSelSql.append("	   , CASE \n");
			sbSelSql.append("         WHEN PODT.PO_COMP_YN='Y' OR PODT.GR_COMP_YN='Y' THEN NVL(PODT.ITEM_QTY,0) - NVL(PODT.GR_QTY,0) -- 입고완료 \n");
			sbSelSql.append("         ELSE 0 \n");
			sbSelSql.append("       END AS UNDELIVERED_QTY -- 감량수량 \n");
			sbSelSql.append("      , PODT.SHOP_CD             AS RC_UPJANG   -- 입고업장 코드 \n");     
			sbSelSql.append("      , PODT.GR_REQ_DATE                AS NEED_DATE -- 입고희망일자 \n");
			sbSelSql.append("      , NVL(CASE WHEN POHD.PO_TYP = 'BP' THEN \n");
			sbSelSql.append("              CASE \n");
			sbSelSql.append("                WHEN PODT.GR_COMP_YN='N' AND POHD.APRV_STS = 'T'         THEN 'RW' --통합영업에서 뷰 불가 \n");
			sbSelSql.append("                WHEN PODT.GR_COMP_YN='N' AND POHD.APRV_STS = 'P'         THEN 'PW' \n");
			sbSelSql.append("                WHEN PODT.GR_COMP_YN='N' AND POHD.APRV_STS IN ('R', 'W') THEN 'PD' \n");
			sbSelSql.append("                WHEN PODT.GR_COMP_YN='N' AND POHD.APRV_STS = 'B'         THEN 'PD' \n");
			sbSelSql.append("                WHEN PODT.GR_COMP_YN='Y' AND POHD.APRV_STS = 'B'         THEN 'GC' \n");
			sbSelSql.append("                WHEN PODT.GR_COMP_YN='Y' AND POHD.APRV_STS IN ('C', 'K') THEN 'GC' \n");
			sbSelSql.append("              END \n");
			sbSelSql.append("           ELSE DECODE(PODT.GR_COMP_YN, 'Y', 'GC', NVL(PRDT.PR_PROG_STS,'PC')) \n");
			sbSelSql.append("        END,'PC') AS LINE_STATUS  -- 라인 상태 코드 \n");
			sbSelSql.append("      , PODT.GR_COMP_YN \n");
			sbSelSql.append("   FROM EPROCUSR.ESPPOHD POHD   -- PO 헤더 \n");
			sbSelSql.append("      , EPROCUSR.ESPPODT PODT   -- PO 상세(품목) \n");
			sbSelSql.append("      , EPROCUSR.ESPPRDT PRDT   -- PR 상세(품목) \n");
			sbSelSql.append("      , EPROCUSR.ESMMTGL MTGL   -- 자재마스터 \n");
			sbSelSql.append("  WHERE PODT.SYS_ID  = POHD.SYS_ID (+) \n");
			sbSelSql.append("    AND PODT.COMP_CD = POHD.COMP_CD(+) \n");
			sbSelSql.append("    AND PODT.PO_NO   = POHD.PO_NO  (+) \n");
			sbSelSql.append("    AND PODT.PR_NO   = PRDT.PR_NO(+) \n");
			sbSelSql.append("	 AND PODT.SYS_ID  = MTGL.SYS_ID \n");
			sbSelSql.append("	 AND PODT.ITEM_CD = MTGL.ITEM_CD \n");
			sbSelSql.append("    AND PODT.PR_LNO  = PRDT.PR_LNO(+) \n");
			sbSelSql.append("    AND PODT.SYS_ID  = PRDT.SYS_ID(+) \n");
			sbSelSql.append("    AND PODT.COMP_CD = PRDT.COMP_CD(+) \n");
			sbSelSql.append("    AND PODT.SHOP_TYP_CD <> '02' \n");
			sbSelSql.append("    AND PODT.SYS_ID  = '100' \n");
			sbSelSql.append("    AND PODT.COMP_CD = 'HFC' \n");
			sbSelSql.append("    -- AND POHD.STS    <> 'D' \n");
			sbSelSql.append("    AND PODT.STS    <> 'D' \n");
			sbSelSql.append("    AND PRDT.STS    <> 'D' \n");
			sbSelSql.append("    --AND PODT.REQ_SYS_CD = 'FR' \n");
			sbSelSql.append("  ) A  \n");
			sbSelSql.append(" WHERE A.NEED_DATE  <= '" + v_Date + "' \n");
			sbSelSql.append("   AND A.RC_UPJANG   = To_CHAR(" + v_Upjang + ") \n");
			sbSelSql.append("   AND A.SUBINV_CODE = '" + v_SubinvCode + "' \n");
			sbSelSql.append("   AND A.LINE_STATUS IN ('PC', 'DL') \n");
			//sbSelSql.append("   AND ABS(A.CENTER_DELI_QTY + A.DIRECT_DELI_QTY) - ABS(A.DELIVERED_QTY + A.UNDELIVERED_QTY) > 0 \n");
			sbSelSql.append(" ORDER BY 1, 2 \n");

			pstmt = conn.prepareStatement(sbSelSql.toString());
			rs = pstmt.executeQuery();
			ds_po = this.makeDataSet(rs, "ds_po");
			out_dl.add(ds_po);
		   	proc_output(response, out, out_vl, out_dl);
		   	return;
		}

		sbSelSql.delete(0, sbSelSql.length());
		sbSelSql.append("SELECT COUNT(1) AS CNT \n");
		sbSelSql.append("  FROM PO_CLAIM_LIST \n");
		sbSelSql.append(" WHERE NEED_DATE <= '" + v_Date + "' \n");
		sbSelSql.append("   AND UPJANG = " + v_Upjang + " \n");
		sbSelSql.append("   AND SUBINV_CODE = '" + v_SubinvCode + "' \n");
		sbSelSql.append("   AND REQ_KIND IN ('C0201','C0202','C0205') -- 반품(실물X),반품(실물O),교환현지구매-사업장 \n");
		sbSelSql.append("   AND PRCS_STATUS <> '09' -- 처리완료가 아닌건 \n");		

		pstmt = conn.prepareStatement(sbSelSql.toString());
		rs = pstmt.executeQuery();
		rs.next();
		
		cnt = rs.getInt("CNT");

		rs.close();
		pstmt.close();

		if( cnt > 0 )
		{
			out_vl.add("v_Claim", "클레임 처리 중인 건이 존재합니다.\n처리 후 재고조사를 하시기 바랍니다.");
		   	this.setResultMessage(0, "OK", out_vl);
		   	proc_output(response, out, out_vl, out_dl);
		   	return;
		}

		sbSelSql.delete(0, sbSelSql.length());
		sbSelSql.append("/* 재고내역 조회 */ \n");
		sbSelSql.append("SELECT A.* \n");
		sbSelSql.append("FROM ( \n");
		sbSelSql.append("SELECT C.CLASS_NAME AS L_CLASS_NAME \n");
		sbSelSql.append("     , D.CLASS_NAME AS M_CLASS_NAME \n");
		sbSelSql.append("     , C.CLASS_CODE AS L_CLASS_CODE \n");
		sbSelSql.append("     , D.CLASS_CODE AS M_CLASS_CODE \n");
		sbSelSql.append("     , A.ITEM_CODE AS ITEM_CODE \n");
		sbSelSql.append("     , A.BARCODE AS BARCODE \n");
		sbSelSql.append("     , A.ITEM_NAME AS ITEM_NAME \n");
		sbSelSql.append("     , A.ITEM_SIZE AS ITEM_SIZE \n");
		sbSelSql.append("     , A.UOM_CODE AS UOM_CODE \n");
		sbSelSql.append("     , A.PO_UOM AS PO_UOM \n");
		// 수불단위, 재고량!=실사량
		if( v_chkPoUom.equals("N") && v_chkPhysicQty.equals("N") ) // 구매단위==N && 실사량=재고량설정==N
		{
			sbSelSql.append("     , DECODE(B.UNIT_QTY, 0, 0, ROUND(B.MARGIN_AMT / B.UNIT_QTY, 5)) AS M_STK_PRICE     -- 재고단가    (출하)(수불:재고량!=실사량) \n");
			sbSelSql.append("     , B.TRANS_QTY AS M_STK_QTY                                                         -- 재고량            (수불:재고량!=실사량) \n");
			sbSelSql.append("     , B.TRANS_QTY AS M_STK_QTY_ORG                                                     -- 재고량 반올림 미처리 (수불:재고량!=실사량) \n");
			sbSelSql.append("     , B.TRANS_MAMT AS M_STK_AMT                                                        -- 재고금액    (출하)(수불:재고량!=실사량) \n");
			sbSelSql.append("     , '0' AS M_REAL_QTY                                                                -- 실사재고량 STRING (수불:재고량!=실사량) \n");
			sbSelSql.append("     , 0 AS M_REAL_QTY_SUM                                                              -- 실사재고량 NUMBER (수불:재고량!=실사량) \n");
			sbSelSql.append("     , 0 AS M_REAL_AMT                                                                  -- 실사재고금액(출하)(수불:재고량!=실사량) \n");
			sbSelSql.append("     , B.TRANS_QTY AS M_USE_QTY                                                         -- 사용량            (수불:재고량!=실사량) \n");
			sbSelSql.append("     , B.TRANS_MAMT AS M_USE_AMT                                                        -- 사용금액    (출하)(수불:재고량!=실사량) \n");
			sbSelSql.append("     , DECODE(B.UNIT_QTY, 0, 0, ROUND(B.UNIT_AMT / B.UNIT_QTY, 5)) AS U_STK_PRICE       -- 재고단가    (매입)(수불:재고량!=실사량) \n");
			sbSelSql.append("     , B.TRANS_UAMT AS U_STK_AMT                                                        -- 재고금액    (매입)(수불:재고량!=실사량) \n");
			sbSelSql.append("     , 0 AS U_REAL_AMT                                                                  -- 실사금액    (매입)(수불:재고량!=실사량) \n");
			sbSelSql.append("     , B.TRANS_UAMT AS U_USE_AMT                                                        -- 사용금액    (매입)(수불:재고량!=실사량) \n");
			sbSelSql.append("     , NVL(E.ADV_PHYSIC_QTY ,0) ADV_PHYSIC_QTY                                          -- 사전 재고 조사량  \n");
			sbSelSql.append("     , UOM_QTY AS MENU_QTY                                                              -- 식단예상사용량(수불) \n");
		}
		// 구매단위, 재고량!=실사량
		else if( v_chkPoUom.equals("Y") && v_chkPhysicQty.equals("N") ) // 구매단위==Y && 실사량=재고량설정==N
		{
			sbSelSql.append("     , DECODE(B.UNIT_QTY, 0, 0, ROUND(B.MARGIN_AMT / (B.UNIT_QTY / A.UOM_CONVERT_RATE), 5)) AS M_STK_PRICE  -- 재고단가    (출하)(구매:재고량!=실사량) \n");
			sbSelSql.append("     , ROUND(B.TRANS_QTY / A.UOM_CONVERT_RATE, 5) AS M_STK_QTY                                              -- 재고량            (구매:재고량!=실사량) \n");
			sbSelSql.append("     , B.TRANS_QTY / A.UOM_CONVERT_RATE AS M_STK_QTY_ORG                                                    -- 재고량 반올림 미처리 (구매:재고량!=실사량) \n");
			sbSelSql.append("     , B.TRANS_MAMT AS M_STK_AMT                                                                            -- 재고금액    (출하)(구매:재고량!=실사량) \n");
			sbSelSql.append("     , '0' AS M_REAL_QTY                                                                                    -- 실사재고량 STRING (수불:재고량!=실사량) \n");
			sbSelSql.append("     , 0 AS M_REAL_QTY_SUM                                                                                  -- 실사재고량 NUMBER (수불:재고량!=실사량) \n");
			sbSelSql.append("     , 0 AS M_REAL_AMT                                                                                      -- 실사재고금액(출하)(구매:재고량!=실사량) \n");
			sbSelSql.append("     , ROUND(B.TRANS_QTY / A.UOM_CONVERT_RATE, 5) AS M_USE_QTY                                              -- 사용량            (구매:재고량!=실사량) \n");
			sbSelSql.append("     , B.TRANS_MAMT AS M_USE_AMT                                                                            -- 사용금액    (출하)(구매:재고량!=실사량) \n");
			sbSelSql.append("     , DECODE(B.UNIT_QTY, 0, 0, ROUND(B.UNIT_AMT / (B.UNIT_QTY / A.UOM_CONVERT_RATE), 5)) AS U_STK_PRICE    -- 재고단가    (매입)(구매:재고량!=실사량) \n");
			sbSelSql.append("     , B.TRANS_UAMT AS U_STK_AMT                                                                            -- 재고금액    (매입)(구매:재고량!=실사량) \n");
			sbSelSql.append("     , 0 AS U_REAL_AMT                                                                                      -- 실사금액    (매입)(구매:재고량!=실사량) \n");
			sbSelSql.append("     , B.TRANS_UAMT AS U_USE_AMT                                                                            -- 사용금액    (매입)(구매:재고량!=실사량) \n");
			sbSelSql.append("     , NVL(ROUND(E.ADV_PHYSIC_QTY/A.UOM_CONVERT_RATE, 5), 0) ADV_PHYSIC_QTY                                 -- 사전 재고 조사량  \n");
			sbSelSql.append("     , PO_QTY AS MENU_QTY                                                                                   -- 식단예상사용량(구매) \n");
		}
		// 수불단위, 재고량=실사량
		else if( v_chkPoUom.equals("N") && v_chkPhysicQty.equals("Y") ) // 구매단위==N && 실사량=재고량설정==Y
		{
			sbSelSql.append("     , DECODE(B.UNIT_QTY, 0, 0, ROUND(B.MARGIN_AMT / B.UNIT_QTY, 5)) AS M_STK_PRICE  -- 재고단가    (출하)(수불:재고량=실사량) \n");
			sbSelSql.append("     , B.TRANS_QTY AS M_STK_QTY                                                      -- 재고량 반올림 미처리 (구매:재고량!=실사량) \n");
			sbSelSql.append("     , B.TRANS_MAMT AS M_STK_AMT                                                     -- 재고금액    (출하)(수불:재고량=실사량) \n");
			sbSelSql.append("     , TO_CHAR(DECODE(SIGN(B.TRANS_QTY), -1, 0, B.TRANS_QTY)) AS M_REAL_QTY          -- 실사재고량 STRING (수불:재고량=실사량) \n");
			sbSelSql.append("     , DECODE(SIGN(B.TRANS_QTY), -1, 0, B.TRANS_QTY) AS M_REAL_QTY_SUM               -- 실사재고량 NUMBER (수불:재고량=실사량) \n");
			sbSelSql.append("     , DECODE(SIGN(B.TRANS_QTY), -1, 0, B.TRANS_MAMT) AS M_REAL_AMT                  -- 실사재고금액(출하)(수불:재고량=실사량) \n");
			sbSelSql.append("     , DECODE(SIGN(B.TRANS_QTY), -1, B.TRANS_QTY, 0) AS M_USE_QTY                    -- 사용량            (수불:재고량=실사량) \n");
			sbSelSql.append("     , DECODE(SIGN(B.TRANS_QTY), -1, B.TRANS_MAMT, 0) AS M_USE_AMT                   -- 사용금액    (출하)(수불:재고량=실사량) \n");
			sbSelSql.append("     , DECODE(B.UNIT_QTY, 0, 0, ROUND(B.UNIT_AMT / B.UNIT_QTY, 5)) AS U_STK_PRICE    -- 재고단가    (매입)(수불:재고량=실사량) \n");
			sbSelSql.append("     , B.TRANS_UAMT AS U_STK_AMT                                                     -- 재고금액    (매입)(수불:재고량=실사량) \n");
			sbSelSql.append("     , DECODE(SIGN(B.TRANS_QTY),-1, 0,B.TRANS_UAMT) AS U_REAL_AMT                    -- 실사금액    (매입)(수불:재고량=실사량) \n");
			sbSelSql.append("     , DECODE(SIGN(B.TRANS_QTY),-1, B.TRANS_UAMT, 0) AS U_USE_AMT                    -- 사용금액    (매입)(수불:재고량=실사량) \n");
			sbSelSql.append("     , 0 AS ADV_PHYSIC_QTY                                                           -- 사전 재고 조사량  \n");
			sbSelSql.append("     , UOM_QTY AS MENU_QTY                                                           -- 식단예상사용량(수불) \n");
		}
		// 구매단위, 재고량=실사량
		else if(v_chkPoUom.equals("Y") && v_chkPhysicQty.equals("Y")) // 구매단위==Y && 실사량=재고량설정==Y
		{
			sbSelSql.append("     , DECODE(B.UNIT_QTY, 0, 0, ROUND(B.MARGIN_AMT / (B.UNIT_QTY / A.UOM_CONVERT_RATE), 5)) AS M_STK_PRICE  -- 재고단가    (출하)(구매:재고량=실사량) \n");
			sbSelSql.append("     , ROUND(B.TRANS_QTY / A.UOM_CONVERT_RATE, 5) AS M_STK_QTY                                              -- 재고량            (구매:재고량=실사량) \n");
			sbSelSql.append("     , B.TRANS_QTY / A.UOM_CONVERT_RATE AS M_STK_QTY_ORG                                                    -- 재고량 반올림 미처리 (구매:재고량!=실사량) \n");
			sbSelSql.append("     , B.TRANS_MAMT AS M_STK_AMT                                                                            -- 재고금액    (출하)(구매:재고량=실사량) \n");
			sbSelSql.append("     , TO_CHAR(DECODE(SIGN(B.TRANS_QTY), -1, 0, ROUND(B.TRANS_QTY / A.UOM_CONVERT_RATE, 5))) AS M_REAL_QTY  -- 실사재고량 STRING (구매:재고량=실사량) \n");
			sbSelSql.append("     , DECODE(SIGN(B.TRANS_QTY), -1, 0, ROUND(B.TRANS_QTY / A.UOM_CONVERT_RATE, 5)) AS M_REAL_QTY_SUM       -- 실사재고량 NUMBER (구매:재고량=실사량) \n");
			sbSelSql.append("     , DECODE(SIGN(B.TRANS_QTY), -1, 0, B.TRANS_MAMT) AS M_REAL_AMT                                         -- 실사재고금액(출하)(수불:재고량=실사량) \n");
			sbSelSql.append("     , DECODE(SIGN(B.TRANS_QTY), -1, ROUND(B.TRANS_QTY / A.UOM_CONVERT_RATE, 5), 0) AS M_USE_QTY            -- 사용량            (구매:재고량=실사량) \n");
			sbSelSql.append("     , DECODE(SIGN(B.TRANS_QTY), -1, B.TRANS_MAMT, 0) AS M_USE_AMT                                          -- 사용금액    (출하)(구매:재고량=실사량) \n");
			sbSelSql.append("     , DECODE(B.UNIT_QTY, 0, 0, ROUND(B.UNIT_AMT / (B.UNIT_QTY / A.UOM_CONVERT_RATE), 5)) AS U_STK_PRICE    -- 재고단가    (매입)(구매:재고량=실사량) \n");
			sbSelSql.append("     , B.TRANS_UAMT AS U_STK_AMT                                                                            -- 재고금액    (매입)(구매:재고량=실사량) \n");
			sbSelSql.append("     , DECODE(SIGN(B.TRANS_QTY), -1, 0, B.TRANS_UAMT) AS U_REAL_AMT                                         -- 실사금액    (매입)(구매:재고량=실사량) \n");
			sbSelSql.append("     , DECODE(SIGN(B.TRANS_QTY), -1, B.TRANS_UAMT, 0) AS U_USE_AMT                                          -- 사용금액    (매입)(구매:재고량=실사량) \n");
			sbSelSql.append("     , 0 AS ADV_PHYSIC_QTY                                                                                  -- 사전 재고 조사량  \n");
			sbSelSql.append("     , PO_QTY AS MENU_QTY                                                                                   -- 식단예상사용량(구매) \n");
		}
		sbSelSql.append("     , KG_QTY AS MENU_KG_QTY  -- 식단예상사용량(KG) \n");
		sbSelSql.append("     , NVL(F.VALUE_DATE_INFO, G.VALUE_DATE_INFO) AS VALUE_DATE_INFO  -- 유효기간 \n");
		sbSelSql.append("     , NVL(F.VALUE_DATE, G.VALUE_DATE) AS VALUE_DATE  -- 유효일자 \n");
		sbSelSql.append("     , NVL(F.MAKER_DATE, G.MAKER_DATE) AS MAKER_DATE  -- 제조일자 \n");
		sbSelSql.append("     , A.UOM_CONVERT_RATE AS UOM_CONVERT_RATE \n");
		sbSelSql.append("     , A.TAX_CODE AS TAX_CODE \n");
		sbSelSql.append("     , CASE WHEN NVL(F.VALUE_DATE, G.VALUE_DATE) <= TO_CHAR(TRUNC(TO_DATE('"+ sPhysic_date +"','YYYYMMDD')+7), 'YYYYMMDD') \n");
		sbSelSql.append("	         THEN 'Y' \n");
		sbSelSql.append("	         ELSE 'N' END AS BG_YN \n");
		sbSelSql.append("     , 'N' AS EDIT_YN \n");
		sbSelSql.append("  FROM HLDC_PO_ITEM_MST A \n");
		sbSelSql.append("     , HLDC_PO_ITEM_CLASS_HLDC_V C \n");
		sbSelSql.append("     , HLDC_PO_ITEM_CLASS_HLDC_V D \n");
		sbSelSql.append("     , ( \n");
		sbSelSql.append("        SELECT ITEM_CODE       AS ITEM_CODE \n");
		sbSelSql.append("             , SUM(UNIT_AMT)   AS UNIT_AMT \n");
		sbSelSql.append("             , SUM(MARGIN_AMT) AS MARGIN_AMT \n");
		sbSelSql.append("             , SUM(UNIT_QTY)   AS UNIT_QTY \n");
		sbSelSql.append("             , SUM(TRANS_QTY)  AS TRANS_QTY \n");
		sbSelSql.append("             , SUM(TRANS_UAMT) AS TRANS_UAMT \n");
		sbSelSql.append("             , SUM(TRANS_MAMT) AS TRANS_MAMT \n");
		sbSelSql.append("             , SUM(KG_QTY)     AS KG_QTY \n");
		sbSelSql.append("             , SUM(PO_QTY)     AS PO_QTY \n");
		sbSelSql.append("             , SUM(UOM_QTY)    AS UOM_QTY \n");
		sbSelSql.append("          FROM ( \n");
		sbSelSql.append("                SELECT C.ITEM_CODE          AS ITEM_CODE \n");
		//sbSelSql.append("                     , ABS(C.UNIT_AMOUNT)   AS UNIT_AMT \n");
		//sbSelSql.append("                     , ABS(C.MARGIN_AMOUNT) AS MARGIN_AMT \n");
		//sbSelSql.append("                     , ABS(C.ONHAND_QTY)    AS UNIT_QTY \n");
		//2018.01.25 윤지혜대리, 염병문차장 요청 절대값 풀기(선조치)
		sbSelSql.append("                     , C.UNIT_AMOUNT   AS UNIT_AMT \n");
		sbSelSql.append("                     , C.MARGIN_AMOUNT AS MARGIN_AMT \n");
		sbSelSql.append("                     , C.ONHAND_QTY    AS UNIT_QTY \n");
		sbSelSql.append("                     , C.ONHAND_QTY         AS TRANS_QTY \n");
		sbSelSql.append("                     , C.UNIT_AMOUNT        AS TRANS_UAMT \n");
		sbSelSql.append("                     , C.MARGIN_AMOUNT      AS TRANS_MAMT \n");
		sbSelSql.append("                     , 0                    AS KG_QTY \n");
		sbSelSql.append("                     , 0                    AS PO_QTY \n");
		sbSelSql.append("                     , 0                    AS UOM_QTY \n");
		sbSelSql.append("                  FROM HLDC_PO_ONHAND_MONTH C \n");
		sbSelSql.append("                 WHERE C.ONHAND_YM   = '" + sOnhandMonth + "' \n");
		sbSelSql.append("                   AND C.SUBINV_CODE = '" + v_SubinvCode + "' \n");
		sbSelSql.append("                 UNION ALL \n");
		sbSelSql.append("                SELECT D.ITEM_CODE               AS ITEM_CODE \n");
		//sbSelSql.append("                     , SUM(ABS(D.UNIT_AMOUNT))   AS UNIT_AMT \n");
		//sbSelSql.append("                     , SUM(ABS(D.TRANS_MAMOUNT)) AS MARGIN_AMT \n");
		//sbSelSql.append("                     , SUM(ABS(D.UOM_QTY))       AS UNIT_QTY \n");
		//2018.01.25 윤지혜대리, 염병문차장 요청 절대값 풀기(선조치)
		sbSelSql.append("                     , SUM(D.UNIT_AMOUNT)   AS UNIT_AMT \n");
		sbSelSql.append("                     , SUM(D.TRANS_MAMOUNT) AS MARGIN_AMT \n");
		sbSelSql.append("                     , SUM(D.UOM_QTY)       AS UNIT_QTY \n");
		sbSelSql.append("                     , 0                         AS TRANS_QTY \n");
		sbSelSql.append("                     , 0                         AS TRANS_UAMT \n");
		sbSelSql.append("                     , 0                         AS TRANS_MAMT \n");
		sbSelSql.append("                     , 0                         AS KG_QTY \n");
		sbSelSql.append("                     , 0                         AS PO_QTY \n");
		sbSelSql.append("                     , 0                         AS UOM_QTY \n");
		//sbSelSql.append("                  FROM HLDC_PO_TRANSACTION D \n");
		sbSelSql.append("                  FROM HLDC_PO_TRANSACTION2 D \n"); // TUNING POINT
		sbSelSql.append("                 WHERE D.TRANS_DATE BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE('" + sOnhandMonth + "'||'01','YYYYMMDD'),1),'YYYYMMDD') AND '" + sPhysic_date + "' \n");
		sbSelSql.append("                   AND D.SUBINV_CODE = '" + v_SubinvCode + "' \n");
		sbSelSql.append("                   AND D.TRANS_TYPE  LIKE 'I%' \n");
		sbSelSql.append("                 GROUP BY D.ITEM_CODE \n");
		sbSelSql.append("                 UNION ALL \n");
		sbSelSql.append("                SELECT D.ITEM_CODE                                                           AS ITEM_CODE\n");
		sbSelSql.append("                     , 0                                                                     AS UNIT_AMT \n");
		sbSelSql.append("                     , 0                                                                     AS MARGIN_AMT \n");
		sbSelSql.append("                     , 0                                                                     AS UNIT_QTY \n");
		sbSelSql.append("                     , SUM(DECODE(SUBSTR(D.TRANS_TYPE, 1, 1), 'I', 1, -1) * D.UOM_QTY)       AS TRANS_QTY \n");
		sbSelSql.append("                     , SUM(DECODE(SUBSTR(D.TRANS_TYPE, 1, 1), 'I', 1, -1) * D.UNIT_AMOUNT)   AS TRANS_UAMT \n");
		sbSelSql.append("                     , SUM(DECODE(SUBSTR(D.TRANS_TYPE, 1, 1), 'I', 1, -1) * D.MARGIN_AMOUNT) AS TRANS_MAMT \n");
		sbSelSql.append("                     , 0                                                                     AS KG_QTY \n");
		sbSelSql.append("                     , 0                                                                     AS PO_QTY \n");
		sbSelSql.append("                     , 0                                                                     AS UOM_QTY \n");
		//sbSelSql.append("                  FROM HLDC_PO_TRANSACTION D \n");
		sbSelSql.append("                  FROM HLDC_PO_TRANSACTION2 D \n"); // TUNING POINT
		sbSelSql.append("                 WHERE D.TRANS_DATE BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE('" + sOnhandMonth + "'||'01','YYYYMMDD'),1),'YYYYMMDD') AND '" + sPhysic_date + "' \n");
		sbSelSql.append("                   AND D.SUBINV_CODE = '" + v_SubinvCode + "' \n");
		sbSelSql.append("                 GROUP BY D.ITEM_CODE \n");
		if( v_MenuQty.equals("RSS") )	// 적정재고량 - 외식
		{
			sbSelSql.append("                 UNION ALL \n");
			sbSelSql.append("                SELECT A.ITEM_CODE \n");
			sbSelSql.append("                     , 0           AS UNIT_AMT \n");
			sbSelSql.append("                     , 0           AS MARGIN_AMT \n");
			sbSelSql.append("                     , 0           AS UNIT_QTY \n");
			sbSelSql.append("                     , 0           AS TRANS_QTY \n");
			sbSelSql.append("                     , 0           AS TRANS_UAMT \n");
			sbSelSql.append("                     , 0           AS TRANS_MAMT \n");
			sbSelSql.append("                     , 0           AS KG_QTY \n");
			sbSelSql.append("                     , ROUND((SUM(A.LOSS_QTY / B.UOM_CONVERT_RATE) / 30) * NVL(MAX(C.OPTIMUM_DAY), 3), 2) AS PO_QTY \n");
			sbSelSql.append("                     , ROUND((SUM(A.LOSS_QTY) / 30) * NVL(MAX(C.OPTIMUM_DAY), 3), 2) AS UOM_QTY \n");
			sbSelSql.append("                  FROM FSP_PHYSICAL_INVENTORY_STOCK A \n");
			sbSelSql.append("                     , HLDC_PO_ITEM_MST B \n");
			sbSelSql.append("                     , FSP_PHYSICAL_INVENTORY_OPTIMUM C \n");
			//FSP_PHYSICAL_INVENTORY_OPTIMUM UPJANG 조건 추가로 튜닝 2018.03.29 김호석
			sbSelSql.append("                     , HLDC_PO_SUBINVENTORY D \n");            
			sbSelSql.append("                 WHERE A.ITEM_CODE = B.ITEM_CODE \n");
			sbSelSql.append("                   AND A.SUBINV_CODE = C.SUBINV_CODE(+) \n");
			sbSelSql.append("                   AND A.ITEM_CODE = C.ITEM_CODE(+) \n");
			//FSP_PHYSICAL_INVENTORY_OPTIMUM UPJANG 조건 추가로 튜닝 2018.03.29 김호석
			sbSelSql.append("                   AND A.SUBINV_CODE = D.SUBINV_CODE \n");
			sbSelSql.append("                   AND D.UPJANG = C.UPJANG \n");			
			sbSelSql.append("                   AND A.SUBINV_CODE = '" + v_SubinvCode + "' \n"); 
			sbSelSql.append("                   AND A.PHYSIC_DATE BETWEEN TO_CHAR(TO_DATE('" + sPhysic_date + "', 'YYYYMMDD') - 30, 'YYYYMMDD') AND TO_CHAR(TO_DATE('" + sPhysic_date + "', 'YYYYMMDD') - 1, 'YYYYMMDD') \n");
			sbSelSql.append("                   AND A.TR_TYPE = 'I' \n");
			sbSelSql.append("                   AND A.STATUS = 'Y' \n");
			sbSelSql.append("                 GROUP BY A.ITEM_CODE \n");
		}
		// 예상사용량 - 단체급식
		else
		{
			if(v_SubinvCode.substring(0,1).equals("C"))
			{
				sbSelSql.append("                 UNION ALL \n");
				sbSelSql.append("                SELECT C.ITEM_CODE AS ITEM_CODE \n");
				sbSelSql.append("                     , 0           AS UNIT_AMT \n");
				sbSelSql.append("                     , 0           AS MARGIN_AMT \n");
				sbSelSql.append("                     , 0           AS UNIT_QTY \n");
				sbSelSql.append("                     , 0           AS TRANS_QTY \n");
				sbSelSql.append("                     , 0           AS TRANS_UAMT \n");
				sbSelSql.append("                     , 0           AS TRANS_MAMT \n");
				sbSelSql.append("                     , ROUND(SUM(DECODE(D.CAFE_YN, 'Y', B.EXPECT_SALE_QTY,DECODE(D.CATER_YN, 'Y', B.EXPECT_SALE_QTY, A.EXPECT_MEAL_QTY))*C.NEED_QTY/1000), 2) KG_QTY \n");
				sbSelSql.append("                     , ROUND(SUM(DECODE(D.CAFE_YN, 'Y', B.EXPECT_SALE_QTY,DECODE(D.CATER_YN, 'Y', B.EXPECT_SALE_QTY, A.EXPECT_MEAL_QTY))*C.NEED_QTY/1000)/E.KG_CONVERT_RATE, 2) PO_QTY \n");
				sbSelSql.append("                     , ROUND(SUM(DECODE(D.CAFE_YN, 'Y', B.EXPECT_SALE_QTY,DECODE(D.CATER_YN, 'Y', B.EXPECT_SALE_QTY, A.EXPECT_MEAL_QTY))*C.NEED_QTY/1000)/E.KG_CONVERT_RATE*E.UOM_CONVERT_RATE, 2) UOM_QTY \n");
				sbSelSql.append("                  FROM FSM_REAL_MENU_MST A \n");
				sbSelSql.append("                     , FSM_REAL_RECIPE_MST B \n");
				sbSelSql.append("                     , FSM_REAL_RECIPE_ITEM C \n");
				sbSelSql.append("                     , FSA_HALL_MST D \n");
				sbSelSql.append("                     , HLDC_PO_ITEM_MST E \n");
				sbSelSql.append("                 WHERE A.UPJANG = B.UPJANG \n");
				sbSelSql.append("                   AND A.MENU_CD = B.MENU_CD \n");
				sbSelSql.append("                   AND B.UPJANG = C.UPJANG \n");
				sbSelSql.append("                   AND B.MENU_CD = C.MENU_CD \n");
				sbSelSql.append("                   AND B.RECIPE_CD = C.RECIPE_CD \n");
				sbSelSql.append("                   AND A.UPJANG = D.UPJANG \n");
				sbSelSql.append("                   AND A.HALL_CD = D.HALL_CD \n");
				sbSelSql.append("                   AND C.ITEM_CODE = E.ITEM_CODE \n");
				sbSelSql.append("                   AND A.UPJANG = (SELECT UPJANG FROM HLDC_PO_SUBINVENTORY WHERE SUBINV_CODE = '" + v_SubinvCode + "') \n");
				sbSelSql.append("                   AND A.SUBINV_CODE = '" + v_SubinvCode + "' \n");
				sbSelSql.append("                   AND A.MENU_DATE = '" + sPhysic_date + "' \n");
				sbSelSql.append("                 GROUP BY C.ITEM_CODE, E.KG_CONVERT_RATE, E.UOM_CONVERT_RATE \n");
			}
		}

		sbSelSql.append("               ) \n");
		sbSelSql.append("         GROUP BY ITEM_CODE \n");
		sbSelSql.append("       ) B \n");
		sbSelSql.append("     , ( \n");
		sbSelSql.append("        SELECT A.ITEM_CODE  AS ITEM_CODE \n");
		sbSelSql.append("             , A.PHYSIC_QTY AS ADV_PHYSIC_QTY --기실사량 \n");
		sbSelSql.append("             , 0 AS ADV_PHYSIC_AMT \n");
		sbSelSql.append("          FROM FSP_PHYSICAL_INVENTORY_STOCK A \n");
		sbSelSql.append("         WHERE A.PHYSIC_DATE = '" + sPhysic_date + "' \n");
		sbSelSql.append("           AND A.SUBINV_CODE = '" + v_SubinvCode + "' \n");
		sbSelSql.append("       ) E \n");
		sbSelSql.append("     , ( \n");
		sbSelSql.append("        SELECT A.ITEM_CODE AS ITEM_CODE \n");
		sbSelSql.append("             , A.VALUE_DATE_INFO AS VALUE_DATE_INFO      -- 유통기한 \n");
		sbSelSql.append("             , CASE WHEN INSTR(A.VALUE_DATE, '-') > 0 THEN '' ELSE A.VALUE_DATE END AS VALUE_DATE  -- 유통일자 \n");
		sbSelSql.append("             , A.MAKER_DATE AS MAKER_DATE                -- 제조일자 \n");
		sbSelSql.append("          FROM FSP_PHYSICAL_INVENTORY_STOCK A \n");
		sbSelSql.append("         WHERE A.PHYSIC_DATE = '" + sPhysic_before_date + "' \n");
		sbSelSql.append("           AND A.SUBINV_CODE = '" + v_SubinvCode + "' \n");
		sbSelSql.append("       ) F \n");
		sbSelSql.append("     , ( \n");
		sbSelSql.append("        SELECT * \n");
		sbSelSql.append("          FROM FSP_PHYSICAL_INVENTORY_STOCK \n");
		sbSelSql.append("         WHERE GRP_NO = (SELECT MAX(TO_NUMBER(GRP_NO)) \n");
		sbSelSql.append("                           FROM FSP_PHYSICAL_INVENTORY_STOCK \n");
		sbSelSql.append("                          WHERE PHYSIC_DATE = '"+sPhysic_date+"' \n");
		sbSelSql.append("                            AND SUBINV_CODE = '"+ v_SubinvCode +"' \n");
		sbSelSql.append("                            AND TR_TYPE = 'T') \n");
		sbSelSql.append("           AND PHYSIC_DATE = '"+sPhysic_date+"' \n");
		sbSelSql.append("           AND SUBINV_CODE = '"+ v_SubinvCode +"' \n");
		sbSelSql.append("           AND TR_TYPE = 'T' \n");
		sbSelSql.append("       ) G \n");
		sbSelSql.append(" WHERE C.CLASS_CODE = A.ITEM_CLASS2 \n");
		sbSelSql.append("   AND C.CLASS_TYPE = 'M' \n");
		sbSelSql.append("   AND D.CLASS_CODE = A.ITEM_CLASS3 \n");
		sbSelSql.append("   AND D.CLASS_TYPE = 'S' \n");
		sbSelSql.append("   AND A.ITEM_CODE  = B.ITEM_CODE \n");
		sbSelSql.append("   AND B.ITEM_CODE  = E.ITEM_CODE(+) \n");
		sbSelSql.append("   AND B.ITEM_CODE  = F.ITEM_CODE(+) \n");
		sbSelSql.append("   AND B.ITEM_CODE  = G.ITEM_CODE(+) \n");
		// 재고량이 0이 아닌 자재만 뽑아온다.
		sbSelSql.append("   AND B.TRANS_QTY  <> 0 \n");
		sbSelSql.append(") A \n");
		sbSelSql.append(", (\n");
		sbSelSql.append("   SELECT ITEM_CODE\n");
		sbSelSql.append("        , TR_TYPE\n");
		sbSelSql.append("     FROM FSP_PHYSICAL_INVENTORY_STOCK\n");
		sbSelSql.append("    WHERE PHYSIC_DATE = '"+sPhysic_date+"'\n");
		sbSelSql.append("      AND SUBINV_CODE = '"+ v_SubinvCode +"'\n");
		sbSelSql.append("  ) B \n");
		sbSelSql.append(" WHERE A.ITEM_CODE = B.ITEM_CODE(+) \n");
		sbSelSql.append("   AND (B.TR_TYPE IS NULL OR B.TR_TYPE <> 'I') \n");
		sbSelSql.append(" ORDER BY A.L_CLASS_CODE, A.M_CLASS_CODE, A.ITEM_CODE \n");

		pstmt = conn.prepareStatement(sbSelSql.toString());
		rs = pstmt.executeQuery();

		ds_stock = this.makeDataSet(rs, "ds_stock");
		out_dl.add(ds_stock);

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