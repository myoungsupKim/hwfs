<%
/*
 ******************************************************************************************
 * 시스템구분: IFIS/식단관리/식단등록(병원)
 * 프로그램명: FSM00221E.XML
 * 기ㅡㅡㅡ능: 식단등록(병원)-병원주기식단 ===> Delete Key 삭제하기 구현로직
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
		String RECIPE_CD   = in_vl.getString("RECIPE_CD");
		
		stmt 	   = conn.createStatement();                                  //실행명령 선언
		StringBuffer sbSql = new StringBuffer();
	
	
				// 주기식단은 체크하지 않는다. 실제 식단만 체크한다.
				//에러체크
				//0) 실식수가 등록된 식단은  스킵하다.
				//0) 발주자재가 등록된 식단은 스킵한다.
				
				
				//1.레시피 자재 삭제
				sbSql.delete(0, sbSql.length());	
				sbSql.append(" DELETE FROM FSH_CYCLE_RECIPE_ITEM                                        \n ");
				sbSql.append(" WHERE UPJANG    = "+ UPJANG +"                                               \n ");
				sbSql.append(" AND   MENU_CD   = '"+ MENU_DATE +"'|| '-' ||'"+HALL_CD+"'||'"+MEAL+"'||'"+CORNER+"'  \n ");
				sbSql.append(" AND   RECIPE_CD = '"+ RECIPE_CD +"'                                            \n ");
				stmt.execute(sbSql.toString());
		
				
				//2.레시피 조리법  삭제
				sbSql.delete(0, sbSql.length());	
				sbSql.append(" DELETE FROM FSH_CYCLE_RECIPE_CUISINE                                        \n ");
				sbSql.append(" WHERE UPJANG    = "+ UPJANG +"                                               \n ");
				sbSql.append(" AND   MENU_CD   = '"+ MENU_DATE +"'|| '-' ||'"+HALL_CD+"'||'"+MEAL+"'||'"+CORNER+"'  \n ");
				sbSql.append(" AND   RECIPE_CD = '"+ RECIPE_CD +"'                                            \n ");
				stmt.execute(sbSql.toString());
		
								
				//3.레시피 마스터 삭제
				sbSql.delete(0, sbSql.length());	
				sbSql.delete(0, sbSql.length());	
				sbSql.append(" DELETE FROM FSH_CYCLE_RECIPE_MST                                        \n ");
				sbSql.append(" WHERE UPJANG    = "+ UPJANG +"                                               \n ");
				sbSql.append(" AND   MENU_CD   = '"+ MENU_DATE +"'|| '-' ||'"+HALL_CD+"'||'"+MEAL+"'||'"+CORNER+"'  \n ");
				sbSql.append(" AND   RECIPE_CD = '"+ RECIPE_CD +"'                                            \n ");
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
