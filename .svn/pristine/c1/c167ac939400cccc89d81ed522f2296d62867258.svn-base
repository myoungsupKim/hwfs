<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/수불관리
■ 프로그램ID   : FMP00642V_T001.jsp
■ 프로그램명   : 사업장별 거래실적집계(월 마감용)
■ 작성일자     : 2011-11-15
■ 작성자       : 노규완
■ 이력관리     : 2011-11-15
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
		//DataSet ds_cond     = in_dl.get("ds_Cond");
		//입력 파라메터
		String strUpjang      = nullToBlank(in_vl.getString("strUpjang"));		
		String strNeedDate    = nullToBlank(in_vl.getString("strNeedDate"));		
		//FileLog.println("d:\\aaa.txt", ds_cond);

		//out 데이타
		DataSet ds_List;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		//내역조회
        sbSql.append("SELECT A.TRANS_UPJANG AS NEED_DATE_ORI \n");
        sbSql.append("     , (SELECT Z.SUBINV_NAME_DISP FROM FMS_SUBINVENTORY@FCUS_TO_FSUS Z WHERE Z.SUBINV_CODE = A.SUBINV_CODE) AS NEED_DATE  \n");
        sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.TRANS_QTY * DECODE(NVL(B.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(B.OP_RATE,0) / 100),B.CEIL_VAL),B.OP_PRICE))) AS OP_AMOUNT \n");
        sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',0,A.TRANS_QTY) * DECODE(NVL(B.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(B.OP_RATE,0) / 100),B.CEIL_VAL),B.OP_PRICE))) AS OP_NOTAX \n");
        sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',A.TRANS_QTY,0) * DECODE(NVL(B.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(B.OP_RATE,0) / 100),B.CEIL_VAL),B.OP_PRICE))) AS OP_TAX \n");
        sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * ROUND(A.TRANS_QTY * DECODE(NVL(B.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(B.OP_RATE,0) / 100),B.CEIL_VAL),B.OP_PRICE)))) AS OP_VAT \n");
        sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.TRANS_QTY * DECODE(NVL(B.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(B.OP_RATE,0) / 100),B.CEIL_VAL),B.OP_PRICE)))) AS OP_TOT \n");
        sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * A.SALE_AMOUNT) AS OP_AMOUNT1 \n");
        sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.TAX_CODE,'100',0,A.SALE_AMOUNT)) AS OP_NOTAX1 \n");
        sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.TAX_CODE,'100',A.SALE_AMOUNT,0)) AS OP_TAX1 \n");
        sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * A.SALE_AMOUNT)) AS OP_VAT1 \n");
        sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * A.SALE_AMOUNT)) AS OP_TOT1 \n");
        sbSql.append(" FROM PO_TRANSACTION_FM@FCUS_TO_HLDC A \n");
        sbSql.append("    , (SELECT * FROM FMU_OP_RATE@FCUS_TO_FSUS WHERE UPJANG = " + strUpjang + ") B \n");
        sbSql.append("WHERE A.TRANS_UPJANG = B.UPJANG(+) \n");
        sbSql.append("  AND A.TRANS_DATE BETWEEN B.SDATE(+) AND B.EDATE(+) \n");
        sbSql.append("  AND A.ITEM_CODE BETWEEN B.ITEM_CODE(+) AND B.ITEM_CODE(+)||'9999' \n");
        sbSql.append("  AND B.USE_YN(+) = 'Y' \n");
        sbSql.append("  AND A.TRANS_UPJANG = " + strUpjang + " \n");
        sbSql.append("  AND A.TRANS_DATE  BETWEEN  '" + strNeedDate + "'||'01' AND '" + strNeedDate + "' ||'31'    \n");
//        sbSql.append("  AND A.SUBINV_CODE BETWEEN 'S1000000' AND 'S1099999' \n");
//        sbSql.append("  AND ((A.TRANS_TYPE = 'I001') OR (A.TRANS_TYPE LIKE '_002' AND A.SOURCE_TYPE = 'PO'))                                             \n");
        sbSql.append("GROUP BY A.TRANS_UPJANG, A.SUBINV_CODE \n");

out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql1.toString());
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		ds_List = this.makeDataSet(rs, "ds_List");
		//FileLog.println("d:\\aaa.txt", ds_List);

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