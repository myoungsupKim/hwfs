
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
		
		String strCustCD 			= nullToBlank(ds_input.getString(0, "CUSTCD")); 
		String strOrderNum 			= nullToBlank(ds_input.getString(0, "ORDER_NUM")); 
		
		if(conn != null && !conn.isClosed()) conn.close();
		
		conn = getIRISConn();
		
		stmt 		=  conn.createStatement();
	
	
		//out 데이타                                                                                                                                                                                        
		DataSet ds_list;                                                                                                                                                                                    
		                                                                                                                                                                                                    
		//sql문 버퍼생성                                                                                                                                                                                    
		StringBuffer sbSql = new StringBuffer();                                                                                                                                                            
		
		// 비식자재발주목록조회--상세내역
		sbSql.delete(0, sbSql.length());
		//sbSql.append(" SELECT PO_GETREGION_FUN(A.RC_UPJANG,A.SUBINV_CODE) AS REGION_NAME \n");
		//sbSql.append(" SELECT PO_GETREGION_FUN(A.RC_UPJANG,A.NEED_DATE) AS REGION_NAME \n");
		sbSql.append(" SELECT PO_GETREGION_FUN(C.SHIP_ID,A.NEED_DATE) AS REGION_NAME \n");
		sbSql.append("      , DECODE(SUBSTR(B.UPJANGNM,1,4),'단체급식', SUBSTR(B.UPJANGNM,6), B.UPJANGNM) UPJANGNM \n");
		sbSql.append("      , C.SUBINV_NAME \n");
		sbSql.append("      , A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM \n");
		sbSql.append("      , A.PO_QTY, A.UNIT_PRICE \n");
		sbSql.append("      , A.PO_QTY*A.UNIT_PRICE AMT \n");
		sbSql.append("      , DECODE(A.TAX_CODE,'100', ROUND(A.PO_QTY * A.UNIT_PRICE * 0.1, 1), 0) VAT \n");
		sbSql.append("      , A.PO_QTY * A.UNIT_PRICE \n");
		sbSql.append("      + DECODE(A.TAX_CODE,'100', ROUND(A.PO_QTY * A.UNIT_PRICE * 0.1, 1), 0) TOTAL \n");
		sbSql.append("   FROM PO_PO A, ST_UPJANG B, PO_SUBINVENTORY C, PO_CENTER D \n");
		sbSql.append("  WHERE A.RC_UPJANG = B.UPJANG \n");
		sbSql.append("    AND A.SUBINV_CODE = C.SUBINV_CODE(+) \n");
		sbSql.append("    AND A.CENTER_CODE = D.CENTER_CODE \n");
		sbSql.append("    AND A.CUSTCD = " + strCustCD + " \n");
		//sbSql.append("    AND A.LINE_STATUS >= '008' \n");
		sbSql.append("    AND A.LINE_STATUS >= DECODE(SUBSTR(D.CENTER_TYPE,1,2)||A.CENTER_FLAG,'01Y','008','009') \n");
		sbSql.append("    AND A.ITEM_CODE NOT LIKE '01%' \n");
		sbSql.append("    AND A.ORDER_NUM = '" + strOrderNum + "' \n");
		sbSql.append("  ORDER BY A.ITEM_CODE \n");
		
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