<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 경영관리/주간실적마감
■ 프로그램ID   : MAS40020E_T002.jsp
■ 프로그램명   : 일별손익실적마감
■ 작성일자     : 2013-12-02
■ 작성자       : 김장욱
■ 이력관리     : 
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	try	{
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();

		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));		

		//입력 데이타
		DataSet ds_Cond     = in_dl.get("ds_Cond");
		DataSet ds_List     = in_dl.get("ds_List");
		//입력 파라메터
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));

		//FileLog.println("d:\\aaa.txt", ds_List);

		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

//System.out.print(ds_List.getRowCount() + "<<<<<<------------------------>>>>>" );

		//입력,수정
		for ( int iRow = 0 ; iRow < ds_List.getRowCount() ; iRow++ )
		{
			//if (ds_List.getRowType(iRow).equals("normal"))
			//{
			//	continue;
			//}
			//저장
			sbSql.delete(0, sbSql.length());
			sbSql.append("MERGE INTO MAS_DAILY_CLOSE A \n");
			sbSql.append("USING (SELECT '" + nullToBlank(ds_Cond.getString(0,    "INPUT_YM")) + "' AS INPUT_YM \n");
			sbSql.append("            , '" + nullToBlank(ds_List.getString(iRow, "CLOSE_DD")) + "' AS CLOSE_DD \n");
			sbSql.append("            , '" + nullToBlank(ds_List.getString(iRow, "DOC_CD")) + "' AS DOC_CD \n");
			sbSql.append("         FROM DUAL) B                   \n");
			sbSql.append("   ON (A.INPUT_YM     = B.INPUT_YM AND  \n");
			sbSql.append("       A.CLOSE_DD     = B.CLOSE_DD AND      \n");
			sbSql.append("       A.DOC_CD       = B.DOC_CD)        \n");
			sbSql.append(" WHEN MATCHED THEN                      \n");
			sbSql.append("      UPDATE                            \n");
			
			// 마감자가 팀장이면(F), 기획팀이면(S) 
			if(ds_Cond.getString(0, "USER_DIV").equals("F")){
				sbSql.append("      SET A.FST_CLOSE_SABUN = DECODE(" + nullToBlank(ds_List.getString(iRow, "CLOSE_YN")) + ", 1, '" + g_EmpNo + "', NULL) \n");							
			}else{
				sbSql.append("      SET A.SND_CLOSE_SABUN = DECODE(" + nullToBlank(ds_List.getString(iRow, "CLOSE_YN")) + ", 1, '" + g_EmpNo + "', NULL) \n");				
			}

			
			// 마감자가 팀장이면(F), 기획팀이면(S) 
			if(ds_Cond.getString(0, "USER_DIV").equals("F")){
				sbSql.append("         , A.CLOSE_YN = DECODE(" + nullToBlank(ds_List.getString(iRow, "CLOSE_YN")) + ", 1, 'Y', 'N') \n");							
			}else{
				// 기획팀 마감일 경우만 Y로 업데이트 한다.
				if(ds_List.getString(iRow, "CLOSE_YN").equals("1")){	
					sbSql.append("         , A.CLOSE_YN = DECODE(" + nullToBlank(ds_List.getString(iRow, "CLOSE_YN")) + ", 1, 'Y', 'N') \n");
				// 기획팀이 마감을 풀때 팀장이 마감(FST_CLOSE_SABUN IS NOT NULL)한 것이 있으면 'N'으로 그렇지 않으면 'Y'로 업데이트한다. 	
				}else{
					sbSql.append("         , A.CLOSE_YN = DECODE(FST_CLOSE_SABUN, NULL, 'N', 'Y') \n");
				}
			}
			
			
			sbSql.append("           , A.UDATE      = SYSDATE \n");
			sbSql.append("           , A.UUSER      = '" + g_EmpNo + "' \n");
			sbSql.append(" WHEN NOT MATCHED THEN \n");
			sbSql.append("      INSERT ( A.INPUT_YM \n");
			sbSql.append("             , A.CLOSE_DD \n");
			sbSql.append("             , A.DOC_CD \n");
			sbSql.append("             , A.CLOSE_YN \n");
			
			// 마감자가 팀장이면(F), 기획팀이면(S) 
			if(ds_Cond.getString(0, "USER_DIV").equals("F")){
				sbSql.append("             , A.FST_CLOSE_SABUN \n");
			}else{
				sbSql.append("             , A.SND_CLOSE_SABUN \n");
			}
			
			sbSql.append("             , A.CUSER \n");
			sbSql.append("             , A.CDATE \n");
			sbSql.append("             , A.UUSER \n");
			sbSql.append("             , A.UDATE ) \n");
			sbSql.append("      VALUES ( '" + nullToBlank(ds_Cond.getString(0,    "INPUT_YM")) + "' \n");
			sbSql.append("             , '" + nullToBlank(ds_List.getString(iRow, "CLOSE_DD")) + "' \n");
			sbSql.append("             , '" + nullToBlank(ds_List.getString(iRow, "DOC_CD")) + "' \n");
			sbSql.append("             , DECODE(" + nullToBlank(ds_List.getString(iRow, "CLOSE_YN")) + ", 1, 'Y', 'N') \n");
			sbSql.append("             , DECODE(" + nullToBlank(ds_List.getString(iRow, "CLOSE_YN")) + ", 1, '" + g_EmpNo + "', NULL) \n");
			sbSql.append("             , '" + g_EmpNo + "' \n");
			sbSql.append("             , SYSDATE \n");
			sbSql.append("             , '" + g_EmpNo + "' \n");
			sbSql.append("             , SYSDATE \n");
			sbSql.append("             ) \n");

out_vl.add("fa_Sql", sbSql.toString());
			//System.out.println(sbSql.toString());
			pstmt = conn.prepareStatement(sbSql.toString());
			pstmt.executeUpdate();
			pstmt.close();
		}

		/**종료**/
		conn.commit();
		this.setResultMessage(0, "OK", out_vl);

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