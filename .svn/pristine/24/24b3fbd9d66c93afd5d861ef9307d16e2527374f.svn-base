<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/주문관리
■ 프로그램ID   : FMP00770V_T001.jsp
■ 프로그램명   : 상품정보조회
■ 작성일자     : 2008.02.14
■ 작성자       : 박은규
■ 이력관리     : [고도화]_운영단가 관련 수정_김경은
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
		String strIndex     = nullToBlank(in_vl.getString("strIndex"));
		
		//out 데이타
		DataSet ds_list;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		//내역조회
		sbSql.append("SELECT A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM \n");
		sbSql.append("     , A.TAX_CODE, A.KEEPING_TYPE, A.ORIGIN_TYPE \n");
		
		sbSql.append("     , CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");              
	    sbSql.append("            THEN DECODE(SIGN(NVL(C.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE) \n"); 
	    sbSql.append("            WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL \n");              
	    sbSql.append("            THEN DECODE(SIGN(NVL(D.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL), D.OP_PRICE) \n"); 
	    sbSql.append("            ELSE A.SALE_PRICE END AS OP_PRICE \n");
		
		if (strIndex.equals("1"))
			sbSql.append("     , 'D-'||TO_CHAR(A.D_DAYS)||'  '||SUBSTR(A.D_TIMES,1,2)||':'||SUBSTR(A.D_TIMES,3) AS ITEM_INFO \n");
		else if (strIndex.equals("2"))
		{
			sbSql.append("     , DECODE(NVL(A.MON,'N'),'Y','월 ') \n");
			sbSql.append("     ||DECODE(NVL(A.TUE,'N'),'Y','화 ') \n");
			sbSql.append("     ||DECODE(NVL(A.WED,'N'),'Y','수 ') \n");
			sbSql.append("     ||DECODE(NVL(A.THU,'N'),'Y','목 ') \n");
			sbSql.append("     ||DECODE(NVL(A.FRI,'N'),'Y','금 ') \n");
			sbSql.append("     ||DECODE(NVL(A.SAT,'N'),'Y','토 ') \n");
			sbSql.append("     ||DECODE(NVL(A.SUN,'N'),'Y','일') AS ITEM_INFO \n");
		}			
		
		sbSql.append("  FROM  \n");
		sbSql.append("      (SELECT " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " AS UPJANG \n");
		sbSql.append("            , '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AS NEED_DATE \n");
		sbSql.append("            , A.ITEM_CODE, C.ITEM_NAME, C.ITEM_SIZE, C.PO_UOM \n");
		sbSql.append("            , C.TAX_CODE, C.KEEPING_TYPE, C.ORIGIN_TYPE \n");
		sbSql.append("            , A.SALE_PRICE \n");
		sbSql.append("            , C.ITEM_CLASS4 \n");
		if (strIndex.equals("1"))
		{
// 			sbSql.append("            , NVL(K.D_DAYS,0) + 1 AS D_DAYS \n");
            sbSql.append(" 	            /* 구매 D_DAYS 사용(기존 +1 삭제) */ \n");
			sbSql.append("            , NVL(K.D_DAYS,0) AS D_DAYS \n");
			sbSql.append("            , TRIM(TO_CHAR(DECODE(K.D_TIMES,'',2400,0,2400,K.D_TIMES*100),'0000')) AS D_TIMES \n");
		}
		else if (strIndex.equals("2"))
			sbSql.append("     , T.MON, T.TUE, T.WED, T.THU, T.FRI, T.SAT, T.SUN \n");
		sbSql.append("         FROM HLDC_PO_ITEM_MST C \n");

		sbSql.append("            ,(SELECT /*+ NO_MERGE  */ A.* \n");
		sbSql.append("                FROM HLDC_PO_CONTRACT_FSALE A, HLDC_ST_UPJANG B \n");
		sbSql.append("               WHERE A.UPJANG = B.AP_UNITPRICE_UPJANG \n");
		sbSql.append("                 AND B.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
		sbSql.append("                 AND A.ITEM_CODE > ' ' \n");
		sbSql.append("                 AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' BETWEEN A.CONTRACT_START AND NVL(A.CONTRACT_END,'99999999') \n");
		sbSql.append("                 AND A.SALE_PRICE > 0 AND A.USE_YN = 'Y') A \n");
		
		if (strIndex.equals("1"))
			sbSql.append("            , HLDC_PO_PREORDER_LIST K \n");
		else if (strIndex.equals("2"))
		{
			/*
			sbSql.append("     ,(SELECT A.CENTER_CODE, A.CUSTCD, A.ITEM_CODE \n");
			sbSql.append("            , (SELECT AP_UNITPRICE_UPJANG FROM HLDC_ST_UPJANG WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + ") AS UPJANG \n");
			sbSql.append("            , A.MON, A.TUE, A.WED, A.THU, A.FRI, A.SAT, A.SUN \n");
			sbSql.append("         FROM HLDC_PO_ORDER_SCHEDULE A \n");
			sbSql.append("            ,(SELECT CENTER_CODE, CUSTCD, MAX(UPJANG) AS UPJANG \n");
			sbSql.append("                FROM HLDC_PO_ORDER_SCHEDULE \n");
			sbSql.append("               WHERE CENTER_CODE = (SELECT A.CENTER_CODE FROM HLDC_PO_UPJANG_CENTER A, HLDC_ST_UPJANG B WHERE A.UPJANG = B.AP_UNITPRICE_UPJANG AND B.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + ") \n");
			sbSql.append("                 AND UPJANG IN (-2,(SELECT AP_UNITPRICE_UPJANG FROM HLDC_ST_UPJANG WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + ")) \n");
			sbSql.append("               GROUP BY CENTER_CODE, CUSTCD) B \n");
			sbSql.append("        WHERE A.CENTER_CODE = B.CENTER_CODE \n");
			sbSql.append("          AND A.CUSTCD = B.CUSTCD \n");
			sbSql.append("          AND A.UPJANG = B.UPJANG) T \n");
			*/
			sbSql.append("     ,(SELECT /*+ NO_MERGE INDEX(A.MR ESPSSGPITM_PK) */A.CENTER_CODE, A.CUSTCD, A.ITEM_CODE \n");
			sbSql.append("            , A.UPJANG AS UPJANG \n");
			sbSql.append("            , A.MON, A.TUE, A.WED, A.THU, A.FRI, A.SAT, A.SUN \n");
			sbSql.append("         FROM FMP_ORDER_SCHEDULE A, HLDC_ST_UPJANG B \n");
			sbSql.append("        WHERE A.UPJANG = B.AP_UNITPRICE_UPJANG \n");
			sbSql.append("          AND B.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
			sbSql.append("          AND A.CUSTCD = B.CUSTCD) T \n");
		}
		sbSql.append("        WHERE A.ITEM_CODE = C.ITEM_CODE \n");
		sbSql.append("          AND C.USE_YN = 'Y' \n");
		sbSql.append("          AND C.ITEM_CODE LIKE 'F%' \n");
		if (strIndex.equals("1"))
		{
			sbSql.append("          AND A.CENTER_CODE = K.CENTER_CODE(+) \n");
			sbSql.append("          AND A.ITEM_CODE = K.ITEM_CODE(+) \n");
		}
		else if (strIndex.equals("2"))
		{
			sbSql.append("          AND A.CENTER_CODE = T.CENTER_CODE \n");
			sbSql.append("          AND A.CUSTCD = T.CUSTCD \n");
			sbSql.append("          AND A.UPJANG = T.UPJANG \n");
			sbSql.append("          AND A.ITEM_CODE = T.ITEM_CODE \n");
			sbSql.append("          AND T.MON||T.TUE||T.WED||T.THU||T.FRI||T.SAT||T.SUN <> 'NNNNNNN' \n");
		}
		//공급업체는 선발주만 있다.
		if (strIndex.equals("1"))
		{
			sbSql.append("       ----------- \n");
			sbSql.append("        UNION ALL \n");
			sbSql.append("       ----------- \n");
			sbSql.append("       SELECT " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " AS UPJANG \n");
			sbSql.append("            , '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AS NEED_DATE \n");
			sbSql.append("            , A.ITEM_CODE, C.ITEM_NAME, C.ITEM_SIZE, C.PO_UOM \n");
			sbSql.append("            , C.TAX_CODE, C.KEEPING_TYPE, C.ORIGIN_TYPE \n");
			sbSql.append("            , A.SALE_PRICE \n");
			sbSql.append("            , C.ITEM_CLASS4 \n");
			if (strIndex.equals("1"))
			{
				sbSql.append("            , NVL(C.D_DAYS,0) + 1 AS D_DAYS \n");
				sbSql.append("            , TRIM(TO_CHAR(DECODE(C.D_TIMES,'',2400,0,2400,TO_NUMBER(C.D_TIMES)),'0000')) AS D_TIMES \n");
			}
			else if (strIndex.equals("2"))
				sbSql.append("     , 'N' AS MON, 'N' AS TUE, 'N' AS WED, 'N' AS THU, 'N' AS FRI, 'N' AS SAT, 'N' AS SUN \n");
			sbSql.append("         FROM FMP_OTCUST_PRICE_AVA_V A \n");
			sbSql.append("            ,(SELECT UPJANG, ITEM_CODE, MAX(SDATE) AS SDATE \n");
			sbSql.append("                FROM FMP_OTCUST_PRICE_AVA_V \n");
			sbSql.append("               WHERE UPJANG = (SELECT OTCUST_PRICE_UPJANG FROM FMS_UPJANG WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + ") \n");
			sbSql.append("                 AND SDATE <= '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' \n");
			sbSql.append("               GROUP BY UPJANG, ITEM_CODE) B \n");
			sbSql.append("            , FMP_OTCUST_ITEM C \n");
			sbSql.append("        WHERE A.UPJANG = B.UPJANG \n");
			sbSql.append("          AND A.SDATE = B.SDATE \n");
			sbSql.append("          AND A.ITEM_CODE = B.ITEM_CODE \n");
			sbSql.append("          AND A.ITEM_CODE = C.ITEM_CODE \n");
			sbSql.append("          AND A.USE_YN = 'Y' AND C.USE_YN = 'Y' \n");
		}
		sbSql.append("      ) A, \n");
		
		sbSql.append("      ( \n");         
        sbSql.append("       SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL \n"); 
        sbSql.append("         FROM FMU_OP_RATE \n");
        sbSql.append("        WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
        sbSql.append("          AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "'  BETWEEN SDATE AND EDATE \n"); 
        sbSql.append("          AND USE_YN = 'Y' \n");
        sbSql.append("          AND ITEM_TYPE = 'M' \n");
        sbSql.append("      ) C, \n");
        sbSql.append("      ( \n");         
        sbSql.append("       SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL \n"); 
        sbSql.append("         FROM FMU_OP_RATE \n");
        sbSql.append("        WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
        sbSql.append("          AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "'  BETWEEN SDATE AND EDATE \n"); 
        sbSql.append("          AND USE_YN = 'Y' \n");
        sbSql.append("          AND ITEM_TYPE = 'C' \n");
        sbSql.append("      ) D \n");
		
		sbSql.append(" WHERE 1 = 1 \n");
		sbSql.append("   AND A.ITEM_CODE = C.ITEM_CODE(+) \n");
		sbSql.append("   AND A.ITEM_CLASS4 = D.ITEM_CODE(+) \n");
		
		if (strIndex.equals("1"))
		{
			String sWhere = nullToBlank(ds_cond.getString(0, "PREORD"));
			if (sWhere.equals(""))
				sbSql.append("   AND A.D_DAYS > 1 \n");
			else
				sbSql.append("   AND A.D_DAYS = '" + sWhere + "' \n");
		}
		else if (strIndex.equals("2"))
		{
			//String[] strWeek = {"SUN","MON","TUE","WED","THU","FRI","SAT"};
			String sWhere = nullToBlank(ds_cond.getString(0, "WEEK"));
			if (sWhere.equals("1")) 
				sbSql.append("   AND A.SUN = 'Y' \n");
			else if (sWhere.equals("2"))
				sbSql.append("   AND A.MON = 'Y' \n");
			else if (sWhere.equals("3"))
				sbSql.append("   AND A.TUE = 'Y' \n");
			else if (sWhere.equals("4"))
				sbSql.append("   AND A.WED = 'Y' \n");
			else if (sWhere.equals("5"))
				sbSql.append("   AND A.THU = 'Y' \n");
			else if (sWhere.equals("6"))
				sbSql.append("   AND A.FRI = 'Y' \n");
			else if (sWhere.equals("7"))
				sbSql.append("   AND A.SAT = 'Y' \n");
		}
		sbSql.append(" ORDER BY A.ITEM_CODE \n");

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
		String strIndex     = nullToBlank(in_vl.getString("strIndex"));
		//FileLog.println("d:\\aaa.txt", ds_cond);


		//out 데이타
		DataSet ds_list;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		//내역조회
		sbSql.append("SELECT A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM \n");
		sbSql.append("     , A.TAX_CODE, A.KEEPING_TYPE, A.ORIGIN_TYPE \n");
		sbSql.append("     , DECODE(SIGN(NVL(C.OP_PRICE,0)),0, SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE) AS OP_PRICE \n");
		if (strIndex.equals("1"))
			sbSql.append("     , 'D-'||TO_CHAR(A.D_DAYS)||'  '||SUBSTR(A.D_TIMES,1,2)||':'||SUBSTR(A.D_TIMES,3) AS ITEM_INFO \n");
		else if (strIndex.equals("2"))
		{
			sbSql.append("     , DECODE(NVL(A.MON,'N'),'Y','월 ') \n");
			sbSql.append("     ||DECODE(NVL(A.TUE,'N'),'Y','화 ') \n");
			sbSql.append("     ||DECODE(NVL(A.WED,'N'),'Y','수 ') \n");
			sbSql.append("     ||DECODE(NVL(A.THU,'N'),'Y','목 ') \n");
			sbSql.append("     ||DECODE(NVL(A.FRI,'N'),'Y','금 ') \n");
			sbSql.append("     ||DECODE(NVL(A.SAT,'N'),'Y','토 ') \n");
			sbSql.append("     ||DECODE(NVL(A.SUN,'N'),'Y','일') AS ITEM_INFO \n");
		}			
		sbSql.append("  FROM FMU_OP_RATE C \n");
		sbSql.append("     ,(SELECT " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " AS UPJANG \n");
		sbSql.append("            , '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AS NEED_DATE \n");
		sbSql.append("            , A.ITEM_CODE, C.ITEM_NAME, C.ITEM_SIZE, C.PO_UOM \n");
		sbSql.append("            , C.TAX_CODE, C.KEEPING_TYPE, C.ORIGIN_TYPE \n");
		sbSql.append("            , A.SALE_PRICE \n");
		if (strIndex.equals("1"))
		{
			//sbSql.append("              --디데이날짜와 입고일이 같으면 디타임을 체크하여 넘었으면 디데이 하루 추가 \n");
			//sbSql.append("            , DECODE( SIGN(TO_DATE('" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "','YYYYMMDD') - TO_DATE(TO_CHAR(SYSDATE,'YYYYMMDD'),'YYYYMMDD') - NVL(K.D_DAYS,0) - 1) \n");
			//sbSql.append("                    , 0, DECODE(SIGN(DECODE(K.D_TIMES,'',24,0,24,K.D_TIMES) - TO_NUMBER(TO_CHAR(SYSDATE,'HH24'))),1,0,1) \n");
			//sbSql.append("                    , 0 ) + NVL(K.D_DAYS,0) + 1 AS D_DAYS \n");
			sbSql.append("            , NVL(K.D_DAYS,0) + 1 AS D_DAYS \n");
			sbSql.append("            , TRIM(TO_CHAR(DECODE(K.D_TIMES,'',2400,0,2400,K.D_TIMES*100),'0000')) AS D_TIMES \n");
		}
		else if (strIndex.equals("2"))
			sbSql.append("     , T.MON, T.TUE, T.WED, T.THU, T.FRI, T.SAT, T.SUN \n");
		sbSql.append("         FROM HLDC_PO_ITEM_MST C \n");

		sbSql.append("            ,(SELECT /*+ INDEX(A PO_CONTRACT_FSALE_PK) */ * \n");
		sbSql.append("                FROM HLDC_PO_CONTRACT_FSALE A \n");
		sbSql.append("               WHERE A.CENTER_CODE = (SELECT A.CENTER_CODE FROM HLDC_PO_UPJANG_CENTER A, HLDC_ST_UPJANG B WHERE A.UPJANG = B.AP_UNITPRICE_UPJANG AND B.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + ") \n");
		sbSql.append("                 AND A.UPJANG = (SELECT AP_UNITPRICE_UPJANG FROM HLDC_ST_UPJANG WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + ") \n");
		sbSql.append("                 AND A.ITEM_CODE > ' ' \n");
		sbSql.append("                 AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' BETWEEN A.CONTRACT_START AND NVL(A.CONTRACT_END,'99999999') \n");
		sbSql.append("                 AND A.SALE_PRICE > 0 AND A.USE_YN = 'Y') A \n");
		
		if (strIndex.equals("1"))
			sbSql.append("            , HLDC_PO_PREORDER_LIST K \n");
		else if (strIndex.equals("2"))
		{
			sbSql.append("     ,(SELECT A.CENTER_CODE, A.CUSTCD, A.ITEM_CODE \n");
			sbSql.append("            , (SELECT AP_UNITPRICE_UPJANG FROM HLDC_ST_UPJANG WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + ") AS UPJANG \n");
			sbSql.append("            , A.MON, A.TUE, A.WED, A.THU, A.FRI, A.SAT, A.SUN \n");
			sbSql.append("         FROM HLDC_PO_ORDER_SCHEDULE A \n");
			sbSql.append("            ,(SELECT CENTER_CODE, CUSTCD, MAX(UPJANG) AS UPJANG \n");
			sbSql.append("                FROM HLDC_PO_ORDER_SCHEDULE \n");
			sbSql.append("               WHERE CENTER_CODE = (SELECT A.CENTER_CODE FROM HLDC_PO_UPJANG_CENTER A, HLDC_ST_UPJANG B WHERE A.UPJANG = B.AP_UNITPRICE_UPJANG AND B.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + ") \n");
			sbSql.append("                 AND UPJANG IN (-2,(SELECT AP_UNITPRICE_UPJANG FROM HLDC_ST_UPJANG WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + ")) \n");
			sbSql.append("               GROUP BY CENTER_CODE, CUSTCD) B \n");
			sbSql.append("        WHERE A.CENTER_CODE = B.CENTER_CODE \n");
			sbSql.append("          AND A.CUSTCD = B.CUSTCD \n");
			sbSql.append("          AND A.UPJANG = B.UPJANG) T \n");
		}
		sbSql.append("        WHERE A.ITEM_CODE = C.ITEM_CODE \n");
		sbSql.append("          AND EXISTS (SELECT 1 FROM HLDC_PO_TREAT_UPJANG X WHERE X.ITEM_CODE = A.ITEM_CODE AND UPJANG = (SELECT AP_UNITPRICE_UPJANG FROM HLDC_ST_UPJANG WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + ")) \n");
		sbSql.append("          AND C.USE_YN = 'Y' \n");
		sbSql.append("          AND C.ITEM_CODE BETWEEN '010000000000' AND '019999999999' \n");
		if (strIndex.equals("1"))
		{
			sbSql.append("          AND A.CENTER_CODE = K.CENTER_CODE(+) \n");
			sbSql.append("          AND A.ITEM_CODE = K.ITEM_CODE(+) \n");
		}
		else if (strIndex.equals("2"))
		{
			sbSql.append("          AND A.CENTER_CODE = T.CENTER_CODE \n");
			sbSql.append("          AND A.CUSTCD = T.CUSTCD \n");
			sbSql.append("          AND A.UPJANG = T.UPJANG \n");
			sbSql.append("          AND A.ITEM_CODE = T.ITEM_CODE \n");
			sbSql.append("          AND T.MON||T.TUE||T.WED||T.THU||T.FRI||T.SAT||T.SUN <> 'NNNNNNN' \n");
		}
		//공급업체는 선발주만 있다.
		if (strIndex.equals("1"))
		{
			sbSql.append("       ----------- \n");
			sbSql.append("        UNION ALL \n");
			sbSql.append("       ----------- \n");
			sbSql.append("       SELECT " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " AS UPJANG \n");
			sbSql.append("            , '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AS NEED_DATE \n");
			sbSql.append("            , A.ITEM_CODE, C.ITEM_NAME, C.ITEM_SIZE, C.PO_UOM \n");
			sbSql.append("            , C.TAX_CODE, C.KEEPING_TYPE, C.ORIGIN_TYPE \n");
			sbSql.append("            , A.SALE_PRICE \n");
			if (strIndex.equals("1"))
			{
				//sbSql.append("              --디데이날짜와 입고일이 같으면 디타임을 체크하여 넘었으면 디데이 하루 추가 \n");
				//sbSql.append("            , DECODE( SIGN(TO_DATE('" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "','YYYYMMDD') - TO_DATE(TO_CHAR(SYSDATE,'YYYYMMDD'),'YYYYMMDD') - NVL(C.D_DAYS,0) - 1) \n");
				//sbSql.append("                    , 0, DECODE(SIGN(DECODE(C.D_TIMES,'',2400,0,2400,TO_NUMBER(C.D_TIMES)) - TO_NUMBER(TO_CHAR(SYSDATE,'HH24MI'))),1,0,1) \n");
				//sbSql.append("                    , 0 ) + NVL(C.D_DAYS,0) + 1 AS D_DAYS \n");
				sbSql.append("            , NVL(C.D_DAYS,0) + 1 AS D_DAYS \n");
				sbSql.append("            , TRIM(TO_CHAR(DECODE(C.D_TIMES,'',2400,0,2400,TO_NUMBER(C.D_TIMES)),'0000')) AS D_TIMES \n");
			}
			else if (strIndex.equals("2"))
				sbSql.append("     , 'N' AS MON, 'N' AS TUE, 'N' AS WED, 'N' AS THU, 'N' AS FRI, 'N' AS SAT, 'N' AS SUN \n");
			sbSql.append("         FROM FMP_OTCUST_PRICE_AVA_V A \n");
			sbSql.append("            ,(SELECT UPJANG, ITEM_CODE, MAX(SDATE) AS SDATE \n");
			sbSql.append("                FROM FMP_OTCUST_PRICE_AVA_V \n");
			sbSql.append("               WHERE UPJANG = (SELECT OTCUST_PRICE_UPJANG FROM FMS_UPJANG WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + ") \n");
			sbSql.append("                 AND SDATE <= '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' \n");
			sbSql.append("               GROUP BY UPJANG, ITEM_CODE) B \n");
			sbSql.append("            , FMP_OTCUST_ITEM C \n");
			sbSql.append("        WHERE A.UPJANG = B.UPJANG \n");
			sbSql.append("          AND A.SDATE = B.SDATE \n");
			sbSql.append("          AND A.ITEM_CODE = B.ITEM_CODE \n");
			sbSql.append("          AND A.ITEM_CODE = C.ITEM_CODE \n");
			sbSql.append("          AND A.USE_YN = 'Y' AND C.USE_YN = 'Y' \n");
		}
		sbSql.append("      ) A \n");
		sbSql.append(" WHERE A.UPJANG = C.UPJANG(+) \n");
		sbSql.append("   AND A.NEED_DATE BETWEEN C.SDATE(+) AND C.EDATE(+) \n");
		sbSql.append("   AND A.ITEM_CODE BETWEEN C.ITEM_CODE(+) AND C.ITEM_CODE(+)||'9999' \n");
		sbSql.append("   AND C.USE_YN(+) = 'Y' \n");
		if (strIndex.equals("1"))
		{
			String sWhere = nullToBlank(ds_cond.getString(0, "PREORD"));
			if (sWhere.equals(""))
				sbSql.append("   AND A.D_DAYS > 1 \n");
			else
				sbSql.append("   AND A.D_DAYS = '" + sWhere + "' \n");
		}
		else if (strIndex.equals("2"))
		{
			//String[] strWeek = {"SUN","MON","TUE","WED","THU","FRI","SAT"};
			String sWhere = nullToBlank(ds_cond.getString(0, "WEEK"));
			if (sWhere.equals("1")) 
				sbSql.append("   AND A.SUN = 'Y' \n");
			else if (sWhere.equals("2"))
				sbSql.append("   AND A.MON = 'Y' \n");
			else if (sWhere.equals("3"))
				sbSql.append("   AND A.TUE = 'Y' \n");
			else if (sWhere.equals("4"))
				sbSql.append("   AND A.WED = 'Y' \n");
			else if (sWhere.equals("5"))
				sbSql.append("   AND A.THU = 'Y' \n");
			else if (sWhere.equals("6"))
				sbSql.append("   AND A.FRI = 'Y' \n");
			else if (sWhere.equals("7"))
				sbSql.append("   AND A.SAT = 'Y' \n");
		}
		sbSql.append(" ORDER BY A.ITEM_CODE \n");

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

--%>
