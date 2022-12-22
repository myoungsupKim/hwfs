<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	Statement stmt             =  null;
	try {
		// [식단복사] 레시피미포함
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));
		
		//오토커밋 강제 false
		conn.setAutoCommit(false);
		
		DataSet ds_input  	= in_dl.get("ds_input");
		DataSet ds_list  	= in_dl.get("ds_list");
		DataSet ds_result  	= in_dl.get("ds_Result");
		DataSet ds_ResultDt	= in_dl.get("ds_ResultDt");
		String v_Upjang  	= in_vl.getString("fa_UPJANG");
		String v_Subinv  	= in_vl.getString("fa_SUBINV_CODE");
		String g_EmpNo 		= in_vl.getString("g_EmpNo");
		String v_SaveType 	= in_vl.getString("SaveType");
	
		StringBuffer sbSelSql = new StringBuffer();
		StringBuffer sbInsSql = new StringBuffer();
		
		int nCnt,nARow,nARow2,RowCnt,RecipeCnt;
		String strMsg;
		String strUpjang,strSubinv,strMenuCD;
		String v_CopyType,v_Menudate,v_Meal,v_Corner,v_MenuCD,v_Dt,v_RecipeCD;
		
		DataSet ds_RecipeList;
		
		strUpjang = ds_input.getString(0,"UPJANG");
		strSubinv = ds_input.getString(0,"SUBINV_CODE");
		
		if (v_SaveType.equals("1"))	// 기간복사인 경우 리스트를 조회한다.
		{
			
			String strCopyGubun 	= in_vl.getString("strCopyGubun");
			ds_list.clear();
			
			if (strCopyGubun.equals("0"))		// 0 : 사업장식단
			{
				String strMeal,strCorner,strFromDt,strToDt;
				
				strMeal 	= ds_input.getString(0,"MEAL1");
				strCorner 	= ds_input.getString(0,"CORNER1");
				strFromDt 	= ds_input.getString(0,"MENU_F_DATE1");
				strToDt 	= ds_input.getString(0,"MENU_T_DATE1");
				
				v_Meal  	= in_vl.getString("MEAL");
				v_Corner  	= in_vl.getString("CORNER");
				v_Dt		= in_vl.getString("D_DT");
				
				sbSelSql.delete(0, sbSelSql.length());                                                             
				//sbSelSql.append("-- 사업장식단   기간복사리스                                                             			 						\n");
				sbSelSql.append("SELECT UPJANG                                                                			\n");
				sbSelSql.append("       , MENU_CD                                                             			\n");
				sbSelSql.append("       , TO_CHAR(TO_DATE(MENU_DATE,'yyyymmdd') + " + v_Dt + ",'yyyymmdd') AS MENU_DATE \n");
				sbSelSql.append("       , '" + v_Meal + "' AS MEAL                                                      \n");
				sbSelSql.append("       , '" + v_Corner + "' AS CORNER                                               	\n");
				sbSelSql.append("       , '" + strCopyGubun + "' AS COPY_TYPE                                           \n");
				sbSelSql.append("  FROM FMM_MENU                                                     					\n");
				sbSelSql.append(" WHERE UPJANG = " + strUpjang + "        --사업장                                      						\n");
				sbSelSql.append("   AND SUBINV_CODE = '" + strSubinv + "'      --식당코드                                     				\n");
				sbSelSql.append("   AND MENU_DATE BETWEEN '" + strFromDt + "' AND '" + strToDt + "' --기간                    		\n");
				sbSelSql.append("   AND MEAL = '" + strMeal + "'      --끼니                                              						\n");
				sbSelSql.append("   AND CORNER = '" + strCorner + "'    --코너                                              					\n");
				sbSelSql.append("ORDER BY  MENU_DATE                                                  					\n");

				//System.out.println(sbSelSql.toString());
				pstmt = conn.prepareStatement(sbSelSql.toString());		
				rs = pstmt.executeQuery(); 
				ds_list = this.makeDataSet(rs,"ds_list");
				
				rs.close();
				pstmt.close();
			}
			else								// 2 : 기간표준식단
			{
				String strMenuClass,strCostType,strMenuType,strMeal,strCorner,strFromDt,strToDt;
				
				strMenuClass 	= ds_input.getString(0,"MENU_CLASS");
				strCostType 	= ds_input.getString(0,"COST_TYPE");
				strMenuType 	= ds_input.getString(0,"MENU_TYPE");
				strMeal 	= ds_input.getString(0,"MEAL2");
				strCorner 	= ds_input.getString(0,"CORNER2");
				strFromDt 	= ds_input.getString(0,"MENU_F_DATE2");
				strToDt 	= ds_input.getString(0,"MENU_T_DATE2");
				
				v_Meal  	= in_vl.getString("MEAL");
				v_Corner  	= in_vl.getString("CORNER");
				v_Dt		= in_vl.getString("D_DT");
				
				sbSelSql.delete(0, sbSelSql.length());                                                             
				//sbSelSql.append("-- 기간표준식단     기간복사리스                                                          									\n");
				sbSelSql.append("SELECT '' AS UPJANG                                                         			\n");
				sbSelSql.append("       , TERM_MENU_CD AS MENU_CD                                            			\n");
				sbSelSql.append("       , TO_CHAR(TO_DATE(MENU_DATE,'yyyymmdd') + " + v_Dt + ",'yyyymmdd') AS MENU_DATE	\n");
				sbSelSql.append("       , '" + v_Meal + "' AS MEAL                                                      \n");
				sbSelSql.append("       , '" + v_Corner + "' AS CORNER                                                	\n");
				sbSelSql.append("       , '" + strCopyGubun + "' AS COPY_TYPE                                           \n");
				sbSelSql.append("  FROM FMM_TERM_MENU_MST                                                    			\n");
				sbSelSql.append(" WHERE MENU_CLASS= '" + strMenuClass + "'                                           	\n");
				sbSelSql.append("   AND COST_TYPE = '" + strCostType + "'                                            	\n");
				sbSelSql.append("   AND MENU_TYPE = '" + strMenuType + "'                                           	\n");
				sbSelSql.append("   AND MEAL = '" + strMeal + "'                                                    	\n");
				sbSelSql.append("   AND CORNER = '" + strCorner + "'                                                  	\n");
				sbSelSql.append("   AND MENU_DATE BETWEEN '" + strFromDt + "' AND '" + strToDt + "'                  	\n");
				sbSelSql.append("ORDER BY  MENU_DATE                                                  					\n");
				
				//System.out.println(sbSelSql.toString());
				pstmt = conn.prepareStatement(sbSelSql.toString());		
				rs = pstmt.executeQuery(); 
				ds_list = this.makeDataSet(rs,"ds_list");
				
				rs.close();
				pstmt.close();
			}
		}
		
		RowCnt = ds_list.getRowCount();
		nARow = 0;
		nARow2 = 0;
		
		for ( int i = 0 ; i < RowCnt ; i++ )
		{	
			v_CopyType 	= ds_list.getString(i,"COPY_TYPE");		
			v_Menudate	= ds_list.getString(i,"MENU_DATE");
			v_Meal  	= ds_list.getString(i,"MEAL");
			v_Corner  	= ds_list.getString(i,"CORNER");
			strMenuCD	= ds_list.getString(i,"MENU_CD");
			
			// 1. 식단코드
			// 1.1 먼저 복사할 대상 테이블에 업장,식당,메뉴일자,끼니,코너로 조회해서 생성 여부를 점검한다.
			//   COUNT(*) <= 0일 경우 에러를 리턴한다.   
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
				// 1.2.1 메뉴가 있는경우
				v_MenuCD = rs.getString("MENU_CD");
			}
			else
			{
				v_MenuCD = v_Menudate + "-" + v_Subinv + v_Meal + v_Corner;
				
				// 1.2.2 식단이 없는경우 식단생성
				sbInsSql.delete(0, sbInsSql.length());
				//sbInsSql.append("-- 1.1 식단생성																				\n");
				sbInsSql.append("INSERT INTO FMM_MENU                                                                 		\n");
				sbInsSql.append("(                                                                                    		\n");
				sbInsSql.append("    UPJANG, MENU_CD, MENU_DATE, SUBINV_CODE, MEAL, CORNER, CUSER, CDATE, UUSER, UDATE		\n");                                 
				sbInsSql.append(")                                                                                    		\n");                                 
				sbInsSql.append("VALUES                                                                               		\n");                                 
				sbInsSql.append("(                                                                                    		\n");                
				sbInsSql.append("    " + v_Upjang + "                                                                  		\n");                               
				sbInsSql.append("    , '" + v_MenuCD + "'                                                                	\n");                                 
				sbInsSql.append("    , '" +v_Menudate + "'                                                               	\n");                                 
				sbInsSql.append("    , '" + v_Subinv + "'	                                                             	\n");                                 
				sbInsSql.append("    , '" + v_Meal + "'                                                                    	\n");                                 
				sbInsSql.append("    , '" + v_Corner + "'                                                                	\n");                                 
				sbInsSql.append("    , '" + g_EmpNo + "', SYSDATE                                                        	\n");                                 
				sbInsSql.append("    , '" + g_EmpNo + "', SYSDATE                                                      		\n");
				sbInsSql.append(")                                                                                    		\n");

				//System.out.println(sbInsSql.toString());
				stmt 		=  conn.createStatement();
				stmt.execute(sbInsSql.toString());
				stmt.close();
				
				ds_ResultDt.newRow(nARow2);
				ds_ResultDt.set(nARow2,"MENU_DATE",v_Menudate);
				nARow2 = nARow2 + 1;
			}
			
			rs.close();
			pstmt.close();
			
			// 2. 각 복사원본에 따라 레시피 리스트 조회
			if (v_CopyType.equals("0"))		// 0 : 사업장식단
			{	
				sbSelSql.delete(0, sbSelSql.length());                                                             
				sbSelSql.append("SELECT RECIPE_CD						\n");
				sbSelSql.append("  FROM FMM_RECIPE						\n");
				sbSelSql.append(" WHERE UPJANG = " + strUpjang + "		\n");
				sbSelSql.append("   AND MENU_CD = '" + strMenuCD + "'	\n");

				//System.out.println(sbSelSql.toString());
				pstmt = conn.prepareStatement(sbSelSql.toString());		
				rs = pstmt.executeQuery(); 
				ds_RecipeList = this.makeDataSet(rs,"ds_RecipeList");
			}
			else if (v_CopyType.equals("1"))	// 1 : 한화표준식단
			{
				sbSelSql.delete(0, sbSelSql.length());                                                             
				sbSelSql.append("SELECT RECIPE_CD								\n");
				sbSelSql.append("  FROM FMM_SINGLE_MENU_RECIPE					\n");
				sbSelSql.append(" WHERE SINGLE_MENU_CD = '" + strMenuCD + "'	\n");

				//System.out.println(sbSelSql.toString());
				pstmt = conn.prepareStatement(sbSelSql.toString());		
				rs = pstmt.executeQuery(); 
				ds_RecipeList = this.makeDataSet(rs,"ds_RecipeList");
			}
			else if (v_CopyType.equals("3"))	// 3 : 본사표준식단
			{
				strUpjang = ds_list.getString(i,"UPJANG");
				
				sbSelSql.delete(0, sbSelSql.length());                                                             
				sbSelSql.append("SELECT RECIPE_CD						\n");
				sbSelSql.append("  FROM FMM_STD_MENU_RECIPE				\n");
				sbSelSql.append(" WHERE UPJANG = " + strUpjang + "		\n");
				sbSelSql.append("   AND MENU_CD = '" + strMenuCD + "'	\n");

				//System.out.println(sbSelSql.toString());
				pstmt = conn.prepareStatement(sbSelSql.toString());		
				rs = pstmt.executeQuery(); 
				ds_RecipeList = this.makeDataSet(rs,"ds_RecipeList");
			}
			else								// 2 : 기간표준식단
			{
				sbSelSql.delete(0, sbSelSql.length());                                                             
				sbSelSql.append("SELECT RECIPE_CD								\n");
				sbSelSql.append("  FROM FMM_TERM_MENU_RECIPE					\n");
				sbSelSql.append(" WHERE TERM_MENU_CD = '" + strMenuCD + "'		\n");

				//System.out.println(sbSelSql.toString());
				pstmt = conn.prepareStatement(sbSelSql.toString());		
				rs = pstmt.executeQuery(); 
				ds_RecipeList = this.makeDataSet(rs,"ds_RecipeList");
			}
			
			rs.close();
			pstmt.close();
			
			RecipeCnt = ds_RecipeList.getRowCount();
			
			for ( int j = 0 ; j < RecipeCnt ; j++ )
			{
				
				v_RecipeCD = ds_RecipeList.getString(j,"RECIPE_CD");	
				
				// 3. 중복레시피
				sbSelSql.delete(0, sbSelSql.length());
				//sbSelSql.append("-- 3. 중복레시피에 대해서는 아래 SQL을 이용하여 팝업창을 띄워준다.                                                        				\n");
				sbSelSql.append("SELECT                                                                                                                     \n");
				sbSelSql.append("      A.MENU_DATE       --제공일                                                                                           												\n");
				sbSelSql.append("      ,(SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0023' AND CODE = A.MEAL) MEAL_NAME --끼니명            		\n");
				sbSelSql.append("      ,(SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0022' AND CODE = A.CORNER) CORNER_NAME --코너명        		\n");
				sbSelSql.append("      ,B.RECIPE_CD                                                                                                         \n");
				sbSelSql.append("      ,B.RECIPE_NAME                                                                                                       \n");
				sbSelSql.append("  FROM FMM_MENU A                                                                                                 			\n");
				sbSelSql.append("      ,FMM_RECIPE B                                                                                               			\n");
				sbSelSql.append(" WHERE A.UPJANG = B.UPJANG                                                                                                 \n");
				sbSelSql.append("   AND A.MENU_CD = B.MENU_CD                                                                                               \n");
				sbSelSql.append("   AND A.UPJANG = " + v_Upjang + " --하단의 복사될 사업장                                                                  										\n");
				sbSelSql.append("   AND A.MENU_CD = '" + v_MenuCD + "' --위 1번에서 불러온 MENU_CD                                                         		\n");
				sbSelSql.append("   AND B.RECIPE_CD  = '" + v_RecipeCD + "'                                                                                 \n");
				
				//System.out.println(sbSelSql.toString());
				pstmt = conn.prepareStatement(sbSelSql.toString());
				rs = pstmt.executeQuery();
				
				if(rs.next())	// 3.1 중복레시피
				{ 
					ds_result.newRow(nARow);
					ds_result.set(nARow,"MENU_DATE",rs.getString("MENU_DATE"));
					ds_result.set(nARow,"MEAL_NAME",rs.getString("MEAL_NAME"));
					ds_result.set(nARow,"CORNER_NAME",rs.getString("CORNER_NAME"));
					ds_result.set(nARow,"RECIPE_CD",rs.getString("RECIPE_CD"));
					ds_result.set(nARow,"RECIPE_NAME",rs.getString("RECIPE_NAME"));
					
					nARow = nARow + 1;
					
					rs.close();
					pstmt.close();
				}
				else			// 3.2 없는경우 inert
				{
					rs.close();
					pstmt.close();
					
					// 4. 사업장표준레시피 체크
					sbSelSql.delete(0, sbSelSql.length());
					sbSelSql.append("SELECT A.UPJANG, A.SUBINV_CLASS, A.RECIPE_CD	\n");
					sbSelSql.append("  FROM FMM_UPJANG_RECIPE_MST A             	\n");
					sbSelSql.append("     , FMS_SUBINVENTORY B                   	\n");
					sbSelSql.append(" WHERE A.SUBINV_CLASS = B.SUBINV_CLASS      	\n");
					sbSelSql.append("   AND B.SUBINV_CODE = '" + v_Subinv + "'   	\n");
					sbSelSql.append("   AND A.UPJANG = " + v_Upjang + "           	\n");
					sbSelSql.append("   AND A.RECIPE_CD = '" + v_RecipeCD + "'     	\n");

					//System.out.println(sbSelSql.toString());
					pstmt = conn.prepareStatement(sbSelSql.toString());
					rs = pstmt.executeQuery();
					
					if(rs.next())	// 4.1 표준레시피 복사
					{
						//  5.1 레시피복사	
						sbInsSql.delete(0, sbInsSql.length());
						//sbInsSql.append("-- 5.1 레시피 마스터 복사																													\n");
						sbInsSql.append("INSERT INTO FMM_RECIPE																													\n");
						sbInsSql.append("(                                                                                                                                		\n");
						sbInsSql.append("  UPJANG, MENU_CD, RECIPE_CD, RECIPE_NAME, SUBINV_CLASS, RECIPE_CLASS, RECIPE_TYPE, CUISINE_TYPE, MAIN_ITEM_CODE1, MAIN_ITEM_CODE2,	\n");
						sbInsSql.append("  COOK_TOOL1, COOK_TOOL2, RECIPE_COLOR, RECIPE_SHAPE, RECIPE_TASTE, RECIPE_FEEL, RECIPE_TEMPER,                                    	\n");
						sbInsSql.append("  SPRING_YN, SUMMER_YN, AUTUMN_YN, WINTER_YN, RESP_NUT1, RESP_NUT2, USE_TOOL, VALID_TIME, DISPLAY_METHOD, SALE_UOM, SALE_PRICE,    	\n");
						sbInsSql.append("  COST_RATE, CORE_TEMPER_YN, GOODS_FEATURE,                                                                                        	\n");
						sbInsSql.append("  PHF_MGMT_YN, PHF, PHF_MGMT1, PHF_MGMT2, PHF_MGMT3, PHF_MGMT4, PHF_MGMT5, COOK_OPRN, PHOTO_PATH, SPHOTO_PATH,                     	\n");                                
		        		sbInsSql.append("  ATTR01, ATTR02, ATTR03, ATTR04, ATTR05, ATTR06, ATTR07, ATTR08, ATTR09, ATTR10, CUSER, CDATE, UUSER, UDATE                       	\n");       
		        		sbInsSql.append(")                                                                                                                                		\n");
						sbInsSql.append("SELECT " + v_Upjang + " -- 하단의 복사될 사업장																								\n");
						sbInsSql.append("      ,'" + v_MenuCD + "' -- 위 1번에서 불러온 MENU_CD																						\n");
						sbInsSql.append("      , RECIPE_CD, RECIPE_NAME																											\n");
						sbInsSql.append("      , SUBINV_CLASS 																													\n");
						sbInsSql.append("      , RECIPE_CLASS, RECIPE_TYPE, CUISINE_TYPE, MAIN_ITEM_CODE1, MAIN_ITEM_CODE2,         											\n");
						sbInsSql.append("		COOK_TOOL1, COOK_TOOL2, RECIPE_COLOR, RECIPE_SHAPE, RECIPE_TASTE, RECIPE_FEEL, RECIPE_TEMPER,                             		\n");
						sbInsSql.append("		SPRING_YN, SUMMER_YN, AUTUMN_YN, WINTER_YN, RESP_NUT1, RESP_NUT2, USE_TOOL, VALID_TIME, DISPLAY_METHOD, SALE_UOM, SALE_PRICE,	\n");
						sbInsSql.append("		COST_RATE, CORE_TEMPER_YN, GOODS_FEATURE,                                                                                    	\n");
						sbInsSql.append("		PHF_MGMT_YN, PHF, PHF_MGMT1, PHF_MGMT2, PHF_MGMT3, PHF_MGMT4, PHF_MGMT5, COOK_OPRN, PHOTO_PATH, SPHOTO_PATH,                 	\n");
						sbInsSql.append("		ATTR01, ATTR02, ATTR03, ATTR04, ATTR05, ATTR06, ATTR07, ATTR08, ATTR09, ATTR10                           						\n");
						sbInsSql.append("		, '" + g_EmpNo + "' CUSER, SYSDATE CDATE																						\n");
						sbInsSql.append("		, '" + g_EmpNo + "' UUSER, SYSDATE UDATE																						\n");
						sbInsSql.append("  FROM FMM_UPJANG_RECIPE_MST A             																							\n");
						sbInsSql.append(" WHERE A.SUBINV_CLASS = (SELECT SUBINV_CLASS FROM FMS_SUBINVENTORY WHERE SUBINV_CODE = '" + v_Subinv + "')								\n");
						sbInsSql.append("   AND A.UPJANG = " + v_Upjang + "           																							\n");
						sbInsSql.append("   AND A.RECIPE_CD = '" + v_RecipeCD + "'     																							\n");
						
						//System.out.println(sbInsSql.toString());
						stmt 		=  conn.createStatement();
						stmt.execute(sbInsSql.toString());
						stmt.close();
						
						//  5.2 레시피자재 복사 
						sbInsSql.delete(0, sbInsSql.length());
						//sbInsSql.append("-- 5.2 레시피 자재 복사\n");
						sbInsSql.append("INSERT INTO FMM_RECIPE_ITEM																										\n");
						sbInsSql.append("( 																																	\n");
						sbInsSql.append("    UPJANG, MENU_CD, RECIPE_CD, ITEM_CODE, ITEM_SEQ, NEED_QTY, EDIBLE_QTY, CUT_SPEC, NEED_DATE, UNIT_PRICE, OP_RATE, OP_PRICE, ATTR01, CUSER, UUSER	\n");
						sbInsSql.append(")																																	\n");
						sbInsSql.append("SELECT " + v_Upjang + " UPJANG \n");
						sbInsSql.append("     , '" + v_MenuCD + "' MENU_CD \n");
						sbInsSql.append("     , A.RECIPE_CD \n");
						sbInsSql.append("     , A.ITEM_CODE \n");
						sbInsSql.append("     , A.ITEM_SEQ \n");
						sbInsSql.append("     , A.NEED_QTY \n");
						sbInsSql.append("     , A.EDIBLE_QTY \n");
						sbInsSql.append("     , A.CUT_SPEC \n");
/*
						sbInsSql.append("     , TO_CHAR(TO_DATE('" + v_Menudate + "','YYYYMMDD') - NVL(( \n");
						sbInsSql.append("            SELECT D_DAYS \n");
						sbInsSql.append("              FROM FMS_MEAL_CORNER \n");
						sbInsSql.append("             WHERE SUBINV_CODE = '" + v_Subinv + "' \n");
						sbInsSql.append("               AND MEAL = '" + v_Meal + "' \n");
						sbInsSql.append("               AND CORNER = '" + v_Corner + "' \n");
						sbInsSql.append("       ),1),'YYYYMMDD') AS NEED_DATE \n");
*/
/*
						//사업장 레시피의 실제 D-Day(ATTR02 : 구축 시 제공일-입고예정일)가 있는 경우 그 값을 D-Day로
						//없으면 식당 정보의 D-Day를 적용하여 입고예정일(제공일-DDay)을 구한다.
						sbInsSql.append("	, TO_CHAR(TO_DATE('" + v_Menudate + "','YYYYMMDD') \n");
						sbInsSql.append("	          - DECODE(TO_NUMBER(NVL(A.ATTR02,0)) \n");
						sbInsSql.append("	                  ,0 \n");
						sbInsSql.append("	                  , (SELECT SUM(D_DAYS) AS D_DAY \n");
						sbInsSql.append("                          FROM (SELECT 0 AS D_DAYS FROM DUAL \n");
						sbInsSql.append("                                 UNION ALL \n");
						sbInsSql.append("                                SELECT NVL(D_DAYS,0) \n");
						sbInsSql.append("                                  FROM FMS_MEAL_CORNER \n");
						sbInsSql.append("                                 WHERE SUBINV_CODE = '" + v_Subinv + "' \n");
						sbInsSql.append("                                   AND MEAL = '" + v_Meal + "' \n");
						sbInsSql.append("                                   AND CORNER = '" + v_Corner + "' ) \n");
						sbInsSql.append("                       ) \n");
						sbInsSql.append("                     ,TO_NUMBER(NVL(A.ATTR02,0)) \n");
						sbInsSql.append("                     ) \n");
						sbInsSql.append("            , 'YYYYMMDD') AS NEED_DATE \n");
*/
						//법정공휴일 제외
						sbInsSql.append("	, FMP_GETEXCDATE_FUN('" + v_Menudate + "', \n");
						sbInsSql.append("	            DECODE(TO_NUMBER(NVL(A.ATTR02,0)) \n");
						sbInsSql.append("	                  ,0 \n");
						sbInsSql.append("	                  , (SELECT SUM(D_DAYS) AS D_DAY \n");
						sbInsSql.append("                          FROM (SELECT 0 AS D_DAYS FROM DUAL \n");
						sbInsSql.append("                                 UNION ALL \n");
						sbInsSql.append("                                SELECT NVL(D_DAYS,0) \n");
						sbInsSql.append("                                  FROM FMS_MEAL_CORNER \n");
						sbInsSql.append("                                 WHERE SUBINV_CODE = '" + v_Subinv + "' \n");
						sbInsSql.append("                                   AND MEAL = '" + v_Meal + "' \n");
						sbInsSql.append("                                   AND CORNER = '" + v_Corner + "' ) \n");
						sbInsSql.append("                       ) \n");
						sbInsSql.append("                     ,TO_NUMBER(NVL(A.ATTR02,0)) \n");
						sbInsSql.append("                     ) \n");
						sbInsSql.append("                       ) AS NEED_DATE \n");
						sbInsSql.append("     , NVL(B.SALE_PRICE,0) AS UNIT_PRICE \n");
						sbInsSql.append("     , NVL(NVL(F.OP_RATE, G.OP_RATE), 0) AS OP_RATE \n");
						sbInsSql.append("     , CASE WHEN F.OP_PRICE IS NOT NULL OR F.OP_RATE IS NOT NULL \n");
						sbInsSql.append("            THEN DECODE(SIGN(NVL(F.OP_PRICE,0) ),0, SCC_CEIL(B.SALE_PRICE + (B.SALE_PRICE * NVL(F.OP_RATE,0) / 100),F.CEIL_VAL), F.OP_PRICE) \n");
						sbInsSql.append("            WHEN G.OP_PRICE IS NOT NULL OR G.OP_RATE IS NOT NULL \n");
						sbInsSql.append("            THEN DECODE(SIGN(NVL(G.OP_PRICE,0) ),0, SCC_CEIL(B.SALE_PRICE + (B.SALE_PRICE * NVL(G.OP_RATE,0) / 100),G.CEIL_VAL), G.OP_PRICE) \n");
						sbInsSql.append("       ELSE B.SALE_PRICE END AS OP_PRICE --운영단가(1인원가) \n");
						sbInsSql.append("     , DECODE(A.ATTR01,'Y','Y','N') AS ATTR01 \n");
						sbInsSql.append("     , '" + g_EmpNo + "' \n");
						sbInsSql.append("     , '" + g_EmpNo + "' \n");
						sbInsSql.append("  FROM (SELECT A.ITEM_CODE, A.SALE_PRICE \n");
						sbInsSql.append("         FROM HLDC_PO_CONTRACT_FSALE A, HLDC_ST_UPJANG B \n");
						sbInsSql.append("        WHERE A.UPJANG = B.AP_UNITPRICE_UPJANG \n");
						sbInsSql.append("          AND B.UPJANG = " + v_Upjang + " \n");
						sbInsSql.append("          AND A.ITEM_CODE > ' ' \n");
						sbInsSql.append("          AND '" + v_Menudate + "' BETWEEN A.CONTRACT_START AND NVL(A.CONTRACT_END,'99999999') \n");
						sbInsSql.append("          AND A.SALE_PRICE > 0 \n");
						sbInsSql.append("          AND A.USE_YN = 'Y' \n");
						sbInsSql.append("       ----------- \n");
						sbInsSql.append("        UNION ALL \n");
						sbInsSql.append("       ----------- \n");
						sbInsSql.append("       SELECT A.ITEM_CODE, A.SALE_PRICE \n");
						sbInsSql.append("         FROM FMP_OTCUST_PRICE_AVA_V A \n");
						sbInsSql.append("            ,(SELECT UPJANG, ITEM_CODE, MAX(SDATE) AS SDATE \n");
						sbInsSql.append("                FROM FMP_OTCUST_PRICE_AVA_V \n");
						sbInsSql.append("               WHERE UPJANG = (SELECT OTCUST_PRICE_UPJANG FROM FMS_UPJANG WHERE UPJANG = " + v_Upjang + ") \n");
						sbInsSql.append("                 AND SDATE <= '" + v_Menudate + "' \n");
						sbInsSql.append("               GROUP BY UPJANG, ITEM_CODE) B \n");
						sbInsSql.append("        WHERE A.UPJANG = B.UPJANG \n");
						sbInsSql.append("          AND A.SDATE = B.SDATE \n");
						sbInsSql.append("          AND A.ITEM_CODE = B.ITEM_CODE \n");
						sbInsSql.append("          AND A.SALE_PRICE > 0 \n");
						sbInsSql.append("          AND A.USE_YN = 'Y' \n");
						sbInsSql.append("      ) B \n");
						sbInsSql.append("      , FMM_UPJANG_RECIPE_ITEM A \n");
						sbInsSql.append("      , FMS_ITEM_V E \n");
						sbInsSql.append("      , ( \n");   
						sbInsSql.append("          SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL \n");
						sbInsSql.append("            FROM FMU_OP_RATE \n");
						sbInsSql.append("           WHERE UPJANG = " + v_Upjang + " \n");
						sbInsSql.append("             AND '" + v_Menudate + "' BETWEEN SDATE AND EDATE \n");
						sbInsSql.append("             AND USE_YN = 'Y' \n");
						sbInsSql.append("             AND ITEM_TYPE = 'M' \n");
						sbInsSql.append("        ) F \n");
						sbInsSql.append("      , ( \n");        
						sbInsSql.append("          SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL \n");
						sbInsSql.append("            FROM FMU_OP_RATE \n");
						sbInsSql.append("           WHERE UPJANG = " + v_Upjang + " \n");
						sbInsSql.append("             AND '" + v_Menudate + "' BETWEEN SDATE AND EDATE \n");
						sbInsSql.append("             AND USE_YN = 'Y' \n");
						sbInsSql.append("             AND ITEM_TYPE = 'C' \n");
						sbInsSql.append("        ) G \n");
						sbInsSql.append(" WHERE A.ITEM_CODE = B.ITEM_CODE(+) \n");
						sbInsSql.append("   AND A.ITEM_CODE = E.ITEM_CODE(+) \n");
						sbInsSql.append("   AND E.ITEM_CODE = F.ITEM_CODE(+) \n");
						sbInsSql.append("   AND E.ITEM_CLASS4 = G.ITEM_CODE(+) \n");
						sbInsSql.append("   AND A.UPJANG = " + v_Upjang + " \n");
						sbInsSql.append("   AND A.RECIPE_CD = '" + v_RecipeCD + "' \n");
						sbInsSql.append("   AND A.SUBINV_CLASS = (SELECT SUBINV_CLASS FROM FMS_SUBINVENTORY WHERE SUBINV_CODE = '" + v_Subinv + "') \n");
						
						stmt 		=  conn.createStatement();
						stmt.execute(sbInsSql.toString());
						stmt.close();
						
						// 5.3 레시피 조리법 복사 		
						sbInsSql.delete(0, sbInsSql.length());
						sbInsSql.append("INSERT INTO FMM_RECIPE_CUISINE                                                                 \n"); 
						sbInsSql.append("(                                                                                              \n"); 
						sbInsSql.append("UPJANG, MENU_CD, RECIPE_CD, CUISINE_SEQ, CUISINE_DESC, PHOTO_PATH, SPHOTO_PATH, REMARK, USE_YN \n"); 
						sbInsSql.append(", ATTR01, ATTR02, ATTR03, ATTR04, ATTR05, ATTR06, ATTR07, ATTR08, ATTR09, ATTR10               \n"); 
						sbInsSql.append(", CUSER, CDATE, UUSER, UDATE                                                                   \n"); 
						sbInsSql.append(")                                                                                             	\n");		
						sbInsSql.append("SELECT   " + v_Upjang + " UPJANG                                                               \n");
						sbInsSql.append("       , '" + v_MenuCD + "' MENU_CD                                                            \n"); 
						sbInsSql.append("       , RECIPE_CD                                                                             \n"); 
						sbInsSql.append("       , CUISINE_SEQ                                                                           \n"); 
						sbInsSql.append("       , CUISINE_DESC                                                                          \n"); 
						sbInsSql.append("       , PHOTO_PATH                                                                            \n"); 
						sbInsSql.append("       , SPHOTO_PATH                                                                           \n"); 
						sbInsSql.append("       , REMARK                                                                                \n"); 
						sbInsSql.append("       , USE_YN                                                                                \n"); 
						sbInsSql.append("       , ATTR01, ATTR02, ATTR03, ATTR04, ATTR05, ATTR06, ATTR07, ATTR08, ATTR09, ATTR10        \n"); 
						sbInsSql.append("       , '" + g_EmpNo + "' CUSER, SYSDATE CDATE                                                \n"); 
						sbInsSql.append("       , '" + g_EmpNo + "' UUSER, SYSDATE UDATE                                                \n"); 
						sbInsSql.append("  FROM FMM_UPJANG_RECIPE_CUISINE A                                                          	\n"); 
						sbInsSql.append(" WHERE A.UPJANG = " + v_Upjang + "                                                           	\n");       
						sbInsSql.append("   AND A.RECIPE_CD = '" + v_RecipeCD + "'                                                 		\n");        
						sbInsSql.append("   AND A.SUBINV_CLASS = (SELECT SUBINV_CLASS FROM FMS_SUBINVENTORY WHERE SUBINV_CODE = '" + v_Subinv + "')\n");
						
						//System.out.println(sbInsSql.toString());
						stmt 		=  conn.createStatement();
						stmt.execute(sbInsSql.toString());
						stmt.close();
						
						// 5.4 레시피특이사항 복사 		
						sbInsSql.delete(0, sbInsSql.length());
						sbInsSql.append("INSERT INTO FMM_RECIPE_SPECIAL                                                                 \n"); 
						sbInsSql.append("(                                                                                              \n"); 
						sbInsSql.append("UPJANG, MENU_CD, RECIPE_CD, SPECIAL_SEQ, SPECIAL_DESC, REMARK, USE_YN						 	\n"); 
						sbInsSql.append(", ATTR01, ATTR02, ATTR03, ATTR04, ATTR05, ATTR06, ATTR07, ATTR08, ATTR09, ATTR10               \n"); 
						sbInsSql.append(", CUSER, CDATE, UUSER, UDATE                                                                   \n"); 
						sbInsSql.append(")                                                                                             	\n");		
						sbInsSql.append("SELECT   " + v_Upjang + " UPJANG                                                               \n");
						sbInsSql.append("       , '" + v_MenuCD + "' MENU_CD                                                            \n"); 
						sbInsSql.append("       , RECIPE_CD                                                                             \n"); 
						sbInsSql.append("       , SPECIAL_SEQ                                                                           \n"); 
						sbInsSql.append("       , SPECIAL_DESC                                                                          \n"); 
						sbInsSql.append("       , REMARK                                                                                \n"); 
						sbInsSql.append("       , USE_YN                                                                                \n"); 
						sbInsSql.append("       , ATTR01, ATTR02, ATTR03, ATTR04, ATTR05, ATTR06, ATTR07, ATTR08, ATTR09, ATTR10        \n"); 
						sbInsSql.append("       , '" + g_EmpNo + "' CUSER, SYSDATE CDATE                                                \n"); 
						sbInsSql.append("       , '" + g_EmpNo + "' UUSER, SYSDATE UDATE                                                \n"); 
						sbInsSql.append("  FROM FMM_UPJANG_RECIPE_SPECIAL A                                                         	\n"); 
						sbInsSql.append(" WHERE A.UPJANG = " + v_Upjang + "                                                           	\n");       
						sbInsSql.append("   AND A.RECIPE_CD = '" + v_RecipeCD + "'                                                 		\n");        
						sbInsSql.append("   AND A.SUBINV_CLASS = (SELECT SUBINV_CLASS FROM FMS_SUBINVENTORY WHERE SUBINV_CODE = '" + v_Subinv + "')\n");
						
						//System.out.println(sbInsSql.toString());
						stmt 		=  conn.createStatement();
						stmt.execute(sbInsSql.toString());
						stmt.close();

						// 5.5 영양정보 복사 		
						sbInsSql.delete(0, sbInsSql.length());
						sbInsSql.append("INSERT INTO FMM_RECIPE_NUT                                                                 	\n"); 
						sbInsSql.append("(                                                                                              \n"); 
						sbInsSql.append("UPJANG, MENU_CD, RECIPE_CD, NUT_SEQ, NUT_DESC, REMARK, USE_YN						 			\n"); 
						sbInsSql.append(", ATTR01, ATTR02, ATTR03, ATTR04, ATTR05, ATTR06, ATTR07, ATTR08, ATTR09, ATTR10               \n"); 
						sbInsSql.append(", CUSER, CDATE, UUSER, UDATE                                                                   \n"); 
						sbInsSql.append(")                                                                                             	\n");		
						sbInsSql.append("SELECT   " + v_Upjang + " UPJANG                                                               \n");
						sbInsSql.append("       , '" + v_MenuCD + "' MENU_CD                                                            \n"); 
						sbInsSql.append("       , RECIPE_CD                                                                             \n"); 
						sbInsSql.append("       , NUT_SEQ                                                                           	\n"); 
						sbInsSql.append("       , NUT_DESC                                                                          	\n"); 
						sbInsSql.append("       , REMARK                                                                                \n"); 
						sbInsSql.append("       , USE_YN                                                                                \n"); 
						sbInsSql.append("       , ATTR01, ATTR02, ATTR03, ATTR04, ATTR05, ATTR06, ATTR07, ATTR08, ATTR09, ATTR10        \n"); 
						sbInsSql.append("       , '" + g_EmpNo + "' CUSER, SYSDATE CDATE                                                \n"); 
						sbInsSql.append("       , '" + g_EmpNo + "' UUSER, SYSDATE UDATE                                                \n"); 
						sbInsSql.append("  FROM FMM_UPJANG_RECIPE_NUT A                                                             	\n"); 
						sbInsSql.append(" WHERE A.UPJANG = " + v_Upjang + "                                                           	\n");       
						sbInsSql.append("   AND A.RECIPE_CD = '" + v_RecipeCD + "'                                                 		\n");        
						sbInsSql.append("   AND A.SUBINV_CLASS = (SELECT SUBINV_CLASS FROM FMS_SUBINVENTORY WHERE SUBINV_CODE = '" + v_Subinv + "')\n");
						
						//System.out.println(sbInsSql.toString());
						stmt 		=  conn.createStatement();
						stmt.execute(sbInsSql.toString());
						stmt.close();
					}
					else
					{
						//System.out.println("v_RecipeCD.length() : " + v_RecipeCD.length());
						if (v_RecipeCD.length() == 6)	// 4.2.1 한화표준 복사
						{
							//  5.1 레시피복사	
							sbInsSql.delete(0, sbInsSql.length());
							//sbInsSql.append("-- 5.1 레시피 마스터 복사																													\n");
							sbInsSql.append("INSERT INTO FMM_RECIPE																													\n");
							sbInsSql.append("(                                                                                                                                		\n");
							sbInsSql.append("  UPJANG, MENU_CD, RECIPE_CD, RECIPE_NAME, SUBINV_CLASS, RECIPE_CLASS, RECIPE_TYPE, CUISINE_TYPE, MAIN_ITEM_CODE1, MAIN_ITEM_CODE2,	\n");
							sbInsSql.append("  COOK_TOOL1, COOK_TOOL2, RECIPE_COLOR, RECIPE_SHAPE, RECIPE_TASTE, RECIPE_FEEL, RECIPE_TEMPER,                                    	\n");
							sbInsSql.append("  SPRING_YN, SUMMER_YN, AUTUMN_YN, WINTER_YN, RESP_NUT1, RESP_NUT2, USE_TOOL, VALID_TIME, DISPLAY_METHOD, SALE_UOM, SALE_PRICE,    	\n");
							sbInsSql.append("  COST_RATE, CORE_TEMPER_YN, GOODS_FEATURE,                                                                                        	\n");
							sbInsSql.append("  PHF_MGMT_YN, PHF, PHF_MGMT1, PHF_MGMT2, PHF_MGMT3, PHF_MGMT4, PHF_MGMT5, COOK_OPRN, PHOTO_PATH, SPHOTO_PATH,                     	\n");                                
			        		sbInsSql.append("  ATTR01, ATTR02, ATTR03, ATTR04, ATTR05, ATTR06, ATTR07, ATTR08, ATTR09, ATTR10, CUSER, CDATE, UUSER, UDATE                       	\n");       
			        		sbInsSql.append(")                                                                                                                                		\n");
							sbInsSql.append("SELECT " + v_Upjang + " -- 하단의 복사될 사업장																								\n");
							sbInsSql.append("      ,'" + v_MenuCD + "' -- 위 1번에서 불러온 MENU_CD																						\n");
							sbInsSql.append("      , RECIPE_CD, RECIPE_NAME																											\n");
							sbInsSql.append("      , (SELECT SUBINV_CLASS FROM FMS_SUBINVENTORY WHERE SUBINV_CODE = '" + v_Subinv + "') SUBINV_CLASS 								\n");
							sbInsSql.append("      , RECIPE_CLASS, RECIPE_TYPE, CUISINE_TYPE, MAIN_ITEM_CODE1, MAIN_ITEM_CODE2,         											\n");
							sbInsSql.append("		COOK_TOOL1, COOK_TOOL2, RECIPE_COLOR, RECIPE_SHAPE, RECIPE_TASTE, RECIPE_FEEL, RECIPE_TEMPER,                             		\n");
							sbInsSql.append("		SPRING_YN, SUMMER_YN, AUTUMN_YN, WINTER_YN, RESP_NUT1, RESP_NUT2, USE_TOOL, VALID_TIME, DISPLAY_METHOD, SALE_UOM, SALE_PRICE,	\n");
							sbInsSql.append("		COST_RATE, CORE_TEMPER_YN, GOODS_FEATURE,                                                                                    	\n");
							sbInsSql.append("		PHF_MGMT_YN, PHF, PHF_MGMT1, PHF_MGMT2, PHF_MGMT3, PHF_MGMT4, PHF_MGMT5, COOK_OPRN, PHOTO_PATH, SPHOTO_PATH,                 	\n");
							sbInsSql.append("		ATTR01, ATTR02, ATTR03, ATTR04, ATTR05, ATTR06, ATTR07, ATTR08, ATTR09, ATTR10                           						\n");
							sbInsSql.append("		, '" + g_EmpNo + "' CUSER, SYSDATE CDATE																						\n");
							sbInsSql.append("		, '" + g_EmpNo + "' UUSER, SYSDATE UDATE																						\n");
							sbInsSql.append("  FROM FMR_STD_RECIPE_MST A                                                                                                 			\n");
							sbInsSql.append(" WHERE A.RECIPE_CD = '" + v_RecipeCD + "'                                                                                            	\n");
							
							//System.out.println(sbInsSql.toString());
							stmt 		=  conn.createStatement();
							stmt.execute(sbInsSql.toString());
							stmt.close();
							
							//  5.2 레시피자재 복사 
							sbInsSql.delete(0, sbInsSql.length());
							//sbInsSql.append("-- 5.2 레시피 자재 복사\n");
							sbInsSql.append("INSERT INTO FMM_RECIPE_ITEM																										\n");
							sbInsSql.append("( 																																	\n");
							sbInsSql.append("    UPJANG, MENU_CD, RECIPE_CD, ITEM_CODE, ITEM_SEQ, NEED_QTY, EDIBLE_QTY, CUT_SPEC, NEED_DATE, UNIT_PRICE, OP_RATE, OP_PRICE, ATTR01, CUSER, UUSER	\n");
							sbInsSql.append(")																																	\n");
							sbInsSql.append("SELECT " + v_Upjang + " UPJANG \n");
							sbInsSql.append("     , '" + v_MenuCD + "' MENU_CD \n");
							sbInsSql.append("     , A.RECIPE_CD \n");
							sbInsSql.append("     , A.ITEM_CODE \n");
							sbInsSql.append("     , A.ITEM_SEQ \n");
							sbInsSql.append("     , A.NEED_QTY \n");
							sbInsSql.append("     , ROUND(A.NEED_QTY * (100 - NVL(( \n");
							sbInsSql.append("            SELECT DISUSE_RATE \n");
							sbInsSql.append("              FROM FMP_ITEM_NUT \n");
							sbInsSql.append("             WHERE UPJANG = (SELECT MAIN_UPJANG FROM FMS_UPJANG WHERE UPJANG = " + v_Upjang + " ) \n");
							sbInsSql.append("               AND ITEM_CODE = A.ITEM_CODE \n");
							sbInsSql.append("             UNION ALL \n");
							sbInsSql.append("           (SELECT DISUSE_RATE \n");
							sbInsSql.append("              FROM FSI_ITEM_NUT \n");
							sbInsSql.append("             WHERE ITEM_CODE = A.ITEM_CODE \n");
							sbInsSql.append("             MINUS \n");
							sbInsSql.append("            SELECT DISUSE_RATE \n");
							sbInsSql.append("              FROM FMP_ITEM_NUT \n");
							sbInsSql.append("             WHERE UPJANG = (SELECT MAIN_UPJANG FROM FMS_UPJANG WHERE UPJANG = " + v_Upjang + " ) \n");
							sbInsSql.append("               AND ITEM_CODE = A.ITEM_CODE \n");
							sbInsSql.append("            ) \n");
							sbInsSql.append("       ),0)) / 100,2) AS EDIBLE_QTY \n");
							sbInsSql.append("     , A.CUT_SPEC \n");
/*
							sbInsSql.append("     , TO_CHAR(TO_DATE('" + v_Menudate + "','YYYYMMDD') - NVL(( \n");
							sbInsSql.append("            SELECT D_DAYS \n");
							sbInsSql.append("              FROM FMS_MEAL_CORNER \n");
							sbInsSql.append("             WHERE SUBINV_CODE = '" + v_Subinv + "' \n");
							sbInsSql.append("               AND MEAL = '" + v_Meal + "' \n");
							sbInsSql.append("               AND CORNER = '" + v_Corner + "' \n");
							sbInsSql.append("       ),1),'YYYYMMDD') AS NEED_DATE \n");
*/
							//법정공휴일 제외
							sbInsSql.append("     , FMP_GETEXCDATE_FUN('" + v_Menudate + "', NVL(( \n");
							sbInsSql.append("            SELECT D_DAYS \n");
							sbInsSql.append("              FROM FMS_MEAL_CORNER \n");
							sbInsSql.append("             WHERE SUBINV_CODE = '" + v_Subinv + "' \n");
							sbInsSql.append("               AND MEAL = '" + v_Meal + "' \n");
							sbInsSql.append("               AND CORNER = '" + v_Corner + "' \n");
							sbInsSql.append("                     ),1)) AS NEED_DATE \n");
							sbInsSql.append("     , NVL(B.SALE_PRICE,0) AS UNIT_PRICE \n");
							sbInsSql.append("     , NVL(NVL(F.OP_RATE, G.OP_RATE), 0) AS OP_RATE \n");
							sbInsSql.append("     , CASE WHEN F.OP_PRICE IS NOT NULL OR F.OP_RATE IS NOT NULL \n");
							sbInsSql.append("            THEN DECODE(SIGN(NVL(F.OP_PRICE,0) ),0, SCC_CEIL(B.SALE_PRICE + (B.SALE_PRICE * NVL(F.OP_RATE,0) / 100),F.CEIL_VAL), F.OP_PRICE) \n");
							sbInsSql.append("            WHEN G.OP_PRICE IS NOT NULL OR G.OP_RATE IS NOT NULL \n");
							sbInsSql.append("            THEN DECODE(SIGN(NVL(G.OP_PRICE,0) ),0, SCC_CEIL(B.SALE_PRICE + (B.SALE_PRICE * NVL(G.OP_RATE,0) / 100),G.CEIL_VAL), G.OP_PRICE) \n");
							sbInsSql.append("       ELSE B.SALE_PRICE END AS OP_PRICE --운영단가(1인원가) \n");
							sbInsSql.append("     , 'N' AS ATTR01 \n");
							sbInsSql.append("     , '" + g_EmpNo + "' \n");
							sbInsSql.append("     , '" + g_EmpNo + "' \n");
							sbInsSql.append("  FROM (SELECT A.ITEM_CODE, A.SALE_PRICE \n");
							sbInsSql.append("          FROM HLDC_PO_CONTRACT_FSALE A, HLDC_ST_UPJANG B \n");
							sbInsSql.append("         WHERE A.UPJANG = B.AP_UNITPRICE_UPJANG \n");
							sbInsSql.append("            AND B.UPJANG = " + v_Upjang + " \n");
							sbInsSql.append("           AND A.ITEM_CODE > ' ' \n");
							sbInsSql.append("           AND '" + v_Menudate + "' BETWEEN A.CONTRACT_START AND NVL(A.CONTRACT_END,'99999999') \n");
							sbInsSql.append("           AND A.SALE_PRICE > 0 \n");
							sbInsSql.append("           AND A.USE_YN = 'Y' \n");
							sbInsSql.append("       ----------- \n");
							sbInsSql.append("        UNION ALL \n");
							sbInsSql.append("       ----------- \n");
							sbInsSql.append("       SELECT A.ITEM_CODE, A.SALE_PRICE \n");
							sbInsSql.append("         FROM FMP_OTCUST_PRICE_AVA_V A \n");
							sbInsSql.append("            ,(SELECT UPJANG, ITEM_CODE, MAX(SDATE) AS SDATE \n");
							sbInsSql.append("                FROM FMP_OTCUST_PRICE_AVA_V \n");
							sbInsSql.append("               WHERE UPJANG = (SELECT OTCUST_PRICE_UPJANG FROM FMS_UPJANG WHERE UPJANG = " + v_Upjang + ") \n");
							sbInsSql.append("                 AND SDATE <= '" + v_Menudate + "' \n");
							sbInsSql.append("               GROUP BY UPJANG, ITEM_CODE) B \n");
							sbInsSql.append("        WHERE A.UPJANG = B.UPJANG \n");
							sbInsSql.append("          AND A.SDATE = B.SDATE \n");
							sbInsSql.append("          AND A.ITEM_CODE = B.ITEM_CODE \n");
							sbInsSql.append("          AND A.SALE_PRICE > 0 \n");
							sbInsSql.append("          AND A.USE_YN = 'Y' \n");
							sbInsSql.append("      ) B \n");
							sbInsSql.append("     ,(SELECT NVL(B.ITEM_CODE_TO,A.ITEM_CODE) AS ITEM_CODE \n");
							sbInsSql.append("             , A.RECIPE_CD \n");
							sbInsSql.append("             , MIN(A.ITEM_SEQ) AS ITEM_SEQ -- ROWNUM \n");
							sbInsSql.append("             , SUM(A.NEED_QTY) AS NEED_QTY \n");
							sbInsSql.append("             , SUM(A.EDIBLE_QTY) AS EDIBLE_QTY \n");
							sbInsSql.append("             , MAX(A.CUT_SPEC) AS CUT_SPEC \n");
							sbInsSql.append("          FROM FMR_STD_RECIPE_ITEM A \n");
							sbInsSql.append("             ,(SELECT * FROM FMM_CHG_ITEM_LIST B WHERE UPJANG = " + v_Upjang + " AND USE_YN = 'Y') B \n");
							sbInsSql.append("         WHERE A.ITEM_CODE = B.ITEM_CODE(+) \n");
							sbInsSql.append("           AND A.RECIPE_CD = '" + v_RecipeCD + "' \n");
							sbInsSql.append("         GROUP BY NVL(B.ITEM_CODE_TO,A.ITEM_CODE), A.RECIPE_CD \n");
							sbInsSql.append("       ) A \n");
							sbInsSql.append("     , FMS_ITEM_V E \n");
							sbInsSql.append("     , ( \n");   
							sbInsSql.append("         SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL \n");
							sbInsSql.append("           FROM FMU_OP_RATE \n");
							sbInsSql.append("          WHERE UPJANG = " + v_Upjang + " \n");
							sbInsSql.append("            AND '" + v_Menudate + "' BETWEEN SDATE AND EDATE \n");
							sbInsSql.append("            AND USE_YN = 'Y' \n");
							sbInsSql.append("            AND ITEM_TYPE = 'M' \n");
							sbInsSql.append("       ) F \n");
							sbInsSql.append("     , ( \n");        
							sbInsSql.append("         SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL \n");
							sbInsSql.append("           FROM FMU_OP_RATE \n");
							sbInsSql.append("          WHERE UPJANG = " + v_Upjang + " \n");
							sbInsSql.append("            AND '" + v_Menudate + "' BETWEEN SDATE AND EDATE \n");
							sbInsSql.append("            AND USE_YN = 'Y' \n");
							sbInsSql.append("            AND ITEM_TYPE = 'C' \n");
							sbInsSql.append("       ) G \n");
							sbInsSql.append(" WHERE A.ITEM_CODE = B.ITEM_CODE(+) \n");
							sbInsSql.append("   AND A.ITEM_CODE = E.ITEM_CODE(+) \n");
							sbInsSql.append("   AND E.ITEM_CODE = F.ITEM_CODE(+) \n");
							sbInsSql.append("   AND E.ITEM_CLASS4 = G.ITEM_CODE(+) \n");
							
							//System.out.println(sbInsSql.toString());
							stmt 		=  conn.createStatement();
							stmt.execute(sbInsSql.toString());
							stmt.close();
							
							// 5.3 레시피 조리법 복사 		
							sbInsSql.delete(0, sbInsSql.length());
							sbInsSql.append("INSERT INTO FMM_RECIPE_CUISINE                                                                 \n"); 
							sbInsSql.append("(                                                                                              \n"); 
							sbInsSql.append("UPJANG, MENU_CD, RECIPE_CD, CUISINE_SEQ, CUISINE_DESC, PHOTO_PATH, SPHOTO_PATH					\n"); 
							sbInsSql.append(", ATTR01, ATTR02, ATTR03, ATTR04, ATTR05, ATTR06, ATTR07, ATTR08, ATTR09, ATTR10               \n"); 
							sbInsSql.append(", CUSER, CDATE, UUSER, UDATE                                                                   \n"); 
							sbInsSql.append(")                                                                                             	\n");		
							sbInsSql.append("SELECT   " + v_Upjang + " UPJANG                                                               \n");
							sbInsSql.append("       , '" + v_MenuCD + "' MENU_CD                                                            \n"); 
							sbInsSql.append("       , RECIPE_CD                                                                          	\n"); 
							sbInsSql.append("       , CUISINE_SEQ                                                                           \n"); 
							sbInsSql.append("       , CUISINE_DESC                                                                          \n"); 
							sbInsSql.append("       , PHOTO_PATH                                                                            \n"); 
							sbInsSql.append("       , SPHOTO_PATH                                                                           \n"); 
							sbInsSql.append("       , ATTR01, ATTR02, ATTR03, ATTR04, ATTR05, ATTR06, ATTR07, ATTR08, ATTR09, ATTR10		\n"); 
							sbInsSql.append("       , '" + g_EmpNo + "' CUSER, SYSDATE CDATE                                                \n"); 
							sbInsSql.append("       , '" + g_EmpNo + "' UUSER, SYSDATE UDATE                                                \n"); 
							sbInsSql.append("  FROM FMR_STD_RECIPE_CUISINE A                                                              	\n");				
							sbInsSql.append(" WHERE A.RECIPE_CD = '" + v_RecipeCD + "'                                                   	\n");
							
							//System.out.println(sbInsSql.toString());
							stmt 		=  conn.createStatement();
							stmt.execute(sbInsSql.toString());
							stmt.close();
							
							// 5.4 레시피특이사항 복사 		
							sbInsSql.delete(0, sbInsSql.length());
							sbInsSql.append("INSERT INTO FMM_RECIPE_SPECIAL                                                                 \n"); 
							sbInsSql.append("(                                                                                              \n"); 
							sbInsSql.append("UPJANG, MENU_CD, RECIPE_CD, SPECIAL_SEQ, SPECIAL_DESC						 					\n"); 
							sbInsSql.append(", ATTR01, ATTR02, ATTR03, ATTR04, ATTR05, ATTR06, ATTR07, ATTR08, ATTR09, ATTR10               \n"); 
							sbInsSql.append(", CUSER, CDATE, UUSER, UDATE                                                                   \n"); 
							sbInsSql.append(")                                                                                             	\n");		
							sbInsSql.append("SELECT   " + v_Upjang + " UPJANG                                                               \n");
							sbInsSql.append("       , '" + v_MenuCD + "' MENU_CD                                                            \n"); 
							sbInsSql.append("       , RECIPE_CD                                                                             \n"); 
							sbInsSql.append("       , SPECIAL_SEQ                                                                           \n"); 
							sbInsSql.append("       , SPECIAL_DESC                                                                          \n"); 
							sbInsSql.append("       , ATTR01, ATTR02, ATTR03, ATTR04, ATTR05, ATTR06, ATTR07, ATTR08, ATTR09, ATTR10		\n"); 
							sbInsSql.append("       , '" + g_EmpNo + "' CUSER, SYSDATE CDATE                                                \n"); 
							sbInsSql.append("       , '" + g_EmpNo + "' UUSER, SYSDATE UDATE                                                \n");
							sbInsSql.append("  FROM FSR_STD_RECIPE_SPECIAL A                                                              	\n");
							sbInsSql.append(" WHERE A.RECIPE_CD = '" + v_RecipeCD + "'                                                   	\n");
							
							//System.out.println(sbInsSql.toString());
							stmt 		=  conn.createStatement();
							stmt.execute(sbInsSql.toString());
							stmt.close();	

							// 5.5 영양정보 복사 		
							sbInsSql.delete(0, sbInsSql.length());
							sbInsSql.append("INSERT INTO FMM_RECIPE_NUT                                                                 	\n"); 
							sbInsSql.append("(                                                                                              \n"); 
							sbInsSql.append("UPJANG, MENU_CD, RECIPE_CD, NUT_SEQ, NUT_DESC										 			\n"); 
							sbInsSql.append(", ATTR01, ATTR02, ATTR03, ATTR04, ATTR05, ATTR06, ATTR07, ATTR08, ATTR09, ATTR10               \n"); 
							sbInsSql.append(", CUSER, CDATE, UUSER, UDATE                                                                   \n"); 
							sbInsSql.append(")                                                                                             	\n");		
							sbInsSql.append("SELECT   " + v_Upjang + " UPJANG                                                               \n");
							sbInsSql.append("       , '" + v_MenuCD + "' MENU_CD                                                            \n"); 
							sbInsSql.append("       , RECIPE_CD                                                                         	\n"); 
							sbInsSql.append("       , NUT_SEQ                                                                           	\n"); 
							sbInsSql.append("       , NUT_DESC                                                                          	\n"); 
							sbInsSql.append("       , ATTR01, ATTR02, ATTR03, ATTR04, ATTR05, ATTR06, ATTR07, ATTR08, ATTR09, ATTR10		\n"); 
							sbInsSql.append("       , '" + g_EmpNo + "' CUSER, SYSDATE CDATE                                                \n"); 
							sbInsSql.append("       , '" + g_EmpNo + "' UUSER, SYSDATE UDATE                                                \n"); 
							sbInsSql.append("  FROM FSR_STD_RECIPE_NUT A                                                              		\n");		
							sbInsSql.append(" WHERE A.RECIPE_CD = '" + v_RecipeCD + "'                                                   	\n");
							
							//System.out.println(sbInsSql.toString());
							stmt 		=  conn.createStatement();
							stmt.execute(sbInsSql.toString());
							stmt.close();
						}
						else							// 4.2.2 본사표준 복사
						{
							//  5.1 레시피복사	
							sbInsSql.delete(0, sbInsSql.length());
							//sbInsSql.append("-- 5.1 레시피 마스터 복사 : 같은 레시피코드로 등록된 데이터를 제외한 레시피에 대해서만 데이터 삽입															\n");
							sbInsSql.append("INSERT INTO FMM_RECIPE																													\n");
							sbInsSql.append("(                                                                                                                                		\n");
							sbInsSql.append("  UPJANG, MENU_CD, RECIPE_CD, RECIPE_NAME, SUBINV_CLASS, RECIPE_CLASS, RECIPE_TYPE, CUISINE_TYPE, MAIN_ITEM_CODE1, MAIN_ITEM_CODE2,	\n");
							sbInsSql.append("  COOK_TOOL1, COOK_TOOL2, RECIPE_COLOR, RECIPE_SHAPE, RECIPE_TASTE, RECIPE_FEEL, RECIPE_TEMPER,                                    	\n");
							sbInsSql.append("  SPRING_YN, SUMMER_YN, AUTUMN_YN, WINTER_YN, RESP_NUT1, RESP_NUT2, USE_TOOL, VALID_TIME, DISPLAY_METHOD, SALE_UOM, SALE_PRICE,    	\n");
							sbInsSql.append("  COST_RATE, CORE_TEMPER_YN, GOODS_FEATURE,                                                                                        	\n");
							sbInsSql.append("  PHF_MGMT_YN, PHF, PHF_MGMT1, PHF_MGMT2, PHF_MGMT3, PHF_MGMT4, PHF_MGMT5, COOK_OPRN, PHOTO_PATH, SPHOTO_PATH,                     	\n");                                
			        		sbInsSql.append("  ATTR01, ATTR02, ATTR03, ATTR04, ATTR05, ATTR06, ATTR07, ATTR08, ATTR09, ATTR10, CUSER, CDATE, UUSER, UDATE                       	\n");       
			        		sbInsSql.append(")                                                                                                                                		\n");
							sbInsSql.append("SELECT " + v_Upjang + " -- 하단의 복사될 사업장																								\n");
							sbInsSql.append("      ,'" + v_MenuCD + "' -- 위 1번에서 불러온 MENU_CD																						\n");
							sbInsSql.append("      , RECIPE_CD, RECIPE_NAME																											\n");
							sbInsSql.append("      , (SELECT SUBINV_CLASS FROM FMS_SUBINVENTORY WHERE SUBINV_CODE = '" + v_Subinv + "') SUBINV_CLASS 								\n");
							sbInsSql.append("      , RECIPE_CLASS, RECIPE_TYPE, CUISINE_TYPE, MAIN_ITEM_CODE1, MAIN_ITEM_CODE2,         											\n");
							sbInsSql.append("		COOK_TOOL1, COOK_TOOL2, RECIPE_COLOR, RECIPE_SHAPE, RECIPE_TASTE, RECIPE_FEEL, RECIPE_TEMPER,                                	\n");
							sbInsSql.append("		SPRING_YN, SUMMER_YN, AUTUMN_YN, WINTER_YN, RESP_NUT1, RESP_NUT2, USE_TOOL, VALID_TIME, DISPLAY_METHOD, SALE_UOM, SALE_PRICE,	\n");
							sbInsSql.append("		COST_RATE, CORE_TEMPER_YN, GOODS_FEATURE,                                                                                    	\n");
							sbInsSql.append("		PHF_MGMT_YN, PHF, PHF_MGMT1, PHF_MGMT2, PHF_MGMT3, PHF_MGMT4, PHF_MGMT5, COOK_OPRN, PHOTO_PATH, SPHOTO_PATH,                 	\n");
							sbInsSql.append("		ATTR01, ATTR02, ATTR03, ATTR04, ATTR05, ATTR06, ATTR07, ATTR08, ATTR09, ATTR10                           						\n");
							sbInsSql.append("		, '" + g_EmpNo + "' CUSER, SYSDATE CDATE																						\n");
							sbInsSql.append("		, '" + g_EmpNo + "' UUSER, SYSDATE UDATE																						\n");
							sbInsSql.append("  FROM FMM_STD_RECIPE_MST A                                                                                                 			\n");
							sbInsSql.append(" WHERE A.RECIPE_CD = '" + v_RecipeCD + "'                                                   											\n");
							sbInsSql.append("   AND UPJANG = (SELECT MAIN_UPJANG FROM FMS_UPJANG WHERE UPJANG = " + v_Upjang + ")													\n");
							
							//System.out.println(sbInsSql.toString());
							stmt 		=  conn.createStatement();
							stmt.execute(sbInsSql.toString());
							stmt.close();
							
							//  5.2 레시피자재 복사 
							sbInsSql.delete(0, sbInsSql.length());
							//sbInsSql.append("-- 5.2 레시피 자재 복사\n");
							sbInsSql.append("INSERT INTO FMM_RECIPE_ITEM																										\n");
							sbInsSql.append("( 																																	\n");
							sbInsSql.append("    UPJANG, MENU_CD, RECIPE_CD, ITEM_CODE, ITEM_SEQ, NEED_QTY, EDIBLE_QTY, CUT_SPEC, NEED_DATE, UNIT_PRICE, OP_RATE, OP_PRICE, ATTR01, CUSER, UUSER	\n");
							sbInsSql.append(")																																	\n");
							sbInsSql.append("SELECT " + v_Upjang + " UPJANG \n");
							sbInsSql.append("     , '" + v_MenuCD + "' MENU_CD \n");
							sbInsSql.append("     , A.RECIPE_CD \n");
							sbInsSql.append("     , A.ITEM_CODE \n");
							sbInsSql.append("     , A.ITEM_SEQ \n");
							sbInsSql.append("     , A.NEED_QTY \n");
							sbInsSql.append("     , A.EDIBLE_QTY \n");
							sbInsSql.append("     , A.CUT_SPEC \n");
/*							
							sbInsSql.append("     , TO_CHAR(TO_DATE('" + v_Menudate + "','YYYYMMDD') - NVL(( \n");
							sbInsSql.append("            SELECT D_DAYS \n");
							sbInsSql.append("              FROM FMS_MEAL_CORNER \n");
							sbInsSql.append("             WHERE SUBINV_CODE = '" + v_Subinv + "' \n");
							sbInsSql.append("               AND MEAL = '" + v_Meal + "' \n");
							sbInsSql.append("               AND CORNER = '" + v_Corner + "' \n");
							sbInsSql.append("       ),1),'YYYYMMDD') AS NEED_DATE \n");
*/
							//법정공휴일 제외
							sbInsSql.append("     , FMP_GETEXCDATE_FUN('" + v_Menudate + "', NVL(( \n");
							sbInsSql.append("            SELECT D_DAYS \n");
							sbInsSql.append("              FROM FMS_MEAL_CORNER \n");
							sbInsSql.append("             WHERE SUBINV_CODE = '" + v_Subinv + "' \n");
							sbInsSql.append("               AND MEAL = '" + v_Meal + "' \n");
							sbInsSql.append("               AND CORNER = '" + v_Corner + "' \n");
							sbInsSql.append("                     ),1)) AS NEED_DATE \n");
							sbInsSql.append("     , NVL(B.SALE_PRICE,0) AS UNIT_PRICE \n");
							sbInsSql.append("     , NVL(NVL(F.OP_RATE, G.OP_RATE), 0) AS OP_RATE \n");
							sbInsSql.append("     , CASE WHEN F.OP_PRICE IS NOT NULL OR F.OP_RATE IS NOT NULL \n");
							sbInsSql.append("            THEN DECODE(SIGN(NVL(F.OP_PRICE,0) ),0, SCC_CEIL(B.SALE_PRICE + (B.SALE_PRICE * NVL(F.OP_RATE,0) / 100),F.CEIL_VAL), F.OP_PRICE) \n");
							sbInsSql.append("            WHEN G.OP_PRICE IS NOT NULL OR G.OP_RATE IS NOT NULL \n");
							sbInsSql.append("            THEN DECODE(SIGN(NVL(G.OP_PRICE,0) ),0, SCC_CEIL(B.SALE_PRICE + (B.SALE_PRICE * NVL(G.OP_RATE,0) / 100),G.CEIL_VAL), G.OP_PRICE) \n");
							sbInsSql.append("       ELSE B.SALE_PRICE END AS OP_PRICE --운영단가(1인원가) \n");
							sbInsSql.append("     , 'N' AS ATTR01 \n");
							sbInsSql.append("     , '" + g_EmpNo + "' \n");
							sbInsSql.append("     , '" + g_EmpNo + "' \n");
							sbInsSql.append("  FROM (SELECT A.ITEM_CODE, A.SALE_PRICE \n");
							sbInsSql.append("          FROM HLDC_PO_CONTRACT_FSALE A, HLDC_ST_UPJANG B \n");
							sbInsSql.append("         WHERE A.UPJANG = B.AP_UNITPRICE_UPJANG \n");
							sbInsSql.append("           AND B.UPJANG = " + v_Upjang + " \n");
							sbInsSql.append("           AND A.ITEM_CODE > ' ' \n");
							sbInsSql.append("           AND '" + v_Menudate + "' BETWEEN A.CONTRACT_START AND NVL(A.CONTRACT_END,'99999999') \n");
							sbInsSql.append("           AND A.SALE_PRICE > 0 \n");
							sbInsSql.append("           AND A.USE_YN = 'Y' \n");
							sbInsSql.append("       ----------- \n");
							sbInsSql.append("        UNION ALL \n");
							sbInsSql.append("       ----------- \n");
							sbInsSql.append("       SELECT A.ITEM_CODE, A.SALE_PRICE \n");
							sbInsSql.append("         FROM FMP_OTCUST_PRICE_AVA_V A \n");
							sbInsSql.append("            ,(SELECT UPJANG, ITEM_CODE, MAX(SDATE) AS SDATE \n");
							sbInsSql.append("                FROM FMP_OTCUST_PRICE_AVA_V \n");
							sbInsSql.append("               WHERE UPJANG = (SELECT OTCUST_PRICE_UPJANG FROM FMS_UPJANG WHERE UPJANG = " + v_Upjang + ") \n");
							sbInsSql.append("                 AND SDATE <= '" + v_Menudate + "' \n");
							sbInsSql.append("               GROUP BY UPJANG, ITEM_CODE) B \n");
							sbInsSql.append("        WHERE A.UPJANG = B.UPJANG \n");
							sbInsSql.append("          AND A.SDATE = B.SDATE \n");
							sbInsSql.append("          AND A.ITEM_CODE = B.ITEM_CODE \n");
							sbInsSql.append("          AND A.SALE_PRICE > 0 \n");
							sbInsSql.append("          AND A.USE_YN = 'Y' \n");
							sbInsSql.append("      ) B \n");
							sbInsSql.append("     , FMM_STD_RECIPE_ITEM A \n");
							sbInsSql.append("     , FMS_ITEM_V E \n");
							sbInsSql.append("     , ( \n");   
							sbInsSql.append("         SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL \n");
							sbInsSql.append("           FROM FMU_OP_RATE \n");
							sbInsSql.append("          WHERE UPJANG = " + v_Upjang + " \n");
							sbInsSql.append("            AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN SDATE AND EDATE \n");
							sbInsSql.append("            AND USE_YN = 'Y' \n");
							sbInsSql.append("            AND ITEM_TYPE = 'M' \n");
							sbInsSql.append("       ) F \n");
							sbInsSql.append("     , ( \n");        
							sbInsSql.append("         SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL \n");
							sbInsSql.append("           FROM FMU_OP_RATE \n");
							sbInsSql.append("          WHERE UPJANG = " + v_Upjang + " \n");
							sbInsSql.append("            AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN SDATE AND EDATE \n");
							sbInsSql.append("            AND USE_YN = 'Y' \n");
							sbInsSql.append("            AND ITEM_TYPE = 'C' \n");
							sbInsSql.append("       ) G \n");
							sbInsSql.append(" WHERE A.ITEM_CODE = B.ITEM_CODE(+) \n");
							sbInsSql.append("   AND A.ITEM_CODE = E.ITEM_CODE(+) \n");
							sbInsSql.append("   AND E.ITEM_CODE = F.ITEM_CODE(+) \n");
							sbInsSql.append("   AND E.ITEM_CLASS4 = G.ITEM_CODE(+) \n");
							sbInsSql.append("   AND A.RECIPE_CD = '" + v_RecipeCD + "' \n");
							sbInsSql.append("   AND A.UPJANG = (SELECT MAIN_UPJANG FROM FMS_UPJANG WHERE UPJANG = " + v_Upjang + ") \n");
							
							//System.out.println(sbInsSql.toString());
							stmt 		=  conn.createStatement();
							stmt.execute(sbInsSql.toString());
							stmt.close();
							
							// 5.3 레시피 조리법 복사 		
							sbInsSql.delete(0, sbInsSql.length());
							sbInsSql.append("INSERT INTO FMM_RECIPE_CUISINE                                                                 \n"); 
							sbInsSql.append("(                                                                                              \n"); 
							sbInsSql.append("UPJANG, MENU_CD, RECIPE_CD, CUISINE_SEQ, CUISINE_DESC, PHOTO_PATH, SPHOTO_PATH, REMARK, USE_YN \n"); 
							sbInsSql.append(", ATTR01, ATTR02, ATTR03, ATTR04, ATTR05, ATTR06, ATTR07, ATTR08, ATTR09, ATTR10               \n"); 
							sbInsSql.append(", CUSER, CDATE, UUSER, UDATE                                                                   \n"); 
							sbInsSql.append(")                                                                                             	\n");		
							sbInsSql.append("SELECT   " + v_Upjang + " UPJANG                                                               \n");
							sbInsSql.append("       , '" + v_MenuCD + "' MENU_CD                                                            \n"); 
							sbInsSql.append("       , RECIPE_CD                                                                         	\n"); 
							sbInsSql.append("       , CUISINE_SEQ                                                                           \n"); 
							sbInsSql.append("       , CUISINE_DESC                                                                          \n"); 
							sbInsSql.append("       , PHOTO_PATH                                                                            \n"); 
							sbInsSql.append("       , SPHOTO_PATH                                                                           \n"); 
							sbInsSql.append("       , REMARK                                                                            	\n"); 
							sbInsSql.append("       , USE_YN                                                                           		\n"); 
							sbInsSql.append("       , ATTR01, ATTR02, ATTR03, ATTR04, ATTR05, ATTR06, ATTR07, ATTR08, ATTR09, ATTR10       	\n"); 
							sbInsSql.append("       , '" + g_EmpNo + "' CUSER, SYSDATE CDATE                                                \n"); 
							sbInsSql.append("       , '" + g_EmpNo + "' UUSER, SYSDATE UDATE                                                \n"); 
							sbInsSql.append("  FROM FMM_STD_RECIPE_CUISINE A                                                          		\n");		
							sbInsSql.append(" WHERE A.RECIPE_CD = '" + v_RecipeCD + "'                                                   											\n");
							sbInsSql.append("   AND UPJANG = (SELECT MAIN_UPJANG FROM FMS_UPJANG WHERE UPJANG = " + v_Upjang + ")													\n");
							
							//System.out.println(sbInsSql.toString());
							stmt 		=  conn.createStatement();
							stmt.execute(sbInsSql.toString());
							stmt.close();
							
							// 5.4 레시피특이사항 복사 		
							sbInsSql.delete(0, sbInsSql.length());
							sbInsSql.append("INSERT INTO FMM_RECIPE_SPECIAL                                                                 \n"); 
							sbInsSql.append("(                                                                                              \n"); 
							sbInsSql.append("UPJANG, MENU_CD, RECIPE_CD, SPECIAL_SEQ, SPECIAL_DESC, REMARK, USE_YN						 	\n"); 
							sbInsSql.append(", ATTR01, ATTR02, ATTR03, ATTR04, ATTR05, ATTR06, ATTR07, ATTR08, ATTR09, ATTR10               \n"); 
							sbInsSql.append(", CUSER, CDATE, UUSER, UDATE                                                                   \n"); 
							sbInsSql.append(")                                                                                             	\n");		
							sbInsSql.append("SELECT   " + v_Upjang + " UPJANG                                                               \n");
							sbInsSql.append("       , '" + v_MenuCD + "' MENU_CD                                                            \n"); 
							sbInsSql.append("       , RECIPE_CD                                                                         	\n"); 
							sbInsSql.append("       , SPECIAL_SEQ                                                                           \n"); 
							sbInsSql.append("       , SPECIAL_DESC                                                                          \n"); 
							sbInsSql.append("       , REMARK                                                                            	\n"); 
							sbInsSql.append("       , USE_YN                                                                           		\n"); 
							sbInsSql.append("       , ATTR01, ATTR02, ATTR03, ATTR04, ATTR05, ATTR06, ATTR07, ATTR08, ATTR09, ATTR10        \n");  
							sbInsSql.append("       , '" + g_EmpNo + "' CUSER, SYSDATE CDATE                                                \n"); 
							sbInsSql.append("       , '" + g_EmpNo + "' UUSER, SYSDATE UDATE                                                \n");
							sbInsSql.append("  FROM FMM_STD_RECIPE_SPECIAL A                                                              	\n");				
							sbInsSql.append(" WHERE A.RECIPE_CD = '" + v_RecipeCD + "'                                                   											\n");
							sbInsSql.append("   AND UPJANG = (SELECT MAIN_UPJANG FROM FMS_UPJANG WHERE UPJANG = " + v_Upjang + ")													\n");
							
							//System.out.println(sbInsSql.toString());
							stmt 		=  conn.createStatement();
							stmt.execute(sbInsSql.toString());
							stmt.close();	

							// 5.5 영양정보 복사 		
							sbInsSql.delete(0, sbInsSql.length());
							sbInsSql.append("INSERT INTO FMM_RECIPE_NUT                                                                 	\n"); 
							sbInsSql.append("(                                                                                              \n"); 
							sbInsSql.append("UPJANG, MENU_CD, RECIPE_CD, NUT_SEQ, NUT_DESC, REMARK, USE_YN						 			\n"); 
							sbInsSql.append(", ATTR01, ATTR02, ATTR03, ATTR04, ATTR05, ATTR06, ATTR07, ATTR08, ATTR09, ATTR10               \n"); 
							sbInsSql.append(", CUSER, CDATE, UUSER, UDATE                                                                   \n"); 
							sbInsSql.append(")                                                                                             	\n");		
							sbInsSql.append("SELECT   " + v_Upjang + " UPJANG                                                               \n");
							sbInsSql.append("       , '" + v_MenuCD + "' MENU_CD                                                            \n"); 
							sbInsSql.append("       , RECIPE_CD                                                                         	\n"); 
							sbInsSql.append("       , NUT_SEQ                                                                           	\n"); 
							sbInsSql.append("       , NUT_DESC                                                                          	\n"); 
							sbInsSql.append("       , REMARK                                                                            	\n"); 
							sbInsSql.append("       , USE_YN                                                                           		\n"); 
							sbInsSql.append("       , ATTR01, ATTR02, ATTR03, ATTR04, ATTR05, ATTR06, ATTR07, ATTR08, ATTR09, ATTR10 		\n");  
							sbInsSql.append("       , '" + g_EmpNo + "' CUSER, SYSDATE CDATE                                                \n"); 
							sbInsSql.append("       , '" + g_EmpNo + "' UUSER, SYSDATE UDATE                                                \n"); 
							sbInsSql.append("  FROM FMM_STD_RECIPE_NUT A                                                              		\n");		
							sbInsSql.append(" WHERE A.RECIPE_CD = '" + v_RecipeCD + "'                                                   											\n");
							sbInsSql.append("   AND UPJANG = (SELECT MAIN_UPJANG FROM FMS_UPJANG WHERE UPJANG = " + v_Upjang + ")													\n");
							
							//System.out.println(sbInsSql.toString());
							stmt 		=  conn.createStatement();
							stmt.execute(sbInsSql.toString());
							stmt.close();
						}
					}
					
					rs.close();
					pstmt.close();
						
				}
			}
			
		}
		
		conn.commit();
		out_dl.add(ds_result);
		out_dl.add(ds_ResultDt);
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