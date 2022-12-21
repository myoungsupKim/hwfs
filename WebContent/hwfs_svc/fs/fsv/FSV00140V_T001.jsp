
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
		
		String strCnterCode 	= nullToBlank(ds_input.getString(0, "CENTER_CODE"));
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
        
		// 발주예정현황
		sbSql.delete(0, sbSql.length());
		sbSql.append("SELECT A.ITEM_CODE, A.ITEM_NAME, DECODE(A.CENTER_FLAG,'N','Y') AS CENTER_FLAG, A.ITEM_SIZE, A.PO_UOM \n");
		sbSql.append("     , E.KEEPING_TYPE \n");
		sbSql.append("     , TO_CHAR(TO_DATE(A.NEED_DATE,'YYYYMMDD'),'YYYY-MM-DD') AS NEED_DATE \n");
		sbSql.append("     , REPLACE(B.UPJANGNM,'단체급식 ') || '(' || REPLACE(C.SUBINV_NAME,'식자재_') || ')' AS UPJANGNM \n");
		//sbSql.append("     , PO_GETREGION_FUN(A.RC_UPJANG,A.SUBINV_CODE) AS REGION_NAME \n");
		//sbSql.append("     , PO_GETREGION_FUN(A.RC_UPJANG,A.NEED_DATE) AS REGION_NAME \n");
		sbSql.append("     , PO_GETREGION_FUN(C.SHIP_ID,A.NEED_DATE) AS REGION_NAME \n");
		sbSql.append("     , A.PO_QTY \n");
		sbSql.append("     , A.UNIT_PRICE AS UNIT_PRICE \n");
		sbSql.append("     , ROUND(A.PO_QTY * A.UNIT_PRICE) AS GONG_PRICE \n");
		sbSql.append("     , ROUND(ROUND(A.PO_QTY * A.UNIT_PRICE) * DECODE(A.TAX_CODE,'100',0.1,0)) VAT \n");
		sbSql.append("     , ROUND(ROUND(A.PO_QTY * A.UNIT_PRICE) * DECODE(A.TAX_CODE,'100',1.1,1)) TOTAL \n");
		sbSql.append("     , A.PR_REMARK \n");
		sbSql.append("  FROM PO_PR A, ST_UPJANG B \n");
		sbSql.append("     , PO_SUBINVENTORY C, PO_ITEM_MST E \n");
		sbSql.append(" WHERE A.RC_UPJANG = B.UPJANG \n");
		sbSql.append("   AND A.SUBINV_CODE = C.SUBINV_CODE(+) \n");
		sbSql.append("   AND A.ITEM_CODE = E.ITEM_CODE \n");
		//sbSql.append("   AND A.LINE_STATUS IN ('002','004') \n");
		sbSql.append("   AND A.LINE_STATUS IN ('002','004', '006', '007') \n");
		sbSql.append("   AND A.NEED_DATE BETWEEN '" + strFromDt + "' AND '" + strToDt + "' \n");
		sbSql.append("   AND A.CUSTCD = " + strCustCD + " \n");
		if (strCnterCode.length() != 0)
			sbSql.append("   AND A.CENTER_CODE = '" + strCnterCode + "' \n");
		sbSql.append(" ORDER BY A.ITEM_CODE, A.NEED_DATE, B.UPJANGNM \n");
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