<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/운영관리
■ 프로그램ID   : FMO00020E_T002.jsp
■ 프로그램명   : 가맹점메뉴 설정저장
■ 작성일자     : 2010.06.14
■ 작성자       : 박은규
■ 이력관리     : 2010.06.14
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
		String sType        = nullToBlank(in_vl.getString("sType"));

		//FileLog.println("d:\\aaa.txt", ds_List);
		
		//변수선언
		int sRowStatus;
		
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		//입력,수정
		for ( int i = 0 ; i < ds_List.getRowCount() ; i++ )
		{
			sbSql.delete(0, sbSql.length());

			sRowStatus = ds_List.getRowType(i);
			
			if (sRowStatus == DataSet.ROW_TYPE_NORMAL)
			{
				continue;
			}
			else if (sRowStatus == DataSet.ROW_TYPE_INSERTED)
			{
				if (sType.equals("SavMst"))
				{
					sbSql.append("INSERT INTO FMO_MENU_MST \n");
					sbSql.append("    ( MENU_ID \n");
					sbSql.append("    , MENU_NAME \n");
					sbSql.append("    , UPJANG \n");
					sbSql.append("    , CONTENTS \n");
					sbSql.append("    , USE_YN \n");
					sbSql.append("    , CUSER \n");
					sbSql.append("    , CDATE \n");
					sbSql.append("    , UUSER \n");
					sbSql.append("    , UDATE ) \n");
					sbSql.append("SELECT FMO_MENU_MST_S.NEXTVAL AS MENU_ID \n");
					sbSql.append("     , '" + nullToBlank(ds_List.getString(i, "MENU_NAME")) + "' AS MENU_NAME \n");
					sbSql.append("     , " + nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG")) + " AS UPJANG \n");
					sbSql.append("     , NULL AS CONTENTS \n");
					sbSql.append("     , SCC_YN_FUN(" + nullToBlank(ds_List.getString(i, "USE_YN")) + ",'I') AS USE_YN \n");
					sbSql.append("     , '" + g_EmpNo + "' AS CUSER \n");
					sbSql.append("     , SYSDATE AS CDATE \n");
					sbSql.append("     , '" + g_EmpNo + "' AS UUSER \n");
					sbSql.append("     , SYSDATE AS UDATE \n");
					sbSql.append("  FROM DUAL \n");
				}
				else
				{
					sbSql.append("INSERT INTO FMO_MENU_DTL \n");
					sbSql.append("    ( MENU_ID \n");
					sbSql.append("    , ITEM_CODE \n");
					sbSql.append("    , STD_QTY \n");
					sbSql.append("    , CONTENTS \n");
					sbSql.append("    , USE_YN \n");
					sbSql.append("    , CUSER \n");
					sbSql.append("    , CDATE \n");
					sbSql.append("    , UUSER \n");
					sbSql.append("    , UDATE ) \n");
					sbSql.append("SELECT " + nullToBlank(ds_Cond.getString(0, "MENU_ID")) + " AS MENU_ID \n");
					sbSql.append("     , '" + nullToBlank(ds_List.getString(i, "ITEM_CODE")) + "' AS ITEM_CODE \n");
					sbSql.append("     , " + nullToBlank(ds_List.getString(i, "STD_QTY")) + " AS STD_QTY \n");
					sbSql.append("     , NULL AS CONTENTS \n");
					sbSql.append("     , 'Y' AS USE_YN \n");
					sbSql.append("     , '" + g_EmpNo + "' AS CUSER \n");
					sbSql.append("     , SYSDATE AS CDATE \n");
					sbSql.append("     , '" + g_EmpNo + "' AS UUSER \n");
					sbSql.append("     , SYSDATE AS UDATE \n");
					sbSql.append("  FROM DUAL \n");
				}
			}
			else if (sRowStatus == DataSet.ROW_TYPE_UPDATED)
			{
				if (sType.equals("SavMst"))
				{
					sbSql.append("UPDATE FMO_MENU_MST \n");
					sbSql.append("   SET MENU_NAME = '" + nullToBlank(ds_List.getString(i, "MENU_NAME")) + "' \n");
					sbSql.append("     , USE_YN = SCC_YN_FUN(" + nullToBlank(ds_List.getString(i, "USE_YN")) + ",'U') \n");
					sbSql.append("     , UUSER = '" + g_EmpNo + "' \n");
					sbSql.append("     , UDATE = SYSDATE \n");
					sbSql.append(" WHERE MENU_ID = " + nullToBlank(ds_List.getString(i, "MENU_ID")) + " \n");
				}
				else
				{
					sbSql.append("UPDATE FMO_MENU_DTL \n");
					sbSql.append("   SET STD_QTY = " + nullToBlank(ds_List.getString(i, "STD_QTY")) + " \n");
					sbSql.append("     , UUSER = '" + g_EmpNo + "' \n");
					sbSql.append("     , UDATE = SYSDATE \n");
					sbSql.append(" WHERE MENU_ID = " + nullToBlank(ds_List.getString(i, "MENU_ID")) + " \n");
					sbSql.append("   AND ITEM_CODE = '" + nullToBlank(ds_List.getString(i, "ITEM_CODE")) + "' \n");
				}
			}
out_vl.add("fa_Sql", sbSql.toString());
			//System.out.println(sbSql.toString());
			pstmt = conn.prepareStatement(sbSql.toString());
			pstmt.executeUpdate();
			pstmt.close();
		}

		//삭제
		for ( int i = 0 ; i < ds_List.getRemovedRowCount() ; i++ )
		{
			sbSql.delete(0, sbSql.length());

			if (sType.equals("SavMst"))
			{
				sbSql.append("DELETE FROM FMO_MENU_MST \n");
				sbSql.append(" WHERE MENU_ID = " + ds_List.getRemovedData(i, "MENU_ID").toString() + " \n");
			}
			else
			{
				sbSql.append("DELETE FROM FMO_MENU_DTL \n");
				sbSql.append(" WHERE MENU_ID = " + ds_List.getRemovedData(i, "MENU_ID").toString() + " \n");
				sbSql.append("   AND ITEM_CODE = '" + ds_List.getRemovedData(i, "ITEM_CODE").toString() + "' \n");
			}
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