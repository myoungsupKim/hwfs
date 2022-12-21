<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 구매관리/도시락
■ 프로그램ID   : FSP00040E_T001.jsp
■ 프로그램명   : 도시락 주문조회
■ 작성일자     : 2012-09-10
■ 작성자       : 박은규
■ 이력관리     : 2012-09-10 박은규 최초작성 CH201209_00102 FS기획팀
                2013-07-05 김동표 수정 CH201209_00102 연회웨딩팀 이일용
                                     도시락메뉴수 A,B -> A,B,C,D,E로 확대
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

		//1)주문내역조회
		sbSql.append("WITH A AS \n");
		sbSql.append("( \n");
		sbSql.append("SELECT A.CC_CD, A.CC_NM \n");
		sbSql.append("     , A.SABUN, A.NM_KOR \n");
		sbSql.append("     , C.ORDER_DATE \n");
		sbSql.append("  FROM SCO_FS_HR_PERSONAL_V A, HLDC_SC_DEPT B \n");
		sbSql.append("     , (SELECT TO_CHAR(NEXT_DAY(TO_DATE('" + nullToBlank(ds_Cond.getString(0, "ORDER_DATE")) + "','YYYYMMDD')-7,1)+(LEVEL),'YYYYMMDD') AS ORDER_DATE \n");
		sbSql.append("          FROM DUAL CONNECT BY LEVEL <= 5) C \n");
		sbSql.append(" WHERE A.DEPT_ID = B.DEPT_ID \n");
		sbSql.append("   AND A.PER_DTD IS NULL \n");
		if (! nullToBlank(ds_Cond.getString(0, "CC_CD")).equals(""))
			sbSql.append("   AND A.CC_CD = '" + nullToBlank(ds_Cond.getString(0, "CC_CD")) + "'\n");
		if (! nullToBlank(ds_Cond.getString(0, "SABUN")).equals(""))
			sbSql.append("   AND A.SABUN = '" + nullToBlank(ds_Cond.getString(0, "SABUN")) + "'\n");
		sbSql.append("   AND B.EXP_CD = 'N' \n");
		sbSql.append(") \n");
		sbSql.append("SELECT A.* \n");
		sbSql.append("     , TO_CHAR(TO_DATE(A.ORDER_DATE,'YYYYMMDD'),'MM/DD(DY)','nls_date_language=korean') AS ORDER_DATE_DISP \n");
		sbSql.append("     , NVL(B.QTY_A,0) AS QTY_A \n");
		sbSql.append("     , NVL(B.QTY_B,0) AS QTY_B \n");
		sbSql.append("     , NVL(B.QTY_C,0) AS QTY_C \n");
		sbSql.append("     , NVL(B.QTY_D,0) AS QTY_D \n");
		sbSql.append("     , NVL(B.QTY_E,0) AS QTY_E \n");
		sbSql.append("     , CASE \n");
		sbSql.append("         WHEN NVL(C.OPEN_FLAG,'N') = 'Y' THEN 'Y' \n");
		//공통코드(FM0015)에 세팅한 마감일자, 시간으로 수정가능 여부를 판단한다.
		sbSql.append("         WHEN TO_CHAR(SYSDATE+NVL(" + nullToBlank(ds_Cond.getString(0, "CDAY")) + ",0),'YYYYMMDDHH24MI') < A.ORDER_DATE||'" + nullToBlank(ds_Cond.getString(0, "CTIME")) + "' THEN 'Y' \n");
		sbSql.append("         ELSE 'N' \n");
		sbSql.append("       END AS OPEN_FLAG \n");
		sbSql.append("  FROM A, FMP_LUNCH B \n");
		sbSql.append("     , FMP_LUNCH_CLS C \n");
		sbSql.append(" WHERE A.ORDER_DATE = B.ORDER_DATE(+) \n");
		sbSql.append("   AND A.SABUN = B.SABUN(+) \n");
		sbSql.append("   AND A.ORDER_DATE = C.ORDER_DATE(+) \n");
		sbSql.append("   AND A.CC_CD = C.CC_CD(+) \n");

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