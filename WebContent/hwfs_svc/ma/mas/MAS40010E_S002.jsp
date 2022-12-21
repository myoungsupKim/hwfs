<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 경영관리/손익실적
■ 프로그램ID   : MAS40010E_S002.jsp
■ 프로그램명   : 월별손익계획관리
■ 작성일자     : 2013-12-11
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
		String g_AuthLevel  = nullToBlank(in_vl.getString("g_AuthLevel"));
		
		//FileLog.println("d:\\aaa.txt", ds_Cond);

		//out 데이타
		DataSet ds_List;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		//if(ds_Cond.getString(0, "DOC_GUBUN").equals("U")){
		sbSql.append("SELECT /*+ INDEX(B100 MAS_DAILY_PL_REPORT_PK) */                               \n");
        sbSql.append("       A100.P_MGMT_ACCT_CD,                                                     \n");
        sbSql.append("       A100.MGMT_ACCT_CD,                                                       \n");
        sbSql.append("       A100.MGMT_ACCT_NAME,                                                     \n");
        sbSql.append("       A100.INPUT_YN,                                                           \n");
        sbSql.append("       TO_CHAR(TO_DATE(A100.P_DATE, 'YYYYMMDD'), 'YYYY-MM-DD') P_DATE,         \n");
        sbSql.append("       NVL(B100.ACT_AMT, 0) ACT_AMT,                                             \n");
        sbSql.append("       B100.CONFIRM_YN, 										                 \n");
        sbSql.append("       NVL(C100.CLOSE_YN, 'N') CLOSE_YN,                                         \n");
        sbSql.append("       '" + g_AuthLevel + "' AUTH_LEVEL                                         \n");
        sbSql.append("  FROM (                                                                        \n");
        sbSql.append("        SELECT A10.P_MGMT_ACCT_CD                                               \n");
        sbSql.append("             , A10.MGMT_ACCT_CD                                                 \n");
        sbSql.append("             , A10.MGMT_ACCT_NAME                                               \n");
        sbSql.append("             , A10.ACCT_LEVEL                                                   \n");
        sbSql.append("             , A10.ACCT_TYPE                                                    \n");
        sbSql.append("             , A10.INPUT_YN                                                     \n");
        sbSql.append("             , B10.P_DATE                                                       \n");
        sbSql.append("          FROM (                                                                \n");
        sbSql.append("                SELECT CASE WHEN ACCT_LEVEL = 3 THEN                            \n");
        sbSql.append("                                SUBSTR(A.MGMT_ACCT_CD, 1, 4) || '0000'          \n");
        sbSql.append("                            WHEN ACCT_LEVEL = 2 THEN                            \n");
        sbSql.append("                                SUBSTR(A.MGMT_ACCT_CD, 1, 3) || '00000'         \n");
        sbSql.append("                            ELSE                                                \n");
        sbSql.append("                                A.MGMT_ACCT_CD                                  \n");
        sbSql.append("                       END P_MGMT_ACCT_CD                                       \n");
        sbSql.append("                     , A.MGMT_ACCT_CD AS MGMT_ACCT_CD                           \n");
        sbSql.append("                 	 , A.MGMT_ACCT_NAME AS MGMT_ACCT_NAME                         \n");
        sbSql.append("                	 , A.PC_CLASS AS PC_CLASS                                      \n");
        sbSql.append("                	 , A.ACCT_LEVEL AS ACCT_LEVEL                                  \n");
        sbSql.append("                	 , A.ACCT_TYPE                                                 \n");
        sbSql.append("                	 , A.ATTR01 AS INPUT_YN                                        \n");
        sbSql.append("                  FROM MAC_MGMT_ACCT       A                                    \n");
        sbSql.append("                 WHERE 1=1                                                      \n");
        sbSql.append("                   AND A.ACCT_TYPE = 'WP'                                       \n");
        sbSql.append("                   AND A.USE_YN = 'Y'                                           \n");
        sbSql.append("               ) A10,                                                           \n");
        sbSql.append("               (                                                                \n");
        sbSql.append("                SELECT P_DATE                                                   \n");
        sbSql.append("                  FROM (                                                        \n");
        sbSql.append("                        -- 가상테이블                                                                                          \n");
        sbSql.append("                        SELECT TO_CHAR(TO_DATE('" + ds_Cond.getString(0, "INPUT_YM") + "'||'01', 'YYYYMMDD')+LEVEL-1,'YYYYMMDD') P_DATE \n");
        sbSql.append("                          FROM DUAL                                             \n");
        sbSql.append("                         WHERE 1=1                                              \n");
        sbSql.append("                         CONNECT BY LEVEL-1 <= 365*10                           \n");
        sbSql.append("                        )                                                       \n");
        sbSql.append("                 WHERE P_DATE BETWEEN '" + ds_Cond.getString(0, "INPUT_YM") + "'||'01' AND '" + ds_Cond.getString(0, "INPUT_YM") + "'||'31'         \n");
        sbSql.append("               ) B10                                                            \n");
        sbSql.append("       ) A100,                                                                  \n");
        sbSql.append("       MAS_DAILY_PL_REPORT B100,                                                \n");
        sbSql.append("       MAS_MONTHLY_CLOSE     C100                                                 \n");
        sbSql.append(" WHERE 1=1                                                                      \n");
        sbSql.append("   AND A100.MGMT_ACCT_CD = B100.MGMT_ACCT_CD(+)                                 \n");
        sbSql.append("   AND A100.P_DATE = B100.INPUT_DD(+)                                           \n");
        sbSql.append("   AND B100.INPUT_YM = C100.INPUT_YM(+)                                           \n");
        sbSql.append("   AND B100.DOC_CD = C100.DOC_CD(+)                                         \n");
        sbSql.append("   AND B100.INPUT_YM(+) = '" + ds_Cond.getString(0, "INPUT_YM") + "'    \n");
        sbSql.append("   AND B100.DOC_CD(+) = '" + ds_Cond.getString(0, "DOC_CD") + "'        \n");
        sbSql.append("   AND B100.DOC_GUBUN(+) = 'P' /* 계획 */       \n");
        sbSql.append(" ORDER BY A100.P_DATE, A100.MGMT_ACCT_CD                                        \n");
		

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