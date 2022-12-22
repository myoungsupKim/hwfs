<%@page import="com.sz.util.AppDataUtility"%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	Statement stmt             =  null;
	try {
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
	//	String v_EmpNo 		= in_vl.getString("g_EmpNo");	
	//	DataSet in_ds  =  in_dl.get("ds_tab1");
	//	String sCode = in_ds.getString(0, "CD");
			
		String BILL_ID 		= nullToBlank(in_vl.getString("BILL_ID"));		
	
		if(conn != null && !conn.isClosed()) conn.close();
		
		conn = getIRISConn();
		
		stmt 		=  conn.createStatement();
	
		StringBuffer sbSql = new StringBuffer();
		

				sbSql.delete(0, sbSql.length());
				sbSql.append("UPDATE PO_CLSBILL                     		\n");
				sbSql.append("   SET CONFIRM_FLAG = 'Y'             		\n");
				sbSql.append("     , CONFIRM_DATE = SYSDATE         		\n");
				sbSql.append(" WHERE BILL_ID =  "+BILL_ID+" -- [BILL_ID]	\n");
				sbSql.append("   AND CONFIRM_FLAG = 'N'             		\n");
				sbSql.append("   AND CANCEL_FLAG = 'N'              		\n");
				
				
				
				System.out.println(sbSql.toString());  				
				pstmt = conn.prepareStatement(sbSql.toString());		
				rs = pstmt.executeQuery(); 
	
		conn.commit();
	   	this.setResultMessage(0, "OK",out_vl);
	} catch(Exception ex) {
		   ex.printStackTrace();
		   conn.rollback();
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