<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 영업관리/매출조회
■ 프로그램ID   : AMG10051S_T001.jsp
■ 프로그램명   : 일별매출(조회)
■ 작성일자     : 2008-02-25
■ 작성자       : 황승
■ 이력관리     : 2008-02-25
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	Statement stmt             =  null;

	try	{
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));			
	
		//입력 데이타
		DataSet ds_cond     = in_dl.get("ds_cond");
		
		//입력 파라메터
		
		//String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		//String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		//String sUpjang      = nullToBlank(in_vl.getString("sUpjang"));
		
	
		String str_in_TRX_DATE     = nullToBlank(ds_cond.getString(0, "TRX_DATE"));
		String str_in_TM_CD        = nullToBlank(ds_cond.getString(0, "TM_CD"));
		String str_in_UPJANG       = nullToBlank(ds_cond.getString(0, "UPJANG"));
		String str_in_SUB_JOB_CD   = nullToBlank(ds_cond.getString(0, "SUB_JOB_CD"));
		String str_in_LOC_CD       = nullToBlank(ds_cond.getString(0, "LOC_CD"));
		String str_in_UNIT         = nullToBlank(ds_cond.getString(0, "UNIT"));
		String str_in_HOMEPLUS     = nullToBlank(ds_cond.getString(0, "HOMEPLUS"));
		
		
		
		//FileLog.println("d:\\aaa.txt", ds_cond);


		//out 데이타
		DataSet ds_list;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		//내역조회	
		sbSql.append("    /* MAG10053S_T001.jsp */ \n");
		sbSql.append("    SELECT V.SAUP_TYPE, \n");
		sbSql.append("           (SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'MA0001' AND CODE = V.SAUP_TYPE) SAUP_TYPENM, \n");
		sbSql.append("           V.GUBUN, \n");
		sbSql.append("           V.MU_CD, \n");
		sbSql.append("          (SELECT MU_NM FROM HLDC_SC_TM WHERE MU_CD = V.MU_CD AND ROWNUM <= 1) MU_NM, \n");
		sbSql.append("           V.TM_CD, \n");
		sbSql.append("          (SELECT TM_NM FROM HLDC_SC_TM WHERE TM_CD = V.TM_CD AND ROWNUM <= 1) TM_NM, \n");
		sbSql.append("           V.UPJANG_CD, \n");
		sbSql.append("          (SELECT UPJANGNM FROM SCO_UPJANG_MST_V WHERE UPJANG = V.UPJANG_CD) UPJANGNM, \n");
		sbSql.append("           V.SUB_UPJANG, \n");
		sbSql.append("          (SELECT UPJANGNM FROM SCO_UPJANG_MST_V WHERE UPJANG = V.SUB_UPJANG) SUB_UPJANGNM, \n");
		sbSql.append("           V.NEW_GUBUN, \n");
			
		String str_Date    = "";
		String str_DateSQL = "";		
		
		//int i;
		
		for ( int i = 1 ; i <= 12 ; i++ ){
	        
			
	        str_Date = Integer.toString(i);
	        
	        if (i < 10)
			str_Date = "0" + str_Date;
				        		
	        str_DateSQL += " SUM(DECODE(SUBSTR(V.TRX_DATE, 5, 2), '" + str_Date + "', QTY, 0)) QTY" + str_Date  + ",\n";			

	    }
    
	    sbSql.append(str_DateSQL);
	    
		sbSql.append("     SUM(QTY) TOT_QTY, \n");		
		sbSql.append("           V.SAUP_TYPE||'-'||V.TM_CD||'-'||V.UPJANG_CD||'-'||V.SUB_UPJANG PL_CD, \n");
		sbSql.append("           '1' PL_UP_CD, \n");
		sbSql.append("           DECODE(V.GUBUN, 'IFIS', '1', '0') BL_SHOW, \n");
		sbSql.append("           4 LEVEL_NO, \n");
		sbSql.append("           '+' BL_PLUS \n");
		 sbSql.append("      FROM ( \n");
		/*sbSql.append("            SELECT C.SAUP_TYPE, \n");
		sbSql.append("                   'IFIS' GUBUN, \n");
		sbSql.append("                   C.TM_CD, \n");
		sbSql.append("                   V.UPJANG_CD, \n");
		sbSql.append("                   NULL SUB_UPJANG, \n");
		sbSql.append("                   (CASE WHEN SUBSTR(MAX(C.OPEN_DATE), 1, 4) < SUBSTR('" + str_in_TRX_DATE + "', 1, 4)  THEN '기존' \n");
		sbSql.append("                         WHEN SUBSTR(MAX(C.OPEN_DATE), 1, 4) >= SUBSTR('" + str_in_TRX_DATE + "', 1, 4) THEN '신규' \n");
		sbSql.append("                         ELSE '미지정' END) NEW_GUBUN, \n");
		sbSql.append("                   SUBSTR(V.OCCUR_DATE, 1, 6) TRX_DATE, \n");
		sbSql.append("                   NVL(SUM(DECODE(SALS_CLASS, '1104', SAL_QUANTITY, '1105', SAL_QUANTITY, 0)), 0) QTY \n");		
		sbSql.append("              FROM SLA_IF_UPJANG_SALS_DETAIL V, \n");
		sbSql.append("                   SCO_UPJANG_MST_V C \n");
		sbSql.append("            WHERE   (V.UPJANG_CD     = C.UPJANG) \n");
		sbSql.append("            AND   (V.OCCUR_DATE   BETWEEN '" + str_in_TRX_DATE + "'||'0101' AND '" + str_in_TRX_DATE + "'||'1231') \n");

		
		if (!str_in_TM_CD.equals("")){
			sbSql.append("            AND   (C.TM_CD      = '" + str_in_TM_CD  + "') \n");
		}
		
		if (!str_in_UPJANG.equals("")){
			sbSql.append("            AND   (C.UPJANG      = " + str_in_UPJANG  + ") \n");
		}

		if (!str_in_SUB_JOB_CD.equals("")){
			sbSql.append("            AND   (C.SUB_JOB_CD  = '" + str_in_SUB_JOB_CD  + "') \n");
		}

		if (!str_in_LOC_CD.equals("")){
			sbSql.append("            AND   (C.LOC_CD  = '" + str_in_LOC_CD  + "') \n");
		}		
		
		sbSql.append("            GROUP BY C.SAUP_TYPE, C.TM_CD, V.UPJANG_CD,  SUBSTR(V.OCCUR_DATE, 1, 6) \n");
		
		
		//호텔 및 63 업장 내역조회 2010.07.26#######################################
		sbSql.append("    UNION ALL \n");				
 */
		sbSql.append("            SELECT C.SAUP_TYPE, \n");
		sbSql.append("                   'IFIS' GUBUN, \n");
		sbSql.append("                   C.MU_CD, \n");
		sbSql.append("                   C.TM_CD, \n");
		sbSql.append("                   C.UPJANG, \n");
		sbSql.append("                   V.UPJANG_CD, \n");
		sbSql.append("                   NULL SUB_UPJANG, \n");
		sbSql.append("                   (CASE WHEN SUBSTR(MAX(C.OPEN_DATE), 1, 4) < SUBSTR('" + str_in_TRX_DATE + "', 1, 4)  THEN '기존' \n");
		sbSql.append("                         WHEN SUBSTR(MAX(C.OPEN_DATE), 1, 4) >= SUBSTR('" + str_in_TRX_DATE + "', 1, 4) THEN '신규' \n");
		sbSql.append("                         ELSE '미지정' END) NEW_GUBUN, \n");
		sbSql.append("                   SUBSTR(V.OCCUR_DATE, 1, 6) TRX_DATE, \n");
		sbSql.append("                   NVL(SUM(DECODE(V.SALS_CLASS, '1103', V.SAL_QUANTITY, '1108', V.SAL_QUANTITY, '1204', V.SAL_QUANTITY, '1205', V.SAL_QUANTITY, 0)),0) QTY \n"); 	
		sbSql.append("            FROM SLA_IF_UPJANG_SALS_DETAIL V, \n");
		sbSql.append("                	  SLA_IF_UPJANG_SALS_MST V2, \n");		
		sbSql.append("                    SCO_UPJANG_MST_V C \n");
		
		if (str_in_HOMEPLUS.equals("1")){		
			sbSql.append("               ,SCC_COMMON_CODE T4 \n");
		}
				
		sbSql.append("            WHERE (V.UPJANG_CD = V2.UPJANG_CD)  \n");
		sbSql.append("            AND   (V.RECEIPT_NUM = V2.RECEIPT_NUM) \n");
		sbSql.append("            AND   (V.OCCUR_DATE = V2.OCCUR_DATE) \n");
		//sbSql.append("            AND   V2.SYS_CLASS = '11' \n");
		sbSql.append("            AND   V2.UPJANG_CD = C.UPJANG \n");
		
		if (str_in_HOMEPLUS.equals("1")){
		sbSql.append("            AND	 V2.UPJANG_CD = T4.CODE \n");
		sbSql.append("            AND	 T4.GROUP_CODE = 'UPJANG_GROUP' \n");
		sbSql.append("            AND	 T4.USE_YN = 'Y' \n");
		sbSql.append("            AND	 SET1 = " + str_in_UPJANG  + " \n");		
		}		
		
		sbSql.append("            AND   V2.TOT_PSN IS NOT NULL \n");
		sbSql.append("            AND   (V.OCCUR_DATE   BETWEEN '" + str_in_TRX_DATE + "'||'0101' AND '" + str_in_TRX_DATE + "'||'1231') \n");

		if (!str_in_HOMEPLUS.equals("1")){
			if (!str_in_TM_CD.equals("")){
				//sbSql.append("            AND   (C.TM_CD      = '" + str_in_TM_CD  + "' OR C.PT_CD = '" + str_in_TM_CD + "') \n");
				//본부조회추가
				sbSql.append("            AND   (C.TM_CD    LIKE  '" + str_in_TM_CD  + "'||'%' OR C.PT_CD LIKE '" + str_in_TM_CD + "'||'%') \n");
			}
		
			if (!str_in_UPJANG.equals("")){
				sbSql.append("            AND   (C.UPJANG      = " + str_in_UPJANG  + ") \n");
			}
		}
		
		//if (str_in_HOMEPLUS.equals("1")){
		//	if (!str_in_UPJANG.equals("")){
		//	sbSql.append("            AND   (C.UPJANG       IN  (SELECT Z.CODE FROM SCC_COMMON_CODE Z WHERE Z.GROUP_CODE = 'UPJANG_GROUP' AND Z.USE_YN = 'Y' AND SET1 = " + str_in_UPJANG  + "  )) \n");	
		//	}
		//}
		
		if (!str_in_SUB_JOB_CD.equals("")){
			sbSql.append("            AND   (C.SUB_JOB_CD  = '" + str_in_SUB_JOB_CD  + "') \n");
		}

		if (!str_in_LOC_CD.equals("")){
			sbSql.append("            AND   (C.LOC_CD  = '" + str_in_LOC_CD  + "') \n");
		}		
		
		sbSql.append("            GROUP BY C.SAUP_TYPE, C.MU_CD, C.TM_CD, C.UPJANG,  SUBSTR(V.OCCUR_DATE, 1, 6), V.UPJANG_CD \n");

		//호텔 및 63 업장 내역조회 2010.07.26#######################################		
		
		sbSql.append("           ) V \n");
		sbSql.append("    GROUP BY V.SAUP_TYPE, V.GUBUN, V.MU_CD, V.TM_CD, V.UPJANG_CD, V.SUB_UPJANG, V.NEW_GUBUN \n");
		

        //out_vl.add("fa_Sql", sbSql.toString());

        //System.out.println(sbSql.toString());
		//pstmt = conn.prepareStatement(sbSql.toString());		
		//rs = pstmt.executeQuery(); 
		
		stmt = conn.createStatement();		
		rs = stmt.executeQuery(sbSql.toString()); 		
		
		ds_list = this.makeDataSet(rs, "ds_list");
		
		rs.close();
		stmt.close();		
		//FileLog.println("d:\\aaa.txt", ds_list);

		/**종료**/
		out_dl.add(ds_list);
		this.setResultMessage(0, "OK", out_vl);

	}
	catch(Exception ex)
	{
		//ex.printStackTrace();
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
		if(stmt != null) {
			try {
				stmt.close();
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