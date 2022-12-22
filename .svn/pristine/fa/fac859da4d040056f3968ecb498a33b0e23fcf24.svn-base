<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 구매관리/도시락
■ 프로그램ID   : FSP00060E_T001.jsp
■ 프로그램명   : 도시락 마감설정
■ 작성일자     : 2012-09-10
■ 작성자       : 박은규
■ 이력관리     : 2012-09-10 박은규 최초작성 CH201209_00102 FS기획팀
               2013-07-05 김동표 수정 CH201209_00102 연회웨딩팀 이일용
                                    도시락메뉴수 A,B -> A,B,C,D,E로 확대
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
		String strOrderDate = nullToBlank(in_vl.getString("strOrderDate"));
		String strCcCd      = nullToBlank(in_vl.getString("strCcCd"));
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));

		//FileLog.println("d:\\aaa.txt", ds_List);

		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		//입력,수정
		sbSql.delete(0, sbSql.length());
		sbSql.append("MERGE INTO FMP_LUNCH_CLS A \n");
		sbSql.append("USING (SELECT '" + strOrderDate + "' AS ORDER_DATE \n");
		sbSql.append("            , '" + strCcCd + "' AS CC_CD \n");
		sbSql.append("         FROM DUAL) B \n");
		sbSql.append("   ON (A.ORDER_DATE = B.ORDER_DATE AND \n");
		sbSql.append("       A.CC_CD = B.CC_CD) \n");
		sbSql.append(" WHEN MATCHED THEN \n");
		sbSql.append("      UPDATE \n");
		sbSql.append("         SET A.OPEN_FLAG = DECODE(A.OPEN_FLAG,'Y','N','Y') \n");
		sbSql.append("           , A.UDATE = SYSDATE \n");
		sbSql.append("           , A.UUSER = '" + g_EmpNo + "' \n");
		sbSql.append(" WHEN NOT MATCHED THEN \n");
		sbSql.append("      INSERT ( A.ORDER_DATE \n");
		sbSql.append("             , A.CC_CD \n");
		sbSql.append("             , A.OPEN_FLAG \n");
		sbSql.append("             , A.CDATE \n");
		sbSql.append("             , A.CUSER \n");
		sbSql.append("             , A.UDATE \n");
		sbSql.append("             , A.UUSER ) \n");
		sbSql.append("      VALUES ( B.ORDER_DATE \n");
		sbSql.append("             , B.CC_CD \n");
		sbSql.append("             , 'Y' \n");
		sbSql.append("             , SYSDATE \n");
		sbSql.append("             , '" + g_EmpNo + "' \n");
		sbSql.append("             , SYSDATE \n");
		sbSql.append("             , '" + g_EmpNo + "' \n");
		sbSql.append("             ) \n");

out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());
		pstmt.executeUpdate();
		pstmt.close();

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