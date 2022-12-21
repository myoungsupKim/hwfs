
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
		
		String UPJANG      = in_vl.getString("UPJANG");
		String HALL_CLASS  = in_vl.getString("HALL_CLASS");
		String RECIPE_CD   = in_vl.getString("RECIPE_CD");
		String BEFORE_ITEM_CODE = in_vl.getString("BEFORE_ITEM_CODE");
		String AFTER_ITEM_CODE  = in_vl.getString("AFTER_ITEM_CODE");
		
		conn.setAutoCommit(false);
		
		StringBuffer sbSelSql = new StringBuffer();
		StringBuffer sbUpdSql = new StringBuffer();
	
		//업장배분 여부 확인
		sbSelSql.delete(0, sbSelSql.length());
		sbSelSql.append("SELECT 1 FROM FSR_UPJANG_RECIPE_ITEM WHERE UPJANG = " + UPJANG + " AND HALL_CLASS ='" +HALL_CLASS+"' AND RECIPE_CD = '"+ RECIPE_CD +"' AND ITEM_CODE = '"+ AFTER_ITEM_CODE +"' AND ROWNUM >= 1 \n");

		stmt = conn.createStatement();		
		rs = stmt.executeQuery(sbSelSql.toString()); 
		
		if(rs.next())
		{
			out_vl.add("strSetCnt", "해당 자재는 이미 등록되어 있습니다.");
		   	this.setResultMessage(0, "OK",out_vl);	
		   	proc_output(response,out,out_vl,out_dl);
		   	return;
		}

		rs.close();
		stmt.close();
		
		//업장 자재변경 UPDATE 문 실행
		sbUpdSql.delete(0, sbUpdSql.length());
		
		sbUpdSql.append("UPDATE FSR_UPJANG_RECIPE_ITEM SET ITEM_CODE='"+ AFTER_ITEM_CODE +"' WHERE  UPJANG = " + UPJANG + " AND HALL_CLASS ='" +HALL_CLASS+"' AND RECIPE_CD = '"+ RECIPE_CD +"' AND ITEM_CODE = '"+ BEFORE_ITEM_CODE +"'");

		stmt = conn.createStatement();
		stmt.execute(sbUpdSql.toString());
		
		conn.commit();
		
	   	this.setResultMessage(0, "OK",out_vl);
		
	}
	catch(Exception ex) 
	{
		conn.rollback();
		//ex.printStackTrace();
		//jsp 로그남기기
		logger.debug(ex.getMessage(), ex);		   
		this.setResultMessage(-1, ex.toString(),out_vl);
	} 
	finally 
	{
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