<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	Statement stmt             =  null;
	try {
		//////////////////////////////////////////////////////////
		//프로그램명: FSM00224V2_T001.jsp
		//작   성   일: 2008.05.09
		//작   성   자: 한화S&C 제조서비스 프로젝트팀 박종세 
		//프로그램기능: 주기식=>> 주기식 복사
		///////////////////////////////////////////////////////////
		PlatformRequest platformRequest = this.proc_input(request);  
		// 입력 데이터셋리스트
		in_dl = platformRequest.getData().getDataSetList();
		// 입력  변수리스트
		in_vl = platformRequest.getData().getVariableList();
		
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));
		
		String g_EmpNo 		        = in_vl.getString("g_EmpNo");
		
		String v_SOURCE_UPJANG      = in_vl.getString("SOURCE_UPJANG");
		String v_SOURCE_HALL_CD     = in_vl.getString("SOURCE_HALL_CD");	
		//String v_SOURCE_CORNER      = in_vl.getString("SOURCE_CORNER");
		//String v_SOURCE_MEAL        = in_vl.getString("SOURCE_MEAL");
		
		String v_TARGET_UPJANG      = in_vl.getString("TARGET_UPJANG");
		String v_TARGET_HALL_CD     = in_vl.getString("TARGET_HALL_CD");	
		String v_TARGET_CORNER      = in_vl.getString("TARGET_CORNER");
		String v_TARGET_MEAL        = in_vl.getString("TARGET_MEAL");
			
		String v_SOURCE_START_DATE  = in_vl.getString("SOURCE_START_DATE");
	    String v_TARGET_START_DATE  = in_vl.getString("TARGET_START_DATE");
	    Integer v_TARGET_DAYS       = in_vl.getInt("TARGET_DAYS");          //타겟식단일수
		
		String  v_TARGET_MENU_CD    = ""; 					                           //타켓의 메뉴CD;	
		String  v_NEED_DATE         = "";                                              //타겟 아이템 NEED_DATE
		stmt 		        = conn.createStatement();                          //실행명령 선언
		
		int i=0;
		StringBuffer sbSql = new StringBuffer();
	
				
		for(i=0; i< v_TARGET_DAYS; i++)
		{
				//에러체크
				//1) 주기식단에 식수인원 예측이 되어 있는지 확인. 등록되어 있지 않다면 SKIP 한다.
				sbSql.delete(0, sbSql.length());
				sbSql.append(" SELECT COUNT(*) AS R_COUNTER FROM \n");
				sbSql.append("      FSH_CYCLE_MENU_MST A          \n");
				sbSql.append(" WHERE  A.UPJANG  = "+ v_TARGET_UPJANG + "\n");
				sbSql.append(" AND    A.HALL_CD = '"+ v_TARGET_HALL_CD +"' \n");
				sbSql.append(" AND    A.CORNER  = DECODE('"+ v_TARGET_CORNER +"', '', A.CORNER, '"+ v_TARGET_CORNER +"' ) \n");
				sbSql.append(" AND    A.MEAL    = DECODE('"+ v_TARGET_MEAL +"','', A.MEAL, '"+ v_TARGET_MEAL +"' ) \n");
				sbSql.append(" AND    A.MENU_DATE = '"+ v_TARGET_START_DATE + "' \n");
				sbSql.append(" AND    NVL(A.EXPECT_MEAL_QTY,0) > 0 \n");
	
				pstmt = conn.prepareStatement(sbSql.toString());	
				rs = pstmt.executeQuery(); 		
				rs.next();
				
				try{
					if(Integer.parseInt(rs.getString("R_COUNTER"))<=0)
					{continue;}		
				}	
				catch(Exception e){
				}				
				finally{
					if(rs!=null){rs.close();}
				}	
				
				//데이터를 삭제한다.
				sbSql.delete(0, sbSql.length());	
				sbSql.append(" DELETE FROM FSH_CYCLE_RECIPE_MST \n");
				sbSql.append(" WHERE UPJANG =   "+ v_TARGET_UPJANG +" \n");
				sbSql.append(" AND   MENU_CD LIKE '"+ v_TARGET_START_DATE + "-" + v_TARGET_HALL_CD + v_TARGET_MEAL + v_TARGET_CORNER +"%' \n");
				stmt.execute(sbSql.toString());	
										
				sbSql.delete(0, sbSql.length());	
				sbSql.append(" DELETE FROM FSH_CYCLE_RECIPE_ITEM \n");
				sbSql.append(" WHERE UPJANG =   "+ v_TARGET_UPJANG +" \n");
				sbSql.append(" AND   MENU_CD LIKE '"+ v_TARGET_START_DATE + "-" + v_TARGET_HALL_CD + v_TARGET_MEAL + v_TARGET_CORNER +"%' \n");
				stmt.execute(sbSql.toString());	
				
				sbSql.delete(0, sbSql.length());	
				sbSql.append(" DELETE FROM FSH_CYCLE_RECIPE_CUISINE \n");
				sbSql.append(" WHERE UPJANG =   "+ v_TARGET_UPJANG +" \n");
				sbSql.append(" AND   MENU_CD LIKE '"+ v_TARGET_START_DATE + "-" + v_TARGET_HALL_CD + v_TARGET_MEAL + v_TARGET_CORNER +"%' \n");
				stmt.execute(sbSql.toString());						
				

				//날짜는 원본을 타켓날짜로 변경한  v_TARGET_MENU_CD 사용한다.
				v_TARGET_MENU_CD = "REPLACE(B.MENU_CD,'"+ v_SOURCE_START_DATE + "','"+ v_TARGET_START_DATE + "')  AS MENU_CD ";
								
				//레시피 마스터 입력
				sbSql.delete(0, sbSql.length());	
				sbSql.append("INSERT INTO FSH_CYCLE_RECIPE_MST (UPJANG, MENU_CD, RECIPE_CD,   RECIPE_NAME,   RECIPE_CLASS,   RECIPE_TYPE,   CUISINE_TYPE,   MAIN_ITEM_CODE1,   MAIN_ITEM_CODE2,   COOK_TOOL1,   COOK_TOOL2,   MAJOR_DISH_INFO,   RECIPE_COLOR,   RECIPE_SHAPE,   RECIPE_TASTE,   RECIPE_FEEL,   RECIPE_TEMPER,   SPRING_YN,   SUMMER_YN,   AUTUMN_YN,   WINTER_YN,   RESP_NUT1,   RESP_NUT2,   USE_TOOL,   VALID_TIME,   DISPLAY_METHOD,   SALE_UOM,   SALE_PRICE,   COST_RATE,   COOK_1MAN_QTY,   COOK_TIME,   EXPECT_SALE_QTY,   REAL_SALE_QTY,   CORE_TEMPER_YN,   GOODS_FEATURE,   PHF_MGMT_YN,   PHF_MGMT1,   PHF_MGMT2,   PHF_MGMT3,   PHF_MGMT4,   PHF_MGMT5,   COOK_OPRN,   PHOTO_PATH,   PREFER,   ORIGIN_RECIPE,   CUSER,         CDATE,       UUSER,        UDATE,     SPHOTO_PATH,   PHF,   RECIPE_SEQ ) \n");
				sbSql.append("SELECT "+ v_TARGET_UPJANG +" AS UPJANG, "+ v_TARGET_MENU_CD +"         ,B.RECIPE_CD, B.RECIPE_NAME, B.RECIPE_CLASS, B.RECIPE_TYPE, B.CUISINE_TYPE, B.MAIN_ITEM_CODE1, B.MAIN_ITEM_CODE2, B.COOK_TOOL1, B.COOK_TOOL2, B.MAJOR_DISH_INFO, B.RECIPE_COLOR, B.RECIPE_SHAPE, B.RECIPE_TASTE, B.RECIPE_FEEL, B.RECIPE_TEMPER, B.SPRING_YN, B.SUMMER_YN, B.AUTUMN_YN, B.WINTER_YN, B.RESP_NUT1, B.RESP_NUT2, B.USE_TOOL, B.VALID_TIME, B.DISPLAY_METHOD, B.SALE_UOM, B.SALE_PRICE, B.COST_RATE, B.COOK_1MAN_QTY, B.COOK_TIME, B.EXPECT_SALE_QTY, B.REAL_SALE_QTY, B.CORE_TEMPER_YN, B.GOODS_FEATURE, B.PHF_MGMT_YN, B.PHF_MGMT1, B.PHF_MGMT2, B.PHF_MGMT3, B.PHF_MGMT4, B.PHF_MGMT5, B.COOK_OPRN, B.PHOTO_PATH, B.PREFER, B.ORIGIN_RECIPE, '"+ g_EmpNo +"', SYSDATE, '"+ g_EmpNo + "', SYSDATE, B.SPHOTO_PATH, B.PHF, B.RECIPE_SEQ  \n");
				sbSql.append("  FROM FSH_CYCLE_MENU_MST    A  \n");
				sbSql.append("      ,FSH_CYCLE_RECIPE_MST  B  \n");
				sbSql.append("WHERE  A.MENU_CD = B.MENU_CD  \n");
				sbSql.append(" AND   A.UPJANG  = B.UPJANG       \n");
				sbSql.append(" AND   A.UPJANG  = "+ v_SOURCE_UPJANG +"  \n");
				sbSql.append(" AND   A.HALL_CD = '"+ v_SOURCE_HALL_CD +"'  \n");
				sbSql.append(" AND   A.MENU_DATE = '"+ v_SOURCE_START_DATE + "'  \n");
				
				//복사대상 레시피 분류에 맞는 데이터만 가져와서 복사한다.
				//2008.05.15 ==> 이명희
				sbSql.append(" AND   SUBSTR(B.RECIPE_CD,1,1) IN ( SELECT RECIPE_CLASS FROM FSA_UPJANG_RECIPE_LINK WHERE  UPJANG = "+ v_TARGET_UPJANG +" ) \n ");
						
				
				//1. 대상 식단의 코너와 끼니가 정해져 있다면 해당하는 데이터만 소스식단에서 가져온다.
				if((v_TARGET_CORNER.length()>0)&&(v_TARGET_MEAL.length()>0))
				{
					sbSql.append("AND    A.CORNER  = '"+ v_TARGET_CORNER +"'  \n");
					sbSql.append("AND    A.MEAL    = '"+ v_TARGET_MEAL   +"'  \n");
				}
				//2. 대상 식단의 코너만 있을 경우 (끼니는 선택하지 않음)
				if((v_TARGET_CORNER.length()>0)&&(v_TARGET_MEAL.length()==0))
				{
					sbSql.append("AND    A.CORNER  = '"+ v_TARGET_CORNER +"'  \n");
					sbSql.append("AND    A.MEAL    IN ( SELECT MEAL FROM FSA_HALL_DTL  WHERE  UPJANG  = " + v_TARGET_UPJANG + "   AND  HALL_CD = '" + v_TARGET_HALL_CD + "'	AND  CORNER  = '"+ v_TARGET_CORNER + "'	AND    USE_YN  = 'Y' ) ");
				}
				//3. 대상 식단의 끼니만 있을 경우(코너는 선택하지 않음)
				if((v_TARGET_CORNER.length()==0)&&(v_TARGET_MEAL.length()>0))
				{
					sbSql.append("AND    A.MEAL  = '"+ v_TARGET_MEAL +"'  \n");
					sbSql.append("AND    A.CORNER    IN ( SELECT CORNER FROM FSA_HALL_DTL  WHERE  UPJANG  = " + v_TARGET_UPJANG + "   AND  HALL_CD = '" + v_TARGET_HALL_CD + "'	AND  MEAL  = '"+ v_TARGET_MEAL + "'	AND    USE_YN  = 'Y' ) ");
				}
				//4. 대상 식단의 코너끼니가 모두 없을 경우
				if((v_TARGET_CORNER.length()==0)&&(v_TARGET_MEAL.length()==0))
				{
					sbSql.append("AND    A.MEAL||A.CORNER  IN ( SELECT MEAL||CORNER FROM FSA_HALL_DTL  WHERE  UPJANG  = " + v_TARGET_UPJANG + "   AND  HALL_CD = '" + v_TARGET_HALL_CD + "'	AND    USE_YN  = 'Y' ) ");
				}
			
				
				//System.out.println(sbSql.toString());
				stmt.execute(sbSql.toString());
				
				
				//타겟 아이템 NEED 데이트
				v_NEED_DATE = " FSM_ITEM_NEED_DATE_FUN('"+ v_TARGET_UPJANG +"', '"+ v_TARGET_HALL_CD +"', A.MEAL, A.CORNER, '"+ v_TARGET_START_DATE +"' ) ";
				
				//레시피 자재 입력
				sbSql.delete(0, sbSql.length());	
				sbSql.append("INSERT INTO FSH_CYCLE_RECIPE_ITEM  (UPJANG, MENU_CD,            RECIPE_CD, ITEM_CODE, ITEM_SEQ, NEED_QTY, EDIBLE_QTY, CUT_SPEC,   NEED_DATE,                      UNIT_PRICE, MARGIN_RATE, MARGIN_PRICE, CUSER, CDATE, UUSER, UDATE) \n");
				sbSql.append("SELECT "+ v_TARGET_UPJANG +" AS UPJANG, "+ v_TARGET_MENU_CD +", RECIPE_CD, ITEM_CODE, ITEM_SEQ, NEED_QTY, EDIBLE_QTY, CUT_SPEC,   "+ v_NEED_DATE +" AS NEED_DATE, UNIT_PRICE, MARGIN_RATE, MARGIN_PRICE,  '"+ g_EmpNo +"', SYSDATE, '"+ g_EmpNo + "', SYSDATE  \n");
				sbSql.append("  FROM FSH_CYCLE_MENU_MST    A  \n");
				sbSql.append("      ,FSH_CYCLE_RECIPE_ITEM  B  \n");
				sbSql.append("WHERE  A.MENU_CD = B.MENU_CD  \n");
				sbSql.append("AND    A.UPJANG  = B.UPJANG       \n");
				sbSql.append("AND    A.UPJANG  = "+ v_SOURCE_UPJANG +"  \n");
				sbSql.append("AND    A.HALL_CD = '"+ v_SOURCE_HALL_CD +"'  \n");
				sbSql.append("AND    A.MENU_DATE = '"+ v_SOURCE_START_DATE + "'  \n");
			
				//복사대상 레시피 분류에 맞는 데이터만 가져와서 복사한다.
				//2008.05.15 ==> 이명희
				sbSql.append(" AND   SUBSTR(B.RECIPE_CD,1,1) IN ( SELECT RECIPE_CLASS FROM FSA_UPJANG_RECIPE_LINK WHERE  UPJANG = "+ v_TARGET_UPJANG +" ) \n ");
			
				
				//1. 대상 식단의 코너와 끼니가 정해져 있다면 해당하는 데이터만 소스식단에서 가져온다.
				if((v_TARGET_CORNER.length()>0)&&(v_TARGET_MEAL.length()>0))
				{
					sbSql.append("AND    A.CORNER  = '"+ v_TARGET_CORNER +"'  \n");
					sbSql.append("AND    A.MEAL    = '"+ v_TARGET_MEAL   +"'  \n");
				}
				//2. 대상 식단의 코너만 있을 경우 (끼니는 선택하지 않음)
				if((v_TARGET_CORNER.length()>0)&&(v_TARGET_MEAL.length()==0))
				{
					sbSql.append("AND    A.CORNER  = '"+ v_TARGET_CORNER +"'  \n");
					sbSql.append("AND    A.MEAL    IN ( SELECT MEAL FROM FSA_HALL_DTL  WHERE  UPJANG  = " + v_TARGET_UPJANG + "   AND  HALL_CD = '" + v_TARGET_HALL_CD + "'	AND  CORNER  = '"+ v_TARGET_CORNER + "'	AND    USE_YN  = 'Y' ) ");
				}
				//3. 대상 식단의 끼니만 있을 경우(코너는 선택하지 않음)
				if((v_TARGET_CORNER.length()==0)&&(v_TARGET_MEAL.length()>0))
				{
					sbSql.append("AND    A.MEAL  = '"+ v_TARGET_MEAL +"'  \n");
					sbSql.append("AND    A.CORNER    IN ( SELECT CORNER FROM FSA_HALL_DTL  WHERE  UPJANG  = " + v_TARGET_UPJANG + "   AND  HALL_CD = '" + v_TARGET_HALL_CD + "'	AND  MEAL  = '"+ v_TARGET_MEAL + "'	AND    USE_YN  = 'Y' ) ");
				}
				//4. 대상 식단의 코너끼니가 모두 없을 경우
				if((v_TARGET_CORNER.length()==0)&&(v_TARGET_MEAL.length()==0))
				{
					sbSql.append("AND    A.MEAL||A.CORNER  IN ( SELECT MEAL||CORNER FROM FSA_HALL_DTL  WHERE  UPJANG  = " + v_TARGET_UPJANG + "   AND  HALL_CD = '" + v_TARGET_HALL_CD + "'	AND    USE_YN  = 'Y' ) ");
				}
			    stmt.execute(sbSql.toString());
				
				
				//레시피 조리법  입력
				sbSql.delete(0, sbSql.length());	
				sbSql.append("INSERT INTO FSH_CYCLE_RECIPE_CUISINE  (UPJANG, MENU_CD, RECIPE_CD, CUISINE_SEQ, CUISINE_DESC, PHOTO_PATH, CUSER, CDATE, UUSER, UDATE, SPHOTO_PATH) \n");
				sbSql.append("SELECT "+ v_TARGET_UPJANG +" AS UPJANG, "+ v_TARGET_MENU_CD +",                RECIPE_CD, CUISINE_SEQ, CUISINE_DESC, PHOTO_PATH, '"+ g_EmpNo +"', SYSDATE, '"+ g_EmpNo + "', SYSDATE, SPHOTO_PATH \n");
				sbSql.append("  FROM FSH_CYCLE_MENU_MST    A  \n");
				sbSql.append("      ,FSH_CYCLE_RECIPE_CUISINE  B  \n");
				sbSql.append("WHERE  A.MENU_CD = B.MENU_CD  \n");
				sbSql.append("AND    A.UPJANG  = B.UPJANG       \n");
				sbSql.append("AND    A.UPJANG  =    "+ v_SOURCE_UPJANG +"  \n");
				sbSql.append("AND    A.HALL_CD =   '"+ v_SOURCE_HALL_CD +"'  \n");
				sbSql.append("AND    A.MENU_DATE = '"+ v_SOURCE_START_DATE + "'  \n");
			
				//복사대상 레시피 분류에 맞는 데이터만 가져와서 복사한다.
				//2008.05.15 ==> 이명희
				sbSql.append(" AND   SUBSTR(B.RECIPE_CD,1,1) IN ( SELECT RECIPE_CLASS FROM FSA_UPJANG_RECIPE_LINK WHERE  UPJANG = "+ v_TARGET_UPJANG +" ) \n ");
			
				//1. 대상 식단의 코너와 끼니가 정해져 있다면 해당하는 데이터만 소스식단에서 가져온다.
				if((v_TARGET_CORNER.length()>0)&&(v_TARGET_MEAL.length()>0))
				{
					sbSql.append("AND    A.CORNER  = '"+ v_TARGET_CORNER +"'  \n");
					sbSql.append("AND    A.MEAL    = '"+ v_TARGET_MEAL   +"'  \n");
				}
				//2. 대상 식단의 코너만 있을 경우 (끼니는 선택하지 않음)
				if((v_TARGET_CORNER.length()>0)&&(v_TARGET_MEAL.length()==0))
				{
					sbSql.append("AND    A.CORNER  = '"+ v_TARGET_CORNER +"'  \n");
					sbSql.append("AND    A.MEAL    IN ( SELECT MEAL FROM FSA_HALL_DTL  WHERE  UPJANG  = " + v_TARGET_UPJANG + "   AND  HALL_CD = '" + v_TARGET_HALL_CD + "'	AND  CORNER  = '"+ v_TARGET_CORNER + "'	AND    USE_YN  = 'Y' ) ");
				}
				//3. 대상 식단의 끼니만 있을 경우(코너는 선택하지 않음)
				if((v_TARGET_CORNER.length()==0)&&(v_TARGET_MEAL.length()>0))
				{
					sbSql.append("AND    A.MEAL  = '"+ v_TARGET_MEAL +"'  \n");
					sbSql.append("AND    A.CORNER    IN ( SELECT CORNER FROM FSA_HALL_DTL  WHERE  UPJANG  = " + v_TARGET_UPJANG + "   AND  HALL_CD = '" + v_TARGET_HALL_CD + "'	AND  MEAL  = '"+ v_TARGET_MEAL + "'	AND    USE_YN  = 'Y' ) ");
				}
				//4. 대상 식단의 코너끼니가 모두 없을 경우
				if((v_TARGET_CORNER.length()==0)&&(v_TARGET_MEAL.length()==0))
				{
					sbSql.append("AND    A.MEAL||A.CORNER  IN ( SELECT MEAL||CORNER FROM FSA_HALL_DTL  WHERE  UPJANG  = " + v_TARGET_UPJANG + "   AND  HALL_CD = '" + v_TARGET_HALL_CD + "'	AND    USE_YN  = 'Y' ) ");
				}
				//System.out.println(sbSql.toString());
				stmt.execute(sbSql.toString());
			
			   //소스날짜 하루씩 늘리기	
				v_SOURCE_START_DATE = Integer.toString(Integer.parseInt(v_SOURCE_START_DATE) + 1);
				v_TARGET_START_DATE = Integer.toString(Integer.parseInt(v_TARGET_START_DATE) + 1);
			   //System.out.println("v_SOURCE_START_DATE:" + v_SOURCE_START_DATE);
		}
		
		//트랜잭션 성공
		conn.commit();		
		this.setResultMessage(0, "OK", out_vl);
	
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
