<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	Statement stmt             =  null;
	try {
		PlatformRequest platformRequest = this.proc_input(request);  
		// 입력 데이터셋리스트
		in_dl = platformRequest.getData().getDataSetList();
		// 입력  변수리스트
		in_vl = platformRequest.getData().getVariableList();
		
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));
		
		//입력 데이타셋 선언
		DataSet ds_cond = in_dl.get("ds_cond");
		
		//출력 데이타셋 선언
		DataSet ds_dailyList;
		
		String UPJANG     = ds_cond.getString(0, "UPJANG");
		String START_DATE = ds_cond.getString(0, "START_DATE");
		String END_DATE   = ds_cond.getString(0, "END_DATE");
		String PRICE_TYPE = ds_cond.getString(0, "PRICE_TYPE");
		
		String LAST_MONTH   = "";
		String ONHAND_MONTH = "";
		String FROM_DATE    = "";
		
		String V_MONTH  = "";
		String V_FROM_DATE = "";
		
		String V_AMOUNT = "";
		String V_PRICE  = "";
		
		//PRICE_TYPE : 관리, 재무 
		//재무를 선택했을 경우 MARGIN_AMOUNT => UNIT_AMOUNT, MARGIN_PRICE => UNIT_PRICE 로 변경한다.
		if(PRICE_TYPE.equals("관리"))
		{
			V_AMOUNT = "MARGIN_AMOUNT";
			V_PRICE  = "MARGIN_PRICE";
		}
		else
		{
			V_AMOUNT = "UNIT_AMOUNT";
			V_PRICE  = "UNIT_PRICE";
		}
	    
		// 조회시 사전 실행 쿼리 
		StringBuffer sbSql = new StringBuffer();
		sbSql.append(" SELECT TO_CHAR(ADD_MONTHS(TO_DATE(SUBSTR('"+ START_DATE +"',1,6),'YYYYMM'), -1), 'YYYYMM') LAST_MONTH,    \n");
		sbSql.append("        NVL(MAX(ONHAND_YM),'200101') ONHAND_MONTH,                                                         \n");
		sbSql.append("        TO_CHAR(ADD_MONTHS(TO_DATE(NVL(MAX(ONHAND_YM),'200101'),'YYYYMM'),1),'YYYYMM')||'01' FROM_DATE     \n");
		sbSql.append("   FROM HLDC_PO_ONHAND_MONTH A                                                                             \n");
		sbSql.append("  WHERE SUBINV_CODE = 'C1000001'                                                                           \n");
		
		pstmt = conn.prepareStatement(sbSql.toString());	
		rs = pstmt.executeQuery(); 		
		rs.next();
		
		LAST_MONTH   = rs.getString("LAST_MONTH");
		ONHAND_MONTH = rs.getString("ONHAND_MONTH");
		FROM_DATE    = rs.getString("FROM_DATE");
			
		if(Integer.parseInt(LAST_MONTH) < Integer.parseInt(ONHAND_MONTH))
		{
			V_MONTH = LAST_MONTH;
			V_FROM_DATE = START_DATE.substring(0,6) + "01";
		}
		else
		{
			V_MONTH = ONHAND_MONTH;
			V_FROM_DATE = FROM_DATE;
		}
		
		sbSql.delete(0, sbSql.length());
        sbSql.append("SELECT A.BASE_DD    /* 기준일 */                                                                                                                                                                      \n");
        sbSql.append("     , A.WEEK_NAME  /* 요일 */                                                                                                                                                                        \n");
        sbSql.append("     , A.WE_COLOR   /* 요일색상 */                                                                                                                                                                    \n");
        sbSql.append("     , B.SP_AMT     /* 매출액 - 식음료매출 계획 */                                                                                                                                                    \n");
        sbSql.append("     , B.SR_AMT     /* 매출액 - 식음료매출 추정 */                                                                                                                                                    \n");
        sbSql.append("     , C.SS_AMT     /* 매출액 - 식음료매출 실적 */                                                                                                                                                    \n");
        sbSql.append("     , D.MP_AMT     /* 재료비 - 식음료원가 계획 */                                                                                                                                                    \n");
        sbSql.append("     , D.MR_AMT     /* 재료비 - 식음료원가 추정 */                                                                                                                                                    \n");
        sbSql.append("     , NVL(E.MS_AMT1, 0) - NVL(G.MS_AMT3, 0) AS MS_AMT     /* 재료비 - 식음료매출 실적 */                                                                                                             \n");
        sbSql.append("     , E.MS_AMT1   /* 식음료매출 실적 - 전산구매 */                                                                                                                                                   \n");
        sbSql.append("     , F.MS_AMT2   /* 식음료매출 실적 - 현지구매 */                                                                                                                                                   \n");
        sbSql.append("     , G.MS_AMT3   /* 식음료매출 실적 - 복리후생식대비 */                                                                                                                                             \n");
        sbSql.append("     , ROUND(DECODE(B.SP_AMT, 0, 0, D.MP_AMT / B.SP_AMT * 100), 2) AS P_RATE   /* 식재료율 - 계획 */                                                                                                  \n");
        sbSql.append("     , ROUND(DECODE(B.SR_AMT, 0, 0, D.MR_AMT / B.SR_AMT * 100), 2) AS R_RATE   /* 식재료율 - 추정 */                                                                                                  \n");
        sbSql.append("     , ROUND(DECODE(NVL(C.SS_AMT, 0), 0, 0, (NVL(E.MS_AMT1, 0) - NVL(G.MS_AMT3, 0)) / C.SS_AMT * 100), 2) AS S_RATE   /* 식재료율 - 실적 */                                                           \n");
        sbSql.append("     , I.IS_AMT                                                                                                                                                                                       \n");
        sbSql.append("     , J.EXPECT_SALE                                                                                                                                                                                  \n");
        sbSql.append("     , J.EXPECT_COST                                                                                                                                                                                  \n");
        sbSql.append("     , J.EXPECT_RATE                                                                                                                                                                                  \n");
        sbSql.append("  FROM (                                                                                                                                                                                              \n");
        sbSql.append("        /* 일자 기준정보 */                                                                                                                                                                           \n");
        sbSql.append("        SELECT A.FDAY AS BASE_DD                                                                                                                                                                      \n");
        sbSql.append("             , A.WEEK_NAME                                                                                                                                                                            \n");
        sbSql.append("             , DECODE(A.WEEK_NAME,'일','FFCC00','토','99CCFF','FFFFFF') AS WE_COLOR                                                                                                                   \n");
        sbSql.append("          FROM (SELECT FDAY                                                                                                                                                                           \n");
        sbSql.append("                     , TO_CHAR(TO_DATE(FDAY, 'YYYYMMDD'), 'DY', 'NLS_DATE_LANGUAGE=KOREAN') AS WEEK_NAME                                                                                              \n");
        sbSql.append("                  FROM (SELECT TO_CHAR(TO_DATE('" + START_DATE + "', 'YYYYMMDD') + LEVEL - 1, 'YYYYMMDD') AS FDAY                                                                                     \n");
        sbSql.append("                          FROM DUAL                                                                                                                                                                   \n");
        sbSql.append("                        CONNECT BY LEVEL <= TO_DATE('" + END_DATE + "', 'YYYYMMDD') - TO_DATE('" + START_DATE + "', 'YYYYMMDD') + 1)) A                                                               \n");
        sbSql.append("       ) A                                                                                                                                                                                            \n");
        sbSql.append("     , (                                                                                                                                                                                              \n");
        sbSql.append("        /* 매출 - 식음료매출 계획(P), 추정(R) */                                                                                                                                                      \n");
        sbSql.append("        SELECT YMD AS BASE_DD                                                                                                                                                                         \n");
        sbSql.append("             , NVL(SUM(PAMT), 0) AS SP_AMT                                                                                                                                                            \n");
        sbSql.append("             , NVL(SUM(RAMT), 0) AS SR_AMT                                                                                                                                                            \n");
        sbSql.append("          FROM (                                                                                                                                                                                      \n");
        sbSql.append("                SELECT B.YMD                                                                                                                                                                          \n");
        sbSql.append("                     , DECODE(B.DAY_CLASS, 'P', SUM(B.DD_AMT), 0) AS PAMT                                                                                                                             \n");
        sbSql.append("                     , DECODE(B.DAY_CLASS, 'R', SUM(B.DD_AMT), 0) AS RAMT                                                                                                                             \n");
        sbSql.append("                  FROM MAP_DAY_LOG_MGMT A                                                                                                                                                             \n");
        sbSql.append("                     , MAP_DAY_PLAN B                                                                                                                                                                 \n");
        sbSql.append("                 WHERE A.UPJANG = B.UPJANG                                                                                                                                                            \n");
        sbSql.append("                   AND B.UPJANG = '" + UPJANG + "'                                                                                                                                                    \n");
        sbSql.append("                   AND A.YY = B.YY                                                                                                                                                                    \n");
        sbSql.append("                   AND A.MM = B.MM                                                                                                                                                                    \n");
        sbSql.append("                   AND A.DAY_CLASS = B.DAY_CLASS                                                                                                                                                                    \n");
        sbSql.append("                   AND A.CONFIRM_YN = 'Y'                                                                                                                                                             \n");
        sbSql.append("                   AND B.YMD BETWEEN '" + START_DATE + "' AND '" + END_DATE + "'                                                                                                                      \n");
        sbSql.append("                   AND B.ACCT_CD IN ('41203010', '41203020', '41203030')                                                                                                                              \n");
        sbSql.append("                 GROUP BY YMD, B.DAY_CLASS                                                                                                                                                            \n");
        sbSql.append("                )                                                                                                                                                                                     \n");
        sbSql.append("         GROUP BY YMD                                                                                                                                                                                 \n");
        sbSql.append("       ) B                                                                                                                                                                                            \n");
        sbSql.append("     , (                                                                                                                                                                                              \n");
        sbSql.append("        /* 매출 - 식음료매출 실적 (내부이용포함) */                                                                                                                                                   \n");
        sbSql.append("        SELECT A.OCCUR_DATE AS BASE_DD                                                                                                                                                                \n");
        sbSql.append("             , SUM(B.NET_AMT) AS SS_AMT                                                                                                                                                               \n");
        sbSql.append("          FROM SLA_IF_UPJANG_SALS_MST A                                                                                                                                                               \n");
        sbSql.append("             , SLA_IF_UPJANG_SALS_DETAIL B                                                                                                                                                            \n");
        sbSql.append("         WHERE A.OCCUR_DATE = B.OCCUR_DATE                                                                                                                                                            \n");
        sbSql.append("           AND A.SYS_CLASS = B.SYS_CLASS                                                                                                                                                              \n");
        sbSql.append("           AND A.UPJANG_CD = B.UPJANG_CD                                                                                                                                                              \n");
        sbSql.append("           AND A.UPJANG_CD = '" + UPJANG + "'                                                                                                                                                         \n");
        sbSql.append("           AND A.OCCUR_DATE BETWEEN '" + START_DATE + "' AND '" + END_DATE + "'                                                                                                                       \n");
        sbSql.append("           AND A.RECEIPT_NUM = B.RECEIPT_NUM                                                                                                                                                          \n");
        sbSql.append("           /* 1103 : FS식음료매출, 2001 : FS POS식음료매출, 1106 : 기타매출-기타, 1204 : 외식식음료매출-식료, 1205 : 외식식음료매출-음료, 2101 : 외식 POS식음료매출-식료, 2102 : 외식 POS식음료매출-음료 */ \n");
        sbSql.append("           AND B.SALS_CLASS IN ('1103', '2001', '1106', '1204', '1205', '2101', '2102')                                                                                                               \n");
        sbSql.append("         GROUP BY A.OCCUR_DATE                                                                                                                                                                        \n");
        sbSql.append("       ) C                                                                                                                                                                                            \n");
        sbSql.append("     , (                                                                                                                                                                                              \n");
        sbSql.append("        /* 재료비 - 식음료원가 계획, 추정 */                                                                                                                                                          \n");
        sbSql.append("        SELECT YMD AS BASE_DD                                                                                                                                                                         \n");
        sbSql.append("             , NVL(SUM(PAMT), 0) AS MP_AMT                                                                                                                                                            \n");
        sbSql.append("             , NVL(SUM(RAMT), 0) AS MR_AMT                                                                                                                                                            \n");
        sbSql.append("          FROM (                                                                                                                                                                                      \n");
        sbSql.append("                SELECT B.YMD                                                                                                                                                                          \n");
        sbSql.append("                     , DECODE(B.DAY_CLASS, 'P', SUM(B.DD_AMT), 0) AS PAMT                                                                                                                             \n");
        sbSql.append("                     , DECODE(B.DAY_CLASS, 'R', SUM(B.DD_AMT), 0) AS RAMT                                                                                                                             \n");
        sbSql.append("                  FROM MAP_DAY_LOG_MGMT A                                                                                                                                                             \n");
        sbSql.append("                     , MAP_DAY_PLAN B                                                                                                                                                                 \n");
        sbSql.append("                 WHERE A.UPJANG = B.UPJANG                                                                                                                                                            \n");
        sbSql.append("                   AND B.UPJANG = '" + UPJANG + "'                                                                                                                                                    \n");
        sbSql.append("                   AND A.YY = B.YY                                                                                                                                                                    \n");
        sbSql.append("                   AND A.MM = B.MM                                                                                                                                                                    \n");
        sbSql.append("                   AND A.DAY_CLASS = B.DAY_CLASS                                                                                                                                                                    \n");
        sbSql.append("                   AND A.CONFIRM_YN = 'Y'                                                                                                                                                             \n");
        sbSql.append("                   AND B.YMD BETWEEN '" + START_DATE + "' AND '" + END_DATE + "'                                                                                                                      \n");
        sbSql.append("                   AND B.ACCT_CD IN ('42203010', '42203020', '42203030')  -- 식음료원가_식료(FC음료포함)                                                                                              \n");
        sbSql.append("                 GROUP BY YMD, B.DAY_CLASS                                                                                                                                                            \n");
        sbSql.append("                )                                                                                                                                                                                     \n");
        sbSql.append("         GROUP BY YMD                                                                                                                                                                                 \n");
        sbSql.append("       ) D                                                                                                                                                                                            \n");
        sbSql.append("     , (                                                                                                                                                                                              \n");
        sbSql.append("        /* 재료비 - 실적 - 전산구매 */                                                                                                                                                                \n");
        sbSql.append("        SELECT /*+ USE_NL(A.HD A.DT) */ TRANS_DATE AS BASE_DD                                                                                                                                         \n");
        sbSql.append("             , ROUND(NVL( DECODE(B.OUTVAT_FLAG, 'Y', SUM( MARGIN_AMOUNT * DECODE( TAX_CODE, '100', DECODE( MATERIAL_ACCTCD, '11402000', 1.1, 1) ) ), SUM( MARGIN_AMOUNT ) ), 0)) AS MS_AMT1           \n");
        sbSql.append("           FROM HLDC_PO_TRANSACTION A                                                                                                                                                                 \n");
        sbSql.append("             , HLDC_PO_SUBINVENTORY B                                                                                                                                                                 \n");
        sbSql.append("         WHERE A.SUBINV_CODE = B.SUBINV_CODE                                                                                                                                                          \n");
        sbSql.append("           AND A.TRANS_DATE BETWEEN '" + START_DATE + "' AND '" + END_DATE + "'                                                                                                                       \n");
        sbSql.append("           AND A.TRANS_UPJANG = '" + UPJANG + "'                                                                                                                                                      \n");
        sbSql.append("           AND A.TRANS_TYPE LIKE 'O%'        -- 출고                                                                                                                                                  \n");
        sbSql.append("           AND A.TRANS_TYPE <> 'O002'  -- 이동출고 제외                                                                                                                                               \n");
        sbSql.append("           AND A.ACCTCD IN ('42203010', '42203020', '42203030')         -- 식재료 (FS사업부 식음료 출고계정 : '42203030', 외식사업부 식음료 출고계정 : '42203010', '42203020')                        \n");
        sbSql.append("         GROUP BY TRANS_DATE, B.OUTVAT_FLAG                                                                                                                                                           \n");
        sbSql.append("       ) E                                                                                                                                                                                            \n");
        sbSql.append("     , (                                                                                                                                                                                              \n");
        sbSql.append("        /* 재료비 - 실적 - 현재구매(전도금 법인, 현금) */                                                                                                                                             \n");
        sbSql.append("        SELECT A.BASIS_DATE AS BASE_DD                                                                                                                                                                \n");
        sbSql.append("             , NVL(SUM(A.AMT), 0) AS MS_AMT2                                                                                                                                                          \n");
        sbSql.append("          FROM MAP_PREPAY_ADJUST A                                                                                                                                                                    \n");
        sbSql.append("             , SCO_UPJANG_MST_V B                                                                                                                                                                     \n");
        sbSql.append("         WHERE A.CC_CD = B.CC_CD                                                                                                                                                                      \n");
        sbSql.append("           AND A.BASIS_DATE BETWEEN '" + START_DATE + "' AND '" + END_DATE + "'                                                                                                                       \n");
        sbSql.append("           AND ACCT_CD = '41203010' -- 식음료매출_식료(FC음료포함)                                                                                                                                    \n");
        sbSql.append("           AND B.UPJANG = '" + UPJANG + "'                                                                                                                                                            \n");
        sbSql.append("         GROUP BY BASIS_DATE                                                                                                                                                                          \n");
        sbSql.append("       ) F                                                                                                                                                                                            \n");
        sbSql.append("     , (                                                                                                                                                                                              \n");
        sbSql.append("        /* 복리후생 식대비 - 일수로 Split */                                                                                                                                                          \n");
        sbSql.append("        SELECT ROUND(NVL(SUM(AMT), 0) / TO_NUMBER(TO_CHAR(LAST_DAY(SYSDATE), 'DD')), 0) AS MS_AMT3                                                                                                    \n");
        sbSql.append("          FROM MAS_WELFARE                                                                                                                                                                            \n");
        sbSql.append("         WHERE UPJANG = '" + UPJANG + "'                                                                                                                                                              \n");
        sbSql.append("           AND APPLY_MM = TO_CHAR(TO_DATE('" + START_DATE + "', 'YYYYMMDD'), 'YYYYMM')                                                                                                                \n");
        sbSql.append("       ) G                                                                                                                                                                                            \n");
        sbSql.append("     , (                                                                                                                                                                                              \n");
        sbSql.append("        /* 재고실적금액 */                                                                                                                                                                            \n");
        sbSql.append("        SELECT A.BASE_DD                                                                                                                                                                              \n");
        sbSql.append("             , SUM(NVL(A.STOCK_AMT, 0)) AS IS_AMT                                                                                                                                                     \n");
        sbSql.append("          FROM (                                                                                                                                                                                      \n");
        sbSql.append("                SELECT A.BASE_DD                                                                                                                                                                      \n");
        sbSql.append("                     , SUM(B.STOCK_AMT) AS STOCK_AMT                                                                                                                                                  \n");
        sbSql.append("                  FROM (                                                                                                                                                                              \n");
        sbSql.append("                        /* 일자 기준정보 */                                                                                                                                                           \n");
        sbSql.append("                        SELECT A.FDAY AS BASE_DD                                                                                                                                                      \n");
        sbSql.append("                             , A.WEEK_NAME                                                                                                                                                            \n");
        sbSql.append("                             , DECODE(A.WEEK_NAME,'일','FFCC00','토','99CCFF','FFFFFF') AS WE_COLOR                                                                                                   \n");
        sbSql.append("                          FROM (SELECT FDAY                                                                                                                                                           \n");
        sbSql.append("                                     , TO_CHAR(TO_DATE(FDAY, 'YYYYMMDD'), 'DY', 'NLS_DATE_LANGUAGE=KOREAN') AS WEEK_NAME                                                                              \n");
        sbSql.append("                                  FROM (SELECT TO_CHAR(TO_DATE('" + START_DATE + "', 'YYYYMMDD') + LEVEL - 1, 'YYYYMMDD') AS FDAY                                                                     \n");
        sbSql.append("                                          FROM DUAL                                                                                                                                                   \n");
        sbSql.append("                                        CONNECT BY LEVEL <= TO_DATE('" + END_DATE + "', 'YYYYMMDD') - TO_DATE('" + START_DATE + "', 'YYYYMMDD') + 1)) A                                               \n");
        sbSql.append("                       ) A                                                                                                                                                                            \n");
        sbSql.append("                     , (                                                                                                                                                                              \n");
        sbSql.append("                        SELECT C.PHYSIC_DATE AS BASE_DD                                                                                                                                               \n");
        sbSql.append("                             , ROUND(SUM(A.ONHAND_MAMOUNT - A.LOSS_MAMOUNT)) AS STOCK_AMT     -- 실사재고금액                                                                                         \n");
        sbSql.append("                          FROM HLDC_PO_PHYSICAL_INVENTORY A                                                                                                                                           \n");
        sbSql.append("                             , HLDC_PO_ITEM_MST B                                                                                                                                                     \n");
        sbSql.append("                             , (SELECT DISTINCT A.*                                                                                                                                                   \n");
        sbSql.append("                                  FROM HLDC_PO_PHYSICAL_INVENTORY A                                                                                                                                   \n");
        sbSql.append("                                     , (SELECT PHYSIC_DATE                                                                                                                                            \n");
        sbSql.append("                                             , SUBINV_CODE                                                                                                                                            \n");
        sbSql.append("                                             , ITEM_CODE AS ITEM_CODE                                                                                                                                 \n");
        sbSql.append("                                             , MAX(UPDATE_DATE) AS UPDATE_DATE                                                                                                                        \n");
        sbSql.append("                                          FROM HLDC_PO_PHYSICAL_INVENTORY                                                                                                                             \n");
        sbSql.append("                                         WHERE PHYSIC_DATE BETWEEN '" + START_DATE + "' AND '" + END_DATE + "' -- 조사일                                                                              \n");
        sbSql.append("                                           AND SUBINV_CODE IN (SELECT SUBINV_CODE FROM HLDC_PO_SUBINVENTORY WHERE UPJANG = '" + UPJANG + "' AND SUBINV_CODE LIKE 'C%')                                                          \n");
        sbSql.append("                                         GROUP BY PHYSIC_DATE, SUBINV_CODE, ITEM_CODE) B                                                                                                              \n");
        sbSql.append("                                 WHERE A.PHYSIC_DATE = B.PHYSIC_DATE                                                                                                                                  \n");
        sbSql.append("                                   AND A.SUBINV_CODE = B.SUBINV_CODE                                                                                                                                  \n");
        sbSql.append("                                   AND A.ITEM_CODE = B.ITEM_CODE                                                                                                                                      \n");
        sbSql.append("                                   AND A.UPDATE_DATE = B.UPDATE_DATE                                                                                                                                  \n");
        sbSql.append("                               ) C                                                                                                                                                                    \n");
        sbSql.append("                         WHERE A.ITEM_CODE   = B.ITEM_CODE                                                                                                                                            \n");
        sbSql.append("                           AND A.PHYSIC_ID   = C.PHYSIC_ID                                                                                                                                            \n");
        sbSql.append("                           AND A.SUBINV_CODE IN (SELECT SUBINV_CODE FROM HLDC_PO_SUBINVENTORY WHERE UPJANG = '" + UPJANG + "')                                                                        \n");
        sbSql.append("                           AND A.PHYSIC_DATE BETWEEN '" + START_DATE + "' AND '" + END_DATE + "' -- 조사일                                                                                            \n");
        sbSql.append("                           AND (A.PHYSIC_QTY <> 0 OR A.LOSS_QTY <> 0)                                                                                                                                 \n");
        sbSql.append("                           AND C.CANCEL_YN = 'N'                                                                                                                                                      \n");
        sbSql.append("                         GROUP BY C.PHYSIC_DATE                                                                                                                                                       \n");
        sbSql.append("                       ) B                                                                                                                                                                            \n");
        sbSql.append("                 WHERE A.BASE_DD = B.BASE_DD(+)                                                                                                                                                       \n");
        sbSql.append("                 GROUP BY A.BASE_DD                                                                                                                                                                   \n");
        sbSql.append("               ) A                                                                                                                                                                                    \n");
        sbSql.append("         GROUP BY A.BASE_DD, A.STOCK_AMT                                                                                                                                                              \n");
        sbSql.append("       ) I                                                                                                                                                                                            \n");
        sbSql.append("     , (                                                                                                                                                                                              \n");
        sbSql.append("        SELECT BASE_DD                                                                                                                                                                                \n");
        sbSql.append("             , ROUND(DECODE(SUM(SALE_AMT),0,0,SUM(EXPECT_COST) / SUM(SALE_AMT)) * 100,1) EXPECT_RATE                                                                                                  \n");
        sbSql.append("             , SUM(EXPECT_COST) EXPECT_COST                                                                                                                                                           \n");
        sbSql.append("             , SUM(SALE_AMT) EXPECT_SALE                                                                                                                                                              \n");
        sbSql.append("          FROM (                                                                                                                                                                                      \n");
        sbSql.append("                SELECT A.MENU_DATE AS BASE_DD                                                                                                                                                         \n");
        sbSql.append("                     , SUM(A.SALE_PRICE * A.EXPECT_MEAL_QTY) SALE_AMT                                                                                                                                 \n");
        sbSql.append("                     , 0 EXPECT_COST                                                                                                                                                                  \n");
        sbSql.append("                  FROM FSM_REAL_MENU_MST A                                                                                                                                                            \n");
        sbSql.append("                     , SCC_COMMON_CODE B                                                                                                                                                              \n");
        sbSql.append("                 WHERE SUBSTR(A.HALL_CD,1,3) = B.CODE                                                                                                                                                 \n");
        sbSql.append("                   AND B.GROUP_CODE= 'FS0019'                                                                                                                                                         \n");
        sbSql.append("                   AND A.MENU_DATE BETWEEN '" + START_DATE + "' AND '" + END_DATE + "'                                                                                                                \n");
        sbSql.append("                   AND A.UPJANG = '" + UPJANG + "'                                                                                                                                                    \n");
        sbSql.append("                   AND B.ATTR02 <> 'Y'                                                                                                                                                                \n");
        sbSql.append("                   AND EXISTS (SELECT 1 FROM FSM_REAL_RECIPE_ITEM X WHERE X.UPJANG = A.UPJANG AND X.MENU_CD = A.MENU_CD AND ROWNUM = 1)                                                               \n");
        sbSql.append("                 GROUP BY A.MENU_DATE                                                                                                                                                                 \n");
        sbSql.append("                UNION ALL                                                                                                                                                                             \n");
        sbSql.append("                SELECT A.MENU_DATE AS BASE_DD                                                                                                                                                         \n");
        sbSql.append("                     , SUM(C.SALE_PRICE * C.EXPECT_SALE_QTY) SALE_AMT                                                                                                                                 \n");
        sbSql.append("                     , 0 EXPECT_COST                                                                                                                                                                  \n");
        sbSql.append("                  FROM FSM_REAL_MENU_MST A                                                                                                                                                            \n");
        sbSql.append("                     , SCC_COMMON_CODE B                                                                                                                                                              \n");
        sbSql.append("                     , FSM_REAL_RECIPE_MST C                                                                                                                                                          \n");
        sbSql.append("                 WHERE SUBSTR(A.HALL_CD,1,3) = B.CODE                                                                                                                                                 \n");
        sbSql.append("                   AND A.UPJANG = C.UPJANG                                                                                                                                                            \n");
        sbSql.append("                   AND A.MENU_CD = C.MENU_CD                                                                                                                                                          \n");
        sbSql.append("                   AND B.GROUP_CODE = 'FS0019'                                                                                                                                                        \n");
        sbSql.append("                   AND A.MENU_DATE BETWEEN '" + START_DATE + "' AND '" + END_DATE + "'                                                                                                                \n");
        sbSql.append("                   AND A.UPJANG = '" + UPJANG + "'                                                                                                                                                    \n");
        sbSql.append("                   AND B.ATTR02 = 'Y'                                                                                                                                                                 \n");
        sbSql.append("                   AND EXISTS (SELECT 1 FROM FSM_REAL_RECIPE_ITEM X WHERE X.UPJANG = A.UPJANG AND X.MENU_CD = A.MENU_CD AND ROWNUM = 1)                                                               \n");
        sbSql.append("                 GROUP BY A.MENU_DATE                                                                                                                                                                 \n");
        sbSql.append("                UNION ALL                                                                                                                                                                             \n");
        sbSql.append("                SELECT MENU_DATE AS BASE_DD                                                                                                                                                           \n");
        sbSql.append("                     , 0 SALE_AMT                                                                                                                                                                     \n");
        sbSql.append("                     , SUM(EXPECT_COST) EXPECT_COST                                                                                                                                                   \n");
        sbSql.append("                  FROM (                                                                                                                                                                              \n");
        sbSql.append("                        SELECT A.UPJANG                                                                                                                                                               \n");
        sbSql.append("                             , A.MENU_CD                                                                                                                                                              \n");
        sbSql.append("                             , A.MENU_DATE                                                                                                                                                            \n");
        sbSql.append("                             , A.RECIPE_CD                                                                                                                                                            \n");
        sbSql.append("                             , ROUND(SUM(A.NEED_QTY*ROUND((A.MARGIN_PRICE/B.KG_CONVERT_RATE/1000),2))) * A.QTY AS EXPECT_COST                                                                         \n");
        sbSql.append("                          FROM HLDC_PO_ITEM_MST B                                                                                                                                                     \n");
        sbSql.append("                             , (                                                                                                                                                                      \n");
        sbSql.append("                                SELECT A.UPJANG                                                                                                                                                       \n");
        sbSql.append("                                     , A.MENU_CD                                                                                                                                                      \n");
        sbSql.append("                                     , A.MENU_DATE                                                                                                                                                    \n");
        sbSql.append("                                     , B.RECIPE_CD                                                                                                                                                    \n");
        sbSql.append("                                     , C.ITEM_CODE                                                                                                                                                    \n");
        sbSql.append("                                     , DECODE(E.ATTR02,'Y', B.EXPECT_SALE_QTY, DECODE(E.SET3, 'Y', B.EXPECT_SALE_QTY, A.EXPECT_MEAL_QTY)) QTY                                                         \n");
        sbSql.append("                                     , C.NEED_QTY                                                                                                                                                     \n");
        sbSql.append("                                     , C.MARGIN_PRICE                                                                                                                                                 \n");
        sbSql.append("                                  FROM FSM_REAL_MENU_MST A                                                                                                                                            \n");
        sbSql.append("                                     , FSM_REAL_RECIPE_MST B                                                                                                                                          \n");
        sbSql.append("                                     , FSM_REAL_RECIPE_ITEM C                                                                                                                                         \n");
        sbSql.append("                                     , (SELECT * FROM SCC_COMMON_CODE WHERE GROUP_CODE= 'FS0019') E                                                                                                   \n");
        sbSql.append("                                 WHERE A.UPJANG = B.UPJANG                                                                                                                                            \n");
        sbSql.append("                                   AND A.MENU_CD = B.MENU_CD                                                                                                                                          \n");
        sbSql.append("                                   AND B.UPJANG = C.UPJANG                                                                                                                                            \n");
        sbSql.append("                                   AND B.MENU_CD = C.MENU_CD                                                                                                                                          \n");
        sbSql.append("                                   AND B.RECIPE_CD = C.RECIPE_CD                                                                                                                                      \n");
        sbSql.append("                                   AND SUBSTR(A.HALL_CD,1,3) = E.CODE                                                                                                                                 \n");
        sbSql.append("                                   AND A.MENU_DATE BETWEEN '" + START_DATE + "' AND '" + END_DATE + "'                                                                                                \n");
        sbSql.append("                                   AND A.UPJANG = '" + UPJANG + "'                                                                                                                                    \n");
        sbSql.append("                               ) A                                                                                                                                                                    \n");
        sbSql.append("                         WHERE A.ITEM_CODE = B.ITEM_CODE                                                                                                                                              \n");
        sbSql.append("                         GROUP BY A.UPJANG, A.MENU_CD, A.MENU_DATE, A.RECIPE_CD, A.QTY                                                                                                                \n");
        sbSql.append("                       )                                                                                                                                                                              \n");
        sbSql.append("                 GROUP BY MENU_DATE                                                                                                                                                                   \n");
        sbSql.append("               )                                                                                                                                                                                      \n");
        sbSql.append("         GROUP BY BASE_DD                                                                                                                                                                             \n");
        sbSql.append("        ) J                                                                                                                                                                                           \n");
        sbSql.append(" WHERE A.BASE_DD = B.BASE_DD(+)                                                                                                                                                                       \n");
        sbSql.append("   AND A.BASE_DD = C.BASE_DD(+)                                                                                                                                                                       \n");
        sbSql.append("   AND A.BASE_DD = D.BASE_DD(+)                                                                                                                                                                       \n");
        sbSql.append("   AND A.BASE_DD = E.BASE_DD(+)                                                                                                                                                                       \n");
        sbSql.append("   AND A.BASE_DD = F.BASE_DD(+)                                                                                                                                                                       \n");
        sbSql.append("   AND A.BASE_DD = I.BASE_DD(+)                                                                                                                                                                       \n");
        sbSql.append("   AND A.BASE_DD = J.BASE_DD(+)                                                                                                                                                                       \n");
        sbSql.append(" ORDER BY A.BASE_DD ASC                                                                                                                                                                               \n");
		
	    //SQL 실행
	    pstmt = conn.prepareStatement(sbSql.toString());
		
	    //RecordSet에 데이터 담기
	    rs = pstmt.executeQuery();
		
		//데이터셋만들기
		ds_dailyList = this.makeDataSet(rs, "ds_dailyList");
	
		/**종료**/
		out_dl.add(ds_dailyList);
		this.setResultMessage(0, "OK", out_vl);
	}
	catch(Exception ex)
	{
		//jsp 로그남기기
		logger.debug(ex.getMessage(), ex);
		//메세지반환
		this.setResultMessage(-1, ex.toString(),out_vl);  
	}
	finally {
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
		if(stmt != null) {
			try {
				stmt.close();
			}catch(Exception e) {} 
		}
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