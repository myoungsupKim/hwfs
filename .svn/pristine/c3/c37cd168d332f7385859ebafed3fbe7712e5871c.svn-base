<%-----------------------------------------------------------
 - Project     : 한화 FS System
 - MenuID      : 메뉴관리 > 식단관리 > 병원식단관련 출력물 > 전처리 계획서
 - ViewPage    : FSM00350V.xml > FSM00352V.xml 
 - Description : 전처리 계획서 리스트 조회
 - Author      : 손 창 덕
 - History     : 1) 2008. 03. 31 - 최초작성.
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
		String sMeal     = ds_Input.getString(0, "MEAL"     );
		String sNeedDate = ds_Input.getString(0, "NEED_DATE");
	

		DataSet ds_out;
		StringBuffer sbQuery = new StringBuffer();
		sbQuery.append("\nSELECT A.MEAL, C.ITEM_CODE, B.RECIPE_CD, A.HALL_CD,														");
		sbQuery.append("\n       F.CODE_NAME AS MEAL_NAME, D.ITEM_NAME, B.RECIPE_NAME, E.HALL_NAME || '\n(kg)' AS HALL_NAME,			");
		sbQuery.append("\n       (C.NEED_QTY * A.EXPECT_MEAL_QTY) / 1000 AS VAL, D.KG_CONVERT_RATE, G.CODE_NAME AS CUT_SPEC_NAME	");
		sbQuery.append("\n  FROM FSM_REAL_MENU_MST A,																				");
		sbQuery.append("\n       FSM_REAL_RECIPE_MST B,																				");
		sbQuery.append("\n       FSM_REAL_RECIPE_ITEM C,																			");
		sbQuery.append("\n       HLDC_PO_ITEM_MST D,																				");
		sbQuery.append("\n       FSA_HALL_MST E,																					");
		sbQuery.append("\n       (SELECT CODE, CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0023') F, /* 끼니 */				");
		sbQuery.append("\n       (SELECT CODE, CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0017') G /* 커팅규격 */			");
		sbQuery.append("\n WHERE A.UPJANG = " + iUpjang + " /* 필수 검색조건(업장코드) */												");
		sbQuery.append("\n   AND A.MENU_DATE = '" + sMenuDate + "' /* 필수 검색조건(메뉴일자) */											");
		if( !sMeal.equals("000") ) {
			sbQuery.append("\n   AND A.MEAL = '" + sMeal + "' /* 선택 검색조건(끼니코드) */												");
		}
		sbQuery.append("\n	 AND B.MAJOR_DISH_INFO NOT IN ('001', '008') /* 주식, 김치 제외 */											");
		sbQuery.append("\n   AND C.NEED_DATE = '" + sNeedDate + "' /* 필수 검색조건(자재 입고일자) */										");
		sbQuery.append("\n   AND C.CUT_SPEC IS NOT NULL																				");
		sbQuery.append("\n   AND A.UPJANG = B.UPJANG																				");
		sbQuery.append("\n   AND A.MENU_CD = B.MENU_CD																				");
		sbQuery.append("\n   AND A.UPJANG = E.UPJANG																				");
		sbQuery.append("\n   AND A.HALL_CD = E.HALL_CD																				");
		sbQuery.append("\n   AND A.MEAL = F.CODE																					");
		sbQuery.append("\n   AND B.UPJANG = C.UPJANG																				");
		sbQuery.append("\n   AND B.MENU_CD = C.MENU_CD																				");
		sbQuery.append("\n   AND B.RECIPE_CD = C.RECIPE_CD																			");
		sbQuery.append("\n   AND C.ITEM_CODE = D.ITEM_CODE(+)																		");
		sbQuery.append("\n   AND C.CUT_SPEC = G.CODE(+)																				");
		sbQuery.append("\n ORDER BY A.MEAL, C.ITEM_CODE, B.RECIPE_CD, A.HALL_CD														");
		
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