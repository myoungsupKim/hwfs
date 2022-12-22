<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/비용관리
■ 프로그램ID   : FMO00130E_T001.jsp
■ 프로그램명   : 비용내용등록/조회
■ 작성일자     : 2008-02-26
■ 작성자       : 박은규
■ 이력관리     : 2008-02-26
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
		//DataSet ds_cond     = in_dl.get("ds_Cond");
		//입력 파라메터
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		String sUpjang      = nullToBlank(in_vl.getString("sUpjang"));
		String sDateF       = nullToBlank(in_vl.getString("sDateF"));
		String sDateT       = nullToBlank(in_vl.getString("sDateT"));
		//FileLog.println("d:\\aaa.txt", ds_cond);


		//out 데이타
		DataSet ds_list;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		//내역조회
		sbSql.append("SELECT A.OCCUR_ID, A.OCCUR_DATE, A.UPJANG \n");
		sbSql.append("     , B.ACCT_TYPE \n");
		sbSql.append("     , C.CODE_NAME AS TYPE_NAME \n");
		sbSql.append("     , A.ACCTCD \n");
		sbSql.append("     , B.ACCTNM, A.SUPPLIER, A.CONTENTS \n");
		sbSql.append("     , A.OCCUR_AMT \n");
		sbSql.append("     , A.ADV_YN \n");
		sbSql.append("  FROM FMO_ACCT_OCCUR A, FMS_UPJANG A2, FMO_ACCOUNT B \n");
		sbSql.append("     ,(SELECT * FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FM0001' AND USE_YN = 'Y') C \n");
		sbSql.append(" WHERE A.UPJANG = A2.UPJANG \n");
		sbSql.append("   AND A2.MAIN_UPJANG = B.UPJANG \n");
		sbSql.append("   AND A.ACCTCD = B.ACCTCD \n");
		sbSql.append("   AND B.ACCT_TYPE = C.CODE \n");
		sbSql.append("   AND A.UPJANG = " + sUpjang + " \n");
		sbSql.append("   AND A.OCCUR_DATE BETWEEN '" + sDateF + "' AND '" + sDateT + "' \n");
		sbSql.append("   AND B.ACCT_TYPE IN ('002','003') \n");
		sbSql.append(" ORDER BY A.OCCUR_DATE, A.ACCTCD \n");

out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery();
				
		ds_list = this.makeDataSet(rs, "ds_List");
		
		rs.close();
		pstmt.close();		
		//FileLog.println("d:\\aaa.txt", ds_list);

		/**종료**/
		out_dl.add(ds_list);
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
