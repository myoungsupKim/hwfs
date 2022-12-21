<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 협력업체 > 운영관리
■ 프로그램ID   : FSV00450E_T002.jsp
■ 프로그램명   : 자재이미지관리(삭제)
■ 작성일자     : 2012-04-01
■ 작성자       : 박은규
■ 이력관리     : 
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	try {
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));		
		
		//오토커밋 강제 false
		conn.setAutoCommit(false);

		//입력 데이타                                                                                                                                                                                         
		DataSet ds_input     = in_dl.get("ds_input"); 

		//입력 파라메터
		String sItemCode     = nullToBlank(in_vl.getString("sItemCode"));
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		
		if(conn != null && !conn.isClosed()) conn.close();
		
		conn = getIRISConn();
		
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
	
		sbSql.delete(0, sbSql.length());
		sbSql.append("UPDATE PO_ITEM_IMAGE A \n");
		sbSql.append("   SET A.IMAGE_FILE = NULL \n");
		sbSql.append("     , A.UPDATE_DATE = SYSDATE \n");
		sbSql.append("     , A.UPDATE_BY = '" + g_EmpNo + "' \n");
		sbSql.append(" WHERE A.CENTER_CODE = " + nullToBlank(ds_input.getString(0, "CENTER_CODE")) + " \n");
		sbSql.append("   AND A.CUSTCD = " + nullToBlank(ds_input.getString(0, "CUSTCD")) + " \n");
		sbSql.append("   AND A.ITEM_CODE = '" + sItemCode + "' \n");
		
out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());
		pstmt.executeUpdate();
		pstmt.close();

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