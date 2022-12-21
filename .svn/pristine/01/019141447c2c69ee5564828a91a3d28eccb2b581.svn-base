<%                                                                                                                                                                                                      
/*-----------------------------------------------------------------------------                                                                                                                         
■ 시스템명     : 메뉴관리/강제레시피                                                                                                                                                                   
■ 프로그램ID   : FSR90100E_T001.jsp                                                                                                                                                                    
■ 프로그램명   : 강제레시피관리 - 강제레시피조회                                                                                                                                               
■ 작성일자     : 2015-02-23                                                                                                                                                                           
■ 작성자       : 김민수                                                                                                                                                                                
■ 이력관리     :                                                                                                                                                                             
-----------------------------------------------------------------------------*/                                                                                                                         
%> 

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
		String RECIPE_NAME 			= nullToBlank(ds_cond.getString(0,"RECIPE_NAME"));                                                                                                                                                                                                        
		String RECIPE_CLASS 		= nullToBlank(ds_cond.getString(0,"RECIPE_CLASS"));                                                                                                                           
		String RECIPE_TYPE			= nullToBlank(ds_cond.getString(0,"RECIPE_TYPE"));                                                                                                                          
		String CUISINE_TYPE			= nullToBlank(ds_cond.getString(0,"CUISINE_TYPE"));
		String MAIN_ITEM_CODE1		= nullToBlank(ds_cond.getString(0,"MAIN_ITEM_CODE1"));
		String RESP_NUT1			= nullToBlank(ds_cond.getString(0,"RESP_NUT1"));		
		String GRP_SEQ				= nullToBlank(ds_cond.getString(0,"GRP_SEQ"));

		StringBuffer sbSql = new StringBuffer();
	
		if(conn!=null)
		{							
			sbSql.delete(0, sbSql.length());
			sbSql.append("SELECT A.RECIPE_CD                                      \n");                                                                 
			sbSql.append("     , A.RECIPE_NAME                                    \n");                                                                 
			sbSql.append("     , A.RECIPE_CLASS                                   \n");                                                                 
			sbSql.append("     , A.RECIPE_TYPE                                    \n");                                                                 
			sbSql.append("     , A.CUISINE_TYPE                                   \n");                                                                 
			sbSql.append("     , A.MAIN_ITEM_CODE1                                \n");                                                                 
			sbSql.append("     , A.RESP_NUT1                                      \n");
			sbSql.append("     , B.GRP_SEQ                                        \n");
			sbSql.append("     , B.GRP_NAME                                       \n");
			sbSql.append("     , B.ENF_YN                                         \n");
			sbSql.append("     , 0 AS CHK                                         \n");
			sbSql.append("  FROM FSR_STD_RECIPE_MST A                             \n");
			sbSql.append("     ,(SELECT L.GRP_SEQ                                 \n");
			sbSql.append("            , M.GRP_NAME                                \n");
			sbSql.append("            , L.RECIPE_CD                               \n");
			sbSql.append("            , M.ENF_YN                                  \n");
			sbSql.append("         FROM FSR_ENF_RECIPE L                          \n");
			sbSql.append("            , FSR_ENF_RECIPE_GRP M                      \n");
			sbSql.append("        WHERE L.GRP_SEQ = M.GRP_SEQ) B                  \n");
			sbSql.append(" WHERE A.RECIPE_CD = B.RECIPE_CD                        \n");
			sbSql.append("   AND B.ENF_YN = 'Y'                                   \n");
			
			if(!RECIPE_CLASS.equals("")) {
				sbSql.append("  AND A.RECIPE_CLASS='"+RECIPE_CLASS+"' \n");
			}
			if(!RECIPE_TYPE.equals("")) {
				sbSql.append("  AND A.RECIPE_TYPE='"+RECIPE_TYPE+"' \n");
			}
			if(!CUISINE_TYPE.equals("")) {
				sbSql.append("  AND A.CUISINE_TYPE='"+CUISINE_TYPE+"' \n");
			}
			if(!MAIN_ITEM_CODE1.equals("")) {
				sbSql.append("  AND A.MAIN_ITEM_CODE1 ='"+MAIN_ITEM_CODE1+"' \n");
			}
			if(!RESP_NUT1.equals("")) {
				sbSql.append("  AND A.RESP_NUT1 ='"+RESP_NUT1+"' \n");
			}
			if(!GRP_SEQ.equals("")) {
				sbSql.append("  AND B.GRP_SEQ ='"+GRP_SEQ+"' \n");
			}
			
			if(!RECIPE_NAME.equals("")) {
				String[] arrSameWord = RECIPE_NAME.split(" ");
				
				sbSql.append("  AND ( \n");
				for(int i=0; i<arrSameWord.length; i++) {
					sbSql.append("   A.SAME_WORD LIKE '%'||'"+arrSameWord[i]+"'||'%' \n");
					sbSql.append("OR A.RECIPE_NAME LIKE '%'||'"+arrSameWord[i]+"'||'%' \n");
					if(i < arrSameWord.length-1) {
						sbSql.append("  OR \n");
					}
				}
				sbSql.append("  ) \n");
			}            
			
			sbSql.append("ORDER BY B.GRP_SEQ DESC, A.RECIPE_NAME ASC  \n");
			
			pstmt = conn.prepareStatement(sbSql.toString());
			rs = pstmt.executeQuery(); 
			
			DataSet ds_MainRecipeList = this.makeDataSet(rs,"ds_recipeList");
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