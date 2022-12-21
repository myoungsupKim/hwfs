<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 타사매입처 입출고 확정 및 처리(타사매입)
■ 프로그램ID   : FMW00220E_T003.jsp
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
		
		//입력 파라메터
		String v_ItemCode  = nullToBlank(in_vl.getString("v_ItemCode"));
		String v_Qty    = nullToBlank(in_vl.getString("v_Qty"));		
		String v_TransDate    = nullToBlank(in_vl.getString("v_TransDate"));
		String v_Upjang    = nullToBlank(in_vl.getString("v_Upjang"));
		String sType    = nullToBlank(in_vl.getString("sType"));
		//FileLog.println("d:\\aaa.txt", ds_Box);

		//out 데이타
		DataSet ds_Price;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		//Box, Bong 금액계산
		sbSql.delete(0, sbSql.length());
        sbSql.append("SELECT A.ITEM_CODE                     				                                \n");
        if (sType.equals("BoxQty"))
		{
       		sbSql.append("     , ROUND(A.ITEM_SIZE_BOX * A.ITEM_SIZE_BONG * NVL(A.UNIT_PRICE_BONG, 0) * "+ v_Qty +") AS BOX_PRICE   \n");
		}
        else if (sType.equals("BongQty"))
		{
        	sbSql.append("     , ROUND(NVL(A.UNIT_PRICE_BONG, 0) * "+ v_Qty +") AS BONG_PRICE 				    \n");
		}
        sbSql.append("     , NVL(A.UNIT_PRICE_BONG, 0) AS TRANS_PRICE                        				    \n");
        sbSql.append("  FROM FMW_OTCUST_ITEM A                                           				    \n");
        sbSql.append(" WHERE A.ITEM_CODE = '"+ v_ItemCode +"'                                				\n");
        sbSql.append("   AND A.UPJANG = '"+ v_Upjang +"'                                				\n");
out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_Price = this.makeDataSet(rs, "ds_Price");

		pstmt.close();
		rs.close();

		/**종료**/
		out_dl.add(ds_Price);
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