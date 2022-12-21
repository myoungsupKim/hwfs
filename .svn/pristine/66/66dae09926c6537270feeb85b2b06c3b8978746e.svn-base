<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	Statement stmt             =  null;
	try {
		// 예상식수 입력
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));
		
		//오토커밋 강제 false
		conn.setAutoCommit(false);
		
		DataSet ds_chkMenuList	= in_dl.get("ds_chkMenuList");
		String v_Upjang  		= in_vl.getString("fa_UPJANG");
		String v_Subinv  		= in_vl.getString("fa_SUBINV_CODE");
		String g_EmpNo 			= in_vl.getString("g_EmpNo");
		stmt 			=  conn.createStatement();
	
		StringBuffer sbSelSql = new StringBuffer();
		StringBuffer sbInsSql = new StringBuffer();
		
		int RowCnt;
		String v_Menudate,v_Meal,v_Corner,v_ExpectMealQty,v_MenuCD;
		
		RowCnt = ds_chkMenuList.getRowCount();
		
		for ( int i = 0 ; i < RowCnt ; i++ )
		{		
			v_Menudate		= ds_chkMenuList.getString(i,"MENU_DATE");
			v_Meal  		= ds_chkMenuList.getString(i,"MEAL");
			v_Corner  		= ds_chkMenuList.getString(i,"CORNER");
			v_ExpectMealQty	= ds_chkMenuList.getString(i,"EXPECT_MEAL_QTY");
			
			v_MenuCD = v_Menudate + "-" + v_Subinv + v_Meal + v_Corner;
			
			// 1. 식단코드
			// 1.1 먼저 복사할 대상 테이블에 업장,식당,메뉴일자,끼니,코너로 조회해서 생성 여부를 점검한다.  
			sbSelSql.delete(0, sbSelSql.length());
			sbSelSql.append("SELECT MENU_CD 							\n");
			sbSelSql.append("  FROM FMM_MENU 							\n");
			sbSelSql.append(" WHERE UPJANG = " + v_Upjang + " 			\n");
			sbSelSql.append("   AND SUBINV_CODE = '" + v_Subinv + "' 	\n");
			sbSelSql.append("   AND MENU_DATE = '" + v_Menudate + "' 	\n");
			sbSelSql.append("   AND MEAL = '" + v_Meal + "' 			\n");
			sbSelSql.append("   AND CORNER = '" + v_Corner + "' 		\n");
			
			//System.out.println(sbSelSql.toString());
			pstmt = conn.prepareStatement(sbSelSql.toString());
			rs = pstmt.executeQuery(); 		
			
			if(rs.next())	
			{
				// 1.2.1 메뉴가 있는경우 예상식수 업데이트
				sbInsSql.delete(0, sbInsSql.length());
				sbInsSql.append("UPDATE FMM_MENU \n");
				sbInsSql.append("   SET EXPECT_MEAL_QTY = '" + v_ExpectMealQty + "' \n");
				sbInsSql.append(" WHERE UPJANG = " + v_Upjang + " \n");
				sbInsSql.append("   AND MENU_CD = '" + v_MenuCD + "' \n");
				
				//System.out.println(sbInsSql.toString());
				stmt 		=  conn.createStatement();
				stmt.execute(sbInsSql.toString());
				stmt.close();
			}
			else
			{

				// 1.2.2 식단이 없는경우 식단생성
				sbInsSql.delete(0, sbInsSql.length());
				sbInsSql.append("-- 1.1 식단생성																				\n");
				sbInsSql.append("INSERT INTO FMM_MENU                                                                 		\n");
				sbInsSql.append("(                                                                                    		\n");
				sbInsSql.append("    UPJANG, MENU_CD, MENU_DATE, SUBINV_CODE, MEAL, CORNER, EXPECT_MEAL_QTY, SALE_PRICE, CUSER, CDATE, UUSER, UDATE		\n");                         
				sbInsSql.append(")                                                                                    		\n");
				sbInsSql.append("SELECT                                                                               		\n");                                            
				sbInsSql.append("    " + v_Upjang + "                                                                  		\n");                               
				sbInsSql.append("    , '" + v_MenuCD + "'                                                                	\n");                                 
				sbInsSql.append("    , '" + v_Menudate + "'                                                               	\n");                                 
				sbInsSql.append("    , '" + v_Subinv + "'	                                                             	\n");                                 
				sbInsSql.append("    , '" + v_Meal + "'                                                                    	\n");                                 
				sbInsSql.append("    , '" + v_Corner + "'                                                                	\n");
				sbInsSql.append("    , '" + v_ExpectMealQty + "'                                                        	\n");
				sbInsSql.append("    , MEAL_PRICE																			\n");
				sbInsSql.append("    , '" + g_EmpNo + "', SYSDATE                                                        	\n");                                 
				sbInsSql.append("    , '" + g_EmpNo + "', SYSDATE                                                      		\n");
				sbInsSql.append(" FROM FMS_MEAL_CORNER																		\n");
				sbInsSql.append("WHERE SUBINV_CODE = '" + v_Subinv + "' 													\n");
				sbInsSql.append("  AND MEAL = '" + v_Meal + "' 																\n");
				sbInsSql.append("  AND CORNER = '" + v_Corner + "' 															\n");

				//System.out.println(sbInsSql.toString());
				stmt 		=  conn.createStatement();
				stmt.execute(sbInsSql.toString());
				stmt.close();
			}
			
			rs.close();
			pstmt.close();
		}
		
		conn.commit();
		this.setResultMessage(0, "OK",out_vl);
	   
	} catch(Exception ex) {
		conn.rollback();
		//ex.printStackTrace();
		//jsp 로그남기기
		logger.debug(ex.getMessage(), ex);
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