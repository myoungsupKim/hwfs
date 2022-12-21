
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
		DataSet ds_input     	= in_dl.get("ds_Input");
	
		String strUpjang 		= nullToBlank(ds_input.getString(0, "UPJANG"));
		String strHalCD			= nullToBlank(ds_input.getString(0, "HALL_CD"));
		String strMenuDate		= nullToBlank(ds_input.getString(0, "MENU_DATE"));
		String strMenuDate2		= nullToBlank(ds_input.getString(0, "MENU_DATE2"));
	

		//out 데이타
		DataSet ds_List;

		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		sbSql.delete(0, sbSql.length()); //내역조회		
		//sbSql.append("\n  SELECT UPJANG, MENU_CD, MEAL_CORNER, AVG(SALE_PRICE) AS SALE_PRICE  ");
		sbSql.append("\n  SELECT UPJANG, MENU_CD, SUBSTR(MENU_DATE,0,4) || '-' || SUBSTR(MENU_DATE,5,2) ||'-' || SUBSTR(MENU_DATE,7,2) AS MENU_DATE, MEAL, CORNER, MENU_FEATURE, AVG(SALE_PRICE) AS SALE_PRICE  ");		
		sbSql.append("\n        ,AVG(EXPECT_MEAL_QTY) AS EXPECT_MEAL_QTY                      ");
		sbSql.append("\n        ,(SELECT LISTAGG(RECIPE_NAME, ', ') WITHIN GROUP(ORDER BY ROWNUM)    ");
		sbSql.append("\n           FROM FSM_REAL_RECIPE_MST                                          ");
		sbSql.append("\n          WHERE UPJANG = D.UPJANG                                            ");
		sbSql.append("\n            AND MENU_CD = D.MENU_CD) AS MENU_CONSTRUCT                       ");
		sbSql.append("\n        , '0' AS SEL                                                         ");		
		//sbSql.append("\n        ,FSM_REAL_RECIPE_NAME_FUN(UPJANG, MENU_CD) AS MENU_CONSTRUCT, '0' AS SEL  ");
		sbSql.append("\n    FROM (    ");                           
		sbSql.append("\n          SELECT /*+ ORDERED */ A.UPJANG, A.MENU_CD, A.MENU_DATE, NVL(A.SALE_PRICE,0) AS SALE_PRICE  ");
		sbSql.append("\n                ,NVL( A.EXPECT_MEAL_QTY,0) AS EXPECT_MEAL_QTY            ");
		//sbSql.append("\n                ,(G.CODE_NAME || H.CODE_NAME) MEAL_CORNER                ");
		sbSql.append("\n                ,G.CODE_NAME MEAL, H.CODE_NAME CORNER, A.MENU_FEATURE     ");		
		sbSql.append("\n          FROM FSM_REAL_MENU_MST A		");   
		sbSql.append("\n              ,FSM_REAL_RECIPE_MST B  ");   
		sbSql.append("\n              ,FSM_REAL_RECIPE_ITEM C ");   
		sbSql.append("\n              ,MAC_UPJANG_V D         ");   
		sbSql.append("\n              ,FSA_HALL_MST E         ");   
		//sbSql.append("\n              ,HLDC_PO_ITEM_MST F     ");   
		sbSql.append("\n              ,(SELECT CODE, CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0023') G	");
		sbSql.append("\n              ,(SELECT CODE, CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0022') H  ");
		sbSql.append("\n          WHERE A.UPJANG = B.UPJANG					");
		sbSql.append("\n            AND B.UPJANG = C.UPJANG         ");
		sbSql.append("\n            AND A.UPJANG = D.UPJANG         ");
		sbSql.append("\n            AND A.UPJANG = E.UPJANG         ");
		sbSql.append("\n            AND A.MENU_CD = B.MENU_CD       ");
		sbSql.append("\n            AND B.MENU_CD = C.MENU_CD       ");
		sbSql.append("\n            AND B.RECIPE_CD = C.RECIPE_CD   ");
		sbSql.append("\n            AND A.HALL_CD = E.HALL_CD       ");
		//sbSql.append("\n            AND C.ITEM_CODE = F.ITEM_CODE   ");
		//if(! strHalCD.equals("00000") || strHalCD != "null"){
			sbSql.append("\n            AND A.UPJANG = "+strUpjang+"   ");
		//}
		//sbSql.append("\n            AND A.MENU_DATE = '"+strMenuDate+"' ");
		sbSql.append("\n            AND A.MENU_DATE BETWEEN '"+strMenuDate+"' AND  '"+strMenuDate2+"' ");
		
		if(! strHalCD.equals("00000") && ! strHalCD.equals("")){
			sbSql.append("\n            AND A.HALL_CD = '"+strHalCD+"' ");
		}
//		sbSql.append("\n            AND A.MENU_CD IN ('20071120-00101001001','20071120-00101002001')  ");  
		sbSql.append("\n            AND A.MEAL = G.CODE(+)		");   
		sbSql.append("\n            AND A.CORNER = H.CODE(+)  ");   
		sbSql.append("\n          ) D       ");                      
		sbSql.append("\n  GROUP BY UPJANG, MENU_DATE, MENU_CD, MEAL, CORNER, MENU_FEATURE  ");
		sbSql.append("\n  ORDER BY UPJANG, MENU_DATE, MENU_CD, MEAL, CORNER, MENU_FEATURE  ");
		//sbSql.append("\n  GROUP BY UPJANG, MENU_CD, MEAL_CORNER  ");

		System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		ds_List = this.makeDataSet(rs, "ds_List"); //ds_list

		/**종료**/
		out_dl.add(ds_List);
		this.setResultMessage(0, "OK", out_vl);
		
		rs.close();
		pstmt.close();
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