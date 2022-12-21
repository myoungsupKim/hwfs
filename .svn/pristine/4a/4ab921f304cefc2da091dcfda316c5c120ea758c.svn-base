<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%	
	Statement stmt             =  null;
	try {
		//////////////////////////////////////////////////////////
		//프로그램명: FSM00224V5_T001.jsp
		//작   성   일: 2008.05.09
		//작   성   자: 한화S&C 제조서비스 프로젝트팀 박종세 
		//프로그램기능: 자유롭게 복사하기 
		///////////////////////////////////////////////////////////	
	
		PlatformRequest platformRequest = this.proc_input(request);  
	    // 입력 데이터셋리스트
		in_dl = platformRequest.getData().getDataSetList();
		// 입력  변수리스트
		in_vl = platformRequest.getData().getVariableList();
		
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));
		
		// 입력변수-사번
		String g_EmpNo 		        = in_vl.getString("g_EmpNo");
		String v_SKIP_YN            = in_vl.getString("SKIP_YN");                //건너띄기
		
		// 입력 데이터셋
		DataSet ds_input  		    = in_dl.get("ds_input");
		
		// 입력 데이셋변수리스트	
		String strSOURCE_UPJANG     = ds_input.getString(0,"SOURCE_UPJANG");
		String strSOURCE_HALL_CD    = ds_input.getString(0,"SOURCE_HALL_CD");
		String strSOURCE_MEAL       = ds_input.getString(0,"SOURCE_MEAL");
		String strSOURCE_CORNER     = ds_input.getString(0,"SOURCE_CORNER");
		String strSOURCE_TYPE       = ds_input.getString(0,"SOURCE_TYPE");
		String strSOURCE_START_DATE = ds_input.getString(0,"SOURCE_START_DATE");
		String strSOURCE_END_DATE   = ds_input.getString(0,"SOURCE_END_DATE");
		Integer intSOURCE_DAYS       = ds_input.getInt(0,"SOURCE_DAYS");
	
		
		String strTARGET_UPJANG     = ds_input.getString(0,"TARGET_UPJANG");
		String strTARGET_HALL_CD    = ds_input.getString(0,"TARGET_HALL_CD");
		String strTARGET_MEAL       = ds_input.getString(0,"TARGET_MEAL");
		String strTARGET_CORNER     = ds_input.getString(0,"TARGET_CORNER");
		String strTARGET_TYPE       = ds_input.getString(0,"TARGET_TYPE");
		String strTARGET_START_DATE = ds_input.getString(0,"TARGET_START_DATE");
		String strTARGET_END_DATE   = ds_input.getString(0,"TARGET_END_DATE");
		
		String strSOURCE_MENU_MST_TABLE="";
		String strSOURCE_RECIPE_MST_TABLE="";
		String strSOURCE_RECIPE_ITEM_TABLE="";
		String strSOURCE_RECIPE_CUISINE_TABLE="";
		
		String strTARGET_MENU_MST_TABLE="";
		String strTARGET_RECIPE_MST_TABLE="";
		String strTARGET_RECIPE_ITEM_TABLE="";
		String strTARGET_RECIPE_CUISINE_TABLE="";
		
		String strTARGET_MENU_CD="";
		String v_NEED_DATE      ="";
		
		//FileLog.println("d:\\ds_input.txt", ds_input);
		
		//소스가 주기식단
		if(strSOURCE_TYPE.equals("CYCLE"))
		{
			 strSOURCE_MENU_MST_TABLE="FSH_CYCLE_MENU_MST";
			 strSOURCE_RECIPE_MST_TABLE="FSH_CYCLE_RECIPE_MST";
			 strSOURCE_RECIPE_ITEM_TABLE="FSH_CYCLE_RECIPE_ITEM";
			 strSOURCE_RECIPE_CUISINE_TABLE="FSH_CYCLE_RECIPE_CUISINE";
		}
		//소스가 실제식단
		if(strSOURCE_TYPE.equals("REAL"))
		{
			 strSOURCE_MENU_MST_TABLE="FSM_REAL_MENU_MST";
			 strSOURCE_RECIPE_MST_TABLE="FSM_REAL_RECIPE_MST";
			 strSOURCE_RECIPE_ITEM_TABLE="FSM_REAL_RECIPE_ITEM";
			 strSOURCE_RECIPE_CUISINE_TABLE="FSM_REAL_RECIPE_CUISINE";
		}
		//타겟이주기단식
		if(strTARGET_TYPE.equals("CYCLE"))
		{
			 strTARGET_MENU_MST_TABLE="FSH_CYCLE_MENU_MST";
			 strTARGET_RECIPE_MST_TABLE="FSH_CYCLE_RECIPE_MST";
			 strTARGET_RECIPE_ITEM_TABLE="FSH_CYCLE_RECIPE_ITEM";
			 strTARGET_RECIPE_CUISINE_TABLE="FSH_CYCLE_RECIPE_CUISINE";
		}
		//타켓이실제식단
		if(strTARGET_TYPE.equals("REAL"))
		{
			 strTARGET_MENU_MST_TABLE="FSM_REAL_MENU_MST";
			 strTARGET_RECIPE_MST_TABLE="FSM_REAL_RECIPE_MST";
			 strTARGET_RECIPE_ITEM_TABLE="FSM_REAL_RECIPE_ITEM";
			 strTARGET_RECIPE_CUISINE_TABLE="FSM_REAL_RECIPE_CUISINE";
		}
			
		
		stmt 		=  conn.createStatement();                                 //실행명령 선언
		StringBuffer sbSql  = new StringBuffer();                                      //SQL문 선언
		
		int i; //날짜를 셋팅하기 위한 옵션
	
				
		for(i=0; i<=intSOURCE_DAYS; i++)
		{
			//에러체크
			//0) 복사대상식단에 식수인원 예측이 되어 있는지 확인. 등록되어 있지 않다면 SKIP 한다.
			sbSql.delete(0, sbSql.length());
			sbSql.append(" SELECT COUNT(*) AS R_COUNTER FROM \n");
			sbSql.append("      " + strTARGET_MENU_MST_TABLE  + " A          \n");
			sbSql.append(" WHERE  A.UPJANG  = "+ strTARGET_UPJANG + "\n");
			sbSql.append(" AND    A.HALL_CD = '"+ strTARGET_HALL_CD +"' \n");
			sbSql.append(" AND    A.CORNER  = '"+ strTARGET_CORNER +"' \n");
			sbSql.append(" AND    A.MEAL    = '"+ strTARGET_MEAL +"' \n");
			sbSql.append(" AND    A.MENU_DATE = TO_CHAR(TO_DATE('"+ strTARGET_START_DATE+"','YYYYMMDD') + "+ Integer.toString(i) +",'YYYYMMDD') \n");
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
			
			
			//0) 실식수가 등록된 식단은  스킵하다. ===>> 주기식단의 경우는 실식수가 등록되지 않음으로 상관없이 체크
			sbSql.delete(0, sbSql.length());
			sbSql.append(" SELECT COUNT(*) AS R_COUNTER FROM \n");
			sbSql.append("      "+ strTARGET_MENU_MST_TABLE   +" A           \n");
			sbSql.append("     ,"+ strTARGET_RECIPE_MST_TABLE +" B         \n");
			sbSql.append(" WHERE  A.MENU_CD = B.MENU_CD      \n");
			sbSql.append(" AND    A.UPJANG  = B.UPJANG       \n");
			sbSql.append(" AND    A.UPJANG  = "+ strTARGET_UPJANG + "\n");
			sbSql.append(" AND    A.HALL_CD = '"+ strTARGET_HALL_CD +"' \n");
			sbSql.append(" AND    A.CORNER  = '"+ strTARGET_CORNER + "' \n");
			sbSql.append(" AND    A.MEAL    = '"+ strTARGET_MEAL + "' \n");
			sbSql.append(" AND    A.MENU_DATE = TO_CHAR(TO_DATE('"+ strTARGET_START_DATE+"','YYYYMMDD') + "+ Integer.toString(i) +",'YYYYMMDD') \n");
			sbSql.append(" AND    A.REAL_MEAL_QTY > 0 \n");
	
			pstmt = conn.prepareStatement(sbSql.toString());	
			rs = pstmt.executeQuery(); 		
			rs.next();
			
			try{
				if(Integer.parseInt(rs.getString("R_COUNTER"))>0)
				{continue;}		
			}	
			catch(Exception e){
			}				
			finally{
				if(rs!=null){rs.close();}
			}
			
			
			//0) 발주자재가 등록된 식단은 스킵한다.
			sbSql.delete(0, sbSql.length());
			sbSql.append(" SELECT COUNT(*) AS R_COUNTER FROM \n");
			sbSql.append("      "+ strTARGET_MENU_MST_TABLE   +" A           \n");
			sbSql.append("     ,"+ strTARGET_RECIPE_ITEM_TABLE +" B         \n");
			sbSql.append(" WHERE  A.MENU_CD = B.MENU_CD      \n");
			sbSql.append(" AND    A.UPJANG  = B.UPJANG       \n");
			sbSql.append(" AND    A.UPJANG  = "+ strTARGET_UPJANG + "\n");
			sbSql.append(" AND    A.HALL_CD = '"+ strTARGET_HALL_CD +"' \n");
			sbSql.append(" AND    A.CORNER  = '"+ strTARGET_CORNER + "' \n");
			sbSql.append(" AND    A.MEAL    = '"+ strTARGET_MEAL + "' \n");
			sbSql.append(" AND    A.MENU_DATE = TO_CHAR(TO_DATE('"+ strTARGET_START_DATE+"','YYYYMMDD') + "+ Integer.toString(i) +",'YYYYMMDD') \n");
	     	sbSql.append(" AND    B.ORDER_YN ='Y' \n");
			
			pstmt = conn.prepareStatement(sbSql.toString());	
			rs = pstmt.executeQuery(); 		
			rs.next();
			
			try{
				if(Integer.parseInt(rs.getString("R_COUNTER"))>0)
				{continue;}		
			}	
			catch(Exception e){
			}				
			finally{
				if(rs!=null){rs.close();}
			}
			
			//2) SKIP_YN 이 1이라면 등록된 식단이 있을 경우 SKIP 한다. 0이라면 삭제 하고 다시 넣는다.
			//1) 복사옵션 SKIP_YN = Y 일때   Count를 조사하여 Continue;;;
			if(v_SKIP_YN.equals("1"))
			{
				sbSql.delete(0, sbSql.length());	
				sbSql.append(" SELECT COUNT(*) AS R_COUNTER FROM  \n");
				sbSql.append("      "+ strTARGET_MENU_MST_TABLE   +" A           \n");
				sbSql.append("     ,"+ strTARGET_RECIPE_MST_TABLE +" B         \n");
				sbSql.append(" WHERE  A.MENU_CD = B.MENU_CD       \n");
				sbSql.append(" AND    A.UPJANG  = B.UPJANG       \n");
				sbSql.append(" AND    A.UPJANG  = "+ strTARGET_UPJANG + " \n");
				sbSql.append(" AND    A.HALL_CD = '"+ strTARGET_HALL_CD +"' \n");
				sbSql.append(" AND    A.CORNER  = '"+ strTARGET_CORNER + "' \n");
				sbSql.append(" AND    A.MEAL    = '"+ strTARGET_MEAL + "' \n");
				sbSql.append(" AND    A.MENU_DATE = TO_CHAR(TO_DATE('"+ strTARGET_START_DATE+"','YYYYMMDD') + "+ Integer.toString(i) +",'YYYYMMDD') \n");
		
				pstmt = conn.prepareStatement(sbSql.toString());	
				rs = pstmt.executeQuery(); 		
				rs.next();
				
				try{
					if(Integer.parseInt(rs.getString("R_COUNTER"))>0)
					{continue;}		
				}	
				catch(Exception e){
				}				
				finally{
					if(rs!=null){rs.close();}
				}		
			}
			else if(v_SKIP_YN.equals("0"))
			{	//데이터를 삭제한다.
				sbSql.delete(0, sbSql.length());	
				sbSql.append(" DELETE FROM "+ strTARGET_RECIPE_MST_TABLE   +" \n");
				sbSql.append(" WHERE UPJANG =    "+ strTARGET_UPJANG + " \n");
				sbSql.append(" AND   MENU_CD LIKE TO_CHAR(TO_DATE('"+ strTARGET_START_DATE+"','YYYYMMDD') + "+ Integer.toString(i) +",'YYYYMMDD')||'-" + strTARGET_HALL_CD + strTARGET_MEAL + strTARGET_CORNER + "%' \n");
				stmt.execute(sbSql.toString());	
									
				sbSql.delete(0, sbSql.length());	
				sbSql.append(" DELETE FROM "+ strTARGET_RECIPE_ITEM_TABLE   +" \n");
				sbSql.append(" WHERE UPJANG =  "+ strTARGET_UPJANG + " \n");
				sbSql.append(" AND   MENU_CD LIKE TO_CHAR(TO_DATE('"+ strTARGET_START_DATE+"','YYYYMMDD') + "+ Integer.toString(i) +",'YYYYMMDD')||'-" + strTARGET_HALL_CD + strTARGET_MEAL + strTARGET_CORNER + "%' \n");
				stmt.execute(sbSql.toString());	
				
				sbSql.delete(0, sbSql.length());	
				sbSql.append(" DELETE FROM "+ strTARGET_RECIPE_CUISINE_TABLE   +"  \n");
				sbSql.append(" WHERE UPJANG =    "+ strTARGET_UPJANG + " \n");
				sbSql.append(" AND   MENU_CD LIKE TO_CHAR(TO_DATE('"+ strTARGET_START_DATE+"','YYYYMMDD') + "+ Integer.toString(i) +",'YYYYMMDD')||'-" + strTARGET_HALL_CD + strTARGET_MEAL + strTARGET_CORNER + "%' \n");
				stmt.execute(sbSql.toString());				
			}
			
		

			//날짜는 원본을 타켓날짜로 변경한  strTARGET_MENU_CD 사용한다.
			//MENU_CD --> 날짜-식당코드끼니코너
			
			strTARGET_MENU_CD = "TO_CHAR(TO_DATE('"+ strTARGET_START_DATE+"','YYYYMMDD') + "+ Integer.toString(i) +",'YYYYMMDD')||'-" + strTARGET_HALL_CD + strTARGET_MEAL + strTARGET_CORNER + "'  AS MENU_CD ";
						
			
			//레시피 마스터 입력
			sbSql.delete(0, sbSql.length());	
			sbSql.append("INSERT INTO "+ strTARGET_RECIPE_MST_TABLE   +" (UPJANG, MENU_CD, RECIPE_CD,   RECIPE_NAME,   RECIPE_CLASS,   RECIPE_TYPE,   CUISINE_TYPE,   MAIN_ITEM_CODE1,   MAIN_ITEM_CODE2,   COOK_TOOL1,   COOK_TOOL2,   MAJOR_DISH_INFO,   RECIPE_COLOR,   RECIPE_SHAPE,   RECIPE_TASTE,   RECIPE_FEEL,   RECIPE_TEMPER,   SPRING_YN,   SUMMER_YN,   AUTUMN_YN,   WINTER_YN,   RESP_NUT1,   RESP_NUT2,   USE_TOOL,   VALID_TIME,   DISPLAY_METHOD,   SALE_UOM,   SALE_PRICE,   COST_RATE,   COOK_1MAN_QTY,   COOK_TIME,   EXPECT_SALE_QTY,   REAL_SALE_QTY,   CORE_TEMPER_YN,   GOODS_FEATURE,   PHF_MGMT_YN,   PHF_MGMT1,   PHF_MGMT2,   PHF_MGMT3,   PHF_MGMT4,   PHF_MGMT5,   COOK_OPRN,   PHOTO_PATH,   PREFER,   ORIGIN_RECIPE,   CUSER,         CDATE,       UUSER,        UDATE,     SPHOTO_PATH,   PHF,   RECIPE_SEQ ) \n");
			sbSql.append("SELECT "+ strTARGET_UPJANG +", "+ strTARGET_MENU_CD +"  ,B.RECIPE_CD, B.RECIPE_NAME, B.RECIPE_CLASS, B.RECIPE_TYPE, B.CUISINE_TYPE, B.MAIN_ITEM_CODE1, B.MAIN_ITEM_CODE2, B.COOK_TOOL1, B.COOK_TOOL2, B.MAJOR_DISH_INFO, B.RECIPE_COLOR, B.RECIPE_SHAPE, B.RECIPE_TASTE, B.RECIPE_FEEL, B.RECIPE_TEMPER, B.SPRING_YN, B.SUMMER_YN, B.AUTUMN_YN, B.WINTER_YN, B.RESP_NUT1, B.RESP_NUT2, B.USE_TOOL, B.VALID_TIME, B.DISPLAY_METHOD, B.SALE_UOM, B.SALE_PRICE, B.COST_RATE, B.COOK_1MAN_QTY, B.COOK_TIME, B.EXPECT_SALE_QTY, B.REAL_SALE_QTY, B.CORE_TEMPER_YN, B.GOODS_FEATURE, B.PHF_MGMT_YN, B.PHF_MGMT1, B.PHF_MGMT2, B.PHF_MGMT3, B.PHF_MGMT4, B.PHF_MGMT5, B.COOK_OPRN, B.PHOTO_PATH, B.PREFER, B.ORIGIN_RECIPE, '"+ g_EmpNo +"', SYSDATE, '"+ g_EmpNo + "', SYSDATE, B.SPHOTO_PATH, B.PHF, B.RECIPE_SEQ  \n");
			sbSql.append("  FROM " + strSOURCE_MENU_MST_TABLE + "    A  \n");
			sbSql.append("      ," + strSOURCE_RECIPE_MST_TABLE + "  B  \n");
			sbSql.append("WHERE  A.MENU_CD = B.MENU_CD  \n");
			sbSql.append(" AND    A.UPJANG  = B.UPJANG       \n");
			sbSql.append(" AND    A.UPJANG  = "+ strSOURCE_UPJANG +"  \n");
			sbSql.append(" AND    A.HALL_CD = '"+ strSOURCE_HALL_CD +"'  \n");
			sbSql.append(" AND    A.CORNER  = '"+ strSOURCE_CORNER + "' \n");
			sbSql.append(" AND    A.MEAL    = '"+ strSOURCE_MEAL + "' \n");
			sbSql.append(" AND    A.MENU_DATE = TO_CHAR(TO_DATE('"+ strSOURCE_START_DATE+"','YYYYMMDD') + "+ Integer.toString(i) +",'YYYYMMDD') \n");
			//System.out.println(sbSql.toString());			
			stmt.execute(sbSql.toString());
			
			
			//타겟 아이템 NEED 데이트
			v_NEED_DATE = " FSM_ITEM_NEED_DATE_FUN('"+ strTARGET_UPJANG +"', '"+ strTARGET_HALL_CD +"', '"+ strTARGET_MEAL  +"', '"+ strTARGET_CORNER +"', TO_CHAR(TO_DATE('"+ strTARGET_START_DATE + "','YYYYMMDD') + "+ Integer.toString(i) +",'YYYYMMDD') ) ";
			
			//System.out.println("************NEED_DATE:" + v_NEED_DATE);
			
			//레시피 자재 입력
			sbSql.delete(0, sbSql.length());	
			sbSql.append("INSERT INTO "+ strTARGET_RECIPE_ITEM_TABLE   +"  (UPJANG, MENU_CD, RECIPE_CD, ITEM_CODE, ITEM_SEQ, NEED_QTY, EDIBLE_QTY, CUT_SPEC, NEED_DATE,                        UNIT_PRICE, MARGIN_RATE, MARGIN_PRICE, CUSER, CDATE, UUSER, UDATE) \n");
			sbSql.append("SELECT "+ strTARGET_UPJANG +", "+ strTARGET_MENU_CD +",            RECIPE_CD, ITEM_CODE, ITEM_SEQ, NEED_QTY, EDIBLE_QTY, CUT_SPEC, " + v_NEED_DATE + " AS NEED_DATE, UNIT_PRICE, MARGIN_RATE, MARGIN_PRICE,  '"+ g_EmpNo +"', SYSDATE, '"+ g_EmpNo + "', SYSDATE  \n");
			sbSql.append("  FROM " + strSOURCE_MENU_MST_TABLE + "    A  \n");
			sbSql.append("      ," + strSOURCE_RECIPE_ITEM_TABLE + "  B  \n");
			sbSql.append("WHERE  A.MENU_CD = B.MENU_CD  \n");
			sbSql.append(" AND    A.UPJANG  = B.UPJANG       \n");
			sbSql.append(" AND    A.UPJANG  = "+ strSOURCE_UPJANG +"  \n");
			sbSql.append(" AND    A.HALL_CD = '"+ strSOURCE_HALL_CD +"'  \n");
			sbSql.append(" AND    A.CORNER  = '"+ strSOURCE_CORNER + "' \n");
			sbSql.append(" AND    A.MEAL    = '"+ strSOURCE_MEAL + "' \n");
			sbSql.append(" AND    A.MENU_DATE = TO_CHAR(TO_DATE('"+ strSOURCE_START_DATE+"','YYYYMMDD') + "+ Integer.toString(i) +",'YYYYMMDD') \n");
		    //System.out.println(sbSql.toString());
			
		    stmt.execute(sbSql.toString());
				
				
			//레시피 조리법  입력
			sbSql.delete(0, sbSql.length());	
			sbSql.append("INSERT INTO "+ strTARGET_RECIPE_CUISINE_TABLE +"  (UPJANG, MENU_CD, RECIPE_CD, CUISINE_SEQ, CUISINE_DESC, PHOTO_PATH, CUSER, CDATE, UUSER, UDATE, SPHOTO_PATH) \n");
			sbSql.append("SELECT "+ strTARGET_UPJANG +", "+ strTARGET_MENU_CD +",    RECIPE_CD, CUISINE_SEQ, CUISINE_DESC, PHOTO_PATH, '"+ g_EmpNo +"', SYSDATE, '"+ g_EmpNo + "', SYSDATE, SPHOTO_PATH \n");
			sbSql.append("  FROM " + strSOURCE_MENU_MST_TABLE + "    A  \n");
			sbSql.append("      ," + strSOURCE_RECIPE_CUISINE_TABLE + "  B  \n");
			sbSql.append("WHERE   A.MENU_CD = B.MENU_CD  \n");
			sbSql.append(" AND    A.UPJANG  = B.UPJANG       \n");
			sbSql.append(" AND    A.UPJANG  = "+ strSOURCE_UPJANG +"  \n");
			sbSql.append(" AND    A.HALL_CD = '"+ strSOURCE_HALL_CD +"'  \n");
			sbSql.append(" AND    A.CORNER  = '"+ strSOURCE_CORNER + "' \n");
			sbSql.append(" AND    A.MEAL    = '"+ strSOURCE_MEAL + "' \n");
			sbSql.append(" AND    A.MENU_DATE = TO_CHAR(TO_DATE('"+ strSOURCE_START_DATE+"','YYYYMMDD') + "+ Integer.toString(i) +",'YYYYMMDD') \n");
		    //System.out.println(sbSql.toString());
	
		    stmt.execute(sbSql.toString());
		 }

		//업장, 시작날짜, 종료일짜를 사용하여 MARGIN_RATE, MARGIN_PRICE, UNIT_PRICE 를 생성하는 프로시져를 콜한다.
		//FSM_PRICE_PERIOD_UPDATE_PRO (  V_UPJANG IN NUMBER, V_FROM_DATE IN VARCHAR2, V_TO_DATE IN  VARCHAR2 )
		 sbSql.delete(0, sbSql.length());
		 sbSql.append(" BEGIN \n");
		 sbSql.append(" FSM_PRICE_PERIOD_UPDATE_PRO("+ strTARGET_UPJANG +", '"+ strTARGET_START_DATE +"', '"+ strTARGET_END_DATE +"'); \n");
		 sbSql.append(" END; ");
 		 stmt.execute(sbSql.toString()); 
 		 
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
