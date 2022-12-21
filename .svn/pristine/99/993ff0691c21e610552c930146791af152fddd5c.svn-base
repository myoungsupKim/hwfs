
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
		String strContractID		= nullToBlank(ds_input.getString(0, "CONTRACT_ID")); 
		String strContractStart		= nullToBlank(ds_input.getString(0, "CONTRACT_START")); 
		String strCustCD			= nullToBlank(ds_input.getString(0, "CUSTCD"));  
		
		if(conn != null && !conn.isClosed()) conn.close();
		
		conn = getIRISConn();
		
		stmt 		=  conn.createStatement();
	
	
		//out 데이타                                                                                                                                                                                        
		DataSet ds_list;                                                                                                                                                                                    
		                                                                                                                                                                                                    
		//sql문 버퍼생성                                                                                                                                                                                    
		StringBuffer sbSql = new StringBuffer();                                                                                                                                                            
        
		// 확정단가조회
		sbSql.delete(0, sbSql.length());
		sbSql.append("SELECT A.ITEM_CODE  --자재코드 \n");
		sbSql.append("     , B.ITEM_NAME  --자재명 \n");
		sbSql.append("     , B.ITEM_SIZE  --규격 \n");
		sbSql.append("     , B.PO_UOM     --단위 \n");
		sbSql.append("     , B.TAX_CODE   --과면세 \n");
		sbSql.append("     , B.KEEPING_TYPE --보관방법 \n");
		sbSql.append("     , B.MAKER        --제조원 \n");
		sbSql.append("     , B.ORIGIN_TYPE  --원산지 \n");
		sbSql.append("     , TO_CHAR(TO_DATE(C.CONTRACT_START,'YYYY-MM-DD'),'YYYY-MM-DD') AS CONTRACT_START  --기존개시일 \n");
		sbSql.append("     , TO_CHAR(TO_DATE(C.CONTRACT_END,'YYYY-MM-DD'),'YYYY-MM-DD') AS CONTRACT_END      --기존종료일 \n");
		sbSql.append("     , C.CONTRACT_PRICE                                                                --기존단가 \n");
		sbSql.append("     , A.CONTRACT_PRICE AS CONFIRM_PRICE                                               --확정가 \n");
		sbSql.append("     , A.CONTRACT_PRICE_M AS CONFIRM_PRICE_S                                               --확정가 \n");
		sbSql.append("     , DECODE(NVL(C.CONTRACT_PRICE,0),0,0,ROUND(((A.CONTRACT_PRICE/C.CONTRACT_PRICE)-1)*100,1)) AS CHANGE_RATE --변동율 \n");
		sbSql.append("  FROM PO_CUSTOM_ITEM K \n");
		sbSql.append("     ,(SELECT * FROM PO_CONTRACT_F A \n");
		sbSql.append("        WHERE A.CENTER_CODE = " + strCnterCode + " \n");
		sbSql.append("          AND A.CUSTCD      = " + strCustCD + " \n");
		sbSql.append("          AND A.CONTRACT_ID = '" + strContractID + "' \n");
		sbSql.append("          AND A.USE_YN      = 'Y') A \n");
		sbSql.append("     , PO_ITEM_MST B \n");
		sbSql.append("     ,(SELECT D.ITEM_CODE, D.CONTRACT_START, D.CONTRACT_END, D.CONTRACT_PRICE \n");
		sbSql.append("         FROM PO_CONTRACT_F D \n");
		sbSql.append("            ,(SELECT F.CENTER_CODE, F.CUSTCD, F.ITEM_CODE, MAX(F.CONTRACT_START) AS CONTRACT_START \n");
		sbSql.append("                FROM PO_CONTRACT_F F \n");
		sbSql.append("               WHERE F.CENTER_CODE    = " + strCnterCode + " \n");
		sbSql.append("                 AND F.CUSTCD         = " + strCustCD + " \n");
		sbSql.append("                 AND F.ITEM_CODE      > ' ' \n");
		sbSql.append("                 AND F.CONTRACT_START < '" + strContractStart + "' \n");
		sbSql.append("                 AND F.USE_YN         = 'Y' \n");
		sbSql.append("               GROUP BY F.CENTER_CODE, F.CUSTCD, F.ITEM_CODE) E \n");
		sbSql.append("        WHERE D.CENTER_CODE    = E.CENTER_CODE \n");
		sbSql.append("          AND D.CUSTCD         = E.CUSTCD \n");
		sbSql.append("          AND D.ITEM_CODE      = E.ITEM_CODE \n");
		sbSql.append("          AND D.CONTRACT_START = E.CONTRACT_START \n");
		sbSql.append("          AND D.USE_YN         = 'Y') C \n");
		sbSql.append(" WHERE K.ITEM_CODE   = A.ITEM_CODE(+) \n");
		sbSql.append("   AND K.ITEM_CODE   = B.ITEM_CODE \n");
		sbSql.append("   AND K.ITEM_CODE   = C.ITEM_CODE(+) \n");
		sbSql.append("   AND K.CENTER_UPJANG = " + strCnterCode + " \n");
		sbSql.append("   AND K.CUSTCD        = " + strCustCD + " \n");
		sbSql.append("   AND K.USE_TYPE      = '01' \n");
		
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