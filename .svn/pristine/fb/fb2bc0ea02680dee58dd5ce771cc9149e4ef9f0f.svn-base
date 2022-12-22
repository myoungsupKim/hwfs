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
		
		String sMainUpjang = ds_cond.getString(0, "schMainUpjang");
		String sUpjang     = ds_cond.getString(0, "schUpjang");
		String sStdDt     = ds_cond.getString(0, "schStdDt");
		String sTotYn      = ds_cond.getString(0, "schTotYn");
		String sUseYn      = ds_cond.getString(0, "schUseYn");
		
		DataSet ds_list;
		
		StringBuffer sbSql = new StringBuffer();

		sbSql.append("  SELECT A.MAIN_UPJANG                               					\n");
		sbSql.append("  	  , (SELECT K.UPJANGNM_DISP                    					\n");
		sbSql.append("					FROM FMS_UPJANG K                  					\n");
		sbSql.append("					WHERE K.UPJANG = A.MAIN_UPJANG     					\n");
		sbSql.append("					AND ROWNUM = 1) AS MAIN_UPJANG_NM  					\n");
		sbSql.append("        , A.UPJANG                                   					\n");
		sbSql.append("        , A.UPJANGNM_DISP                            					\n");
		sbSql.append("        , B.SUBINV_CODE                              					\n");
		sbSql.append("        , B.SUBINV_NAME                              					\n");
		sbSql.append("        , C.START_DATE                               					\n");
		sbSql.append("        , C.END_DATE                                 					\n");
		sbSql.append("        , C.BUDGET_AMT                               					\n");
		sbSql.append("        , C.BUDGET_SEQ                               					\n");
		sbSql.append("        , DECODE(C.BUDGET_SEQ, NULL, -1, C.BUDGET_SEQ) AS FLAG		\n");
		sbSql.append("        FROM FMS_UPJANG A                            					\n");
		sbSql.append("        , HLDC_PO_SUBINVENTORY B                     					\n");
		sbSql.append("        , FMO_BUDGET_MGMT C                          					\n");
		sbSql.append("  WHERE A.UPJANG = B.UPJANG                          					\n");
		sbSql.append("  AND B.SUBINV_CODE = C.SUBINV_CODE(+)               					\n");
		sbSql.append("  AND A.BUDGET_FLAG = 'Y'				               					\n");
		
		if ( !sMainUpjang.equals("")){
			sbSql.append("  AND A.MAIN_UPJANG = " + sMainUpjang + "		   					\n");
		}
		
		if ( !sUpjang.equals("")){
			sbSql.append("  AND A.UPJANG = " + sUpjang + "                 					\n");
		}
		
		if ( sTotYn.equals("0") ) {
			sbSql.append("  AND " +sStdDt + " BETWEEN C.START_DATE AND C.END_DATE			\n");
		}
		
		if ( !sUseYn.equals("") ) {
			sbSql.append("  AND B.USE_YN = '" + sUseYn + "' \n");
		}
		
		sbSql.append("  ORDER BY A.MAIN_UPJANG, A.UPJANG, B.SUBINV_CODE, C.BUDGET_SEQ		\n");
		
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
