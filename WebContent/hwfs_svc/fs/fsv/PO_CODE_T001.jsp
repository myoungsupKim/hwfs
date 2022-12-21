
<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	Statement stmt             =  null;
	try {
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		
		String v_Blank  	= nullToBlank(in_vl.getString("BLANK"));
		String v_Code  		= nullToBlank(in_vl.getString("GROUP_CODE"));
		
/* 		if(conn != null && !conn.isClosed()) conn.close();
		
		conn = getIRISConn(); */
		
		stmt 		=  conn.createStatement();
	
	
		//out 데이타                                                                                                                                                                                        
		DataSet gds_Csqlout;                                                                                                                                                                                    
		                                                                                                                                                                                                    
		//sql문 버퍼생성                                                                                                                                                                                    
		StringBuffer sbSql = new StringBuffer();                                                                                                                                                            
        
		// 물류센터권한
		sbSql.delete(0, sbSql.length());
		if (v_Blank.equals("A"))
		{
			sbSql.append("SELECT NULL AS CODE, '전체' AS CODE_NAME FROM DUAL \n");
			sbSql.append("UNION ALL \n");
		}
		if (v_Blank.equals("Y"))
		{
			sbSql.append("SELECT NULL AS CODE, '' AS CODE_NAME FROM DUAL \n");
			sbSql.append("UNION ALL \n");
		}
		sbSql.append("SELECT CODE, CODE_NAME \n");
		sbSql.append("  FROM PO_CODE \n");
		sbSql.append(" WHERE GROUP_CODE IN (" + v_Code + ") \n");
		sbSql.append(" ORDER BY 1 \n");
		
		pstmt = conn.prepareStatement(sbSql.toString());		                                                                                                                                                
		rs = pstmt.executeQuery();                                                                                                                                                                          
		gds_Csqlout = this.makeDataSet(rs, "gds_Csqlout");                                                                                                                                                          
        
		/**종료**/                                                                                                                                                                                          
		out_dl.add(gds_Csqlout);                                                                                                                                                          
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