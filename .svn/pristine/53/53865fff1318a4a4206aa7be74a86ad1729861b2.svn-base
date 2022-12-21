<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 메뉴관리/식단관리
■ 프로그램ID   : FSM00280E_T002.jsp
■ 프로그램명   : 학교직군레시피수정-레시피수정리스트조회
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
	
		//FileLog.println("d:\\aaa.txt", ds_input);
		
		String strUpjang 		= nullToBlank(ds_input.getString(0, "UPJANG"));
		String strSubinvCode	= nullToBlank(ds_input.getString(0, "SUBINV_CODE"));
		String strMenuDate		= nullToBlank(ds_input.getString(0, "MENU_DATE"));
		String strMenuCD		= nullToBlank(ds_input.getString(0, "MENU_CD"));
		String strAdjust		= nullToBlank(ds_input.getString(0, "ADJUST"));


		//out 데이타
		DataSet ds_list1;
		DataSet ds_list2;
		
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		if(strAdjust.equals("Y"))			// 수정된레시피
		{
			sbSql.delete(0, sbSql.length()); 
			sbSql.append("SELECT A.UPJANG \n");
			sbSql.append("      ,A.MENU_CD \n");
			sbSql.append("      ,A.MENU_DATE \n");
			sbSql.append("      ,A.MENU_NAME \n");
			sbSql.append("      ,A.HALL_CD \n");
			sbSql.append("      ,A.SUBINV_CODE \n");
			sbSql.append("      ,A.MEAL \n");
			sbSql.append("      ,A.CORNER \n");
			sbSql.append("      ,A.RECIPE_CD \n");
			sbSql.append("      ,C.RECIPE_NAME \n");
			sbSql.append("      ,A.ITEM_CODE \n");
			sbSql.append("      ,D.ITEM_NAME \n");
			sbSql.append("      ,D.ITEM_SIZE \n");
			sbSql.append("      ,D.PO_UOM \n");
			sbSql.append("      ,A.NEED_QTY \n");
			sbSql.append("      ,A.EDIBLE_QTY \n");
			sbSql.append("      ,ROUND(A.NEED_QTY * A.EXPECT_MEAL_QTY / 1000,2) TOT_QTY \n");
			sbSql.append("      ,DECODE( \n");
			sbSql.append("              SIGN((A.NEED_QTY*A.EXPECT_MEAL_QTY/1000/D.KG_CONVERT_RATE)-D.MIN_ORD_QTY),-1, \n");
			sbSql.append("                    DECODE(D.POINT_FLAG,'N',CEIL(D.MIN_ORD_QTY),D.MIN_ORD_QTY), \n");
			sbSql.append("                    DECODE(D.POINT_FLAG,'N',CEIL(A.NEED_QTY*A.EXPECT_MEAL_QTY/1000/D.KG_CONVERT_RATE), \n");
			sbSql.append("                          DECODE( D.MULTIPLIER_QTY, 0, (A.NEED_QTY*A.EXPECT_MEAL_QTY/1000/D.KG_CONVERT_RATE), \n");
			sbSql.append("                                                       CASE WHEN MOD((A.NEED_QTY*A.EXPECT_MEAL_QTY/1000/D.KG_CONVERT_RATE),D.MULTIPLIER_QTY) > 0 THEN (TRUNC((A.NEED_QTY*A.EXPECT_MEAL_QTY/1000/D.KG_CONVERT_RATE)/D.MULTIPLIER_QTY)*D.MULTIPLIER_QTY)+D.MULTIPLIER_QTY \n");
			sbSql.append("                                                       ELSE (A.NEED_QTY*A.EXPECT_MEAL_QTY/1000/D.KG_CONVERT_RATE) END \n");
			sbSql.append("                                ) \n");
			sbSql.append("                  ) \n");
			sbSql.append("             ) PR_QTY \n");
			//sbSql.append("      ,NVL(ROUND(ROUND(A.NEED_QTY * A.EXPECT_MEAL_QTY / 1000,2)*A.MARGIN_PRICE/D.KG_CONVERT_RATE),0) TOT_AMT \n");
			sbSql.append("      ,NVL(ROUND(ROUND(A.NEED_QTY * A.EXPECT_MEAL_QTY / 1000,2)*A.KG_PRICE),0) TOT_AMT \n");
			sbSql.append("      ,NVL(ROUND(A.PR_QTY*A.MARGIN_PRICE/10)*10,0) PR_AMT \n");
			//sbSql.append("      ,NVL(ROUND(A.MARGIN_PRICE/D.KG_CONVERT_RATE,2),0) KG_PRICE \n");
			sbSql.append("      ,NVL(A.KG_PRICE,0) KG_PRICE \n");
			sbSql.append("      ,A.UNIT_PRICE \n");
			sbSql.append("      ,A.MARGIN_PRICE \n");
			sbSql.append("      ,NVL(A.MARGIN_RATE,0) MARGIN_RATE \n");
			sbSql.append("      ,D.KG_CONVERT_RATE \n");
			sbSql.append("      ,D.POINT_FLAG \n");
			sbSql.append("      ,D.MIN_ORD_QTY \n");
			sbSql.append("      ,D.MULTIPLIER_QTY \n");
			sbSql.append("      ,A.SALE_PRICE \n");
			sbSql.append("      ,A.EXPECT_MEAL_QTY \n");
			sbSql.append("      ,NVL(E.DISUSE_RATE, 0) AS DISUSE_RATE \n");
			sbSql.append("  FROM FSM_MEAL_RECIPE_ADJUST A \n");
			sbSql.append("      ,FSM_REAL_MENU_MST B \n");
			sbSql.append("      ,FSM_REAL_RECIPE_MST C \n");
			sbSql.append("      ,HLDC_PO_ITEM_MST D \n");
			sbSql.append("      ,FSI_ITEM_NUT E \n");
			sbSql.append(" WHERE A.UPJANG = B.UPJANG \n");
			sbSql.append("   AND A.MENU_CD = B.MENU_CD \n");
			sbSql.append("   AND B.UPJANG = C.UPJANG \n");
			sbSql.append("   AND B.MENU_CD = C.MENU_CD \n");
			sbSql.append("   AND A.RECIPE_CD = C.RECIPE_CD \n");
			sbSql.append("   AND A.ITEM_CODE = D.ITEM_CODE \n");
			sbSql.append("   AND A.ITEM_CODE = E.ITEM_CODE(+) \n");
			sbSql.append("   AND A.UPJANG = " + strUpjang + " \n");
			sbSql.append("   AND A.MENU_DATE = '" + strMenuDate + "' \n");
			sbSql.append("   AND A.MENU_CD IN (" + strMenuCD + ") \n");
			sbSql.append(" ORDER BY MENU_CD, RECIPE_CD, NEED_QTY DESC \n");
			
		}
		else					// 실제식단조회
		{
			sbSql.delete(0, sbSql.length());
			
			sbSql.append("SELECT A.UPJANG \n");
			sbSql.append("      ,A.MENU_CD \n");
			sbSql.append("      ,A.MENU_DATE \n");
			sbSql.append("      ,DECODE(A.MEAL,NULL,A.MENU_FEATURE,A.MENU_NAME) MENU_NAME \n");
			sbSql.append("      ,A.HALL_CD \n");
			sbSql.append("      ,A.SUBINV_CODE \n");
			sbSql.append("      ,A.MEAL \n");
			sbSql.append("      ,A.CORNER \n");
			sbSql.append("      ,A.RECIPE_CD \n");
			sbSql.append("      ,A.RECIPE_NAME \n");
			sbSql.append("      ,A.ITEM_CODE \n");
			sbSql.append("      ,A.ITEM_NAME \n");
			sbSql.append("      ,A.ITEM_SIZE \n");
			sbSql.append("      ,A.PO_UOM \n");
			sbSql.append("      ,A.NEED_QTY \n");
			sbSql.append("      ,A.EDIBLE_QTY \n");
			sbSql.append("      ,A.TOT_QTY \n");
			sbSql.append("      ,A.PR_QTY \n");
			sbSql.append("      ,NVL(ROUND(A.TOT_QTY*ROUND(A.MARGIN_PRICE/A.KG_CONVERT_RATE/1000, 2)*1000),0) TOT_AMT \n");
			sbSql.append("      ,NVL(ROUND(A.PR_QTY*A.MARGIN_PRICE/10)*10,0) PR_AMT \n");
			sbSql.append("      ,NVL(ROUND(ROUND(A.MARGIN_PRICE/A.KG_CONVERT_RATE/1000, 2)*1000,2),0) KG_PRICE \n");
			sbSql.append("      ,NVL(A.UNIT_PRICE,0) UNIT_PRICE \n");
			sbSql.append("      ,NVL(A.MARGIN_PRICE,0) MARGIN_PRICE \n");
			sbSql.append("      ,NVL(A.MARGIN_RATE,0) MARGIN_RATE \n");
			sbSql.append("      ,A.KG_CONVERT_RATE \n");
			sbSql.append("      ,A.POINT_FLAG \n");
			sbSql.append("      ,A.MIN_ORD_QTY \n");
			sbSql.append("      ,A.MULTIPLIER_QTY \n");
			sbSql.append("      ,A.SALE_PRICE \n");
			sbSql.append("      ,A.EXPECT_MEAL_QTY \n");
			sbSql.append("      ,NVL(C.DISUSE_RATE, 0) AS DISUSE_RATE \n");
			sbSql.append("  FROM \n");
			sbSql.append("       ( \n");
			sbSql.append("        SELECT \n");
			sbSql.append("               A.UPJANG \n");
			sbSql.append("              ,A.MENU_CD \n");
			sbSql.append("              ,A.MENU_DATE \n");
			sbSql.append("              ,A.HALL_CD \n");
			sbSql.append("              ,A.SUBINV_CODE \n");
			sbSql.append("              ,A.MEAL \n");
			sbSql.append("              ,A.CORNER \n");
			sbSql.append("              ,DECODE(E.ATTR02,'Y',B.SALE_PRICE,DECODE(E.SET3,'Y',B.SALE_PRICE,A.SALE_PRICE)) SALE_PRICE  --수정 \n");
			sbSql.append("              ,DECODE(E.ATTR02,'Y',B.EXPECT_SALE_QTY,DECODE(E.SET3,'Y',B.EXPECT_SALE_QTY,A.EXPECT_MEAL_QTY)) EXPECT_MEAL_QTY --수정 \n");
			sbSql.append("              ,(SELECT CODE_NAME FROM SCC_COMMON_CODE X WHERE X.GROUP_CODE = 'FS0023' AND X.CODE = A.MEAL) || \n");
			sbSql.append("               (SELECT CODE_NAME FROM SCC_COMMON_CODE X WHERE X.GROUP_CODE = 'FS0022' AND X.CODE = A.CORNER) MENU_NAME \n");
			sbSql.append("              ,B.RECIPE_CD \n");
			sbSql.append("              ,B.RECIPE_NAME \n");
			sbSql.append("              ,B.RECIPE_TYPE \n");
			sbSql.append("              ,B.CUISINE_TYPE \n");
			sbSql.append("              ,B.RECIPE_SEQ \n");
			sbSql.append("              ,C.ITEM_CODE \n");
			sbSql.append("              ,D.ITEM_NAME \n");
			sbSql.append("              ,D.ITEM_SIZE \n");
			sbSql.append("              ,D.PO_UOM \n");
			sbSql.append("              ,C.NEED_QTY \n");
			sbSql.append("              ,C.EDIBLE_QTY \n");
			sbSql.append("              ,ROUND(C.NEED_QTY * DECODE(E.ATTR02,'Y',B.EXPECT_SALE_QTY,DECODE(E.SET3,'Y',B.EXPECT_SALE_QTY,A.EXPECT_MEAL_QTY)) / 1000,2) TOT_QTY --수정 \n");
			sbSql.append("              ,DECODE( \n");
			sbSql.append("                      SIGN((C.NEED_QTY*DECODE(E.ATTR02,'Y',B.EXPECT_SALE_QTY,DECODE(E.SET3,'Y',B.EXPECT_SALE_QTY,A.EXPECT_MEAL_QTY))/1000/D.KG_CONVERT_RATE)-D.MIN_ORD_QTY),-1, \n");
			sbSql.append("                            DECODE(D.POINT_FLAG,'N',CEIL(D.MIN_ORD_QTY),D.MIN_ORD_QTY), \n");
			sbSql.append("                            DECODE(D.POINT_FLAG,'N',CEIL(C.NEED_QTY*DECODE(E.ATTR02,'Y',B.EXPECT_SALE_QTY,DECODE(E.SET3,'Y',B.EXPECT_SALE_QTY,A.EXPECT_MEAL_QTY))/1000/D.KG_CONVERT_RATE), \n");
			sbSql.append("                                  DECODE( D.MULTIPLIER_QTY, 0, (C.NEED_QTY*DECODE(E.ATTR02,'Y',B.EXPECT_SALE_QTY,DECODE(E.SET3,'Y',B.EXPECT_SALE_QTY,A.EXPECT_MEAL_QTY))/1000/D.KG_CONVERT_RATE), \n");
			sbSql.append("                                                               CASE WHEN MOD((C.NEED_QTY*DECODE(E.ATTR02,'Y',B.EXPECT_SALE_QTY,DECODE(E.SET3,'Y',B.EXPECT_SALE_QTY,A.EXPECT_MEAL_QTY))/1000/D.KG_CONVERT_RATE),D.MULTIPLIER_QTY) > 0 THEN (TRUNC((C.NEED_QTY*DECODE(E.ATTR02,'Y',B.EXPECT_SALE_QTY,DECODE(E.SET3,'Y',B.EXPECT_SALE_QTY,A.EXPECT_MEAL_QTY))/1000/D.KG_CONVERT_RATE)/D.MULTIPLIER_QTY)*D.MULTIPLIER_QTY)+D.MULTIPLIER_QTY \n");
			sbSql.append("                                                               ELSE (C.NEED_QTY*DECODE(E.ATTR02,'Y',B.EXPECT_SALE_QTY,DECODE(E.SET3,'Y',B.EXPECT_SALE_QTY,A.EXPECT_MEAL_QTY))/1000/D.KG_CONVERT_RATE) END \n");
			sbSql.append("                                        ) \n");
			sbSql.append("                          ) \n");
			sbSql.append("                     ) PR_QTY  --수정 \n");
			sbSql.append("              ,C.UNIT_PRICE \n");
			sbSql.append("              ,C.MARGIN_PRICE \n");
			sbSql.append("              ,C.MARGIN_RATE \n");
			sbSql.append("              ,D.KG_CONVERT_RATE \n");
			sbSql.append("              ,D.POINT_FLAG \n");
			sbSql.append("              ,D.MIN_ORD_QTY \n");
			sbSql.append("              ,D.MULTIPLIER_QTY \n");
			sbSql.append("              ,A.MENU_FEATURE \n");
			sbSql.append("          FROM FSM_REAL_MENU_MST A \n");
			sbSql.append("              ,FSM_REAL_RECIPE_MST B \n");
			sbSql.append("              ,FSM_REAL_RECIPE_ITEM C \n");
			sbSql.append("              ,HLDC_PO_ITEM_MST D \n");
			sbSql.append("              ,SCC_COMMON_CODE E --추가 \n");
			sbSql.append("         WHERE A.UPJANG = B.UPJANG \n");
			sbSql.append("           AND A.MENU_CD = B.MENU_CD \n");
			sbSql.append("           AND B.UPJANG = C.UPJANG \n");
			sbSql.append("           AND B.MENU_CD = C.MENU_CD \n");
			sbSql.append("           AND B.RECIPE_CD = C.RECIPE_CD \n");
			sbSql.append("           AND C.ITEM_CODE = D.ITEM_CODE \n");
			sbSql.append("           AND SUBSTR(A.HALL_CD,1,3) = E.CODE --추가 \n");
			sbSql.append("           AND E.GROUP_CODE= 'FS0019'  --추가 \n");
			sbSql.append("           AND A.UPJANG = " + strUpjang + " \n");
			sbSql.append("           AND A.MENU_DATE = '" + strMenuDate + "' \n");
			sbSql.append("           AND A.MENU_CD IN (" + strMenuCD + ") \n");
			sbSql.append("       ) A \n");
			sbSql.append("       ,FSI_ITEM_NUT C \n");
			sbSql.append(" WHERE A.ITEM_CODE = C.ITEM_CODE(+) \n");
			sbSql.append(" ORDER BY MENU_CD, RECIPE_CD, NEED_QTY DESC \n");
			
		}
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		DataSet ds_list = this.makeDataSet(rs, "ds_list1");
		
		rs.close();
		pstmt.close();

		sbSql.delete(0, sbSql.length());
		//sbSql.append("-- 식재료 비율 계산을 위한 데이터 셋 \n");
		sbSql.append("SELECT MENU_CD, TOT_SALE_AMT \n");
		sbSql.append("  FROM ( \n");
		sbSql.append("        SELECT MENU_CD, SALE_PRICE*EXPECT_MEAL_QTY TOT_SALE_AMT \n");
		sbSql.append("          FROM FSM_REAL_MENU_MST A \n");
		sbSql.append("             , SCC_COMMON_CODE B \n");
		sbSql.append("         WHERE SUBSTR(A.HALL_CD,1,3) = B.CODE \n");
		sbSql.append("           AND B.GROUP_CODE= 'FS0019' \n");
		sbSql.append("           AND (B.ATTR02 <> 'Y' AND B.SET3 <> 'Y') \n");
		sbSql.append("           AND UPJANG = " + strUpjang + " \n");
		sbSql.append("           AND MENU_DATE = '" + strMenuDate + "' \n");
		sbSql.append("           AND MENU_CD IN (" + strMenuCD + ") \n");
		sbSql.append("        UNION ALL \n");
		sbSql.append("        SELECT A.MENU_CD, SUM(C.SALE_PRICE * C.EXPECT_SALE_QTY) TOT_SALE_AMT \n");
		sbSql.append("          FROM FSM_REAL_MENU_MST A \n");
		sbSql.append("             , SCC_COMMON_CODE B \n");
		sbSql.append("             , FSM_REAL_RECIPE_MST C \n");
		sbSql.append("         WHERE SUBSTR(A.HALL_CD,1,3) = B.CODE \n");
		sbSql.append("           AND A.UPJANG    = C.UPJANG \n");
		sbSql.append("           AND A.MENU_CD   = C.MENU_CD \n");
		sbSql.append("           AND B.GROUP_CODE= 'FS0019' \n");
		sbSql.append("           AND (B.ATTR02 = 'Y' OR B.SET3 = 'Y') \n");
		sbSql.append("           AND A.UPJANG = " + strUpjang + " \n");
		sbSql.append("           AND A.MENU_DATE = '" + strMenuDate + "' \n");
		sbSql.append("           AND A.MENU_CD IN (" + strMenuCD + ") \n");
		sbSql.append("        GROUP BY A.MENU_CD \n");
		sbSql.append("       ) \n");
		
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_list2 = this.makeDataSet(rs, "ds_list2");
		
		rs.close();
		pstmt.close();
		
		/**종료**/
		out_dl.add(ds_list);
		out_dl.add(ds_list2);
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