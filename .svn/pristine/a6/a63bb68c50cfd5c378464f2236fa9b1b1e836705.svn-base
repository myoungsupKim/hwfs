<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/구매관리/발주관리
■ 프로그램ID   : FMP00150V_T001.jsp
■ 프로그램명   : 발주예정 조회(본사)
■ 작성일자     : 2009-05-13
■ 작성자       : 노규완
■ 이력관리     : 
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
		String sTaxCode = nullToBlank(ds_cond.getString(0, "TAX_CODE"));
		String sCC = nullToBlank(ds_cond.getString(0, "CC_NM"));
		String sCS = nullToBlank(ds_cond.getString(0, "CS_NM"));
		//String sITEM = nullToBlank(ds_cond.getString(0, "ITEM"));
		
		//내역조회
		if (sOtCust.equals(""))
		{
			sbSql.append("SELECT A.* \n");
			sbSql.append("  FROM \n");
			sbSql.append("( \n");
		}
		if (sOtCust.equals("0000") || sOtCust.equals(""))
		{
			sbSql.append("SELECT DECODE(A.DOCU_SOURCE,'07 FM(식단)','식단','07 FM(상품)','개별','07 FM(주요)','개별','유선') AS GB \n");
			sbSql.append("     , A.NEED_DATE \n");
			sbSql.append("     , D.UPJANGNM_DISP \n");
			sbSql.append("     , D.DEPT_ID \n");
			sbSql.append("     , (SELECT Z.CC_NM FROM SCC_CC Z WHERE Z.CC_CD = D.DEPT_ID) CC_NM  \n");
			sbSql.append("     , D.CS_SABUN \n");
			sbSql.append("     , (SELECT Z.NM_KOR FROM SCC_USERINFO_V Z WHERE Z.SABUN = D.CS_SABUN) NM_KOR  \n");
			sbSql.append("     , E.SUBINV_NAME_DISP \n");			
			sbSql.append("     , E.CONSUM_YN \n");
			sbSql.append("     , A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM, A.CENTER_FLAG \n");
			sbSql.append("     , A.PR_QTY \n");
			sbSql.append("     , A.SALE_PRICE \n");
			sbSql.append("     , CASE WHEN X.OP_PRICE IS NOT NULL OR X.OP_RATE IS NOT NULL \n");
	        sbSql.append("            THEN DECODE(SIGN(NVL(X.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(X.OP_RATE,0) / 100),X.CEIL_VAL), X.OP_PRICE) \n");
	        sbSql.append("            WHEN Y.OP_PRICE IS NOT NULL OR Y.OP_RATE IS NOT NULL \n");
	        sbSql.append("            THEN DECODE(SIGN(NVL(Y.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(Y.OP_RATE,0) / 100),Y.CEIL_VAL), Y.OP_PRICE) \n");
	        sbSql.append("       ELSE A.SALE_PRICE END AS OP_PRICE \n");
	        sbSql.append("     , ROUND(A.PR_QTY * CASE WHEN X.OP_PRICE IS NOT NULL OR X.OP_RATE IS NOT NULL \n");
	        sbSql.append("                             THEN DECODE(SIGN(NVL(X.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(X.OP_RATE,0) / 100),X.CEIL_VAL), X.OP_PRICE) \n");
	        sbSql.append("                             WHEN Y.OP_PRICE IS NOT NULL OR Y.OP_RATE IS NOT NULL \n");
	        sbSql.append("                             THEN DECODE(SIGN(NVL(Y.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(Y.OP_RATE,0) / 100),Y.CEIL_VAL), Y.OP_PRICE) \n");
	        sbSql.append("                        ELSE A.SALE_PRICE END) AS OP_AMOUNT \n");
	        sbSql.append("     , ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * ROUND(A.PR_QTY * CASE WHEN X.OP_PRICE IS NOT NULL OR X.OP_RATE IS NOT NULL \n");
	        sbSql.append("                                                                    THEN DECODE(SIGN(NVL(X.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(X.OP_RATE,0) / 100),X.CEIL_VAL), X.OP_PRICE) \n");
	        sbSql.append("                                                                    WHEN Y.OP_PRICE IS NOT NULL OR Y.OP_RATE IS NOT NULL \n");
	        sbSql.append("                                                                    THEN DECODE(SIGN(NVL(Y.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(Y.OP_RATE,0) / 100),Y.CEIL_VAL), Y.OP_PRICE) \n");
	        sbSql.append("                                                               ELSE A.SALE_PRICE END)) AS OP_VAT \n");
	        sbSql.append("     , ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.PR_QTY * CASE WHEN X.OP_PRICE IS NOT NULL OR X.OP_RATE IS NOT NULL \n");
	        sbSql.append("                                                                    THEN DECODE(SIGN(NVL(X.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(X.OP_RATE,0) / 100),X.CEIL_VAL), X.OP_PRICE) \n");
	        sbSql.append("                                                                    WHEN Y.OP_PRICE IS NOT NULL OR Y.OP_RATE IS NOT NULL \n");
	        sbSql.append("                                                                    THEN DECODE(SIGN(NVL(Y.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(Y.OP_RATE,0) / 100),Y.CEIL_VAL), Y.OP_PRICE) \n");
	        sbSql.append("                                                               ELSE A.SALE_PRICE END)) AS OP_TOT \n");
			sbSql.append("     , A.PR_REMARK, A.PR_ID, '한화리조트' AS OTCUSTNM, A.ITEM_CLASS2, A.ORIGIN_TYPE \n");
			sbSql.append("     , (SELECT CLASS_NAME2 FROM HLDC_PO_ITEM_CLASS_FULL_HLDC_V WHERE CLASS_CODE2 = A.ITEM_CLASS2 GROUP BY CLASS_NAME2) AS CLASS_NAME2 \n");
			sbSql.append("     , A.PO_QTY \n");
			//sbSql.append("     , A.UPDATE_DATE \n");  
			//발주 확정 시간이 아닌 실제 발주시간으로 변경 요청 김진희 20171013
			sbSql.append("     , TO_CHAR(A.CREATE_DATE, 'YYYY-MM-DD HH24:MI:SS') AS UPDATE_DATE  \n");  
			//sbSql.append("  FROM (SELECT A.*, B.ITEM_CLASS2, B.ITEM_CLASS4, B.ORIGIN_TYPE FROM SO_PR A, HLDC_PO_ITEM_MST B WHERE A.ITEM_CODE = B.ITEM_CODE) A \n");
			sbSql.append("  FROM (SELECT A.*, B.ITEM_CLASS2, B.ITEM_CLASS4, B.ORIGIN_TYPE FROM SO_PR A, HLDC_PO_ITEM_MST B \n");
			sbSql.append("         WHERE A.ITEM_CODE = B.ITEM_CODE \n");
			
			if (! nullToBlank(ds_cond.getString(0, "ITEM")).equals("")) {
				sbSql.append("         AND ( A.ITEM_CODE LIKE '%" + ds_cond.getString(0, "ITEM") + "%' OR A.ITEM_NAME LIKE '%" + ds_cond.getString(0, "ITEM") + "%' ) \n");
			}
			
			if (! nullToBlank(ds_cond.getString(0, "UPJANG")).equals("")) {
				sbSql.append("       AND A.RC_UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");   
		    }else{
		    	sbSql.append("       AND A.RC_UPJANG IN (SELECT UPJANG FROM FMS_UPJANG WHERE MAIN_UPJANG = " + nullToBlank(ds_cond.getString(0, "MAIN_UPJANG")) + ")  \n");
		    }	
			sbSql.append("           AND A.NEED_DATE BETWEEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATET")) + "' \n");
			sbSql.append("       ) A \n");
			sbSql.append("     , FMS_UPJANG D, FMS_SUBINVENTORY E \n");
			sbSql.append("     , (SELECT * \n");
			sbSql.append("          FROM FMU_OP_RATE \n");
			sbSql.append("         WHERE USE_YN = 'Y' \n");
			sbSql.append("           AND ITEM_TYPE = 'M' \n");
			sbSql.append("        ) X \n");
			sbSql.append("     , (SELECT * \n");
			sbSql.append("          FROM FMU_OP_RATE \n");
			sbSql.append("         WHERE USE_YN = 'Y' \n");
			sbSql.append("           AND ITEM_TYPE = 'C' \n");
			sbSql.append("        ) Y \n");
			sbSql.append(" WHERE A.NEED_DATE BETWEEN X.SDATE(+) AND X.EDATE(+) \n");
			sbSql.append("   AND A.NEED_DATE BETWEEN Y.SDATE(+) AND Y.EDATE(+) \n");
			sbSql.append("   AND A.ITEM_CODE = X.ITEM_CODE(+) \n");
			sbSql.append("   AND A.ITEM_CLASS4 = Y.ITEM_CODE(+) \n");
			sbSql.append("   AND A.RC_UPJANG = X.UPJANG(+) \n");
			sbSql.append("   AND A.RC_UPJANG = Y.UPJANG(+) \n");
			sbSql.append("   AND A.RC_UPJANG = D.UPJANG  \n");
			sbSql.append("   AND A.SUBINV_CODE = E.SUBINV_CODE     \n");			
			
			if (! nullToBlank(ds_cond.getString(0, "UPJANG")).equals("")) {
				sbSql.append("   AND A.RC_UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");   
			}else{
				sbSql.append("   AND A.RC_UPJANG IN (SELECT UPJANG FROM FMS_UPJANG WHERE MAIN_UPJANG = " + nullToBlank(ds_cond.getString(0, "MAIN_UPJANG")) + ")  \n");
			}			
			if (! nullToBlank(ds_cond.getString(0, "chk_all")).equals("1")){
				sbSql.append("   AND INSTR('" + nullToBlank(ds_cond.getString(0, "chk_str")) + "',NVL(E.CONSUM_YN,' ')) > 0 \n");
			}			
			sbSql.append("   AND A.NEED_DATE BETWEEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATET")) + "' \n");
			
			if (! nullToBlank(ds_cond.getString(0, "FLAG_CODE")).equals(""))
				sbSql.append("   AND A.CENTER_FLAG = '" + nullToBlank(ds_cond.getString(0, "FLAG_CODE")) + "' \n"); 
			sbSql.append("   AND A.PR_QTY > 0 \n");
			if (!sTaxCode.equals("0"))
				sbSql.append("   AND A.TAX_CODE = '" + sTaxCode + "' \n");				
			sbSql.append("   AND A.LINE_STATUS NOT IN ('003','005','999') \n");  //2009/07/03(금) 김진희씨 요청으로 008(발주확정) 부분도 보이게 해 달라고 해서 다시 수정 해 드림 008 코드를 제외 시킴
		}
		if (sOtCust.equals(""))
			sbSql.append(" UNION ALL \n");
		if ((! sOtCust.equals("0000")) || sOtCust.equals(""))
		{
			sbSql.append("SELECT DECODE(A.DOCU_SOURCE,'07 FM(식단)','식단','개별') AS GB \n");
			sbSql.append("     , A.NEED_DATE \n");			
			sbSql.append("     , D.UPJANGNM_DISP \n");
			sbSql.append("     , D.DEPT_ID \n");
			sbSql.append("     , (SELECT Z.CC_NM FROM SCC_CC Z WHERE Z.CC_CD = D.DEPT_ID) CC_NM  \n");
			sbSql.append("     , D.CS_SABUN \n");
			sbSql.append("     , (SELECT Z.NM_KOR FROM SCC_USERINFO_V Z WHERE Z.SABUN = D.CS_SABUN) NM_KOR  \n");
			sbSql.append("     , E.SUBINV_NAME_DISP \n");			
			sbSql.append("     , E.CONSUM_YN \n");			
			sbSql.append("     , A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM, '직송' AS CENTER_FLAG \n");
			sbSql.append("     , A.PR_QTY \n");
			sbSql.append("     , A.SALE_PRICE \n");
			sbSql.append("     , CASE WHEN X.OP_PRICE IS NOT NULL OR X.OP_RATE IS NOT NULL \n");
	        sbSql.append("            THEN DECODE(SIGN(NVL(X.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(X.OP_RATE,0) / 100),X.CEIL_VAL), X.OP_PRICE) \n");
	        sbSql.append("            WHEN Y.OP_PRICE IS NOT NULL OR Y.OP_RATE IS NOT NULL \n");
	        sbSql.append("            THEN DECODE(SIGN(NVL(Y.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(Y.OP_RATE,0) / 100),Y.CEIL_VAL), Y.OP_PRICE) \n");
	        sbSql.append("       ELSE A.SALE_PRICE END AS OP_PRICE \n");
	        sbSql.append("     , ROUND(A.PR_QTY * CASE WHEN X.OP_PRICE IS NOT NULL OR X.OP_RATE IS NOT NULL \n");
	        sbSql.append("                             THEN DECODE(SIGN(NVL(X.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(X.OP_RATE,0) / 100),X.CEIL_VAL), X.OP_PRICE) \n");
	        sbSql.append("                             WHEN Y.OP_PRICE IS NOT NULL OR Y.OP_RATE IS NOT NULL \n");
	        sbSql.append("                             THEN DECODE(SIGN(NVL(Y.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(Y.OP_RATE,0) / 100),Y.CEIL_VAL), Y.OP_PRICE) \n");
	        sbSql.append("                        ELSE A.SALE_PRICE END) AS OP_AMOUNT \n");
	        sbSql.append("     , ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * ROUND(A.PR_QTY * CASE WHEN X.OP_PRICE IS NOT NULL OR X.OP_RATE IS NOT NULL \n");
	        sbSql.append("                                                                    THEN DECODE(SIGN(NVL(X.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(X.OP_RATE,0) / 100),X.CEIL_VAL), X.OP_PRICE) \n");
	        sbSql.append("                                                                    WHEN Y.OP_PRICE IS NOT NULL OR Y.OP_RATE IS NOT NULL \n");
	        sbSql.append("                                                                    THEN DECODE(SIGN(NVL(Y.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(Y.OP_RATE,0) / 100),Y.CEIL_VAL), Y.OP_PRICE) \n");
	        sbSql.append("                                                               ELSE A.SALE_PRICE END)) AS OP_VAT \n");
	        sbSql.append("     , ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.PR_QTY * CASE WHEN X.OP_PRICE IS NOT NULL OR X.OP_RATE IS NOT NULL \n");
	        sbSql.append("                                                                    THEN DECODE(SIGN(NVL(X.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(X.OP_RATE,0) / 100),X.CEIL_VAL), X.OP_PRICE) \n");
	        sbSql.append("                                                                    WHEN Y.OP_PRICE IS NOT NULL OR Y.OP_RATE IS NOT NULL \n");
	        sbSql.append("                                                                    THEN DECODE(SIGN(NVL(Y.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(Y.OP_RATE,0) / 100),Y.CEIL_VAL), Y.OP_PRICE) \n");
	        sbSql.append("                                                               ELSE A.SALE_PRICE END)) AS OP_TOT \n");
			sbSql.append("     , A.CONTENTS AS PR_REMARK, A.PR_ID, F.OTCUSTNM, A.ITEM_CLASS2, A.ORIGIN_TYPE \n");
			sbSql.append("     , (SELECT CLASS_NAME2 FROM HLDC_PO_ITEM_CLASS_FULL_HLDC_V WHERE CLASS_CODE2 = A.ITEM_CLASS2 GROUP BY CLASS_NAME2) AS CLASS_NAME2 \n");
			sbSql.append("     , A.PO_QTY \n");
			//sbSql.append("     , A.UDATE AS UPDATE_DATE \n");
			//실제 발주시간으로 변경 요청 20171013 김진희
			sbSql.append("     , TO_CHAR(A.CDATE, 'YYYY-MM-DD HH24:MI:SS') AS UPDATE_DATE \n");
			sbSql.append("  FROM (SELECT A.*, B.ITEM_CLASS2, B.ITEM_CLASS4, B.ORIGIN_TYPE FROM FMP_OTCUST_PR A, FMP_OTCUST_ITEM B \n");
			sbSql.append("         WHERE A.ITEM_CODE = B.ITEM_CODE \n");
			
			if (! nullToBlank(ds_cond.getString(0, "ITEM")).equals("")) {
				sbSql.append("         AND ( A.ITEM_CODE LIKE '%" + ds_cond.getString(0, "ITEM") + "%' OR A.ITEM_NAME LIKE '%" + ds_cond.getString(0, "ITEM") + "%' ) \n");
			}
			
			if (! nullToBlank(ds_cond.getString(0, "UPJANG")).equals(""))
			{
				sbSql.append("       AND A.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");   
			}else{
				sbSql.append("       AND A.UPJANG IN (SELECT UPJANG FROM FMS_UPJANG WHERE MAIN_UPJANG = " + nullToBlank(ds_cond.getString(0, "MAIN_UPJANG")) + ")  \n");
			}
			sbSql.append("           AND A.NEED_DATE BETWEEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATET")) + "' \n");
			
			sbSql.append("       ) A \n");
			sbSql.append("     , FMS_UPJANG D, FMS_SUBINVENTORY E , FMP_OTHER_CUST F\n");
			sbSql.append("     , (SELECT * \n");
			sbSql.append("          FROM FMU_OP_RATE \n");
			sbSql.append("         WHERE USE_YN = 'Y' \n");
			sbSql.append("           AND ITEM_TYPE = 'M' \n");
			sbSql.append("        ) X \n");
			sbSql.append("     , (SELECT * \n");
			sbSql.append("          FROM FMU_OP_RATE \n");
			sbSql.append("         WHERE USE_YN = 'Y' \n");
			sbSql.append("           AND ITEM_TYPE = 'C' \n");
			sbSql.append("        ) Y \n");
			sbSql.append(" WHERE A.NEED_DATE BETWEEN X.SDATE(+) AND X.EDATE(+) \n");
			sbSql.append("   AND A.NEED_DATE BETWEEN Y.SDATE(+) AND Y.EDATE(+) \n");
			sbSql.append("   AND A.UPJANG = X.UPJANG(+) \n");
			sbSql.append("   AND A.UPJANG = Y.UPJANG(+) \n");
			sbSql.append("   AND A.ITEM_CODE = X.ITEM_CODE(+) \n");
			sbSql.append("   AND A.ITEM_CLASS4 = Y.ITEM_CODE(+) \n");
			sbSql.append("   AND A.UPJANG = D.UPJANG  \n");
			sbSql.append("   AND A.OTCUSTCD = F.OTCUSTCD  \n");			
			sbSql.append("   AND A.SUBINV_CODE = E.SUBINV_CODE     \n");
			
			if (! nullToBlank(ds_cond.getString(0, "UPJANG")).equals(""))
			{
				sbSql.append("   AND A.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");   
			}else{
				sbSql.append("   AND A.UPJANG IN (SELECT UPJANG FROM FMS_UPJANG WHERE MAIN_UPJANG = " + nullToBlank(ds_cond.getString(0, "MAIN_UPJANG")) + ")  \n");
			}
			if (! nullToBlank(ds_cond.getString(0, "chk_all")).equals("1")){
				sbSql.append("   AND INSTR('" + nullToBlank(ds_cond.getString(0, "chk_str")) + "',NVL(E.CONSUM_YN,' ')) > 0 \n");
			}			
			//sbSql.append("   AND A.NEED_DATE = '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' \n");
			sbSql.append("   AND A.NEED_DATE BETWEEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATET")) + "' \n");
			if (! sOtCust.equals(""))
				sbSql.append("   AND A.OTCUSTCD LIKE '%" + nullToBlank(ds_cond.getString(0, "OTCUSTCD")) + "%' \n");
			sbSql.append("   AND A.PR_QTY > 0 \n");
			if (!sTaxCode.equals("0"))
				sbSql.append("   AND A.TAX_CODE = '" + sTaxCode + "' \n");	
			if (! nullToBlank(ds_cond.getString(0, "FLAG_CODE")).equals(""))
				sbSql.append("   AND 'VC' = '" + nullToBlank(ds_cond.getString(0, "FLAG_CODE")) + "' \n"); 
			sbSql.append("   AND A.LINE_STATUS NOT IN ('003','005','999') \n");    //2009/07/03(금) 김진희씨 요청으로 008(발주확정) 부분도 보이게 해 달라고 해서 다시 수정 해 드림 008 코드를 제외 시킴
		}
		if (sOtCust.equals(""))
			sbSql.append(") A \n");
		sbSql.append("WHERE 1=1 \n");
		if (! nullToBlank(ds_cond.getString(0, "CC_NM")).equals("")) 
			sbSql.append("  AND A.CC_NM LIKE '%" + nullToBlank(ds_cond.getString(0, "CC_NM")) + "%' \n");
		if (! nullToBlank(ds_cond.getString(0, "CS_NM")).equals("")) 
			sbSql.append("  AND A.NM_KOR LIKE '%" + nullToBlank(ds_cond.getString(0, "CS_NM")) + "%' \n");
		sbSql.append(" ORDER BY UPJANGNM_DISP, SUBINV_NAME_DISP, NEED_DATE" );

out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
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
		String sTaxCode = nullToBlank(ds_cond.getString(0, "TAX_CODE"));
		
		//내역조회
		if (sOtCust.equals(""))
		{
			sbSql.append("SELECT A.* \n");
			sbSql.append("  FROM \n");
			sbSql.append("( \n");
		}
		if (sOtCust.equals("0000") || sOtCust.equals(""))
		{
			sbSql.append("SELECT DECODE(A.DOCU_SOURCE,'07 FM(식단)','식단','07 FM(상품)','개별','07 FM(주요)','개별','유선') AS GB \n");
			sbSql.append("     , A.NEED_DATE \n");
			sbSql.append("     , D.UPJANGNM_DISP \n");
			sbSql.append("     , E.SUBINV_NAME_DISP \n");			
			sbSql.append("     , E.CONSUM_YN \n");
			sbSql.append("     , A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM, A.CENTER_FLAG \n");
			sbSql.append("     , A.PR_QTY \n");
			sbSql.append("     , A.SALE_PRICE \n");
			sbSql.append("     , DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE) AS OP_PRICE \n");
			sbSql.append("     , ROUND(A.PR_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)) AS OP_AMOUNT \n");
			sbSql.append("     , ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * ROUND(A.PR_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))) AS OP_VAT \n");
			sbSql.append("     , ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.PR_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))) AS OP_TOT \n");
			sbSql.append("     , A.PR_REMARK, A.PR_ID, '한화리조트' AS OTCUSTNM, F.ITEM_CLASS2 \n");
			sbSql.append("     , (SELECT G.CLASS_NAME2 FROM HLDC_PO_ITEM_CLASS_FULL_HLDC_V G WHERE G.CLASS_CODE2 = F.ITEM_CLASS2 GROUP BY G.CLASS_NAME2) AS CLASS_NAME2 \n");			
			sbSql.append("  FROM HLDC_PO_PR A, FMU_OP_RATE C, FMS_UPJANG D, FMS_SUBINVENTORY E, FMS_ITEM_V F \n");
			sbSql.append(" WHERE A.RC_UPJANG = C.UPJANG(+) \n");
			sbSql.append("   AND A.NEED_DATE BETWEEN C.SDATE(+) AND C.EDATE(+) \n");
			sbSql.append("   AND A.ITEM_CODE BETWEEN C.ITEM_CODE(+) AND C.ITEM_CODE(+)||'9999' \n");
			sbSql.append("   AND A.RC_UPJANG = D.UPJANG  \n");
			sbSql.append("   AND A.ITEM_CODE = F.ITEM_CODE  \n");			
			sbSql.append("   AND A.SUBINV_CODE = E.SUBINV_CODE     \n");			
			sbSql.append("   AND C.USE_YN(+) = 'Y' \n");
			if (! nullToBlank(ds_cond.getString(0, "UPJANG")).equals(""))
			{{sbSql.append("   AND A.RC_UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");   }}
			else
			{sbSql.append("   AND A.RC_UPJANG IN (SELECT T.UPJANG FROM FMS_UPJANG T WHERE T.MAIN_UPJANG = " + nullToBlank(ds_cond.getString(0, "MAIN_UPJANG")) + ")  \n");}			
			if (! nullToBlank(ds_cond.getString(0, "chk_all")).equals("1"))			
			{sbSql.append("   AND INSTR('" + nullToBlank(ds_cond.getString(0, "chk_str")) + "',NVL(E.CONSUM_YN,' ')) > 0 \n");}			
			sbSql.append("   AND A.NEED_DATE = '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' \n");
			if (! nullToBlank(ds_cond.getString(0, "FLAG_CODE")).equals(""))
				sbSql.append("   AND A.CENTER_FLAG = '" + nullToBlank(ds_cond.getString(0, "FLAG_CODE")) + "' \n"); 
			sbSql.append("   AND A.PR_QTY > 0 \n");
			if (!sTaxCode.equals("0"))
				sbSql.append("   AND A.TAX_CODE = '" + sTaxCode + "' \n");				
			sbSql.append("   AND A.LINE_STATUS NOT IN ('003','005') \n");  //2009/07/03(금) 김진희씨 요청으로 008(발주확정) 부분도 보이게 해 달라고 해서 다시 수정 해 드림 008 코드를 제외 시킴
		}
		if (sOtCust.equals(""))
			sbSql.append(" UNION ALL \n");
		if ((! sOtCust.equals("0000")) || sOtCust.equals(""))
		{
			sbSql.append("SELECT DECODE(A.DOCU_SOURCE,'07 FM(식단)','식단','개별') AS GB \n");
			sbSql.append("     , A.NEED_DATE \n");			
			sbSql.append("     , D.UPJANGNM_DISP \n");
			sbSql.append("     , E.SUBINV_NAME_DISP \n");			
			sbSql.append("     , E.CONSUM_YN \n");			
			sbSql.append("     , A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM, 'N' AS CENTER_FLAG \n");
			sbSql.append("     , A.PR_QTY \n");
			sbSql.append("     , A.SALE_PRICE \n");
			sbSql.append("     , DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE) AS OP_PRICE \n");
			sbSql.append("     , ROUND(A.PR_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)) AS OP_AMOUNT \n");
			sbSql.append("     , ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * ROUND(A.PR_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))) AS OP_VAT \n");
			sbSql.append("     , ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.PR_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))) AS OP_TOT \n");
			sbSql.append("     , A.CONTENTS AS PR_REMARK, A.PR_ID, F.OTCUSTNM, G.ITEM_CLASS2 \n");
			sbSql.append("     , (SELECT H.CLASS_NAME2 FROM HLDC_PO_ITEM_CLASS_FULL_HLDC_V H WHERE H.CLASS_CODE2 = G.ITEM_CLASS2 GROUP BY H.CLASS_NAME2) AS CLASS_NAME2 \n");			
			sbSql.append("  FROM FMP_OTCUST_PR A, FMU_OP_RATE C, FMS_UPJANG D, FMS_SUBINVENTORY E, FMP_OTHER_CUST F, FMS_ITEM_V G \n");
			sbSql.append(" WHERE A.UPJANG = C.UPJANG(+) \n");
			sbSql.append("   AND A.NEED_DATE BETWEEN C.SDATE(+) AND C.EDATE(+) \n");
			sbSql.append("   AND A.ITEM_CODE BETWEEN C.ITEM_CODE(+) AND C.ITEM_CODE(+)||'9999' \n");
			sbSql.append("   AND A.UPJANG = D.UPJANG  \n");
			sbSql.append("   AND A.OTCUSTCD = F.OTCUSTCD  \n");			
			sbSql.append("   AND A.SUBINV_CODE = E.SUBINV_CODE     \n");
			sbSql.append("   AND A.ITEM_CODE = G.ITEM_CODE     \n");			
			sbSql.append("   AND C.USE_YN(+) = 'Y' \n");
			if (! nullToBlank(ds_cond.getString(0, "UPJANG")).equals(""))
			{sbSql.append("   AND A.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");   }
			else
			{sbSql.append("   AND A.UPJANG IN (SELECT T.UPJANG FROM FMS_UPJANG T WHERE T.MAIN_UPJANG = " + nullToBlank(ds_cond.getString(0, "MAIN_UPJANG")) + ")  \n");}
			if (! nullToBlank(ds_cond.getString(0, "chk_all")).equals("1"))			
			{sbSql.append("   AND INSTR('" + nullToBlank(ds_cond.getString(0, "chk_str")) + "',NVL(E.CONSUM_YN,' ')) > 0 \n");}			
			sbSql.append("   AND A.NEED_DATE = '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' \n");
			if (! sOtCust.equals(""))
				sbSql.append("   AND A.OTCUSTCD LIKE '%" + nullToBlank(ds_cond.getString(0, "OTCUSTCD")) + "%' \n");
			sbSql.append("   AND A.PR_QTY > 0 \n");
			if (!sTaxCode.equals("0"))
				sbSql.append("   AND A.TAX_CODE = '" + sTaxCode + "' \n");			
			sbSql.append("   AND A.LINE_STATUS NOT IN ('003','005') \n");    //2009/07/03(금) 김진희씨 요청으로 008(발주확정) 부분도 보이게 해 달라고 해서 다시 수정 해 드림 008 코드를 제외 시킴
		}
		if (sOtCust.equals(""))
			sbSql.append(") A \n");
		sbSql.append(" ORDER BY UPJANGNM_DISP, SUBINV_NAME_DISP" );

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
