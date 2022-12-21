<%-----------------------------------------------------------
 - Project     : 한화 FS System
 - MenuID      : 시스템공통 > 공통코드 > 권한별 프로그램 구성
 - ViewPage    : SCC00060E.xml 
 - Description : 시스템ID(콤보박스) 조회
 - Author      : 손 창 덕
 - History     : 1) 2008. 04. 11 - 최초작성.
 -               2) 
 ------------------------------------------------------------%>
<%@page import="com.sz.util.AppDataUtility,  com.ifis.sc.scc.CommonUtil"%>
<%@page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	Statement stmt           =  null;

	try {
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		// IN DataSet
		DataSet ds_Input = in_dl.get("ds_Input");
		
		// 변수 설정
		String sSysType = ds_Input.getString(0, "SYS_TYPE");
	

		DataSet ds_out;
		StringBuffer sbQuery = new StringBuffer();
		
		// Query Setting
		sbQuery.setLength(0);
		sbQuery.append("\nSELECT 0 AS SYS_ID, '- 전체 -' AS SYS_NAME		");
		sbQuery.append("\n  FROM DUAL									");
		sbQuery.append("\n UNION ALL									");
		sbQuery.append("\nSELECT *										");
		sbQuery.append("\n  FROM (SELECT SYS_ID, SYS_NAME				");
		sbQuery.append("\n          FROM SCC_SYSTEM						");
		sbQuery.append("\n         WHERE SYS_TYPE = '" + sSysType + "'	");
		sbQuery.append("\n         ORDER BY SORT_SEQ)					");
		
		//pstmt = conn.prepareStatement(sbQuery.toString());
		//rs = pstmt.executeQuery();
		stmt = conn.createStatement();		
		rs = stmt.executeQuery(sbQuery.toString());			
		
		DataSet ds_SysId = this.makeDataSet(rs, "ds_SysId");
		out_dl.add(ds_SysId);
		
	   	this.setResultMessage(0, "OK", out_vl);
	} catch(Exception ex) {
	   ex.printStackTrace();
       this.setResultMessage(-1, ex.toString(), out_vl);
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
		proc_output(response, out, out_vl, out_dl);
	}
%>