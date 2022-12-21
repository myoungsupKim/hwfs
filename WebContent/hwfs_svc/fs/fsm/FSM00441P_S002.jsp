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
						
		String MENU_CD 		= nullToBlank(in_vl.getString("MENU_CD"));
		String UPJANG 		= nullToBlank(in_vl.getString("UPJANG"));
			
	//	if(conn != null && !conn.isClosed()) conn.close();
		
	//	conn = getIRISConn();
		
		stmt 		=  conn.createStatement();
	
		DataSet ds_out;
		StringBuffer sbSql = new StringBuffer();
	
		sbSql.delete(0, sbSql.length());
 		sbSql.append("SELECT BB.RECIPE_NAME,                                                                                                  	\n");
		sbSql.append("       BB.ITEM_NAME,                                                                                                     \n");
		sbSql.append("       BB.ITEM_COST,                                                                                                    	\n");
		sbSql.append("       BB.NEED_QTY,                                                                                                     	\n");
		sbSql.append("       CC.COSTSUM                                                                                                       	\n");
		sbSql.append("FROM                                                                                                                    	\n");
		sbSql.append("(                                                                                                                       	\n");
		sbSql.append("    SELECT A.RECIPE_NAME                                                                                                	\n");
		sbSql.append("         , C.ITEM_NAME                                                                                                  	\n");
		sbSql.append("         , ROUND(B.NEED_QTY*(B.MARGIN_PRICE/C.KG_CONVERT_RATE/1000),1) ITEM_COST   --재무일경우 B.UNIT_PRICE 사용       	\n");
		sbSql.append("         , B.NEED_QTY                                                                                                   	\n");
		sbSql.append("      FROM FSM_REAL_RECIPE_MST A                                                                                        	\n");
		sbSql.append("         , FSM_REAL_RECIPE_ITEM B                                                                                        \n");
		sbSql.append("         , HLDC_PO_ITEM_MST C                                                                                        \n");
		sbSql.append("     WHERE A.UPJANG = B.UPJANG                                                                                          	\n");
 		sbSql.append("       AND A.MENU_CD = B.MENU_CD                                                                                        	\n");
		sbSql.append("       AND A.RECIPE_CD = B.RECIPE_CD                                                                                     \n");
		sbSql.append("       AND B.ITEM_CODE = C.ITEM_CODE                                                                                    	\n");
		sbSql.append("       AND A.UPJANG = "+UPJANG+"                                                                                            	\n");
		sbSql.append("       AND A.MENU_CD = '"+MENU_CD+"'                                                                           	\n");
		sbSql.append("     ORDER BY A.RECIPE_CD, A.RECIPE_NAME, NEED_QTY DESC                                                                 	\n");
		sbSql.append(") BB,                                                                                                                   	\n");
		sbSql.append("(                                                                                                                       	\n");
		sbSql.append("    SELECT A.RECIPE_NAME,SUM(ITEM_COST) COSTSUM                                                                         	\n");
		sbSql.append("    FROM                                                                                                                	\n");
		sbSql.append("    (                                                                                                                   	\n");
		sbSql.append("        SELECT A.RECIPE_NAME                                                                                            	\n");
		sbSql.append("             , '' --레시피원가는 합계로 구함                                                                             \n");
		sbSql.append("             , C.ITEM_NAME                                                                                           \n");
		sbSql.append("             , ROUND(B.NEED_QTY*(B.MARGIN_PRICE/C.KG_CONVERT_RATE/1000),1) ITEM_COST   --재무일경우 B.UNIT_PRICE 사용   	\n");
 		sbSql.append("             , B.NEED_QTY                                                                                               	\n");
		sbSql.append("          FROM FSM_REAL_RECIPE_MST A                                                                                     \n");
		sbSql.append("             , FSM_REAL_RECIPE_ITEM B                                                                                   	\n");
		sbSql.append("             , HLDC_PO_ITEM_MST C                                                                                       	\n");
		sbSql.append("         WHERE A.UPJANG = B.UPJANG                                                                                      	\n");
		sbSql.append("           AND A.MENU_CD = B.MENU_CD                                                                                    	\n");
		sbSql.append("           AND A.RECIPE_CD = B.RECIPE_CD                                                                                	\n");
		sbSql.append("           AND B.ITEM_CODE = C.ITEM_CODE                                                                                	\n");
		sbSql.append("           AND A.UPJANG = "+UPJANG+"                                                                                        	\n");
		sbSql.append("           AND A.MENU_CD = '"+MENU_CD+"'                                                                       	\n");
		sbSql.append("         ORDER BY A.RECIPE_CD, A.RECIPE_NAME, NEED_QTY DESC                                                             	\n");
		sbSql.append("    ) A                                                                                                                 	\n");
		sbSql.append("    GROUP BY A.RECIPE_NAME                                                                                               \n");
		sbSql.append(") CC                                                                                                                 \n");
		sbSql.append("WHERE BB.RECIPE_NAME = CC.RECIPE_NAME(+)                                                                                	\n");		
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 

		DataSet ds_PopDiv = this.makeDataSet(rs,"ds_PopDiv");
		out_dl.add(ds_PopDiv);

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