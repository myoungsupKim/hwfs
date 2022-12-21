<%-----------------------------------------------------------
 - Project     : 한화 FS System
 - MenuID      : 메뉴관리 > 식단관리 > 병원식단관련 출력물 > 검식일지
 - ViewPage    : FSM00350V.xml > FSM00354R.xml 
 - Description : 검식일지 리스트 조회
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
		sbQuery.append("\nSELECT MEAL, CORNER, MEAL_NAME, CORNER_NAME,													");
		sbQuery.append("\n       MAX(MAJOR1) AS MAJOR1, MAX(MAJOR2) AS MAJOR2, MAX(MAJOR3) AS MAJOR3,					");
		sbQuery.append("\n       MAX(MAJOR4) AS MAJOR4, MAX(MAJOR5) AS MAJOR5, MAX(MAJOR6) AS MAJOR6,					");
		sbQuery.append("\n       MAX(MAJOR7) AS MAJOR7, MAX(MAJOR8) AS MAJOR8, MAX(MAJOR9) AS MAJOR9,					");
		sbQuery.append("\n       MAX(MAJOR10) AS MAJOR10, MAX(MAJOR11) AS MAJOR11										");
		sbQuery.append("\n  FROM (																						");
		sbQuery.append("\n        SELECT MEAL, CORNER, MEAL_NAME, CORNER_NAME,											");
		sbQuery.append("\n               DECODE(MAJOR_DISH_INFO, '001', RECIPE_NAME) AS MAJOR1,							");
		sbQuery.append("\n               DECODE(MAJOR_DISH_INFO, '002', RECIPE_NAME) AS MAJOR2,							");
		sbQuery.append("\n               DECODE(MAJOR_DISH_INFO, '003', RECIPE_NAME) AS MAJOR3,							");
		sbQuery.append("\n               DECODE(MAJOR_DISH_INFO, '004', RECIPE_NAME) AS MAJOR4,							");
		sbQuery.append("\n               DECODE(MAJOR_DISH_INFO, '005', RECIPE_NAME) AS MAJOR5,							");
		sbQuery.append("\n               DECODE(MAJOR_DISH_INFO, '006', RECIPE_NAME) AS MAJOR6,							");
		sbQuery.append("\n               DECODE(MAJOR_DISH_INFO, '007', RECIPE_NAME) AS MAJOR7,							");
		sbQuery.append("\n               DECODE(MAJOR_DISH_INFO, '008', RECIPE_NAME) AS MAJOR8,							");
		sbQuery.append("\n               DECODE(MAJOR_DISH_INFO, '009', RECIPE_NAME) AS MAJOR9,							");
		sbQuery.append("\n               DECODE(MAJOR_DISH_INFO, '010', RECIPE_NAME) AS MAJOR10,						");
		sbQuery.append("\n               DECODE(MAJOR_DISH_INFO, '011', RECIPE_NAME) AS MAJOR11							");
		sbQuery.append("\n          FROM (SELECT A.MEAL, A.CORNER, B.RECIPE_CD, B.MAJOR_DISH_INFO,						");
		sbQuery.append("\n                       D.CODE_NAME AS MEAL_NAME, E.CODE_NAME AS CORNER_NAME, B.RECIPE_NAME	");
		sbQuery.append("\n                  FROM FSM_REAL_MENU_MST A,													");
		sbQuery.append("\n                       FSM_REAL_RECIPE_MST B,													");
		sbQuery.append("\n                       FSA_HALL_MST C,														");
		sbQuery.append("\n                       (SELECT CODE, CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0023') D, /* 끼니 */	");
		sbQuery.append("\n                       (SELECT CODE, CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0022') E /* 코너 */	");
		sbQuery.append("\n                 WHERE A.UPJANG = " + iUpjang + " /* 필수 검색조건(업장코드) */					");
		sbQuery.append("\n                   AND A.MENU_DATE = '" + sMenuDate + "' /* 필수 검색조건(메뉴일자) */				");
		sbQuery.append("\n                   AND A.HALL_CD = '" + sHallCd +"' /* 필수 검색조건(식당코드) */					");
		if( !sMeal.equals("000") ) {
			sbQuery.append("\n                   AND A.MEAL = '" + sMeal + "' /* 선택 검색조건(끼니코드) */					");
		}
		if( !sCorner.equals("000") ) {
			sbQuery.append("\n                   AND A.CORNER = '" + sCorner + "' /* 선택 검색조건(코너코드) */				");
		}
		sbQuery.append("\n                   AND A.UPJANG = B.UPJANG													");
		sbQuery.append("\n                   AND A.MENU_CD = B.MENU_CD													");
		sbQuery.append("\n                   AND A.UPJANG = C.UPJANG													");
		sbQuery.append("\n                   AND A.HALL_CD = C.HALL_CD													");
		sbQuery.append("\n                   AND A.MEAL = D.CODE														");
		sbQuery.append("\n                   AND A.CORNER = E.CODE														");
		sbQuery.append("\n                 ORDER BY A.MEAL, A.CORNER, B.RECIPE_CD))										");
		sbQuery.append("\n	GROUP BY MEAL, CORNER, MEAL_NAME, CORNER_NAME												");
		
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