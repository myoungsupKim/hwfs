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
						
		String HALL_CD 		= nullToBlank(in_vl.getString("HALL_CD"));
		String UPJANG 		= nullToBlank(in_vl.getString("UPJANG"));
		String FROM			= nullToBlank(in_vl.getString("FROM"));
		String TO			= nullToBlank(in_vl.getString("TO"));
	
			
	//	if(conn != null && !conn.isClosed()) conn.close();
		
	//	conn = getIRISConn();
		
		stmt 		=  conn.createStatement();
	
		DataSet ds_out;
		StringBuffer sbSql = new StringBuffer();
	
		sbSql.delete(0, sbSql.length());

		sbSql.append("SELECT \n");
		sbSql.append("       A.UPJANG \n");
		sbSql.append("     , A.MENU_CD \n");
		sbSql.append("     , SUBSTR(A.MENU_DATE,7,8) MENU_DATE \n");
		sbSql.append("     , (SELECT CODE_NAME FROM SCC_COMMON_CODE X WHERE X.GROUP_CODE = 'FS0023' AND X.CODE = A.MEAL) MEAL_NAME \n");
		sbSql.append("     , (SELECT CODE_NAME FROM SCC_COMMON_CODE X WHERE X.GROUP_CODE = 'FS0022' AND X.CODE = A.CORNER) CORNER_NAME \n");
		sbSql.append("     , A.MENU_FEATURE \n");
		sbSql.append("     , A.SALE_PRICE \n");
		sbSql.append("     , A.EXPECT_MEAL_QTY \n");
		sbSql.append("     , SUM(A.SALE_COST) SALE_COST \n");
		sbSql.append("     , TO_CHAR(ROUND( \n");
		sbSql.append("       DECODE(CAFE_YN,'Y',DECODE(SUM(EXPECT_SALE),0,0,SUM(EXPECT_COST)/SUM(EXPECT_SALE)) \n");
		sbSql.append("             ,DECODE(CATER_YN,'Y',DECODE((A.EXPECT_MEAL_QTY*A.SALE_PRICE),0,0,SUM(EXPECT_COST)/(A.EXPECT_MEAL_QTY*A.SALE_PRICE)) \n");
		sbSql.append("             ,DECODE(A.SALE_PRICE,0,0,SUM(A.SALE_COST)/A.SALE_PRICE) ) \n");
		sbSql.append("       )*100 \n");
		sbSql.append("       ,1)) || '%' COST_RATIO \n");
		sbSql.append("     , FSM_REAL_RECIPE_NAME_FUN(A.UPJANG, A.MENU_CD, 'FSM_REAL_RECIPE_MST') AS MENU_INFO \n");
		sbSql.append("  FROM \n");
		sbSql.append("    ( \n");
		sbSql.append("      SELECT A.UPJANG \n");
		sbSql.append("         , A.MENU_CD \n");
		sbSql.append("         , A.MEAL \n");
		sbSql.append("         , A.CORNER \n");
		sbSql.append("         , A.MENU_DATE \n");
		sbSql.append("         , A.MENU_FEATURE \n");
		sbSql.append("         , A.SALE_PRICE \n");
		sbSql.append("         , A.EXPECT_MEAL_QTY \n");
		sbSql.append("         , D.RECIPE_CD \n");
		sbSql.append("         , E.CAFE_YN \n");
		sbSql.append("         , E.CATER_YN \n");
		sbSql.append("         , ROUND(SUM(B.NEED_QTY*ROUND((B.MARGIN_PRICE/C.KG_CONVERT_RATE/1000),2))) AS SALE_COST \n");
		sbSql.append("         , AVG(DECODE(E.CAFE_YN,'Y', D.EXPECT_SALE_QTY*D.SALE_PRICE,0)) EXPECT_SALE \n");
		sbSql.append("         , SUM(B.NEED_QTY*DECODE(E.CAFE_YN,'Y',D.EXPECT_SALE_QTY,DECODE(E.CATER_YN,'Y',D.EXPECT_SALE_QTY,0))*ROUND((B.MARGIN_PRICE/C.KG_CONVERT_RATE/1000),2)) EXPECT_COST \n");
		sbSql.append("      FROM FSM_REAL_MENU_MST A \n");
		sbSql.append("         , FSM_REAL_RECIPE_ITEM B \n");
		sbSql.append("         , HLDC_PO_ITEM_MST C \n");
		sbSql.append("         , FSM_REAL_RECIPE_MST D \n");
		sbSql.append("         , FSA_HALL_MST E \n");
		sbSql.append("     WHERE A.UPJANG = D.UPJANG \n");
		sbSql.append("       AND A.MENU_CD = D.MENU_CD \n");
		sbSql.append("       AND D.UPJANG = B.UPJANG \n");
		sbSql.append("       AND D.MENU_CD = B.MENU_CD \n");
		sbSql.append("       AND D.RECIPE_CD = B.RECIPE_CD \n");
		sbSql.append("       AND A.UPJANG = E.UPJANG \n");
		sbSql.append("       AND A.HALL_CD = E.HALL_CD \n");
		sbSql.append("       AND B.ITEM_CODE = C.ITEM_CODE \n");
		sbSql.append("       AND A.UPJANG = "+UPJANG+" \n");
		sbSql.append("       AND A.HALL_CD = '"+HALL_CD+"' \n");
		sbSql.append("       AND A.MENU_DATE BETWEEN '"+FROM+"' AND '"+TO+"' \n");
		sbSql.append("     GROUP BY A.UPJANG \n");
		sbSql.append("            , A.MENU_CD \n");
		sbSql.append("            , A.MENU_DATE \n");
		sbSql.append("            , A.MEAL \n");
		sbSql.append("            , A.CORNER \n");
		sbSql.append("            , A.MENU_FEATURE \n");
		sbSql.append("            , A.SALE_PRICE \n");
		sbSql.append("            , A.EXPECT_MEAL_QTY \n");
		sbSql.append("            , D.RECIPE_CD \n");
		sbSql.append("            , E.CAFE_YN \n");
		sbSql.append("            , E.CATER_YN \n");
		sbSql.append("    ) A \n");
		sbSql.append(" GROUP BY A.UPJANG \n");
		sbSql.append("        , A.MENU_CD \n");
		sbSql.append("        , A.MENU_DATE \n");
		sbSql.append("        , A.MEAL \n");
		sbSql.append("        , A.CORNER \n");
		sbSql.append("        , A.MENU_FEATURE \n");
		sbSql.append("        , A.SALE_PRICE \n");
		sbSql.append("        , A.EXPECT_MEAL_QTY \n");
		sbSql.append("        , A.CAFE_YN \n");
		sbSql.append("        , A.CATER_YN \n");
		
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 

		DataSet ds_PopList = this.makeDataSet(rs,"ds_PopList");
		out_dl.add(ds_PopList);

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