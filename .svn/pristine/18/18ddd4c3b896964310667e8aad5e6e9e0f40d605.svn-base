<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	try {
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));
		
		String RECIPE_TYPE 			= in_vl.getString("RECIPE_TYPE");                                                                                                                                                                                                        
		String CUISINE_TYPE 		= in_vl.getString("CUISINE_TYPE");                                                                                                                           
		String RECIPE_NAME			= in_vl.getString("RECIPE_NAME");                                                                                                                          

		
		StringBuffer sbSql = new StringBuffer();
		
		if(conn!=null)
		{							
			sbSql.delete(0, sbSql.length());
			
			sbSql.append("SELECT DISTINCT SUBSTR(RECIPE_CD,2,5) RECIPE_CD,RECIPE_TYPE,CUISINE_TYPE,RECIPE_NAME \n");
			sbSql.append("	FROM   FSR_STD_RECIPE_MST \n");
			sbSql.append("	WHERE  1=1 \n");
			if(!RECIPE_TYPE.equals(""))
			{
			sbSql.append("  AND RECIPE_TYPE='"+RECIPE_TYPE+"' \n");
			}
			if(!CUISINE_TYPE.equals(""))
			{
			sbSql.append("  AND CUISINE_TYPE='"+CUISINE_TYPE+"' \n");
			}
			if(!RECIPE_NAME.equals(""))
			{
			sbSql.append("  AND RECIPE_NAME LIKE '%'||'"+RECIPE_NAME+"'||'%' \n");
			}
			sbSql.append("	ORDER BY RECIPE_CD,RECIPE_TYPE,CUISINE_TYPE \n");



			pstmt = conn.prepareStatement(sbSql.toString());
			
			rs = pstmt.executeQuery(); 

//			out_dl.add("DS_body", this.makeDataSet(rs,"DS_body"));
			
			DataSet ds_List = this.makeDataSet(rs,"ds_List");
			out_dl.add(ds_List);
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