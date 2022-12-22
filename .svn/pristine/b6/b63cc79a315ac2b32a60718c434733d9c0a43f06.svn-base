<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 사업계획관리
■ 프로그램ID   : MAP30010E_T006.jsp
■ 프로그램명   : 사업계획관리 조리직 조회
■ 작성일자     : 2015-08-25
■ 작성자       : 김태윤
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
		String g_Yy     	= nullToBlank(in_vl.getString("g_Yy"));
		
		//out 데이타
		DataSet ds_ListDtl2;
		
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		
		sbSql.delete(0, sbSql.length());
		sbSql.append("	SELECT A.ACCT_CLASS      										\n");
		sbSql.append("        ,B.YY AS PLAN_YEAR                           				\n");
		sbSql.append("        ,B.VER_CD                                 				\n");
		sbSql.append("        ,B.CC_CD                                					\n");
		sbSql.append("	      ,A.ACCT_CD                                                \n");
		sbSql.append("	      ,A.ACCT_NM                                                \n");
		sbSql.append("	      ,'FS-1486' AS JOB_GRADE_CD                                \n");
		sbSql.append("	      ,A.JOB_GRADE_NM                                           \n");
		sbSql.append("	      ,NVL(DECODE(A.ACCT_CD, 'HRCNT', MIN(B.MM_AMT_01), ROUND(NVL(MIN(B.MM_AMT_01), 0) / 1000)),0) MM_AMT_01         \n");
		sbSql.append("	      ,NVL(DECODE(A.ACCT_CD, 'HRCNT', MIN(B.MM_AMT_02), ROUND(NVL(MIN(B.MM_AMT_02), 0) / 1000)),0) MM_AMT_02         \n");
		sbSql.append("	      ,NVL(DECODE(A.ACCT_CD, 'HRCNT', MIN(B.MM_AMT_03), ROUND(NVL(MIN(B.MM_AMT_03), 0) / 1000)),0) MM_AMT_03         \n");
		sbSql.append("	      ,NVL(DECODE(A.ACCT_CD, 'HRCNT', MIN(B.MM_AMT_04), ROUND(NVL(MIN(B.MM_AMT_04), 0) / 1000)),0) MM_AMT_04         \n");
		sbSql.append("	      ,NVL(DECODE(A.ACCT_CD, 'HRCNT', MIN(B.MM_AMT_05), ROUND(NVL(MIN(B.MM_AMT_05), 0) / 1000)),0) MM_AMT_05         \n");
		sbSql.append("	      ,NVL(DECODE(A.ACCT_CD, 'HRCNT', MIN(B.MM_AMT_06), ROUND(NVL(MIN(B.MM_AMT_06), 0) / 1000)),0) MM_AMT_06         \n");
		sbSql.append("	      ,NVL(DECODE(A.ACCT_CD, 'HRCNT', MIN(B.MM_AMT_07), ROUND(NVL(MIN(B.MM_AMT_07), 0) / 1000)),0) MM_AMT_07         \n");
		sbSql.append("	      ,NVL(DECODE(A.ACCT_CD, 'HRCNT', MIN(B.MM_AMT_08), ROUND(NVL(MIN(B.MM_AMT_08), 0) / 1000)),0) MM_AMT_08         \n");
		sbSql.append("	      ,NVL(DECODE(A.ACCT_CD, 'HRCNT', MIN(B.MM_AMT_09), ROUND(NVL(MIN(B.MM_AMT_09), 0) / 1000)),0) MM_AMT_09         \n");
		sbSql.append("	      ,NVL(DECODE(A.ACCT_CD, 'HRCNT', MIN(B.MM_AMT_10), ROUND(NVL(MIN(B.MM_AMT_10), 0) / 1000)),0) MM_AMT_10         \n");
		sbSql.append("	      ,NVL(DECODE(A.ACCT_CD, 'HRCNT', MIN(B.MM_AMT_11), ROUND(NVL(MIN(B.MM_AMT_11), 0) / 1000)),0) MM_AMT_11         \n");
		sbSql.append("	      ,NVL(DECODE(A.ACCT_CD, 'HRCNT', MIN(B.MM_AMT_12), ROUND(NVL(MIN(B.MM_AMT_12), 0) / 1000)),0) MM_AMT_12         \n");
		sbSql.append("	  FROM (                                                        \n");
		sbSql.append("	        SELECT '노무비' AS ACCT_CLASS                         	\n");
		sbSql.append("	              ,'43102010' AS ACCT_CD                            \n");
		sbSql.append("	              ,'직원급여_기본급' AS ACCT_NM                     \n");
		sbSql.append("	              ,'조리직' AS JOB_GRADE_NM                         \n");
		sbSql.append("	          FROM DUAL                                             \n");
		sbSql.append("	         UNION ALL                                              \n");
		sbSql.append("	        SELECT '노무비' AS ACCT_CLASS                         	\n");
		sbSql.append("	              ,'43102020' AS ACCT_CD                            \n");
		sbSql.append("	              ,'직원급여_상여금' AS ACCT_NM                     \n");
		sbSql.append("	              ,'조리직' AS JOB_GRADE_NM                         \n");
		sbSql.append("	          FROM DUAL                                             \n");
		sbSql.append("	         UNION ALL                                              \n");
		sbSql.append("	        SELECT '노무비' AS ACCT_CLASS                         	\n");
		sbSql.append("	              ,'43102030' AS ACCT_CD                            \n");
		sbSql.append("	              ,'직원급여_제수당' AS ACCT_NM                     \n");
		sbSql.append("	              ,'조리직' AS JOB_GRADE_NM                         \n");
		sbSql.append("	          FROM DUAL                                             \n");
		sbSql.append("	         UNION ALL                                              \n");
		sbSql.append("	        SELECT '노무비' AS ACCT_CLASS                         	\n");
		sbSql.append("	              ,'HRCNT' AS ACCT_CD                               \n");
		sbSql.append("	              ,'인원수' AS ACCT_NM                              \n");
		sbSql.append("	              ,'조리직' AS JOB_GRADE_NM                         \n");
		sbSql.append("	          FROM DUAL                                             \n");
		sbSql.append("	       ) A                                                      \n");
		sbSql.append("	      ,MAP_BIZ_PLAN_DTL B                                       \n");
		sbSql.append("	 WHERE A.ACCT_CD = B.ACCT_CD(+)                                 \n");
		sbSql.append("	   AND B.UPJANG(+) = '" + ds_Cond.getString(0, "UPJANG") + "'   \n");
		sbSql.append("	   AND B.YY(+) = '" + ds_Cond.getString(0, "INPUT_YY") + "'     \n");
		sbSql.append("	 GROUP BY A.ACCT_CLASS, B.YY, B.VER_CD, B.CC_CD, A.ACCT_CD, A.ACCT_NM, A.JOB_GRADE_NM    \n");
		sbSql.append("	 ORDER BY A.JOB_GRADE_NM, A.ACCT_CD                             \n");
		
		out_vl.add("fa_Sql", sbSql.toString());

		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_ListDtl2 = this.makeDataSet(rs, "ds_ListDtl2");

		pstmt.close();
		rs.close();

		/**종료**/
		out_dl.add(ds_ListDtl2);
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