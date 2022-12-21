<%
//-----------------------------------------------------------------------------
//■ 시스템명     : 식재영업/수불관리/실적관리/상품별 거래실적 조회
//■ 프로그램ID   : FMP01030V_T001.jsp
//■ 프로그램명   : 제출단가 상품별 거래실적 조회
//■ 작성일자     : 2008.01.31
//■ 작성자       : 노규완
//■ 이력관리     : 2008.01.31
//-----------------------------------------------------------------------------*/
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
		DataSet ds_cond     = in_dl.get("ds_cond");
		//입력 파라메터
	//	String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
	//	String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
	
	//FileLog.println("d:\\aaa.txt", ds_cond);
		//HLDC로 재연결
		if(conn != null && !conn.isClosed()) conn.close();
		conn = getIRISConn();

		//out 데이타
		DataSet ds_list;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		//
		String sUpjang = nullToBlank(ds_cond.getString(0, "UPJANG"));
		String sItemCode = nullToBlank(ds_cond.getString(0, "ITEM_CODE"));
		String sFmonth = nullToBlank(ds_cond.getString(0, "FROM_MONTH"));
		String sTmonth = nullToBlank(ds_cond.getString(0, "TO_MONTH"));

		//내역조회
        sbSql.append("SELECT                             \n");
        sbSql.append("       A.CONTRACT_START  ,A.CONTRACT_END                              \n");
        sbSql.append("     , A.CONTRACT_PRICE                                \n");
        sbSql.append("     , A.SALE_PRICE                                    \n");
        sbSql.append("     , A.SALE_PRICE - A.CONTRACT_PRICE AS AMT          \n");
        sbSql.append("     , A.MARGIN_RATE                                   \n");
        sbSql.append("  FROM PO_CONTRACT_FSALE A                        \n");
        sbSql.append("     , ST_UPJANG B                                \n");
        sbSql.append("     , PO_ITEM_MST C                              \n");
        sbSql.append(" WHERE C.ITEM_CODE = '" + sItemCode + "'               \n");
        sbSql.append("   AND CONTRACT_START <= '" + sTmonth + "' || '31'     \n");
        sbSql.append("   AND NVL(CONTRACT_END,'99991231') >= '" + sFmonth + "' || '01' \n");
        sbSql.append("   AND A.UPJANG = B.AP_UNITPRICE_UPJANG                \n");
        sbSql.append("   AND A.ITEM_CODE = C.ITEM_CODE                       \n");
        sbSql.append("   AND B.UPJANG = " + sUpjang + "         \n");
        sbSql.append(" ORDER BY 1                                            \n");		
		
out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_list = this.makeDataSet(rs, "ds_list");
		
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
