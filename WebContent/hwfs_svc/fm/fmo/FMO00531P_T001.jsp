<%
/*-----------------------------------------------------------------------------
�� �ý��۸�     : ���翵��/�޽�ä�ǰ���
�� ���α׷�ID   : FMO00531P_T001.jsp
�� ���α׷���   : �Ա� �� ������Ȳ��ȸ/����� �Աݳ���
�� �ۼ�����     : 2008.02.21
�� �ۼ���       : ������
�� �̷°���     : 2008.02.21
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	try	{
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		//jsp log ���� ���� 
		logger.startIndividualLog(in_vl.getString("titLogId"));		
	
		//�Է� ����Ÿ
		//DataSet ds_cond     = in_dl.get("ds_Cond");
		//�Է� �Ķ����
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		String sUpjang      = nullToBlank(in_vl.getString("sUpjang"));
		String sDate        = nullToBlank(in_vl.getString("sDate"));
		//FileLog.println("d:\\aaa.txt", ds_cond);


		//out ����Ÿ
		DataSet ds_list;
		//sql�� ���ۻ���
		StringBuffer sbSql = new StringBuffer();

		//������ȸ
		//sbSql.append("SELECT TO_CHAR(TO_DATE(A.RECEIPT_DATE,'YYYYMMDD'),'DD\"(\"DY\")\"') AS JDATE \n");
		//sbSql.append("     , SUM(AMOUNT) AS AMT \n");
		//sbSql.append("  FROM HLDC_FM_RECEIPT A \n");
		//sbSql.append(" WHERE A.UPJANG = " + sUpjang + " \n");
		//sbSql.append("   AND A.RECEIPT_DATE BETWEEN SUBSTR('" + sDate + "',1,6)||'01' AND '" + sDate + "' \n");
		//sbSql.append("   AND A.DCGUBUN = '1' \n");
		//sbSql.append(" GROUP BY A.RECEIPT_DATE \n");

		// ä�ǰ��� �Աݳ��� ��ȸ
		//sbSql.append("SELECT M.CUST_NM, TO_CHAR(TO_DATE(D.RECEIVE_DATE,'YYYYMMDD'),'DD\"(\"DY\")\"') AS JDATE \n");
		//sbSql.append("     , SUM(D.RECEIVE_AMT) AS AMT \n");
		//sbSql.append("  FROM SLA_AR_MST M  INNER JOIN SLA_AR_RECEIVE_DETAIL D  ON D.RECD_STATUS  = 'L'  \n");
		//sbSql.append("														  AND D.RECEIVE_DATE BETWEEN SUBSTR('" + sDate + "',1,6)||'01' AND '" + sDate + "' \n");
		//sbSql.append("														  AND M.AR_NUM = D.AR_NUM \n");
		//sbSql.append(" WHERE M.UPJANG_CD = " + sUpjang + " \n");
		//sbSql.append(" GROUP BY M.CUST_NM, D.RECEIVE_DATE \n");
		//sbSql.append(" ORDER BY M.CUST_NM, D.RECEIVE_DATE \n");

 
		// 1.������� �Ա� ����
		sbSql.append(" SELECT  \n");
		sbSql.append("	    (SELECT CUSTNM FROM ST_CUST WHERE CUSTCD = S.CUSTCD) AS CUST_NM \n");
		sbSql.append("	  , TO_CHAR(TO_DATE(A.RECEIVE_DATE,'YYYYMMDD'),'DD\"(\"DY\")\"')  AS JDATE \n");
		sbSql.append("	  , NVL(A.RECEIVE_AMT,0) AS AMT \n");
		sbSql.append("	  , '��������Ա�'  AS GUBUN \n");
		sbSql.append(" FROM SLA_SAP_SUSPENSE_INFO A INNER JOIN SLA_SAP_BANK_ACCT_NO B ON B.BANK_ACCT_TYPE = 'V' \n");
		sbSql.append("																									   AND A.BANK_ACCT_NO = B.BANK_ACCT_NO   \n");
		sbSql.append("												INNER JOIN ST_UPJANG S ON S.UPJANG = " + sUpjang + " \n");
		sbSql.append("																				  AND B.UPJANG_CD = S.UPJANG \n");
		sbSql.append(" WHERE  A.RECD_STATUS = 'L' \n");
        sbSql.append(" AND     A.RECEIVE_DATE BETWEEN SUBSTR('" + sDate + "',1,6)||'01' AND '" + sDate + "'  \n");
	    sbSql.append(" UNION ALL \n");
		// 2. �����Ա����� 
		sbSql.append(" SELECT  \n");
		sbSql.append("	    (SELECT CUSTNM FROM ST_CUST WHERE CUSTCD = S.CUSTCD) AS CUST_NM \n");
		sbSql.append("	, TO_CHAR(TO_DATE(D.RECEIVE_DATE,'YYYYMMDD'),'DD\"(\"DY\")\"')  AS JDATE \n");
		sbSql.append("	, D.RECEIVE_AMT AS AMT \n");
		sbSql.append("	, '�����Ա�'  AS GUBUN \n");
		sbSql.append(" FROM SLA_AR_RECEIVE_DETAIL D INNER JOIN SLA_AR_MST M ON M.SYS_CLASS = '13' \n");
		sbSql.append("																						AND M.RECD_STATUS = 'L' \n");
		sbSql.append("																						AND D.AR_NUM = M.AR_NUM \n");
		sbSql.append("													INNER JOIN ST_UPJANG S ON  S.UPJANG  = " + sUpjang + " \n");
		sbSql.append("																						AND	M.UPJANG_CD = S.UPJANG \n");
		sbSql.append("													INNER JOIN SLA_AR_RECEIVE_MST R ON R.RECEIVE_TYPE_CD NOT IN ('B10')	 -- ������ ���� \n");
		sbSql.append("																									AND D.RECEIVE_NUM = R.RECEIVE_NUM \n");
		sbSql.append(" WHERE  D.RECD_STATUS = 'L' \n");
        sbSql.append(" AND     D.RECEIVE_DATE BETWEEN SUBSTR('" + sDate + "',1,6)||'01' AND '" + sDate + "'  \n");
		sbSql.append(" AND R.RECEIVE_TYPE_CD NOT IN ('B07','B16')  --�̼��� ä���̰��� ���� \n");
		sbSql.append(" ORDER BY 2 \n");


out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_list = this.makeDataSet(rs, "ds_List");
		
		pstmt.close();
		rs.close();

		/**����**/
		out_dl.add(ds_list);
		this.setResultMessage(0, "OK", out_vl);

	}
	catch(Exception ex)
	{
		//ex.printStackTrace();
		//jsp �α׳����
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
		//jsp log ���� �ݱ� 
		try {
			logger.endIndividualLog();
		} catch( Exception logE) {
			logE.printStackTrace();
		}		
	}

	proc_output(response,out,out_vl,out_dl);

%>
