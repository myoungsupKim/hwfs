<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	try {
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));
		
		String RECIPE_NAME 			= in_vl.getString("RECIPE_NAME");                                                                                                                                                                                                        
		String RECIPE_CLASS 		= in_vl.getString("RECIPE_CLASS");                                                                                                                           
		String RECIPE_TYPE			= in_vl.getString("RECIPE_TYPE");                                                                                                                          
		String CUISINE_TYPE			= in_vl.getString("CUISINE_TYPE");
		String MAIN_ITEM_CODE1		= in_vl.getString("MAIN_ITEM_CODE1");
		String SAVEFROM				= in_vl.getString("SAVEFROM");
		String SAVETO				= in_vl.getString("SAVETO");
		String UPJANG				= in_vl.getString("UPJANG");
		String RESP_NUT1			= in_vl.getString("RESP_NUT1");	
		String SABUN				= in_vl.getString("SABUN");
		
		String TERM_TYPE			= in_vl.getString("TERM_TYPE");
		String FROM_DT				= in_vl.getString("FROM_DT");
		String TO_DT				= in_vl.getString("TO_DT");
		
		
		StringBuffer sbSql = new StringBuffer();
	
		if(conn!=null)
		{							
			sbSql.delete(0, sbSql.length());
			
			sbSql.append("SELECT /*+ ORDERED USE_HASH(A B C D E) */	A.RECIPE_CD, \n");
			sbSql.append("	A.RECIPE_NAME, \n");
			sbSql.append("	A.RECIPE_CLASS, \n");
			sbSql.append("	A.RECIPE_TYPE, \n");
			sbSql.append("	A.CUISINE_TYPE, \n");
			sbSql.append("	A.MAIN_ITEM_CODE1, \n");
			sbSql.append("	A.MAIN_ITEM_CODE2, \n");
			sbSql.append("	A.COOK_TOOL1, \n");
			sbSql.append("	A.COOK_TOOL2, \n");
			sbSql.append("	A.RECIPE_COLOR, \n");
			sbSql.append("	A.RECIPE_SHAPE, \n");
			sbSql.append("	A.RECIPE_TASTE, \n");
			sbSql.append("	A.RECIPE_FEEL, \n");
			sbSql.append("	A.RECIPE_TEMPER, \n");
			sbSql.append("	A.SPRING_YN, \n");
			sbSql.append("	A.SUMMER_YN, \n");
			sbSql.append("	A.AUTUMN_YN, \n");
			sbSql.append("	A.WINTER_YN, \n");
			sbSql.append("	TRIM(A.RESP_NUT1) AS RESP_NUT1, \n");
			sbSql.append("	TRIM(A.RESP_NUT2) AS RESP_NUT2, \n");
			sbSql.append("	A.USE_TOOL, \n");
			sbSql.append("	A.VALID_TIME, \n");
			sbSql.append("	A.DISPLAY_METHOD, \n");
			sbSql.append("	A.SALE_UOM, \n");
			sbSql.append("	A.SALE_PRICE, \n");
			sbSql.append("	A.COST_RATE, \n");
			sbSql.append("	A.CORE_TEMPER_YN, \n");
			sbSql.append("	A.GOODS_FEATURE, \n");
			sbSql.append("	A.PHF_MGMT1, \n");
			sbSql.append("	A.PHF_MGMT2, \n");
			sbSql.append("	A.PHF_MGMT3, \n");
			sbSql.append("	A.PHF_MGMT4, \n");
			sbSql.append("	A.PHF_MGMT5, \n");
			sbSql.append("	A.COOK_OPRN, \n");
			sbSql.append("	A.PHOTO_PATH, \n");
			sbSql.append("  A.SPHOTO_PATH, \n");
			sbSql.append("	A.USE_YN, \n");
			sbSql.append("	A.ATTR01, \n");
			sbSql.append("	A.ATTR02, \n");
			sbSql.append("	A.ATTR03, \n");
			sbSql.append("	A.ATTR04, \n");
			sbSql.append("	A.ATTR05, \n");
			sbSql.append("	A.ATTR06, \n");
			sbSql.append("	A.ATTR07, \n");
			sbSql.append("	A.ATTR08, \n");
			sbSql.append("	A.ATTR09, \n");
			sbSql.append("	A.ATTR10, \n");
			sbSql.append("	A.CUSER, \n");
			sbSql.append("  E.NM_KOR, \n");
			sbSql.append("	A.CDATE, \n");
			sbSql.append("	A.UUSER, \n");
			sbSql.append("	A.UDATE, \n");
			sbSql.append("  A.PHF, \n");
			sbSql.append("	A.SAME_WORD, \n");
			sbSql.append("	SUM(ROUND(B.NEED_QTY * (NVL(C.MARGIN_PRICE,0) / D.KG_CONVERT_RATE / 1000) ) )                 RECIPE_WONGA, \n");
			sbSql.append("	(SELECT NM_KOR || '(' || A.SABUN || ')' FROM SCC_USERINFO WHERE SABUN = A.SABUN) AS DEVELOPER \n");
			sbSql.append("  from	FMR_STD_RECIPE_MST A , \n");
			sbSql.append("          SCC_USERINFO E, \n");
			sbSql.append("	FMR_STD_RECIPE_ITEM B , \n");
			sbSql.append("	FMI_STD_PRICE C , \n");
			sbSql.append("	HLDC_PO_ITEM_MST D  \n");
			sbSql.append("  WHERE	A.RECIPE_CD = B.RECIPE_CD(+) \n");
			sbSql.append("  AND B.ITEM_CODE = C.ITEM_CODE(+) \n");
			sbSql.append("  AND B.ITEM_CODE = D.ITEM_CODE(+) \n");
			sbSql.append("  AND A.RECIPE_CLASS != 'H'  \n");
			sbSql.append("  AND A.CUSER= E.SABUN(+) \n");
			sbSql.append("  AND D.ITEM_CLASS1(+) = 'F'  \n");
			if(!RECIPE_NAME.equals(""))
			{
			sbSql.append("  AND (A.RECIPE_NAME LIKE '%'||'"+RECIPE_NAME+"'||'%' OR A.SAME_WORD LIKE '%'||'"+RECIPE_NAME+"'||'%') \n");
			}
			if(!RECIPE_CLASS.equals(""))
			{
			sbSql.append("  AND A.RECIPE_CLASS='"+RECIPE_CLASS+"' \n");
			}
			if(!RECIPE_TYPE.equals(""))
			{
			sbSql.append("  AND A.RECIPE_TYPE='"+RECIPE_TYPE+"' \n");
			}
			if(!CUISINE_TYPE.equals(""))
			{
			sbSql.append("  AND A.CUISINE_TYPE='"+CUISINE_TYPE+"' \n");
			}
			if(!MAIN_ITEM_CODE1.equals(""))
			{
				sbSql.append("  AND A.MAIN_ITEM_CODE1 ='"+MAIN_ITEM_CODE1+"' \n");
			}
			if(!RESP_NUT1.equals(""))
			{
			sbSql.append("  AND A.RESP_NUT1 ='"+RESP_NUT1+"' \n");
			}
			if(!SABUN.equals(""))
			{
			sbSql.append("  AND A.SABUN ='"+SABUN+"' \n");
			}
			if(!FROM_DT.equals("") && !TO_DT.equals(""))
			{
			sbSql.append("  AND A." + TERM_TYPE + " BETWEEN TO_DATE('" + FROM_DT + "000000', 'YYYYMMDDHH24MISS') AND TO_DATE('" + TO_DT + "115959', 'YYYYMMDDHH24MISS')  \n");
			}
			
			sbSql.append(" GROUP BY A.RECIPE_CD, \n");
			sbSql.append("	A.RECIPE_NAME, \n");
			sbSql.append("	A.RECIPE_CLASS, \n");
			sbSql.append("	A.RECIPE_TYPE, \n");
			sbSql.append("	A.CUISINE_TYPE, \n");
			sbSql.append("	A.MAIN_ITEM_CODE1, \n");
			sbSql.append("	A.MAIN_ITEM_CODE2, \n");
			sbSql.append("	A.COOK_TOOL1, \n");
			sbSql.append("	A.COOK_TOOL2, \n");
			sbSql.append("	A.RECIPE_COLOR, \n");
			sbSql.append("	A.RECIPE_SHAPE, \n");
			sbSql.append("	A.RECIPE_TASTE, \n");
			sbSql.append("	A.RECIPE_FEEL, \n");
			sbSql.append("	A.RECIPE_TEMPER, \n");
			sbSql.append("	A.SPRING_YN, \n");
			sbSql.append("	A.SUMMER_YN, \n");
			sbSql.append("	A.AUTUMN_YN, \n");
			sbSql.append("	A.WINTER_YN, \n");
			sbSql.append("	A.RESP_NUT1, \n");
			sbSql.append("	A.RESP_NUT2, \n");
			sbSql.append("	A.USE_TOOL, \n");
			sbSql.append("	A.VALID_TIME, \n");
			sbSql.append("	A.DISPLAY_METHOD, \n");
			sbSql.append("	A.SALE_UOM, \n");
			sbSql.append("	A.SALE_PRICE, \n");
			sbSql.append("	A.COST_RATE, \n");
			sbSql.append("	A.CORE_TEMPER_YN, \n");
			sbSql.append("	A.GOODS_FEATURE, \n");
			sbSql.append("	A.PHF_MGMT1, \n");
			sbSql.append("	A.PHF_MGMT2, \n");
			sbSql.append("	A.PHF_MGMT3, \n");
			sbSql.append("	A.PHF_MGMT4, \n");
			sbSql.append("	A.PHF_MGMT5, \n");
			sbSql.append("	A.COOK_OPRN, \n");
			sbSql.append("	A.PHOTO_PATH, \n");
			sbSql.append("  A.SPHOTO_PATH, \n");
			sbSql.append("	A.USE_YN, \n");
			sbSql.append("	A.ATTR01, \n");
			sbSql.append("	A.ATTR02, \n");
			sbSql.append("	A.ATTR03, \n");
			sbSql.append("	A.ATTR04, \n");
			sbSql.append("	A.ATTR05, \n");
			sbSql.append("	A.ATTR06, \n");
			sbSql.append("	A.ATTR07, \n");
			sbSql.append("	A.ATTR08, \n");
			sbSql.append("	A.ATTR09, \n");
			sbSql.append("	A.ATTR10, \n");
			sbSql.append("	A.CUSER, \n");
			sbSql.append("	A.CDATE, \n");
			sbSql.append("	A.UUSER, \n");
			sbSql.append("  A.UDATE, \n");
			sbSql.append("  E.NM_KOR, \n");
			sbSql.append("  A.PHF, \n");
			sbSql.append("  A.SAME_WORD, \n");
			sbSql.append("  A.SABUN \n");
			pstmt = conn.prepareStatement(sbSql.toString());
			
			rs = pstmt.executeQuery(); 

//			out_dl.add("DS_body", this.makeDataSet(rs,"DS_body"));
			
			DataSet ds_MainRecipeList = this.makeDataSet(rs,"ds_MainRecipeList");
			out_dl.add(ds_MainRecipeList);
			rs.close();
			pstmt.close();
			this.setResultMessage(0, "OK",out_vl);  
		}
	
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