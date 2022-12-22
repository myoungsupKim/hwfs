<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 영업관리/영업잔액조회
■ 프로그램ID   : MAG00010V_T001.jsp
■ 프로그램명   : 영업잔액조회
■ 작성일자     : 2013-02-05 
■ 작성자       : 박은규
■ 이력관리     : 
	1) 2013-02-05 박은규 - 최초개발 (CH201203_00081)
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
		//FileLog.println("d:\\aaa.txt", ds_cond
		
		String strTmCd      = nullToBlank(ds_Cond.getString(0, "TM_CD"));
		String strUpjang    = nullToBlank(ds_Cond.getString(0, "UPJANG"));
		String strSdate     = nullToBlank(ds_Cond.getString(0, "SDATE"));
		String strEdate     = nullToBlank(ds_Cond.getString(0, "EDATE"));
		String strIndex     = nullToBlank(in_vl.getString("strIndex"));

		//out 데이타
		DataSet ds_List;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		//내역조회
		//1.전도금 잔액
		if (strIndex.equals("1"))
		{
			sbSql.delete(0, sbSql.length());
			sbSql.append("WITH T AS \n");
			sbSql.append("( \n");
			sbSql.append("SELECT -1 AS JID \n");
			sbSql.append("     , B.TM_CD \n");
			sbSql.append("     , B.TM_NAME AS TM_NM \n");
			sbSql.append("     , A.UPJANG \n");
			sbSql.append("     , B.UPJANGNM \n");
			sbSql.append("     , '" + strSdate + "' AS JDATE \n");
			sbSql.append("     , '<전기이월>' AS JDESC \n");
			sbSql.append("     , SUM(DECODE(A.ADV_KIND,'I',1,-1) * (A.AMT - A.NOPAY_AMT)) AS AMT1 --전기 \n");
			sbSql.append("     , 0 AS AMT2 --입금 \n");
			sbSql.append("     , 0 AS AMT3 --지출 \n");
			sbSql.append("     , 0 AS AMT4 --잔액 \n");
			sbSql.append("     , NULL AS GANUM \n");
			sbSql.append("  FROM MAS_ADVANCE A, MAC_UPJANG_V B \n");
			sbSql.append(" WHERE A.UPJANG = B.UPJANG \n");
			sbSql.append("   AND A.ADJ_DATE < '" + strSdate + "' \n");
			if (! strTmCd.equals(""))
				sbSql.append("   AND B.TM_CD = '" + strTmCd + "' \n");
			if (! strUpjang.equals(""))
				sbSql.append("   AND A.UPJANG = " + strUpjang + " \n");
			sbSql.append(" GROUP BY B.TM_CD, B.TM_NAME, A.UPJANG, B.UPJANGNM \n");
			sbSql.append(" --------- \n");
			sbSql.append(" UNION ALL \n");
			sbSql.append(" --------- \n");
			sbSql.append("SELECT A.ADV_ID AS JID \n");
			sbSql.append("     , B.TM_CD \n");
			sbSql.append("     , B.TM_NAME AS TM_NM \n");
			sbSql.append("     , A.UPJANG \n");
			sbSql.append("     , B.UPJANGNM \n");
			sbSql.append("     , A.ADJ_DATE AS JDATE \n");
			sbSql.append("     , A.ADJ_DESC AS JDESC \n");
			sbSql.append("     , 0 AS AMT1 --전기 \n");
			sbSql.append("     , DECODE(A.ADV_KIND, 'I', (A.AMT - A.NOPAY_AMT), 0) AS AMT2 --입금 \n");
			sbSql.append("     , DECODE(A.ADV_KIND, 'I', 0, (A.AMT - A.NOPAY_AMT)) AS AMT3 --지출 \n");
			sbSql.append("     , 0 AS AMT4 --잔액 \n");
			sbSql.append("     , A.GAMU||'-'||A.GADATE||'-'||TRIM(TO_CHAR(A.GANO,'0000')) AS GANUM \n");
			sbSql.append("  FROM MAS_ADVANCE A, MAC_UPJANG_V B \n");
			sbSql.append(" WHERE A.UPJANG = B.UPJANG \n");
			sbSql.append("   AND A.ADJ_DATE BETWEEN '" + strSdate + "' AND '" + strEdate + "' \n");
			if (! strTmCd.equals(""))
				sbSql.append("   AND B.TM_CD = '" + strTmCd + "' \n");
			if (! strUpjang.equals(""))
				sbSql.append("   AND A.UPJANG = " + strUpjang + " \n");
			sbSql.append(" --------- \n");
			sbSql.append(" UNION ALL \n");
			sbSql.append(" --------- \n");
			sbSql.append("SELECT 9999999999999 AS JID \n");
			sbSql.append("     , B.TM_CD \n");
			sbSql.append("     , B.TM_NAME AS TM_NM \n");
			sbSql.append("     , A.UPJANG \n");
			sbSql.append("     , B.UPJANGNM \n");
			sbSql.append("     , '" + strEdate + "' AS JDATE \n");
			sbSql.append("     , '<기말잔액>' AS JDESC \n");
			sbSql.append("     , 0 AS AMT1 --전기 \n");
			sbSql.append("     , 0 AS AMT2 --입금 \n");
			sbSql.append("     , 0 AS AMT3 --지출 \n");
			sbSql.append("     , SUM(DECODE(A.ADV_KIND,'I',1,-1) * (A.AMT - A.NOPAY_AMT)) AS AMT4 --잔액 \n");
			sbSql.append("     , NULL AS GANUM \n");
			sbSql.append("  FROM MAS_ADVANCE A, MAC_UPJANG_V B \n");
			sbSql.append(" WHERE A.UPJANG = B.UPJANG \n");
			sbSql.append("   AND A.ADJ_DATE <= '" + strEdate + "' \n");
			if (! strTmCd.equals(""))
				sbSql.append("   AND B.TM_CD = '" + strTmCd + "' \n");
			if (! strUpjang.equals(""))
				sbSql.append("   AND A.UPJANG = " + strUpjang + " \n");
			sbSql.append(" GROUP BY B.TM_CD, B.TM_NAME, A.UPJANG, B.UPJANGNM \n");
			sbSql.append(") \n");
			sbSql.append("SELECT A.* \n");
			sbSql.append("  FROM T A \n");
			sbSql.append(" ORDER BY A.TM_CD, A.UPJANG, A.JDATE, A.JID \n");
		}
		//2.시재금 잔액 (1111461 가지급금)
		else if (strIndex.equals("2"))
		{
			sbSql.delete(0, sbSql.length());
			sbSql.append("SELECT 1 AS JID \n");
			sbSql.append("     , B.TM_CD \n");
			sbSql.append("     , B.TM_NM \n");
			sbSql.append("     , C.UPJANG \n");
			sbSql.append("     , C.UPJANGNM \n");
			sbSql.append("     , A.RTN3_ATTR2 AS JDATE \n");
			//sbSql.append("     , A.RTN3_ATTR4 AS JDESC \n");
			sbSql.append("     , CASE \n");
			sbSql.append("         WHEN A.RTN3_ATTR1 = '<이월금액>' THEN '<전기이월>' \n");
			sbSql.append("         WHEN A.RTN3_ATTR1 = '<잔액>' THEN '<기말잔액>' \n");
			sbSql.append("         ELSE A.RTN3_ATTR4 \n");
			sbSql.append("       END AS JDESC \n");
			sbSql.append("     , A.RTN3_ATTR9 AS AMT1 --전기 \n");
			sbSql.append("     , A.RTN3_ATTR10 AS AMT2 --입금 \n");
			sbSql.append("     , A.RTN3_ATTR11 AS AMT3 --지출 \n");
			sbSql.append("     , A.RTN3_ATTR12 AS AMT4 --잔액 \n");
			//sbSql.append("     , A.RTN3_ATTR1 AS GANUM \n");
			sbSql.append("     , CASE \n");
			sbSql.append("         WHEN A.RTN3_ATTR1 IN ('<이월금액>', '<잔액>') THEN NULL \n");
			sbSql.append("         ELSE A.RTN3_ATTR1 \n");
			sbSql.append("       END AS GANUM \n");
			sbSql.append("  FROM TABLE (GA_DEPTJAN_FUN('" + strSdate + "', '" + strEdate + "', '1111461', '', (SELECT Z.CC_CD FROM HLDC_ST_UPJANG Z WHERE Z.UPJANG = '" + strUpjang + "'))) A \n");
			sbSql.append("     , HLDC_SC_DEPT_V B \n");
			sbSql.append("     , HLDC_ST_UPJANG C \n");
			sbSql.append(" WHERE A.RTN3_ATTR8 = B.DEPT_ID \n");
			sbSql.append("   AND A.RTN3_ATTR8 = C.DEPT_ID \n");
			if (! strTmCd.equals(""))
				sbSql.append("   AND B.TM_CD = '" + strTmCd + "' \n");
			if (! strUpjang.equals(""))
				sbSql.append("   AND C.UPJANG = " + strUpjang + " \n");
			sbSql.append(" ORDER BY B.TM_CD, C.UPJANG, A.RTN3_ATTR2 \n");
		}
		//3.소액현금F/S 잔액(1110114)
		//4.미수금(신용카드) 잔액(1110815)
		else if (strIndex.equals("3") || strIndex.equals("4"))
		{
			sbSql.delete(0, sbSql.length());
			sbSql.append("WITH T AS \n");
			sbSql.append("( \n");
			sbSql.append("SELECT -1 AS JID \n");
			sbSql.append("     , B.TM_CD \n");
			sbSql.append("     , B.TM_NAME AS TM_NM \n");
			sbSql.append("     , A.UPJANG \n");
			sbSql.append("     , B.UPJANGNM \n");
			sbSql.append("     , '" + strSdate + "' AS JDATE \n");
	        sbSql.append("     , NULL AS RCP_TYPE \n");
	        sbSql.append("     , NULL AS TYPE_NAME \n");
	        sbSql.append("     , NULL AS SUBINV_CODE \n");
	        sbSql.append("     , NULL AS SUBINV_NAME \n");
	        sbSql.append("     , NULL AS CUSTCD \n");
	        sbSql.append("     , NULL AS CUSTNM \n");
			sbSql.append("     , '<전기이월>' AS JDESC \n");
	        sbSql.append("     , SUM(A.AMT - NVL((SELECT SUM(Z.AMT) FROM MAS_RMT_LINE Z WHERE Z.RCP_ID = A.RCP_ID),0)) AS AMT1 --전기 \n");
			sbSql.append("     , 0 AS AMT2 --입금등록 \n");
			sbSql.append("     , 0 AS AMT3 --이체금액 \n");
			sbSql.append("     , SUM(A.AMT - NVL((SELECT SUM(Z.AMT) FROM MAS_RMT_LINE Z WHERE Z.RCP_ID = A.RCP_ID),0)) AS AMT4 --이체잔액 \n");
	        sbSql.append("  FROM MAS_RCP A, MAC_UPJANG_V B \n");
	        sbSql.append(" WHERE A.UPJANG = B.UPJANG \n");
	        sbSql.append("   AND A.RCP_DATE < '" + strSdate + "' \n");
			if (! strTmCd.equals(""))
				sbSql.append("   AND B.TM_CD = '" + strTmCd + "' \n");
			if (! strUpjang.equals(""))
				sbSql.append("   AND A.UPJANG = " + strUpjang + " \n");
			sbSql.append("   AND EXISTS (SELECT 1 FROM SCC_COMMON_CODE Z WHERE Z.GROUP_CODE = 'MA0115' AND Z.SET5 = 'REMIT' AND Z.SET1 = A.DR_ACCTCD) \n");
			if (strIndex.equals("3"))
				sbSql.append("   AND A.DR_ACCTCD = '1110114' -- 소액현금f/s(업장) \n");
			else
				sbSql.append("   AND A.DR_ACCTCD = '1110815' -- 미수금(신용카드) \n");
			sbSql.append(" GROUP BY B.TM_CD, B.TM_NAME, A.UPJANG, B.UPJANGNM \n");
			sbSql.append(" --------- \n");
			sbSql.append(" UNION ALL \n");
			sbSql.append(" --------- \n");
			sbSql.append("SELECT A.RCP_ID AS JID \n");
			sbSql.append("     , B.TM_CD \n");
			sbSql.append("     , B.TM_NAME AS TM_NM \n");
			sbSql.append("     , A.UPJANG \n");
			sbSql.append("     , B.UPJANGNM \n");
	        sbSql.append("     , A.RCP_DATE AS JDATE \n");
	        sbSql.append("     , A.RCP_TYPE \n");
	        sbSql.append("     , (SELECT Z.TYPE_NAME FROM MAS_TYPE Z WHERE Z.TYPE_CD = A.RCP_TYPE) AS TYPE_NAME \n");
	        sbSql.append("     , A.SUBINV_CODE \n");
	        sbSql.append("     , (SELECT Z.SUBINV_NAME FROM HLDC_PO_SUBINVENTORY Z WHERE Z.SUBINV_CODE = A.SUBINV_CODE) AS SUBINV_NAME \n");
	        sbSql.append("     , A.CUSTCD \n");
	        sbSql.append("     , (SELECT Z.CUSTNM FROM HLDC_ST_CUST Z WHERE Z.CUSTCD = A.CUSTCD) AS CUSTNM \n");
	        sbSql.append("     , A.RCP_DESC AS JDESC \n");
	        sbSql.append("     , 0 AS AMT1 --전기 \n");
	        sbSql.append("     , A.AMT AS AMT2 --입금등록 \n");
	        sbSql.append("     , NVL((SELECT SUM(Z.AMT) FROM MAS_RMT_LINE Z WHERE Z.RCP_ID = A.RCP_ID),0) AS AMT3 --이체금액 \n");
	        sbSql.append("     , A.AMT - NVL((SELECT SUM(Z.AMT) FROM MAS_RMT_LINE Z WHERE Z.RCP_ID = A.RCP_ID),0) AS AMT4 --이체잔액 \n");
	        sbSql.append("  FROM MAS_RCP A, MAC_UPJANG_V B \n");
	        sbSql.append(" WHERE A.UPJANG = B.UPJANG \n");
	        sbSql.append("   AND A.RCP_DATE BETWEEN '" + strSdate + "' AND '" + strEdate + "' \n");
			if (! strTmCd.equals(""))
				sbSql.append("   AND B.TM_CD = '" + strTmCd + "' \n");
			if (! strUpjang.equals(""))
				sbSql.append("   AND A.UPJANG = " + strUpjang + " \n");
			sbSql.append("   AND EXISTS (SELECT 1 FROM SCC_COMMON_CODE Z WHERE Z.GROUP_CODE = 'MA0115' AND Z.SET5 = 'REMIT' AND Z.SET1 = A.DR_ACCTCD) \n");
			if (strIndex.equals("3"))
				sbSql.append("   AND A.DR_ACCTCD = '1110114' -- 소액현금f/s(업장) \n");
			else
				sbSql.append("   AND A.DR_ACCTCD = '1110815' -- 미수금(신용카드) \n");
			sbSql.append(") \n");
			sbSql.append("SELECT A.* \n");
			sbSql.append("  FROM T A \n");
			sbSql.append(" ORDER BY A.TM_CD, A.UPJANG, A.JDATE, A.JID, A.RCP_TYPE, A.SUBINV_CODE \n");
		}
		
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