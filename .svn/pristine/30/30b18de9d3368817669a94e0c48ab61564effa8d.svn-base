<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업
■ 프로그램ID   : FMP01150E_T001.jsp
■ 프로그램명   : 공휴일 입고일 제외업장관리(조회)
■ 작성일자     : 2015-11-27
■ 작성자       : 박용대
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
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
	
		//FileLog.println("d:\\aaa.txt", ds_Cond);

		//out 데이타
		DataSet ds_List;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		String sMuCode = nullToBlank(ds_Cond.getString(0, "MU"));
		String sTmCode = nullToBlank(ds_Cond.getString(0, "TM"));
		String sDate   = nullToBlank(ds_Cond.getString(0, "DT"));

		//내역조회
        sbSql.append("SELECT UPJANG                                                                                                          \n");
        sbSql.append("     , UPJANGNM, 0 AS CHK                                                                                                        \n");
        sbSql.append("  FROM ST_UPJANG                                                                                                       \n");
        sbSql.append(" WHERE UPJANG IN (                                                                                                     \n");
        sbSql.append("        SELECT A.UPJANG                                                                                                \n");
        sbSql.append("          FROM SCO_UPJANG_MST_V A                                                                                      \n");
        sbSql.append("         WHERE 1=1                                                                                                     \n");
        sbSql.append("           AND CASE WHEN A.CLOSE_DATE IS NULL THEN 'N' ELSE CASE WHEN A.CLOSE_DATE = '99991231' THEN 'N' ELSE 'Y' END END = 'N' \n");
        sbSql.append("           AND A.CC_CD IN (SELECT CC_CD FROM SCC_CC WHERE ORG_LEVEL_CD10 NOT LIKE '%Z')                                \n");
        sbSql.append("           AND A.MU_CD = '"+sMuCode+"'                                                                                        \n");
        sbSql.append("           AND (A.TM_CD = '"+sTmCode+"' OR A.PT_CD = '"+sTmCode+"')                                                                    \n");
        sbSql.append("         MINUS                                                                                                         \n");
        sbSql.append("        SELECT A.UPJANG                                                                                                \n");
        sbSql.append("          FROM FSP_HOLIDAY_UPJANG A                                                                                    \n");
        sbSql.append("         WHERE NEED_DATE = '"+sDate+"'                                                                                  \n");
        sbSql.append("        )                                                                                                              \n");

		//로그남기기
		logger.debug(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_List = this.makeDataSet(rs, "ds_List");
		
		pstmt.close();
		rs.close();
		
		//out 데이타
		DataSet ds_List1;
		//sql문 버퍼생성
		StringBuffer sbSql1 = new StringBuffer();
        sbSql1.append("SELECT 0 AS CHK, A.UPJANG                                                              \n");
        sbSql1.append("     , (SELECT Z.UPJANGNM FROM ST_UPJANG Z WHERE Z.UPJANG = A.UPJANG) AS UPJANGNM \n");
        sbSql1.append("     , A.REMARK                                                              \n");
        sbSql1.append("  FROM FSP_HOLIDAY_UPJANG A                                                 \n"); 
        sbSql1.append(" WHERE A.NEED_DATE = '"+sDate+"'                                              \n");
        sbSql1.append("   AND A.TM_CD     = '"+sTmCode+"'                                                   \n");
		//내역조회

		//로그남기기
		logger.debug(sbSql1.toString());
		pstmt = conn.prepareStatement(sbSql1.toString());		
		rs = pstmt.executeQuery(); 
		ds_List1 = this.makeDataSet(rs, "ds_List1");
				
		pstmt.close();
		rs.close();

		/**종료**/
		out_dl.add(ds_List);
		out_dl.add(ds_List1);
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
