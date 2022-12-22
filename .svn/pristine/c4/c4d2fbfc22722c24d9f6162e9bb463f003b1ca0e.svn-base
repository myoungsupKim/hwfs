<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/수불관리
■ 프로그램ID   : FMP00651P_T001.jsp
■ 프로그램명   : 거래실적집계 상세조회
■ 작성일자     : 2008-08-07
■ 작성자       : 박은규
■ 이력관리     : 1. 수정 CSR#[27433]
                  2009-05-18(월) SQL 수정 BY 노규완
                  내용 >> 기존 조회 화면에 수량 및 각각의 단가 정보 표시 추가.
               2. 수정 2009-07-22   
                  내용 : 매출 장려율(FM_SALE_RATE 테이블에 과세/면세율을 따로 관리 하게 수정 BY 노규완
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
		String sWhere       = nullToBlank(in_vl.getString("sWhere"));
		//FileLog.println("d:\\aaa.txt", ds_cond);


		//out 데이타
		DataSet ds_list;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		//
		String sUpjang = nullToBlank(ds_cond.getString(0, "UPJANG"));
		String sOtCust = nullToBlank(ds_cond.getString(0, "OTCUSTCD"));
		//내역조회
		sbSql.append("SELECT A.* FROM \n");
		sbSql.append("( \n");
		if (sOtCust.equals("0000") || sOtCust.equals(""))
		{

			sbSql.append("SELECT \n");
			if (sType.equals("001"))
				sbSql.append("       A.TRANS_DATE AS NEED_DATE_ORI, TO_CHAR(TO_DATE(A.TRANS_DATE,'YYYYMMDD'),'YYYY-MM-DD') AS NEED_DATE \n");
			else
				sbSql.append("       A.TRANS_UPJANG AS NEED_DATE_ORI, B.UPJANGNM_DISP AS NEED_DATE \n");
			sbSql.append("     , A.SUBINV_CODE, C.SUBINV_NAME_DISP \n");
			
			/*원산지 추가 -> 20150528 김진희 매니저 요청*/
			sbSql.append("     , A.ORIGIN_TYPE AS ORIGIN_TYPE \n");
			
			sbSql.append("     , A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.TRANS_UOM AS PO_UOM \n");
			//CSR#[27433]  수량
     		sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * A.TRANS_QTY) AS TRANS_QTY \n");			
			//CSR#[27433]  장려금 포함한 단가
			sbSql.append("     , DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.SALE_PRICE) AS SALE_PRICE \n");
			sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * A.SALE_AMOUNT) AS OP_AMOUNT \n");
			sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * A.SALE_AMOUNT) \n");
			sbSql.append("     + ROUND(SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.TAX_CODE,'100',A.SALE_PRICE*A.TRANS_QTY*0.1,0))) AS OP_TOT  \n");			
			//CSR#[27433]  장려금 제외한 단가			
			sbSql.append("     , DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.SALE_PRICE / (1 + DECODE(A.TAX_CODE,'100',NVL(NVL(D.FM_SALE_RATE, NVL(E.FM_SALE_RATE, F.FM_SALE_RATE)),0),NVL(NVL(D.FM_NOSALE_RATE, NVL(E.FM_NOSALE_RATE, F.FM_NOSALE_RATE)),0))/100)) AS SALE_PRICE1 \n");
			sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.TRANS_QTY * ROUND(A.SALE_PRICE / (1 + DECODE(A.TAX_CODE,'100',NVL(NVL(D.FM_SALE_RATE, NVL(E.FM_SALE_RATE, F.FM_SALE_RATE)),0),NVL(NVL(D.FM_NOSALE_RATE, NVL(E.FM_NOSALE_RATE, F.FM_NOSALE_RATE)),0))/100)))) AS OP_AMOUNT1 \n");
			sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(ROUND(A.TRANS_QTY * ROUND(A.SALE_PRICE / (1 + DECODE(A.TAX_CODE,'100',NVL(NVL(D.FM_SALE_RATE, NVL(E.FM_SALE_RATE, F.FM_SALE_RATE)),0),NVL(NVL(D.FM_NOSALE_RATE, NVL(E.FM_NOSALE_RATE, F.FM_NOSALE_RATE)),0))/100))) * DECODE(A.TAX_CODE,'100',1.1,1))) AS OP_TOT1 \n");
			//부가세는 매출장려율 적용하지 않는다. 또한 합계 후 라운드
			//Sql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.TRANS_QTY * ROUND(A.SALE_PRICE / (1 + DECODE(A.TAX_CODE,'100',NVL(NVL(D.FM_SALE_RATE, NVL(E.FM_SALE_RATE, F.FM_SALE_RATE)),0),NVL(NVL(D.FM_NOSALE_RATE, NVL(E.FM_NOSALE_RATE, F.FM_NOSALE_RATE)),0))/100)))) \n");						
			//sbSql.append("     + ROUND(SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.TAX_CODE,'100',A.SALE_PRICE*A.TRANS_QTY*0.1,0))) AS OP_TOT1 \n");
			sbSql.append("  FROM (SELECT A.* , B.ORIGIN_TYPE, B.ITEM_CLASS3, B.ITEM_CLASS4 FROM FMS_TRANSACTION_V A, FMS_ITEM_V B WHERE A.ITEM_CODE = B.ITEM_CODE) A \n");
			sbSql.append("      ,FMS_UPJANG B, FMS_SUBINVENTORY C \n");
			sbSql.append("      ,( \n");
		    sbSql.append("       SELECT UPJANG, SUBINV_CODE, ITEM_CODE, FM_SALE_RATE, FM_NOSALE_RATE, SDATE, EDATE \n");
		    sbSql.append("         FROM FMS_ITEM_SALE_RATE -- 자재별 \n");
			sbSql.append("        WHERE CASH_CODE = '003' \n");
		    sbSql.append("          AND (FM_SALE_RATE >= 0 OR FM_NOSALE_RATE >= 0) \n");
		    sbSql.append("          AND USE_YN = 'Y' \n");
		    sbSql.append("       ) D \n");
		    sbSql.append("      ,( \n");
		    sbSql.append("       SELECT UPJANG, SUBINV_CODE, ITEM_CLASS AS ITEM_CLASS4, FM_SALE_RATE, FM_NOSALE_RATE, SDATE, EDATE \n");
		    sbSql.append("         FROM FMS_SALE_RATE A -- 세분류별 \n");
			sbSql.append("        WHERE CASH_CODE = '003' \n");
		    sbSql.append("          AND (FM_SALE_RATE >= 0 OR FM_NOSALE_RATE >= 0) \n");
		    sbSql.append("          AND USE_YN = 'Y' \n");
		    sbSql.append("          AND LENGTH(ITEM_CLASS) = 7 \n");
		    sbSql.append("       ) E \n");
		    sbSql.append("      ,( \n");
		    sbSql.append("       SELECT UPJANG, SUBINV_CODE, ITEM_CLASS AS ITEM_CLASS3, FM_SALE_RATE, FM_NOSALE_RATE, SDATE, EDATE \n");
		    sbSql.append("         FROM FMS_SALE_RATE A -- 소분류별 \n");
			sbSql.append("        WHERE CASH_CODE = '003' \n");
		    sbSql.append("          AND (FM_SALE_RATE >= 0 OR FM_NOSALE_RATE >= 0) \n");
		    sbSql.append("          AND USE_YN = 'Y' \n");
		    sbSql.append("          AND LENGTH(ITEM_CLASS) = 5 \n");
		    sbSql.append("       ) F \n");
		    
			sbSql.append(" WHERE A.TRANS_UPJANG = B.UPJANG \n");
			sbSql.append("   AND A.TRANS_UPJANG = D.UPJANG(+) \n");
		    sbSql.append("   AND A.TRANS_UPJANG = E.UPJANG(+) \n");
		    sbSql.append("   AND A.TRANS_UPJANG = F.UPJANG(+) \n");
		    sbSql.append("   AND A.TRANS_DATE BETWEEN D.SDATE(+) AND D.EDATE(+) \n");
		    sbSql.append("   AND A.TRANS_DATE BETWEEN E.SDATE(+) AND E.EDATE(+) \n");
		    sbSql.append("   AND A.TRANS_DATE BETWEEN F.SDATE(+) AND F.EDATE(+) \n");
			sbSql.append("   AND A.ITEM_CODE = D.ITEM_CODE(+) \n");
		    sbSql.append("   AND A.ITEM_CLASS4 = E.ITEM_CLASS4(+) \n");
		    sbSql.append("   AND A.ITEM_CLASS3 = F.ITEM_CLASS3(+) \n");
		    sbSql.append("   AND A.SUBINV_CODE = D.SUBINV_CODE(+) \n");
		    sbSql.append("   AND A.SUBINV_CODE = E.SUBINV_CODE(+) \n");
		    sbSql.append("   AND A.SUBINV_CODE = F.SUBINV_CODE(+) \n");
			sbSql.append("   AND A.SUBINV_CODE = C.SUBINV_CODE \n");
			
			sbSql.append("   AND A.TRANS_DATE BETWEEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATET")) + "' \n");
			sbSql.append("   AND (A.TRANS_TYPE = 'I001' OR (A.TRANS_TYPE LIKE '_002' AND A.SOURCE_TYPE = 'PO')) \n");
			sbSql.append("   AND B.MAIN_UPJANG = " + nullToBlank(ds_cond.getString(0, "MAIN_UPJANG")) + " \n");
			/* if (! sUpjang.equals(""))
				sbSql.append("   AND A.TRANS_UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
			 */
			if (sType.equals("001"))
				sbSql.append("   AND A.TRANS_UPJANG = " + sWhere + " \n");
			else
				sbSql.append("   AND A.TRANS_DATE = REPLACE('" + sWhere + "','-') \n");
			
			if (sType.equals("001"))
				sbSql.append(" GROUP BY A.TRANS_DATE, A.ORIGIN_TYPE, DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.SALE_PRICE)  ,DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.SALE_PRICE / (1 + DECODE(A.TAX_CODE,'100',NVL(NVL(D.FM_SALE_RATE, NVL(E.FM_SALE_RATE, F.FM_SALE_RATE)),0),NVL(NVL(D.FM_NOSALE_RATE, NVL(E.FM_NOSALE_RATE, F.FM_NOSALE_RATE)),0))/100)) \n");				
			else
				sbSql.append(" GROUP BY A.TRANS_UPJANG, B.UPJANGNM_DISP,A.ORIGIN_TYPE \n");
			sbSql.append("     , A.SUBINV_CODE, C.SUBINV_NAME_DISP,A.ORIGIN_TYPE \n");
			sbSql.append("     , A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.TRANS_UOM, DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.SALE_PRICE)  ,DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.SALE_PRICE / (1 + DECODE(A.TAX_CODE,'100',NVL(NVL(D.FM_SALE_RATE, NVL(E.FM_SALE_RATE, F.FM_SALE_RATE)),0),NVL(NVL(D.FM_NOSALE_RATE, NVL(E.FM_NOSALE_RATE, F.FM_NOSALE_RATE)),0))/100)) \n");
		}
		if (sOtCust.equals(""))
			sbSql.append(" UNION ALL \n");
		if ((! sOtCust.equals("0000")) || sOtCust.equals(""))
		{
			if (sType.equals("001"))
				sbSql.append("SELECT A.NEED_DATE AS NEED_DATE_ORI, TO_CHAR(TO_DATE(A.NEED_DATE,'YYYYMMDD'),'YYYY-MM-DD') AS NEED_DATE \n");
			else
				sbSql.append("SELECT A.UPJANG AS NEED_DATE_ORI, B.UPJANGNM_DISP AS NEED_DATE \n");
			sbSql.append("     , A.SUBINV_CODE, C.SUBINV_NAME_DISP \n");
			
			/*원산지 추가 -> 20150528 김진희 매니저 요청*/
			sbSql.append("     , A.ORIGIN_TYPE AS ORIGIN_TYPE \n");
			
			sbSql.append("     , A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM \n");
			//CSR#[27433]  수량
			sbSql.append("     , SUM(A.PR_QTY) AS TRANS_QTY \n");
			//CSR#[27433]  장려금 포함한 단가			
			sbSql.append("     , ROUND(A.SALE_PRICE) AS SALE_PRICE \n");
			sbSql.append("     , SUM(A.SALE_AMOUNT) AS OP_AMOUNT \n");
			sbSql.append("     , SUM(A.SALE_AMOUNT) \n");
			sbSql.append("     + ROUND(SUM(DECODE(A.TAX_CODE,'100',A.SALE_AMOUNT*0.1,0))) AS OP_TOT \n");
			//CSR#[27433]  장려금 제외한 단가
			sbSql.append("     , ROUND(A.SALE_PRICE / (1 + DECODE(A.TAX_CODE,'100',NVL(NVL(D.FM_SALE_RATE, NVL(E.FM_SALE_RATE, F.FM_SALE_RATE)),0),NVL(NVL(D.FM_NOSALE_RATE, NVL(E.FM_NOSALE_RATE, F.FM_NOSALE_RATE)),0))/100)) AS SALE_PRICE1 \n");
			sbSql.append("     , SUM(ROUND(A.PR_QTY * ROUND(A.SALE_PRICE / (1 + DECODE(A.TAX_CODE,'100',NVL(NVL(D.FM_SALE_RATE, NVL(E.FM_SALE_RATE, F.FM_SALE_RATE)),0),NVL(NVL(D.FM_NOSALE_RATE, NVL(E.FM_NOSALE_RATE, F.FM_NOSALE_RATE)),0))/100)))) AS OP_AMOUNT1 \n");
			sbSql.append("     , SUM(ROUND(A.PR_QTY * ROUND(A.SALE_PRICE / (1 + DECODE(A.TAX_CODE,'100',NVL(NVL(D.FM_SALE_RATE, NVL(E.FM_SALE_RATE, F.FM_SALE_RATE)),0),NVL(NVL(D.FM_NOSALE_RATE, NVL(E.FM_NOSALE_RATE, F.FM_NOSALE_RATE)),0))/100)))) \n");						
			sbSql.append("     + ROUND(SUM(DECODE(A.TAX_CODE,'100',A.SALE_AMOUNT*0.1,0))) AS OP_TOT1 \n"); //부가세는 장려율 적용하지 않는다.
			sbSql.append("  FROM (SELECT A.*, B.ORIGIN_TYPE, B.ITEM_CLASS3, B.ITEM_CLASS4  FROM FMP_OTCUST_PR A, FMP_OTCUST_ITEM B WHERE A.ITEM_CODE = B.ITEM_CODE) A \n");			
			sbSql.append("      , FMS_UPJANG B, FMS_SUBINVENTORY C \n");
			sbSql.append("      ,( \n");
		    sbSql.append("       SELECT UPJANG, SUBINV_CODE, ITEM_CODE, FM_SALE_RATE, FM_NOSALE_RATE, SDATE, EDATE \n");
		    sbSql.append("         FROM FMS_ITEM_SALE_RATE -- 자재별 \n");
			sbSql.append("        WHERE CASH_CODE = '003' \n");
		    sbSql.append("          AND (FM_SALE_RATE >= 0 OR FM_NOSALE_RATE >= 0) \n");
		    sbSql.append("          AND USE_YN = 'Y' \n");
		    sbSql.append("       ) D \n");
		    sbSql.append("      ,( \n");
		    sbSql.append("       SELECT UPJANG, SUBINV_CODE, ITEM_CLASS AS ITEM_CLASS4, FM_SALE_RATE, FM_NOSALE_RATE, SDATE, EDATE \n");
		    sbSql.append("         FROM FMS_SALE_RATE A -- 세분류별 \n");
			sbSql.append("        WHERE CASH_CODE = '003' \n");
		    sbSql.append("          AND (FM_SALE_RATE >= 0 OR FM_NOSALE_RATE >= 0) \n");
		    sbSql.append("          AND USE_YN = 'Y' \n");
		    sbSql.append("          AND LENGTH(ITEM_CLASS) = 7 \n");
		    sbSql.append("       ) E \n");
		    sbSql.append("      ,( \n");
		    sbSql.append("       SELECT UPJANG, SUBINV_CODE, ITEM_CLASS AS ITEM_CLASS3, FM_SALE_RATE, FM_NOSALE_RATE, SDATE, EDATE \n");
		    sbSql.append("         FROM FMS_SALE_RATE A -- 소분류별 \n");
			sbSql.append("        WHERE CASH_CODE = '003' \n");
		    sbSql.append("          AND (FM_SALE_RATE >= 0 OR FM_NOSALE_RATE >= 0) \n");
		    sbSql.append("          AND USE_YN = 'Y' \n");
		    sbSql.append("          AND LENGTH(ITEM_CLASS) = 5 \n");
		    sbSql.append("       ) F \n");
		    
			sbSql.append(" WHERE A.UPJANG = B.UPJANG \n");
			sbSql.append("   AND A.UPJANG = D.UPJANG(+) \n");
		    sbSql.append("   AND A.UPJANG = E.UPJANG(+) \n");
		    sbSql.append("   AND A.UPJANG = F.UPJANG(+) \n");
		    sbSql.append("   AND A.NEED_DATE BETWEEN D.SDATE(+) AND D.EDATE(+) \n");
		    sbSql.append("   AND A.NEED_DATE BETWEEN E.SDATE(+) AND E.EDATE(+) \n");
		    sbSql.append("   AND A.NEED_DATE BETWEEN F.SDATE(+) AND F.EDATE(+) \n");
			sbSql.append("   AND A.ITEM_CODE = D.ITEM_CODE(+) \n");
		    sbSql.append("   AND A.ITEM_CLASS4 = E.ITEM_CLASS4(+) \n");
		    sbSql.append("   AND A.ITEM_CLASS3 = F.ITEM_CLASS3(+) \n");
		    sbSql.append("   AND A.SUBINV_CODE = D.SUBINV_CODE(+) \n");
		    sbSql.append("   AND A.SUBINV_CODE = E.SUBINV_CODE(+) \n");
		    sbSql.append("   AND A.SUBINV_CODE = F.SUBINV_CODE(+) \n");
			sbSql.append("   AND A.SUBINV_CODE = C.SUBINV_CODE \n");
			
			sbSql.append("   AND A.NEED_DATE BETWEEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATET")) + "' \n");
			sbSql.append("   AND B.MAIN_UPJANG = " + nullToBlank(ds_cond.getString(0, "MAIN_UPJANG")) + " \n");
			/* if (! sUpjang.equals(""))
				sbSql.append("   AND A.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n"); */
			if (sType.equals("001"))
				sbSql.append("   AND A.UPJANG = " + sWhere + " \n");
			else
				sbSql.append("   AND A.NEED_DATE = REPLACE('" + sWhere + "','-') \n");
			if (! sOtCust.equals(""))
				sbSql.append("   AND A.OTCUSTCD = '" + nullToBlank(ds_cond.getString(0, "OTCUSTCD")) + "' \n");
			sbSql.append("   AND A.LINE_STATUS <> '003' \n");
			if (sType.equals("001"))		
			    sbSql.append(" GROUP BY A.NEED_DATE, A.ORIGIN_TYPE,ROUND(A.SALE_PRICE), ROUND(A.SALE_PRICE / (1 + DECODE(A.TAX_CODE,'100',NVL(NVL(D.FM_SALE_RATE, NVL(E.FM_SALE_RATE, F.FM_SALE_RATE)),0),NVL(NVL(D.FM_NOSALE_RATE, NVL(E.FM_NOSALE_RATE, F.FM_NOSALE_RATE)),0))/100)) \n");			    
			else
				sbSql.append(" GROUP BY A.UPJANG, B.UPJANGNM_DISP, A.ORIGIN_TYPE \n");
			sbSql.append("     , A.SUBINV_CODE, C.SUBINV_NAME_DISP \n");
			sbSql.append("     , A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM, ROUND(A.SALE_PRICE), ROUND(A.SALE_PRICE / (1 + DECODE(A.TAX_CODE,'100',NVL(NVL(D.FM_SALE_RATE, NVL(E.FM_SALE_RATE, F.FM_SALE_RATE)),0),NVL(NVL(D.FM_NOSALE_RATE, NVL(E.FM_NOSALE_RATE, F.FM_NOSALE_RATE)),0))/100)) \n");			
		}
		sbSql.append(") A \n");
		sbSql.append(" ORDER BY A.NEED_DATE_ORI, A.SUBINV_CODE, A.ITEM_CODE, A.ORIGIN_TYPE \n");

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
		String sType        = nullToBlank(in_vl.getString("sType"));
		String sWhere       = nullToBlank(in_vl.getString("sWhere"));
		//FileLog.println("d:\\aaa.txt", ds_cond);


		//out 데이타
		DataSet ds_list;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		//
		String sUpjang = nullToBlank(ds_cond.getString(0, "UPJANG"));
		String sOtCust = nullToBlank(ds_cond.getString(0, "OTCUSTCD"));
		//내역조회
		sbSql.append("SELECT A.* FROM \n");
		sbSql.append("( \n");
		if (sOtCust.equals("0000") || sOtCust.equals(""))
		{

			sbSql.append("SELECT \n");
			if (sType.equals("001"))
				sbSql.append("       A.TRANS_DATE AS NEED_DATE_ORI, TO_CHAR(TO_DATE(A.TRANS_DATE,'YYYYMMDD'),'YYYY-MM-DD') AS NEED_DATE \n");
			else
				sbSql.append("       A.TRANS_UPJANG AS NEED_DATE_ORI, B.UPJANGNM_DISP AS NEED_DATE \n");
			sbSql.append("     , A.SUBINV_CODE, C.SUBINV_NAME_DISP \n");
			sbSql.append("     , A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.TRANS_UOM AS PO_UOM \n");
			//CSR#[27433]  수량
     		sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * A.TRANS_QTY) AS TRANS_QTY \n");			
			//CSR#[27433]  장려금 포함한 단가
			sbSql.append("     , DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.SALE_PRICE) AS SALE_PRICE \n");
			sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * A.SALE_AMOUNT) AS OP_AMOUNT \n");
			sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * A.SALE_AMOUNT) \n");
			sbSql.append("     + ROUND(SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.TAX_CODE,'100',A.SALE_AMOUNT*0.1 + A.TRANS_QTY*A.SALE_VAT,0))) AS OP_TOT \n");			
			//CSR#[27433]  장려금 제외한 단가
//**************  FM_NOSALE_RATE 추가에 따른 변경  2009/07/22 백업 및 수정  *******************
//			sbSql.append("     , DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.SALE_PRICE / (1 + (NVL(NVL(D.FM_SALE_RATE, NVL(E.FM_SALE_RATE, F.FM_SALE_RATE)),0)/100))) AS SALE_PRICE1 \n");
//			sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.TRANS_QTY * ROUND(A.SALE_PRICE / (1 + (NVL(NVL(D.FM_SALE_RATE, NVL(E.FM_SALE_RATE, F.FM_SALE_RATE)),0)/100))))) AS OP_AMOUNT1 \n");			
//			sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.TRANS_QTY * ROUND(A.SALE_PRICE / (1 + (NVL(NVL(D.FM_SALE_RATE, NVL(E.FM_SALE_RATE, F.FM_SALE_RATE)),0)/100))))) \n");			
			sbSql.append("     , DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.SALE_PRICE / (1 + DECODE(A.TAX_CODE,'100',NVL(NVL(D.FM_SALE_RATE, NVL(E.FM_SALE_RATE, F.FM_SALE_RATE)),0),NVL(NVL(D.FM_NOSALE_RATE, NVL(E.FM_NOSALE_RATE, F.FM_NOSALE_RATE)),0))/100)) AS SALE_PRICE1 \n");
			sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.TRANS_QTY * ROUND(A.SALE_PRICE / (1 + DECODE(A.TAX_CODE,'100',NVL(NVL(D.FM_SALE_RATE, NVL(E.FM_SALE_RATE, F.FM_SALE_RATE)),0),NVL(NVL(D.FM_NOSALE_RATE, NVL(E.FM_NOSALE_RATE, F.FM_NOSALE_RATE)),0))/100)))) AS OP_AMOUNT1 \n");
			//부가세는 매출장려율 적용하지 않는다. 또한 합계 후 라운드
			sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.TRANS_QTY * ROUND(A.SALE_PRICE / (1 + DECODE(A.TAX_CODE,'100',NVL(NVL(D.FM_SALE_RATE, NVL(E.FM_SALE_RATE, F.FM_SALE_RATE)),0),NVL(NVL(D.FM_NOSALE_RATE, NVL(E.FM_NOSALE_RATE, F.FM_NOSALE_RATE)),0))/100)))) \n");			
//**************  FM_NOSALE_RATE 추가에 따른 변경  2009/07/22 백업 및 수정  *******************			
			sbSql.append("     + ROUND(SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.TAX_CODE,'100',A.SALE_AMOUNT*0.1 + A.TRANS_QTY*A.SALE_VAT,0))) AS OP_TOT1 \n");
			sbSql.append("  FROM HLDC_PO_TRANSACTION A, FMS_UPJANG B, HLDC_FM_SALE_RATE K, FMS_SUBINVENTORY D \n");
			sbSql.append(" WHERE A.TRANS_UPJANG = B.UPJANG \n");
			sbSql.append("   AND A.SUBINV_CODE = K.SUBINV_CODE(+) \n");
			sbSql.append("   AND A.TRANS_DATE BETWEEN K.SDATE(+) AND K.EDATE(+) \n");
			sbSql.append("   AND SUBSTR(A.ITEM_CODE,1,8) = K.ITEM_CLASS(+) \n");			
			sbSql.append("   AND K.USE_YN(+) = 'Y' \n");
			sbSql.append("   AND A.SUBINV_CODE = D.SUBINV_CODE \n");
			sbSql.append("   AND A.TRANS_DATE BETWEEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATET")) + "' \n");
			sbSql.append("   AND (A.TRANS_TYPE = 'I001' OR (A.TRANS_TYPE LIKE '_002' AND A.SOURCE_TYPE = 'PO')) \n");
			sbSql.append("   AND B.MAIN_UPJANG = " + nullToBlank(ds_cond.getString(0, "MAIN_UPJANG")) + " \n");
			if (! sUpjang.equals(""))
				sbSql.append("   AND A.TRANS_UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
			if (sType.equals("001"))
				sbSql.append("   AND A.TRANS_UPJANG = " + sWhere + " \n");
			else
				sbSql.append("   AND A.TRANS_DATE = REPLACE('" + sWhere + "','-') \n");
			if (sType.equals("001"))
//**************  FM_NOSALE_RATE 추가에 따른 변경  2009/07/22 백업 및 수정  *******************				
//				sbSql.append(" GROUP BY A.TRANS_DATE, DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.SALE_PRICE)  ,DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.SALE_PRICE / (1 + (NVL(NVL(D.FM_SALE_RATE, NVL(E.FM_SALE_RATE, F.FM_SALE_RATE)),0)/100))) \n");
				sbSql.append(" GROUP BY A.TRANS_DATE, DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.SALE_PRICE)  ,DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.SALE_PRICE / (1 + DECODE(A.TAX_CODE,'100',NVL(NVL(D.FM_SALE_RATE, NVL(E.FM_SALE_RATE, F.FM_SALE_RATE)),0),NVL(NVL(D.FM_NOSALE_RATE, NVL(E.FM_NOSALE_RATE, F.FM_NOSALE_RATE)),0))/100)) \n");
//**************  FM_NOSALE_RATE 추가에 따른 변경  2009/07/22 백업 및 수정  *******************				
			else
				sbSql.append(" GROUP BY A.TRANS_UPJANG, B.UPJANGNM_DISP \n");
			sbSql.append("     , A.SUBINV_CODE, C.SUBINV_NAME_DISP \n");
//**************  FM_NOSALE_RATE 추가에 따른 변경  2009/07/22 백업 및 수정  *******************			
//			sbSql.append("     , A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.TRANS_UOM, DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.SALE_PRICE)  ,DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.SALE_PRICE / (1 + (NVL(NVL(D.FM_SALE_RATE, NVL(E.FM_SALE_RATE, F.FM_SALE_RATE)),0)/100))) \n");
			sbSql.append("     , A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.TRANS_UOM, DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.SALE_PRICE)  ,DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.SALE_PRICE / (1 + DECODE(A.TAX_CODE,'100',NVL(NVL(D.FM_SALE_RATE, NVL(E.FM_SALE_RATE, F.FM_SALE_RATE)),0),NVL(NVL(D.FM_NOSALE_RATE, NVL(E.FM_NOSALE_RATE, F.FM_NOSALE_RATE)),0))/100)) \n");
//**************  FM_NOSALE_RATE 추가에 따른 변경  2009/07/22 백업 및 수정  *******************
		}
		if (sOtCust.equals(""))
			sbSql.append(" UNION ALL \n");
		if ((! sOtCust.equals("0000")) || sOtCust.equals(""))
		{
			if (sType.equals("001"))
				sbSql.append("SELECT A.NEED_DATE AS NEED_DATE_ORI, TO_CHAR(TO_DATE(A.NEED_DATE,'YYYYMMDD'),'YYYY-MM-DD') AS NEED_DATE \n");
			else
				sbSql.append("SELECT A.UPJANG AS NEED_DATE_ORI, B.UPJANGNM_DISP AS NEED_DATE \n");
			sbSql.append("     , A.SUBINV_CODE, C.SUBINV_NAME_DISP \n");
			sbSql.append("     , A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM \n");
			//CSR#[27433]  수량
			sbSql.append("     , SUM(A.PR_QTY) AS TRANS_QTY \n");
			//CSR#[27433]  장려금 포함한 단가			
			sbSql.append("     , ROUND(A.SALE_PRICE) AS SALE_PRICE \n");
			sbSql.append("     , SUM(A.SALE_AMOUNT) AS OP_AMOUNT \n");
			sbSql.append("     , SUM(A.SALE_AMOUNT) \n");
			sbSql.append("     + ROUND(SUM(DECODE(A.TAX_CODE,'100',A.SALE_AMOUNT*0.1,0))) AS OP_TOT \n");
			//CSR#[27433]  장려금 제외한 단가
//**************  FM_NOSALE_RATE 추가에 따른 변경  2009/07/22 백업 및 수정  *******************			
//			sbSql.append("     , ROUND(A.SALE_PRICE / (1 + (NVL(NVL(D.FM_SALE_RATE, NVL(E.FM_SALE_RATE, F.FM_SALE_RATE)),0)/100))) AS SALE_PRICE1 \n");
//			sbSql.append("     , SUM(ROUND(A.PR_QTY * ROUND(A.SALE_PRICE / (1 + (NVL(NVL(D.FM_SALE_RATE, NVL(E.FM_SALE_RATE, F.FM_SALE_RATE)),0)/100))))) AS OP_AMOUNT1 \n");
//			sbSql.append("     , SUM(ROUND(A.PR_QTY * ROUND(A.SALE_PRICE / (1 + (NVL(NVL(D.FM_SALE_RATE, NVL(E.FM_SALE_RATE, F.FM_SALE_RATE)),0)/100))))) \n");
			sbSql.append("     , ROUND(A.SALE_PRICE / (1 + DECODE(A.TAX_CODE,'100',NVL(NVL(D.FM_SALE_RATE, NVL(E.FM_SALE_RATE, F.FM_SALE_RATE)),0),NVL(NVL(D.FM_NOSALE_RATE, NVL(E.FM_NOSALE_RATE, F.FM_NOSALE_RATE)),0))/100)) AS SALE_PRICE1 \n");
			sbSql.append("     , SUM(ROUND(A.PR_QTY * ROUND(A.SALE_PRICE / (1 + DECODE(A.TAX_CODE,'100',NVL(NVL(D.FM_SALE_RATE, NVL(E.FM_SALE_RATE, F.FM_SALE_RATE)),0),NVL(NVL(D.FM_NOSALE_RATE, NVL(E.FM_NOSALE_RATE, F.FM_NOSALE_RATE)),0))/100)))) AS OP_AMOUNT1 \n");
			sbSql.append("     , SUM(ROUND(A.PR_QTY * ROUND(A.SALE_PRICE / (1 + DECODE(A.TAX_CODE,'100',NVL(NVL(D.FM_SALE_RATE, NVL(E.FM_SALE_RATE, F.FM_SALE_RATE)),0),NVL(NVL(D.FM_NOSALE_RATE, NVL(E.FM_NOSALE_RATE, F.FM_NOSALE_RATE)),0))/100)))) \n");			
//**************  FM_NOSALE_RATE 추가에 따른 변경  2009/07/22 백업 및 수정  *******************			
			sbSql.append("     + ROUND(SUM(DECODE(A.TAX_CODE,'100',A.SALE_AMOUNT*0.1,0))) AS OP_TOT1 \n"); //부가세는 장려율 적용하지 않는다.
			sbSql.append("  FROM (SELECT B.ITEM_CLASS3, A.* FROM FMP_OTCUST_PR A, FMP_OTCUST_ITEM B WHERE A.ITEM_CODE = B.ITEM_CODE) A \n");			
			sbSql.append("      , FMS_UPJANG B, HLDC_FM_SALE_RATE K, FMS_SUBINVENTORY D \n");
			sbSql.append(" WHERE A.UPJANG = B.UPJANG \n");
			sbSql.append("   AND A.SUBINV_CODE = K.SUBINV_CODE(+) \n");
			sbSql.append("   AND A.ITEM_CLASS3 = K.ITEM_CLASS(+) \n");			
			sbSql.append("   AND A.NEED_DATE BETWEEN K.SDATE(+) AND K.EDATE(+) \n");
			sbSql.append("   AND K.USE_YN(+) = 'Y' \n");
			sbSql.append("   AND A.SUBINV_CODE = D.SUBINV_CODE \n");
			sbSql.append("   AND A.NEED_DATE BETWEEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATET")) + "' \n");
			sbSql.append("   AND B.MAIN_UPJANG = " + nullToBlank(ds_cond.getString(0, "MAIN_UPJANG")) + " \n");
			if (! sUpjang.equals(""))
				sbSql.append("   AND A.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
			if (sType.equals("001"))
				sbSql.append("   AND A.UPJANG = " + sWhere + " \n");
			else
				sbSql.append("   AND A.NEED_DATE = REPLACE('" + sWhere + "','-') \n");
			if (! sOtCust.equals(""))
				sbSql.append("   AND A.OTCUSTCD = '" + nullToBlank(ds_cond.getString(0, "OTCUSTCD")) + "' \n");
			sbSql.append("   AND A.LINE_STATUS <> '003' \n");
			if (sType.equals("001"))
//**************  FM_NOSALE_RATE 추가에 따른 변경  2009/07/22 백업 및 수정  *******************				
//				sbSql.append(" GROUP BY A.NEED_DATE, ROUND(A.SALE_PRICE), ROUND(A.SALE_PRICE / (1 + (NVL(NVL(D.FM_SALE_RATE, NVL(E.FM_SALE_RATE, F.FM_SALE_RATE)),0)/100))) \n");		
			    sbSql.append(" GROUP BY A.NEED_DATE, ROUND(A.SALE_PRICE), ROUND(A.SALE_PRICE / (1 + DECODE(A.TAX_CODE,'100',NVL(NVL(D.FM_SALE_RATE, NVL(E.FM_SALE_RATE, F.FM_SALE_RATE)),0),NVL(NVL(D.FM_NOSALE_RATE, NVL(E.FM_NOSALE_RATE, F.FM_NOSALE_RATE)),0))/100)) \n");
//**************  FM_NOSALE_RATE 추가에 따른 변경  2009/07/22 백업 및 수정  *******************			    
			else
				sbSql.append(" GROUP BY A.UPJANG, B.UPJANGNM_DISP \n");
			sbSql.append("     , A.SUBINV_CODE, C.SUBINV_NAME_DISP \n");
//**************  FM_NOSALE_RATE 추가에 따른 변경  2009/07/22 백업 및 수정  *******************			
//			sbSql.append("     , A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM, ROUND(A.SALE_PRICE), ROUND(A.SALE_PRICE / (1 + (NVL(NVL(D.FM_SALE_RATE, NVL(E.FM_SALE_RATE, F.FM_SALE_RATE)),0)/100))) \n");
			sbSql.append("     , A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM, ROUND(A.SALE_PRICE), ROUND(A.SALE_PRICE / (1 + DECODE(A.TAX_CODE,'100',NVL(NVL(D.FM_SALE_RATE, NVL(E.FM_SALE_RATE, F.FM_SALE_RATE)),0),NVL(NVL(D.FM_NOSALE_RATE, NVL(E.FM_NOSALE_RATE, F.FM_NOSALE_RATE)),0))/100)) \n");
//**************  FM_NOSALE_RATE 추가에 따른 변경  2009/07/22 백업 및 수정  *******************			
		}
		sbSql.append(") A \n");
		sbSql.append(" ORDER BY A.NEED_DATE_ORI, A.SUBINV_CODE, A.ITEM_CODE \n");

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