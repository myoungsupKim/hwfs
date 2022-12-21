<%-----------------------------------------------------------
 - Project     : 한화 FS System
 - MenuID      : 메뉴관리 > 구매관리 > 입고관리 > 입고예정현황조회 > 검수창고/부서 조회 팝업
 - ViewPage    : FSP00111P.xml 
 - Description : 검수창고("S") / 검수부서("D") 검색 팝업
 - Author      : 손 창 덕
 - History     : 1) 2008. 03. 18 - 최초작성.
 -               2) 
 ------------------------------------------------------------%>
<%@page import="com.sz.util.AppDataUtility"%>

<%@page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	try {
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		String  sUpjang = in_vl.getString("g_Upjang");
		String  sEmpNo  = in_vl.getString("g_EmpNo" );
		DataSet in_ds   = in_dl.get("ds_Input"      );
		
		// 변수 설정
		String sType     = in_ds.getString(0, "TYPE"     );
		String sCode     = in_ds.getString(0, "CODE"     );
		String sCodeName = in_ds.getString(0, "CODE_NAME");
		
		if(conn != null && !conn.isClosed()) conn.close();
		conn = getIRISConn();
	

		DataSet ds_out;
		StringBuffer sbQuery = new StringBuffer();
		
		sbQuery.setLength(0);
		if( sType.equals("S") ) {
			sbQuery.append("\nSELECT SUBINV_CODE AS CODE, SUBINV_NAME AS CODE_NAME	");
			sbQuery.append("\n  FROM (												");
			sbQuery.append("\n        SELECT A.SUBINV_CODE,							");
			sbQuery.append("\n               DECODE(A.USE_YN, 'N' , '폐장' )||A.SUBINV_CODE||' '||A.SUBINV_NAME||' ( '|| REPLACE(B.UPJANGNM,'단체급식 ')||' ) ' AS SUBINV_NAME	");
			sbQuery.append("\n          FROM PO_SUBINVENTORY A,						");
			sbQuery.append("\n               ST_UPJANG B							");
			sbQuery.append("\n         WHERE A.UPJANG = B.UPJANG					");
			sbQuery.append("\n           AND EXISTS									");
			sbQuery.append("\n               (										");
			sbQuery.append("\n                SELECT 1								");
			sbQuery.append("\n                  FROM PO_SUBINV_USER C				");
			sbQuery.append("\n                 WHERE C.SUBINV_CODE = A.SUBINV_CODE	");
			sbQuery.append("\n                   AND C.SABUN = '" + sEmpNo + "'		");
			sbQuery.append("\n                )										");
			sbQuery.append("\n           AND A.USE_YN = 'Y'							");
			sbQuery.append("\n       )												");
			sbQuery.append("\n WHERE 1 = 1											");
			if( AppDataUtility.isNotNull(sCode) ) {
				sbQuery.append("\n   AND SUBINV_CODE LIKE '%" + sCode + "%'			");
			}
			if( AppDataUtility.isNotNull(sCodeName) ) {
				sbQuery.append("\n   AND SUBINV_NAME LIKE '%" + sCodeName + "%'		");
			}
		} else {
			sbQuery.append("\nSELECT A.DEPT_ID AS CODE,								");
			sbQuery.append("\n       A.DEPT_NAME AS CODE_NAME						");
			sbQuery.append("\n  FROM (												");
			sbQuery.append("\n        SELECT B.DEPT_ID,								");
			sbQuery.append("\n               DECODE(B.DEPT_USE, 'N' , ' (구) ' )||' ( '||B.CC_CD||' ) '||B.MU_NM||''||B.CC_NM||' ( '||TO_CHAR(B.DEPT_ID)||' ) ' AS DEPT_NAME ,	");
			sbQuery.append("\n               B.DEPT_USE AS USE_YN					");
			sbQuery.append("\n          FROM (										");
			sbQuery.append("\n                SELECT A.UPJANG						");
			sbQuery.append("\n                  FROM PO_SUBINVENTORY A,				");
			sbQuery.append("\n                       PO_SUBINV_USER B				");
			sbQuery.append("\n                 WHERE A.SUBINV_CODE = B.SUBINV_CODE	");
			sbQuery.append("\n                   AND A.USE_YN = 'Y'					");
			sbQuery.append("\n                   AND B.SUBINV_CODE > ' '			");
			sbQuery.append("\n                   AND B.SABUN = '" + sEmpNo + "'		");
			sbQuery.append("\n                 UNION ALL							");
			sbQuery.append("\n                SELECT " + sUpjang + " AS UPJANG		");
			sbQuery.append("\n                  FROM DUAL							");
			sbQuery.append("\n               ) A ,									");
			sbQuery.append("\n               SC_DEPT_V B,							");
			sbQuery.append("\n               ST_UPJANG C							");
			sbQuery.append("\n         WHERE A.UPJANG = C.UPJANG					");
			sbQuery.append("\n           AND C.DEPT_ID = B.DEPT_ID					");
			sbQuery.append("\n         GROUP BY B.DEPT_ID,							");
			sbQuery.append("\n                  DECODE(B.DEPT_USE, 'N' , ' (구) ' )||' ( '||B.CC_CD||' ) '||B.MU_NM||''||B.CC_NM||' ( '||TO_CHAR(B.DEPT_ID)||' ) ' ,		");
			sbQuery.append("\n                  B.DEPT_USE							");
			sbQuery.append("\n       ) A											");
			sbQuery.append("\n WHERE (1 = 1)										");
			sbQuery.append("\n   AND A.USE_YN = 'Y'									");
			if( AppDataUtility.isNotNull(sCode) ) {
				sbQuery.append("\n   AND A.DEPT_ID LIKE '%" + sCode + "%'			");
			}
			if( AppDataUtility.isNotNull(sCodeName) ) {
				sbQuery.append("\n   AND A.DEPT_NAME LIKE '%" + sCodeName + "%'		");
			}
		}
		pstmt = conn.prepareStatement(sbQuery.toString());
		rs = pstmt.executeQuery();
		
		DataSet ds_List = this.makeDataSet(rs, "ds_List");
		out_dl.add(ds_List);
		
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