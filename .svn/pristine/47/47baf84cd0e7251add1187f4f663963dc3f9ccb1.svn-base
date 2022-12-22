<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../main/common.jsp" %>
<%
	try {	
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		String IN_SYS_GBN  = in_vl.getString("IN_SYS_GBN");

		if(conn!=null)
		{
			StringBuffer sbSql = new StringBuffer();
							
			sbSql.delete(0, sbSql.length());
			sbSql.append("SELECT   SYS_ID ID,     				");
			sbSql.append("         SYS_NAME NAME  				");
			sbSql.append("FROM     SCC_SYSTEM     				");
			sbSql.append("WHERE    SYS_TYPE='"+ IN_SYS_GBN +"'	");

			pstmt = conn.prepareStatement(sbSql.toString());
			
			rs = pstmt.executeQuery(); 

//			out_dl.add("DS_body", this.makeDataSet(rs,"DS_body"));
			
			DataSet FS000001_sl2 = this.makeDataSet(rs,"FS000001_sl2");
			out_dl.add(FS000001_sl2);
			this.setResultMessage(0, "OK",out_vl);
		}
	
	} catch(Exception ex) {
        this.setResultMessage(-1, ex.getMessage(),out_vl);
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
		if(conn != null) {
			try {
				conn.close();
			}catch(Exception e) {}
		}
	}
    proc_output(response,out,out_vl,out_dl);
%>