
<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	Statement stmt             =  null;
	try {
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		DataSet ds_input     	= in_dl.get("ds_input"); 
		String v_Blank  		= nullToBlank(in_vl.getString("BLANK"));
		
		String strCnterCode		= nullToBlank(ds_input.getString(0, "CENTER_CODE"));                                                                                                                                                                                                        
		String strCustCD		= nullToBlank(ds_input.getString(0, "CUSTCD"));  
		
		if(conn != null && !conn.isClosed()) conn.close();
		
		conn = getIRISConn();
		
		stmt 		=  conn.createStatement();
	
	
		//out 데이타                                                                                                                                                                                        
		DataSet ds_out;                                                                                                                                                                                    
		                                                                                                                                                                                                    
		//sql문 버퍼생성                                                                                                                                                                                    
		StringBuffer sbSql = new StringBuffer();                                                                                                                                                            
        
		// 물류센터권한
		sbSql.delete(0, sbSql.length());
		if (v_Blank.equals("A"))
		{
			sbSql.append("SELECT NULL AS CONTRACT_ID, '전체' AS CONTRACT_NM FROM DUAL \n");
			sbSql.append("UNION ALL \n");
		}
		if (v_Blank.equals("Y"))
		{
			sbSql.append("SELECT NULL AS CONTRACT_ID, '' AS CONTRACT_NM FROM DUAL \n");
			sbSql.append("UNION ALL \n");
		}
		sbSql.append("SELECT CONTRACT_ID \n");
		sbSql.append("     , CONTRACT_ID || ';' || REMARK AS CONTRACT_NM \n");
		sbSql.append("  FROM PO_CONTRACT_F \n");
		sbSql.append(" WHERE CENTER_CODE = " + strCnterCode + " \n");
		sbSql.append("   AND CUSTCD = " + strCustCD + " \n");
		sbSql.append(" GROUP BY CONTRACT_ID, CONTRACT_ID||';'||REMARK \n");
		sbSql.append(" ORDER BY 1 DESC \n");
		
		//System.out.println(sbSql.toString());                                                                                                                                                             
		pstmt = conn.prepareStatement(sbSql.toString());		                                                                                                                                                
		rs = pstmt.executeQuery();                                                                                                                                                                          
		ds_out = this.makeDataSet(rs, "ds_out");                                                                                                                                                          
        
		/**종료**/                                                                                                                                                                                          
		out_dl.add(ds_out);                                                                                                                                                          
		this.setResultMessage(0, "OK", out_vl);  

		
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