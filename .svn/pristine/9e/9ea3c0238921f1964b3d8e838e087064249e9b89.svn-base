<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식단관리/자재추가
■ 프로그램ID   : FSM00060P_T001.jsp
■ 프로그램명   : 입고예정일조회(식단제공일 + 식당D_Days)
■ 작성일자     : 2009.08.20
■ 작성자       : 박은규
■ 이력관리     : 2009.08.20
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	PlatformRequest platformRequest = this.proc_input(request);
	in_vl = platformRequest.getData().getVariableList();
	in_dl = platformRequest.getData().getDataSetList();

	//입력 파라메터
	String sMENU_DATE   = nullToBlank(in_vl.getString("sMENU_DATE"));
	String sUPJANG      = nullToBlank(in_vl.getString("sUPJANG"));
	String sHALL_CD     = nullToBlank(in_vl.getString("sHALL_CD"));
	String sMEAL        = nullToBlank(in_vl.getString("sMEAL"));
	String sCORNER      = nullToBlank(in_vl.getString("sCORNER"));
	//FileLog.println("d:\\aaa.txt", ds_cond);

	try
	{
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		//내역조회
		sbSql.delete(0, sbSql.length());
		sbSql.append("SELECT TO_CHAR(TO_DATE('" + sMENU_DATE + "','YYYYMMDD') - NVL(D_DAY,0), 'YYYYMMDD') AS NEED_DATE \n");
		sbSql.append("  FROM FSA_HALL_DTL \n");
		sbSql.append(" WHERE UPJANG = '" + sUPJANG + "' \n");
		sbSql.append("   AND HALL_CD = '" + sHALL_CD + "' \n");
		sbSql.append("   AND MEAL = '" + sMEAL + "' \n");
		sbSql.append("   AND CORNER = '" + sCORNER + "' \n");
		
		out_vl.add("fa_Sql", sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery();
		if (rs.next())
		{
			out_vl.add("fa_JDATE", rs.getString("NEED_DATE"));
		}
		rs.close();
		pstmt.close();

		/**종료**/
		this.setResultMessage(0, "OK", out_vl);

	}
	catch(Exception ex)
	{
		ex.printStackTrace();
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
	}

	proc_output(response,out,out_vl,out_dl);

%>
