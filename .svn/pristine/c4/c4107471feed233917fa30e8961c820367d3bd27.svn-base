<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/단가관리/공급업체관리
■ 프로그램ID   : FMU00240E_T003.jsp
■ 프로그램명   : 운영율 다중업장 조회(조회)
■ 작성일자     : 2008.04.14
■ 작성자       : 박은규
■ 이력관리     : 2008.04.14
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
		//입력 파라메터
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		String sMainUpjang  = nullToBlank(in_vl.getString("sMainUpjang"));
		String sSdate       = nullToBlank(in_vl.getString("sSdate"));
		String sEdate       = nullToBlank(in_vl.getString("sEdate"));

		//out 데이타
		DataSet ds_List;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		//내역조회
		sbSql.append("SELECT A.UPJANG, A.UPJANGNM_DISP \n");
		sbSql.append("     , NVL((SELECT COUNT(1) \n");
		sbSql.append("              FROM FMU_OP_RATE Z \n");
		sbSql.append("             WHERE Z.UPJANG = A.UPJANG \n");
		sbSql.append("               AND Z.SDATE = '" + sSdate + "' \n");
		sbSql.append("               AND Z.ITEM_TYPE = 'M') \n");
		sbSql.append("          , 0) AS SAVE_FLAG \n");
		sbSql.append("     , TRUNC(NVL((SELECT AVG(OP_RATE) \n");
		sbSql.append("              FROM FMU_OP_RATE Z \n");
		sbSql.append("             WHERE Z.UPJANG = A.UPJANG \n");
		sbSql.append("               AND Z.SDATE = '" + sSdate + "' \n");
		sbSql.append("               AND Z.ITEM_TYPE = 'M') \n");
		sbSql.append("          , 0),1) AS OP_RATE_AVG \n");
		sbSql.append("     , '0' AS CHK \n");
		sbSql.append("  FROM FMS_UPJANG A \n");
		sbSql.append(" WHERE A.MAIN_UPJANG = " + sMainUpjang + " \n");
		sbSql.append("   AND A.USE_YN = 'Y' \n");
		sbSql.append(" ORDER BY 1 \n");

out_vl.add("fa_Sql", sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_List = this.makeDataSet(rs, "ds_List");
		rs.close(); 
		pstmt.close();		

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
