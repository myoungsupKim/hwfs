<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 상품별판매실적조회
■ 프로그램ID   : FMW00360V_T001.jsp
■ 프로그램명   : 상품별판매실적조회
■ 작성일자     : 2011-02-25
■ 작성자       : 맹수영
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
		//DataSet ds_cond     = in_dl.get("ds_Cond");
		DataSet ds_input  	    = in_dl.get("ds_input");
		//입력 파라메터

		String v_Upjang         = nullToBlank(ds_input.getString(0, "UPJANG"));
		String v_Sdate         = nullToBlank(ds_input.getString(0, "SDATE"));
		String v_Edate         = nullToBlank(ds_input.getString(0, "EDATE"));
		String v_Hall_Code         = nullToBlank(ds_input.getString(0, "HALL_CODE"));
		String v_Stype         = nullToBlank(ds_input.getString(0, "STYPE"));
		
		//FileLog.println("d:\\aaa.txt", ds_cond);


		//out 데이타
		DataSet ds_list;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		//내역조회
        sbSql.append("SELECT V.상품코드                                                                                                                                                     \n");
        sbSql.append("      ,MAX(V.상품명) 상품명                                                                                                                                           \n");
        sbSql.append("      ,MAX((SELECT OTCUSTNM FROM FMW_OTCUST WHERE OTCUSTCD = V.매입처)) 매입처                                                                                        \n");
        sbSql.append("      ,SUM(V.매출박스) 매출박스                                                                                                                                       \n");
        sbSql.append("      ,SUM(V.매출봉) 매출봉                                                                                                                                           \n");
        sbSql.append("      ,SUM(V.매출금액) 매출금액                                                                                                                                       \n");
        sbSql.append("      ,SUM(V.반품박스) 반품박스                                                                                                                                       \n");
        sbSql.append("      ,SUM(V.반품봉) 반품봉                                                                                                                                           \n");
        sbSql.append("      ,SUM(V.반품금액) 반품금액                                                                                                                                       \n");
        sbSql.append("      ,SUM(V.순매출) 순매출                                                                                                                                           \n");
        sbSql.append("      ,SUM(V.매입원가) 매입원가                                                                                                                                       \n");
        sbSql.append("      ,SUM(V.순매출) - SUM(매입원가) 이익금                                                                                                                           \n");
        sbSql.append("      ,DECODE(SUM(V.순매출),0,0, (SUM(V.순매출) - SUM(V.매입원가)) / SUM(V.순매출) * 100) AS 이익율                                                                   \n");
        sbSql.append("FROM (                                                                                                                                                                \n");
        sbSql.append("        SELECT A.ITEM_CODE 상품코드                                                                                                                                   \n");
        sbSql.append("              ,MAX(A.ITEM_NAME) 상품명                                                                                                                                \n");
        sbSql.append("              ,MAX(B.OTCUSTCD) 매입처                                                                                                                                 \n");
        sbSql.append("              ,SUM(DECODE(TRANS_TYPE,'O001',SUBSTR(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,NULL,A.TRANS_QTY),1,INSTR(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,NULL,A.TRANS_QTY),',')-1),0)) 매출박스 \n");
        sbSql.append("              ,SUM(DECODE(TRANS_TYPE,'O001',SUBSTR(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,NULL,A.TRANS_QTY),INSTR(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,NULL,A.TRANS_QTY),',')+1),0)) 매출봉 \n");
        sbSql.append("              ,SUM(DECODE(A.TRANS_TYPE,'O001',SALE_AMOUNT,0)) 매출금액                                                                                                \n");
        sbSql.append("              ,SUM(DECODE(TRANS_TYPE,'O002',SUBSTR(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,NULL,A.TRANS_QTY),1,INSTR(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,NULL,A.TRANS_QTY),',')-1),0)) 반품박스 \n");
        sbSql.append("              ,SUM(DECODE(TRANS_TYPE,'O002',SUBSTR(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,NULL,A.TRANS_QTY),INSTR(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,NULL,A.TRANS_QTY),',')+1),0)) 반품봉 \n");
        sbSql.append("              ,SUM(DECODE(A.TRANS_TYPE,'O002',SALE_AMOUNT,0)) 반품금액                                                                                                \n");
        sbSql.append("              ,SUM(DECODE(A.TRANS_TYPE,'O001', NVL(A.SALE_AMOUNT,0),0)) +                                                                                             \n");
        sbSql.append("               SUM(DECODE(A.TRANS_TYPE,'O002', NVL(A.SALE_AMOUNT,0),0)) - SUM(DECODE(B.TAX_CODE,'100',ROUND(NVL(A.SALE_AMOUNT,0) / 10),0)) AS 순매출                  \n");
        sbSql.append("              ,SUM(NVL(A.AVG_AMOUNT,0)) AS 매입원가                                                                                                                   \n");
        sbSql.append("          FROM FMW_PO_TRANSACTION A,                                                                                                                                  \n");
        sbSql.append("               FMW_ITEM_V B                                                                                                                                           \n");
        sbSql.append("         WHERE A.ITEM_CODE = B.ITEM_CODE                                                                                                                              \n");
        sbSql.append("           AND A.UPJANG = '" + v_Upjang + "'                                                                                                                            \n");
        sbSql.append("           AND A.HALL_CODE = '" + v_Hall_Code + "'                                                                                                                      \n");
        sbSql.append("           AND A.TRANS_DATE BETWEEN '" + v_Sdate + "' AND '" + v_Edate + "'                                                                                               \n");
        sbSql.append("        GROUP BY A.ITEM_CODE                                                                                                                                          \n");
        sbSql.append("       ) V                                                                                                                                                            \n");
        sbSql.append("GROUP BY V.상품코드                                                                                                                                                   \n");

out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery();
				
		ds_list = this.makeDataSet(rs, "ds_list");
		
		rs.close();
		pstmt.close();		
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
