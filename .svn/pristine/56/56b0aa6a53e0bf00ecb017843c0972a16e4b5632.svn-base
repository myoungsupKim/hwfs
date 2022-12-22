<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../main/common.jsp" %>
<%
	Statement stmt             =  null;
	try 
	{	
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("ds_login"));

		//오토커밋 강제 false
		conn.setAutoCommit(false);
		
		DataSet in_ds  =  in_dl.get("ds_login");

		StringBuffer sbSql = new StringBuffer();

		//System.out.println("DataSet ====> ds_login : " + in_ds);
		System.out.print("Check --------->");
		if ( in_ds.getString(0,"LOGIN_YN").equals("Y")){
			sbSql.append("UPDATE	SCC_USERINFO	SET																			\n");
			sbSql.append("			LOGIN_YN		='"	+	nullToBlank(in_ds.getString(0,"LOGIN_YN"))			+"',	\n");
			sbSql.append("			LOGIN_TIME 		= SYSDATE																	\n");
			sbSql.append("WHERE    SABUN			='" +	in_ds.getString(0,"SABUN")							+"'	  	  ");
		}
		else {
			sbSql.append("UPDATE	SCC_USERINFO	SET																			\n");
			sbSql.append("			LOGIN_YN		='"	+	nullToBlank(in_ds.getString(0,"LOGIN_YN"))			+"',	\n");
			sbSql.append("			LOGOUT_TIME 		= SYSDATE																\n");
			sbSql.append("WHERE    SABUN			='" +	in_ds.getString(0,"SABUN")							+"'	  	  ");
		}
		
		stmt =  conn.createStatement();
		stmt.execute(sbSql.toString());
		stmt.close();

		conn.commit();
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