<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 구매관리/도시락
■ 프로그램ID   : FSP00050V_T001.jsp
■ 프로그램명   : 도시락 주문현황
■ 작성일자     : 2012-09-10
■ 작성자       : 박은규
■ 이력관리     : 2012-09-10 박은규 최초작성 CH201209_00102 FS기획팀
               2013-07-05 김동표 수정 CH201209_00102 연회웨딩팀 이일용
                                    도시락메뉴수 A,B -> A,B,C,D,E로 확대
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

		//out 데이타
		DataSet ds_List, ds_List2;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		//변수생성
		String strMonth = nullToBlank(ds_Cond.getString(0, "ORDER_DATE")).substring(0,6) + "01";

		//1)팀별 내역조회
		sbSql.append("WITH A AS \n");
		sbSql.append("( \n");
		sbSql.append("SELECT A.CC_CD, A.CC_NM \n");
		sbSql.append("     , A.QTY_SABUN \n");
		sbSql.append("     , B.WEEK \n");
		sbSql.append("     , B.ORDER_DATE_F, B.ORDER_DATE_T \n");
		sbSql.append("  FROM (SELECT A.CC_CD, A.CC_NM \n");
		sbSql.append("             , COUNT(A.SABUN) AS QTY_SABUN \n");
		sbSql.append("          FROM SCO_FS_HR_PERSONAL_V A, HLDC_SC_DEPT B \n");
		sbSql.append("         WHERE A.DEPT_ID = B.DEPT_ID \n");
		sbSql.append("           AND A.PER_DTD IS NULL \n");
		if (! nullToBlank(ds_Cond.getString(0, "SC_CD")).equals(""))
			sbSql.append("           AND A.SC_CD = '" + nullToBlank(ds_Cond.getString(0, "SC_CD")) + "'\n");
		if (! nullToBlank(ds_Cond.getString(0, "CC_CD")).equals(""))
			sbSql.append("           AND A.CC_CD = '" + nullToBlank(ds_Cond.getString(0, "CC_CD")) + "'\n");
		sbSql.append("           AND B.EXP_CD = 'N' \n");
		//주문이 있는 팀만 인원산정
		sbSql.append("           AND EXISTS (SELECT 1 FROM FMP_LUNCH Z \n");
		sbSql.append("                        WHERE Z.DEPT_ID = B.DEPT_ID \n");
		sbSql.append("                          AND Z.ORDER_DATE BETWEEN '" + nullToBlank(ds_Cond.getString(0, "ORDER_DATE")).substring(0,6) + "01" + "' \n");
		sbSql.append("                                               AND '" + nullToBlank(ds_Cond.getString(0, "ORDER_DATE")).substring(0,6) + "31" + "' \n");
		sbSql.append("                      )\n");
		sbSql.append("         GROUP BY A.CC_CD, A.CC_NM \n");
		sbSql.append("       ) A \n");
		sbSql.append("     , (SELECT 0 AS WEEK \n");
		sbSql.append("             , TO_CHAR(NEXT_DAY(TO_DATE('" + nullToBlank(ds_Cond.getString(0, "ORDER_DATE")) + "','YYYYMMDD')-7,1)+(LEVEL),'YYYYMMDD') AS ORDER_DATE_F \n");
		sbSql.append("             , TO_CHAR(NEXT_DAY(TO_DATE('" + nullToBlank(ds_Cond.getString(0, "ORDER_DATE")) + "','YYYYMMDD')-7,1)+(LEVEL),'YYYYMMDD') AS ORDER_DATE_T \n");
		sbSql.append("          FROM DUAL CONNECT BY LEVEL <= 5 \n");
		sbSql.append("         UNION ALL \n");
		sbSql.append("        SELECT LEVEL AS WEEK \n");
		sbSql.append("             , GREATEST('" + strMonth + "', TO_CHAR(NEXT_DAY(TO_DATE('" + strMonth + "','YYYYMMDD')+((LEVEL-1)*7)-7,2),'YYYYMMDD')) AS ORDER_DATE_F \n");
		sbSql.append("             , LEAST(TO_CHAR(LAST_DAY(TO_DATE('" + strMonth + "','YYYYMMDD')),'YYYYMMDD'), TO_CHAR(NEXT_DAY(TO_DATE('" + strMonth + "','YYYYMMDD')+((LEVEL-1)*7)-7,1)+7,'YYYYMMDD')) AS ORDER_DATE_T \n");
		sbSql.append("          FROM DUAL CONNECT BY LEVEL <= 5 \n");
		sbSql.append("         UNION ALL \n");
		sbSql.append("        SELECT 999 AS WEEK \n");
		sbSql.append("             , '" + nullToBlank(ds_Cond.getString(0, "ORDER_DATE")).substring(0,6) + "01" + "' AS ORDER_DATE_F \n");
		sbSql.append("             , '" + nullToBlank(ds_Cond.getString(0, "ORDER_DATE")).substring(0,6) + "31" + "' AS ORDER_DATE_T \n");
		sbSql.append("          FROM DUAL \n");
		sbSql.append("       ) B \n");
		sbSql.append(") \n");
		sbSql.append("SELECT A.CC_CD, A.CC_NM \n");
		sbSql.append("     , A.QTY_SABUN \n");
		sbSql.append("     , CASE \n");
		sbSql.append("         WHEN A.WEEK = 0 THEN TO_CHAR(TO_DATE(A.ORDER_DATE_F,'YYYYMMDD'),'MM/DD(DY)','nls_date_language=korean') \n");
		sbSql.append("         WHEN A.WEEK = 999 THEN '누계' \n");
		sbSql.append("         ELSE TO_CHAR(A.WEEK)||'주차' \n");
		sbSql.append("       END AS ORDER_DATE_DISP \n");
		sbSql.append("     , A.ORDER_DATE_F AS ORDER_DATE \n");
		sbSql.append("     , NVL(SUM(B.QTY_A),0) AS QTY_A \n");
		sbSql.append("     , NVL(SUM(B.QTY_B),0) AS QTY_B \n");
		
		sbSql.append("     , NVL(SUM(B.QTY_C),0) AS QTY_C \n");
		
		sbSql.append("     , NVL(SUM(B.QTY_D),0) AS QTY_D \n");
		
		sbSql.append("     , NVL(SUM(B.QTY_E),0) AS QTY_E \n");
		sbSql.append("     , SUM(NVL(B.QTY_A,0) + NVL(B.QTY_B,0) + NVL(B.QTY_C,0) + NVL(B.QTY_D,0) + NVL(B.QTY_E,0)) AS QTY_SUM \n");
		sbSql.append("  FROM A \n");
		sbSql.append("     , (SELECT Y.CC_CD, X.* \n");
		sbSql.append("          FROM FMP_LUNCH X, HLDC_SC_DEPT Y \n");
		sbSql.append("         WHERE X.DEPT_ID = Y.DEPT_ID \n");
		sbSql.append("       ) B \n");
		sbSql.append(" WHERE B.ORDER_DATE(+) BETWEEN A.ORDER_DATE_F AND A.ORDER_DATE_T \n");
		sbSql.append("   AND A.CC_CD = B.CC_CD(+) \n");
		sbSql.append(" GROUP BY A.CC_CD, A.CC_NM, A.QTY_SABUN, A.WEEK, A.ORDER_DATE_F \n");
		
out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_List = this.makeDataSet(rs, "ds_List");

		pstmt.close();
		rs.close();

		//2)사업부별 내역조회
		sbSql.delete(0, sbSql.length());
		sbSql.append("WITH A AS \n");
		sbSql.append("( \n");
		sbSql.append("SELECT A.SC_CD, A.SC_NM \n");
		sbSql.append("     , A.QTY_SABUN \n");
		sbSql.append("     , B.WEEK \n");
		sbSql.append("     , B.ORDER_DATE_F, B.ORDER_DATE_T \n");
		sbSql.append("  FROM (SELECT A.SC_CD, A.SC_NM \n");
		sbSql.append("             , COUNT(A.SABUN) AS QTY_SABUN \n");
		sbSql.append("          FROM SCO_FS_HR_PERSONAL_V A, HLDC_SC_DEPT B \n");
		sbSql.append("         WHERE A.DEPT_ID = B.DEPT_ID \n");
		sbSql.append("           AND A.PER_DTD IS NULL \n");
		if (! nullToBlank(ds_Cond.getString(0, "SC_CD")).equals(""))
			sbSql.append("           AND A.SC_CD = '" + nullToBlank(ds_Cond.getString(0, "SC_CD")) + "'\n");
		if (! nullToBlank(ds_Cond.getString(0, "CC_CD")).equals(""))
			sbSql.append("           AND A.CC_CD = '" + nullToBlank(ds_Cond.getString(0, "CC_CD")) + "'\n");
		sbSql.append("           AND B.EXP_CD = 'N' \n");
		//주문이 있는 팀만 인원산정
		sbSql.append("           AND EXISTS (SELECT 1 FROM FMP_LUNCH Z \n");
		sbSql.append("                        WHERE Z.DEPT_ID = B.DEPT_ID \n");
		sbSql.append("                          AND Z.ORDER_DATE BETWEEN '" + nullToBlank(ds_Cond.getString(0, "ORDER_DATE")).substring(0,6) + "01" + "' \n");
		sbSql.append("                                               AND '" + nullToBlank(ds_Cond.getString(0, "ORDER_DATE")).substring(0,6) + "31" + "' \n");
		sbSql.append("                      )\n");
		sbSql.append("         GROUP BY A.SC_CD, A.SC_NM \n");
		sbSql.append("       ) A \n");
		sbSql.append("     , (SELECT 0 AS WEEK \n");
		sbSql.append("             , TO_CHAR(NEXT_DAY(TO_DATE('" + nullToBlank(ds_Cond.getString(0, "ORDER_DATE")) + "','YYYYMMDD')-7,1)+(LEVEL),'YYYYMMDD') AS ORDER_DATE_F \n");
		sbSql.append("             , TO_CHAR(NEXT_DAY(TO_DATE('" + nullToBlank(ds_Cond.getString(0, "ORDER_DATE")) + "','YYYYMMDD')-7,1)+(LEVEL),'YYYYMMDD') AS ORDER_DATE_T \n");
		sbSql.append("          FROM DUAL CONNECT BY LEVEL <= 5 \n");
		sbSql.append("         UNION ALL \n");
		sbSql.append("        SELECT LEVEL AS WEEK \n");
		sbSql.append("             , GREATEST('" + strMonth + "', TO_CHAR(NEXT_DAY(TO_DATE('" + strMonth + "','YYYYMMDD')+((LEVEL-1)*7)-7,2),'YYYYMMDD')) AS ORDER_DATE_F \n");
		sbSql.append("             , LEAST(TO_CHAR(LAST_DAY(TO_DATE('" + strMonth + "','YYYYMMDD')),'YYYYMMDD'), TO_CHAR(NEXT_DAY(TO_DATE('" + strMonth + "','YYYYMMDD')+((LEVEL-1)*7)-7,1)+7,'YYYYMMDD')) AS ORDER_DATE_T \n");
		sbSql.append("          FROM DUAL CONNECT BY LEVEL <= 5 \n");
		sbSql.append("         UNION ALL \n");
		sbSql.append("        SELECT 999 AS WEEK \n");
		sbSql.append("             , '" + nullToBlank(ds_Cond.getString(0, "ORDER_DATE")).substring(0,6) + "01" + "' AS ORDER_DATE_F \n");
		sbSql.append("             , '" + nullToBlank(ds_Cond.getString(0, "ORDER_DATE")).substring(0,6) + "31" + "' AS ORDER_DATE_T \n");
		sbSql.append("          FROM DUAL \n");
		sbSql.append("       ) B \n");
		sbSql.append(") \n");
		sbSql.append("SELECT A.SC_CD, A.SC_NM \n");
		sbSql.append("     , A.QTY_SABUN \n");
		sbSql.append("     , CASE \n");
		sbSql.append("         WHEN A.WEEK = 0 THEN TO_CHAR(TO_DATE(A.ORDER_DATE_F,'YYYYMMDD'),'MM/DD(DY)','nls_date_language=korean') \n");
		sbSql.append("         WHEN A.WEEK = 999 THEN '누계' \n");
		sbSql.append("         ELSE TO_CHAR(A.WEEK)||'주차' \n");
		sbSql.append("       END AS ORDER_DATE_DISP \n");
		sbSql.append("     , A.ORDER_DATE_F AS ORDER_DATE \n");
		sbSql.append("     , NVL(SUM(B.QTY_A),0) AS QTY_A \n");
		sbSql.append("     , NVL(SUM(B.QTY_B),0) AS QTY_B \n");
		
		sbSql.append("     , NVL(SUM(B.QTY_C),0) AS QTY_C \n");
		
		sbSql.append("     , NVL(SUM(B.QTY_D),0) AS QTY_D \n");
		
		sbSql.append("     , NVL(SUM(B.QTY_E),0) AS QTY_E \n");
		sbSql.append("     , SUM(NVL(B.QTY_A,0) + NVL(B.QTY_B,0) + NVL(B.QTY_C,0) + NVL(B.QTY_D,0) + NVL(B.QTY_E,0)) AS QTY_SUM \n");
		sbSql.append("  FROM A \n");
		sbSql.append("     , (SELECT Y.SC_CD, X.* \n");
		sbSql.append("          FROM FMP_LUNCH X, HLDC_SC_DEPT Y \n");
		sbSql.append("         WHERE X.DEPT_ID = Y.DEPT_ID \n");
		sbSql.append("       ) B \n");
		sbSql.append(" WHERE B.ORDER_DATE(+) BETWEEN A.ORDER_DATE_F AND A.ORDER_DATE_T \n");
		sbSql.append("   AND A.SC_CD = B.SC_CD(+) \n");
		sbSql.append(" GROUP BY A.SC_CD, A.SC_NM, A.QTY_SABUN, A.WEEK, A.ORDER_DATE_F \n");
		
out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_List2 = this.makeDataSet(rs, "ds_List2");

		pstmt.close();
		rs.close();

		/**종료**/
		out_dl.add(ds_List);
		out_dl.add(ds_List2);
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