<%@page import="com.sz.util.AppDataUtility"%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	Statement stmt             =  null;
	try {
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));
			
		String UPJANG 		= nullToBlank(in_vl.getString("UPJANG"));		
		String HALL_CLASS 	= nullToBlank(in_vl.getString("HALL_CLASS"));
		String RECIPE_CD 	= nullToBlank(in_vl.getString("RECIPE_CD"));

		stmt 		=  conn.createStatement();

		DataSet ds_out;
		StringBuffer sbSql = new StringBuffer();
		
		sbSql.delete(0, sbSql.length());
		sbSql.append("SELECT * \n");
		sbSql.append("FROM FSR_UPJANG_RECIPE_MST \n");
		sbSql.append("WHERE UPJANG = "+UPJANG+" \n");
		sbSql.append("AND HALL_CLASS = '"+HALL_CLASS+"' \n");
		sbSql.append("AND RECIPE_CD = '"+RECIPE_CD+"' \n");
		
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery();
	
		DataSet ds_rCnt = this.makeDataSet(rs,"ds_rCnt");
		out_dl.add(ds_rCnt);

		sbSql.delete(0, sbSql.length());		
		sbSql.append("SELECT * \n");
		sbSql.append("  FROM FSR_UPJANG_RECIPE_ITEM  \n");
		sbSql.append(" WHERE UPJANG = "+UPJANG+" \n");
		sbSql.append("   AND HALL_CLASS = '"+HALL_CLASS+"' \n");
		sbSql.append("   AND RECIPE_CD = '"+RECIPE_CD+"' \n");
		
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery();
		
		DataSet ds_iCnt = this.makeDataSet(rs,"ds_iCnt");
		out_dl.add(ds_iCnt);
		
		this.setResultMessage(0, "OK",out_vl);
		
	} catch(Exception ex) {
		//ex.printStackTrace();
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
		proc_output(response,out,out_vl,out_dl);
	}
%>