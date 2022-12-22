<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	//[코너복사]
	PlatformRequest platformRequest = this.proc_input(request);  
	// 입력 데이터셋리스트
	in_dl = platformRequest.getData().getDataSetList();
	// 입력  변수리스트
	in_vl = platformRequest.getData().getVariableList();
	
	String g_EmpNo 		        = in_vl.getString("g_EmpNo");
	String v_UPJANG             = in_vl.getString("UPJANG");
	String v_HALL_CD            = in_vl.getString("HALL_CD");
	
	String v_SOURCE_CORNER      = in_vl.getString("SOURCE_CORNER");
	String v_SOURCE_MEAL        = in_vl.getString("SOURCE_MEAL");
	
	//String v_TARGET_CORNER      = in_vl.getString("TARGET_CORNER");
	//String v_TARGET_MEAL        = in_vl.getString("TARGET_MEAL");
	
	String v_SOURCE_START_DATE  = in_vl.getString("SOURCE_START_DATE");
    //String v_SOURCE_END_DATE    = in_vl.getString("SOURCE_END_DATE");
	Integer v_SOURCE_DAYS       = in_vl.getInt("SOURCE_DAYS");            //주기식단일수

	String v_TARGET_START_DATE  = in_vl.getString("TARGET_START_DATE");
   	//String v_TARGET_END_DATE    = in_vl.getString("TARGET_END_DATE");        //타켓이 속한 마지막날(타겟의 마지막날  또는 타겟이 속한 달의  마지막날) 
    //	Integer v_TARGET_DAYS       = in_vl.getInt("TARGET_DAYS");       //타겟식단일수
    
	//Integer v_TARGET_SOURCE_NUM  = in_vl.getInt("TARGET_SOURCE_NUM");    //올림(타켓식단일수 /주기식단일수)
	String  v_TARGET_MENU_CD=""; //타켓의 메뉴CD;	
	String v_SKIP_YN            = in_vl.getString("SKIP_YN");                //건너띄기
	
	//System.out.println(v_UPJANG);
	//System.out.println(v_HALL_CD);
	//System.out.println(v_SOURCE_CORNER);
	//System.out.println(v_SOURCE_MEAL);
	//System.out.println(v_SOURCE_START_DATE);
	//System.out.println(v_SOURCE_DAYS);
	//System.out.println(v_TARGET_START_DATE);
	//System.out.println(v_TARGET_END_DATE);
	//System.out.println(v_TARGET_SOURCE_NUM);
	//System.out.println(v_SKIP_YN);
	
	Statement stmt 		=  conn.createStatement();                                  //실행명령 선언
	
	int i=0;
	
	StringBuffer sbSql = new StringBuffer();
	
	try 
	{				
		
		for(i=0; i< v_SOURCE_DAYS; i++)
		{
				//에러체크

				//0) 실식수가 등록된 식단은  스킵하다.
				sbSql.delete(0, sbSql.length());
				sbSql.append(" SELECT COUNT(*) AS R_COUNTER FROM \n");
				sbSql.append("      FSM_REAL_MENU_MST A          \n");
				sbSql.append("     ,FSM_REAL_RECIPE_MST B        \n");
				sbSql.append(" WHERE  A.MENU_CD = B.MENU_CD      \n");
				sbSql.append(" AND    A.UPJANG  = "+ v_UPJANG + "\n");
				sbSql.append(" AND    A.HALL_CD = '"+ v_HALL_CD +"' \n");
				sbSql.append(" AND    A.CORNER  = DECODE('"+ v_SOURCE_CORNER +"', '', A.CORNER, '"+ v_SOURCE_CORNER +"' ) \n");
				sbSql.append(" AND    A.MEAL    = DECODE('"+ v_SOURCE_MEAL +"','', A.MEAL, '"+ v_SOURCE_MEAL +"' ) \n");
				sbSql.append(" AND    A.MENU_DATE = '"+ v_TARGET_START_DATE + "' \n");
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
				sbSql.append("      FSM_REAL_MENU_MST A          \n");
				sbSql.append("     ,FSM_REAL_RECIPE_ITEM B        \n");
				sbSql.append(" WHERE  A.MENU_CD = B.MENU_CD      \n");
				sbSql.append(" AND    A.UPJANG  = "+ v_UPJANG + "\n");
				sbSql.append(" AND    A.HALL_CD = '"+ v_HALL_CD +"' \n");
				sbSql.append(" AND    A.CORNER  = DECODE('"+ v_SOURCE_CORNER +"', '', A.CORNER, '"+ v_SOURCE_CORNER +"' ) \n");
				sbSql.append(" AND    A.MEAL    = DECODE('"+ v_SOURCE_MEAL +"','', A.MEAL, '"+ v_SOURCE_MEAL +"' ) \n");
				sbSql.append(" AND    A.MENU_DATE = '"+ v_TARGET_START_DATE + "' \n");
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
										
				//1) 복사옵션 SKIP_YN = Y 일때   Count를 조사하여 Continue;;;
				if(v_SKIP_YN.equals("1"))
				{
					sbSql.delete(0, sbSql.length());	
					sbSql.append(" SELECT COUNT(*) AS R_COUNTER FROM  \n");
					sbSql.append("      FSM_REAL_MENU_MST A           \n");
					sbSql.append("     ,FSM_REAL_RECIPE_MST B         \n");
					sbSql.append(" WHERE  A.MENU_CD = B.MENU_CD       \n");
					sbSql.append(" AND    A.UPJANG  = "+ v_UPJANG + " \n");
					sbSql.append(" AND    A.HALL_CD = '"+ v_HALL_CD +"' \n");
					sbSql.append(" AND    A.CORNER  = DECODE('"+ v_SOURCE_CORNER +"', '', A.CORNER, '"+ v_SOURCE_CORNER +"' ) \n");
					sbSql.append(" AND    A.MEAL    = DECODE('"+ v_SOURCE_MEAL +"','', A.MEAL, '"+ v_SOURCE_MEAL +"' ) \n");
					sbSql.append(" AND    A.MENU_DATE = '"+ v_TARGET_START_DATE + "' \n");
			
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
				{
					//데이터를 삭제한다.
					sbSql.delete(0, sbSql.length());	
					sbSql.append(" DELETE FROM FSM_REAL_RECIPE_MST \n");
					sbSql.append(" WHERE UPJANG =   "+ v_UPJANG +" \n");
					sbSql.append(" AND   MENU_CD LIKE '"+ v_TARGET_START_DATE + "-" + v_HALL_CD + v_SOURCE_MEAL + v_SOURCE_CORNER +"%' \n");
					stmt.execute(sbSql.toString());	
										
					sbSql.delete(0, sbSql.length());	
					sbSql.append(" DELETE FROM FSM_REAL_RECIPE_ITEM \n");
					sbSql.append(" WHERE UPJANG =   "+ v_UPJANG +" \n");
					sbSql.append(" AND   MENU_CD LIKE '"+ v_TARGET_START_DATE + "-" + v_HALL_CD + v_SOURCE_MEAL + v_SOURCE_CORNER +"%' \n");
					stmt.execute(sbSql.toString());	
					
					sbSql.delete(0, sbSql.length());	
					sbSql.append(" DELETE FROM FSM_REAL_RECIPE_CUISINE \n");
					sbSql.append(" WHERE UPJANG =   "+ v_UPJANG +" \n");
					sbSql.append(" AND   MENU_CD LIKE '"+ v_TARGET_START_DATE + "-" + v_HALL_CD + v_SOURCE_MEAL + v_SOURCE_CORNER +"%' \n");
					stmt.execute(sbSql.toString());						
				}

				//날짜는 원본을 타켓날짜로 변경한  v_TARGET_MENU_CD 사용한다.
				v_TARGET_MENU_CD = "REPLACE(B.MENU_CD,'"+ v_SOURCE_START_DATE + "','"+ v_TARGET_START_DATE + "')  AS MENU_CD ";
				
				
				//레시피 마스터 입력
				sbSql.delete(0, sbSql.length());	
				sbSql.append("INSERT INTO FSM_REAL_RECIPE_MST (UPJANG, MENU_CD, RECIPE_CD,   RECIPE_NAME,   RECIPE_CLASS,   RECIPE_TYPE,   CUISINE_TYPE,   MAIN_ITEM_CODE1,   MAIN_ITEM_CODE2,   COOK_TOOL1,   COOK_TOOL2,   MAJOR_DISH_INFO,   RECIPE_COLOR,   RECIPE_SHAPE,   RECIPE_TASTE,   RECIPE_FEEL,   RECIPE_TEMPER,   SPRING_YN,   SUMMER_YN,   AUTUMN_YN,   WINTER_YN,   RESP_NUT1,   RESP_NUT2,   USE_TOOL,   VALID_TIME,   DISPLAY_METHOD,   SALE_UOM,   SALE_PRICE,   COST_RATE,   COOK_1MAN_QTY,   COOK_TIME,   EXPECT_SALE_QTY,   REAL_SALE_QTY,   CORE_TEMPER_YN,   GOODS_FEATURE,   PHF_MGMT_YN,   PHF_MGMT1,   PHF_MGMT2,   PHF_MGMT3,   PHF_MGMT4,   PHF_MGMT5,   COOK_OPRN,   PHOTO_PATH,   PREFER,   ORIGIN_RECIPE,   CUSER,         CDATE,       UUSER,        UDATE,     SPHOTO_PATH,   PHF,   RECIPE_SEQ ) \n");
				sbSql.append("SELECT B.UPJANG, "+ v_TARGET_MENU_CD +"  ,B.RECIPE_CD, B.RECIPE_NAME, B.RECIPE_CLASS, B.RECIPE_TYPE, B.CUISINE_TYPE, B.MAIN_ITEM_CODE1, B.MAIN_ITEM_CODE2, B.COOK_TOOL1, B.COOK_TOOL2, B.MAJOR_DISH_INFO, B.RECIPE_COLOR, B.RECIPE_SHAPE, B.RECIPE_TASTE, B.RECIPE_FEEL, B.RECIPE_TEMPER, B.SPRING_YN, B.SUMMER_YN, B.AUTUMN_YN, B.WINTER_YN, B.RESP_NUT1, B.RESP_NUT2, B.USE_TOOL, B.VALID_TIME, B.DISPLAY_METHOD, B.SALE_UOM, B.SALE_PRICE, B.COST_RATE, B.COOK_1MAN_QTY, B.COOK_TIME, B.EXPECT_SALE_QTY, B.REAL_SALE_QTY, B.CORE_TEMPER_YN, B.GOODS_FEATURE, B.PHF_MGMT_YN, B.PHF_MGMT1, B.PHF_MGMT2, B.PHF_MGMT3, B.PHF_MGMT4, B.PHF_MGMT5, B.COOK_OPRN, B.PHOTO_PATH, B.PREFER, B.ORIGIN_RECIPE, '"+ g_EmpNo +"', SYSDATE, '"+ g_EmpNo + "', SYSDATE, B.SPHOTO_PATH, B.PHF, B.RECIPE_SEQ  \n");
				sbSql.append("  FROM FSM_REAL_MENU_MST    A  \n");
				sbSql.append("      ,FSM_REAL_RECIPE_MST  B  \n");
				sbSql.append("WHERE  A.MENU_CD = B.MENU_CD  \n");
				sbSql.append("AND    A.UPJANG  = "+ v_UPJANG +"  \n");
				sbSql.append("AND    A.HALL_CD = '"+ v_HALL_CD +"'  \n");
				sbSql.append("AND    A.CORNER  = DECODE('"+ v_SOURCE_CORNER +"', '', A.CORNER, '"+ v_SOURCE_CORNER +"' )  \n");
				sbSql.append("AND    A.MEAL    = DECODE('"+ v_SOURCE_MEAL +"','', A.MEAL, '"+ v_SOURCE_MEAL +"' )  \n");
				sbSql.append("AND    A.MENU_DATE = '"+ v_SOURCE_START_DATE + "'  \n");
				//System.out.println(sbSql.toString());
				stmt.execute(sbSql.toString());
				
				
				//레시피 자재 입력
				sbSql.delete(0, sbSql.length());	
				sbSql.append("INSERT INTO FSM_REAL_RECIPE_ITEM  (UPJANG, MENU_CD, RECIPE_CD, ITEM_CODE, ITEM_SEQ, NEED_QTY, EDIBLE_QTY, CUT_SPEC, ORDER_YN, PR_ID, PR_NUM, PR_QTY, NEED_DATE, UNIT_PRICE, MARGIN_RATE, MARGIN_PRICE, CUSER, CDATE, UUSER, UDATE) \n");
				sbSql.append("SELECT B.UPJANG, "+ v_TARGET_MENU_CD +",            RECIPE_CD, ITEM_CODE, ITEM_SEQ, NEED_QTY, EDIBLE_QTY, CUT_SPEC, ORDER_YN, PR_ID, PR_NUM, PR_QTY, NEED_DATE, UNIT_PRICE, MARGIN_RATE, MARGIN_PRICE,  '"+ g_EmpNo +"', SYSDATE, '"+ g_EmpNo + "', SYSDATE  \n");
				sbSql.append("  FROM FSM_REAL_MENU_MST    A  \n");
				sbSql.append("      ,FSM_REAL_RECIPE_ITEM  B  \n");
				sbSql.append("WHERE  A.MENU_CD = B.MENU_CD  \n");
				sbSql.append("AND    A.UPJANG  = "+ v_UPJANG +"  \n");
				sbSql.append("AND    A.HALL_CD = '"+ v_HALL_CD +"'  \n");
				sbSql.append("AND    A.CORNER  = DECODE('"+ v_SOURCE_CORNER +"', '', A.CORNER, '"+ v_SOURCE_CORNER +"' )  \n");
				sbSql.append("AND    A.MEAL    = DECODE('"+ v_SOURCE_MEAL +"','', A.MEAL, '"+ v_SOURCE_MEAL +"' )  \n");
				sbSql.append("AND    A.MENU_DATE = '"+ v_SOURCE_START_DATE + "'  \n");
				//System.out.println(sbSql.toString());
				stmt.execute(sbSql.toString());
				
				
				//레시피 조리법  입력
				sbSql.delete(0, sbSql.length());	
				sbSql.append("INSERT INTO FSM_REAL_RECIPE_CUISINE  (UPJANG, MENU_CD, RECIPE_CD, CUISINE_SEQ, CUISINE_DESC, PHOTO_PATH, CUSER, CDATE, UUSER, UDATE, SPHOTO_PATH) \n");
				sbSql.append("SELECT B.UPJANG, "+ v_TARGET_MENU_CD +",    RECIPE_CD, CUISINE_SEQ, CUISINE_DESC, PHOTO_PATH, '"+ g_EmpNo +"', SYSDATE, '"+ g_EmpNo + "', SYSDATE, SPHOTO_PATH \n");
				sbSql.append("  FROM FSM_REAL_MENU_MST    A  \n");
				sbSql.append("      ,FSM_REAL_RECIPE_CUISINE  B  \n");
				sbSql.append("WHERE  A.MENU_CD = B.MENU_CD  \n");
				sbSql.append("AND    A.UPJANG  = "+ v_UPJANG +"  \n");
				sbSql.append("AND    A.HALL_CD = '"+ v_HALL_CD +"'  \n");
				sbSql.append("AND    A.CORNER  = DECODE('"+ v_SOURCE_CORNER +"', '', A.CORNER, '"+ v_SOURCE_CORNER +"' )  \n");
				sbSql.append("AND    A.MEAL    = DECODE('"+ v_SOURCE_MEAL +"','', A.MEAL, '"+ v_SOURCE_MEAL +"' )  \n");
				sbSql.append("AND    A.MENU_DATE = '"+ v_SOURCE_START_DATE + "'  \n");
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
	}	
	
    proc_output(response,out,out_vl,out_dl);

%>
