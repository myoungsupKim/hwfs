<%
/*-----------------------------------------------------------------------------
-----------------------------------------------------------------------------------------*/
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
		//String g_Main_Upjang     = nullToBlank(in_vl.getString("g_Main_Upjang"));		
		//FileLog.println("d:\\aaa.txt", ds_Cond);


		//out 데이타
		DataSet ds_List;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		//본사 통합 업장 대상 여신체크할 최종 발주일자 조회
		sbSql.delete(0,sbSql.length());
        sbSql.append("SELECT A.UPJANG                                      		\n");
        sbSql.append("     , A.UPJANGNM_DISP                               		\n");
        sbSql.append("     , NVL(B.SUB_AMOUNT, 0) AS SUB_AMOUNT            		\n");
        sbSql.append("     , NVL(B.SUB_RATE, 0) AS SUB_RATE               		\n");
        sbSql.append("     , NVL(B.SUB_START,'" + nullToBlank(ds_Cond.getString(0, "SUB_START")) + "') AS SUB_START \n");
        sbSql.append("     , NVL(B.SUB_END,'" + nullToBlank(ds_Cond.getString(0, "SUB_END")) + "') AS SUB_END \n");
        sbSql.append("     , DECODE(NVL(B.USE_YN, 'Y'), 'Y' , '1', '0') AS USE_YN \n");
        sbSql.append("  FROM FMS_UPJANG A, FMS_GREEN_SUB B                 		\n");
        sbSql.append(" WHERE A.UPJANG = B.UPJANG(+)                        		\n");
        sbSql.append("   AND A.MAIN_UPJANG = '" + nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG")) + "'             \n");
		sbSql.append("   AND B.SUB_START(+) BETWEEN '" + nullToBlank(ds_Cond.getString(0, "SUB_START")) + "' AND '" + nullToBlank(ds_Cond.getString(0, "SUB_END")) + "' \n");
out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
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
