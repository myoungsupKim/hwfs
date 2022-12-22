<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식단관리[DS_body]
■ 프로그램ID   : FSM00052E_S003.jsp
■ 프로그램명   : 주간 식단 조회
■ 작성일자     : 
■ 작성자       : 
■ 이력관리     : 
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
		String UPJANG	    = nullToBlank(in_vl.getString("UPJANG"));
		String HALL_CD      = nullToBlank(in_vl.getString("HALL_CD"));
		String MENU_SDATE   = nullToBlank(in_vl.getString("MENU_SDATE"));
		String SUBINV_CODE  = nullToBlank(in_vl.getString("SUBINV_CODE"));
		//FileLog.println("d:\\aaa.txt", ds_cond);

		//out 데이타
		DataSet DS_body;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		//내역조회
        sbSql.append("SELECT A.MENU_DATE AS FDAY ,                                                                                                                                                                                                                                                                                        \n");
        sbSql.append("       A.MENU_CD ,                                                                                                                                                                                                                                                                                             \n");
        sbSql.append("       A.MEAL AS SGBN ,                                                                                                                                                                                                                                                                                             \n");
        sbSql.append("       (                                                                                                                                                                                                                                                                                                            \n");
        sbSql.append("       SELECT CODE_NAME                                                                                                                                                                                                                                                                                             \n");
        sbSql.append("         FROM SCC_COMMON_CODE                                                                                                                                                                                                                                                                                       \n");
        sbSql.append("        WHERE GROUP_CODE = 'FS0023'                                                                                                                                                                                                                                                                                 \n");
        sbSql.append("          AND CODE = A.MEAL                                                                                                                                                                                                                                                                                         \n");
        sbSql.append("       ) SGBN_NM ,                                                                                                                                                                                                                                                                                                  \n");
        sbSql.append("       A.CORNER AS CGBN_CD,                                                                                                                                                                                                                                                                                         \n");
        sbSql.append("       A.CORNER_DESC AS CGBN_NM ,                                                                                                                                                                                                                                                                                   \n");
        sbSql.append("       (                                                                                                                                                                                                                                                                                                            \n");
        sbSql.append("       SELECT CODE_NAME                                                                                                                                                                                                                                                                                             \n");
        sbSql.append("         FROM SCC_COMMON_CODE                                                                                                                                                                                                                                                                                       \n");
        sbSql.append("        WHERE GROUP_CODE = 'FS0022'                                                                                                                                                                                                                                                                                 \n");
        sbSql.append("          AND CODE = A.CORNER                                                                                                                                                                                                                                                                                       \n");
        sbSql.append("       ) CGBN ,                                                                                                                                                                                                                                                                                                     \n");
        sbSql.append("       A.PHF ,                                                                                                                                                                                                                                                                                                      \n");
        sbSql.append("       '' DUP_STA ,                                                                                                                                                                                                                                                                                                 \n");
        sbSql.append("       '' DUP_COLOR ,                                                                                                                                                                                                                                                                                               \n");
        sbSql.append("       ROW_NUMBER( ) OVER(PARTITION BY MENU_DATE, MEAL, CORNER ORDER BY MEAL, CORNER, RECIPE_SEQ, CUISINE_TYPE ASC) SSEQ ,                                                                                                                                                                                          \n");
        sbSql.append("       A.RECIPE_CD AS SD_CD ,                                                                                                                                                                                                                                                                                       \n");
        sbSql.append("       A.RECIPE_NAME AS SD_NM ,                                                                                                                                                                                                                                                                                     \n");
        sbSql.append("       NVL(ROUND(SUM( (A.NEED_QTY * NVL(G_ITEM_PRICE, 0) ) ) ) , 0) SD_WON ,                                                                                                                                                                                                                                        \n");
        sbSql.append("       A.MEAL_UPRICE AS MEAL_PRICE ,                                                                                                                                                                                                                                                                                \n");
        sbSql.append("       CASE                                                                                                                                                                                                                                                                                                         \n");
        sbSql.append("              WHEN A.CAFE_YN = 'Y'                                                                                                                                                                                                                                                                                  \n");
        sbSql.append("              THEN DECODE(A.SALE_PRICE2, 0, 0, ROUND(NVL(ROUND(SUM( (A.NEED_QTY * NVL(G_ITEM_PRICE, 0) ) ) ) , 0)/A.SALE_PRICE2*100, 1) )||'%'                                                                                                                                                                      \n");
        sbSql.append("              ELSE DECODE(A.SALE_PRICE, 0, 0, ROUND(NVL(ROUND(SUM( (A.NEED_QTY * NVL(G_ITEM_PRICE, 0) ) ) ) , 0)/A.SALE_PRICE *100, 1) )||'%'                                                                                                                                                                       \n");
        sbSql.append("       END                                                                                                                                                                                                                                                                                                          \n");
        sbSql.append("       AS RECIPE_COST_RATE ,                                                                                                                                                                                                                                                                                        \n");
        sbSql.append("       A.SALE_PRICE ,                                                                                                                                                                                                                                                                                               \n");
        sbSql.append("       A.SALE_PRICE2 ,                                                                                                                                                                                                                                                                                              \n");
        sbSql.append("       A.EXPECT_SALE_QTY ,                                                                                                                                                                                                                                                                                          \n");
        sbSql.append("       A.EXPECT_MEAL_QTY ,                                                                                                                                                                                                                                                                                          \n");
        sbSql.append("       A.MAIN_ITEM_CODE1 ,                                                                                                                                                                                                                                                                                          \n");
        sbSql.append("       A.CUISINE_TYPE ,                                                                                                                                                                                                                                                                                             \n");
        sbSql.append("       NVL(ROUND(SUM( (A.NEED_QTY * NVL(G_ITEM_PRICE, 0) ) ) ) , 0) * A.EXPECT_SALE_QTY AS EXPECT_WON_AMT ,                                                                                                                                                                                                         \n");
        sbSql.append("       A.SALE_PRICE2 * A.EXPECT_SALE_QTY AS EXPECT_SALE_AMT,                                                                                                                                                                                                                                                        \n");
        sbSql.append("       A.MEAL || A.CORNER || ROW_NUMBER() OVER(PARTITION BY MENU_DATE, MEAL, CORNER ORDER BY MEAL, CORNER, RECIPE_SEQ, CUISINE_TYPE ASC) AS KEY,                                                                                                                                                                    \n");
        sbSql.append("       TO_CHAR(TO_DATE(A.MENU_DATE), 'd') AS WEEK,                                                                                                                                                                                                                                                                  \n");        
        sbSql.append("       A.ATTR02 AS ATTR02,                                                                                                                                                                                                                                                                                           \n");
        sbSql.append("       A.ATTR03 AS ATTR03,  --메인이미지                                                                                                                                                                                                                                                                                           \n");
        sbSql.append("       A.ATTR04 AS ATTR04   --평가대상                                                                                                                                                                                                                                                                                         \n");
        sbSql.append("  FROM                                                                                                                                                                                                                                                                                                              \n");
        sbSql.append("       (                                                                                                                                                                                                                                                                                                            \n");
        sbSql.append("       SELECT A.UPJANG,                                                                                                                                                                                                                                                                                             \n");
        sbSql.append("              A.MENU_DATE,                                                                                                                                                                                                                                                                                          \n");
        sbSql.append("              A.MENU_CD,                                                                                                                                                                                                                                                                                            \n");        
        sbSql.append("              A.MEAL,                                                                                                                                                                                                                                                                                               \n");
        sbSql.append("              A.CORNER,                                                                                                                                                                                                                                                                                             \n");
        sbSql.append("              D.CORNER_DESC,                                                                                                                                                                                                                                                                                        \n");
        sbSql.append("              B.RECIPE_CD,                                                                                                                                                                                                                                                                                          \n");
        sbSql.append("              B.RECIPE_NAME,                                                                                                                                                                                                                                                                                        \n");
        sbSql.append("              B.RECIPE_SEQ,                                                                                                                                                                                                                                                                                         \n");
        sbSql.append("              B.CUISINE_TYPE,                                                                                                                                                                                                                                                                                       \n");
        sbSql.append("              C.ITEM_CODE,                                                                                                                                                                                                                                                                                          \n");
        sbSql.append("              C.NEED_QTY,                                                                                                                                                                                                                                                                                           \n");
        sbSql.append("              NVL(D.MEAL_UPRICE, 0) MEAL_UPRICE,                                                                                                                                                                                                                                                                    \n");
        sbSql.append("              PHF,                                                                                                                                                                                                                                                                                                  \n");
        sbSql.append("              A.SALE_PRICE,                                                                                                                                                                                                                                                                                         \n");
        sbSql.append("              B.MAIN_ITEM_CODE1,                                                                                                                                                                                                                                                                                    \n");
        sbSql.append("              A.EXPECT_MEAL_QTY,                                                                                                                                                                                                                                                                                    \n");
        sbSql.append("              B.SALE_PRICE AS SALE_PRICE2,                                                                                                                                                                                                                                                                          \n");
        sbSql.append("              B.EXPECT_SALE_QTY,                                                                                                                                                                                                                                                                                    \n");
        sbSql.append("              E.CATER_YN,                                                                                                                                                                                                                                                                                           \n");
        sbSql.append("              E.CAFE_YN,                                                                                                                                                                                                                                                                                             \n");
        sbSql.append("              C.MARGIN_PRICE AS ITEM_PRICE,                          \n");
        sbSql.append("              F.KG_CONVERT_RATE,                                                                                                                                                                                                                                                                                      \n");
        sbSql.append("              ROUND(C.MARGIN_PRICE/F.KG_CONVERT_RATE/1000, 2) AS G_ITEM_PRICE, \n");
        sbSql.append("              NVL(B.ATTR02, 0) AS ATTR02, \n");
        sbSql.append("              NVL(B.ATTR03, 0) AS ATTR03, \n");
        sbSql.append("              NVL(B.ATTR04, 0) AS ATTR04 \n");
        sbSql.append("         FROM FSM_REAL_MENU_MST A ,                                                                                                                                                                                                                                                                                 \n");
        sbSql.append("              FSM_REAL_RECIPE_MST B ,                                                                                                                                                                                                                                                                               \n");
        sbSql.append("              FSM_REAL_RECIPE_ITEM C ,                                                                                                                                                                                                                                                                              \n");
        sbSql.append("              FSA_HALL_DTL D ,                                                                                                                                                                                                                                                                                      \n");
        sbSql.append("              FSA_HALL_MST E ,                                                                                                                                                                                                                                                                                       \n");
        sbSql.append("              HLDC_PO_ITEM_MST F                                                                                                                                                                                                                                                                                    \n");
        sbSql.append("        WHERE A.UPJANG = B.UPJANG                                                                                                                                                                                                                                                                                   \n");
        sbSql.append("          AND A.MENU_CD = B.MENU_CD                                                                                                                                                                                                                                                                                 \n");
        sbSql.append("          AND B.UPJANG = C.UPJANG                                                                                                                                                                                                                                                                                   \n");
        sbSql.append("          AND B.MENU_CD = C.MENU_CD                                                                                                                                                                                                                                                                                 \n");
        sbSql.append("          AND B.RECIPE_CD = C.RECIPE_CD                                                                                                                                                                                                                                                                             \n");
        sbSql.append("          AND A.UPJANG = E.UPJANG                                                                                                                                                                                                                                                                                   \n");
        sbSql.append("          AND A.HALL_CD = E.HALL_CD                                                                                                                                                                                                                                                                                 \n");
        sbSql.append("          AND A.UPJANG = D.UPJANG                                                                                                                                                                                                                                                                                   \n");
        sbSql.append("          AND A.HALL_CD = D.HALL_CD                                                                                                                                                                                                                                                                                 \n");
        sbSql.append("          AND A.MEAL = D.MEAL                                                                                                                                                                                                                                                                                       \n");
        sbSql.append("          AND A.CORNER = D.CORNER                                                                                                                                                                                                                                                                                   \n");
        sbSql.append("          AND C.ITEM_CODE = F.ITEM_CODE                                                                                                                                                                                                                                                                                   \n");
        sbSql.append("          AND A.MEAL IS NOT NULL                                                                                                                                                                                                                                                                                    \n");
        sbSql.append("          AND A.CORNER IS NOT NULL                                                                                                                                                                                                                                                                                  \n");
        sbSql.append("          AND A.UPJANG = ?                                                                                                                                                                                                                                                                                 \n");
        sbSql.append("          AND A.HALL_CD = ?                                                                                                                                                                                                                                                                             \n");
        sbSql.append("          AND A.MENU_DATE BETWEEN TO_CHAR(TO_DATE(?, 'YYYYMMDD' )+0, 'YYYYMMDD' ) AND TO_CHAR(TO_DATE(?, 'YYYYMMDD' )+6, 'YYYYMMDD' )                                                                                                                                                 \n");
        sbSql.append("       ) A                                                                                                                                                                                                                                                                                                         \n");
        sbSql.append(" GROUP BY A.MENU_DATE ,                                                                                                                                                                                                                                                                                             \n");
        sbSql.append("       A.MENU_CD ,                                                                                                                                                                                                                                                                                             \n");        
        sbSql.append("       A.RECIPE_SEQ ,                                                                                                                                                                                                                                                                                               \n");
        sbSql.append("       A.CUISINE_TYPE ,                                                                                                                                                                                                                                                                                             \n");
        sbSql.append("       A.MEAL ,                                                                                                                                                                                                                                                                                                     \n");
        sbSql.append("       A.CORNER ,                                                                                                                                                                                                                                                                                                   \n");
        sbSql.append("       A.CORNER_DESC ,                                                                                                                                                                                                                                                                                              \n");
        sbSql.append("       A.RECIPE_CD ,                                                                                                                                                                                                                                                                                                \n");
        sbSql.append("       A.RECIPE_NAME ,                                                                                                                                                                                                                                                                                              \n");
        sbSql.append("       A.MEAL_UPRICE ,                                                                                                                                                                                                                                                                                              \n");
        sbSql.append("       A.PHF ,                                                                                                                                                                                                                                                                                                      \n");
        sbSql.append("       A.SALE_PRICE ,                                                                                                                                                                                                                                                                                               \n");
        sbSql.append("       A.SALE_PRICE2 ,                                                                                                                                                                                                                                                                                              \n");
        sbSql.append("       A.EXPECT_MEAL_QTY ,                                                                                                                                                                                                                                                                                          \n");
        sbSql.append("       A.EXPECT_SALE_QTY ,                                                                                                                                                                                                                                                                                          \n");
        sbSql.append("       A.CAFE_YN ,                                                                                                                                                                                                                                                                                                  \n");
        sbSql.append("       A.MAIN_ITEM_CODE1,                                                                                                                                                                                                                                                                                           \n");
        sbSql.append("       A.ATTR02,                                                                                                                                                                                                                                                                                                     \n");
        sbSql.append("       A.ATTR03,                                                                                                                                                                                                                                                                                                     \n");
        sbSql.append("       A.ATTR04                                                                                                                                                                                                                                                                                                     \n");
        sbSql.append(" ORDER BY SGBN, CGBN_CD, SSEQ, A.MENU_DATE                                                                                                                                                                                                                                                                          \n");
        
        out_vl.add("fa_Sql", sbSql.toString());
        //System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());
		pstmt.setString(1, UPJANG);
		pstmt.setString(2, HALL_CD);
		pstmt.setString(3, MENU_SDATE);
		pstmt.setString(4, MENU_SDATE);
		
		rs = pstmt.executeQuery();
		DS_body = this.makeDataSet(rs, "DS_body");
		
		rs.close();
		pstmt.close();
		
		/**종료**/
		out_dl.add(DS_body);
		this.setResultMessage(0, "OK", out_vl);

	}
	catch(Exception ex)
	{
		//ex.printStackTrace();
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
