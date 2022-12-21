<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/주문관리
■ 프로그램ID   : FMP00130E_T002.jsp
■ 프로그램명   : 식단발주상품 조회 / 소요량 상세내역
■ 작성일자     : 2008.02.12
■ 작성자       : 박은규
■ 이력관리     : 2008.02.12
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
		//DataSet ds_cond     = in_dl.get("ds_Cond");
		//입력 파라메터
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		String sUpjang      = nullToBlank(in_vl.getString("sUpjang"));
		String sSubinv      = nullToBlank(in_vl.getString("sSubinv"));
		String sNeedDate    = nullToBlank(in_vl.getString("sNeedDate"));
		String sItemCode    = nullToBlank(in_vl.getString("sItemCode"));
		String sItemName    = nullToBlank(in_vl.getString("sItemName"));
		String sKgCon       = nullToBlank(in_vl.getString("sKgCon"));
		String sPrID        = nullToBlank(in_vl.getString("sPrID"));
		//FileLog.println("d:\\aaa.txt", ds_cond);


		//out 데이타
		DataSet ds_list;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		//내역조회
		sbSql.append("SELECT C.ITEM_CODE, '" + sItemName + "' AS ITEM_NAME \n");
		sbSql.append("     , TO_CHAR(TO_DATE(A.MENU_DATE,'YYYYMMDD'),'YYYY-MM-DD') AS MENU_DATE \n");
		sbSql.append("     , A.MEAL \n");
		sbSql.append("     , (SELECT Z.CODE_NAME FROM SCC_COMMON_CODE Z WHERE Z.GROUP_CODE = 'FS0023' AND Z.CODE = A.MEAL) AS MEAL_NAME \n");
		sbSql.append("     , A.CORNER \n");
		sbSql.append("     , (SELECT Z.CODE_NAME FROM SCC_COMMON_CODE Z WHERE Z.GROUP_CODE = 'FS0022' AND Z.CODE = A.CORNER) AS CORNER_NAME \n");
		sbSql.append("     , B.RECIPE_NAME \n");
		sbSql.append("     , ROUND(SUM(A.EXPECT_MEAL_QTY * C.NEED_QTY / 1000),2) AS TOT_QTY \n");
		sbSql.append("     , ROUND(SUM(A.EXPECT_MEAL_QTY * C.NEED_QTY / 1000 / " + sKgCon + "),1) AS ORD_QTY \n");
		sbSql.append("     , C.NEED_QTY \n");
		sbSql.append("     , A.EXPECT_MEAL_QTY \n");
		sbSql.append("  FROM FMM_MENU A, FMM_RECIPE B, FMM_RECIPE_ITEM C \n");
		sbSql.append(" WHERE A.UPJANG = B.UPJANG \n");
		sbSql.append("   AND A.MENU_CD = B.MENU_CD \n");
		sbSql.append("   AND B.UPJANG = C.UPJANG \n");
		sbSql.append("   AND B.MENU_CD = C.MENU_CD \n");
		sbSql.append("   AND B.RECIPE_CD = C.RECIPE_CD \n");
		sbSql.append("   AND A.UPJANG = " + sUpjang + " \n");
		//sbSql.append("   AND A.MENU_CD LIKE '" + sNeedDate + "-" + sSubinv + "%' \n");
		sbSql.append("   AND A.SUBINV_CODE = '" + sSubinv + "' \n");
		sbSql.append("   AND C.NEED_DATE = '" + sNeedDate + "' \n");
		sbSql.append("   AND C.ITEM_CODE = '" + sItemCode + "' \n");
		if (sPrID.equals(""))
			sbSql.append("   AND C.PR_YN = 'N' \n");
		else
		{
			sbSql.append("   AND C.PR_ID = " + sPrID + " \n");
			sbSql.append("   AND C.PR_YN = 'Y' \n");
		}
		sbSql.append(" GROUP BY C.ITEM_CODE, A.MENU_DATE, A.MEAL, A.CORNER, B.RECIPE_NAME \n");
		sbSql.append("        , C.NEED_QTY \n");
		sbSql.append("        , A.EXPECT_MEAL_QTY \n");

out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_list = this.makeDataSet(rs, "ds_List");
		
		pstmt.close();
		rs.close();
		
		//FileLog.println("d:\\aaa.txt", ds_list);

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
