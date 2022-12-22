<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/단가관리/공급업체관리
■ 프로그램ID   : FMU00240E_T001.jsp
■ 프로그램명   : 운영율 등록관리(조회)
■ 작성일자     : 2008.04.14
■ 작성자       : 박은규
■ 이력관리     : 2008.04.14
               PO_TREAT_UPJANG에 없는 건 기본 조회에서 제외되나, 일단 한번 운영율 등록된 품목은 조회되어야 한다.
               즉, 신규작업인 경우에만 PO_TREAT_UPJANG에 있어야 조회된다.
               [고도화]_HLDC_PO_TREAT_UPJANG -> HLDC_PO_CONTRACT_FSALE 테이블로 통합_김경은 
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
		String sCopy        = nullToBlank(in_vl.getString("sCopy"));
		String sBefore      = nullToBlank(in_vl.getString("sBefore"));

		//out 데이타
		DataSet ds_List;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		
		//단가계약업장 가져오기
		sbSql.delete(0, sbSql.length());
		sbSql.append("SELECT AP_UNITPRICE_UPJANG \n");
		sbSql.append("  FROM HLDC_ST_UPJANG \n"); 
		sbSql.append(" WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
	    
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		rs.next();
		String sApUnitpriceUpjang = rs.getString("AP_UNITPRICE_UPJANG");
		rs.close();
		pstmt.close();
		
		//내역조회
		sbSql.delete(0, sbSql.length());
		sbSql.append("SELECT A.SDATE \n");
		sbSql.append("     , A.EDATE \n");
		sbSql.append("     , A.UPJANG, A.CONSUM_YN, A.ITEM_CLASS2, A.ITEM_CLASS3, A.ITEM_CLASS4 \n");
		sbSql.append("     , NULL AS CONSUM_NAME \n");
		sbSql.append("     ,(SELECT Z.CLASS_NAME FROM HLDC_PO_ITEM_CLASS Z WHERE Z.CLASS_CODE = A.ITEM_CLASS2) AS CLASS_NAME2 \n");
		sbSql.append("     , NULL AS CLASS_NAME3 \n");
		sbSql.append("     , NULL AS CLASS_NAME4 \n");
		sbSql.append("     , A.ITEM_CODE, A.ITEM_NAME \n");
		sbSql.append("     , DECODE(A.TAX_CODE,'100','과)','면)')||A.ITEM_SIZE AS ITEM_SIZE \n");
		sbSql.append("     , A.PO_UOM \n");
		sbSql.append("     , DECODE(A.TAX_CODE,'100','과세','면세') AS TAX_CODE \n");
		sbSql.append("     ----------------------------- \n");
		sbSql.append("     , TO_CHAR(TO_DATE(C.SDATE,'YYYYMMDD'),'YYYY-MM-DD') AS PRE_SDATE \n");
		sbSql.append("     , TO_CHAR(TO_DATE(C.EDATE,'YYYYMMDD'),'YYYY-MM-DD') AS PRE_EDATE \n");
		sbSql.append("     , DECODE(C.SDATE,NULL,NULL,FMU_ITEMSALEPRICE_FUN(A.UPJANG,A.ITEM_CODE,C.SDATE)) AS PRE_SALE_PRICE \n");
		sbSql.append("     , C.OP_RATE AS PRE_OP_RATE \n");
		sbSql.append("     , C.OP_PRICE AS PRE_OP_PRICE \n");
		sbSql.append("     , A.CUSER\n");
		sbSql.append("     , TO_CHAR(A.CDATE,'YYYY-MM-DD HH24:MI:SS') AS CDATE \n");
		sbSql.append("     , A.UUSER\n");
		sbSql.append("     , TO_CHAR(A.UDATE,'YYYY-MM-DD HH24:MI:SS') AS UDATE \n");
		sbSql.append("     ----------------------------- \n");
		sbSql.append("     , A.SALE_PRICE \n");
		sbSql.append("     , A.ORIGIN_TYPE \n"); 
		if (sCopy.equals("0"))
		{
			sbSql.append("     , DECODE(A.FROM_GB,'Z',A.OP_PRICE,NVL(B.OP_PRICE,0)) AS OP_PRICE \n");
			sbSql.append("     , DECODE(A.FROM_GB,'Z',ROUND(A.OP_RATE, 1),0) AS OP_RATE \n");			
			sbSql.append("     , DECODE(DECODE(A.FROM_GB,'Z',NVL(A.OP_PRICE,0),NVL(B.OP_PRICE,0)),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * DECODE(A.FROM_GB,'Z',A.OP_RATE,0) / 100),DECODE(A.FROM_GB,'Z',A.CEIL_VAL,0)), DECODE(A.FROM_GB,'Z',A.OP_PRICE,NVL(B.OP_PRICE,0)) ) AS OP_AMT \n");			
			sbSql.append("     , DECODE(A.FROM_GB,'Z',A.CEIL_VAL,0) AS CEIL_VAL \n");
		}
		else
		{
			sbSql.append("     , DECODE(A.FROM_GB,'Z',A.OP_PRICE,NVL(B.OP_PRICE,NVL(C.OP_PRICE,0))) AS OP_PRICE \n");
			sbSql.append("     , DECODE(A.FROM_GB,'Z',ROUND(A.OP_RATE, 1),NVL(ROUND(C.OP_RATE, 1),0)) AS OP_RATE \n");			
			sbSql.append("     , DECODE(DECODE(A.FROM_GB,'Z',NVL(A.OP_PRICE,0),NVL(B.OP_PRICE,NVL(C.OP_PRICE,0))),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * DECODE(A.FROM_GB,'Z',A.OP_RATE,NVL(C.OP_RATE,0)) / 100),DECODE(A.FROM_GB,'Z',A.CEIL_VAL,NVL(C.CEIL_VAL,0))), DECODE(A.FROM_GB,'Z',A.OP_PRICE,NVL(B.OP_PRICE,NVL(C.OP_PRICE,0))) ) AS OP_AMT \n");			
			sbSql.append("     , DECODE(A.FROM_GB,'Z',A.CEIL_VAL,NVL(C.CEIL_VAL,0)) AS CEIL_VAL \n");
		}
		sbSql.append("     , B.ITEM_CODE AS FIXED_ITEM, A.FROM_GB \n");
		sbSql.append("  FROM (SELECT * FROM FMU_OP_FIX_LIST WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " AND USE_YN = 'Y') B \n");

		if (sBefore.equals("1"))
		{		
			sbSql.append("     , ( \n");
			sbSql.append("        SELECT T.* \n");
	        sbSql.append("          FROM ( \n");
	        sbSql.append("                SELECT A.UPJANG \n");
	        sbSql.append("                     , A.ITEM_CODE \n");
	        sbSql.append("                     , A.SDATE \n");
	        sbSql.append("                     , A.EDATE \n");
	        sbSql.append("                     , A.OP_RATE \n");
	        sbSql.append("                     , A.OP_PRICE \n");
	        sbSql.append("                     , A.CEIL_VAL \n");
	        sbSql.append("                     , A.CUSER \n");
	        sbSql.append("                     , A.CDATE \n");
	        sbSql.append("                     , A.UUSER \n");
	        sbSql.append("                     , A.UDATE \n");
	        sbSql.append("                     , RANK() OVER(PARTITION BY A.UPJANG, A.ITEM_CODE ORDER BY A.SDATE DESC) AS RANK \n");
	        sbSql.append("                  FROM FMU_OP_RATE A \n");
	        sbSql.append("                 WHERE A.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n"); 
	        sbSql.append("                   AND A.SDATE < '" + nullToBlank(ds_cond.getString(0, "SDATE")) + "' \n"); 
	        sbSql.append("                   AND A.SDATE <> '00000000' \n"); 
	        sbSql.append("                   AND A.ITEM_TYPE = 'M' \n"); 
	        sbSql.append("                   AND A.USE_YN = 'Y' \n"); 
	        sbSql.append("               ) T \n");
	        sbSql.append("         WHERE T.RANK = 1 \n");
	        sbSql.append("       ) C \n");
		}
		else
		{
			sbSql.append("     , (SELECT 0 AS UPJANG \n");
			sbSql.append("             , '' AS ITEM_CODE \n");
			sbSql.append("             , '' AS SDATE \n");
			sbSql.append("             , '' AS EDATE \n");
			sbSql.append("             , 0 AS OP_RATE \n");
			sbSql.append("             , 0 AS OP_PRICE \n");
			sbSql.append("             , 0 AS CEIL_VAL \n");
			sbSql.append("          FROM DUAL \n");
			sbSql.append("       ) C \n");			
		}
		sbSql.append("     , (SELECT " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " AS UPJANG \n");
		sbSql.append("             , A.CONSUM_YN, A.ITEM_CLASS2, A.ITEM_CLASS3, A.ITEM_CLASS4 \n");
		sbSql.append("             , A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM, A.TAX_CODE \n");
		sbSql.append("             , SUM(A.SALE_PRICE) AS SALE_PRICE \n");
		sbSql.append("             , SUM(A.OP_PRICE) AS OP_PRICE \n");
		sbSql.append("             , SUM(A.OP_RATE) AS OP_RATE \n");
		sbSql.append("             , SUM(A.CEIL_VAL) AS CEIL_VAL \n");
		sbSql.append("             , MAX(A.SDATE) AS SDATE \n");
		sbSql.append("             , MAX(A.EDATE) AS EDATE \n");
		sbSql.append("             , MAX(A.FROM_GB) AS FROM_GB \n");
		sbSql.append("             , MAX(A.ORIGIN_TYPE) AS ORIGIN_TYPE \n");
		sbSql.append("             , MAX(A.CDATE) AS CDATE \n");
		sbSql.append("             , MAX(A.CUSER) AS CUSER \n");
		sbSql.append("             , MAX(A.UDATE) AS UDATE \n");
		sbSql.append("             , MAX(A.UUSER) AS UUSER \n");
		sbSql.append("          FROM \n");
		sbSql.append("              ( \n");
		sbSql.append("               SELECT B.CONSUM_YN, B.ITEM_CLASS2, B.ITEM_CLASS3, B.ITEM_CLASS4 \n");
		sbSql.append("                    , A.ITEM_CODE, B.ITEM_NAME, B.ITEM_SIZE, B.PO_UOM, B.TAX_CODE \n");
		sbSql.append("                    , C.SALE_PRICE, A.OP_PRICE, A.OP_RATE \n");
		sbSql.append("                    , B.OTCUSTCD, A.SDATE, A.EDATE \n");
		sbSql.append("                    , A.CEIL_VAL \n");
		sbSql.append("                    , A.CDATE \n");
		sbSql.append("                    , A.CUSER \n");
		sbSql.append("                    , A.UDATE \n");
		sbSql.append("                    , A.UUSER \n");
		sbSql.append("                    , 'Z' AS FROM_GB, B.ORIGIN_TYPE \n");
		sbSql.append("                 FROM FMU_OP_RATE A, FMS_ITEM_V B, HLDC_PO_CONTRACT_FSALE C \n");
		sbSql.append("                WHERE A.ITEM_CODE = B.ITEM_CODE \n");
		sbSql.append("                  AND A.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
		sbSql.append("                  AND " + sApUnitpriceUpjang + " = C.UPJANG(+) \n");
		sbSql.append("                  AND A.ITEM_CODE = C.ITEM_CODE(+) \n");
		sbSql.append("                  AND A.SDATE = '" + nullToBlank(ds_cond.getString(0, "SDATE")) + "' \n");
		sbSql.append("                  AND '" + nullToBlank(ds_cond.getString(0, "SDATE")) + "' BETWEEN C.CONTRACT_START(+) AND NVL(C.CONTRACT_END(+), '99999999') \n");
		sbSql.append("                  AND A.ITEM_TYPE = 'M' \n");
		sbSql.append("                  AND C.CENTER_CODE = (SELECT X.CENTER_CODE FROM HLDC_PO_UPJANG_CENTER X WHERE X.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + ") \n");
		sbSql.append("                  AND A.USE_YN = 'Y' \n");
		sbSql.append("              ) A \n");
		String sOtcust = nullToBlank(ds_cond.getString(0, "OTCUSTCD"));
		if (! sOtcust.equals(""))
			sbSql.append("         WHERE A.OTCUSTCD = '" + nullToBlank(ds_cond.getString(0, "OTCUSTCD")) + "' \n");
		else
			sbSql.append("         WHERE EXISTS (SELECT 1 FROM FMP_OTCUST_LINK Z WHERE Z.OTCUSTCD = A.OTCUSTCD AND Z.USE_YN = 'Y' AND Z.UPJANG = '" + nullToBlank(ds_cond.getString(0, "MAIN_UPJANG")) + "') \n");
		sbSql.append("         GROUP BY A.CONSUM_YN, A.ITEM_CLASS2, A.ITEM_CLASS3, A.ITEM_CLASS4 \n");
		sbSql.append("                , A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM, A.TAX_CODE \n");
		sbSql.append("       ) A \n");
		sbSql.append(" WHERE A.UPJANG = B.UPJANG(+) \n");
		sbSql.append("   AND A.ITEM_CODE = B.ITEM_CODE(+) \n");
		sbSql.append("   AND A.UPJANG = C.UPJANG(+) \n");
		sbSql.append("   AND A.ITEM_CODE = C.ITEM_CODE(+) \n");
		sbSql.append("   AND DECODE(A.FROM_GB,'Z',9999,A.SALE_PRICE) > 0 \n");

		out_vl.add("fa_Sql", sbSql.toString());
		
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
		String sCopy        = nullToBlank(in_vl.getString("sCopy"));
		String sBefore      = nullToBlank(in_vl.getString("sBefore"));
		//FileLog.println("d:\\aaa.txt", ds_cond);

		//out 데이타
		DataSet ds_List;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		//운영율 구분
		sbSql.append("SELECT 1 \n");
		sbSql.append("  FROM FMS_UPJANG A \n");
		sbSql.append(" WHERE A.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
//		sbSql.append("   AND A.OP_RATE_YN = 'I' \n");

out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		if (! rs.next())
		{
			this.setResultMessage(-1, "해당 업장은 상품별 운영율 사용설정을 하지 않았습니다!", out_vl);
			proc_output(response,out,out_vl,out_dl);
			return;
		}
		
		//내역조회
		sbSql.delete(0, sbSql.length());
		sbSql.append("SELECT '" + nullToBlank(ds_cond.getString(0, "SDATE")) + "' AS SDATE \n");
		sbSql.append("     , '" + nullToBlank(ds_cond.getString(0, "EDATE")) + "' AS EDATE \n");
		sbSql.append("     , A.UPJANG, A.CONSUM_YN, A.ITEM_CLASS2, A.ITEM_CLASS3, A.ITEM_CLASS4 \n");
		sbSql.append("     , NULL AS CONSUM_NAME \n");
		sbSql.append("     ,(SELECT Z.CLASS_NAME FROM HLDC_PO_ITEM_CLASS Z WHERE Z.CLASS_CODE = A.ITEM_CLASS2) AS CLASS_NAME2 \n");
		sbSql.append("     , NULL AS CLASS_NAME3 \n");
		sbSql.append("     , NULL AS CLASS_NAME4 \n");
		sbSql.append("     , A.ITEM_CODE, A.ITEM_NAME \n");
		sbSql.append("     , DECODE(A.TAX_CODE,'100','과)','면)')||A.ITEM_SIZE AS ITEM_SIZE \n");
		sbSql.append("     , A.PO_UOM \n");
		sbSql.append("     , DECODE(A.TAX_CODE,'100','과세','면세') AS TAX_CODE \n");
		sbSql.append("     ----------------------------- \n");
		sbSql.append("     , TO_CHAR(TO_DATE(C.SDATE,'YYYYMMDD'),'YYYY-MM-DD') AS PRE_SDATE \n");
		sbSql.append("     , TO_CHAR(TO_DATE(C.EDATE,'YYYYMMDD'),'YYYY-MM-DD') AS PRE_EDATE \n");
		//sbSql.append("     , DECODE(A.CDATE,'00000000',NULL,FMU_ITEMSALEPRICE_FUN(A.UPJANG,A.ITEM_CODE,TO_CHAR(TO_DATE(A.CDATE,'YYYYMMDD')-1,'YYYYMMDD'))) AS PRE_SALE_PRICE \n");
		sbSql.append("     , DECODE(C.SDATE,NULL,NULL,FMU_ITEMSALEPRICE_FUN(A.UPJANG,A.ITEM_CODE,C.SDATE)) AS PRE_SALE_PRICE \n");
		sbSql.append("     , C.OP_RATE AS PRE_OP_RATE \n");
		sbSql.append("     , C.OP_PRICE AS PRE_OP_PRICE \n");
		sbSql.append("     ----------------------------- \n");
		//sbSql.append("     , DECODE(A.USE_YN,'N',0,A.SALE_PRICE) AS SALE_PRICE \n");
		sbSql.append("     , A.SALE_PRICE \n");
		if (sCopy.equals("0"))
		{
			sbSql.append("     , DECODE(A.FROM_GB,'Z',A.OP_PRICE,NVL(B.OP_PRICE,0)) AS OP_PRICE \n");
			sbSql.append("     , DECODE(A.FROM_GB,'Z',A.OP_RATE,0) AS OP_RATE \n");
//			sbSql.append("     , DECODE(DECODE(A.FROM_GB,'Z',A.OP_PRICE,NVL(B.OP_PRICE,0)),0,SCC_CEIL(DECODE(A.USE_YN,'N',0,A.SALE_PRICE) + ROUND(DECODE(A.USE_YN,'N',0,A.SALE_PRICE) * DECODE(A.FROM_GB,'Z',A.OP_RATE,0) / 100),DECODE(A.FROM_GB,'Z',A.CEIL_VAL,1)), DECODE(A.FROM_GB,'Z',A.OP_PRICE,NVL(B.OP_PRICE,0)) ) AS OP_AMT \n");
//			sbSql.append("     , DECODE(DECODE(A.FROM_GB,'Z',A.OP_PRICE,NVL(B.OP_PRICE,0)),0,SCC_CEIL(DECODE(A.USE_YN,'N',0,A.SALE_PRICE) + ROUND(DECODE(A.USE_YN,'N',0,A.SALE_PRICE) * DECODE(A.FROM_GB,'Z',A.OP_RATE,0) / 100),DECODE(A.FROM_GB,'Z',A.CEIL_VAL,0)), DECODE(A.FROM_GB,'Z',A.OP_PRICE,NVL(B.OP_PRICE,0)) ) AS OP_AMT \n");			
			sbSql.append("     , DECODE(DECODE(A.FROM_GB,'Z',A.OP_PRICE,NVL(B.OP_PRICE,0)),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * DECODE(A.FROM_GB,'Z',A.OP_RATE,0) / 100),DECODE(A.FROM_GB,'Z',A.CEIL_VAL,0)), DECODE(A.FROM_GB,'Z',A.OP_PRICE,NVL(B.OP_PRICE,0)) ) AS OP_AMT \n");			
			sbSql.append("     , DECODE(A.FROM_GB,'Z',A.CEIL_VAL,0) AS CEIL_VAL \n");
		}
		else
		{
			sbSql.append("     , DECODE(A.FROM_GB,'Z',A.OP_PRICE,NVL(B.OP_PRICE,NVL(C.OP_PRICE,0))) AS OP_PRICE \n");
			sbSql.append("     , DECODE(A.FROM_GB,'Z',A.OP_RATE,NVL(C.OP_RATE,0)) AS OP_RATE \n");
//			sbSql.append("     , DECODE(DECODE(A.FROM_GB,'Z',A.OP_PRICE,NVL(B.OP_PRICE,NVL(C.OP_PRICE,0))),0,SCC_CEIL(DECODE(A.USE_YN,'N',0,A.SALE_PRICE) + ROUND(DECODE(A.USE_YN,'N',0,A.SALE_PRICE) * DECODE(A.FROM_GB,'Z',A.OP_RATE,NVL(C.OP_RATE,0)) / 100),DECODE(A.FROM_GB,'Z',A.CEIL_VAL,NVL(C.CEIL_VAL,1))), DECODE(A.FROM_GB,'Z',A.OP_PRICE,NVL(B.OP_PRICE,NVL(C.OP_PRICE,0))) ) AS OP_AMT \n");
//			sbSql.append("     , DECODE(DECODE(A.FROM_GB,'Z',A.OP_PRICE,NVL(B.OP_PRICE,NVL(C.OP_PRICE,0))),0,SCC_CEIL(DECODE(A.USE_YN,'N',0,A.SALE_PRICE) + ROUND(DECODE(A.USE_YN,'N',0,A.SALE_PRICE) * DECODE(A.FROM_GB,'Z',A.OP_RATE,NVL(C.OP_RATE,0)) / 100),DECODE(A.FROM_GB,'Z',A.CEIL_VAL,NVL(C.CEIL_VAL,0))), DECODE(A.FROM_GB,'Z',A.OP_PRICE,NVL(B.OP_PRICE,NVL(C.OP_PRICE,0))) ) AS OP_AMT \n");			
			sbSql.append("     , DECODE(DECODE(A.FROM_GB,'Z',A.OP_PRICE,NVL(B.OP_PRICE,NVL(C.OP_PRICE,0))),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * DECODE(A.FROM_GB,'Z',A.OP_RATE,NVL(C.OP_RATE,0)) / 100),DECODE(A.FROM_GB,'Z',A.CEIL_VAL,NVL(C.CEIL_VAL,0))), DECODE(A.FROM_GB,'Z',A.OP_PRICE,NVL(B.OP_PRICE,NVL(C.OP_PRICE,0))) ) AS OP_AMT \n");			
			sbSql.append("     , DECODE(A.FROM_GB,'Z',A.CEIL_VAL,NVL(C.CEIL_VAL,0)) AS CEIL_VAL \n");
		}
		sbSql.append("     , B.ITEM_CODE AS FIXED_ITEM, A.FROM_GB \n");
		sbSql.append("  FROM (SELECT * FROM FMU_OP_FIX_LIST WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " AND USE_YN = 'Y') B \n");
//		sbSql.append("     , (SELECT A.UPJANG, A.ITEM_CODE, A.SDATE, A.EDATE, A.OP_RATE, A.OP_PRICE \n");
//		sbSql.append("          FROM FMU_OP_RATE A \n");
//		sbSql.append("             ,(SELECT A.UPJANG, MAX(A.SDATE) AS SDATE, MAX(A.EDATE) AS EDATE, A.ITEM_CODE \n");
//		sbSql.append("                 FROM FMU_OP_RATE A \n");
//		sbSql.append("                WHERE A.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
//		sbSql.append("                  AND A.SDATE < '" + nullToBlank(ds_cond.getString(0, "SDATE")) + "' \n");
//		sbSql.append("                  AND A.EDATE < '" + nullToBlank(ds_cond.getString(0, "EDATE")) + "' \n");
//		sbSql.append("                GROUP BY A.UPJANG, A.ITEM_CODE) B \n");
//		sbSql.append("         WHERE A.UPJANG = B.UPJANG \n");
//		sbSql.append("           AND A.SDATE = B.SDATE \n");
//		sbSql.append("           AND A.EDATE = B.EDATE \n");
//		sbSql.append("           AND A.ITEM_CODE = B.ITEM_CODE \n");
//		sbSql.append("           AND A.USE_YN = 'Y') C \n");
		if (sBefore.equals("1"))
		{		
			sbSql.append("     , (SELECT UPJANG \n");
			sbSql.append("             , ITEM_CODE \n");
			sbSql.append("             , SUBSTR(UDATA,1,8) AS SDATE \n");
			sbSql.append("             , SUBSTR(UDATA,9,8) AS EDATE \n");
			sbSql.append("             , TO_NUMBER(SUBSTR(UDATA,17,10)) AS OP_RATE \n");
			sbSql.append("             , TO_NUMBER(SUBSTR(UDATA,27,10)) AS OP_PRICE \n");
			sbSql.append("             , TO_NUMBER(SUBSTR(UDATA,37,10)) AS CEIL_VAL \n");
			sbSql.append("          FROM ( \n");
			sbSql.append("                SELECT A.UPJANG, A.ITEM_CODE, MAX(A.SDATE||A.EDATE||TRIM(TO_CHAR(LPAD(TO_CHAR(A.OP_RATE),10),'S000000000'))||TRIM(TO_CHAR(LPAD(TO_CHAR(A.OP_PRICE),10),'0000000000'))||TRIM(TO_CHAR(LPAD(TO_CHAR(A.CEIL_VAL),10),'0000000000'))) AS UDATA \n");
			sbSql.append("                  FROM FMU_OP_RATE A \n");
			sbSql.append("                 WHERE A.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
			sbSql.append("                   AND A.SDATE < '" + nullToBlank(ds_cond.getString(0, "SDATE")) + "' \n");
			sbSql.append("                   AND A.EDATE < '" + nullToBlank(ds_cond.getString(0, "EDATE")) + "' \n");
			sbSql.append("                   AND A.SDATE <> '00000000' \n");
			sbSql.append("                   AND A.USE_YN = 'Y' \n");
			sbSql.append("                 GROUP BY A.UPJANG, A.ITEM_CODE \n");
			sbSql.append("               ) \n");
			sbSql.append("       ) C \n");
		}
		else
		{
			sbSql.append("     , (SELECT 0 AS UPJANG \n");
			sbSql.append("             , '' AS ITEM_CODE \n");
			sbSql.append("             , '' AS SDATE \n");
			sbSql.append("             , '' AS EDATE \n");
			sbSql.append("             , 0 AS OP_RATE \n");
			sbSql.append("             , 0 AS OP_PRICE \n");
			sbSql.append("             , 0 AS CEIL_VAL \n");
			sbSql.append("          FROM DUAL \n");
			sbSql.append("       ) C \n");			
		}
		sbSql.append("     , (SELECT " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " AS UPJANG \n");
		sbSql.append("             , A.CONSUM_YN, A.ITEM_CLASS2, A.ITEM_CLASS3, A.ITEM_CLASS4 \n");
		sbSql.append("             , A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM, A.TAX_CODE \n");
		sbSql.append("             , SUM(A.SALE_PRICE) AS SALE_PRICE \n");
		sbSql.append("             , SUM(A.OP_PRICE) AS OP_PRICE \n");
		sbSql.append("             , SUM(A.OP_RATE) AS OP_RATE \n");
		sbSql.append("             , SUM(A.CEIL_VAL) AS CEIL_VAL \n");
		sbSql.append("             , MAX(A.CDATE) AS CDATE \n");
		//sbSql.append("             , MAX(A.USE_YN) AS USE_YN \n");
		sbSql.append("             , MAX(A.FROM_GB) AS FROM_GB \n");
		sbSql.append("          FROM \n");
		sbSql.append("              (SELECT /*+ INDEX(A PO_CONTRACT_FSALE_I2) */  \n");
		sbSql.append("                      B.CONSUM_YN, B.ITEM_CLASS2, B.ITEM_CLASS3, B.ITEM_CLASS4 \n");
		sbSql.append("                    , A.ITEM_CODE, B.ITEM_NAME, B.ITEM_SIZE, B.PO_UOM, B.TAX_CODE \n");
		sbSql.append("                    , A.SALE_PRICE, 0 AS OP_PRICE, 0 AS OP_RATE \n");
		sbSql.append("                    , '0000' AS OTCUSTCD, A.CONTRACT_START AS CDATE \n");
		sbSql.append("                    , 0 AS CEIL_VAL \n");
		//sbSql.append("                    , A.USE_YN \n");
		sbSql.append("                    , 'A' AS FROM_GB \n");
		sbSql.append("                 FROM HLDC_PO_CONTRACT_FSALE A, HLDC_PO_ITEM_MST B \n");
		sbSql.append("                WHERE A.ITEM_CODE = B.ITEM_CODE \n");
		sbSql.append("                  AND A.CENTER_CODE = (SELECT A.CENTER_CODE FROM HLDC_PO_UPJANG_CENTER A, HLDC_ST_UPJANG B WHERE A.UPJANG = B.AP_UNITPRICE_UPJANG AND B.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + ") \n");
		sbSql.append("                  AND A.UPJANG = (SELECT A.AP_UNITPRICE_UPJANG FROM HLDC_ST_UPJANG A WHERE A.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + ") \n");
		sbSql.append("                  AND A.ITEM_CODE > ' ' \n");
		sbSql.append("                  AND '" + nullToBlank(ds_cond.getString(0, "DATE")) + "' BETWEEN A.CONTRACT_START AND NVL(A.CONTRACT_END,'99999999') \n");
		sbSql.append("                  AND EXISTS (SELECT 1 FROM HLDC_PO_TREAT_UPJANG X WHERE X.ITEM_CODE = A.ITEM_CODE AND X.UPJANG = A.UPJANG) \n");
		sbSql.append("                  AND A.USE_YN = 'Y' \n");
		sbSql.append("               ----------- \n");
		sbSql.append("                UNION ALL \n");
		sbSql.append("               ----------- \n");
		sbSql.append("               SELECT /*+ NO_MERGE(A) */ B.CONSUM_YN, B.ITEM_CLASS2, B.ITEM_CLASS3, B.ITEM_CLASS4 \n");
		sbSql.append("                    , A.ITEM_CODE, B.ITEM_NAME, B.ITEM_SIZE, B.PO_UOM, B.TAX_CODE \n");
		sbSql.append("                    , A.SALE_PRICE, 0 AS OP_PRICE, 0 AS OP_RATE \n");
		sbSql.append("                    , B.OTCUSTCD, A.SDATE AS CDATE \n");
		sbSql.append("                    , 0 AS CEIL_VAL \n");
		//sbSql.append("                    , A.USE_YN \n");
		sbSql.append("                    , 'A' AS FROM_GB \n");
		sbSql.append("                 FROM FMP_OTCUST_PRICE_AVA_V A, FMP_OTCUST_ITEM B \n");
		sbSql.append("                    ,(SELECT A.UPJANG, A.ITEM_CODE, MAX(A.SDATE) AS SDATE \n");
		sbSql.append("                        FROM FMP_OTCUST_PRICE_AVA_V A \n");
		sbSql.append("                       WHERE A.UPJANG = (SELECT OTCUST_PRICE_UPJANG FROM FMS_UPJANG WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + ") \n");
		sbSql.append("                         AND A.ITEM_CODE > ' ' \n");
		sbSql.append("                         AND A.SDATE <= '" + nullToBlank(ds_cond.getString(0, "DATE")) + "' \n");
		sbSql.append("                       GROUP BY A.UPJANG, A.ITEM_CODE) C \n");
		sbSql.append("                WHERE A.ITEM_CODE = B.ITEM_CODE \n");
		sbSql.append("                  AND A.UPJANG = C.UPJANG \n");
		sbSql.append("                  AND A.ITEM_CODE = C.ITEM_CODE \n");
		sbSql.append("                  AND A.SDATE = C.SDATE \n");
		sbSql.append("                  AND A.USE_YN = 'Y' \n");
		sbSql.append("               ----------- \n");
		sbSql.append("                UNION ALL \n");
		sbSql.append("               ----------- \n");
		sbSql.append("               SELECT B.CONSUM_YN, B.ITEM_CLASS2, B.ITEM_CLASS3, B.ITEM_CLASS4 \n");
		sbSql.append("                    , A.ITEM_CODE, B.ITEM_NAME, B.ITEM_SIZE, B.PO_UOM, B.TAX_CODE \n");
		sbSql.append("                    , 0 AS SALE_PRICE, A.OP_PRICE, A.OP_RATE \n");
		sbSql.append("                    , B.OTCUSTCD, '00000000' AS CDATE \n");
		sbSql.append("                    , A.CEIL_VAL \n");
		//sbSql.append("                    , A.USE_YN \n");
		sbSql.append("                    , 'Z' AS FROM_GB \n");
		sbSql.append("                 FROM FMU_OP_RATE A, FMS_ITEM_V B \n");
		sbSql.append("                WHERE A.ITEM_CODE = B.ITEM_CODE \n");
		sbSql.append("                  AND A.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
		sbSql.append("                  AND A.SDATE = '" + nullToBlank(ds_cond.getString(0, "SDATE")) + "' \n");
		sbSql.append("                  AND A.EDATE = '" + nullToBlank(ds_cond.getString(0, "EDATE")) + "' \n");
		sbSql.append("                  AND A.USE_YN = 'Y' \n");
		sbSql.append("              ) A \n");
		String sOtcust = nullToBlank(ds_cond.getString(0, "OTCUSTCD"));
		if (! sOtcust.equals(""))
			sbSql.append("         WHERE A.OTCUSTCD = '" + nullToBlank(ds_cond.getString(0, "OTCUSTCD")) + "' \n");
		else
			sbSql.append("         WHERE EXISTS (SELECT 1 FROM FMP_OTCUST_LINK Z WHERE Z.OTCUSTCD = A.OTCUSTCD AND Z.USE_YN = 'Y' AND Z.UPJANG = '" + nullToBlank(ds_cond.getString(0, "MAIN_UPJANG")) + "') \n");
		sbSql.append("         GROUP BY A.CONSUM_YN, A.ITEM_CLASS2, A.ITEM_CLASS3, A.ITEM_CLASS4 \n");
		sbSql.append("                , A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM, A.TAX_CODE \n");
		sbSql.append("       ) A \n");
		sbSql.append(" WHERE A.UPJANG = B.UPJANG(+) \n");
		sbSql.append("   AND A.ITEM_CODE = B.ITEM_CODE(+) \n");
		sbSql.append("   AND A.UPJANG = C.UPJANG(+) \n");
		sbSql.append("   AND A.ITEM_CODE BETWEEN C.ITEM_CODE(+) AND C.ITEM_CODE(+)||'9999' \n");
		//sbSql.append("   AND DECODE(A.USE_YN,'N',0,A.SALE_PRICE) > 0 \n");
		//sbSql.append("   AND DECODE(A.FROM_GB,'Z',9999,DECODE(A.USE_YN,'N',0,A.SALE_PRICE)) > 0 \n");
		sbSql.append("   AND DECODE(A.FROM_GB,'Z',9999,A.SALE_PRICE) > 0 \n");

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

--%>
