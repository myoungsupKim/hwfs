<%
/*-----------------------------------------------------------------------------
■ 시스템명     : FS영업
■ 프로그램ID   : FSP00031E_T004.jsp
■ 프로그램명   : 요일 체크로직(조회)
■ 작성일자     : 2019-07-01
■ 작성자       : 김호석
■ 이력관리     : 신규생성
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	try	{
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();		
	
		// log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));

		//입력 데이타
		DataSet ds_Cond     = in_dl.get("ds_Cond");
		//입력 파라메터
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		String g_NeedDate   = nullToBlank(in_vl.getString("g_NeedDate"));
	
		//FileLog.println("d:\\aaa.txt", ds_Cond);

		//out 데이타
		DataSet ds_List;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		/*
		String sMuCode = nullToBlank(ds_Cond.getString(0, "MU"));
		String sTmCode = nullToBlank(ds_Cond.getString(0, "TM"));
		String sDate   = nullToBlank(ds_Cond.getString(0, "DT"));
		*/

		//내역조회
        sbSql.append("SELECT TO_CHAR(TO_DATE('"+g_NeedDate+"', 'YYYYMMDD') ,'d') AS WDAY, 'N' AS CHK   \n");
		sbSql.append(", DECODE((SELECT COUNT(*) FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'SC0170' AND USE_YN = 'Y' AND CODE = '"+g_NeedDate+"'),1,'Y','N') AS EXP \n");
        sbSql.append("  FROM DUAL  \n");
        //sbSql.append(" WHERE NEED_DATE = '"+g_NeedDate+"'  \n");
		//로그남기기
		logger.debug(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_List = this.makeDataSet(rs, "ds_List");
		
		pstmt.close();
		rs.close();
		
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
