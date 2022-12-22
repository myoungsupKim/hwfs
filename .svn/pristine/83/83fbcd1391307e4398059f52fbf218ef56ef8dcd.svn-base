<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 타사매입처 입출고 확정 및 처리(타사매입)
■ 프로그램ID   : FMW00220E_T001.jsp
■ 프로그램명   : 타사매입처 입출고 확정 및 처리(타사매입)
■ 작성일자     : 2011.01.06
■ 작성자      : 문형광
■ 이력관리     : 2011.01.06
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
		
		sbSql.delete(0, sbSql.length());
        sbSql.append("SELECT A.SUBINV_CODE                            \n");
        sbSql.append("     , A.SUBINV_NAME_DISP AS SUBINV_NAME        \n");
        sbSql.append("     , NVL(B.CLS_YM, '"+nullToBlank(ds_Cond.getString(0, "DATE"))+"') AS CLS_YM \n");
        sbSql.append("     , NVL(B.CLS_FLAG, 'N') AS CLS_FLAG         \n");
        sbSql.append("  FROM FMS_SUBINVENTORY A                       \n");
        sbSql.append("     , (SELECT Z.SUBINV_CODE, Z.CLS_YM, Z.CLS_FLAG \n");
        sbSql.append("          FROM FMW_CLOSING Z                    \n");
        sbSql.append("         WHERE Z.CLS_YM = '" + nullToBlank(ds_Cond.getString(0, "DATE")) + "'   \n");
        sbSql.append("       ) B                                      \n");
        sbSql.append(" WHERE A.SUBINV_CODE = B.SUBINV_CODE(+)         \n");
        sbSql.append("   AND A.UPJANG = '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'         \n");
        sbSql.append("   AND A.USE_YN = 'Y'                           \n");
        sbSql.append("   AND A.SUBINV_CODE LIKE 'S1%'                 \n");
        sbSql.append(" ORDER BY A.SUBINV_CODE                         \n");
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