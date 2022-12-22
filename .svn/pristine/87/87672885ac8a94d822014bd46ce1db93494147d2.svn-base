<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	try {
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));
		
		DataSet ds_cond             = in_dl.get("ds_cond");		    // 조회조건
		String RecipeGbn            = in_vl.getString("RecipeGbn");	// 0:표준레시피, 1:미확정레시피
		String RECIPE_NAME 			= nullToBlank(ds_cond.getString(0,"RECIPE_NAME"));                
		String RECIPE_ENAME 		= nullToBlank(ds_cond.getString(0,"RECIPE_ENAME"));                                                                                                                                                                                                 
		String RECIPE_CLASS 		= nullToBlank(ds_cond.getString(0,"RECIPE_CLASS"));                                                                                                                           
		String RECIPE_TYPE			= nullToBlank(ds_cond.getString(0,"RECIPE_TYPE"));                                                                                                                          
		String CUISINE_TYPE			= nullToBlank(ds_cond.getString(0,"CUISINE_TYPE"));
		String MAIN_ITEM_CODE1		= nullToBlank(ds_cond.getString(0,"MAIN_ITEM_CODE1"));
		String RESP_NUT1			= nullToBlank(ds_cond.getString(0,"RESP_NUT1"));		
		String SAVEFROM				= nullToBlank(ds_cond.getString(0,"SAVEFROM"));
		String SAVETO				= nullToBlank(ds_cond.getString(0,"SAVETO"));
		String UPJANG				= nullToBlank(ds_cond.getString(0,"UPJANG"));

		StringBuffer sbSql = new StringBuffer();
	
		if(conn!=null)
		{							
			sbSql.delete(0, sbSql.length());

			if(RecipeGbn.equals("0")) {
	            sbSql.append("SELECT D.RECIPE_CD                                                                                                       \n");
	            sbSql.append("     , D.RECIPE_NAME                                                                                                     \n");
	            sbSql.append("     , D.RECIPE_ENAME                                                                                                     \n");
	            sbSql.append("     , E.RECIPE_WONGA                                                                                                    \n");
	            sbSql.append("     , D.RECIPE_CLASS                                                                                                    \n");
	            sbSql.append("     , D.RECIPE_TYPE                                                                                                     \n");
	            sbSql.append("     , D.CUISINE_TYPE                                                                                                    \n");
	            sbSql.append("     , D.MAIN_ITEM_CODE1                                                                                                 \n");
	            sbSql.append("     , D.RESP_NUT1                                                                                                       \n");
	            sbSql.append("  FROM FSR_STD_RECIPE_MST D                                                                                              \n");
	            sbSql.append("     , (SELECT A.RECIPE_CD                                                                                               \n");
	            sbSql.append("             , SUM(ROUND(A.NEED_QTY * (NVL(B.MARGIN_PRICE,0) / C.KG_CONVERT_RATE / 1000))) AS RECIPE_WONGA               \n");
	            sbSql.append("          FROM FSR_STD_RECIPE_ITEM A                                                                                     \n");
	            sbSql.append("             , FSI_STD_PRICE B                                                                                           \n");
	            sbSql.append("             , HLDC_PO_ITEM_MST C                                                                                        \n");
	            sbSql.append("         WHERE A.ITEM_CODE = B.ITEM_CODE                                                                                 \n");
	            sbSql.append("           AND A.ITEM_CODE = C.ITEM_CODE                                                                                 \n");
	            sbSql.append("           AND C.ITEM_CLASS1 = 'F'                                                                                       \n");
	            sbSql.append("         GROUP BY RECIPE_CD) E                                                                                           \n");
	            sbSql.append(" WHERE D.RECIPE_CD = E.RECIPE_CD			                                                                               \n");
			} else {
	            sbSql.append("SELECT D.NEW_RECIPE_SEQ                                                                                                  \n");
	            sbSql.append("     , D.SUBMIT_DATE                                                                                                     \n");
	            sbSql.append("     , D.SUBMIT_USER                                                                                                     \n");
	            sbSql.append("     , (SELECT NM_KOR FROM HLDC_HR_PERSONAL WHERE SABUN = D.SUBMIT_USER) AS SUBMIT_NM_KOR                                \n");
	            sbSql.append("     , D.APPRV_YN                                                                                                        \n");
	            sbSql.append("     , D.UPJANG                                                                                                          \n");
	            sbSql.append("     , (SELECT UPJANGNM FROM HLDC_ST_UPJANG WHERE UPJANG = D.UPJANG) AS UPJANGNM                                         \n");
	            sbSql.append("     , D.RECIPE_CD                                                                                                       \n");
	            sbSql.append("     , D.RECIPE_NAME                                                                                                     \n");
	            sbSql.append("     , E.RECIPE_WONGA                                                                                                    \n");
	            sbSql.append("     , D.RECIPE_CLASS                                                                                                    \n");
	            sbSql.append("     , D.RECIPE_TYPE                                                                                                     \n");
	            sbSql.append("     , D.CUISINE_TYPE                                                                                                    \n");
	            sbSql.append("     , D.MAIN_ITEM_CODE1                                                                                                 \n");
	            sbSql.append("     , D.RESP_NUT1                                                                                                       \n");
	            sbSql.append("     , D.SABUN                                                                                                           \n");
	            sbSql.append("     , (SELECT NM_KOR FROM SCC_USERINFO WHERE SABUN = D.SABUN) AS NM_KOR                                                 \n");
	            sbSql.append("  FROM FSR_NEW_RECIPE_MST D                                                                                              \n");
	            sbSql.append("     , (SELECT A.NEW_RECIPE_SEQ, SUM(ROUND(A.NEED_QTY * (NVL(B.MARGIN_PRICE,0) / C.KG_CONVERT_RATE / 1000))) AS RECIPE_WONGA  \n");
	            sbSql.append("         FROM FSR_NEW_RECIPE_ITEM A                                                                                      \n");
	            sbSql.append("            , FSI_STD_PRICE B                                                                                            \n");
	            sbSql.append("            , HLDC_PO_ITEM_MST C                                                                                         \n");
	            sbSql.append("        WHERE A.ITEM_CODE = B.ITEM_CODE                                                                                  \n");
	            sbSql.append("          AND A.ITEM_CODE = C.ITEM_CODE                                                                                  \n");
	            sbSql.append("          AND C.ITEM_CLASS1 = 'F'                                                                                        \n");
	            sbSql.append("        GROUP BY NEW_RECIPE_SEQ) E                                                                                       \n");
	            sbSql.append(" WHERE D.NEW_RECIPE_SEQ = E.NEW_RECIPE_SEQ(+)			                                                                   \n");
	            sbSql.append("   AND D.APPRV_YN IN ('N', 'M')             			                                                                   \n");
			}
            
			if(!RECIPE_CLASS.equals("")) {
				sbSql.append("  AND D.RECIPE_CLASS='"+RECIPE_CLASS+"' \n");
			}
			if(!RECIPE_TYPE.equals("")) {
				sbSql.append("  AND D.RECIPE_TYPE='"+RECIPE_TYPE+"' \n");
			}
			if(!CUISINE_TYPE.equals("")) {
				sbSql.append("  AND D.CUISINE_TYPE='"+CUISINE_TYPE+"' \n");
			}
			if(!MAIN_ITEM_CODE1.equals("")) {
				sbSql.append("  AND D.MAIN_ITEM_CODE1 ='"+MAIN_ITEM_CODE1+"' \n");
			}
			if(!RESP_NUT1.equals("")) {
				sbSql.append("  AND D.RESP_NUT1 ='"+RESP_NUT1+"' \n");
			}
			if(!SAVEFROM.equals("")) {
				sbSql.append("  AND D.SUBMIT_DATE >= "+SAVEFROM+" \n");
			}
			if(!SAVETO.equals("")) {
				sbSql.append("  AND D.SUBMIT_DATE <= "+SAVETO+" \n");
			}
			if(!UPJANG.equals("")) {
				sbSql.append("  AND D.UPJANG ='"+UPJANG+"' \n");
			}
			
			if(!RECIPE_NAME.equals("")) {
				String[] arrSameWord = RECIPE_NAME.split(" ");
				
				sbSql.append("  AND ( \n");
				for(int i=0; i<arrSameWord.length; i++) {
					sbSql.append("   D.SAME_WORD LIKE '%'||'"+arrSameWord[i]+"'||'%' \n");
					sbSql.append("OR D.RECIPE_NAME LIKE '%'||'"+arrSameWord[i]+"'||'%' \n");
					if(i < arrSameWord.length-1) {
						sbSql.append("  OR \n");
					}
				}
				sbSql.append("  ) \n");
			}            
			
			// 정렬순서
			if(RecipeGbn.equals("0")) {
				sbSql.append("ORDER BY D.RECIPE_NAME ASC  \n");
			} else {
				sbSql.append("ORDER BY D.SUBMIT_DATE DESC  \n");
			}
			
			/*
			sbSql.append("select	A.RECIPE_CD, \n");
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
			sbSql.append("                A.SPHOTO_PATH, \n");
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
			sbSql.append("               E.NM_KOR, \n");
			sbSql.append("	A.CDATE, \n");
			sbSql.append("	A.UUSER, \n");
			sbSql.append("	A.UDATE, \n");
			sbSql.append("              A.PHF, \n");
			sbSql.append("	SUM(ROUND(B.NEED_QTY * (NVL(C.MARGIN_PRICE,0) / D.KG_CONVERT_RATE / 1000) ) )                 RECIPE_WONGA \n");
			sbSql.append("  from	FSR_STD_RECIPE_MST A , \n");
			sbSql.append("	FSR_STD_RECIPE_ITEM B , \n");
			sbSql.append("	FSI_STD_PRICE C , \n");
			sbSql.append("	( \n");
			sbSql.append("		SELECT	ITEM_CODE, \n");
			sbSql.append("			KG_CONVERT_RATE \n");
			sbSql.append("		FROM	HLDC_PO_ITEM_MST \n");
			sbSql.append("		WHERE	ITEM_CLASS1 = 'F' \n");
			sbSql.append("	) D, \n");
			sbSql.append("                SCC_USERINFO E \n");
			sbSql.append("  WHERE	A.RECIPE_CD = B.RECIPE_CD \n");
			sbSql.append("  AND B.ITEM_CODE = C.ITEM_CODE(+) \n");
			sbSql.append("  AND B.ITEM_CODE = D.ITEM_CODE \n");
			sbSql.append("  AND A.CUSER= E.SABUN(+) \n");
			if(!RECIPE_NAME.equals(""))
			{
			sbSql.append("  AND A.RECIPE_NAME LIKE '%'||'"+RECIPE_NAME+"'||'%' \n");
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
			//sbSql.append("  <isNotNull col=SAVEFROM> \n");
			//sbSql.append("  AND TO_CHAR(UDATE,'yyyymmdd') >= #SAVEFROM# \n");
			//sbSql.append("  </isNotNull> \n");
			//sbSql.append("  <isNotNull col=SAVETO> \n");
			//sbSql.append("  AND TO_CHAR(A.UDATE,'yyyymmdd') <= #SAVETO# \n");
			//sbSql.append("  </isNotNull> \n");
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
			sbSql.append("                A.SPHOTO_PATH, \n");
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
			sbSql.append("                A.UDATE, \n");
			sbSql.append("                E.NM_KOR, \n");
			sbSql.append("              A.PHF \n");
			*/

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