<%-----------------------------------------------------------
 - Project     : 한화 FS System
 - MenuID      : 메뉴관리 > 식단관리 > 병원식단관련 출력물 > 음식담기 계획서
 - ViewPage    : FSM00350V.xml > FSM00353R.xml 
 - Description : 음식담기 계획서 리스트 조회
 - Author      : 손 창 덕
 - History     : 1) 2008. 06. 10 - 최초작성.
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
		
		// IN DataSet
		DataSet ds_Input = in_dl.get("ds_Input");
		
		// 변수 설정
		int    iUpjang   = ds_Input.getInt(0, "UPJANG");
		String sMenuDate = ds_Input.getString(0, "MENU_DATE");
		String sHallCd   = ds_Input.getString(0, "HALL_CD"  );
		String sMeal     = ds_Input.getString(0, "MEAL"     );
		String sCorner   = ds_Input.getString(0, "CORNER"   );
		String sNeedDate = ds_Input.getString(0, "NEED_DATE");
	

		DataSet ds_out;
		StringBuffer sbQuery = new StringBuffer();
		sbQuery.append("\nSELECT A.MENU_CD, B.RECIPE_CD, A.HALL_CD, A.MEAL, A.CORNER, B.USE_TOOL,						");
		sbQuery.append("\n       D.CODE_NAME AS MEAL_NAME, B.RECIPE_NAME, C.HALL_NAME,									");
		sbQuery.append("\n       E.CODE_NAME AS CORNER_NAME, F.CODE_NAME AS USE_TOOL_NAME, A.EXPECT_MEAL_QTY			");
		sbQuery.append("\n  FROM FSM_REAL_MENU_MST A,																	");
		sbQuery.append("\n       FSM_REAL_RECIPE_MST B,																	");
		sbQuery.append("\n       FSA_HALL_MST C,																		");
		sbQuery.append("\n       (SELECT CODE, CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0023') D, /* 끼니 */	");
		sbQuery.append("\n       (SELECT CODE, CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0022') E, /* 코너 */	");
		sbQuery.append("\n       (SELECT CODE, CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0013') F /* 찬기 */	");
		sbQuery.append("\n WHERE A.UPJANG = " + iUpjang + " /* 필수 검색조건(업장코드) */									");
		sbQuery.append("\n   AND A.MENU_DATE = '" + sMenuDate + "' /* 필수 검색조건(메뉴일자) */								");
		sbQuery.append("\n   AND A.HALL_CD = '" + sHallCd + "' /* 필수 검색조건(식당코드) */									");
		if( !sMeal.equals("000") ) {
			sbQuery.append("\n   AND A.MEAL = '" + sMeal + "' /* 선택 검색조건(끼니코드) */									");
		}
		if( !sCorner.equals("000") ) {
			sbQuery.append("\n   AND A.CORNER = '" + sCorner + "' /* 선택 검색조건(코너코드) */								");
		}
		sbQuery.append("\n   AND A.UPJANG = B.UPJANG																	");
		sbQuery.append("\n   AND A.MENU_CD = B.MENU_CD																	");
		sbQuery.append("\n   AND A.UPJANG = C.UPJANG																	");
		sbQuery.append("\n   AND A.HALL_CD = C.HALL_CD																	");
		sbQuery.append("\n   AND A.MEAL = D.CODE																		");
		sbQuery.append("\n   AND A.CORNER = E.CODE																		");
		sbQuery.append("\n   AND B.USE_TOOL = F.CODE(+)																	");
		sbQuery.append("\n ORDER BY A.MEAL, B.MAJOR_DISH_INFO, B.RECIPE_CD, A.HALL_CD, A.CORNER, B.USE_TOOL				");
		
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