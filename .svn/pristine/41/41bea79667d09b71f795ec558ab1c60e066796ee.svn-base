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
		System.out.println(":::FSM00030E_S007====>:::");				
			String RECIPE_NAME 		= nullToBlank(in_vl.getString("RECIPE_NAME"));		
			String RECIPE_CLASS 	= nullToBlank(in_vl.getString("RECIPE_CLASS"));
			String RECIPE_TYPE 		= nullToBlank(in_vl.getString("RECIPE_TYPE"));
			String CUISINE_TYPE		= nullToBlank(in_vl.getString("CUISINE_TYPE"));
			String MAIN_ITEM_CODE1	= nullToBlank(in_vl.getString("MAIN_ITEM_CODE1"));
			String RESP_NUT1 		= nullToBlank(in_vl.getString("RESP_NUT1"));		
			String FROM_COST 		= nullToBlank(in_vl.getString("FROM_COST"));
			String TO_COST 			= nullToBlank(in_vl.getString("TO_COST"));
	
			
	//	if(conn != null && !conn.isClosed()) conn.close();
		
	//	conn = getIRISConn();
		
		stmt 		=  conn.createStatement();

		DataSet ds_out;
		StringBuffer sbSql = new StringBuffer();
		
		sbSql.delete(0, sbSql.length());
		sbSql.append("SELECT AA.* \n");
		sbSql.append("FROM \n");
		sbSql.append("( \n");
		sbSql.append("SELECT /*+ USE_HASH(A B C D) INDEX(A)*/ \n");
		sbSql.append("    A.RECIPE_CD, \n");
		sbSql.append("	A.RECIPE_NAME, \n");
		sbSql.append("	A.RECIPE_CLASS, \n");
		sbSql.append("	A.RECIPE_TYPE, \n");
		sbSql.append("	A.CUISINE_TYPE, \n");
		sbSql.append("	A.MAIN_ITEM_CODE1, \n");
		sbSql.append("	A.MAIN_ITEM_CODE2, \n");
		sbSql.append("	A.COOK_TOOL1, \n");
		sbSql.append("	A.COOK_TOOL2, \n");
		sbSql.append("	A.RECIPE_COLOR, \n");
		sbSql.append("	A.RECIPE_SHAPE, \n");
		sbSql.append("	A.RECIPE_TASTE, \n");
		sbSql.append("	A.RECIPE_FEEL, \n");
		sbSql.append("	A.RECIPE_TEMPER, \n");
		sbSql.append("	A.SPRING_YN, \n");
		sbSql.append("	A.SUMMER_YN, \n");
		sbSql.append("	A.AUTUMN_YN, \n");
		sbSql.append("	A.WINTER_YN, \n");
		sbSql.append("	A.RESP_NUT1, \n");
		sbSql.append("	A.RESP_NUT2, \n");
		sbSql.append("	A.USE_TOOL, \n");
		sbSql.append("	A.VALID_TIME, \n");
		sbSql.append("	A.DISPLAY_METHOD, \n");
		sbSql.append("	A.SALE_UOM, \n");
		sbSql.append("	A.SALE_PRICE, \n");
		sbSql.append("	A.COST_RATE, \n");
		sbSql.append("	A.CORE_TEMPER_YN, \n");
		sbSql.append("	A.GOODS_FEATURE, \n");
		sbSql.append("	A.PHF_MGMT1, \n");
		sbSql.append("	A.PHF_MGMT2, \n");
		sbSql.append("	A.PHF_MGMT3, \n");
		sbSql.append("	A.PHF_MGMT4, \n");
		sbSql.append("	A.PHF_MGMT5, \n");
		sbSql.append("	A.COOK_OPRN, \n");
		sbSql.append("	A.PHOTO_PATH, \n");
		sbSql.append("    A.SPHOTO_PATH, \n");
		sbSql.append("	A.USE_YN, \n");
		sbSql.append("	A.CUSER, \n");
		sbSql.append("    (SELECT NM_KOR FROM SCC_USERINFO X WHERE X.SABUN = A.CUSER) NM_KOR, \n");
		sbSql.append("	A.CDATE, \n");
		sbSql.append("	A.UUSER, \n");
		sbSql.append("	A.UDATE, \n");
		sbSql.append("    A.PHF, \n");
		sbSql.append("	SUM(ROUND(B.NEED_QTY * (NVL(C.MARGIN_PRICE,0) / D.KG_CONVERT_RATE / 1000) ) ) RECIPE_COST, \n");
		sbSql.append("    CASE WHEN MONTHS_BETWEEN(SYSDATE, TO_DATE(A.CDATE,'RRRR-MM-DD')) <= 1 THEN 1 ELSE 0 END DI_MON \n");
		sbSql.append("  FROM \n");
		sbSql.append("    FSR_STD_RECIPE_MST A , \n");
		sbSql.append("	FSR_STD_RECIPE_ITEM B , \n");
		sbSql.append("	FSI_STD_PRICE C , \n");
		sbSql.append("	HLDC_PO_ITEM_MST D \n");
		sbSql.append("  WHERE	A.RECIPE_CD = B.RECIPE_CD \n");
		sbSql.append("  AND B.ITEM_CODE = C.ITEM_CODE(+) \n");
		sbSql.append("  AND B.ITEM_CODE = D.ITEM_CODE \n");
		sbSql.append("  AND A.RECIPE_CLASS <> 'H' \n");
		if(!RECIPE_NAME.equals(""))
		{
		sbSql.append("  AND A.RECIPE_NAME LIKE '%'||'"+RECIPE_NAME+"'||'%' \n");
		}
		if(!RECIPE_CLASS.equals(""))
		{
		sbSql.append("  AND A.RECIPE_CLASS='"+RECIPE_CLASS+"' \n");
		}
		if(!RECIPE_TYPE.equals(""))
		{
		sbSql.append("  AND A.RECIPE_TYPE='"+RECIPE_TYPE+"' \n");
		}
		if(!CUISINE_TYPE.equals(""))
		{
		sbSql.append("  AND A.CUISINE_TYPE='"+CUISINE_TYPE+"' \n");
		}
		if(!MAIN_ITEM_CODE1.equals(""))
		{
		sbSql.append("  AND A.MAIN_ITEM_CODE1 ='"+MAIN_ITEM_CODE1+"' \n");
		}
		if(!RESP_NUT1.equals(""))
		{
		sbSql.append("  AND A.RESP_NUT1 ='"+RESP_NUT1+"' \n");
		}
		sbSql.append(" GROUP BY A.RECIPE_CD, \n");
		sbSql.append("	A.RECIPE_NAME, \n");
		sbSql.append("	A.RECIPE_CLASS, \n");
		sbSql.append("	A.RECIPE_TYPE, \n");
		sbSql.append("	A.CUISINE_TYPE, \n");
		sbSql.append("	A.MAIN_ITEM_CODE1, \n");
		sbSql.append("	A.MAIN_ITEM_CODE2, \n");
		sbSql.append("	A.COOK_TOOL1, \n");
		sbSql.append("	A.COOK_TOOL2, \n");
		sbSql.append("	A.RECIPE_COLOR, \n");
		sbSql.append("	A.RECIPE_SHAPE, \n");
		sbSql.append("	A.RECIPE_TASTE, \n");
		sbSql.append("	A.RECIPE_FEEL, \n");
		sbSql.append("	A.RECIPE_TEMPER, \n");
		sbSql.append("	A.SPRING_YN, \n");
		sbSql.append("	A.SUMMER_YN, \n");
		sbSql.append("	A.AUTUMN_YN, \n");
		sbSql.append("	A.WINTER_YN, \n");
		sbSql.append("	A.RESP_NUT1, \n");
		sbSql.append("	A.RESP_NUT2, \n");
		sbSql.append("	A.USE_TOOL, \n");
		sbSql.append("	A.VALID_TIME, \n");
		sbSql.append("	A.DISPLAY_METHOD, \n");
		sbSql.append("	A.SALE_UOM, \n");
		sbSql.append("	A.SALE_PRICE, \n");
		sbSql.append("	A.COST_RATE, \n");
		sbSql.append("	A.CORE_TEMPER_YN, \n");
		sbSql.append("	A.GOODS_FEATURE, \n");
		sbSql.append("	A.PHF_MGMT1, \n");
		sbSql.append("	A.PHF_MGMT2, \n");
		sbSql.append("	A.PHF_MGMT3, \n");
		sbSql.append("	A.PHF_MGMT4, \n");
		sbSql.append("	A.PHF_MGMT5, \n");
		sbSql.append("	A.COOK_OPRN, \n");
		sbSql.append("	A.PHOTO_PATH, \n");
		sbSql.append("    A.SPHOTO_PATH, \n");
		sbSql.append("	A.USE_YN, \n");
		sbSql.append("	A.ATTR01, \n");
		sbSql.append("	A.ATTR02, \n");
		sbSql.append("	A.ATTR03, \n");
		sbSql.append("	A.ATTR04, \n");
		sbSql.append("	A.ATTR05, \n");
		sbSql.append("	A.ATTR06, \n");
		sbSql.append("	A.ATTR07, \n");
		sbSql.append("	A.ATTR08, \n");
		sbSql.append("	A.ATTR09, \n");
		sbSql.append("	A.ATTR10, \n");
		sbSql.append("	A.CUSER, \n");
		sbSql.append("	A.CDATE, \n");
		sbSql.append("	A.UUSER, \n");
		sbSql.append("    A.UDATE, \n");
		sbSql.append("    A.PHF \n");
		sbSql.append(") AA \n");
		sbSql.append("WHERE 1=1 \n");
		if(!FROM_COST.equals(""))
		{
		sbSql.append("  AND AA.RECIPE_COST  >= "+FROM_COST+" \n");
		}
		if(!TO_COST.equals(""))
		{
		sbSql.append("  AND AA.RECIPE_COST <= "+TO_COST+" \n");
		}
		
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery();
		
		//this.makeDataSet(rs,"output").dump();
		DataSet ds_List = this.makeDataSet(rs,"ds_List");
		out_dl.add(ds_List);
	//	System.out.println(":::FSM00030E_S007====>::: Result DS RowCount="+ds_out.getRowCount());
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
		proc_output(response,out,out_vl,out_dl);
	}
%>