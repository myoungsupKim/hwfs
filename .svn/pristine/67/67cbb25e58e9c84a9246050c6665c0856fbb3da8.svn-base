<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/주문관리
■ 프로그램ID   : FMP00140V_T001.jsp
■ 프로그램명   : 발주내역 조회/출력
■ 작성일자     : 2008-01-30
■ 작성자       : 박은규
■ 이력관리     : 2008-01-30
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

		//out 데이타
		DataSet ds_list;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		String sOtCust = nullToBlank(ds_cond.getString(0, "OTCUSTCD"));
		String sCheck  = nullToBlank(ds_cond.getString(0, "CHECK"));
		
		//내역조회
		if (sOtCust.equals(""))
		{
			sbSql.append("SELECT A.* \n");
			sbSql.append("       ,DECODE(SUBSTR(A.UU,1,2),'CS','시스템','전화') AS PTYPE \n");
			sbSql.append("  FROM \n");
			sbSql.append("( \n");
		}
		if (sOtCust.equals("0000") || sOtCust.equals(""))
		{
			sbSql.append("SELECT DECODE(A.DOCU_SOURCE,'07 FM(식단)','식단','07 FM(상품)','개별','07 FM(주요)','개별','07 FM(모바일)','모바일','유선') AS GB \n");
			sbSql.append("     , A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM \n");
			sbSql.append("     , A.PR_QTY \n");
			sbSql.append("     , A.SALE_PRICE \n");
			//sbSql.append("     , CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
			//sbSql.append("            THEN DECODE(SIGN(NVL(C.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE) \n");
			//sbSql.append("            WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL \n");
			//sbSql.append("            THEN DECODE(SIGN(NVL(D.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL), D.OP_PRICE) \n");
			//sbSql.append("       ELSE A.SALE_PRICE END AS OP_PRICE \n");
			sbSql.append("      , DECODE(NVL(A.OP_PRICE,0),0,A.SALE_PRICE,A.OP_PRICE) AS OP_PRICE \n");
			sbSql.append("      , ROUND(DECODE(NVL(A.OP_PRICE,0),0,A.SALE_PRICE,A.OP_PRICE) * A.PR_QTY) AS OP_AMOUNT \n");
			sbSql.append("      , ROUND(ROUND(DECODE(NVL(A.OP_PRICE,0),0,A.SALE_PRICE,A.OP_PRICE) * A.PR_QTY)*DECODE(A.TAX_CODE,100,0.1,0)) AS OP_VAT \n");
			sbSql.append("      , ROUND(DECODE(NVL(A.OP_PRICE,0),0,A.SALE_PRICE,A.OP_PRICE) * A.PR_QTY)+ROUND(ROUND(DECODE(NVL(A.OP_PRICE,0),0,A.SALE_PRICE,A.OP_PRICE) * A.PR_QTY)*DECODE(A.TAX_CODE,100,0.1,0)) AS OP_TOT \n");
			/*
			sbSql.append("     , ROUND(A.PR_QTY * CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
			sbSql.append("                             THEN DECODE(SIGN(NVL(C.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE) \n");
			sbSql.append("                             WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL \n");
			sbSql.append("                             THEN DECODE(SIGN(NVL(D.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL), D.OP_PRICE) \n");
			sbSql.append("                        ELSE A.SALE_PRICE END) AS OP_AMOUNT \n");
			sbSql.append("     , ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * ROUND(A.PR_QTY * CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
			sbSql.append("                                                                    THEN DECODE(SIGN(NVL(C.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE) \n");
			sbSql.append("                                                                    WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL \n");
			sbSql.append("                                                                    THEN DECODE(SIGN(NVL(D.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL), D.OP_PRICE) \n");
			sbSql.append("                                                               ELSE A.SALE_PRICE END)) AS OP_VAT \n");
			sbSql.append("     , ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.PR_QTY * CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
			sbSql.append("                                                                    THEN DECODE(SIGN(NVL(C.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE) \n");
			sbSql.append("                                                                    WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL \n");
			sbSql.append("                                                                    THEN DECODE(SIGN(NVL(D.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL), D.OP_PRICE) \n");
			sbSql.append("                                                               ELSE A.SALE_PRICE END)) AS OP_TOT \n");
			*/
			sbSql.append("     , A.PR_REMARK, A.PR_ID, A.CREATE_BY AS UU \n");
			sbSql.append("     , A.ORIGIN_TYPE \n");
			
			if (sCheck.equals("1") || sCheck.equals("2")) {
				sbSql.append("     , A.NEED_DATE \n");
			}
			
			sbSql.append("     , A.PR_NUM \n");
			sbSql.append("     , A.DOCU_SOURCE \n");
			
			if (sCheck.equals("2")) {
				sbSql.append("     , TO_CHAR(A.UPDATE_DATE, 'YYYY-MM-DD HH24:MI:SS') AS APPROVE_TIME  \n");
			} else {
				sbSql.append("     , TO_CHAR(A.CREATE_DATE, 'YYYY-MM-DD HH24:MI:SS') AS APPROVE_TIME  \n");
			}
			
			if (sCheck.equals("0") || sCheck.equals("2")) {
				sbSql.append("	   , FMS_PO_LINESTATUS_FUN(A.PR_ID, A.PR_NUM, 'N') AS PO_LINE_STATUS \n");
			}
			sbSql.append("     , A.CENTER_FLAG \n");
			sbSql.append("     , DECODE(A.CENTER_FLAG, 'VC', 'Y', '') AS VC_YN \n");
			
			sbSql.append("  FROM (SELECT A.*, B.ITEM_CLASS4, B.ORIGIN_TYPE FROM SO_PR A, HLDC_PO_ITEM_MST B WHERE A.ITEM_CODE = B.ITEM_CODE) A \n");
			/*
			sbSql.append("     , (SELECT * \n");
			sbSql.append("          FROM FMU_OP_RATE \n");
			sbSql.append("         WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
			sbSql.append("           AND USE_YN = 'Y' \n");
			sbSql.append("           AND ITEM_TYPE = 'M' \n");
			sbSql.append("        ) C \n");
			sbSql.append("     , (SELECT * \n");
			sbSql.append("          FROM FMU_OP_RATE \n");
			sbSql.append("         WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
			sbSql.append("           AND USE_YN = 'Y' \n");
			sbSql.append("           AND ITEM_TYPE = 'C' \n");
			sbSql.append("        ) D \n");
			*/
			//sbSql.append(" WHERE A.NEED_DATE BETWEEN C.SDATE(+) AND C.EDATE(+) \n");
			//sbSql.append("   AND A.NEED_DATE BETWEEN D.SDATE(+) AND D.EDATE(+) \n");
			//sbSql.append("   AND A.ITEM_CODE = C.ITEM_CODE(+) \n");
			//sbSql.append("   AND A.ITEM_CLASS4 = D.ITEM_CODE(+) \n");
			sbSql.append("   WHERE A.RC_UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
			if (!nullToBlank(ds_cond.getString(0, "SUBINV_CODE")).equals("")) {
				sbSql.append("   AND A.SUBINV_CODE = '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) + "' \n");
			}
			sbSql.append("   AND A.NEED_DATE BETWEEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATET")) + "' \n");
			sbSql.append("   AND A.PR_QTY > 0 \n");
			
			if (sCheck.equals("2")) {
				sbSql.append("   AND A.LINE_STATUS IN ('003','005','PD') \n");
			} else {
				sbSql.append("   AND A.LINE_STATUS NOT IN ('003','005','999') \n");
			}
			//sbSql.append("   AND A.SO_STATUS != '999' \n");
		}
		if (sOtCust.equals(""))
			sbSql.append(" UNION ALL \n");
		if ((! sOtCust.equals("0000")) || sOtCust.equals(""))
		{
			sbSql.append("SELECT DECODE(A.DOCU_SOURCE,'07 FM(식단)','식단','07 FM(상품)','개별','07 FM(주요)','개별','07 FM(모바일)','모바일','유선') AS GB \n");
			sbSql.append("     , A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM \n");
			sbSql.append("     , A.PR_QTY \n");
			sbSql.append("      , DECODE(NVL(A.OP_PRICE,0),0,A.SALE_PRICE,A.OP_PRICE) AS OP_PRICE \n");
			sbSql.append("      , ROUND(DECODE(NVL(A.OP_PRICE,0),0,A.SALE_PRICE,A.OP_PRICE) * A.PR_QTY) AS OP_AMOUNT \n");
			sbSql.append("      , ROUND(ROUND(DECODE(NVL(A.OP_PRICE,0),0,A.SALE_PRICE,A.OP_PRICE) * A.PR_QTY)*DECODE(A.TAX_CODE,100,0.1,0)) AS OP_VAT \n");
			sbSql.append("      , ROUND(DECODE(NVL(A.OP_PRICE,0),0,A.SALE_PRICE,A.OP_PRICE) * A.PR_QTY)+ROUND(ROUND(DECODE(NVL(A.OP_PRICE,0),0,A.SALE_PRICE,A.OP_PRICE) * A.PR_QTY)*DECODE(A.TAX_CODE,100,0.1,0)) AS OP_TOT \n");
			sbSql.append("     , A.SALE_PRICE \n");
			/*
			sbSql.append("     , CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
			sbSql.append("            THEN DECODE(SIGN(NVL(C.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE) \n");
			sbSql.append("            WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL \n");
			sbSql.append("            THEN DECODE(SIGN(NVL(D.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL), D.OP_PRICE) \n");
			sbSql.append("       ELSE A.SALE_PRICE END AS OP_PRICE \n");
			sbSql.append("     , ROUND(A.PR_QTY * CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
			sbSql.append("                             THEN DECODE(SIGN(NVL(C.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE) \n");
			sbSql.append("                             WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL \n");
			sbSql.append("                             THEN DECODE(SIGN(NVL(D.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL), D.OP_PRICE) \n");
			sbSql.append("                        ELSE A.SALE_PRICE END) AS OP_AMOUNT \n");
			sbSql.append("     , ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * ROUND(A.PR_QTY * CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
			sbSql.append("                                                                    THEN DECODE(SIGN(NVL(C.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE) \n");
			sbSql.append("                                                                    WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL \n");
			sbSql.append("                                                                    THEN DECODE(SIGN(NVL(D.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL), D.OP_PRICE) \n");
			sbSql.append("                                                               ELSE A.SALE_PRICE END)) AS OP_VAT \n");
			sbSql.append("     , ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.PR_QTY * CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
			sbSql.append("                                                                    THEN DECODE(SIGN(NVL(C.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE) \n");
			sbSql.append("                                                                    WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL \n");
			sbSql.append("                                                                    THEN DECODE(SIGN(NVL(D.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL), D.OP_PRICE) \n");
			sbSql.append("                                                               ELSE A.SALE_PRICE END)) AS OP_TOT \n");
			*/
			sbSql.append("     , A.CONTENTS AS PR_REMARK, A.PR_ID, A.UUSER AS UU \n");
			sbSql.append("     , A.ORIGIN_TYPE \n");
			if (sCheck.equals("1") || sCheck.equals("2"))
				sbSql.append("     , A.NEED_DATE \n");
			sbSql.append("     , A.PR_NUM \n");
			sbSql.append("     , A.DOCU_SOURCE \n");
			sbSql.append("     , TO_CHAR(A.CDATE, 'YYYY-MM-DD HH24:MI:SS') AS APPROVE_TIME \n");
			if (sCheck.equals("0") || sCheck.equals("2")) {
				sbSql.append("     , '발주완료' AS PO_LINE_STATUS \n");
			}
			sbSql.append("     , 'VC' AS CENTER_FLAG \n");
			sbSql.append("     , 'Y' AS VC_YN \n");
			sbSql.append("  FROM (SELECT A.*, B.ITEM_CLASS4, B.ORIGIN_TYPE FROM FMP_OTCUST_PR A, FMP_OTCUST_ITEM B WHERE A.ITEM_CODE = B.ITEM_CODE) A \n");
			/*
			sbSql.append("     , (SELECT * \n");
			sbSql.append("          FROM FMU_OP_RATE \n");
			sbSql.append("         WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
			sbSql.append("           AND USE_YN = 'Y' \n");
			sbSql.append("           AND ITEM_TYPE = 'M' \n");
			sbSql.append("        ) C \n");
			sbSql.append("     , (SELECT * \n");
			sbSql.append("          FROM FMU_OP_RATE \n");
			sbSql.append("         WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
			sbSql.append("           AND USE_YN = 'Y' \n");
			sbSql.append("           AND ITEM_TYPE = 'C' \n");
			sbSql.append("        ) D \n");
			*/
			//sbSql.append(" WHERE A.NEED_DATE BETWEEN C.SDATE(+) AND C.EDATE(+) \n");
			//sbSql.append("   AND A.NEED_DATE BETWEEN D.SDATE(+) AND D.EDATE(+) \n");
			//sbSql.append("   AND A.ITEM_CODE = C.ITEM_CODE(+) \n");
			//sbSql.append("   AND A.ITEM_CLASS4 = D.ITEM_CODE(+) \n");
			
			sbSql.append("   WHERE A.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
			
			if (!nullToBlank(ds_cond.getString(0, "SUBINV_CODE")).equals("")) {
				sbSql.append("   AND A.SUBINV_CODE = '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) + "' \n");
			}
			
			sbSql.append("   AND A.NEED_DATE BETWEEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATET")) + "' \n");
			if (! sOtCust.equals(""))
				sbSql.append("   AND A.OTCUSTCD = '" + nullToBlank(ds_cond.getString(0, "OTCUSTCD")) + "' \n");
			sbSql.append("   AND A.PR_QTY > 0 \n");
			if (sCheck.equals("2")) {
				sbSql.append("   AND A.LINE_STATUS IN ('003','005','PD') \n");
			} else {
				sbSql.append("   AND A.LINE_STATUS NOT IN ('003','005','999') \n");
			}
		}
		if (sOtCust.equals(""))
			sbSql.append(") A \n");
		sbSql.append(" ORDER BY " + nullToBlank(ds_cond.getString(0, "SORT")));

out_vl.add("fa_Sql", sbSql.toString());
		
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

<%--
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
		DataSet ds_list;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		String sOtCust = nullToBlank(ds_cond.getString(0, "OTCUSTCD"));
		String sCheck  = nullToBlank(ds_cond.getString(0, "CHECK"));
		
		//내역조회
		if (sOtCust.equals(""))
		{
			sbSql.append("SELECT A.* \n");
			sbSql.append("       ,DECODE(SUBSTR(A.UU,1,2),'CS','시스템','전화') AS PTYPE \n");
			sbSql.append("  FROM \n");
			sbSql.append("( \n");
		}
		if (sOtCust.equals("0000") || sOtCust.equals(""))
		{
			sbSql.append("SELECT DECODE(A.DOCU_SOURCE,'07 FM(식단)','식단','07 FM(상품)','개별','07 FM(주요)','개별','유선') AS GB \n");
			sbSql.append("     , A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM \n");
			sbSql.append("     , A.PR_QTY \n");
			sbSql.append("     , A.SALE_PRICE \n");
			sbSql.append("     , DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE) AS OP_PRICE \n");
			sbSql.append("     , ROUND(A.PR_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)) AS OP_AMOUNT \n");
			sbSql.append("     , ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * ROUND(A.PR_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))) AS OP_VAT \n");
			sbSql.append("     , ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.PR_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))) AS OP_TOT \n");
			sbSql.append("     , A.PR_REMARK, A.PR_ID, A.CREATE_BY AS UU \n");
			if (sCheck.equals("1"))
				sbSql.append("     , A.NEED_DATE \n");
			sbSql.append("  FROM HLDC_PO_PR A, FMU_OP_RATE C \n");
			sbSql.append(" WHERE A.RC_UPJANG = C.UPJANG(+) \n");
			sbSql.append("   AND A.NEED_DATE BETWEEN C.SDATE(+) AND C.EDATE(+) \n");
			sbSql.append("   AND A.ITEM_CODE BETWEEN C.ITEM_CODE(+) AND C.ITEM_CODE(+)||'9999' \n");
			sbSql.append("   AND C.USE_YN(+) = 'Y' \n");
			sbSql.append("   AND A.RC_UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
			sbSql.append("   AND A.SUBINV_CODE = '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) + "' \n");
			sbSql.append("   AND A.NEED_DATE BETWEEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATET")) + "' \n");
			sbSql.append("   AND A.PR_QTY > 0 \n");
			sbSql.append("   AND A.LINE_STATUS NOT IN ('003','005') \n");
		}
		if (sOtCust.equals(""))
			sbSql.append(" UNION ALL \n");
		if ((! sOtCust.equals("0000")) || sOtCust.equals(""))
		{
			sbSql.append("SELECT DECODE(A.DOCU_SOURCE,'07 FM(식단)','식단','개별') AS GB \n");
			sbSql.append("     , A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM \n");
			sbSql.append("     , A.PR_QTY \n");
			sbSql.append("     , A.SALE_PRICE \n");
			sbSql.append("     , DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE) AS OP_PRICE \n");
			sbSql.append("     , ROUND(A.PR_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)) AS OP_AMOUNT \n");
			sbSql.append("     , ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * ROUND(A.PR_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))) AS OP_VAT \n");
			sbSql.append("     , ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.PR_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))) AS OP_TOT \n");
			sbSql.append("     , A.CONTENTS AS PR_REMARK, A.PR_ID, A.UUSER AS UU \n");
			if (sCheck.equals("1"))
				sbSql.append("     , A.NEED_DATE \n");
			sbSql.append("  FROM FMP_OTCUST_PR A, FMU_OP_RATE C \n");
			sbSql.append(" WHERE A.UPJANG = C.UPJANG(+) \n");
			sbSql.append("   AND A.NEED_DATE BETWEEN C.SDATE(+) AND C.EDATE(+) \n");
			sbSql.append("   AND A.ITEM_CODE BETWEEN C.ITEM_CODE(+) AND C.ITEM_CODE(+)||'9999' \n");
			sbSql.append("   AND C.USE_YN(+) = 'Y' \n");
			sbSql.append("   AND A.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
			sbSql.append("   AND A.SUBINV_CODE = '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) + "' \n");
			sbSql.append("   AND A.NEED_DATE BETWEEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATET")) + "' \n");
			if (! sOtCust.equals(""))
				sbSql.append("   AND A.OTCUSTCD = '" + nullToBlank(ds_cond.getString(0, "OTCUSTCD")) + "' \n");
			sbSql.append("   AND A.PR_QTY > 0 \n");
			sbSql.append("   AND A.LINE_STATUS NOT IN ('003','005') \n");
		}
		if (sOtCust.equals(""))
			sbSql.append(") A \n");
		sbSql.append(" ORDER BY " + nullToBlank(ds_cond.getString(0, "SORT")));

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

--%>
