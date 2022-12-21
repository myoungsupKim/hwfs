<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 메뉴관리/식단관리
■ 프로그램ID   : FSM00280E_T001.jsp
■ 프로그램명   : 학교직군레시피수정-식단리스트조회
■ 작성일자     : 2008.02.18
■ 작성자       : 박지영
■ 이력관리     : 2008.02.18
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	try	{
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));
	
		//입력 데이타
		DataSet ds_input     = in_dl.get("ds_input");
	
		//FileLog.println("d:\\aaa.txt", ds_cond);
		
	
		String strUpjang 		= nullToBlank(ds_input.getString(0, "UPJANG"));
		String strHalCD			= nullToBlank(ds_input.getString(0, "HALL_CD"));
		String strMenuDate	= nullToBlank(ds_input.getString(0, "MENU_DATE"));


		//out 데이타
		DataSet ds_menu;
		
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		//내역조회
		//sbSql.append("-- 좌측 식단 내역 \n");
		sbSql.append("SELECT DISTINCT \n");
		sbSql.append("       A.MENU_CD, \n");
		sbSql.append("       (SELECT CODE_NAME FROM SCC_COMMON_CODE X WHERE X.GROUP_CODE = 'FS0023' AND X.CODE = A.MEAL) || \n");
		sbSql.append("       (SELECT CODE_NAME FROM SCC_COMMON_CODE X WHERE X.GROUP_CODE = 'FS0022' AND X.CODE = A.CORNER) MENU_NAME, \n");
		sbSql.append("       A.MEAL, A.CORNER, \n");
		sbSql.append("       DECODE(A.MEAL,NULL,A.MENU_FEATURE, \n");
		sbSql.append("       (SELECT CODE_NAME FROM SCC_COMMON_CODE X WHERE X.GROUP_CODE = 'FS0023' AND X.CODE = A.MEAL) || \n");
		sbSql.append("       (SELECT CODE_NAME FROM SCC_COMMON_CODE X WHERE X.GROUP_CODE = 'FS0022' AND X.CODE = A.CORNER) || \n");
		sbSql.append("       (SELECT DECODE(X.CORNER_DESC,NULL,'','('||X.CORNER_DESC||')') FROM FSA_HALL_DTL X WHERE X.UPJANG = A.UPJANG AND X.HALL_CD = A.HALL_CD AND X.MEAL = A.MEAL AND X.CORNER = A.CORNER)) MENU, \n");
		sbSql.append("       SUBINV_CODE, \n");
		sbSql.append("       NVL2(C.WORK_YN,C.WORK_YN,'') WORK_YN, \n");
		sbSql.append("       SALE_PRICE, EXPECT_MEAL_QTY, \n");
		sbSql.append("       '0' AS CHK \n");
		sbSql.append("  FROM FSM_REAL_MENU_MST A \n");
		sbSql.append("      ,( \n");
		sbSql.append("       SELECT DISTINCT UPJANG, MENU_CD, 'Y' WORK_YN \n");
		sbSql.append("          FROM FSM_MEAL_RECIPE_ADJUST \n");
		sbSql.append("         WHERE UPJANG = " + strUpjang + " \n");
		sbSql.append("           AND HALL_CD = '" + strHalCD + "' \n");
		sbSql.append("           AND MENU_DATE = '" + strMenuDate + "' \n");
		sbSql.append("       ) C \n");
		sbSql.append(" WHERE A.UPJANG = C.UPJANG(+) \n");
		sbSql.append("   AND A.MENU_CD = C.MENU_CD(+) \n");
		sbSql.append("   AND A.UPJANG = " + strUpjang + " \n");
		sbSql.append("   AND A.HALL_CD = '" + strHalCD + "' \n");
		sbSql.append("   AND A.MENU_DATE = '" + strMenuDate + "' \n");
		sbSql.append("   AND EXISTS (SELECT 1 \n");
		sbSql.append("                 FROM FSM_REAL_RECIPE_MST X \n");
		sbSql.append("                WHERE X.UPJANG = A.UPJANG \n");
		sbSql.append("                  AND X.MENU_CD = A.MENU_CD \n");
		sbSql.append("                  AND ROWNUM = 1 \n");
		sbSql.append("              ) \n");
		
		System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_menu = this.makeDataSet(rs, "ds_menu");
		
		rs.close();
		pstmt.close();

		/**종료**/
		out_dl.add(ds_menu);
		this.setResultMessage(0, "OK", out_vl);

	}
	catch(Exception ex)
	{
		//ex.printStackTrace();
		//jsp 로그남기기
		logger.debug(ex.getMessage(), ex);
		this.setResultMessage(-1, ex.toString(),out_vl); 
	}
	finally
	{
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
		//jsp log 서비스 닫기 
		try {
			logger.endIndividualLog();
		} catch( Exception logE) {
			logE.printStackTrace();
		}
	}

	proc_output(response,out,out_vl,out_dl);

%>
