<%
//-----------------------------------------------------------------------------
//■ 시스템명     : 식재영업/수불관리
//■ 프로그램ID   : FMP00550V_T001.jsp
//■ 프로그램명   : 수불내역 조회
//■ 작성일자     : 2008.01.22
//■ 작성자       : 노규완
//■ 이력관리     : 2008.01.22
//-----------------------------------------------------------------------------*/
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
		DataSet ds_cond     = in_dl.get("ds_cond");
		//입력 파라메터
	//	String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String sCHK_DAY     = nullToBlank(ds_cond.getString(0, "CHK_DAY"));
	
	//FileLog.println("d:\\aaa.txt", ds_cond);


		//out 데이타
		DataSet ds_list;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

// alert기능	 System.out.println(nullToBlank(ds_cond.getString(0, "ITEM_DETAIL")));
//내역조회
//---------------------------------------------
//-----조회 조건에서 일자별 수불내역 조회 일 경우--------
//---------------------------------------------
if ( !sCHK_DAY.equals("0") )   
	{
		sbSql.append( " SELECT  \n");
		if ( nullToBlank(ds_cond.getString(0, "ITEM_DETAIL")).equals("1"))
			{
				sbSql.append("            A.ITEM_CODE, \n");
				sbSql.append("            A.ITEM_NAME, \n");
				sbSql.append("            A.ITEM_SIZE, \n");
				sbSql.append("            A.UOM_CODE, \n");
			}
		else
			{
				sbSql.append( "           B." + nullToBlank(ds_cond.getString(0, "ITEM_CLASS")) + ", \n");
				sbSql.append( "           (SELECT C.CLASS_NAME FROM HLDC_PO_ITEM_CLASS_HLDC_V C WHERE B." + nullToBlank(ds_cond.getString(0, "ITEM_CLASS")) + " = C.CLASS_CODE) AS CLASS_NAME, \n");
			}
		sbSql.append( "                   TO_CHAR(TO_DATE(A.SDATE,'YYYYMMDD'),'YYYY-MM-DD') SDATE, \n");
		sbSql.append( "                   SUM(A.FROM_QTY) AS FROM_QTY, \n");
		sbSql.append( "                   SUM(A.FROM_OPAMOUNT) AS FROM_AMOUNT, \n");
		sbSql.append( "                   SUM(A.IN_QTY) AS IN_QTY, \n");
		sbSql.append( "                   SUM(A.IN_OPAMOUNT) AS IN_AMOUNT, \n");
		sbSql.append( "                   SUM(A.OUT_QTY) AS OUT_QTY, \n");
		sbSql.append( "                   SUM(A.OUT_OPAMOUNT) AS OUT_AMOUNT, \n");
		sbSql.append( "                   SUM(A.TO_QTY) AS TO_QTY, \n");
		sbSql.append( "                   SUM(A.TO_OPAMOUNT) AS TO_AMOUNT, \n");
		sbSql.append("            		  B.ORIGIN_TYPE \n");
		sbSql.append( "              FROM FMP_SUBUL A, FMS_ITEM_V B \n");
		sbSql.append( "             WHERE A.ITEM_CODE = B.ITEM_CODE \n");
		sbSql.append( "               AND (A.FROM_QTY + A.IN_QTY + A.OUT_QTY + A.TO_QTY) <> 0 \n");
		sbSql.append( "               AND A.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
		if ( nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) != "")
			{
                sbSql.append( "       AND A.SUBINV_CODE = '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) + "' \n");
			}
		if ( nullToBlank(ds_cond.getString(0, "E_DATE")) != "")
			{
                sbSql.append( "       AND A.SDATE BETWEEN " + nullToBlank(ds_cond.getString(0, "S_DATE")) + " AND " + nullToBlank(ds_cond.getString(0, "E_DATE")) + " \n");
			}		
		if ( nullToBlank(ds_cond.getString(0, "ITEM_DETAIL")).equals("1"))
			{
                sbSql.append( "  GROUP BY A.SDATE, A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.UOM_CODE, B.ORIGIN_TYPE \n");
			}
		else
		{
                sbSql.append( "  GROUP BY A.SDATE, B." + nullToBlank(ds_cond.getString(0, "ITEM_CLASS")) + " \n");
		}
//------------------------------------------------------------------------------------------
// 2008년 07월 22일 재고량 0제외 기능 추가 
// 수정자 : 노규완
//------------------------------------------------------------------------------------------
		if ( nullToBlank(ds_cond.getString(0, "ZERO")).equals("1"))
		{
          sbSql.append( "        HAVING SUM(A.TO_QTY) <> '0'   \n");
		}
//------------------------------------------------------------------------------------------
	}
//---------------------------------------------
//-----조회 조건에서 기간별 수불내역 조회 일 경우--------
//---------------------------------------------
else
	{
	//-----------------------------------------
	//------------상품별 상세 텝 일 경우------------
	//-----------------------------------------
		if ( nullToBlank(ds_cond.getString(0, "ITEM_DETAIL")).equals("1"))
			{
				//상품별 기간별
                sbSql.append(" SELECT A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.UOM_CODE \n");
                sbSql.append("      , SUM(DECODE(A.SDATE,'" + nullToBlank(ds_cond.getString(0, "S_DATE")) + "' ,A.FROM_QTY,0)) AS FROM_QTY \n");
                sbSql.append("      , SUM(DECODE(A.SDATE,'" + nullToBlank(ds_cond.getString(0, "S_DATE")) + "' ,A.FROM_OPAMOUNT,0)) AS FROM_AMOUNT \n");
                sbSql.append("      , SUM(A.IN_QTY) AS IN_QTY \n");
                sbSql.append("      , SUM(A.IN_OPAMOUNT) AS IN_AMOUNT \n");
                sbSql.append("      , SUM(A.OUT_QTY) AS OUT_QTY \n");
                sbSql.append("      , SUM(A.OUT_OPAMOUNT) AS OUT_AMOUNT \n");
                sbSql.append("      , SUM(DECODE(A.SDATE,'" + nullToBlank(ds_cond.getString(0, "E_DATE")) + "', A.TO_QTY,0)) AS TO_QTY \n");
                sbSql.append("      , SUM(DECODE(A.SDATE,'" + nullToBlank(ds_cond.getString(0, "E_DATE")) + "', A.TO_OPAMOUNT,0)) AS TO_AMOUNT \n");
                sbSql.append("      , B.ORIGIN_TYPE \n");
                sbSql.append("   FROM FMP_SUBUL A, FMS_ITEM_V B \n");
                sbSql.append("  WHERE A.ITEM_CODE = B.ITEM_CODE \n");
        		sbSql.append("    AND (A.FROM_QTY + A.IN_QTY + A.OUT_QTY + A.TO_QTY) <> 0 \n");
                sbSql.append("    AND A.UPJANG = '" + nullToBlank(ds_cond.getString(0, "UPJANG")) + "' \n");
                sbSql.append("    AND A.SUBINV_CODE = '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) + "' \n");
                sbSql.append("    AND A.SDATE BETWEEN '" + nullToBlank(ds_cond.getString(0, "S_DATE")) + "' AND '" + nullToBlank(ds_cond.getString(0, "E_DATE")) + "' \n");
                sbSql.append(" GROUP BY A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.UOM_CODE, B.ORIGIN_TYPE  \n");	
//------------------------------------------------------------------------------------------
// 2008년 07월 22일 재고량 0제외 기능 추가 
// 수정자 : 노규완
//------------------------------------------------------------------------------------------
               if ( nullToBlank(ds_cond.getString(0, "ZERO")).equals("1"))
               {
                 sbSql.append( "       HAVING SUM(DECODE(A.SDATE,'" + nullToBlank(ds_cond.getString(0, "E_DATE")) + "', A.TO_QTY,0)) <> '0'   \n");
               }
//------------------------------------------------------------------------------------------	
			}
		else
			{
				//대중소 분류별
               sbSql.append(" SELECT C.CLASS_NAME \n");
               sbSql.append("      , SUM(DECODE(A.SDATE,'" + nullToBlank(ds_cond.getString(0, "S_DATE")) + "', A.FROM_QTY,0)) AS FROM_QTY \n");
               sbSql.append("      , SUM(DECODE(A.SDATE,'" + nullToBlank(ds_cond.getString(0, "S_DATE")) + "', A.FROM_OPAMOUNT,0)) AS FROM_AMOUNT \n");
               sbSql.append("      , SUM(A.IN_QTY) AS IN_QTY \n");
               sbSql.append("      , SUM(A.IN_OPAMOUNT) AS IN_AMOUNT \n");
               sbSql.append("      , SUM(A.OUT_QTY) AS OUT_QTY \n");
               sbSql.append("      , SUM(A.OUT_OPAMOUNT) AS OUT_AMOUNT \n");
               sbSql.append("      , SUM(DECODE(A.SDATE,'" + nullToBlank(ds_cond.getString(0, "E_DATE")) + "', A.TO_QTY,0)) AS TO_QTY \n");
               sbSql.append("      , SUM(DECODE(A.SDATE,'" + nullToBlank(ds_cond.getString(0, "E_DATE")) + "', A.TO_OPAMOUNT,0)) AS TO_AMOUNT \n");
               sbSql.append("   FROM FMP_SUBUL A, FMS_ITEM_V B, HLDC_PO_ITEM_CLASS_HLDC_V C \n");
               sbSql.append("  WHERE A.ITEM_CODE = B.ITEM_CODE \n");
               sbSql.append("    AND B." + nullToBlank(ds_cond.getString(0, "ITEM_CLASS")) + " = C.CLASS_CODE \n");
               sbSql.append("    AND A.UPJANG = '" + nullToBlank(ds_cond.getString(0, "UPJANG")) + "' \n");
               sbSql.append("    AND A.SUBINV_CODE = '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) + "' \n");
               sbSql.append("    AND A.SDATE BETWEEN '" + nullToBlank(ds_cond.getString(0, "S_DATE")) + "' AND '" + nullToBlank(ds_cond.getString(0, "E_DATE")) + "' \n");
               sbSql.append(" GROUP BY C.CLASS_CODE, C.CLASS_NAME \n");
//------------------------------------------------------------------------------------------
// 2008년 07월 22일 재고량 0제외 기능 추가 
// 수정자 : 노규완
//------------------------------------------------------------------------------------------
	           if ( nullToBlank(ds_cond.getString(0, "ZERO")).equals("1"))
			   {
                  sbSql.append( "       HAVING SUM(DECODE(A.SDATE,'" + nullToBlank(ds_cond.getString(0, "E_DATE")) + "', A.TO_QTY,0)) <> '0'   \n");
               }
//------------------------------------------------------------------------------------------	
			}	

	}		

		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_list = this.makeDataSet(rs, "ds_list");
		
		pstmt.close();
		rs.close();
		
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
