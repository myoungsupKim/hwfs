<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	Statement stmt = null;

	try {
		//////////////////////////////////////////////////////////
		//���α׷�  ��: FSM90800P_T001.jsp
		//��   ��   ��: 2015.07.06
		//��   ��   ��: ��μ� 
		//���α׷����: �Ĵܵ�� 
		///////////////////////////////////////////////////////////
		PlatformRequest platformRequest = this.proc_input(request);  
		in_dl = platformRequest.getData().getDataSetList();
		in_vl = platformRequest.getData().getVariableList();
		
		//jsp log ���� ���� 
		logger.startIndividualLog(in_vl.getString("titLogId"));
		
		String g_EmpNo         = in_vl.getString("g_EmpNo");
		DataSet ds_cond        = in_dl.get("ds_cond");		    // ��ȸ����
		
		String UPJANG       = nullToBlank(ds_cond.getString(0, "UPJANG"));
		String MENU_CD      = nullToBlank(ds_cond.getString(0, "MENU_CD"));
		String RECIPE_CD    = "";
		
		System.out.println("UPJANG : " + UPJANG);
		System.out.println("MENU_CD : " + MENU_CD);
		System.out.println("RECIPE_CD : " + RECIPE_CD);

		StringBuffer sbSql = new StringBuffer();
		sbSql.append("SELECT A.RECIPE_CD                                      \n");
		sbSql.append("FROM                                                    \n");
		sbSql.append("(                                                       \n");
		sbSql.append("SELECT AA.*                                             \n");
		sbSql.append("FROM(                                                   \n");
		sbSql.append("    SELECT RECIPE_CD                                    \n");
		sbSql.append("     FROM FSM_REAL_RECIPE_MST                           \n");
		sbSql.append("     WHERE MENU_CD    = '" + MENU_CD + "'               \n");
		sbSql.append("       AND UPJANG     = " + UPJANG + "                  \n");
		sbSql.append("     MINUS                                              \n");
		sbSql.append("    SELECT RECIPE_CD                                    \n");
		sbSql.append("      FROM FSM_REAL_RECIPE_ITEM                         \n");
		sbSql.append("     WHERE MENU_CD    = '" + MENU_CD + "'               \n");
		sbSql.append("       AND UPJANG     = " + UPJANG + "                  \n");
		sbSql.append("       GROUP BY RECIPE_CD                               \n");
		sbSql.append("   ) AA                                                 \n");
		sbSql.append("UNION ALL                                               \n");
		sbSql.append("SELECT BB.*                                             \n");
		sbSql.append("FROM(                                                   \n");
		sbSql.append("    SELECT RECIPE_CD                                    \n");
		sbSql.append("      FROM FSM_REAL_RECIPE_ITEM                         \n");
		sbSql.append("     WHERE MENU_CD    = '" + MENU_CD + "'               \n");
		sbSql.append("       AND UPJANG     = " + UPJANG + "                  \n");
		sbSql.append("       GROUP BY RECIPE_CD                               \n");
		sbSql.append("     MINUS                                              \n");
		sbSql.append("    SELECT RECIPE_CD                                    \n");
		sbSql.append("      FROM FSM_REAL_RECIPE_MST                          \n");
		sbSql.append("     WHERE MENU_CD    = '" + MENU_CD + "'               \n");
		sbSql.append("       AND UPJANG     = " + UPJANG + "                  \n");
		sbSql.append("		) BB                                              \n");
		sbSql.append(") A                                                     \n");
		
		pstmt = conn.prepareStatement(sbSql.toString());	
		rs = pstmt.executeQuery(); 		

		while(rs.next()) {
			
			RECIPE_CD = nullToBlank(rs.getString("RECIPE_CD"));
			
			if(nullToBlank(UPJANG).equals("") || nullToBlank(MENU_CD).equals("") || RECIPE_CD.equals("")) continue;

			sbSql.delete(0, sbSql.length());	
			sbSql.append(" DELETE FROM FSM_REAL_RECIPE_MST \n");
			sbSql.append("  WHERE UPJANG    = " + UPJANG +" \n");
			sbSql.append("    AND MENU_CD   = '" + MENU_CD + "' \n");
			sbSql.append("    AND RECIPE_CD = '" + rs.getString("RECIPE_CD") + "' \n");
			stmt = conn.createStatement();
			stmt.execute(sbSql.toString());
			stmt.close();
							
			sbSql.delete(0, sbSql.length());	
			sbSql.append(" DELETE FROM FSM_REAL_RECIPE_ITEM \n");
			sbSql.append("  WHERE UPJANG    = " + UPJANG +" \n");
			sbSql.append("    AND MENU_CD   = '" + MENU_CD + "' \n");
			sbSql.append("    AND RECIPE_CD = '" + rs.getString("RECIPE_CD") + "' \n");
			stmt = conn.createStatement();
			stmt.execute(sbSql.toString());
			stmt.close();
			
			sbSql.delete(0, sbSql.length());	
			sbSql.append(" DELETE FROM FSM_REAL_RECIPE_CUISINE \n");
			sbSql.append("  WHERE UPJANG    = " + UPJANG +" \n");
			sbSql.append("    AND MENU_CD   = '" + MENU_CD + "' \n");
			sbSql.append("    AND RECIPE_CD = '" + rs.getString("RECIPE_CD") + "' \n");
			stmt = conn.createStatement();
			stmt.execute(sbSql.toString());
			stmt.close();
		
		}
		
		//Ʈ����� ����
		conn.commit();		
		this.setResultMessage(0, "OK", out_vl);		
		
	} catch(Exception ex) {	
		ex.printStackTrace();
		//Ʈ����� ����
		conn.rollback();
		//jsp �α׳����
		logger.debug(ex.getMessage(), ex);
		//�޼�����ȯ
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
		//jsp log ���� �ݱ� 
		try {
			logger.endIndividualLog();
		} catch( Exception logE) {
			logE.printStackTrace();
		}				
	}
	
    proc_output(response,out,out_vl,out_dl);
%>