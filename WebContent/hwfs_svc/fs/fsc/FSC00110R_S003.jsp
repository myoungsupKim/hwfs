<%-----------------------------------------------------------
 - Project     : 한화 FS System
 - MenuID      : 메뉴관리 > 위생관리 > 위생일지출력 > CCP1
 - ViewPage    : FSC00110R.xml
 - Description : 선택 메뉴 레시피 리스트 조회
 - Author      : 손 창 덕
 - History     : 1) 2008. 03. 20 - 최초작성.
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
		String sUpjang = in_vl.getString("UPJANG" );
		String sMenuCd = in_vl.getString("MENU_CD");
	

		DataSet ds_out;
		StringBuffer sbQuery = new StringBuffer();
		
		sbQuery.setLength(0);
		sbQuery.append("\nSELECT T1.MENU_CD, T1.HALL_CD, T1.MEAL, T1.CORNER,																					");
		sbQuery.append("\n	     T2.CODE_NAME || T3.CODE_NAME || DECODE(T1.CORNER_DESC, NULL, '', '(' || T1.CORNER_DESC || ')') AS MENU_NAME, T1.MENU_FEATURE,	");
		sbQuery.append("\n       T1.RECIPE_CD, T1.RECIPE_NAME, T1.PHF_MGMT_YN, T1.PHF,																			");
		sbQuery.append("\n       T1.PHF_MGMT1, T1.PHF_MGMT2, T1.PHF_MGMT3, T1.PHF_MGMT4, T1.PHF_MGMT5, '0' AS CHK												");
		sbQuery.append("\n  FROM (SELECT A.MENU_CD, A.HALL_CD, A.MEAL, A.CORNER,																				");
		sbQuery.append("\n               (SELECT AB.CORNER_DESC FROM FSA_HALL_DTL AB																			");
		sbQuery.append("\n                 WHERE AB.UPJANG  = A.UPJANG																							");
		sbQuery.append("\n                   AND AB.HALL_CD = A.HALL_CD																							");
		sbQuery.append("\n                   AND AB.MEAL    = A.MEAL																							");
		sbQuery.append("\n                   AND AB.CORNER  = A.CORNER) AS CORNER_DESC, A.MENU_FEATURE,															");
		sbQuery.append("\n               B.RECIPE_CD, B.RECIPE_NAME, B.PHF_MGMT_YN, B.PHF,																		");
		sbQuery.append("\n               DECODE(B.PHF_MGMT_YN, 'Y', NVL(B.PHF_MGMT1,'N'), '') AS PHF_MGMT1,														");
		sbQuery.append("\n               DECODE(B.PHF_MGMT_YN, 'Y', NVL(B.PHF_MGMT2,'N'), '') AS PHF_MGMT2,														");
		sbQuery.append("\n               DECODE(B.PHF_MGMT_YN, 'Y', NVL(B.PHF_MGMT3,'N'), '') AS PHF_MGMT3,														");
		sbQuery.append("\n               DECODE(B.PHF_MGMT_YN, 'Y', NVL(B.PHF_MGMT4,'N'), '') AS PHF_MGMT4,														");
		sbQuery.append("\n               DECODE(B.PHF_MGMT_YN, 'Y', NVL(B.PHF_MGMT5,'N'), '') AS PHF_MGMT5														");
		sbQuery.append("\n          FROM FSM_REAL_MENU_MST A, FSM_REAL_RECIPE_MST B																				");
		sbQuery.append("\n         WHERE A.UPJANG = " + sUpjang																									 );
		sbQuery.append("\n           AND A.MENU_CD IN (" + sMenuCd + ")																							");
		sbQuery.append("\n           AND A.UPJANG = B.UPJANG																									");
		sbQuery.append("\n           AND A.MENU_CD = B.MENU_CD																									");
		sbQuery.append("\n         ORDER BY A.MENU_CD, B.CUISINE_TYPE, B.RECIPE_CD) T1,																			");
		sbQuery.append("\n       (SELECT CODE, CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0023') T2, -- 끼니(공통코드)									");
		sbQuery.append("\n       (SELECT CODE, CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0022') T3 -- 코너(공통코드)									");
		sbQuery.append("\n WHERE T1.MEAL = T2.CODE(+)																											");
		sbQuery.append("\n   AND T1.CORNER = T3.CODE(+)																											");
		
		pstmt = conn.prepareStatement(sbQuery.toString());
		rs = pstmt.executeQuery();
		
		DataSet ds_RecipeList = this.makeDataSet(rs, "ds_RecipeList");
		out_dl.add(ds_RecipeList);
		
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