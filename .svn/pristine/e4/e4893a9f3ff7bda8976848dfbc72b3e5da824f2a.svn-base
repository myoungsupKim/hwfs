<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	Statement stmt             =  null;
	try {
		//사업장레시피 일괄 복사
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));
		
		//오토커밋 강제 false
		conn.setAutoCommit(false);
		
		DataSet ds_in  		= in_dl.get("ds_in");
		DataSet ds_Save  	= in_dl.get("ds_Save");
		
		String g_EmpNo 		= in_vl.getString("g_EmpNo");
	
		StringBuffer sbInsSql = new StringBuffer();
		
		int RowCnt;
		String strUpjang,strSubinvClass,strRecipeCD,strSaveGbn,v_Upjang,v_SubinvClass;
		int strRowType;
		
		strUpjang 		= ds_in.getString(0,"UPJANG");
		strSubinvClass 	= ds_in.getString(0,"SUBINV_CLASS");
		
		RowCnt = ds_Save.getRowCount();
		
		for ( int i = 0 ; i < RowCnt ; i++ )
		{	

			strRowType		= ds_Save.getRowType(i);
			  
			
			if (strRowType ==  DataSet.ROW_TYPE_INSERTED)	// Insert인 경우만 실행
			{
				strRecipeCD		= ds_Save.getString(i,"RECIPE_CD");
				strSaveGbn		= ds_Save.getString(i,"SAVE_GBN");
				v_Upjang		= ds_Save.getString(i,"UPJANG");
				v_SubinvClass	= ds_Save.getString(i,"SUBINV_CLASS");
				
				// 1.기존데이터 삭제(삭제후 INSERT)
				//  1-1. 레시피 삭제                                                  
				sbInsSql.delete(0, sbInsSql.length());                                    
				sbInsSql.append("DELETE FROM FMM_UPJANG_RECIPE_MST				\n");                   
				sbInsSql.append(" WHERE UPJANG = " + strUpjang + "           	\n");        
				sbInsSql.append("   AND SUBINV_CLASS = '" + strSubinvClass + "'	\n");
				sbInsSql.append("   AND RECIPE_CD = '" + strRecipeCD + "'     	\n");

				//System.out.println(sbInsSql.toString());
				stmt 		=  conn.createStatement();
				stmt.execute(sbInsSql.toString());
				stmt.close();
				
				//  1-2. 조리법 삭제                                                  
				sbInsSql.delete(0, sbInsSql.length());                                    
				sbInsSql.append("DELETE FROM FMM_UPJANG_RECIPE_CUISINE			\n");                   
				sbInsSql.append(" WHERE UPJANG = " + strUpjang + "           	\n"); 
				sbInsSql.append("   AND SUBINV_CLASS = '" + strSubinvClass + "'	\n");
				sbInsSql.append("   AND RECIPE_CD = '" + strRecipeCD + "'     	\n");

				//System.out.println(sbInsSql.toString());
				stmt 		=  conn.createStatement();
				stmt.execute(sbInsSql.toString());
				stmt.close();
				
				//  1-3. 특이사항  삭제                                                
// 				sbInsSql.delete(0, sbInsSql.length());                                    
// 				sbInsSql.append("DELETE FROM FMM_UPJANG_RECIPE_SPECIAL			\n");                   
// 				sbInsSql.append(" WHERE UPJANG = " + strUpjang + "           	\n");
// 				sbInsSql.append("   AND SUBINV_CLASS = '" + strSubinvClass + "'	\n");
// 				sbInsSql.append("   AND RECIPE_CD = '" + strRecipeCD + "'     	\n");
				
// 				stmt 		=  conn.createStatement();
// 				stmt.execute(sbInsSql.toString());
// 				stmt.close();
				
				//  1-4. 영양정보  삭제                                                
				sbInsSql.delete(0, sbInsSql.length());                                    
				sbInsSql.append("DELETE FROM FMM_UPJANG_RECIPE_NUT				\n");                   
				sbInsSql.append(" WHERE UPJANG = " + strUpjang + "           	\n");
				sbInsSql.append("   AND SUBINV_CLASS = '" + strSubinvClass + "'	\n");
				sbInsSql.append("   AND RECIPE_CD = '" + strRecipeCD + "'     	\n");

				stmt 		=  conn.createStatement();
				stmt.execute(sbInsSql.toString());
				stmt.close();
				
				//  1-5. 식자재  삭제                                                
				sbInsSql.delete(0, sbInsSql.length());                                    
				sbInsSql.append("DELETE FROM FMM_UPJANG_RECIPE_ITEM				\n");                   
				sbInsSql.append(" WHERE UPJANG = " + strUpjang + "           	\n");
				sbInsSql.append("   AND SUBINV_CLASS = '" + strSubinvClass + "'	\n");
				sbInsSql.append("   AND RECIPE_CD = '" + strRecipeCD + "'     	\n");

				stmt 		=  conn.createStatement();
				stmt.execute(sbInsSql.toString());
				stmt.close();
				
				
				// 2. 레시피복사
				sbInsSql.delete(0, sbInsSql.length());                               
				sbInsSql.append("INSERT INTO FMM_UPJANG_RECIPE_MST(             \n");
				sbInsSql.append("       UPJANG                                  \n");
				sbInsSql.append("       , SUBINV_CLASS                          \n");
				sbInsSql.append("       , RECIPE_CD                             \n");
				sbInsSql.append("       , RECIPE_NAME                           \n");
				sbInsSql.append("       , RECIPE_CLASS                          \n");
				sbInsSql.append("       , RECIPE_TYPE                           \n");
				sbInsSql.append("       , CUISINE_TYPE                          \n");
				sbInsSql.append("       , MAIN_ITEM_CODE1                       \n");
				sbInsSql.append("       , MAIN_ITEM_CODE2                       \n");
				sbInsSql.append("       , COOK_TOOL1                            \n");
				sbInsSql.append("       , COOK_TOOL2                            \n");
				sbInsSql.append("       , RECIPE_COLOR                          \n");
				sbInsSql.append("       , RECIPE_SHAPE                          \n");
				sbInsSql.append("       , RECIPE_TASTE                          \n");
				sbInsSql.append("       , RECIPE_FEEL                           \n");
				sbInsSql.append("       , RECIPE_TEMPER                         \n");
				sbInsSql.append("       , SPRING_YN                             \n");
				sbInsSql.append("       , SUMMER_YN                             \n");
				sbInsSql.append("       , AUTUMN_YN                             \n");
				sbInsSql.append("       , WINTER_YN                             \n");
				sbInsSql.append("       , RESP_NUT1                             \n");
				sbInsSql.append("       , RESP_NUT2                             \n");
				sbInsSql.append("       , USE_TOOL                              \n");
				sbInsSql.append("       , VALID_TIME                            \n");
				sbInsSql.append("       , DISPLAY_METHOD                        \n");
				sbInsSql.append("       , SALE_UOM                              \n");
				sbInsSql.append("       , SALE_PRICE                            \n");
				sbInsSql.append("       , COST_RATE                             \n");
				sbInsSql.append("       , CORE_TEMPER_YN                   		\n");
				sbInsSql.append("       , GOODS_FEATURE                         \n");
				sbInsSql.append("       , PHF_MGMT_YN                           \n");
				sbInsSql.append("       , PHF                                   \n");
				sbInsSql.append("       , PHF_MGMT1                             \n");
				sbInsSql.append("       , PHF_MGMT2                             \n");
				sbInsSql.append("       , PHF_MGMT3                             \n");
				sbInsSql.append("       , PHF_MGMT4                             \n");
				sbInsSql.append("       , PHF_MGMT5                             \n");
				sbInsSql.append("       , COOK_OPRN                             \n");
				sbInsSql.append("       , PHOTO_PATH                            \n");
				sbInsSql.append("       , SPHOTO_PATH                           \n");
				sbInsSql.append("       , REMARK                                \n");
				sbInsSql.append("       , USE_YN                                \n");
				sbInsSql.append("       , ATTR01, ATTR02, ATTR03, ATTR04, ATTR05\n");
				sbInsSql.append("       , ATTR06, ATTR07, ATTR08, ATTR09, ATTR10\n");
				sbInsSql.append("       , CUSER, CDATE                          \n");
				sbInsSql.append("       , UUSER, UDATE                          \n");
				sbInsSql.append(" )                                             \n");
				if (strSaveGbn.equals("1"))		// 1 : 한화표준레시피
				{
					sbInsSql.append("SELECT " + strUpjang + " UPJANG                \n");
					sbInsSql.append("       , '" + strSubinvClass + "' SUBINV_CLASS \n");
					sbInsSql.append("       , RECIPE_CD                             \n");
					sbInsSql.append("       , RECIPE_NAME                           \n");
					sbInsSql.append("       , RECIPE_CLASS                          \n");
					sbInsSql.append("       , RECIPE_TYPE                           \n");
					sbInsSql.append("       , CUISINE_TYPE                          \n");
					sbInsSql.append("       , MAIN_ITEM_CODE1                       \n");
					sbInsSql.append("       , MAIN_ITEM_CODE2                       \n");
					sbInsSql.append("       , COOK_TOOL1                            \n");
					sbInsSql.append("       , COOK_TOOL2                            \n");
					sbInsSql.append("       , RECIPE_COLOR                          \n");
					sbInsSql.append("       , RECIPE_SHAPE                          \n");
					sbInsSql.append("       , RECIPE_TASTE                          \n");
					sbInsSql.append("       , RECIPE_FEEL                           \n");
					sbInsSql.append("       , RECIPE_TEMPER                         \n");
					sbInsSql.append("       , SPRING_YN                             \n");
					sbInsSql.append("       , SUMMER_YN                             \n");
					sbInsSql.append("       , AUTUMN_YN                             \n");
					sbInsSql.append("       , WINTER_YN                             \n");
					sbInsSql.append("       , RESP_NUT1                             \n");
					sbInsSql.append("       , RESP_NUT2                             \n");
					sbInsSql.append("       , USE_TOOL                              \n");
					sbInsSql.append("       , VALID_TIME                            \n");
					sbInsSql.append("       , DISPLAY_METHOD                        \n");
					sbInsSql.append("       , SALE_UOM                              \n");
					sbInsSql.append("       , SALE_PRICE                            \n");
					sbInsSql.append("       , COST_RATE                             \n");
					sbInsSql.append("       , CORE_TEMPER_YN						\n");
					sbInsSql.append("       , GOODS_FEATURE                         \n");
					sbInsSql.append("       , PHF_MGMT_YN                           \n");
					sbInsSql.append("       , PHF                                   \n");
					sbInsSql.append("       , PHF_MGMT1                             \n");
					sbInsSql.append("       , PHF_MGMT2                             \n");
					sbInsSql.append("       , PHF_MGMT3                             \n");
					sbInsSql.append("       , PHF_MGMT4                             \n");
					sbInsSql.append("       , PHF_MGMT5                             \n");
					sbInsSql.append("       , COOK_OPRN                             \n");
					sbInsSql.append("       , PHOTO_PATH                            \n");
					sbInsSql.append("       , SPHOTO_PATH                           \n");
					sbInsSql.append("       , '' REMARK                             \n");
					sbInsSql.append("       , USE_YN                                \n");
					sbInsSql.append("       , '', '', '', '', ''                    \n");
					sbInsSql.append("       , '', '', '', '', ''                    \n");
					sbInsSql.append("       , '" + g_EmpNo + "', SYSDATE            \n");
					sbInsSql.append("       , '" + g_EmpNo + "', SYSDATE            \n");
					sbInsSql.append("  FROM FMR_STD_RECIPE_MST A                    \n");
					sbInsSql.append(" WHERE RECIPE_CD = '" + strRecipeCD + "'       \n");
				}
				else if (strSaveGbn.equals("2"))	// 2 : 본사 표준레시피
				{
					sbInsSql.append("SELECT " + strUpjang + " UPJANG                \n");
					sbInsSql.append("       , '" + strSubinvClass + "' SUBINV_CLASS \n");
					sbInsSql.append("       , RECIPE_CD                             \n");
					sbInsSql.append("       , RECIPE_NAME                           \n");
					sbInsSql.append("       , RECIPE_CLASS                          \n");
					sbInsSql.append("       , RECIPE_TYPE                           \n");
					sbInsSql.append("       , CUISINE_TYPE                          \n");
					sbInsSql.append("       , MAIN_ITEM_CODE1                       \n");
					sbInsSql.append("       , MAIN_ITEM_CODE2                       \n");
					sbInsSql.append("       , COOK_TOOL1                            \n");
					sbInsSql.append("       , COOK_TOOL2                            \n");
					sbInsSql.append("       , RECIPE_COLOR                          \n");
					sbInsSql.append("       , RECIPE_SHAPE                          \n");
					sbInsSql.append("       , RECIPE_TASTE                          \n");
					sbInsSql.append("       , RECIPE_FEEL                           \n");
					sbInsSql.append("       , RECIPE_TEMPER                         \n");
					sbInsSql.append("       , SPRING_YN                             \n");
					sbInsSql.append("       , SUMMER_YN                             \n");
					sbInsSql.append("       , AUTUMN_YN                             \n");
					sbInsSql.append("       , WINTER_YN                             \n");
					sbInsSql.append("       , RESP_NUT1                             \n");
					sbInsSql.append("       , RESP_NUT2                             \n");
					sbInsSql.append("       , USE_TOOL                              \n");
					sbInsSql.append("       , VALID_TIME                            \n");
					sbInsSql.append("       , DISPLAY_METHOD                        \n");
					sbInsSql.append("       , SALE_UOM                              \n");
					sbInsSql.append("       , SALE_PRICE                            \n");
					sbInsSql.append("       , COST_RATE                             \n");
					sbInsSql.append("       , CORE_TEMPER_YN						\n");
					sbInsSql.append("       , GOODS_FEATURE                         \n");
					sbInsSql.append("       , PHF_MGMT_YN                           \n");
					sbInsSql.append("       , PHF                                   \n");
					sbInsSql.append("       , PHF_MGMT1                             \n");
					sbInsSql.append("       , PHF_MGMT2                             \n");
					sbInsSql.append("       , PHF_MGMT3                             \n");
					sbInsSql.append("       , PHF_MGMT4                             \n");
					sbInsSql.append("       , PHF_MGMT5                             \n");
					sbInsSql.append("       , COOK_OPRN                             \n");
					sbInsSql.append("       , PHOTO_PATH                            \n");
					sbInsSql.append("       , SPHOTO_PATH                           \n");
					sbInsSql.append("       , REMARK                             	\n");
					sbInsSql.append("       , USE_YN                                \n");
					sbInsSql.append("       , '', '', '', '', ''                    \n");
					sbInsSql.append("       , '', '', '', '', ''                    \n");
					sbInsSql.append("       , '" + g_EmpNo + "', SYSDATE            \n");
					sbInsSql.append("       , '" + g_EmpNo + "', SYSDATE            \n");
					sbInsSql.append("  FROM FMM_STD_RECIPE_MST A                    \n");
					sbInsSql.append(" WHERE UPJANG = " + v_Upjang + "       		\n");
					sbInsSql.append("   AND RECIPE_CD = '" + strRecipeCD + "'		\n");
				}
				else								// 3 : 사업장레시피
				{
					sbInsSql.append("SELECT " + strUpjang + " UPJANG                \n");
					sbInsSql.append("       , '" + strSubinvClass + "' SUBINV_CLASS \n");
					sbInsSql.append("       , RECIPE_CD                             \n");
					sbInsSql.append("       , RECIPE_NAME                           \n");
					sbInsSql.append("       , RECIPE_CLASS                          \n");
					sbInsSql.append("       , RECIPE_TYPE                           \n");
					sbInsSql.append("       , CUISINE_TYPE                          \n");
					sbInsSql.append("       , MAIN_ITEM_CODE1                       \n");
					sbInsSql.append("       , MAIN_ITEM_CODE2                       \n");
					sbInsSql.append("       , COOK_TOOL1                            \n");
					sbInsSql.append("       , COOK_TOOL2                            \n");
					sbInsSql.append("       , RECIPE_COLOR                          \n");
					sbInsSql.append("       , RECIPE_SHAPE                          \n");
					sbInsSql.append("       , RECIPE_TASTE                          \n");
					sbInsSql.append("       , RECIPE_FEEL                           \n");
					sbInsSql.append("       , RECIPE_TEMPER                         \n");
					sbInsSql.append("       , SPRING_YN                             \n");
					sbInsSql.append("       , SUMMER_YN                             \n");
					sbInsSql.append("       , AUTUMN_YN                             \n");
					sbInsSql.append("       , WINTER_YN                             \n");
					sbInsSql.append("       , RESP_NUT1                             \n");
					sbInsSql.append("       , RESP_NUT2                             \n");
					sbInsSql.append("       , USE_TOOL                              \n");
					sbInsSql.append("       , VALID_TIME                            \n");
					sbInsSql.append("       , DISPLAY_METHOD                        \n");
					sbInsSql.append("       , SALE_UOM                              \n");
					sbInsSql.append("       , SALE_PRICE                            \n");
					sbInsSql.append("       , COST_RATE                             \n");
					sbInsSql.append("       , CORE_TEMPER_YN						\n");
					sbInsSql.append("       , GOODS_FEATURE                         \n");
					sbInsSql.append("       , PHF_MGMT_YN                           \n");
					sbInsSql.append("       , PHF                                   \n");
					sbInsSql.append("       , PHF_MGMT1                             \n");
					sbInsSql.append("       , PHF_MGMT2                             \n");
					sbInsSql.append("       , PHF_MGMT3                             \n");
					sbInsSql.append("       , PHF_MGMT4                             \n");
					sbInsSql.append("       , PHF_MGMT5                             \n");
					sbInsSql.append("       , COOK_OPRN                             \n");
					sbInsSql.append("       , PHOTO_PATH                            \n");
					sbInsSql.append("       , SPHOTO_PATH                           \n");
					sbInsSql.append("       , REMARK                             	\n");
					sbInsSql.append("       , USE_YN                                \n");
					sbInsSql.append("       , '', '', '', '', ''                    \n");
					sbInsSql.append("       , '', '', '', '', ''                    \n");
					sbInsSql.append("       , '" + g_EmpNo + "', SYSDATE            \n");
					sbInsSql.append("       , '" + g_EmpNo + "', SYSDATE            \n");
					sbInsSql.append("  FROM FMM_UPJANG_RECIPE_MST A                 \n");
					sbInsSql.append(" WHERE UPJANG = " + v_Upjang + "       		\n");
					sbInsSql.append("   AND SUBINV_CLASS = '" + v_SubinvClass + "'	\n");
					sbInsSql.append("   AND RECIPE_CD = '" + strRecipeCD + "'		\n");
				}
				
				
				stmt 		=  conn.createStatement();
				stmt.execute(sbInsSql.toString());
				stmt.close();
				
				// 3. 조리법
				sbInsSql.delete(0, sbInsSql.length());
				sbInsSql.append("INSERT INTO FMM_UPJANG_RECIPE_CUISINE(         \n");
				sbInsSql.append("         UPJANG                                \n");
				sbInsSql.append("       , SUBINV_CLASS                          \n");
				sbInsSql.append("       , RECIPE_CD                             \n");
				sbInsSql.append("       , CUISINE_SEQ                           \n");
				sbInsSql.append("       , CUISINE_DESC                          \n");
				sbInsSql.append("       , PHOTO_PATH                            \n");
				sbInsSql.append("       , SPHOTO_PATH                           \n");
				sbInsSql.append("       , REMARK                                \n");
				sbInsSql.append("       , USE_YN                                \n");
				sbInsSql.append("       , ATTR01, ATTR02, ATTR03, ATTR04, ATTR05\n");
				sbInsSql.append("       , ATTR06, ATTR07, ATTR08, ATTR09, ATTR10\n");
				sbInsSql.append("       , CUSER, CDATE                          \n");
				sbInsSql.append("       , UUSER, UDATE                          \n");
				sbInsSql.append(" )                                             \n");
				if (strSaveGbn.equals("1"))		// 1 : 한화표준레시피
				{
					sbInsSql.append("SELECT   " + strUpjang + " UPJANG              \n");
					sbInsSql.append("       , '" + strSubinvClass + "' SUBINV_CLASS \n");
					sbInsSql.append("       , RECIPE_CD                             \n");
					sbInsSql.append("       , CUISINE_SEQ                           \n");
					sbInsSql.append("       , CUISINE_DESC                          \n");
					sbInsSql.append("       , PHOTO_PATH                            \n");
					sbInsSql.append("       , SPHOTO_PATH                           \n");
					sbInsSql.append("       , '' REMARK                             \n");
					sbInsSql.append("       , 'Y' USE_YN                            \n");
					sbInsSql.append("       , '', '', '', '', ''                    \n");
					sbInsSql.append("       , '', '', '', '', ''                    \n");
					sbInsSql.append("       , '" + g_EmpNo + "', SYSDATE            \n");
					sbInsSql.append("       , '" + g_EmpNo + "', SYSDATE            \n");
					sbInsSql.append("  FROM FMR_STD_RECIPE_CUISINE A                \n");
					sbInsSql.append(" WHERE RECIPE_CD = '" + strRecipeCD + "'       \n");
				}
				else if (strSaveGbn.equals("2"))	// 2 : 본사 표준레시피
				{
					sbInsSql.append("SELECT   " + strUpjang + " UPJANG              \n");
					sbInsSql.append("       , '" + strSubinvClass + "' SUBINV_CLASS \n");
					sbInsSql.append("       , RECIPE_CD                             \n");
					sbInsSql.append("       , CUISINE_SEQ                           \n");
					sbInsSql.append("       , CUISINE_DESC                          \n");
					sbInsSql.append("       , PHOTO_PATH                            \n");
					sbInsSql.append("       , SPHOTO_PATH                           \n");
					sbInsSql.append("       , REMARK                             	\n");
					sbInsSql.append("       , USE_YN                            	\n");
					sbInsSql.append("       , '', '', '', '', ''                    \n");
					sbInsSql.append("       , '', '', '', '', ''                    \n");
					sbInsSql.append("       , '" + g_EmpNo + "', SYSDATE            \n");
					sbInsSql.append("       , '" + g_EmpNo + "', SYSDATE            \n");
					sbInsSql.append("  FROM FMM_STD_RECIPE_CUISINE A                \n");
					sbInsSql.append(" WHERE UPJANG = " + v_Upjang + "       		\n");
					sbInsSql.append("   AND RECIPE_CD = '" + strRecipeCD + "'		\n");
				}
				else								// 3 : 사업장레시피
				{
					sbInsSql.append("SELECT   " + strUpjang + " UPJANG              \n");
					sbInsSql.append("       , '" + strSubinvClass + "' SUBINV_CLASS \n");
					sbInsSql.append("       , RECIPE_CD                             \n");
					sbInsSql.append("       , CUISINE_SEQ                           \n");
					sbInsSql.append("       , CUISINE_DESC                          \n");
					sbInsSql.append("       , PHOTO_PATH                            \n");
					sbInsSql.append("       , SPHOTO_PATH                           \n");
					sbInsSql.append("       , REMARK                             	\n");
					sbInsSql.append("       , USE_YN                            	\n");
					sbInsSql.append("       , '', '', '', '', ''                    \n");
					sbInsSql.append("       , '', '', '', '', ''                    \n");
					sbInsSql.append("       , '" + g_EmpNo + "', SYSDATE            \n");
					sbInsSql.append("       , '" + g_EmpNo + "', SYSDATE            \n");
					sbInsSql.append("  FROM FMM_UPJANG_RECIPE_CUISINE A             \n");
					sbInsSql.append(" WHERE UPJANG = " + v_Upjang + "       		\n");
					sbInsSql.append("   AND SUBINV_CLASS = '" + v_SubinvClass + "'	\n");
					sbInsSql.append("   AND RECIPE_CD = '" + strRecipeCD + "'		\n");
				}
				
				stmt 		=  conn.createStatement();
				stmt.execute(sbInsSql.toString());
				stmt.close();
				
				// 4. 특이사항
// 				sbInsSql.delete(0, sbInsSql.length());                               
// 				sbInsSql.append("INSERT INTO FMM_UPJANG_RECIPE_SPECIAL(         \n");
// 				sbInsSql.append("       UPJANG                                  \n");
// 				sbInsSql.append("       , SUBINV_CLASS                          \n");
// 				sbInsSql.append("       , RECIPE_CD                             \n");
// 				sbInsSql.append("       , SPECIAL_SEQ                           \n");
// 				sbInsSql.append("       , SPECIAL_DESC                          \n");
// 				sbInsSql.append("       , REMARK                                \n");
// 				sbInsSql.append("       , USE_YN                                \n");
// 				sbInsSql.append("       , ATTR01, ATTR02, ATTR03, ATTR04, ATTR05\n");
// 				sbInsSql.append("       , ATTR06, ATTR07, ATTR08, ATTR09, ATTR10\n");
// 				sbInsSql.append("       , CUSER, CDATE                          \n");
// 				sbInsSql.append("       , UUSER, UDATE                          \n");
// 				sbInsSql.append(" )                                             \n");
// 				if (strSaveGbn.equals("1"))		// 1 : 한화표준레시피
// 				{
// 					sbInsSql.append("SELECT   " + strUpjang + " UPJANG              \n");
// 					sbInsSql.append("       , '" + strSubinvClass + "' SUBINV_CLASS \n");
// 					sbInsSql.append("       , RECIPE_CD                             \n");
// 					sbInsSql.append("       , SPECIAL_SEQ                           \n");
// 					sbInsSql.append("       , SPECIAL_DESC                          \n");
// 					sbInsSql.append("       , '' REMARK                             \n");
// 					sbInsSql.append("       , 'Y' USE_YN                            \n");
// 					sbInsSql.append("       , '', '', '', '', ''                    \n");
// 					sbInsSql.append("       , '', '', '', '', ''                    \n");
// 					sbInsSql.append("       , '" + g_EmpNo + "', SYSDATE            \n");
// 					sbInsSql.append("       , '" + g_EmpNo + "', SYSDATE            \n");
// 					sbInsSql.append("  FROM FSR_STD_RECIPE_SPECIAL A                \n");
// 					sbInsSql.append(" WHERE RECIPE_CD = '" + strRecipeCD + "'       \n");
// 				}
// 				else if (strSaveGbn.equals("2"))	// 2 : 본사 표준레시피
// 				{
// 					sbInsSql.append("SELECT   " + strUpjang + " UPJANG              \n");
// 					sbInsSql.append("       , '" + strSubinvClass + "' SUBINV_CLASS \n");
// 					sbInsSql.append("       , RECIPE_CD                             \n");
// 					sbInsSql.append("       , SPECIAL_SEQ                           \n");
// 					sbInsSql.append("       , SPECIAL_DESC                          \n");
// 					sbInsSql.append("       , REMARK                             	\n");
// 					sbInsSql.append("       , USE_YN                            	\n");
// 					sbInsSql.append("       , '', '', '', '', ''                    \n");
// 					sbInsSql.append("       , '', '', '', '', ''                    \n");
// 					sbInsSql.append("       , '" + g_EmpNo + "', SYSDATE            \n");
// 					sbInsSql.append("       , '" + g_EmpNo + "', SYSDATE            \n");
// 					sbInsSql.append("  FROM FMM_STD_RECIPE_SPECIAL A                \n");
// 					sbInsSql.append(" WHERE UPJANG = " + v_Upjang + "       		\n");
// 					sbInsSql.append("   AND RECIPE_CD = '" + strRecipeCD + "'		\n");
// 				}
// 				else								// 3 : 사업장레시피
// 				{
// 					sbInsSql.append("SELECT   " + strUpjang + " UPJANG              \n");
// 					sbInsSql.append("       , '" + strSubinvClass + "' SUBINV_CLASS \n");
// 					sbInsSql.append("       , RECIPE_CD                             \n");
// 					sbInsSql.append("       , SPECIAL_SEQ                           \n");
// 					sbInsSql.append("       , SPECIAL_DESC                          \n");
// 					sbInsSql.append("       , REMARK                             	\n");
// 					sbInsSql.append("       , USE_YN                            	\n");
// 					sbInsSql.append("       , '', '', '', '', ''                    \n");
// 					sbInsSql.append("       , '', '', '', '', ''                    \n");
// 					sbInsSql.append("       , '" + g_EmpNo + "', SYSDATE            \n");
// 					sbInsSql.append("       , '" + g_EmpNo + "', SYSDATE            \n");
// 					sbInsSql.append("  FROM FMM_UPJANG_RECIPE_SPECIAL A             \n");
// 					sbInsSql.append(" WHERE UPJANG = " + v_Upjang + "       		\n");
// 					sbInsSql.append("   AND SUBINV_CLASS = '" + v_SubinvClass + "'	\n");
// 					sbInsSql.append("   AND RECIPE_CD = '" + strRecipeCD + "'		\n");
// 				}

// 				stmt 		=  conn.createStatement();
// 				stmt.execute(sbInsSql.toString());
// 				stmt.close();
				
				// 5. 식자재
				sbInsSql.delete(0, sbInsSql.length());
				sbInsSql.append("INSERT INTO FMM_UPJANG_RECIPE_ITEM(            \n");
				sbInsSql.append("       UPJANG                                  \n");
				sbInsSql.append("       , SUBINV_CLASS                          \n");
				sbInsSql.append("       , RECIPE_CD                             \n");
				sbInsSql.append("       , ITEM_CODE                             \n");
				sbInsSql.append("       , ITEM_SEQ                              \n");
				sbInsSql.append("       , NEED_QTY                              \n");
				sbInsSql.append("       , EDIBLE_QTY                            \n");
				sbInsSql.append("       , CUT_SPEC                              \n");
				sbInsSql.append("       , REMARK                                \n");
				sbInsSql.append("       , USE_YN                                \n");
				sbInsSql.append("       , ATTR01, ATTR02, ATTR03, ATTR04, ATTR05\n");
				sbInsSql.append("       , ATTR06, ATTR07, ATTR08, ATTR09, ATTR10\n");
				sbInsSql.append("       , CUSER, CDATE, UUSER, UDATE            \n");
				sbInsSql.append(" )                                             \n");
				if (strSaveGbn.equals("1"))		// 1 : 한화표준레시피
				{
					sbInsSql.append("SELECT   " + strUpjang + " UPJANG \n");
					sbInsSql.append("       , '" + strSubinvClass + "' SUBINV_CLASS \n");
					sbInsSql.append("       , A.RECIPE_CD \n");
					sbInsSql.append("       , A.ITEM_CODE \n");
					sbInsSql.append("       , A.ITEM_SEQ \n");
					sbInsSql.append("       , A.NEED_QTY \n");
					sbInsSql.append("       , ROUND(A.NEED_QTY * (100 - NVL(( \n");
					sbInsSql.append("            SELECT DISUSE_RATE \n");
					sbInsSql.append("              FROM FMP_ITEM_NUT \n");
					sbInsSql.append("             WHERE UPJANG = (SELECT MAIN_UPJANG FROM FMS_UPJANG WHERE UPJANG = " + strUpjang + " ) \n");
					sbInsSql.append("               AND ITEM_CODE = A.ITEM_CODE \n");
					sbInsSql.append("             UNION ALL \n");
					sbInsSql.append("           (SELECT DISUSE_RATE \n");
					sbInsSql.append("              FROM FSI_ITEM_NUT \n");
					sbInsSql.append("             WHERE ITEM_CODE = A.ITEM_CODE \n");
					sbInsSql.append("             MINUS \n");
					sbInsSql.append("            SELECT DISUSE_RATE \n");
					sbInsSql.append("              FROM FMP_ITEM_NUT \n");
					sbInsSql.append("             WHERE UPJANG = (SELECT MAIN_UPJANG FROM FMS_UPJANG WHERE UPJANG = " + strUpjang + " ) \n");
					sbInsSql.append("               AND ITEM_CODE = A.ITEM_CODE \n");
					sbInsSql.append("            ) \n");
					sbInsSql.append("         ),0)) / 100,2)  AS EDIBLE_QTY \n");
					sbInsSql.append("       , A.CUT_SPEC \n");
					sbInsSql.append("       , '' REMARK \n");
					sbInsSql.append("       , 'Y' USE_YN \n");
					sbInsSql.append("       , '', '', '', '', '' \n");
					sbInsSql.append("       , '', '', '', '', '' \n");
					sbInsSql.append("       , '" + g_EmpNo + "', SYSDATE \n");
					sbInsSql.append("       , '" + g_EmpNo + "', SYSDATE \n");
					sbInsSql.append("  FROM (SELECT NVL(B.ITEM_CODE_TO,A.ITEM_CODE) AS ITEM_CODE \n");
					sbInsSql.append("             , A.RECIPE_CD \n");
					sbInsSql.append("             , MIN(A.ITEM_SEQ) AS ITEM_SEQ -- ROWNUM \n");
					sbInsSql.append("             , SUM(A.NEED_QTY) AS NEED_QTY \n");
					sbInsSql.append("             , SUM(A.EDIBLE_QTY) AS EDIBLE_QTY \n");
					sbInsSql.append("             , MAX(A.CUT_SPEC) AS CUT_SPEC \n");
					sbInsSql.append("          FROM FMR_STD_RECIPE_ITEM A \n");
					sbInsSql.append("             ,(SELECT * FROM FMM_CHG_ITEM_LIST B WHERE UPJANG = " + strUpjang + " AND USE_YN = 'Y') B \n");
					sbInsSql.append("         WHERE A.ITEM_CODE = B.ITEM_CODE(+) \n");
					sbInsSql.append("         GROUP BY NVL(B.ITEM_CODE_TO,A.ITEM_CODE), A.RECIPE_CD \n");
					sbInsSql.append("       ) A \n");
					sbInsSql.append(" WHERE A.RECIPE_CD = '" + strRecipeCD + "' \n");
				}
				else if (strSaveGbn.equals("2"))	// 2 : 본사 표준레시피
				{
					sbInsSql.append("SELECT   " + strUpjang + " UPJANG              \n");
					sbInsSql.append("       , '" + strSubinvClass + "' SUBINV_CLASS \n");
					sbInsSql.append("       , RECIPE_CD                             \n");
					sbInsSql.append("       , ITEM_CODE                             \n");
					sbInsSql.append("       , ITEM_SEQ                              \n");
					sbInsSql.append("       , NEED_QTY                              \n");
					sbInsSql.append("       , EDIBLE_QTY                            \n");
					sbInsSql.append("       , CUT_SPEC                              \n");
					sbInsSql.append("       , '' REMARK                             \n");
					sbInsSql.append("       , 'Y' USE_YN                            \n");
					sbInsSql.append("       , '', '', '', '', ''                    \n");
					sbInsSql.append("       , '', '', '', '', ''                    \n");
					sbInsSql.append("       , '" + g_EmpNo + "', SYSDATE            \n");
					sbInsSql.append("       , '" + g_EmpNo + "', SYSDATE            \n");
					sbInsSql.append("  FROM FMM_STD_RECIPE_ITEM A                   \n");
					sbInsSql.append(" WHERE UPJANG = " + v_Upjang + "       		\n");
					sbInsSql.append("   AND RECIPE_CD = '" + strRecipeCD + "'		\n");
				}
				else								// 3 : 사업장레시피
				{
					sbInsSql.append("SELECT   " + strUpjang + " UPJANG              \n");
					sbInsSql.append("       , '" + strSubinvClass + "' SUBINV_CLASS \n");
					sbInsSql.append("       , RECIPE_CD                             \n");
					sbInsSql.append("       , ITEM_CODE                             \n");
					sbInsSql.append("       , ITEM_SEQ                              \n");
					sbInsSql.append("       , NEED_QTY                              \n");
					sbInsSql.append("       , EDIBLE_QTY                            \n");
					sbInsSql.append("       , CUT_SPEC                              \n");
					sbInsSql.append("       , '' REMARK                             \n");
					sbInsSql.append("       , 'Y' USE_YN                            \n");
					sbInsSql.append("       , '', '', '', '', ''                    \n");
					sbInsSql.append("       , '', '', '', '', ''                    \n");
					sbInsSql.append("       , '" + g_EmpNo + "', SYSDATE            \n");
					sbInsSql.append("       , '" + g_EmpNo + "', SYSDATE            \n");
					sbInsSql.append("  FROM FMM_UPJANG_RECIPE_ITEM A                \n");
					sbInsSql.append(" WHERE UPJANG = " + v_Upjang + "       		\n");
					sbInsSql.append("   AND SUBINV_CLASS = '" + v_SubinvClass + "'	\n");
					sbInsSql.append("   AND RECIPE_CD = '" + strRecipeCD + "'		\n");
				}
				
				stmt 		=  conn.createStatement();
				stmt.execute(sbInsSql.toString());
				stmt.close();
				
				// 6.데이터셋팅
				ds_Save.set(i,"UPJANG",strUpjang);
				ds_Save.set(i,"SUBINV_CLASS",strSubinvClass);
				ds_Save.set(i,"ORG_GBN","");
				ds_Save.set(i,"EXIST_YN","Y");
			}
		}
		
		conn.commit();
		out_dl.add(ds_Save);
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