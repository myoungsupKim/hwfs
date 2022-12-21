<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/수불관리
■ 프로그램ID   : FMP00631P_T001.jsp
■ 프로그램명   : 거래실적집계 상세조회
■ 작성일자     : 2008-07-21
■ 작성자       : 박은규
■ 이력관리     : 2008-07-21
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
		String sType        = nullToBlank(in_vl.getString("sType"));
		String sAll         = nullToBlank(in_vl.getString("sAll"));
		String sNeedDate    = nullToBlank(in_vl.getString("sNeedDate"));
		String sSubinv      = nullToBlank(in_vl.getString("sSubinv"));
		//FileLog.println("d:\\aaa.txt", ds_cond);


		//out 데이타
		DataSet ds_list;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		//
		String sOtCust = nullToBlank(ds_cond.getString(0, "OTCUSTCD"));

		//내역조회
		sbSql.append("SELECT * FROM \n");
		sbSql.append("( \n");
		if (sOtCust.equals("0000") || sOtCust.equals(""))
		{
			sbSql.append("SELECT TO_CHAR(TO_DATE(A.TRANS_DATE,'YYYYMMDD'),'YYYY-MM-DD') AS NEED_DATE \n");
			sbSql.append("     , A.SUBINV_CODE, B.SUBINV_NAME_DISP \n");
			sbSql.append("     , A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.TRANS_UOM AS PO_UOM \n");
			sbSql.append("     , DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE) AS OP_PRICE \n");
			sbSql.append("     , DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * A.TRANS_QTY AS TRANS_QTY \n");
			sbSql.append("     , DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.TRANS_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)) AS OP_AMOUNT \n");
			sbSql.append("     , DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * ROUND(A.TRANS_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))) AS OP_VAT \n");
			sbSql.append("     , DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.TRANS_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))) AS OP_TOT \n");
			sbSql.append("  FROM PO_TRANSACTION_FM@FCUS_TO_HLDC A, FMS_SUBINVENTORY@FCUS_TO_FSUS B, FMU_OP_RATE@FCUS_TO_FSUS C \n");
			sbSql.append(" WHERE A.SUBINV_CODE = B.SUBINV_CODE \n");
			sbSql.append("   AND A.TRANS_UPJANG = C.UPJANG(+) \n");
			sbSql.append("   AND A.TRANS_DATE BETWEEN C.SDATE(+) AND C.EDATE(+) \n");
			sbSql.append("   AND A.ITEM_CODE BETWEEN C.ITEM_CODE(+) AND C.ITEM_CODE(+)||'9999' \n");
			sbSql.append("   AND C.USE_YN(+) = 'Y' \n");
			if (sType.equals("001"))	//일별선택
				sbSql.append("   AND A.TRANS_DATE = '" + sNeedDate + "' \n");
			else						//월별선택
			{
				sbSql.append("   AND A.TRANS_DATE BETWEEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATET")) + "' \n");
				sbSql.append("   AND A.TRANS_DATE BETWEEN '" + sNeedDate + "'||'01' AND '" + sNeedDate + "'||'31' \n");
			}				
			sbSql.append("   AND A.TRANS_UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
			sbSql.append("   AND A.ITEM_CODE BETWEEN '010000000000' AND '019999999999' \n");
			if (! sSubinv.equals("%"))
				sbSql.append("   AND A.SUBINV_CODE = '" + sSubinv + "' \n");
			///*과세매출보정자재(자재코드70XXXXX)는 과세품목에 대한 보정 값을 직접 들고 온다.*/
			sbSql.append("UNION ALL \n");
			sbSql.append("SELECT TO_CHAR(TO_DATE(A.TRANS_DATE,'YYYYMMDD'),'YYYY-MM-DD') AS NEED_DATE \n");
			sbSql.append("     , A.SUBINV_CODE, B.SUBINV_NAME_DISP \n");
			sbSql.append("     , A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.TRANS_UOM AS PO_UOM \n");
			sbSql.append("     , DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE) AS OP_PRICE \n");
			sbSql.append("     , DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * A.TRANS_QTY AS TRANS_QTY \n");
			sbSql.append("     , A.SALE_PRICE AS OP_AMOUNT \n");
			sbSql.append("     , A.SALE_VAT AS OP_VAT \n");
			sbSql.append("     , A.SALE_PRICE + A.SALE_VAT AS OP_TOT \n");
			sbSql.append("  FROM PO_TRANSACTION_FM@FCUS_TO_HLDC A, FMS_SUBINVENTORY@FCUS_TO_FSUS B, FMU_OP_RATE@FCUS_TO_FSUS C \n");
			sbSql.append(" WHERE A.SUBINV_CODE = B.SUBINV_CODE \n");
			sbSql.append("   AND A.TRANS_UPJANG = C.UPJANG(+) \n");
			sbSql.append("   AND A.TRANS_DATE BETWEEN C.SDATE(+) AND C.EDATE(+) \n");
			sbSql.append("   AND A.ITEM_CODE BETWEEN C.ITEM_CODE(+) AND C.ITEM_CODE(+)||'9999' \n");
			sbSql.append("   AND C.USE_YN(+) = 'Y' \n");
			if (sType.equals("001"))	//일별선택
				sbSql.append("   AND A.TRANS_DATE = '" + sNeedDate + "' \n");
			else						//월별선택
			{
				sbSql.append("   AND A.TRANS_DATE BETWEEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATET")) + "' \n");
				sbSql.append("   AND A.TRANS_DATE BETWEEN '" + sNeedDate + "'||'01' AND '" + sNeedDate + "'||'31' \n");
			}				
			sbSql.append("   AND A.TRANS_UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
			sbSql.append("   AND A.ITEM_CODE BETWEEN '700000000000' AND '709999999999' \n");
			if (! sSubinv.equals("%"))
				sbSql.append("   AND A.SUBINV_CODE = '" + sSubinv + "' \n");
		}
		if (sOtCust.equals(""))
			sbSql.append(" UNION ALL \n");
		if ((! sOtCust.equals("0000")) || sOtCust.equals(""))
		{
			sbSql.append("SELECT TO_CHAR(TO_DATE(A.NEED_DATE,'YYYYMMDD'),'YYYY-MM-DD') AS NEED_DATE \n");
			sbSql.append("     , A.SUBINV_CODE, B.SUBINV_NAME_DISP \n");
			sbSql.append("     , A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM \n");
			sbSql.append("     , DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE) AS OP_PRICE \n");
			sbSql.append("     , A.PR_QTY AS TRANS_QTY \n");
			sbSql.append("     , ROUND(A.PR_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)) AS OP_AMOUNT \n");
			sbSql.append("     , ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * ROUND(A.PR_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))) AS OP_VAT \n");
			sbSql.append("     , ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.PR_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))) AS OP_TOT \n");
			sbSql.append("  FROM FMP_OTCUST_PR@FCUS_TO_FSUS A, FMS_SUBINVENTORY@FCUS_TO_FSUS B, FMU_OP_RATE@FCUS_TO_FSUS C \n");
			sbSql.append(" WHERE A.SUBINV_CODE = B.SUBINV_CODE \n");
			sbSql.append("   AND A.UPJANG = C.UPJANG(+) \n");
			sbSql.append("   AND A.NEED_DATE BETWEEN C.SDATE(+) AND C.EDATE(+) \n");
			sbSql.append("   AND A.ITEM_CODE BETWEEN C.ITEM_CODE(+) AND C.ITEM_CODE(+)||'9999' \n");
			sbSql.append("   AND C.USE_YN(+) = 'Y' \n");
			if (sType.equals("001")) 	//일별선택
				sbSql.append("   AND A.NEED_DATE = '" + sNeedDate + "' \n");
			else						//월별선택
			{
				sbSql.append("   AND A.NEED_DATE BETWEEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATET")) + "' \n");
				sbSql.append("   AND A.NEED_DATE BETWEEN '" + sNeedDate + "'||'01' AND '" + sNeedDate + "'||'31' \n");
			}				
			sbSql.append("   AND A.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
			if (! sSubinv.equals("%"))	//창고전체가 아닐때
				sbSql.append("   AND A.SUBINV_CODE = '" + sSubinv + "' \n");
			if (! sOtCust.equals(""))
				sbSql.append("   AND A.OTCUSTCD = '" + nullToBlank(ds_cond.getString(0, "OTCUSTCD")) + "' \n");
			sbSql.append("   AND A.LINE_STATUS <> '003' \n");
		}
		sbSql.append(") A \n");
		sbSql.append(" ORDER BY A.NEED_DATE, A.SUBINV_CODE, A.NEED_DATE, A.ITEM_CODE \n");

out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_list = this.makeDataSet(rs, "ds_List");
		
		pstmt.close();
		rs.close();
		
		//FileLog.println("d:\\aaa.txt", ds_list);

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
