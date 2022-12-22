<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/단가관리/공급업체관리
■ 프로그램ID   : FMU00300E_T001.jsp
■ 프로그램명   : 제출단가 등록관리(조회)
■ 작성일자     : 2008.04.14
■ 작성자       : 박은규
■ 이력관리     : 2008.04.14
               PO_TREAT_UPJANG에 없는 건 기본 조회에서 제외되나, 일단 한번 운영율 등록된 품목은 조회되어야 한다.
               즉, 신규작업인 경우에만 PO_TREAT_UPJANG에 있어야 조회된다.
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
		//FileLog.println("d:\\aaa.txt", ds_cond);


		//out 데이타
		DataSet ds_List;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		//내역조회
		sbSql.append("SELECT /*+ DRIVING_SITE(A) */ '" + nullToBlank(ds_cond.getString(0, "SDATE")) + "' AS SDATE \n");
		sbSql.append("     , '" + nullToBlank(ds_cond.getString(0, "EDATE")) + "' AS EDATE \n");
		sbSql.append("     ,  " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " AS UPJANG \n");
		sbSql.append("     , A.ITEM_CLASS2 \n");
		sbSql.append("     ,(SELECT Z.CLASS_NAME FROM HLDC_PO_ITEM_CLASS Z WHERE Z.CLASS_CODE = A.ITEM_CLASS2) AS CLASS_NAME2 \n");
		sbSql.append("     , A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM, A.TAX_CODE, MAX(A.FROM_GB) AS FROM_GB \n");
		sbSql.append("     , SUM(A.SALE_PRICE) AS SALE_PRICE \n");
		sbSql.append("     , SUM(A.SB_PRICE) AS SB_PRICE \n");
		sbSql.append("  FROM \n");
		sbSql.append("      (SELECT /*+ DRIVING_SITE(A) INDEX(A PO_CONTRACT_FSALE_PK) */ \n");
		sbSql.append("              B.CONSUM_YN, B.ITEM_CLASS2, B.ITEM_CLASS3, B.ITEM_CLASS4 \n");
		sbSql.append("            , A.ITEM_CODE, B.ITEM_NAME, B.ITEM_SIZE, B.PO_UOM, B.TAX_CODE \n");
		sbSql.append("            , A.SALE_PRICE, 0 AS SB_PRICE \n");
		sbSql.append("            , '0000' AS OTCUSTCD \n");
		sbSql.append("            , 'A' AS FROM_GB \n");
		sbSql.append("         FROM HLDC_PO_CONTRACT_FSALE A, HLDC_PO_ITEM_MST B \n");
		sbSql.append("        WHERE A.ITEM_CODE = B.ITEM_CODE \n");
		sbSql.append("          AND A.CENTER_CODE = (SELECT A.CENTER_CODE FROM HLDC_PO_UPJANG_CENTER A, HLDC_ST_UPJANG B WHERE A.UPJANG = B.AP_UNITPRICE_UPJANG AND B.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + ") \n");
		sbSql.append("          AND A.UPJANG = (SELECT A.AP_UNITPRICE_UPJANG FROM HLDC_ST_UPJANG A WHERE A.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + ") \n");
		sbSql.append("          AND A.ITEM_CODE > ' ' \n");
		sbSql.append("          AND '" + nullToBlank(ds_cond.getString(0, "DATE")) + "' BETWEEN A.CONTRACT_START AND NVL(A.CONTRACT_END,'99999999') \n");
		sbSql.append("          AND EXISTS (SELECT /*+ DRIVING_SITE(X) INDEX(X PO_TREAT_UPJANG_PK) */ 1 FROM HLDC_PO_TREAT_UPJANG X WHERE X.ITEM_CODE = A.ITEM_CODE AND X.UPJANG = A.UPJANG) \n");
		sbSql.append("          AND A.USE_YN = 'Y' \n");
		sbSql.append("          AND A.SALE_PRICE > 0 \n");
		sbSql.append("       ----------- \n");
		sbSql.append("        UNION ALL \n");
		sbSql.append("       ----------- \n");
		sbSql.append("       SELECT B.CONSUM_YN, B.ITEM_CLASS2, B.ITEM_CLASS3, B.ITEM_CLASS4 \n");
		sbSql.append("            , A.ITEM_CODE, B.ITEM_NAME, B.ITEM_SIZE, B.PO_UOM, B.TAX_CODE \n");
		sbSql.append("            , A.SALE_PRICE, 0 AS SB_PRICE \n");
		sbSql.append("            , B.OTCUSTCD \n");
		sbSql.append("            , 'A' AS FROM_GB \n");
		sbSql.append("         FROM FMP_OTCUST_PRICE_AVA_V A, FMP_OTCUST_ITEM B \n");
		sbSql.append("            ,(SELECT A.UPJANG, A.ITEM_CODE, MAX(A.SDATE) AS SDATE \n");
		sbSql.append("                FROM FMP_OTCUST_PRICE_AVA_V A \n");
		sbSql.append("               WHERE A.UPJANG = (SELECT OTCUST_PRICE_UPJANG FROM FMS_UPJANG WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + ") \n");
		sbSql.append("                 AND A.ITEM_CODE > ' ' \n");
		sbSql.append("                 AND A.SDATE <= '" + nullToBlank(ds_cond.getString(0, "DATE")) + "' \n");
		sbSql.append("               GROUP BY A.UPJANG, A.ITEM_CODE) C \n");
		sbSql.append("        WHERE A.ITEM_CODE = B.ITEM_CODE \n");
		sbSql.append("          AND A.UPJANG = C.UPJANG \n");
		sbSql.append("          AND A.ITEM_CODE = C.ITEM_CODE \n");
		sbSql.append("          AND A.SDATE = C.SDATE \n");
		sbSql.append("          AND A.USE_YN = 'Y' \n");
		sbSql.append("       ----------- \n");
		sbSql.append("        UNION ALL \n");
		sbSql.append("       ----------- \n");
		sbSql.append("       SELECT B.CONSUM_YN, B.ITEM_CLASS2, B.ITEM_CLASS3, B.ITEM_CLASS4 \n");
		sbSql.append("            , A.ITEM_CODE, B.ITEM_NAME, B.ITEM_SIZE, B.PO_UOM, B.TAX_CODE \n");
		sbSql.append("            , 0 AS SALE_PRICE, A.SB_PRICE \n");
		sbSql.append("            , B.OTCUSTCD \n");
		sbSql.append("            , 'Z' AS FROM_GB \n");
		sbSql.append("         FROM FMU_SB_PRICE A, FMS_ITEM_V B \n");
		sbSql.append("        WHERE A.ITEM_CODE = B.ITEM_CODE \n");
		sbSql.append("          AND A.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
		sbSql.append("          AND A.SDATE = '" + nullToBlank(ds_cond.getString(0, "SDATE")) + "' \n");
		sbSql.append("          AND A.EDATE = '" + nullToBlank(ds_cond.getString(0, "EDATE")) + "' \n");
		sbSql.append("          AND A.USE_YN = 'Y' \n");
		sbSql.append("      ) A \n");
		String sOtcust = nullToBlank(ds_cond.getString(0, "OTCUSTCD"));
		if (! sOtcust.equals(""))
			sbSql.append("  WHERE A.OTCUSTCD = '" + nullToBlank(ds_cond.getString(0, "OTCUSTCD")) + "' \n");
		else
			sbSql.append("  WHERE EXISTS (SELECT 1 FROM FMP_OTCUST_LINK Z WHERE Z.OTCUSTCD = A.OTCUSTCD AND Z.USE_YN = 'Y' AND Z.UPJANG = '" + nullToBlank(ds_cond.getString(0, "MAIN_UPJANG")) + "') \n");
		sbSql.append("  GROUP BY A.CONSUM_YN, A.ITEM_CLASS2, A.ITEM_CLASS3, A.ITEM_CLASS4 \n");
		sbSql.append("         , A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM, A.TAX_CODE \n");

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
