<%
//////////////////////////////////////////////////////////
//프로그램명: FSM00221P_T001.jsp
//작   성   일: 2008.05.09
//작   성   자: 한화S&C 제조서비스 프로젝트팀 박종세 
//프로그램기능: 코너일괄복사   ::: 식단등록==>주기식단==>코너일괄복사
///////////////////////////////////////////////////////////
%>
<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	Statement stmt             =  null;
	try {
		PlatformRequest platformRequest = this.proc_input(request);  
		// 입력 데이터셋리스트
		in_dl = platformRequest.getData().getDataSetList();
		// 입력  변수리스트
		in_vl = platformRequest.getData().getVariableList();
		
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));
		
	
		String g_EmpNo 		   = in_vl.getString("g_EmpNo");
		String v_UPJANG        = in_vl.getString("UPJANG");
		String v_HALL_CD       = in_vl.getString("HALL_CD");
		String v_SOURCE_CORNER = in_vl.getString("SOURCE_CORNER");
		String v_TARGET_CORNER_LIST = in_vl.getString("TARGET_CORNER_LIST");
	    String v_TARGET_CORNER = "";
	    String v_START_DATE    = in_vl.getString("START_DATE");
		String v_END_DATE      = in_vl.getString("END_DATE");
		String v_OVER_WRITE    = in_vl.getString("OVER_WRITE");				
		String v_NEED_DATE          = "";                                               //타겟 아이템 NEED_DATE
		
		//타켓코너
		String[] arrTARGET_CORNER = v_TARGET_CORNER_LIST.split(",");
		
		stmt 		=  conn.createStatement();		
		StringBuffer sbMySql = new StringBuffer();
		
		int    i = 0;
		for(i=0;i<arrTARGET_CORNER.length;i++)
		{
			//타켓코너를 변경해간다.
			v_TARGET_CORNER = arrTARGET_CORNER[i];			
			
			sbMySql.delete(0, sbMySql.length());	
			sbMySql.append("--레시피마스터에서 복사대상 삭제옵션(삭제, 건너뛰기)  \n  \n");
			
			if(v_OVER_WRITE.equals("1"))
			{
				sbMySql.append("--1.삭제옵션 선택시  \n");
				sbMySql.append("    --무조건 삭제 명령어를 실행 (중요: 원본은 점심만 있고 대상은 아침점심저녁이 있으면 점심만 삭제해야함)  \n");
				sbMySql.append("    DELETE FROM FSH_CYCLE_RECIPE_MST  \n");
				sbMySql.append("    WHERE  MENU_CD IN  \n");
				sbMySql.append("           (SELECT  SUBSTR(A.MENU_CD,1,17 )|| '" + v_TARGET_CORNER + "' AS MENU_CD        --복사대상의 메뉴CD  \n");
				sbMySql.append("              FROM  FSH_CYCLE_MENU_MST    A  \n");
				sbMySql.append("             WHERE  A.UPJANG  = " + v_UPJANG + "  \n");
		  		sbMySql.append("               AND  A.HALL_CD  = '" + v_HALL_CD + "'  \n");
				sbMySql.append("               AND  A.CORNER  = '" + v_SOURCE_CORNER + "'                                 --원본코너  \n");
				sbMySql.append("               AND  A.MEAL   IN  \n");
				sbMySql.append("                   (SELECT MEAL FROM FSA_HALL_DTL WHERE UPJANG  = " + v_UPJANG + "  AND HALL_CD = '" + v_HALL_CD + "' AND CORNER='" + v_SOURCE_CORNER + "'  AND USE_YN='Y') --복사원본의  끼니만 삭제한다.  \n");
				sbMySql.append("               AND  A.MENU_DATE BETWEEN '" + v_START_DATE + "' AND '" + v_END_DATE + "')    --원본코너 대상날짜  \n");
				
				stmt.execute(sbMySql.toString());		
			
			
				sbMySql.delete(0, sbMySql.length());	
				sbMySql.append("    --레시피마스터 복사 INSERT 한다  \n");
				sbMySql.append("    INSERT INTO FSH_CYCLE_RECIPE_MST (UPJANG, MENU_CD, RECIPE_CD, RECIPE_NAME, RECIPE_CLASS, RECIPE_TYPE, CUISINE_TYPE, MAIN_ITEM_CODE1, MAIN_ITEM_CODE2, COOK_TOOL1, COOK_TOOL2, MAJOR_DISH_INFO, RECIPE_COLOR, RECIPE_SHAPE, RECIPE_TASTE, RECIPE_FEEL, RECIPE_TEMPER, SPRING_YN, SUMMER_YN, AUTUMN_YN, WINTER_YN, RESP_NUT1, RESP_NUT2, USE_TOOL, VALID_TIME, DISPLAY_METHOD, SALE_UOM, SALE_PRICE, COST_RATE, COOK_1MAN_QTY, COOK_TIME, EXPECT_SALE_QTY, REAL_SALE_QTY, CORE_TEMPER_YN, GOODS_FEATURE, PHF_MGMT_YN, PHF_MGMT1, PHF_MGMT2, PHF_MGMT3, PHF_MGMT4, PHF_MGMT5, COOK_OPRN, PHOTO_PATH, PREFER, ORIGIN_RECIPE, CUSER, CDATE, UUSER, UDATE, SPHOTO_PATH, PHF, RECIPE_SEQ)  \n");
				sbMySql.append("    SELECT  B.UPJANG, SUBSTR(B.MENU_CD,1,17 )||'" + v_TARGET_CORNER + "' AS MENU_CD,      --복사대상의 메뉴CD  \n");
				sbMySql.append("            B.RECIPE_CD, B.RECIPE_NAME, B.RECIPE_CLASS, B.RECIPE_TYPE, B.CUISINE_TYPE, B.MAIN_ITEM_CODE1, B.MAIN_ITEM_CODE2, B.COOK_TOOL1, B.COOK_TOOL2, B.MAJOR_DISH_INFO, B.RECIPE_COLOR, B.RECIPE_SHAPE, B.RECIPE_TASTE, B.RECIPE_FEEL, B.RECIPE_TEMPER, B.SPRING_YN, B.SUMMER_YN, B.AUTUMN_YN, B.WINTER_YN, B.RESP_NUT1, B.RESP_NUT2, B.USE_TOOL, B.VALID_TIME, B.DISPLAY_METHOD, B.SALE_UOM, B.SALE_PRICE, B.COST_RATE, B.COOK_1MAN_QTY, B.COOK_TIME, B.EXPECT_SALE_QTY, B.REAL_SALE_QTY, B.CORE_TEMPER_YN, B.GOODS_FEATURE, B.PHF_MGMT_YN, B.PHF_MGMT1, B.PHF_MGMT2, B.PHF_MGMT3, B.PHF_MGMT4, B.PHF_MGMT5, B.COOK_OPRN, B.PHOTO_PATH, B.PREFER, B.ORIGIN_RECIPE, '"+ g_EmpNo +"' AS  CUSER, SYSDATE, '"+ g_EmpNo +"' AS UUSER,SYSDATE, B.SPHOTO_PATH, B.PHF, B.RECIPE_SEQ  \n");
				sbMySql.append("    FROM    FSH_CYCLE_MENU_MST    A  \n");
				sbMySql.append("           ,FSH_CYCLE_RECIPE_MST  B  \n");
				sbMySql.append("    WHERE  A.MENU_CD = B.MENU_CD  \n");
				sbMySql.append("    AND    A.UPJANG  = B.UPJANG       \n");
				sbMySql.append("    AND    A.UPJANG  = " + v_UPJANG + "                              --업장  \n");
				sbMySql.append("    AND    A.HALL_CD  = '" + v_HALL_CD + "'  \n");
				sbMySql.append("    AND    A.CORNER  = '" + v_SOURCE_CORNER + "'                                 --원본코너  \n");
				sbMySql.append("    AND    A.MENU_DATE BETWEEN '" + v_START_DATE + "' AND '" + v_END_DATE + "'     --원본코너 대상날짜  \n");
				sbMySql.append("    AND    A.MEAL   IN  \n");
				sbMySql.append("           (SELECT MEAL FROM FSA_HALL_DTL WHERE UPJANG  = " + v_UPJANG + " AND HALL_CD = '" + v_HALL_CD + "' AND CORNER='" + v_TARGET_CORNER + "'  AND USE_YN='Y' ) --복사대상의끼니만 복사한다.  \n");
		
				stmt.execute(sbMySql.toString());
								
				/////////////////////////////////////////////
				///// 자재
				/////////////////////////////////////////////
				sbMySql.delete(0, sbMySql.length());	
				
				sbMySql.append("--레시피자재에서 복사대상 삭제옵션(삭제, 건너뛰기)  \n");
				sbMySql.append("--1.삭제옵션 선택시  \n");
				sbMySql.append("    --무조건 삭제 명령어를 실행 (중요: 원본은 점심만 있고 대상은 아침점심저녁이 있으면 점심만 삭제해야함)  \n");
				sbMySql.append("    DELETE FROM FSH_CYCLE_RECIPE_ITEM  \n");
				sbMySql.append("    WHERE  MENU_CD IN  \n");
				sbMySql.append("           (SELECT  SUBSTR(A.MENU_CD,1,17 )||'" + v_TARGET_CORNER + "' AS MENU_CD        --복사대상의 메뉴CD  \n");
				sbMySql.append("              FROM  FSH_CYCLE_MENU_MST     A  \n");
				sbMySql.append("            WHERE  A.UPJANG  = " + v_UPJANG + "  \n");
				sbMySql.append("            AND    A.HALL_CD  = '" + v_HALL_CD + "'  \n");
				sbMySql.append("            AND    A.CORNER  = '" + v_SOURCE_CORNER + "'                                 --원본코너  \n");
				sbMySql.append("            AND    A.MEAL   IN  \n");
				sbMySql.append("                   (SELECT MEAL FROM FSA_HALL_DTL WHERE UPJANG  = " + v_UPJANG + "  AND HALL_CD = '" + v_HALL_CD + "' AND CORNER='" + v_SOURCE_CORNER + "'  AND USE_YN='Y') --복사대상에 있는 복사 원본의 끼니를 삭제한다. \n");
				sbMySql.append("            AND    A.MENU_DATE BETWEEN '" + v_START_DATE + "' AND '" + v_END_DATE + "')    --원본코너 대상날짜  \n");
				
				stmt.execute(sbMySql.toString());
				
				
				//타겟 아이템 NEED 데이트
				v_NEED_DATE = " FSM_ITEM_NEED_DATE_FUN('"+ v_UPJANG +"', '"+ v_HALL_CD +"', A.MEAL, '"+ v_TARGET_CORNER +"', A.MENU_DATE ) ";
				
				sbMySql.delete(0, sbMySql.length());				
				sbMySql.append("    --레시피자재  복사 INSERT 한다  \n");
				sbMySql.append("    INSERT INTO FSH_CYCLE_RECIPE_ITEM (UPJANG, MENU_CD, RECIPE_CD, ITEM_CODE, ITEM_SEQ, NEED_QTY, EDIBLE_QTY, CUT_SPEC, NEED_DATE,                          UNIT_PRICE,   MARGIN_RATE,  MARGIN_PRICE, CUSER, CDATE, UUSER, UDATE)  \n");
				sbMySql.append("    SELECT  B.UPJANG, SUBSTR(B.MENU_CD,1,17 )||'" + v_TARGET_CORNER + "' AS MENU_CD,      --복사대상의 메뉴CD  \n");
				sbMySql.append("            B.RECIPE_CD, B.ITEM_CODE, B.ITEM_SEQ, B.NEED_QTY, B.EDIBLE_QTY, B.CUT_SPEC,                                 "+  v_NEED_DATE + " AS NEED_DATE, B.UNIT_PRICE, B.MARGIN_RATE, B.MARGIN_PRICE, '"+ g_EmpNo +"' AS  CUSER, SYSDATE, '"+ g_EmpNo +"' AS UUSER, SYSDATE  \n");
				sbMySql.append("    FROM    FSH_CYCLE_MENU_MST     A  \n");
				sbMySql.append("           ,FSH_CYCLE_RECIPE_ITEM  B  \n");
				sbMySql.append("    WHERE  A.MENU_CD = B.MENU_CD  \n");
				sbMySql.append("    AND    A.UPJANG  = B.UPJANG       \n");
				sbMySql.append("    AND    A.UPJANG  = " + v_UPJANG + "  \n");
				sbMySql.append("    AND    A.HALL_CD  = '" + v_HALL_CD + "'  \n");
				sbMySql.append("    AND    A.CORNER  = '" + v_SOURCE_CORNER + "'                                 --원본코너  \n");
				sbMySql.append("    AND    A.MENU_DATE BETWEEN '" + v_START_DATE + "' AND '" + v_END_DATE + "'     --원본코너 대상날짜  \n");
				sbMySql.append("    AND    A.MEAL   IN  \n");
				sbMySql.append("           (SELECT MEAL FROM FSA_HALL_DTL WHERE UPJANG  = " + v_UPJANG + "  AND HALL_CD = '" + v_HALL_CD + "' AND CORNER='" + v_TARGET_CORNER + "'  AND USE_YN='Y' ) --복사대상의끼니만 복사한다.  \n");
		
				stmt.execute(sbMySql.toString());
				
				
				/////////////////////////////////////////////
				///// 조리법
				/////////////////////////////////////////////
				sbMySql.delete(0, sbMySql.length());
				sbMySql.append("--레시피 조리법에서 복사대상 삭제옵션(삭제, 건너뛰기)  \n");
				sbMySql.append("--1.삭제옵션 선택시  \n");
				sbMySql.append("    --무조건 삭제 명령어를 실행 (중요: 원본은 점심만 있고 대상은 아침점심저녁이 있으면 점심만 삭제해야함)  \n");
				sbMySql.append("    DELETE FROM FSH_CYCLE_RECIPE_CUISINE  \n");
				sbMySql.append("    WHERE  MENU_CD IN  \n");
				sbMySql.append("           (SELECT  SUBSTR(A.MENU_CD,1,17 )||'" + v_TARGET_CORNER + "' AS MENU_CD        --복사대상의 메뉴CD  \n");
				sbMySql.append("              FROM  FSH_CYCLE_MENU_MST        A  \n");
				sbMySql.append("            WHERE  A.UPJANG  = " + v_UPJANG + "  \n");
				sbMySql.append("            AND    A.HALL_CD  = '" + v_HALL_CD + "'  \n");
				sbMySql.append("            AND    A.CORNER  = '" + v_SOURCE_CORNER + "'                                 --원본코너  \n");
				sbMySql.append("            AND    A.MEAL   IN  \n");
				sbMySql.append("                   (SELECT MEAL FROM FSA_HALL_DTL WHERE UPJANG  = " + v_UPJANG + "  AND HALL_CD = '" + v_HALL_CD + "' AND CORNER='" + v_SOURCE_CORNER + "'  AND USE_YN='Y') --복사대상에 있는 복사원본의끼니만 삭제한다.  \n");
				sbMySql.append("            AND    A.MENU_DATE BETWEEN '" + v_START_DATE + "' AND '" + v_END_DATE + "')    --원본코너 대상날짜  \n");
					
				stmt.execute(sbMySql.toString());
				
				sbMySql.delete(0, sbMySql.length());
				sbMySql.append("    --레시피 조리법 복사INSERT 한다  \n");
				sbMySql.append("    INSERT INTO FSH_CYCLE_RECIPE_CUISINE (UPJANG, MENU_CD, RECIPE_CD, CUISINE_SEQ, CUISINE_DESC, PHOTO_PATH, SPHOTO_PATH, CUSER, CDATE, UUSER, UDATE)  \n");
				sbMySql.append("    SELECT  B.UPJANG, SUBSTR(B.MENU_CD,1,17 )||'" + v_TARGET_CORNER + "' AS MENU_CD,      --복사대상의 메뉴CD  \n");
				sbMySql.append("            B.RECIPE_CD, B.CUISINE_SEQ, B.CUISINE_DESC, B.PHOTO_PATH, B.SPHOTO_PATH, '"+ g_EmpNo +"' AS  CUSER, SYSDATE, '"+ g_EmpNo +"' AS UUSER, SYSDATE  \n");
				sbMySql.append("    FROM    FSH_CYCLE_MENU_MST        A  \n");
				sbMySql.append("           ,FSH_CYCLE_RECIPE_CUISINE  B  \n");
				sbMySql.append("    WHERE  A.MENU_CD = B.MENU_CD  \n");
				sbMySql.append("            AND    A.UPJANG  = B.UPJANG       \n");
				sbMySql.append("            AND    A.UPJANG  = " + v_UPJANG + "  \n");
				sbMySql.append("            AND    A.HALL_CD  = '" + v_HALL_CD + "'  \n");
				sbMySql.append("    AND    A.CORNER  = '" + v_SOURCE_CORNER + "'                                 --원본코너  \n");
				sbMySql.append("    AND    A.MENU_DATE BETWEEN '" + v_START_DATE + "' AND '" + v_END_DATE + "'     --원본코너 대상날짜  \n");
				sbMySql.append("    AND    A.MEAL   IN  \n");
				sbMySql.append("           (SELECT MEAL FROM FSA_HALL_DTL WHERE UPJANG  = " + v_UPJANG + "  AND HALL_CD = '" + v_HALL_CD + "' AND CORNER='" + v_TARGET_CORNER + "'  AND USE_YN='Y') --복사대상의끼니만 복사한다.  \n");
				
				stmt.execute(sbMySql.toString());
			}
			else
			{
				/////////////////////////////////////////////
				///// 레시피 마스터
				/////////////////////////////////////////////				
				sbMySql.delete(0, sbMySql.length());					
				sbMySql.append("--2.건너뛰기 선택시  \n");
				sbMySql.append("    --레시피마스터 복사 INSERT 한다  \n");
				sbMySql.append("    INSERT INTO FSH_CYCLE_RECIPE_MST (UPJANG, MENU_CD, RECIPE_CD, RECIPE_NAME, RECIPE_CLASS, RECIPE_TYPE, CUISINE_TYPE, MAIN_ITEM_CODE1, MAIN_ITEM_CODE2, COOK_TOOL1, COOK_TOOL2, MAJOR_DISH_INFO, RECIPE_COLOR, RECIPE_SHAPE, RECIPE_TASTE, RECIPE_FEEL, RECIPE_TEMPER, SPRING_YN, SUMMER_YN, AUTUMN_YN, WINTER_YN, RESP_NUT1, RESP_NUT2, USE_TOOL, VALID_TIME, DISPLAY_METHOD, SALE_UOM, SALE_PRICE, COST_RATE, COOK_1MAN_QTY, COOK_TIME, EXPECT_SALE_QTY, REAL_SALE_QTY, CORE_TEMPER_YN, GOODS_FEATURE, PHF_MGMT_YN, PHF_MGMT1, PHF_MGMT2, PHF_MGMT3, PHF_MGMT4, PHF_MGMT5, COOK_OPRN, PHOTO_PATH, PREFER, ORIGIN_RECIPE, CUSER, CDATE, UUSER, UDATE, SPHOTO_PATH, PHF, RECIPE_SEQ)  \n");
				sbMySql.append("    SELECT  B.UPJANG, SUBSTR(B.MENU_CD,1,17 )||'" + v_TARGET_CORNER + "' AS MENU_CD,      --복사대상의 메뉴CD  \n");
				sbMySql.append("            B.RECIPE_CD, B.RECIPE_NAME, B.RECIPE_CLASS, B.RECIPE_TYPE, B.CUISINE_TYPE, B.MAIN_ITEM_CODE1, B.MAIN_ITEM_CODE2, B.COOK_TOOL1, B.COOK_TOOL2, B.MAJOR_DISH_INFO, B.RECIPE_COLOR, B.RECIPE_SHAPE, B.RECIPE_TASTE, B.RECIPE_FEEL, B.RECIPE_TEMPER, B.SPRING_YN, B.SUMMER_YN, B.AUTUMN_YN, B.WINTER_YN, B.RESP_NUT1, B.RESP_NUT2, B.USE_TOOL, B.VALID_TIME, B.DISPLAY_METHOD, B.SALE_UOM, B.SALE_PRICE, B.COST_RATE, B.COOK_1MAN_QTY, B.COOK_TIME, B.EXPECT_SALE_QTY, B.REAL_SALE_QTY, B.CORE_TEMPER_YN, B.GOODS_FEATURE, B.PHF_MGMT_YN, B.PHF_MGMT1, B.PHF_MGMT2, B.PHF_MGMT3, B.PHF_MGMT4, B.PHF_MGMT5, B.COOK_OPRN, B.PHOTO_PATH, B.PREFER, B.ORIGIN_RECIPE, '"+ g_EmpNo +"' AS  CUSER, SYSDATE, '"+ g_EmpNo +"' AS UUSER,SYSDATE, B.SPHOTO_PATH, B.PHF, B.RECIPE_SEQ  \n");
				sbMySql.append("    FROM    FSH_CYCLE_MENU_MST    A  \n");
				sbMySql.append("           ,FSH_CYCLE_RECIPE_MST  B  \n");
				sbMySql.append("    WHERE  A.MENU_CD = B.MENU_CD  \n");
				sbMySql.append("    AND    A.UPJANG  = B.UPJANG       \n");
				sbMySql.append("    AND    A.UPJANG  = " + v_UPJANG + "                               --업장  \n");
				sbMySql.append("    AND    A.HALL_CD  = '" + v_HALL_CD + "'  							  --식당  \n");
				sbMySql.append("    AND    A.CORNER  = '" + v_SOURCE_CORNER + "'                                  --원본코너  \n");
				sbMySql.append("    AND    A.MENU_DATE BETWEEN '" + v_START_DATE + "' AND '" + v_END_DATE + "'      --원본코너 대상날짜  \n");
				sbMySql.append("    AND    A.MEAL   IN  \n");
				sbMySql.append("           (SELECT MEAL FROM FSA_HALL_DTL WHERE UPJANG  = " + v_UPJANG + "  AND HALL_CD = '" + v_HALL_CD + "' AND CORNER='" + v_TARGET_CORNER + "' AND USE_YN='Y') --복사대상의끼니만 복사한다.  \n");
				sbMySql.append("    AND    SUBSTR(B.MENU_CD,1,17) || '" + v_TARGET_CORNER + "' NOT IN  \n");
				sbMySql.append("           (SELECT B.MENU_CD  \n");
				sbMySql.append("              FROM FSH_CYCLE_MENU_MST A,  \n");
				sbMySql.append("                   FSH_CYCLE_RECIPE_MST B  \n");
				sbMySql.append("             WHERE A.MENU_CD = B.MENU_CD  \n");
				sbMySql.append("               AND A.UPJANG  = " + v_UPJANG + "  \n");
				sbMySql.append("               AND A.HALL_CD  = '" + v_HALL_CD + "'  \n");
				sbMySql.append("               AND A.CORNER = '" + v_TARGET_CORNER + "'  \n");
				sbMySql.append("               AND A.MENU_DATE BETWEEN '" + v_START_DATE + "' AND '" + v_END_DATE + "') --대상이 있는지 체크한다.(있으면복사하지않음)  \n");
				System.out.println(sbMySql.toString());
				stmt.execute(sbMySql.toString());				
				
				
				/////////////////////////////////////////////
				///// 자재
				/////////////////////////////////////////////
				sbMySql.delete(0, sbMySql.length());	
				sbMySql.append("--2.건너뛰기 선택시  \n");
				sbMySql.append("    --레시피자재  복사 INSERT 한다  \n");
				sbMySql.append("    INSERT INTO FSH_CYCLE_RECIPE_ITEM (UPJANG, MENU_CD, RECIPE_CD, ITEM_CODE, ITEM_SEQ, NEED_QTY, EDIBLE_QTY, CUT_SPEC, NEED_DATE,  UNIT_PRICE,    MARGIN_RATE,   MARGIN_PRICE, CUSER,                     CDATE,   UUSER,                    UDATE)  \n");
				sbMySql.append("    SELECT  B.UPJANG, SUBSTR(B.MENU_CD,1,17 )||'" + v_TARGET_CORNER + "' AS MENU_CD,      --복사대상의 메뉴CD  \n");
				sbMySql.append("            B.RECIPE_CD, B.ITEM_CODE, B.ITEM_SEQ, B.NEED_QTY, B.EDIBLE_QTY, B.CUT_SPEC,                               B.NEED_DATE, B.UNIT_PRICE, B.MARGIN_RATE, B.MARGIN_PRICE, '"+ g_EmpNo +"' AS  CUSER, SYSDATE, '"+ g_EmpNo +"' AS UUSER, SYSDATE  \n");
				sbMySql.append("    FROM    FSH_CYCLE_MENU_MST     A  \n");
				sbMySql.append("           ,FSH_CYCLE_RECIPE_ITEM  B  \n");
				sbMySql.append("    WHERE  A.MENU_CD = B.MENU_CD  \n");
				sbMySql.append("    AND    A.UPJANG  = B.UPJANG       \n");
				sbMySql.append("    AND    A.UPJANG  = " + v_UPJANG + "                              --업장  \n");
				sbMySql.append("    AND    A.HALL_CD  = '" + v_HALL_CD + "'  							  --식당  \n");
				sbMySql.append("    AND    A.CORNER  = '" + v_SOURCE_CORNER + "'                                 --원본코너  \n");
				sbMySql.append("    AND    A.MENU_DATE BETWEEN '" + v_START_DATE + "' AND '" + v_END_DATE + "'     --원본코너 대상날짜  \n");
				sbMySql.append("    AND    A.MEAL   IN  \n");
				sbMySql.append("           (SELECT MEAL FROM FSA_HALL_DTL WHERE UPJANG  = " + v_UPJANG + "  AND HALL_CD = '" + v_HALL_CD + "' AND CORNER='" + v_TARGET_CORNER + "' AND USE_YN='Y') --복사대상의끼니만 복사한다.  \n");
				sbMySql.append("    AND    SUBSTR(B.MENU_CD,1,17) || '" + v_TARGET_CORNER + "' NOT IN  \n");
				sbMySql.append("           (SELECT B.MENU_CD \n");
				sbMySql.append("              FROM FSH_CYCLE_MENU_MST A,  \n");
				sbMySql.append("                   FSH_CYCLE_RECIPE_ITEM B  \n");
				sbMySql.append("             WHERE A.MENU_CD = B.MENU_CD  \n");
				sbMySql.append("               AND A.UPJANG  = " + v_UPJANG + "  \n");
				sbMySql.append("               AND A.HALL_CD  = '" + v_HALL_CD + "'  \n");
				sbMySql.append("               AND A.CORNER = '" + v_TARGET_CORNER + "'  \n");
				sbMySql.append("               AND A.MENU_DATE BETWEEN '" + v_START_DATE + "' AND '" + v_END_DATE + "') --대상이 있는지 체크한다.(있으면복사하지않음)  \n");
				System.out.println(sbMySql.toString());
				stmt.execute(sbMySql.toString());
				
				
				/////////////////////////////////////////////
				///// 조리법
				/////////////////////////////////////////////				
				sbMySql.delete(0, sbMySql.length());					
				sbMySql.append("--2.건너뛰기 선택시  \n");
				sbMySql.append("    --레시피조리법  복사 INSERT 한다  \n");
				sbMySql.append("    INSERT INTO FSH_CYCLE_RECIPE_CUISINE (UPJANG, MENU_CD, RECIPE_CD, CUISINE_SEQ, CUISINE_DESC, PHOTO_PATH, SPHOTO_PATH, CUSER, CDATE, UUSER, UDATE)  \n");
				sbMySql.append("    SELECT  B.UPJANG, SUBSTR(B.MENU_CD,1,17 )||'" + v_TARGET_CORNER + "' AS MENU_CD,      --복사대상의 메뉴CD  \n");
				sbMySql.append("            B.RECIPE_CD, B.CUISINE_SEQ, B.CUISINE_DESC, B.PHOTO_PATH, B.SPHOTO_PATH, '"+ g_EmpNo +"' AS  CUSER, SYSDATE, '"+ g_EmpNo +"' AS UUSER, SYSDATE  \n");
				sbMySql.append("    FROM    FSH_CYCLE_MENU_MST        A  \n");
				sbMySql.append("           ,FSH_CYCLE_RECIPE_CUISINE  B  \n");
				sbMySql.append("    WHERE   A.MENU_CD = B.MENU_CD  \n");
				sbMySql.append("      AND   A.UPJANG  = B.UPJANG       \n");
				sbMySql.append("      AND   A.UPJANG  = " + v_UPJANG + "  \n");
				sbMySql.append("      AND   A.HALL_CD  = '" + v_HALL_CD + "'  \n");
				sbMySql.append("      AND    A.CORNER  = '" + v_SOURCE_CORNER + "'                                 --원본코너  \n");
				sbMySql.append("      AND    A.MENU_DATE BETWEEN '" + v_START_DATE + "' AND '" + v_END_DATE + "'     --원본코너 대상날짜  \n");
				sbMySql.append("      AND    A.MEAL   IN  \n");
				sbMySql.append("           (SELECT MEAL FROM FSA_HALL_DTL WHERE UPJANG  = " + v_UPJANG + " AND HALL_CD = '" + v_HALL_CD + "'  AND CORNER='" + v_TARGET_CORNER + "' AND USE_YN='Y') --복사대상의끼니만 복사한다.  \n");
				sbMySql.append("      AND    SUBSTR(B.MENU_CD,1,17) || '" + v_TARGET_CORNER + "' NOT IN  \n");
				sbMySql.append("           (SELECT B.MENU_CD  \n");
				sbMySql.append("              FROM FSH_CYCLE_MENU_MST A,  \n");
				sbMySql.append("                   FSH_CYCLE_RECIPE_CUISINE B  \n");
				sbMySql.append("             WHERE A.MENU_CD = B.MENU_CD  \n");
				sbMySql.append("               AND A.UPJANG  = " + v_UPJANG + "  \n");
				sbMySql.append("               AND A.HALL_CD  = '" + v_HALL_CD + "'  \n");
				sbMySql.append("               AND A.CORNER = '" + v_TARGET_CORNER + "'  \n");
				sbMySql.append("               AND A.MENU_DATE BETWEEN '" + v_START_DATE + "' AND '" + v_END_DATE + "') --대상이 있는지 체크한다.(있으면복사하지않음)  \n");
		
				stmt.execute(sbMySql.toString());
			}
	   }
				
	   conn.commit();
	   this.setResultMessage(0, "OK",out_vl);
	   
	} catch(Exception ex) {
		//트랜잭션 실패
		conn.rollback();
		//jsp 로그남기기
		logger.debug(ex.getMessage(), ex);
		//메세지반환
		this.setResultMessage(-1, ex.toString(),out_vl);
	} finally {
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
		if(stmt != null) {
			try {
				stmt.close();
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