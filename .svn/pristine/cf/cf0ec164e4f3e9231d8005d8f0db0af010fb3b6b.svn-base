<%-----------------------------------------------------------
 - Project     : 한화 FS System
 - MenuID      : 시스템공통 > 공통코드 > 권한별 프로그램 구성
 - ViewPage    : SCC00061P.xml 
 - Description : 기존 권한 불러오기
 - Author      : 손 창 덕
 - History     : 1) 2008. 04. 17 - 최초작성.
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
		int    iSysId   = ds_Input.getInt(0, "SYS_ID");
		String sRole    = ds_Input.getString(0, "ROLE"              );
		String sSysType = ds_Input.getString(0, "SYS_TYPE"          );
	

		DataSet ds_CopyRole;
		StringBuffer sbQuery = new StringBuffer();
		
		// Query Setting
		sbQuery.setLength(0);
		sbQuery.append("\nSELECT B.ROLE, A.MENU_NAME, B.MENU_ID, B.SYS_TYPE,										");
		sbQuery.append("\n       DECODE(A.MENU_TYPE,'M','메뉴','프로그램') AS MENU_TYPE,								");
		sbQuery.append("\n       A.SYS_ID, (SELECT SYS_NAME FROM SCC_SYSTEM WHERE SYS_ID = A.SYS_ID) AS SYS_NAME,	");
		sbQuery.append("\n       (CASE WHEN B.SRC_YN = 'Y' THEN '1' ELSE '0' END) SRC_YN,							");
		sbQuery.append("\n       (CASE WHEN B.PRT_YN = 'Y' THEN '1' ELSE '0' END) PRT_YN,							");
		sbQuery.append("\n       (CASE WHEN B.EXL_YN = 'Y' THEN '1' ELSE '0' END) EXL_YN,							");
		sbQuery.append("\n       (CASE WHEN B.INS_YN = 'Y' THEN '1' ELSE '0' END) INS_YN,							");
		sbQuery.append("\n       (CASE WHEN B.DEL_YN = 'Y' THEN '1' ELSE '0' END) DEL_YN,							");
		sbQuery.append("\n       (CASE WHEN B.SAV_YN = 'Y' THEN '1' ELSE '0' END) SAV_YN,							");
		sbQuery.append("\n       '0' AS TMP_YN																		");
		sbQuery.append("\n  FROM SCC_MENU A, SCC_ROLE_MENU B														");
		sbQuery.append("\n WHERE 1 = 1																				");
		if( iSysId != 0 ) {
			sbQuery.append("\n   AND A.SYS_ID = " + iSysId + " -- 필수 검색조건(시스템ID)								");
		}
		sbQuery.append("\n   AND A.MENU_ID = B.MENU_ID																");
		sbQuery.append("\n   AND B.ROLE = '" + sRole + "' -- 필수 검색조건(권한)										");
		sbQuery.append("\n   AND B.SYS_TYPE = '" + sSysType + "' -- 필수 검색조건(시스템구분)							");
		sbQuery.append("\n ORDER BY B.ROLE																			");
		
		//pstmt = conn.prepareStatement(sbQuery.toString());
		//rs = pstmt.executeQuery();
		stmt = conn.createStatement();		
		rs = stmt.executeQuery(sbQuery.toString());			
		
		ds_CopyRole = this.makeDataSet(rs, "ds_CopyRole");
		out_dl.add(ds_CopyRole);
		
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