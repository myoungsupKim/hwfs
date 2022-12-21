<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 공통/사용자관리
■ 프로그램ID   : SCC00046P_T001.jsp
■ 프로그램명   : 권한별 사용자조회 팝업(조회)
■ 작성일자     : 2008.10.30
■ 작성자       : 박은규
■ 이력관리     : 2008.10.30
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
		String strIndex     = nullToBlank(in_vl.getString("strIndex"));

		//out 데이타
		DataSet ds_List;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		
		//내역조회
		String sRole = nullToBlank(ds_Cond.getString(0, "ROLE"));
		if (strIndex.equals("1"))
		{
			sbSql.append("SELECT A.ROLE, A.ROLE_NAME \n");
			sbSql.append("     , C.USERID, B.SABUN, C.NM_KOR \n");
			sbSql.append("     , DECODE(C.USER_GROUP,'협력업체' \n");
			sbSql.append("                          ,(SELECT Z.CUSTNM FROM HLDC_ST_CUST Z WHERE Z.CUSTCD = C.CUSTCD) \n");
			sbSql.append("                          ,'공급업체' \n");
			sbSql.append("                          ,(SELECT Z.OTCUSTNM FROM FMP_OTHER_CUST Z WHERE Z.OTCUSTCD = C.OTCUSTCD) \n");
			sbSql.append("                          ,(SELECT Z.UPJANGNM FROM HLDC_ST_UPJANG Z WHERE Z.UPJANG = C.UPJANG) \n");
			sbSql.append("             ) AS UPJANGNM \n");
			sbSql.append("     ,(SELECT Z.CODE_NAME FROM SCC_COMMON_CODE Z WHERE Z.GROUP_CODE = 'SC0003' AND Z.CODE = C.AUTHLEVEL) AS AUTHLEVEL \n");
			sbSql.append("     , NVL((SELECT 'Y' FROM DUAL WHERE TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN NVL(C.SDATE,'00000000') AND NVL(C.EDATE,'99999999')),'N') AS USE_YN \n");
			sbSql.append("  FROM SCC_ROLE A, SCC_USER_ROLE B, SCC_USERINFO C \n");
			sbSql.append(" WHERE A.SYS_TYPE = B.SYS_TYPE \n");
			sbSql.append("   AND A.ROLE = B.ROLE \n");
			sbSql.append("   AND B.SABUN = C.SABUN \n");
			sbSql.append("   AND A.SYS_TYPE = '" + nullToBlank(ds_Cond.getString(0, "SYS_TYPE")) + "' \n");
			if (! sRole.equals(""))
				sbSql.append("   AND A.ROLE = '" + nullToBlank(ds_Cond.getString(0, "ROLE")) + "' \n");
			sbSql.append(" ORDER BY A.ROLE_NAME \n");
		}
		else
		{
			sbSql.append("SELECT A.BBSROLE AS ROLE, A.ROLE_NAME \n");
			sbSql.append("     , C.USERID, B.SABUN, C.NM_KOR \n");
			sbSql.append("     , DECODE(C.USER_GROUP,'협력업체' \n");
			sbSql.append("                          ,(SELECT Z.CUSTNM FROM HLDC_ST_CUST Z WHERE Z.CUSTCD = C.CUSTCD) \n");
			sbSql.append("                          ,'공급업체' \n");
			sbSql.append("                          ,(SELECT Z.OTCUSTNM FROM FMP_OTHER_CUST Z WHERE Z.OTCUSTCD = C.OTCUSTCD) \n");
			sbSql.append("                          ,(SELECT Z.UPJANGNM FROM HLDC_ST_UPJANG Z WHERE Z.UPJANG = C.UPJANG) \n");
			sbSql.append("             ) AS UPJANGNM \n");
			sbSql.append("  FROM SCC_BBSROLE A, SCC_USER_BBSROLE B, SCC_USERINFO C \n");
			sbSql.append(" WHERE A.BBSROLE = B.BBSROLE \n");
			sbSql.append("   AND B.SABUN = C.SABUN \n");
			if (! sRole.equals(""))
				sbSql.append("   AND A.BBSROLE = '" + nullToBlank(ds_Cond.getString(0, "ROLE")) + "' \n");
			sbSql.append(" ORDER BY A.ROLE_NAME \n");
		}
		
out_vl.add("fa_Sql", sbSql.toString());
		System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_List = this.makeDataSet(rs, "ds_List");
		//FileLog.println("d:\\BBB.txt", ds_List);
		
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