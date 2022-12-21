<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 타사매입처 입출고 조회
■ 프로그램ID   : FMW00420V_T001.jsp
■ 프로그램명   : 타사매입처 입출고 조회
■ 작성일자     : 2011.01.06
■ 작성자      : 노규완
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
        sbSql.append("SELECT K.TRANS_ID,K.ITEM_CODE,K.ITEM_NAME                                                                                                                                                                                                            \n");
        sbSql.append("       , DECODE(K.TRANS_TYPE,'I002','매입','I003','반품', DECODE(SIGN(K.TRANS_QTY), -1, '반품','매입')) AS TRANS_TYPE                                                                                                                                \n");
        sbSql.append("      ,K.BOX_QTY, K.BONG_QTY, K.BOX_PRICE, K.BONG_PRICE, K.TRANS_AMOUNT, K.TRANS_DATE, K.OTCUSTCD, K.OTCUSTNM, K.TRANS_PRICE, K.REMARK, K.CREATE_NM                                                                                                  \n");
        sbSql.append("FROM                                                                                                                                                                                                                                                 \n");
        sbSql.append("(SELECT A.TRANS_ID                                                                                                                                                                                                                                   \n");
        sbSql.append("     , A.ITEM_CODE                                                                                                                                                                                                                                   \n");
        sbSql.append("     , B.ITEM_NAME                                                                                                                                                                                                                                   \n");
        sbSql.append("     , A.TRANS_TYPE                                                                                                                                                                                                                                  \n");
        sbSql.append("     , A.TRANS_QTY                                                                                                                                                                                                                                   \n");
        sbSql.append("     , SUBSTR(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,0,A.TRANS_QTY), 1, INSTR(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,0,A.TRANS_QTY), ',') - 1) AS BOX_QTY  --박스수량                                                                                                												   \n");
        sbSql.append("     , SUBSTR(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,0,A.TRANS_QTY), INSTR(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,0,A.TRANS_QTY), ',') +1, LENGTH(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,0,A.TRANS_QTY))) AS BONG_QTY  --봉수량                                              						   \n");
//        sbSql.append("     , (A.TRANS_AMOUNT - TO_NUMBER(SUBSTR(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,0,A.TRANS_QTY), INSTR(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,0,A.TRANS_QTY), ',') +1, LENGTH(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,0,A.TRANS_QTY))) * A.TRANS_PRICE)) AS BOX_PRICE --박스금액 \n");
//        sbSql.append("     , TO_NUMBER(SUBSTR(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,0,A.TRANS_QTY), INSTR(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,0,A.TRANS_QTY), ',') +1, LENGTH(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,0,A.TRANS_QTY))) * A.TRANS_PRICE) AS BONG_PRICE  --봉금액                 		   \n");
        sbSql.append("     , B.ITEM_SIZE_BONG * A.TRANS_PRICE AS BOX_PRICE --박스금액      \n");
        sbSql.append("     , TO_NUMBER(A.TRANS_PRICE) AS BONG_PRICE  --봉금액                     \n");        
        sbSql.append("     , ROUND(A.TRANS_PRICE * A.TRANS_QTY) AS TRANS_AMOUNT                                                                                                                                                                                            \n");
        sbSql.append("     , A.TRANS_DATE, B.OTCUSTCD, C.OTCUSTNM, A.TRANS_PRICE                                                                                                                                                                                           \n");
        sbSql.append("     , A.REMARK                                                                                                                                                                                                                                      \n");
        sbSql.append("     , (SELECT Z.SABUN||' '||Z.NM_KOR FROM SCC_USERINFO Z WHERE Z.SABUN = A.UUSER) AS CREATE_NM                                                                                                                                                      \n");
        sbSql.append("  FROM FMW_PO_TRANSACTION A, FMW_OTCUST_ITEM B, FMW_OTCUST C, FMS_SUBINVENTORY D                                                                                                                                                                     \n");
        sbSql.append(" WHERE A.ITEM_CODE = B.ITEM_CODE                                                                                                                                                                                                                     \n");
        sbSql.append("   AND B.OTCUSTCD = C.OTCUSTCD                                                                                                                                                                                                                       \n");
        sbSql.append("   AND A.SUBINV_CODE = D.SUBINV_CODE                                                                                                                                                                                                                 \n");
        sbSql.append("   AND A.SUBINV_CODE = '" + nullToBlank(ds_Cond.getString(0, "SUBINV_CODE")) + "'                                                                                                                                                            \n");
        sbSql.append("   AND A.TRANS_DATE BETWEEN '" + nullToBlank(ds_Cond.getString(0, "TRANS_SDATE")) + "' AND '" + nullToBlank(ds_Cond.getString(0, "TRANS_EDATE")) + "'                                                                                \n");
        sbSql.append("   AND A.TRANS_TYPE IN ('I002','I003')                                                                                                                                                                                                               \n");
        sbSql.append("   AND B.UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "                                                                                                                                                                        \n");
        sbSql.append("UNION ALL                                                                                                                                                                                                                                            \n");
        sbSql.append("SELECT A.TRANS_ID                                                                                                                                                                                                                                    \n");
        sbSql.append("     , A.ITEM_CODE                                                                                                                                                                                                                                   \n");
        sbSql.append("     , B.ITEM_NAME                                                                                                                                                                                                                                   \n");
        sbSql.append("     , A.TRANS_TYPE                                                                                                                                                                                                                                  \n");
        sbSql.append("     , A.TRANS_QTY                                                                                                                                                                                                                                   \n");
//        sbSql.append("     , SUBSTR(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,0,A.TRANS_QTY), 1, INSTR(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,0,A.TRANS_QTY), ',') - 1) AS BOX_QTY  --박스수량                                                                                                \n");
//        sbSql.append("     , SUBSTR(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,0,A.TRANS_QTY), INSTR(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,0,A.TRANS_QTY), ',') +1, LENGTH(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,0,A.TRANS_QTY))) AS BONG_QTY  --봉수량                                              \n");
        sbSql.append("     , TO_CHAR(ROUND(A.TRANS_QTY / B.ITEM_SIZE_BONG)) AS BOX_QTY  --박스수량                                                                                                \n");
        sbSql.append("     , '0' AS BONG_QTY  --봉수량                                              \n");
//        sbSql.append("     , (A.TRANS_AMOUNT - TO_NUMBER(SUBSTR(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,0,A.TRANS_QTY), INSTR(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,0,A.TRANS_QTY), ',') +1, LENGTH(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,0,A.TRANS_QTY))) * A.TRANS_PRICE)) AS BOX_PRICE --박스금액 \n");
//        sbSql.append("     , TO_NUMBER(SUBSTR(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,0,A.TRANS_QTY), INSTR(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,0,A.TRANS_QTY), ',') +1, LENGTH(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,0,A.TRANS_QTY))) * A.TRANS_PRICE) AS BONG_PRICE  --봉금액                 \n");
        sbSql.append("     , DECODE(ROUND(A.TRANS_QTY / B.ITEM_SIZE_BONG),0,0, A.TRANS_AMOUNT  / ROUND(A.TRANS_QTY / B.ITEM_SIZE_BONG)) AS BOX_PRICE --박스금액 \n");
        sbSql.append("     , 0 AS BONG_PRICE  --봉금액   \n");
        sbSql.append("     , A.TRANS_AMOUNT                                                                                                                                                                                         \n");
        sbSql.append("     , A.TRANS_DATE, B.OTCUSTCD, '한화호텔&리조트' AS OTCUSTNM, A.TRANS_PRICE                                                                                                                                                                        \n");
        sbSql.append("     , A.REMARK                                                                                                                                                                                                                                      \n");
        sbSql.append("     , (SELECT Z.SABUN||' '||Z.NM_KOR FROM SCC_USERINFO Z WHERE Z.SABUN = A.UUSER) AS CREATE_NM                                                                                                                                                      \n");
        sbSql.append("  FROM FMW_PO_TRANSACTION A, FMW_ITEM_V B, FMS_SUBINVENTORY D                                                                                                                                                                                        \n");
        sbSql.append(" WHERE A.ITEM_CODE = B.ITEM_CODE                                                                                                                                                                                                                     \n");
        sbSql.append("   AND A.SUBINV_CODE = D.SUBINV_CODE                                                                                                                                                                                                                 \n");
        sbSql.append("   AND A.SUBINV_CODE = '" + nullToBlank(ds_Cond.getString(0, "SUBINV_CODE")) + "'                                                                                                                                                            \n");
        sbSql.append("   AND A.TRANS_DATE BETWEEN '" + nullToBlank(ds_Cond.getString(0, "TRANS_SDATE")) + "' AND '" + nullToBlank(ds_Cond.getString(0, "TRANS_EDATE")) + "'                                                                                \n");
        sbSql.append("   AND A.TRANS_TYPE = 'I001'                                                                                                                                                                                                                         \n");
        sbSql.append("   AND A.UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + " ) K                                                                                                                                                                    \n");
        sbSql.append("      GROUP BY K.TRANS_ID,K.ITEM_CODE,K.ITEM_NAME, DECODE(K.TRANS_TYPE,'I002','매입','I003','반품', DECODE(SIGN(K.TRANS_QTY), -1, '반품','매입'))      \n");
        sbSql.append("               ,K.BOX_QTY, K.BONG_QTY, K.BOX_PRICE, K.BONG_PRICE, K.TRANS_AMOUNT, K.TRANS_DATE, K.OTCUSTCD, K.OTCUSTNM, K.TRANS_PRICE, K.REMARK, K.CREATE_NM     \n");        
        sbSql.append("   ORDER BY K.OTCUSTNM,K.TRANS_DATE,DECODE(K.TRANS_TYPE,'I002','매입','I003','반품', DECODE(SIGN(K.TRANS_QTY), -1, '반품','매입'))               \n");        
        
        

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