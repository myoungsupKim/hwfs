<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/식단관리[DS_body]
■ 프로그램ID   : FMM00200V_S001.jsp
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
		//입력 데이타
		DataSet ds_cond     = in_dl.get("ds_Cond");
		//입력 파라메터
		String UPJANG	    = nullToBlank(in_vl.getString("UPJANG"));
		String SUBINV_CODE  = nullToBlank(in_vl.getString("SUBINV_CODE"));
		String MENU_SDATE   = nullToBlank(in_vl.getString("MENU_SDATE"));
		//FileLog.println("d:\\aaa.txt", ds_cond);

		//out 데이타
		DataSet DS_body;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		//내역조회
        sbSql.append("  SELECT /*+ USE_HASH (B A) */                                                                                                                                    \n");
        sbSql.append("-- 메인조회 [ DS_body ]                                                                                                                                           \n");
        sbSql.append("       A.MENU_DATE AS FDAY      --메뉴일자                                                                                                                        \n");
        sbSql.append("      ,A.MEAL AS SGBN       --                                                                                                                                    \n");
        sbSql.append("      ,(SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0023' AND CODE = A.MEAL) SGBN_NM                                                              \n");
        sbSql.append("      ,A.CORNER AS CGBN_CD, A.CORNER_DESC AS CGBN_NM                                                                                                              \n");
        sbSql.append("      ,(SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0022' AND CODE = A.CORNER) CGBN                                                               \n");
        sbSql.append("      ,A.PHF                                                                                                                                                      \n");
        sbSql.append("      ,'' DUP_STA                                                                                                                                                 \n");
        sbSql.append("      ,'' DUP_COLOR                                                                                                                                               \n");
        sbSql.append("      ,ROW_NUMBER() OVER(PARTITION BY MENU_DATE, MEAL, CORNER ORDER BY MEAL, CORNER, CUISINE_TYPE ASC) SSEQ                                                       \n");
        sbSql.append("      ,A.RECIPE_CD AS SD_CD                                                                                                                                       \n");
        sbSql.append("      ,A.RECIPE_NAME AS SD_NM                                                                                                                                     \n");
        sbSql.append("      ,NVL(ROUND(SUM( (A.NEED_QTY * NVL(A.OP_PRICE,0)))),0) SD_WON                                                                                                  \n");
        sbSql.append("      ,A.MEAL_UPRICE AS MEAL_PRICE                                                                                                                                \n");
        sbSql.append("      ,DECODE(A.SALE_PRICE,0,0,ROUND(NVL(ROUND(SUM( (A.NEED_QTY * NVL(A.OP_PRICE,0)))),0)/A.SALE_PRICE*100,1)) RECIPE_COST_RATE                                     \n");
        sbSql.append("      ,DECODE(A.SALE_PRICE,0,A.MEAL_UPRICE,A.SALE_PRICE) AS SALE_PRICE                                                                                            \n");
        sbSql.append("      ,A.MAIN_ITEM_CODE1                                                                                                                                          \n");
        sbSql.append("      ,A.CUISINE_TYPE                                                                                                                                             \n");
        sbSql.append("      ,A.EXPECT_MEAL_QTY                                                                                                                                         \n");
        sbSql.append("        FROM    (                                                                                                                                                 \n");
        sbSql.append("  SELECT A.UPJANG, A.MENU_DATE, A.MEAL, A.CORNER, D.CORNER_DESC, \n");
    	sbSql.append("                B.RECIPE_CD, B.RECIPE_NAME, B.CUISINE_TYPE, C.ITEM_CODE, C.NEED_QTY, E.KG_CONVERT_RATE,  \n");
    	sbSql.append("            --    ROUND((NVL(C.UNIT_PRICE,0)/E.KG_CONVERT_RATE/1000),2) AS OP_PRICE ,  \n");
    	sbSql.append("                DECODE(NVL(C.OP_RATE,0),0,ROUND((NVL(C.UNIT_PRICE,0)/E.KG_CONVERT_RATE/1000),2),ROUND((NVL(C.OP_PRICE,0)/E.KG_CONVERT_RATE/1000),2)) AS OP_PRICE ,  \n");    	
    	sbSql.append("                NVL(D.MEAL_PRICE,0) MEAL_UPRICE, PHF, A.SALE_PRICE, B.MAIN_ITEM_CODE1, A.EXPECT_MEAL_QTY \n");
    	sbSql.append("           FROM \n");
    	sbSql.append("                FMM_MENU A  \n");
    	sbSql.append("               ,FMM_RECIPE B  \n");
    	sbSql.append("               ,FMM_RECIPE_ITEM C  \n");
    	sbSql.append("               ,FMS_MEAL_CORNER D  \n");
    	sbSql.append("               ,FMS_ITEM_V E  \n");
    	sbSql.append("          WHERE A.UPJANG = B.UPJANG  \n");
    	sbSql.append("            AND A.MENU_CD = B.MENU_CD  \n");
    	sbSql.append("            AND B.UPJANG = C.UPJANG  \n");
    	sbSql.append("            AND B.MENU_CD = C.MENU_CD  \n");
    	sbSql.append("            AND B.RECIPE_CD = C.RECIPE_CD  \n");
    	sbSql.append("            AND A.SUBINV_CODE = D.SUBINV_CODE  \n");
    	sbSql.append("            AND A.MEAL = D.MEAL  \n");
    	sbSql.append("            AND A.CORNER = D.CORNER  \n");
    	sbSql.append("            AND C.ITEM_CODE = E.ITEM_CODE  \n");
    	sbSql.append("            AND A.MEAL IS NOT NULL  \n");
    	sbSql.append("            AND A.CORNER IS NOT NULL  \n");
    	sbSql.append("            AND A.UPJANG = '"+UPJANG+"'  \n");
    	sbSql.append("            AND A.SUBINV_CODE = '"+SUBINV_CODE+"'  \n");
    	sbSql.append("            AND A.MENU_DATE BETWEEN TO_CHAR(TO_DATE('"+MENU_SDATE+"','YYYYMMDD'),'YYYYMMDD') AND TO_CHAR(TO_DATE('"+MENU_SDATE+"','YYYYMMDD')+6,'YYYYMMDD')  \n");
    	sbSql.append("        ) A  \n");
    	sbSql.append("  WHERE (1=1)  \n");
    	sbSql.append("  GROUP BY A.MENU_DATE  \n");
    	sbSql.append("          ,A.CUISINE_TYPE  \n");
    	sbSql.append("          ,A.MEAL  \n");
    	sbSql.append("          ,A.CORNER  \n");
    	sbSql.append("          ,A.CORNER_DESC  \n");
    	sbSql.append("          ,A.RECIPE_CD  \n");
    	sbSql.append("          ,A.RECIPE_NAME  \n");
    	sbSql.append("          ,A.MEAL_UPRICE  \n");
    	sbSql.append("          ,A.PHF  \n");
    	sbSql.append("          ,A.SALE_PRICE  \n");
    	sbSql.append("          ,A.MAIN_ITEM_CODE1  \n");
        sbSql.append("         ,A.EXPECT_MEAL_QTY                                                                                                                                       \n");
out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		DS_body = this.makeDataSet(rs, "DS_body");
		/**종료**/
		out_dl.add(DS_body);
		this.setResultMessage(0, "OK", out_vl);

	}
	catch(Exception ex)
	{
		ex.printStackTrace();
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
	}

	proc_output(response,out,out_vl,out_dl);

%>