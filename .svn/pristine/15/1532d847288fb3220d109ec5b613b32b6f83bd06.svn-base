<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../main/common.jsp" %>
<%
	try {	
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
	

		if(conn!=null)
		{
			StringBuffer sbSql = new StringBuffer();
							
			sbSql.delete(0, sbSql.length());
			sbSql.append("SELECT	CODE		CD,		");
			sbSql.append("			CODE_NAME	NM		");
			sbSql.append("FROM   SCC_COMMON_CODE		");
			sbSql.append("WHERE  GROUP_CODE='SC0001'	");   
			sbSql.append("ORDER BY TO_NUMBER(CODE)		");  
			
			pstmt = conn.prepareStatement(sbSql.toString());
			
			rs = pstmt.executeQuery(); 

//			out_dl.add("DS_body", this.makeDataSet(rs,"DS_body"));
			
			DataSet FS000001_sl4 = this.makeDataSet(rs,"FS000001_sl4");
			out_dl.add(FS000001_sl4);
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