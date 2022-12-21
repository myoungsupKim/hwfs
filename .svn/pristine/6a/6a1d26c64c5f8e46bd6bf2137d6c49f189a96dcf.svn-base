
<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	//Statement stmt             =  null;
	try {
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		DataSet ds_condi     = in_dl.get("ds_condi");
		
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));		
		
		String UPJANG      = nullToBlank(in_vl.getString("UPJANG"));
        String MENU_DATE   = nullToBlank(in_vl.getString("MENU_DATE"));
        String NEED_DATE   = nullToBlank(in_vl.getString("NEED_DATE"));
        String SUBINV_CODE = nullToBlank(in_vl.getString("SUBINV_CODE"));
        String ITEM_CODE   = nullToBlank(in_vl.getString("ITEM_CODE"));

		DataSet ds_menu_item;
		StringBuffer sbSelSql = new StringBuffer();
	
		sbSelSql.delete(0, sbSelSql.length());
		
		sbSelSql.append("\n SELECT C.ITEM_CODE ");
		sbSelSql.append("\n       ,E.ITEM_NAME ");
		sbSelSql.append("\n       ,A.MENU_DATE ");
		sbSelSql.append("\n       ,(SELECT HALL_NAME FROM FSA_HALL_MST WHERE UPJANG = A.UPJANG AND HALL_CD = A.HALL_CD) HALL_NAME ");
		sbSelSql.append("\n       ,(SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0023' AND CODE = A.MEAL) MEAL_NAME ");
		sbSelSql.append("\n       ,(SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0022' AND CODE = A.CORNER) CORNER_NAME ");
		sbSelSql.append("\n       ,B.RECIPE_NAME ");
		sbSelSql.append("\n       ,ROUND((DECODE(D.CATER_YN,'Y', B.EXPECT_SALE_QTY, DECODE(D.CAFE_YN,'Y', B.EXPECT_SALE_QTY, A.EXPECT_MEAL_QTY))*C.NEED_QTY)/1000/E.KG_CONVERT_RATE,2) NEED_QTY ");
		sbSelSql.append("\n       ,0 TOT_NEED_QTY "                        );
		sbSelSql.append("\n   FROM FSM_REAL_MENU_MST A "                   );
		sbSelSql.append("\n       ,FSM_REAL_RECIPE_MST B "                 );
		sbSelSql.append("\n       ,FSM_REAL_RECIPE_ITEM C "                );
		sbSelSql.append("\n       ,FSA_HALL_MST D "                        );
		sbSelSql.append("\n       ,HLDC_PO_ITEM_MST E "                    );
		sbSelSql.append("\n  WHERE A.UPJANG      = B.UPJANG "              );
		sbSelSql.append("\n    AND A.MENU_CD     = B.MENU_CD "             );
		sbSelSql.append("\n    AND B.UPJANG      = C.UPJANG "              );
		sbSelSql.append("\n    AND B.MENU_CD     = C.MENU_CD "             );
		sbSelSql.append("\n    AND B.RECIPE_CD   = C.RECIPE_CD "           );
		sbSelSql.append("\n    AND A.UPJANG      = D.UPJANG "              );
		sbSelSql.append("\n    AND A.HALL_CD     = D.HALL_CD "             );
		sbSelSql.append("\n    AND C.ITEM_CODE   = E.ITEM_CODE "           );
		sbSelSql.append("\n    AND C.UPJANG      = '" + UPJANG      + "' " );
		sbSelSql.append("\n    AND C.NEED_DATE   = '" + NEED_DATE   + "' " );
		sbSelSql.append("\n    AND C.ITEM_CODE   = '" + ITEM_CODE   + "' " );
		sbSelSql.append("\n    AND A.SUBINV_CODE = '" + SUBINV_CODE + "'\n");
		
        pstmt = conn.prepareStatement(sbSelSql.toString());
        rs = pstmt.executeQuery();
        ds_menu_item = this.makeDataSet(rs, "ds_menu_item");

        pstmt.close();
        rs.close();

        /**종료**/
        out_dl.add(ds_menu_item);
        this.setResultMessage(0, "OK", out_vl);
	   	
    }
    catch(Exception ex)
    {
            ex.printStackTrace();
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