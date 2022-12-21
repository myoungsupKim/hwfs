<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 타사매입처 입출고 확정 및 처리(타사매입)
■ 프로그램ID   : FMW00220E_T001.jsp
■ 프로그램명   : 타사매입처 입출고 확정 및 처리(타사매입)
■ 작성일자     : 2011.01.06
■ 작성자      : 문형광
■ 이력관리     : 2011.01.06
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
		String sType        = nullToBlank(in_vl.getString("sType"));
		//FileLog.println("d:\\aaa.txt", ds_Cond);
		//out 데이타
		DataSet ds_List;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		sbSql.delete(0, sbSql.length());
		//1)주문내역조회
		if (sType.equals("QryLst"))
		{
	        sbSql.append("SELECT A.TRANS_ID                                                                                \n");
	        sbSql.append("     , A.ITEM_CODE                                                                               \n");
	        sbSql.append("     , B.ITEM_NAME                                                                               \n");
	        sbSql.append("     , A.TRANS_TYPE                     \n");
	        //sbSql.append("     , ABS(SUBSTR(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,0,A.TRANS_QTY), 1, INSTR(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,0,A.TRANS_QTY), ',') - 1)) AS BOX_QTY  --박스수량                                                                                                     \n");
	        //sbSql.append("     , ABS(SUBSTR(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,0,A.TRANS_QTY), INSTR(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,0,A.TRANS_QTY), ',') +1, LENGTH(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,0,A.TRANS_QTY)))) AS BONG_QTY  --봉수량                                              \n");
	        //sbSql.append("     , ABS((A.TRANS_AMOUNT - TO_NUMBER(SUBSTR(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,0,A.TRANS_QTY), INSTR(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,0,A.TRANS_QTY), ',') +1, LENGTH(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,0,A.TRANS_QTY))) * A.TRANS_PRICE))) AS BOX_PRICE --박스금액 \n");
	        //sbSql.append("     , ABS(TO_NUMBER(SUBSTR(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,0,A.TRANS_QTY), INSTR(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,0,A.TRANS_QTY), ',') +1, LENGTH(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,0,A.TRANS_QTY))) * A.TRANS_PRICE)) AS BONG_PRICE  --봉금액                 \n");
	        //sbSql.append("     , ABS(ROUND(A.TRANS_PRICE * A.TRANS_QTY)) AS TRANS_AMOUNT                                            \n");     
	        sbSql.append("     , SUBSTR(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,0,A.TRANS_QTY), 1, INSTR(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,0,A.TRANS_QTY), ',') - 1) AS BOX_QTY  --박스수량                                                                                                     \n");
	        sbSql.append("     , SUBSTR(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,0,A.TRANS_QTY), INSTR(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,0,A.TRANS_QTY), ',') +1, LENGTH(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,0,A.TRANS_QTY))) AS BONG_QTY  --봉수량                                              \n");
	        sbSql.append("     , (A.TRANS_AMOUNT - TO_NUMBER(SUBSTR(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,0,A.TRANS_QTY), INSTR(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,0,A.TRANS_QTY), ',') +1, LENGTH(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,0,A.TRANS_QTY))) * A.TRANS_PRICE)) AS BOX_PRICE --박스금액 \n");
	        sbSql.append("     , TO_NUMBER(SUBSTR(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,0,A.TRANS_QTY), INSTR(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,0,A.TRANS_QTY), ',') +1, LENGTH(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,0,A.TRANS_QTY))) * A.TRANS_PRICE) AS BONG_PRICE  --봉금액                 \n");
	        sbSql.append("     , ROUND(A.TRANS_PRICE * A.TRANS_QTY) AS TRANS_AMOUNT                                            \n");
	        sbSql.append("     , A.TRANS_DATE, B.OTCUSTCD, C.OTCUSTNM, A.TRANS_PRICE                                                      \n");
	        sbSql.append("     , A.REMARK                                                                                  \n");
	        sbSql.append("     , (SELECT Z.SABUN||' '||Z.NM_KOR FROM SCC_USERINFO Z WHERE Z.SABUN = A.UUSER) AS CREATE_NM \n");
	        sbSql.append("  FROM FMW_PO_TRANSACTION A, FMW_OTCUST_ITEM B, FMW_OTCUST C, FMS_SUBINVENTORY D                       \n");
	        sbSql.append(" WHERE A.ITEM_CODE = B.ITEM_CODE                                                                 \n");
	        sbSql.append("   AND B.OTCUSTCD = C.OTCUSTCD                                                                   \n");
	        sbSql.append("   AND A.SUBINV_CODE = D.SUBINV_CODE                                                             \n");
	        sbSql.append("   AND A.SUBINV_CODE = '" + nullToBlank(ds_Cond.getString(0, "SUBINV_CODE")) + "'         \n");
	        sbSql.append("   AND A.TRANS_DATE = '" + nullToBlank(ds_Cond.getString(0, "TRANS_DATE")) + "'                \n");
	        sbSql.append("   AND A.TRANS_TYPE BETWEEN 'I002' AND 'IOO3'                                                 \n");	        
	        sbSql.append("   AND B.UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "                  \n");
	        sbSql.append(" ORDER BY A.TRANS_ID                                                                             \n");
		}
		//2)상품검색
		else if (sType.equals("QryItm"))
		{
	        sbSql.append("SELECT A.ITEM_CODE                                                              	                           \n");
	        sbSql.append("     , A.ITEM_NAME                                                                                           \n");
	        sbSql.append("     , DECODE(A.TAX_CODE,'100','과세','210','면세','영세') AS TAX_CODE                                         \n");
	        sbSql.append("     , A.ITEM_SIZE_BONG                                                                                      \n");
	        sbSql.append("     , NVL(A.UNIT_PRICE_BONG, 0) AS BONG_PRICE_M                                                             \n");
	        sbSql.append("     , ROUND(A.ITEM_SIZE_BOX * A.ITEM_SIZE_BONG * NVL(A.UNIT_PRICE_BONG, 0)) AS BOX_PRICE_M                  \n");
	        sbSql.append("     , NVL(A.SALE_PRICE_BONG, 0) AS UNIT_PRICE                                                               \n");
	        sbSql.append("     , A.OTCUSTCD                                                                                            \n");
	        sbSql.append("     , B.OTCUSTNM                                                                                            \n");
	        sbSql.append("     , (SELECT Z.SABUN||' '||Z.NM_KOR FROM HLDC_HR_PERSONAL Z WHERE Z.SABUN = '" +g_EmpNo+ "') AS CREATE_NM  \n");
	        sbSql.append("  FROM FMW_OTCUST_ITEM A, FMW_OTCUST B                                                               		   \n");
	        sbSql.append(" WHERE A.OTCUSTCD = B.OTCUSTCD                                                                               \n");
	        sbSql.append("   AND (A.ITEM_CODE LIKE '%" + nullToBlank(ds_Cond.getString(0, "ITEM_NAME")) + "%'               \n");
	        sbSql.append("     OR A.ITEM_NAME LIKE '%" + nullToBlank(ds_Cond.getString(0, "ITEM_NAME")) + "%')              \n");
	        sbSql.append("   AND A.UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "                                \n");
	        sbSql.append("   AND A.USE_YN = 'Y'                                                                                        \n");
	        sbSql.append(" ORDER BY A.ITEM_CODE                                                                                		   \n");
		}
out_vl.add("fa_Sql", sbSql.toString());
//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_List = this.makeDataSet(rs, "ds_List");
		pstmt.close();
		rs.close();

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