<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 메뉴관리/자재관리/구매제한 자재정보 조회
■ 프로그램ID   : FSI00070V.jsp
■ 프로그램명   : 구매제한 자재정보 조회
■ 작성일자     : 2008-09-23
■ 작성자       : 박은규
■ 이력관리     : 2008-09-23
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
	
		//IRIS DB연결
		if(conn != null && !conn.isClosed()) conn.close();
		conn = getIRISConn();

		//입력 데이타
		DataSet ds_Cond     = in_dl.get("ds_Cond");
		//입력 파라메터
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		String strIndex     = nullToBlank(in_vl.getString("strIndex"));
		//FileLog.println("d:\\aaa.txt", ds_Cond);


		//out 데이타
		DataSet ds_List;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		//내역조회
		sbSql.append("SELECT A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM \n");
		sbSql.append("     , A.TAX_CODE, A.KEEPING_TYPE, A.ORIGIN_TYPE \n");
		if (strIndex.equals("1"))
			sbSql.append("     , 'D-'||TO_CHAR(NVL(C.D_DAYS,0) + 1)||'  '||TO_CHAR(TO_DATE(DECODE(C.D_TIMES,'',2359,0,2359,C.D_TIMES*100),'HH24MI'),'HH24:MI') AS ITEM_INFO \n");
		else if (strIndex.equals("2"))
		{
			sbSql.append("     , TRIM(DECODE(NVL(C.MON,'N'),'Y','월 ') \n");
			sbSql.append("          ||DECODE(NVL(C.TUE,'N'),'Y','화 ') \n");
			sbSql.append("          ||DECODE(NVL(C.WED,'N'),'Y','수 ') \n");
			sbSql.append("          ||DECODE(NVL(C.THU,'N'),'Y','목 ') \n");
			sbSql.append("          ||DECODE(NVL(C.FRI,'N'),'Y','금 ') \n");
			sbSql.append("          ||DECODE(NVL(C.SAT,'N'),'Y','토 ') \n");
			sbSql.append("          ||DECODE(NVL(C.SUN,'N'),'Y','일')) AS ITEM_INFO \n");
		}			
		sbSql.append("  FROM PO_ITEM_MST A \n");
		if (strIndex.equals("1"))
		{
			sbSql.append("     ,(SELECT * FROM PO_PREORDER_LIST \n");
			sbSql.append("        WHERE CENTER_CODE = (SELECT A.CENTER_CODE FROM PO_UPJANG_CENTER A, ST_UPJANG B WHERE A.UPJANG = B.AP_UNITPRICE_UPJANG AND B.UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + ")) C \n");
		}
		else if (strIndex.equals("2"))
		{
			sbSql.append("     ,(SELECT A.ITEM_CODE \n");
			sbSql.append("            , A.MON, A.TUE, A.WED, A.THU, A.FRI, A.SAT, A.SUN \n");
			sbSql.append("         FROM PO_ORDER_SCHEDULE A \n");
			sbSql.append("            ,(SELECT * FROM PO_TREAT_UPJANG \n");
			sbSql.append("               WHERE UPJANG = (SELECT AP_UNITPRICE_UPJANG FROM ST_UPJANG WHERE UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + ")) B \n");
			sbSql.append("            ,(SELECT CENTER_CODE, CUSTCD, MAX(UPJANG) AS UPJANG \n");
			sbSql.append("                FROM PO_ORDER_SCHEDULE \n");
			sbSql.append("               WHERE CENTER_CODE = (SELECT A.CENTER_CODE FROM PO_UPJANG_CENTER A, ST_UPJANG B WHERE A.UPJANG = B.AP_UNITPRICE_UPJANG AND B.UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + ") \n");
			sbSql.append("                 AND UPJANG IN (-1,(SELECT AP_UNITPRICE_UPJANG FROM ST_UPJANG WHERE UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + ")) \n");
			sbSql.append("               GROUP BY CENTER_CODE, CUSTCD) C \n");
			sbSql.append("        WHERE A.CENTER_CODE = B.CENTER_CODE \n");
			sbSql.append("          AND A.CUSTCD = B.CUSTCD \n");
			sbSql.append("          AND A.ITEM_CODE = B.ITEM_CODE \n");
			sbSql.append("          AND A.CENTER_CODE = C.CENTER_CODE \n");
			sbSql.append("          AND A.CUSTCD = C.CUSTCD \n");
			sbSql.append("          AND A.UPJANG = C.UPJANG) C \n");
		}
		sbSql.append(" WHERE A.ITEM_CODE = C.ITEM_CODE \n");
		if (strIndex.equals("1"))
		{
			String sWhere = nullToBlank(ds_Cond.getString(0, "PREORD"));
			if (sWhere.equals(""))
				sbSql.append("   AND C.D_DAYS > 0 \n");
			else
				sbSql.append("   AND TO_CHAR(NVL(C.D_DAYS,0) + 1) = '" + sWhere + "' \n");
		}
		else if (strIndex.equals("2"))
		{
			//String[] strWeek = {"SUN","MON","TUE","WED","THU","FRI","SAT"};
			String sWhere = nullToBlank(ds_Cond.getString(0, "WEEK"));
			if (sWhere.equals("1")) 
				sbSql.append("   AND C.SUN = 'Y' \n");
			else if (sWhere.equals("2"))
				sbSql.append("   AND C.MON = 'Y' \n");
			else if (sWhere.equals("3"))
				sbSql.append("   AND C.TUE = 'Y' \n");
			else if (sWhere.equals("4"))
				sbSql.append("   AND C.WED = 'Y' \n");
			else if (sWhere.equals("5"))
				sbSql.append("   AND C.THU = 'Y' \n");
			else if (sWhere.equals("6"))
				sbSql.append("   AND C.FRI = 'Y' \n");
			else if (sWhere.equals("7"))
				sbSql.append("   AND C.SAT = 'Y' \n");
			else
				sbSql.append("   AND C.MON||C.TUE||C.WED||C.THU||C.FRI||C.SAT||C.SUN <> 'NNNNNNN' \n");
		}
		String sItemName = nullToBlank(ds_Cond.getString(0, "ITEM_NAME"));
		if (! sItemName.equals(""))
			sbSql.append("   AND A.ITEM_NAME LIKE '%" + sItemName + "%' \n");
		sbSql.append(" ORDER BY A.ITEM_CODE \n");

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