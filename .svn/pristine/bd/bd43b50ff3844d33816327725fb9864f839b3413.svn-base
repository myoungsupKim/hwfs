<%
//////////////////////////////////////////////////////////
//프로그램명: FSM00221P_T001.jsp
//작   성   일: 2008.05.09
//작   성   자: 한화S&C 제조서비스 프로젝트팀 박종세 
//프로그램기능: 코너일괄복사   ::: 식단등록==>일일식단==>코너일괄복사
///////////////////////////////////////////////////////////
%>
<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	Statement stmt             =  null;
	ResultSet rs2 = null; 
	ResultSet rs3 = null;
	try {
		//[코너복사]
		PlatformRequest platformRequest = this.proc_input(request);  
		// 입력 데이터셋리스트
		in_dl = platformRequest.getData().getDataSetList();
		// 입력  변수리스트
		in_vl = platformRequest.getData().getVariableList();
		
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));
		
		String g_EmpNo 		        = in_vl.getString("g_EmpNo");
		String v_UPJANG             = in_vl.getString("UPJANG");
		String v_HALL_CD            = in_vl.getString("HALL_CD");
		String v_TARGET_CORNER_LIST = in_vl.getString("TARGET_CORNER_LIST");
		String v_START_DATE         = in_vl.getString("START_DATE");
		String v_END_DATE           = in_vl.getString("END_DATE");
		String v_BEFORE_RECIPE_CD   = in_vl.getString("BEFORE_RECIPE_CD");
		String v_AFTER_RECIPE_GUBUN = in_vl.getString("AFTER_RECIPE_GUBUN");
		String v_AFTER_RECIPE_CD    = in_vl.getString("AFTER_RECIPE_CD");
		

		stmt 		=  conn.createStatement();
	
						
		StringBuffer sbSql = new StringBuffer();
		
		//변경전 레시피가 속해있는 메뉴코드를 조사한다.
		sbSql.delete(0, sbSql.length());	
		sbSql.append( "SELECT A.MENU_CD  AS MENU_CD    \n");
		sbSql.append( "  FROM FSH_CYCLE_MENU_MST   A   \n");
		sbSql.append( "      ,FSH_CYCLE_RECIPE_MST B   \n");
		sbSql.append( "WHERE A.MENU_CD = B.MENU_CD     \n");
		sbSql.append(" AND    A.UPJANG  = B.UPJANG       \n");
		sbSql.append( "AND   A.UPJANG      = "+  v_UPJANG  +"      \n");
		sbSql.append( "AND   A.HALL_CD     = "+  v_HALL_CD +"       \n");
		sbSql.append( "AND   A.CORNER    IN ("+ v_TARGET_CORNER_LIST  +")   \n");
		sbSql.append( "AND   A.MENU_DATE   BETWEEN '"+ v_START_DATE +"' AND '"+ v_END_DATE +"'  \n");
		sbSql.append( "AND   B.RECIPE_CD   = '"+ v_BEFORE_RECIPE_CD + "'   \n");
		
		pstmt = conn.prepareStatement(sbSql.toString());	
		rs = pstmt.executeQuery(); 			
		
		//해당 하는 메뉴코드에서 
		while(rs.next())
		{
			//변경후 레시피가 포함되어 있는지 데이터 조사
			 sbSql.delete(0, sbSql.length());	
			sbSql.append( "SELECT TO_CHAR(COUNT(*)) as R_COUNTER \n");
			sbSql.append( "FROM   FSH_CYCLE_RECIPE_MST \n");
			sbSql.append( "WHERE  MENU_CD = '"+ rs.getString("MENU_CD")+"' \n");
			sbSql.append( "AND    RECIPE_CD = '"+ v_AFTER_RECIPE_CD +"' \n");
					
			pstmt = conn.prepareStatement(sbSql.toString());	
			
			//다른 레코드셋을 사용.
			rs2 = pstmt.executeQuery(); 	
			rs2.next();
			
			//변경후 레시피가 포함되어 있지 않다면 .... 
			if(rs2.getString("R_COUNTER").equals("0"))
			{ 				
  			    //1. 변경전  레시피 데이터 삭제
			    //1) 레시피 마스터  ---> 레시피 마스터는 UPDATE 한다.(MAIN_DISH_INFO 유지)
			    
			    //2) 레시피 자재
			      sbSql.delete(0, sbSql.length());
			    sbSql.append( "DELETE FROM FSH_CYCLE_RECIPE_ITEM \n");
			    sbSql.append( "WHERE  UPJANG    ="+ v_UPJANG +" \n");
			    sbSql.append( "AND    MENU_CD   ='"+ rs.getString("MENU_CD") +"' \n");
			    sbSql.append( "AND    RECIPE_CD ='"+ v_BEFORE_RECIPE_CD +"' \n");
			      
			    stmt.execute(sbSql.toString());
			    
			    //3) 레시피 조리법
			      sbSql.delete(0, sbSql.length());
			    sbSql.append( "DELETE FROM FSH_CYCLE_RECIPE_CUISINE \n");
			    sbSql.append( "WHERE  UPJANG    ="+ v_UPJANG +" \n ");
			    sbSql.append( "AND    MENU_CD   ='"+ rs.getString("MENU_CD") +"' \n");
			    sbSql.append( "AND    RECIPE_CD ='"+ v_BEFORE_RECIPE_CD +"' \n");		
			  
			    stmt.execute(sbSql.toString());
	
			  
			   //2. 변경후 레시피 데이터 입력
				//1) 레시피 마스터
			    //2) 레시피 자재
			    //3) 레시피 조리법
				    
			   if(v_AFTER_RECIPE_GUBUN.trim().equals("표준"))
			   {
						  sbSql.delete(0, sbSql.length());
						//표준 레시피 마스터를 SELECT 해 온다.
						sbSql.append(" SELECT RECIPE_CD, RECIPE_NAME, RECIPE_CLASS, RECIPE_TYPE, CUISINE_TYPE, MAIN_ITEM_CODE1, MAIN_ITEM_CODE2, COOK_TOOL1, COOK_TOOL2, RECIPE_COLOR, RECIPE_SHAPE, RECIPE_TASTE, RECIPE_FEEL, RECIPE_TEMPER, SPRING_YN, SUMMER_YN, AUTUMN_YN, WINTER_YN, RESP_NUT1, RESP_NUT2, USE_TOOL, VALID_TIME, DISPLAY_METHOD, SALE_UOM, nvl(SALE_PRICE,0) AS SALE_PRICE, nvl(COST_RATE,0) AS COST_RATE, CORE_TEMPER_YN, GOODS_FEATURE, PHF_MGMT_YN, PHF_MGMT1, PHF_MGMT2, PHF_MGMT3, PHF_MGMT4, PHF_MGMT5, COOK_OPRN, PHOTO_PATH, USE_YN, SPHOTO_PATH \n");
						sbSql.append("   FROM FSR_STD_RECIPE_MST \n");
						sbSql.append("  WHERE RECIPE_CD=    '"+ v_AFTER_RECIPE_CD + "' \n");
									
						rs3 = stmt.executeQuery(sbSql.toString());
						rs3.next();
						
				       //1) 레시피 마스터
				          sbSql.delete(0, sbSql.length());
				        sbSql.append("UPDATE FSH_CYCLE_RECIPE_MST \n");
					    sbSql.append("SET \n");
						sbSql.append("RECIPE_CD       ='" + nullToBlank(rs3.getString("RECIPE_CD"))   +"', \n");
						sbSql.append("RECIPE_NAME     ='" + nullToBlank(rs3.getString("RECIPE_NAME"))  +"', \n");
						sbSql.append("RECIPE_CLASS    ='" + nullToBlank(rs3.getString("RECIPE_CLASS"))   +"', \n");
						sbSql.append("RECIPE_TYPE     ='" + nullToBlank(rs3.getString("RECIPE_TYPE"))   +"', \n");
						sbSql.append("CUISINE_TYPE    ='" + nullToBlank(rs3.getString("CUISINE_TYPE")) +"', \n");
						sbSql.append("MAIN_ITEM_CODE1 ='" + nullToBlank(rs3.getString("MAIN_ITEM_CODE1"))  +"', \n");
						sbSql.append("MAIN_ITEM_CODE2 ='" + nullToBlank(rs3.getString("MAIN_ITEM_CODE2"))  +"', \n");
						sbSql.append("COOK_TOOL1      ='" + nullToBlank(rs3.getString("COOK_TOOL1"))   +"', \n");
						sbSql.append("COOK_TOOL2      ='" + nullToBlank(rs3.getString("COOK_TOOL2"))   +"', \n");
						sbSql.append("RECIPE_COLOR    ='" + nullToBlank(rs3.getString("RECIPE_COLOR"))   +"', \n");
						sbSql.append("RECIPE_SHAPE    ='" + nullToBlank(rs3.getString("RECIPE_SHAPE"))   +"', \n");
						sbSql.append("RECIPE_TASTE    ='" + nullToBlank(rs3.getString("RECIPE_TASTE"))   +"', \n");
						sbSql.append("RECIPE_FEEL     ='" + nullToBlank(rs3.getString("RECIPE_FEEL"))   +"', \n");
						sbSql.append("RECIPE_TEMPER   ='" + nullToBlank(rs3.getString("RECIPE_TEMPER"))   +"', \n");
						sbSql.append("SPRING_YN       ='" + nullToBlank(rs3.getString("SPRING_YN"))   +"', \n");
						sbSql.append("SUMMER_YN       ='" + nullToBlank(rs3.getString("SUMMER_YN"))   +"', \n");
						sbSql.append("AUTUMN_YN       ='" + nullToBlank(rs3.getString("AUTUMN_YN"))   +"', \n");
						sbSql.append("WINTER_YN       ='" + nullToBlank(rs3.getString("WINTER_YN"))   +"', \n");
						sbSql.append("RESP_NUT1       ='" + nullToBlank(rs3.getString("RESP_NUT1"))   +"', \n");
						sbSql.append("RESP_NUT2       ='" + nullToBlank(rs3.getString("RESP_NUT2"))   +"', \n");
				        sbSql.append("USE_TOOL        ='" + nullToBlank(rs3.getString("USE_TOOL"))   +"', \n");
						sbSql.append("VALID_TIME      ='" + nullToBlank(rs3.getString("VALID_TIME"))   +"', \n");
						sbSql.append("DISPLAY_METHOD  ='" + nullToBlank(rs3.getString("DISPLAY_METHOD"))   +"', \n");
						sbSql.append("SALE_UOM        ='" + nullToBlank(rs3.getString("SALE_UOM"))   +"', \n");
				     	sbSql.append("SALE_PRICE      =" + nullToBlank(rs3.getString("SALE_PRICE"))   +", \n");
						sbSql.append("COST_RATE       =" + nullToBlank(rs3.getString("COST_RATE"))   +", \n");
						sbSql.append("CORE_TEMPER_YN  ='" + nullToBlank(rs3.getString("CORE_TEMPER_YN"))   +"', \n");
						sbSql.append("GOODS_FEATURE   ='" + nullToBlank(rs3.getString("GOODS_FEATURE"))   +"', \n");
						sbSql.append("PHF_MGMT_YN     ='" + nullToBlank(rs3.getString("PHF_MGMT_YN"))   +"', \n");
						sbSql.append("PHF_MGMT1       ='" + nullToBlank(rs3.getString("PHF_MGMT1"))   +"', \n");
						sbSql.append("PHF_MGMT2       ='" + nullToBlank(rs3.getString("PHF_MGMT2"))   +"', \n");
						sbSql.append("PHF_MGMT3       ='" + nullToBlank(rs3.getString("PHF_MGMT3"))   +"', \n");
						sbSql.append("PHF_MGMT4       ='" + nullToBlank(rs3.getString("PHF_MGMT4"))   +"', \n");
						sbSql.append("PHF_MGMT5       ='" + nullToBlank(rs3.getString("PHF_MGMT5"))   +"', \n");
						sbSql.append("COOK_OPRN       ='" + nullToBlank(rs3.getString("COOK_OPRN"))   +"', \n");
						sbSql.append("PHOTO_PATH      ='" + nullToBlank(rs3.getString("PHOTO_PATH"))   +"', \n");
				       // sbSql.append("PREFER          ='" + rs3.getString("PREFER")   +"', \n");
						sbSql.append("CUSER           = '" + g_EmpNo + "', \n");
						sbSql.append("CDATE           = SYSDATE, \n");
						sbSql.append("UUSER           = '" + g_EmpNo + "', \n");
						sbSql.append("UDATE           = SYSDATE, \n");
						sbSql.append("SPHOTO_PATH     ='" + nullToBlank(rs3.getString("SPHOTO_PATH"))   +"', \n");
						sbSql.append("ATTR01          ='STD:'||TO_CHAR(SYSDATE,'YYYYMMDD') \n");
					    sbSql.append("WHERE  UPJANG    ="+ v_UPJANG +" \n");
					    sbSql.append("AND    MENU_CD   ='"+ rs.getString("MENU_CD") +"' \n");
					    sbSql.append("AND    RECIPE_CD ='"+ v_BEFORE_RECIPE_CD +"' \n");
					    
					    //System.out.println(sbSql.toString());
					    
						stmt.execute(sbSql.toString());	
	        		
	        		   //2) 레시피 자재
        		       sbSql.delete(0, sbSql.length());
	        		sbSql.append("INSERT INTO FSH_CYCLE_RECIPE_ITEM(UPJANG, MENU_CD,          RECIPE_CD, ITEM_CODE, ITEM_SEQ, NEED_QTY, EDIBLE_QTY, CUT_SPEC, CUSER, CDATE, UUSER, UDATE) ");
	        		sbSql.append("SELECT "+ v_UPJANG     +", '"+ rs.getString("MENU_CD") +"', RECIPE_CD, ITEM_CODE, ITEM_SEQ, NEED_QTY, EDIBLE_QTY, CUT_SPEC, '" + g_EmpNo + "', SYSDATE, '" + g_EmpNo + "',SYSDATE ");
	        		sbSql.append("FROM   FSR_STD_RECIPE_ITEM ");
	        		sbSql.append("WHERE  RECIPE_CD ='"+ v_AFTER_RECIPE_CD +"' ");
	            	   stmt.execute(sbSql.toString());	
	        		   
	            	   //3) 레시피 조리법
	        		   sbSql.delete(0, sbSql.length());
	        		sbSql.append("INSERT INTO FSH_CYCLE_RECIPE_CUISINE(UPJANG, MENU_CD,       RECIPE_CD, CUISINE_SEQ, CUISINE_DESC, PHOTO_PATH, SPHOTO_PATH, CUSER, CDATE, UUSER, UDATE) ");
	        		sbSql.append("SELECT "+ v_UPJANG     +", '"+ rs.getString("MENU_CD") +"', RECIPE_CD, CUISINE_SEQ, CUISINE_DESC, PHOTO_PATH, SPHOTO_PATH, '" + g_EmpNo + "', SYSDATE, '" + g_EmpNo + "',SYSDATE ");
	        		sbSql.append("FROM   FSR_STD_RECIPE_CUISINE ");
	        		sbSql.append("WHERE  RECIPE_CD ='"+ v_AFTER_RECIPE_CD +"' ");
	        			stmt.execute(sbSql.toString());	
	           }
			   else  //구분-업장: 업장표준을 선택하였을 경우
			   {
				      sbSql.delete(0, sbSql.length());
					//표준 레시피 마스터를 SELECT 해 온다.
					sbSql.append(" SELECT RECIPE_CD, RECIPE_NAME, RECIPE_CLASS, RECIPE_TYPE, CUISINE_TYPE, MAIN_ITEM_CODE1, MAIN_ITEM_CODE2, COOK_TOOL1, COOK_TOOL2, RECIPE_COLOR, RECIPE_SHAPE, RECIPE_TASTE, RECIPE_FEEL, RECIPE_TEMPER, SPRING_YN, SUMMER_YN, AUTUMN_YN, WINTER_YN, RESP_NUT1, RESP_NUT2, USE_TOOL, VALID_TIME, DISPLAY_METHOD, SALE_UOM, SALE_PRICE, COST_RATE, CORE_TEMPER_YN, GOODS_FEATURE, PHF_MGMT_YN, PHF_MGMT1, PHF_MGMT2, PHF_MGMT3, PHF_MGMT4, PHF_MGMT5, COOK_OPRN, PHOTO_PATH, USE_YN, SPHOTO_PATH \n");
					sbSql.append("   FROM FSR_UPJANG_RECIPE_MST \n");
					sbSql.append("  WHERE RECIPE_CD=    '"+ v_AFTER_RECIPE_CD + "' \n");
								
					rs3 = stmt.executeQuery(sbSql.toString());
					rs3.next();
					
			       //1) 레시피 마스터
			          sbSql.delete(0, sbSql.length());
			        sbSql.append("UPDATE FSH_CYCLE_RECIPE_MST \n");
				    sbSql.append("SET \n");
					sbSql.append("RECIPE_CD       ='" + nullToBlank(rs3.getString("RECIPE_CD"))   +"', \n");
					sbSql.append("RECIPE_NAME     ='" + nullToBlank(rs3.getString("RECIPE_NAME"))  +"', \n");
					sbSql.append("RECIPE_CLASS    ='" + nullToBlank(rs3.getString("RECIPE_CLASS"))   +"', \n");
					sbSql.append("RECIPE_TYPE     ='" + nullToBlank(rs3.getString("RECIPE_TYPE"))   +"', \n");
					sbSql.append("CUISINE_TYPE    ='" + nullToBlank(rs3.getString("CUISINE_TYPE")) +"', \n");
					sbSql.append("MAIN_ITEM_CODE1 ='" + nullToBlank(rs3.getString("MAIN_ITEM_CODE1"))  +"', \n");
					sbSql.append("MAIN_ITEM_CODE2 ='" + nullToBlank(rs3.getString("MAIN_ITEM_CODE2"))  +"', \n");
					sbSql.append("COOK_TOOL1      ='" + nullToBlank(rs3.getString("COOK_TOOL1"))   +"', \n");
					sbSql.append("COOK_TOOL2      ='" + nullToBlank(rs3.getString("COOK_TOOL2"))   +"', \n");
					sbSql.append("RECIPE_COLOR    ='" + nullToBlank(rs3.getString("RECIPE_COLOR"))   +"', \n");
					sbSql.append("RECIPE_SHAPE    ='" + nullToBlank(rs3.getString("RECIPE_SHAPE"))   +"', \n");
					sbSql.append("RECIPE_TASTE    ='" + nullToBlank(rs3.getString("RECIPE_TASTE"))   +"', \n");
					sbSql.append("RECIPE_FEEL     ='" + nullToBlank(rs3.getString("RECIPE_FEEL"))   +"', \n");
					sbSql.append("RECIPE_TEMPER   ='" + nullToBlank(rs3.getString("RECIPE_TEMPER"))   +"', \n");
					sbSql.append("SPRING_YN       ='" + nullToBlank(rs3.getString("SPRING_YN"))   +"', \n");
					sbSql.append("SUMMER_YN       ='" + nullToBlank(rs3.getString("SUMMER_YN"))   +"', \n");
					sbSql.append("AUTUMN_YN       ='" + nullToBlank(rs3.getString("AUTUMN_YN"))   +"', \n");
					sbSql.append("WINTER_YN       ='" + nullToBlank(rs3.getString("WINTER_YN"))   +"', \n");
					sbSql.append("RESP_NUT1       ='" + nullToBlank(rs3.getString("RESP_NUT1"))   +"', \n");
					sbSql.append("RESP_NUT2       ='" + nullToBlank(rs3.getString("RESP_NUT2"))   +"', \n");
			        sbSql.append("USE_TOOL        ='" + nullToBlank(rs3.getString("USE_TOOL"))   +"', \n");
					sbSql.append("VALID_TIME      ='" + nullToBlank(rs3.getString("VALID_TIME"))   +"', \n");
					sbSql.append("DISPLAY_METHOD  ='" + nullToBlank(rs3.getString("DISPLAY_METHOD"))   +"', \n");
					sbSql.append("SALE_UOM        ='" + nullToBlank(rs3.getString("SALE_UOM"))   +"', \n");
			     	sbSql.append("SALE_PRICE      =" + nullToBlank(rs3.getString("SALE_PRICE"))   +", \n");
					sbSql.append("COST_RATE       =" + nullToBlank(rs3.getString("COST_RATE"))   +", \n");
					sbSql.append("CORE_TEMPER_YN  ='" + nullToBlank(rs3.getString("CORE_TEMPER_YN"))   +"', \n");
					sbSql.append("GOODS_FEATURE   ='" + nullToBlank(rs3.getString("GOODS_FEATURE"))   +"', \n");
					sbSql.append("PHF_MGMT_YN     ='" + nullToBlank(rs3.getString("PHF_MGMT_YN"))   +"', \n");
					sbSql.append("PHF_MGMT1       ='" + nullToBlank(rs3.getString("PHF_MGMT1"))   +"', \n");
					sbSql.append("PHF_MGMT2       ='" + nullToBlank(rs3.getString("PHF_MGMT2"))   +"', \n");
					sbSql.append("PHF_MGMT3       ='" + nullToBlank(rs3.getString("PHF_MGMT3"))   +"', \n");
					sbSql.append("PHF_MGMT4       ='" + nullToBlank(rs3.getString("PHF_MGMT4"))   +"', \n");
					sbSql.append("PHF_MGMT5       ='" + nullToBlank(rs3.getString("PHF_MGMT5"))   +"', \n");
					sbSql.append("COOK_OPRN       ='" + nullToBlank(rs3.getString("COOK_OPRN"))   +"', \n");
					sbSql.append("PHOTO_PATH      ='" + nullToBlank(rs3.getString("PHOTO_PATH"))   +"', \n");
			       // sbSql.append("PREFER          ='" + rs3.getString("PREFER")   +"', \n");
					sbSql.append("CUSER           = '" + g_EmpNo + "', \n");
					sbSql.append("CDATE           = SYSDATE, \n");
					sbSql.append("UUSER           = '" + g_EmpNo + "', \n");
					sbSql.append("UDATE           = SYSDATE, \n");
					sbSql.append("SPHOTO_PATH     ='" + nullToBlank(rs3.getString("SPHOTO_PATH"))   +"', \n");
					sbSql.append("ATTR01          ='STD:'||TO_CHAR(SYSDATE,'YYYYMMDD') \n");
				    sbSql.append("WHERE  UPJANG    ="+ v_UPJANG +" \n");
				    sbSql.append("AND    MENU_CD   ='"+ rs.getString("MENU_CD") +"' \n");
				    sbSql.append("AND    RECIPE_CD ='"+ v_BEFORE_RECIPE_CD +"' \n");
				    
					stmt.execute(sbSql.toString());	
       		
		       		   //2) 레시피 자재
		   		       sbSql.delete(0, sbSql.length());
		       		sbSql.append("INSERT INTO FSH_CYCLE_RECIPE_ITEM(UPJANG, MENU_CD,          RECIPE_CD, ITEM_CODE, ITEM_SEQ, NEED_QTY, EDIBLE_QTY, CUT_SPEC, CUSER, CDATE, UUSER, UDATE) ");
		       		sbSql.append("SELECT "+ v_UPJANG     +", '"+ rs.getString("MENU_CD") +"', RECIPE_CD, ITEM_CODE, ITEM_SEQ, NEED_QTY, EDIBLE_QTY, CUT_SPEC, '" + g_EmpNo + "', SYSDATE, '" + g_EmpNo + "',SYSDATE ");
		       		sbSql.append("FROM   FSR_UPJANG_RECIPE_ITEM ");
		       		sbSql.append("WHERE  RECIPE_CD ='"+ v_AFTER_RECIPE_CD +"' ");
		           	   stmt.execute(sbSql.toString());	
		       		   
		           	   //3) 레시피 조리법
		       		   sbSql.delete(0, sbSql.length());
		       		sbSql.append("INSERT INTO FSH_CYCLE_RECIPE_CUISINE(UPJANG, MENU_CD,       RECIPE_CD, CUISINE_SEQ, CUISINE_DESC, PHOTO_PATH, SPHOTO_PATH, CUSER, CDATE, UUSER, UDATE) ");
		       		sbSql.append("SELECT "+ v_UPJANG     +", '"+ rs.getString("MENU_CD") +"', RECIPE_CD, CUISINE_SEQ, CUISINE_DESC, PHOTO_PATH, SPHOTO_PATH, '" + g_EmpNo + "', SYSDATE, '" + g_EmpNo + "',SYSDATE ");
		       		sbSql.append("FROM   FSR_UPJANG_RECIPE_CUISINE ");
		       		sbSql.append("WHERE  RECIPE_CD ='"+ v_AFTER_RECIPE_CD +"' ");
		       			stmt.execute(sbSql.toString());	
			   }
			}
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
		if(rs2 != null) {
			try {
				rs2.close();
			}catch(Exception e) {}
		}
		if(rs3 != null) {
			try {
				rs3.close();
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
