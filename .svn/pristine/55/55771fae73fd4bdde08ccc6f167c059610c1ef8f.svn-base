
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
		                                                                                                                                                                                                      
	  	String strCnterCode 		= nullToBlank(ds_input.getString(0, "CENTER_CODE"));                                                                                                                                                                                                        
		String strNeedDate 			= nullToBlank(ds_input.getString(0, "NEED_DATE")); 
		String strCustCD 			= nullToBlank(ds_input.getString(0, "CUSTCD"));  
		
		if(conn != null && !conn.isClosed()) conn.close();
		
		conn = getIRISConn();
		
		stmt 		=  conn.createStatement();
	
	
		//out 데이타                                                                                                                                                                                        
		DataSet ds_list;                                                                                                                                                                                    
		                                                                                                                                                                                                    
		//sql문 버퍼생성                                                                                                                                                                                    
		StringBuffer sbSql = new StringBuffer();                                                                                                                                                            
        
		// 거래내역조회(비식자재)
		sbSql.delete(0, sbSql.length());
		sbSql.append("SELECT A.RC_UPJANG, B.UPJANGNM, A.ORDER_DATE, \n");
		sbSql.append("       SUM((A.PO_QTY * A.UNIT_PRICE)) AMT, \n");
		sbSql.append("       NVL(SUM((DECODE(A.TAX_CODE,'100',0.1)*A.PO_QTY*A.UNIT_PRICE)),0) VAT, \n");
		sbSql.append("       SUM((A.PO_QTY * A.UNIT_PRICE))+ \n");
		sbSql.append("       NVL(SUM((DECODE(A.TAX_CODE,'100',0.1)*A.PO_QTY*A.UNIT_PRICE)),0) TOTAL \n");
		sbSql.append("FROM   PO_PO A, \n");
		sbSql.append("       ST_UPJANG B, \n");
		sbSql.append("       PO_SUBINVENTORY C \n");
		sbSql.append("WHERE  A.RC_UPJANG = B.UPJANG \n");
		sbSql.append("  AND  A.SUBINV_CODE = C.SUBINV_CODE(+) \n");
		sbSql.append("  AND  A.LINE_STATUS >= '008' \n");
		if (strCnterCode.length() != 0) sbSql.append("  AND  A.CENTER_CODE = '" + strCnterCode + "' \n");
		sbSql.append("  AND  A.ORDER_DATE   = '" + strNeedDate + "' \n");
		sbSql.append("  AND  A.CUSTCD = " + strCustCD + " \n");
		sbSql.append("  AND  A.ITEM_CODE NOT LIKE '01%'  \n");
		sbSql.append("  AND  A.PO_QTY > 0 \n");
		sbSql.append("GROUP BY B.UPJANGNM, A.RC_UPJANG, A.ORDER_DATE \n");
		//sbSql.append("ORDER BY B.UPJANGNM \n");

		
		
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