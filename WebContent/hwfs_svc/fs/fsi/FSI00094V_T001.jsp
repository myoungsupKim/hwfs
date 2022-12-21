<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 메뉴관리/자재관리/기획자재 사용현황 조회
■ 프로그램ID   : FSI00094V_T001.jsp
■ 프로그램명   : 분석결과(사업장)
■ 작성일자     : 2012-11-05
■ 작성자       : 박은규
■ 이력관리     : 
1)박은규 2012-11-05 CSR#(CH201210_00143) 요청자:박현정(FS기획팀)
최초 작성
2)박은규 2013-04-18 CSR#(CH201304_00072) 요청자:박현정(FS기획팀)
확정 절감액 항목 추가
3)김장욱 2013-10-15 CSR#() 요청자:박현정(FS기획팀)
  ; 금액을 관리단가(1)와 재무단가(2)로 구분하여 조회 
4)김장욱 2013-11-11 요청자:박현정(FS지원팀)
  ; [사업장]에서 보이는 [확정절감비]는 [관리자]에서 보이는 확정절감액과 동일하게 [재무]로
    보이게 해달라고 함.(비율은 재무와 관리가 동일함.)
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	try	{
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));
	
		//입력 데이타
		DataSet ds_Cond     = in_dl.get("ds_Cond");
		//FileLog.println("d:\\aaa.txt", ds_cond
		
		String strFromDt = nullToBlank(ds_Cond.getString(0, "FROM_DT"));
		String strToDt	 = nullToBlank(ds_Cond.getString(0, "TO_DT"));
		String strTmCd	 = nullToBlank(ds_Cond.getString(0, "TM_CD"));
		String strUpjang = nullToBlank(ds_Cond.getString(0, "UPJANG"));
		
		// 관리단가("1") 재무단가("2") 구분
		String strStype	 = nullToBlank(ds_Cond.getString(0, "STYPE"));
		
		// 'M'이면 재무절감액과 관리절감액 각각으로 절감비를 계산
		// 'S'이면 절감액은 관리절감액으로 보여주나 절감비는 재무절감액으로 계산한다. 
		String strGUBUN	 = nullToBlank(ds_Cond.getString(0, "GUBUN"));
		
		//System.out.println("==============strGUBUN=================>" + strGUBUN);

		//out 데이타
		DataSet ds_List;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		//내역조회
		sbSql.append("WITH T AS \n");
		sbSql.append("( \n");
		sbSql.append("         --기획식재 \n");
		sbSql.append("         SELECT /*+ ORDERED USE_NL(B A) INDEX(A PO_TRANSACTION_PT_I12) */  \n");
		sbSql.append("                A.TRANS_UPJANG AS UPJANG \n");
		
		//============================================================================================
		//(2013-10-15 변경) 시작
		// 김장욱	 2013-10-15 CSR#(CH201304_00072) 요청자:박현정(FS기획팀)
		// 관리단가와 재무단가 구분
		//============================================================================================
		if (strGUBUN.equals("M")){	
			if (strStype.equals("2")){ 	// 재무단가
				sbSql.append("              , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * A.TRANS_MAMOUNT) AS PLN_AMT /* 재무 TRANS_UAMOUNT */ \n");
			}else{						// 관리단가
				sbSql.append("              , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * A.TRANS_MAMOUNT) AS PLN_AMT /* 관리 */ \n");
			}
		}else{
			sbSql.append("              , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * A.TRANS_MAMOUNT) AS PLN_AMT /* 재무 TRANS_UAMOUNT */ \n");			
		}
		//============================================================================================
		//(2013-04-18 추가) 시작
		// 박은규 2013-04-18 CSR#(CH201304_00072) 요청자:박현정(FS기획팀)
		// 확정 절감액 항목 추가
		//============================================================================================
		//sbSql.append("              , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * A.TRANS_QTY * (B.MARKET_PRICE - A.TRANS_UPRICE)) AS REAL_SAVE \n");
		//분석결과탭(FSI00093V_TOO1)과 데이터를 일치시키기 위해 (시장단가 - 품목별 평균단가) * 수량합으로 절감액을 구한다.
		//if (strStype.equals("2")){ 	// 재무단가
		//	sbSql.append("              , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * A.TRANS_QTY) * (B.MARKET_PRICE - DECODE(NVL(SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * A.TRANS_QTY),0), 0, 0, ROUND(SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * A.TRANS_UAMOUNT) / SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * A.TRANS_QTY)))) AS REAL_SAVE /* 재무 */ \n");
		//}else{						// 관리단가
		//	sbSql.append("              , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * A.TRANS_QTY) * (B.MARKET_PRICE - DECODE(NVL(SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * A.TRANS_QTY),0), 0, 0, ROUND(SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * A.TRANS_MAMOUNT) / SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * A.TRANS_QTY)))) AS REAL_SAVE /* 관리 */ \n");
		//}
		sbSql.append("              , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * A.TRANS_QTY) * (B.MARKET_PRICE - DECODE(NVL(SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * A.TRANS_QTY),0), 0, 0, ROUND(SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * A.TRANS_MAMOUNT) / SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * A.TRANS_QTY)))) AS U_REAL_SAVE /* 재무 TRANS_UAMOUNT */ \n");
		sbSql.append("              , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * A.TRANS_QTY) * (B.MARKET_PRICE - DECODE(NVL(SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * A.TRANS_QTY),0), 0, 0, ROUND(SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * A.TRANS_MAMOUNT) / SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * A.TRANS_QTY)))) AS M_REAL_SAVE /* 관리 */ \n");
		//============================================================================================
		//(2013-04-18 추가) 끝
		//============================================================================================
		sbSql.append("              , 0 AS TRANS_COST_AMT \n");
		sbSql.append("              , 0 AS LOCAL_COST_AMT \n");
		sbSql.append("              , 0 AS EMP_COST_AMT \n");
		sbSql.append("           FROM FSI_DUTY_MST B \n");
		sbSql.append("              , HLDC_PO_TRANSACTION A \n");
		sbSql.append("          WHERE A.CENTER_CODE = B.CENTER_CODE \n");
		sbSql.append("            AND A.CUSTCD = B.CUSTCD \n");
		sbSql.append("            AND A.ITEM_CODE = B.ITEM_CODE \n");
		//sbSql.append("            AND A.TRANS_DATE BETWEEN B.START_DATE AND B.END_DATE \n");
		sbSql.append("            AND A.TRANS_DATE BETWEEN GREATEST(B.START_DATE,'" + strFromDt + "') AND LEAST(B.END_DATE,'" + strToDt + "') \n");
		//sbSql.append("            AND ( (B.START_DATE BETWEEN '" + strFromDt + "' AND '" + strToDt + "') \n");
		//sbSql.append("                                OR (B.END_DATE BETWEEN '" + strFromDt + "' AND '" + strToDt + "') \n");
		//sbSql.append("                                OR (B.START_DATE <= '" + strFromDt + "' AND B.END_DATE >= '" + strToDt + "') ) \n");
		sbSql.append("            AND B.START_DATE <= '" + strToDt + "' AND B.END_DATE >= '" + strFromDt + "' \n");
		sbSql.append("            AND A.TRANS_MU_CD = '2002' \n");
		sbSql.append("            AND A.SUBINV_CODE LIKE 'C%' \n");
		sbSql.append("            AND (A.TRANS_TYPE = 'I001' OR (A.TRANS_TYPE LIKE '_002' AND A.SOURCE_TYPE = 'PO')) \n");
		if (! strUpjang.equals(""))
			sbSql.append("            AND A.TRANS_UPJANG = '" + strUpjang + "' \n");
		//sbSql.append("          GROUP BY A.TRANS_UPJANG \n");
		//분석결과탭(FSI00093V_TOO1)과 데이터를 일치시키기 위해 (시장단가 - 품목별 평균단가) * 수량합으로 절감액을 구한다.
		sbSql.append("          GROUP BY A.TRANS_UPJANG, A.ITEM_CODE, B.MARKET_PRICE ");
		
		sbSql.append("          UNION ALL \n");
		sbSql.append("         --전산구매,현지구매 \n");
		sbSql.append("         SELECT /*+ NO_MERGE */ TRANS_UPJANG AS UPJANG  \n");
		sbSql.append("              , 0 AS PLN_AMT \n");
		sbSql.append("              , 0 AS U_REAL_SAVE \n");
		
		sbSql.append("              , 0 AS M_REAL_SAVE \n");
		sbSql.append("              , SUM(DECODE(CODE,NULL,TRANS_COST_AMT,0)) AS TRANS_COST_AMT \n");
		sbSql.append("              , SUM(DECODE(CODE,NULL,0,TRANS_COST_AMT)) AS LOCAL_COST_AMT \n");
		sbSql.append("              , 0 EMP_COST_AMT \n");
		sbSql.append("           FROM (SELECT /*+ LEADING(A C B) USE_HASH(B) USE_NL(C) INDEX(A PO_TRANSACTION_PT_I8) */   \n");
		sbSql.append("                        A.TRANS_UPJANG, C.CODE \n");
		
		if (strGUBUN.equals("M")){
			if (strStype.equals("2")){ 	// 재무단가
				sbSql.append("                      , NVL(DECODE(B.OUTVAT_FLAG, 'Y', ROUND(SUM(A.UNIT_AMOUNT * DECODE(A.TAX_CODE, '100', DECODE(B.MATERIAL_ACCTCD, '1120311', 1.1, 1), 1) ) ), SUM(A.UNIT_AMOUNT)), 0) AS TRANS_COST_AMT /* 재무 */ \n");
			}else{ // 관리단가
				sbSql.append("                      , NVL(DECODE(B.OUTVAT_FLAG, 'Y', ROUND(SUM(A.MARGIN_AMOUNT * DECODE(A.TAX_CODE, '100', DECODE(B.MATERIAL_ACCTCD, '1120311', 1.1, 1), 1) ) ), SUM(A.MARGIN_AMOUNT)), 0) AS TRANS_COST_AMT /* 관리 */ \n");			
			}
		}else{
			sbSql.append("                      , NVL(DECODE(B.OUTVAT_FLAG, 'Y', ROUND(SUM(A.UNIT_AMOUNT * DECODE(A.TAX_CODE, '100', DECODE(B.MATERIAL_ACCTCD, '1120311', 1.1, 1), 1) ) ), SUM(A.UNIT_AMOUNT)), 0) AS TRANS_COST_AMT /* 재무 */ \n");			
		}
//		if (!strStype.equals("2")){ 	// 관리단가(위의 소스처럼 "1"로 비교하였는데 비교가 안되어 "2"가 아닌걸로 바꿈(이상하네))
		
//		}
		
		//============================================================================================
		//(2013-10-15 변경) 끝
		//============================================================================================		
		sbSql.append("                   FROM HLDC_PO_TRANSACTION A, HLDC_PO_SUBINVENTORY B \n");
		sbSql.append("                      , (SELECT * FROM SCC_COMMON_CODE X WHERE X.GROUP_CODE = 'MA0132') C \n");
		sbSql.append("                  WHERE A.SUBINV_CODE = B.SUBINV_CODE \n");
		sbSql.append("                    AND A.TRANS_DATE BETWEEN '" + strFromDt + "' AND '" + strToDt + "' \n");
		sbSql.append("                    AND A.TRANS_TYPE LIKE 'O%' \n");
		sbSql.append("                    AND A.TRANS_TYPE <> 'O002' \n");
		sbSql.append("                    AND A.ACCTCD = '4020231' \n");
		sbSql.append("                    AND A.ITEM_CODE = C.CODE(+)                                                                                                                                                             \n");
		if (! strUpjang.equals(""))
			sbSql.append("                    AND A.TRANS_UPJANG = '" + strUpjang + "' \n");
		sbSql.append("                  GROUP BY A.TRANS_UPJANG, B.OUTVAT_FLAG, C.CODE) \n");
		sbSql.append("          GROUP BY TRANS_UPJANG \n");
		sbSql.append("          UNION ALL \n");
		sbSql.append("         --2009.01 부터 현지구매 => 전도금정산에서 구매연동없슴.100%원가처리 \n");
        sbSql.append("          SELECT TO_CHAR(UPJANG)                                                                                                                              \n");
        sbSql.append("               , 0 AS PLN_AMT                                                                                                                                 \n");
        sbSql.append("               , 0 AS U_REAL_SAVE                                                                                                                             \n");
        sbSql.append("               , 0 AS M_REAL_SAVE                                                                                                                             \n");
        sbSql.append("               , 0 AS TRANS_COST_AMT                                                                                                                          \n");
        sbSql.append("               , NVL(SUM(DECODE((SELECT Z.SCHOOL_YN FROM HLDC_ST_UPJANG Z WHERE Z.UPJANG = B.UPJANG), 'Y', ROUND(A.AMT / 1.1), A.AMT)), 0) AS LOCAL_COST_AMT  \n");
        sbSql.append("               , 0 EMP_COST_AMT                                                                                                                               \n");
        sbSql.append("            FROM FSD_PREPAY_ADJUST A                                                                                                                          \n");
        sbSql.append("               , SCO_UPJANG_MST_V B                                                                                                                           \n");
        sbSql.append("           WHERE B.DEPT_ID = A.CC_CD                                                                                                                          \n");
        sbSql.append("             AND A.BASIS_DATE BETWEEN GREATEST('20090101','" + strFromDt + "') AND '" + strToDt + "'                                                          \n");
        sbSql.append("             AND A.ACCT_CD IN ('42203010', '42203020')                                                                                                        \n");
		if (! strUpjang.equals(""))
			sbSql.append("            AND B.UPJANG = " + strUpjang + " \n");
        sbSql.append("           GROUP BY B.UPJANG 		                                                                                                                         \n");
/* 		sbSql.append("         SELECT A.UPJANG  \n");
		sbSql.append("              , 0 AS PLN_AMT \n");
		sbSql.append("              , 0 AS U_REAL_SAVE \n");
		
		sbSql.append("              , 0 AS M_REAL_SAVE \n");
		sbSql.append("              , 0 AS TRANS_COST_AMT \n");
		sbSql.append("              , NVL(SUM(DECODE((SELECT Z.SCHOOL_YN FROM HLDC_ST_UPJANG Z WHERE Z.UPJANG = A.UPJANG), 'Y', A.AMT, A.ADJ_AMT)), 0) AS LOCAL_COST_AMT \n");
		sbSql.append("              , 0 EMP_COST_AMT \n");
		sbSql.append("           FROM MAS_ADVANCE A \n");	
		sbSql.append("          WHERE A.ADJ_DATE BETWEEN GREATEST('20090101','" + strFromDt + "') AND '" + strToDt + "' \n");	
		sbSql.append("            AND A.ACCTCD = '1120311' \n");	
		if (! strUpjang.equals(""))
			sbSql.append("            AND A.UPJANG = " + strUpjang + " \n");
		sbSql.append("          GROUP BY A.UPJANG \n"); */                                                 
		sbSql.append("          UNION ALL \n");                                                            
		sbSql.append("         --직원식대  \n");                                                           
        sbSql.append("         SELECT /*+ LEADING(V.A) USE_NL(V.A V.B) index(V.A MAF_SALE_IDX01) */        \n");
        sbSql.append("                TO_CHAR(UPJANG)                                                      \n");
        sbSql.append("              , 0 PLN_AMT                                                            \n");
        sbSql.append("              , 0 AS U_REAL_SAVE                                                     \n");
        sbSql.append("              , 0 AS M_REAL_SAVE                                                     \n");
        sbSql.append("              , 0 AS TRANS_COST_AMT                                                  \n");
        sbSql.append("              , 0 AS LOCAL_COST_AMT                                                  \n");
        sbSql.append("              , SUM(AMT * -1) AS EMP_COST_AMT                                        \n");
        sbSql.append("           FROM MAS_WELFARE                                                          \n");
        sbSql.append("          WHERE GADATE BETWEEN '" + strFromDt + "' AND '" + strToDt + "'             \n");
		if (! strUpjang.equals(""))
		sbSql.append("            AND UPJANG = " + strUpjang + " \n");
        sbSql.append("          GROUP BY UPJANG 		                                                   \n");
//		sbSql.append("         SELECT /*+ LEADING(V.A) USE_NL(V.A V.B) index(V.A MAF_SALE_IDX01) */ \n");
//		sbSql.append("                UPJANG \n");
//		sbSql.append("              , 0 PLN_AMT \n");
//		sbSql.append("              , 0 AS U_REAL_SAVE \n");
//		sbSql.append("              , 0 AS M_REAL_SAVE \n");
//		sbSql.append("              , 0 AS TRANS_COST_AMT \n");
//		sbSql.append("              , 0 AS LOCAL_COST_AMT \n");
//		sbSql.append("              , SUM(OP_MANS * 1500 * -1) AS EMP_COST_AMT \n");
//		sbSql.append("           FROM MAF_FS_SALE_V \n");
//		sbSql.append("          WHERE SALE_DATE BETWEEN '" + strFromDt + "' AND '" + strToDt + "' \n");
//		if (! strUpjang.equals(""))
//			sbSql.append("            AND UPJANG = " + strUpjang + " \n");
//		sbSql.append("          GROUP BY UPJANG \n");
		sbSql.append(") \n");
		sbSql.append("SELECT A.TM_CD \n");
		sbSql.append("     , A.TM_NAME \n");
		sbSql.append("     , A.JOB_CD \n");
		sbSql.append("     , A.JOB_NAME \n");
		sbSql.append("     , A.SUB_JOB_CD \n");
		sbSql.append("     , A.SUB_JOB_NAME \n");
		sbSql.append("     , A.UPJANG \n");
		sbSql.append("     , A.UPJANGNM \n");
		sbSql.append("     , SUM(C.PLN_AMT) AS PLN_AMT \n");
		sbSql.append("     , SUM(C.TRANS_COST_AMT + C.LOCAL_COST_AMT + C.EMP_COST_AMT) AS ALL_AMT \n");
		sbSql.append("     , DECODE(SUM(C.TRANS_COST_AMT + C.LOCAL_COST_AMT + C.EMP_COST_AMT), 0, 0, ROUND(100 * SUM(C.PLN_AMT) / SUM(C.TRANS_COST_AMT + C.LOCAL_COST_AMT + C.EMP_COST_AMT), 2)) AS PLN_RATE \n");
		//============================================================================================
		//(2013-04-18 추가) 시작
		// 박은규 2013-04-18 CSR#(CH201304_00072) 요청자:박현정(FS기획팀)
		// 확정 절감액 항목 추가
		//============================================================================================
		//sbSql.append("     , SUM(C.REAL_SAVE) AS REAL_SAVE \n");
		//============================================================================================
			
		//============================================================================================
		// (2013-11-11 추가) 시작
		// 김장욱 2013-11-11 요청자:박현정(FS지원팀)
		// 2013-10-14 FC간담회 후 확정절감비 추가 
		//============================================================================================			
		if (strGUBUN.equals("M")){
			if (strStype.equals("2")){ 	// 재무단가
				sbSql.append("     , SUM(C.U_REAL_SAVE) AS REAL_SAVE /* 지원팀_재무_확정절감액 */ \n");
			}else{
				sbSql.append("     , SUM(C.M_REAL_SAVE) AS REAL_SAVE /* 지원팀_관리_확정절감액 */ \n");
			}
		}else{	//영양사
			sbSql.append("     , SUM(C.U_REAL_SAVE) AS REAL_SAVE /* 영양사_관리_확정절감액 */ \n"); /* 영양사 (관리_확정절감액)*/						
		}
		//============================================================================================
		//(2013-11-11 추가) 끝
		//============================================================================================			
		
		//============================================================================================
		// (2013-10-15 추가) 시작
		// 김장욱 2013-10-15 요청자:박현정(FS기획팀)
		// 2013-10-14 FC간담회 후 확정절감비 추가 
		//============================================================================================
		//sbSql.append("     , DECODE(SUM(C.TRANS_COST_AMT + C.LOCAL_COST_AMT + C.EMP_COST_AMT), 0, 0, ROUND(100 * SUM(C.REAL_SAVE)/SUM(C.TRANS_COST_AMT + C.LOCAL_COST_AMT + C.EMP_COST_AMT), 2)) AS REAL_SAVE_RATE /* 확정절감액/전체식재료비 */ \n");
		
		if (strGUBUN.equals("M")){
			if (strStype.equals("2")){ 	// 재무단가
				sbSql.append("     , DECODE(SUM(C.TRANS_COST_AMT + C.LOCAL_COST_AMT + C.EMP_COST_AMT), 0, 0, ROUND(100 * SUM(C.U_REAL_SAVE)/SUM(C.TRANS_COST_AMT + C.LOCAL_COST_AMT + C.EMP_COST_AMT), 2)) AS REAL_SAVE_RATE /* 지원팀_재무확정절감액/전체식재료비 */ \n");
			}else{
				sbSql.append("     , DECODE(SUM(C.TRANS_COST_AMT + C.LOCAL_COST_AMT + C.EMP_COST_AMT), 0, 0, ROUND(100 * SUM(C.M_REAL_SAVE)/SUM(C.TRANS_COST_AMT + C.LOCAL_COST_AMT + C.EMP_COST_AMT), 2)) AS REAL_SAVE_RATE /* 지원팀_관리확정절감액/전체식재료비 */ \n");
			}
		}else{	//영양사
			sbSql.append("         , DECODE(SUM(C.TRANS_COST_AMT + C.LOCAL_COST_AMT + C.EMP_COST_AMT), 0, 0, ROUND(100 * SUM(C.U_REAL_SAVE)/SUM(C.TRANS_COST_AMT + C.LOCAL_COST_AMT + C.EMP_COST_AMT), 2)) AS REAL_SAVE_RATE /* 영양사_재무확정절감액/전체식재료비 */ \n");						
		}
		
		//============================================================================================
		//(2013-10-15 추가) 끝
		//============================================================================================			
		sbSql.append("  FROM MAC_UPJANG_V A \n");
		sbSql.append("     , (SELECT CODE FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'MA0045' AND USE_YN = 'Y') B \n");
		sbSql.append("     , T C \n");
		sbSql.append(" WHERE A.TM_CD = B.CODE \n");
		//sbSql.append("   AND A.UPJANG = C.UPJANG(+) \n");
		sbSql.append("   AND A.UPJANG = C.UPJANG \n");
		if (! strTmCd.equals(""))
			sbSql.append("   AND A.TM_CD = '" + strTmCd + "' \n");
		if (! strUpjang.equals(""))
			sbSql.append("   AND A.UPJANG = " + strUpjang + " \n");
		//sbSql.append("   AND A.OPEN_DATE <= '" + strToDt + "' \n");
		//sbSql.append("   AND NVL(A.CLOSE_DATE,'99999999') >= '" + strFromDt + "' \n");
		sbSql.append(" GROUP BY A.TM_CD, A.TM_NAME \n");
		sbSql.append("        , A.JOB_CD, A.JOB_NAME \n");
		sbSql.append("        , A.SUB_JOB_CD, A.SUB_JOB_NAME \n");
		sbSql.append("        , A.UPJANG, A.UPJANGNM \n");
		
out_vl.add("fa_Sql", sbSql.toString());
		System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_List = this.makeDataSet(rs, "ds_List");
		
		rs.close();
		pstmt.close();

		/**종료**/
		out_dl.add(ds_List);
		this.setResultMessage(0, "OK", out_vl);

	}
	catch(Exception ex)
	{
		//ex.printStackTrace();
		//jsp 로그남기기
		logger.debug(ex.getMessage(), ex);
		this.setResultMessage(-1, ex.toString(),out_vl); 
	}
	finally
	{
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