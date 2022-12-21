<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/단가관리/운영율 일괄변경
■ 프로그램ID   : FMU00260E_T001.jsp
■ 프로그램명   : 운영율 일괄변경(저장)
■ 작성일자     : 2008.04.29
■ 작성자       : 박은규
■ 이력관리     : 2008.04.29
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
		DataSet ds_List   = in_dl.get("ds_List");
	
		//입력 파라메터
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));


		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		String sChk, sBrate, sArate, sBprice, sAprice;
		//수정
		for ( int i = 0; i < ds_List.getRowCount(); i++ )
		{
			sChk = nullToBlank(ds_List.getString(i, "SEL"));
			if (! sChk.equals("1")) continue;
			
			sBrate = nullToBlank(ds_List.getString(i, "BEFORE_OP_RATE"));
			sArate = nullToBlank(ds_List.getString(i, "AFTER_OP_RATE"));
			sBprice = nullToBlank(ds_List.getString(i, "BEFORE_OP_PRICE"));
			sAprice = nullToBlank(ds_List.getString(i, "AFTER_OP_PRICE"));
			
			if ((sBrate.equals(sArate)) && (sBprice.equals(sAprice))) continue;

			sbSql.delete(0, sbSql.length());
			sbSql.append("UPDATE FMU_OP_RATE \n");
			sbSql.append("   SET OP_PRICE = ROUND(TO_NUMBER(NVL('" + nullToBlank(ds_List.getString(i, "AFTER_OP_PRICE")) + "',0))) \n");
			sbSql.append("     , OP_RATE = ROUND(" + nullToBlank(ds_List.getString(i, "AFTER_OP_RATE")) + ") \n");
			sbSql.append("     , UUSER = '" + g_EmpNo + "' \n");
			sbSql.append("     , UDATE = SYSDATE \n");
			sbSql.append(" WHERE UPJANG = " + nullToBlank(ds_List.getString(i, "UPJANG")) + " \n");
			sbSql.append("   AND SDATE = '" + nullToBlank(ds_List.getString(i, "SDATE")) + "' \n");
			sbSql.append("   AND EDATE = '" + nullToBlank(ds_List.getString(i, "EDATE")) + "' \n");
			sbSql.append("   AND ITEM_CODE = '" + nullToBlank(ds_List.getString(i, "ITEM_CODE")) + "' \n");
						
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