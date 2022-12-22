<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../main/common.jsp" %> 
<%
	Statement stmt           =  null;

	try {	
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		//jsp log 서비스 시작 
		//logger.startIndividualLog(in_vl.getString("titLogId"));
	
		String SABUN 	= in_vl.getString("SABUN");
		String USERID 	= in_vl.getString("USERID");


		if(conn!=null)
		{
			StringBuffer sbSql = new StringBuffer();
							
			sbSql.delete(0, sbSql.length());
			sbSql.append("		SELECT *  \n"); 
			sbSql.append("		FROM SCC_USERINFO  \n"); 
			sbSql.append("		WHERE USERID = '"+USERID+"'  \n"); 
			sbSql.append("		AND SABUN != '"+SABUN+"'  \n"); 
			
			//pstmt = conn.prepareStatement(sbSql.toString());
			//rs = pstmt.executeQuery(); 
			stmt = conn.createStatement();		
			rs = stmt.executeQuery(sbSql.toString());				

//			out_dl.add("DS_body", this.makeDataSet(rs,"DS_body"));
			
			DataSet SCC00040E_S011 = this.makeDataSet(rs,"SCC00040E_S011");
			out_dl.add(SCC00040E_S011);
			//rs.close();
			//pstmt.close();
			this.setResultMessage(0, "OK",out_vl);
		}
	
	} catch(Exception ex) {
		ex.printStackTrace();
		//jsp 로그남기기
		//logger.debug(ex.getMessage(), ex);
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
		//jsp log 서비스 닫기 
		//try {
		//	logger.endIndividualLog();
		//} catch( Exception logE) {
		//	logE.printStackTrace();
		//}		
	}
    proc_output(response,out,out_vl,out_dl);
%>