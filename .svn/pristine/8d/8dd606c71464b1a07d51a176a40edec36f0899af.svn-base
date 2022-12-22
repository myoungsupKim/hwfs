
<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	Statement stmt             =  null;
	try {
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		String p_ALRAM_ID 		= in_vl.getString("p_ALRAM_ID");
		
		if(conn != null && !conn.isClosed()) conn.close();
		
		conn = getIRISConn();
		
		stmt 		=  conn.createStatement();
	
	
		StringBuffer sbInsSql = new StringBuffer();
		
		sbInsSql.delete(0, sbInsSql.length());
			
		sbInsSql.append("UPDATE PO_ALRAM SET CONFIRM_DATE = SYSDATE WHERE ALRAM_ID = " + p_ALRAM_ID);
		
		//System.out.println(sbInsSql.toString());
		stmt.execute(sbInsSql.toString());

		conn.commit();
		
	   	this.setResultMessage(0, "OK",out_vl);
	   	
	} catch(Exception ex) {
		conn.rollback();
		ex.printStackTrace();
	    this.setResultMessage(-1, ex.toString(),out_vl);
		} finally {
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