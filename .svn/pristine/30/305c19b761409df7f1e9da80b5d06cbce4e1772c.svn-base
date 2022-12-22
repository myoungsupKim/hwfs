<%@page import="com.sz.util.AppDataUtility"%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	Statement stmt             =  null;
	try {
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
	//	String v_EmpNo 		= in_vl.getString("g_EmpNo");	
	//	DataSet in_ds  =  in_dl.get("ds_Input");
	//	String sCode = in_ds.getString(0, "CD");
				
		String CENTER 		= nullToBlank(in_vl.getString("CENTER"));		
		String FROM 		= nullToBlank(in_vl.getString("FROM"));		
		String TO 			= nullToBlank(in_vl.getString("TO"));
		String GBN 			= nullToBlank(in_vl.getString("GBN"));
		String g_CustCd		= nullToBlank(in_vl.getString("g_CustCd"));
			
		if(conn != null && !conn.isClosed()) conn.close();
		
		conn = getIRISConn();
		
		stmt 		=  conn.createStatement();
	
		DataSet ds_out;
		StringBuffer sbSql = new StringBuffer();
	
		sbSql.delete(0, sbSql.length());
		sbSql.append(" SELECT A.NEED_DATE,                                                         	\n");
		sbSql.append("        REPLACE(B.UPJANGNM,'단체급식 ') UPJANGNM,                                  		\n");
		sbSql.append("        C.SUBINV_NAME,                                                             	\n");
		sbSql.append("        A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM,                           	\n");
		sbSql.append("        DECODE(A.TAX_CODE,'100','과세','210','면세','220','영세') TAX,             		\n");
		sbSql.append("        ROUND(A.UNIT_PRICE,1) UNIT_PRICE,                                            	\n");
		sbSql.append("        ROUND(SUM(A.PO_QTY),1) AS PO_QTY,                                            	\n");
		sbSql.append("        ROUND(SUM(A.PO_QTY * A.UNIT_PRICE),1) AS PO_AMT,                             	\n");
		sbSql.append("        ROUND(SUM(A.CENTER_UNDELI_QTY),1) AS CENTER_UNDELI_QTY,                      	\n");
		sbSql.append("        ROUND(SUM(A.CENTER_UNDELI_QTY * A.UNIT_PRICE),1) AS CENTER_UNDELI_AMT,       	\n");
		sbSql.append("        ROUND(SUM(A.UNDELIVERED_QTY),1) AS UNDELIVERED_QTY,                          	\n");
		sbSql.append("        ROUND(SUM(A.UNDELIVERED_QTY*A.UNIT_PRICE),1) AS UNDELIVERED_AMT,             	\n");
		sbSql.append("        ROUND(SUM(ABS(A.TRANS_QTY)),1) AS RETURN_QTY,                                	\n");
		sbSql.append("        ROUND(SUM(ABS(A.TRANS_QTY)*A.UNIT_PRICE),1) AS RETURN_AMT,                    	\n");
		sbSql.append("        ROUND(SUM(ABS(A.DELIVERED_QTY)),1) AS DELIVERED_QTY, 		                   	\n");
		sbSql.append("        ROUND(SUM(ABS(A.DELIVERED_QTY)*A.UNIT_PRICE),1) AS DELIVERED_AMT            	\n");
		sbSql.append(" FROM    (                                                                         	\n");
		sbSql.append("         SELECT /*+ INDEX(PO_PO PO_PO_I8) */                        	\n");
		sbSql.append("                RC_UPJANG, SUBINV_CODE, NEED_DATE, TAX_CODE,                      	\n");
		sbSql.append("                ITEM_CODE, ITEM_NAME,   ITEM_SIZE, PO_UOM, UNIT_PRICE,             	\n");
		sbSql.append("                SUM(PO_QTY) AS PO_QTY,                                             	\n");
		sbSql.append("                SUM(CENTER_UNDELI_QTY) AS CENTER_UNDELI_QTY,                       	\n");
		sbSql.append("                SUM(UNDELIVERED_QTY) AS UNDELIVERED_QTY,                           	\n");
		sbSql.append("                0 AS TRANS_QTY,                                                     	\n");
		sbSql.append("                SUM(DELIVERED_QTY) AS DELIVERED_QTY                                   \n");
		sbSql.append("         FROM   PO_PO                                                              	\n");
		sbSql.append("         WHERE  NEED_DATE   BETWEEN '"+FROM+"' AND '"+TO+"' --[입고일]           		\n");
		sbSql.append("         AND    CUSTCD = "+g_CustCd+"         --[g_CustCd]                            \n");
		if(!CENTER.equals(""))
		{
			sbSql.append("         AND    CENTER_CODE = "+CENTER+"    --[물류센터권역.CENTER_CODE, 전체도 가능]  \n");
		}
		if(GBN.equals("1"))
		{
			sbSql.append("--if 콤보값 =1                                                                		\n");
			sbSql.append(" AND    ITEM_CODE LIKE '01%'                                                      \n");			
		} else if(GBN.equals("2"))
		{
			sbSql.append("--if 콤보값 = 2                                                                		\n");
			sbSql.append(" AND    ITEM_CODE BETWEEN '020000000000' AND '039999999999'                     \n");				
		} else if(GBN.equals("4"))
		{
			sbSql.append("--if 콤보값 = 4                                                                		\n");
			sbSql.append(" AND    ITEM_CODE BETWEEN '040000000000' AND '059999999999'                     \n");			
		} else if(GBN.equals("6"))
		{
			sbSql.append("--if 콤보값 = 6                                                                		\n");
			sbSql.append(" AND    ITEM_CODE LIKE '06%'                                                    \n");			
		}
		sbSql.append("         GROUP BY RC_UPJANG, SUBINV_CODE, NEED_DATE, TAX_CODE,                     	\n");
		sbSql.append("                  ITEM_CODE, ITEM_NAME,   ITEM_SIZE, PO_UOM, UNIT_PRICE            	\n");
		sbSql.append("         HAVING NVL(SUM(CENTER_UNDELI_QTY),0) + NVL(SUM(UNDELIVERED_QTY),0) > 0    	\n");
		sbSql.append("         UNION ALL                                                                 	\n");
		sbSql.append("         SELECT TRANS_UPJANG, SUBINV_CODE, TRANS_DATE, TAX_CODE,                   	\n");
		sbSql.append("                ITEM_CODE, ITEM_NAME, ITEM_SIZE, TRANS_UOM,                        	\n");
		sbSql.append("                TRANS_UPRICE,                                                      	\n");
		sbSql.append("                0, 0, 0,                                                           	\n");
		sbSql.append("                SUM(TRANS_QTY) AS TRANS_QTY,                                        	\n");
		sbSql.append("                0 AS DELIVERED_QTY                                        			\n");
		sbSql.append("         FROM   PO_TRANSACTION                                                     	\n");
		sbSql.append("         WHERE  TRANS_DATE   BETWEEN '"+FROM+"' AND '"+TO+"' --[입고일]          		\n");
		sbSql.append("         AND    TRANS_TYPE   = 'I001'                                              	\n");
		sbSql.append("         AND    TRANS_QTY    < 0                                                   	\n");
		sbSql.append("         AND    CUSTCD = "+g_CustCd+"         --[g_CustCd]                           	\n");
		if(!CENTER.equals(""))
		{
			sbSql.append("         AND    CENTER_CODE = "+CENTER+"    --[물류센터권역.CENTER_CODE, 전체도 가능]  \n");
		}		
		if(GBN.equals("1"))
		{
			sbSql.append("--if 콤보값 =1                                                                		\n");
			sbSql.append(" AND    ITEM_CODE LIKE '01%'                                                      \n");			
		} else if(GBN.equals("2"))
		{ 
			sbSql.append("--if 콤보값 = 2                                                                		\n");
			sbSql.append(" AND    ITEM_CODE BETWEEN '020000000000' AND '039999999999'                     \n");				
		} else if(GBN.equals("4"))
		{
			sbSql.append("--if 콤보값 = 4                                                                		\n");
			sbSql.append(" AND    ITEM_CODE BETWEEN '040000000000' AND '059999999999'                     \n");			
		} else if(GBN.equals("6"))
		{
			sbSql.append("--if 콤보값 = 6                                                                		\n");
			sbSql.append(" AND    ITEM_CODE LIKE '06%'                                                    \n");			
		}
		sbSql.append("         GROUP BY TRANS_UPJANG, SUBINV_CODE, TRANS_DATE, TAX_CODE,                 	\n");
		sbSql.append("                  ITEM_CODE, ITEM_NAME, ITEM_SIZE, TRANS_UOM, TRANS_UPRICE         	\n");
		sbSql.append("        ) A,                                                                       	\n");
		sbSql.append("        ST_UPJANG B,                                                               	\n");
		sbSql.append("        PO_SUBINVENTORY C                                                          	\n");
		sbSql.append(" WHERE  A.RC_UPJANG   = B.UPJANG                                                   	\n");
		sbSql.append(" AND    A.SUBINV_CODE = C.SUBINV_CODE(+)                                           	\n");
		sbSql.append(" GROUP BY A.NEED_DATE, B.UPJANGNM, C.SUBINV_NAME, A.TAX_CODE,                      	\n");
		sbSql.append("          A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM, A.UNIT_PRICE            	\n");
		
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 

		DataSet ds_List = this.makeDataSet(rs,"ds_List");
		out_dl.add(ds_List);

	   	this.setResultMessage(0, "OK",out_vl);
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