<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/단가관리
■ 프로그램ID   : FMU00021V_T001.jsp
■ 프로그램명   : 본부/본사 운영단가조회
■ 작성일자     : 2013-01-02
■ 작성자       : 박용대
■ 이력관리     : 2013-01-02
■ 설명 : 사업장에 따라 엑셀다운로드를 할지 말지를 결정하기 위해 사업장 정보를 가져오는 트랜잭션
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
		//FileLog.println("d:\\aaa.txt", ds_Cond);


		//out 데이타
		DataSet ds_List;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		
		sbSql.append("\n\n");
		sbSql.append("SELECT UPJANG,EXCEL_EXPORT_YN   \n");
        sbSql.append("FROM FMS_UPJANG                 \n");
        sbSql.append("WHERE (1=1)                     \n");
		if (! g_Upjang.equals(""))
			sbSql.append("   AND UPJANG = '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "' \n");
		sbSql.append("\n\n");

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
