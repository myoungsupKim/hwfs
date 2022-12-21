
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
		String strOrderNum 			= nullToBlank(ds_input.getString(0, "ORDER_NUM")); 
		String sCenter 		        = nullToBlank(in_vl.getString("sCenter"));		
		
		if(conn != null && !conn.isClosed()) conn.close();
		
		conn = getIRISConn();
		
		stmt =  conn.createStatement();
	
	
		//out 데이타                                                                                                                                                                                        
		DataSet ds_list;                                                                                                                                                                                    
		                                                                                                                                                                                                    
		//sql문 버퍼생성                                                                                                                                                                                    
		StringBuffer sbSql = new StringBuffer();                                                                                                                                                            
        
		// 발주목록조회-발주상세내역
		sbSql.delete(0, sbSql.length());
		//sbSql.append("SELECT PO_GETREGION_FUN(A.RC_UPJANG,A.SUBINV_CODE) AS REGION_NAME \n");
		//sbSql.append("SELECT PO_GETREGION_FUN(A.RC_UPJANG,A.NEED_DATE) AS REGION_NAME \n");
		sbSql.append("SELECT PO_GETREGION_FUN(C.SHIP_ID,A.NEED_DATE) AS REGION_NAME \n");
		//직영점은 업장명 + 창고명('식자재_' 제외), 식재영업은 창고명만 표시
		sbSql.append("     , DECODE(SUBSTR(A.SUBINV_CODE,1,3), 'S10', C.SUBINV_NAME \n");
		sbSql.append("             ,DECODE(SUBSTR(B.UPJANGNM,1,4),'단체급식', SUBSTR(B.UPJANGNM,6), B.UPJANGNM)) UPJANGNM \n");
		//sbSql.append("     , DECODE(SUBSTR(A.SUBINV_CODE,1,3), 'S10', C.SUBINV_NAME \n");
		sbSql.append("     , DECODE(SUBSTR(A.SUBINV_CODE,1,3), 'S10', NULL \n");
		sbSql.append("             ,REPLACE(C.SUBINV_NAME,'식자재_')) AS SUBINV_NAME \n");
		sbSql.append("     , A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM \n");
		sbSql.append("     , E.KEEPING_TYPE, TO_CHAR(TO_DATE(A.NEED_DATE,'YYYYMMDD'),'YYYY-MM-DD') NEED_DATE \n");
		sbSql.append("     , A.PO_QTY, ROUND(A.UNIT_PRICE) AS UNIT_PRICE \n");
		sbSql.append("     , ROUND(A.PO_QTY * A.UNIT_PRICE) AMT \n");
		sbSql.append("     , ROUND(ROUND(A.PO_QTY * A.UNIT_PRICE) * DECODE(A.TAX_CODE,'100',0.1,0)) VAT \n");
		sbSql.append("     , ROUND(ROUND(A.PO_QTY * A.UNIT_PRICE) * DECODE(A.TAX_CODE,'100',1.1,1)) TOTAL \n");
		sbSql.append("     , E.ORIGIN_TYPE \n");
		sbSql.append("     , A.PR_REMARK \n");
		sbSql.append("     , TRIM(TO_CHAR(A.PO_ID,'0000000000')) AS PO_ID_STR \n");
		sbSql.append("     , DECODE(MOD(TO_NUMBER(PO_GETREGION_FUN(C.SHIP_ID,A.NEED_DATE,'3')),2), 0, 'Y', 'N') AS CLASSIFY \n");
		sbSql.append("  FROM PO_PO A, ST_UPJANG B, PO_SUBINVENTORY C \n");
		sbSql.append("     , PO_ITEM_MST E \n");
		sbSql.append(" WHERE A.RC_UPJANG           = B.UPJANG \n");
		sbSql.append("   AND A.SUBINV_CODE         = C.SUBINV_CODE(+) \n");
		sbSql.append("   AND A.ITEM_CODE           = E.ITEM_CODE \n");
		sbSql.append("   AND A.CUSTCD              = " + strCustCD + " \n");
		sbSql.append("   AND A.LINE_STATUS        >= '008' \n");
		sbSql.append("   AND A.ITEM_CODE BETWEEN '010000000001' AND '019999999999' \n");
		sbSql.append("   AND A.ORDER_NUM           = '" + strOrderNum + "' \n");
		sbSql.append("   AND A.NEED_DATE           = '" + strNeedDate + "' \n");
		sbSql.append("   AND A.CENTER_CODE         = " + sCenter + " \n");
		sbSql.append(" ORDER BY A.ITEM_CODE, B.UPJANGNM \n");
		
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