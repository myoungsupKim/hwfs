<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/매출통계
■ 프로그램ID   : MAO00040V_T001.jsp
■ 프로그램명   : 발주예정 조회(영업사원)
■ 작성일자     : 2012-03-09
■ 작성자       : 박은규
■ 이력관리     : 2012-03-09 박은규 - 최초개발 (CH201203_00081)
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

		//내역조회
		sbSql.delete(0, sbSql.length());
		sbSql.append("WITH A AS \n");
		sbSql.append("( \n");
		sbSql.append("SELECT (SELECT Z.UPJANGNM_DISP FROM FMS_UPJANG Z WHERE Z.UPJANG = D.MAIN_UPJANG) AS MAIN_UPJANGNM \n");
		sbSql.append("     , D.UPJANGNM_DISP AS UPJANGNM\n");
		sbSql.append("     , A.SUBINV_CODE \n");			
		sbSql.append("     , C.SUBINV_NAME_DISP AS SUBINV_NAME \n");			
		sbSql.append("     , A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM, B.ORIGIN_NAT \n");
		sbSql.append("     , A.SALE_PRICE \n");
		sbSql.append("     , A.PR_QTY \n");
		sbSql.append("     , ROUND(A.PR_QTY * A.SALE_PRICE) AS SALE_AMOUNT \n");
		sbSql.append("     , ROUND(A.PR_QTY * A.UNIT_PRICE) AS UNIT_AMOUNT \n");
		sbSql.append("     , ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * ROUND(A.PR_QTY * A.SALE_PRICE)) AS SALE_VAT \n");
		sbSql.append("     , ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.PR_QTY * A.SALE_PRICE)) AS SALE_TOT \n");
		sbSql.append("     , ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.PR_QTY * A.UNIT_PRICE)) AS UNIT_TOT \n");
		sbSql.append("     , D.PART_SALES_SABUN \n");			
	//sbSql.append("  FROM HLDC_PO_PR A, HLDC_PO_ITEM_MST B, FMS_SUBINVENTORY C, FMS_UPJANG D \n");
		sbSql.append("  FROM SO_PR A, HLDC_PO_ITEM_MST B, FMS_SUBINVENTORY C, FMS_UPJANG D \n");
/*
		sbSql.append("     , (SELECT Z.CODE, Z.SET1 FROM SCC_COMMON_CODE Z \n");
		sbSql.append("         WHERE Z.GROUP_CODE = 'FM0022' AND Z.USE_YN = 'Y') E \n");
*/
		sbSql.append("     , HLDC_SC_DEPT_V F \n");		
		sbSql.append(" WHERE A.ITEM_CODE = B.ITEM_CODE \n");			
		sbSql.append("   AND A.SUBINV_CODE = C.SUBINV_CODE \n");			
		sbSql.append("   AND A.RC_UPJANG = D.UPJANG \n");
//		sbSql.append("   AND D.PART_CODE = E.CODE \n");
		//sbSql.append("   AND E.SET1 = '" + nullToBlank(ds_Cond.getString(0, "TEAM")) + "' \n");
		//sbSql.append("   AND D.DEPT_ID = '" + nullToBlank(ds_Cond.getString(0, "TEAM")) + "' \n");
		sbSql.append("   AND D.DEPT_ID = F.DEPT_ID \n");
		if (! nullToBlank(ds_Cond.getString(0, "TEAM")).equals(""))			
			sbSql.append("   AND F.TM_CD = '" + nullToBlank(ds_Cond.getString(0, "TEAM")) + "' \n");
		if ( ds_Cond.getString(0, "CC").equals("CC") && !nullToBlank(ds_Cond.getString(0, "CC")).equals(""))			
			sbSql.append("   AND F.CC_CD = '" + nullToBlank(ds_Cond.getString(0, "CC")) + "' \n");
		if (! nullToBlank(ds_Cond.getString(0, "SABUN")).equals(""))			
			sbSql.append("   AND D.PART_SALES_SABUN = '" + nullToBlank(ds_Cond.getString(0, "SABUN")) + "' \n");			
		if (! nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG")).equals(""))			
			sbSql.append("   AND D.MAIN_UPJANG = '" + nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG")) + "' \n");
		if (! nullToBlank(ds_Cond.getString(0, "UPJANG")).equals(""))			
			sbSql.append("   AND D.UPJANG = '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "' \n");		
		sbSql.append("   AND A.NEED_DATE BETWEEN '" + nullToBlank(ds_Cond.getString(0, "NEED_DATE_S")) + "' AND '" + nullToBlank(ds_Cond.getString(0, "NEED_DATE_E")) + "' \n");
		sbSql.append("   AND A.PR_QTY > 0 \n");
		//sbSql.append("   AND A.LINE_STATUS > '003' \n");
		if (! nullToBlank(ds_Cond.getString(0, "SO_STATUS")).equals("")){	
			sbSql.append("   AND A.SO_STATUS IN ('" + nullToBlank(ds_Cond.getString(0, "SO_STATUS")) + "') /*001:주문신청*/\n");
		}else{
			sbSql.append("   AND A.SO_STATUS IN ('001','007','008') /*001:주문신청*/\n");
		}
		sbSql.append(") \n");
		sbSql.append("SELECT GROUPING(A.MAIN_UPJANGNM) + GROUPING(A.UPJANGNM) + GROUPING(A.SUBINV_CODE) AS GB \n");
        sbSql.append("     , CASE \n");
        sbSql.append("         WHEN GROUPING(A.MAIN_UPJANGNM) = 1 THEN '합계' \n");
        sbSql.append("         ELSE A.MAIN_UPJANGNM \n");
        sbSql.append("       END AS MAIN_UPJANGNM \n");
        sbSql.append("     , CASE \n");
        sbSql.append("         WHEN GROUPING(A.MAIN_UPJANGNM) = 1 AND GROUPING(A.UPJANGNM) = 1 THEN NULL \n");
        sbSql.append("         WHEN GROUPING(A.MAIN_UPJANGNM) = 0 AND GROUPING(A.UPJANGNM) = 1 THEN '소계' \n");
        sbSql.append("         ELSE A.UPJANGNM \n");
        sbSql.append("       END AS UPJANGNM \n");
        sbSql.append("     , CASE \n");
        sbSql.append("         WHEN GROUPING(A.UPJANGNM) = 1 AND GROUPING(A.SUBINV_CODE) = 1 THEN NULL \n");
        sbSql.append("         WHEN GROUPING(A.UPJANGNM) = 0 AND GROUPING(A.SUBINV_CODE) = 1 THEN '소계' \n");
        sbSql.append("         ELSE A.SUBINV_NAME \n");
        sbSql.append("       END AS SUBINV_NAME \n");
        sbSql.append("     , A.ITEM_CODE \n");
        sbSql.append("     , A.ITEM_NAME \n");
        sbSql.append("     , A.ITEM_SIZE \n");
        sbSql.append("     , A.PO_UOM \n");
        sbSql.append("     , A.ORIGIN_NAT \n");
        sbSql.append("     , A.SALE_PRICE \n");
        sbSql.append("     , SUM(A.PR_QTY) AS PR_QTY \n");
        sbSql.append("     , SUM(A.SALE_AMOUNT) AS SALE_AMOUNT \n");
        sbSql.append("     , SUM(A.SALE_VAT) AS SALE_VAT \n");
        sbSql.append("     , SUM(A.SALE_TOT) AS SALE_TOT \n");
        sbSql.append("     , SUM(A.SALE_AMOUNT) - SUM(A.UNIT_AMOUNT) AS MARGIN_TOT \n");
        sbSql.append("     , ROUND( DECODE(SUM(A.SALE_AMOUNT),0,0,(SUM(A.SALE_AMOUNT)-SUM(A.UNIT_AMOUNT))/SUM(A.SALE_AMOUNT)*100) ,1) AS MARGIN_RATE \n");
        sbSql.append("     , (SELECT Z.SABUN||' '||Z.NM_KOR FROM HLDC_HR_PERSONAL Z WHERE Z.SABUN = A.PART_SALES_SABUN) AS SALE_SABUNNM \n");
        sbSql.append("  FROM A  \n");
        sbSql.append(" GROUP BY ROLLUP(A.MAIN_UPJANGNM, A.UPJANGNM, (A.SUBINV_CODE, A.SUBINV_NAME, A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM, A.SALE_PRICE, A.PART_SALES_SABUN, A.ORIGIN_NAT)) \n");
        sbSql.append(" ORDER BY A.MAIN_UPJANGNM, A.UPJANGNM, A.SUBINV_CODE, A.ITEM_CODE \n");

out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_List = this.makeDataSet(rs, "ds_List");
		pstmt.close();
		rs.close();

		//FileLog.println("d:\\aaa.txt", ds_list);

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
