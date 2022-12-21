<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/수불관리/재고관리
■ 프로그램ID   : FMP00470E_T002.jsp
■ 프로그램명   : 재고관리상품 등록(저장)
■ 작성일자     : 2008.04.25
■ 작성자       : 박은규
■ 이력관리     : 2008.04.25
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
		
		//오토커밋 강제 false
		conn.setAutoCommit(false);		
	
		//입력 데이타
		DataSet ds_iud      = in_dl.get("ds_IUD");
		//입력 파라메터
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		String sUpjang      = nullToBlank(in_vl.getString("sUpjang"));
		String sSubinv      = nullToBlank(in_vl.getString("sSubinv"));


		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		//기존자료 삭제초기화
		sbSql.append("DELETE FROM FMS_STOCK_ITEM \n");
		sbSql.append(" WHERE UPJANG = " + sUpjang + " \n");
		sbSql.append("   AND SUBINV_CODE = '" + sSubinv + "' \n");

out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());
		pstmt.executeUpdate();
		
		pstmt.close();

		//입력
		for ( int i = 0 ; i < ds_iud.getRowCount() ; i++ )
		{
			sbSql.delete(0, sbSql.length());

			sbSql.append("INSERT INTO FMS_STOCK_ITEM( \n");
			sbSql.append("  UPJANG \n");
			sbSql.append(", SUBINV_CODE \n");
			sbSql.append(", ITEM_CODE \n");
			sbSql.append(", STOCK_YN \n");
			sbSql.append(", CUSER \n");
			sbSql.append(", CDATE \n");
			sbSql.append(", UUSER \n");
			sbSql.append(", UDATE \n");
			sbSql.append(") VALUES ( \n");
			sbSql.append("  " + nullToBlank(ds_iud.getString(i, "UPJANG")) + " \n");
			sbSql.append(", '" + nullToBlank(ds_iud.getString(i, "SUBINV_CODE")) + "' \n");
			sbSql.append(", '" + nullToBlank(ds_iud.getString(i, "ITEM_CODE")) + "' \n");
			sbSql.append(", 'Y' \n");
			sbSql.append(", '" + g_EmpNo + "' \n");
			sbSql.append(", SYSDATE \n");
			sbSql.append(", '" + g_EmpNo + "' \n");
			sbSql.append(", SYSDATE \n");
			sbSql.append(" ) \n");

out_vl.add("fa_Sql", sbSql.toString());
			//System.out.println(sbSql.toString());
			pstmt = conn.prepareStatement(sbSql.toString());
			pstmt.executeUpdate();
			
			pstmt.close();
		}
		
		/**종료**/
		conn.commit();
		this.setResultMessage(0, "OK", out_vl);

	}
	catch(Exception ex)
	{
		conn.rollback();
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