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
		
		String p_ACCTCD 	= nullToBlank(in_vl.getString("p_ACCTCD"));
		String p_BUD_CLS 	= nullToBlank(in_vl.getString("p_BUD_CLS"));	

		String strACCTCD = p_ACCTCD;
		String strACCTNM = "";
		String strYAESAN = "";
		String strBudCls = "";
		String strBudClsNm = "";
		String strBudClsYn = "N";

/* 		if(conn != null && !conn.isClosed()) conn.close();
		
		conn = getIRISConn(); */
		
	
		StringBuffer sbSelSql = new StringBuffer();
	
		sbSelSql.delete(0, sbSelSql.length());

		sbSelSql.append("SELECT ACCTNM6||'-'||ACCTNM1||'-'||ACCTNM2||'-'||ACCTNM3||'-'||ACCTNM4||'-'||ACCTNM5 ACCTNM, YAESAN \n");
		sbSelSql.append("  FROM ST_ACCOUNT \n");
		sbSelSql.append(" WHERE ACCTCD = '" + p_ACCTCD + "' \n");
   
		//pstmt = conn.prepareStatement(sbSelSql.toString());		
		//rs = pstmt.executeQuery();
		
		stmt = conn.createStatement();		
		rs = stmt.executeQuery(sbSelSql.toString()); 			
		
		if(rs.next())
		{
			strACCTNM = rs.getString("ACCTNM");
			strYAESAN = rs.getString("YAESAN");
		}
		
		rs.close();
		stmt.close();
		
		if(strYAESAN.equals("1")) 
		{
			strBudClsYn = "N";
			strBudCls = " ";
			strBudClsNm = "관리항목 없음";
		}
		else
		{
			sbSelSql.delete(0, sbSelSql.length());

			sbSelSql.append("SELECT BUD_CLS, BUDCLS_NM \n");
			sbSelSql.append("  FROM PL_BUDCLS A \n");
			sbSelSql.append(" WHERE ACCTCD = '" + p_ACCTCD + "' \n");
			sbSelSql.append("   AND BUD_CLS = '" + p_BUD_CLS + "' \n");
	   
			//pstmt = conn.prepareStatement(sbSelSql.toString());		
			//rs = pstmt.executeQuery();
			stmt = conn.createStatement();		
			rs = stmt.executeQuery(sbSelSql.toString()); 			
			
			if(rs.next())
			{
				strBudCls = rs.getString("BUD_CLS");
				strBudClsNm = rs.getString("BUDCLS_NM");
			}
			
			rs.close();
			stmt.close();

			if(strBudCls.equals(""))
			{
				sbSelSql.delete(0, sbSelSql.length());
	
				sbSelSql.append("SELECT BUD_CLS, BUDCLS_NM \n");
				sbSelSql.append("  FROM PL_BUDCLS \n");
				sbSelSql.append(" WHERE ACCTCD = '" + p_ACCTCD + "' \n");
				sbSelSql.append("   AND ROWNUM   = 1 \n");
		   
				//pstmt = conn.prepareStatement(sbSelSql.toString());		
				//rs = pstmt.executeQuery();
				stmt = conn.createStatement();		
				rs = stmt.executeQuery(sbSelSql.toString()); 			
				
				if(rs.next())
				{
					strBudCls = rs.getString("BUD_CLS");
					strBudClsNm = rs.getString("BUDCLS_NM");
				}
				else
				{
					strBudCls = " ";
					strBudClsNm = "관리항목 없음";
				}
				
				rs.close();
				stmt.close();
			}
		}
		
		out_vl.add("strACCTCD", strACCTCD);
		out_vl.add("strACCTNM", strACCTNM);
		out_vl.add("strBudCls", strBudCls);
		out_vl.add("strBudClsNm", strBudClsNm);
		out_vl.add("strBudClsYn", strBudClsYn);
		
	   	this.setResultMessage(0, "OK",out_vl);
	   	
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