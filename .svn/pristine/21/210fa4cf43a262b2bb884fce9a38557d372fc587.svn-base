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
		String FROM 		= nullToBlank(in_vl.getString("FROM"));		
		String g_CustCd		= nullToBlank(in_vl.getString("g_CustCd"));
			
		if(conn != null && !conn.isClosed()) conn.close();
		
		conn = getIRISConn();
		
		stmt 		=  conn.createStatement();
	
		DataSet ds_out;
		StringBuffer sbSql = new StringBuffer();
	
		sbSql.delete(0, sbSql.length());
		sbSql.append("SELECT ROWNUM SEQ,																\n");
		sbSql.append("		A.NEED_DATE,																\n");
		sbSql.append("		REPLACE(C.UPJANGNM, '단체급식 ' ) UPJANGNM,									\n");
		sbSql.append("		A.ITEM_CODE,																\n");
		sbSql.append("		A.ITEM_NAME,																\n");
		sbSql.append("		A.ITEM_SIZE,																\n");
		sbSql.append("		A.PO_UOM,																	\n");
		sbSql.append("		A.CENTER_UNDELI_QTY,														\n");
		sbSql.append("		A.DIRECT_DELI_QTY,															\n");
		sbSql.append("		B.REMARK||' '||E.UNDELI_REASON												\n");
		sbSql.append("FROM PO_PO A, PO_CLAIM B, ST_UPJANG C ,PO_CENTER D                                \n");
		sbSql.append("   , PO_CENTER_UNDELI E                                \n");
		sbSql.append("WHERE A.RC_UPJANG   = C.UPJANG                                                    \n");
		sbSql.append("   AND A.CENTER_CODE = D.CENTER_CODE												\n");
		sbSql.append("   AND A.PO_ID = B.PO_ID(+)														\n");
		sbSql.append("   AND A.PO_ID = E.PO_ID(+)														\n");
		sbSql.append("   AND A.NEED_DATE = '"+FROM+"'  --[입고일]  										\n");
		sbSql.append("   AND A.CUSTCD    = '"+g_CustCd+"'         --[g_CustCd] 							\n");
		if(!CENTER.equals(""))
		{
			sbSql.append("   AND A.CENTER_CODE = '"+CENTER+"'    --[물류센터권역.CENTER_CODE, 전체도 가능]   \n");
		}
		sbSql.append("   AND A.CENTER_UNDELI_QTY > 0													\n");
		sbSql.append("   AND A.CENTER_FLAG = 'Y'														\n");
		sbSql.append(" ORDER BY C.UPJANGNM, A.ITEM_NAME														\n");		
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