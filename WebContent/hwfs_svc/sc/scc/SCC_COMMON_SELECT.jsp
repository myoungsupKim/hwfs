<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../main/common.jsp" %>

<%
	Statement stmt           =  null;

	try {	
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		//System.out.println("in_v1   :"+in_vl.getString("in_sql")+"/");
		String in_sql  	= nullToBlank(in_vl.getString("in_sql"));
		String in_where = nullToBlank(in_vl.getString("in_where"));
		//String in_cdnm  	= nullToBlank(in_vl.getString("in_cdnm"));
		//String in_cbotype  	= nullToBlank(in_vl.getString("in_cbotype"));
		
		//System.out.println("in_sql   :"+in_sql+"/");
		//System.out.println("in_where :"+in_where+"/");


		if(conn!=null)
		{
			StringBuffer sbSql = new StringBuffer();
							
			sbSql.delete(0, sbSql.length());

			sbSql.append(in_sql+"\n");
			sbSql.append(in_where+"\n");
			
						
			//System.out.println(sbSql.toString());
			//pstmt = conn.prepareStatement(sbSql.toString());
			//rs = pstmt.executeQuery(); 
			stmt = conn.createStatement();		
			stmt.setFetchSize(1000);
			rs = stmt.executeQuery(sbSql.toString());
			
			DataSet ds_common = this.makeDataSet(rs,"ds_common");  //서버
			out_dl.add(ds_common);             //클라이언트 
			this.setResultMessage(0, "OK",out_vl);
			
            //	Log Write 
			//String fileUrl = "C:/tomcat-4.1/webapps/hwfs/hwfs_svc/log/KOO.log";
			//tit.util.FileLog.println(fileUrl, "sql=====>"+sbSql.toString());	
		}
	
	} catch(Exception ex) {
		ex.printStackTrace();		
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