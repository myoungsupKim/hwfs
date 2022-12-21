
<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	Statement stmt             =  null;
	try {
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
	
		//입력 변수
		String QNA_ID 	= in_vl.getString("QNA_ID");
		
		//입력 데이타
		//DataSet ds_input     	= in_dl.get("ds_input");
		//String UPJANG     = nullToBlank(ds_input.getString(0, "UPJANG"));
		
		//IRIS 접속
		if(conn != null && !conn.isClosed()) conn.close();
		conn = getIRISConn();	
		stmt 		= conn.createStatement();
		
	
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		sbSql.delete(0, sbSql.length()); //클리어
		
		sbSql.delete(0, sbSql.length());
		
		sbSql.append(" UPDATE PO_CUST_QNA              \n  ");
		sbSql.append("     SET                         \n  ");
		sbSql.append("          READ_CNT = READ_CNT+1, \n  ");
		sbSql.append("          READ_DATE = SYSDATE    \n  ");
		sbSql.append("  WHERE QNA_ID = "+ QNA_ID +"    \n  ");

		stmt.execute(sbSql.toString());
		conn.commit();

		this.setResultMessage(0, "OK",out_vl);
		
	 }
	catch(Exception ex)
	{
		   conn.rollback();
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
			if(stmt != null) {
				try {
					stmt.close();
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