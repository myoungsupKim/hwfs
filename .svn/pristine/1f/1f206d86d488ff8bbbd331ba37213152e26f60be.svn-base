<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 경영관리/손익실적
■ 프로그램ID   : MAS40070E_S001.jsp
■ 프로그램명   : 주간손익조회
■ 작성일자     : 2014-02-14
■ 작성자       : 김장욱
■ 이력관리     : 
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
		//입력 파라메터
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		
		//FileLog.println("d:\\aaa.txt", ds_Cond);
		
		//System.out.println("g_Upjang-------------------" + g_Upjang);

		//out 데이타
		DataSet ds_List;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		
		// 업장실적마감
		if(ds_Cond.getString(0, "DIV").equals("U")){
			//=============================================================================================
			// ※ 로직이 조금 복잡하니 아래 주석을 꼭 확인하자.	
			// 입력된 데이터가 관리금액으로 들어가 있기때문에 재무금액으로 조회하려면 관리금액에서 재무금액으로 재계산하여야 한다.
			// 재무금액으로 적용되는 계정은 '식음료원가'만 적용된다.
			// '식음료원가'의 재무금액 = '식음료원가'의관리금액/업장의 출하율*100
			// '식음료원가'의 금액이 변경되면 그 상위 계정인 '재료비', '매출원가'계정의 값이 변경된다.
			// '재료비', '매출원가'계정의 재계산을 위해서 재료비(PLB20000)와 매출원가(PLB00000)계정에 관리금액과 재무금액의 
			// 차이만큼 빼준다.
			// 구해진 이 금액은 '식음료원가'계정에만 적용된다.
			// 상품매출원가의 '재무'와 '관리'의 금액차이를 구한다.
	        //=============================================================================================
			sbSql.append("SELECT CASE WHEN A10.ATTR03 = 'Y' THEN                  \n");
	        sbSql.append("            C10.MON_GSS_AMT - C10.MON_GSS_U_AMT         \n");
	        sbSql.append("       ELSE                                             \n");
	        sbSql.append("            0                                           \n");
	        sbSql.append("       END MON_GSS_DIFF_AMT  /* 월추정의 관리와 재무의 차액 */ \n");
	        sbSql.append("     , CASE WHEN A10.ATTR03 = 'Y' THEN                  \n");
	        sbSql.append("            A10.MON_PL_AMT - A10.MON_PL_U_AMT           \n");
	        sbSql.append("       ELSE                                             \n");
	        sbSql.append("            0                                           \n");
	        sbSql.append("       END MON_PL_DIFF_AMT  /* 월계획의 관리와 재무의 차액 */ \n");
	        sbSql.append("     , CASE WHEN A10.ATTR03 = 'Y' THEN                  \n");
	        sbSql.append("            B10.ACCU_PL_AMT - B10.ACCU_PL_U_AMT         \n");
	        sbSql.append("       ELSE                                             \n");
	        sbSql.append("            0                                           \n");
	        sbSql.append("       END ACCU_PL_DIFF_AMT  /* 조회일 누계계획의 관리와 재무의 차액 */ \n");
	        sbSql.append("     , CASE WHEN A10.ATTR03 = 'Y' THEN                  \n");
	        sbSql.append("            B10.ACCU_RLT_AMT - B10.ACCU_RLT_U_AMT       \n");
	        sbSql.append("       ELSE                                             \n");
	        sbSql.append("            0                                           \n");
	        sbSql.append("       END ACCU_RLT_DIFF_AMT  /* 조회일 누계실적의 관리와 재무의 차액 */ \n");
	        sbSql.append("  FROM (-- 월계획                                                                                                                                                                \n");
	        sbSql.append("        SELECT /*+ INDEX(A MAS_DAILY_PL_REPORT_PK)  */                                                                                                                           \n");
	        sbSql.append("               B.MGMT_ACCT_CD    -- 관리계정코드                                                                                                                                 \n");
	        sbSql.append("             , B.MGMT_ACCT_NAME                                                                                                                                                  \n");
	        sbSql.append("             , B.ATTR03                                                                                                                                                  \n");
	        sbSql.append("             , NVL(SUM(A.ACT_AMT), 0) AS MON_PL_AMT -- 월계획금액                                                                                                                \n");
	        sbSql.append("             , NVL(SUM(                                                                                                                                                          \n");
	        sbSql.append("                       CASE WHEN B.ATTR03 = 'Y' AND 'U' = '" + ds_Cond.getString(0, "STYPE") + "' THEN -- 상품매출원가이고 조회구분이 '재무'이면 계산(금액 / 출하율 * 100)해서 보여준다. '관리(M)'이면 계산하지 않음. \n");
	        sbSql.append("                               A.ACT_AMT / NVL((SELECT M_RATE FROM MAS_UPJANG_M_RATE_MGMT WHERE INPUT_YM = SUBSTR('" + ds_Cond.getString(0, "INPUT_YMD") + "', 1, 6) AND DOC_CD = A.DOC_CD AND GUBUN = 'P'), 100) * 100           \n");
	        sbSql.append("                            ELSE                                                                                                                                                 \n");
	        sbSql.append("                               A.ACT_AMT                                                                                                                                         \n");
	        sbSql.append("                       END                                                                                                                                                       \n");
	        sbSql.append("                      ),                                                                                                                                                         \n");
	        sbSql.append("                   0) AS MON_PL_U_AMT -- 월계획금액(출하율 적용금액)                                                                                                             \n");
	        sbSql.append("          FROM MAS_DAILY_PL_REPORT A                                                                                                                                             \n");
	        sbSql.append("             , MAC_MGMT_ACCT B                                                                                                                                                   \n");
	        sbSql.append("         WHERE 1 = 1                                                                                                                                                             \n");
	        sbSql.append("           AND A.MGMT_ACCT_CD(+) = B.MGMT_ACCT_CD                                                                                                                                \n");
	        sbSql.append("           AND B.ACCT_TYPE = 'WP'                                                                                                                                                \n");
	        sbSql.append("           AND B.USE_YN = 'Y'                                                                                                                                                    \n");
	        sbSql.append("           AND B.ATTR03 = 'Y'                                                                                                                                                    \n");
	        sbSql.append("           AND A.INPUT_YM(+) = SUBSTR('" + ds_Cond.getString(0, "INPUT_YMD") + "', 1, 6) /* 파라미터 */                                                                                                           \n");
	        
	        // 업장(마케터)정보
	        if(!ds_Cond.getString(0, "DOC_CD").equals("")){
	        	sbSql.append("       AND A.DOC_CD(+) = '" + ds_Cond.getString(0, "DOC_CD") + "'  /* 업장 또는 마케터 */   \n");
	        } 
	        
	        // 팀정보
	        sbSql.append("           AND EXISTS (SELECT 1 FROM SCO_UPJANG_MST_V WHERE UPJANG = A.DOC_CD AND TM_CD = '" + ds_Cond.getString(0, "TM_CD") + "') /* 팀만 선택했을 경우(마케터 제외) */   \n");
	        
	        sbSql.append("           AND A.DOC_GUBUN(+) = 'P'                                                                                                                                              \n");
	        sbSql.append("         GROUP BY B.MGMT_ACCT_CD, B.MGMT_ACCT_NAME, B.ATTR03                                                                                                                              \n");
	        sbSql.append("       ) A10,                                                                                                                                                                    \n");
	        sbSql.append("       (-- 월실적(확정쿼리)                                                                                                                                                      \n");
	        sbSql.append("        SELECT /*+ INDEX(A MAS_DAILY_PL_REPORT_PK)  */                                                                                                                           \n");
	        sbSql.append("               B.MGMT_ACCT_CD    -- 관리계정코드                                                                                                                                 \n");
	        sbSql.append("             , SUM(CASE WHEN A.DOC_GUBUN = 'P' AND A.INPUT_DD BETWEEN SUBSTR('" + ds_Cond.getString(0, "INPUT_YMD") + "', 1, 6) || '01' AND '" + ds_Cond.getString(0, "INPUT_YMD") + "' THEN                                                       \n");
	        sbSql.append("                        A.ACT_AMT                                                                                                                                                \n");
	        sbSql.append("                   ELSE                                                                                                                                                          \n");
	        sbSql.append("                        0                                                                                                                                                        \n");
	        sbSql.append("                   END) AS ACCU_PL_AMT   -- 조회기간까지의 계획누적                                                                                                              \n");
	        sbSql.append("             , SUM(CASE WHEN A.DOC_GUBUN = 'P' AND A.INPUT_DD BETWEEN SUBSTR('" + ds_Cond.getString(0, "INPUT_YMD") + "', 1, 6) || '01' AND '" + ds_Cond.getString(0, "INPUT_YMD") + "' THEN                                                       \n");
	        sbSql.append("                        --A.ACT_AMT                                                                                                                                              \n");
	        sbSql.append("                        CASE WHEN B.ATTR03 = 'Y' /* 식음료원가 */ AND 'U' = '" + ds_Cond.getString(0, "STYPE") + "' THEN -- 상품매출원가이고 조회구분이 '재무'이면 계산(금액 * 출하율 / 100)해서 보여준다. '관리'이면 계산하지 않음. \n");
	        sbSql.append("                               A.ACT_AMT / NVL((SELECT M_RATE FROM MAS_UPJANG_M_RATE_MGMT WHERE INPUT_YM = SUBSTR('" + ds_Cond.getString(0, "INPUT_YMD") + "', 1, 6) AND DOC_CD = A.DOC_CD AND GUBUN = 'R'), 100) * 100           \n");
	        sbSql.append("                            ELSE                                                                                                                                                 \n");
	        sbSql.append("                               A.ACT_AMT                                                                                                                                         \n");
	        sbSql.append("                        END                                                                                                                                                      \n");
	        sbSql.append("                   ELSE                                                                                                                                                          \n");
	        sbSql.append("                        0                                                                                                                                                        \n");
	        sbSql.append("                   END) AS ACCU_PL_U_AMT   -- 조회기간까지의 계획누적:출하율 적용금액                                                                                            \n");
	        sbSql.append("             , SUM(CASE WHEN A.DOC_GUBUN = 'R' AND A.INPUT_DD BETWEEN SUBSTR('" + ds_Cond.getString(0, "INPUT_YMD") + "', 1, 6) || '01' AND '" + ds_Cond.getString(0, "INPUT_YMD") + "' THEN                                                       \n");
	        sbSql.append("                        A.ACT_AMT                                                                                                                                                \n");
	        sbSql.append("                   ELSE                                                                                                                                                          \n");
	        sbSql.append("                        0                                                                                                                                                        \n");
	        sbSql.append("                   END) AS ACCU_RLT_AMT  -- 조회기간까지의 실적누계                                                                                                              \n");
	        sbSql.append("             , SUM(CASE WHEN A.DOC_GUBUN = 'R' AND A.INPUT_DD BETWEEN SUBSTR('" + ds_Cond.getString(0, "INPUT_YMD") + "', 1, 6) || '01' AND '" + ds_Cond.getString(0, "INPUT_YMD") + "' THEN                                                       \n");
	        sbSql.append("                        CASE WHEN B.ATTR03 = 'Y' AND 'U' = '" + ds_Cond.getString(0, "STYPE") + "' THEN -- 상품매출원가이고 조회구분이 '재무'이면 계산(금액 * 출하율 / 100)해서 보여준다. '관리'이면 계산하지 않음.  \n");
	        sbSql.append("                               A.ACT_AMT / NVL((SELECT M_RATE FROM MAS_UPJANG_M_RATE_MGMT WHERE INPUT_YM = SUBSTR('" + ds_Cond.getString(0, "INPUT_YMD") + "', 1, 6) AND DOC_CD = A.DOC_CD AND GUBUN = 'R'), 100) * 100           \n");
	        sbSql.append("                            ELSE                                                                                                                                                 \n");
	        sbSql.append("                               A.ACT_AMT                                                                                                                                         \n");
	        sbSql.append("                        END                                                                                                                                                      \n");
	        sbSql.append("                   ELSE                                                                                                                                                          \n");
	        sbSql.append("                        0                                                                                                                                                        \n");
	        sbSql.append("                   END) AS ACCU_RLT_U_AMT  -- 조회기간까지의 실적누계:출하율 적용금액                                                                                            \n");
	        sbSql.append("          FROM MAS_DAILY_PL_REPORT A                                                                                                                                             \n");
	        sbSql.append("             , MAC_MGMT_ACCT B                                                                                                                                                   \n");
	        sbSql.append("         WHERE 1 = 1                                                                                                                                                             \n");
	        sbSql.append("           AND A.MGMT_ACCT_CD(+) = B.MGMT_ACCT_CD                                                                                                                                \n");
	        sbSql.append("           AND B.ACCT_TYPE = 'WP'                                                                                                                                                \n");
	        sbSql.append("           AND B.USE_YN = 'Y'                                                                                                                                                    \n");
	        sbSql.append("           AND B.ATTR03 = 'Y'                                                                                                                                                    \n");
	        sbSql.append("           AND A.INPUT_YM(+) = SUBSTR('" + ds_Cond.getString(0, "INPUT_YMD") + "', 1, 6)                                                                                                                          \n");
	        
	     	// 업장(마케터)정보
	        if(!ds_Cond.getString(0, "DOC_CD").equals("")){
	        	sbSql.append("       AND A.DOC_CD(+) = '" + ds_Cond.getString(0, "DOC_CD") + "'  /* 업장 또는 마케터 */   \n");
	        } 
	     	
	     	// 팀정보
	        sbSql.append("           AND EXISTS (SELECT 1 FROM SCO_UPJANG_MST_V WHERE UPJANG = A.DOC_CD AND TM_CD = '" + ds_Cond.getString(0, "TM_CD") + "') /* 팀만 선택했을 경우(마케터 제외) */   \n");
	        
	        sbSql.append("         GROUP BY B.MGMT_ACCT_CD                                                                                                                                                 \n");
	        sbSql.append("       ) B10,                                                                                                                                                                     \n");
	        sbSql.append("       (-- 월추정                                                                                                                                                                \n");
	        sbSql.append("        SELECT /*+ INDEX(A MAS_DAILY_PL_REPORT_PK)  */                                                                                                                           \n");
	        sbSql.append("               B.MGMT_ACCT_CD    -- 관리계정코드                                                                                                                                 \n");
	        sbSql.append("             , B.MGMT_ACCT_NAME                                                                                                                                                  \n");
	        sbSql.append("             , B.ATTR03                                                                                                                                                  \n");
	        sbSql.append("             , NVL(SUM(A.ACT_AMT), 0) AS MON_GSS_AMT -- 월추정금액                                                                                                                \n");
	        sbSql.append("             , NVL(SUM(                                                                                                                                                          \n");
	        sbSql.append("                       CASE WHEN B.ATTR03 = 'Y' AND 'U' = '" + ds_Cond.getString(0, "STYPE") + "' THEN -- 상품매출원가이고 조회구분이 '재무'이면 계산(금액 / 출하율 * 100)해서 보여준다. '관리(M)'이면 계산하지 않음. \n");
	        sbSql.append("                               A.ACT_AMT / NVL((SELECT M_RATE FROM MAS_UPJANG_M_RATE_MGMT WHERE INPUT_YM = SUBSTR('" + ds_Cond.getString(0, "INPUT_YMD") + "', 1, 6) AND DOC_CD = A.DOC_CD AND GUBUN = 'R'), 100) * 100           \n");
	        sbSql.append("                            ELSE                                                                                                                                                 \n");
	        sbSql.append("                               A.ACT_AMT                                                                                                                                         \n");
	        sbSql.append("                       END                                                                                                                                                       \n");
	        sbSql.append("                      ),                                                                                                                                                         \n");
	        sbSql.append("                   0) AS MON_GSS_U_AMT -- 월추정금액(출하율 적용금액)                                                                                                             \n");
	        sbSql.append("          FROM MAS_DAILY_PL_REPORT A                                                                                                                                             \n");
	        sbSql.append("             , MAC_MGMT_ACCT B                                                                                                                                                   \n");
	        sbSql.append("         WHERE 1 = 1                                                                                                                                                             \n");
	        sbSql.append("           AND A.MGMT_ACCT_CD(+) = B.MGMT_ACCT_CD                                                                                                                                \n");
	        sbSql.append("           AND B.ACCT_TYPE = 'WP'                                                                                                                                                \n");
	        sbSql.append("           AND B.USE_YN = 'Y'                                                                                                                                                    \n");
	        sbSql.append("           AND B.ATTR03 = 'Y'                                                                                                                                                    \n");
	        sbSql.append("           AND A.INPUT_YM(+) = SUBSTR('" + ds_Cond.getString(0, "INPUT_YMD") + "', 1, 6) /* 파라미터 */                                                                                                           \n");
	        
	        // 업장(마케터)정보
	        if(!ds_Cond.getString(0, "DOC_CD").equals("")){
	        	sbSql.append("       AND A.DOC_CD(+) = '" + ds_Cond.getString(0, "DOC_CD") + "'  /* 업장 또는 마케터 */   \n");
	        } 
	        
	        // 팀정보
	        sbSql.append("           AND EXISTS (SELECT 1 FROM SCO_UPJANG_MST_V WHERE UPJANG = A.DOC_CD AND TM_CD = '" + ds_Cond.getString(0, "TM_CD") + "') /* 팀만 선택했을 경우(마케터 제외) */   \n");
	        
	        sbSql.append("           AND A.DOC_GUBUN(+) = 'R'                                                                                                                                              \n");
	        sbSql.append("           AND A.INPUT_DD(+) = SUBSTR('" + ds_Cond.getString(0, "INPUT_YMD") + "', 1, 6) || '00'                                                                                                                                            \n");
	        sbSql.append("         GROUP BY B.MGMT_ACCT_CD, B.MGMT_ACCT_NAME, B.ATTR03                                                                                                                              \n");
	        sbSql.append("       ) C10                                                                                                                                                                    \n");
	        sbSql.append(" WHERE A10.MGMT_ACCT_CD = B10.MGMT_ACCT_CD                                                                                                                                      \n");
	        sbSql.append("   AND B10.MGMT_ACCT_CD = C10.MGMT_ACCT_CD                                                                                                                                      \n");


	        pstmt = conn.prepareStatement(sbSql.toString());
			rs = pstmt.executeQuery();
			
			//rs.next();
			//String MON_PL_DIFF_AMT   = rs.getString("MON_PL_DIFF_AMT");
			//String ACCU_PL_DIFF_AMT  = rs.getString("ACCU_PL_DIFF_AMT");
			//String ACCU_RLT_DIFF_AMT = rs.getString("ACCU_RLT_DIFF_AMT");
			String MON_PL_DIFF_AMT   = "0"; // 월계획의 관리금액과 재무금액의 차
			String ACCU_PL_DIFF_AMT  = "0";	// 조회일 누계계획의 관리금액과 재무금액의 차
			String ACCU_RLT_DIFF_AMT = "0";	// 조회일 누계실적의 관리금액과 재무금액의 차			
			String MON_GSS_DIFF_AMT  = "0";	// 월추정의 관리금액과 재무금액의 차
			
			if(rs.next()){	// 데이터가 있으면
				MON_PL_DIFF_AMT   = rs.getString("MON_PL_DIFF_AMT"); // 
				ACCU_PL_DIFF_AMT  = rs.getString("ACCU_PL_DIFF_AMT");
				ACCU_RLT_DIFF_AMT = rs.getString("ACCU_RLT_DIFF_AMT");
				MON_GSS_DIFF_AMT  = rs.getString("MON_GSS_DIFF_AMT");
			}else{			// 데이터가 없으면
				MON_PL_DIFF_AMT   = "0";
				ACCU_PL_DIFF_AMT  = "0";
				ACCU_RLT_DIFF_AMT = "0";
				MON_GSS_DIFF_AMT  = "0";
			}
			
			rs.close();
			pstmt.close();			
			
			// 위에서 구해진 차이금액만큼 '재료비'와 '매출원가'계정에서 빼주고 '매출이익'계정에는 더한다.
			sbSql.delete(0, sbSql.length()); //초기화
			sbSql.append("SELECT B10.MGMT_ACCT_CD                                                                                                                                                            \n");
        	sbSql.append("     , B10.MGMT_ACCT_NAME                                                                                                                                                          \n");
        	sbSql.append("     , CASE WHEN (C10.MGMT_ACCT_CD = 'PLB00000' OR C10.MGMT_ACCT_CD = 'PLB20000') AND 'U' = '" + ds_Cond.getString(0, "STYPE") + "' THEN /* 매출원가 또는 재료비 또는 매출이익에 금액반영 */                                                    \n");
        	sbSql.append("                  CASE WHEN C10.MON_GSS_U_AMT <= 0 THEN                                                                                                                                  \n");
        	sbSql.append("                       C10.MON_GSS_U_AMT + TO_NUMBER('" + MON_GSS_DIFF_AMT + "')                                                                                                    \n");
        	sbSql.append("                  ELSE                                                                                                                                   \n");
        	sbSql.append("                       C10.MON_GSS_U_AMT - TO_NUMBER('" + MON_GSS_DIFF_AMT + "')                                                                                                                                  \n");
        	sbSql.append("                  END                      \n");
        	sbSql.append("            WHEN  C10.MGMT_ACCT_CD = 'PLC00000' AND 'U' = '" + ds_Cond.getString(0, "STYPE") + "' THEN /* 매출이익에 금액반영 */                                                    \n");
        	sbSql.append("                  C10.MON_GSS_U_AMT + TO_NUMBER('" + MON_GSS_DIFF_AMT + "')                                                                                                                                  \n");
        	sbSql.append("            ELSE                                                                                                                                                                        \n");
        	sbSql.append("                  C10.MON_GSS_U_AMT                                                                                                                                                       \n");
        	sbSql.append("       END MON_GSS_U_AMT       -- 월추정금액(C):출하율  적용금액(자동계산)                                                                                                          \n");
        	sbSql.append("     , CASE WHEN (A10.MGMT_ACCT_CD = 'PLB00000' OR A10.MGMT_ACCT_CD = 'PLB20000') AND 'U' = '" + ds_Cond.getString(0, "STYPE") + "' THEN /* 매출원가 또는 재료비 또는 매출이익에 금액반영 */                                                    \n");
        	sbSql.append("                  CASE WHEN A10.MON_PL_U_AMT <= 0 THEN                                                                                                                                  \n");
        	sbSql.append("                       A10.MON_PL_U_AMT + TO_NUMBER('" + MON_PL_DIFF_AMT + "')                                                                                                    \n");
        	sbSql.append("                  ELSE                                                                                                                                   \n");
        	sbSql.append("                       A10.MON_PL_U_AMT - TO_NUMBER('" + MON_PL_DIFF_AMT + "')                                                                                                                                  \n");
        	sbSql.append("                  END                      \n");
        	sbSql.append("            WHEN  A10.MGMT_ACCT_CD = 'PLC00000' AND 'U' = '" + ds_Cond.getString(0, "STYPE") + "' THEN /* 매출이익에 금액반영 */                                                    \n");
        	sbSql.append("                  A10.MON_PL_U_AMT + TO_NUMBER('" + MON_PL_DIFF_AMT + "')                                                                                                                                  \n");
        	sbSql.append("            ELSE                                                                                                                                                                        \n");
        	sbSql.append("                  A10.MON_PL_U_AMT                                                                                                                                                       \n");
        	sbSql.append("       END MON_PL_U_AMT       -- 월계획금액(C):출하율  적용금액(자동계산)                                                                                                          \n");
        	sbSql.append("     , CASE WHEN (A10.MGMT_ACCT_CD = 'PLB00000' OR A10.MGMT_ACCT_CD = 'PLB20000') AND 'U' = '" + ds_Cond.getString(0, "STYPE") + "' THEN /* 매출원가 또는 재료비에 금액반영 */                                                    \n");
        	sbSql.append("                  CASE WHEN B10.ACCU_PL_U_AMT <= 0 THEN                                                                                                                               \n");
        	sbSql.append("                       B10.ACCU_PL_U_AMT + TO_NUMBER('" + ACCU_PL_DIFF_AMT + "')                                                                                                                                 \n");
        	sbSql.append("                  ELSE                                                                                                                                 \n");
        	sbSql.append("                       B10.ACCU_PL_U_AMT - TO_NUMBER('" + ACCU_PL_DIFF_AMT + "')                                                                                                                                 \n");
        	sbSql.append("                  END \n");
        	sbSql.append("            WHEN  A10.MGMT_ACCT_CD = 'PLC00000' AND 'U' = '" + ds_Cond.getString(0, "STYPE") + "' THEN /* 매출이익에 금액반영 */                                                    \n");
        	sbSql.append("                  B10.ACCU_PL_U_AMT + TO_NUMBER('" + ACCU_PL_DIFF_AMT + "')                                                                                                                                 \n");
        	sbSql.append("            ELSE                                                                                                                                                                        \n");
        	sbSql.append("                  B10.ACCU_PL_U_AMT                                                                                                                                                      \n");
        	sbSql.append("       END ACCU_PL_U_AMT  -- 조회일 누계계획(B):출하율 적용금액(자동계산)                                                                                                          \n");
        	sbSql.append("     , CASE WHEN (A10.MGMT_ACCT_CD = 'PLB00000' OR A10.MGMT_ACCT_CD = 'PLB20000') AND 'U' = '" + ds_Cond.getString(0, "STYPE") + "' THEN /* 매출원가 또는 재료비에 금액반영 */                                                    \n");
        	sbSql.append("                  CASE WHEN B10.ACCU_RLT_U_AMT <= 0 THEN                                                                                                                                  \n");
        	sbSql.append("                       B10.ACCU_RLT_U_AMT - TO_NUMBER('" + ACCU_RLT_DIFF_AMT + "')                                                                                                                                \n");
        	sbSql.append("                  ELSE                                                                                                                                \n");
        	sbSql.append("                       B10.ACCU_RLT_U_AMT - TO_NUMBER('" + ACCU_RLT_DIFF_AMT + "')                                                                                                                                \n");
        	sbSql.append("                  END                                                                                                                               \n");
        	sbSql.append("            WHEN  A10.MGMT_ACCT_CD = 'PLC00000' AND 'U' = '" + ds_Cond.getString(0, "STYPE") + "' THEN /* 매출이익에 금액반영 */                                                    \n");
        	sbSql.append("                  B10.ACCU_RLT_U_AMT + TO_NUMBER('" + ACCU_RLT_DIFF_AMT + "')                                                                                                                                \n");
        	sbSql.append("            ELSE                                                                                                                                                                        \n");
        	sbSql.append("                  B10.ACCU_RLT_U_AMT                                                                                                                                                     \n");
        	sbSql.append("       END ACCU_RLT_U_AMT  -- 조회일 누계실적(B):출하율 적용금액(자동계산)                                                                                                         \n");
	        sbSql.append("  FROM (-- 월계획                                                                                                                                                                \n");
	        sbSql.append("        SELECT /*+ INDEX(A MAS_DAILY_PL_REPORT_PK)  */                                                                                                                           \n");
	        sbSql.append("               B.MGMT_ACCT_CD    -- 관리계정코드                                                                                                                                 \n");
	        sbSql.append("             , B.MGMT_ACCT_NAME                                                                                                                                                  \n");
	        sbSql.append("             , NVL(SUM(A.ACT_AMT), 0) AS MON_PL_AMT -- 월계획금액                                                                                                                \n");
	        sbSql.append("             , NVL(SUM(                                                                                                                                                          \n");
	        sbSql.append("                       CASE WHEN B.ATTR03 = 'Y' AND 'U' = '" + ds_Cond.getString(0, "STYPE") + "' THEN -- 식음료원가이고 조회구분이 '재무'이면 계산(금액 / 출하율 * 100)해서 보여준다. '관리(M)'이면 계산하지 않음. \n");
	        sbSql.append("                               A.ACT_AMT / NVL((SELECT M_RATE FROM MAS_UPJANG_M_RATE_MGMT WHERE INPUT_YM = SUBSTR('" + ds_Cond.getString(0, "INPUT_YMD") + "', 1, 6) AND DOC_CD = A.DOC_CD AND GUBUN = 'P'), 100) * 100           \n");
	        sbSql.append("                            ELSE                                                                                                                                                 \n");
	        sbSql.append("                               A.ACT_AMT                                                                                                                                         \n");
	        sbSql.append("                       END                                                                                                                                                       \n");
	        sbSql.append("                      ),                                                                                                                                                         \n");
	        sbSql.append("                   0) AS MON_PL_U_AMT -- 월계획금액(출하율 적용금액)                                                                                                             \n");
	        sbSql.append("          FROM MAS_DAILY_PL_REPORT A                                                                                                                                             \n");
	        sbSql.append("             , MAC_MGMT_ACCT B                                                                                                                                                   \n");
	        sbSql.append("         WHERE 1 = 1                                                                                                                                                             \n");
	        sbSql.append("           AND A.MGMT_ACCT_CD(+) = B.MGMT_ACCT_CD                                                                                                                                \n");
	        sbSql.append("           AND B.ACCT_TYPE = 'WP'                                                                                                                                                \n");
	        sbSql.append("           AND B.USE_YN = 'Y'                                                                                                                                                    \n");
	        sbSql.append("           AND A.INPUT_YM(+) = SUBSTR('" + ds_Cond.getString(0, "INPUT_YMD") + "', 1, 6) /* 파라미터 */                                                                                                           \n");
	        
	        // 업장(마케터)정보
	        if(!ds_Cond.getString(0, "DOC_CD").equals("")){
	        	sbSql.append("       AND A.DOC_CD(+) = '" + ds_Cond.getString(0, "DOC_CD") + "'  /* 업장 */   \n");
	        } 
	        
	     	// 팀정보
	        sbSql.append("           AND EXISTS (SELECT 1 FROM SCO_UPJANG_MST_V WHERE UPJANG = A.DOC_CD AND TM_CD = '" + ds_Cond.getString(0, "TM_CD") + "') /* 팀만 선택했을 경우(마케터 제외) */   \n");
	        
	        sbSql.append("           AND A.DOC_GUBUN(+) = 'P'                                                                                                                                              \n");
	        sbSql.append("         GROUP BY B.MGMT_ACCT_CD, B.MGMT_ACCT_NAME                                                                                                                               \n");
	        sbSql.append("       ) A10,                                                                                                                                                                    \n");
	        sbSql.append("       (-- 월실적(확정쿼리)                                                                                                                                                      \n");
	        sbSql.append("        SELECT /*+ INDEX(A MAS_DAILY_PL_REPORT_PK)  */                                                                                                                           \n");
	        sbSql.append("               B.MGMT_ACCT_CD    -- 관리계정코드                                                                                                                                 \n");
	        sbSql.append("             , B.MGMT_ACCT_NAME    -- 관리계정명                                                                                                                                 \n");
	        sbSql.append("             , SUM(CASE WHEN A.DOC_GUBUN = 'P' AND A.INPUT_DD BETWEEN SUBSTR('" + ds_Cond.getString(0, "INPUT_YMD") + "', 1, 6) || '01' AND '" + ds_Cond.getString(0, "INPUT_YMD") + "' THEN                                                       \n");
	        sbSql.append("                        A.ACT_AMT                                                                                                                                                \n");
	        sbSql.append("                   ELSE                                                                                                                                                          \n");
	        sbSql.append("                        0                                                                                                                                                        \n");
	        sbSql.append("                   END) AS ACCU_PL_AMT   -- 조회기간까지의 계획누적                                                                                                              \n");
	        sbSql.append("             , SUM(CASE WHEN A.DOC_GUBUN = 'P' AND A.INPUT_DD BETWEEN SUBSTR('" + ds_Cond.getString(0, "INPUT_YMD") + "', 1, 6) || '01' AND '" + ds_Cond.getString(0, "INPUT_YMD") + "' THEN                                                       \n");
	        sbSql.append("                        --A.ACT_AMT                                                                                                                                              \n");
	        sbSql.append("                        CASE WHEN B.ATTR03 = 'Y' /* 상품매출원가 */ AND 'U' = '" + ds_Cond.getString(0, "STYPE") + "' THEN -- 식음료원가이고 조회구분이 '재무'이면 계산(금액 * 출하율 / 100)해서 보여준다. '관리'이면 계산하지 않음. \n");
	        sbSql.append("                               A.ACT_AMT / NVL((SELECT M_RATE FROM MAS_UPJANG_M_RATE_MGMT WHERE INPUT_YM = SUBSTR('" + ds_Cond.getString(0, "INPUT_YMD") + "', 1, 6) AND DOC_CD = A.DOC_CD AND GUBUN = 'R'), 100) * 100           \n");
	        sbSql.append("                            ELSE                                                                                                                                                 \n");
	        sbSql.append("                               A.ACT_AMT                                                                                                                                         \n");
	        sbSql.append("                        END                                                                                                                                                      \n");
	        sbSql.append("                   ELSE                                                                                                                                                          \n");
	        sbSql.append("                        0                                                                                                                                                        \n");
	        sbSql.append("                   END) AS ACCU_PL_U_AMT   -- 조회기간까지의 계획누적:출하율 적용금액                                                                                            \n");
	        sbSql.append("             , SUM(CASE WHEN A.DOC_GUBUN = 'R' AND A.INPUT_DD BETWEEN SUBSTR('" + ds_Cond.getString(0, "INPUT_YMD") + "', 1, 6) || '01' AND '" + ds_Cond.getString(0, "INPUT_YMD") + "' THEN                                                       \n");
	        sbSql.append("                        A.ACT_AMT                                                                                                                                                \n");
	        sbSql.append("                   ELSE                                                                                                                                                          \n");
	        sbSql.append("                        0                                                                                                                                                        \n");
	        sbSql.append("                   END) AS ACCU_RLT_AMT  -- 조회기간까지의 실적누계                                                                                                              \n");
	        sbSql.append("             , SUM(CASE WHEN A.DOC_GUBUN = 'R' AND A.INPUT_DD BETWEEN SUBSTR('" + ds_Cond.getString(0, "INPUT_YMD") + "', 1, 6) || '01' AND '" + ds_Cond.getString(0, "INPUT_YMD") + "' THEN                                                       \n");
	        sbSql.append("                        CASE WHEN B.ATTR03 = 'Y' AND 'U' = '" + ds_Cond.getString(0, "STYPE") + "' THEN -- 식음료원가이고 조회구분이 '재무'이면 계산(금액 * 출하율 / 100)해서 보여준다. '관리'이면 계산하지 않음.  \n");
	        sbSql.append("                               A.ACT_AMT / NVL((SELECT M_RATE FROM MAS_UPJANG_M_RATE_MGMT WHERE INPUT_YM = SUBSTR('" + ds_Cond.getString(0, "INPUT_YMD") + "', 1, 6) AND DOC_CD = A.DOC_CD AND GUBUN = 'R'), 100) * 100           \n");
	        sbSql.append("                            ELSE                                                                                                                                                 \n");
	        sbSql.append("                               A.ACT_AMT                                                                                                                                         \n");
	        sbSql.append("                        END                                                                                                                                                      \n");
	        sbSql.append("                   ELSE                                                                                                                                                          \n");
	        sbSql.append("                        0                                                                                                                                                        \n");
	        sbSql.append("                   END) AS ACCU_RLT_U_AMT  -- 조회기간까지의 실적누계:출하율 적용금액                                                                                            \n");
	        sbSql.append("          FROM MAS_DAILY_PL_REPORT A                                                                                                                                             \n");
	        sbSql.append("             , MAC_MGMT_ACCT B                                                                                                                                                   \n");
	        sbSql.append("         WHERE 1 = 1                                                                                                                                                             \n");
	        sbSql.append("           AND A.MGMT_ACCT_CD(+) = B.MGMT_ACCT_CD                                                                                                                                \n");
	        sbSql.append("           AND B.ACCT_TYPE = 'WP'                                                                                                                                                \n");
	        sbSql.append("           AND B.USE_YN = 'Y'                                                                                                                                                    \n");
	        sbSql.append("           AND A.INPUT_YM(+) = SUBSTR('" + ds_Cond.getString(0, "INPUT_YMD") + "', 1, 6)                                                                                                                          \n");
	        
	     	// 업장(마케터)정보
	        if(!ds_Cond.getString(0, "DOC_CD").equals("")){
	        	sbSql.append("       AND A.DOC_CD(+) = '" + ds_Cond.getString(0, "DOC_CD") + "'  /* 업장  */   \n");
	        } 
	     	
		    // 팀정보
	        sbSql.append("           AND EXISTS (SELECT 1 FROM SCO_UPJANG_MST_V WHERE UPJANG = A.DOC_CD AND TM_CD = '" + ds_Cond.getString(0, "TM_CD") + "') /* 팀만 선택했을 경우(마케터 제외) */   \n");
	        
	        sbSql.append("         GROUP BY B.MGMT_ACCT_CD, B.MGMT_ACCT_NAME                                                                                                                                                 \n");
	        sbSql.append("       ) B10,                                                                                                                                                                     \n");
	        sbSql.append("      (-- 월추정                                                                                                                                                                \n");
	        sbSql.append("        SELECT /*+ INDEX(A MAS_DAILY_PL_REPORT_PK)  */                                                                                                                           \n");
	        sbSql.append("               B.MGMT_ACCT_CD    -- 관리계정코드                                                                                                                                 \n");
	        sbSql.append("             , B.MGMT_ACCT_NAME                                                                                                                                                  \n");
	        sbSql.append("             , NVL(SUM(A.ACT_AMT), 0) AS MON_PL_AMT -- 월추정금액                                                                                                                \n");
	        sbSql.append("             , NVL(SUM(                                                                                                                                                          \n");
	        sbSql.append("                       CASE WHEN B.ATTR03 = 'Y' AND 'U' = '" + ds_Cond.getString(0, "STYPE") + "' THEN -- 식음료원가이고 조회구분이 '재무'이면 계산(금액 / 출하율 * 100)해서 보여준다. '관리(M)'이면 계산하지 않음. \n");
	        sbSql.append("                               A.ACT_AMT / NVL((SELECT M_RATE FROM MAS_UPJANG_M_RATE_MGMT WHERE INPUT_YM = SUBSTR('" + ds_Cond.getString(0, "INPUT_YMD") + "', 1, 6) AND DOC_CD = A.DOC_CD AND GUBUN = 'R'), 100) * 100           \n");
	        sbSql.append("                            ELSE                                                                                                                                                 \n");
	        sbSql.append("                               A.ACT_AMT                                                                                                                                         \n");
	        sbSql.append("                       END                                                                                                                                                       \n");
	        sbSql.append("                      ),                                                                                                                                                         \n");
	        sbSql.append("                   0) AS MON_GSS_U_AMT -- 월추정금액(출하율 적용금액)                                                                                                             \n");
	        sbSql.append("          FROM MAS_DAILY_PL_REPORT A                                                                                                                                             \n");
	        sbSql.append("             , MAC_MGMT_ACCT B                                                                                                                                                   \n");
	        sbSql.append("         WHERE 1 = 1                                                                                                                                                             \n");
	        sbSql.append("           AND A.MGMT_ACCT_CD(+) = B.MGMT_ACCT_CD                                                                                                                                \n");
	        sbSql.append("           AND B.ACCT_TYPE = 'WP'                                                                                                                                                \n");
	        sbSql.append("           AND B.USE_YN = 'Y'                                                                                                                                                    \n");
	        sbSql.append("           AND A.INPUT_YM(+) = SUBSTR('" + ds_Cond.getString(0, "INPUT_YMD") + "', 1, 6) /* 파라미터 */                                                                                                           \n");
	        
	        // 업장(마케터)정보
	        if(!ds_Cond.getString(0, "DOC_CD").equals("")){
	        	sbSql.append("       AND A.DOC_CD(+) = '" + ds_Cond.getString(0, "DOC_CD") + "'  /* 업장 */   \n");
	        } 
	        
	     	// 팀정보
	        sbSql.append("           AND EXISTS (SELECT 1 FROM SCO_UPJANG_MST_V WHERE UPJANG = A.DOC_CD AND TM_CD = '" + ds_Cond.getString(0, "TM_CD") + "') /* 팀만 선택했을 경우(마케터 제외) */   \n");
	        
	        sbSql.append("           AND A.DOC_GUBUN(+) = 'R'                                                                                                                                              \n");
	        sbSql.append("           AND A.INPUT_DD(+) = SUBSTR('" + ds_Cond.getString(0, "INPUT_YMD") + "', 1, 6) || '00' /* 월추정 */                                                                                                           \n");
	        sbSql.append("         GROUP BY B.MGMT_ACCT_CD, B.MGMT_ACCT_NAME                                                                                                                               \n");
	        sbSql.append("       ) C10                                                                                                                                                                    \n");
	        sbSql.append(" WHERE A10.MGMT_ACCT_CD(+) = B10.MGMT_ACCT_CD                                                                                                                                      \n");
	        sbSql.append("   AND B10.MGMT_ACCT_CD(+) = C10.MGMT_ACCT_CD                                                                                                                                      \n");
	        sbSql.append(" ORDER BY B10.MGMT_ACCT_CD                                                                                                                                      \n");

	        // 업장(마케터)정보
	        
	        //if(!ds_Cond.getString(0, "DOC_CD").equals("")){
	        //	sbSql.append("   AND A.DOC_CD = '" + ds_Cond.getString(0, "DOC_CD") + "'  /* 업장 또는 마케터 */   \n");
	        //} 
	        
	        //sbSql.append("   AND EXISTS (SELECT 1 FROM SCO_UPJANG_MST_V WHERE UPJANG = A.DOC_CD AND TM_CD = '" + ds_Cond.getString(0, "TM_CD") + "') /* 팀만 선택했을 경우(마케터 제외) */   \n");
	        //sbSql.append(" GROUP BY A.INPUT_DD, A.MGMT_ACCT_CD, MGMT_ACCT_NAME, B.ATTR01                                                                     \n");
	        
		}else{ // 마케터실적마감
			sbSql.append("SELECT B10.MGMT_ACCT_CD                                                                                                                                         \n");
	        sbSql.append("     , B10.MGMT_ACCT_NAME                                                                                                                                       \n");
	        sbSql.append("     , C10.MON_GSS_AMT AS MON_GSS_U_AMT -- 월추정금액                                                                                                                        \n");
	        sbSql.append("     , A10.MON_PL_AMT AS MON_PL_U_AMT -- 월계획금액(C)                                                                                                                        \n");
	        sbSql.append("     , B10.ACCU_PL_AMT AS ACCU_PL_U_AMT -- 조회일 누계계획(B)                                                                                                                  \n");
	        sbSql.append("     , B10.ACCU_RLT_AMT AS ACCU_RLT_U_AMT -- 조회일 누계실적(A)                                                                                                                 \n");
	        //sbSql.append("--     , B10.ACCU_PL_AMT - B10.ACCU_RLT_AMT AS PL_DIFF -- 계획비(조회일 누계계획 - 조회일 누계실적(A-B))                                                        \n");
	        //sbSql.append("--     , ROUND(DECODE(A10.MON_PL_AMT, 0, 0, B10.ACCU_RLT_AMT/A10.MON_PL_AMT * 100), 2) AS PROSS_RATE -- 진도율(조회일 누계계획/A10.MON_PL_AMT * 100)(A/C*100)   \n");
	        sbSql.append("  FROM (-- 월계획                                                                                                                                               \n");
	        sbSql.append("        SELECT /*+ INDEX(A MAS_DAILY_PL_REPORT_PK)  */                                                                                                          \n");
	        sbSql.append("               B.MGMT_ACCT_CD    -- 관리계정코드                                                                                                                \n");
	        sbSql.append("             , B.MGMT_ACCT_NAME                                                                                                                                 \n");
	        sbSql.append("             , NVL(SUM(A.ACT_AMT), 0) AS MON_PL_AMT -- 월계획금액                                                                                               \n");
	        sbSql.append("          FROM MAS_DAILY_PL_REPORT A                                                                                                                            \n");
	        sbSql.append("             , MAC_MGMT_ACCT B                                                                                                                                  \n");
	        sbSql.append("         WHERE 1 = 1                                                                                                                                            \n");
	        sbSql.append("           AND A.MGMT_ACCT_CD(+) = B.MGMT_ACCT_CD                                                                                                               \n");
	        sbSql.append("           AND B.ACCT_TYPE = 'WP'                                                                                                                               \n");
	        sbSql.append("           AND B.USE_YN = 'Y'                                                                                                                                   \n");
	        sbSql.append("           AND A.INPUT_YM(+) = SUBSTR('" + ds_Cond.getString(0, "INPUT_YMD") + "', 1, 6)                                                                                                         \n");
	        sbSql.append("           AND A.DOC_GUBUN(+) = 'P'                                                                                                                             \n");
	        
	     	// 업장(마케터)정보
	        if(!ds_Cond.getString(0, "DOC_CD").equals("")){
	        	sbSql.append("       AND A.DOC_CD(+) = '" + ds_Cond.getString(0, "DOC_CD") + "'  /* 마케터 */   \n");
	        } 	        
	        
	        sbSql.append("  AND A.DOC_CD IN (SELECT V.SABUN                                                                                                                            \n");
	        sbSql.append("                   FROM SCO_FS_HR_PERSONAL_V V                                                                                                                          \n");
	        sbSql.append("                  WHERE 1=1                                                                                                                                \n");
	        sbSql.append("                    AND EXISTS (SELECT 1 FROM SCC_COMMON_CODE WHERE CODE = V.DEPT_ID AND GROUP_CODE = 'MA1002' AND SET1 = 'FICS')                                                                                                                                \n");
	        sbSql.append("                    AND TM_CD = '" + ds_Cond.getString(0, "TM_CD") + "')  \n");
	        
	        sbSql.append("         GROUP BY B.MGMT_ACCT_CD, B.MGMT_ACCT_NAME                                                                                                              \n");
	        sbSql.append("       ) A10,                                                                                                                                                   \n");
	        sbSql.append("       (-- 월실적(확정쿼리)                                                                                                                                     \n");
	        sbSql.append("        SELECT /*+ INDEX(A MAS_DAILY_PL_REPORT_PK)  */                                                                                                          \n");
	        sbSql.append("               B.MGMT_ACCT_CD    -- 관리계정코드                                                                                                                \n");
	        sbSql.append("             , B.MGMT_ACCT_NAME    -- 관리계정명                                                                                                                \n");
	        sbSql.append("             , SUM(CASE WHEN A.DOC_GUBUN = 'P' AND A.INPUT_DD BETWEEN SUBSTR('" + ds_Cond.getString(0, "INPUT_YMD") + "', 1, 6) || '01' AND '" + ds_Cond.getString(0, "INPUT_YMD") + "' THEN                                      \n");
	        sbSql.append("                        A.ACT_AMT                                                                                                                               \n");
	        sbSql.append("                   ELSE                                                                                                                                         \n");
	        sbSql.append("                        0                                                                                                                                       \n");
	        sbSql.append("                   END) AS ACCU_PL_AMT   -- 조회기간까지의 계획누적                                                                                             \n");
	        sbSql.append("             , SUM(CASE WHEN A.DOC_GUBUN = 'R' AND A.INPUT_DD BETWEEN SUBSTR('" + ds_Cond.getString(0, "INPUT_YMD") + "', 1, 6) || '01' AND '" + ds_Cond.getString(0, "INPUT_YMD") + "' THEN                                      \n");
	        sbSql.append("                        A.ACT_AMT                                                                                                                               \n");
	        sbSql.append("                   ELSE                                                                                                                                         \n");
	        sbSql.append("                        0                                                                                                                                       \n");
	        sbSql.append("                   END) AS ACCU_RLT_AMT  -- 조회기간까지의 실적누계                                                                                             \n");
	        sbSql.append("          FROM MAS_DAILY_PL_REPORT A                                                                                                                            \n");
	        sbSql.append("             , MAC_MGMT_ACCT B                                                                                                                                  \n");
	        sbSql.append("         WHERE 1 = 1                                                                                                                                            \n");
	        sbSql.append("           AND A.MGMT_ACCT_CD(+) = B.MGMT_ACCT_CD                                                                                                               \n");
	        sbSql.append("           AND B.ACCT_TYPE = 'WP'                                                                                                                               \n");
	        sbSql.append("           AND B.USE_YN = 'Y'                                                                                                                                   \n");
	        sbSql.append("           AND A.INPUT_YM(+) = SUBSTR('" + ds_Cond.getString(0, "INPUT_YMD") + "', 1, 6)                                                                                                         \n");
	        
	     	// 업장(마케터)정보
	        if(!ds_Cond.getString(0, "DOC_CD").equals("")){
	        	sbSql.append("       AND A.DOC_CD(+) = '" + ds_Cond.getString(0, "DOC_CD") + "'  /* 마케터 */   \n");
	        }
	     	
	        sbSql.append("  AND A.DOC_CD IN (SELECT V.SABUN                                                                                                                            \n");
	        sbSql.append("                   FROM SCO_FS_HR_PERSONAL_V V                                                                                                                          \n");
	        sbSql.append("                  WHERE 1=1                                                                                                                                \n");
	        sbSql.append("                    AND EXISTS (SELECT 1 FROM SCC_COMMON_CODE WHERE CODE = V.DEPT_ID AND GROUP_CODE = 'MA1002' AND SET1 = 'FICS')                                                                                                                                \n");
	        sbSql.append("                    AND TM_CD = '" + ds_Cond.getString(0, "TM_CD") + "')  \n");
	        
	     	
	        sbSql.append("         GROUP BY B.MGMT_ACCT_CD, B.MGMT_ACCT_NAME                                                                                                                           \n");
	        sbSql.append("       ) B10,                                                                                                                                                    \n");
	        sbSql.append("       (-- 월추정                                                                                                                                               \n");
	        sbSql.append("        SELECT /*+ INDEX(A MAS_DAILY_PL_REPORT_PK)  */                                                                                                          \n");
	        sbSql.append("               B.MGMT_ACCT_CD    -- 관리계정코드                                                                                                                \n");
	        sbSql.append("             , B.MGMT_ACCT_NAME                                                                                                                                 \n");
	        sbSql.append("             , NVL(SUM(A.ACT_AMT), 0) AS MON_GSS_AMT -- 월추정금액                                                                                               \n");
	        sbSql.append("          FROM MAS_DAILY_PL_REPORT A                                                                                                                            \n");
	        sbSql.append("             , MAC_MGMT_ACCT B                                                                                                                                  \n");
	        sbSql.append("         WHERE 1 = 1                                                                                                                                            \n");
	        sbSql.append("           AND A.MGMT_ACCT_CD(+) = B.MGMT_ACCT_CD                                                                                                               \n");
	        sbSql.append("           AND B.ACCT_TYPE = 'WP'                                                                                                                               \n");
	        sbSql.append("           AND B.USE_YN = 'Y'                                                                                                                                   \n");
	        sbSql.append("           AND A.INPUT_YM(+) = SUBSTR('" + ds_Cond.getString(0, "INPUT_YMD") + "', 1, 6)                                                                \n");
	        sbSql.append("           AND A.DOC_GUBUN(+) = 'R'                                                                                                                             \n");
	        sbSql.append("           AND A.INPUT_DD(+) = SUBSTR('" + ds_Cond.getString(0, "INPUT_YMD") + "', 1, 6) || '00' /* 월추정 */                                                               \n");
	        
	     	// 업장(마케터)정보
	        if(!ds_Cond.getString(0, "DOC_CD").equals("")){
	        	sbSql.append("       AND A.DOC_CD(+) = '" + ds_Cond.getString(0, "DOC_CD") + "'  /* 마케터 */   \n");
	        } 	        
	        
	        sbSql.append("  AND A.DOC_CD IN (SELECT V.SABUN                                                                                                                            \n");
	        sbSql.append("                   FROM SCO_FS_HR_PERSONAL_V V                                                                                                                          \n");
	        sbSql.append("                  WHERE 1=1                                                                                                                                \n");
	        sbSql.append("                    AND EXISTS (SELECT 1 FROM SCC_COMMON_CODE WHERE CODE = V.DEPT_ID AND GROUP_CODE = 'MA1002' AND SET1 = 'FICS')                                                                                                                                \n");
	        sbSql.append("                    AND TM_CD = '" + ds_Cond.getString(0, "TM_CD") + "')  \n");
	        
	        sbSql.append("         GROUP BY B.MGMT_ACCT_CD, B.MGMT_ACCT_NAME                                                                                                              \n");
	        sbSql.append("       ) C10                                                                                                                                                   \n");	        
	        sbSql.append(" WHERE A10.MGMT_ACCT_CD(+) = B10.MGMT_ACCT_CD                                                                                                                      \n");
	        sbSql.append("   AND B10.MGMT_ACCT_CD(+) = C10.MGMT_ACCT_CD                                                                                                                      \n");
	        sbSql.append(" ORDER BY B10.MGMT_ACCT_CD                                                                                                                                      \n");
			
			
			
			
			//sbSql.append("SELECT A.MGMT_ACCT_CD                                                                                                              \n");
	        //sbSql.append("     , B.MGMT_ACCT_NAME                                                                                                            \n");
	        //sbSql.append("     , B.ATTR01 AS INPUT_YN                                                                                                                   \n");
	        //sbSql.append("     , TO_CHAR(TO_DATE(A.INPUT_DD, 'YYYY-MM-DD'), 'YYYY-MM-DD')|| ' (' || DECODE(TO_CHAR(TO_DATE(A.INPUT_DD, 'YYYYMMDD'), 'D'), '1', '일', '2', '월', '3', '화', '4', '수', '5', '목', '6', '금', '7', '토') || ')' AS P_DATE                                                                                                                 \n");
	        //sbSql.append("     , SUM(A.ACT_AMT) ACT_AMT                                                                                                      \n");
	        //sbSql.append("  FROM MAS_DAILY_PL_REPORT A                                                                                                       \n");
	        //sbSql.append("     , MAC_MGMT_ACCT       B                                                                                                       \n");
	        //sbSql.append(" WHERE 1 = 1                                                                                                                       \n");
	        //sbSql.append("   AND A.MGMT_ACCT_CD(+) = B.MGMT_ACCT_CD                                                                                             \n");
	        //sbSql.append("   AND B.ACCT_TYPE = 'WP'                                                                                                          \n");
	        //sbSql.append("   AND B.USE_YN = 'Y'                                                                                                              \n");
	        //sbSql.append("   AND A.INPUT_YM(+) = '" + ds_Cond.getString(0, "INPUT_YM") + "'  \n");
	        //sbSql.append("   AND A.DOC_GUBUN(+) = 'P' /* 월계획 */                                                                                                \n");

	        // 업장(마케터)정보
	        //if(!ds_Cond.getString(0, "DOC_CD").equals("")){
	        //	sbSql.append("   AND A.DOC_CD(+) = '" + ds_Cond.getString(0, "DOC_CD") + "'  /* 업장 또는 마케터 */   \n");
	        //} 
	        
	     	//sbSql.append("  AND A.DOC_CD IN (SELECT V.SABUN                                                                                                                            \n");
	        //sbSql.append("                   FROM SCO_FS_HR_PERSONAL_V V                                                                                                                          \n");
	        //sbSql.append("                  WHERE 1=1                                                                                                                                \n");
	        //sbSql.append("                    AND EXISTS (SELECT 1 FROM SCC_COMMON_CODE WHERE CODE = V.DEPT_ID AND GROUP_CODE = 'MA1002' AND SET1 = 'FICS')                                                                                                                                \n");
	        //sbSql.append("                    AND TM_CD = '" + ds_Cond.getString(0, "TM_CD") + "')  \n");
	                
	        //sbSql.append(" GROUP BY A.INPUT_DD, A.MGMT_ACCT_CD, MGMT_ACCT_NAME, B.ATTR01                                                                     \n");	        
	        			
		}
		
		

out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_List = this.makeDataSet(rs, "ds_List");

		pstmt.close();
		rs.close();

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