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
		
			String CENTER 		= in_vl.getString("CENTER");		
			String GBN 			= in_vl.getString("GBN");		
			String FROM 		= nullToBlank(in_vl.getString("FROM"));		
			String TO 			= nullToBlank(in_vl.getString("TO"));
			String g_CustCd		= nullToBlank(in_vl.getString("g_CustCd"));
			
		if(conn != null && !conn.isClosed()) conn.close();
		
		conn = getIRISConn();
		
		stmt 		=  conn.createStatement();
	
		DataSet ds_out;
		StringBuffer sbSql = new StringBuffer();
	
		sbSql.delete(0, sbSql.length());
		sbSql.append("SELECT TO_CHAR(TO_DATE(A.NEED_DATE,'YYYYMMDD'),'YYYY-MM-DD')	NEED_DATE                                 	\n");
		sbSql.append("     , TO_CHAR(TO_DATE(A.ORDER_DATE,'YYYYMMDD'),'YYYY-MM-DD')	ORDER_DATE                                	\n");
		sbSql.append("     , A.ORDER_NUM                                                                                        	\n");
		sbSql.append("     , REPLACE(B.UPJANGNM,'단체급식 ') || '(' || NVL(C.SUBINV_NAME,'비품부서입고') || ')' UPJANGNM        	\n");
		sbSql.append("     , A.ITEM_CODE                                                                                        	\n");
		sbSql.append("     , A.ITEM_NAME                                                                                        	\n");
		sbSql.append("     , A.ITEM_SIZE                                                                                        	\n");
		sbSql.append("     , A.PO_UOM                                                                                           	\n");
		sbSql.append("     , A.PO_QTY                                                                                           	\n");
		sbSql.append("     , (A.CENTER_DELI_QTY + A.DIRECT_DELI_QTY - A.DELIVERED_QTY - A.UNDELIVERED_QTY) QTY                  	\n");
		sbSql.append("     , A.UNIT_PRICE                                                                                       	\n");
		sbSql.append("     , (A.CENTER_DELI_QTY + A.DIRECT_DELI_QTY - A.DELIVERED_QTY - A.UNDELIVERED_QTY) * A.UNIT_PRICE AMT   	\n");
		sbSql.append("FROM PO_PO A, ST_UPJANG B, PO_SUBINVENTORY C                                                              	\n");
		sbSql.append("WHERE A.RC_UPJANG   = B.UPJANG                                                                            	\n");
		sbSql.append("   AND A.SUBINV_CODE = C.SUBINV_CODE(+)                                                                   	\n");
		if(GBN.equals("1"))
		{
			sbSql.append("   AND A.NEED_DATE BETWEEN '"+FROM+"' AND '"+TO+"' --[입고일]                                           	\n");
		}
		else{
			sbSql.append("   AND A.ORDER_DATE BETWEEN '"+FROM+"' AND '"+TO+"' --[입고일]                                        	\n");	
		}
		sbSql.append("   AND (A.CENTER_DELI_QTY + A.DIRECT_DELI_QTY - A.DELIVERED_QTY - A.UNDELIVERED_QTY) > 0                  	\n");
		sbSql.append("   AND A.LINE_STATUS BETWEEN '009' AND '010'                                                              	\n");
		sbSql.append("   AND A.CUSTCD = '"+g_CustCd+"'         --[g_CustCd]                                                         \n");
		if(!CENTER.equals(""))
		{
			sbSql.append("   AND A.CENTER_CODE = '"+CENTER+"'    --[물류센터권역.CENTER_CODE, 전체도 가능]                                \n");
		}
		
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