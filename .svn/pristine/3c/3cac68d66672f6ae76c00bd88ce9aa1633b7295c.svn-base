<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/단가관리
■ 프로그램ID   : FMU00280E_T001.jsp
■ 프로그램명   : 업장별 운영율 등록관리(조회)
■ 작성일자     : 2008.04.14
■ 작성자       : 박은규
■ 이력관리     : 2008.04.14
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
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		//FileLog.println("d:\\aaa.txt", ds_Cond);

		//out 데이타
		DataSet ds_List;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		//운영율 구분
		sbSql.append("SELECT 1 \n");
		sbSql.append("  FROM FMS_UPJANG A \n");
		sbSql.append(" WHERE A.UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + " \n");
		sbSql.append("   AND A.OP_RATE_YN = 'C' \n");

out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		if (! rs.next())
		{
			this.setResultMessage(-1, "해당 업장은 분류별 운영율 사용설정을 하지 않았습니다!", out_vl);
			proc_output(response,out,out_vl,out_dl);
			return;
		}

		//내역조회
		sbSql.delete(0, sbSql.length());
		sbSql.append("SELECT A.SDATE \n");
		sbSql.append("     , A.EDATE \n");
		sbSql.append("     , MAX(A.OP_RATE) AS OP_RATE \n");
		sbSql.append("     , DECODE(MAX(A.OP_RATE), MIN(A.OP_RATE), NULL, '분류별 상이한 운영율이 존재. 분류별 운영율 확인필요!') AS OP_REMARK \n");
		sbSql.append("  FROM FMU_OP_RATE A \n");
		sbSql.append(" WHERE A.UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + " \n");
		sbSql.append("   AND A.SDATE BETWEEN '" + nullToBlank(ds_Cond.getString(0, "SDATE")) + "'||'0101' \n");
		sbSql.append("                   AND '" + nullToBlank(ds_Cond.getString(0, "SDATE")) + "'||'1231' \n");
		sbSql.append("   AND A.SDATE > '00000000' \n");
		sbSql.append("   AND A.EDATE > '00000000' \n");
		sbSql.append(" GROUP BY A.SDATE, A.EDATE \n");
		sbSql.append(" ORDER BY A.SDATE \n");

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
