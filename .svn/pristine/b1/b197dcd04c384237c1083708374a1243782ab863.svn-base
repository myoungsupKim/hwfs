<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 경영관리/주간실적관리
■ 프로그램ID   : MAS40010E_T002.jsp
■ 프로그램명   : 월별손익계획저장
■ 작성일자     : 2013-12-11
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

		//입력,수정
		for ( int iRow = 0 ; iRow < ds_List.getRowCount() ; iRow++ )
		{

			//저장
			sbSql.delete(0, sbSql.length());
			sbSql.append("MERGE INTO MAS_DAILY_PL_REPORT A \n");
			sbSql.append("USING (SELECT '" + nullToBlank(ds_Cond.getString(0,    "INPUT_YM")) + "' AS INPUT_YM \n");
			sbSql.append("            , '" + nullToBlank(ds_List.getString(iRow, "P_DATE").substring(0, 10).replaceAll("-", "")) + "' AS INPUT_DD \n");
			sbSql.append("            , '" + nullToBlank(ds_Cond.getString(0, "DOC_CD")) + "' AS DOC_CD \n");
			sbSql.append("            , '" + nullToBlank(ds_List.getString(iRow, "MGMT_ACCT_CD")) + "' AS MGMT_ACCT_CD \n");
			sbSql.append("         FROM DUAL) B                   \n");
			sbSql.append("   ON (A.INPUT_YM     = B.INPUT_YM AND  \n");
			sbSql.append("       A.INPUT_DD     = B.INPUT_DD AND      \n");
			sbSql.append("       A.DOC_CD       = B.DOC_CD AND        \n");
			sbSql.append("       A.DOC_GUBUN    = 'P' AND        \n");
			sbSql.append("       A.MGMT_ACCT_CD = B.MGMT_ACCT_CD) \n");
			sbSql.append(" WHEN MATCHED THEN                      \n");
			sbSql.append("      UPDATE                            \n");
			//sbSql.append("         SET A.ACT_AMT    = " + nullToBlank(ds_List.getString(iRow, "ACT_AMT")) + " \n");
			sbSql.append("         SET A.ACT_AMT    = NVL(" + ds_List.getString(iRow, "ACT_AMT") + ", 0) \n");
			sbSql.append("           , A.UDATE      = SYSDATE \n");
			sbSql.append("           , A.UUSER      = '" + g_EmpNo + "' \n");
			sbSql.append(" WHEN NOT MATCHED THEN \n");
			sbSql.append("      INSERT ( A.INPUT_YM \n");
			sbSql.append("             , A.INPUT_DD \n");
			sbSql.append("             , A.DOC_CD \n");
			sbSql.append("             , A.MGMT_ACCT_CD \n");
			sbSql.append("             , A.DOC_GUBUN \n");
			sbSql.append("             , A.ACT_AMT \n");
			sbSql.append("             , A.CUSER \n");
			sbSql.append("             , A.CDATE \n");
			sbSql.append("             , A.UUSER \n");
			sbSql.append("             , A.UDATE ) \n");
			sbSql.append("      VALUES ( '" + nullToBlank(ds_Cond.getString(0,    "INPUT_YM")) + "' \n");
			sbSql.append("             , '" + nullToBlank(ds_List.getString(iRow, "P_DATE").substring(0, 10).replaceAll("-", "")) + "' \n");
			sbSql.append("             , '" + nullToBlank(ds_Cond.getString(0,    "DOC_CD")) + "' \n");
			sbSql.append("             , '" + nullToBlank(ds_List.getString(iRow, "MGMT_ACCT_CD")) + "' \n");
			sbSql.append("             , '" + nullToBlank(ds_Cond.getString(0,    "DOC_GUBUN")) + "' \n");
			sbSql.append("             , NVL(" + ds_List.getString(iRow,  "ACT_AMT") + ", 0) \n");
			//sbSql.append("             , DECODE(" + nullToBlank(ds_List.getString(iRow, "CONFIRM_YN")) + ", 1, 'Y', 'N') \n");
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