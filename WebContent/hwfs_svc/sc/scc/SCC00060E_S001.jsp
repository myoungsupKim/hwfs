<%-----------------------------------------------------------
 - Project     : ��ȭ FS System
 - MenuID      : �ý��۰��� > �����ڵ� > ���Ѻ� ���α׷� ����
 - ViewPage    : SCC00060E.xml 
 - Description : �ý��۱���(�޺��ڽ�) ��ȸ
 - Author      : �� â ��
 - History     : 1) 2008. 04. 11 - �����ۼ�.
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
	
		StringBuffer sbQuery = new StringBuffer();
		
		// Query Setting
		sbQuery.setLength(0);
		sbQuery.append("\nSELECT 'NULL' AS SYS_TYPE, '- ���� -' AS SYS_TYPE_NAME			");
		sbQuery.append("\n  FROM DUAL													");
		sbQuery.append("\n UNION ALL													");
		sbQuery.append("\nSELECT *														");
		sbQuery.append("\n  FROM (SELECT CODE AS SYS_TYPE, CODE_NAME AS SYS_TYPE_NAME	");
		sbQuery.append("\n          FROM SCC_COMMON_CODE								");
		sbQuery.append("\n         WHERE GROUP_CODE = '�ý��۱���'						");
		sbQuery.append("\n         ORDER BY CODE_NAME)									");
		
		//pstmt = conn.prepareStatement(sbQuery.toString());
		//rs = pstmt.executeQuery();
		stmt = conn.createStatement();		
		rs = stmt.executeQuery(sbQuery.toString());			
		
		DataSet ds_SysType = this.makeDataSet(rs, "ds_SysType");
		out_dl.add(ds_SysType);
		
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