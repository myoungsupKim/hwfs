<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/운영관리
■ 프로그램ID   : FMO00030E_T001.jsp
■ 프로그램명   : 가맹점메뉴 매출인원수 조회
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
		//입력 파라메터
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		String sType        = nullToBlank(in_vl.getString("sType"));
		//FileLog.println("d:\\aaa.txt", ds_Cond);

		//out 데이타
		DataSet ds_List;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		//1)메뉴Mst조회
		if (sType.equals("QryMst"))
		{
			sbSql.append("SELECT A.UPJANG \n");
			sbSql.append("     , A.UPJANGNM_DISP \n");
			sbSql.append("  FROM FMS_UPJANG A \n");
			sbSql.append(" WHERE A.MAIN_UPJANG = " + nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG")) + " \n");
			sbSql.append(" AND A.UPJANG LIKE '%'||'" +  nullToBlank(ds_Cond.getString(0, "UPJANG"))  + "'||'%'\n");
			sbSql.append(" ORDER BY A.UPJANGNM_DISP \n");
		}
		//2)메뉴Dtl조회
		else if (sType.equals("QryDtl"))
		{
			sbSql.append("SELECT " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + " AS UPJANG \n");
			sbSql.append("     , '" + nullToBlank(ds_Cond.getString(0, "SALE_YM")) + "' AS SALE_YM \n");
			sbSql.append("     , A.MENU_ID, A.MENU_NAME \n");
			sbSql.append("     , NVL(B.SALE_QTY,0) AS SALE_QTY \n");
			sbSql.append("     , DECODE(B.MENU_ID,NULL,'N','Y') AS EXI_YN \n");
			sbSql.append("  FROM FMO_MENU_MST A \n");
			sbSql.append("     , (SELECT * FROM FMO_MENU_SALE \n");
			sbSql.append("         WHERE UPJANG = '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "' \n");
			sbSql.append("           AND SALE_YM = '" + nullToBlank(ds_Cond.getString(0, "SALE_YM")) + "') B \n");
			sbSql.append(" WHERE A.MENU_ID = B.MENU_ID(+) \n");
			sbSql.append("   AND A.UPJANG = " + nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG")) + " \n");
			sbSql.append(" ORDER BY A.MENU_ID \n");
		}

out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_List = this.makeDataSet(rs, "ds_List");

		pstmt.close();
		rs.close();

		/**종료**/
		out_dl.add(ds_List);
		this.setResultMessage(0, "OK", out_vl);

	}
	catch(Exception ex)
	{
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