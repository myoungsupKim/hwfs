
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
		
		//String sType     		= nullToBlank(ds_input.getString(0, "STYPE")); 
		
		String sType            = nullToBlank(in_vl.getString("sType"));
			
		if(conn != null && !conn.isClosed()) conn.close();
		
		conn = getIRISConn();
		
		stmt 		=  conn.createStatement();
	
	
		//out 데이타                                                                                                                                                                                        
		DataSet ds_list;                                                                                                                                                                                    
		                                                                                                                                                                                                    
		//sql문 버퍼생성                                                                                                                                                                                    
		StringBuffer sbSql = new StringBuffer();                                                                                                                                                            
        
		// 예정(전체)발주현황
		sbSql.delete(0, sbSql.length());
        sbSql.append("SELECT /*+ LEADING(A) USE_HASH(F) */ F.CENTER_NAME                                                                                                 \n");
        sbSql.append("     , A.ITEM_CODE, A.ITEM_NAME, DECODE(A.CENTER_FLAG,'N','예','아니오') AS CENTER_FLAG, A.ITEM_SIZE, A.PO_UOM         \n");
        sbSql.append("     , E.KEEPING_TYPE                                                                                                \n");
        sbSql.append("     , REPLACE(B.UPJANGNM,'단체급식 ') || '(' || REPLACE(C.SUBINV_NAME,'식자재_') || ')' UPJANGNM                       \n");
        sbSql.append("     , PO_GETREGION_FUN(C.SHIP_ID,A.NEED_DATE) AS REGION_NAME                                                        \n");
        sbSql.append("     , A.LINE_STATUS                                                                                                 \n");
        sbSql.append("     , A.PR_QTY                                                                                                      \n");
        sbSql.append("     , A.ORDER_QTY                                                                                                   \n");
        sbSql.append("     , A.PO_QTY                                                                                                      \n");
        sbSql.append("     , DECODE(A.LINE_STATUS, '예정', 0, TO_NUMBER(A.PO_QTY) - TO_NUMBER(A.PR_QTY)) AS CHK_QTY                                                                               \n");
        sbSql.append("     , A.UNIT_PRICE                                                                                                  \n");
        sbSql.append("     , A.PO_QTY * A.UNIT_PRICE AS GONG_PRICE                                                                         \n");
        sbSql.append("     , DECODE(A.TAX_CODE,'100',ROUND(A.PO_QTY * A.UNIT_PRICE / 10,1),0) AS VAT                                       \n");
        sbSql.append("     , (A.PO_QTY * A.UNIT_PRICE) + DECODE(A.TAX_CODE,'100',ROUND(A.PO_QTY * A.UNIT_PRICE / 10,1),0) AS TOTAL         \n");
        sbSql.append("  FROM (SELECT /*+ INDEX(Z PO_PR_I5) */ Z.CENTER_CODE, Z.ITEM_CODE, Z.ITEM_NAME, Z.CENTER_FLAG, Z.ITEM_SIZE, Z.PO_UOM                         \n");
        sbSql.append("             , Z.NEED_DATE, Z.SUBINV_CODE, Z.TAX_CODE, Z.RC_UPJANG, NVL(Y.UNIT_PRICE, 0) AS UNIT_PRICE               \n");
        sbSql.append("             , Z.PR_QTY                                                                                              \n");
        sbSql.append("             , DECODE(SIGN(TO_NUMBER(Z.LINE_STATUS) -5), 1, DECODE(NVL(Y.ORDER_QTY, 0),0,Y.PO_QTY,Y.ORDER_QTY), 0) AS ORDER_QTY \n");
        sbSql.append("             , DECODE(SIGN(TO_NUMBER(Z.LINE_STATUS) -5), 1, Y.PO_QTY, 0) AS PO_QTY                                   \n");
        sbSql.append("             , DECODE(SIGN(TO_NUMBER(Z.LINE_STATUS) -5), -1, '예정', 0, '취소', '정상') AS LINE_STATUS                 \n");
        sbSql.append("          FROM PO_PR Z, PO_PO Y                                                                                      \n");
        sbSql.append("         WHERE Z.PR_ID = Y.PR_ID(+)                                                                                  \n");
        sbSql.append("           AND Z.LINE_STATUS >= '004'                                                                                \n");
        if (sType.equals("PoCancel"))
        {
        	sbSql.append("           AND Z.LINE_STATUS <> '005'                                                                                 \n");
        }
        sbSql.append("           AND Z.NEED_DATE BETWEEN '" + strFromDt + "' AND '" + strToDt + "'                                         \n");
        sbSql.append("           AND Z.CUSTCD = " + strCustCD + "                                                                          \n");
        if (strCnterCode.length() != 0) 
          sbSql.append("           AND Z.CENTER_CODE = '" + strCnterCode + "'                                                                  \n");
        sbSql.append("       )A                                                                                                            \n");
        sbSql.append("     , ST_UPJANG B                                                                                                   \n");
        sbSql.append("     , PO_SUBINVENTORY C                                                                                             \n");
        sbSql.append("     , PO_ITEM_MST E                                                                                                 \n");
        sbSql.append("     , PO_CENTER F                                                                                                   \n");
        sbSql.append(" WHERE A.RC_UPJANG = B.UPJANG                                                                                        \n");
        sbSql.append("   AND A.SUBINV_CODE = C.SUBINV_CODE(+)                                                                              \n");
        sbSql.append("   AND A.ITEM_CODE = E.ITEM_CODE                                                                                     \n");
        sbSql.append("   AND A.CENTER_CODE = F.CENTER_CODE                                                                                 \n");
        sbSql.append(" ORDER BY A.ITEM_CODE, B.UPJANGNM, C.SUBINV_NAME                                                                     \n");
		
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