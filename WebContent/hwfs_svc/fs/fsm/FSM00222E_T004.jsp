<%
/*
 ******************************************************************************************
 * 시스템구분: IFIS/식단관리/식단등록(병원)
 * 프로그램명: FSM00222E.XML
 * 기ㅡㅡㅡ능: 식단등록(병원)-병원일일식단 ===> F3 전체삭제하기 구현로직
 * 작ㅡ성ㅡ자: 김민수
 * 작성ㅡ일자: 2015-11-11
 * ----------------------------------------------------------------------------------------
 * HISTORY    : 
 ******************************************************************************************
 */
 %> 
<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	Statement stmt             =  null;
	try	{
		//[코너복사]
		PlatformRequest platformRequest = this.proc_input(request);  
		// 입력 데이터셋리스트
		in_dl = platformRequest.getData().getDataSetList();
		// 입력  변수리스트
		in_vl = platformRequest.getData().getVariableList();
		
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));
		
		String g_EmpNo 	   = in_vl.getString("g_EmpNo");
		String UPJANG      = in_vl.getString("UPJANG");	
		String MENU_DATE   = in_vl.getString("MENU_DATE");
		String HALL_CD     = in_vl.getString("HALL_CD");
		String CORNER      = in_vl.getString("CORNER");
		String MEAL        = in_vl.getString("MEAL");
		
		stmt 	   = conn.createStatement();                                  //실행명령 선언
		StringBuffer sbSql = new StringBuffer();
	
		//에러체크
		//0) 실식수가 등록된 식단은  스킵하다.
		sbSql.delete(0, sbSql.length());
		sbSql.append(" SELECT COUNT(*) AS R_COUNTER FROM \n");
		sbSql.append("      FSM_REAL_MENU_MST A          \n");
		sbSql.append("     ,FSM_REAL_RECIPE_MST B        \n");
		sbSql.append(" WHERE  A.MENU_CD = B.MENU_CD      \n");
		sbSql.append(" AND    A.UPJANG  = B.UPJANG       \n");
		sbSql.append(" AND    A.UPJANG  = ? \n");
		sbSql.append(" AND    A.HALL_CD = ? \n");
		sbSql.append(" AND    A.CORNER  = ? \n");
		sbSql.append(" AND    A.MEAL    = ? \n");
		sbSql.append(" AND    A.MENU_DATE = ? \n");
		sbSql.append(" AND    A.REAL_MEAL_QTY > 0 \n");

		pstmt = conn.prepareStatement(sbSql.toString());
		pstmt.setString(1, UPJANG);
		pstmt.setString(2, HALL_CD);
		pstmt.setString(3, CORNER);
		pstmt.setString(4, MEAL);
		pstmt.setString(5, MENU_DATE);
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
		
		//0) 발주자재가 등록된 레시피는 스킵한다.
		sbSql.delete(0, sbSql.length());
		sbSql.append(" SELECT COUNT(*) AS R_COUNTER FROM \n");
		sbSql.append("      FSM_REAL_MENU_MST A          \n");
		sbSql.append("     ,FSM_REAL_RECIPE_ITEM B        \n");
		sbSql.append(" WHERE  A.MENU_CD = B.MENU_CD      \n");
		sbSql.append(" AND    A.UPJANG  = B.UPJANG       \n");
		sbSql.append(" AND    A.UPJANG  = ? \n");
		sbSql.append(" AND    A.HALL_CD = ? \n");
		sbSql.append(" AND    A.CORNER  = ? \n");
		sbSql.append(" AND    A.MEAL    = ? \n");
		sbSql.append(" AND    A.MENU_DATE = ? \n");
		sbSql.append(" AND    B.ORDER_YN  = 'Y' \n");
		
		pstmt = conn.prepareStatement(sbSql.toString());
		pstmt.setString(1, UPJANG);
		pstmt.setString(2, HALL_CD);
		pstmt.setString(3, CORNER);
		pstmt.setString(4, MEAL);
		pstmt.setString(5, MENU_DATE);
		rs = pstmt.executeQuery(); 		
		rs.next();
		
		try{
			if(Integer.parseInt(rs.getString("R_COUNTER"))>0)
			{
				{throw new Exception("에러발생:발주자재가 등록된 식단입니다.");}		
			}		
		}
		
		catch(Exception e){
			throw e;
		}				
		
		finally{
			if(rs!=null){rs.close();}
		}
		
		
		//1.레시피 자재 삭제
		sbSql.delete(0, sbSql.length());	
		sbSql.append(" DELETE FROM FSM_REAL_RECIPE_ITEM                                                     \n ");
		sbSql.append(" WHERE UPJANG    = "+ UPJANG +"                                                       \n ");
		sbSql.append(" AND   MENU_CD   = '"+ MENU_DATE +"'|| '-' ||'"+HALL_CD+"'||'"+MEAL+"'||'"+CORNER+"'  \n ");
		stmt.execute(sbSql.toString());

		
		//2.레시피 조리법  삭제
		sbSql.delete(0, sbSql.length());	
		sbSql.append(" DELETE FROM FSM_REAL_RECIPE_CUISINE                                                  \n ");
		sbSql.append(" WHERE UPJANG    = "+ UPJANG +"                                                       \n ");
		sbSql.append(" AND   MENU_CD   = '"+ MENU_DATE +"'|| '-' ||'"+HALL_CD+"'||'"+MEAL+"'||'"+CORNER+"'  \n ");
		stmt.execute(sbSql.toString());

						
		//3.레시피 마스터 삭제
		sbSql.delete(0, sbSql.length());	
		sbSql.delete(0, sbSql.length());	
		sbSql.append(" DELETE FROM FSM_REAL_RECIPE_MST                                                      \n ");
		sbSql.append(" WHERE UPJANG    = "+ UPJANG +"                                                       \n ");
		sbSql.append(" AND   MENU_CD   = '"+ MENU_DATE +"'|| '-' ||'"+HALL_CD+"'||'"+MEAL+"'||'"+CORNER+"'  \n ");
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
