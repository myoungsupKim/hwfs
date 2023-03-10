<%
/*-----------------------------------------------------------------------------
■ 시스템명     : TOP화면 팝업조회
■ 프로그램ID   : SCCALRAM001_T001.jsp
■ 프로그램명   : TOP화면 팝업조회
■ 작성일자     : 2008.05.30
■ 작성자       : 박은규
■ 이력관리     : 2008.05.30
■ 주의사항     : 1.보건증 알림은 오늘그만보기 체크 시 오늘은 안뜸, 그냥 닫으면 계속 뜸.
               (FICS는 만기일10일,20일전 팝업 / IFIS는 알림일1,2,3에 팝업)
               2.FICS CS공지는 팝업과 동시에 자동 확인처리.(지정된 팝업횟수 만큼 뜸)
               3.게시판은 팝업과 동시에 자동 확인처리, 오늘이후 그만보기 체크 후 확인 시 계속 안뜸.
               4.일정관리는 로그인 시에만 시작일 및 종료일에 맞춰서 뜬다. 별도의 확인처리는 없다.
               5.협력업체 공지는 게시기간 동안 무조건 5회까지 팝업됨. 단, 확인처리 시 5회가 안되도 해당일은 그만뜸.
               6.협력업체 배송공지는 출력하지 않은 발주 건이 있을 경우 팝업처리.
               7.평균 발주량 초과 시 담당 CS에게 알림 팝업 처리.
               8.IFIS의 경우 로그인 시 담보정보 조회 담장자에게는(FMS00510V화면 권한자) 보증보험 만료 3달 전부터 팝업처리.
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
		//logger.startIndividualLog(in_vl.getString("titLogId"));

		//입력 데이타
		//DataSet ds_cond     = in_dl.get("ds_Cond");
		//입력 파라메터
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		String g_SystemId   = nullToBlank(in_vl.getString("g_SystemId"));
		String g_UserKind   = nullToBlank(in_vl.getString("g_UserKind"));   //본부/본사/사업장 구분 추가
		String g_MainUpjang = nullToBlank(in_vl.getString("g_MainUpjang"));
		String g_CustCd     = nullToBlank(in_vl.getString("g_CustCd"));
		String sFirst       = nullToBlank(in_vl.getString("sFirst"));

		//FileLog.println("d:\\aaa.txt", ds_cond);


		//out 데이타
		DataSet ds_List;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		//조회
		sbSql.append("SELECT * FROM \n");
		sbSql.append("( \n");
		if (((g_SystemId.equals("FICS")) || (g_SystemId.equals("SPOON")) ) && !"".equals(g_Upjang) )
		{
			//sbSql.append("/*----- 보건증알림 -----*/ \n");
			sbSql.append("SELECT '보건증' AS PTYPE \n");
			sbSql.append("     , '' AS PKEY \n");
			sbSql.append("     , '' AS PKEY2 \n");
			sbSql.append("     , '보건증 갱신알림' AS PTITLE \n");
			sbSql.append("     , '보건증 갱신내용' AS PCONTENTS \n");
			sbSql.append("     ,  TO_CHAR(A.CDATE,'YYYY-MM-DD HH24:MI:SS') AS PDATE \n");
			sbSql.append("     , 'SYSTEM' AS PFROMINFO \n");
			sbSql.append("     , 'U_FMO::FMO00061P.xfdl' AS PFORM \n");
			sbSql.append("     , '' AS PPARM \n");
			sbSql.append("  FROM FMO_LICEN_MGMT A \n");
			sbSql.append("     ,(SELECT * FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FM0011') C \n");
			sbSql.append(" WHERE A.LICEN_NAME = C.CODE \n");
			sbSql.append("   AND A.UPJANG = " + g_Upjang + " \n");
			sbSql.append("   AND A.EXPIRE_DATE > ' ' \n");
			sbSql.append("   AND C.SET1 = 'Y' \n");
			sbSql.append("   AND CEIL((TO_DATE(A.EXPIRE_DATE,'YYYYMMDD') - TO_DATE(TO_CHAR(SYSDATE,'YYYYMMDD'),'YYYYMMDD') )) IN (10,20) \n");
			sbSql.append("   AND EXISTS (SELECT 1 FROM SCC_USERINFO AA, HR_PERSONAL BB WHERE BB.SABUN = AA.SABUN AND BB.GB_JAEJIK = 'AA' AND AA.SABUN = '" + g_EmpNo + "' AND NVL(TO_CHAR(AA.LICEN_POPC_DATE,'YYYYMMDD'),'99999999') <> TO_CHAR(SYSDATE,'YYYYMMDD')) \n");
			sbSql.append("   AND ROWNUM <= 1 \n");
			sbSql.append(" UNION ALL \n");
			//sbSql.append("/*----- CS공지 -----*/ \n");
			//[[해당 테이블이 몰까? - 삭제
//			sbSql.append("SELECT /*+ INDEX(A FM_ALRAM_I2) */ \n");
//			sbSql.append("       'CS공지' AS PTYPE \n");
//			sbSql.append("     , TO_CHAR(A.ALRAM_ID) AS PKEY \n");
//			sbSql.append("     , '' AS PKEY2 \n");
//			sbSql.append("     , A.TITLE AS PTITLE \n");
//			sbSql.append("     , A.MEMO AS PCONTENTS \n");
//			sbSql.append("     , DECODE(A.SEND_NM_KOR,NULL,'시스템공지','CS '||A.SEND_NM_KOR) AS PFROMINFO \n");
//			sbSql.append("     , 'U_SCC::SCCALRAM001.xfdl' AS PFORM \n");
//			sbSql.append("     , '' AS PPARM \n");
//			sbSql.append("  FROM HLDC_FM_ALRAM A \n");
//			sbSql.append(" WHERE A.EMPNO = '" + g_EmpNo + "' \n");
//			sbSql.append("   AND SYSDATE BETWEEN NVL(A.F_DATE,TO_DATE('20040101','YYYYMMDD')) AND NVL(A.T_DATE,TO_DATE('21001231','YYYYMMDD')) \n");
//			sbSql.append("   AND A.POPUP_CNT > A.CONFIRM_CNT \n");
//			sbSql.append(" UNION ALL \n");
			//해당 테이블이 몰까? - 삭제]]

			if (g_UserKind.equals("본부"))
			{
				//sbSql.append("/*----- CS 담당 사업장  상품 초과발주 공지 -----*/ \n");
		        sbSql.append("SELECT   '발주초과공지' AS PTYPE                  \n");
		        sbSql.append("       , A.SUBINV_CODE AS PKEY                             \n");
		        sbSql.append("       , A.SDATE AS PKEY2                 \n");
		        sbSql.append("       , '평균발주량초과' PTITLE                   \n");
		        sbSql.append("       , '\n'||'\n'||' ◈ 사업장: ' ||C.UPJANGNM_DISP||'\n'||'\n'||' ◈ 창고: ' || B.SUBINV_NAME_DISP ||'\n'||'\n'||' ※ 평균 발주량의 200% 인  '||TRIM(TO_CHAR(A.AVG_AMT * 2,'999,999,999'))||' 금액을 초과 하였습니다.' || '\n'     \n");
		        sbSql.append("          ||'\n'|| ' 익일 발주 총액은 : ' || TRIM(TO_CHAR(D.TOT_AMT,'999,999,999')) ||' 원 입니다.' ||'\n'||'\n'||'\n'||' 해당 사업장 담당자는 : ' || C.PART_NAME || '(' || C.PART_HP_NO ||')' || ' 입니다.' AS PCONTENTS \n");
		        sbSql.append("     , TO_CHAR(A.CDATE,'YYYY-MM-DD HH24:MI:SS') PDATE \n");
				sbSql.append("     , 'SYSTEM' AS PFROMINFO \n");
		        sbSql.append("     , 'U_SCC::SCCALRAM001.xfdl' AS PFORM        \n");
		        sbSql.append("     , '' AS PPARM                              \n");
		        sbSql.append("  FROM FMP_PO_AVG_ALRAM A, FMS_SUBINVENTORY B, FMS_UPJANG C                                 \n");
		        sbSql.append("      ,( SELECT A.SUBINV_CODE , SUM(ROUND(A.PR_QTY * A.SALE_PRICE)) AS TOT_AMT   --총 금액       \n");
		        sbSql.append("           FROM SO_PR A,FMS_SUBINVENTORY B, FMS_UPJANG C                               \n");
		        sbSql.append("          WHERE C.CS_SABUN = '" + g_EmpNo + "'    \n");
		        sbSql.append("            AND C.UPJANG = B.UPJANG               \n");
		        sbSql.append("            AND B.SUBINV_CODE = A.SUBINV_CODE     \n");
		        //sbSql.append("            AND A.NEED_DATE = TO_CHAR(SYSDATE + 1 ,'YYYYMMDD')                               \n");
		        sbSql.append("            AND A.NEED_DATE = TO_CHAR(DECODE(TRIM(TO_CHAR(SYSDATE + 1,'DAY')),'SUNDAY',SYSDATE + 2, SYSDATE +1),'YYYYMMDD')      \n");
		        sbSql.append("            AND A.LINE_STATUS NOT IN ('003','999')                                           \n");
		        sbSql.append("            AND A.SUBINV_CODE LIKE 'S1%'                                                     \n");
		        sbSql.append("          GROUP BY A.SUBINV_CODE                                                             \n");
		        sbSql.append("          ) D                                                                                \n");
		        sbSql.append("  WHERE A.SUBINV_CODE = B.SUBINV_CODE                                                        \n");
		        sbSql.append("    AND B.UPJANG  = C.UPJANG                                                                 \n");
		        sbSql.append("    AND A.SUBINV_CODE = D.SUBINV_CODE                                                        \n");
		        sbSql.append("    AND C.CS_SABUN = '" + g_EmpNo + "'                                                       \n");
		        sbSql.append("    AND A.SDATE = TO_CHAR(SYSDATE ,'YYYYMMDD')                                               \n");
		        sbSql.append("    AND (A.AVG_AMT * 2)  < D.TOT_AMT                                                         \n");
		        sbSql.append("    AND ((A.CONFIRM_DATE <> TO_CHAR(SYSDATE,'YYYYMMDD')) OR (A.CONFIRM_DATE IS NULL))                           \n");
				sbSql.append(" UNION ALL \n");
			}
		}
//[[뭘까???
		// 		if (g_SystemId.equals("MFIS")&& sFirst.equals("Y"))
// 		{
// 	        sbSql.append("SELECT   '월마감공지' AS PTYPE                                                   \n");
// 	        sbSql.append("       , '' AS PKEY                                                              \n");
// 	        sbSql.append("       , '' AS PKEY2                                                             \n");
// 	        sbSql.append("       , '월마감 확인 공지' PTITLE                                               \n");
// 	        sbSql.append("       , '\n'||'\n'||' ◈ 금일은 '|| TO_CHAR(SYSDATE,'MM') ||'월의 마지막 날 입니다.' \n");
// 	        sbSql.append("          ||'\n'|| ' 이달의 마감여부를 확인 하시기 바랍니다.' AS PCONTENTS       \n");
// 	        sbSql.append("     , 'SYSTEM' AS PFROMINFO                                                     \n");
// 	        sbSql.append("     , 'U_SCC::SCCALRAM001.xfdl' AS PFORM                                         \n");
// 	        sbSql.append("     , '' AS PPARM                                                               \n");
// 	        sbSql.append("  FROM DUAL                                                                      \n");
// 	        sbSql.append(" UNION ALL \n");
// 		}
//뭘까???]]
		if (g_SystemId.equals("IFIS"))
		{
			//sbSql.append("/*----- 보건증알림 -----*/ \n");
			sbSql.append("SELECT '보건증' AS PTYPE \n");
			sbSql.append("     , '' AS PKEY \n");
			sbSql.append("     , '' AS PKEY2 \n");
			sbSql.append("     , '보건알림' AS PTITLE \n");
			sbSql.append("     , '보건알림' AS PCONTENTS \n");
			sbSql.append("     ,  TO_CHAR(A.CDATE,'YYYY-MM-DD HH24:MI:SS') AS PDATE \n");
			sbSql.append("     , 'SYSTEM' AS PFROMINFO \n");
			sbSql.append("     , 'U_FMO::FMO00061P.xfdl' AS PFORM \n");
			sbSql.append("     , '' AS PPARM \n");
			sbSql.append("  FROM FSC_HEALTH_CHECK A \n");
			sbSql.append(" WHERE A.UPJANG = " + g_Upjang + " \n");
			sbSql.append("   AND TO_CHAR(SYSDATE,'YYYYMMDD') IN (A.FIRST_INFORM, A.SECOND_INFORM, A.THIRD_INFORM) \n");
			sbSql.append("   AND EXISTS (SELECT 1 FROM SCC_USERINFO AA, HR_PERSONAL BB WHERE BB.SABUN = AA.SABUN AND BB.GB_JAEJIK = 'AA' AND AA.SABUN = '" + g_EmpNo + "' AND NVL(TO_CHAR(AA.LICEN_POPC_DATE,'YYYYMMDD'),'99999999') <> TO_CHAR(SYSDATE,'YYYYMMDD')) \n");
			sbSql.append("   AND ROWNUM <= 1 \n");
			sbSql.append(" UNION ALL \n");
			//sbSql.append("/*----- 로그인 시 보증보험 만료 3달 전부터 팝업처리 -----*/ \n");
			if (sFirst.equals("Y"))
			{
				sbSql.append("SELECT '보증보험' AS PTYPE \n");
				sbSql.append("     , '' AS PKEY \n");
				sbSql.append("     , '' AS PKEY2 \n");
				sbSql.append("     , '보증보험 만기예정' AS PTITLE \n");
				sbSql.append("     , A.PCONTENTS \n");
				sbSql.append("     , TO_CHAR(SYSDATE,'YYYY-MM-DD HH24:MI:SS') AS PDATE \n");
				sbSql.append("     , '시스템공지' AS PFROMINFO \n");
				sbSql.append("     , 'U_SCC::SCCALRAM001.xfdl' AS PFORM \n");
				sbSql.append("     , '' AS PPARM \n");
				sbSql.append("  FROM (SELECT FMS_GUARANEXPIREINFO_FUN(TO_CHAR(SYSDATE,'YYYYMM\"01\"'),TO_CHAR(ADD_MONTHS(SYSDATE,3),'YYYYMMDD')) AS PCONTENTS FROM DUAL) A \n");
				sbSql.append(" WHERE LENGTH(A.PCONTENTS) > 0 \n");
				sbSql.append("   AND EXISTS (SELECT 1 FROM SCC_USER_ROLE Z, SCC_ROLE_MENU Y, SCC_MENU X WHERE Y.SYS_TYPE = Z.SYS_TYPE AND Y.ROLE = Z.ROLE AND X.MENU_ID = Y.MENU_ID AND X.PRG_ID LIKE 'FMS00510V.%' AND Z.SABUN = '" + g_EmpNo + "') \n");
				sbSql.append(" UNION ALL \n");
			}
		}
		//sbSql.append("/*----- 게시판 -----*/ \n");
		sbSql.append("SELECT /*+ LEADING(A B C A0) USE_NL(A B C A0) */ \n");
		sbSql.append("       '게시판' AS PTYPE \n");
		sbSql.append("     , TO_CHAR(A.CON_ID) AS PKEY \n");
		sbSql.append("     , TO_CHAR(A0.BBS_ID) AS PKEY2 \n");
		sbSql.append("     , B.TITLE AS PTITLE \n");
		sbSql.append("     , B.CONTENTS AS PCONTENTS \n");
		sbSql.append("     , TO_CHAR(B.CDATE,'YYYY-MM-DD HH24:MI:SS') AS PDATE \n");
		sbSql.append("     , '['||A0.BBS_NAME||']'||C.NM_KOR AS PFROMINFO \n");
		sbSql.append("     , 'U_SCC::SCCALRAM001.xfdl' AS PFORM \n");
		sbSql.append("     , '' AS PPARM \n");
		sbSql.append("  FROM SCC_BBS A0, SCC_BBS_POPUP A, SCC_BBS_CON B, SCC_USERINFO C \n");
		sbSql.append(" WHERE A0.BBS_ID = B.BBS_ID \n");
		sbSql.append("   AND A.CON_ID = B.CON_ID \n");
		sbSql.append("   AND B.WRITE_SABUN = C.SABUN \n");
		
		sbSql.append(" AND A0.BBS_ID IN (SELECT ZA.BBS_ID \n");
		sbSql.append("        FROM SCC_BBSROLE_BBS ZA \n");
		sbSql.append("           , SCC_USER_BBSROLE ZB \n");
		sbSql.append("       WHERE ZB.BBSROLE = ZA.BBSROLE \n");
		sbSql.append("         AND ZB.SABUN = '" + g_EmpNo + "') \n");
		
		if (g_SystemId.equals("SPOON"))
		{
			sbSql.append("   AND DECODE(A0.BBS_TYPE,'100','IFIS','200','SPOON','300','FOMS','400','" + g_SystemId + "') = '" + g_SystemId + "' \n");
		}
		else
		{
			sbSql.append("   AND DECODE(A0.BBS_TYPE,'100','IFIS','200','FICS','300','FOMS','400','" + g_SystemId + "','600','" + g_SystemId + "') = '" + g_SystemId + "' \n");
		}
		sbSql.append("   AND A0.VOC_YN = 'N' \n");
		sbSql.append("   AND B.READ_ALL_YN = 'Y' \n");
		sbSql.append("   AND DECODE(A0.MAIN_YN,'Y',TO_CHAR(B.UPJANG),NVL('" + g_MainUpjang + "','0')) = NVL('" + g_MainUpjang + "','0') \n");
		sbSql.append("   AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN A.SDATE AND A.EDATE \n");
		sbSql.append("   AND NOT EXISTS \n");
		sbSql.append("      (SELECT /*+ UNNEST NL_AJ */ 1 FROM SCC_BBS_POPUP_CONF Z \n");
		sbSql.append("        WHERE Z.CON_ID = A.CON_ID \n");
		sbSql.append("          AND Z.SABUN = '" + g_EmpNo + "' \n");
		sbSql.append("          AND (TO_CHAR(Z.CONF_DATE,'YYYYMMDD') = TO_CHAR(SYSDATE,'YYYYMMDD') \n");
		sbSql.append("               OR Z.BLOCK_YN = 'Y')) \n");
		sbSql.append("-----------이상 전체공지 게시물 \n");
		sbSql.append(" UNION ALL \n");
		sbSql.append("-----------이하 부분공지 게시물 \n");
		sbSql.append("SELECT /*+ LEADING(A B A0 C) USE_NL(A B A0 C) */ \n");
		sbSql.append("       '게시판' AS PTYPE \n");
		sbSql.append("     , TO_CHAR(A.CON_ID) AS PKEY \n");
		sbSql.append("     , TO_CHAR(A0.BBS_ID) AS PKEY2 \n");
		sbSql.append("     , B.TITLE AS PTITLE \n");
		sbSql.append("     , B.CONTENTS AS PCONTENTS \n");
		sbSql.append("     , TO_CHAR(B.CDATE,'YYYY-MM-DD HH24:MI:SS') AS PDATE \n");
		sbSql.append("     , '['||A0.BBS_NAME||']'||C.NM_KOR AS PFROMINFO \n");
		sbSql.append("     , 'U_SCC::SCCALRAM001.xfdl' AS PFORM \n");
		sbSql.append("     , '' AS PPARM \n");
		sbSql.append("  FROM SCC_BBS A0, SCC_BBS_POPUP A, SCC_BBS_CON B, SCC_BBS_PRIV_LIST B1, SCC_USERINFO C \n");
		sbSql.append(" WHERE A0.BBS_ID = B.BBS_ID \n");
		sbSql.append("   AND A.CON_ID = B.CON_ID \n");
		sbSql.append("   AND B.CON_ID = B1.CON_ID \n");
		
		
		
		sbSql.append(" AND A0.BBS_ID IN (SELECT ZA.BBS_ID \n");
		sbSql.append("        FROM SCC_BBSROLE_BBS ZA \n");
		sbSql.append("           , SCC_USER_BBSROLE ZB \n");
		sbSql.append("       WHERE ZB.BBSROLE = ZA.BBSROLE \n");
		sbSql.append("         AND ZB.SABUN = '" + g_EmpNo + "') \n");

		
		
		sbSql.append("   AND B.WRITE_SABUN = C.SABUN \n");
		if (g_SystemId.equals("SPOON"))
		{
			sbSql.append("   AND DECODE(A0.BBS_TYPE,'100','IFIS','200','SPOON','300','FOMS','400','" + g_SystemId + "') = '" + g_SystemId + "' \n");
		}
		else
		{
			sbSql.append("   AND DECODE(A0.BBS_TYPE,'100','IFIS','200','FICS','300','FOMS','400','" + g_SystemId + "','400','" + g_SystemId + "','600','" + g_SystemId + "') = '" + g_SystemId + "' \n");
		}
		sbSql.append("   AND A0.VOC_YN = 'N' \n");
		sbSql.append("   AND B.READ_ALL_YN = 'N' \n");
		if (g_SystemId.equals("FOMS"))
			sbSql.append("   AND B1.TARGET_CODE = NVL('" + g_CustCd + "','0') \n");
		else
			sbSql.append("   AND B1.TARGET_CODE = NVL('" + g_Upjang + "','0') \n");
		sbSql.append("   AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN A.SDATE AND A.EDATE \n");
		

		//sbSql.append("   AND NOT EXISTS \n");
		//sbSql.append("      (SELECT /*+ UNNEST NL_AJ */ 1 FROM SCC_BBS_POPUP_CONF Z \n");
		//sbSql.append("        WHERE Z.CON_ID = A.CON_ID \n");
		//sbSql.append("          AND Z.SABUN = '" + g_EmpNo + "' \n");
		//sbSql.append("          AND (TO_CHAR(Z.CONF_DATE,'YYYYMMDD') = TO_CHAR(SYSDATE,'YYYYMMDD') \n");
		//sbSql.append("               OR Z.BLOCK_YN = 'Y')) \n");
		
		//일정관리는 최초 로그인시만 팝업처리(협력업체 제외)
//		if ((! g_SystemId.equals("FOMS")) && sFirst.equals("Y"))
//		{
//			sbSql.append(" UNION ALL \n");
//			//sbSql.append("/*----- 일정관리 -----*/ \n");
//			sbSql.append("SELECT /*+ INDEX_DESC(A SCC_BBS_POPUP_PK) */ \n");
//			sbSql.append("       '일정관리' AS PTYPE \n");
//			sbSql.append("     , TO_CHAR(A.SCH_ID) AS PKEY \n");
//			sbSql.append("     , '' AS PKEY2 \n");
//			sbSql.append("     , A.TITLE AS PTITLE \n");
//			sbSql.append("     , A.CONTENTS AS PCONTENTS \n");
//			sbSql.append("     , B.NM_KOR AS PFROMINFO \n");
//			sbSql.append("     , 'U_SCC::SCCALRAM001.xfdl' AS PFORM \n");
//			sbSql.append("     , '' AS PPARM \n");
//			sbSql.append("  FROM SCC_SCHEDULE A, SCC_USERINFO B \n");
//			sbSql.append(" WHERE A.REGI_SABUN = B.SABUN \n");
//			sbSql.append("   AND A.UPJANG = " + g_Upjang + " \n");
//			sbSql.append("   AND A.ALRAM_YN = 'Y' \n");
//			sbSql.append("   AND TO_CHAR(SYSDATE,'YYYYMMDD') IN (A.SDATE,A.EDATE) \n");
//			if (g_SystemId.equals("FICS"))
//			{
//				sbSql.append(" UNION ALL \n");
//				sbSql.append("SELECT /*+ INDEX_DESC(A SCC_BBS_POPUP_PK) */ \n");
//				sbSql.append("       '일정관리' AS PTYPE \n");
//				sbSql.append("     , TO_CHAR(A.SCH_ID) AS PKEY \n");
//				sbSql.append("     , '' AS PKEY2 \n");
//				sbSql.append("     , A.TITLE AS PTITLE \n");
//				sbSql.append("     , A.CONTENTS AS PCONTENTS \n");
//				sbSql.append("     , B.NM_KOR AS PFROMINFO \n");
//				sbSql.append("     , 'U_SCC::SCCALRAM001.xfdl' AS PFORM \n");
//				sbSql.append("     , '' AS PPARM \n");
//				sbSql.append("  FROM SCC_SCHEDULE A, SCC_USERINFO B \n");
//				sbSql.append("     , SCC_SCH_GROUP_UPJANG C \n");
//				sbSql.append(" WHERE A.REGI_SABUN = B.SABUN \n");
//				sbSql.append("   AND A.GROUP_CODE = C.GROUP_CODE \n");
//				sbSql.append("   AND A.UPJANG != " + g_Upjang + " \n");
//				sbSql.append("   AND C.UPJANG = " + g_Upjang + " \n");
//				sbSql.append("   AND A.ALRAM_YN = 'Y' \n");
//				sbSql.append("   AND TO_CHAR(SYSDATE,'YYYYMMDD') IN (A.SDATE,A.EDATE) \n");
//			}
//		}
		//협력업체인 경우 협력업체 공지/배송공지
		if (g_SystemId.equals("FOMS"))
		{
// 			sbSql.append(" UNION ALL \n");
// 			//sbSql.append("/*----- 협력업체 공지 -----*/ \n");
// 			sbSql.append("SELECT /* INDEX(A PO_ALRAM_FK) */ \n");
// 			sbSql.append("       '협력업체공지' AS PTYPE \n");
// 			sbSql.append("     , TO_CHAR(A.ALRAM_ID) AS PKEY \n");
// 			sbSql.append("     , '' AS PKEY2 \n");
// 			//sbSql.append("     , DECODE(A.PO_YN,'Y','발주확정','공지사항') AS PTITLE \n");
// 			sbSql.append("     , '구매관리자님이 보낸 메모가 왔습니다.' AS PTITLE \n");
// 			sbSql.append("     , A.MEMO AS PCONTENTS \n");
// 			sbSql.append("     , '한화리조트 구매관리자' AS PFROMINFO \n");
// 			sbSql.append("     , 'U_SCC::SCCALRAM001.xfdl' AS PFORM \n");
// 			sbSql.append("     , '' AS PPARM \n");
// 			sbSql.append("  FROM HLDC_PO_ALRAM A \n");
// 			sbSql.append(" WHERE A.CUSTCD = TO_NUMBER(NVL('" + g_CustCd + "','0')) \n");
// 			sbSql.append("   AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN A.F_DATE AND A.T_DATE \n");
// 			sbSql.append("   AND NVL(TO_CHAR(A.CONFIRM_DATE,'YYYYMMDD'),'미확인') <> TO_CHAR(SYSDATE,'YYYYMMDD') \n");
// 			sbSql.append("   AND A.POPUP_CNT < 5 \n");
// 			sbSql.append(" UNION ALL \n");
// 			//sbSql.append("/*----- 배송 공지 -----*/ \n");
// 			sbSql.append("SELECT '배송공지' AS PTYPE \n");
// 			sbSql.append("     , '' AS PKEY \n");
// 			sbSql.append("     , '' AS PKEY2 \n");
// 			sbSql.append("     , '구매관리자님이 보낸 메모가 왔습니다.' AS PTITLE \n");
// 			//sbSql.append("     , '배송분류표를 출력하시지 않았습니다.' \n");
// 			//sbSql.append("     ||CHR(13)||CHR(13) \n");
// 			//sbSql.append("     ||'발주번호:'||A.ORDER_NUM \n");
// 			//sbSql.append("     ||CHR(13)||CHR(13) \n");
// 			//sbSql.append("     ||MAX(A.ITEM_NAME)||DECODE(SIGN(COUNT(*) - 1),1,' 외 '||TO_CHAR(COUNT(*) - 1)||'종') AS PCONTENTS \n");
// 			sbSql.append("     , '('||REPLACE(B.CENTER_NAME,'센터','')||')배송분류표를 출력하시지 않았습니다.('||A.ORDER_NUM||')' AS PCONTENTS \n");
// 			sbSql.append("     , '한화리조트 구매관리자' AS PFROMINFO \n");
// 			sbSql.append("     , 'U_SCC::SCCALRAM001.xfdl' AS PFORM \n");
// 			sbSql.append("     , '' AS PPARM \n");
// 			sbSql.append("  FROM HLDC_PO_PO A, HLDC_PO_CENTER B \n");
// 			sbSql.append(" WHERE A.CENTER_CODE = B.CENTER_CODE \n");
// 			sbSql.append("   AND A.NEED_DATE = TO_CHAR(SYSDATE+1,'YYYYMMDD') \n");
// 			sbSql.append("   AND A.CUSTCD = TO_NUMBER(NVL('" + g_CustCd + "','0')) \n");
// 			sbSql.append("   AND A.LINE_STATUS = DECODE(A.CENTER_FLAG,'Y','008','009') \n");
// 			sbSql.append("   AND (A.CENTER_DELI_QTY + A.DIRECT_DELI_QTY) <> 0 \n");
// 			sbSql.append("   AND NOT EXISTS (SELECT 1 FROM HLDC_PO_ORDER_PRT Z \n");
// 			sbSql.append("                    WHERE Z.ORDER_NUM = A.ORDER_NUM \n");
// 			sbSql.append("                      AND Z.NEED_DATE = A.NEED_DATE \n");
// 			sbSql.append("                      AND Z.CENTER_CODE = A.CENTER_CODE \n");
// 			sbSql.append("                      AND Z.CUSTCD = TO_NUMBER(NVL('" + g_CustCd + "','0')) \n");
// 			sbSql.append("                      AND Z.NEED_DATE = TO_CHAR(SYSDATE+1,'YYYYMMDD')) \n");
// 			sbSql.append(" GROUP BY A.ORDER_NUM, B.CENTER_NAME \n");
		}
		sbSql.append(") A \n");
		sbSql.append(" ORDER BY A.PDATE DESC \n");

//out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		//jsp 로그남기기
		//logger.debug(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		ds_List = this.makeDataSet(rs, "ds_List");
		pstmt.close();
		rs.close();

		//기존확인 초기화
		//sbSql.delete(0, sbSql.length());
		////sbSql.append("/*----- 기존팝업확인 초기화 -----*/ \n");
		//sbSql.append("DELETE FROM SCC_BBS_POPUP_CONF A \n");
		//sbSql.append(" WHERE (A.CON_ID, A.SABUN) IN \n");
		//sbSql.append("( \n");
		//sbSql.append("SELECT A.CON_ID, '" + g_EmpNo + "' \n");
		//sbSql.append("  FROM SCC_BBS A0, SCC_BBS_POPUP A, SCC_BBS_CON B \n");
		//sbSql.append(" WHERE A0.BBS_ID = B.BBS_ID \n");
		//sbSql.append("   AND A.CON_ID = B.CON_ID \n");
		//if (g_SystemId.equals("SPOON"))
		//{
			//sbSql.append("   AND DECODE(A0.BBS_TYPE,'100','IFIS','200','SPOON','300','FOMS','400','" + g_SystemId + "') = '" + g_SystemId + "' \n");
		//}
		//else
		//{
			//sbSql.append("   AND DECODE(A0.BBS_TYPE,'100','IFIS','200','FICS','300','FOMS','400','" + g_SystemId + "') = '" + g_SystemId + "' \n");
		//}
		//sbSql.append("   AND A0.VOC_YN = 'N' \n");
		//sbSql.append("   AND B.READ_ALL_YN = 'Y' \n");
		//sbSql.append("   AND DECODE(A0.MAIN_YN,'Y',TO_CHAR(B.UPJANG),NVL('" + g_MainUpjang + "','0')) = NVL('" + g_MainUpjang + "','0') \n");
		//sbSql.append("   AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN A.SDATE AND A.EDATE \n");
		//sbSql.append("   AND NOT EXISTS \n");
		//sbSql.append("      (SELECT 1 FROM SCC_BBS_POPUP_CONF Z \n");
		//sbSql.append("        WHERE Z.CON_ID = A.CON_ID \n");
		//sbSql.append("          AND Z.SABUN = '" + g_EmpNo + "' \n");
		//sbSql.append("          AND (TO_CHAR(Z.CONF_DATE,'YYYYMMDD') = TO_CHAR(SYSDATE,'YYYYMMDD') \n");
		//sbSql.append("               OR Z.BLOCK_YN = 'Y')) \n");
		//sbSql.append("-----------이상 전체공지 게시물 \n");
		//sbSql.append(" UNION ALL \n");
		//sbSql.append("-----------이하 부분공지 게시물 \n");
		//sbSql.append("SELECT A.CON_ID, '" + g_EmpNo + "' \n");
		//sbSql.append("  FROM SCC_BBS A0, SCC_BBS_POPUP A, SCC_BBS_CON B, SCC_BBS_PRIV_LIST B1 \n");
		//sbSql.append(" WHERE A0.BBS_ID = B.BBS_ID \n");
		//sbSql.append("   AND A.CON_ID = B.CON_ID \n");
		//sbSql.append("   AND B.CON_ID = B1.CON_ID \n");
		//if (g_SystemId.equals("SPOON"))
		//{
			//sbSql.append("   AND DECODE(A0.BBS_TYPE,'100','IFIS','200','SPOON','300','FOMS','400','" + g_SystemId + "') = '" + g_SystemId + "' \n");
		//}
		//else
		//{
			//sbSql.append("   AND DECODE(A0.BBS_TYPE,'100','IFIS','200','FICS','300','FOMS','400','" + g_SystemId + "') = '" + g_SystemId + "' \n");
		//}
		//sbSql.append("   AND A0.VOC_YN = 'N' \n");
		//sbSql.append("   AND B.READ_ALL_YN = 'N' \n");
		//if (g_SystemId.equals("FOMS"))
			//sbSql.append("   AND B1.TARGET_CODE = NVL('" + g_CustCd + "','0') \n");
		//else
			//sbSql.append("   AND B1.TARGET_CODE = NVL('" + g_Upjang + "','0') \n");
		//sbSql.append("   AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN A.SDATE AND A.EDATE \n");
		//sbSql.append("   AND NOT EXISTS \n");
		//sbSql.append("      (SELECT 1 FROM SCC_BBS_POPUP_CONF Z \n");
		//sbSql.append("        WHERE Z.CON_ID = A.CON_ID \n");
		//sbSql.append("          AND Z.SABUN = '" + g_EmpNo + "' \n");
		//sbSql.append("          AND (TO_CHAR(Z.CONF_DATE,'YYYYMMDD') = TO_CHAR(SYSDATE,'YYYYMMDD') \n");
		//sbSql.append("               OR Z.BLOCK_YN = 'Y')) \n");
		//sbSql.append(") \n");
//out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		//로그남기기
		//logger.debug(sbSql.toString());
		//pstmt = conn.prepareStatement(sbSql.toString());
		//pstmt.executeUpdate();
		//pstmt.close();

		//게시물 자동 확인
		//게시판 팝업 확인처리
		//sbSql.delete(0, sbSql.length());
		////sbSql.append("/*----- 게시판 팝업 확인처리 -----*/ \n");
		//sbSql.append("INSERT INTO SCC_BBS_POPUP_CONF \n");
		//sbSql.append("(CON_ID, SABUN, CONF_DATE, BLOCK_YN, CUSER, CDATE) \n");
		//sbSql.append("SELECT A.CON_ID, '" + g_EmpNo + "', SYSDATE, 'N'  \n");
		//sbSql.append("     , '" + g_EmpNo + "', SYSDATE \n");
		//sbSql.append("  FROM SCC_BBS A0, SCC_BBS_POPUP A, SCC_BBS_CON B \n");
		//sbSql.append(" WHERE A0.BBS_ID = B.BBS_ID \n");
		//sbSql.append("   AND A.CON_ID = B.CON_ID \n");
		//if (g_SystemId.equals("SPOON"))
		//{
			//sbSql.append("   AND DECODE(A0.BBS_TYPE,'100','IFIS','200','SPOON','300','FOMS','400','" + g_SystemId + "') = '" + g_SystemId + "' \n");
		//}
		//else
		//{
			//sbSql.append("   AND DECODE(A0.BBS_TYPE,'100','IFIS','200','FICS','300','FOMS','400','" + g_SystemId + "') = '" + g_SystemId + "' \n");
		//}
		//sbSql.append("   AND A0.VOC_YN = 'N' \n");
		//sbSql.append("   AND B.READ_ALL_YN = 'Y' \n");
		//sbSql.append("   AND DECODE(A0.MAIN_YN,'Y',TO_CHAR(B.UPJANG),NVL('" + g_MainUpjang + "','0')) = NVL('" + g_MainUpjang + "','0') \n");
		//sbSql.append("   AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN A.SDATE AND A.EDATE \n");
		//sbSql.append("   AND NOT EXISTS \n");
		//sbSql.append("      (SELECT 1 FROM SCC_BBS_POPUP_CONF Z \n");
		//sbSql.append("        WHERE Z.CON_ID = A.CON_ID \n");
		//sbSql.append("          AND Z.SABUN = '" + g_EmpNo + "' \n");
		//sbSql.append("          AND (TO_CHAR(Z.CONF_DATE,'YYYYMMDD') = TO_CHAR(SYSDATE,'YYYYMMDD') \n");
		//sbSql.append("               OR Z.BLOCK_YN = 'Y')) \n");
		//sbSql.append("-----------이상 전체공지 게시물 \n");
		//sbSql.append(" UNION ALL \n");
		//sbSql.append("-----------이하 부분공지 게시물 \n");
		//sbSql.append("SELECT A.CON_ID, '" + g_EmpNo + "', SYSDATE, 'N'  \n");
		//sbSql.append("     , '" + g_EmpNo + "', SYSDATE \n");
		//sbSql.append("  FROM SCC_BBS A0, SCC_BBS_POPUP A, SCC_BBS_CON B, SCC_BBS_PRIV_LIST B1 \n");
		//sbSql.append(" WHERE A0.BBS_ID = B.BBS_ID \n");
		//sbSql.append("   AND A.CON_ID = B.CON_ID \n");
		//sbSql.append("   AND B.CON_ID = B1.CON_ID \n");
		//if (g_SystemId.equals("SPOON"))
		//{
			//sbSql.append("   AND DECODE(A0.BBS_TYPE,'100','IFIS','200','SPOON','300','FOMS','400','" + g_SystemId + "') = '" + g_SystemId + "' \n");
		//}
		//else
		//{
			//sbSql.append("   AND DECODE(A0.BBS_TYPE,'100','IFIS','200','FICS','300','FOMS','400','" + g_SystemId + "') = '" + g_SystemId + "' \n");
		//}

		//sbSql.append("   AND A0.VOC_YN = 'N' \n");
		//sbSql.append("   AND B.READ_ALL_YN = 'N' \n");
		//if (g_SystemId.equals("FOMS"))
			//sbSql.append("   AND B1.TARGET_CODE = NVL('" + g_CustCd + "','0') \n");
		//else
			//sbSql.append("   AND B1.TARGET_CODE = NVL('" + g_Upjang + "','0') \n");
		//sbSql.append("   AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN A.SDATE AND A.EDATE \n");
		//sbSql.append("   AND NOT EXISTS \n");
		//sbSql.append("      (SELECT 1 FROM SCC_BBS_POPUP_CONF Z \n");
		//sbSql.append("        WHERE Z.CON_ID = A.CON_ID \n");
		//sbSql.append("          AND Z.SABUN = '" + g_EmpNo + "' \n");
		//sbSql.append("          AND (TO_CHAR(Z.CONF_DATE,'YYYYMMDD') = TO_CHAR(SYSDATE,'YYYYMMDD') \n");
		//sbSql.append("               OR Z.BLOCK_YN = 'Y')) \n");
////out_vl.add("fa_Sql", sbSql.toString());
		////System.out.println(sbSql.toString());
		////로그남기기
		////logger.debug(sbSql.toString());
		//pstmt = conn.prepareStatement(sbSql.toString());
		//pstmt.executeUpdate();
		//pstmt.close();

		//CS공지는 팝업과 동시에 확인처리
		//if (g_SystemId.equals("FICS"))
		if ((g_SystemId.equals("FICS")) || (g_SystemId.equals("SPOON")) )
		{
// 			sbSql.delete(0, sbSql.length());
// 			//sbSql.append("/*----- CS공지확인처리 -----*/ \n");
// 			sbSql.append("UPDATE HLDC_FM_ALRAM A \n");
// 			sbSql.append("   SET A.CONFIRM_CNT = A.CONFIRM_CNT + 1 \n");
// 			sbSql.append("     , A.CONFIRM_DATE = SYSDATE \n");
// 			sbSql.append("     , A.UPDATE_BY    = '" + g_EmpNo + "' \n");
// 			sbSql.append("     , A.UPDATE_DATE  = SYSDATE \n");
// 			sbSql.append(" WHERE A.EMPNO = '" + g_EmpNo + "' \n");
// 			sbSql.append("   AND SYSDATE BETWEEN A.F_DATE AND A.T_DATE \n");
// 			sbSql.append("   AND A.POPUP_CNT > A.CONFIRM_CNT \n");

// //out_vl.add("fa_Sql", sbSql.toString());
// 			//System.out.println(sbSql.toString());
// 			//로그남기기
// 			//logger.debug(sbSql.toString());
// 			pstmt = conn.prepareStatement(sbSql.toString());
// 			pstmt.executeUpdate();
// 			pstmt.close();
		}
		//협력업체 공지는 팝업과 동시에 팝업카운트
		if (g_SystemId.equals("FOMS"))
		{
// 			sbSql.delete(0, sbSql.length());
// 			//sbSql.append("/*----- 협력업체공지카운트 -----*/ \n");
// 			sbSql.append("UPDATE HLDC_PO_ALRAM A \n");
// 			sbSql.append("   SET A.POPUP_CNT = A.POPUP_CNT + 1 \n");
// 			sbSql.append(" WHERE A.CUSTCD = TO_NUMBER(NVL('" + g_CustCd + "','0')) \n");
// 			sbSql.append("   AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN A.F_DATE AND A.T_DATE \n");
// 			sbSql.append("   AND NVL(TO_CHAR(A.CONFIRM_DATE,'YYYYMMDD'),'미확인') <> TO_CHAR(SYSDATE,'YYYYMMDD') \n");
// 			sbSql.append("   AND A.POPUP_CNT < 5 \n");

// //out_vl.add("fa_Sql", sbSql.toString());
// 			//System.out.println(sbSql.toString());
// 			//로그남기기
// 			//logger.debug(sbSql.toString());
// 			pstmt = conn.prepareStatement(sbSql.toString());
// 			pstmt.executeUpdate();
// 			pstmt.close();

// 			//협력업체 배송공지도 1회만 팝업
// 			sbSql.delete(0, sbSql.length());
// 			//sbSql.append("/*----- 확인 -----*/ \n");
// 			sbSql.append("INSERT INTO HLDC_PO_ORDER_PRT \n");
// 			sbSql.append("(ORDER_NUM, NEED_DATE, CENTER_CODE, CUSTCD, ORDER_DISP, ORDER_AMOUNT, PRT_FLAG, PRT_TIME, PRT_SABUN, CREATE_DATE, CREATE_BY, UPDATE_DATE, UPDATE_BY) \n");
// 			sbSql.append("SELECT A.ORDER_NUM \n");
// 			sbSql.append("     , TO_CHAR(SYSDATE+1,'YYYYMMDD') AS NEED_DATE \n");
// 			sbSql.append("     , A.CENTER_CODE \n");
// 			sbSql.append("     , NVL('" + g_CustCd + "','0') AS CUSTCD \n");
// 			sbSql.append("     , MAX(A.ITEM_NAME)||DECODE(SIGN(COUNT(*) - 1),1,' 외 '||TO_CHAR(COUNT(*) - 1)||'종') AS ORDER_DISP \n");
// 			sbSql.append("     , SUM(ROUND(A.UNIT_PRICE * (A.CENTER_DELI_QTY + A.DIRECT_DELI_QTY))) AS ORDER_AMOUNT \n");
// 			sbSql.append("     , 'N' \n");
// 			sbSql.append("     , NULL \n");
// 			sbSql.append("     , NULL \n");
// 			sbSql.append("     , SYSDATE \n");
// 			sbSql.append("     , '" + g_EmpNo + "' \n");
// 			sbSql.append("     , SYSDATE \n");
// 			sbSql.append("     , '" + g_EmpNo + "' \n");
// 			sbSql.append("  FROM HLDC_PO_PO A \n");
// 			sbSql.append(" WHERE A.NEED_DATE = TO_CHAR(SYSDATE+1,'YYYYMMDD') \n");
// 			sbSql.append("   AND A.CUSTCD = TO_NUMBER(NVL('" + g_CustCd + "','0')) \n");
// 			sbSql.append("   AND A.LINE_STATUS = DECODE(A.CENTER_FLAG,'Y','008','009') \n");
// 			sbSql.append("   AND (A.CENTER_DELI_QTY + A.DIRECT_DELI_QTY) <> 0 \n");
// 			sbSql.append("   AND NOT EXISTS (SELECT 1 FROM HLDC_PO_ORDER_PRT Z \n");
// 			sbSql.append("                    WHERE Z.ORDER_NUM = A.ORDER_NUM \n");
// 			sbSql.append("                      AND Z.NEED_DATE = A.NEED_DATE \n");
// 			sbSql.append("                      AND Z.CENTER_CODE = A.CENTER_CODE \n");
// 			sbSql.append("                      AND Z.CUSTCD = TO_NUMBER(NVL('" + g_CustCd + "','0')) \n");
// 			sbSql.append("                      AND Z.NEED_DATE = TO_CHAR(SYSDATE+1,'YYYYMMDD')) \n");
// 			sbSql.append(" GROUP BY A.ORDER_NUM, A.CENTER_CODE \n");

// //out_vl.add("fa_Sql", sbSql.toString());
// 			//System.out.println(sbSql.toString());
// 			//로그남기기
// 			//logger.debug(sbSql.toString());
// 			pstmt = conn.prepareStatement(sbSql.toString());
// 			pstmt.executeUpdate();
// 			pstmt.close();
		}

		/**종료**/
		out_dl.add(ds_List);
		conn.commit();
		this.setResultMessage(0, "OK", out_vl);

	}
	catch(Exception ex)
	{
		conn.rollback();
		ex.printStackTrace();
		//jsp 로그남기기
		//logger.debug(ex.getMessage(), ex);
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
//		try {
//			logger.endIndividualLog();
//		} catch( Exception logE) {
//			logE.printStackTrace();
//		}
	}

	proc_output(response,out,out_vl,out_dl);

%>
