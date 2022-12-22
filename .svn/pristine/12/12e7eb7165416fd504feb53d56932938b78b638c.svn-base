<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 통합영업
■ 프로그램ID   : FMS00700E_S001.jsp
■ 프로그램명   : 식재 공휴일 제어 조회
■ 작성일자     : 2016-01-19
■ 작성자       : 강대성
■ 이력관리     : 2016-01-19
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
		DataSet ds_cond     = in_dl.get("ds_cond");
		//입력 파라메터
		//String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		//FileLog.println("d:\\aaa.txt", ds_cond);

		//out 데이타
		DataSet ds_list;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		//
		//내역조회
		sbSql.append("SELECT HOLIDAY_DATE , CODE_NAME , DECODE(CODE, NULL ,'0' ,'1') YN, DECODE(CODE, NULL ,'미적용' ,'적용') NOTE \n");
		sbSql.append("  FROM ( SELECT MM||DD HOLIDAY_DATE \n");
		sbSql.append("           FROM (SELECT "+ds_cond.getString(0, "HOLIDAY_DATE")+" MM \n");
		sbSql.append("                   FROM    DUAL) A \n");
		sbSql.append("              , (SELECT LPAD(ROWNUM,2,'0') DD \n");
		sbSql.append("                   FROM    DICT \n");
		sbSql.append("                  WHERE   ROWNUM <= 31) B \n");
		sbSql.append("          WHERE   TO_CHAR(LAST_DAY(TO_DATE(A.MM||'01','YYYYMMDD')),'DD') >= B.DD) A \n");
		sbSql.append("     , (SELECT  CODE_NAME, CODE  \n");
		sbSql.append("          FROM  SCC_COMMON_CODE \n");
		sbSql.append("         WHERE  GROUP_CODE = 'HOLIDAY_TIME')B \n");
		sbSql.append("  WHERE    A.HOLIDAY_DATE = CODE(+) \n");
		sbSql.append("  ORDER BY A.HOLIDAY_DATE \n");
		
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_list = this.makeDataSet(rs, "ds_list");
		
		pstmt.close();
		rs.close();
		
		/**종료**/
		out_dl.add(ds_list);
		this.setResultMessage(0, "OK", out_vl);

	}
	catch(Exception ex)
	{
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
