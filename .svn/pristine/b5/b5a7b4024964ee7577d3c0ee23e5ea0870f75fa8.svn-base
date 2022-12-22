<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/매출통계
■ 프로그램ID   : MAO00050V_T001.jsp
■ 프로그램명   : 일매출보고
■ 작성일자     : 2012.02.01
■ 작성자       : 박은규
■ 이력관리     : 2012.02.01
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
		
		//변수
		String strSDay, strPreSDay,strEDay, strPreEDay;
		strSDay = nullToBlank(ds_Cond.getString(0, "SDATE"));
		strEDay = nullToBlank(ds_Cond.getString(0, "EDATE"));
		//out 데이타
		DataSet ds_List;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		//요일 구하기
		sbSql.delete(0, sbSql.length());
		sbSql.append("SELECT TO_CHAR(TO_DATE('" + nullToBlank(ds_Cond.getString(0, "SDATE")) + "','YYYYMMDD'),'YYYY-MM-DD') AS SDATE \n");
		sbSql.append("     , TO_CHAR(TO_DATE('" + nullToBlank(ds_Cond.getString(0, "SDATE")) + "','YYYYMMDD'),'YYYY-MM-DD') AS EDATE \n");
		sbSql.append("     , TO_CHAR(TO_DATE('" + nullToBlank(ds_Cond.getString(0, "SDATE")) + "','YYYYMMDD'),'DY','NLS_DATE_LANGUAGE=KOREAN') AS SWEEK \n");
		sbSql.append("     , TO_CHAR(TO_DATE('" + nullToBlank(ds_Cond.getString(0, "SDATE")) + "','YYYYMMDD'),'DY','NLS_DATE_LANGUAGE=KOREAN') AS EWEEK \n");
		sbSql.append("  FROM DUAL \n");
		out_vl.add("fa_Sql", sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery();
		if (! rs.next())
		{
			this.setResultMessage(-1, "요일 조회오류!", out_vl);
			//throw new Exception();
			proc_output(response,out,out_vl,out_dl);
			return;			
		}
		out_vl.add("fa_PreDay", rs.getString("SDATE")+'(' + rs.getString("SWEEK") + ')' + " ~ " + rs.getString("EDATE")+'(' + rs.getString("EWEEK") + ')');
		rs.close();
		pstmt.close();
		
		//내역조회
		sbSql.delete(0, sbSql.length());
		sbSql.append("WITH A AS \n");
		sbSql.append("( \n");
		//팀-파트-사원(매출계획기준) 정보
		sbSql.append("SELECT B.TEAM_CODE \n");
		sbSql.append("     , (SELECT TM_SEQ FROM (SELECT ROWNUM TM_SEQ,TM_CD FROM HLDC_SC_TM  WHERE MU_CD = '2004' AND USE_YN = 'Y' ORDER BY MU_CD,TM_CD) WHERE TM_CD = B.TEAM_CODE) AS TEAM_SEQ \n");
		sbSql.append("     , A.CODE AS PART_CODE \n");
		sbSql.append("     , A.SORT_SEQ AS PART_SEQ \n");
		sbSql.append("     , B.SABUN \n");
		sbSql.append("     , 0 AS DAY_PLAN \n");
		sbSql.append("     , 0 AS DAY_PLAN_MARGIN \n");
		sbSql.append("     , 0 AS DAY_SALE \n");
		sbSql.append("     , 0 AS DAY_MARGIN \n");
		sbSql.append("     , 0 AS MONTH_PLAN \n");
		sbSql.append("     , 0 AS MONTH_PLAN_MARGIN \n");
		sbSql.append("     , 0 AS MONTH_SALE \n");
		sbSql.append("     , 0 AS MONTH_MARGIN \n");
		sbSql.append("  FROM SCC_COMMON_CODE A, FMB_SALE_PLAN B \n");
		sbSql.append(" WHERE A.CODE = B.PART_CODE \n");
		sbSql.append("   AND A.GROUP_CODE = 'FM0022' \n");
		if (! nullToBlank(ds_Cond.getString(0, "TEAM_CODE")).equals(""))
			sbSql.append("   AND A.SET1 = '" + nullToBlank(ds_Cond.getString(0, "TEAM_CODE")) + "' \n");
		sbSql.append("----------- \n");
		sbSql.append(" UNION ALL \n");
		sbSql.append("----------- \n");
		//매출계획
		sbSql.append("SELECT A.TEAM_CODE \n");
		sbSql.append("     , (SELECT TM_SEQ FROM (SELECT ROWNUM TM_SEQ,TM_CD FROM HLDC_SC_TM  WHERE MU_CD = '2004' AND USE_YN = 'Y' ORDER BY MU_CD,TM_CD) WHERE TM_CD = A.TEAM_CODE) AS TEAM_SEQ \n");
		sbSql.append("     , A.PART_CODE \n");
		sbSql.append("     , (SELECT Z.SORT_SEQ FROM SCC_COMMON_CODE Z WHERE Z.GROUP_CODE = 'FM0022' AND Z.CODE = A.PART_CODE) AS PART_SEQ \n");
		sbSql.append("     , A.SABUN \n");
//		sbSql.append("     , SUM(DECODE(A.YYYYMM,SUBSTR('" + strEDay + "',1,6),ROUND(A.SALE_AMOUNT/(SELECT Z.BIZDAYS FROM FMB_BIZDAY Z WHERE Z.YYYYMM = A.YYYYMM AND Z.TEAM_CODE = A.TEAM_CODE)),0)) AS DAY_PLAN \n");
//		sbSql.append("     , SUM(DECODE(A.YYYYMM,SUBSTR('" + strEDay + "',1,6),ROUND(A.MARGIN_AMOUNT/(SELECT Z.BIZDAYS FROM FMB_BIZDAY Z WHERE Z.YYYYMM = A.YYYYMM AND Z.TEAM_CODE = A.TEAM_CODE)),0)) AS DAY_PLAN_MARGIN \n");
//		sbSql.append("     , SUM(DECODE(A.YYYYMM,SUBSTR('" + strSDay + "',1,6),ROUND(A.SALE_AMOUNT/(SELECT COUNT(*) FROM (SELECT DISTINCT A.YYYYMMDD , A.YYYYMM , A.TEAM_CODE FROM FMB_SALE_PLAN A ) Z WHERE Z.YYYYMM = A.YYYYMM AND Z.TEAM_CODE = A.TEAM_CODE)),0)) AS DAY_PLAN \n");
//		sbSql.append("     , SUM(DECODE(A.YYYYMM,SUBSTR('" + strSDay + "',1,6),ROUND(A.MARGIN_AMOUNT/(SELECT COUNT(*) FROM (SELECT DISTINCT A.YYYYMMDD , A.YYYYMM , A.TEAM_CODE FROM FMB_SALE_PLAN A ) Z WHERE Z.YYYYMM = A.YYYYMM AND Z.TEAM_CODE = A.TEAM_CODE)),0)) AS DAY_PLAN_MARGIN \n");
		sbSql.append("     , SUM(CASE WHEN A.YYYYMMDD BETWEEN SUBSTR('" + strSDay + "',1,6)||'01' AND '" + strSDay + "' THEN ROUND(A.SALE_AMOUNT/(SELECT SUM(BIZDAYS) FROM FMB_BIZDAY WHERE YYYYMM = A.YYYYMM AND TEAM_CODE = A.TEAM_CODE AND YYYYMM||DD_DAYS BETWEEN SUBSTR('" + strSDay + "',1,6)||'01' AND '" + strSDay + "'))ELSE 0 END) AS DAY_PLAN \n");
		sbSql.append("     , SUM(CASE WHEN A.YYYYMMDD BETWEEN SUBSTR('" + strSDay + "',1,6)||'01' AND '" + strSDay + "' THEN ROUND(A.MARGIN_AMOUNT/(SELECT SUM(BIZDAYS) FROM FMB_BIZDAY WHERE YYYYMM = A.YYYYMM AND TEAM_CODE = A.TEAM_CODE AND YYYYMM||DD_DAYS BETWEEN SUBSTR('" + strSDay + "',1,6)||'01' AND '" + strSDay + "'))ELSE 0 END) AS DAY_PLAN_MARGIN \n");

		sbSql.append("     , 0 AS DAY_SALE \n");
		sbSql.append("     , 0 AS DAY_MARGIN \n");
		sbSql.append("     , SUM(DECODE(A.YYYYMM,SUBSTR('" + strSDay + "',1,6),A.SALE_AMOUNT,0)) AS MONTH_PLAN \n");
		sbSql.append("     , SUM(DECODE(A.YYYYMM,SUBSTR('" + strSDay + "',1,6),A.MARGIN_AMOUNT,0)) AS MONTH_PLAN_MARGIN \n");
		sbSql.append("     , 0 AS MONTH_SALE \n");
		sbSql.append("     , 0 AS MONTH_MARGIN \n");
		sbSql.append("  FROM FMB_SALE_PLAN A \n");
		sbSql.append(" WHERE A.YYYYMM BETWEEN SUBSTR('" + strSDay + "',1,4)||'01' AND SUBSTR('" + strSDay + "',1,6) \n");
		if (! nullToBlank(ds_Cond.getString(0, "TEAM_CODE")).equals(""))
			sbSql.append("   AND A.TEAM_CODE = '" + nullToBlank(ds_Cond.getString(0, "TEAM_CODE")) + "' \n");
		sbSql.append(" GROUP BY A.TEAM_CODE, A.PART_CODE, A.SABUN \n");
		//매출실적
		sbSql.append("----------- \n");
		sbSql.append(" UNION ALL \n");
		sbSql.append("----------- \n");
		sbSql.append("SELECT A.TEAM_CODE \n");
		sbSql.append("     , (SELECT TM_SEQ FROM (SELECT ROWNUM TM_SEQ,TM_CD FROM HLDC_SC_TM  WHERE MU_CD = '2004' AND USE_YN = 'Y' ORDER BY MU_CD,TM_CD) WHERE TM_CD = A.TEAM_CODE) AS TEAM_SEQ \n");
		sbSql.append("     , A.PART_CODE \n");
		sbSql.append("     , (SELECT Z.SORT_SEQ FROM SCC_COMMON_CODE Z WHERE Z.GROUP_CODE = 'FM0022' AND Z.CODE = A.PART_CODE) AS PART_SEQ \n");
		sbSql.append("     , A.SABUN \n");
		sbSql.append("     , 0 AS DAY_PLAN \n");
		sbSql.append("     , 0 AS DAY_PLAN_MARGIN \n");
		sbSql.append("     , SUM(DECODE(A.SDATE,'" + strSDay + "',A.SALE_AMOUNT,0)) AS DAY_SALE \n");
		sbSql.append("     , SUM(DECODE(A.SDATE,'" + strSDay + "',A.SALE_AMOUNT-A.UNIT_AMOUNT,0)) AS DAY_MARGIN \n");
		sbSql.append("     , 0 AS MONTH_PLAN \n");
		sbSql.append("     , 0 AS MONTH_PLAN_MARGIN \n");
		sbSql.append("     , SUM(DECODE(SUBSTR(A.SDATE,1,6),SUBSTR('" + strSDay + "',1,6),A.SALE_AMOUNT,0)) AS MONTH_SALE \n");
		sbSql.append("     , SUM(DECODE(SUBSTR(A.SDATE,1,6),SUBSTR('" + strSDay + "',1,6),A.SALE_AMOUNT-A.UNIT_AMOUNT,0)) AS MONTH_MARGIN \n");
		sbSql.append("  FROM FMB_SALE_DATA A \n");
		sbSql.append(" WHERE A.SDATE BETWEEN SUBSTR('" + strSDay + "',1,4)||'0101' AND '" + strSDay + "' \n");
		sbSql.append("   AND A.USE_YN = 'Y' \n");
		if (! nullToBlank(ds_Cond.getString(0, "TEAM_CODE")).equals(""))
			sbSql.append("   AND A.TEAM_CODE = '" + nullToBlank(ds_Cond.getString(0, "TEAM_CODE")) + "' \n");
		sbSql.append(" GROUP BY A.TEAM_CODE, A.PART_CODE, A.SABUN \n");
		sbSql.append(") \n");
		//
		//영업사원별 매출현황
		sbSql.append("SELECT GROUPING(A.TEAM_CODE) + GROUPING(A.PART_CODE) + GROUPING(A.SABUN) AS GB \n");
		sbSql.append("     , CASE \n");
		sbSql.append("         WHEN GROUPING(A.TEAM_CODE) = 1 AND GROUPING(A.PART_CODE) = 1 AND GROUPING(A.SABUN) = 1 \n"); 
		sbSql.append("		     THEN '식재사업부' \n");
		sbSql.append("         WHEN GROUPING(A.TEAM_CODE) = 0 AND GROUPING(A.PART_CODE) = 1 AND GROUPING(A.SABUN) = 1 \n");
        sbSql.append("           THEN '  '||(SELECT TM_NM FROM HLDC_SC_TM  WHERE MU_CD = '2004' AND USE_YN = 'Y' AND TM_CD = A.TEAM_CODE)||'('||NVL((SELECT SUM(BIZDAYS) FROM FMB_BIZDAY WHERE YYYYMM = SUBSTR('" + strSDay + "',1,6) AND TEAM_CODE = A.TEAM_CODE AND YYYYMM||DD_DAYS BETWEEN SUBSTR('" + strSDay + "',1,6)||'01' AND '" + strSDay + "'),0)||')' \n");
        sbSql.append("         WHEN GROUPING(A.TEAM_CODE) = 0 AND GROUPING(A.PART_CODE) = 0 AND GROUPING(A.SABUN) = 1 \n");
		sbSql.append("           THEN '    '||(SELECT Z.CODE_NAME FROM SCC_COMMON_CODE Z WHERE Z.GROUP_CODE = 'FM0022' AND Z.CODE = A.PART_CODE) \n");
		sbSql.append("         ELSE '      '||(SELECT Z.NM_KOR FROM HLDC_HR_PERSONAL Z WHERE Z.SABUN = A.SABUN) \n");
		sbSql.append("       END AS LINE_NAME \n");
		sbSql.append("     , A.TEAM_CODE, A.PART_CODE \n");
        sbSql.append("     , NVL(ROUND(SUM(A.DAY_PLAN)),0) AS DAY_PLAN                                                                    \n");
        sbSql.append("     , NVL(ROUND(SUM(A.DAY_PLAN_MARGIN)),0) AS DAY_PLAN_MARGIN                                                      \n");
        sbSql.append("     , NVL(DECODE(SUM(A.DAY_PLAN),0,100,ROUND(SUM(A.DAY_PLAN_MARGIN)/SUM(A.DAY_PLAN)*100,1)),0) AS DAY_PLAN_RATE               \n");
        sbSql.append("     , NVL(ROUND(SUM(A.DAY_SALE)),0) AS DAY_SALE                                                                    \n");
        sbSql.append("     , NVL(ROUND(SUM(A.DAY_MARGIN )),0) AS DAY_MARGIN                                                               \n");
        sbSql.append("     , NVL(DECODE(SUM(A.DAY_SALE),0,100,ROUND(SUM(A.DAY_MARGIN)/SUM(A.DAY_SALE)*100,1)),0) AS DAY_RATE                         \n");
        sbSql.append("     , NVL(ROUND(SUM(A.MONTH_PLAN)),0) AS MONTH_PLAN                                                                \n");
        sbSql.append("     , NVL(ROUND(SUM(A.MONTH_PLAN_MARGIN)),0) AS MONTH_PLAN_MARGIN                                                  \n");
        sbSql.append("     , NVL(DECODE(SUM(A.MONTH_PLAN),0,100,ROUND(SUM(A.MONTH_PLAN_MARGIN)/SUM(A.MONTH_PLAN)*100,1)),0) AS MONTH_PLAN_RATE       \n");
        sbSql.append("     , NVL(ROUND(SUM(A.MONTH_SALE)),0) AS MONTH_SALE                                                                \n");
        sbSql.append("     , NVL(ROUND(SUM(A.MONTH_MARGIN)),0) AS MONTH_MARGIN                                                            \n");
        sbSql.append("     , NVL(DECODE(SUM(A.MONTH_SALE),0,100,ROUND(SUM(A.MONTH_MARGIN)/SUM(A.MONTH_SALE)*100,1)),0) AS MONTH_RATE                 \n");
        sbSql.append("     , NVL(DECODE(SUM(A.MONTH_PLAN),0,100,ROUND(SUM(A.MONTH_SALE)/SUM(A.MONTH_PLAN)*100,1)),0) AS SALE_DIFF                \n");
        sbSql.append("     , NVL(DECODE(SUM(A.MONTH_PLAN_MARGIN),0,100,ROUND(SUM(A.MONTH_MARGIN)/SUM(A.MONTH_PLAN_MARGIN)*100,1)),0) AS MARGIN_DIFF \n");
		sbSql.append("  FROM A  \n");
		sbSql.append("  WHERE TEAM_SEQ IS NOT NULL  \n");
		sbSql.append(" GROUP BY ROLLUP((A.TEAM_SEQ, A.TEAM_CODE), (A.PART_SEQ, A.PART_CODE), A.SABUN) \n");
		sbSql.append(" ORDER BY A.TEAM_SEQ NULLS FIRST, A.PART_SEQ NULLS FIRST, A.SABUN NULLS FIRST \n");
		out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		ds_List = this.makeDataSet(rs, "ds_List");
		rs.close();
		pstmt.close();		
		//**종료**/
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