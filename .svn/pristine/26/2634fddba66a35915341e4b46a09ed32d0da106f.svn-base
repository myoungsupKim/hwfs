<%
/*-----------------------------------------------------------------------------
■ 시스템명     : FS시스템/IFIS/마케팅관리/식재사업 입금안내장
■ 프로그램ID   : MAK10220S_T001.jsp
■ 프로그램명   : 식재사업 입금안내장 출력
■ 작성일자     : 2009.04.01
■ 작성자       : 황승한
■ 이력관리     : 1)식재사업 입금안내장 출력 신규프로그램생성 - 2009.04.01 #CSR25892 황승한
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
		
		//본사업장목록을 IN조건으로 만든다.
		String sUpjangList = ""; 
		sbSql.delete(0,sbSql.length());
		sbSql.append("SELECT UPJANG FROM HLDC_ST_UPJANG \n");
		sbSql.append(" WHERE CUSTCD  = " + nullToBlank(ds_Cond.getString(0, "CUSTCD")) + " \n");

		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		while (rs.next())
		{
			sUpjangList += ", " + rs.getString("UPJANG");
		}
		if (sUpjangList.equals(""))
			sUpjangList = "(NULL)";
		else
			sUpjangList = "(" + sUpjangList.substring(1) + ")";
		rs.close();
		pstmt.close();
		

		//본사 통합 업장 대상 여신체크할 최종 발주일자 조회
		sbSql.delete(0,sbSql.length());
		sbSql.append("SELECT /*+ INDEX_DESC(A PO_PR_I5) */ \n");
		sbSql.append("       NEED_DATE \n");
		sbSql.append("  FROM HLDC_PO_PR A \n");
		sbSql.append(" WHERE RC_UPJANG IN " + sUpjangList + " \n");
		sbSql.append("   AND NEED_DATE BETWEEN '" + nullToBlank(ds_Cond.getString(0, "JDATE")) + "' AND GREATEST(TO_CHAR(SYSDATE+31,'YYYYMMDD'),'" + nullToBlank(ds_Cond.getString(0, "JDATE")) + "') \n");
		sbSql.append("   AND LINE_STATUS <> '003' --신청취소 \n");
		sbSql.append("   AND ROWNUM <= 1 \n");
out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		String strDate;
		if(rs.next())
			strDate = rs.getString("NEED_DATE");
		else
			strDate = nullToBlank(ds_Cond.getString(0, "JDATE"));
		rs.close();
		pstmt.close();

		//본사통합 업장내역조회(속도관계상 운영율은 적용하지 않는다.)
		sbSql.delete(0,sbSql.length());
		sbSql.append("/* MAK10220S_T001.jsp */ \n");
    sbSql.append("    SELECT (SELECT SAUPNO FROM HLDC_ST_CUST WHERE CUSTCD = V.CUSTCD) SAUPNO\n");
    sbSql.append("         , (SELECT CUSTNM FROM HLDC_ST_CUST WHERE CUSTCD = V.CUSTCD) CUSTNM\n");
    sbSql.append("         , A.MAIN_UPJANG, DECODE(A.MAIN_UPJANG,A.UPJANG,'0','1') AS BON_GB \n");
    sbSql.append("         , A.UPJANG \n");
    sbSql.append("         , A.UPJANGNM_DISP \n");
    sbSql.append("         , NVL(E.PO_AMT,0) + NVL(F.PR_AMT,0) AS AMT1_2 --매입예정액 \n");
    sbSql.append("         , NVL(D.TR_AMT,0) AS AMT1_3 --매입확정액 \n");
    sbSql.append("         , NVL(C.RMN_AMT,0) AS AMT2 --외상매출금, \n");
    sbSql.append("         , NVL(C1.PRE_AMT,0) AS AMT3 --선수금, \n");
    sbSql.append("         , NVL(E.PO_AMT,0) + NVL(F.PR_AMT,0) + NVL(D.TR_AMT,0) + NVL(C.RMN_AMT,0) - NVL(C1.PRE_AMT,0) AS AMT4 \n");   
    sbSql.append("         , NVL((SELECT REQ_AMT2 FROM MAK_BOND_REQ_B WHERE UPJANG = V.UPJANG AND REQ_DATE = '" + nullToBlank(ds_Cond.getString(0, "JDATE")) + "'),0)  REQ_AMT2\n");
    sbSql.append("         , NVL((SELECT REQ_AMT3 FROM MAK_BOND_REQ_B WHERE UPJANG = V.UPJANG AND REQ_DATE = '" + nullToBlank(ds_Cond.getString(0, "JDATE")) + "'),0)  REQ_AMT3\n");            
    sbSql.append("         , (SELECT UDATE FROM MAK_BOND_REQ_B WHERE UPJANG = V.UPJANG AND REQ_DATE = '" + nullToBlank(ds_Cond.getString(0, "JDATE")) + "')  UDATE\n");            
    sbSql.append("         , (SELECT NM_KOR FROM HLDC_HR_PERSONAL WHERE SABUN = A.PART_SALES_SABUN) PART_SALES_SABUNNM\n"); 
    sbSql.append("         , '" + nullToBlank(ds_Cond.getString(0, "JDATE")) + "' REQ_DATE \n"); 
    sbSql.append("         , NVL(E.PO_AMT,0) + NVL(F.PR_AMT,0) + NVL(D.TR_AMT,0) + NVL(C.RMN_AMT,0) - NVL(C1.PRE_AMT,0) + \n");  
    sbSql.append("           NVL((SELECT REQ_AMT2 FROM MAK_BOND_REQ_B WHERE UPJANG = V.UPJANG AND REQ_DATE = '" + nullToBlank(ds_Cond.getString(0, "JDATE")) + "'),0)  + \n");
    sbSql.append("           NVL((SELECT REQ_AMT3 FROM MAK_BOND_REQ_B WHERE UPJANG = V.UPJANG AND REQ_DATE = '" + nullToBlank(ds_Cond.getString(0, "JDATE")) + "'),0)  REQ_AMT4, \n");                   
    sbSql.append("           (SELECT SC_CRYPTO_FUN('DEC', ACNTCD_ENC , '3') AS ACNTCD  FROM HLDC_ST_ACNT  WHERE UPJANG = A.UPJANG  AND   ACTDIV = '99') VIRACTNUM, \n");            
    sbSql.append("           (SELECT COUNT(*)  FROM FMS_UPJANG  WHERE UPJANG = MAIN_UPJANG  AND   UPJANG IN " + sUpjangList + ")  MAIN_UPJANG_CNT, \n");            
    sbSql.append("           DECODE(NVL((SELECT COUNT(*) FROM MAK_BOND_REQ_B WHERE UPJANG = V.UPJANG AND REQ_DATE = '" + nullToBlank(ds_Cond.getString(0, "JDATE")) + "'),0), 0, 'N', 'Y')  PRINT_GUBUN \n");            
    sbSql.append("      FROM HLDC_ST_UPJANG V \n");
    sbSql.append("         , FMS_UPJANG A \n");
    sbSql.append("           --C.외상잔액정보 \n");
    sbSql.append("         ,(SELECT A.UPJANG, SUM((A.BILL_AMOUNT + A.BILL_VAT) - NVL(B.RCP_AMT,0)) AS RMN_AMT \n");
    sbSql.append("             FROM HLDC_FM_BILL A \n");
    sbSql.append("                ,(SELECT C.BILL_ID, SUM(C.AMOUNT) AS RCP_AMT \n");
    sbSql.append("                    FROM HLDC_FM_RECEIPT B, HLDC_FM_BILL_RECEIPT C \n");
    sbSql.append("                   WHERE B.RECEIPT_ID = C.RECEIPT_ID \n");
    sbSql.append("                     AND B.UPJANG IN   " + sUpjangList + " \n");
    sbSql.append("                   GROUP BY C.BILL_ID) B \n");
    sbSql.append("            WHERE A.BILL_ID = B.BILL_ID(+) \n");
    sbSql.append("              AND A.UPJANG  IN " + sUpjangList + " \n");
    sbSql.append("              AND A.BILL_DATE <= '" + strDate + "' \n");
    sbSql.append("              AND A.CANCEL_FLAG = 'N' \n");
    sbSql.append("              AND A.DCGUBUN = '1' \n");
    sbSql.append("              AND A.ACCTCD = '1110411' \n");
    sbSql.append("              AND ((A.BILL_AMOUNT + A.BILL_VAT) - NVL(B.RCP_AMT,0)) != 0 \n");
    sbSql.append("            GROUP BY A.UPJANG) C \n");
    sbSql.append("           --C1.선수잔액정보 \n");
    sbSql.append("         ,(SELECT A.UPJANG, SUM(A.AMOUNT - NVL(B.USE_AMT,0)) AS PRE_AMT \n");
    sbSql.append("                , MIN(A.RECEIPT_DATE) AS L_RECEIPT_DATE \n");
    sbSql.append("             FROM HLDC_FM_RECEIPT A \n");
    sbSql.append("                ,(SELECT C.RECEIPT_ID, SUM(C.AMOUNT) AS USE_AMT \n");
    sbSql.append("                    FROM HLDC_FM_RECEIPT B, HLDC_FM_BILL_RECEIPT C \n");
    sbSql.append("                   WHERE B.RECEIPT_ID = C.RECEIPT_ID \n");
    sbSql.append("                     AND B.UPJANG IN " + sUpjangList + " \n");
    sbSql.append("                   GROUP BY C.RECEIPT_ID) B \n");
    sbSql.append("            WHERE A.RECEIPT_ID = B.RECEIPT_ID(+) \n");
    sbSql.append("              AND A.UPJANG IN  " + sUpjangList + " \n");
    sbSql.append("              AND A.RECEIPT_DATE <= '" + strDate + "' \n");
    sbSql.append("              AND A.DCGUBUN = '2' \n");
    sbSql.append("              AND A.ACCTCD = '2110441' \n");
    sbSql.append("              --AND A.GANO > 0 --가상계좌 전표화 시킨 것만 인정하려면 주석제거. \n");
    sbSql.append("              AND (A.AMOUNT - NVL(B.USE_AMT,0)) != 0 \n");
    sbSql.append("            GROUP BY A.UPJANG) C1 \n");
    sbSql.append("           --D.당월 미매출마감된 검수금액 \n");
    sbSql.append("         ,(SELECT UPJANG, SUM(TR_AMT) AS TR_AMT \n");
    sbSql.append("             FROM (SELECT /*+ INDEX(A PO_TRANSACTION_PT_I8) */ \n");
    sbSql.append("                          TRANS_UPJANG AS UPJANG \n");
    sbSql.append("                        , SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(TAX_CODE,'100',1.1,1) * SALE_AMOUNT)) AS TR_AMT \n");
    sbSql.append("                     FROM HLDC_PO_TRANSACTION A \n");
    sbSql.append("                    WHERE TRANS_DATE BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE('" + strDate + "','YYYYMMDD'),-1),'YYYYMM\"01\"') \n");
    sbSql.append("                                         AND TO_CHAR(ADD_MONTHS(TO_DATE('" + strDate + "','YYYYMMDD'),-1),'YYYYMM\"31\"') \n");
    sbSql.append("                      AND (TRANS_TYPE = 'I001' OR (TRANS_TYPE LIKE '_002' AND SOURCE_TYPE = 'PO')) \n");
    sbSql.append("                      AND TRANS_UPJANG IN  " + sUpjangList + " \n");
    sbSql.append("                      AND SGANO = -1 \n");
    sbSql.append("                    GROUP BY TRANS_UPJANG \n");
    sbSql.append("                    UNION ALL \n");
    sbSql.append("                   SELECT /*+ INDEX(A PO_TRANSACTION_PT_I8) */ \n");
    sbSql.append("                          TRANS_UPJANG AS UPJANG \n");
    sbSql.append("                        , SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(TAX_CODE,'100',1.1,1) * SALE_AMOUNT)) AS TR_AMT \n");
    sbSql.append("                     FROM HLDC_PO_TRANSACTION A \n");
    sbSql.append("                    WHERE TRANS_DATE BETWEEN SUBSTR('" + strDate + "',1,6)||'01' AND '" + strDate + "' \n");
    sbSql.append("                      AND (TRANS_TYPE = 'I001' OR (TRANS_TYPE LIKE '_002' AND SOURCE_TYPE = 'PO')) \n");
    sbSql.append("                      AND TRANS_UPJANG IN  " + sUpjangList + " \n");
    sbSql.append("                      AND SGANO = -1 \n");
    sbSql.append("                    GROUP BY TRANS_UPJANG \n");
    sbSql.append("                  ) \n");
    sbSql.append("            GROUP BY UPJANG ) D \n");
    sbSql.append("           --E.당월 미검수 발주금액 \n");
    sbSql.append("         ,(SELECT /*+ INDEX_DESC(A PO_PO_I8) */ \n");
    sbSql.append("                  A.RC_UPJANG AS UPJANG \n");
    sbSql.append("                , SUM(ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND((A.CENTER_DELI_QTY + A.DIRECT_DELI_QTY - A.DELIVERED_QTY - A.UNDELIVERED_QTY) * A.SALE_PRICE))) AS PO_AMT \n");
    sbSql.append("             FROM HLDC_PO_PO A \n");
    sbSql.append("            WHERE A.NEED_DATE BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE('" + strDate + "','YYYYMMDD'),-1),'YYYYMM\"01\"') AND '" + strDate + "' \n");
    sbSql.append("              AND A.RC_UPJANG IN   " + sUpjangList + " \n");
    sbSql.append("              AND A.LINE_STATUS BETWEEN '006' AND '010' \n");
    sbSql.append("            GROUP BY A.RC_UPJANG \n");
    sbSql.append("          ) E \n");
    sbSql.append("           --F.당월 미발주 주문금액 \n");
    sbSql.append("         ,(SELECT /*+ INDEX_DESC(A PO_PR_I5) */ \n");
    sbSql.append("                  A.RC_UPJANG AS UPJANG \n");
    sbSql.append("                , SUM(ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.PR_QTY * A.SALE_PRICE))) AS PR_AMT \n");
    sbSql.append("             FROM HLDC_PO_PR A \n");
    sbSql.append("            WHERE A.NEED_DATE BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE('" + strDate + "','YYYYMMDD'),-1),'YYYYMM\"01\"') AND '" + strDate + "' \n");
    sbSql.append("              AND A.RC_UPJANG IN   " + sUpjangList + " \n");
    sbSql.append("              AND A.LINE_STATUS IN ('001','002','004') \n");
    sbSql.append("            GROUP BY A.RC_UPJANG \n");
    sbSql.append("          ) F \n");
    sbSql.append("     WHERE V.UPJANG = A.UPJANG \n");
    sbSql.append("       AND A.UPJANG = C.UPJANG(+) \n");
    sbSql.append("       AND A.UPJANG = C1.UPJANG(+) \n");
    sbSql.append("       AND A.UPJANG = D.UPJANG(+) \n");
    sbSql.append("       AND A.UPJANG = E.UPJANG(+) \n");
    sbSql.append("       AND A.UPJANG = F.UPJANG(+) \n");
    sbSql.append("       AND V.CUSTCD = " + nullToBlank(ds_Cond.getString(0, "CUSTCD")) + " \n");
		
		
		
		
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