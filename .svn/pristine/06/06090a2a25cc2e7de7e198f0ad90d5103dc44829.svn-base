<%-----------------------------------------------------------
 - Project     : 한화 FS System
 - MenuID      : 메뉴관리 > 위생관리 > 위생일지출력
 - ViewPage    : FSC00110R.xml
 - Description : 업장에 딸린 식당 조회
 - Author      : 손 창 덕
 - History     : 1) 2008. 03. 19 - 최초작성.
 -               2) 
 ------------------------------------------------------------%>
<%@page import="com.sz.util.AppDataUtility"%>

<%@page import="com.ifis.sc.scc.CommonUtil"%>
<%@page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	try {
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		// IN Valiables
		String sUpjang = in_vl.getString("UPJANG");
		

		DataSet ds_out;
		StringBuffer sbQuery = new StringBuffer();
		
		sbQuery.setLength(0);
		sbQuery.append("\nSELECT '00000' AS HALL_CD, '- 전체 -' AS HALL_NAME	");
		sbQuery.append("\n  FROM DUAL										");
		sbQuery.append("\n UNION ALL										");
		sbQuery.append("\nSELECT HALL_CD, HALL_NAME							");
		sbQuery.append("\n  FROM FSA_HALL_MST								");
		sbQuery.append("\n WHERE UPJANG = " + sUpjang						 );
		sbQuery.append("\n   AND USE_YN = 'Y'								");
		
		pstmt = conn.prepareStatement(sbQuery.toString());
		rs = pstmt.executeQuery();
		
		DataSet ds_Hall = this.makeDataSet(rs, "ds_Hall");
		out_dl.add(ds_Hall);
		
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