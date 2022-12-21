<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 협력업체 > 외식사업부
■ 프로그램ID   : FSV00710V_T001.jsp
■ 프로그램명   : 외식사업부 일별 매출집계
■ 작성일자     : 2012-02-08
■ 작성자       : 박은규
■ 이력관리     : 박은규 2012-02-08 CSR#(CH201202_00071) 요청자:최정순(외식사업팀)
               신규개발
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

		//주문내역조회
		sbSql.append("SELECT TO_CHAR(TO_DATE(A.SDATE,'YYYYMMDD'),'YYYY-MM-DD') AS SDATE \n");
		if (nullToBlank(ds_Cond.getString(0, "LOC")).equals(""))
			sbSql.append("     , NULL AS LOC, '전체' AS LOC_NAME \n");
		else
			sbSql.append("     , A.LOC, (SELECT Z.LOC_NAME FROM FMB_PLAZA_LOC_MST Z WHERE Z.LOC = A.LOC) AS LOC_NAME \n");
		sbSql.append("     , SUM(A.GUEST) AS GUEST \n");
		sbSql.append("     , SUM(A.FOODAMT) AS FOODAMT \n");
		sbSql.append("     , SUM(A.BEVAMT) AS BEVAMT \n");
		sbSql.append("     , SUM(A.OTHAMT) AS OTHAMT \n");
		sbSql.append("     , SUM(A.SANAMT) AS SANAMT \n");
		sbSql.append("     , SUM(A.FOODDC) AS FOODDC \n");
		sbSql.append("     , SUM(A.BEVDC) AS BEVDC \n");
		sbSql.append("     , SUM(A.OTHDC) AS OTHDC \n");
		sbSql.append("     , SUM(A.SANDC) AS SANDC \n");
		sbSql.append("     , SUM(A.NET) AS NET \n");
		sbSql.append("     , SUM(A.SVC) AS SVC \n");
		sbSql.append("     , SUM(A.VAT) AS VAT \n");
		sbSql.append("     , SUM(A.GROSS) AS GROSS \n");
		sbSql.append("     , SUM(A.CASH) AS CASH \n");
		sbSql.append("     , SUM(A.CARD) AS CARD \n");
		sbSql.append("     , SUM(A.CL) AS CL \n");
		sbSql.append("     , SUM(A.ETC) AS ETC \n");
		sbSql.append("  FROM FMB_PLAZA_DAILY_SALE A \n");
		sbSql.append(" WHERE A.SDATE BETWEEN '" + nullToBlank(ds_Cond.getString(0, "SDATEF")) + "' \n");
		sbSql.append("                   AND '" + nullToBlank(ds_Cond.getString(0, "SDATET")) + "' \n");
		if (nullToBlank(ds_Cond.getString(0, "LOC")).equals(""))
			sbSql.append("   AND A.LOC IN (SELECT Z.LOC FROM FMB_PLAZA_LOC_MST Z WHERE Z.UPJANG = " + g_Upjang + ") \n");
		else
			sbSql.append("   AND A.LOC = '" + nullToBlank(ds_Cond.getString(0, "LOC")) + "' \n");
		sbSql.append(" GROUP BY A.SDATE \n");
		if (! nullToBlank(ds_Cond.getString(0, "LOC")).equals(""))
			sbSql.append("        , A.LOC \n");
		sbSql.append(" ORDER BY A.SDATE \n");
		if (! nullToBlank(ds_Cond.getString(0, "LOC")).equals(""))
			sbSql.append("        , A.LOC \n");
		
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