<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/공통
■ 프로그램ID   : FMZ_CREDIT_INFO_PRT_T001.jsp
■ 프로그램명   : 거래명세서 출력용 여신정보 조회(FMS_CRTCRDINFO_PRO 프로시져 내용과 동일)
■ 작성일자     : 2008.01.30
■ 작성자       : 박은규
■ 이력관리     : 2008.01.30
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
		DataSet ds_cond     = in_dl.get("ds_Cond");
		//입력 파라메터
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		String sIgnorCtrl   = nullToBlank(in_vl.getString("sIgnorCtrl"));
		//String strDate      = nullToBlank(in_vl.getString("strDate"));
		//FileLog.println("d:\\aaa.txt", ds_cond);

		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		//본사통합 여신관리 여부
		sbSql.append("SELECT NVL(HEAD_CREDIT_YN,'N') AS HEAD_CREDIT_YN \n");
		sbSql.append("     , MAIN_UPJANG \n");
		sbSql.append("  FROM FMS_UPJANG \n");
		sbSql.append(" WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");

out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
//		if(! rs.next())
//		{
//			out_vl.add("v_ErrMsg", "여신정보 조회오류...\n관리자에게 연락하세요.");
//		   	this.setResultMessage(0, "OK", out_vl);
//		   	if (true) return;
//		}
		rs.next();
		String sHeadYn = rs.getString("HEAD_CREDIT_YN");
		String sMainUpjang = rs.getString("MAIN_UPJANG");
		rs.close();
		pstmt.close();

		//본사통합인 경우 업장목록을 IN조건으로 만든다.
		String sUpjangList = ""; 
		if (sHeadYn.equals("Y"))
		{
			sbSql.delete(0,sbSql.length());
			sbSql.append("SELECT UPJANG FROM FMS_UPJANG \n");
			sbSql.append(" WHERE MAIN_UPJANG = " + sMainUpjang + " \n");
			sbSql.append("   AND HEAD_CREDIT_YN = 'Y' \n");
			pstmt = conn.prepareStatement(sbSql.toString());
			rs = pstmt.executeQuery();
			while (rs.next())
			{
				sUpjangList += ", " + rs.getString("UPJANG");
			}
			sUpjangList = "(" + sUpjangList.substring(1) + ")";
			rs.close();
			pstmt.close();
		}
		
		//여신체크할 최종 발주일자 조회
		sbSql.delete(0,sbSql.length());
		sbSql.append("SELECT MAX(NEED_DATE) AS NEED_DATE \n");
		sbSql.append("  FROM HLDC_PO_PR \n");
		if (sHeadYn.equals("Y"))
			sbSql.append(" WHERE RC_UPJANG IN " + sUpjangList + " \n");
		else
			sbSql.append(" WHERE RC_UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
		sbSql.append("   AND NEED_DATE BETWEEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AND GREATEST(TO_CHAR(SYSDATE+31,'YYYYMMDD'),'" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "') \n");
		sbSql.append("   AND LINE_STATUS <> '003' --신청취소 \n");
out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		String strDate;
		if(rs.next())
			strDate = rs.getString("NEED_DATE");
		else
			strDate = nullToBlank(ds_cond.getString(0, "NEED_DATE"));
		rs.close();
		pstmt.close();

		String sNeedDate = nullToBlank(ds_cond.getString(0, "NEED_DATE")); 

		//내역조회(속도관계상 운영율은 적용하지 않는다.)
		sbSql.delete(0,sbSql.length());
		sbSql.append("SELECT CASE WHEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' BETWEEN NVL(A.CREDIT_START,'00000000') AND NVL(A.CREDIT_END,'99999999') THEN NVL(A.CREDIT_AMOUNT,0) + NVL(B.CREDIT_EXT_AMOUNT,0) ELSE 0 END AS CREDIT_AMOUNT_TOT \n");//총 여신책정금액
		sbSql.append("     , NVL(C.PRE_SALE_AMT,0) - NVL(C1.PRE_RCP_AMT,0) AS RMN_AMT \n"); //전월 기준으로 외매잔액
		sbSql.append("     , NVL(D.TR_AMT,0) + NVL(C3.SALE_AMT,0) AS TR_AMT \n"); //당월 매출+입고금액
		sbSql.append("     , NVL(E.PO_AMT,0) AS PO_AMT \n"); //매입예정(발주)
		sbSql.append("     , NVL(F.PR_AMT,0) AS PR_AMT \n"); //매입예정(신청)
		sbSql.append("     , CASE WHEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' BETWEEN NVL(A.CREDIT_START,'00000000') AND NVL(A.CREDIT_END,'99999999') THEN NVL(A.CREDIT_AMOUNT,0) + NVL(B.CREDIT_EXT_AMOUNT,0) ELSE 0 END \n"); //가용여신
		sbSql.append("     - NVL(C.PRE_SALE_AMT,0) + NVL(C1.PRE_RCP_AMT,0) - NVL(C3.SALE_AMT,0) + NVL(C2.RCP_AMT,0) - NVL(D.TR_AMT,0) - NVL(E.PO_AMT,0) - NVL(F.PR_AMT,0) AS CREDIT_RMN_AMT \n"); //가용여신
		sbSql.append("     , '우리은행  '||SC_CRYPTO_FUN('DEC', A.ACNTCD_ENC , '3')||'  한화호텔앤드리조트(주)' AS ACNTCD \n"); //계좌정보
		sbSql.append("     , NVL(C2.RCP_AMT,0) AS RCP_AMT \n");//당월입금
		if (sHeadYn.equals("Y"))
		{
			sbSql.append("  FROM FMS_UPJANG A \n");
			sbSql.append("       --B.여신연장정보 \n");
			sbSql.append("     ,(SELECT SUM(A.CREDIT_EXT_DAYS) AS CREDIT_EXT_DAYS \n");
			sbSql.append("            , SUM(A.CREDIT_EXT_AMOUNT) AS CREDIT_EXT_AMOUNT \n");
			sbSql.append("         FROM FMS_CREDIT_EXT A \n");
			sbSql.append("        WHERE A.UPJANG = " + sMainUpjang + " \n");
			//sbSql.append("          AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' BETWEEN A.SUPPLY_START AND A.SUPPLY_END \n");
			sbSql.append("          AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN A.SUPPLY_START AND A.SUPPLY_END \n");
			sbSql.append("          AND A.APPR_YN = 'Y' \n");
			sbSql.append("      ) B \n");
			sbSql.append("       --C.전월매출정보 \n");
			sbSql.append("     ,(SELECT SUM(A.BILL_AMOUNT + A.BILL_VAT) AS PRE_SALE_AMT \n");
			sbSql.append("         FROM HLDC_FM_BILL A \n");
			sbSql.append("        WHERE A.UPJANG IN " + sUpjangList + " \n");
			sbSql.append("          AND A.BILL_DATE < SUBSTR('" + sNeedDate + "',1,6)||'01' \n");
			sbSql.append("          AND A.CANCEL_FLAG = 'N' \n");
			sbSql.append("          AND A.DCGUBUN = '2' \n");
			sbSql.append("      ) C \n");
			sbSql.append("       --C1.전월입금정보 \n");
			sbSql.append("     ,(SELECT SUM(A.AMOUNT) AS PRE_RCP_AMT \n");
			sbSql.append("         FROM HLDC_FM_RECEIPT A \n");
			sbSql.append("        WHERE A.UPJANG IN " + sUpjangList + " \n");
			sbSql.append("          AND A.RECEIPT_DATE < SUBSTR('" + sNeedDate + "',1,6)||'01' \n");
			sbSql.append("          AND A.DCGUBUN = '1' \n");
			sbSql.append("      ) C1 \n");
			sbSql.append("       --C2.당월입금정보 \n");
			sbSql.append("     ,(SELECT SUM(A.AMOUNT) AS RCP_AMT \n");
			sbSql.append("         FROM HLDC_FM_RECEIPT A \n");
			sbSql.append("        WHERE A.UPJANG IN " + sUpjangList + " \n");
			sbSql.append("          AND A.RECEIPT_DATE BETWEEN SUBSTR('" + sNeedDate + "',1,6)||'01' \n");
			sbSql.append("                                 AND GREATEST('" + strDate + "',TO_CHAR(LAST_DAY(SYSDATE),'YYYYMMDD')) \n");
			sbSql.append("          AND A.DCGUBUN = '1' \n");
			sbSql.append("      ) C2 \n");
			sbSql.append("       --C3.당월매출정보 \n");
			sbSql.append("     ,(SELECT SUM(A.BILL_AMOUNT + A.BILL_VAT) AS SALE_AMT \n");
			sbSql.append("         FROM HLDC_FM_BILL A \n");
			sbSql.append("        WHERE A.UPJANG IN " + sUpjangList + " \n");
			sbSql.append("          AND A.BILL_DATE BETWEEN SUBSTR('" + sNeedDate + "',1,6)||'01' \n");
			sbSql.append("                              AND GREATEST('" + strDate + "',TO_CHAR(LAST_DAY(SYSDATE),'YYYYMMDD')) \n");
			sbSql.append("          AND A.CANCEL_FLAG = 'N' \n");
			sbSql.append("          AND A.DCGUBUN = '2' \n");
			sbSql.append("      ) C3 \n");
			sbSql.append("       --D.당월 미매출마감된 검수금액 \n");
			sbSql.append("     ,(SELECT SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(TAX_CODE,'100',1.1,1) * SALE_AMOUNT)) AS TR_AMT \n");
			sbSql.append("         FROM HLDC_PO_TRANSACTION \n");
			sbSql.append("        WHERE TRANS_DATE BETWEEN SUBSTR('" + sNeedDate + "',1,6)||'01' AND '" + strDate + "' \n");
			sbSql.append("          AND TRANS_UPJANG IN " + sUpjangList + " \n");			
			sbSql.append("          AND (TRANS_TYPE = 'I001' OR (TRANS_TYPE LIKE '_002' AND SOURCE_TYPE = 'PO')) \n");
			sbSql.append("          AND SGANO = -1 \n");
			sbSql.append("          AND (SELECT CREDIT_AMOUNT_CONTROL_YN FROM FMS_UPJANG WHERE UPJANG =  " + sMainUpjang + ") = 'Y' \n");
			sbSql.append("      ) D \n");
			sbSql.append("       --E.당월 미검수 발주금액 \n");
			sbSql.append("     ,(SELECT SUM(ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND((A.CENTER_DELI_QTY + A.DIRECT_DELI_QTY - A.DELIVERED_QTY - A.UNDELIVERED_QTY) * A.SALE_PRICE))) AS PO_AMT \n");
			sbSql.append("         FROM HLDC_PO_PO A \n");
			sbSql.append("        WHERE A.NEED_DATE BETWEEN SUBSTR('" + sNeedDate + "',1,6)||'01' AND '" + strDate + "' \n");
			sbSql.append("          AND A.RC_UPJANG IN " + sUpjangList + " \n");
			sbSql.append("          AND A.LINE_STATUS BETWEEN '006' AND '010' \n");
			sbSql.append("          AND (SELECT CREDIT_AMOUNT_CONTROL_YN FROM FMS_UPJANG WHERE UPJANG =  " + sMainUpjang + ") = 'Y' \n");
			sbSql.append("      ) E \n");
			sbSql.append("       --F.당월 미발주 주문금액 \n");
			sbSql.append("     ,(SELECT SUM(ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.PR_QTY * A.SALE_PRICE))) AS PR_AMT \n");
			sbSql.append("         FROM HLDC_PO_PR A \n");
			sbSql.append("        WHERE A.NEED_DATE BETWEEN SUBSTR('" + sNeedDate + "',1,6)||'01' AND '" + strDate + "' \n");
			sbSql.append("          AND A.RC_UPJANG IN " + sUpjangList + " \n");
			sbSql.append("          AND A.LINE_STATUS IN ('001','002','004') \n");
			sbSql.append("          AND (SELECT CREDIT_AMOUNT_CONTROL_YN FROM FMS_UPJANG WHERE UPJANG =  " + sMainUpjang + ") = 'Y' \n");
			sbSql.append("      ) F \n");
			sbSql.append(" WHERE A.UPJANG = " + sMainUpjang + " \n");
			//sbSql.append("   AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' BETWEEN NVL(A.CREDIT_START,'00000000') AND NVL(A.CREDIT_END,'99999999') \n");
		}
		else
		{
			sbSql.append("  FROM FMS_UPJANG A \n");
			sbSql.append("       --B.여신연장정보 \n");
			sbSql.append("     ,(SELECT SUM(A.CREDIT_EXT_DAYS) AS CREDIT_EXT_DAYS \n");
			sbSql.append("            , SUM(A.CREDIT_EXT_AMOUNT) AS CREDIT_EXT_AMOUNT \n");
			sbSql.append("         FROM FMS_CREDIT_EXT A \n");
			sbSql.append("        WHERE A.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
//			sbSql.append("          AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' BETWEEN A.SUPPLY_START AND A.SUPPLY_END \n");
			sbSql.append("          AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN A.SUPPLY_START AND A.SUPPLY_END \n");
			sbSql.append("          AND A.APPR_YN = 'Y' \n");
			sbSql.append("      ) B \n");
			sbSql.append("       --C.전월매출정보 \n");
			sbSql.append("     ,(SELECT SUM(A.BILL_AMOUNT + A.BILL_VAT) AS PRE_SALE_AMT \n");
			sbSql.append("         FROM HLDC_FM_BILL A \n");
			sbSql.append("        WHERE A.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
			sbSql.append("          AND A.BILL_DATE < SUBSTR('" + sNeedDate + "',1,6)||'01' \n");
			sbSql.append("          AND A.CANCEL_FLAG = 'N' \n");
			sbSql.append("          AND A.DCGUBUN = '2' \n");
			sbSql.append("      ) C \n");
			sbSql.append("       --C1.전월입금정보 \n");
			sbSql.append("     ,(SELECT SUM(A.AMOUNT) AS PRE_RCP_AMT \n");
			sbSql.append("         FROM HLDC_FM_RECEIPT A \n");
			sbSql.append("        WHERE A.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
			sbSql.append("          AND A.RECEIPT_DATE < SUBSTR('" + sNeedDate + "',1,6)||'01' \n");
			sbSql.append("          AND A.DCGUBUN = '1' \n");
			sbSql.append("      ) C1 \n");
			sbSql.append("       --C2.당월입금정보 \n");
			sbSql.append("     ,(SELECT SUM(A.AMOUNT) AS RCP_AMT \n");
			sbSql.append("         FROM HLDC_FM_RECEIPT A \n");
			sbSql.append("        WHERE A.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
			sbSql.append("          AND A.RECEIPT_DATE BETWEEN SUBSTR('" + sNeedDate + "',1,6)||'01' \n");
			sbSql.append("                                 AND GREATEST('" + strDate + "',TO_CHAR(LAST_DAY(SYSDATE),'YYYYMMDD')) \n");
			sbSql.append("          AND A.DCGUBUN = '1' \n");
			sbSql.append("      ) C2 \n");
			sbSql.append("       --C3.당월매출정보 \n");
			sbSql.append("     ,(SELECT SUM(A.BILL_AMOUNT + A.BILL_VAT) AS SALE_AMT \n");
			sbSql.append("         FROM HLDC_FM_BILL A \n");
			sbSql.append("        WHERE A.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
			sbSql.append("          AND A.BILL_DATE BETWEEN SUBSTR('" + sNeedDate + "',1,6)||'01' \n");
			sbSql.append("                              AND GREATEST('" + strDate + "',TO_CHAR(LAST_DAY(SYSDATE),'YYYYMMDD')) \n");
			sbSql.append("          AND A.CANCEL_FLAG = 'N' \n");
			sbSql.append("          AND A.DCGUBUN = '2' \n");
			sbSql.append("      ) C3 \n");
			sbSql.append("       --D.당월 미매출마감된 검수금액 \n");
			sbSql.append("     ,(SELECT SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(TAX_CODE,'100',1.1,1) * SALE_AMOUNT)) AS TR_AMT \n");
			sbSql.append("         FROM HLDC_PO_TRANSACTION \n");
			sbSql.append("        WHERE TRANS_DATE BETWEEN SUBSTR('" + sNeedDate + "',1,6)||'01' AND '" + strDate + "' \n");
			sbSql.append("          AND TRANS_UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");			
			sbSql.append("          AND (TRANS_TYPE = 'I001' OR (TRANS_TYPE LIKE '_002' AND SOURCE_TYPE = 'PO')) \n");
			sbSql.append("          AND SGANO = -1 \n");
			sbSql.append("          AND (SELECT CREDIT_AMOUNT_CONTROL_YN FROM FMS_UPJANG WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + ") = 'Y' \n");
			sbSql.append("      ) D \n");
			sbSql.append("       --E.당월 미검수 발주금액 \n");
			sbSql.append("     ,(SELECT SUM(ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND((A.CENTER_DELI_QTY + A.DIRECT_DELI_QTY - A.DELIVERED_QTY - A.UNDELIVERED_QTY) * A.SALE_PRICE))) AS PO_AMT \n");
			sbSql.append("         FROM HLDC_PO_PO A \n");
			sbSql.append("        WHERE A.NEED_DATE BETWEEN SUBSTR('" + sNeedDate + "',1,6)||'01' AND '" + strDate + "' \n");
			sbSql.append("          AND A.RC_UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
			sbSql.append("          AND A.LINE_STATUS BETWEEN '006' AND '010' \n");
			sbSql.append("          AND (SELECT CREDIT_AMOUNT_CONTROL_YN FROM FMS_UPJANG WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + ") = 'Y' \n");
			sbSql.append("      ) E \n"); 
			sbSql.append("       --F.당월 미발주 주문금액 \n");
			sbSql.append("     ,(SELECT SUM(ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.PR_QTY * A.SALE_PRICE))) AS PR_AMT \n");
			sbSql.append("         FROM HLDC_PO_PR A \n");
			sbSql.append("        WHERE A.NEED_DATE BETWEEN SUBSTR('" + sNeedDate + "',1,6)||'01' AND '" + strDate + "' \n");
			sbSql.append("          AND A.RC_UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
			sbSql.append("          AND A.LINE_STATUS IN ('001','002','004') \n");
			sbSql.append("          AND (SELECT CREDIT_AMOUNT_CONTROL_YN FROM FMS_UPJANG WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + ") = 'Y' \n");
			sbSql.append("      ) F \n");
			sbSql.append(" WHERE A.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
			//sbSql.append("   AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' BETWEEN NVL(A.CREDIT_START,'00000000') AND NVL(A.CREDIT_END,'99999999') \n");
		}
		if (! sIgnorCtrl.equals("Y"))
		{
			sbSql.append("   AND A.CREDIT_CONTROL_YN = 'Y' \n");
			sbSql.append("   AND (A.CREDIT_TURN_CONTROL_YN = 'Y' OR A.CREDIT_AMOUNT_CONTROL_YN = 'Y') \n");
		}
		
out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		DataSet ds_list = this.makeDataSet(rs, "ds_List");
	
		rs.close();
		pstmt.close();

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