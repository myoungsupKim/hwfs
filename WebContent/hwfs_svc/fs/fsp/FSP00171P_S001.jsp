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
		DataSet in_ds  =  in_dl.get("ds_Input");
		
		String sCode = in_ds.getString(0, "CD");
		String sName = in_ds.getString(0, "NM");
		String g_EmpNo = in_ds.getString(0, "g_EmpNo");
	
		
		// 사원번호 들어 오는지 찍어보자
		//System.out.println("=============\n g_EmpNo: "+g_EmpNo+"\n");
		
		if(conn != null && !conn.isClosed()) conn.close();
		
		conn = getIRISConn();
		
		stmt 		=  conn.createStatement();
	
		DataSet ds_out;
		StringBuffer sbSql = new StringBuffer();
	
		sbSql.delete(0, sbSql.length());
		sbSql.append("\nSELECT A.SUBINV_CODE CD,A.SUBINV_NAME CD_NM,");
		sbSql.append("\n	   DECODE(A.USE_YN, 'N' , '폐장' )||A.SUBINV_CODE||' '||A.SUBINV_NAME||' ( '|| REPLACE(B.UPJANGNM,'단체급식 ')||' ) ' NM");
		sbSql.append("\n  FROM PO_SUBINVENTORY A,");
		sbSql.append("\n	   ST_UPJANG B");
		sbSql.append("\n WHERE A.UPJANG = B.UPJANG");
		sbSql.append("\n   AND EXISTS");
		sbSql.append("\n	   (");
		sbSql.append("\n	   SELECT 1");
		sbSql.append("\n		 FROM PO_SUBINV_USER C");
		sbSql.append("\n		WHERE C.SUBINV_CODE = A.SUBINV_CODE");
		sbSql.append("\n		  AND C.SABUN = '"+ g_EmpNo +"'");
		sbSql.append("\n	   )");
		sbSql.append("\n	AND A.SUBINV_CODE LIKE '%'||'"+nullToBlank(sCode) +"'||'%'");
		sbSql.append("\n	AND A.SUBINV_NAME LIKE '%'||'"+ nullToBlank(sName) +"'||'%'");
		
		
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 

		DataSet ds_Subinv = this.makeDataSet(rs,"ds_Subinv");
		out_dl.add(ds_Subinv);

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