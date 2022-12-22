<%
/*
 ******************************************************************************************
 * 시스템구분: IFIS/식단관리/식단등록(병원)
 * 프로그램명: FSM00221E.XML
 * 기ㅡㅡㅡ능: 식단등록(병원)-병원일일식단 ===> 빠른식단 복사 구현로직
 * 작ㅡ성ㅡ자: 한화S&C 박종세
 * 작성ㅡ일자: 2008-05-13
 * ----------------------------------------------------------------------------------------
 * HISTORY    : 
 ******************************************************************************************
 */
 %> 
<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	Statement stmt             =  null;
	try {
		///////////////////////////
		//일일식단 ==> 빠른식단복사 
		///////////////////////////
		PlatformRequest platformRequest = this.proc_input(request);  
		// 입력 데이터셋리스트
		in_dl = platformRequest.getData().getDataSetList();
		// 입력  변수리스트
		in_vl = platformRequest.getData().getVariableList();
		
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));
		
		String g_EmpNo 		        = in_vl.getString("g_EmpNo");
		String v_GUBUN              = in_vl.getString("GUBUN");
		
		String tbl_MENU_MST           = "";  //메뉴마스터테이블
		String tbl_RECIPE_MST         = "";  //레시피마스터테이블
		String tbl_RECIPE_ITEM        = "";  //레시피아이템테이블
		String tbl_RECIPE_CUISINE     = "";  //레시피조리법테이블
		
		String v_SOURCE_UPJANG      = in_vl.getString("SOURCE_UPJANG");
		String v_SOURCE_MENU_DATE   = in_vl.getString("SOURCE_MENU_DATE");
		String v_SOURCE_HALL_CD     = in_vl.getString("SOURCE_HALL_CD");
		String v_SOURCE_CORNER      = in_vl.getString("SOURCE_CORNER");
		String v_SOURCE_MEAL        = in_vl.getString("SOURCE_MEAL");
		
	
		String v_TARGET_UPJANG      = in_vl.getString("TARGET_UPJANG");
		String v_TARGET_MENU_DATE   = in_vl.getString("TARGET_MENU_DATE");
		String v_TARGET_HALL_CD     = in_vl.getString("TARGET_HALL_CD");
		String v_TARGET_CORNER      = in_vl.getString("TARGET_CORNER");
		String v_TARGET_MEAL        = in_vl.getString("TARGET_MEAL");
			
		String v_TARGET_MENU_CD     = "'" + v_TARGET_MENU_DATE + "-" + v_TARGET_HALL_CD + v_TARGET_MEAL + v_TARGET_CORNER + "'  AS MENU_CD ";
		String v_NEED_DATE          = "";
		
		stmt 	   = conn.createStatement();                                  //실행명령 선언
		StringBuffer sbSql = new StringBuffer();
	
				
				if(v_GUBUN.equals("REAL"))
				{    //일일식
					 tbl_MENU_MST           = "FSM_REAL_MENU_MST";        //메뉴마스터테이블
					 tbl_RECIPE_MST         = "FSM_REAL_RECIPE_MST";      //레시피마스터테이블
					 tbl_RECIPE_ITEM        = "FSM_REAL_RECIPE_ITEM";     //레시피아이템테이블
					 tbl_RECIPE_CUISINE     = "FSM_REAL_RECIPE_CUISINE";  //레시피조리법테이블
				}
				else
				{    //주기식단
					 tbl_MENU_MST           = "FSH_CYCLE_MENU_MST";        //메뉴마스터테이블
					 tbl_RECIPE_MST         = "FSH_CYCLE_RECIPE_MST";      //레시피마스터테이블
					 tbl_RECIPE_ITEM        = "FSH_CYCLE_RECIPE_ITEM";     //레시피아이템테이블
					 tbl_RECIPE_CUISINE     = "FSH_CYCLE_RECIPE_CUISINE";  //레시피조리법테이블
				}
		
		
		
				//에러체크
				//0) 실식수가 등록된 식단은  스킵하다.
				sbSql.delete(0, sbSql.length());
				sbSql.append(" SELECT COUNT(*) AS R_COUNTER FROM \n");
				sbSql.append("      "+ tbl_MENU_MST +" A          \n");
				sbSql.append("     ,"+ tbl_RECIPE_MST +" B        \n");
				sbSql.append(" WHERE  A.MENU_CD = B.MENU_CD      \n");
				sbSql.append(" AND    A.UPJANG  = B.UPJANG       \n");
				sbSql.append(" AND    A.UPJANG  = " + v_TARGET_UPJANG + "\n");
				sbSql.append(" AND    A.HALL_CD = '"+ v_TARGET_HALL_CD +"' \n");
				sbSql.append(" AND    A.CORNER  = '"+ v_TARGET_CORNER +"' \n");
				sbSql.append(" AND    A.MEAL    = '"+ v_TARGET_MEAL +"' \n");
				sbSql.append(" AND    A.MENU_DATE = '"+ v_TARGET_MENU_DATE +"' \n");
				sbSql.append(" AND    A.REAL_MEAL_QTY > 0 \n");
	
				pstmt = conn.prepareStatement(sbSql.toString());	
				rs = pstmt.executeQuery(); 		
				rs.next();
				
				try{
					if(Integer.parseInt(rs.getString("R_COUNTER"))>0)
					{throw new Exception("에러발생: 실식수가 등록된 식단입니다.");}		
				}	
				catch(Exception e){
					throw e;
				}				
				finally{
					if(rs!=null){rs.close();}
				}				
				
				//0) 발주자재가 등록된 식단은 스킵한다.
				sbSql.delete(0, sbSql.length());
				sbSql.append(" SELECT COUNT(*) AS R_COUNTER FROM \n");
				sbSql.append("      "+ tbl_MENU_MST +" A          \n");
				sbSql.append("     ,"+ tbl_RECIPE_ITEM +" B        \n");
				sbSql.append(" WHERE  A.MENU_CD = B.MENU_CD      \n");
				sbSql.append(" AND    A.UPJANG  = B.UPJANG       \n");
				sbSql.append(" AND    A.UPJANG  = " + v_TARGET_UPJANG + "\n");
				sbSql.append(" AND    A.HALL_CD = '"+ v_TARGET_HALL_CD +"' \n");
				sbSql.append(" AND    A.CORNER  = '"+ v_TARGET_CORNER +"' \n");
				sbSql.append(" AND    A.MEAL    = '"+ v_TARGET_MEAL +"' \n");
				sbSql.append(" AND    A.MENU_DATE = '"+ v_TARGET_MENU_DATE +"' \n");
				sbSql.append(" AND    B.ORDER_YN ='Y' \n");
				
				pstmt = conn.prepareStatement(sbSql.toString());	
				rs = pstmt.executeQuery(); 		
				rs.next();
				
				try{
					if(Integer.parseInt(rs.getString("R_COUNTER"))>0)
					{throw new Exception("에러발생: 발주자재가 등록된 식단입니다.");}		
				}
				
				catch(Exception e){
						throw e;
				}				
				
				finally{
					if(rs!=null){rs.close();}
				}
				
				
				
				//기존 등록된 식단정보  삭제하기
				//데이터를 삭제한다.
				sbSql.delete(0, sbSql.length());	
				sbSql.append(" DELETE FROM "+ tbl_RECIPE_MST +" \n");
				sbSql.append(" WHERE UPJANG =   "+ v_TARGET_UPJANG +" \n");
				sbSql.append(" AND   MENU_CD =  '" + v_TARGET_MENU_DATE + "-" + v_TARGET_HALL_CD + v_TARGET_MEAL + v_TARGET_CORNER + "'  \n");
				stmt.execute(sbSql.toString());	
									
				sbSql.delete(0, sbSql.length());	
				sbSql.append(" DELETE FROM "+ tbl_RECIPE_ITEM +" \n");
				sbSql.append(" WHERE UPJANG =   "+ v_TARGET_UPJANG +" \n");
				sbSql.append(" AND   MENU_CD =  '" + v_TARGET_MENU_DATE + "-" + v_TARGET_HALL_CD + v_TARGET_MEAL + v_TARGET_CORNER + "'  \n");
				stmt.execute(sbSql.toString());	
				
				sbSql.delete(0, sbSql.length());	
				sbSql.append(" DELETE FROM "+ tbl_RECIPE_CUISINE +" \n");
				sbSql.append(" WHERE UPJANG =   "+ v_TARGET_UPJANG +" \n");
				sbSql.append(" AND   MENU_CD =  '" + v_TARGET_MENU_DATE + "-" + v_TARGET_HALL_CD + v_TARGET_MEAL + v_TARGET_CORNER + "'  \n");
				stmt.execute(sbSql.toString());	
				
								
				//레시피 마스터 입력
				sbSql.delete(0, sbSql.length());	
				sbSql.append("INSERT INTO "+ tbl_RECIPE_MST +" (UPJANG, MENU_CD, RECIPE_CD,            RECIPE_NAME,   RECIPE_CLASS,   RECIPE_TYPE,   CUISINE_TYPE,   MAIN_ITEM_CODE1,   MAIN_ITEM_CODE2,   COOK_TOOL1,   COOK_TOOL2,   MAJOR_DISH_INFO,   RECIPE_COLOR,   RECIPE_SHAPE,   RECIPE_TASTE,   RECIPE_FEEL,   RECIPE_TEMPER,   SPRING_YN,   SUMMER_YN,   AUTUMN_YN,   WINTER_YN,   RESP_NUT1,   RESP_NUT2,   USE_TOOL,   VALID_TIME,   DISPLAY_METHOD,   SALE_UOM,   SALE_PRICE,   COST_RATE,   COOK_1MAN_QTY,   COOK_TIME,   EXPECT_SALE_QTY,   REAL_SALE_QTY,   CORE_TEMPER_YN,   GOODS_FEATURE,   PHF_MGMT_YN,   PHF_MGMT1,   PHF_MGMT2,   PHF_MGMT3,   PHF_MGMT4,   PHF_MGMT5,   COOK_OPRN,   PHOTO_PATH,   PREFER,   ORIGIN_RECIPE,   CUSER,         CDATE,       UUSER,        UDATE,     SPHOTO_PATH,   PHF,   RECIPE_SEQ ) \n");
				sbSql.append("SELECT " + v_TARGET_UPJANG + ", "+ v_TARGET_MENU_CD +"  ,B.RECIPE_CD, B.RECIPE_NAME, B.RECIPE_CLASS, B.RECIPE_TYPE, B.CUISINE_TYPE, B.MAIN_ITEM_CODE1, B.MAIN_ITEM_CODE2, B.COOK_TOOL1, B.COOK_TOOL2, B.MAJOR_DISH_INFO, B.RECIPE_COLOR, B.RECIPE_SHAPE, B.RECIPE_TASTE, B.RECIPE_FEEL, B.RECIPE_TEMPER, B.SPRING_YN, B.SUMMER_YN, B.AUTUMN_YN, B.WINTER_YN, B.RESP_NUT1, B.RESP_NUT2, B.USE_TOOL, B.VALID_TIME, B.DISPLAY_METHOD, B.SALE_UOM, B.SALE_PRICE, B.COST_RATE, B.COOK_1MAN_QTY, B.COOK_TIME, B.EXPECT_SALE_QTY, B.REAL_SALE_QTY, B.CORE_TEMPER_YN, B.GOODS_FEATURE, B.PHF_MGMT_YN, B.PHF_MGMT1, B.PHF_MGMT2, B.PHF_MGMT3, B.PHF_MGMT4, B.PHF_MGMT5, B.COOK_OPRN, B.PHOTO_PATH, B.PREFER, B.ORIGIN_RECIPE, '"+ g_EmpNo +"', SYSDATE, '"+ g_EmpNo + "', SYSDATE, B.SPHOTO_PATH, B.PHF, B.RECIPE_SEQ   \n");
				sbSql.append("  FROM "+ tbl_MENU_MST +"    A  \n");
				sbSql.append("      ,"+ tbl_RECIPE_MST +"  B  \n");
				sbSql.append("WHERE  A.MENU_CD   = B.MENU_CD  \n");
				sbSql.append("AND    A.UPJANG    = B.UPJANG       \n");
				sbSql.append("AND    A.UPJANG    = "+  v_SOURCE_UPJANG    +"    \n");
				sbSql.append("AND    A.HALL_CD   = '"+ v_SOURCE_HALL_CD   +"'   \n");
				sbSql.append("AND    A.CORNER    = '"+ v_SOURCE_CORNER    +"'   \n");
				sbSql.append("AND    A.MEAL      = '"+ v_SOURCE_MEAL      +"'   \n");
				sbSql.append("AND    A.MENU_DATE = '"+ v_SOURCE_MENU_DATE + "'  \n");
				stmt.execute(sbSql.toString());
				
				
				//레시피 자재 입력
				//타겟 아이템 NEED 데이트
		    	v_NEED_DATE = " FSM_ITEM_NEED_DATE_FUN('"+ v_TARGET_UPJANG +"', '"+ v_TARGET_HALL_CD +"', '"+ v_TARGET_MEAL +"', '"+ v_TARGET_CORNER +"', '"+ v_TARGET_MENU_DATE + "' ) ";
			
				sbSql.delete(0, sbSql.length());	
				sbSql.append("INSERT INTO "+ tbl_RECIPE_ITEM +"  (UPJANG, MENU_CD,     RECIPE_CD, ITEM_CODE, ITEM_SEQ, NEED_QTY, EDIBLE_QTY, CUT_SPEC, NEED_DATE,                       UNIT_PRICE, MARGIN_RATE, MARGIN_PRICE, CUSER, CDATE, UUSER, UDATE) \n");
				sbSql.append("SELECT " + v_TARGET_UPJANG + ", "+ v_TARGET_MENU_CD +",  RECIPE_CD, ITEM_CODE, ITEM_SEQ, NEED_QTY, EDIBLE_QTY, CUT_SPEC, "+ v_NEED_DATE + " AS NEED_DATE, UNIT_PRICE, MARGIN_RATE, MARGIN_PRICE,  '"+ g_EmpNo +"', SYSDATE, '"+ g_EmpNo + "', SYSDATE  \n");
				sbSql.append("  FROM "+ tbl_MENU_MST +"    A  \n");
				sbSql.append("      ,"+ tbl_RECIPE_ITEM +"  B  \n");
				sbSql.append("WHERE  A.MENU_CD = B.MENU_CD  \n");
				sbSql.append("AND    A.UPJANG  = B.UPJANG       \n");
				sbSql.append("AND    A.UPJANG  = " + v_SOURCE_UPJANG +"  \n");
				sbSql.append("AND    A.HALL_CD = '"+ v_SOURCE_HALL_CD +"'  \n");
				sbSql.append("AND    A.CORNER  = '"+ v_SOURCE_CORNER  +"'  \n");
				sbSql.append("AND    A.MEAL    = '"+ v_SOURCE_MEAL +"'     \n");
				sbSql.append("AND    A.MENU_DATE = '"+ v_SOURCE_MENU_DATE + "'  \n");
				stmt.execute(sbSql.toString());
				
				//레시피 조리법  입력
				sbSql.delete(0, sbSql.length());	
				sbSql.append("INSERT INTO "+ tbl_RECIPE_CUISINE +"  (UPJANG, MENU_CD, RECIPE_CD, CUISINE_SEQ, CUISINE_DESC, PHOTO_PATH, CUSER, CDATE, UUSER, UDATE, SPHOTO_PATH) \n");
				sbSql.append("SELECT " + v_TARGET_UPJANG + ", "+ v_TARGET_MENU_CD +",    RECIPE_CD, CUISINE_SEQ, CUISINE_DESC, PHOTO_PATH, '"+ g_EmpNo +"', SYSDATE, '"+ g_EmpNo + "', SYSDATE, SPHOTO_PATH \n");
				sbSql.append("  FROM "+ tbl_MENU_MST +"    A  \n");
				sbSql.append("      ,"+ tbl_RECIPE_CUISINE +"  B  \n");
				sbSql.append("WHERE  A.MENU_CD = B.MENU_CD  \n");
				sbSql.append("AND    A.UPJANG  = B.UPJANG       \n");
				sbSql.append("AND    A.UPJANG  = " + v_SOURCE_UPJANG +"  \n");
				sbSql.append("AND    A.HALL_CD = '"+ v_SOURCE_HALL_CD +"'  \n");
				sbSql.append("AND    A.CORNER  = '"+ v_SOURCE_CORNER  +"'  \n");
				sbSql.append("AND    A.MEAL    = '"+ v_SOURCE_MEAL +"'     \n");
				sbSql.append("AND    A.MENU_DATE = '"+ v_SOURCE_MENU_DATE + "'  \n");
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
