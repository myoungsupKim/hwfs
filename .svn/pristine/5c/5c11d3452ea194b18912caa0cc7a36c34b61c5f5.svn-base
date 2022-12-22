<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	try {
		// 기간식단 식수예측 리스트 조회
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));
		
		DataSet ds_input  		= in_dl.get("ds_input");
	
	
		StringBuffer sbSelSql = new StringBuffer();
		
		int RowCnt;
		String strCopyGubun,v_Upjang,v_Subinv,v_Menudate,v_Meal,v_Corner,v_FromDt,v_ToDt,v_Dt;
		
		strCopyGubun 	= in_vl.getString("strCopyGubun");
		v_Upjang		= in_vl.getString("fa_UPJANG");
		v_Subinv		= in_vl.getString("fa_SUBINV_CODE");
		v_Meal  		= in_vl.getString("MEAL");
		v_Corner  		= in_vl.getString("CORNER");
		v_FromDt  		= in_vl.getString("FROM_DT");
		v_ToDt  		= in_vl.getString("TO_DT");
		v_Dt			= in_vl.getString("D_DT");

		//out 데이타                                                                                                                                                                                        
		DataSet ds_chkMenuList;                                                                                                                                                                                    
		                                                                                                                                                                                                    
		//sql문 버퍼생성                                                                                                                                                                                    
		StringBuffer sbSql = new StringBuffer();                                                                                                                                                            
        
		if (strCopyGubun.equals("0"))		// 0 : 사업장식단
		{
			String strUpjang,strSubinv,strMeal,strCorner,strFromDt,strToDt;
			
			strUpjang 	= ds_input.getString(0,"UPJANG");
			strSubinv 	= ds_input.getString(0,"SUBINV_CODE");
			strMeal 	= ds_input.getString(0,"MEAL1");
			strCorner 	= ds_input.getString(0,"CORNER1");
			strFromDt 	= ds_input.getString(0,"MENU_F_DATE1");
			strToDt 	= ds_input.getString(0,"MENU_T_DATE1");

			
			sbSql.delete(0, sbSql.length());
			sbSql.append("SELECT TO_CHAR(TO_DATE(MENU_DATE,'yyyymmdd') + " + v_Dt + " ,'yyyymmdd') || '-' || '"+v_Subinv+"' || '"+v_Meal+"' || '"+v_Corner+"' AS MENU_CD \n");
			sbSql.append("     , '" + v_Meal + "' AS MEAL \n");
			sbSql.append("     , '" + v_Corner + "' AS CORNER \n");
			sbSql.append("     , TO_CHAR(TO_DATE(MENU_DATE,'yyyymmdd') + " + v_Dt + " ,'yyyymmdd') AS MENU_DATE \n");
			sbSql.append("  FROM FMM_MENU \n");
			sbSql.append(" WHERE UPJANG = '" + strUpjang + "' \n");
			sbSql.append("   AND SUBINV_CODE = '" + strSubinv + "' \n");
			sbSql.append("   AND MENU_DATE BETWEEN '" + strFromDt + "' AND '" + strToDt + "' \n");
			sbSql.append("   AND MEAL = '" + strMeal + "' \n");
			sbSql.append("   AND CORNER = '" + strCorner + "' \n");
			sbSql.append("   AND TO_CHAR(TO_DATE(MENU_DATE,'yyyymmdd') + " + v_Dt + " ,'yyyymmdd') NOT IN ( \n");
			sbSql.append("                         SELECT MENU_DATE \n");
			sbSql.append("                           FROM FMM_MENU \n");
			sbSql.append("                          WHERE UPJANG = '" + v_Upjang + "' \n");
			sbSql.append("                            AND SUBINV_CODE = '" + v_Subinv + "' \n");
			sbSql.append("                            AND MENU_DATE BETWEEN '" + v_FromDt + "' AND '" + v_ToDt + "' \n");
			sbSql.append("                            AND MEAL = '" + v_Meal + "' \n");
			sbSql.append("                            AND CORNER = '" + v_Corner + "' \n");
			sbSql.append("                            AND EXPECT_MEAL_QTY > 0 \n");
			sbSql.append("                      ) \n");
			sbSql.append(" ORDER BY MENU_DATE, MEAL, CORNER \n");
			
			
		}
		else								// 본사표준식단
		{
			String strMenuClass,strCostType,strMenuType,strMeal,strCorner,strFromDt,strToDt;
			
			strMenuClass 	= ds_input.getString(0,"MENU_CLASS");
			strCostType 	= ds_input.getString(0,"COST_TYPE");
			strMenuType 	= ds_input.getString(0,"MENU_TYPE");
			strMeal 		= ds_input.getString(0,"MEAL2");
			strCorner 		= ds_input.getString(0,"CORNER2");
			strFromDt 		= ds_input.getString(0,"MENU_F_DATE2");
			strToDt 		= ds_input.getString(0,"MENU_T_DATE2");
			
			sbSql.delete(0, sbSql.length());
			sbSql.append("SELECT TO_CHAR(TO_DATE(MENU_DATE,'yyyymmdd') + " + v_Dt + " ,'yyyymmdd') || '-' || '"+v_Subinv+"' || '"+v_Meal+"' || '"+v_Corner+"' AS MENU_CD \n");
			sbSql.append("     , '" + v_Meal + "' AS MEAL \n");
			sbSql.append("     , '" + v_Corner + "' AS CORNER \n");
			sbSql.append("     , TO_CHAR(TO_DATE(MENU_DATE,'yyyymmdd') + " + v_Dt + " ,'yyyymmdd') AS MENU_DATE \n");
			sbSql.append("  FROM FMM_TERM_MENU_MST \n");
			sbSql.append(" WHERE MENU_CLASS = '" + strMenuClass + "' \n");
			sbSql.append("   AND COST_TYPE = '" + strCostType + "' \n");
			sbSql.append("   AND MENU_TYPE = '" + strMenuType + "' \n");
			sbSql.append("   AND MENU_DATE BETWEEN '" + strFromDt + "' AND '" + strToDt + "' \n");
			sbSql.append("   AND MEAL = '" + strMeal + "' \n");
			sbSql.append("   AND CORNER = '" + strCorner + "' \n");
			sbSql.append("   AND TO_CHAR(TO_DATE(MENU_DATE,'yyyymmdd') + " + v_Dt + " ,'yyyymmdd') NOT IN ( \n");
			sbSql.append("                         SELECT MENU_DATE \n");
			sbSql.append("                           FROM FMM_MENU \n");
			sbSql.append("                          WHERE UPJANG = '" + v_Upjang + "' \n");
			sbSql.append("                            AND SUBINV_CODE = '" + v_Subinv + "' \n");
			sbSql.append("                            AND MENU_DATE BETWEEN '" + v_FromDt + "' AND '" + v_ToDt + "' \n");
			sbSql.append("                            AND MEAL = '" + v_Meal + "' \n");
			sbSql.append("                            AND CORNER = '" + v_Corner + "' \n");
			sbSql.append("                            AND EXPECT_MEAL_QTY > 0 \n");
			sbSql.append("                      ) \n");
			sbSql.append(" ORDER BY MENU_DATE, MEAL, CORNER \n");
		}
		
		
		//System.out.println(sbSql.toString());                                                                                                                                                             
		pstmt = conn.prepareStatement(sbSql.toString());		                                                                                                                                                
		rs = pstmt.executeQuery();                                                                                                                                                                          
		ds_chkMenuList = this.makeDataSet(rs, "ds_chkMenuList");                                                                                                                                                          
        
		rs.close();
		pstmt.close();
		
		/**종료**/                                                                                                                                                                                          
		out_dl.add(ds_chkMenuList);                                                                                                                                                          
		this.setResultMessage(0, "OK", out_vl);
	   
	} catch(Exception ex) {
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