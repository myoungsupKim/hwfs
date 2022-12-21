<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 타매입처입금등록
■ 프로그램ID   : FMW00230E_T001.jsp
■ 프로그램명   : 타매입처입금등록
■ 작성일자     : 2011-01-01
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
		//DataSet ds_cond     = in_dl.get("ds_Cond");
		//입력 파라메터
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		String sUpjang          = nullToBlank(in_vl.getString("sUpjang"));
		String sPayment_SDate    = nullToBlank(in_vl.getString("sPayment_SDate"));
		String sPayment_EDate    = nullToBlank(in_vl.getString("sPayment_EDate"));
		String sOtcustcd        = nullToBlank(in_vl.getString("sOtcustcd"));		
		
		//FileLog.println("d:\\aaa.txt", ds_cond);


		//out 데이타
		DataSet ds_list;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
 
		//내역조회
		sbSql.append("SELECT A.PAYMENT_ID, A.OTCUSTCD, A3.OTCUSTNM, A.UPJANG, A2.UPJANGNM_DISP \n");
		sbSql.append("     , A.PAYMENT_TYPE,(SELECT B.CODE_NAME FROM SCC_COMMON_CODE B WHERE A.PAYMENT_TYPE = B.CODE AND B.GROUP_CODE = 'FMW002') AS PAYMENT_TYPE_NM \n"); 
		sbSql.append("	   , A.PAYMENT_DATE, A.PAYMENT_AMT \n");
		sbSql.append("     , A.REMARK \n");		
		sbSql.append("  FROM FMW_OTCUST_PAYMENT A, FMS_UPJANG A2, FMW_OTCUST A3 \n");		
		sbSql.append(" WHERE A.UPJANG = A2.UPJANG \n");
		sbSql.append("   AND A.OTCUSTCD = A3.OTCUSTCD \n");		
		sbSql.append("   AND A.UPJANG = " + sUpjang + " \n");
		sbSql.append("   AND A.PAYMENT_DATE BETWEEN '" + sPayment_SDate + "' AND '" + sPayment_EDate + "' \n");
        if (! sOtcustcd.equals(""))
        	sbSql.append("   AND A.OTCUSTCD = '" + sOtcustcd + "' \n");
		sbSql.append(" ORDER BY A.OTCUSTCD, A.PAYMENT_DATE \n");

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
