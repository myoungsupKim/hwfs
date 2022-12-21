
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
        
		// 발주목록조회
		sbSql.delete(0, sbSql.length());
		sbSql.append(" SELECT /*+ LEADING(A B) USE_NL(A B) INDEX(A PO_PO_I8) */ \n");
		sbSql.append("        A.NEED_DATE, A.CENTER_CODE, REPLACE(B.CENTER_NAME,'센터','') CENTER_NAME \n");
		sbSql.append("      , A.ORDER_DATE, A.ORDER_NUM \n");
		
		sbSql.append("      , DECODE(A.CENTER_FLAG,'N','Y') AS CENTER_FLAG \n");
		sbSql.append("      , MAX(A.ITEM_NAME)||DECODE(SIGN(COUNT(*)-1),1,' 외 '||TO_CHAR(COUNT(*)-1)||'종') AS ORDER_TITLE \n");
		sbSql.append("      , SUM(ROUND(ROUND(A.PO_QTY * A.UNIT_PRICE) * DECODE(A.TAX_CODE,'100',1.1,1))) ORDER_AMT \n");
		sbSql.append("   FROM PO_PO A, PO_CENTER B \n");
		sbSql.append("  WHERE A.CENTER_CODE = B.CENTER_CODE \n");
		sbSql.append("    AND A.LINE_STATUS >= '008' \n");
		sbSql.append("    AND A.ORDER_NUM > ' ' \n");
		sbSql.append("    AND A.CUSTCD = " + strCustCD + " \n");
		sbSql.append("    AND A.NEED_DATE = '" + strNeedDate + "' \n");
		if (strCnterCode.length() != 0)
			sbSql.append("    AND A.CENTER_CODE = " + strCnterCode + " \n");
		sbSql.append("    AND A.ITEM_CODE BETWEEN '010000000001' AND '019999999999' \n");
		sbSql.append("  GROUP BY A.ORDER_DATE, A.CENTER_CODE, A.ORDER_NUM, A.CENTER_FLAG, A.NEED_DATE, B.CENTER_NAME \n");
		
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