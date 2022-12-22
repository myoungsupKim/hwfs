<%-----------------------------------------------------------
 - Project     : 한화 FS System
 - MenuID      : 시스템공통 > 공통코드 > 권한별 프로그램 구성
 - ViewPage    : SCC00060E.xml 
 - Description : 프로그램 리스트 조회, 프로그램별 권한 리스트 조회
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
		int    iSysId   = ds_Input.getInt(0, "SYS_ID");
		String sRole    = ds_Input.getString(0, "ROLE"              );
		String sSystem  = ds_Input.getString(0, "SYS_TYPE"          );
	

		DataSet ds_StdProgram;
		DataSet ds_Program;
		DataSet ds_ProgramRole;
		StringBuffer sbQuery = new StringBuffer();
		
		// Query Setting - 전체 프로그램  리스트
		sbQuery.setLength(0);
		sbQuery.append("\nSELECT A.MENU_ID, A.MENU_NAME, DECODE(A.MENU_TYPE,'M','메뉴','프로그램') AS MENU_TYPE,							");
		sbQuery.append("\n       A.SYS_ID, (SELECT SYS_NAME FROM SCC_SYSTEM WHERE SYS_ID = A.SYS_ID) AS SYS_NAME						");
		sbQuery.append("\n  FROM SCC_MENU A																								");
		sbQuery.append("\n WHERE A.SYS_ID IN (SELECT SYS_ID FROM SCC_SYSTEM WHERE SYS_TYPE = '" + sSystem + "' AND USE_YN = 'Y')		");
		if( iSysId != 0 ) {
			sbQuery.append("\n   AND A.SYS_ID = " + iSysId + " -- 필수 검색조건(시스템ID)													");
		}
		sbQuery.append("\n   AND A.USE_YN = 'Y'																							");
		sbQuery.append("\n ORDER BY A.MENU_ID																							");
		
		//pstmt = conn.prepareStatement(sbQuery.toString());
		//rs = pstmt.executeQuery();
		stmt = conn.createStatement();		
		rs = stmt.executeQuery(sbQuery.toString());				
		
		ds_StdProgram = this.makeDataSet(rs, "ds_StdProgram");
		
		rs.close();
		stmt.close();
		
		// Query Setting - 프로그램 리스트
		sbQuery.setLength(0);
		sbQuery.append("\nSELECT A.MENU_ID, A.MENU_NAME, DECODE(A.MENU_TYPE,'M','메뉴','프로그램') AS MENU_TYPE,							");
		sbQuery.append("\n       A.SYS_ID, (SELECT SYS_NAME FROM SCC_SYSTEM WHERE SYS_ID = A.SYS_ID) AS SYS_NAME						");
		sbQuery.append("\n  FROM SCC_MENU A																								");
		sbQuery.append("\n WHERE A.SYS_ID IN (SELECT SYS_ID FROM SCC_SYSTEM WHERE SYS_TYPE = '" + sSystem + "' AND USE_YN = 'Y')		");
		if( iSysId != 0 ) {
			sbQuery.append("\n   AND A.SYS_ID = " + iSysId + " -- 필수 검색조건(시스템ID)													");
		}
		sbQuery.append("\n   AND A.MENU_ID NOT IN (SELECT MENU_ID FROM SCC_ROLE_MENU WHERE ROLE = '" + sRole + "') -- 필수 검색조건(권한)	");
		sbQuery.append("\n   AND A.USE_YN = 'Y'																							");
		sbQuery.append("\n ORDER BY A.MENU_ID																							");
		
		//pstmt = conn.prepareStatement(sbQuery.toString());
		//rs = pstmt.executeQuery();
		stmt = conn.createStatement();		
		rs = stmt.executeQuery(sbQuery.toString());			
		
		ds_Program = this.makeDataSet(rs, "ds_Program");
		
		rs.close();
		stmt.close();		
		
		// Query Setting - 프로그램 권한 리스트
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
		sbQuery.append("\n       (CASE WHEN B.PRSINF_YN = 'Y' THEN '1' ELSE '0' END) PRSINF_YN,							");
		sbQuery.append("\n       '0' AS TMP_YN																		");
		sbQuery.append("\n  FROM SCC_MENU A, SCC_ROLE_MENU B														");
		sbQuery.append("\n WHERE 1 = 1																				");
		sbQuery.append("\n   AND A.SYS_ID IN (SELECT SYS_ID FROM SCC_SYSTEM WHERE SYS_TYPE = '" + sSystem + "' AND USE_YN = 'Y')		");
		if( iSysId != 0 ) {
			sbQuery.append("\n   AND A.SYS_ID = " + iSysId + " -- 필수 검색조건(시스템ID)								");
		}
		sbQuery.append("\n   AND A.MENU_ID = B.MENU_ID																");
		sbQuery.append("\n   AND B.ROLE = '" + sRole + "' -- 필수 검색조건(권한)										");
		sbQuery.append("\n ORDER BY B.ROLE, B.MENU_ID																");
		
		//pstmt = conn.prepareStatement(sbQuery.toString());
		//rs = pstmt.executeQuery();
		stmt = conn.createStatement();		
		rs = stmt.executeQuery(sbQuery.toString());			
		
		ds_ProgramRole = this.makeDataSet(rs, "ds_ProgramRole");
		
		rs.close();
		stmt.close();
		
		out_dl.add(ds_StdProgram);
		out_dl.add(ds_Program);
		out_dl.add(ds_ProgramRole);
		
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