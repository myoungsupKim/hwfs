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
		
		String IN_SYS_GBN  = in_vl.getString("IN_SYS_GBN");

	
		if(conn!=null)
		{
			StringBuffer sbSql = new StringBuffer();
							
			sbSql.delete(0, sbSql.length());
			sbSql.append("SELECT   SYS_ID ID,     				\n");
			sbSql.append("         SYS_NAME NAME  				\n");
			sbSql.append("FROM     SCC_SYSTEM     				\n");
			sbSql.append("WHERE    SYS_TYPE='"+ IN_SYS_GBN +"'	\n");

			//pstmt = conn.prepareStatement(sbSql.toString());
			//rs = pstmt.executeQuery();
			stmt = conn.createStatement();		
			rs = stmt.executeQuery(sbSql.toString()); 			

//			out_dl.add("DS_body", this.makeDataSet(rs,"DS_body"));
			
			DataSet SCC00010E_S002 = this.makeDataSet(rs,"SCC00010E_S002");
			out_dl.add(SCC00010E_S002);
			//rs.close();
			//pstmt.close();
			
			this.setResultMessage(0, "OK",out_vl);
//			String fileUrl = "c:/tomcat-4.1/webapps/hwfs/hwfs_svc/log/test.log";
//			tit.util.FileLog.println(fileUrl, "sql=====>"+sbSql.toString());
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