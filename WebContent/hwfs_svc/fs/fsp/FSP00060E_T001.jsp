<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 구매관리/도시락
■ 프로그램ID   : FSP00060E_T001.jsp
■ 프로그램명   : 도시락 마감자료
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

		//내역조회
		sbSql.append("SELECT A.SABUN, A.NM_KOR \n");
		sbSql.append("     , '['||A.MU_NM||']'||A.CC_NM AS CC_NM \n");
		sbSql.append("     , SUM(NVL(B.QTY_A,0) + NVL(B.QTY_B,0) + NVL(B.QTY_C,0) + NVL(B.QTY_D,0) + NVL(B.QTY_E,0)) AS QTY \n");
		sbSql.append("     , 3700 AS PRICE \n");
		sbSql.append("     , 3700 * SUM(NVL(B.QTY_A,0) + NVL(B.QTY_B,0) + NVL(B.QTY_C,0) + NVL(B.QTY_D,0) + NVL(B.QTY_E,0)) AS AMOUNT \n");
		sbSql.append("     , 1800 AS APP_PRICE \n");
		sbSql.append("     , 1800 * SUM(NVL(B.QTY_A,0) + NVL(B.QTY_B,0) + NVL(B.QTY_C,0) + NVL(B.QTY_D,0) + NVL(B.QTY_E,0)) AS APP_AMOUNT \n");
		sbSql.append("     , (3700 + 1800) * SUM(NVL(B.QTY_A,0) + NVL(B.QTY_B,0) + NVL(B.QTY_C,0) + NVL(B.QTY_D,0) + NVL(B.QTY_E,0)) AS TOT_AMOUNT \n");
		sbSql.append("  FROM SCO_FS_HR_PERSONAL_V A, FMP_LUNCH B \n");
		sbSql.append(" WHERE A.SABUN = B.SABUN \n");
		sbSql.append("   AND B.ORDER_DATE BETWEEN '" + nullToBlank(ds_Cond.getString(0, "ORDER_DATEF")) + "' \n");
		sbSql.append("                        AND '" + nullToBlank(ds_Cond.getString(0, "ORDER_DATET")) + "' \n");
		//sbSql.append("   AND A.PER_DTD IS NULL \n");
		if (! nullToBlank(ds_Cond.getString(0, "SC_CD")).equals(""))
			sbSql.append("   AND A.SC_CD = '" + nullToBlank(ds_Cond.getString(0, "SC_CD")) + "'\n");
		if (! nullToBlank(ds_Cond.getString(0, "CC_CD")).equals(""))
			sbSql.append("   AND A.CC_CD = '" + nullToBlank(ds_Cond.getString(0, "CC_CD")) + "'\n");
		sbSql.append(" GROUP BY A.MU_CD, A.MU_NM, A.CC_CD, A.CC_NM, A.SABUN, A.NM_KOR \n");
		sbSql.append(" ORDER BY A.MU_CD, A.CC_CD, A.SABUN \n");

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