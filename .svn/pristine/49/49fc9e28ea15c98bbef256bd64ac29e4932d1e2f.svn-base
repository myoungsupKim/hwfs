<%
//-----------------------------------------------------------------------------
//■ 시스템명     : 단가관리/공급업체 관리/ 공급업체 실적집계
//■ 프로그램ID   : FMP00610V_T001.jsp
//■ 프로그램명   : 공급업체 실적집계
//■ 작성일자     : 2008.02.13
//■ 작성자       : 노규완
//■ 이력관리     : 2008.02.13
//-----------------------------------------------------------------------------*/
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
		DataSet ds_cond     = in_dl.get("ds_cond");
		//입력 파라메터
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		String sType        = nullToBlank(in_vl.getString("sType"));


		//out 데이타
		DataSet ds_list;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		//
		String sMUpjang = nullToBlank(ds_cond.getString(0, "MAIN_UPJANG"));			//업장
		String sUpjang = nullToBlank(ds_cond.getString(0, "UPJANG"));			//업장		
		String sSdate = nullToBlank(ds_cond.getString(0, "SDATE"));				//입고예정일(시작일)
		String sEdate = nullToBlank(ds_cond.getString(0, "EDATE"));				//입고예정일(종료일)		
		String sOtcust = nullToBlank(ds_cond.getString(0, "OTCUSTCD"));			//공급업체		

// alert기능	 System.out.println(nullToBlank(ds_cond.getString(0, "ITEM_DETAIL")));
/*		//현재 공급업체 품목은 운영율 적용안됨	
		String sPrice;
		if (sType.equals("운영"))
			sPrice = "DECODE(NVL(E.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(E.OP_RATE,0) / 100),E.CEIL_VAL),E.OP_PRICE)";
		else
			sPrice = "A.SALE_PRICE";
		//내역조회
		sbSql.append( "SELECT A.UPJANG \n");
		sbSql.append( "     , B.UPJANGNM_DISP \n");
		sbSql.append( "     , A.SUBINV_CODE \n");
		sbSql.append( "     , C.SUBINV_NAME_DISP \n");

		sbSql.append( "     , SUM(ROUND(A.PR_QTY * " + sPrice + ")) AS IN_SUM \n");
		sbSql.append( "     , SUM(ROUND(DECODE(A.TAX_CODE,'100',0,1) * ROUND(A.PR_QTY * " + sPrice + "))) AS TAX_N \n");
		sbSql.append( "     , SUM(ROUND(DECODE(A.TAX_CODE,'100',1,0) * ROUND(A.PR_QTY * " + sPrice + "))) AS TAX_Y \n");
		sbSql.append( "     , SUM(ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * ROUND(A.PR_QTY * " + sPrice + "))) AS VAT \n");
		sbSql.append( "     , SUM(ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.PR_QTY * " + sPrice + "))) AS AMT_SUM \n");

		sbSql.append( "  FROM FMP_OTCUST_PR A, FMS_UPJANG B, FMS_SUBINVENTORY C \n");
		if (sType.equals("운영"))
			sbSql.append( "     , FMU_OP_RATE E \n");
		sbSql.append( " WHERE (1=1) \n");
		sbSql.append( "   AND A.UPJANG = B.UPJANG \n");
		sbSql.append( "   AND A.SUBINV_CODE = C.SUBINV_CODE \n");
        if (!sMUpjang.equals(""))
            sbSql.append("   AND B.MAIN_UPJANG = '" + sMUpjang + "' \n");
		if (sType.equals("운영"))
		{
			sbSql.append( "   AND A.UPJANG = E.UPJANG(+) \n");
			sbSql.append( "   AND A.NEED_DATE BETWEEN E.SDATE(+) AND E.EDATE(+) \n");
			sbSql.append( "   AND A.ITEM_CODE BETWEEN E.ITEM_CODE(+) AND E.ITEM_CODE(+)||'9999' \n");
			sbSql.append( "   AND E.USE_YN(+) = 'Y' \n");
		}
		sbSql.append( "   AND A.NEED_DATE BETWEEN '" + sSdate + "' AND '" + sEdate + "' \n");		
		if ( (! sUpjang.equals("")) && (! sUpjang.equals("%")))							
			sbSql.append( "   AND A.UPJANG = " + sUpjang + " \n");
		sbSql.append( "   AND A.OTCUSTCD = '" + sOtcust + "' \n");
		sbSql.append( "   AND A.LINE_STATUS <> '003' \n");
		sbSql.append( " GROUP BY A.UPJANG, B.UPJANGNM_DISP, A.SUBINV_CODE, C.SUBINV_NAME_DISP \n");		
*/

		//내역조회
		if (sType.equals("001"))
		{
			sbSql.append( "SELECT A.UPJANG \n");
			sbSql.append( "     , A.UPJANGNM_DISP \n");
			sbSql.append( "     , A.SUBINV_CODE \n");
			sbSql.append( "     , C.SUBINV_NAME_DISP \n");
		}
		else
		{
			sbSql.append( "SELECT A.NEED_DATE AS UPJANG \n");
			sbSql.append( "     , A.NEED_DATE AS UPJANGNM_DISP \n");
			sbSql.append( "     , A.NEED_DATE AS SUBINV_CODE \n");
			sbSql.append( "     , A.NEED_DATE AS SUBINV_NAME_DISP \n");
		}
		sbSql.append( "     , SUM(ROUND(A.PO_QTY * NVL(D.UNIT_PRICE,0))) AS IN_SUM0 \n");
		sbSql.append( "     , SUM(DECODE(A.TAX_CODE,'100',0,1) * ROUND(A.PO_QTY * NVL(D.UNIT_PRICE,0))) AS TAX_N0 \n");
		sbSql.append( "     , SUM(DECODE(A.TAX_CODE,'100',1,0) * ROUND(A.PO_QTY * NVL(D.UNIT_PRICE,0))) AS TAX_Y0 \n");

		sbSql.append( "     , SUM(A.SALE_AMOUNT) AS IN_SUM \n");
		sbSql.append( "     , SUM(DECODE(A.TAX_CODE,'100',0,1) * A.SALE_AMOUNT) AS TAX_N \n");
		sbSql.append( "     , SUM(DECODE(A.TAX_CODE,'100',1,0) * A.SALE_AMOUNT) AS TAX_Y \n");
		sbSql.append( "     , SUM(ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * A.SALE_AMOUNT)) AS VAT \n");
		sbSql.append( "     , SUM(ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * A.SALE_AMOUNT)) AS AMT_SUM \n");
		
		sbSql.append( "  FROM (SELECT B.UPJANGNM_DISP, B.MAIN_UPJANG, B.OTCUST_PRICE_UPJANG, A.* \n");
		sbSql.append( "          FROM FMP_OTCUST_PR A, FMS_UPJANG B \n");
		sbSql.append( "         WHERE A.UPJANG = B.UPJANG \n");
		sbSql.append( "           AND A.NEED_DATE BETWEEN '" + sSdate + "' AND '" + sEdate + "' \n");		
		if (!sMUpjang.equals(""))
			sbSql.append("            AND B.MAIN_UPJANG = '" + sMUpjang + "' \n");
		if ( (! sUpjang.equals("")) && (! sUpjang.equals("%")))							
			sbSql.append( "       AND A.UPJANG = " + sUpjang + " \n");
		sbSql.append( "           AND A.OTCUSTCD = '" + sOtcust + "' \n");
		sbSql.append( "           AND A.LINE_STATUS <> '003' \n");
		sbSql.append( "       ) A \n");
		sbSql.append( "     , FMS_SUBINVENTORY C \n");
		sbSql.append( "     , FMP_OTCUST_PRICE D \n");
		sbSql.append( " WHERE A.SUBINV_CODE = C.SUBINV_CODE \n");
		sbSql.append( "   AND A.OTCUST_PRICE_UPJANG = D.UPJANG(+) \n");
		sbSql.append( "   AND A.NEED_DATE BETWEEN D.SDATE(+) AND NVL(D.EDATE(+),'20301231') \n");
		sbSql.append( "   AND A.ITEM_CODE = D.ITEM_CODE(+) \n");
		if (sType.equals("001"))
			sbSql.append( " GROUP BY A.UPJANG, A.UPJANGNM_DISP, A.SUBINV_CODE, C.SUBINV_NAME_DISP \n");
		else
			sbSql.append( " GROUP BY A.NEED_DATE \n");		

out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
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
