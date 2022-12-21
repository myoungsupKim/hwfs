<%-----------------------------------------------------------
 - Project     : 한화 FS System
 - MenuID      : 메뉴관리 > 식단관리 > 병원식단관련 출력물
 - ViewPage    : FSM00350V.xml 
 - Description : 공통코드 조회(식당, 끼니, 코너) -- FMS00351V ~ FMS00355R에서 공통으로 사용
 - Author      : 손 창 덕
 - History     : 1) 2008. 03. 26 - 최초작성.
 -               2) 
 ------------------------------------------------------------%>
<%@page import="com.sz.util.AppDataUtility,  com.ifis.sc.scc.CommonUtil"%>
<%@page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	try {
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		// IN Variables
		String sGubun    = in_vl.getString("GUBUN"    );
		String sOutputDS = in_vl.getString("OUTPUT_DS");
	

		DataSet ds_out;
		StringBuffer sbQuery = new StringBuffer();
		
		if( sGubun.equals("HALL") ) {	// 업체의 식당 조회
			// IN DataSet
			DataSet ds_Input = in_dl.get("ds_Input");
			// 변수 설정
			int iUpjang = ds_Input.getInt(0, "UPJANG");
			// Query Set
			sbQuery.setLength(0);
			sbQuery.append("\nSELECT HALL_CD, HALL_NAME			");
			sbQuery.append("\n  FROM FSA_HALL_MST				");
			sbQuery.append("\n WHERE UPJANG = " + iUpjang		 );
			sbQuery.append("\n ORDER BY HALL_CLASS, HALL_CD		");
		} else if( sGubun.equals("MEAL") ) {	// 공통코드의 끼니 조회
			// Query Set
			sbQuery.setLength(0);
			sbQuery.append("\nSELECT '000' AS CODE, '- 전체 -' AS CODE_NAME		");
			sbQuery.append("\n  FROM DUAL										");
			sbQuery.append("\n UNION ALL										");
			sbQuery.append("\nSELECT CODE, CODE_NAME							");
			sbQuery.append("\n  FROM SCC_COMMON_CODE							");
			sbQuery.append("\n WHERE GROUP_CODE = 'FS0023'						");
		} else if( sGubun.equals("CORNER") ) {	// 공통코드의 코너 조회
			// Query Set
			sbQuery.setLength(0);
			sbQuery.append("\nSELECT '000' AS CODE, '- 전체 -' AS CODE_NAME		");
			sbQuery.append("\n  FROM DUAL										");
			sbQuery.append("\n UNION ALL										");
			sbQuery.append("\nSELECT CODE, CODE_NAME							");
			sbQuery.append("\n  FROM SCC_COMMON_CODE							");
			sbQuery.append("\n WHERE GROUP_CODE = 'FS0022'						");
		} else {
			throw new Exception("구분값이 올바르지 않습니다.\n관리자에게 문의하여 주십시요.");
		}
		
		pstmt = conn.prepareStatement(sbQuery.toString());
		rs = pstmt.executeQuery();
		
		//DataSet OUTPUT_DS = this.makeDataSet(rs, "OUTPUT_DS");
		DataSet OUTPUT_DS = this.makeDataSet(rs, sOutputDS);
		out_dl.add(OUTPUT_DS);
		
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