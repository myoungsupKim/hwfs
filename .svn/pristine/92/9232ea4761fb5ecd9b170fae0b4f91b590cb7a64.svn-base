<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 
■ 프로그램ID   : FSM00370V_S001.jsp
■ 프로그램명   : 식재료율 실적조회(관리자용)
■ 작성일자     : 
■ 작성자       : 
■ 이력관리     : 1)박은규 2012-11-05 CSR#(CH201210_00143) 요청자:박현정(FS기획팀)
               sc조회조건 추가(공통:MA0046)
-----------------------------------------------------------------------------*/
%>
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
		DataSet ds_input     = in_dl.get("ds_input");
		
		//출력 데이타셋 선언
		DataSet ds_list;
		
		String SAUP_TYPE = ds_input.getString(0,"SAUP_TYPE");
		String TM_CD = ds_input.getString(0,"TM_CD");
		//String TM_NM = ds_input.getString(0,"TM_NM");
		String JOB_CD = ds_input.getString(0,"JOB_CD");
		String SUB_JOB_CD = ds_input.getString(0,"SUB_JOB_CD");
		String UPJANG = ds_input.getString(0,"UPJANG");
		//String UPJANG_NM = ds_input.getString(0,"UPJANG_NM");
		String START_DATE = ds_input.getString(0,"START_DATE");
		String END_DATE = ds_input.getString(0,"END_DATE");
		String PRICE_TYPE = ds_input.getString(0,"PRICE_TYPE");
		String LOC_CD = ds_input.getString(0,"LOC_CD");
		String OPEN_TYPE = ds_input.getString(0,"OPEN_TYPE");
		String CHK_HIS = ds_input.getString(0,"CHK_HIS");

		String strSCLst        = nullToBlank(in_vl.getString("strSCLst"));
		
		String LAST_MONTH   = "";
		String ONHAND_MONTH = "";
		String FROM_DATE    = "";
		
		String V_MONTH  = "";
		String V_FROM_DATE = "";
		
		String V_AMOUNT = "";
		String V_PRICE  = "";
		String V_MAM_FS_PL_V = "";
		String V_MAF_FS_SALE_V = "";
		
		stmt 		=  conn.createStatement();                                  //실행명령 선언
		StringBuffer sbSql = new StringBuffer();										//SQL버퍼  선언

		//SQL버퍼 clear
		sbSql.delete(0, sbSql.length());	
				

		//PRICE_TYPE : 관리, 재무 
		//재무를 선택했을 경우 MARGIN_AMOUNT => UNIT_AMOUNT, MARGIN_PRICE => UNIT_PRICE 로 변경한다.
		//계획의 경우 관리일 경우 MAM_FS_PL_V, 재무일 경우  MAM_FS_PL_V1
		if(PRICE_TYPE.equals("관리"))
		{
			V_AMOUNT = "MARGIN_AMOUNT";
			V_PRICE  = "MARGIN_PRICE";
			V_MAM_FS_PL_V = "MAM_FS_PL_V";
			V_MAF_FS_SALE_V = "MAF_FS_SALE_V";
		}
		else
		{
			V_AMOUNT = "UNIT_AMOUNT";
			V_PRICE  = "UNIT_PRICE";
			V_MAM_FS_PL_V = "MAM_FS_PL_V1";
			V_MAF_FS_SALE_V = "MAF_FS_SALE_V";
		}
	    
	
		// 조회시 사전 실행 쿼리 -- '20080101' => 시작기간 
		sbSql.append(" SELECT TO_CHAR(ADD_MONTHS(TO_DATE(SUBSTR('"+ START_DATE +"',1,6),'YYYYMM'), -1), 'YYYYMM') LAST_MONTH  \n ");
		sbSql.append("      , NVL(MAX(ONHAND_YM),'200101') ONHAND_MONTH                                                       \n ");
		sbSql.append("      , TO_CHAR(ADD_MONTHS(TO_DATE(NVL(MAX(ONHAND_YM),'200101'),'YYYYMM'),1),'YYYYMM')||'01' FROM_DATE  \n ");
		sbSql.append("   FROM HLDC_PO_ONHAND_MONTH A                                                                          \n ");
		sbSql.append("  WHERE SUBINV_CODE = 'C1000001'                                                                        \n ");

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
		
		//데이터를 삭제한다.
		sbSql.delete(0, sbSql.length());
		
		
		//운영부서 선택시 
		if((!TM_CD.equals(""))||(!UPJANG.equals("")))
		{
			sbSql.append(" SELECT DECODE(B.OPEN_YY, TO_CHAR(SYSDATE,'YYYY'),'신규','기존') AS OPEN_TYPE,  B.LOC_NAME,  B.JOB_NAME                                                                                                                                                                                                                                                                     \n ");               
			sbSql.append("      , B.SUB_JOB_NAME                                                                                                                                                                                                                                                                 \n ");
			sbSql.append("      , B.UPJANG                                                                                                                                                                                                                                                                     \n ");
			sbSql.append("      , B.UPJANGNM                                                                                                                                                                                                                                                                     \n ");
			sbSql.append("      , SUM(PLAN_TRX_AMT)  PLAN_TRX_AMT    --당월계획                                                                                                                                                                                                                                  \n ");
			sbSql.append("      , SUM(PROSPECT_TRX_AMT) PROSPECT_TRX_AMT --기간전망                                                                                                                                                                                                                              \n ");
			sbSql.append("      , SUM(RESULT_TRX_AMT)  RESULT_TRX_AMT  --기간실적                                                                                                                                                                                                                                \n ");
			sbSql.append("      , ROUND(DECODE(SUM(PLAN_TRX_AMT),0,0, SUM(RESULT_TRX_AMT)/SUM(PLAN_TRX_AMT)*100),1) AS AMT_PLAN_COMP_RATE         --계획대비                                                                                                                                                        \n ");
			sbSql.append("      , ROUND(DECODE(SUM(PROSPECT_TRX_AMT),0,0, SUM(RESULT_TRX_AMT)/SUM(PROSPECT_TRX_AMT)*100),1) AS AMT_PRO_COMP_RATE  --전망대비                                                                                                                                                        \n ");
			sbSql.append("      , SUM(TRANS_COST_AMT+LOCAL_COST_AMT+EMP_COST_AMT) TOTAL_COST  --식재료비합계                                                                                                                                                                                                     \n ");
			sbSql.append("      , SUM(TRANS_COST_AMT) TRANS_COST_AMT   --전산구매                                                                                                                                                                                                                                \n ");
			sbSql.append("      , SUM(LOCAL_COST_AMT) LOCAL_COST_AMT    --현지구매                                                                                                                                                                                                                               \n ");
			sbSql.append("      , SUM(EMP_COST_AMT) EMP_COST_AMT     --직원식대                                                                                                                                                                                                                                \n ");
			sbSql.append("      , SUM(PLAN_RATE)  PLAN_RATE       --당월계획                                                                                                                                                                                                                                     \n ");
			sbSql.append("      , SUM(PROSPECT_RATE) PROSPECT_RATE    --기간전망                                                                                                                                                                                                                                 \n ");
		//	sbSql.append("      , SUM(EXPECT_RATE) EXPECT_RATE      --기간예상                                                                                                                                                                                                                                   \n ");
		//	sbSql.append("      , ROUND(DECODE(SUM(EXPECT_COST),0,0,SUM(TRANS_COST_AMT+LOCAL_COST_AMT+EMP_COST_AMT)/SUM(EXPECT_COST)*100),1) RESULT_RATE           --기간실적                                                                                                                                    \n ");
		//	sbSql.append("      , ROUND(DECODE(SUM(EXPECT_COST),0,0,SUM(TRANS_COST_AMT+LOCAL_COST_AMT+EMP_COST_AMT)/SUM(EXPECT_COST)*100),1) - SUM(PLAN_RATE)    COST_PLAN_COMP_RATE   --식재료율 계획대비                                                                                                       \n ");
		//	sbSql.append("      , ROUND(DECODE(SUM(EXPECT_COST),0,0,SUM(TRANS_COST_AMT+LOCAL_COST_AMT+EMP_COST_AMT)/SUM(EXPECT_COST)*100),1) - SUM(PROSPECT_RATE) COST_PROSPECT_COMP_RATE --식재료율 전망대비                                                                                                    \n ");
		    sbSql.append("      , NVL(ROUND( DECODE(SUM(EXPECT_SALE), 0, 0, SUM(EXPECT_COST) / SUM(EXPECT_SALE) * 1000) ) / 10,0) EXPECT_RATE      --기간예상    \n ");
		 	sbSql.append("      , NVL(ROUND( DECODE(SUM(RESULT_TRX_AMT), 0, 0, ( SUM(TRANS_COST_AMT) + SUM(LOCAL_COST_AMT) + SUM(EMP_COST_AMT) ) / SUM(RESULT_TRX_AMT)) * 1000 ) / 10,0) RESULT_RATE           --기간실적   \n ");
		    sbSql.append("      , NVL(ROUND( DECODE(SUM(RESULT_TRX_AMT), 0, 0, ( SUM(TRANS_COST_AMT) + SUM(LOCAL_COST_AMT) + SUM(EMP_COST_AMT) ) / SUM(RESULT_TRX_AMT)) * 1000 ) / 10,0) - SUM(PLAN_RATE)    COST_PLAN_COMP_RATE   --식재료율 계획대비   \n ");
		    sbSql.append("      , NVL(ROUND( DECODE(SUM(RESULT_TRX_AMT), 0, 0, ( SUM(TRANS_COST_AMT) + SUM(LOCAL_COST_AMT) + SUM(EMP_COST_AMT) ) / SUM(RESULT_TRX_AMT)) * 1000 ) / 10,0) - SUM(PROSPECT_RATE) COST_PROSPECT_COMP_RATE --식재료율 전망대비  \n ");
		    
		    sbSql.append("      , SUM(STOCK_AMT)  STOCK_AMT       --재고금액                                                                                                                                                                                                                                     \n ");
			sbSql.append("      , SUM(GOAL_STOCK_RATE)   GOAL_STOCK_RATE      --월말목표                                                                                                                                                                                                                         \n ");
			sbSql.append("      , ROUND(DECODE(SUM(TRANS_COST_AMT+LOCAL_COST_AMT+EMP_COST_AMT),0,0,(SUM(STOCK_AMT)/SUM(TRANS_COST_AMT+LOCAL_COST_AMT+EMP_COST_AMT))*100),1) RESULT_STOCK_RATE --재고실적                                                                                                               \n ");
			sbSql.append("      , ROUND(DECODE(SUM(TRANS_COST_AMT+LOCAL_COST_AMT+EMP_COST_AMT),0,0,(SUM(STOCK_AMT)/SUM(TRANS_COST_AMT+LOCAL_COST_AMT+EMP_COST_AMT))*100),1) - SUM(GOAL_STOCK_RATE) STOCK_GAP --재고차이                                                                                                \n ");
		
			sbSql.append("      , SUM(EXPECT_SALE)   EXPECT_SALE --예상매출   \n ");
			sbSql.append("      , SUM(EXPECT_COST)   EXPECT_COST --예상식재료비      \n ");
			sbSql.append("      , SUM(PLAN_COST)     PLAN_COST  --계획식재료비    \n ");
			sbSql.append("      , SUM(PROSPECT_COST) PROSPECT_COST --전망식재료비   \n ");
			
			sbSql.append(" FROM (                                                                                                                                                                                                                                                                                \n ");
			sbSql.append("         -- 당월계획                                                                                                                                                                                                                                                                   \n ");
			sbSql.append("         SELECT UPJANG                                                                                                                                                                                                                                                                 \n ");
			sbSql.append("              , SUM(AMT) PLAN_TRX_AMT                                                                                                                                                                                                                                                  \n ");
			sbSql.append("              , 0 PROSPECT_TRX_AMT                                                                                                                                                                                                                                                     \n ");
			sbSql.append("              , 0 RESULT_TRX_AMT                                                                                                                                                                                                                                                       \n ");
			sbSql.append("              , 0 TRANS_COST_AMT                                                                                                                                                                                                                                                       \n ");
			sbSql.append("              , 0 LOCAL_COST_AMT                                                                                                                                                                                                                                                       \n ");
			sbSql.append("              , 0 EMP_COST_AMT                                                                                                                                                                                                                                                         \n ");
			sbSql.append("              , 0 PLAN_RATE                                                                                                                                                                                                                                                            \n ");
			sbSql.append("              , 0 PROSPECT_RATE                                                                                                                                                                                                                                                        \n ");
			sbSql.append("              , 0 GOAL_RATE                                                                                                                                                                                                                                                            \n ");
			sbSql.append("              , 0 EXPECT_RATE                                                                                                                                                                                                                                                          \n ");
			sbSql.append("              , 0 EXPECT_COST                                                                                                                                                                                                                                                          \n ");
			sbSql.append("              , 0 PLAN_COST                                  \n ");
			sbSql.append("              , 0 PROSPECT_COST                              \n ");
			sbSql.append("              , 0 EXPECT_SALE                                \n ");
			sbSql.append("              , 0 STOCK_AMT                                                                                                                                                                                                                                                            \n ");
			sbSql.append("              , 0 GOAL_STOCK_RATE                                                                                                                                                                                                                                                      \n ");
			sbSql.append("           FROM " + V_MAM_FS_PL_V + "                                                                                                                                                                                                                                                            \n ");
			sbSql.append("          WHERE YYMM = SUBSTR('"+ START_DATE +"',1,6)                                                                                                                                                                                                                                  \n ");
			sbSql.append("            AND MGMT_ACCT_CD IN ('PLA10000','PLA30000')                                                                                                                                                                                                                                \n ");
			sbSql.append("            AND DATA_CLASS = 'P'                                                                                                                                                                                                                                                       \n ");
			sbSql.append("          GROUP BY UPJANG                                                                                                                                                                                                                                                              \n ");
			sbSql.append("         UNION ALL                                                                                                                                                                                                                                                                     \n ");
			sbSql.append("         --기간전망                                                                                                                                                                                                                                                                    \n ");
			sbSql.append("         SELECT UPJANG                                                                                                                                                                                                                                                                 \n ");
			sbSql.append("              , 0 PLAN_TRX_AMT                                                                                                                                                                                                                                                         \n ");
			sbSql.append("              , SUM(NVL(FOOD_SALEAMT,0)+NVL(ETC_SALEAMT,0)) PROSPECT_TRX_AMT                                                                                                                                                                                                           \n ");
			sbSql.append("              , 0 RESULT_TRX_AMT                                                                                                                                                                                                                                                       \n ");
			sbSql.append("              , 0 TRANS_COST_AMT                                                                                                                                                                                                                                                       \n ");
			sbSql.append("              , 0 LOCAL_COST_AMT                                                                                                                                                                                                                                                       \n ");
			sbSql.append("              , 0 EMP_COST_AMT                                                                                                                                                                                                                                                         \n ");
			sbSql.append("              , 0 PLAN_RATE                                                                                                                                                                                                                                                            \n ");
			sbSql.append("              , 0 PROSPECT_RATE                                                                                                                                                                                                                                                        \n ");
			sbSql.append("              , 0 GOAL_RATE                                                                                                                                                                                                                                                            \n ");
			sbSql.append("              , 0 EXPECT_RATE                                                                                                                                                                                                                                                          \n ");
			sbSql.append("              , 0 EXPECT_COST                                                                                                                                                                                                                                                          \n ");
			sbSql.append("              , 0 PLAN_COST                                  \n ");
			sbSql.append("              , 0 PROSPECT_COST                              \n ");
			sbSql.append("              , 0 EXPECT_SALE                                \n ");
			sbSql.append("              , 0 STOCK_AMT                                                                                                                                                                                                                                                            \n ");
			sbSql.append("              , 0 GOAL_STOCK_RATE                                                                                                                                                                                                                                                      \n ");
			sbSql.append("           FROM " + V_MAF_FS_SALE_V + "                                                                                                                                                                                                                                                          \n ");
			sbSql.append("          WHERE SALE_DATE BETWEEN '"+ START_DATE +"' AND '"+ END_DATE +"'                                                                                                                                                                                                              \n ");
			sbSql.append("          GROUP BY UPJANG                                                                                                                                                                                                                                                              \n ");
			sbSql.append("         UNION ALL                                                                                                                                                                                                                                                                     \n ");
			sbSql.append("         -- 기간실적                                                                                                                                                                                                                                                                   \n ");
			sbSql.append("         SELECT UPJANG                                                                                                                                                                                                                                                                 \n ");
			sbSql.append("              , 0 PLAN_TRX_AMT                                                                                                                                                                                                                                                         \n ");
			sbSql.append("              , 0 PROSPECT_TRX_AMT                                                                                                                                                                                                                                                     \n ");
			sbSql.append("              , ROUND(SUM(DECODE(CUSTCD, 999991, AMT, DECODE(TAX_KIND, '310', AMT / 1.1, AMT)))) RESULT_TRX_AMT                                                                                                                                                                                                     \n ");
			sbSql.append("              , 0 TRANS_COST_AMT                                                                                                                                                                                                                                                       \n ");
			sbSql.append("              , 0 LOCAL_COST_AMT                                                                                                                                                                                                                                                       \n ");
			sbSql.append("              , 0 EMP_COST_AMT                                                                                                                                                                                                                                                         \n ");
			sbSql.append("              , 0 PLAN_RATE                                                                                                                                                                                                                                                            \n ");
			sbSql.append("              , 0 PROSPECT_RATE                                                                                                                                                                                                                                                        \n ");
			sbSql.append("              , 0 GOAL_RATE                                                                                                                                                                                                                                                            \n ");
			sbSql.append("              , 0 EXPECT_RATE                                                                                                                                                                                                                                                          \n ");
			sbSql.append("              , 0 EXPECT_COST                                                                                                                                                                                                                                                          \n ");
			sbSql.append("              , 0 PLAN_COST                                  \n ");
			sbSql.append("              , 0 PROSPECT_COST                              \n ");
			sbSql.append("              , 0 EXPECT_SALE                                \n ");
			sbSql.append("              , 0 STOCK_AMT                                                                                                                                                                                                                                                            \n ");
			sbSql.append("              , 0 GOAL_STOCK_RATE                                                                                                                                                                                                                                                      \n ");
			sbSql.append("           FROM MAS_TRX                                                                                                                                                                                                                                                                \n ");
			sbSql.append("          WHERE TRX_DATE BETWEEN '"+ START_DATE +"' AND '"+ END_DATE +"'                                                                                                                                                                                                               \n ");
			sbSql.append("            AND CR_ACCTCD IN ('4010221', '4010299')                                                                                                                                                                                                                                    \n ");
			sbSql.append("          GROUP BY UPJANG                                                                                                                                                                                                                                                              \n ");
			sbSql.append("         UNION ALL                                                                                                                                                                                                                                                                     \n ");
			sbSql.append("         --전산구매,현지구매                                                                                                                                                                                                                                                                    \n ");
			sbSql.append("         SELECT TRANS_UPJANG                                                                                                                                                                                                                                                           \n ");
			sbSql.append("              , 0 PLAN_TRX_AMT                                                                                                                                                                                                                                                         \n ");
			sbSql.append("              , 0 PROSPECT_TRX_AMT                                                                                                                                                                                                                                                     \n ");
			sbSql.append("              , 0 RESULT_TRX_AMT                                                                                                                                                                                                                                                       \n ");
			sbSql.append("              , SUM(DECODE(CODE,NULL,TRANS_COST_AMT,0)) TRANS_COST_AMT                                                                                                                                                                                                                                    \n ");
			sbSql.append("              , SUM(DECODE(CODE,NULL,0,TRANS_COST_AMT)) LOCAL_COST_AMT                                                                                                                                                                                                                                                       \n ");
			sbSql.append("              , 0 EMP_COST_AMT                                                                                                                                                                                                                                                         \n ");
			sbSql.append("              , 0 PLAN_RATE                                                                                                                                                                                                                                                            \n ");
			sbSql.append("              , 0 PROSPECT_RATE                                                                                                                                                                                                                                                        \n ");
			sbSql.append("              , 0 GOAL_RATE                                                                                                                                                                                                                                                            \n ");
			sbSql.append("              , 0 EXPECT_RATE                                                                                                                                                                                                                                                          \n ");
			sbSql.append("              , 0 EXPECT_COST                                                                                                                                                                                                                                                          \n ");
			sbSql.append("              , 0 PLAN_COST                                  \n ");
			sbSql.append("              , 0 PROSPECT_COST                              \n ");
			sbSql.append("              , 0 EXPECT_SALE                                \n ");
			sbSql.append("              , 0 STOCK_AMT                                                                                                                                                                                                                                                            \n ");
			sbSql.append("              , 0 GOAL_STOCK_RATE                                                                                                                                                                                                                                                      \n ");
			sbSql.append("           FROM (                                                                                                                                                                                                                                                                      \n ");
			if (CHK_HIS.equals("0"))
			{
				sbSql.append("                SELECT /*+ LEADING(A B C) USE_HASH(A B C) INDEX(A PO_TRANSACTION_IE3) */ TRANS_UPJANG,C.CODE,                                                                                                                                                                                                                                                   \n ");
				sbSql.append("                       NVL( DECODE(B.OUTVAT_FLAG, 'Y', ROUND( SUM( "+ V_AMOUNT +" * DECODE( TAX_CODE, '100', DECODE( MATERIAL_ACCTCD, '1120311', 1.1, 1), 1) ) ), SUM( "+ V_AMOUNT +" ) ), 0) TRANS_COST_AMT                                                                           \n ");
				sbSql.append("                  FROM HLDC_PO_TRANSACTION A         \n ");
			}
			else
			{
				sbSql.append("                SELECT TRANS_UPJANG,C.CODE,                                                                                                                                                                                                                                                   \n ");
				sbSql.append("                       NVL( DECODE(B.OUTVAT_FLAG, 'Y', ROUND( SUM( "+ V_AMOUNT +" * DECODE( TAX_CODE, '100', DECODE( MATERIAL_ACCTCD, '1120311', 1.1, 1), 1) ) ), SUM( "+ V_AMOUNT +" ) ), 0) TRANS_COST_AMT                                                                           \n ");
				sbSql.append("                  FROM HLDC_HIS_PO_TRANSACTION_201312 A         \n ");
			}
			sbSql.append("                     , HLDC_PO_SUBINVENTORY B,  (SELECT * FROM SCC_COMMON_CODE X WHERE X.GROUP_CODE = 'MA0132') C                                                                           \n ");
			sbSql.append("                 WHERE A.SUBINV_CODE = B.SUBINV_CODE                                                                                                                                                                                                                                   \n ");
			sbSql.append("                   AND TRANS_DATE BETWEEN '"+ START_DATE +"' AND '"+ END_DATE +"'                                                                                                                                                                                                      \n ");
			sbSql.append("                   AND TRIM(TRANS_TYPE) LIKE 'O%'                                                                                                                                                                                                                                            \n ");
			sbSql.append("                   AND TRANS_TYPE <> 'O002'                                                                                                                                                                                                                                            \n ");
			sbSql.append("                   AND A.ACCTCD = '4020231'                                                                                                                                                                                                                                            \n ");
			sbSql.append("                   AND A.ITEM_CODE = C.CODE(+)                                                                                                                                                             \n ");
			sbSql.append("                 GROUP BY TRANS_UPJANG, B.OUTVAT_FLAG, C.CODE                                                                                                                                                                                                                                  \n ");
			sbSql.append("                )                                                                                                                                                                                                                                                                      \n ");
			sbSql.append("          GROUP BY TRANS_UPJANG                                                                                                                                                                                                                                                        \n ");

			sbSql.append("         UNION ALL                                                                                                                                                                                                                                              \n ");

			sbSql.append("         --2009.01 부터 현지구매 => 전도금정산에서 구매연동없슴.100%원가처리 \n ");
			sbSql.append("         SELECT TRANS_UPJANG                                                                                                                                                                                                                                                           \n ");
			sbSql.append("              , 0 PLAN_TRX_AMT                                                                                                                                                                                                                                                         \n ");
			sbSql.append("              , 0 PROSPECT_TRX_AMT                                                                                                                                                                                                                                                     \n ");
			sbSql.append("              , 0 RESULT_TRX_AMT                                                                                                                                                                                                                                                       \n ");
			sbSql.append("              , 0 TRANS_COST_AMT                                                                                                                                                                                                                                                       \n ");
			sbSql.append("              , SUM(LOCAL_COST_AMT) LOCAL_COST_AMT                                                                                                                                                                                                                                     \n ");
			sbSql.append("              , 0 EMP_COST_AMT                                                                                                                                                                                                                                                         \n ");
			sbSql.append("              , 0 PLAN_RATE                                                                                                                                                                                                                                                            \n ");
			sbSql.append("              , 0 PROSPECT_RATE                                                                                                                                                                                                                                                        \n ");
			sbSql.append("              , 0 GOAL_RATE                                                                                                                                                                                                                                                            \n ");
			sbSql.append("              , 0 EXPECT_RATE                                                                                                                                                                                                                                                          \n ");
			sbSql.append("              , 0 EXPECT_COST                                                                                                                                                                                                                                                          \n ");
			sbSql.append("              , 0 PLAN_COST                                  \n ");
			sbSql.append("              , 0 PROSPECT_COST                              \n ");
			sbSql.append("              , 0 EXPECT_SALE                                \n ");
			sbSql.append("              , 0 STOCK_AMT                                                                                                                                                                                                                                                            \n ");
 			sbSql.append("              , 0 GOAL_STOCK_RATE                                                                                                                                                                                                                                                      \n ");
			sbSql.append("           FROM (                                                                                                                                                                                                                                                                      \n ");	
			sbSql.append("                SELECT A.UPJANG TRANS_UPJANG,                                                                                                                                                                                                                                          \n ");	
			sbSql.append("                       NVL(SUM(DECODE((SELECT SCHOOL_YN FROM HLDC_ST_UPJANG WHERE UPJANG = A.UPJANG), 'Y', A.AMT, A.ADJ_AMT)), 0)  LOCAL_COST_AMT                                                                                                                                      \n ");	
			sbSql.append("                 FROM MAS_ADVANCE A                                                                                                                                                                                                                                                    \n ");	
			sbSql.append("                 WHERE (A.ADJ_DATE BETWEEN '20090101' AND '99999999')                                                                                                                                                                                                                  \n ");	
			sbSql.append("                 AND   (A.ADJ_DATE BETWEEN '"+ START_DATE +"' AND '"+ END_DATE +"')                                                                                                                                                                                                    \n ");	
			sbSql.append("                 AND   (A.ACCTCD   =  '1120311')                                                                                                                                                                                                                                       \n ");	
			sbSql.append("                 GROUP BY A.UPJANG                              		                                                                                                                                                                                                                   \n ");
			sbSql.append("                )                                                                                                                                                                                                                                                                      \n ");
			sbSql.append("          GROUP BY TRANS_UPJANG                                                                                                                                                                                                                                                        \n ");
			sbSql.append("         UNION ALL                                                                                                                                                                                                                                                                     \n ");	

			sbSql.append("         --직원식대                                                                                                                                                                                                                                                                    \n ");
			sbSql.append("         SELECT UPJANG                                                                                                                                                                                                                                                                 \n ");
			sbSql.append("              , 0 PLAN_TRX_AMT                                                                                                                                                                                                                                                         \n ");
			sbSql.append("              , 0 PROSPECT_TRX_AMT                                                                                                                                                                                                                                                     \n ");
			sbSql.append("              , 0 RESULT_TRX_AMT                                                                                                                                                                                                                                                       \n ");
			sbSql.append("              , 0 TRANS_COST_AMT                                                                                                                                                                                                                                                       \n ");
			sbSql.append("              , 0 LOCAL_COST_AMT                                                                                                                                                                                                                                                       \n ");
			sbSql.append("              , SUM(OP_MANS * 1500 * -1) EMP_COST_AMT                                                                                                                                                                                                                                  \n ");
			sbSql.append("              , 0 PLAN_RATE                                                                                                                                                                                                                                                            \n ");
			sbSql.append("              , 0 PROSPECT_RATE                                                                                                                                                                                                                                                        \n ");
			sbSql.append("              , 0 GOAL_RATE                                                                                                                                                                                                                                                            \n ");
			sbSql.append("              , 0 EXPECT_RATE                                                                                                                                                                                                                                                          \n ");
			sbSql.append("              , 0 EXPECT_COST                                                                                                                                                                                                                                                          \n ");
			sbSql.append("              , 0 PLAN_COST                                  \n ");
			sbSql.append("              , 0 PROSPECT_COST                              \n ");
			sbSql.append("              , 0 EXPECT_SALE                                \n ");
			sbSql.append("              , 0 STOCK_AMT                                                                                                                                                                                                                                                            \n ");
			sbSql.append("              , 0 GOAL_STOCK_RATE                                                                                                                                                                                                                                                      \n ");
			sbSql.append("           FROM " + V_MAF_FS_SALE_V + "                                                                                                                                                                                                                                                          \n ");
			sbSql.append("          WHERE SALE_DATE BETWEEN '"+ START_DATE +"' AND '"+ END_DATE +"'                                                                                                                                                                                                              \n ");
			sbSql.append("          GROUP BY UPJANG                                                                                                                                                                                                                                                              \n ");
			sbSql.append("         UNION ALL                                                                                                                                                                                                                                                                     \n ");
			sbSql.append("         --당월계획, 기간전망, 기간목표, 기간예상, 기간원가                                                                                                                                                                                                                            \n ");
			sbSql.append("         SELECT UPJANG                                                                                                                                                                                                                                                                 \n ");
			sbSql.append("              , 0 PLAN_TRX_AMT                                                                                                                                                                                                                                                         \n ");
			sbSql.append("              , 0 PROSPECT_TRX_AMT                                                                                                                                                                                                                                                     \n ");
			sbSql.append("              , 0 RESULT_TRX_AMT                                                                                                                                                                                                                                                       \n ");
			sbSql.append("              , 0 TRANS_COST_AMT                                                                                                                                                                                                                                                       \n ");
			sbSql.append("              , 0 LOCAL_COST_AMT                                                                                                                                                                                                                                                       \n ");
			sbSql.append("              , 0 EMP_COST_AMT                                                                                                                                                                                                                                                         \n ");
			sbSql.append("              , ROUND(SUM(DECODE(PLAN_AMT,0,0,PLAN_COST/PLAN_AMT))*100,1) PLAN_RATE                                                                                                                                                                                                    \n ");
			sbSql.append("              , ROUND(SUM(DECODE(PROSPECT_AMT,0,0,PROSPECT_COST/PROSPECT_AMT))*100,1) PROSPECT_RATE                                                                                                                                                                                    \n ");
			sbSql.append("              , 0 GOAL_RATE                                                                                                                                                                                                                                                            \n ");
			sbSql.append("              , 0 EXPECT_RATE                                                                                                                                                                                                                                                          \n ");
			sbSql.append("              , 0 EXPECT_COST                                                                                                                                                                                                                                                          \n ");
			sbSql.append("              , SUM(PLAN_COST) PLAN_COST                                  \n ");
			sbSql.append("              , SUM(PROSPECT_COST) PROSPECT_COST                              \n ");
			sbSql.append("              , 0 EXPECT_SALE                                \n ");
			sbSql.append("              , 0 STOCK_AMT                                                                                                                                                                                                                                                            \n ");
			sbSql.append("              , 0 GOAL_STOCK_RATE                                                                                                                                                                                                                                                      \n ");
			sbSql.append("           FROM (                                                                                                                                                                                                                                                                      \n ");
			sbSql.append("                 SELECT UPJANG                                                                                                                                                                                                                                                         \n ");
			sbSql.append("                      , SUM(DECODE(MGMT_ACCT_CD, 'PLA10000', AMT, 'PLA30000', AMT, 0)) PLAN_AMT                                                                                                                                                                                        \n ");
			sbSql.append("                      , SUM(DECODE(MGMT_ACCT_CD, 'PLB11000', AMT, 0)) PLAN_COST                                                                                                                                                                                                        \n ");
			sbSql.append("                      , 0 PROSPECT_COST                                                                                                                                                                                                                                                \n ");
			sbSql.append("                      , 0 PROSPECT_AMT                                                                                                                                                                                                                                                 \n ");
			sbSql.append("                   FROM " + V_MAM_FS_PL_V + "                                                                                                                                                                                                                                                    \n ");
			sbSql.append("                  WHERE DATA_CLASS = 'P'                                                                                                                                                                                                                                               \n ");
			sbSql.append("                    AND YYMM = SUBSTR('"+ START_DATE +"',1,6)                                                                                                                                                                                                                                            \n ");
			sbSql.append("                  GROUP BY UPJANG                                                                                                                                                                                                                                                      \n ");
			sbSql.append("                 UNION ALL                                                                                                                                                                                                                                                             \n ");
			sbSql.append("                 SELECT UPJANG                                                                                                                                                                                                                                                         \n ");
			sbSql.append("                      , 0 PLAN_AMT                                                                                                                                                                                                                                                     \n ");
			sbSql.append("                      , 0 PLAN_COST                                                                                                                                                                                                                                                    \n ");
			sbSql.append("                      , SUM(NVL(RAWCOST,0)) PROSPECT_COST                                                                                                                                                                                                                              \n ");
			sbSql.append("                      , SUM(NVL(FOOD_SALEAMT,0)+NVL(ETC_SALEAMT,0)) PROSPECT_AMT                                                                                                                                                                                                       \n ");
			sbSql.append("                   FROM " + V_MAF_FS_SALE_V + "                                                                                                                                                                                                                                                  \n ");
			sbSql.append("                  WHERE SALE_DATE BETWEEN '"+ START_DATE +"' AND '"+ END_DATE +"'                                                                                                                                                                                                      \n ");
			sbSql.append("                  GROUP BY UPJANG                                                                                                                                                                                                                                                      \n ");
			sbSql.append("                 )                                                                                                                                                                                                                                                                     \n ");
			sbSql.append("          GROUP BY UPJANG                                                                                                                                                                                                                                                              \n ");
			sbSql.append("          UNION ALL                                                                                                                                                                                                                                                                    \n ");
			
//			sbSql.append("          SELECT UPJANG                                                                                                                                                                                                                                                                \n ");
//			sbSql.append("              , 0 PLAN_TRX_AMT                                                                                                                                                                                                                                                         \n ");
//			sbSql.append("              , 0 PROSPECT_TRX_AMT                                                                                                                                                                                                                                                     \n ");
//			sbSql.append("              , 0 RESULT_TRX_AMT                                                                                                                                                                                                                                                       \n ");
//			sbSql.append("              , 0 TRANS_COST_AMT                                                                                                                                                                                                                                                       \n ");
//			sbSql.append("              , 0 LOCAL_COST_AMT                                                                                                                                                                                                                                                       \n ");
//			sbSql.append("              , 0 EMP_COST_AMT                                                                                                                                                                                                                                                         \n ");
//			sbSql.append("              , 0 PLAN_RATE                                                                                                                                                                                                                                                            \n ");
//			sbSql.append("              , 0 PROSPECT_RATE                                                                                                                                                                                                                                                        \n ");
//			sbSql.append("              , ROUND(SUM( DECODE(SALE_AMT,0,0,GOAL_COST / SALE_AMT) )*100,1) GOAL_RATE                                                                                                                                                                                                \n ");
//			sbSql.append("              , ROUND(SUM( DECODE(SALE_AMT,0,0,EXPECT_COST / SALE_AMT) )*100,1) EXPECT_RATE                                                                                                                                                                                            \n ");
//			sbSql.append("              , SUM(EXPECT_COST) EXPECT_COST                                                                                                                                                                                                                                           \n ");
//			sbSql.append("              , 0 STOCK_AMT                                                                                                                                                                                                                                                            \n ");
//			sbSql.append("              , 0 GOAL_STOCK_RATE                                                                                                                                                                                                                                                      \n ");
//			sbSql.append("           FROM (                                                                                                                                                                                                                                                                      \n ");
//			sbSql.append("                 SELECT A.UPJANG                                                                                                                                                                                                                                                       \n ");
//			sbSql.append("                      , SUM(A.SALE_PRICE*A.EXPECT_MEAL_QTY) SALE_AMT                                                                                                                                                                                                                   \n ");
//			sbSql.append("                      , SUM((A.SALE_PRICE*B.GOAL_COST_RATE/100)*A.EXPECT_MEAL_QTY) GOAL_COST                                                                                                                                                                                           \n ");
//			sbSql.append("                      , 0 EXPECT_COST                                                                                                                                                                                                                                                  \n ");
//			sbSql.append("                   FROM FSM_REAL_MENU_MST A                                                                                                                                                                                                                                            \n ");
//			sbSql.append("                      , FSM_GOAL_COST_RATE B                                                                                                                                                                                                                                           \n ");
//			sbSql.append("                  WHERE A.UPJANG = B.UPJANG                                                                                                                                                                                                                                            \n ");
//			sbSql.append("                    AND A.HALL_CD = B.HALL_CD                                                                                                                                                                                                                                          \n ");
//			sbSql.append("                    AND A.MENU_DATE = B.MENU_DATE                                                                                                                                                                                                                                      \n ");
//			sbSql.append("                    AND A.MENU_DATE BETWEEN '"+ START_DATE +"' AND '"+ END_DATE +"'                                                                                                                                                                                                    \n ");
//			sbSql.append("                  GROUP BY A.UPJANG                                                                                                                                                                                                                                                    \n ");
//			sbSql.append("                 UNION ALL                                                                                                                                                                                                                                                             \n ");
//			sbSql.append("                 SELECT A.UPJANG                                                                                                                                                                                                                                                       \n ");
//			sbSql.append("                      , 0 SALE_AMT                                                                                                                                                                                                                                                     \n ");
//			sbSql.append("                      , 0 GOAL_COST                                                                                                                                                                                                                                                    \n ");
//			sbSql.append("                      , SUM(B.NEED_QTY*A.EXPECT_MEAL_QTY*(B."+ V_PRICE +"/C.KG_CONVERT_RATE/1000)) EXPECT_COST  --재무일경우 B.UNIT_PRICE 사용                                                                                                                                         \n ");
//			sbSql.append("                   FROM FSM_REAL_MENU_MST A                                                                                                                                                                                                                                            \n ");
//			sbSql.append("                      , FSM_REAL_RECIPE_ITEM B                                                                                                                                                                                                                                         \n ");
//			sbSql.append("                      , HLDC_PO_ITEM_MST C                                                                                                                                                                                                                                             \n ");
//			sbSql.append("                  WHERE A.UPJANG = B.UPJANG                                                                                                                                                                                                                                            \n ");
//			sbSql.append("                    AND A.MENU_CD = B.MENU_CD                                                                                                                                                                                                                                          \n ");
//			sbSql.append("                    AND B.ITEM_CODE = C.ITEM_CODE                                                                                                                                                                                                                                      \n ");
//			sbSql.append("                    AND A.MENU_DATE BETWEEN '"+ START_DATE +"' AND '"+ END_DATE +"'                                                                                                                                                                                                    \n ");
//			sbSql.append("                  GROUP BY A.UPJANG                                                                                                                                                                                                                                                    \n ");
//			sbSql.append("                 )                                                                                                                                                                                                                                                                     \n ");
//			sbSql.append("          GROUP BY UPJANG                                                                                                                                                                                                                                                              \n ");

			sbSql.append("   SELECT UPJANG                                                                                                                                                                   \n   ");
			sbSql.append("       , 0 PLAN_TRX_AMT                                                                                                                                                            \n   ");
			sbSql.append("       , 0 PROSPECT_TRX_AMT                                                                                                                                                        \n   ");
			sbSql.append("       , 0 RESULT_TRX_AMT                                                                                                                                                          \n   ");
			sbSql.append("       , 0 TRANS_COST_AMT                                                                                                                                                          \n   ");
			sbSql.append("       , 0 LOCAL_COST_AMT                                                                                                                                                          \n   ");
			sbSql.append("       , 0 EMP_COST_AMT                                                                                                                                                            \n   ");
			sbSql.append("       , 0 PLAN_RATE                                                                                                                                                               \n   ");
			sbSql.append("       , 0 PROSPECT_RATE                                                                                                                                                           \n   ");
			sbSql.append("       , 0 GOAL_RATE                                                                                                                                                               \n   ");
			sbSql.append("       , ROUND( DECODE(SUM(SALE_AMT),0,0,SUM(EXPECT_COST) / SUM(SALE_AMT)) *100,1) EXPECT_RATE                                                                                     \n   ");
			sbSql.append("       , SUM(EXPECT_COST) EXPECT_COST                                                                                                                                              \n   ");
			sbSql.append("       , 0 PLAN_COST                                                                                                                                                               \n   ");
			sbSql.append("       , 0 PROSPECT_COST                                                                                                                                                           \n   ");
			sbSql.append("       , SUM(SALE_AMT) EXPECT_SALE                                                                                                                                                 \n   ");
			sbSql.append("       , 0 STOCK_AMT                                                                                                                                                               \n   ");
			sbSql.append("       , 0 GOAL_STOCK_RATE                                                                                                                                                         \n   ");
			sbSql.append("    FROM (                                                                                                                                                                         \n   ");
			sbSql.append("          SELECT /*+ LEADING(B A) USE_HASH(B A) */ A.UPJANG                                                                                                                                                          \n   ");
			sbSql.append("               , SUM(A.SALE_PRICE * A.EXPECT_MEAL_QTY) SALE_AMT                                                                                                                    \n   ");
			sbSql.append("               , 0 EXPECT_COST                                                                                                                                                     \n   ");
			sbSql.append("            FROM FSM_REAL_MENU_MST A                                                                                                                                               \n   ");
			sbSql.append("               , SCC_COMMON_CODE B                                                                                                                                                 \n   ");
			sbSql.append("           WHERE SUBSTR(A.HALL_CD,1,3) = B.CODE                                                                                                                                    \n   ");
			sbSql.append("             AND B.GROUP_CODE= 'FS0019'                                                                                                                                            \n   ");
			sbSql.append("             AND A.MENU_DATE BETWEEN '"+ START_DATE +"' AND '"+ END_DATE +"'                                                                                                                     \n   ");
			sbSql.append("             AND (B.ATTR02 <> 'Y' )                                                                                                                                                   \n   ");
			//식단의 자재가 있을 경우에 한해 예상 매출액 산출
			sbSql.append("             AND EXISTS (SELECT 1 FROM FSM_REAL_RECIPE_ITEM X WHERE X.UPJANG = A.UPJANG AND X.MENU_CD = A.MENU_CD AND ROWNUM = 1)                                                  \n   ");
			sbSql.append("           GROUP BY A.UPJANG                                                                                                                                                       \n   ");
			sbSql.append("          UNION ALL                                                                                                                                                                \n   ");
			sbSql.append("          SELECT /*+ LEADING(B A C) USE_NL(B A) USE_NL(C) */  A.UPJANG                                                                                                                                                          \n   ");
			sbSql.append("               , SUM(C.SALE_PRICE * C.EXPECT_SALE_QTY) SALE_AMT                                                                                                                    \n   ");
			sbSql.append("               , 0 EXPECT_COST                                                                                                                                                     \n   ");
			sbSql.append("            FROM FSM_REAL_MENU_MST A                                                                                                                                               \n   ");
			sbSql.append("               , SCC_COMMON_CODE B                                                                                                                                                 \n   ");
			sbSql.append("               , FSM_REAL_RECIPE_MST C                                                                                                                                             \n   ");
			sbSql.append("           WHERE SUBSTR(A.HALL_CD,1,3) = B.CODE                                                                                                                                    \n   ");
			sbSql.append("             AND A.UPJANG    = C.UPJANG                                                                                                                                            \n   ");
			sbSql.append("             AND A.MENU_CD   = C.MENU_CD                                                                                                                                           \n   ");
			sbSql.append("             AND B.GROUP_CODE= 'FS0019'                                                                                                                                            \n   ");
			sbSql.append("             AND A.MENU_DATE BETWEEN '"+ START_DATE +"' AND '"+ END_DATE +"'                                                                                                                     \n   ");
			sbSql.append("             AND (B.ATTR02 = 'Y' )                                                                                                                                                 \n   ");
			//식단의 자재가 있을 경우에 한해 예상 매출액 산출
			sbSql.append("             AND EXISTS (SELECT 1 FROM FSM_REAL_RECIPE_ITEM X WHERE X.UPJANG = A.UPJANG AND X.MENU_CD = A.MENU_CD AND ROWNUM = 1)                                                  \n   ");
			sbSql.append("           GROUP BY A.UPJANG                                                                                                                                                       \n   ");
			sbSql.append("          UNION ALL                                                                                                                                                                \n   ");
			
/*
			sbSql.append("          SELECT  A.UPJANG  \n");
			sbSql.append("               , 0 SALE_AMT                                                                                                                                                        \n   ");
			sbSql.append("               , SUM(C.NEED_QTY*DECODE(E.ATTR02,'Y',B.EXPECT_SALE_QTY,DECODE(E.SET3,'Y',B.EXPECT_SALE_QTY,A.EXPECT_MEAL_QTY))*(C."+ V_PRICE +"/D.KG_CONVERT_RATE/1000)) EXPECT_COST  --재무일경우 B.UNIT_PRICE 사용      \n   ");
			sbSql.append("            FROM FSM_REAL_MENU_MST A                                                                                                                                               \n   ");
			sbSql.append("               , FSM_REAL_RECIPE_MST B                                                                                                                                             \n   ");
			sbSql.append("               , FSM_REAL_RECIPE_ITEM C                                                                                                                                            \n   ");
			sbSql.append("               , HLDC_PO_ITEM_MST D                                                                                                                                                \n   ");
			sbSql.append("               , SCC_COMMON_CODE E                                                                                                                                                 \n   ");
			sbSql.append("           WHERE A.UPJANG    = B.UPJANG                                                                                                                                            \n   ");
			sbSql.append("             AND A.MENU_CD   = B.MENU_CD                                                                                                                                           \n   ");
			sbSql.append("             AND B.UPJANG    = C.UPJANG                                                                                                                                            \n   ");
			sbSql.append("             AND B.MENU_CD   = C.MENU_CD                                                                                                                                           \n   ");
			sbSql.append("             AND B.RECIPE_CD = C.RECIPE_CD                                                                                                                                         \n   ");
			sbSql.append("             AND C.ITEM_CODE = D.ITEM_CODE                                                                                                                                         \n   ");
			sbSql.append("             AND SUBSTR(A.HALL_CD,1,3) = E.CODE                                                                                                                                    \n   ");
			sbSql.append("             AND E.GROUP_CODE= 'FS0019'                                                                                                                                            \n   ");
			sbSql.append("             AND A.MENU_DATE BETWEEN '"+ START_DATE +"' AND '"+ END_DATE +"'                                                                                                                     \n   ");
			sbSql.append("           GROUP BY A.UPJANG                                                                                                                                                       \n   ");
*/

			sbSql.append("            SELECT UPJANG, 0 SALE_AMT, SUM(EXPECT_COST) EXPECT_COST \n   ");
			sbSql.append("              FROM ( \n   ");
			sbSql.append("                    SELECT UPJANG \n   ");
			sbSql.append("                         , MENU_DATE \n   ");
			sbSql.append("                         , MENU_CD \n   ");
			sbSql.append("                         , RECIPE_CD \n   ");
			sbSql.append("                         , ROUND(SUM(EXPECT_COST)) * QTY EXPECT_COST \n   ");
			sbSql.append("                      FROM ( \n   ");
			sbSql.append("                            SELECT /*+ LEADING(E A) USE_HASH(E A) USE_NL(B)  */ A.UPJANG \n   ");
			sbSql.append("                                 , A.MENU_CD \n   ");
			sbSql.append("                                 , A.MENU_DATE \n   ");
			sbSql.append("                                 , B.RECIPE_CD \n   ");
			sbSql.append("                                 , DECODE(E.ATTR02,'Y',B.EXPECT_SALE_QTY, DECODE(E.SET3, 'Y', B.EXPECT_SALE_QTY,A.EXPECT_MEAL_QTY)) QTY \n   ");
			sbSql.append("                                 , C.NEED_QTY*ROUND((C."+ V_PRICE +"/D.KG_CONVERT_RATE/1000),2) EXPECT_COST \n   ");
			sbSql.append("                              FROM FSM_REAL_MENU_MST A \n   ");
			sbSql.append("                                 , FSM_REAL_RECIPE_MST B \n   ");
			sbSql.append("                                 , FSM_REAL_RECIPE_ITEM C \n   ");
			sbSql.append("                                 , HLDC_PO_ITEM_MST D \n   ");
			sbSql.append("                                 , SCC_COMMON_CODE E \n   ");
			sbSql.append("                             WHERE A.UPJANG    = B.UPJANG \n   ");
			sbSql.append("                               AND A.MENU_CD   = B.MENU_CD \n   ");
			sbSql.append("                               AND B.UPJANG    = C.UPJANG \n   ");
			sbSql.append("                               AND B.MENU_CD   = C.MENU_CD \n   ");
			sbSql.append("                               AND B.RECIPE_CD = C.RECIPE_CD \n   ");
			sbSql.append("                               AND C.ITEM_CODE = D.ITEM_CODE \n   ");
			sbSql.append("                               AND SUBSTR(A.HALL_CD,1,3) = E.CODE \n   ");
			sbSql.append("                               AND E.GROUP_CODE= 'FS0019' \n   ");
			sbSql.append("                               AND A.MENU_DATE BETWEEN '"+ START_DATE +"' AND '"+ END_DATE +"' \n   ");
			sbSql.append("                           ) \n   ");
			sbSql.append("                    GROUP BY UPJANG, MENU_DATE, MENU_CD, RECIPE_CD, QTY \n   ");
			sbSql.append("                   ) \n   ");
			sbSql.append("             GROUP BY UPJANG \n   ");			
			sbSql.append("          )                                                                                                                                                                        \n   ");
			sbSql.append("   GROUP BY UPJANG                                                                                                                                                                 \n   ");
			sbSql.append("         UNION ALL                                                                                                                                                                                                                                                                     \n ");
			sbSql.append("         --재고금액                                                                                                                                                                                                                                                                    \n ");
			sbSql.append("         SELECT UPJANG                                                                                                                                                                                                                                                                 \n ");
			sbSql.append("              , 0 PLAN_TRX_AMT                                                                                                                                                                                                                                                         \n ");
			sbSql.append("              , 0 PROSPECT_TRX_AMT                                                                                                                                                                                                                                                     \n ");
			sbSql.append("              , 0 RESULT_TRX_AMT                                                                                                                                                                                                                                                       \n ");
			sbSql.append("              , 0 TRANS_COST_AMT                                                                                                                                                                                                                                                       \n ");
			sbSql.append("              , 0 LOCAL_COST_AMT                                                                                                                                                                                                                                                       \n ");
			sbSql.append("              , 0 EMP_COST_AMT                                                                                                                                                                                                                                                         \n ");
			sbSql.append("              , 0 PLAN_RATE                                                                                                                                                                                                                                                            \n ");
			sbSql.append("              , 0 PROSPECT_RATE                                                                                                                                                                                                                                                        \n ");
			sbSql.append("              , 0 GOAL_RATE                                                                                                                                                                                                                                                            \n ");
			sbSql.append("              , 0 EXPECT_RATE                                                                                                                                                                                                                                                          \n ");
			sbSql.append("              , 0 EXPECT_COST                                                                                                                                                                                                                                                          \n ");
			sbSql.append("              , 0 PLAN_COST                                  \n ");
			sbSql.append("              , 0 PROSPECT_COST                              \n ");
			sbSql.append("              , 0 EXPECT_SALE                                \n ");
			sbSql.append("              , SUM(STOCK_AMT) STOCK_AMT                                                                                                                                                                                                                                               \n ");
			sbSql.append("              , 0 GOAL_STOCK_RATE                                                                                                                                                                                                                                                      \n ");
			sbSql.append("           FROM (                                                                                                                                                                                                                                                                      \n ");
			sbSql.append("                SELECT UPJANG,                                                                                                                                                                                                                                                         \n ");
			sbSql.append("                       NVL( DECODE(B.OUTVAT_FLAG, 'Y', ROUND( SUM( "+ V_AMOUNT +" * DECODE( TAX_CODE, '100', DECODE( MATERIAL_ACCTCD, '1120311', 1.1, 1), 1) ) ), SUM( "+ V_AMOUNT +" ) ), 0) STOCK_AMT                                                                                \n ");
			if (CHK_HIS.equals("0"))
            {
				sbSql.append("                  FROM HLDC_PO_ONHAND_MONTH A                                                                                                                                                                                                                                          \n ");
            }
			else
			{
				sbSql.append("                  FROM HLDC_HIS_PO_ONHAND_MONTH_2013 A                                                                                                                                                                                                                                          \n ");
			}
			sbSql.append("                     , HLDC_PO_SUBINVENTORY B, HLDC_PO_ITEM_MST C                                                                                                                                                                                                                      \n ");
			sbSql.append("                 WHERE A.SUBINV_CODE = B.SUBINV_CODE                                                                                                                                                                                                                                   \n ");
			sbSql.append("                   AND A.ITEM_CODE   = C.ITEM_CODE                                                                                                                                                                                                                                     \n ");
			sbSql.append("                   AND A.ONHAND_YM   = '"+ V_MONTH +"'   -- 상단에서 조회된 V_MONTH 값을 지정한다.                                                                                                                                                                                           \n ");
			sbSql.append("                   AND MATERIAL_ACCTCD = '1120311'                                                                                                                                                                                                                                     \n ");
			sbSql.append("                 GROUP BY UPJANG, B.OUTVAT_FLAG                                                                                                                                                                                                                                        \n ");
			sbSql.append("                UNION ALL                                                                                                                                                                                                                                                              \n ");			
			if (CHK_HIS.equals("0"))
            {
				sbSql.append("                SELECT /*+ INDEX(A PO_TRANSACTION_PT_I2) */  UPJANG,                                                                                                                                                                                                                   \n ");
				sbSql.append("                       DECODE(SUBSTR(TRANS_TYPE,1,1), 'I', 1, -1) * NVL( DECODE(B.OUTVAT_FLAG, 'Y', ROUND( SUM( "+ V_AMOUNT +" * DECODE( A.TAX_CODE, '100', DECODE( MATERIAL_ACCTCD, '1120311', 1.1, 1), 1) ) ), SUM( "+ V_AMOUNT +" ) ), 0) STOCK_AMT                                 \n ");
				sbSql.append("                  FROM HLDC_PO_TRANSACTION A																																																										     \n ");
            }
			else
			{
				sbSql.append("                SELECT /*+ INDEX(A HIS_PO_TRANSACTION_201312_I2) */  UPJANG,                                                                                                                                                                                                                   \n ");
			    sbSql.append("                       DECODE(SUBSTR(TRANS_TYPE,1,1), 'I', 1, -1) * NVL( DECODE(B.OUTVAT_FLAG, 'Y', ROUND( SUM( "+ V_AMOUNT +" * DECODE( A.TAX_CODE, '100', DECODE( MATERIAL_ACCTCD, '1120311', 1.1, 1), 1) ) ), SUM( "+ V_AMOUNT +" ) ), 0) STOCK_AMT                                 \n ");
				sbSql.append("                  FROM HLDC_HIS_PO_TRANSACTION_201312 A                                                                                                                                                                                                                                          \n ");
			}
			sbSql.append("                     , HLDC_PO_SUBINVENTORY B, HLDC_PO_ITEM_MST C                                                                                                                                                                                                                      \n ");
			sbSql.append("                 WHERE A.SUBINV_CODE = B.SUBINV_CODE                                                                                                                                                                                                                                   \n ");
			sbSql.append("                   AND A.ITEM_CODE   = C.ITEM_CODE                                                                                                                                                                                                                                     \n ");
			sbSql.append("                   AND A.TRANS_DATE  BETWEEN '"+ V_FROM_DATE +"' AND '"+ END_DATE +"'  --'20080101'자리에 상단에서 조회된 V_FROM_DATE를 지정한다.                                                                                                                                              \n ");
			sbSql.append("                   AND MATERIAL_ACCTCD = '1120311'                                                                                                                                                                                                                                     \n ");
			sbSql.append("                 GROUP BY UPJANG, B.OUTVAT_FLAG, SUBSTR(TRANS_TYPE,1,1)                                                                                                                                                                                                                \n ");
			sbSql.append("              )                                                                                                                                                                                                                                                                        \n ");
			sbSql.append("         GROUP BY UPJANG                                                                                                                                                                                                                                                               \n ");
			sbSql.append("         UNION ALL                                                                                                                                                                                                                                                                     \n ");
			sbSql.append("         -- 월말목표                                                                                                                                                                                                                                                                   \n ");
			sbSql.append("         SELECT UPJANG                                                                                                                                                                                                                                                                 \n ");
			sbSql.append("              , 0 PLAN_TRX_AMT                                                                                                                                                                                                                                                         \n ");
			sbSql.append("              , 0 PROSPECT_TRX_AMT                                                                                                                                                                                                                                                     \n ");
			sbSql.append("              , 0 RESULT_TRX_AMT                                                                                                                                                                                                                                                       \n ");
			sbSql.append("              , 0 TRANS_COST_AMT                                                                                                                                                                                                                                                       \n ");
			sbSql.append("              , 0 LOCAL_COST_AMT                                                                                                                                                                                                                                                       \n ");
			sbSql.append("              , 0 EMP_COST_AMT                                                                                                                                                                                                                                                         \n ");
			sbSql.append("              , 0 PLAN_RATE                                                                                                                                                                                                                                                            \n ");
			sbSql.append("              , 0 PROSPECT_RATE                                                                                                                                                                                                                                                        \n ");
			sbSql.append("              , 0 GOAL_RATE                                                                                                                                                                                                                                                            \n ");
			sbSql.append("              , 0 EXPECT_RATE                                                                                                                                                                                                                                                          \n ");
			sbSql.append("              , 0 EXPECT_COST                                                                                                                                                                                                                                                          \n ");
			sbSql.append("              , 0 PLAN_COST                                  \n ");
			sbSql.append("              , 0 PROSPECT_COST                              \n ");
			sbSql.append("              , 0 EXPECT_SALE                                \n ");
			sbSql.append("              , 0 STOCK_AMT                                                                                                                                                                                                                                                            \n ");
			sbSql.append("              , GOAL_RATE GOAL_STOCK_RATE                                                                                                                                                                                                                                              \n ");
			sbSql.append("           FROM FSA_STOCK_GOAL_SET                                                                                                                                                                                                                                                     \n ");
			sbSql.append("          WHERE GOAL_MM = SUBSTR('"+ START_DATE +"',1,6)                                                                                                                                                                                                                                       \n ");
			sbSql.append("      ) A                                                                                                                                                                                                                                                                              \n ");
			sbSql.append("      , MAC_UPJANG_V B                                                                                                                                                                                                                                                                 \n ");
			sbSql.append("  WHERE A.UPJANG = B.UPJANG                                                                                                                                                                                                                                                            \n ");
			sbSql.append("    AND B.SAUP_TYPE = '"+ SAUP_TYPE +"'  --사업구분                                                                                                                                                                                                                                                \n ");
			
			if(!TM_CD.equals(""))
			{
				sbSql.append("    AND B.TM_CD = '"+ TM_CD +"' --운영부서                                                                                                                                                                                                                                                     \n ");
			}
			
			if(JOB_CD.equals("000")){JOB_CD="";} //JOB_CD를 전체를 선택하면 000이 넘어간다.
			if(!JOB_CD.equals(""))
			{
				sbSql.append("    AND B.JOB_CD = '"+ JOB_CD +"' --직군                                                                                                                                                                                                                                                           \n ");
			}
			
			if(!UPJANG.equals(""))
			{
			sbSql.append("    AND B.UPJANG = "+ UPJANG +" --사업장                                                                                                                                                                                                                                                     \n ");
			}
			
			if(!LOC_CD.equals(""))
			{
			sbSql.append("    AND B.LOC_CD = '"+ LOC_CD  + "' --지역                                                                                                                                                                                                                                                           \n ");
			}
			
			if(OPEN_TYPE.equals("신규"))
			{
				sbSql.append("    AND B.OPEN_YY = TO_CHAR(SYSDATE,'YYYY') --신규일 경우                                                                                                                                                                                                                              \n ");
			}
			if(OPEN_TYPE.equals("기존"))
			{
				sbSql.append("    AND B.OPEN_YY BETWEEN '1' AND TO_CHAR(ADD_MONTHS(SYSDATE,-12),'YYYY')  --기존일 경우                                                                                                                                                                                                \n ");
			}
			//============================================================================================
			//(2012-11-05 추가) 시작
			// 박은규 2012-11-05 CSR#(CH201210_00143) 요청자:박현정(FS기획팀)
			// sc조회조건 추가(공통:MA0046)
			//============================================================================================
			if (! strSCLst.equals(""))
			{
				sbSql.append("   AND B.SC_CD IN (" + strSCLst + ") \n");
			}
			//============================================================================================
			//(2012-11-05 추가) 끝
			//============================================================================================
			sbSql.append("    AND ( B.CLOSE_DATE IS NULL OR B.CLOSE_DATE < '"+ START_DATE +"' )                                                                                                                                                                                                                  \n ");
			sbSql.append("  GROUP BY B.OPEN_YY, B.LOC_NAME, B.JOB_NAME, B.SUB_JOB_NAME, B.UPJANGNM, B.UPJANG                                                                                                                                                                                                                                      \n ");
			sbSql.append("  ORDER BY B.OPEN_YY, B.LOC_NAME, B.JOB_NAME, B.SUB_JOB_NAME, B.UPJANGNM                                                                                                                                                                                                                                      \n ");

			sbSql.append("  ---운영부서 선택했을 경우                                                                                                                                                                                                                                          \n ");

		}
		else
		{		
			sbSql.append(" SELECT B.TM_CD, B.TM_NAME AS TM_NM                                                                                                                                                                                                                                               \n ");
			sbSql.append("      , SUM(PLAN_TRX_AMT)  PLAN_TRX_AMT    --당월계획                                                                                                                                                                                                           \n ");
			sbSql.append("      , SUM(PROSPECT_TRX_AMT) PROSPECT_TRX_AMT --기간전망                                                                                                                                                                                                       \n ");
			sbSql.append("      , SUM(RESULT_TRX_AMT)  RESULT_TRX_AMT  --기간실적                                                                                                                                                                                                         \n ");
			sbSql.append("      , ROUND(DECODE(SUM(PLAN_TRX_AMT),0,0, SUM(RESULT_TRX_AMT)/SUM(PLAN_TRX_AMT)*100),1) AS AMT_PLAN_COMP_RATE         --계획대비                                                                                                                                 \n ");
			sbSql.append("      , ROUND(DECODE(SUM(PROSPECT_TRX_AMT),0,0, SUM(RESULT_TRX_AMT)/SUM(PROSPECT_TRX_AMT)*100),1) AS AMT_PRO_COMP_RATE  --전망대비                                                                                                                                 \n ");
			sbSql.append("      , SUM(TRANS_COST_AMT+LOCAL_COST_AMT+EMP_COST_AMT) TOTAL_COST  --식재료비합계                                                                                                                                                                              \n ");
			sbSql.append("      , SUM(TRANS_COST_AMT) TRANS_COST_AMT   --전산구매                                                                                                                                                                                                         \n ");
			sbSql.append("      , SUM(LOCAL_COST_AMT) LOCAL_COST_AMT    --현지구매                                                                                                                                                                                                        \n ");
			sbSql.append("      , SUM(EMP_COST_AMT) EMP_COST_AMT     --직원식대                                                                                                                                                                                                           \n ");
			sbSql.append("      , ROUND(DECODE(SUM(PLAN_TRX_AMT),0,0, SUM(PLAN_COST)/SUM(PLAN_TRX_AMT)*100),1)  AS PLAN_RATE       --당월계획                                                                                                                                                                                                              \n ");
			sbSql.append("      , ROUND(DECODE(SUM(PROSPECT_TRX_AMT),0,0, SUM(PROSPECT_COST)/SUM(PROSPECT_TRX_AMT)*100),1) AS PROSPECT_RATE   --기간전망                                                                                                                                                                                                          \n ");
			
			//sbSql.append("      , SUM(EXPECT_RATE) EXPECT_RATE      --기간예상                                                                                                                                                                                                            \n ");
			//sbSql.append("      , ROUND(DECODE(SUM(EXPECT_COST),0,0,SUM(TRANS_COST_AMT+LOCAL_COST_AMT+EMP_COST_AMT)/SUM(EXPECT_COST)*100),1) RESULT_RATE           --기간실적                                                                                                             \n ");
			//sbSql.append("      , ROUND(DECODE(SUM(EXPECT_COST),0,0,SUM(TRANS_COST_AMT+LOCAL_COST_AMT+EMP_COST_AMT)/SUM(EXPECT_COST)*100),1) - SUM(PLAN_RATE)    COST_PLAN_COMP_RATE   --식재료율 계획대비                                                                                \n ");
			//sbSql.append("      , ROUND(DECODE(SUM(EXPECT_COST),0,0,SUM(TRANS_COST_AMT+LOCAL_COST_AMT+EMP_COST_AMT)/SUM(EXPECT_COST)*100),1) - SUM(PROSPECT_RATE) COST_PROSPECT_COMP_RATE --식재료율 전망대비                                                                             \n ");
			sbSql.append("     , NVL(ROUND( DECODE(SUM(EXPECT_SALE), 0, 0, SUM(EXPECT_COST) / SUM(EXPECT_SALE) * 1000) ) / 10,0) EXPECT_RATE      --기간예상                                                                          \n   ");
			sbSql.append("     , NVL(ROUND( DECODE(SUM(RESULT_TRX_AMT), 0, 0, ( SUM(TRANS_COST_AMT) + SUM(LOCAL_COST_AMT) + SUM(EMP_COST_AMT) ) / SUM(RESULT_TRX_AMT)) * 1000 ) / 10,0) RESULT_RATE           --기간실적                                    \n   ");
			sbSql.append("     , NVL(ROUND( DECODE(SUM(RESULT_TRX_AMT), 0, 0, ( SUM(TRANS_COST_AMT) + SUM(LOCAL_COST_AMT) + SUM(EMP_COST_AMT) ) / SUM(RESULT_TRX_AMT)) * 1000 ) / 10,0) - ROUND(DECODE(SUM(PLAN_TRX_AMT),0,0, SUM(PLAN_COST)/SUM(PLAN_TRX_AMT)*100),1)    COST_PLAN_COMP_RATE   --식재료율 계획대비       \n   ");
			sbSql.append("     , NVL(ROUND( DECODE(SUM(RESULT_TRX_AMT), 0, 0, ( SUM(TRANS_COST_AMT) + SUM(LOCAL_COST_AMT) + SUM(EMP_COST_AMT) ) / SUM(RESULT_TRX_AMT)) * 1000 ) / 10,0) - ROUND(DECODE(SUM(PROSPECT_TRX_AMT),0,0, SUM(PROSPECT_COST)/SUM(PROSPECT_TRX_AMT)*100),1) COST_PROSPECT_COMP_RATE --식재료율 전망대비    \n   ");

			sbSql.append("      , SUM(STOCK_AMT)  STOCK_AMT       --재고금액                                                                                                                                                                                                              \n ");
			sbSql.append("      , SUM(GOAL_STOCK_RATE)   GOAL_STOCK_RATE      --월말목표                                                                                                                                                                                                  \n ");
			sbSql.append("      , ROUND(DECODE(SUM(TRANS_COST_AMT+LOCAL_COST_AMT+EMP_COST_AMT),0,0,(SUM(STOCK_AMT)/SUM(TRANS_COST_AMT+LOCAL_COST_AMT+EMP_COST_AMT))*100),1) RESULT_STOCK_RATE --재고실적                                                                                        \n ");
			sbSql.append("      , ROUND(DECODE(SUM(TRANS_COST_AMT+LOCAL_COST_AMT+EMP_COST_AMT),0,0,(SUM(STOCK_AMT)/SUM(TRANS_COST_AMT+LOCAL_COST_AMT+EMP_COST_AMT))*100),1) - SUM(GOAL_STOCK_RATE) STOCK_GAP --재고차이                                                                         \n ");

			sbSql.append("     , SUM(EXPECT_SALE) EXPECT_SALE --예상매출            \n   ");
			sbSql.append("     , SUM(EXPECT_COST) EXPECT_COST --예상식재료비        \n   ");
			sbSql.append("     , SUM(PLAN_COST) PLAN_COST  --계획식재료비           \n   ");
			sbSql.append("     , SUM(PROSPECT_COST) PROSPECT_COST --전망식재료비    \n   ");

			sbSql.append(" FROM (                                                                                                                                                                                                                                                         \n ");
			sbSql.append("         -- 당월계획                                                                                                                                                                                                                                            \n ");
			sbSql.append("         SELECT UPJANG                                                                                                                                                                                                                                          \n ");
			sbSql.append("              , SUM(AMT) PLAN_TRX_AMT                                                                                                                                                                                                                           \n ");
			sbSql.append("              , 0 PROSPECT_TRX_AMT                                                                                                                                                                                                                              \n ");
			sbSql.append("              , 0 RESULT_TRX_AMT                                                                                                                                                                                                                                \n ");
			sbSql.append("              , 0 TRANS_COST_AMT                                                                                                                                                                                                                                \n ");
			sbSql.append("              , 0 LOCAL_COST_AMT                                                                                                                                                                                                                                \n ");
			sbSql.append("              , 0 EMP_COST_AMT                                                                                                                                                                                                                                  \n ");
			sbSql.append("              , 0 PLAN_RATE                                                                                                                                                                                                                                     \n ");
			sbSql.append("              , 0 PROSPECT_RATE                                                                                                                                                                                                                                 \n ");
			sbSql.append("              , 0 GOAL_RATE                                                                                                                                                                                                                                     \n ");
			sbSql.append("              , 0 EXPECT_RATE                                                                                                                                                                                                                                   \n ");
			sbSql.append("              , 0 EXPECT_COST                                                                                                                                                                                                                                   \n ");
			sbSql.append("              , 0 PLAN_COST                                                                                                                                                                                     \n      ");
			sbSql.append("              , 0 PROSPECT_COST                                                                                                                                                                                 \n      ");
			sbSql.append("              , 0 EXPECT_SALE                                                                                                                                                                                   \n      ");
			sbSql.append("              , 0 STOCK_AMT                                                                                                                                                                                                                                     \n ");
			sbSql.append("              , 0 GOAL_STOCK_RATE                                                                                                                                                                                                                               \n ");
			sbSql.append("           FROM " + V_MAM_FS_PL_V + "                                                                                                                                                                                                                                     \n ");
			sbSql.append("          WHERE YYMM = SUBSTR('"+ START_DATE +"',1,6)                                                                                                                                                                                                           \n ");
			sbSql.append("            AND MGMT_ACCT_CD IN ('PLA10000','PLA30000')                                                                                                                                                                                                         \n ");
			sbSql.append("            AND DATA_CLASS = 'P'                                                                                                                                                                                                                                \n ");
			sbSql.append("          GROUP BY UPJANG                                                                                                                                                                                                                                       \n ");
			sbSql.append("         UNION ALL                                                                                                                                                                                                                                              \n ");
			sbSql.append("         --기간전망                                                                                                                                                                                                                                             \n ");
			sbSql.append("         SELECT UPJANG                                                                                                                                                                                                                                          \n ");
			sbSql.append("              , 0 PLAN_TRX_AMT                                                                                                                                                                                                                                  \n ");
			sbSql.append("              , SUM(NVL(FOOD_SALEAMT,0)+NVL(ETC_SALEAMT,0)) PROSPECT_TRX_AMT                                                                                                                                                                                    \n ");
			sbSql.append("              , 0 RESULT_TRX_AMT                                                                                                                                                                                                                                \n ");
			sbSql.append("              , 0 TRANS_COST_AMT                                                                                                                                                                                                                                \n ");
			sbSql.append("              , 0 LOCAL_COST_AMT                                                                                                                                                                                                                                \n ");
			sbSql.append("              , 0 EMP_COST_AMT                                                                                                                                                                                                                                  \n ");
			sbSql.append("              , 0 PLAN_RATE                                                                                                                                                                                                                                     \n ");
			sbSql.append("              , 0 PROSPECT_RATE                                                                                                                                                                                                                                 \n ");
			sbSql.append("              , 0 GOAL_RATE                                                                                                                                                                                                                                     \n ");
			sbSql.append("              , 0 EXPECT_RATE                                                                                                                                                                                                                                   \n ");
			sbSql.append("              , 0 EXPECT_COST                                                                                                                                                                                                                                   \n ");
			sbSql.append("                  , 0 PLAN_COST                                                                                                                                                                                     \n      ");
			sbSql.append("                  , 0 PROSPECT_COST                                                                                                                                                                                 \n      ");
			sbSql.append("                  , 0 EXPECT_SALE                                                                                                                                                                                   \n      ");
			sbSql.append("              , 0 STOCK_AMT                                                                                                                                                                                                                                     \n ");
			sbSql.append("              , 0 GOAL_STOCK_RATE                                                                                                                                                                                                                               \n ");
			sbSql.append("           FROM " + V_MAF_FS_SALE_V + "                                                                                                                                                                                                                                   \n ");
			sbSql.append("          WHERE SALE_DATE BETWEEN '"+ START_DATE +"' AND '"+ END_DATE +"'                                                                                                                                                                                       \n ");
			sbSql.append("          GROUP BY UPJANG                                                                                                                                                                                                                                       \n ");
			sbSql.append("         UNION ALL                                                                                                                                                                                                                                              \n ");
			sbSql.append("         -- 기간실적                                                                                                                                                                                                                                            \n ");
			sbSql.append("         SELECT UPJANG                                                                                                                                                                                                                                          \n ");
			sbSql.append("              , 0 PLAN_TRX_AMT                                                                                                                                                                                                                                  \n ");
			sbSql.append("              , 0 PROSPECT_TRX_AMT                                                                                                                                                                                                                              \n ");
			sbSql.append("              , ROUND(SUM(DECODE(CUSTCD, 999991, AMT, DECODE(TAX_KIND, '310', AMT / 1.1, AMT)))) RESULT_TRX_AMT                                                                                                                                                                              \n ");
			sbSql.append("              , 0 TRANS_COST_AMT                                                                                                                                                                                                                                \n ");
			sbSql.append("              , 0 LOCAL_COST_AMT                                                                                                                                                                                                                                \n ");
			sbSql.append("              , 0 EMP_COST_AMT                                                                                                                                                                                                                                  \n ");
			sbSql.append("              , 0 PLAN_RATE                                                                                                                                                                                                                                     \n ");
			sbSql.append("              , 0 PROSPECT_RATE                                                                                                                                                                                                                                 \n ");
			sbSql.append("              , 0 GOAL_RATE                                                                                                                                                                                                                                     \n ");
			sbSql.append("              , 0 EXPECT_RATE                                                                                                                                                                                                                                   \n ");
			sbSql.append("              , 0 EXPECT_COST                                                                                                                                                                                                                                   \n ");
			sbSql.append("                  , 0 PLAN_COST                                                                                                                                                                                     \n      ");
			sbSql.append("                  , 0 PROSPECT_COST                                                                                                                                                                                 \n      ");
			sbSql.append("                  , 0 EXPECT_SALE                                                                                                                                                                                   \n      ");
			sbSql.append("              , 0 STOCK_AMT                                                                                                                                                                                                                                     \n ");
			sbSql.append("              , 0 GOAL_STOCK_RATE                                                                                                                                                                                                                               \n ");
			sbSql.append("           FROM MAS_TRX                                                                                                                                                                                                                                         \n ");
			sbSql.append("          WHERE TRX_DATE BETWEEN '"+ START_DATE +"' AND '"+ END_DATE +"'                                                                                                                                                                                        \n ");
			sbSql.append("            AND CR_ACCTCD IN ('4010221', '4010299')                                                                                                                                                                                                             \n ");
			sbSql.append("          GROUP BY UPJANG                                                                                                                                                                                                                                       \n ");
			sbSql.append("         UNION ALL                                                                                                                                                                                                                                              \n ");
			sbSql.append("         --전산구매,현지구매                                                                                                                                                                                                                                                                    \n ");
			sbSql.append("         SELECT TRANS_UPJANG                                                                                                                                                                                                                                                           \n ");
			sbSql.append("              , 0 PLAN_TRX_AMT                                                                                                                                                                                                                                                         \n ");
			sbSql.append("              , 0 PROSPECT_TRX_AMT                                                                                                                                                                                                                                                     \n ");
			sbSql.append("              , 0 RESULT_TRX_AMT                                                                                                                                                                                                                                                       \n ");
			sbSql.append("              , SUM(DECODE(CODE,NULL,TRANS_COST_AMT,0)) TRANS_COST_AMT                                                                                                                                                                                                                                    \n ");
			sbSql.append("              , SUM(DECODE(CODE,NULL,0,TRANS_COST_AMT)) LOCAL_COST_AMT                                                                                                                                                                                                                                                       \n ");
			sbSql.append("              , 0 EMP_COST_AMT                                                                                                                                                                                                                                                         \n ");
			sbSql.append("              , 0 PLAN_RATE                                                                                                                                                                                                                                                            \n ");
			sbSql.append("              , 0 PROSPECT_RATE                                                                                                                                                                                                                                                        \n ");
			sbSql.append("              , 0 GOAL_RATE                                                                                                                                                                                                                                                            \n ");
			sbSql.append("              , 0 EXPECT_RATE                                                                                                                                                                                                                                                          \n ");
			sbSql.append("              , 0 EXPECT_COST                                                                                                                                                                                                                                                          \n ");
			sbSql.append("              , 0 PLAN_COST                                  \n ");
			sbSql.append("              , 0 PROSPECT_COST                              \n ");
			sbSql.append("              , 0 EXPECT_SALE                                \n ");
			sbSql.append("              , 0 STOCK_AMT                                                                                                                                                                                                                                                            \n ");
			sbSql.append("              , 0 GOAL_STOCK_RATE                                                                                                                                                                                                                                                      \n ");
			sbSql.append("           FROM (                                                                                                                                                                                                                                                                      \n ");
			if (CHK_HIS.equals("0"))
			{
				sbSql.append("                SELECT /*+ LEADING(A B C) USE_HASH(A B C) INDEX(A PO_TRANSACTION_IE3) */ TRANS_UPJANG,C.CODE,                                                                                                                                                                                                                                                   \n ");
				sbSql.append("                       NVL( DECODE(B.OUTVAT_FLAG, 'Y', ROUND( SUM( "+ V_AMOUNT +" * DECODE( TAX_CODE, '100', DECODE( MATERIAL_ACCTCD, '1120311', 1.1, 1), 1) ) ), SUM( "+ V_AMOUNT +" ) ), 0) TRANS_COST_AMT                                                                           \n ");
				sbSql.append("                  FROM HLDC_PO_TRANSACTION A                                                                           \n ");
			}
			else
			{
				sbSql.append("                SELECT TRANS_UPJANG,C.CODE,                                                                                                                                                                                                                                                   \n ");
				sbSql.append("                       NVL( DECODE(B.OUTVAT_FLAG, 'Y', ROUND( SUM( "+ V_AMOUNT +" * DECODE( TAX_CODE, '100', DECODE( MATERIAL_ACCTCD, '1120311', 1.1, 1), 1) ) ), SUM( "+ V_AMOUNT +" ) ), 0) TRANS_COST_AMT                                                                           \n ");
				sbSql.append("                  FROM HLDC_HIS_PO_TRANSACTION_201312 A                                                                           \n ");
			}
			sbSql.append("                     , HLDC_PO_SUBINVENTORY B,  (SELECT * FROM SCC_COMMON_CODE X WHERE X.GROUP_CODE = 'MA0132') C                                                                           \n ");
			sbSql.append("                 WHERE A.SUBINV_CODE = B.SUBINV_CODE                                                                                                                                                                                                                                   \n ");
			sbSql.append("                   AND TRANS_DATE BETWEEN '"+ START_DATE +"' AND '"+ END_DATE +"'                                                                                                                                                                                                      \n ");
			sbSql.append("                   AND TRIM(TRANS_TYPE) LIKE 'O%'                                                                                                                                                                                                                                            \n ");
			sbSql.append("                   AND TRANS_TYPE <> 'O002'                                                                                                                                                                                                                                            \n ");
			sbSql.append("                   AND A.ACCTCD = '4020231'                                                                                                                                                                                                                                            \n ");
			sbSql.append("                   AND A.ITEM_CODE = C.CODE(+)                                                                                                                                                             \n ");
			sbSql.append("                 GROUP BY TRANS_UPJANG, B.OUTVAT_FLAG, C.CODE                                                                                                                                                                                                                                  \n ");
			sbSql.append("                )                                                                                                                                                                                                                                                                      \n ");
			sbSql.append("          GROUP BY TRANS_UPJANG                                                                                                                                                                                                                                                        \n ");

			sbSql.append("         UNION ALL                                                                                                                                                                                                                                              \n ");
			sbSql.append("         --2009.01 부터 현지구매 => 전도금정산에서 구매연동없슴.100%원가처리 \n ");
			sbSql.append("         SELECT TRANS_UPJANG                                                                                                                                                                                                                                                           \n ");
			sbSql.append("              , 0 PLAN_TRX_AMT                                                                                                                                                                                                                                                         \n ");
			sbSql.append("              , 0 PROSPECT_TRX_AMT                                                                                                                                                                                                                                                     \n ");
			sbSql.append("              , 0 RESULT_TRX_AMT                                                                                                                                                                                                                                                       \n ");
			sbSql.append("              , 0 TRANS_COST_AMT                                                                                                                                                                                                                                                       \n ");
			sbSql.append("              , SUM(LOCAL_COST_AMT) LOCAL_COST_AMT                                                                                                                                                                                                                                     \n ");
			sbSql.append("              , 0 EMP_COST_AMT                                                                                                                                                                                                                                                         \n ");
			sbSql.append("              , 0 PLAN_RATE                                                                                                                                                                                                                                                            \n ");
			sbSql.append("              , 0 PROSPECT_RATE                                                                                                                                                                                                                                                        \n ");
			sbSql.append("              , 0 GOAL_RATE                                                                                                                                                                                                                                                            \n ");
			sbSql.append("              , 0 EXPECT_RATE                                                                                                                                                                                                                                                          \n ");
			sbSql.append("              , 0 EXPECT_COST                                                                                                                                                                                                                                                          \n ");
			sbSql.append("              , 0 PLAN_COST                                  \n ");
			sbSql.append("              , 0 PROSPECT_COST                              \n ");
			sbSql.append("              , 0 EXPECT_SALE                                \n ");
			sbSql.append("              , 0 STOCK_AMT                                                                                                                                                                                                                                                            \n ");
			sbSql.append("              , 0 GOAL_STOCK_RATE                                                                                                                                                                                                                                                      \n ");
			sbSql.append("           FROM (                                                                                                                                                                                                                                                                      \n ");
			sbSql.append("                SELECT A.UPJANG TRANS_UPJANG,                                                                                                                                                                                                                                          \n ");
			sbSql.append("                       NVL(SUM(DECODE((SELECT SCHOOL_YN FROM HLDC_ST_UPJANG WHERE UPJANG = A.UPJANG), 'Y', A.AMT, A.ADJ_AMT)), 0)  LOCAL_COST_AMT                                                                                                                                      \n ");
			sbSql.append("                 FROM MAS_ADVANCE A                                                                                                                                                                                                                                                    \n ");
			sbSql.append("                 WHERE (A.ADJ_DATE BETWEEN '20090101' AND '99999999')                                                                                                                                                                                                                  \n ");
			sbSql.append("                 AND   (A.ADJ_DATE BETWEEN '"+ START_DATE +"' AND '"+ END_DATE +"')                                                                                                                                                                                                    \n ");
			sbSql.append("                 AND   (A.ACCTCD   =  '1120311')                                                                                                                                                                                                                                       \n ");
			sbSql.append("                 GROUP BY A.UPJANG                              		                                                                                                                                                                                                                   \n ");
			sbSql.append("                )                                                                                                                                                                                                                                                                      \n ");
			sbSql.append("          GROUP BY TRANS_UPJANG                                                                                                                                                                                                                                                        \n ");
			sbSql.append("         UNION ALL                                                                                                                                                                                                                                                                     \n ");

			sbSql.append("         --직원식대                                                                                                                                                                                                                                             \n ");
			sbSql.append("         SELECT UPJANG                                                                                                                                                                                                                                          \n ");
			sbSql.append("              , 0 PLAN_TRX_AMT                                                                                                                                                                                                                                  \n ");
			sbSql.append("              , 0 PROSPECT_TRX_AMT                                                                                                                                                                                                                              \n ");
			sbSql.append("              , 0 RESULT_TRX_AMT                                                                                                                                                                                                                                \n ");
			sbSql.append("              , 0 TRANS_COST_AMT                                                                                                                                                                                                                                \n ");
			sbSql.append("              , 0 LOCAL_COST_AMT                                                                                                                                                                                                                                \n ");
			sbSql.append("              , SUM(OP_MANS * 1500 * -1) EMP_COST_AMT                                                                                                                                                                                                           \n ");
			sbSql.append("              , 0 PLAN_RATE                                                                                                                                                                                                                                     \n ");
			sbSql.append("              , 0 PROSPECT_RATE                                                                                                                                                                                                                                 \n ");
			sbSql.append("              , 0 GOAL_RATE                                                                                                                                                                                                                                     \n ");
			sbSql.append("              , 0 EXPECT_RATE                                                                                                                                                                                                                                   \n ");
			sbSql.append("              , 0 EXPECT_COST                                                                                                                                                                                                                                   \n ");
			sbSql.append("                  , 0 PLAN_COST                                                                                                                                                                                     \n      ");
			sbSql.append("                  , 0 PROSPECT_COST                                                                                                                                                                                 \n      ");
			sbSql.append("                  , 0 EXPECT_SALE                                                                                                                                                                                   \n      ");
			sbSql.append("              , 0 STOCK_AMT                                                                                                                                                                                                                                     \n ");
			sbSql.append("              , 0 GOAL_STOCK_RATE                                                                                                                                                                                                                               \n ");
			sbSql.append("           FROM " + V_MAF_FS_SALE_V + "                                                                                                                                                                                                                                   \n ");
			sbSql.append("          WHERE SALE_DATE BETWEEN '"+ START_DATE +"' AND '"+ END_DATE +"'                                                                                                                                                                                       \n ");
			sbSql.append("          GROUP BY UPJANG                                                                                                                                                                                                                                       \n ");
			sbSql.append("         UNION ALL                                                                                                                                                                                                                                              \n ");
			sbSql.append("         --당월계획, 기간전망, 기간목표, 기간예상, 기간원가                                                                                                                                                                                                     \n ");
			sbSql.append("         SELECT UPJANG                                                                                                                                                                                                                                        \n ");
			sbSql.append("              , 0 PLAN_TRX_AMT                                                                                                                                                                                                                                  \n ");
			sbSql.append("              , 0 PROSPECT_TRX_AMT                                                                                                                                                                                                                              \n ");
			sbSql.append("              , 0 RESULT_TRX_AMT                                                                                                                                                                                                                                \n ");
			sbSql.append("              , 0 TRANS_COST_AMT                                                                                                                                                                                                                                \n ");
			sbSql.append("              , 0 LOCAL_COST_AMT                                                                                                                                                                                                                                \n ");
			sbSql.append("              , 0 EMP_COST_AMT                                                                                                                                                                                                                                  \n ");
			sbSql.append("              , ROUND(SUM(DECODE(PLAN_AMT,0,0,PLAN_COST/PLAN_AMT))*100,1) PLAN_RATE                                                                                                                                                                             \n ");
			sbSql.append("              , ROUND(SUM(DECODE(PROSPECT_AMT,0,0,PROSPECT_COST/PROSPECT_AMT))*100,1) PROSPECT_RATE                                                                                                                                                             \n ");
			sbSql.append("              , 0 GOAL_RATE                                                                                                                                                                                                                                     \n ");
			sbSql.append("              , 0 EXPECT_RATE                                                                                                                                                                                                                                   \n ");
			sbSql.append("              , 0 EXPECT_COST                                                                                                                                                                                                                                   \n ");
			sbSql.append("                  , SUM(PLAN_COST) AS PLAN_COST                                                                                                                                                                                     \n      ");
			sbSql.append("                  , SUM(PROSPECT_COST) AS PROSPECT_COST                                                                                                                                                                                 \n      ");
			sbSql.append("                  , 0 EXPECT_SALE                                                                                                                                                                                   \n      ");
			sbSql.append("              , 0 STOCK_AMT                                                                                                                                                                                                                                     \n ");
			sbSql.append("              , 0 GOAL_STOCK_RATE                                                                                                                                                                                                                               \n ");
			sbSql.append("           FROM (                                                                                                                                                                                                                                               \n ");
			sbSql.append("                 SELECT UPJANG                                                                                                                                                                                                                                  \n ");
			sbSql.append("                      , SUM(DECODE(MGMT_ACCT_CD, 'PLA10000', AMT, 'PLA30000', AMT, 0)) PLAN_AMT                                                                                                                                                                 \n ");
			sbSql.append("                      , SUM(DECODE(MGMT_ACCT_CD, 'PLB11000', AMT, 0)) PLAN_COST                                                                                                                                                                                 \n ");
			sbSql.append("                      , 0 PROSPECT_COST                                                                                                                                                                                                                         \n ");
			sbSql.append("                      , 0 PROSPECT_AMT                                                                                                                                                                                                                          \n ");
			sbSql.append("                   FROM " + V_MAM_FS_PL_V + "                                                                                                                                                                                                                             \n ");
			sbSql.append("                  WHERE DATA_CLASS = 'P'                                                                                                                                                                                                                        \n ");
			sbSql.append("                    AND YYMM = SUBSTR('"+ START_DATE +"',1,6)                                                                                                                                                                                           \n ");
			sbSql.append("                  GROUP BY UPJANG                                                                                                                                                                                                                               \n ");
			sbSql.append("                 UNION ALL                                                                                                                                                                                                                                      \n ");
			sbSql.append("                 SELECT UPJANG                                                                                                                                                                                                                                  \n ");
			sbSql.append("                      , 0 PLAN_AMT                                                                                                                                                                                                                              \n ");
			sbSql.append("                      , 0 PLAN_COST                                                                                                                                                                                                                             \n ");
			sbSql.append("                      , SUM(NVL(RAWCOST,0)) PROSPECT_COST                                                                                                                                                                                                       \n ");
			sbSql.append("                      , SUM(NVL(FOOD_SALEAMT,0)+NVL(ETC_SALEAMT,0)) PROSPECT_AMT                                                                                                                                                                                \n ");
			sbSql.append("                   FROM " + V_MAF_FS_SALE_V + "                                                                                                                                                                                                                           \n ");
			sbSql.append("                  WHERE SALE_DATE BETWEEN '"+ START_DATE +"' AND '"+ END_DATE +"'                                                                                                                                                                               \n ");
			sbSql.append("                  GROUP BY UPJANG                                                                                                                                                                                                                               \n ");
			sbSql.append("                 )                                                                                                                                                                                                                                              \n ");
			sbSql.append("          GROUP BY UPJANG                                                                                                                                                                                                                                       \n ");
			sbSql.append("          UNION ALL                                                                                                                                                                                                                                             \n ");
			sbSql.append("   SELECT UPJANG                                                                                                                                                                       \n   ");   
			sbSql.append("       , 0 PLAN_TRX_AMT                                                                                                                                                                \n   ");   
			sbSql.append("       , 0 PROSPECT_TRX_AMT                                                                                                                                                            \n   ");   
			sbSql.append("       , 0 RESULT_TRX_AMT                                                                                                                                                              \n   ");   
			sbSql.append("       , 0 TRANS_COST_AMT                                                                                                                                                              \n   ");   
			sbSql.append("       , 0 LOCAL_COST_AMT                                                                                                                                                              \n   ");   
			sbSql.append("       , 0 EMP_COST_AMT                                                                                                                                                                \n   ");   
			sbSql.append("       , 0 PLAN_RATE                                                                                                                                                                   \n   ");   
			sbSql.append("       , 0 PROSPECT_RATE                                                                                                                                                               \n   ");   
			sbSql.append("       , 0 GOAL_RATE                                                                                                                                                                   \n   ");   
			sbSql.append("       , ROUND( DECODE(SUM(SALE_AMT),0,0,SUM(EXPECT_COST) / SUM(SALE_AMT)) *100,1) EXPECT_RATE                                                                                         \n   ");   
			sbSql.append("       , SUM(EXPECT_COST) EXPECT_COST                                                                                                                                                  \n   ");   
			sbSql.append("       , 0 PLAN_COST                                                                                                                                                                   \n   ");   
			sbSql.append("       , 0 PROSPECT_COST                                                                                                                                                               \n   ");   
			sbSql.append("       , SUM(SALE_AMT) EXPECT_SALE                                                                                                                                                     \n   ");   
			sbSql.append("       , 0 STOCK_AMT                                                                                                                                                                   \n   ");   
			sbSql.append("       , 0 GOAL_STOCK_RATE                                                                                                                                                             \n   ");   
			sbSql.append("    FROM (                                                                                                                                                                             \n   ");   
			sbSql.append("          SELECT /*+ LEADING(B A) USE_HASH(B A) */ A.UPJANG                                                                                                                                                              \n   ");   
			sbSql.append("               , SUM(A.SALE_PRICE * A.EXPECT_MEAL_QTY) SALE_AMT                                                                                                                        \n   ");   
			sbSql.append("               , 0 EXPECT_COST                                                                                                                                                         \n   ");   
			sbSql.append("            FROM FSM_REAL_MENU_MST A                                                                                                                                                   \n   ");   
			sbSql.append("               , SCC_COMMON_CODE B                                                                                                                                                     \n   ");   
			sbSql.append("           WHERE SUBSTR(A.HALL_CD,1,3) = B.CODE                                                                                                                                        \n   ");   
			sbSql.append("             AND B.GROUP_CODE= 'FS0019'                                                                                                                                                \n   ");   
			sbSql.append("             AND A.MENU_DATE BETWEEN '"+ START_DATE +"' AND '"+ END_DATE +"'                                                                                                                         \n   ");   
			sbSql.append("             AND B.ATTR02 <> 'Y'                                                                                                                                                       \n   ");   
			//식단의 자재가 있을 경우에 한해 예상 매출액 산출
			sbSql.append("             AND EXISTS (SELECT 1 FROM FSM_REAL_RECIPE_ITEM X WHERE X.UPJANG = A.UPJANG AND X.MENU_CD = A.MENU_CD AND ROWNUM = 1)                                                  \n   ");
			sbSql.append("           GROUP BY A.UPJANG                                                                                                                                                           \n   ");   
			sbSql.append("          UNION ALL                                                                                                                                                                    \n   ");   
			sbSql.append("          SELECT /*+ LEADING(B A C) USE_NL(B A) USE_NL(C) */ A.UPJANG                                                                                                                                                              \n   ");   
			sbSql.append("               , SUM(C.SALE_PRICE * C.EXPECT_SALE_QTY) SALE_AMT                                                                                                                        \n   ");   
			sbSql.append("               , 0 EXPECT_COST                                                                                                                                                         \n   ");   
			sbSql.append("            FROM FSM_REAL_MENU_MST A                                                                                                                                                   \n   ");   
			sbSql.append("               , SCC_COMMON_CODE B                                                                                                                                                     \n   ");   
			sbSql.append("               , FSM_REAL_RECIPE_MST C                                                                                                                                                 \n   ");   
			sbSql.append("           WHERE SUBSTR(A.HALL_CD,1,3) = B.CODE                                                                                                                                        \n   ");   
			sbSql.append("             AND A.UPJANG    = C.UPJANG                                                                                                                                                \n   ");   
			sbSql.append("             AND A.MENU_CD   = C.MENU_CD                                                                                                                                               \n   ");   
			sbSql.append("             AND B.GROUP_CODE= 'FS0019'                                                                                                                                                \n   ");   
			sbSql.append("             AND A.MENU_DATE BETWEEN '"+ START_DATE +"' AND '"+ END_DATE +"'                                                                                                                         \n   ");   
			sbSql.append("             AND B.ATTR02    = 'Y'                                                                                                                                                     \n   ");   
			//식단의 자재가 있을 경우에 한해 예상 매출액 산출
			sbSql.append("             AND EXISTS (SELECT 1 FROM FSM_REAL_RECIPE_ITEM X WHERE X.UPJANG = A.UPJANG AND X.MENU_CD = A.MENU_CD AND ROWNUM = 1)                                                  \n   ");
			sbSql.append("           GROUP BY A.UPJANG                                                                                                                                                           \n   ");   
			sbSql.append("          UNION ALL                                                                                                                                                                    \n   ");   
			sbSql.append("          SELECT /*+ LEADING(E A) USE_HASH(E A) USE_NL(B) */ A.UPJANG \n   ");
			sbSql.append("               , 0 SALE_AMT                                                                                                                                                            \n   ");   
			sbSql.append("               , SUM(C.NEED_QTY*DECODE(E.ATTR02,'Y',B.EXPECT_SALE_QTY,DECODE(E.SET3,'Y',B.EXPECT_SALE_QTY,A.EXPECT_MEAL_QTY))*(C."+ V_PRICE +"/D.KG_CONVERT_RATE/1000)) EXPECT_COST  --재무일경우 B.UNIT_PRICE 사용          \n   ");   
			sbSql.append("            FROM FSM_REAL_MENU_MST A                                                                                                                                                   \n   ");   
			sbSql.append("               , FSM_REAL_RECIPE_MST B                                                                                                                                                 \n   ");   
			sbSql.append("               , FSM_REAL_RECIPE_ITEM C                                                                                                                                                \n   ");   
			sbSql.append("               , HLDC_PO_ITEM_MST D                                                                                                                                                    \n   ");   
			sbSql.append("               , SCC_COMMON_CODE E                                                                                                                                                     \n   ");   
			sbSql.append("           WHERE A.UPJANG    = B.UPJANG                                                                                                                                                \n   ");   
			sbSql.append("             AND A.MENU_CD   = B.MENU_CD                                                                                                                                               \n   ");   
			sbSql.append("             AND B.UPJANG    = C.UPJANG                                                                                                                                                \n   ");   
			sbSql.append("             AND B.MENU_CD   = C.MENU_CD                                                                                                                                               \n   ");   
			sbSql.append("             AND B.RECIPE_CD = C.RECIPE_CD                                                                                                                                             \n   ");   
			sbSql.append("             AND C.ITEM_CODE = D.ITEM_CODE                                                                                                                                             \n   ");   
			sbSql.append("             AND SUBSTR(A.HALL_CD,1,3) = E.CODE                                                                                                                                        \n   ");   
			sbSql.append("             AND E.GROUP_CODE= 'FS0019'                                                                                                                                                \n   ");   
			sbSql.append("             AND A.MENU_DATE BETWEEN '"+ START_DATE +"' AND '"+ END_DATE +"'                                                                                                                         \n   ");   
			sbSql.append("           GROUP BY A.UPJANG                                                                                                                                                           \n   ");   
			sbSql.append("          )                                                                                                                                                                            \n   ");   
			sbSql.append("   GROUP BY UPJANG                                                                                                                                                                     \n   ");   

			sbSql.append("         UNION ALL                                                                                                                                                                                                                                              \n ");
			sbSql.append("         --재고금액                                                                                                                                                                                                                                             \n ");
			sbSql.append("         SELECT UPJANG                                                                                                                                                                                                                                          \n ");
			sbSql.append("              , 0 PLAN_TRX_AMT                                                                                                                                                                                                                                  \n ");
			sbSql.append("              , 0 PROSPECT_TRX_AMT                                                                                                                                                                                                                              \n ");
			sbSql.append("              , 0 RESULT_TRX_AMT                                                                                                                                                                                                                                \n ");
			sbSql.append("              , 0 TRANS_COST_AMT                                                                                                                                                                                                                                \n ");
			sbSql.append("              , 0 LOCAL_COST_AMT                                                                                                                                                                                                                                \n ");
			sbSql.append("              , 0 EMP_COST_AMT                                                                                                                                                                                                                                  \n ");
			sbSql.append("              , 0 PLAN_RATE                                                                                                                                                                                                                                     \n ");
			sbSql.append("              , 0 PROSPECT_RATE                                                                                                                                                                                                                                 \n ");
			sbSql.append("              , 0 GOAL_RATE                                                                                                                                                                                                                                     \n ");
			sbSql.append("              , 0 EXPECT_RATE                                                                                                                                                                                                                                   \n ");
			sbSql.append("              , 0 EXPECT_COST                                                                                                                                                                                                                                   \n ");
			sbSql.append("                  , 0 PLAN_COST                                                                                                                                                                                     \n      ");
			sbSql.append("                  , 0 PROSPECT_COST                                                                                                                                                                                 \n      ");
			sbSql.append("                  , 0 EXPECT_SALE                                                                                                                                                                                   \n      ");
			sbSql.append("              , SUM(STOCK_AMT) STOCK_AMT                                                                                                                                                                                                                        \n ");
			sbSql.append("              , 0 GOAL_STOCK_RATE                                                                                                                                                                                                                               \n ");
			sbSql.append("           FROM (                                                                                                                                                                                                                                               \n ");
			sbSql.append("                SELECT UPJANG,                                                                                                                                                                                                                                  \n ");
			sbSql.append("                       NVL( DECODE(B.OUTVAT_FLAG, 'Y', ROUND( SUM( "+ V_AMOUNT +" * DECODE( TAX_CODE, '100', DECODE( MATERIAL_ACCTCD, '1120311', 1.1, 1), 1) ) ), SUM( "+ V_AMOUNT +" ) ), 0) STOCK_AMT                                                         \n ");
			if (CHK_HIS.equals("0"))
			{
				sbSql.append("                  FROM HLDC_PO_ONHAND_MONTH A                             \n ");
			}
			else
			{
				sbSql.append("                  FROM HLDC_HIS_PO_ONHAND_MONTH_2013 A                             \n ");
			}
			sbSql.append("                     , HLDC_PO_SUBINVENTORY B, HLDC_PO_ITEM_MST C                                                                                                                                                                       \n ");			
			sbSql.append("                 WHERE A.SUBINV_CODE = B.SUBINV_CODE                                                                                                                                                                                                            \n ");
			sbSql.append("                   AND A.ITEM_CODE   = C.ITEM_CODE                                                                                                                                                                                                              \n ");
			sbSql.append("                   AND A.ONHAND_YM   = '"+ V_MONTH +"'  -- 상단에서 조회된 V_MONTH 값을 지정한다.                                                                                                                                                               \n ");
			sbSql.append("                   AND MATERIAL_ACCTCD = '1120311'                                                                                                                                                                                                              \n ");
			sbSql.append("                 GROUP BY UPJANG, B.OUTVAT_FLAG                                                                                                                                                                                                                 \n ");
			sbSql.append("                UNION ALL                                                                                                                                                                                                                                       \n ");
			if (CHK_HIS.equals("0"))
			{
				sbSql.append("                SELECT /*+ INDEX(A PO_TRANSACTION_PT_I2) */ UPJANG,                                                                                                                                                                                        \n ");
				sbSql.append("                       DECODE(SUBSTR(TRANS_TYPE,1,1), 'I', 1, -1) * NVL( DECODE(B.OUTVAT_FLAG, 'Y', ROUND( SUM( "+ V_AMOUNT +" * DECODE( A.TAX_CODE, '100', DECODE( MATERIAL_ACCTCD, '1120311', 1.1, 1), 1) ) ), SUM( "+ V_AMOUNT +" ) ), 0) STOCK_AMT          \n ");
				sbSql.append("                  FROM HLDC_PO_TRANSACTION A      \n ");
			}
			else
			{
				sbSql.append("                SELECT /*+ INDEX(A HIS_PO_TRANSACTION_201312_I2) */ UPJANG,                                                                                                                                                                                        \n ");
				sbSql.append("                       DECODE(SUBSTR(TRANS_TYPE,1,1), 'I', 1, -1) * NVL( DECODE(B.OUTVAT_FLAG, 'Y', ROUND( SUM( "+ V_AMOUNT +" * DECODE( A.TAX_CODE, '100', DECODE( MATERIAL_ACCTCD, '1120311', 1.1, 1), 1) ) ), SUM( "+ V_AMOUNT +" ) ), 0) STOCK_AMT          \n ");
				sbSql.append("                  FROM HLDC_HIS_PO_TRANSACTION_201312 A      \n ");
			}
			sbSql.append("                     , HLDC_PO_SUBINVENTORY B, HLDC_PO_ITEM_MST C                                                                                                                                                                        \n ");
			sbSql.append("                 WHERE A.SUBINV_CODE = B.SUBINV_CODE                                                                                                                                                                                                            \n ");
			sbSql.append("                   AND A.ITEM_CODE   = C.ITEM_CODE                                                                                                                                                                                                              \n ");
			sbSql.append("                   AND A.TRANS_DATE  BETWEEN '"+ V_FROM_DATE +"' AND '"+ END_DATE +"'  --'20080101'자리에 상단에서 조회된 V_FROM_DATE를 지정한다.                                                                                                             \n ");
			sbSql.append("                   AND MATERIAL_ACCTCD = '1120311'                                                                                                                                                                                                              \n ");
			sbSql.append("                 GROUP BY UPJANG, B.OUTVAT_FLAG, SUBSTR(TRANS_TYPE,1,1)                                                                                                                                                                                         \n ");
			sbSql.append("              )                                                                                                                                                                                                                                                 \n ");
			sbSql.append("         GROUP BY UPJANG                                                                                                                                                                                                                                        \n ");
			sbSql.append("         UNION ALL                                                                                                                                                                                                                                              \n ");
			sbSql.append("         -- 월말목표                                                                                                                                                                                                                                            \n ");
			sbSql.append("         SELECT UPJANG                                                                                                                                                                                                                                          \n ");
			sbSql.append("              , 0 PLAN_TRX_AMT                                                                                                                                                                                                                                  \n ");
			sbSql.append("              , 0 PROSPECT_TRX_AMT                                                                                                                                                                                                                              \n ");
			sbSql.append("              , 0 RESULT_TRX_AMT                                                                                                                                                                                                                                \n ");
			sbSql.append("              , 0 TRANS_COST_AMT                                                                                                                                                                                                                                \n ");
			sbSql.append("              , 0 LOCAL_COST_AMT                                                                                                                                                                                                                                \n ");
			sbSql.append("              , 0 EMP_COST_AMT                                                                                                                                                                                                                                  \n ");
			sbSql.append("              , 0 PLAN_RATE                                                                                                                                                                                                                                     \n ");
			sbSql.append("              , 0 PROSPECT_RATE                                                                                                                                                                                                                                 \n ");
			sbSql.append("              , 0 GOAL_RATE                                                                                                                                                                                                                                     \n ");
			sbSql.append("              , 0 EXPECT_RATE                                                                                                                                                                                                                                   \n ");
			sbSql.append("              , 0 EXPECT_COST                                                                                                                                                                                                                                   \n ");
			sbSql.append("                  , 0 PLAN_COST                                                                                                                                                                                     \n      ");
			sbSql.append("                  , 0 PROSPECT_COST                                                                                                                                                                                 \n      ");
			sbSql.append("                  , 0 EXPECT_SALE                                                                                                                                                                                   \n      ");
			sbSql.append("              , 0 STOCK_AMT                                                                                                                                                                                                                                     \n ");
			sbSql.append("              , GOAL_RATE GOAL_STOCK_RATE                                                                                                                                                                                                                       \n ");
			sbSql.append("           FROM FSA_STOCK_GOAL_SET                                                                                                                                                                                                                              \n ");
			sbSql.append("          WHERE GOAL_MM = SUBSTR('"+ START_DATE + "',1,6)                                                                                                                                                                                                       \n ");
			sbSql.append("      ) A                                                                                                                                                                                                                                                       \n ");
			sbSql.append("      , MAC_UPJANG_V B                                                                                                                                                                                                                                          \n ");
			sbSql.append("  WHERE A.UPJANG = B.UPJANG                                                                                                                                                                                                                                     \n ");
			sbSql.append("    AND B.SAUP_TYPE = '"+ SAUP_TYPE +"'  --사업구분                                                                                                                                                                                                                                                \n ");
			
			//운영부서
			if(!TM_CD.equals(""))
			{
			sbSql.append("    AND B.TM_CD = '"+ TM_CD +"' --운영부서                                                                                                                                                                                                                                                     \n ");
			}
			
			//직군
			if(JOB_CD.equals("000")){JOB_CD="";} //JOB_CD를 전체를 선택하면 000이 넘어간다.
			if(!JOB_CD.equals(""))
			{
				sbSql.append("    AND B.JOB_CD = '"+ JOB_CD +"' --직군                                                                                                                                                                                                                                                           \n ");
			}
	
			//업
			if(!UPJANG.equals(""))
			{
			sbSql.append("    AND B.UPJANG = "+ UPJANG +" --사업장                                                                                                                                                                                                                                                     \n ");
			}
			
			//지역
			if(!LOC_CD.equals(""))
			{
				sbSql.append("    AND B.LOC_CD = '"+ LOC_CD  + "' --지역                                                                                                                                                                                                                                                           \n ");
			}

			if(OPEN_TYPE.equals("신규"))
			{
				sbSql.append("    AND B.OPEN_YY = TO_CHAR(SYSDATE,'YYYY') --신규일 경우                                                                                                                                                                                                                              \n ");
			}
			if(OPEN_TYPE.equals("기존"))
			{
				sbSql.append("    AND B.OPEN_YY BETWEEN '1' AND TO_CHAR(ADD_MONTHS(SYSDATE,-12),'YYYY')  --기존일 경우                                                                                                                                                                                                \n ");
			}
			//============================================================================================
			//(2012-11-05 추가) 시작
			// 박은규 2012-11-05 CSR#(CH201210_00143) 요청자:박현정(FS기획팀)
			// sc조회조건 추가(공통:MA0046)
			//============================================================================================
			if (! strSCLst.equals(""))
			{
				sbSql.append("   AND B.SC_CD IN (" + strSCLst + ") \n");
			}
			//============================================================================================
			//(2012-11-05 추가) 끝
			//============================================================================================
			sbSql.append("    AND ( B.CLOSE_DATE IS NULL OR B.CLOSE_DATE < '"+ START_DATE +"' )                                                                                                                                                                                           \n ");
			sbSql.append("  GROUP BY B.TM_NAME, B.TM_CD                                                                                                                                                                                                                                            \n ");
			sbSql.append("  ORDER BY B.TM_NAME                                                                                                                                                                                                                                            \n ");
		
			sbSql.append("  ---운영부서 선택안함                                                                                                                                                                                                                                          \n ");
			
		}
			
	    //SQL 실행
	    pstmt = conn.prepareStatement(sbSql.toString());
		
	    //RecordSet에 데이터 담기
	    rs = pstmt.executeQuery();
		
		//데이터셋만들기
		ds_list = this.makeDataSet(rs, "ds_list"); //ds_list
		
		/**종료**/
		out_dl.add(ds_list);
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