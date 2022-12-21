
<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	Statement stmt             =  null;
	try {
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		
		String v_Blank  	= nullToBlank(in_vl.getString("BLANK"));
		
		if(conn != null && !conn.isClosed()) conn.close();
		
		conn = getIRISConn();
		
		stmt 		=  conn.createStatement();
	
	
		//out 데이타                                                                                                                                                                                        
		DataSet ds_Center;                                                                                                                                                                                    
		                                                                                                                                                                                                    
		//sql문 버퍼생성                                                                                                                                                                                    
		StringBuffer sbSql = new StringBuffer();                                                                                                                                                            
        
		// 물류센터권한
		sbSql.delete(0, sbSql.length());
		if (v_Blank.equals("A"))
		{
			sbSql.append("SELECT NULL AS CENTER_CODE, '전체' AS CENTER_NAME FROM DUAL \n");
			sbSql.append("UNION ALL \n");
		}
		if (v_Blank.equals("Y"))
		{
			sbSql.append("SELECT NULL AS CENTER_CODE, '' AS CENTER_NAME FROM DUAL \n");
			sbSql.append("UNION ALL \n");
		}
		sbSql.append("SELECT CENTER_CODE, CENTER_NAME \n");
		sbSql.append("  FROM PO_CENTER \n");
		sbSql.append(" WHERE USE_YN = 'Y' \n");
		//sbSql.append(" ORDER BY CENTER_CODE \n");
		
		//System.out.println(sbSql.toString());                                                                                                                                                             
		pstmt = conn.prepareStatement(sbSql.toString());		                                                                                                                                                
		rs = pstmt.executeQuery();                                                                                                                                                                          
		ds_Center = this.makeDataSet(rs, "ds_Center");                                                                                                                                                          
        
		/**종료**/                                                                                                                                                                                          
		out_dl.add(ds_Center);                                                                                                                                                          
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