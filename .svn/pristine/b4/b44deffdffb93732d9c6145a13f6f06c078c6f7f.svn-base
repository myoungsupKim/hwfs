
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
        
		// 발주전체현황
		sbSql.delete(0, sbSql.length());
		sbSql.append("SELECT /*+ USE_HASH(AA) USE_HASH(V1) USE_HASH(V2) */ \n");
		sbSql.append("       A.ITEM_CODE, A.ITEM_NAME, DECODE(A.CENTER_FLAG,'N','예','아니오') AS CENTER_FLAG, A.ITEM_SIZE, A.PO_UOM \n");
		sbSql.append("     , A.KEEPING_TYPE \n");
		sbSql.append("     , REPLACE(A.UPJANGNM,'단체급식 ') || '(' || REPLACE(A.SUBINV_NAME,'식자재_') || ')' UPJANGNM \n");
		//함수 해체...
		//sbSql.append("     , PO_GETREGION_FUN(C.SHIP_ID,A.NEED_DATE) AS REGION_NAME \n");
		sbSql.append("     , CASE \n");
		sbSql.append("         WHEN V1.WMS_USE ='Y' THEN V2.ROUTE_NM \n");
        sbSql.append("         ELSE AA.REGION_NAME \n");
        sbSql.append("       END AS REGION_NAME \n");
		sbSql.append("     , A.PO_QTY, A.UNIT_PRICE \n");
		sbSql.append("     , A.PO_QTY * A.UNIT_PRICE AS GONG_PRICE \n");
		sbSql.append("     , DECODE(A.TAX_CODE,'100',ROUND(A.PO_QTY * A.UNIT_PRICE / 10,1),0) AS VAT \n");
		sbSql.append("     , (A.PO_QTY * A.UNIT_PRICE) + DECODE(A.TAX_CODE,'100',ROUND(A.PO_QTY * A.UNIT_PRICE / 10,1),0) AS TOTAL \n");
		sbSql.append("     , A.LINE_STATUS \n");
		sbSql.append("     , DECODE(NVL(A.ORDER_QTY, 0),0,A.PO_QTY,A.ORDER_QTY) AS BEFORE_PO_QTY \n");
		sbSql.append("  FROM ( \n");	
		sbSql.append("        SELECT /*+ USE_HASH(C) USE_HASH(B) USE_HASH(E) */ \n");
		sbSql.append("               A.ITEM_CODE, A.ITEM_NAME, A.CENTER_FLAG, A.ITEM_SIZE, A.PO_UOM, E.KEEPING_TYPE, B.UPJANGNM, C.SUBINV_NAME \n");
 		sbSql.append("             , A.PO_QTY, A.UNIT_PRICE, A.TAX_CODE,  A.LINE_STATUS, A.ORDER_QTY, C.SHIP_ID, A.NEED_DATE \n");
		sbSql.append("          FROM PO_PO A, ST_UPJANG B, PO_SUBINVENTORY C, PO_ITEM_MST E \n");
		sbSql.append("         WHERE A.RC_UPJANG = B.UPJANG \n");
		sbSql.append("           AND A.SUBINV_CODE = C.SUBINV_CODE(+) \n");
		sbSql.append("           AND A.ITEM_CODE = E.ITEM_CODE \n");
        if (!sType.equals("CancelOrd"))
        {	      	
		  sbSql.append("           AND A.LINE_STATUS >= '008' \n");
			if (sType.equals("ChangeOrd"))
			{
			  sbSql.append("           AND A.REORDER_SABUN IS NOT NULL \n");
			}
		}		
	    else	
		{
			sbSql.append("           AND A.LINE_STATUS = '005' \n");
			sbSql.append("           AND A.ORDER_NUM IS NOT NULL \n");
		}
		sbSql.append("           AND A.NEED_DATE BETWEEN '" + strFromDt + "' AND '" + strToDt + "' \n");
		sbSql.append("           AND A.CUSTCD = " + strCustCD + " \n");
		if (strCnterCode.length() != 0) 
			sbSql.append("           AND A.CENTER_CODE = '" + strCnterCode + "' \n");
		sbSql.append("       ) A \n");
	    sbSql.append("     , (SELECT /*+ USE_HASH(A) */ Y.SHIP_ID , A.WMS_USE         \n");
	    sbSql.append("          FROM PO_CENTER A,                                       \n");
	    sbSql.append("               PO_UPJANG_CENTER B,                                \n");
	    sbSql.append("               ST_UPJANG X,                                       \n");
	    sbSql.append("               PO_SHIPMENT Y                                      \n");
	    sbSql.append("         WHERE A.CENTER_CODE = B.CENTER_CODE                      \n");
	    sbSql.append("           AND B.UPJANG = X.AP_UNITPRICE_UPJANG                   \n");
	    sbSql.append("           AND X.UPJANG = Y.UPJANG                                \n");
	    sbSql.append("       ) V1,                                                      \n");
	    sbSql.append("       (SELECT A.SHIP_ID,                                         \n");
	    sbSql.append("               A.USEDATE_FROM,                                    \n");
	    sbSql.append("               A.USEDATE_TO,                                      \n");
	    sbSql.append("               MIN(A.ROUTE_CD) ROUTE_CD,                          \n");
	    sbSql.append("               MIN(A.ROUTE_NM) ROUTE_NM ,                         \n");
	    sbSql.append("               MIN(NVL(A.STOP_NUMBER, 1)) STOP_NUMBER             \n");
	    sbSql.append("          FROM PO_DELI_INFO A                                     \n");
	    sbSql.append("         WHERE A.DAY_GB = '00010' --평일배차기준(00010:평일/00020:휴일) \n");
	    sbSql.append("           AND A.TRANS_TYPE = '00010' --배송기준(00010:배송/00020:백홀) \n");
	    sbSql.append("         GROUP BY A.SHIP_ID,                                      \n");
	    sbSql.append("                  A.USEDATE_FROM,                                 \n");
	    sbSql.append("                  A.USEDATE_TO                                    \n");
	    sbSql.append("       ) V2,                                                      \n");
	    sbSql.append("       PO_REGION AA,                                              \n");
	    sbSql.append("       PO_UPJANG_DELIVERY BB,                                     \n");
	    sbSql.append("       PO_SHIPMENT CC                                             \n");
	    sbSql.append(" WHERE V1.SHIP_ID(+) = A.SHIP_ID                                \n");
	    sbSql.append("   AND V2.SHIP_ID(+) = A.SHIP_ID                                  \n");
	    sbSql.append("   AND A.NEED_DATE BETWEEN V2.USEDATE_FROM(+) AND V2.USEDATE_TO(+) \n");
	    sbSql.append("   AND AA.CENTER_CODE(+) = BB.CENTER_CODE                         \n");
	    sbSql.append("   AND AA.AREA_CODE(+) = BB.AREA_CODE                             \n");
	    sbSql.append("   AND AA.REGION_CODE(+) = BB.REGION_CODE                         \n");
	    sbSql.append("   AND BB.UPJANG(+) = CC.UPJANG                                   \n");
	    sbSql.append("   AND CC.SHIP_ID(+) = A.SHIP_ID                                  \n");
	    sbSql.append(" ORDER BY A.ITEM_CODE, A.UPJANGNM, A.SUBINV_NAME                  \n");

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