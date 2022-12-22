<%-----------------------------------------------------------
 - Project     : 한화 FS System
 - MenuID      : 메뉴관리 > 구매관리 > 입고관리 > 입고예정현황조회
 - ViewPage    : FSP00110V.xml 
 - Description : 창고입고의 경우 검수예정서 출력을 위해 해당 입고예정의 업장코드 조회
 - Author      : 손 창 덕
 - History     : 1) 2008. 03. 18 - 최초작성.
 -               2) 
 ------------------------------------------------------------%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	try {
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		// IN Valiables
		String sSubinvCode = in_vl.getString("SUBINV_CODE" );
		
		if(conn != null && !conn.isClosed()) conn.close();
		conn = getIRISConn();
	

		DataSet ds_out;
		StringBuffer sbQuery = new StringBuffer();
		
		sbQuery.setLength(0);
		sbQuery.append("\nSELECT UPJANG								");
		sbQuery.append("\n  FROM PO_SUBINVENTORY					");
		sbQuery.append("\n WHERE SUBINV_CODE = '" + sSubinvCode + "'");
		
		pstmt = conn.prepareStatement(sbQuery.toString());
		rs = pstmt.executeQuery();
		
		DataSet ds_Temp = this.makeDataSet(rs, "ds_Temp");
		out_dl.add(ds_Temp);
		
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
		if(conn != null) {
			try {
				conn.close();
			}catch(Exception e) {}
		}
		proc_output(response, out, out_vl, out_dl);
	}
%>