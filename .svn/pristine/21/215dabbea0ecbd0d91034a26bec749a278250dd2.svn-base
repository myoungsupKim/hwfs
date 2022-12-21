
<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	Statement stmt             =  null;
	try	{
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		//DataSet ds_input  	= in_dl.get("");
		
		String g_CustCd 	= in_vl.getString("g_CustCd");
		
		if(conn != null && !conn.isClosed()) conn.close();
		
		conn = getIRISConn();
		
		stmt 		=  conn.createStatement();
	
	
		DataSet ds_detail;
		StringBuffer sbSelSql = new StringBuffer();
	
		sbSelSql.delete(0, sbSelSql.length());
		
		sbSelSql.append("SELECT ALRAM_ID, MEMO \n");
		sbSelSql.append("  FROM PO_ALRAM \n");
		sbSelSql.append(" WHERE CUSTCD = " + g_CustCd + " \n");
		sbSelSql.append("   AND F_DATE <= TO_CHAR(SYSDATE,'YYYYMMDD') \n");
		sbSelSql.append("   AND T_DATE >= TO_CHAR(SYSDATE,'YYYYMMDD') \n");
		sbSelSql.append("   AND DECODE(CONFIRM_DATE, NULL, 'X', TO_CHAR(CONFIRM_DATE,'YYYYMMDD')) \n");
		sbSelSql.append("       <> DECODE(CONFIRM_DATE, NULL, 'Y', TO_CHAR(SYSDATE,'YYYYMMDD')) \n");
		sbSelSql.append("   AND POPUP_CNT < 5 \n");
		sbSelSql.append(" ORDER BY ALRAM_ID \n");
		
		pstmt = conn.prepareStatement(sbSelSql.toString());		
		rs = pstmt.executeQuery(); 
		DataSet ds_memo = this.makeDataSet(rs,"ds_memo");
		out_dl.add(ds_memo);
		
	   	this.setResultMessage(0, "OK",out_vl);
		
	} catch(Exception ex) {
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