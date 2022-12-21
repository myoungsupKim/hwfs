<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 경영관리/손익실적
■ 프로그램ID   : MAS40060E_T001.jsp
■ 프로그램명   : 월별손익계획조회
■ 작성일자     : 2013-12-18
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
			if(ds_Cond.getString(0, "STYPE").equals("M")){	// 조회구분 : 관리(M)
		        sbSql.append("SELECT A.MGMT_ACCT_CD                                                                                                              \n");
		        sbSql.append("     , B.MGMT_ACCT_NAME                                                                                                            \n");
		        sbSql.append("     , B.ATTR01 AS INPUT_YN                                                                                                                   \n");
		        sbSql.append("     , TO_CHAR(TO_DATE(A.INPUT_DD, 'YYYY-MM-DD'), 'YYYY-MM-DD')|| ' (' || DECODE(TO_CHAR(TO_DATE(A.INPUT_DD, 'YYYYMMDD'), 'D'), '1', '일', '2', '월', '3', '화', '4', '수', '5', '목', '6', '금', '7', '토') || ')' AS P_DATE                                                                                                                 \n");
		        sbSql.append("     , SUM(A.ACT_AMT) ACT_AMT                                                                                                      \n");
		        sbSql.append("  FROM MAS_DAILY_PL_REPORT A                                                                                                       \n");
		        sbSql.append("     , MAC_MGMT_ACCT       B                                                                                                       \n");
		        sbSql.append(" WHERE 1 = 1                                                                                                                       \n");
		        sbSql.append("   AND A.MGMT_ACCT_CD = B.MGMT_ACCT_CD                                                                                             \n");
		        sbSql.append("   AND B.ACCT_TYPE = 'WP'                                                                                                          \n");
		        sbSql.append("   AND B.USE_YN = 'Y'                                                                                                              \n");
		        sbSql.append("   AND A.INPUT_YM = '" + ds_Cond.getString(0, "INPUT_YM") + "'  \n");
		        sbSql.append("   AND A.DOC_GUBUN = 'P' /* 월계획 */                                                                                                \n");
	
		        // 업장(마케터)정보
		        if(!ds_Cond.getString(0, "DOC_CD").equals("")){
		        	sbSql.append("   AND A.DOC_CD = '" + ds_Cond.getString(0, "DOC_CD") + "'  /* 업장 또는 마케터 */   \n");
		        } 
		        
		        sbSql.append("   AND EXISTS (SELECT 1 FROM SCO_UPJANG_MST_V WHERE UPJANG = A.DOC_CD AND TM_CD = '" + ds_Cond.getString(0, "TM_CD") + "') /* 팀만 선택했을 경우(마케터 제외) */   \n");
		        sbSql.append(" GROUP BY A.INPUT_DD, A.MGMT_ACCT_CD, MGMT_ACCT_NAME, B.ATTR01                                                                     \n");
			}else{// 조회구분 : 재무(U)
				// 입력 된 데이터는 관리금액으로 입력되어 있으므로 재무금액으로 재계산해야 한다.
				// 재무금액으로 변경해야 하는 계정과목은 '식음료원가'계정만 재무금액으로 재계산한다.
				// '식음료원가'가 변경되면 '재료비'계정과 '매출원가', '매출이익'계정의 값이 변경된다.
				sbSql.append("SELECT A10.MGMT_ACCT_CD                                                                                                                                                                                                    \n");
		        sbSql.append("     , A10.MGMT_ACCT_NAME                                                                                                                                                                                                  \n");
		        sbSql.append("     , A10.INPUT_YN                                                                                                                                                                                                        \n");
		        sbSql.append("     , A10.P_DATE                                                                                                                                                                                                          \n");
		        sbSql.append("     , SUM(CASE WHEN A10.MGMT_ACCT_CD IN ('PLB00000', 'PLB20000') THEN /* 매출원가, 재료비 */                                                                                                                              \n");
		        sbSql.append("                     A10.U_ACT_AMT - A10.DIFF_ACT_AMT  /* 관리금액에서 재무금액의 차이만큼 빼준다.(재무금액이 출하율적용된 금액이므로 더 작다 */                                                                                   \n");
		        sbSql.append("                WHEN A10.MGMT_ACCT_CD IN ('PLC00000') THEN /* 매출이익 */                                                                                                                                                  \n");
		        sbSql.append("                     A10.U_ACT_AMT + A10.DIFF_ACT_AMT  /* 매출이익(매출액-매출원가)이므로 매출원가가 작아지면 매출이익이 증가한다. */                                                                              \n");
		        sbSql.append("           ELSE                                                                                                                                                                                                            \n");
		        sbSql.append("                A10.U_ACT_AMT                                                                                                                                                                                              \n");
		        sbSql.append("           END) AS ACT_AMT                                                                                                                                                                                                 \n");
		        sbSql.append("  FROM (                                                                                                                                                                                                                   \n");
		        sbSql.append("        SELECT A.DOC_CD                                                                                                                                                                                                    \n");
		        sbSql.append("             , A.MGMT_ACCT_CD                                                                                                                                                                                              \n");
		        sbSql.append("             , B.MGMT_ACCT_NAME                                                                                                                                                                                            \n");
		        sbSql.append("             , B.ATTR01 AS INPUT_YN                                                                                                                                                                                        \n");
		        sbSql.append("             , A.INPUT_DD                                                                                                                                                                                                  \n");
		        sbSql.append("             , TO_CHAR(TO_DATE(A.INPUT_DD, 'YYYY-MM-DD'), 'YYYY-MM-DD')|| ' (' || DECODE(TO_CHAR(TO_DATE(A.INPUT_DD, 'YYYYMMDD'), 'D'), '1', '일', '2', '월', '3', '화', '4', '수', '5', '목', '6', '금', '7', '토') || ')' AS P_DATE \n");
		        sbSql.append("             , A.ACT_AMT -- 관리금액                                                                                                                                                                                       \n");
		        sbSql.append("             , CASE WHEN B.ATTR03 = 'Y'THEN /* 식음료원가 계정이고 재무금액으로 조회하면 */                                                                                                                                \n");
		        sbSql.append("                    A.ACT_AMT/NVL((SELECT M_RATE FROM MAS_UPJANG_M_RATE_MGMT WHERE INPUT_YM = '" + ds_Cond.getString(0, "INPUT_YM") + "' AND DOC_CD = A.DOC_CD AND GUBUN = 'P'), 100)*100                                                                                    \n");
		        sbSql.append("               ELSE                                                                                                                                                                                                        \n");
		        sbSql.append("                    A.ACT_AMT                                                                                                                                                                                              \n");
		        sbSql.append("               END U_ACT_AMT -- 재무금액                                                                                                                                                                                   \n");
		        sbSql.append("             , C.DIFF_ACT_AMT -- 관리와 재무의 차이금액                                                                                                                                                                    \n");
		        sbSql.append("          FROM MAS_DAILY_PL_REPORT A                                                                                                                                                                                       \n");
		        sbSql.append("             , MAC_MGMT_ACCT       B                                                                                                                                                                                       \n");
		        sbSql.append("             , (SELECT A.DOC_CD                                                                                                                                                                                            \n");
		        sbSql.append("                     , A.INPUT_DD                                                                                                                                                                                          \n");
		        sbSql.append("                     , A.ACT_AMT - A.ACT_AMT/NVL((SELECT M_RATE FROM MAS_UPJANG_M_RATE_MGMT WHERE INPUT_YM = '" + ds_Cond.getString(0, "INPUT_YM") + "' AND DOC_CD = A.DOC_CD AND GUBUN = 'P'), 100)*100 AS DIFF_ACT_AMT                                                     \n");
		        sbSql.append("                  FROM MAS_DAILY_PL_REPORT A                                                                                                                                                                               \n");
		        sbSql.append("                     , MAC_MGMT_ACCT       B                                                                                                                                                                               \n");
		        sbSql.append("                 WHERE 1 = 1                                                                                                                                                                                               \n");
		        sbSql.append("                   AND A.MGMT_ACCT_CD = B.MGMT_ACCT_CD                                                                                                                                                                     \n");
		        sbSql.append("                   AND B.ACCT_TYPE = 'WP'                                                                                                                                                                                  \n");
		        sbSql.append("                   AND B.USE_YN = 'Y'                                                                                                                                                                                      \n");
		        sbSql.append("                   AND A.INPUT_YM = '" + ds_Cond.getString(0, "INPUT_YM") + "'                                                                                                                                                                               \n");
		        sbSql.append("                   AND A.DOC_GUBUN = 'P'    /* 월계획 */                                                                                                                                                                   \n");
		        //sbSql.append("                   AND A.DOC_CD = '100751'  /* 업장 또는 마케터 */                                                                                                                                                         \n");
		        
		     	// 업장(마케터)정보
		        if(!ds_Cond.getString(0, "DOC_CD").equals("")){
		        	sbSql.append("   AND A.DOC_CD = '" + ds_Cond.getString(0, "DOC_CD") + "'  /* 업장 또는 마케터 */   \n");
		        }		        
		        
		        sbSql.append("                   AND B.ATTR03 = 'Y'                                                                                                                                                                                      \n");
		        sbSql.append("                   AND EXISTS (SELECT 1 FROM SCO_UPJANG_MST_V WHERE UPJANG = A.DOC_CD AND TM_CD = '" + ds_Cond.getString(0, "TM_CD") + "') /* 팀만 선택했을 경우(마케터 제외) */                                                                             \n");
		        sbSql.append("               ) C /* 업장에 일자별 식음료원가계정 관리금액과 재무금액의 차이 */                                                                                                                                           \n");
		        sbSql.append("         WHERE 1 = 1                                                                                                                                                                                                       \n");
		        sbSql.append("           AND A.MGMT_ACCT_CD = B.MGMT_ACCT_CD                                                                                                                                                                             \n");
		        sbSql.append("           AND B.ACCT_TYPE = 'WP'                                                                                                                                                                                          \n");
		        sbSql.append("           AND B.USE_YN = 'Y'                                                                                                                                                                                              \n");
		        sbSql.append("           AND A.INPUT_YM = '" + ds_Cond.getString(0, "INPUT_YM") + "'                                                                                                                                                                                       \n");
		        sbSql.append("           AND A.DOC_GUBUN = 'P' /* 월계획 */                                                                                                                                                                              \n");
		        sbSql.append("           AND A.DOC_CD = C.DOC_CD                                                                                                                                                                                         \n");
		        sbSql.append("           AND A.INPUT_DD = C.INPUT_DD                                                                                                                                                                                     \n");
//		        sbSql.append("           AND A.DOC_CD = '100751'  /* 업장 또는 마케터 */                                                                                                                                                                 \n");

		     	// 업장(마케터)정보
		        if(!ds_Cond.getString(0, "DOC_CD").equals("")){
		        	sbSql.append("   AND A.DOC_CD = '" + ds_Cond.getString(0, "DOC_CD") + "'  /* 업장 또는 마케터 */   \n");
		        }

		        sbSql.append("           AND EXISTS (SELECT 1 FROM SCO_UPJANG_MST_V WHERE UPJANG = A.DOC_CD AND TM_CD = '" + ds_Cond.getString(0, "TM_CD") + "') /* 팀만 선택했을 경우(마케터 제외) */                                                                                     \n");
		        sbSql.append("       ) A10                                                                                                                                                                                                               \n");
		        sbSql.append(" GROUP BY A10.P_DATE, A10.MGMT_ACCT_CD, A10.MGMT_ACCT_NAME, A10.INPUT_YN                                                                                                                                                   \n");
			}
		}else{ // 마케터실적마감
			sbSql.append("SELECT A.MGMT_ACCT_CD                                                                                                              \n");
	        sbSql.append("     , B.MGMT_ACCT_NAME                                                                                                            \n");
	        sbSql.append("     , B.ATTR01 AS INPUT_YN                                                                                                                   \n");
	        sbSql.append("     , TO_CHAR(TO_DATE(A.INPUT_DD, 'YYYY-MM-DD'), 'YYYY-MM-DD')|| ' (' || DECODE(TO_CHAR(TO_DATE(A.INPUT_DD, 'YYYYMMDD'), 'D'), '1', '일', '2', '월', '3', '화', '4', '수', '5', '목', '6', '금', '7', '토') || ')' AS P_DATE                                                                                                                 \n");
	        sbSql.append("     , SUM(A.ACT_AMT) ACT_AMT                                                                                                      \n");
	        sbSql.append("  FROM MAS_DAILY_PL_REPORT A                                                                                                       \n");
	        sbSql.append("     , MAC_MGMT_ACCT       B                                                                                                       \n");
	        sbSql.append(" WHERE 1 = 1                                                                                                                       \n");
	        sbSql.append("   AND A.MGMT_ACCT_CD(+) = B.MGMT_ACCT_CD                                                                                             \n");
	        sbSql.append("   AND B.ACCT_TYPE = 'WP'                                                                                                          \n");
	        sbSql.append("   AND B.USE_YN = 'Y'                                                                                                              \n");
	        sbSql.append("   AND A.INPUT_YM(+) = '" + ds_Cond.getString(0, "INPUT_YM") + "'  \n");
	        sbSql.append("   AND A.DOC_GUBUN(+) = 'P' /* 월계획 */                                                                                                \n");

	        // 업장(마케터)정보
	        if(!ds_Cond.getString(0, "DOC_CD").equals("")){
	        	sbSql.append("   AND A.DOC_CD(+) = '" + ds_Cond.getString(0, "DOC_CD") + "'  /* 업장 또는 마케터 */   \n");
	        } 
	        
	     	sbSql.append("  AND A.DOC_CD IN (SELECT V.SABUN                                                                                                                            \n");
	        sbSql.append("                   FROM SCO_FS_HR_PERSONAL_V V                                                                                                                          \n");
	        sbSql.append("                  WHERE 1=1                                                                                                                                \n");
	        sbSql.append("                    AND EXISTS (SELECT 1 FROM SCC_COMMON_CODE WHERE CODE = V.DEPT_ID AND GROUP_CODE = 'MA1002' AND SET1 = 'FICS')                                                                                                                                \n");
	        sbSql.append("                    AND TM_CD = '" + ds_Cond.getString(0, "TM_CD") + "')  \n");
	                
	        sbSql.append(" GROUP BY A.INPUT_DD, A.MGMT_ACCT_CD, MGMT_ACCT_NAME, B.ATTR01                                                                     \n");	        
	        			
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