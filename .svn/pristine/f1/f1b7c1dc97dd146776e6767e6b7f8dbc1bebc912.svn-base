
<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	Statement stmt             =  null;
	try {
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));
		
		//입력 데이타                                                                                                                                                                                         
		DataSet ds_input     = in_dl.get("ds_input"); 
		
	  	String strFromDt 		= nullToBlank(ds_input.getString(0, "FROM_DT"));                                                                                                                                                                                                        
		String strToDt 			= nullToBlank(ds_input.getString(0, "TO_DT")); 
		String strCustCD 		= nullToBlank(ds_input.getString(0, "CUSTCD")); 
		
		if(conn != null && !conn.isClosed()) conn.close();
		
		conn = getIRISConn();
		
		stmt 		=  conn.createStatement();
	
	
		//out 데이타                                                                                                                                                                                        
		DataSet ds_list;                                                                                                                                                                                    
		                                                                                                                                                                                                    
		//sql문 버퍼생성                                                                                                                                                                                    
		StringBuffer sbSql = new StringBuffer();                                                                                                                                                            
        
		// 비식자재발주목록조회
		sbSql.delete(0, sbSql.length());
		sbSql.append(" SELECT /*+INDEX(A PO_PO_I4)*/ A.ORDER_DATE, A.ORDER_NUM \n");
		sbSql.append("      , MAX(A.ITEM_NAME) || ' 외 ' || TO_CHAR(COUNT(*)-1) || '종' ORDER_TITLE \n");
		sbSql.append("      , SUM(A.PO_QTY * A.UNIT_PRICE + DECODE(A.TAX_CODE,'100', ROUND(A.PO_QTY * A.UNIT_PRICE * 0.1, 1), 0)) ORDER_AMT \n");
		sbSql.append("   FROM PO_PO A, PO_CENTER B \n");
		sbSql.append("  WHERE A.CENTER_CODE = B.CENTER_CODE \n");
		//sbSql.append("    AND A.LINE_STATUS >= '008' \n");
		sbSql.append("    AND A.LINE_STATUS >= DECODE(SUBSTR(B.CENTER_TYPE,1,2)||A.CENTER_FLAG,'01Y','008','009') \n");
		sbSql.append("    AND A.ORDER_NUM > ' ' \n");
		sbSql.append("    AND A.CUSTCD = " + strCustCD + " \n");
		sbSql.append("    AND A.ORDER_DATE BETWEEN '" + strFromDt + "' AND '" + strToDt + "' \n");
		sbSql.append("    AND A.ITEM_CODE NOT LIKE '01%' \n");
		sbSql.append(" GROUP BY ORDER_DATE, ORDER_NUM \n");
		//sbSql.append(" ORDER BY ORDER_DATE, ORDER_NUM \n");
		
		//System.out.println(sbSql.toString());                                                                                                                                                             
		pstmt = conn.prepareStatement(sbSql.toString());		                                                                                                                                                
		rs = pstmt.executeQuery();                                                                                                                                                                          
		ds_list = this.makeDataSet(rs, "ds_list");  
		
		rs.close();
		pstmt.close();
                                                                                                                                                                                                        
		/**종료**/                                                                                                                                                                                          
		out_dl.add(ds_list);                                                                                                                                                          
		this.setResultMessage(0, "OK", out_vl);  
		
	} catch(Exception ex) {
		//ex.printStackTrace();
		//jsp 로그남기기
		logger.debug(ex.getMessage(), ex);
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
			try {
				logger.endIndividualLog();
			} catch( Exception logE) {
				logE.printStackTrace();
			}
		}
		
	  proc_output(response,out,out_vl,out_dl);
	
%>	