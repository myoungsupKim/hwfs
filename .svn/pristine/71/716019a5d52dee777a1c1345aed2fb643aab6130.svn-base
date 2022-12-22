<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/급식채권관리
■ 프로그램ID   : FMO00531P_T001.jsp
■ 프로그램명   : 입금 및 여신현황조회/사업장 입금내역
■ 작성일자     : 2008.02.21
■ 작성자       : 박은규
■ 이력관리     : 2008.02.21
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
		//DataSet ds_cond     = in_dl.get("ds_Cond");
		//입력 파라메터
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		String sUpjang      = nullToBlank(in_vl.getString("sUpjang"));
		String sDate        = nullToBlank(in_vl.getString("sDate"));
		//FileLog.println("d:\\aaa.txt", ds_cond);


		//out 데이타
		DataSet ds_list;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		//내역조회
		//sbSql.append("SELECT TO_CHAR(TO_DATE(A.RECEIPT_DATE,'YYYYMMDD'),'DD\"(\"DY\")\"') AS JDATE \n");
		//sbSql.append("     , SUM(AMOUNT) AS AMT \n");
		//sbSql.append("  FROM HLDC_FM_RECEIPT A \n");
		//sbSql.append(" WHERE A.UPJANG = " + sUpjang + " \n");
		//sbSql.append("   AND A.RECEIPT_DATE BETWEEN SUBSTR('" + sDate + "',1,6)||'01' AND '" + sDate + "' \n");
		//sbSql.append("   AND A.DCGUBUN = '1' \n");
		//sbSql.append(" GROUP BY A.RECEIPT_DATE \n");

		// 채권관련 입금내역 조회
		//sbSql.append("SELECT M.CUST_NM, TO_CHAR(TO_DATE(D.RECEIVE_DATE,'YYYYMMDD'),'DD\"(\"DY\")\"') AS JDATE \n");
		//sbSql.append("     , SUM(D.RECEIVE_AMT) AS AMT \n");
		//sbSql.append("  FROM SLA_AR_MST M  INNER JOIN SLA_AR_RECEIVE_DETAIL D  ON D.RECD_STATUS  = 'L'  \n");
		//sbSql.append("														  AND D.RECEIVE_DATE BETWEEN SUBSTR('" + sDate + "',1,6)||'01' AND '" + sDate + "' \n");
		//sbSql.append("														  AND M.AR_NUM = D.AR_NUM \n");
		//sbSql.append(" WHERE M.UPJANG_CD = " + sUpjang + " \n");
		//sbSql.append(" GROUP BY M.CUST_NM, D.RECEIVE_DATE \n");
		//sbSql.append(" ORDER BY M.CUST_NM, D.RECEIVE_DATE \n");

 
		// 1.가상계좌 입금 정보
		sbSql.append(" SELECT  \n");
		sbSql.append("	    (SELECT CUSTNM FROM ST_CUST WHERE CUSTCD = S.CUSTCD) AS CUST_NM \n");
		sbSql.append("	  , TO_CHAR(TO_DATE(A.RECEIVE_DATE,'YYYYMMDD'),'DD\"(\"DY\")\"')  AS JDATE \n");
		sbSql.append("	  , NVL(A.RECEIVE_AMT,0) AS AMT \n");
		sbSql.append("	  , '가상계좌입금'  AS GUBUN \n");
		sbSql.append(" FROM SLA_SAP_SUSPENSE_INFO A INNER JOIN SLA_SAP_BANK_ACCT_NO B ON B.BANK_ACCT_TYPE = 'V' \n");
		sbSql.append("																									   AND A.BANK_ACCT_NO = B.BANK_ACCT_NO   \n");
		sbSql.append("												INNER JOIN ST_UPJANG S ON S.UPJANG = " + sUpjang + " \n");
		sbSql.append("																				  AND B.UPJANG_CD = S.UPJANG \n");
		sbSql.append(" WHERE  A.RECD_STATUS = 'L' \n");
        sbSql.append(" AND     A.RECEIVE_DATE BETWEEN SUBSTR('" + sDate + "',1,6)||'01' AND '" + sDate + "'  \n");
	    sbSql.append(" UNION ALL \n");
		// 2. 수기입금정보 
		sbSql.append(" SELECT  \n");
		sbSql.append("	    (SELECT CUSTNM FROM ST_CUST WHERE CUSTCD = S.CUSTCD) AS CUST_NM \n");
		sbSql.append("	, TO_CHAR(TO_DATE(D.RECEIVE_DATE,'YYYYMMDD'),'DD\"(\"DY\")\"')  AS JDATE \n");
		sbSql.append("	, D.RECEIVE_AMT AS AMT \n");
		sbSql.append("	, '수기입금'  AS GUBUN \n");
		sbSql.append(" FROM SLA_AR_RECEIVE_DETAIL D INNER JOIN SLA_AR_MST M ON M.SYS_CLASS = '13' \n");
		sbSql.append("																						AND M.RECD_STATUS = 'L' \n");
		sbSql.append("																						AND D.AR_NUM = M.AR_NUM \n");
		sbSql.append("													INNER JOIN ST_UPJANG S ON  S.UPJANG  = " + sUpjang + " \n");
		sbSql.append("																						AND	M.UPJANG_CD = S.UPJANG \n");
		sbSql.append("													INNER JOIN SLA_AR_RECEIVE_MST R ON R.RECEIVE_TYPE_CD NOT IN ('B10')	 -- 선수금 제외 \n");
		sbSql.append("																									AND D.RECEIVE_NUM = R.RECEIVE_NUM \n");
		sbSql.append(" WHERE  D.RECD_STATUS = 'L' \n");
        sbSql.append(" AND     D.RECEIVE_DATE BETWEEN SUBSTR('" + sDate + "',1,6)||'01' AND '" + sDate + "'  \n");
		sbSql.append(" AND R.RECEIVE_TYPE_CD NOT IN ('B07','B16')  --이성훈 채권이관건 제거 \n");
		sbSql.append(" ORDER BY 2 \n");


out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_list = this.makeDataSet(rs, "ds_List");
		
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
