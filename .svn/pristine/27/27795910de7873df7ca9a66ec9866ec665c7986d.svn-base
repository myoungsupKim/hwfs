<%
/*-----------------------------------------------------------------------------
■ 시스템명     : FS식단/구매관리
■ 프로그램ID   : FSP00321P_T001.jsp
■ 프로그램명   : 상세내역
■ 작성일자     : 2009-09-09
■ 작성자       : 박은규
■ 이력관리     : 2009-09-09
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
		DataSet ds_Cond     = in_dl.get("ds_condi");

		//out 데이타
		DataSet ds_list;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		//내역조회
		sbSql.append("SELECT (SELECT Z.HALL_NAME FROM FSA_HALL_MST Z WHERE Z.UPJANG = A.UPJANG AND Z.HALL_CD = A.HALL_CD) AS HALL_NAME \n");
		sbSql.append("     , (SELECT Z.CODE_NAME FROM SCC_COMMON_CODE Z WHERE Z.GROUP_CODE = 'FS0023' AND Z.CODE = A.MEAL) AS MEAL_NAME \n");
		sbSql.append("     , (SELECT Z.CODE_NAME FROM SCC_COMMON_CODE Z WHERE Z.GROUP_CODE = 'FS0022' AND Z.CODE = A.CORNER) AS CORNER_NAME \n");
		sbSql.append("     , (SELECT Z.RECIPE_NAME FROM FSM_REAL_RECIPE_MST Z WHERE Z.UPJANG = B.UPJANG AND Z.MENU_CD = B.MENU_CD AND Z.RECIPE_CD = B.RECIPE_CD) AS RECIPE_NAME \n");
		sbSql.append("     , B.NEED_QTY * A.EXPECT_MEAL_QTY AS G_MENU_QTY \n");
		sbSql.append("     , ROUND(B.NEED_QTY * A.EXPECT_MEAL_QTY / C.KG_CONVERT_RATE / 1000, 1) AS MENU_QTY \n");
		sbSql.append("  FROM FSM_REAL_MENU_MST A, FSM_REAL_RECIPE_ITEM B, HLDC_PO_ITEM_MST C \n");
		sbSql.append(" WHERE A.UPJANG = B.UPJANG \n");
		sbSql.append("   AND A.MENU_CD = B.MENU_CD \n");
		sbSql.append("   AND B.ITEM_CODE = C.ITEM_CODE \n");
		sbSql.append("   AND A.UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + " \n");
		sbSql.append("   AND A.MENU_DATE = '" + nullToBlank(ds_Cond.getString(0, "MENU_DATE")) + "' \n");
		sbSql.append("   AND A.SUBINV_CODE = '" + nullToBlank(ds_Cond.getString(0, "SUBINV_CODE")) + "' \n");
		sbSql.append("   AND B.ITEM_CODE = '" + nullToBlank(ds_Cond.getString(0, "ITEM_CODE")) + "' \n");
		sbSql.append(" ORDER BY A.HALL_CD, A.MEAL, A.CORNER, 4 \n");

		out_vl.add("fa_Sql", sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_list = this.makeDataSet(rs, "ds_list");
		
		pstmt.close();
		rs.close();
		
		/**종료**/
		out_dl.add(ds_list);
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
