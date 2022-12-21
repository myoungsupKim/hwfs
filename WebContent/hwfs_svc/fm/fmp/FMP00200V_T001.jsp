<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/수불관리
■ 프로그램ID   : FMP00200V_T001.jsp
■ 프로그램명   : 입고확정 및 반품조회
■ 작성일자     : 2008.01.22
■ 작성자       : 박은규
■ 이력관리     : 2008.01.22
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
	
		//FileLog.println("d:\\aaa.txt", ds_cond);


		//out 데이타
		DataSet ds_List;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		//내역조회
		sbSql.append("SELECT A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM \n");
		sbSql.append("     , DECODE(A.TAX_CODE,'100','과세','210','면세','영세') AS TAX_CODE \n");
		sbSql.append("     , (A.ADJUST_QTY + A.PO_QTY) AS PR_QTY \n");
		sbSql.append("     , (A.ADJUST_QTY + A.CENTER_UNDELI_QTY + A.UNDELIVERED_QTY + A.RETURNED_QTY) AS RTN_QTY \n");
		sbSql.append("     , (A.DELIVERED_QTY - A.RETURNED_QTY) AS IN_QTY \n");
		sbSql.append("     , B.CODE_NAME AS LINE_STATUS \n");
		sbSql.append("     , A.ORIGIN_TYPE AS ORIGIN_TYPE \n");
		sbSql.append("     , DECODE(LINE_STATUS, 'GC', '입고확정', 'IV', '입고확정', '입고예정') AS STATUS \n");
		sbSql.append("  FROM (SELECT A.*, B.ORIGIN_TYPE FROM HLDC_PO_PO A, HLDC_PO_ITEM_MST B WHERE A.ITEM_CODE = B.ITEM_CODE) A, (SELECT CODE, CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FM0037') B \n");
		sbSql.append(" WHERE A.LINE_STATUS = B.CODE \n");
		sbSql.append("   AND A.RC_UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
		sbSql.append("   AND A.SUBINV_CODE = '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) + "' \n");
		sbSql.append("   AND A.NEED_DATE = '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' \n");
		//sbSql.append("   AND A.LINE_STATUS = DECODE('" + nullToBlank(ds_cond.getString(0, "LINE_STATUS")) + "','%',A.LINE_STATUS,'" + nullToBlank(ds_cond.getString(0, "LINE_STATUS")) + "') \n");
		sbSql.append("   AND (A.ADJUST_QTY + A.PO_QTY) > 0 \n");

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
