<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 협력업체
■ 프로그램ID   : FSV00420V_T001.jsp
■ 프로그램명   : MRO미입고 자재조회
■ 작성일자     : 2008-06-26
■ 작성자       : 박은규
■ 이력관리     : 2008-06-26 - 최초작성
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	try	{
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
	
		//입력 데이타
		DataSet ds_Cond     = in_dl.get("ds_Cond");
		//입력 파라메터
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		String sChk_        = nullToBlank(in_vl.getString("sChk_"));
		//FileLog.println("d:\\aaa.txt", ds_Cond);

		//IRIS로 접속
		if(conn != null && !conn.isClosed()) conn.close();
		conn = getIRISConn();

		//out 데이타
		DataSet ds_List;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		
		//조회
		sbSql.append("SELECT 'N' AS CHK \n");
		sbSql.append("     , TO_CHAR(A.REQ_DELIVERY_DATE,'YYYYMMDD') AS NEED_DATE \n");
		sbSql.append("     , NVL(D.SUBINV_NAME,'부서입고') AS SUBINV_NAME \n");
		sbSql.append("     , B.ORDER_NUM, A.MRO_PO_NO, A.MRO_PO_SEQ, A.STATE \n");
		sbSql.append("     , A.ITEM_CODE, A.ITEM_NAME, A.UNIT_CODE AS PO_UOM \n");
		sbSql.append("     , A.PR_QTY, A.PO_QTY \n");
		sbSql.append("     , A.RECEIVER_NAME||'('||A.RECEIVER_HP_NO||','||A.RECEIVER_TEL_NO||')' AS RECEIVER_NAME \n");
		sbSql.append("     , A.SP_NAME, A.SP_MANAGER_NAME, A.SP_TEL, A.SP_HP, A.SP_FAX \n");
		sbSql.append("  FROM MRO_V_MRO_PO_ODT_HLDC A, PO_PO B \n");
		sbSql.append("     , PO_SUBINVENTORY D \n");
		sbSql.append(" WHERE TO_NUMBER(A.PO_SEQ) = B.PO_ID \n");
		sbSql.append("   AND B.SUBINV_CODE = D.SUBINV_CODE(+) \n");
		sbSql.append("   AND TO_CHAR(A.REQ_DELIVERY_DATE,'YYYYMMDD') BETWEEN '" + nullToBlank(ds_Cond.getString(0, "DATEF")) + "' \n");
		sbSql.append("                                                   AND '" + nullToBlank(ds_Cond.getString(0, "DATET")) + "' \n");
		sbSql.append("   AND B.RC_UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + " \n");
		if (sChk_.equals("Y"))
			sbSql.append("   AND A.STATE NOT IN ('입고','입고취소','주문취소') \n");
		sbSql.append(" ORDER BY A.REQ_DELIVERY_DATE, B.SUBINV_CODE \n");
		
out_vl.add("fa_Sql", sbSql.toString());
		System.out.println(sbSql.toString());
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
		ex.printStackTrace();
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
	}

	proc_output(response,out,out_vl,out_dl);

%>