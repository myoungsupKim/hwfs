<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/매출통계
■ 프로그램ID   : MAO00010E_T001.jsp
■ 프로그램명   : 영업일 등록관리(조회)
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

		//입력 데이타
		DataSet ds_Cond     = in_dl.get("ds_Cond");
		//입력 파라메터
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		//FileLog.println("d:\\aaa.txt", ds_Cond);

		//out 데이타
		DataSet ds_List;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		//내역조회
		sbSql.append(" /*  MAO00010E_T001.jsp    */ \n");
		sbSql.append(" SELECT  NVL(B.TEAM_CODE,'" + nullToBlank(ds_Cond.getString(0, "TEAM_CODE")) + "') TEAM_CODE 	\n");
		sbSql.append("  , NVL((SELECT DISTINCT TM_NM FROM HLDC_SC_TM WHERE TM_CD = B.TEAM_CODE),'" + nullToBlank(ds_Cond.getString(0, "TEAM_NAME")) + "') TEAM_NAME	 \n");
		sbSql.append("  , A.RDATE AS CTRL_DATE	 \n");
		sbSql.append("  , A.YYYYMM	 \n");
		sbSql.append("  , A.DD_DAYS 	 \n");
		sbSql.append("  , TO_CHAR(TO_DATE(A.RDATE,'YYYYMMDD'),'DY', 'NLS_DATE_LANGUAGE=KOREAN') AS WEEK   \n");
		sbSql.append("  , B.BIZDAYS \n");
		sbSql.append("  , B.CONTENTS \n");
		sbSql.append("  , '' HUDAY \n");
		sbSql.append("  , TO_CHAR(LAST_DAY(TO_DATE('" + nullToBlank(ds_Cond.getString(0, "YYYYMM")) + "'||'01','YYYYMMDD')),'DD') LASTDAY \n");
		sbSql.append(" FROM (SELECT '" + nullToBlank(ds_Cond.getString(0, "YYYYMM")) + "' YYYYMM  \n");
		sbSql.append("           ,TRIM(TO_CHAR(ROWNUM,'00')) AS DD_DAYS \n");
		sbSql.append("           ,'" + nullToBlank(ds_Cond.getString(0, "YYYYMM")) + "'||TRIM(TO_CHAR(ROWNUM,'00')) AS RDATE  \n");
		sbSql.append("       FROM DICT  \n");
		sbSql.append("      WHERE ROWNUM <= TO_CHAR(LAST_DAY(TO_DATE('" + nullToBlank(ds_Cond.getString(0, "YYYYMM")) + "'||'01','YYYYMMDD')),'DD')) A  \n");
		sbSql.append("  , (SELECT * FROM FMB_BIZDAY A WHERE YYYYMM LIKE '" + nullToBlank(ds_Cond.getString(0, "YYYYMM")) + "'||'%' AND A.TEAM_CODE = '" + nullToBlank(ds_Cond.getString(0, "TEAM_CODE")) + "' ) B  \n"); 
		sbSql.append(" WHERE A.YYYYMM = B.YYYYMM(+) \n");
		sbSql.append("   AND A.DD_DAYS = B.DD_DAYS(+)  \n");
		
		sbSql.append(" ORDER BY A.RDATE   \n");
		/*
		sbSql.append(" SELECT A.YYYYMM \n");
		sbSql.append("     , A.TEAM_CODE \n");
		sbSql.append("     , A.TEAM_NAME \n");
		sbSql.append("     , NVL(B.BIZDAYS,0) AS BIZDAYS \n");
		sbSql.append("     , B.CONTENTS \n");
		sbSql.append("     , TO_CHAR(LAST_DAY(TO_DATE(A.YYYYMM,'YYYYMM')),'DD') AS LASTDAY \n");
		sbSql.append("     , WEEKDAYS");
		sbSql.append("     , SATURDAY");
		sbSql.append("     , SUNDAY ");
		sbSql.append("  FROM FMB_BIZDAY B \n");
		sbSql.append("     , (SELECT '" + nullToBlank(ds_Cond.getString(0, "YYYY")) + "'||B.MM AS YYYYMM \n");
		sbSql.append("             , A.TM_CD       AS TEAM_CODE  \n");
		sbSql.append("             , A.TM_NM  AS TEAM_NAME  \n");
		sbSql.append("          FROM HLDC_SC_TM A  \n");
		sbSql.append("             , (SELECT LPAD(ROWNUM,2,'0') AS MM FROM DICT WHERE ROWNUM <= 12) B \n");
		sbSql.append("         WHERE A.MU_CD = '2004' \n");
		if (! nullToBlank(ds_Cond.getString(0, "TEAM_CODE")).equals(""))
			sbSql.append("           AND A.TM_CD = '" + nullToBlank(ds_Cond.getString(0, "TEAM_CODE")) + "' \n");
		sbSql.append("           AND A.USE_YN = 'Y' \n");
		sbSql.append("       ) A \n");
		sbSql.append(" WHERE A.YYYYMM = B.YYYYMM(+) \n");
		sbSql.append("   AND A.TEAM_CODE = B.TEAM_CODE(+) \n");
//		sbSql.append(" ORDER BY A.YYYYMM, A.TEAM_CODE \n");
		sbSql.append(" ORDER BY A.YYYYMM \n");
		*/
		out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
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
