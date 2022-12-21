<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/예산관리
■ 프로그램ID   : FMO00420E_T001.jsp
■ 프로그램명   : 예산관리/조회
■ 작성일자     : 2018-08-07
■ 작성자       : kihoon
■ 이력관리     : 2018-08-07	신규작성
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	try	{
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		logger.startIndividualLog(in_vl.getString("titLogId"));		
	
		DataSet ds_cond    = in_dl.get("ds_search");
		
		String nSeq = ds_cond.getString(0, "schBudgetSeq");
				
		DataSet ds_list;
		
		StringBuffer sbSql = new StringBuffer();

		sbSql.append("	SELECT TO_CHAR(LOG_DDTT, 'YYYY-MM-DD HH24:MM:SS') AS LOG_DDTT		 \n");
		sbSql.append("		  , (SELECT  B.NM_KOR || '(' || A.CUSER || ')' 					 \n");
		sbSql.append("					 FROM SCC_USERINFO B 								 \n"); 
		sbSql.append("					 WHERE B.SABUN = A.UUSER) AS UUSER                   \n");
		sbSql.append("		  , BUDGET_SEQ                                                   \n");
		sbSql.append("	      , (SELECT B.SUBINV_NAME                                        \n");
		sbSql.append("					FROM HLDC_PO_SUBINVENTORY B                          \n");
		sbSql.append("					WHERE B.SUBINV_CODE = A.SUBINV_CODE) AS SUBINV_NAME  \n");
		sbSql.append("	      , START_DATE                                                   \n");
		sbSql.append("	      , END_DATE                                                     \n");
		sbSql.append("	      , BUDGET_AMT                                                   \n");
		sbSql.append("	      FROM FMO_BUDGET_MGMT_HIST A                                    \n");
		sbSql.append("	      WHERE A.BUDGET_SEQ = " + nSeq + "                              \n");
		sbSql.append("	ORDER BY LOG_DDTT DESC                                               \n");
		
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery();
				
		ds_list = this.makeDataSet(rs, "ds_list");
		
		rs.close();
		pstmt.close();		

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
