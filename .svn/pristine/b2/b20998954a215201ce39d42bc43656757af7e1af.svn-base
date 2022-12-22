<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 영업관리/세금계산서
■ 프로그램ID   : MAS10140E_T001.jsp
■ 프로그램명   : 고객사 조회
■ 작성일자     : 2008-05-16
■ 작성자       : 박은규
■ 이력관리     : 2008-05-16
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	try	{
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();		
	
		// log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));

		//입력 데이타
		DataSet ds_cond     = in_dl.get("ds_cond");
		//입력 파라메터
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
	
		//FileLog.println("d:\\aaa.txt", ds_cond);


		//out 데이타
		DataSet ds_list;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		//내역조회
		sbSql.append("SELECT V.CUSTCD,                                                                                                                                            \n");
		sbSql.append("     DECODE(V.SAUPNO, '9999999999', '', V.CUSTNM) CUSTNM,                                                                                                   \n");
		sbSql.append("     DECODE(V.SAUPNO, '9999999999', '', V.SAUPNO) SAUPNO,                                                                                                   \n");
		sbSql.append("     V.SAUPNO ORG_SAUPNO,                                                                                                                                   \n");
		sbSql.append("     '1'                                          TAXSENDGB,                                                                                                \n");
		sbSql.append("     'Y'                                          SMSSENDYN,                                                                                                \n");
		sbSql.append("     DECODE(V.SAUPNO, '9999999999', '02', '01')   NATFORGB,                                                                                                 \n");
		sbSql.append("     DECODE(V.SAUPNO, '9999999999', '', V.DRNAME1) DRNAME1,                                                                                                 \n");
		sbSql.append("     DECODE(V.SAUPNO, '9999999999', '', SC_CRYPTO_FUN('DEC', V.ADDR_ENC, '6'))    ADDR,                                                                                                    \n");
		sbSql.append("     DECODE(V.SAUPNO, '9999999999', '',  V.UP_TAE) UPTAE,                                                                                                   \n");
		sbSql.append("     DECODE(V.SAUPNO, '9999999999', '', V.UP_JONG) UPJONG,                                                                                                  \n");
		sbSql.append("     (SELECT CHARGE_SABUN FROM SCO_UPJANG_MST WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + ")     EMPNO,                                                                           \n");
		sbSql.append("     (SELECT NM_KOR FROM HLDC_HR_PERSONAL WHERE SABUN = (SELECT CHARGE_SABUN FROM SCO_UPJANG_MST WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + ")) EMPNO_NAME,                      \n");
		sbSql.append("     (SELECT REPLACE(SC_CRYPTO_FUN('DEC', UPJANG_TEL_ENC, '4'), '-', '') FROM SCO_UPJANG_MST WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + ")       TELNO,                                                         \n");
		sbSql.append("     (SELECT REPLACE(SC_CRYPTO_FUN('DEC', CHARGE_SABUNHP_ENC, '4'), '-', '') FROM SCO_UPJANG_MST WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + ")   CPNO,                                                          \n");
		sbSql.append("     (SELECT SC_CRYPTO_FUN('DEC', COMM_EMAIL_ENC, '5') AS COMM_EMAIL FROM HLDC_HR_PERSONAL WHERE SABUN = (SELECT CHARGE_SABUN FROM SCO_UPJANG_MST WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + ")) EMAIL,                       \n");
		sbSql.append("     (SELECT MU_NM||' '||CC_NM FROM SCO_UPJANG_MST_V WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + ") DEPTNM,                                                                       \n");
		sbSql.append("     (SELECT SUBTEAM_MST_SABUN FROM SCO_UPJANG_MST WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + ")     EMPNOUP,                                                                    \n");
		sbSql.append("     (SELECT NM_KOR FROM HLDC_HR_PERSONAL WHERE SABUN = (SELECT SUBTEAM_MST_SABUN FROM SCO_UPJANG_MST WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + ")) EMPNOUP_NAME,               \n");
		sbSql.append("     (SELECT REPLACE(SC_CRYPTO_FUN('DEC', COMM_TEL1_ENC, '4'), '-', '') FROM HLDC_HR_PERSONAL WHERE SABUN = (SELECT SUBTEAM_MST_SABUN FROM SCO_UPJANG_MST WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + "))  TELNOUP, \n");
		sbSql.append("     (SELECT REPLACE(SC_CRYPTO_FUN('DEC', COMM_TEL3_ENC, '4'), '-', '') FROM HLDC_HR_PERSONAL WHERE SABUN = (SELECT SUBTEAM_MST_SABUN FROM SCO_UPJANG_MST WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + "))  CPNOUP, \n");
		sbSql.append("     (SELECT SC_CRYPTO_FUN('DEC', COMM_EMAIL_ENC, '5') AS COMM_EMAIL FROM HLDC_HR_PERSONAL WHERE SABUN = (SELECT SUBTEAM_MST_SABUN FROM SCO_UPJANG_MST WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + ")) EMAILUP,                \n");
		sbSql.append("     (                                                                                                                                                      \n");
		sbSql.append("      SELECT MU_NM||' '||CC_NM FROM HLDC_SC_DEPT_V WHERE DEPT_ID =                                                                                          \n");
		sbSql.append("      (SELECT DEPT_ID FROM HLDC_HR_PERSONAL WHERE SABUN = (SELECT SUBTEAM_MST_SABUN FROM SCO_UPJANG_MST WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + "))                           \n");
		sbSql.append("     ) DEPTNMUP,                                                                                                                                            \n");
		sbSql.append("     HLDC_ST_UPJANG_HIST_FUN(" + nullToBlank(ds_cond.getString(0, "UPJANG")) + ", '" + nullToBlank(ds_cond.getString(0, "BILL_DATE")) + "', '1') UPJANG_SAUPNO,                                                                                     \n");
		sbSql.append("     HLDC_ST_UPJANG_HIST_FUN(" + nullToBlank(ds_cond.getString(0, "UPJANG")) + ", '" + nullToBlank(ds_cond.getString(0, "BILL_DATE")) + "', '2') UPJANG_VATUPJANGNM,                                                                                \n");
		sbSql.append("     HLDC_ST_UPJANG_HIST_FUN(" + nullToBlank(ds_cond.getString(0, "UPJANG")) + ", '" + nullToBlank(ds_cond.getString(0, "BILL_DATE")) + "', '5') UPJANG_DRNAME,                                                                                     \n");
		sbSql.append("     HLDC_ST_UPJANG_HIST_FUN(100001, '" + nullToBlank(ds_cond.getString(0, "BILL_DATE")) + "', '7') UPJANG_ADDR,                                                                                         \n");
		sbSql.append("     HLDC_ST_UPJANG_HIST_FUN(100001, '" + nullToBlank(ds_cond.getString(0, "BILL_DATE")) + "', '4') UPJANG_UP_TAE,                                                                                       \n");
		sbSql.append("     HLDC_ST_UPJANG_HIST_FUN(100001, '" + nullToBlank(ds_cond.getString(0, "BILL_DATE")) + "', '3') UPJANG_UP_JONG                                                                                       \n");
		sbSql.append("FROM HLDC_ST_CUST V                                                                                                                                         \n");
		sbSql.append("WHERE (V.CUSTCD = " + nullToBlank(ds_cond.getString(0, "CUSTCD")) + ")                                                                                                                                 \n");

out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		//로그남기기
		logger.debug(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_list = this.makeDataSet(rs, "ds_list");
		
		pstmt.close();
		rs.close();

		/**종료**/
		out_dl.add(ds_list);
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
