<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 사업계획관리
■ 프로그램ID   : MAP30010E_T005.jsp
■ 프로그램명   : 사업계획관리 공통경비 조회
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
		DataSet ds_ListDtl;
		
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		
		sbSql.delete(0, sbSql.length());
		sbSql.append(" SELECT PLAN_CLASS 													\n");
		sbSql.append("       ,PLAN_YEAR                                 					\n");
		sbSql.append("       ,VER_CD                                 						\n");
		sbSql.append("       ,CC_CD                                							\n");
		sbSql.append("       ,JOB_GRADE_CD                                					\n");
		sbSql.append("       ,JOB_GRADE_NM                                					\n");
		sbSql.append("       ,ACCT_CD                                     					\n");
		sbSql.append("       ,ACCT_NM                                     					\n");
		sbSql.append("       ,DECODE(SUBSTR(ACCT_CD,1,3), '431', '노무비', 'HRC', '노무비' , '432', '경비', '경비')  ACCT_CLASS	\n");
		sbSql.append("       ,NVL(DECODE(ACCT_CD, 'HRCNT', MM_AMT_01, ROUND(MM_AMT_01 / 1000)), 0) MM_AMT_01   					\n");
		sbSql.append("       ,NVL(DECODE(ACCT_CD, 'HRCNT', MM_AMT_02, ROUND(MM_AMT_02 / 1000)), 0) MM_AMT_02   					\n");
		sbSql.append("       ,NVL(DECODE(ACCT_CD, 'HRCNT', MM_AMT_03, ROUND(MM_AMT_03 / 1000)), 0) MM_AMT_03   					\n");
		sbSql.append("       ,NVL(DECODE(ACCT_CD, 'HRCNT', MM_AMT_04, ROUND(MM_AMT_04 / 1000)), 0) MM_AMT_04   					\n");
		sbSql.append("       ,NVL(DECODE(ACCT_CD, 'HRCNT', MM_AMT_05, ROUND(MM_AMT_05 / 1000)), 0) MM_AMT_05   					\n");
		sbSql.append("       ,NVL(DECODE(ACCT_CD, 'HRCNT', MM_AMT_06, ROUND(MM_AMT_06 / 1000)), 0) MM_AMT_06   					\n");
		sbSql.append("       ,NVL(DECODE(ACCT_CD, 'HRCNT', MM_AMT_07, ROUND(MM_AMT_07 / 1000)), 0) MM_AMT_07   					\n");
		sbSql.append("       ,NVL(DECODE(ACCT_CD, 'HRCNT', MM_AMT_08, ROUND(MM_AMT_08 / 1000)), 0) MM_AMT_08   					\n");
		sbSql.append("       ,NVL(DECODE(ACCT_CD, 'HRCNT', MM_AMT_09, ROUND(MM_AMT_09 / 1000)), 0) MM_AMT_09   					\n");
		sbSql.append("       ,NVL(DECODE(ACCT_CD, 'HRCNT', MM_AMT_10, ROUND(MM_AMT_10 / 1000)), 0) MM_AMT_10   					\n");
		sbSql.append("       ,NVL(DECODE(ACCT_CD, 'HRCNT', MM_AMT_11, ROUND(MM_AMT_11 / 1000)), 0) MM_AMT_11   					\n");
		sbSql.append("       ,NVL(DECODE(ACCT_CD, 'HRCNT', MM_AMT_12, ROUND(MM_AMT_12 / 1000)), 0) MM_AMT_12   					\n");
		sbSql.append("   FROM MAP_BPC_SC_EXPENSE_INFO                     					\n");
		sbSql.append("  WHERE PLAN_CLASS = 'AP'                           					\n");
		sbSql.append("    AND PLAN_YEAR = '" + ds_Cond.getString(0, "INPUT_YY") + "'        \n");
		sbSql.append("    AND VER_CD = (SELECT VER_CD FROM MAP_BPC_MODIFY_PLAN WHERE PLAN_CLASS = 'AP' AND OPEN_YN = 'Y')	\n");
		sbSql.append("    AND CC_CD = '" + nullToBlank(ds_Cond.getString(0, "CC_CD")) + "'	\n");
		sbSql.append("  ORDER BY JOB_GRADE_NM, ACCT_CD                    					\n");
		
		out_vl.add("fa_Sql", sbSql.toString());

		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_ListDtl = this.makeDataSet(rs, "ds_ListDtl");

		pstmt.close();
		rs.close();

		/**종료**/
		out_dl.add(ds_ListDtl);
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