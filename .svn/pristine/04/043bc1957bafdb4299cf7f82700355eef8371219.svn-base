<%-----------------------------------------------------------
 - Project     : 한화 FS System
 - MenuID      : 메뉴관리 > 위생관리 > 건강진단결과 관리
 - ViewPage    : FSC00100E.xml
 - Description : 사업장의 CC_CD 조회
 - Author      : 손 창 덕
 - History     : 1) 2008. 05. 19 - 최초작성.
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
		int iAuthLevel = Integer.parseInt(in_vl.getString("g_AuthLevel"));
		
		// IN DataSet
		DataSet ds_Input = in_dl.get("ds_Input");
		
		// Variables
		int iUpjang = ds_Input.getInt(0, "UPJANG");
	

		DataSet ds_out;
		StringBuffer sbQuery = new StringBuffer();
		
		sbQuery.setLength(0);
		sbQuery.append("\nSELECT UPJANG, CC_CD			");
		sbQuery.append("\n  FROM HLDC_ST_UPJANG			");
		sbQuery.append("\n WHERE UPJANG = " + iUpjang	 );
		
		pstmt = conn.prepareStatement(sbQuery.toString());
		rs = pstmt.executeQuery();
		
		DataSet ds_CcCd = this.makeDataSet(rs, "ds_CcCd");
		out_dl.add(ds_CcCd);
		
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