
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
		String strMenuCd  		= nullToBlank(ds_input.getString(0, "MENU_CD"));
		
		String strResource		= nullToBlank(ds_input.getString(0, "RESOURCE"));		// 1: 자재별, 		0: 레시피별
		String strAbolitionRate	= nullToBlank(ds_input.getString(0, "ABOLITIONRATE"));	// 1: 폐기율적용, 	0: 미적용
		String strRecipe		= nullToBlank(ds_input.getString(0, "RECIPE"));			// 1: 레시피수정 적용, 	0: 미적용
		
		String strNeedQty 		= ""; // 폐기율 적용과 미적용했을경우 Round함수에 들어갈 컬럼 담기
		
		if(strResource.equals("1")){System.out.println("#### 자재별 영양조회 시작 ####");}else{System.out.println("#### 레시피별 영양조회 시작 ####");}
	
		if(strAbolitionRate.equals("1")){
			strNeedQty = "EDIBLE_QTY";
			System.out.println("#### 폐기율 적용 했음 ####");
		}else{
			strNeedQty = "NEED_QTY";
			System.out.println("#### 폐기율 미적용 ####");
		}
		if(strRecipe.equals("1")){System.out.println("#### 레시피수정 적용 #### \n");}else{System.out.println("#### 레시피수정 미적용 #### \n");}
		
	//System.out.println("strUpjang:"+strUpjang+", strHalCD:"+strHalCD+", strMenuDate:"+strMenuDate);
	//System.out.println("strResource:"+strResource+", strAbolitionRate:"+strAbolitionRate+", strRecipe:"+strRecipe);


		//out 데이타
		DataSet ds_list;

		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		sbSql.delete(0, sbSql.length()); //내역조회
		
		// 자재별 영양관리
		if(strResource.equals("1")){
			// 폐기율 적용_레시피 수정
			if(strAbolitionRate.equals("1") && strRecipe.equals("1")){
				sbSql.append("\n  SELECT A.UPJANG, A.UPJANGNM, A.HALL_CD, A.HALL_NAME,																																				");
				sbSql.append("\n         SUBSTR(A.MENU_DATE,1,4) || '년 ' || SUBSTR(A.MENU_DATE,5,2) || '월 ' || SUBSTR(A.MENU_DATE,7,2) || '일' MENU_DATE,   ");
				sbSql.append("\n         A.MEAL, A.CORNER, A.MEAL_CORNER,                                 	");
				sbSql.append("\n         A.RECIPE_CD, A.RECIPE_NAME, A.ITEM_CODE, A.ITEM_NAME, 	");
				sbSql.append("\n		 A.NEED_QTY, A.EDIBLE_QTY, B.DISUSE_RATE, ");
				sbSql.append("\n  		 ROUND(A.NEED_QTY * A.G_ITEM_PRICE,2) ITEM_COST,	");
				sbSql.append("\n         ROUND(SUM(NVL(B.CAL,0)*A."+strNeedQty+")/100,2) CAL,		-- 열량                    ");
				sbSql.append("\n         ROUND(SUM(NVL(B.WATER,0)*A."+strNeedQty+")/100,2) WATER,	-- 수분                    ");
				sbSql.append("\n         ROUND(SUM(NVL(B.PROT,0)*A."+strNeedQty+")/100,2) PROT,		-- 단백질         ");
				sbSql.append("\n         ROUND(SUM(NVL(B.FAT,0)*A."+strNeedQty+")/100,2) FAT,		-- 지방 (지질)    ");
				sbSql.append("\n         ROUND(SUM(NVL(B.CARBO,0)*A."+strNeedQty+")/100,2) CARBO,	-- 탄수화물(당질) ");
				sbSql.append("\n         ROUND(SUM(NVL(B.FIBER,0)*A."+strNeedQty+")/100,2) FIBER,	-- 섬유                    ");
				sbSql.append("\n         ROUND(SUM(NVL(B.ASH,0)*A."+strNeedQty+")/100,2) ASH,		-- 회분                    ");
				sbSql.append("\n         ROUND(SUM(NVL(B.CA,0)*A."+strNeedQty+")/100,2) CA,		-- 칼슘                    ");
				sbSql.append("\n         ROUND(SUM(NVL(B.P,0)*A."+strNeedQty+")/100,2) P,		-- 인분                            ");
				sbSql.append("\n         ROUND(SUM(NVL(B.FE,0)*A."+strNeedQty+")/100,2) FE,		-- 철분                    ");
				sbSql.append("\n         ROUND(SUM(NVL(B.NA,0)*A."+strNeedQty+")/100,2) NA,		-- 나트륨                 ");
				sbSql.append("\n         ROUND(SUM(NVL(B.K,0)*A."+strNeedQty+")/100,2) K,		-- 칼륨                            ");
				sbSql.append("\n         ROUND(SUM(NVL(B.VITA_A,0)*A."+strNeedQty+")/100,2) VITA_A,	-- 비타민A   ");
				sbSql.append("\n         ROUND(SUM(NVL(B.RETIN,0)*A."+strNeedQty+")/100,2) RETIN,	-- 레티놀                ");
				sbSql.append("\n         ROUND(SUM(NVL(B.B_CAROT,0)*A."+strNeedQty+")/100,2) B_CAROT,	-- 베타카로틴 ");
				sbSql.append("\n         ROUND(SUM(NVL(B.THIA,0)*A."+strNeedQty+")/100,2) THIA,		-- 티아민(비타민b1)		");
				sbSql.append("\n         ROUND(SUM(NVL(B.RIBO,0)*A."+strNeedQty+")/100,2) RIBO,		-- 리보플라빈(비타민B2)    ");
				sbSql.append("\n         ROUND(SUM(NVL(B.NIACIN,0)*A."+strNeedQty+")/100,2) NIACIN,	-- 나이아아신                          ");
				sbSql.append("\n         ROUND(SUM(NVL(B.VITA_C,0)*A."+strNeedQty+")/100,2) VITA_C,	-- 비타민C               ");
				sbSql.append("\n         ROUND(SUM(NVL(B.CHOLE,0)*A."+strNeedQty+")/100,2) CHOLE	-- 콜레스테롤                                 ");

			    //sbSql.append("\n  		 ROUND(SUM(NVL(B.CAL,0)*(A."+strNeedQty+"*((100-NVL(B.DISUSE_RATE,0))/100)))/100,2) CAL, 		  ");
			    //sbSql.append("\n  		 ROUND(SUM(NVL(B.WATER,0)*(A."+strNeedQty+"*((100-NVL(B.DISUSE_RATE,0))/100)))/100,2) WATER,    ");
			    //sbSql.append("\n  		 ROUND(SUM(NVL(B.PROT,0)*(A."+strNeedQty+"*((100-NVL(B.DISUSE_RATE,0))/100)))/100,2) PROT,      ");
			    //sbSql.append("\n  		 ROUND(SUM(NVL(B.FAT,0)*(A."+strNeedQty+"*((100-NVL(B.DISUSE_RATE,0))/100)))/100,2) FAT,        ");
			    //sbSql.append("\n  		 ROUND(SUM(NVL(B.CARBO,0)*(A."+strNeedQty+"*((100-NVL(B.DISUSE_RATE,0))/100)))/100,2) CARBO,    ");
			    //sbSql.append("\n  		 ROUND(SUM(NVL(B.FIBER,0)*(A."+strNeedQty+"*((100-NVL(B.DISUSE_RATE,0))/100)))/100,2) FIBER,    ");
			    //sbSql.append("\n  		 ROUND(SUM(NVL(B.ASH,0)*(A."+strNeedQty+"*((100-NVL(B.DISUSE_RATE,0))/100)))/100,2) ASH,        ");
			    //sbSql.append("\n  		 ROUND(SUM(NVL(B.CA,0)*(A."+strNeedQty+"*((100-NVL(B.DISUSE_RATE,0))/100)))/100,2) CA,          ");
			    //sbSql.append("\n  		 ROUND(SUM(NVL(B.P,0)*(A."+strNeedQty+"*((100-NVL(B.DISUSE_RATE,0))/100)))/100,2) P,            ");
			    //sbSql.append("\n  		 ROUND(SUM(NVL(B.FE,0)*(A."+strNeedQty+"*((100-NVL(B.DISUSE_RATE,0))/100)))/100,2) FE,          ");
			    //sbSql.append("\n  		 ROUND(SUM(NVL(B.NA,0)*(A."+strNeedQty+"*((100-NVL(B.DISUSE_RATE,0))/100)))/100,2) NA,          ");
			    //sbSql.append("\n  		 ROUND(SUM(NVL(B.K,0)*(A."+strNeedQty+"*((100-NVL(B.DISUSE_RATE,0))/100)))/100,2) K,            ");
			    //sbSql.append("\n  		 ROUND(SUM(NVL(B.VITA_A,0)*(A."+strNeedQty+"*((100-NVL(B.DISUSE_RATE,0))/100)))/100,2) VITA_A,  ");
			    //sbSql.append("\n  		 ROUND(SUM(NVL(B.RETIN,0)*(A."+strNeedQty+"*((100-NVL(B.DISUSE_RATE,0))/100)))/100,2) RETIN,    ");
			    //sbSql.append("\n  		 ROUND(SUM(NVL(B.B_CAROT,0)*(A."+strNeedQty+"*((100-NVL(B.DISUSE_RATE,0))/100)))/100,2) B_CAROT,");
			    //sbSql.append("\n  		 ROUND(SUM(NVL(B.THIA,0)*(A."+strNeedQty+"*((100-NVL(B.DISUSE_RATE,0))/100)))/100,2) THIA,      ");
			    //sbSql.append("\n  		 ROUND(SUM(NVL(B.RIBO,0)*(A."+strNeedQty+"*((100-NVL(B.DISUSE_RATE,0))/100)))/100,2) RIBO,      ");
			    //sbSql.append("\n  		 ROUND(SUM(NVL(B.NIACIN,0)*(A."+strNeedQty+"*((100-NVL(B.DISUSE_RATE,0))/100)))/100,2) NIACIN,  ");
			    //sbSql.append("\n  		 ROUND(SUM(NVL(B.VITA_C,0)*(A."+strNeedQty+"*((100-NVL(B.DISUSE_RATE,0))/100)))/100,2) VITA_C,  ");
			    //sbSql.append("\n		 ROUND(SUM(NVL(B.CHOLE,0)*(A."+strNeedQty+"*((100-NVL(B.DISUSE_RATE,0))/100)))/100,2) CHOLE     ");
			    
			    sbSql.append("\n    FROM           ");
				sbSql.append("\n          (        ");
				sbSql.append("\n          SELECT A.UPJANG, D.UPJANGNM, A.HALL_CD, E.HALL_NAME, A.MENU_DATE,  ");
			    sbSql.append("\n         		 A.MEAL, A.CORNER,  ");
			    sbSql.append("\n                 (SELECT CODE_NAME FROM SCC_COMMON_CODE X WHERE X.GROUP_CODE = 'FS0023' AND X.CODE = A.MEAL) || '(' ||  ");
			    sbSql.append("\n                 (SELECT CODE_NAME FROM SCC_COMMON_CODE X WHERE X.GROUP_CODE = 'FS0022' AND X.CODE = A.CORNER) || ')' MEAL_CORNER,  ");
			    sbSql.append("\n                 A.RECIPE_CD, A.RECIPE_NAME, A.ITEM_CODE, F.ITEM_NAME,  ");
			    sbSql.append("\n                 A.NEED_QTY, A.EDIBLE_QTY,  ");
				sbSql.append("\n                 ROUND(A.MARGIN_PRICE/F.KG_CONVERT_RATE/1000,2) AS G_ITEM_PRICE  ");
			    sbSql.append("\n            FROM FSM_MEAL_RECIPE_ADJUST A  ");
			    sbSql.append("\n                ,MAC_UPJANG_V D  ");
			    sbSql.append("\n                ,FSA_HALL_MST E  ");
			    sbSql.append("\n                ,HLDC_PO_ITEM_MST F  ");
			    sbSql.append("\n           WHERE A.UPJANG = D.UPJANG  ");
			    sbSql.append("\n             AND A.UPJANG = E.UPJANG  ");
			    sbSql.append("\n             AND A.HALL_CD = E.HALL_CD  ");
			    sbSql.append("\n             AND A.ITEM_CODE = F.ITEM_CODE  ");
			    sbSql.append("\n             AND A.UPJANG = "+strUpjang+"  ");
			    //sbSql.append("\n             AND A.MENU_DATE = '"+strMenuDate+"'  ");
				sbSql.append("\n            AND A.MENU_DATE BETWEEN '"+strMenuDate+"' AND  '"+strMenuDate2+"' ");
			    if(! strHalCD.equals("00000")){
					sbSql.append("\n             AND A.HALL_CD = '"+strHalCD+"' ");
				}
			    sbSql.append("\n     AND A.MENU_CD IN ( "+strMenuCd+" )  "); //('20071120-00101001001','20071120-00101002001')
				sbSql.append("\n          ) A                                                         ");
				sbSql.append("\n         ,FSI_ITEM_NUT B                                              ");
				sbSql.append("\n   WHERE A.ITEM_CODE = B.ITEM_CODE(+)                                 ");
				sbSql.append("\n   GROUP BY A.UPJANG, A.UPJANGNM, A.HALL_CD, A.HALL_NAME, A.MENU_DATE,");
				sbSql.append("\n            A.MEAL, A.CORNER, A.MEAL_CORNER,                          ");
				sbSql.append("\n            A.RECIPE_CD, A.RECIPE_NAME, A.ITEM_CODE, A.ITEM_NAME, 	  ");
				sbSql.append("\n			A.NEED_QTY, A.EDIBLE_QTY, G_ITEM_PRICE, B.DISUSE_RATE     ");
				sbSql.append("\n   ORDER BY A.MEAL, A.CORNER, A.MEAL_CORNER                                  ");

			// 폐기율 미적용_레시피 미적용
			}else if (strAbolitionRate.equals("0") && strRecipe.equals("0")){		
				sbSql.append("\n  SELECT A.UPJANG, A.UPJANGNM, A.HALL_CD, A.HALL_NAME,																																				");
				sbSql.append("\n         SUBSTR(A.MENU_DATE,1,4) || '년 ' || SUBSTR(A.MENU_DATE,5,2) || '월 ' || SUBSTR(A.MENU_DATE,7,2) || '일' MENU_DATE,   ");
				sbSql.append("\n         A.MEAL, A.CORNER, A.MEAL_CORNER,                                 	");
				sbSql.append("\n         A.RECIPE_CD, A.RECIPE_NAME, A.ITEM_CODE, A.ITEM_NAME, 	");
				sbSql.append("\n		 A.NEED_QTY, A.EDIBLE_QTY, B.DISUSE_RATE, ");
				sbSql.append("\n  		 ROUND(A.NEED_QTY * A.G_ITEM_PRICE,2) ITEM_COST,	");
				sbSql.append("\n         ROUND(SUM(NVL(B.CAL,0)*A."+strNeedQty+")/100,2) CAL,		-- 열량                    ");
				sbSql.append("\n         ROUND(SUM(NVL(B.WATER,0)*A."+strNeedQty+")/100,2) WATER,	-- 수분                    ");
				sbSql.append("\n         ROUND(SUM(NVL(B.PROT,0)*A."+strNeedQty+")/100,2) PROT,		-- 단백질         ");
				sbSql.append("\n         ROUND(SUM(NVL(B.FAT,0)*A."+strNeedQty+")/100,2) FAT,		-- 지방 (지질)    ");
				sbSql.append("\n         ROUND(SUM(NVL(B.CARBO,0)*A."+strNeedQty+")/100,2) CARBO,	-- 탄수화물(당질) ");
				sbSql.append("\n         ROUND(SUM(NVL(B.FIBER,0)*A."+strNeedQty+")/100,2) FIBER,	-- 섬유                    ");
				sbSql.append("\n         ROUND(SUM(NVL(B.ASH,0)*A."+strNeedQty+")/100,2) ASH,		-- 회분                    ");
				sbSql.append("\n         ROUND(SUM(NVL(B.CA,0)*A."+strNeedQty+")/100,2) CA,		-- 칼슘                    ");
				sbSql.append("\n         ROUND(SUM(NVL(B.P,0)*A."+strNeedQty+")/100,2) P,		-- 인분                            ");
				sbSql.append("\n         ROUND(SUM(NVL(B.FE,0)*A."+strNeedQty+")/100,2) FE,		-- 철분                    ");
				sbSql.append("\n         ROUND(SUM(NVL(B.NA,0)*A."+strNeedQty+")/100,2) NA,		-- 나트륨                 ");
				sbSql.append("\n         ROUND(SUM(NVL(B.K,0)*A."+strNeedQty+")/100,2) K,		-- 칼륨                            ");
				sbSql.append("\n         ROUND(SUM(NVL(B.VITA_A,0)*A."+strNeedQty+")/100,2) VITA_A,	-- 비타민A   ");
				sbSql.append("\n         ROUND(SUM(NVL(B.RETIN,0)*A."+strNeedQty+")/100,2) RETIN,	-- 레티놀                ");
				sbSql.append("\n         ROUND(SUM(NVL(B.B_CAROT,0)*A."+strNeedQty+")/100,2) B_CAROT,	-- 베타카로틴 ");
				sbSql.append("\n         ROUND(SUM(NVL(B.THIA,0)*A."+strNeedQty+")/100,2) THIA,		-- 티아민(비타민b1)		");
				sbSql.append("\n         ROUND(SUM(NVL(B.RIBO,0)*A."+strNeedQty+")/100,2) RIBO,		-- 리보플라빈(비타민B2)    ");
				sbSql.append("\n         ROUND(SUM(NVL(B.NIACIN,0)*A."+strNeedQty+")/100,2) NIACIN,	-- 나이아아신                          ");
				sbSql.append("\n         ROUND(SUM(NVL(B.VITA_C,0)*A."+strNeedQty+")/100,2) VITA_C,	-- 비타민C               ");
				sbSql.append("\n         ROUND(SUM(NVL(B.CHOLE,0)*A."+strNeedQty+")/100,2) CHOLE	-- 콜레스테롤                                 ");
				sbSql.append("\n    FROM           ");
				sbSql.append("\n          (        ");
				sbSql.append("\n          SELECT A.UPJANG, D.UPJANGNM, A.HALL_CD, E.HALL_NAME, A.MENU_DATE,		");
				sbSql.append("\n                 A.MEAL, A.CORNER,  ");
				sbSql.append("\n                 (SELECT CODE_NAME FROM SCC_COMMON_CODE X WHERE X.GROUP_CODE = 'FS0023' AND X.CODE = A.MEAL) || '(' ||              ");
				sbSql.append("\n                 (SELECT CODE_NAME FROM SCC_COMMON_CODE X WHERE X.GROUP_CODE = 'FS0022' AND X.CODE = A.CORNER) || ')' MEAL_CORNER,   ");
				sbSql.append("\n                 B.RECIPE_CD, B.RECIPE_NAME, C.ITEM_CODE, F.ITEM_NAME,          ");
				sbSql.append("\n                 C.EDIBLE_QTY, C.NEED_QTY,   ");
				sbSql.append("\n                 ROUND(C.MARGIN_PRICE/F.KG_CONVERT_RATE/1000,2) AS G_ITEM_PRICE  ");
				sbSql.append("\n            FROM FSM_REAL_MENU_MST A       ");
				sbSql.append("\n                ,FSM_REAL_RECIPE_MST B     ");
				sbSql.append("\n                ,FSM_REAL_RECIPE_ITEM C    ");
				sbSql.append("\n                ,MAC_UPJANG_V D            ");
				sbSql.append("\n                ,FSA_HALL_MST E            ");
				sbSql.append("\n                ,HLDC_PO_ITEM_MST F        ");
				sbSql.append("\n           WHERE A.UPJANG = B.UPJANG       ");
				sbSql.append("\n             AND A.MENU_CD = B.MENU_CD     ");
				sbSql.append("\n             AND B.UPJANG = C.UPJANG       ");
				sbSql.append("\n             AND B.MENU_CD = C.MENU_CD     ");
				sbSql.append("\n             AND B.RECIPE_CD = C.RECIPE_CD ");
				sbSql.append("\n             AND A.UPJANG = D.UPJANG       ");
				sbSql.append("\n             AND A.UPJANG = E.UPJANG       ");
				sbSql.append("\n             AND A.HALL_CD = E.HALL_CD     ");
				sbSql.append("\n             AND C.ITEM_CODE = F.ITEM_CODE ");
				sbSql.append("\n             AND A.UPJANG = "+strUpjang+"  ");
				//sbSql.append("\n             AND A.MENU_DATE = '"+strMenuDate+"' ");
				sbSql.append("\n            AND A.MENU_DATE BETWEEN '"+strMenuDate+"' AND  '"+strMenuDate2+"' ");
				if(! strHalCD.equals("00000") ){
					sbSql.append("\n             AND A.HALL_CD = '"+strHalCD+"' ");
				}
				sbSql.append("\n             AND A.MENU_CD IN ( "+strMenuCd+" )  "); //('20071120-00101001001','20071120-00101002001')
				sbSql.append("\n          ) A                                                         ");
				sbSql.append("\n         ,FSI_ITEM_NUT B                                              ");
				sbSql.append("\n   WHERE A.ITEM_CODE = B.ITEM_CODE(+)                                 ");
				sbSql.append("\n   GROUP BY A.UPJANG, A.UPJANGNM, A.HALL_CD, A.HALL_NAME, A.MENU_DATE,");
				sbSql.append("\n            A.MEAL, A.CORNER, A.MEAL_CORNER,                          ");
				sbSql.append("\n            A.RECIPE_CD, A.RECIPE_NAME, A.ITEM_CODE, A.ITEM_NAME, 	  ");
				sbSql.append("\n			A.NEED_QTY, A.EDIBLE_QTY, G_ITEM_PRICE, B.DISUSE_RATE     ");
				sbSql.append("\n   ORDER BY A.MEAL, A.CORNER, A.MEAL_CORNER                                  ");				

			// 폐기율 적용_레시피 미적용	
			}else if (strAbolitionRate.equals("1") && strRecipe.equals("0")){		
				sbSql.append("\n  SELECT A.UPJANG, A.UPJANGNM, A.HALL_CD, A.HALL_NAME,																																				");
				sbSql.append("\n         SUBSTR(A.MENU_DATE,1,4) || '년 ' || SUBSTR(A.MENU_DATE,5,2) || '월 ' || SUBSTR(A.MENU_DATE,7,2) || '일' MENU_DATE,   ");
				sbSql.append("\n         A.MEAL, A.CORNER, A.MEAL_CORNER,                                 	");
				sbSql.append("\n         A.RECIPE_CD, A.RECIPE_NAME, A.ITEM_CODE, A.ITEM_NAME, 	");
				sbSql.append("\n		 A.NEED_QTY, A.EDIBLE_QTY, B.DISUSE_RATE, ");
				sbSql.append("\n  		 ROUND(A.NEED_QTY * A.G_ITEM_PRICE,2) ITEM_COST,	");
				sbSql.append("\n         ROUND(SUM(NVL(B.CAL,0)*A."+strNeedQty+")/100,2) CAL,		-- 열량                    ");
				sbSql.append("\n         ROUND(SUM(NVL(B.WATER,0)*A."+strNeedQty+")/100,2) WATER,	-- 수분                    ");
				sbSql.append("\n         ROUND(SUM(NVL(B.PROT,0)*A."+strNeedQty+")/100,2) PROT,		-- 단백질         ");
				sbSql.append("\n         ROUND(SUM(NVL(B.FAT,0)*A."+strNeedQty+")/100,2) FAT,		-- 지방 (지질)    ");
				sbSql.append("\n         ROUND(SUM(NVL(B.CARBO,0)*A."+strNeedQty+")/100,2) CARBO,	-- 탄수화물(당질) ");
				sbSql.append("\n         ROUND(SUM(NVL(B.FIBER,0)*A."+strNeedQty+")/100,2) FIBER,	-- 섬유                    ");
				sbSql.append("\n         ROUND(SUM(NVL(B.ASH,0)*A."+strNeedQty+")/100,2) ASH,		-- 회분                    ");
				sbSql.append("\n         ROUND(SUM(NVL(B.CA,0)*A."+strNeedQty+")/100,2) CA,		-- 칼슘                    ");
				sbSql.append("\n         ROUND(SUM(NVL(B.P,0)*A."+strNeedQty+")/100,2) P,		-- 인분                            ");
				sbSql.append("\n         ROUND(SUM(NVL(B.FE,0)*A."+strNeedQty+")/100,2) FE,		-- 철분                    ");
				sbSql.append("\n         ROUND(SUM(NVL(B.NA,0)*A."+strNeedQty+")/100,2) NA,		-- 나트륨                 ");
				sbSql.append("\n         ROUND(SUM(NVL(B.K,0)*A."+strNeedQty+")/100,2) K,		-- 칼륨                            ");
				sbSql.append("\n         ROUND(SUM(NVL(B.VITA_A,0)*A."+strNeedQty+")/100,2) VITA_A,	-- 비타민A   ");
				sbSql.append("\n         ROUND(SUM(NVL(B.RETIN,0)*A."+strNeedQty+")/100,2) RETIN,	-- 레티놀                ");
				sbSql.append("\n         ROUND(SUM(NVL(B.B_CAROT,0)*A."+strNeedQty+")/100,2) B_CAROT,	-- 베타카로틴 ");
				sbSql.append("\n         ROUND(SUM(NVL(B.THIA,0)*A."+strNeedQty+")/100,2) THIA,		-- 티아민(비타민b1)		");
				sbSql.append("\n         ROUND(SUM(NVL(B.RIBO,0)*A."+strNeedQty+")/100,2) RIBO,		-- 리보플라빈(비타민B2)    ");
				sbSql.append("\n         ROUND(SUM(NVL(B.NIACIN,0)*A."+strNeedQty+")/100,2) NIACIN,	-- 나이아아신                          ");
				sbSql.append("\n         ROUND(SUM(NVL(B.VITA_C,0)*A."+strNeedQty+")/100,2) VITA_C,	-- 비타민C               ");
				sbSql.append("\n         ROUND(SUM(NVL(B.CHOLE,0)*A."+strNeedQty+")/100,2) CHOLE	-- 콜레스테롤                                 ");
				sbSql.append("\n    FROM           ");
				sbSql.append("\n          (        ");				
				sbSql.append("\n          SELECT /*+ ORDERED */ A.UPJANG, D.UPJANGNM, A.HALL_CD, E.HALL_NAME, A.MENU_DATE,		");
				sbSql.append("\n                 A.MEAL, A.CORNER,  ");
				sbSql.append("\n                 (SELECT CODE_NAME FROM SCC_COMMON_CODE X WHERE X.GROUP_CODE = 'FS0023' AND X.CODE = A.MEAL) || '(' ||        ");
				sbSql.append("\n                 (SELECT CODE_NAME FROM SCC_COMMON_CODE X WHERE X.GROUP_CODE = 'FS0022' AND X.CODE = A.CORNER) || ')' MEAL_CORNER,   ");
				sbSql.append("\n                 B.RECIPE_CD, B.RECIPE_NAME, C.ITEM_CODE, F.ITEM_NAME,          ");
				sbSql.append("\n                 C.EDIBLE_QTY, C.NEED_QTY,   ");
				sbSql.append("\n                 ROUND(C.MARGIN_PRICE/F.KG_CONVERT_RATE/1000,2) AS G_ITEM_PRICE  ");
				//sbSql.append("\n				 ,B.CUISINE_TYPE		   ");	// 상단의 제공메뉴 순서와 맞추려할때 추가
				sbSql.append("\n            FROM FSM_REAL_MENU_MST A       ");
				sbSql.append("\n                ,FSM_REAL_RECIPE_MST B     ");
				sbSql.append("\n                ,FSM_REAL_RECIPE_ITEM C    ");
				sbSql.append("\n                ,MAC_UPJANG_V D            ");
				sbSql.append("\n                ,FSA_HALL_MST E            ");
				sbSql.append("\n                ,HLDC_PO_ITEM_MST F        ");
				sbSql.append("\n           WHERE A.UPJANG = B.UPJANG       ");
				sbSql.append("\n             AND A.MENU_CD = B.MENU_CD     ");
				sbSql.append("\n             AND B.UPJANG = C.UPJANG       ");
				sbSql.append("\n             AND B.MENU_CD = C.MENU_CD     ");
				sbSql.append("\n             AND B.RECIPE_CD = C.RECIPE_CD ");
				sbSql.append("\n             AND A.UPJANG = D.UPJANG       ");
				sbSql.append("\n             AND A.UPJANG = E.UPJANG       ");
				sbSql.append("\n             AND A.HALL_CD = E.HALL_CD     ");
				sbSql.append("\n             AND C.ITEM_CODE = F.ITEM_CODE ");
				sbSql.append("\n             AND A.UPJANG = "+strUpjang+"  ");
				//sbSql.append("\n             AND A.MENU_DATE = '"+strMenuDate+"' ");
				sbSql.append("\n            AND A.MENU_DATE BETWEEN '"+strMenuDate+"' AND  '"+strMenuDate2+"' ");
				if(! strHalCD.equals("00000") ){
					sbSql.append("\n             AND A.HALL_CD = '"+strHalCD+"' ");
				}
				sbSql.append("\n             AND A.MENU_CD IN ( "+strMenuCd+" )  "); //('20071120-00101001001','20071120-00101002001')
				sbSql.append("\n          ) A                                                         ");
				sbSql.append("\n         ,FSI_ITEM_NUT B                                              ");
				sbSql.append("\n   WHERE A.ITEM_CODE = B.ITEM_CODE(+)                                 ");
				sbSql.append("\n   GROUP BY A.UPJANG, A.UPJANGNM, A.HALL_CD, A.HALL_NAME, A.MENU_DATE,");
				sbSql.append("\n            A.MEAL, A.CORNER, A.MEAL_CORNER,                          ");
				sbSql.append("\n            A.RECIPE_CD, A.RECIPE_NAME, A.ITEM_CODE, A.ITEM_NAME, 	  ");
				sbSql.append("\n			A.NEED_QTY, A.EDIBLE_QTY, G_ITEM_PRICE, B.DISUSE_RATE     ");
				sbSql.append("\n   ORDER BY A.MEAL, A.CORNER, A.MEAL_CORNER, RECIPE_NAME                                  ");
				
			// 폐기율 미적용_레시피 적용
			}else {
				sbSql.append("\n  SELECT A.UPJANG, A.UPJANGNM, A.HALL_CD, A.HALL_NAME,																																				");
				sbSql.append("\n         SUBSTR(A.MENU_DATE,1,4) || '년 ' || SUBSTR(A.MENU_DATE,5,2) || '월 ' || SUBSTR(A.MENU_DATE,7,2) || '일' MENU_DATE,   ");
				sbSql.append("\n         A.MEAL, A.CORNER, A.MEAL_CORNER,                                 	");
				sbSql.append("\n         A.RECIPE_CD, A.RECIPE_NAME, A.ITEM_CODE, A.ITEM_NAME, 	");
				sbSql.append("\n		 A.NEED_QTY, A.EDIBLE_QTY, B.DISUSE_RATE, ");
				sbSql.append("\n  		 ROUND(A.NEED_QTY * A.G_ITEM_PRICE,2) ITEM_COST,	");
				sbSql.append("\n         ROUND(SUM(NVL(B.CAL,0)*A."+strNeedQty+")/100,2) CAL,		-- 열량                    ");
				sbSql.append("\n         ROUND(SUM(NVL(B.WATER,0)*A."+strNeedQty+")/100,2) WATER,	-- 수분                    ");
				sbSql.append("\n         ROUND(SUM(NVL(B.PROT,0)*A."+strNeedQty+")/100,2) PROT,		-- 단백질         ");
				sbSql.append("\n         ROUND(SUM(NVL(B.FAT,0)*A."+strNeedQty+")/100,2) FAT,		-- 지방 (지질)    ");
				sbSql.append("\n         ROUND(SUM(NVL(B.CARBO,0)*A."+strNeedQty+")/100,2) CARBO,	-- 탄수화물(당질) ");
				sbSql.append("\n         ROUND(SUM(NVL(B.FIBER,0)*A."+strNeedQty+")/100,2) FIBER,	-- 섬유                    ");
				sbSql.append("\n         ROUND(SUM(NVL(B.ASH,0)*A."+strNeedQty+")/100,2) ASH,		-- 회분                    ");
				sbSql.append("\n         ROUND(SUM(NVL(B.CA,0)*A."+strNeedQty+")/100,2) CA,		-- 칼슘                    ");
				sbSql.append("\n         ROUND(SUM(NVL(B.P,0)*A."+strNeedQty+")/100,2) P,		-- 인분                            ");
				sbSql.append("\n         ROUND(SUM(NVL(B.FE,0)*A."+strNeedQty+")/100,2) FE,		-- 철분                    ");
				sbSql.append("\n         ROUND(SUM(NVL(B.NA,0)*A."+strNeedQty+")/100,2) NA,		-- 나트륨                 ");
				sbSql.append("\n         ROUND(SUM(NVL(B.K,0)*A."+strNeedQty+")/100,2) K,		-- 칼륨                            ");
				sbSql.append("\n         ROUND(SUM(NVL(B.VITA_A,0)*A."+strNeedQty+")/100,2) VITA_A,	-- 비타민A   ");
				sbSql.append("\n         ROUND(SUM(NVL(B.RETIN,0)*A."+strNeedQty+")/100,2) RETIN,	-- 레티놀                ");
				sbSql.append("\n         ROUND(SUM(NVL(B.B_CAROT,0)*A."+strNeedQty+")/100,2) B_CAROT,	-- 베타카로틴 ");
				sbSql.append("\n         ROUND(SUM(NVL(B.THIA,0)*A."+strNeedQty+")/100,2) THIA,		-- 티아민(비타민b1)		");
				sbSql.append("\n         ROUND(SUM(NVL(B.RIBO,0)*A."+strNeedQty+")/100,2) RIBO,		-- 리보플라빈(비타민B2)    ");
				sbSql.append("\n         ROUND(SUM(NVL(B.NIACIN,0)*A."+strNeedQty+")/100,2) NIACIN,	-- 나이아아신                          ");
				sbSql.append("\n         ROUND(SUM(NVL(B.VITA_C,0)*A."+strNeedQty+")/100,2) VITA_C,	-- 비타민C               ");
				sbSql.append("\n         ROUND(SUM(NVL(B.CHOLE,0)*A."+strNeedQty+")/100,2) CHOLE	-- 콜레스테롤                                 ");
				sbSql.append("\n    FROM           ");
				sbSql.append("\n          (        ");
				sbSql.append("\n          SELECT A.UPJANG, D.UPJANGNM, A.HALL_CD, E.HALL_NAME, A.MENU_DATE,  ");
			    sbSql.append("\n         		 A.MEAL, A.CORNER,  ");
			    sbSql.append("\n                 (SELECT CODE_NAME FROM SCC_COMMON_CODE X WHERE X.GROUP_CODE = 'FS0023' AND X.CODE = A.MEAL) || '(' ||  ");
			    sbSql.append("\n                 (SELECT CODE_NAME FROM SCC_COMMON_CODE X WHERE X.GROUP_CODE = 'FS0022' AND X.CODE = A.CORNER) || ')' MEAL_CORNER,  ");
			    sbSql.append("\n                 A.RECIPE_CD, A.RECIPE_NAME, A.ITEM_CODE, F.ITEM_NAME,  ");
			    sbSql.append("\n                 A.NEED_QTY, A.EDIBLE_QTY,  ");
				sbSql.append("\n                 ROUND(A.MARGIN_PRICE/F.KG_CONVERT_RATE/1000,2) AS G_ITEM_PRICE  ");
			    sbSql.append("\n            FROM FSM_MEAL_RECIPE_ADJUST A  ");
			    sbSql.append("\n                ,MAC_UPJANG_V D  ");
			    sbSql.append("\n                ,FSA_HALL_MST E  ");
			    sbSql.append("\n                ,HLDC_PO_ITEM_MST F  ");
			    sbSql.append("\n           WHERE A.UPJANG = D.UPJANG  ");
			    sbSql.append("\n             AND A.UPJANG = E.UPJANG  ");
			    sbSql.append("\n             AND A.HALL_CD = E.HALL_CD  ");
			    sbSql.append("\n             AND A.ITEM_CODE = F.ITEM_CODE  ");
			    sbSql.append("\n             AND A.UPJANG = "+strUpjang+"  ");
			    //sbSql.append("\n             AND A.MENU_DATE = '"+strMenuDate+"'  ");
				sbSql.append("\n            AND A.MENU_DATE BETWEEN '"+strMenuDate+"' AND  '"+strMenuDate2+"' ");			    
			    if(! strHalCD.equals("00000")){
					sbSql.append("\n             AND A.HALL_CD = '"+strHalCD+"' ");
				}
			    sbSql.append("\n     AND A.MENU_CD IN ( "+strMenuCd+" )  "); //('20071120-00101001001','20071120-00101002001')
				sbSql.append("\n          ) A                                                         ");
				sbSql.append("\n         ,FSI_ITEM_NUT B                                              ");
				sbSql.append("\n   WHERE A.ITEM_CODE = B.ITEM_CODE(+)                                 ");
				sbSql.append("\n   GROUP BY A.UPJANG, A.UPJANGNM, A.HALL_CD, A.HALL_NAME, A.MENU_DATE,");
				sbSql.append("\n            A.MEAL, A.CORNER, A.MEAL_CORNER,                          ");
				sbSql.append("\n            A.RECIPE_CD, A.RECIPE_NAME, A.ITEM_CODE, A.ITEM_NAME, 	  ");
				sbSql.append("\n			A.NEED_QTY, A.EDIBLE_QTY, G_ITEM_PRICE, B.DISUSE_RATE     ");
				sbSql.append("\n   ORDER BY A.MEAL, A.CORNER, A.MEAL_CORNER, RECIPE_NAME                                  ");
			}
			
		// 레시피별 영양관리
		}else {
			if(strAbolitionRate.equals("1") && strRecipe.equals("1")){
				sbSql.append("\n  SELECT A.UPJANG, A.UPJANGNM, A.HALL_CD, A.HALL_NAME,      ");
				sbSql.append("\n         SUBSTR(A.MENU_DATE,1,4) || '년 ' || SUBSTR(A.MENU_DATE,5,2) || '월 ' || SUBSTR(A.MENU_DATE,7,2) || '일' MENU_DATE,  ");
				sbSql.append("\n         A.MEAL, A.CORNER, A.MEAL_CORNER, ");
				sbSql.append("\n         A.RECIPE_CD, A.RECIPE_NAME, ");
				sbSql.append("\n         SUM(NVL(A.NEED_QTY,0)) NEED_QTY, ");
				sbSql.append("\n  		 ROUND(SUM(A.NEED_QTY * A.G_ITEM_PRICE),2) ITEM_COST,	");
				sbSql.append("\n         ROUND(SUM(NVL(B.CAL,0)*A."+strNeedQty+")/100,2) CAL,		-- 열량                    ");
				sbSql.append("\n         ROUND(SUM(NVL(B.WATER,0)*A."+strNeedQty+")/100,2) WATER,	-- 수분                    ");
				sbSql.append("\n         ROUND(SUM(NVL(B.PROT,0)*A."+strNeedQty+")/100,2) PROT,		-- 단백질         ");
				sbSql.append("\n         ROUND(SUM(NVL(B.FAT,0)*A."+strNeedQty+")/100,2) FAT,		-- 지방 (지질)    ");
				sbSql.append("\n         ROUND(SUM(NVL(B.CARBO,0)*A."+strNeedQty+")/100,2) CARBO,	-- 탄수화물(당질) ");
				sbSql.append("\n         ROUND(SUM(NVL(B.FIBER,0)*A."+strNeedQty+")/100,2) FIBER,	-- 섬유                    ");
				sbSql.append("\n         ROUND(SUM(NVL(B.ASH,0)*A."+strNeedQty+")/100,2) ASH,		-- 회분                    ");
				sbSql.append("\n         ROUND(SUM(NVL(B.CA,0)*A."+strNeedQty+")/100,2) CA,		-- 칼슘                    ");
				sbSql.append("\n         ROUND(SUM(NVL(B.P,0)*A."+strNeedQty+")/100,2) P,		-- 인분                            ");
				sbSql.append("\n         ROUND(SUM(NVL(B.FE,0)*A."+strNeedQty+")/100,2) FE,		-- 철분                    ");
				sbSql.append("\n         ROUND(SUM(NVL(B.NA,0)*A."+strNeedQty+")/100,2) NA,		-- 나트륨                 ");
				sbSql.append("\n         ROUND(SUM(NVL(B.K,0)*A."+strNeedQty+")/100,2) K,		-- 칼륨                            ");
				sbSql.append("\n         ROUND(SUM(NVL(B.VITA_A,0)*A."+strNeedQty+")/100,2) VITA_A,	-- 비타민A   ");
				sbSql.append("\n         ROUND(SUM(NVL(B.RETIN,0)*A."+strNeedQty+")/100,2) RETIN,	-- 레티놀                ");
				sbSql.append("\n         ROUND(SUM(NVL(B.B_CAROT,0)*A."+strNeedQty+")/100,2) B_CAROT,	-- 베타카로틴 ");
				sbSql.append("\n         ROUND(SUM(NVL(B.THIA,0)*A."+strNeedQty+")/100,2) THIA,		-- 티아민(비타민b1)		");
				sbSql.append("\n         ROUND(SUM(NVL(B.RIBO,0)*A."+strNeedQty+")/100,2) RIBO,		-- 리보플라빈(비타민B2)    ");
				sbSql.append("\n         ROUND(SUM(NVL(B.NIACIN,0)*A."+strNeedQty+")/100,2) NIACIN,	-- 나이아아신                          ");
				sbSql.append("\n         ROUND(SUM(NVL(B.VITA_C,0)*A."+strNeedQty+")/100,2) VITA_C,	-- 비타민C               ");
				sbSql.append("\n         ROUND(SUM(NVL(B.CHOLE,0)*A."+strNeedQty+")/100,2) CHOLE	-- 콜레스테롤                                 ");
				sbSql.append("\n    FROM     ");
				sbSql.append("\n          (  ");				
				sbSql.append("\n          SELECT A.UPJANG, D.UPJANGNM, A.HALL_CD, E.HALL_NAME, A.MENU_DATE,  ");
				sbSql.append("\n                 A.MEAL, A.CORNER,  ");
				sbSql.append("\n                 (SELECT CODE_NAME FROM SCC_COMMON_CODE X WHERE X.GROUP_CODE = 'FS0023' AND X.CODE = A.MEAL) || '(' ||							");
				sbSql.append("\n                 (SELECT CODE_NAME FROM SCC_COMMON_CODE X WHERE X.GROUP_CODE = 'FS0022' AND X.CODE = A.CORNER) || ')' MEAL_CORNER, ");
				sbSql.append("\n                 A.RECIPE_CD, A.RECIPE_NAME, A.ITEM_CODE, F.ITEM_NAME,  ");
				sbSql.append("\n                 A.NEED_QTY, A.EDIBLE_QTY,");
				sbSql.append("\n                 ROUND(A.MARGIN_PRICE/F.KG_CONVERT_RATE/1000,2) AS G_ITEM_PRICE  ");
				sbSql.append("\n            FROM FSM_MEAL_RECIPE_ADJUST A     ");
				sbSql.append("\n                ,MAC_UPJANG_V D               ");
				sbSql.append("\n                ,FSA_HALL_MST E               ");
				sbSql.append("\n                ,HLDC_PO_ITEM_MST F           ");
				sbSql.append("\n           WHERE A.UPJANG = D.UPJANG          ");
				sbSql.append("\n             AND A.UPJANG = E.UPJANG          ");
				sbSql.append("\n             AND A.HALL_CD = E.HALL_CD        ");
				sbSql.append("\n             AND A.ITEM_CODE = F.ITEM_CODE    ");
				sbSql.append("\n             AND A.UPJANG = "+strUpjang+"     ");
				//sbSql.append("\n             AND A.MENU_DATE = '"+strMenuDate+"' ");
				sbSql.append("\n            AND A.MENU_DATE BETWEEN '"+strMenuDate+"' AND  '"+strMenuDate2+"' ");
				if(! strHalCD.equals("00000")){
					sbSql.append("\n             AND A.HALL_CD = '"+strHalCD+"'  ");
				}
				sbSql.append("\n             AND A.MENU_CD IN ( "+strMenuCd+" )  "); //('20071120-00101001001','20071120-00101002001')
				sbSql.append("\n          ) A                                                         ");
				sbSql.append("\n         ,FSI_ITEM_NUT B                                              ");
				sbSql.append("\n   WHERE A.ITEM_CODE = B.ITEM_CODE(+)                                 ");
				sbSql.append("\n   GROUP BY A.UPJANG, A.UPJANGNM, A.HALL_CD, A.HALL_NAME, A.MENU_DATE,");
				sbSql.append("\n            A.MEAL, A.CORNER, A.MEAL_CORNER,                ");
				sbSql.append("\n            A.RECIPE_CD, A.RECIPE_NAME                           	  ");
//				sbSql.append("\n			A.NEED_QTY                                                ");
				sbSql.append("\n   ORDER BY A.MEAL, A.CORNER, A.MEAL_CORNER, RECIPE_NAME                                  ");
				
			// 폐기율 미적용_레시피 수정미적용	
			}else if(strAbolitionRate.equals("0") && strRecipe.equals("0")) {
				sbSql.append("\n  SELECT A.UPJANG, A.UPJANGNM, A.HALL_CD, A.HALL_NAME,      ");
				sbSql.append("\n         SUBSTR(A.MENU_DATE,1,4) || '년 ' || SUBSTR(A.MENU_DATE,5,2) || '월 ' || SUBSTR(A.MENU_DATE,7,2) || '일' MENU_DATE,  ");
				sbSql.append("\n         A.MEAL, A.CORNER, A.MEAL_CORNER, ");
				sbSql.append("\n         A.RECIPE_CD, A.RECIPE_NAME, ");
				sbSql.append("\n         SUM(NVL(A.NEED_QTY,0)) NEED_QTY, ");
				sbSql.append("\n  		 ROUND(SUM(A.NEED_QTY * A.G_ITEM_PRICE),2) ITEM_COST,	");
				sbSql.append("\n         ROUND(SUM(NVL(B.CAL,0)*A."+strNeedQty+")/100,2) CAL,		-- 열량                    ");
				sbSql.append("\n         ROUND(SUM(NVL(B.WATER,0)*A."+strNeedQty+")/100,2) WATER,	-- 수분                    ");
				sbSql.append("\n         ROUND(SUM(NVL(B.PROT,0)*A."+strNeedQty+")/100,2) PROT,		-- 단백질         ");
				sbSql.append("\n         ROUND(SUM(NVL(B.FAT,0)*A."+strNeedQty+")/100,2) FAT,		-- 지방 (지질)    ");
				sbSql.append("\n         ROUND(SUM(NVL(B.CARBO,0)*A."+strNeedQty+")/100,2) CARBO,	-- 탄수화물(당질) ");
				sbSql.append("\n         ROUND(SUM(NVL(B.FIBER,0)*A."+strNeedQty+")/100,2) FIBER,	-- 섬유                    ");
				sbSql.append("\n         ROUND(SUM(NVL(B.ASH,0)*A."+strNeedQty+")/100,2) ASH,		-- 회분                    ");
				sbSql.append("\n         ROUND(SUM(NVL(B.CA,0)*A."+strNeedQty+")/100,2) CA,		-- 칼슘                    ");
				sbSql.append("\n         ROUND(SUM(NVL(B.P,0)*A."+strNeedQty+")/100,2) P,		-- 인분                            ");
				sbSql.append("\n         ROUND(SUM(NVL(B.FE,0)*A."+strNeedQty+")/100,2) FE,		-- 철분                    ");
				sbSql.append("\n         ROUND(SUM(NVL(B.NA,0)*A."+strNeedQty+")/100,2) NA,		-- 나트륨                 ");
				sbSql.append("\n         ROUND(SUM(NVL(B.K,0)*A."+strNeedQty+")/100,2) K,		-- 칼륨                            ");
				sbSql.append("\n         ROUND(SUM(NVL(B.VITA_A,0)*A."+strNeedQty+")/100,2) VITA_A,	-- 비타민A   ");
				sbSql.append("\n         ROUND(SUM(NVL(B.RETIN,0)*A."+strNeedQty+")/100,2) RETIN,	-- 레티놀                ");
				sbSql.append("\n         ROUND(SUM(NVL(B.B_CAROT,0)*A."+strNeedQty+")/100,2) B_CAROT,	-- 베타카로틴 ");
				sbSql.append("\n         ROUND(SUM(NVL(B.THIA,0)*A."+strNeedQty+")/100,2) THIA,		-- 티아민(비타민b1)		");
				sbSql.append("\n         ROUND(SUM(NVL(B.RIBO,0)*A."+strNeedQty+")/100,2) RIBO,		-- 리보플라빈(비타민B2)    ");
				sbSql.append("\n         ROUND(SUM(NVL(B.NIACIN,0)*A."+strNeedQty+")/100,2) NIACIN,	-- 나이아아신                          ");
				sbSql.append("\n         ROUND(SUM(NVL(B.VITA_C,0)*A."+strNeedQty+")/100,2) VITA_C,	-- 비타민C               ");
				sbSql.append("\n         ROUND(SUM(NVL(B.CHOLE,0)*A."+strNeedQty+")/100,2) CHOLE	-- 콜레스테롤                                 ");
				sbSql.append("\n    FROM     ");
				sbSql.append("\n          (  ");				
				sbSql.append("\n          SELECT A.UPJANG, D.UPJANGNM, A.HALL_CD, E.HALL_NAME, A.MENU_DATE,	");
				sbSql.append("\n                 A.MEAL, A.CORNER,                                          ");
				sbSql.append("\n                 (SELECT CODE_NAME FROM SCC_COMMON_CODE X WHERE X.GROUP_CODE = 'FS0023' AND X.CODE = A.MEAL) || '(' ||					");
				sbSql.append("\n                 (SELECT CODE_NAME FROM SCC_COMMON_CODE X WHERE X.GROUP_CODE = 'FS0022' AND X.CODE = A.CORNER) || ')' MEAL_CORNER,	");
				sbSql.append("\n                 B.RECIPE_CD, B.RECIPE_NAME, C.ITEM_CODE, F.ITEM_NAME,      ");
				sbSql.append("\n                 C.EDIBLE_QTY, C.NEED_QTY,");
				sbSql.append("\n                 ROUND(C.MARGIN_PRICE/F.KG_CONVERT_RATE/1000,2) AS G_ITEM_PRICE  ");
				sbSql.append("\n            FROM FSM_REAL_MENU_MST A          ");
				sbSql.append("\n                ,FSM_REAL_RECIPE_MST B        ");
				sbSql.append("\n                ,FSM_REAL_RECIPE_ITEM C       ");
				sbSql.append("\n                ,MAC_UPJANG_V D               ");
				sbSql.append("\n                ,FSA_HALL_MST E               ");
				sbSql.append("\n                ,HLDC_PO_ITEM_MST F           ");
				sbSql.append("\n           WHERE A.UPJANG = B.UPJANG          ");
				sbSql.append("\n             AND A.MENU_CD = B.MENU_CD        ");
				sbSql.append("\n             AND B.UPJANG = C.UPJANG          ");
				sbSql.append("\n             AND B.MENU_CD = C.MENU_CD        ");
				sbSql.append("\n             AND B.RECIPE_CD = C.RECIPE_CD    ");
				sbSql.append("\n             AND A.UPJANG = D.UPJANG          ");
				sbSql.append("\n             AND A.UPJANG = E.UPJANG          ");
				sbSql.append("\n             AND A.HALL_CD = E.HALL_CD        ");
				sbSql.append("\n             AND C.ITEM_CODE = F.ITEM_CODE    ");
				sbSql.append("\n             AND A.UPJANG = "+strUpjang+"	  ");
				//sbSql.append("\n             AND A.MENU_DATE = '"+strMenuDate+"' ");
				sbSql.append("\n            AND A.MENU_DATE BETWEEN '"+strMenuDate+"' AND  '"+strMenuDate2+"' ");
				if(! strHalCD.equals("00000")){
					sbSql.append("\n             AND A.HALL_CD = '"+strHalCD+"'  ");
				}
				sbSql.append("\n             AND A.MENU_CD IN ( "+strMenuCd+" )  "); //('20071120-00101001001','20071120-00101002001')
				sbSql.append("\n          ) A                                                         ");
				sbSql.append("\n         ,FSI_ITEM_NUT B                                              ");
				sbSql.append("\n   WHERE A.ITEM_CODE = B.ITEM_CODE(+)                                 ");
				sbSql.append("\n   GROUP BY A.UPJANG, A.UPJANGNM, A.HALL_CD, A.HALL_NAME, A.MENU_DATE,");
				sbSql.append("\n            A.MEAL, A.CORNER, A.MEAL_CORNER,                          ");
				sbSql.append("\n            A.RECIPE_CD, A.RECIPE_NAME                           	  ");
//				sbSql.append("\n			A.NEED_QTY                                                ");
				sbSql.append("\n   ORDER BY A.MEAL, A.CORNER, A.MEAL_CORNER, RECIPE_NAME                                  ");

				// 폐기율 적용_레시피수정 미적용				
			} else if(strAbolitionRate.equals("1") && strRecipe.equals("0")) {
				sbSql.append("\n  SELECT A.UPJANG, A.UPJANGNM, A.HALL_CD, A.HALL_NAME,      ");
				sbSql.append("\n         SUBSTR(A.MENU_DATE,1,4) || '년 ' || SUBSTR(A.MENU_DATE,5,2) || '월 ' || SUBSTR(A.MENU_DATE,7,2) || '일' MENU_DATE,  ");
				sbSql.append("\n         A.MEAL, A.CORNER, A.MEAL_CORNER,   ");
				sbSql.append("\n         A.RECIPE_CD, A.RECIPE_NAME, ");
				sbSql.append("\n         SUM(NVL(A.NEED_QTY,0)) NEED_QTY, ");
				sbSql.append("\n  		 ROUND(SUM(A.NEED_QTY * A.G_ITEM_PRICE),2) ITEM_COST,	");
				sbSql.append("\n         ROUND(SUM(NVL(B.CAL,0)*A."+strNeedQty+")/100,2) CAL,		-- 열량                    ");
				sbSql.append("\n         ROUND(SUM(NVL(B.WATER,0)*A."+strNeedQty+")/100,2) WATER,	-- 수분                    ");
				sbSql.append("\n         ROUND(SUM(NVL(B.PROT,0)*A."+strNeedQty+")/100,2) PROT,		-- 단백질         ");
				sbSql.append("\n         ROUND(SUM(NVL(B.FAT,0)*A."+strNeedQty+")/100,2) FAT,		-- 지방 (지질)    ");
				sbSql.append("\n         ROUND(SUM(NVL(B.CARBO,0)*A."+strNeedQty+")/100,2) CARBO,	-- 탄수화물(당질) ");
				sbSql.append("\n         ROUND(SUM(NVL(B.FIBER,0)*A."+strNeedQty+")/100,2) FIBER,	-- 섬유                    ");
				sbSql.append("\n         ROUND(SUM(NVL(B.ASH,0)*A."+strNeedQty+")/100,2) ASH,		-- 회분                    ");
				sbSql.append("\n         ROUND(SUM(NVL(B.CA,0)*A."+strNeedQty+")/100,2) CA,		-- 칼슘                    ");
				sbSql.append("\n         ROUND(SUM(NVL(B.P,0)*A."+strNeedQty+")/100,2) P,		-- 인분                            ");
				sbSql.append("\n         ROUND(SUM(NVL(B.FE,0)*A."+strNeedQty+")/100,2) FE,		-- 철분                    ");
				sbSql.append("\n         ROUND(SUM(NVL(B.NA,0)*A."+strNeedQty+")/100,2) NA,		-- 나트륨                 ");
				sbSql.append("\n         ROUND(SUM(NVL(B.K,0)*A."+strNeedQty+")/100,2) K,		-- 칼륨                            ");
				sbSql.append("\n         ROUND(SUM(NVL(B.VITA_A,0)*A."+strNeedQty+")/100,2) VITA_A,	-- 비타민A   ");
				sbSql.append("\n         ROUND(SUM(NVL(B.RETIN,0)*A."+strNeedQty+")/100,2) RETIN,	-- 레티놀                ");
				sbSql.append("\n         ROUND(SUM(NVL(B.B_CAROT,0)*A."+strNeedQty+")/100,2) B_CAROT,	-- 베타카로틴 ");
				sbSql.append("\n         ROUND(SUM(NVL(B.THIA,0)*A."+strNeedQty+")/100,2) THIA,		-- 티아민(비타민b1)		");
				sbSql.append("\n         ROUND(SUM(NVL(B.RIBO,0)*A."+strNeedQty+")/100,2) RIBO,		-- 리보플라빈(비타민B2)    ");
				sbSql.append("\n         ROUND(SUM(NVL(B.NIACIN,0)*A."+strNeedQty+")/100,2) NIACIN,	-- 나이아아신                          ");
				sbSql.append("\n         ROUND(SUM(NVL(B.VITA_C,0)*A."+strNeedQty+")/100,2) VITA_C,	-- 비타민C               ");
				sbSql.append("\n         ROUND(SUM(NVL(B.CHOLE,0)*A."+strNeedQty+")/100,2) CHOLE	-- 콜레스테롤                                 ");
				sbSql.append("\n    FROM     ");
				sbSql.append("\n          (  ");				
				sbSql.append("\n          SELECT A.UPJANG, D.UPJANGNM, A.HALL_CD, E.HALL_NAME, A.MENU_DATE,	");
				sbSql.append("\n                 A.MEAL, A.CORNER,                                          ");
				sbSql.append("\n                 (SELECT CODE_NAME FROM SCC_COMMON_CODE X WHERE X.GROUP_CODE = 'FS0023' AND X.CODE = A.MEAL) || '(' ||				");
				sbSql.append("\n                 (SELECT CODE_NAME FROM SCC_COMMON_CODE X WHERE X.GROUP_CODE = 'FS0022' AND X.CODE = A.CORNER) || ')' MEAL_CORNER,	");
				sbSql.append("\n                 B.RECIPE_CD, B.RECIPE_NAME, C.ITEM_CODE, F.ITEM_NAME,      ");
				sbSql.append("\n                 C.EDIBLE_QTY, C.NEED_QTY, ");
				sbSql.append("\n                 ROUND(C.MARGIN_PRICE/F.KG_CONVERT_RATE/1000,2) AS G_ITEM_PRICE  ");
				sbSql.append("\n            FROM FSM_REAL_MENU_MST A          ");
				sbSql.append("\n                ,FSM_REAL_RECIPE_MST B        ");
				sbSql.append("\n                ,FSM_REAL_RECIPE_ITEM C       ");
				sbSql.append("\n                ,MAC_UPJANG_V D               ");
				sbSql.append("\n                ,FSA_HALL_MST E               ");
				sbSql.append("\n                ,HLDC_PO_ITEM_MST F           ");
				sbSql.append("\n           WHERE A.UPJANG = B.UPJANG          ");
				sbSql.append("\n             AND A.MENU_CD = B.MENU_CD        ");
				sbSql.append("\n             AND B.UPJANG = C.UPJANG          ");
				sbSql.append("\n             AND B.MENU_CD = C.MENU_CD        ");
				sbSql.append("\n             AND B.RECIPE_CD = C.RECIPE_CD    ");
				sbSql.append("\n             AND A.UPJANG = D.UPJANG          ");
				sbSql.append("\n             AND A.UPJANG = E.UPJANG          ");
				sbSql.append("\n             AND A.HALL_CD = E.HALL_CD        ");
				sbSql.append("\n             AND C.ITEM_CODE = F.ITEM_CODE    ");
				sbSql.append("\n             AND A.UPJANG = "+strUpjang+"	  ");
				//sbSql.append("\n             AND A.MENU_DATE = '"+strMenuDate+"' ");
				sbSql.append("\n            AND A.MENU_DATE BETWEEN '"+strMenuDate+"' AND  '"+strMenuDate2+"' ");
				if(! strHalCD.equals("00000")){
					sbSql.append("\n             AND A.HALL_CD = '"+strHalCD+"'  ");
				}
				sbSql.append("\n             AND A.MENU_CD IN ( "+strMenuCd+" )  "); //('20071120-00101001001','20071120-00101002001')
				sbSql.append("\n          ) A                                                         ");
				sbSql.append("\n         ,FSI_ITEM_NUT B                                              ");
				sbSql.append("\n   WHERE A.ITEM_CODE = B.ITEM_CODE(+)                                 ");
				sbSql.append("\n   GROUP BY A.UPJANG, A.UPJANGNM, A.HALL_CD, A.HALL_NAME, A.MENU_DATE,");
				sbSql.append("\n            A.MEAL, A.CORNER, A.MEAL_CORNER,                          ");
				sbSql.append("\n            A.RECIPE_CD, A.RECIPE_NAME                           	  ");
//				sbSql.append("\n			A.NEED_QTY                                                ");
				sbSql.append("\n   ORDER BY A.MEAL, A.CORNER, A.MEAL_CORNER, RECIPE_NAME                                  ");


				// 폐기율 미적용_레시피 수정 적용
			}else {
				sbSql.append("\n  SELECT A.UPJANG, A.UPJANGNM, A.HALL_CD, A.HALL_NAME,      ");
				sbSql.append("\n         SUBSTR(A.MENU_DATE,1,4) || '년 ' || SUBSTR(A.MENU_DATE,5,2) || '월 ' || SUBSTR(A.MENU_DATE,7,2) || '일' MENU_DATE,  ");
				sbSql.append("\n         A.MEAL, A.CORNER, A.MEAL_CORNER, ");
				sbSql.append("\n         A.RECIPE_CD, A.RECIPE_NAME, ");
				sbSql.append("\n         SUM(NVL(A.NEED_QTY,0)) NEED_QTY, ");
				sbSql.append("\n  		 ROUND(SUM(A.NEED_QTY * A.G_ITEM_PRICE),2) ITEM_COST,	");
				sbSql.append("\n         ROUND(SUM(NVL(B.CAL,0)*A."+strNeedQty+")/100,2) CAL,		-- 열량                    ");
				sbSql.append("\n         ROUND(SUM(NVL(B.WATER,0)*A."+strNeedQty+")/100,2) WATER,	-- 수분                    ");
				sbSql.append("\n         ROUND(SUM(NVL(B.PROT,0)*A."+strNeedQty+")/100,2) PROT,		-- 단백질         ");
				sbSql.append("\n         ROUND(SUM(NVL(B.FAT,0)*A."+strNeedQty+")/100,2) FAT,		-- 지방 (지질)    ");
				sbSql.append("\n         ROUND(SUM(NVL(B.CARBO,0)*A."+strNeedQty+")/100,2) CARBO,	-- 탄수화물(당질) ");
				sbSql.append("\n         ROUND(SUM(NVL(B.FIBER,0)*A."+strNeedQty+")/100,2) FIBER,	-- 섬유                    ");
				sbSql.append("\n         ROUND(SUM(NVL(B.ASH,0)*A."+strNeedQty+")/100,2) ASH,		-- 회분                    ");
				sbSql.append("\n         ROUND(SUM(NVL(B.CA,0)*A."+strNeedQty+")/100,2) CA,		-- 칼슘                    ");
				sbSql.append("\n         ROUND(SUM(NVL(B.P,0)*A."+strNeedQty+")/100,2) P,		-- 인분                            ");
				sbSql.append("\n         ROUND(SUM(NVL(B.FE,0)*A."+strNeedQty+")/100,2) FE,		-- 철분                    ");
				sbSql.append("\n         ROUND(SUM(NVL(B.NA,0)*A."+strNeedQty+")/100,2) NA,		-- 나트륨                 ");
				sbSql.append("\n         ROUND(SUM(NVL(B.K,0)*A."+strNeedQty+")/100,2) K,		-- 칼륨                            ");
				sbSql.append("\n         ROUND(SUM(NVL(B.VITA_A,0)*A."+strNeedQty+")/100,2) VITA_A,	-- 비타민A   ");
				sbSql.append("\n         ROUND(SUM(NVL(B.RETIN,0)*A."+strNeedQty+")/100,2) RETIN,	-- 레티놀                ");
				sbSql.append("\n         ROUND(SUM(NVL(B.B_CAROT,0)*A."+strNeedQty+")/100,2) B_CAROT,	-- 베타카로틴 ");
				sbSql.append("\n         ROUND(SUM(NVL(B.THIA,0)*A."+strNeedQty+")/100,2) THIA,		-- 티아민(비타민b1)		");
				sbSql.append("\n         ROUND(SUM(NVL(B.RIBO,0)*A."+strNeedQty+")/100,2) RIBO,		-- 리보플라빈(비타민B2)    ");
				sbSql.append("\n         ROUND(SUM(NVL(B.NIACIN,0)*A."+strNeedQty+")/100,2) NIACIN,	-- 나이아아신                          ");
				sbSql.append("\n         ROUND(SUM(NVL(B.VITA_C,0)*A."+strNeedQty+")/100,2) VITA_C,	-- 비타민C               ");
				sbSql.append("\n         ROUND(SUM(NVL(B.CHOLE,0)*A."+strNeedQty+")/100,2) CHOLE	-- 콜레스테롤                                 ");
				sbSql.append("\n    FROM           ");
				sbSql.append("\n          (        ");
				sbSql.append("\n          SELECT A.UPJANG, D.UPJANGNM, A.HALL_CD, E.HALL_NAME, A.MENU_DATE,  ");
				sbSql.append("\n                 A.MEAL, A.CORNER,  ");
				sbSql.append("\n                 (SELECT CODE_NAME FROM SCC_COMMON_CODE X WHERE X.GROUP_CODE = 'FS0023' AND X.CODE = A.MEAL) || '(' ||		");
				sbSql.append("\n                 (SELECT CODE_NAME FROM SCC_COMMON_CODE X WHERE X.GROUP_CODE = 'FS0022' AND X.CODE = A.CORNER) || ')' MEAL_CORNER, ");
				sbSql.append("\n                 A.RECIPE_CD, A.RECIPE_NAME, A.ITEM_CODE, F.ITEM_NAME,  ");
				sbSql.append("\n                 A.NEED_QTY, A.EDIBLE_QTY,");
				sbSql.append("\n                 ROUND(A.MARGIN_PRICE/F.KG_CONVERT_RATE/1000,2) AS G_ITEM_PRICE  ");
				sbSql.append("\n            FROM FSM_MEAL_RECIPE_ADJUST A     ");
				sbSql.append("\n                ,MAC_UPJANG_V D               ");
				sbSql.append("\n                ,FSA_HALL_MST E               ");
				sbSql.append("\n                ,HLDC_PO_ITEM_MST F           ");
				sbSql.append("\n           WHERE A.UPJANG = D.UPJANG          ");
				sbSql.append("\n             AND A.UPJANG = E.UPJANG          ");
				sbSql.append("\n             AND A.HALL_CD = E.HALL_CD        ");
				sbSql.append("\n             AND A.ITEM_CODE = F.ITEM_CODE    ");
				sbSql.append("\n             AND A.UPJANG = "+strUpjang+"     ");
				//sbSql.append("\n             AND A.MENU_DATE = '"+strMenuDate+"' ");
				sbSql.append("\n            AND A.MENU_DATE BETWEEN '"+strMenuDate+"' AND  '"+strMenuDate2+"' ");
				if(! strHalCD.equals("00000")){
					sbSql.append("\n             AND A.HALL_CD = '"+strHalCD+"'  ");
				}
				sbSql.append("\n             AND A.MENU_CD IN ( "+strMenuCd+" )  "); //('20071120-00101001001','20071120-00101002001')
				sbSql.append("\n          ) A                                                         ");
				sbSql.append("\n         ,FSI_ITEM_NUT B                                              ");
				sbSql.append("\n   WHERE A.ITEM_CODE = B.ITEM_CODE(+)                                 ");
				sbSql.append("\n   GROUP BY A.UPJANG, A.UPJANGNM, A.HALL_CD, A.HALL_NAME, A.MENU_DATE,");
				sbSql.append("\n            A.MEAL, A.CORNER, A.MEAL_CORNER,                          ");
				sbSql.append("\n            A.RECIPE_CD, A.RECIPE_NAME                           	  ");
//				sbSql.append("\n			A.NEED_QTY                                                ");
				sbSql.append("\n   ORDER BY A.MEAL, A.CORNER, A.MEAL_CORNER, RECIPE_NAME                                  ");
			}
		}

		System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		DataSet ds_MainList = this.makeDataSet(rs, "ds_MainList"); //ds_list

		/**종료**/
		out_dl.add(ds_MainList);
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