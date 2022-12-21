<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/매출통계
■ 프로그램ID   : MAO00030V_T001.jsp
■ 프로그램명   : 누계매출/손익보고
■ 작성일자     : 2012-03-09
■ 작성자       : 박은규
■ 이력관리     : 2012-03-09 박은규 - 최초개발 (CH201203_00081)
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

		//입력 데이타dd
		DataSet ds_Cond     = in_dl.get("ds_Cond");
		//입력 파라메터
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		//FileLog.println("d:\\aaa.txt", ds_Cond);
		
		//변수
		String strSDay, strEDay, strPreSDay , strPreEDay;
		
		//out 데이타
		//DataSet ds_List;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		StringBuffer sbSqlRtn = new StringBuffer();

		//전년 동일 요일 구하기
		sbSql.delete(0, sbSql.length());
		sbSql.append("SELECT TO_CHAR(NEXT_DAY(ADD_MONTHS(TO_DATE('" + nullToBlank(ds_Cond.getString(0, "SDATE")) + "','YYYYMMDD'),-12),TO_CHAR(TO_DATE('" + nullToBlank(ds_Cond.getString(0, "SDATE")) + "','YYYYMMDD'),'DY'))-0,'YYYY-MM-DD') AS PRESDAY \n");
		sbSql.append("     , TO_CHAR(NEXT_DAY(ADD_MONTHS(TO_DATE('" + nullToBlank(ds_Cond.getString(0, "EDATE")) + "','YYYYMMDD'),-12),TO_CHAR(TO_DATE('" + nullToBlank(ds_Cond.getString(0, "EDATE")) + "','YYYYMMDD'),'DY'))-0,'YYYY-MM-DD') AS PREEDAY \n");
		sbSql.append("     , TO_CHAR(TO_DATE('" + nullToBlank(ds_Cond.getString(0, "SDATE")) + "','YYYYMMDD'),'DY','NLS_DATE_LANGUAGE=KOREAN') AS SWEEK \n");
		sbSql.append("     , TO_CHAR(TO_DATE('" + nullToBlank(ds_Cond.getString(0, "EDATE")) + "','YYYYMMDD'),'DY','NLS_DATE_LANGUAGE=KOREAN') AS EWEEK \n");
		sbSql.append("  FROM DUAL \n");
		
		out_vl.add("fa_Sql", sbSql.toString());
		
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery();
		if (! rs.next())
		{
			this.setResultMessage(-1, "전년 일자 조회오류!", out_vl);
			//throw new Exception();
			proc_output(response,out,out_vl,out_dl);
			return;			
		}
		strPreSDay = rs.getString("PRESDAY").replaceAll("-","");
		strPreEDay = rs.getString("PREEDAY").replaceAll("-","");

		out_vl.add("fa_PreDay", "전년:" + rs.getString("PRESDAY") + '(' + rs.getString("SWEEK") + ')'+" ~ " + rs.getString("PREEDAY") + '(' + rs.getString("EWEEK")+')');

		rs.close();
		pstmt.close();

		strSDay = nullToBlank(ds_Cond.getString(0, "SDATE"));
		strEDay = nullToBlank(ds_Cond.getString(0, "EDATE"));

		
		//내역조회
		for (int iCnt=0; iCnt<3; iCnt++)
		{
			sbSql.delete(0, sbSql.length());
			sbSql.append("WITH A AS \n");
			sbSql.append("( \n");
			//팀-파트 정보
			sbSql.append("SELECT A.TM_CD AS TEAM_CODE \n");
			sbSql.append("     , (SELECT TM_SEQ FROM (SELECT ROWNUM TM_SEQ,TM_CD FROM HLDC_SC_TM WHERE USE_YN = 'Y' ORDER BY MU_CD,TM_CD) WHERE TM_CD = A.TM_CD) AS TEAM_SEQ \n");
			sbSql.append("     , A.PART_CODE \n");
			sbSql.append("     , A.SORT_SEQ AS PART_SEQ \n");
			sbSql.append("     , 0 AS DAY_PLAN \n");
			sbSql.append("     , 0 AS DAY_PLAN_MARGIN \n");
			sbSql.append("     , 0 AS DAY_SALE \n");
			sbSql.append("     , 0 AS DAY_MARGIN \n");
			sbSql.append("     , 0 AS PRE_DAY_SALE \n");
			sbSql.append("     , 0 AS PRE_DAY_MARGIN \n");
			sbSql.append("     , 0 AS MONTH_PLAN \n");
			sbSql.append("     , 0 AS MONTH_PLAN_MARGIN \n");
			sbSql.append("     , 0 AS MONTH_SALE \n");
			sbSql.append("     , 0 AS MONTH_MARGIN \n");
			sbSql.append("     , 0 AS PRE_MONTH_SALE \n");
			sbSql.append("     , 0 AS PRE_MONTH_MARGIN \n");
			sbSql.append("     , 0 AS YEAR_PLAN \n");
			sbSql.append("     , 0 AS YEAR_PLAN_MARGIN \n");
			sbSql.append("     , 0 AS YEAR_SALE \n");
			sbSql.append("     , 0 AS YEAR_MARGIN \n");
			sbSql.append("     , 0 AS PRE_YEAR_SALE \n");
			sbSql.append("     , 0 AS PRE_YEAR_MARGIN \n");
			sbSql.append("  FROM (SELECT UJ.PART_CODE, P.SORT_SEQ, P.CODE_NAME AS PART_CODE_NAME, DJ.TM_CD  \n");
			sbSql.append("       FROM FMS_UPJANG_V UJ, HLDC_SC_DEPT_V DJ, HLDC_ST_UPJANG HUJ, FMS_UPJANG_V UJ2, SCC_COMMON_CODE P  \n"); 
			sbSql.append("  WHERE UJ.MAIN_UPJANG=UJ2.UPJANG   \n");
			sbSql.append("  AND UJ.DEPT_ID=DJ.DEPT_ID   \n");
			sbSql.append("  AND UJ.UPJANG=HUJ.UPJANG   \n");
			sbSql.append("  AND UJ.PART_CODE=P.CODE   \n");
			sbSql.append("  AND P.GROUP_CODE='FM0022'   \n");
			sbSql.append("  AND UJ.PART_CODE IS NOT NULL   \n");
			sbSql.append("  GROUP BY DJ.TM_CD , UJ.PART_CODE, P.CODE_NAME, P.SORT_SEQ  \n"); 
			sbSql.append("  ORDER BY DJ.TM_CD , UJ.PART_CODE ) A WHERE 1=1  \n");
			if (! nullToBlank(ds_Cond.getString(0, "TEAM_CODE")).equals(""))
				sbSql.append("   AND A.TM_CD = '" + nullToBlank(ds_Cond.getString(0, "TEAM_CODE")) + "' \n");
			sbSql.append("----------- \n");
			sbSql.append(" UNION ALL \n");
			sbSql.append("----------- \n");
			//매출계획
			sbSql.append("SELECT A.TEAM_CODE \n");
			sbSql.append("     , (SELECT TM_SEQ FROM (SELECT ROWNUM TM_SEQ,TM_CD FROM HLDC_SC_TM WHERE USE_YN = 'Y' ORDER BY MU_CD,TM_CD) WHERE TM_CD = A.TEAM_CODE) AS TEAM_SEQ \n");
			sbSql.append("     , A.PART_CODE \n");
			sbSql.append("     , (SELECT Z.SORT_SEQ FROM SCC_COMMON_CODE Z WHERE Z.GROUP_CODE = 'FM0022' AND Z.CODE = A.PART_CODE) AS PART_SEQ \n");
			//sbSql.append("     , SUM(DECODE(A.YYYYMM,SUBSTR('" + strEDay + "',1,6),ROUND(A.SALE_AMOUNT/(SELECT Z.BIZDAYS FROM FMB_BIZDAY Z WHERE Z.YYYYMM = A.YYYYMM AND Z.TEAM_CODE = A.TEAM_CODE)),0)) AS DAY_PLAN \n");
			//sbSql.append("     , SUM(DECODE(A.YYYYMM,SUBSTR('" + strEDay + "',1,6),ROUND(A.MARGIN_AMOUNT/(SELECT Z.BIZDAYS FROM FMB_BIZDAY Z WHERE Z.YYYYMM = A.YYYYMM AND Z.TEAM_CODE = A.TEAM_CODE)),0)) AS DAY_PLAN_MARGIN \n");
			//sbSql.append("     , SUM(DECODE(A.YYYYMM,SUBSTR('" + strSDay + "',1,6),ROUND(A.SALE_AMOUNT/(SELECT COUNT(*) FROM (SELECT DISTINCT A.YYYYMMDD , A.YYYYMM , A.TEAM_CODE FROM FMB_SALE_PLAN A ) Z WHERE Z.YYYYMM = A.YYYYMM AND Z.TEAM_CODE = A.TEAM_CODE)),0)) AS DAY_PLAN \n");
			//sbSql.append("     , SUM(DECODE(A.YYYYMM,SUBSTR('" + strSDay + "',1,6),ROUND(A.MARGIN_AMOUNT/(SELECT COUNT(*) FROM (SELECT DISTINCT A.YYYYMMDD , A.YYYYMM , A.TEAM_CODE FROM FMB_SALE_PLAN A ) Z WHERE Z.YYYYMM = A.YYYYMM AND Z.TEAM_CODE = A.TEAM_CODE)),0)) AS DAY_PLAN_MARGIN \n");
			//sbSql.append("     , SUM(DECODE(A.YYYYMM,SUBSTR('" + strSDay + "',1,6),ROUND(A.SALE_AMOUNT/(SELECT SUM(BIZDAYS) FROM FMB_BIZDAY WHERE YYYYMM = A.YYYYMM AND TEAM_CODE = A.TEAM_CODE AND YYYYMM||DD_DAYS BETWEEN SUBSTR('" + strSDay + "',1,4)||'0101' AND '" + strSDay + "')),0)) AS DAY_PLAN \n");			
			//sbSql.append("     , SUM(DECODE(A.YYYYMM,SUBSTR('" + strSDay + "',1,6),ROUND(A.MARGIN_AMOUNT/(SELECT SUM(BIZDAYS) FROM FMB_BIZDAY WHERE YYYYMM = A.YYYYMM AND TEAM_CODE = A.TEAM_CODE AND YYYYMM||DD_DAYS BETWEEN SUBSTR('" + strSDay + "',1,4)||'0101' AND '" + strSDay + "')),0)) AS DAY_PLAN_MARGIN \n");
			sbSql.append("     , SUM(CASE WHEN A.YYYYMMDD BETWEEN SUBSTR('" + strSDay + "',1,6)||'01' AND '" + strSDay + "' THEN ROUND(A.SALE_AMOUNT/(SELECT SUM(BIZDAYS) FROM FMB_BIZDAY WHERE YYYYMM = A.YYYYMM AND TEAM_CODE = A.TEAM_CODE AND YYYYMM||DD_DAYS BETWEEN SUBSTR('" + strSDay + "',1,6)||'01' AND '" + strSDay + "'))ELSE 0 END) AS DAY_PLAN \n");
			sbSql.append("     , SUM(CASE WHEN A.YYYYMMDD BETWEEN SUBSTR('" + strSDay + "',1,6)||'01' AND '" + strSDay + "' THEN ROUND(A.MARGIN_AMOUNT/(SELECT SUM(BIZDAYS) FROM FMB_BIZDAY WHERE YYYYMM = A.YYYYMM AND TEAM_CODE = A.TEAM_CODE AND YYYYMM||DD_DAYS BETWEEN SUBSTR('" + strSDay + "',1,6)||'01' AND '" + strSDay + "'))ELSE 0 END) AS DAY_PLAN_MARGIN \n");
			sbSql.append("     , 0 AS DAY_SALE \n");
			sbSql.append("     , 0 AS DAY_MARGIN \n");
			sbSql.append("     , 0 AS PRE_DAY_SALE \n");
			sbSql.append("     , 0 AS PRE_DAY_MARGIN \n");
			sbSql.append("     , SUM(DECODE(A.YYYYMM,SUBSTR('" + strSDay + "',1,6),A.SALE_AMOUNT,0)) AS MONTH_PLAN \n");
			sbSql.append("     , SUM(DECODE(A.YYYYMM,SUBSTR('" + strSDay + "',1,6),A.MARGIN_AMOUNT,0)) AS MONTH_PLAN_MARGIN \n");
			sbSql.append("     , 0 AS MONTH_SALE \n");
			sbSql.append("     , 0 AS MONTH_MARGIN \n");
			sbSql.append("     , 0 AS PRE_MONTH_SALE \n");
			sbSql.append("     , 0 AS PRE_MONTH_MARGIN \n");
			sbSql.append("     , SUM(A.SALE_AMOUNT) AS YEAR_PLAN \n");
			sbSql.append("     , SUM(A.MARGIN_AMOUNT) AS YEAR_PLAN_MARGIN \n");
			sbSql.append("     , 0 AS YEAR_SALE \n");
			sbSql.append("     , 0 AS YEAR_MARGIN \n");
			sbSql.append("     , 0 AS PRE_YEAR_SALE \n");
			sbSql.append("     , 0 AS PRE_YEAR_MARGIN \n");
			sbSql.append("  FROM FMB_SALE_PLAN A \n");
			sbSql.append(" WHERE A.YYYYMM BETWEEN SUBSTR('" + strSDay + "',1,4)||'01' AND SUBSTR('" + strSDay + "',1,6) \n");
			if (! nullToBlank(ds_Cond.getString(0, "TEAM_CODE")).equals(""))
				sbSql.append("   AND A.TEAM_CODE = '" + nullToBlank(ds_Cond.getString(0, "TEAM_CODE")) + "' \n");
			sbSql.append(" GROUP BY A.TEAM_CODE, A.PART_CODE \n");
			//매출실적
			sbSql.append("----------- \n");
			sbSql.append(" UNION ALL \n");
			sbSql.append("----------- \n");
			sbSql.append("SELECT A.TEAM_CODE \n");
			sbSql.append("     , (SELECT TM_SEQ FROM (SELECT ROWNUM TM_SEQ,TM_CD FROM HLDC_SC_TM WHERE USE_YN = 'Y' ORDER BY MU_CD,TM_CD) WHERE TM_CD = A.TEAM_CODE) AS TEAM_SEQ \n");
			sbSql.append("     , A.PART_CODE \n");
			sbSql.append("     , (SELECT Z.SORT_SEQ FROM SCC_COMMON_CODE Z WHERE Z.GROUP_CODE = 'FM0022' AND Z.CODE = A.PART_CODE) AS PART_SEQ \n");
			sbSql.append("     , 0 AS DAY_PLAN \n");
			sbSql.append("     , 0 AS DAY_PLAN_MARGIN \n");
			sbSql.append("     , SUM(DECODE(A.SDATE,'" + strSDay + "',A.SALE_AMOUNT,0)) AS DAY_SALE \n");
			sbSql.append("     , SUM(DECODE(A.SDATE,'" + strSDay + "',A.SALE_AMOUNT-A.UNIT_AMOUNT,0)) AS DAY_MARGIN \n");
			sbSql.append("     , 0 AS PRE_DAY_SALE \n");
			sbSql.append("     , 0 AS PRE_DAY_MARGIN \n");
			sbSql.append("     , 0 AS MONTH_PLAN \n");
			sbSql.append("     , 0 AS MONTH_PLAN_MARGIN \n");
			sbSql.append("     , SUM(DECODE(SUBSTR(A.SDATE,1,6),SUBSTR('" + strSDay + "',1,6),A.SALE_AMOUNT,0)) AS MONTH_SALE \n");
			sbSql.append("     , SUM(DECODE(SUBSTR(A.SDATE,1,6),SUBSTR('" + strSDay + "',1,6),A.SALE_AMOUNT-A.UNIT_AMOUNT,0)) AS MONTH_MARGIN \n");
			sbSql.append("     , 0 AS PRE_MONTH_SALE \n");
			sbSql.append("     , 0 AS PRE_MONTH_MARGIN \n");
			sbSql.append("     , 0 AS YEAR_PLAN \n");
			sbSql.append("     , 0 AS YEAR_PLAN_MARGIN \n");
			sbSql.append("     , SUM(A.SALE_AMOUNT) AS YEAR_SALE \n");
			sbSql.append("     , SUM(A.SALE_AMOUNT-A.UNIT_AMOUNT) AS YEAR_MARGIN \n");
			sbSql.append("     , 0 AS PRE_YEAR_SALE \n");
			sbSql.append("     , 0 AS PRE_YEAR_MARGIN \n");
			sbSql.append("  FROM FMB_SALE_DATA A \n");
			sbSql.append(" WHERE A.SDATE BETWEEN SUBSTR('" + strSDay + "',1,4)||'0101' AND '" + strSDay + "' \n");
			sbSql.append("   AND A.USE_YN = 'Y' \n");
			if (! nullToBlank(ds_Cond.getString(0, "TEAM_CODE")).equals(""))
				sbSql.append("   AND A.TEAM_CODE = '" + nullToBlank(ds_Cond.getString(0, "TEAM_CODE")) + "' \n");
			sbSql.append(" GROUP BY A.TEAM_CODE, A.PART_CODE \n");
			//전년실적
			sbSql.append("----------- \n");
			sbSql.append(" UNION ALL \n");
			sbSql.append("----------- \n");
			sbSql.append("SELECT A.TEAM_CODE \n");
			sbSql.append("     , (SELECT TM_SEQ FROM (SELECT ROWNUM TM_SEQ,TM_CD FROM HLDC_SC_TM WHERE USE_YN = 'Y' ORDER BY MU_CD,TM_CD) WHERE TM_CD = A.TEAM_CODE) AS TEAM_SEQ \n");
			sbSql.append("     , A.PART_CODE \n");
			sbSql.append("     , (SELECT Z.SORT_SEQ FROM SCC_COMMON_CODE Z WHERE Z.GROUP_CODE = 'FM0022' AND Z.CODE = A.PART_CODE) AS PART_SEQ \n");
			sbSql.append("     , 0 AS DAY_PLAN \n");
			sbSql.append("     , 0 AS DAY_PLAN_MARGIN \n");
			sbSql.append("     , 0 AS DAY_SALE \n");
			sbSql.append("     , 0 AS DAY_MARGIN \n");
			sbSql.append("     , SUM(DECODE(A.SDATE,'" + strPreSDay + "',A.SALE_AMOUNT,0)) AS PRE_DAY_SALE \n");
			sbSql.append("     , SUM(DECODE(A.SDATE,'" + strPreSDay + "',A.SALE_AMOUNT-A.UNIT_AMOUNT,0)) AS PRE_DAY_MARGIN \n");
			sbSql.append("     , 0 AS MONTH_PLAN \n");
			sbSql.append("     , 0 AS MONTH_PLAN_MARGIN \n");
			sbSql.append("     , 0 AS MONTH_SALE \n");
			sbSql.append("     , 0 AS MONTH_MARGIN \n");
			sbSql.append("     , SUM(DECODE(SUBSTR(A.SDATE,1,6),SUBSTR('" + strPreSDay + "',1,6),A.SALE_AMOUNT,0)) AS PRE_MONTH_SALE \n");
			sbSql.append("     , SUM(DECODE(SUBSTR(A.SDATE,1,6),SUBSTR('" + strPreSDay + "',1,6),A.SALE_AMOUNT-A.UNIT_AMOUNT,0)) AS PRE_MONTH_MARGIN \n");
			sbSql.append("     , 0 AS YEAR_PLAN \n");
			sbSql.append("     , 0 AS YEAR_PLAN_MARGIN \n");
			sbSql.append("     , 0 AS YEAR_SALE \n");
			sbSql.append("     , 0 AS YEAR_MARGIN \n");
			sbSql.append("     , SUM(A.SALE_AMOUNT) AS PRE_YEAR_SALE \n");
			sbSql.append("     , SUM(A.SALE_AMOUNT-A.UNIT_AMOUNT) AS PRE_YEAR_MARGIN \n");
			sbSql.append("  FROM FMB_SALE_DATA A \n");
			sbSql.append(" WHERE A.SDATE BETWEEN SUBSTR('" + strPreSDay + "',1,4)||'0101' AND '" + strPreSDay + "' \n");
			sbSql.append("   AND A.USE_YN = 'Y' \n");
			if (! nullToBlank(ds_Cond.getString(0, "TEAM_CODE")).equals(""))
				sbSql.append("   AND A.TEAM_CODE = '" + nullToBlank(ds_Cond.getString(0, "TEAM_CODE")) + "' \n");
			sbSql.append(" GROUP BY A.TEAM_CODE, A.PART_CODE \n");
			sbSql.append(") \n");
			//
			//매출액
			if (iCnt == 0)
			{
				sbSql.append("SELECT " + iCnt + " AS LLVEL \n");
				sbSql.append("     , GROUPING(A.TEAM_CODE) + GROUPING(A.PART_CODE) AS GB \n");
				sbSql.append("     , CASE \n");
				sbSql.append("         WHEN GROUPING(A.TEAM_CODE) = 1 AND GROUPING(A.PART_CODE) = 1 THEN DECODE(" + iCnt + ",0,'매출액',1,'매출이익액',2,'매출이익률') \n");
				sbSql.append("         WHEN GROUPING(A.TEAM_CODE) = 0 AND GROUPING(A.PART_CODE) = 1 THEN '  '||(SELECT TM_NM FROM HLDC_SC_TM WHERE USE_YN = 'Y' AND TM_CD = A.TEAM_CODE)||'('||NVL((SELECT SUM(BIZDAYS) FROM FMB_BIZDAY WHERE YYYYMM = SUBSTR('" + strSDay + "',1,6) AND TEAM_CODE = A.TEAM_CODE AND YYYYMM||DD_DAYS BETWEEN SUBSTR('" + strSDay + "',1,6)||'01' AND '" + strSDay + "'),0)||')' \n");
				sbSql.append("         ELSE '    '||(SELECT Z.CODE_NAME FROM SCC_COMMON_CODE Z WHERE Z.GROUP_CODE = 'FM0022' AND Z.CODE = A.PART_CODE) \n");
				sbSql.append("       END AS LINE_NAME \n");
				sbSql.append("     , A.TEAM_CODE, A.PART_CODE \n");
				sbSql.append("     , NVL(ROUND(SUM(A.DAY_PLAN)),0) AS DAY_PLAN \n");
				sbSql.append("     , NVL(ROUND(SUM(A.DAY_SALE)),0) AS DAY_SALE \n");
				sbSql.append("     , NVL(DECODE(SUM(A.DAY_PLAN),0,100,ROUND(SUM(A.DAY_SALE)/SUM(A.DAY_PLAN)*100,1)),0) AS DAY_RATE \n");
				sbSql.append("     , NVL(ROUND(SUM(A.DAY_SALE))- ROUND(SUM(A.DAY_PLAN)),0) AS DAY_DIFF \n");
				sbSql.append("     , ROUND(SUM(A.PRE_DAY_SALE)) AS PRE_DAY_SALE \n");
				sbSql.append("     , DECODE(SUM(A.PRE_DAY_SALE),0,100,ROUND(SUM(A.DAY_SALE)/SUM(A.PRE_DAY_SALE)*100,1)) AS PRE_DAY_RATE \n");
				sbSql.append("     , ROUND(SUM(A.DAY_SALE))- ROUND(SUM(A.PRE_DAY_SALE)) AS PRE_DAY_DIFF \n");
				sbSql.append("     , ROUND(SUM(A.MONTH_PLAN)) AS MONTH_PLAN \n");
				sbSql.append("     , ROUND(SUM(A.MONTH_SALE)) AS MONTH_SALE \n");
				sbSql.append("     , DECODE(SUM(A.MONTH_PLAN),0,100,ROUND(SUM(A.MONTH_SALE)/SUM(A.MONTH_PLAN)*100,1)) AS MONTH_RATE \n");
				sbSql.append("     , ROUND(SUM(A.MONTH_SALE))- ROUND(SUM(A.MONTH_PLAN)) AS MONTH_DIFF \n");
				sbSql.append("     , ROUND(SUM(A.PRE_MONTH_SALE)) AS PRE_MONTH_SALE \n");
				sbSql.append("     , DECODE(SUM(A.PRE_MONTH_SALE),0,100,ROUND(SUM(A.MONTH_SALE)/SUM(A.PRE_MONTH_SALE)*100,1)) AS PRE_MONTH_RATE \n");
				sbSql.append("     , ROUND(SUM(A.MONTH_SALE))- ROUND(SUM(A.PRE_MONTH_SALE)) AS PRE_MONTH_DIFF \n");
				sbSql.append("     , ROUND(SUM(A.YEAR_PLAN)) AS YEAR_PLAN \n");
				sbSql.append("     , ROUND(SUM(A.YEAR_SALE)) AS YEAR_SALE \n");
				sbSql.append("     , DECODE(SUM(A.YEAR_PLAN),0,100,ROUND(SUM(A.YEAR_SALE)/SUM(A.YEAR_PLAN)*100,1)) AS YEAR_RATE \n");
				sbSql.append("     , ROUND(SUM(A.YEAR_SALE))- ROUND(SUM(A.YEAR_PLAN)) AS YEAR_DIFF \n");
				sbSql.append("     , ROUND(SUM(A.PRE_YEAR_SALE)) AS PRE_YEAR_SALE \n");
				sbSql.append("     , DECODE(SUM(A.PRE_YEAR_SALE),0,100,ROUND(SUM(A.YEAR_SALE)/SUM(A.PRE_YEAR_SALE)*100,1)) AS PRE_YEAR_RATE \n");
				sbSql.append("     , ROUND(SUM(A.YEAR_SALE))- ROUND(SUM(A.PRE_YEAR_SALE)) AS PRE_YEAR_DIFF \n");
				sbSql.append("  FROM A  \n");
				sbSql.append(" GROUP BY ROLLUP((A.TEAM_SEQ, A.TEAM_CODE), (A.PART_SEQ, A.PART_CODE)) \n");
//				sbSql.append(" ORDER BY A.TEAM_CODE NULLS FIRST, A.PART_CODE NULLS FIRST \n");
				sbSql.append(" ORDER BY A.TEAM_SEQ NULLS FIRST, A.PART_SEQ NULLS FIRST \n");
			}
			//매출이익액
			else if (iCnt == 1)
			{
				sbSql.append("SELECT " + iCnt + " AS LLVEL \n");
				sbSql.append("     , GROUPING(A.TEAM_CODE) + GROUPING(A.PART_CODE) AS GB \n");
		        sbSql.append("     , CASE \n");
		        sbSql.append("         WHEN GROUPING(A.TEAM_CODE) = 1 AND GROUPING(A.PART_CODE) = 1 THEN DECODE(" + iCnt + ",0,'매출액',1,'매출이익액',2,'매출이익률') \n");
		        sbSql.append("         WHEN GROUPING(A.TEAM_CODE) = 0 AND GROUPING(A.PART_CODE) = 1 THEN '  '||(SELECT TM_NM FROM HLDC_SC_TM WHERE USE_YN = 'Y' AND TM_CD = A.TEAM_CODE)||'('||NVL((SELECT SUM(BIZDAYS) FROM FMB_BIZDAY WHERE YYYYMM = SUBSTR('" + strSDay + "',1,6) AND TEAM_CODE = A.TEAM_CODE AND YYYYMM||DD_DAYS BETWEEN SUBSTR('" + strSDay + "',1,6)||'01' AND '" + strSDay + "'),0)||')' \n");
		        sbSql.append("         ELSE '    '||(SELECT Z.CODE_NAME FROM SCC_COMMON_CODE Z WHERE Z.GROUP_CODE = 'FM0022' AND Z.CODE = A.PART_CODE) \n");
		        sbSql.append("       END AS LINE_NAME \n");
		        sbSql.append("     , A.TEAM_CODE, A.PART_CODE \n");
				sbSql.append("     , NVL(ROUND(SUM(A.DAY_PLAN_MARGIN)),0) AS DAY_PLAN \n");
				sbSql.append("     , NVL(ROUND(SUM(A.DAY_MARGIN)),0) AS DAY_SALE \n");
				sbSql.append("     , NVL(DECODE(SUM(A.DAY_PLAN_MARGIN),0,100,ROUND(SUM(A.DAY_MARGIN)/SUM(A.DAY_PLAN_MARGIN)*100,1)),0) AS DAY_RATE \n");
				sbSql.append("     , NVL(ROUND(SUM(A.DAY_MARGIN))- ROUND(SUM(A.DAY_PLAN_MARGIN)),0) AS DAY_DIFF \n");
				sbSql.append("     , ROUND(SUM(A.PRE_DAY_MARGIN)) AS PRE_DAY_SALE \n");
				sbSql.append("     , DECODE(SUM(A.PRE_DAY_MARGIN),0,100,ROUND(SUM(A.DAY_MARGIN)/SUM(A.PRE_DAY_MARGIN)*100,1)) AS PRE_DAY_RATE \n");
				sbSql.append("     , ROUND(SUM(A.DAY_MARGIN))- ROUND(SUM(A.PRE_DAY_MARGIN)) AS PRE_DAY_DIFF \n");
				sbSql.append("     , ROUND(SUM(A.MONTH_PLAN_MARGIN)) AS MONTH_PLAN \n");
				sbSql.append("     , ROUND(SUM(A.MONTH_MARGIN)) AS MONTH_SALE \n");
				sbSql.append("     , DECODE(SUM(A.MONTH_PLAN_MARGIN),0,100,ROUND(SUM(A.MONTH_MARGIN)/SUM(A.MONTH_PLAN_MARGIN)*100,1)) AS MONTH_RATE \n");
				sbSql.append("     , ROUND(SUM(A.MONTH_MARGIN))- ROUND(SUM(A.MONTH_PLAN_MARGIN)) AS MONTH_DIFF \n");
				sbSql.append("     , ROUND(SUM(A.PRE_MONTH_MARGIN)) AS PRE_MONTH_SALE \n");
				sbSql.append("     , DECODE(SUM(A.PRE_MONTH_MARGIN),0,100,ROUND(SUM(A.MONTH_MARGIN)/SUM(A.PRE_MONTH_MARGIN)*100,1)) AS PRE_MONTH_RATE \n");
				sbSql.append("     , ROUND(SUM(A.MONTH_MARGIN))- ROUND(SUM(A.PRE_MONTH_MARGIN)) AS PRE_MONTH_DIFF \n");
				sbSql.append("     , ROUND(SUM(A.YEAR_PLAN_MARGIN)) AS YEAR_PLAN \n");
				sbSql.append("     , ROUND(SUM(A.YEAR_MARGIN)) AS YEAR_SALE \n");
				sbSql.append("     , DECODE(SUM(A.YEAR_PLAN_MARGIN),0,100,ROUND(SUM(A.YEAR_MARGIN)/SUM(A.YEAR_PLAN_MARGIN)*100,1)) AS YEAR_RATE \n");
				sbSql.append("     , ROUND(SUM(A.YEAR_MARGIN))- ROUND(SUM(A.YEAR_PLAN_MARGIN)) AS YEAR_DIFF \n");
				sbSql.append("     , ROUND(SUM(A.PRE_YEAR_MARGIN)) AS PRE_YEAR_SALE \n");
				sbSql.append("     , DECODE(SUM(A.PRE_YEAR_MARGIN),0,100,ROUND(SUM(A.YEAR_MARGIN)/SUM(A.PRE_YEAR_MARGIN)*100,1)) AS PRE_YEAR_RATE \n");
				sbSql.append("     , ROUND(SUM(A.YEAR_MARGIN))- ROUND(SUM(A.PRE_YEAR_MARGIN)) AS PRE_YEAR_DIFF \n");
		        sbSql.append("  FROM A  \n");
		        sbSql.append(" GROUP BY ROLLUP((A.TEAM_SEQ, A.TEAM_CODE), (A.PART_SEQ, A.PART_CODE)) \n");
//		        sbSql.append(" ORDER BY A.TEAM_CODE NULLS FIRST, A.PART_CODE NULLS FIRST \n");
		        sbSql.append(" ORDER BY A.TEAM_SEQ NULLS FIRST, A.PART_SEQ NULLS FIRST \n");
			}
			//매출이익율
			else
			{
				sbSql.append("SELECT " + iCnt + " AS LLVEL \n");
				sbSql.append("     , GROUPING(A.TEAM_CODE) + GROUPING(A.PART_CODE) AS GB \n");
		        sbSql.append("     , CASE \n");
		        sbSql.append("         WHEN GROUPING(A.TEAM_CODE) = 1 AND GROUPING(A.PART_CODE) = 1 THEN DECODE(" + iCnt + ",0,'매출액',1,'매출이익액',2,'매출이익률') \n");
		        sbSql.append("         WHEN GROUPING(A.TEAM_CODE) = 0 AND GROUPING(A.PART_CODE) = 1 THEN '  '||(SELECT TM_NM FROM HLDC_SC_TM WHERE USE_YN = 'Y' AND TM_CD = A.TEAM_CODE)||'('||NVL((SELECT SUM(BIZDAYS) FROM FMB_BIZDAY WHERE YYYYMM = SUBSTR('" + strSDay + "',1,6) AND TEAM_CODE = A.TEAM_CODE AND YYYYMM||DD_DAYS BETWEEN SUBSTR('" + strSDay + "',1,6)||'01' AND '" + strSDay + "'),0)||')' \n");
		        sbSql.append("         ELSE '    '||(SELECT Z.CODE_NAME FROM SCC_COMMON_CODE Z WHERE Z.GROUP_CODE = 'FM0022' AND Z.CODE = A.PART_CODE) \n");
		        sbSql.append("       END AS LINE_NAME \n");
		        sbSql.append("     , A.TEAM_CODE \n");
		        sbSql.append("     , A.PART_CODE \n");
				sbSql.append("     , NVL(DECODE(SUM(A.DAY_PLAN),0,100,ROUND(SUM(A.DAY_PLAN_MARGIN)/SUM(A.DAY_PLAN)*100,1)),0) AS DAY_PLAN \n");
				sbSql.append("     , NVL(DECODE(SUM(A.DAY_SALE),0,100,ROUND(SUM(A.DAY_MARGIN)/SUM(A.DAY_SALE)*100,1)),0) AS DAY_SALE \n");
				sbSql.append("     , NVL(DECODE(SUM(A.DAY_SALE),0,100,ROUND(SUM(A.DAY_MARGIN)/SUM(A.DAY_SALE)*100,1)) \n");
				sbSql.append("     - DECODE(SUM(A.DAY_PLAN),0,100,ROUND(SUM(A.DAY_PLAN_MARGIN)/SUM(A.DAY_PLAN)*100,1)),0) AS DAY_RATE \n");
				sbSql.append("     , NVL(DECODE(SUM(A.DAY_SALE),0,100,ROUND(SUM(A.DAY_MARGIN)/SUM(A.DAY_SALE)*100,1)) \n");
				sbSql.append("     - DECODE(SUM(A.DAY_PLAN),0,100,ROUND(SUM(A.DAY_PLAN_MARGIN)/SUM(A.DAY_PLAN)*100,1)),0) AS DAY_DIFF \n");
				sbSql.append("     , DECODE(SUM(A.PRE_DAY_SALE),0,100,ROUND(SUM(A.PRE_DAY_MARGIN)/SUM(A.PRE_DAY_SALE)*100,1)) AS PRE_DAY_SALE \n");
				sbSql.append("     , DECODE(SUM(A.DAY_SALE),0,100,ROUND(SUM(A.DAY_MARGIN)/SUM(A.DAY_SALE)*100,1)) \n");
				sbSql.append("     - DECODE(SUM(A.PRE_DAY_SALE),0,100,ROUND(SUM(A.PRE_DAY_MARGIN)/SUM(A.PRE_DAY_SALE)*100,1)) AS PRE_DAY_RATE \n");
				sbSql.append("     , DECODE(SUM(A.DAY_SALE),0,100,ROUND(SUM(A.DAY_MARGIN)/SUM(A.DAY_SALE)*100,1)) \n");
				sbSql.append("     - DECODE(SUM(A.PRE_DAY_SALE),0,100,ROUND(SUM(A.PRE_DAY_MARGIN)/SUM(A.PRE_DAY_SALE)*100,1)) AS PRE_DAY_DIFF \n");
				sbSql.append("     , DECODE(SUM(A.MONTH_PLAN),0,100,ROUND(SUM(A.MONTH_PLAN_MARGIN)/SUM(A.MONTH_PLAN)*100,1)) AS MONTH_PLAN \n");
				sbSql.append("     , DECODE(SUM(A.MONTH_SALE),0,100,ROUND(SUM(A.MONTH_MARGIN)/SUM(A.MONTH_SALE)*100,1)) AS MONTH_SALE \n");
				sbSql.append("     , DECODE(SUM(A.MONTH_SALE),0,100,ROUND(SUM(A.MONTH_MARGIN)/SUM(A.MONTH_SALE)*100,1)) \n");
				sbSql.append("     - DECODE(SUM(A.MONTH_PLAN),0,100,ROUND(SUM(A.MONTH_PLAN_MARGIN)/SUM(A.MONTH_PLAN)*100,1)) AS MONTH_RATE \n");
				sbSql.append("     , DECODE(SUM(A.MONTH_SALE),0,100,ROUND(SUM(A.MONTH_MARGIN)/SUM(A.MONTH_SALE)*100,1)) \n");
				sbSql.append("     - DECODE(SUM(A.MONTH_PLAN),0,100,ROUND(SUM(A.MONTH_PLAN_MARGIN)/SUM(A.MONTH_PLAN)*100,1)) AS MONTH_DIFF \n");
				sbSql.append("     , DECODE(SUM(A.PRE_MONTH_SALE),0,100,ROUND(SUM(A.PRE_MONTH_MARGIN)/SUM(A.PRE_MONTH_SALE)*100,1)) AS PRE_MONTH_SALE \n");
				sbSql.append("     , DECODE(SUM(A.MONTH_SALE),0,100,ROUND(SUM(A.MONTH_MARGIN)/SUM(A.MONTH_SALE)*100,1)) \n");
				sbSql.append("     - DECODE(SUM(A.PRE_MONTH_SALE),0,100,ROUND(SUM(A.PRE_MONTH_MARGIN)/SUM(A.PRE_MONTH_SALE)*100,1)) AS PRE_MONTH_RATE \n");
				sbSql.append("     , DECODE(SUM(A.MONTH_SALE),0,100,ROUND(SUM(A.MONTH_MARGIN)/SUM(A.MONTH_SALE)*100,1)) \n");
				sbSql.append("     - DECODE(SUM(A.PRE_MONTH_SALE),0,100,ROUND(SUM(A.PRE_MONTH_MARGIN)/SUM(A.PRE_MONTH_SALE)*100,1)) AS PRE_MONTH_DIFF \n");
				sbSql.append("     , DECODE(SUM(A.YEAR_PLAN),0,100,ROUND(SUM(A.YEAR_PLAN_MARGIN)/SUM(A.YEAR_PLAN)*100,1)) AS YEAR_PLAN \n");
				sbSql.append("     , DECODE(SUM(A.YEAR_SALE),0,100,ROUND(SUM(A.YEAR_MARGIN)/SUM(A.YEAR_SALE)*100,1)) AS YEAR_SALE \n");
				sbSql.append("     , DECODE(SUM(A.YEAR_SALE),0,100,ROUND(SUM(A.YEAR_MARGIN)/SUM(A.YEAR_SALE)*100,1)) \n");
				sbSql.append("     - DECODE(SUM(A.YEAR_PLAN),0,100,ROUND(SUM(A.YEAR_PLAN_MARGIN)/SUM(A.YEAR_PLAN)*100,1)) AS YEAR_RATE \n");
				sbSql.append("     , DECODE(SUM(A.YEAR_SALE),0,100,ROUND(SUM(A.YEAR_MARGIN)/SUM(A.YEAR_SALE)*100,1)) \n");
				sbSql.append("     - DECODE(SUM(A.YEAR_PLAN),0,100,ROUND(SUM(A.YEAR_PLAN_MARGIN)/SUM(A.YEAR_PLAN)*100,1)) AS YEAR_DIFF \n");
				sbSql.append("     , DECODE(SUM(A.PRE_YEAR_SALE),0,100,ROUND(SUM(A.PRE_YEAR_MARGIN)/SUM(A.PRE_YEAR_SALE)*100,1)) AS PRE_YEAR_SALE \n");
				sbSql.append("     , DECODE(SUM(A.YEAR_SALE),0,100,ROUND(SUM(A.YEAR_MARGIN)/SUM(A.YEAR_SALE)*100,1)) \n");
				sbSql.append("     - DECODE(SUM(A.PRE_YEAR_SALE),0,100,ROUND(SUM(A.PRE_YEAR_MARGIN)/SUM(A.PRE_YEAR_SALE)*100,1)) AS PRE_YEAR_RATE \n");
				sbSql.append("     , DECODE(SUM(A.YEAR_SALE),0,100,ROUND(SUM(A.YEAR_MARGIN)/SUM(A.YEAR_SALE)*100,1)) \n");
				sbSql.append("     - DECODE(SUM(A.PRE_YEAR_SALE),0,100,ROUND(SUM(A.PRE_YEAR_MARGIN)/SUM(A.PRE_YEAR_SALE)*100,1)) AS PRE_YEAR_DIFF \n");
		        sbSql.append("  FROM A  \n");
		        sbSql.append("  WHERE TEAM_CODE IS NOT NULL \n");
		        sbSql.append(" GROUP BY ROLLUP((A.TEAM_SEQ, A.TEAM_CODE), (A.PART_SEQ, A.PART_CODE)) \n");
//		        sbSql.append(" ORDER BY A.TEAM_CODE NULLS FIRST, A.PART_CODE NULLS FIRST \n");
		        sbSql.append(" ORDER BY A.TEAM_SEQ NULLS FIRST, A.PART_SEQ NULLS FIRST \n");
			}

			sbSqlRtn.append(sbSql.toString() + "\n\n");
			pstmt = conn.prepareStatement(sbSql.toString());
			rs = pstmt.executeQuery();
			//ds_List = this.makeDataSet(rs, "ds_List");
			out_dl.add(this.makeDataSet(rs, "ds_List"+iCnt));
			rs.close();
			pstmt.close();
		}
out_vl.add("fa_Sql", sbSqlRtn.toString());

		/**종료**/
		//out_dl.add("ds_List", ds_List);
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