<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 영업관리/마케팅
■ 프로그램ID   : AMG10051S_T001.jsp
■ 프로그램명   : 거래처 자재별 매출집계표
■ 작성일자     : 2008-02-25
■ 작성자       : 황승한
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
		
	
		String str_in_DEPT_ID            = nullToBlank(ds_cond.getString(0, "DEPT_ID"));
		String str_in_PART_SALES_SABUN   = nullToBlank(ds_cond.getString(0, "PART_SALES_SABUN"));
		String str_in_CENTER_CODE        = nullToBlank(ds_cond.getString(0, "CENTER_CODE"));
		String str_in_TRANS_DATEFR       = nullToBlank(ds_cond.getString(0, "TRANS_DATEFR"));
		String str_in_TRANS_DATETO       = nullToBlank(ds_cond.getString(0, "TRANS_DATETO"));
		String str_in_MAIN_UPJANG        = nullToBlank(ds_cond.getString(0, "MAIN_UPJANG"));
		String str_in_SUB_UPJANG         = nullToBlank(ds_cond.getString(0, "SUB_UPJANG"));
		String str_in_JOB                = nullToBlank(ds_cond.getString(0, "JOB"));
		String str_in_SUBJOB             = nullToBlank(ds_cond.getString(0, "SUB_JOB"));
		
		String str_in_chk_0    = nullToBlank(ds_cond.getString(0, "chk_0"));
		
		String str_Div         = " A.SALE_PRICE";
	
		if (str_in_chk_0.equals("true")){
			
			
			//str_Div =  " / (1 + ((SELECT FM_SALE_RATE FROM HLDC_PO_SUBINVENTORY WHERE SUBINV_CODE = C.SUBINV_CODE) /100)) ";	
			str_Div =  "ROUND(A.SALE_PRICE / (1 + DECODE(A.TAX_CODE,'100',NVL(A.FM_SALE_RATE,0),NVL(A.FM_NOSALE_RATE,0))/100))";
	
		}
		
		
	
		
		//FileLog.println("d:\\aaa.txt", ds_cond);


		//Master 조회###########################################################################
		
		//out 데이타
		DataSet ds_list;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		//내역조회	
		

		sbSql.append("    SELECT /*+ LEADING(D B A) USE_HASH(B) USE_HASH(A) */ D.CLASS_NAME, ITEM_CODE,ITEM_NAME,ITEM_SIZE,TRANS_UOM \n");
		sbSql.append("         , SUM(A.TRANS_QTY) SUM_A \n");
		sbSql.append("         , DECODE(SUM(A.TRANS_QTY),0,0,ROUND(SUM(A.UNIT_AMOUNT)/SUM(A.TRANS_QTY))) SUM_B \n");
		sbSql.append("         , DECODE(SUM(A.TRANS_QTY),0,0,ROUND(SUM(ROUND(A.TRANS_QTY *  " + str_Div + "))/SUM(A.TRANS_QTY))) SUM_C \n");
		sbSql.append("         , SUM(ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * A.TRANS_QTY *  " + str_Div + ")) SUM_D_TOT \n");
		sbSql.append("         , SUM(ROUND(A.TRANS_QTY *  " + str_Div + ")) SUM_D \n");
		sbSql.append("         , SUM(ROUND(A.TRANS_QTY *  " + str_Div + ")) - SUM(A.UNIT_AMOUNT) SUM_E \n");
		sbSql.append("         , DECODE(SUM(ROUND(A.TRANS_QTY *  " + str_Div + ")),0,0,100*(SUM(ROUND(A.TRANS_QTY *  " + str_Div + ")) - SUM(A.UNIT_AMOUNT))/SUM(ROUND(A.TRANS_QTY *  " + str_Div + "))) SUM_F \n");
		sbSql.append("      FROM ( \n");
		sbSql.append("            SELECT /*+ USE_HASH(C) */ A.TRANS_UPJANG, SUBSTR(A.ITEM_CODE,1,4)||'0000' AS ITEM_CLASS, A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.TRANS_UOM \n");
		sbSql.append("                 , DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * A.TRANS_QTY TRANS_QTY, DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * A.UNIT_AMOUNT UNIT_AMOUNT, A.SALE_PRICE, A.CENTER_CODE, C.FM_SALE_RATE, C.FM_NOSALE_RATE, A.TAX_CODE \n");
		sbSql.append("              FROM PO_TRANSACTION@FCUS_TO_HLDC A, FM_SALE_RATE@FCUS_TO_HLDC C \n");
		sbSql.append("             WHERE (A.SUBINV_CODE  = C.SUBINV_CODE(+)) \n");
		sbSql.append("               AND SUBSTR(A.ITEM_CODE,1,6)||'00' = C.ITEM_CLASS(+) \n");		
		sbSql.append("               AND (A.TRANS_DATE BETWEEN C.SDATE(+) AND C.EDATE(+)) \n");
		sbSql.append("               AND (C.USE_YN(+) = 'Y') \n");
		sbSql.append("               AND (A.TRANS_DATE BETWEEN '" + str_in_TRANS_DATEFR + "' AND '" + str_in_TRANS_DATETO + "') \n");
		sbSql.append("               AND (A.TRANS_TYPE = 'I001' OR (A.TRANS_TYPE LIKE '_002' AND A.SOURCE_TYPE = 'PO')) \n");
		sbSql.append("           ) A \n");
		sbSql.append("         , FMS_UPJANG@FCUS_TO_FSUS B \n");
		sbSql.append("         , PO_ITEM_CLASS_HLDC_V@FCUS_TO_HLDC D \n");		
		sbSql.append("     WHERE A.TRANS_UPJANG = B.UPJANG \n");
		sbSql.append("       AND A.ITEM_CLASS   = D.CLASS_CODE \n");		
		
		if (!str_in_DEPT_ID.equals("")){
			sbSql.append("            AND   (B.DEPT_ID               = " + str_in_DEPT_ID  + ") \n");
		}
		
		if (!str_in_PART_SALES_SABUN.equals("")){
			sbSql.append("            AND   (B.PART_SALES_SABUN      = '" + str_in_PART_SALES_SABUN  + "') \n");
		}
		
		if (!str_in_CENTER_CODE.equals("")){
			sbSql.append("            AND   (A.CENTER_CODE           = '" + str_in_CENTER_CODE  + "') \n");
		}
		
		if (!str_in_JOB.equals("")){
			sbSql.append("            AND   (B.BIZ_GROUP           = '" + str_in_JOB  + "') \n");
		}
		if (!str_in_SUBJOB.equals("")){
			sbSql.append("            AND   (B.BIZ_DETAIL          = '" + str_in_SUBJOB  + "') \n");
		}
		
		
		if (!str_in_SUB_UPJANG.equals("")){
			sbSql.append("            AND   (A.TRANS_UPJANG          = " + str_in_SUB_UPJANG  + ") \n");
		}
		else {
			
			
			if (!str_in_MAIN_UPJANG.equals("")){
				sbSql.append("        AND   (B.MAIN_UPJANG          = " + str_in_MAIN_UPJANG  + ") \n");
			}
			
		}
		
		sbSql.append("     GROUP BY D.CLASS_NAME, A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.TRANS_UOM \n");
		sbSql.append("     ORDER BY D.CLASS_NAME, A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.TRANS_UOM \n");

		

	

		

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