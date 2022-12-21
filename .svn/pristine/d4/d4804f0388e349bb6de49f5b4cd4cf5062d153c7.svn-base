<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/급식채권관리
■ 프로그램ID   : FMO00530V_T002.jsp
■ 프로그램명   : 입금 및 여신현황조회(전체업장)
■ 작성일자     : 2008.02.20
■ 작성자       : 박은규
■ 이력관리     : 2008.02.20
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	PlatformRequest platformRequest = this.proc_input(request);
	in_vl = platformRequest.getData().getVariableList();
	in_dl = platformRequest.getData().getDataSetList();

	//입력 데이타
	DataSet ds_Cond     = in_dl.get("ds_Cond");
	//입력 파라메터
	String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
	String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
	//FileLog.println("d:\\aaa.txt", ds_Cond);

	try
	{
		//out 데이타
		DataSet ds_List, ds_ListTmp;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		String strDate;

		strDate = "20080415";

		//본사통합 업장내역조회
		sbSql.delete(0,sbSql.length());
		sbSql.append("SELECT A.UPJANG  \n");
		sbSql.append("     , A.UPJANGNM_DISP \n");

		sbSql.append("     , NVL(C1.전월외매,0) + NVL(D1.전월미검수,0) + NVL(E1.전월발주,0) + NVL(F1.전월주문,0) AS 기초잔고 \n");
		sbSql.append("     , NVL(C.당월매출,0) + NVL(D.당월검수,0) + NVL(E.당월발주,0) + NVL(F.당월주문,0) AS 당월매출 \n");
		sbSql.append("     , CC.당월입금 \n");

		sbSql.append("     , NVL(C1.전월외매,0) + NVL(D1.전월미검수,0) + NVL(E1.전월발주,0) + NVL(F1.전월주문,0) \n");
		sbSql.append("     + NVL(C.당월매출,0) + NVL(D.당월검수,0) + NVL(E.당월발주,0) + NVL(F.당월주문,0) \n");
		sbSql.append("     - NVL(CC.당월입금,0) AS 기말잔고 \n");

		sbSql.append("     , A.CREDIT_AMOUNT + NVL(B.여신연장액,0) AS 여신금액 \n");

		sbSql.append("     , A.CREDIT_AMOUNT + NVL(B.여신연장액,0) \n");
		sbSql.append("     - ( NVL(C1.전월외매,0) + NVL(D1.전월미검수,0) + NVL(E1.전월발주,0) + NVL(F1.전월주문,0) \n");
		sbSql.append("       + NVL(C.당월매출,0) + NVL(D.당월검수,0) + NVL(E.당월발주,0) + NVL(F.당월주문,0) \n");
		sbSql.append("       - NVL(CC.당월입금,0) ) AS 여신잔액 \n");

		sbSql.append("     A.CREDIT_TURN_DAYS + NVL(B.여신연장일,0) AS 약정회전일 \n");

		sbSql.append("     , DECODE(A.CREDIT_CONTROL_YN||A.CREDIT_TURN_CONTROL_YN||A.CREDIT_AMOUNT_CONTROL_YN \n");
		sbSql.append("             ,'YYY','금액+회전일' \n");
		sbSql.append("             ,'YYN','회전일통제' \n");
		sbSql.append("             ,'YNY','금액통제','무통제') AS 여신기준 \n");
		sbSql.append("     , NVL(A.CREDIT_START,'00000000')||' ~ '||NVL(A.CREDIT_END,'99999999') AS 여신기간 \n");

		sbSql.append("  FROM FMS_UPJANG A \n");
		sbSql.append("       --B.여신연장정보 \n");
		sbSql.append("     ,(SELECT A.UPJANG \n");
		sbSql.append("            , SUM(A.CREDIT_EXT_AMOUNT) AS 여신연장액 \n");
		sbSql.append("            , SUM(A.CREDIT_EXT_DAYS) AS 여신연장일 \n");
		sbSql.append("         FROM FMS_CREDIT_EXT A, FMS_UPJANG B \n");
		sbSql.append("        WHERE A.UPJANG = B.UPJANG \n");
		sbSql.append("          AND B.MAIN_UPJANG = B.UPJANG \n");
		sbSql.append("          AND B.HEAD_CREDIT_YN = 'Y' \n");
		sbSql.append("          AND A.UPJANG = " + nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG")) + " \n");
		sbSql.append("          AND '" + strDate + "' BETWEEN A.SUPPLY_START AND A.SUPPLY_END \n");
		sbSql.append("          AND A.APPR_YN = 'Y' \n");
		sbSql.append("        GROUP BY A.UPJANG) B \n");
		sbSql.append("       --C.당월매출 \n");
		sbSql.append("     ,(SELECT A.MAIN_UPJANG AS UPJANG \n");
		sbSql.append("            , SUM(B.BILL_AMOUNT + B.BILL_VAT) AS 당월매출 \n");
		sbSql.append("         FROM FMS_UPJANG A, HLDC_FM_BILL B \n");
		sbSql.append("        WHERE A.UPJANG = B.UPJANG \n");
		sbSql.append("          AND A.HEAD_CREDIT_YN = 'Y' \n");
		sbSql.append("          AND A.MAIN_UPJANG = " + nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG")) + " \n");
		sbSql.append("          AND B.BILL_DATE BETWEEN SUBSTR('" + strDate + "',1,6)||'01' AND '" + strDate + "' \n");
		sbSql.append("          AND B.CANCEL_FLAG = 'N' \n");
		sbSql.append("          AND B.DCGUBUN = '1' \n");
		sbSql.append("          AND B.ACCTCD = '1110411' \n");
		sbSql.append("          AND (B.BILL_AMOUNT + B.BILL_VAT) != 0 \n");
		sbSql.append("        GROUP BY A.MAIN_UPJANG) C \n");
		sbSql.append("       --CC.당월입금 \n");
		sbSql.append("     ,(SELECT A.MAIN_UPJANG AS UPJANG \n");
		sbSql.append("            , SUM(B.AMOUNT) AS 당월입금 \n");
		sbSql.append("         FROM FMS_UPJANG A, HLDC_FM_RECEIPT B \n");
		sbSql.append("        WHERE A.UPJANG = B.UPJANG \n");
		sbSql.append("          AND A.HEAD_CREDIT_YN = 'Y' \n");
		sbSql.append("          AND A.MAIN_UPJANG = " + nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG")) + " \n");
		sbSql.append("          AND B.RECEIPT_DATE BETWEEN SUBSTR('" + strDate + "',1,6)||'01' AND '" + strDate + "' \n");
		sbSql.append("          AND B.DCGUBUN = '2' \n");
		sbSql.append("          AND B.ACCTCD = '1110411' \n");
		sbSql.append("          AND B.AMOUNT != 0 \n");
		sbSql.append("        GROUP BY A.MAIN_UPJANG) CC \n");
		sbSql.append("       --C1.전월외매 \n");
		sbSql.append("     ,(SELECT B.MAIN_UPJANG AS UPJANG \n");
		sbSql.append("            , SUM((C.BILL_AMOUNT + C.BILL_VAT) - NVL(C.RCP_AMT,0)) AS 전월외매 \n");
		sbSql.append("         FROM HLDC_FM_BILL A, FMS_UPJANG B \n");
		sbSql.append("            ,(SELECT C.BILL_ID, SUM(C.AMOUNT) AS RCP_AMT \n");
		sbSql.append("                FROM HLDC_FM_RECEIPT B, HLDC_FM_BILL_RECEIPT C \n");
		sbSql.append("               WHERE B.RECEIPT_ID = C.RECEIPT_ID \n");
		sbSql.append("                 AND B.RECEIPT_DATE < SUBSTR('" + strDate + "',1,6) \n");
		sbSql.append("               GROUP BY C.BILL_ID) C \n");
		sbSql.append("        WHERE A.UPJANG = B.UPJANG \n");
		sbSql.append("          AND B.HEAD_CREDIT_YN = 'Y' \n");
		sbSql.append("          AND B.MAIN_UPJANG = " + nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG")) + " \n");
		sbSql.append("          AND A.BILL_ID = C.BILL_ID(+) \n");
		sbSql.append("          AND A.BILL_DATE < SUBSTR('" + strDate + "',1,6) \n");
		sbSql.append("          AND A.CANCEL_FLAG = 'N' \n");
		sbSql.append("          AND A.DCGUBUN = '1' \n");
		sbSql.append("          AND A.ACCTCD = '1110411' \n");
		sbSql.append("          AND ((A.BILL_AMOUNT + A.BILL_VAT) - NVL(B.RCP_AMT,0)) != 0 \n");
		sbSql.append("        GROUP BY B.MAIN_UPJANG) C1 \n");
		sbSql.append("       --D.당월검수 \n");
		sbSql.append("     ,(SELECT /*+ INDEX(A HLDC_PO_TRANSACTION_PT_I8) */ \n");
		sbSql.append("              B.MAIN_UPJANG AS UPJANG \n");
		sbSql.append("            , SUM(ROUND(DECODE(TAX_CODE,'100',1.1,1) * SALE_AMOUNT)) AS 당월검수 \n");
		sbSql.append("         FROM HLDC_PO_TRANSACTION A, FMS_UPJANG B \n");
		sbSql.append("        WHERE A.TRANS_UPJANG = B.UPJANG \n");
		sbSql.append("          AND B.HEAD_CREDIT_YN = 'Y' \n");
		sbSql.append("          AND B.MAIN_UPJANG = " + nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG")) + " \n");
		sbSql.append("          AND A.TRANS_DATE BETWEEN SUBSTR('" + strDate + "',1,6)||'01' AND '" + strDate + "' \n");
		sbSql.append("          AND A.TRANS_TYPE = 'I001' \n");
		sbSql.append("          AND A.SGANO = -1 \n");
		sbSql.append("        GROUP BY B.MAIN_UPJANG \n");
		sbSql.append("      ) D \n");
		sbSql.append("       --D1.전월검수 \n");
		sbSql.append("     ,(SELECT /*+ INDEX(A HLDC_PO_TRANSACTION_PT_I8) */ \n");
		sbSql.append("              B.MAIN_UPJANG AS UPJANG \n");
		sbSql.append("            , SUM(ROUND(DECODE(TAX_CODE,'100',1.1,1) * SALE_AMOUNT)) AS 전월검수 \n");
		sbSql.append("         FROM HLDC_PO_TRANSACTION A, FMS_UPJANG B \n");
		sbSql.append("        WHERE A.TRANS_UPJANG = B.UPJANG \n");
		sbSql.append("          AND B.HEAD_CREDIT_YN = 'Y' \n");
		sbSql.append("          AND B.MAIN_UPJANG = " + nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG")) + " \n");
		sbSql.append("          AND A.TRANS_DATE BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE('" + strDate + "','YYYYMMDD'),-1),'YYYYMM\"01\"') \n");
		sbSql.append("                               AND TO_CHAR(ADD_MONTHS(TO_DATE('" + strDate + "','YYYYMMDD'),-1),'YYYYMM\"31\"') \n");
		sbSql.append("          AND A.TRANS_TYPE = 'I001' \n");
		sbSql.append("          AND A.SGANO = -1 \n");
		sbSql.append("        GROUP BY B.MAIN_UPJANG \n");
		sbSql.append("      ) D1 \n");
		sbSql.append("       --E.당월 발주 \n");
		sbSql.append("     ,(SELECT B.MAIN_UPJANG AS UPJANG \n");
		sbSql.append("            , SUM(ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND((A.CENTER_DELI_QTY + A.DIRECT_DELI_QTY - A.DELIVERED_QTY - A.UNDELIVERED_QTY) * A.SALE_PRICE))) AS 당월발주 \n");
		sbSql.append("         FROM HLDC_PO_PO A, FMS_UPJANG B \n");
		sbSql.append("        WHERE A.RC_UPJANG = B.UPJANG \n");
		sbSql.append("          AND B.HEAD_CREDIT_YN = 'Y' \n");
		sbSql.append("          AND B.MAIN_UPJANG = " + nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG")) + " \n");
		sbSql.append("          AND A.NEED_DATE BETWEEN SUBSTR('" + strDate + "',1,6)||'01' AND '" + strDate + "' \n");
		sbSql.append("          AND A.LINE_STATUS BETWEEN '006' AND '010' \n");
		sbSql.append("        GROUP BY B.MAIN_UPJANG \n");
		sbSql.append("      ) E \n");
		sbSql.append("       --E1.전월 발주 \n");
		sbSql.append("     ,(SELECT B.MAIN_UPJANG AS UPJANG \n");
		sbSql.append("            , SUM(ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND((A.CENTER_DELI_QTY + A.DIRECT_DELI_QTY - A.DELIVERED_QTY - A.UNDELIVERED_QTY) * A.SALE_PRICE))) AS 전월발주 \n");
		sbSql.append("         FROM HLDC_PO_PO A, FMS_UPJANG B \n");
		sbSql.append("        WHERE A.RC_UPJANG = B.UPJANG \n");
		sbSql.append("          AND B.HEAD_CREDIT_YN = 'Y' \n");
		sbSql.append("          AND B.MAIN_UPJANG = " + nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG")) + " \n");
		sbSql.append("          AND A.NEED_DATE BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE('" + strDate + "','YYYYMMDD'),-1),'YYYYMM\"01\"') \n");
		sbSql.append("                              AND TO_CHAR(ADD_MONTHS(TO_DATE('" + strDate + "','YYYYMMDD'),-1),'YYYYMM\"31\"') \n");
		sbSql.append("          AND A.LINE_STATUS BETWEEN '006' AND '010' \n");
		sbSql.append("        GROUP BY B.MAIN_UPJANG \n");
		sbSql.append("      ) E1 \n");
		sbSql.append("       --F.당월주문 \n");
		sbSql.append("     ,(SELECT B.MAIN_UPJANG AS UPJANG \n");
		sbSql.append("            , SUM(ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND((A.CENTER_DELI_QTY + A.DIRECT_DELI_QTY - A.DELIVERED_QTY - A.UNDELIVERED_QTY) * A.SALE_PRICE))) AS 당월주문 \n");
		sbSql.append("         FROM HLDC_PO_PR A, FMS_UPJANG B \n");
		sbSql.append("        WHERE A.RC_UPJANG = B.UPJANG \n");
		sbSql.append("          AND B.HEAD_CREDIT_YN = 'Y' \n");
		sbSql.append("          AND B.MAIN_UPJANG = " + nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG")) + " \n");
		sbSql.append("          AND A.NEED_DATE BETWEEN SUBSTR('" + strDate + "',1,6)||'01' AND '" + strDate + "' \n");
		sbSql.append("          AND A.LINE_STATUS BETWEEN '006' AND '010' \n");
		sbSql.append("        GROUP BY B.MAIN_UPJANG \n");
		sbSql.append("      ) F \n");
		sbSql.append("       --F1.전월주문 \n");
		sbSql.append("     ,(SELECT B.MAIN_UPJANG AS UPJANG \n");
		sbSql.append("            , SUM(ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND((A.CENTER_DELI_QTY + A.DIRECT_DELI_QTY - A.DELIVERED_QTY - A.UNDELIVERED_QTY) * A.SALE_PRICE))) AS 전월주문 \n");
		sbSql.append("         FROM HLDC_PO_PR A, FMS_UPJANG B \n");
		sbSql.append("        WHERE A.RC_UPJANG = B.UPJANG \n");
		sbSql.append("          AND B.HEAD_CREDIT_YN = 'Y' \n");
		sbSql.append("          AND B.MAIN_UPJANG = " + nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG")) + " \n");
		sbSql.append("          AND A.NEED_DATE BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE('" + strDate + "','YYYYMMDD'),-1),'YYYYMM\"01\"') \n");
		sbSql.append("                              AND TO_CHAR(ADD_MONTHS(TO_DATE('" + strDate + "','YYYYMMDD'),-1),'YYYYMM\"31\"') \n");
		sbSql.append("          AND A.LINE_STATUS BETWEEN '006' AND '010' \n");
		sbSql.append("        GROUP BY B.MAIN_UPJANG \n");
		sbSql.append("      ) F1 \n");
		sbSql.append(" WHERE A.UPJANG = B.UPJANG(+) \n");
		sbSql.append("   AND A.UPJANG = C.UPJANG(+) \n");
		sbSql.append("   AND A.UPJANG = CC.UPJANG(+) \n");
		sbSql.append("   AND A.UPJANG = C1.UPJANG(+) \n");
		sbSql.append("   AND A.UPJANG = D.UPJANG(+) \n");
		sbSql.append("   AND A.UPJANG = D1.UPJANG(+) \n");
		sbSql.append("   AND A.UPJANG = E.UPJANG(+) \n");
		sbSql.append("   AND A.UPJANG = E1.UPJANG(+) \n");
		sbSql.append("   AND A.UPJANG = F.UPJANG(+) \n");
		sbSql.append("   AND A.UPJANG = F1.UPJANG(+) \n");
		sbSql.append("   AND A.HEAD_CREDIT_YN = 'Y' \n");
		sbSql.append("   AND A.UPJANG = " + nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG")) + " \n");

out_vl.add("fa_Sql", sbSql.toString());
		System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_List = this.makeDataSet(rs, "ds_List");
		//FileLog.println("d:\\AAA.txt", ds_List);

		
		//본사 미통합 업장내역조회(개별여신관리)
		sbSql.delete(0,sbSql.length());
		sbSql.append("SELECT A.UPJANG  \n");
		sbSql.append("     , A.UPJANGNM_DISP \n");

		sbSql.append("     , NVL(C1.전월외매,0) + NVL(D1.전월미검수,0) + NVL(E1.전월발주,0) + NVL(F1.전월주문,0) AS 기초잔고 \n");
		sbSql.append("     , NVL(C.당월매출,0) + NVL(D.당월검수,0) + NVL(E.당월발주,0) + NVL(F.당월주문,0) AS 당월매출 \n");
		sbSql.append("     , CC.당월입금 \n");

		sbSql.append("     , NVL(C1.전월외매,0) + NVL(D1.전월미검수,0) + NVL(E1.전월발주,0) + NVL(F1.전월주문,0) \n");
		sbSql.append("     + NVL(C.당월매출,0) + NVL(D.당월검수,0) + NVL(E.당월발주,0) + NVL(F.당월주문,0) \n");
		sbSql.append("     - NVL(CC.당월입금,0) AS 기말잔고 \n");

		sbSql.append("     , A.CREDIT_AMOUNT + NVL(B.여신연장액,0) AS 여신금액 \n");

		sbSql.append("     , A.CREDIT_AMOUNT + NVL(B.여신연장액,0) \n");
		sbSql.append("     - ( NVL(C1.전월외매,0) + NVL(D1.전월미검수,0) + NVL(E1.전월발주,0) + NVL(F1.전월주문,0) \n");
		sbSql.append("       + NVL(C.당월매출,0) + NVL(D.당월검수,0) + NVL(E.당월발주,0) + NVL(F.당월주문,0) \n");
		sbSql.append("       - NVL(CC.당월입금,0) ) AS 여신잔액 \n");

		sbSql.append("     A.CREDIT_TURN_DAYS + NVL(B.여신연장일,0) AS 약정회전일 \n");

		sbSql.append("     , DECODE(A.CREDIT_CONTROL_YN||A.CREDIT_TURN_CONTROL_YN||A.CREDIT_AMOUNT_CONTROL_YN \n");
		sbSql.append("             ,'YYY','금액+회전일' \n");
		sbSql.append("             ,'YYN','회전일통제' \n");
		sbSql.append("             ,'YNY','금액통제','무통제') AS 여신기준 \n");
		sbSql.append("     , NVL(A.CREDIT_START,'00000000')||' ~ '||NVL(A.CREDIT_END,'99999999') AS 여신기간 \n");

		sbSql.append("  FROM FMS_UPJANG A \n");
		sbSql.append("       --B.여신연장정보 \n");
		sbSql.append("     ,(SELECT A.UPJANG \n");
		sbSql.append("            , SUM(A.CREDIT_EXT_AMOUNT) AS 여신연장액 \n");
		sbSql.append("            , SUM(A.CREDIT_EXT_DAYS) AS 여신연장일 \n");
		sbSql.append("         FROM FMS_CREDIT_EXT A, FMS_UPJANG B \n");
		sbSql.append("        WHERE A.UPJANG = B.UPJANG \n");
		sbSql.append("          AND B.HEAD_CREDIT_YN = 'N' \n");
		sbSql.append("          AND B.MAIN_UPJANG = " + nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG")) + " \n");
		sbSql.append("          AND '" + strDate + "' BETWEEN A.SUPPLY_START AND A.SUPPLY_END \n");
		sbSql.append("          AND A.APPR_YN = 'Y' \n");
		sbSql.append("        GROUP BY A.UPJANG) B \n");
		sbSql.append("       --C.당월매출 \n");
		sbSql.append("     ,(SELECT A.UPJANG \n");
		sbSql.append("            , SUM(B.BILL_AMOUNT + B.BILL_VAT) AS 당월매출 \n");
		sbSql.append("         FROM FMS_UPJANG A, HLDC_FM_BILL B \n");
		sbSql.append("        WHERE A.UPJANG = B.UPJANG \n");
		sbSql.append("          AND A.HEAD_CREDIT_YN = 'N' \n");
		sbSql.append("          AND A.MAIN_UPJANG = " + nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG")) + " \n");
		sbSql.append("          AND B.BILL_DATE BETWEEN SUBSTR('" + strDate + "',1,6)||'01' AND '" + strDate + "' \n");
		sbSql.append("          AND B.CANCEL_FLAG = 'N' \n");
		sbSql.append("          AND B.DCGUBUN = '1' \n");
		sbSql.append("          AND B.ACCTCD = '1110411' \n");
		sbSql.append("          AND (B.BILL_AMOUNT + B.BILL_VAT) != 0 \n");
		sbSql.append("        GROUP BY A.UPJANG) C \n");
		sbSql.append("       --CC.당월입금 \n");
		sbSql.append("     ,(SELECT A.UPJANG \n");
		sbSql.append("            , SUM(B.AMOUNT) AS 당월입금 \n");
		sbSql.append("         FROM FMS_UPJANG A, HLDC_FM_RECEIPT B \n");
		sbSql.append("        WHERE A.UPJANG = B.UPJANG \n");
		sbSql.append("          AND A.HEAD_CREDIT_YN = 'N' \n");
		sbSql.append("          AND A.MAIN_UPJANG = " + nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG")) + " \n");
		sbSql.append("          AND B.RECEIPT_DATE BETWEEN SUBSTR('" + strDate + "',1,6)||'01' AND '" + strDate + "' \n");
		sbSql.append("          AND B.DCGUBUN = '2' \n");
		sbSql.append("          AND B.ACCTCD = '1110411' \n");
		sbSql.append("          AND B.AMOUNT != 0 \n");
		sbSql.append("        GROUP BY A.UPJANG) CC \n");
		sbSql.append("       --C1.전월외매 \n");
		sbSql.append("     ,(SELECT B.UPJANG \n");
		sbSql.append("            , SUM((C.BILL_AMOUNT + C.BILL_VAT) - NVL(C.RCP_AMT,0)) AS 전월외매 \n");
		sbSql.append("         FROM HLDC_FM_BILL A, FMS_UPJANG B \n");
		sbSql.append("            ,(SELECT C.BILL_ID, SUM(C.AMOUNT) AS RCP_AMT \n");
		sbSql.append("                FROM HLDC_FM_RECEIPT B, HLDC_FM_BILL_RECEIPT C \n");
		sbSql.append("               WHERE B.RECEIPT_ID = C.RECEIPT_ID \n");
		sbSql.append("                 AND B.RECEIPT_DATE < SUBSTR('" + strDate + "',1,6) \n");
		sbSql.append("               GROUP BY C.BILL_ID) C \n");
		sbSql.append("        WHERE A.UPJANG = B.UPJANG \n");
		sbSql.append("          AND B.HEAD_CREDIT_YN = 'N' \n");
		sbSql.append("          AND B.MAIN_UPJANG = " + nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG")) + " \n");
		sbSql.append("          AND A.BILL_ID = C.BILL_ID(+) \n");
		sbSql.append("          AND A.BILL_DATE < SUBSTR('" + strDate + "',1,6) \n");
		sbSql.append("          AND A.CANCEL_FLAG = 'N' \n");
		sbSql.append("          AND A.DCGUBUN = '1' \n");
		sbSql.append("          AND A.ACCTCD = '1110411' \n");
		sbSql.append("          AND ((A.BILL_AMOUNT + A.BILL_VAT) - NVL(B.RCP_AMT,0)) != 0 \n");
		sbSql.append("        GROUP BY B.UPJANG) C1 \n");
		sbSql.append("       --D.당월검수 \n");
		sbSql.append("     ,(SELECT /*+ INDEX(A HLDC_PO_TRANSACTION_PT_I8) */ \n");
		sbSql.append("              B.UPJANG \n");
		sbSql.append("            , SUM(ROUND(DECODE(TAX_CODE,'100',1.1,1) * SALE_AMOUNT)) AS 당월검수 \n");
		sbSql.append("         FROM HLDC_PO_TRANSACTION A, FMS_UPJANG B \n");
		sbSql.append("        WHERE A.TRANS_UPJANG = B.UPJANG \n");
		sbSql.append("          AND B.HEAD_CREDIT_YN = 'N' \n");
		sbSql.append("          AND B.MAIN_UPJANG = " + nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG")) + " \n");
		sbSql.append("          AND A.TRANS_DATE BETWEEN SUBSTR('" + strDate + "',1,6)||'01' AND '" + strDate + "' \n");
		sbSql.append("          AND A.TRANS_TYPE = 'I001' \n");
		sbSql.append("          AND A.SGANO = -1 \n");
		sbSql.append("        GROUP BY B.UPJANG \n");
		sbSql.append("      ) D \n");
		sbSql.append("       --D1.전월검수 \n");
		sbSql.append("     ,(SELECT /*+ INDEX(A HLDC_PO_TRANSACTION_PT_I8) */ \n");
		sbSql.append("              B.UPJANG \n");
		sbSql.append("            , SUM(ROUND(DECODE(TAX_CODE,'100',1.1,1) * SALE_AMOUNT)) AS 전월검수 \n");
		sbSql.append("         FROM HLDC_PO_TRANSACTION A, FMS_UPJANG B \n");
		sbSql.append("        WHERE A.TRANS_UPJANG = B.UPJANG \n");
		sbSql.append("          AND B.HEAD_CREDIT_YN = 'N' \n");
		sbSql.append("          AND B.MAIN_UPJANG = " + nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG")) + " \n");
		sbSql.append("          AND A.TRANS_DATE BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE('" + strDate + "','YYYYMMDD'),-1),'YYYYMM\"01\"') \n");
		sbSql.append("                               AND TO_CHAR(ADD_MONTHS(TO_DATE('" + strDate + "','YYYYMMDD'),-1),'YYYYMM\"31\"') \n");
		sbSql.append("          AND A.TRANS_TYPE = 'I001' \n");
		sbSql.append("          AND A.SGANO = -1 \n");
		sbSql.append("        GROUP BY B.UPJANG \n");
		sbSql.append("      ) D1 \n");
		sbSql.append("       --E.당월 발주 \n");
		sbSql.append("     ,(SELECT B.UPJANG \n");
		sbSql.append("            , SUM(ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND((A.CENTER_DELI_QTY + A.DIRECT_DELI_QTY - A.DELIVERED_QTY - A.UNDELIVERED_QTY) * A.SALE_PRICE))) AS 당월발주 \n");
		sbSql.append("         FROM HLDC_PO_PO A, FMS_UPJANG B \n");
		sbSql.append("        WHERE A.RC_UPJANG = B.UPJANG \n");
		sbSql.append("          AND B.HEAD_CREDIT_YN = 'N' \n");
		sbSql.append("          AND B.MAIN_UPJANG = " + nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG")) + " \n");
		sbSql.append("          AND A.NEED_DATE BETWEEN SUBSTR('" + strDate + "',1,6)||'01' AND '" + strDate + "' \n");
		sbSql.append("          AND A.LINE_STATUS BETWEEN '006' AND '010' \n");
		sbSql.append("        GROUP BY B.UPJANG \n");
		sbSql.append("      ) E \n");
		sbSql.append("       --E1.전월 발주 \n");
		sbSql.append("     ,(SELECT B.UPJANG \n");
		sbSql.append("            , SUM(ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND((A.CENTER_DELI_QTY + A.DIRECT_DELI_QTY - A.DELIVERED_QTY - A.UNDELIVERED_QTY) * A.SALE_PRICE))) AS 전월발주 \n");
		sbSql.append("         FROM HLDC_PO_PO A, FMS_UPJANG B \n");
		sbSql.append("        WHERE A.RC_UPJANG = B.UPJANG \n");
		sbSql.append("          AND B.HEAD_CREDIT_YN = 'N' \n");
		sbSql.append("          AND B.MAIN_UPJANG = " + nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG")) + " \n");
		sbSql.append("          AND A.NEED_DATE BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE('" + strDate + "','YYYYMMDD'),-1),'YYYYMM\"01\"') \n");
		sbSql.append("                              AND TO_CHAR(ADD_MONTHS(TO_DATE('" + strDate + "','YYYYMMDD'),-1),'YYYYMM\"31\"') \n");
		sbSql.append("          AND A.LINE_STATUS BETWEEN '006' AND '010' \n");
		sbSql.append("        GROUP BY B.UPJANG \n");
		sbSql.append("      ) E1 \n");
		sbSql.append("       --F.당월주문 \n");
		sbSql.append("     ,(SELECT B.UPJANG \n");
		sbSql.append("            , SUM(ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND((A.CENTER_DELI_QTY + A.DIRECT_DELI_QTY - A.DELIVERED_QTY - A.UNDELIVERED_QTY) * A.SALE_PRICE))) AS 당월주문 \n");
		sbSql.append("         FROM HLDC_PO_PR A, FMS_UPJANG B \n");
		sbSql.append("        WHERE A.RC_UPJANG = B.UPJANG \n");
		sbSql.append("          AND B.HEAD_CREDIT_YN = 'N' \n");
		sbSql.append("          AND B.MAIN_UPJANG = " + nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG")) + " \n");
		sbSql.append("          AND A.NEED_DATE BETWEEN SUBSTR('" + strDate + "',1,6)||'01' AND '" + strDate + "' \n");
		sbSql.append("          AND A.LINE_STATUS BETWEEN '006' AND '010' \n");
		sbSql.append("        GROUP BY B.UPJANG \n");
		sbSql.append("      ) F \n");
		sbSql.append("       --F1.전월주문 \n");
		sbSql.append("     ,(SELECT B.UPJANG \n");
		sbSql.append("            , SUM(ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND((A.CENTER_DELI_QTY + A.DIRECT_DELI_QTY - A.DELIVERED_QTY - A.UNDELIVERED_QTY) * A.SALE_PRICE))) AS 전월주문 \n");
		sbSql.append("         FROM HLDC_PO_PR A, FMS_UPJANG B \n");
		sbSql.append("        WHERE A.RC_UPJANG = B.UPJANG \n");
		sbSql.append("          AND B.HEAD_CREDIT_YN = 'N' \n");
		sbSql.append("          AND B.MAIN_UPJANG = " + nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG")) + " \n");
		sbSql.append("          AND A.NEED_DATE BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE('" + strDate + "','YYYYMMDD'),-1),'YYYYMM\"01\"') \n");
		sbSql.append("                              AND TO_CHAR(ADD_MONTHS(TO_DATE('" + strDate + "','YYYYMMDD'),-1),'YYYYMM\"31\"') \n");
		sbSql.append("          AND A.LINE_STATUS BETWEEN '006' AND '010' \n");
		sbSql.append("        GROUP BY B.UPJANG \n");
		sbSql.append("      ) F1 \n");
		sbSql.append(" WHERE A.UPJANG = B.UPJANG(+) \n");
		sbSql.append("   AND A.UPJANG = C.UPJANG(+) \n");
		sbSql.append("   AND A.UPJANG = CC.UPJANG(+) \n");
		sbSql.append("   AND A.UPJANG = C1.UPJANG(+) \n");
		sbSql.append("   AND A.UPJANG = D.UPJANG(+) \n");
		sbSql.append("   AND A.UPJANG = D1.UPJANG(+) \n");
		sbSql.append("   AND A.UPJANG = E.UPJANG(+) \n");
		sbSql.append("   AND A.UPJANG = E1.UPJANG(+) \n");
		sbSql.append("   AND A.UPJANG = F.UPJANG(+) \n");
		sbSql.append("   AND A.UPJANG = F1.UPJANG(+) \n");
		sbSql.append("   AND A.HEAD_CREDIT_YN = 'N' \n");
		sbSql.append("   AND A.MAIN_UPJANG = " + nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG")) + " \n");
		
out_vl.add("fa_Sql", sbSql.toString());
		System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_ListTmp = this.makeDataSet(rs, "ds_ListTmp");
		//FileLog.println("d:\\BBB.txt", ds_ListTmp);

		/**종료**/
		out_dl.add(ds_ListTmp);
		out_dl.add(ds_List);
		this.setResultMessage(0, "OK", out_vl);

	}
	catch(Exception ex)
	{
		ex.printStackTrace();
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
	}

	proc_output(response,out,out_vl,out_dl);

%>