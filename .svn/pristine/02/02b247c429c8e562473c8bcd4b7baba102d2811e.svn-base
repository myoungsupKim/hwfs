<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 메뉴관리/식단관리
■ 프로그램ID   : FSM00410V_T001.jsp
■ 프로그램명   : 업장별 음식물쓰레기현황
■ 작성일자     : 2008-03-17
■ 작성자       : 박은규
■ 이력관리     : 2008-03-17 - 최초작성
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
		String sType        = nullToBlank(in_vl.getString("sType"));
		//FileLog.println("d:\\aaa.txt", ds_cond);


		//out 데이타
		DataSet ds_List;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		//내역조회
		sbSql.append("SELECT A1.TM_CD \n");
		sbSql.append("     , A1.TM_NM \n");
		if (sType.equals("popup"))
		{
			sbSql.append("     , SUM(DECODE(C.GARB_QTY,0,0,NULL,0,1)) AS Y_CNT \n");
			sbSql.append("     , COUNT(DISTINCT A.UPJANG) AS A_CNT \n");
		}
		else
		{
			sbSql.append("     , A.UPJANG \n");
			sbSql.append("     , A.UPJANGNM \n");
			sbSql.append("     , NVL(TO_CHAR(TO_DATE(C.JDATE,'YYYYMMDD'),'YYYY-MM-DD(DAY)'),'자료없음') AS JDATE \n");
			sbSql.append("     , SUM(C.GARB_QTY) AS GARB_QTY \n");
			sbSql.append("     , SUM(C.SALE_QTY) AS SALE_QTY \n");
		}
		sbSql.append("     , NVL(DECODE(SUM(C.SALE_QTY),0,0,ROUND(1000*SUM(C.GARB_QTY)/SUM(C.SALE_QTY),0)),0) AS GARB_EACH \n");
		sbSql.append("  FROM HLDC_ST_UPJANG A, SCO_UPJANG_MST_V A1, HLDC_SC_DEPT_V B \n");
		
		if(nullToBlank(ds_Cond.getString(0, "QTY_GUBUN")).equals("0"))
		{
			sbSql.append("     , (SELECT A.UPJANG_CD AS UPJANG \n");
			if (! sType.equals("popup"))
	        	sbSql.append("              , A.OCCUR_DATE AS JDATE                                 \n");
	        sbSql.append("              , 0 AS GARB_QTY                                         \n");
	        sbSql.append("              , SUM(A.SAL_QUANTITY) AS SALE_QTY                       \n");
	        sbSql.append("           FROM SLA_IF_UPJANG_SALS_DETAIL A                           \n");                                                          
	        sbSql.append("          WHERE A.SALS_CLASS IN ('1103', '1104')                        \n");                                                          
	        sbSql.append("            AND A.OCCUR_DATE BETWEEN '" + nullToBlank(ds_Cond.getString(0, "DATEF")) + "' AND '" + nullToBlank(ds_Cond.getString(0, "DATET")) + "'    \n");                                                                     
	        sbSql.append("            AND A.RECD_STATUS = 'L'                                     \n");
	        sbSql.append("         GROUP BY A.UPJANG_CD \n");
			if (! sType.equals("popup"))
				sbSql.append("                , A.OCCUR_DATE \n");
		}
		else
		{
			sbSql.append("     , (SELECT A.UPJANG \n");
			if (! sType.equals("popup"))
				sbSql.append("             , A.MENU_DATE AS JDATE \n");
			sbSql.append("             , 0 AS GARB_QTY \n");
			sbSql.append("             , SUM(A.REAL_MEAL_QTY) AS SALE_QTY \n");
			sbSql.append("          FROM FSM_REAL_MENU_MST A \n");			
			sbSql.append("         WHERE A.MENU_DATE BETWEEN '" + nullToBlank(ds_Cond.getString(0, "DATEF")) + "' AND '" + nullToBlank(ds_Cond.getString(0, "DATET")) + "' \n");
			sbSql.append("         GROUP BY A.UPJANG \n");
			if (! sType.equals("popup"))
				sbSql.append("                , A.MENU_DATE \n");			
		}
		
		sbSql.append("         UNION ALL \n");
		sbSql.append("        SELECT A.UPJANG \n");
		if (! sType.equals("popup"))
			sbSql.append("             , A.MENU_DATE AS JDATE \n");
		sbSql.append("             , SUM(NVL(A.LEAVING_QTY,0) + NVL(A.LEFTOVER_QTY,0) + NVL(A.BEFORE_PROC_QTY,0)) AS GARB_QTY \n");
		sbSql.append("             , 0 AS SALE_QTY \n");
		sbSql.append("          FROM FSM_DAILY_OP_DIARY A \n");
		sbSql.append("         WHERE A.MENU_DATE BETWEEN '" + nullToBlank(ds_Cond.getString(0, "DATEF")) + "' AND '" + nullToBlank(ds_Cond.getString(0, "DATET")) + "' \n");
		sbSql.append("         GROUP BY A.UPJANG \n");
		if (! sType.equals("popup"))
			sbSql.append("                , A.MENU_DATE \n");
		sbSql.append("       ) C \n");
		sbSql.append(" WHERE A.UPJANG = A1.UPJANG \n");
		sbSql.append("   AND A.DEPT_ID = B.DEPT_ID \n");
		sbSql.append("   AND A.UPJANG = C.UPJANG(+) \n");
		//식재영업 업장 제외한 FC업장 조회대상...
		sbSql.append("   AND NVL(A.CUSTCD,0) = 0 \n");
		if (! nullToBlank(ds_Cond.getString(0, "UPJANG")).equals(""))
		    sbSql.append("   AND A.UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + " \n");
		if (! nullToBlank(ds_Cond.getString(0, "TM_CD")).equals(""))
		    sbSql.append("   AND B.TM_CD = '" + nullToBlank(ds_Cond.getString(0, "TM_CD")) + "' \n");
		if (! nullToBlank(ds_Cond.getString(0, "MU_CD")).equals(""))
		    sbSql.append("   AND B.MU_CD = '" + nullToBlank(ds_Cond.getString(0, "MU_CD")) + "' \n");
		if (nullToBlank(ds_Cond.getString(0, "CHK_")).equals("Y"))
//		    sbSql.append("   AND A.ACC_CLOSEDATE IS NULL \n");
		    sbSql.append("   AND A1.CLOSE_DATE IS NULL \n");
		sbSql.append(" GROUP BY A1.TM_CD , A1.TM_NM \n");
		if (! sType.equals("popup"))
			sbSql.append("        , A.UPJANG, A.UPJANGNM, C.JDATE \n");
out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_List = this.makeDataSet(rs, "ds_List");
		
		pstmt.close();
		rs.close();
		
		//FileLog.println("d:\\aaa.txt", ds_List);

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