<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 메뉴관리/구매관리/입고관리
■ 프로그램ID   : FSP00310E_T002.jsp
■ 프로그램명   : MRO자재 배송조회(저장)
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
		DataSet ds_iud      = in_dl.get("ds_IUD");
		//입력 파라메터
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		//FileLog.println("d:\\aaa.txt", ds_iud);
	
		//IRIS로 접속
		if(conn != null && !conn.isClosed()) conn.close();
		conn = getIRISConn();

		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		String sChk;

		//검수자료 저장
		for ( int i = 0 ; i < ds_iud.getRowCount() ; i++ )
		{
			sChk = nullToBlank(ds_iud.getString(i, "CHK"));
			if (sChk.equals("0")) continue;				

			//이미 전송자료인지 확인
			sbSql.delete(0, sbSql.length());
			sbSql.append("SELECT 1 FROM PO_MROMISSITEM \n");
			sbSql.append(" WHERE MRO_PO_NO = '" + nullToBlank(ds_iud.getString(i, "MRO_PO_NO")) + "' \n");
			sbSql.append("   AND MRO_PO_SEQ = '" + nullToBlank(ds_iud.getString(i, "MRO_PO_SEQ")) + "' \n");
out_vl.add("fa_Sql", sbSql.toString());
			System.out.println(sbSql.toString());
			pstmt = conn.prepareStatement(sbSql.toString());
			rs = pstmt.executeQuery();
			if(rs.next()) continue;

			sbSql.delete(0, sbSql.length());
			sbSql.append("INSERT INTO PO_MROMISSITEM \n");
			sbSql.append("SELECT TO_CHAR(A.REQ_DELIVERY_DATE,'YYYYMMDD') \n");
			sbSql.append("     , B.RC_UPJANG \n");
			sbSql.append("     , C.UPJANGNM \n");
			sbSql.append("     , B.SUBINV_CODE \n");
			sbSql.append("     , NVL(D.SUBINV_NAME,'부서입고') \n");
			sbSql.append("     , B.ORDER_NUM, A.MRO_PO_NO, A.MRO_PO_SEQ \n");
			sbSql.append("     , A.ITEM_CODE, A.ITEM_NAME, A.UNIT_CODE \n");
			sbSql.append("     , A.PR_QTY, A.PO_QTY \n");
			sbSql.append("     , A.RECEIVER_NAME \n");
			sbSql.append("     , A.RECEIVER_HP_NO \n");
			sbSql.append("     , A.RECEIVER_TEL_NO \n");
			sbSql.append("     , A.SP_NAME, A.SP_MANAGER_NAME, A.SP_TEL, A.SP_HP, A.SP_FAX \n");
			sbSql.append("     , A.SALES_PRICE, A.SALES_AMOUNT, A.PO_CREATOR_NAME, A.PO_CREATOR_TEL_NO \n");
			sbSql.append("     , A.STATE \n");
			sbSql.append("     , '" + g_EmpNo + "' \n");
			sbSql.append("     , SYSDATE \n");
			sbSql.append("     , '" + g_EmpNo + "' \n");
			sbSql.append("     , SYSDATE, B.PO_ID, B.RC_MU_CD \n");
			sbSql.append("  FROM MRO_V_MRO_PO_ODT_HLDC A, PO_PO B \n");
			sbSql.append("     , ST_UPJANG C, PO_SUBINVENTORY D \n");
			sbSql.append(" WHERE TO_NUMBER(A.PO_SEQ) = B.PO_ID \n");
			sbSql.append("   AND B.RC_UPJANG = C.UPJANG \n");
			sbSql.append("   AND B.SUBINV_CODE = D.SUBINV_CODE(+) \n");
			sbSql.append("   AND A.MRO_PO_NO = '" + nullToBlank(ds_iud.getString(i, "MRO_PO_NO")) + "' \n");
			sbSql.append("   AND A.MRO_PO_SEQ = '" + nullToBlank(ds_iud.getString(i, "MRO_PO_SEQ")) + "' \n");
out_vl.add("fa_Sql", sbSql.toString());
			System.out.println(sbSql.toString());
			pstmt = conn.prepareStatement(sbSql.toString());
			pstmt.executeUpdate();
		}

		/**종료**/
		conn.commit();
		this.setResultMessage(0, "OK", out_vl);

	}
	catch(Exception ex)
	{
		conn.rollback();
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