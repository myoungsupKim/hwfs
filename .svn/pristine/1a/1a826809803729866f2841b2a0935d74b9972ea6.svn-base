<%-----------------------------------------------------------
 - Project     : 한화 FS System
 - MenuID      : 메뉴관리 > 위생관리 > 위생일지출력
 - ViewPage    : FSC00110R.xml
 - Description : 식단리스트 조회
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
		
		// IN DataSet
		DataSet ds_Input        = in_dl.get("ds_Input"      );
		
		// 변수 설정
		String sUpjang       = ds_Input.getString(0, "UPJANG"        );
		String sFromMenuDate = ds_Input.getString(0, "FROM_MENU_DATE");
		String sToMenuDate   = ds_Input.getString(0, "TO_MENU_DATE"  );
		String sHallCd       = ds_Input.getString(0, "HALL_CD"       );
	

		DataSet ds_out;
		StringBuffer sbQuery = new StringBuffer();
		
		sbQuery.setLength(0);
		sbQuery.append("\nSELECT T1.UPJANG, T1.MENU_CD, T1.MENU_DATE, T1.HALL_CD, T1.MEAL, T1.CORNER, T2.HALL_NAME,								");
		sbQuery.append("\n       T3.CODE_NAME || T4.CODE_NAME || DECODE(T1.CORNER_DESC, NULL, '', '(' || T1.CORNER_DESC || ')') AS MENU_NAME,	");
		sbQuery.append("\n       T1.MENU_FEATURE, FSM_REAL_RECIPE_NAME_FUN(T1.UPJANG, T1.MENU_CD) AS MENU_CONSTRUCT, '1' AS CHK					");
		sbQuery.append("\n  FROM (SELECT A.UPJANG, A.MENU_CD, A.MENU_DATE, A.HALL_CD, A.MEAL, A.CORNER,											");
		sbQuery.append("\n               (SELECT AB.CORNER_DESC FROM FSA_HALL_DTL AB															");
		sbQuery.append("\n                 WHERE AB.UPJANG  = A.UPJANG																			");
		sbQuery.append("\n                   AND AB.HALL_CD = A.HALL_CD																			");
		sbQuery.append("\n                   AND AB.MEAL    = A.MEAL																			");
		sbQuery.append("\n                   AND AB.CORNER  = A.CORNER) AS CORNER_DESC, A.MENU_FEATURE											");
		sbQuery.append("\n          FROM FSM_REAL_MENU_MST A,																					");
		sbQuery.append("\n               FSM_REAL_RECIPE_MST B																					");
		sbQuery.append("\n         WHERE A.UPJANG = " + sUpjang + " -- 업장코드(필수 검색조건)														");
		if( !sHallCd.equals("00000") ) {
			sbQuery.append("\n           AND A.HALL_CD = '" + sHallCd + "' -- 식당코드(선택 검색조건)												");
		}
		sbQuery.append("\n           AND A.MENU_DATE BETWEEN '" + sFromMenuDate + "' AND '" + sToMenuDate + "' -- 제공일(필수 검색조건)				");
		sbQuery.append("\n           AND A.UPJANG = B.UPJANG																					");
		sbQuery.append("\n           AND A.MENU_CD = B.MENU_CD																					");
		sbQuery.append("\n         GROUP BY A.UPJANG, A.MENU_CD, A.MENU_DATE, A.HALL_CD, A.MEAL, A.CORNER, A.MENU_FEATURE ) T1,					");
		sbQuery.append("\n       (SELECT HALL_CD, HALL_NAME FROM FSA_HALL_MST WHERE UPJANG = " + sUpjang + " ) T2,								");
		sbQuery.append("\n       (SELECT CODE, CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0023') T3, -- 끼니(공통코드)					");
		sbQuery.append("\n       (SELECT CODE, CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0022') T4 -- 코너(공통코드)					");
		sbQuery.append("\n  WHERE T1.HALL_CD = T2.HALL_CD																						");
		sbQuery.append("\n    AND T1.MEAL = T3.CODE(+)																							");
		sbQuery.append("\n    AND T1.CORNER = T4.CODE(+)																						");
		
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