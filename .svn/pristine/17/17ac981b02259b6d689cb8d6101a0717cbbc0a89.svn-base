<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 경영관리/손익실적
■ 프로그램ID   : MAS40010E_S001.jsp
■ 프로그램명   : 월손익계획관리
■ 작성일자     : 2013-12-10
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
		
//System.out.println(ds_Cond.getString(0, "INPUT_YM") + "<<<-------------------------------------");
//System.out.println(ds_Cond.getString(1, "INPUT_YM") + "<<<-------------------------------------");
//System.out.println(ds_Cond.getString(2, "INPUT_YM") + "<<<-------------------------------------");
		
		//입력 파라메터
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		
		//FileLog.println("d:\\aaa.txt", ds_Cond);

		//out 데이타
		DataSet ds_List;
		
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		sbSql.append("        SELECT A10.MGMT_ACCT_CD                                                 \n");
        sbSql.append("             , A10.MGMT_ACCT_NAME                                               \n");
        sbSql.append("             , A10.ACCT_LEVEL                                                   \n");
        sbSql.append("             , A10.ACCT_TYPE                                                    \n");
        sbSql.append("             , B10.P_DATE                                                       \n");
        sbSql.append("             , 0 ACT_AMT                                                        \n");
        sbSql.append("             , A10.INPUT_YN                                                     \n");
        sbSql.append("          FROM (                                                                \n");
        sbSql.append("                SELECT A.MGMT_ACCT_CD AS MGMT_ACCT_CD                           \n");
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
        sbSql.append("                SELECT TO_CHAR(TO_DATE(P_DATE, 'YYYY-MM-DD'), 'YYYY-MM-DD') AS P_DATE  \n");
        sbSql.append("                  FROM (                                                        \n");
        sbSql.append("                        -- 가상테이블                                           \n");
        sbSql.append("                        SELECT TO_CHAR(TO_DATE('" + ds_Cond.getString(0, "INPUT_YM") + "'||'01', 'YYYYMMDD')+LEVEL-1,'YYYYMMDD') P_DATE \n");
        sbSql.append("                          FROM DUAL                                             \n");
        sbSql.append("                         WHERE 1=1                                              \n");
        sbSql.append("                         CONNECT BY LEVEL-1 <= 365*10                           \n");
        sbSql.append("                        )                                                       \n");
        sbSql.append("                 WHERE P_DATE BETWEEN '" + ds_Cond.getString(0, "INPUT_YM") + "'||'01' AND '" + ds_Cond.getString(0, "INPUT_YM") + "'||'31'         \n");
        sbSql.append("               ) B10                                                            \n");
        sbSql.append("         ORDER BY B10.P_DATE, A10.MGMT_ACCT_CD                                \n");

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