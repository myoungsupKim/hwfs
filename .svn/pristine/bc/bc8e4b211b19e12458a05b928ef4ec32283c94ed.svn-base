<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 메뉴관리/자재관리
■ 프로그램ID   : FSI00091V_T001.jsp
■ 프로그램명   : 업장별 사용현황조회
■ 작성일자     : 2008.02.12
■ 작성자       : 박지영
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
		DataSet ds_input     = in_dl.get("ds_input");
	
		//FileLog.println("d:\\aaa.txt", ds_input);
		
		/*
		ds_input.SetColumn(0,"DUTY_SEQ",ds_list.GetColumn(nRow,"DUTY_SEQ"));
		ds_input.SetColumn(0,"ITEM_CODE",ds_list.GetColumn(nRow,"ITEM_CODE"));
		ds_input.SetColumn(0,"START_DATE",ds_list.GetColumn(nRow,"START_DATE"));
		ds_input.SetColumn(0,"END_DATE",ds_list.GetColumn(nRow,"END_DATE"));
		*/
	
		String strDutySEQ 	= nullToBlank(ds_input.getString(0, "DUTY_SEQ"));
		String strItemCode	= nullToBlank(ds_input.getString(0, "ITEM_CODE"));
		String strStartDate	= nullToBlank(ds_input.getString(0, "START_DATE"));
		String strEndDate		= nullToBlank(ds_input.getString(0, "END_DATE"));
		String strUpjang		= nullToBlank(ds_input.getString(0, "SUB_UPJANG"));


		//out 데이타
		DataSet ds_list1;
		DataSet ds_list2;
		
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		sbSql.delete(0, sbSql.length()); 
		//sbSql.append("-- 업장별 사용현황 조회 디테일 \n");
		//sbSql.append("-- 좌측 그리드 \n");
		sbSql.append("SELECT D.SUBINV_NAME, A.MENU_DATE, E.HALL_NAME,B.RECIPE_CD, B.RECIPE_NAME, \n");
		sbSql.append("       DECODE(A.MEAL,NULL,A.MENU_FEATURE, \n");
		sbSql.append("       (SELECT CODE_NAME FROM SCC_COMMON_CODE X WHERE X.GROUP_CODE = 'FS0023' AND X.CODE = A.MEAL) || \n");
		sbSql.append("       (SELECT CODE_NAME FROM SCC_COMMON_CODE X WHERE X.GROUP_CODE = 'FS0022' AND X.CODE = A.CORNER) || \n");
		sbSql.append("       (SELECT DECODE(X.CORNER_DESC,NULL,'','('||X.CORNER_DESC||')') FROM FSA_HALL_DTL X WHERE X.UPJANG = A.UPJANG AND X.HALL_CD = A.HALL_CD AND X.MEAL = A.MEAL AND X.CORNER = A.CORNER)) MENU, \n");
		sbSql.append("       SUM(C.NEED_QTY) NEED_QTY, \n");
		sbSql.append("       DECODE(E.CAFE_YN,'Y',B.EXPECT_SALE_QTY,DECODE(E.CATER_YN,'Y',B.EXPECT_SALE_QTY,A.EXPECT_MEAL_QTY)) EXPECT_MEAL_QTY, \n");
		sbSql.append("       ROUND(SUM(C.NEED_QTY * DECODE(E.CAFE_YN,'Y',B.EXPECT_SALE_QTY,DECODE(E.CATER_YN,'Y',B.EXPECT_SALE_QTY,A.EXPECT_MEAL_QTY)) / F.KG_CONVERT_RATE / 1000),2) TOT_NEED_QTY, \n");
		sbSql.append("       F.PO_UOM \n");
		sbSql.append("  FROM FSM_REAL_MENU_MST A \n");
		sbSql.append("      ,FSM_REAL_RECIPE_MST B \n");
		sbSql.append("      ,FSM_REAL_RECIPE_ITEM C \n");
		sbSql.append("      ,HLDC_PO_SUBINVENTORY D \n");
		sbSql.append("      ,FSA_HALL_MST E \n");
		sbSql.append("      ,HLDC_PO_ITEM_MST F \n");
		sbSql.append(" WHERE A.UPJANG = B.UPJANG \n");
		sbSql.append("   AND A.MENU_CD = B.MENU_CD \n");
		sbSql.append("   AND B.UPJANG = C.UPJANG \n");
		sbSql.append("   AND B.MENU_CD = C.MENU_CD \n");
		sbSql.append("   AND B.RECIPE_CD = C.RECIPE_CD \n");
		sbSql.append("   AND A.SUBINV_CODE = D.SUBINV_CODE \n");
		sbSql.append("   AND A.UPJANG = E.UPJANG \n");
		sbSql.append("   AND A.HALL_CD = E.HALL_CD \n");
		sbSql.append("   AND C.ITEM_CODE = F.ITEM_CODE \n");
		sbSql.append("   AND A.UPJANG = " + strUpjang + " \n");
		sbSql.append("   AND C.NEED_DATE BETWEEN '" + strStartDate + "' AND '" + strEndDate + "' \n");
		sbSql.append("   AND C.ITEM_CODE = '" + strItemCode + "' \n");
		sbSql.append(" GROUP BY A.UPJANG,A.HALL_CD,D.SUBINV_NAME, A.MENU_DATE, E.HALL_NAME, B.RECIPE_CD, B.RECIPE_NAME, A.MEAL, A.CORNER \n");
		sbSql.append("         ,A.EXPECT_MEAL_QTY, B.EXPECT_SALE_QTY, F.KG_CONVERT_RATE, F.PO_UOM, E.CATER_YN, E.CAFE_YN,A.MENU_FEATURE \n");
		sbSql.append(" ORDER BY D.SUBINV_NAME, A.MENU_DATE, E.HALL_NAME, A.MEAL, A.CORNER, B.RECIPE_CD \n");
		
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery(); 
		DataSet ds_Detail1 = this.makeDataSet(rs, "ds_list1");
		
		rs.close();
		pstmt.close();

		sbSql.delete(0, sbSql.length());
		//sbSql.append("-- 우측 그리드 \n");
		sbSql.append("SELECT A.SUBINV_CODE, \n");
		sbSql.append("       (SELECT Z.SUBINV_NAME FROM HLDC_PO_SUBINVENTORY Z WHERE Z.SUBINV_CODE = A.SUBINV_CODE) AS SUBINV_NAME, \n");
		sbSql.append("       A.NEED_DATE, \n");
		sbSql.append("       SUM(PR_QTY) PR_QTY, --신청량 \n");
		sbSql.append("       SUM(TRANS_QTY) TRANS_QTY --입고량 \n");
		sbSql.append("  FROM \n");
		sbSql.append("       ( \n");
/*
		sbSql.append("                SELECT SUBINV_CODE, NEED_DATE, PR_QTY, 0 TRANS_QTY \n");
		sbSql.append("                  FROM HLDC_PO_PR \n");
		sbSql.append("                 WHERE RC_MU_CD = 'YA' \n");
		sbSql.append("                   AND LINE_STATUS >= '004' \n");
		sbSql.append("                   AND SUBINV_CODE LIKE 'C%' \n");
		sbSql.append("                   AND RC_UPJANG = " + strUpjang + " \n");
		sbSql.append("                   AND ITEM_CODE = '" + strItemCode + "' \n");
		sbSql.append("                   AND NEED_DATE BETWEEN '" + strStartDate + "' AND '" + strEndDate + "' \n");
		sbSql.append("                UNION ALL \n");
*/
		sbSql.append("                SELECT SUBINV_CODE, TRANS_DATE AS NEED_DATE, 0 PR_QTY \n");
		sbSql.append("                     , DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * A.TRANS_QTY AS TRANS_QTY \n");
		sbSql.append("                  FROM HLDC_PO_TRANSACTION A \n");
		sbSql.append("                 WHERE TRANS_MU_CD = '2002' \n");
		//sbSql.append("                   AND SUBINV_CODE LIKE 'C%' \n");
		//TRANS_TYPE = 'I001':정상입고(PO)/반품출고(INV)  OR  SOURCE_TYE = 'PO':센터인수입고/센터반송이관출고
		//sbSql.append("                   AND TRANS_TYPE = 'I001' \n");
		sbSql.append("                   AND (A.TRANS_TYPE = 'I001' OR (A.TRANS_TYPE LIKE '_002' AND A.SOURCE_TYPE = 'PO')) \n");
		sbSql.append("                   AND TRANS_UPJANG = '" + strUpjang + "' \n");
		sbSql.append("                   AND ITEM_CODE = '" + strItemCode + "' \n");
		sbSql.append("                   AND TRANS_DATE BETWEEN '" + strStartDate + "' AND '" + strEndDate + "' \n");
		sbSql.append("       ) A \n");
		sbSql.append(" GROUP BY A.SUBINV_CODE, A.NEED_DATE \n");
		
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		DataSet ds_Detail2 = this.makeDataSet(rs, "ds_list2");
		
		rs.close();
		pstmt.close();
		
		/**종료**/
		out_dl.add(ds_Detail1);
		out_dl.add(ds_Detail2);
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