<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/급식운영관리
■ 프로그램ID   : FMO00061P_T001.jsp
■ 프로그램명   : 보건증갱신 알림
■ 작성일자     : 2008-02-25
■ 작성자       : 박은규
■ 이력관리     : 2008-02-25
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
		String g_SystemId   = nullToBlank(in_vl.getString("g_SystemId"));
		//FileLog.println("d:\\aaa.txt", ds_cond);


		//out 데이타
		DataSet ds_list;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		//내역조회
		if (g_SystemId.equals("FICS"))
		{
			sbSql.append("SELECT A.UPJANG, B.UPJANGNM_DISP \n");
			sbSql.append("     , A.LICENCER \n");
			sbSql.append("     , A.LICEN_DATE, A.EXPIRE_DATE \n");
			sbSql.append("     , SCC_CEIL((TO_DATE(A.EXPIRE_DATE,'YYYYMMDD') - SYSDATE)) AS D_DAYS \n");
			sbSql.append("  FROM FMO_LICEN_MGMT A, FMS_UPJANG B \n");
			sbSql.append("     ,(SELECT * FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FM0011') C \n");
			sbSql.append(" WHERE A.UPJANG = B.UPJANG \n");
			sbSql.append("   AND A.LICEN_NAME = C.CODE \n");
			sbSql.append("   AND A.UPJANG = " + g_Upjang + " \n");
			sbSql.append("   AND A.EXPIRE_DATE > ' ' \n");
			sbSql.append("   AND C.SET1 = 'Y' \n");
			//sbSql.append("   AND SCC_CEIL((TO_DATE(A.EXPIRE_DATE,'YYYYMMDD') - SYSDATE)) IN (7,10) \n");
			sbSql.append("   AND SCC_CEIL((TO_DATE(A.EXPIRE_DATE,'YYYYMMDD') - SYSDATE)) IN (10,20) \n");
		}
		else //if (g_SystemId.equals("IFIS"))
		{
			sbSql.append("SELECT A.UPJANG, B.UPJANGNM AS UPJANGNM_DISP \n");
			sbSql.append("     , C.NM_KOR AS LICENCER \n");
			sbSql.append("     , A.CHECK_DATE AS LICEN_DATE \n");
			sbSql.append("     , A.END_DD AS EXPIRE_DATE \n");
			sbSql.append("     , SCC_CEIL((TO_DATE(A.END_DD,'YYYYMMDD') - SYSDATE)) AS D_DAYS \n");
			sbSql.append("  FROM FSC_HEALTH_CHECK A, HLDC_ST_UPJANG B, HLDC_HR_PERSONAL C \n");
			sbSql.append(" WHERE A.UPJANG = B.UPJANG \n");
			sbSql.append("   AND A.SABUN = C.SABUN \n");
			sbSql.append("   AND A.UPJANG = " + g_Upjang + " \n");
			sbSql.append("   AND TO_CHAR(SYSDATE,'YYYYMMDD') IN (A.FIRST_INFORM, A.SECOND_INFORM, A.THIRD_INFORM) \n");
			sbSql.append("   AND NVL(C.PER_DTD,TO_CHAR(SYSDATE,'YYYYMMDD')) >=  TO_CHAR(SYSDATE,'YYYYMMDD') \n");
		}

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
