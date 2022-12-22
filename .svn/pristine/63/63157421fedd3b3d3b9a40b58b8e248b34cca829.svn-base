<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../main/common.jsp" %>
<%
	try {
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
	//	String v_sample1  = in_vl.getString("v_sample1");
	//	String v_sample2  = in_vl.getString("v_sample2");
	//	String IN_SYS_GBN  = nullToString(in_vl.getString("IN_SYS_GBN"));	
		StringBuffer sbSql = new StringBuffer();
	
		if(conn!=null)
		{							
			sbSql.delete(0, sbSql.length());
			sbSql.append("SELECT	CODE,					");
			sbSql.append("			CODE_NAME				");
			sbSql.append("FROM		SCC_COMMON_CODE			");
			sbSql.append("WHERE		USE_YN='Y'				");
			sbSql.append("AND		SYSTEM_YN='Y'			");
			sbSql.append("AND		GROUP_CODE='시스템구분'");
			
			
//			sbSql.append(" SELECT ROLE, ROLE_NAME, CONTENTS, USE_YN FROM SCC_ROLE");
			pstmt = conn.prepareStatement(sbSql.toString());
			
			rs = pstmt.executeQuery(); 

//			out_dl.add("DS_body", this.makeDataSet(rs,"DS_body"));
			
			DataSet FS000001_sl1 = this.makeDataSet(rs,"FS000001_sl1");
			out_dl.add(FS000001_sl1);
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