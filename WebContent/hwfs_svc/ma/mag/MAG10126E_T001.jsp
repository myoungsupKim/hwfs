<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 영업관리/마감관리자조정
■ 프로그램ID   : MAG10126E_T001.jsp
■ 프로그램명   : 월마감/취소
■ 작성일자     : 2012.06.04
■ 작성자       : 박은규
■ 이력관리     : 2012.06.04
박은규 2012-06-04 CSR#(CH201205_00175) 요청자:박현주(FS지원팀)
최초생성
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
		//DataSet ds_Cond     = in_dl.get("ds_Cond");
		//DataSet ds_List     = in_dl.get("ds_List");
		//입력 파라메터
		String strMonth     = nullToBlank(in_vl.getString("strMonth"));
		String strClsFlag   = nullToBlank(in_vl.getString("strClsFlag"));
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
	
		//FileLog.println("d:\\aaa.txt", ds_List);
		
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		sbSql.delete(0, sbSql.length());
		sbSql.append("MERGE INTO SCC_COMMON_CODE A \n");
		sbSql.append("USING DUAL \n");
		sbSql.append("ON ( A.GROUP_CODE = 'MA0044' AND A.CODE = '" + strMonth + "' ) \n");
		sbSql.append("WHEN MATCHED THEN \n");
		sbSql.append("     UPDATE SET \n");
		sbSql.append("            A.CODE_NAME = '" + strClsFlag + "' \n");
		sbSql.append("          , A.UUSER = '" + g_EmpNo + "' \n");
		sbSql.append("          , A.UDATE = SYSDATE \n");
		sbSql.append("WHEN NOT MATCHED THEN \n");
		sbSql.append("     INSERT ( GROUP_CODE \n");
		sbSql.append("            , CODE \n");
		sbSql.append("            , CODE_NAME \n");
		sbSql.append("            , CONTENTS \n");
		sbSql.append("            , CUSER \n");
		sbSql.append("            , CDATE \n");
		sbSql.append("   ) VALUES ( 'MA0044' \n");
		sbSql.append("            , '" + strMonth + "' \n");
		sbSql.append("            , '" + strClsFlag + "' \n");
		sbSql.append("            , TO_CHAR(TO_DATE('" + strMonth + "', 'YYYYMM'), 'YYYY\"년\"MM\"월 마감현황\"') \n");
		sbSql.append("            , '" + g_EmpNo + "' \n");
		sbSql.append("            , SYSDATE \n");
		sbSql.append("            ) \n");
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