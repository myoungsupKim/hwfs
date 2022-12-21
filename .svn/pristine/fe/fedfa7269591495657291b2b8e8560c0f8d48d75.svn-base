<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 경영관리/손익실적
■ 프로그램ID   : MAS40090E_S001.jsp
■ 프로그램명   : 일손익실적관리
■ 작성일자     : 2014-02-17
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
		//입력 파라메터
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		
		//FileLog.println("d:\\aaa.txt", ds_Cond);

		//out 데이타
		DataSet ds_List;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

        sbSql.append("SELECT A10.UPJANG                                                    \n");
        sbSql.append("     , A10.UPJANGNM                                                  \n");
        sbSql.append("     , TO_CHAR(TO_DATE(A10.INPUT_YM, 'YYYY-MM'), 'YYYY-MM') AS INPUT_YM \n");
        sbSql.append("     , B10.M_RATE                                                    \n");
        sbSql.append("  FROM (                                                             \n");
        sbSql.append("        SELECT A.UPJANG                                              \n");
        sbSql.append("             , A.UPJANGNM                                            \n");
        sbSql.append("             , B.INPUT_YM                                            \n");
        sbSql.append("          FROM SCO_UPJANG_MST_V       A,                             \n");
        sbSql.append("               (                                                     \n");
        sbSql.append("                SELECT '" + ds_Cond.getString(0, "INPUT_YM") + "'||'01' INPUT_YM FROM DUAL               \n");
        sbSql.append("                UNION ALL                                            \n");
        sbSql.append("                SELECT '" + ds_Cond.getString(0, "INPUT_YM") + "'||'02' FROM DUAL                        \n");
        sbSql.append("                UNION ALL                                            \n");
        sbSql.append("                SELECT '" + ds_Cond.getString(0, "INPUT_YM") + "'||'03' FROM DUAL                        \n");
        sbSql.append("                UNION ALL                                            \n");
        sbSql.append("                SELECT '" + ds_Cond.getString(0, "INPUT_YM") + "'||'04' FROM DUAL                        \n");
        sbSql.append("                UNION ALL                                            \n");
        sbSql.append("                SELECT '" + ds_Cond.getString(0, "INPUT_YM") + "'||'05' FROM DUAL                        \n");
        sbSql.append("                UNION ALL                                            \n");
        sbSql.append("                SELECT '" + ds_Cond.getString(0, "INPUT_YM") + "'||'06' FROM DUAL                        \n");
        sbSql.append("                UNION ALL                                            \n");
        sbSql.append("                SELECT '" + ds_Cond.getString(0, "INPUT_YM") + "'||'07' FROM DUAL                        \n");
        sbSql.append("                UNION ALL                                            \n");
        sbSql.append("                SELECT '" + ds_Cond.getString(0, "INPUT_YM") + "'||'08' FROM DUAL                        \n");
        sbSql.append("                UNION ALL                                            \n");
        sbSql.append("                SELECT '" + ds_Cond.getString(0, "INPUT_YM") + "'||'09' FROM DUAL                        \n");
        sbSql.append("                UNION ALL                                            \n");
        sbSql.append("                SELECT '" + ds_Cond.getString(0, "INPUT_YM") + "'||'10' FROM DUAL                        \n");
        sbSql.append("                UNION ALL                                            \n");
        sbSql.append("                SELECT '" + ds_Cond.getString(0, "INPUT_YM") + "'||'11' FROM DUAL                        \n");
        sbSql.append("                UNION ALL                                            \n");
        sbSql.append("                SELECT '" + ds_Cond.getString(0, "INPUT_YM") + "'||'12' FROM DUAL                        \n");
        sbSql.append("               ) B                                                   \n");
        sbSql.append("         WHERE 1=1                                                   \n");
        sbSql.append("           AND A.CLOSE_DATE IS NULL /* 폐점안한곳 */                 \n");
        sbSql.append("           AND A.TM_CD = '" + ds_Cond.getString(0, "TM_CD") + "'                                       \n");
        
     	// 업장정보
        if(!ds_Cond.getString(0, "DOC_CD").equals("")){
        	sbSql.append("       AND A.UPJANG = '" + ds_Cond.getString(0, "DOC_CD") + "'  /* 업장 */   \n");
        } 
        
        sbSql.append("       ) A10,                                                        \n");
        sbSql.append("       MAS_UPJANG_M_RATE_MGMT B10                                    \n");
        sbSql.append(" WHERE A10.UPJANG   = B10.DOC_CD(+)                                  \n");
        sbSql.append("   AND A10.INPUT_YM = B10.INPUT_YM(+)                                \n");
        sbSql.append("   AND B10.GUBUN(+) = '" + ds_Cond.getString(0, "GUBUN") + "' \n");
        sbSql.append(" ORDER BY A10.UPJANGNM, A10.INPUT_YM                                 \n");

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