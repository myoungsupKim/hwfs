<%
//-----------------------------------------------------------------------------
//■ 시스템명     : 식재영업/수불관리/실적관리/상품별 거래실적 조회
//■ 프로그램ID   : FMP00720V_T001.jsp
//■ 프로그램명   : 공급업체별 거래실적 조회
//■ 작성일자     : 2008.01.31
//■ 작성자       : 노규완
//■ 이력관리     : 2008.01.31
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
	//	String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
	
	//FileLog.println("d:\\aaa.txt", ds_cond);


		//out 데이타
		DataSet ds_list;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		//
		String sMainUpjang = nullToBlank(ds_cond.getString(0, "MAIN_UPJANG"));
		String sUpjang = nullToBlank(ds_cond.getString(0, "UPJANG"));
		String sOtcustcd = nullToBlank(ds_cond.getString(0, "OTCUSTCD"));
		String sSubinv_Code = nullToBlank(ds_cond.getString(0, "SUBINV_CODE"));
		String sSdate = nullToBlank(ds_cond.getString(0, "SDATE"));
		String sEdate = nullToBlank(ds_cond.getString(0, "EDATE"));		
		String sTax = nullToBlank(ds_cond.getString(0, "TAX_CODE"));
		String sItemName = nullToBlank(ds_cond.getString(0, "ITEM_NAME"));
		String sSabun = nullToBlank(ds_cond.getString(0, "SABUN"));

		//=========================================================================================
		// (2013-08-27 변경) 시작
		// 김장욱  2013-08-27 SQL 튜닝
		//=========================================================================================
		//내역조회
		//if (sOtcustcd.equals(""))
		//{
		//	sbSql.append( "SELECT SDATE  \n");
		//	sbSql.append( "     , UPJANG \n");	
		//	sbSql.append( "     , UPJANGNM_DISP \n");	
		//	sbSql.append( "     , ITEM_CODE \n");				        
		//	sbSql.append( "     , ITEM_NAME \n");
		//	sbSql.append( "     , ITEM_SIZE \n");
		//	sbSql.append( "     , PO_UOM, TAX_CODE \n");
		//	sbSql.append( "     , SUM(NVL(SALE_PRICE,0)) AS SALE_PRICE  \n");
		//	sbSql.append( "     , SUM(NVL(PR_QTY,0)) AS PR_QTY \n");
		//	sbSql.append( "     , SUM(NVL(IN_PRICE,0)) AS IN_PRICE \n");
		//	sbSql.append( "     , SUM(NVL(TAX_AMOUNT,0)) AS TAX_AMOUNT \n");
		//	sbSql.append( "     , SUM(NVL(IN_AMOUNT,0)) AS IN_AMOUNT \n");				
		//	sbSql.append( "     , SDATE||'-'||UPJANGNM_DISP AS PL_CD \n");
		//	sbSql.append( "     , '1' PL_UP_CD \n");
		//	sbSql.append( "     , '0' BL_SHOW \n");
		//	sbSql.append( "     , 3 LEVEL_NO \n");
		//	sbSql.append( "     , '+' BL_PLUS \n");
		//	sbSql.append( "  FROM \n");
		//	sbSql.append( "( \n");
		//}
		//if (sOtcustcd.equals("") || sOtcustcd.equals("0000"))		
		//{
//			sbSql.append( "SELECT A.TRANS_UPJANG AS UPJANG \n");
//			sbSql.append( "     , C.UPJANGNM_DISP \n");
			//sbSql.append( "SELECT A.TRANS_DATE AS SDATE \n");		
			//sbSql.append( "     , C.MAIN_UPJANG AS UPJANG \n");
			//sbSql.append( "     , D.UPJANGNM_DISP AS UPJANGNM_DISP\n");			
			//sbSql.append( "     , A.ITEM_CODE \n");
			//sbSql.append( "     , A.ITEM_NAME \n");
			//sbSql.append( "     , A.ITEM_SIZE \n");
			//sbSql.append( "     , A.TRANS_UOM AS PO_UOM \n");				
			//sbSql.append( "     , DECODE(A.TAX_CODE,'100','과세','면세') AS TAX_CODE \n");
			//sbSql.append( "     , A.SALE_PRICE AS SALE_PRICE \n");			
			//sbSql.append( "     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * A.TRANS_QTY) AS PR_QTY \n");				
			//sbSql.append( "     , ROUND(SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * A.SALE_PRICE * A.TRANS_QTY)) AS IN_PRICE \n");				
			//sbSql.append( "     , ROUND(SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.TAX_CODE, '100', 0.1, 0) * ROUND(A.SALE_PRICE * A.TRANS_QTY)))  AS TAX_AMOUNT \n");				
			//sbSql.append( "     , ROUND(SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * A.SALE_PRICE * A.TRANS_QTY)) + ROUND(SUM(DECODE(A.TAX_CODE, '100', 0.1, 0) * ROUND(A.SALE_PRICE * A.TRANS_QTY)))  AS IN_AMOUNT \n");				
			//sbSql.append( "  FROM HLDC_PO_TRANSACTION A,  FMS_UPJANG C,  FMS_UPJANG D \n");
			//sbSql.append( " WHERE A.TRANS_UPJANG = C.UPJANG");
			//sbSql.append( "   AND C.MAIN_UPJANG  = D.UPJANG");
			//sbSql.append( "   AND A.TRANS_DATE BETWEEN '" + sSdate + "' AND '" + sEdate + "' \n");
			//sbSql.append("    AND (A.TRANS_TYPE = 'I001' OR (A.TRANS_TYPE LIKE '_002' AND A.SOURCE_TYPE = 'PO')) \n");
			//sbSql.append( "   AND A.SUBINV_CODE LIKE 'S10%' \n");
			//if ( !sMainUpjang.equals(""))
			//	sbSql.append( "   AND C.MAIN_UPJANG = '" + nullToBlank(ds_cond.getString(0, "MAIN_UPJANG")) + "' \n");			
			//if ( !sUpjang.equals(""))								
			//	sbSql.append( "   AND A.TRANS_UPJANG = '" + nullToBlank(ds_cond.getString(0, "UPJANG")) + "' \n");
			//if ( !sSubinv_Code.equals(""))							
			//	sbSql.append( "   AND A.SUBINV_CODE = '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) + "' \n");
			//if ( !sTax.equals(""))							
			//	sbSql.append( "   AND A.TAX_CODE = '" + sTax + "' \n");
			//if ( !sSabun.equals(""))							
			//	sbSql.append( "   AND C.PART_SALES_SABUN = '" + sSabun + "' \n");			
			//if ( !sItemName.equals(""))							
			//	sbSql.append( "   AND A.ITEM_NAME LIKE  '%" + sItemName + "%' \n");			
			//sbSql.append( " GROUP BY A.TRANS_DATE, C.MAIN_UPJANG, D.UPJANGNM_DISP, A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.TRANS_UOM, A.TAX_CODE, A.SALE_PRICE \n");
		//}
		//if (sOtcustcd.equals(""))		
		//	sbSql.append( "  UNION ALL \n");
		//if (sOtcustcd.equals("") || (! sOtcustcd.equals("0000")))		
		//{
//			sbSql.append( "SELECT A.UPJANG  \n");
//			sbSql.append( "     , C.UPJANGNM_DISP \n");	
			//sbSql.append( "SELECT A.NEED_DATE AS SDATE \n");		
			//sbSql.append( "     , C.MAIN_UPJANG AS UPJANG \n");	
			//sbSql.append( "     , D.UPJANGNM_DISP AS UPJANGNM_DISP\n");				
			//sbSql.append( "     , A.ITEM_CODE \n");
			//sbSql.append( "     , A.ITEM_NAME \n");
			//sbSql.append( "     , A.ITEM_SIZE \n");
			//sbSql.append( "     , A.PO_UOM \n");
			//sbSql.append( "     , DECODE(A.TAX_CODE,'100''과세','면세') AS TAX_CODE \n");
			//sbSql.append( "     , A.SALE_PRICE AS  SALE_PRICE \n");			
			//sbSql.append( "     , ROUND(SUM(A.PO_QTY)) AS PR_QTY \n");
			//sbSql.append( "     , ROUND(SUM(A.SALE_PRICE * A.PO_QTY)) AS IN_PRICE \n");				
			//sbSql.append( "     , ROUND(SUM(DECODE(A.TAX_CODE, '100', 0.1, 0) * ROUND(A.SALE_PRICE * A.PO_QTY)))  AS TAX_AMOUNT \n");				
			//sbSql.append( "     , ROUND(SUM(A.SALE_PRICE * A.PO_QTY)) + ROUND(SUM(DECODE(A.TAX_CODE, '100', 0.1, 0) * ROUND(A.SALE_PRICE * A.PO_QTY))) AS IN_AMOUNT \n");				
			//sbSql.append( "  FROM FMP_OTCUST_PR A, FMS_UPJANG C,  FMS_UPJANG D \n");			
			//sbSql.append( " WHERE A.UPJANG = C.UPJANG" );
			//sbSql.append( "   AND C.MAIN_UPJANG  = D.UPJANG");
			//sbSql.append( "   AND A.NEED_DATE BETWEEN '" + sSdate + "' AND '" + sEdate + "' \n");
			//if ( !sMainUpjang.equals(""))
			//	sbSql.append( "   AND C.MAIN_UPJANG = '" + nullToBlank(ds_cond.getString(0, "MAIN_UPJANG")) + "' \n");
			//if ( !sUpjang.equals(""))								
			//	sbSql.append( "   AND A.UPJANG = '" + nullToBlank(ds_cond.getString(0, "UPJANG")) + "' \n");
			//if ( !sSubinv_Code.equals(""))							
			//	sbSql.append( "   AND A.SUBINV_CODE = '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) + "' \n");
			//if (! sOtcustcd.equals(""))
			//	sbSql.append( "   AND A.OTCUSTCD = '" + nullToBlank(ds_cond.getString(0, "OTCUSTCD")) + "' \n");
			//if ( !sTax.equals(""))							
			//	sbSql.append( "   AND A.TAX_CODE = '" + sTax + "' \n");
			//if ( !sSabun.equals(""))							
			//	sbSql.append( "   AND C.PART_SALES_SABUN = '" + sSabun + "' \n");
			//if ( !sItemName.equals(""))							
			//	sbSql.append( "   AND A.ITEM_NAME LIKE '%" + sItemName + "%' \n");			
			//sbSql.append( "   AND A.LINE_STATUS <> '003' \n");				
			//sbSql.append( " GROUP BY A.NEED_DATE, C.MAIN_UPJANG,D.UPJANGNM_DISP, A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM, A.TAX_CODE, A.SALE_PRICE \n");
		//}			
		//if (sOtcustcd.equals(""))		
		//	sbSql.append( ") GROUP BY SDATE, UPJANG, UPJANGNM_DISP, ITEM_CODE, ITEM_NAME, ITEM_SIZE, PO_UOM, TAX_CODE \n");	
			
			
			
			
			
			
			
			
		//내역조회			
		if (sOtcustcd.equals(""))
		{
			sbSql.append( "SELECT SDATE  \n");
			sbSql.append( "     , A10.UPJANG \n");	
			sbSql.append( "     , B10.UPJANGNM_DISP \n");	
			sbSql.append( "     , ITEM_CODE \n");				        
			sbSql.append( "     , ITEM_NAME \n");
			sbSql.append( "     , ITEM_SIZE \n");
			sbSql.append( "     , PO_UOM, TAX_CODE \n");
			sbSql.append( "     , SUM(NVL(SALE_PRICE,0)) AS SALE_PRICE  \n");
			sbSql.append( "     , SUM(NVL(PR_QTY,0)) AS PR_QTY \n");
			sbSql.append( "     , SUM(NVL(IN_PRICE,0)) AS IN_PRICE \n");
			sbSql.append( "     , SUM(NVL(TAX_AMOUNT,0)) AS TAX_AMOUNT \n");
			sbSql.append( "     , SUM(NVL(IN_AMOUNT,0)) AS IN_AMOUNT \n");				
			sbSql.append( "     , SDATE||'-'||UPJANGNM_DISP AS PL_CD \n");
			sbSql.append( "     , '1' PL_UP_CD \n");
			sbSql.append( "     , '0' BL_SHOW \n");
			sbSql.append( "     , 3 LEVEL_NO \n");
			sbSql.append( "     , '+' BL_PLUS \n");
			sbSql.append( "  FROM \n");
			sbSql.append( "( \n");
		}
		if (sOtcustcd.equals("") || sOtcustcd.equals("0000"))		
		{
			//sbSql.append( "SELECT /*+ PARALLEL(A,4) */ A.TRANS_DATE AS SDATE \n");		
			sbSql.append( "SELECT A.TRANS_DATE AS SDATE \n");
			sbSql.append( "     , C.MAIN_UPJANG AS UPJANG \n");
			sbSql.append( "     , A.ITEM_CODE \n");
			sbSql.append( "     , A.ITEM_NAME \n");
			sbSql.append( "     , A.ITEM_SIZE \n");
			sbSql.append( "     , A.TRANS_UOM AS PO_UOM \n");				
			sbSql.append( "     , DECODE(A.TAX_CODE,'100','과세','면세') AS TAX_CODE \n");
			sbSql.append( "     , A.SALE_PRICE AS SALE_PRICE \n");			
			sbSql.append( "     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * A.TRANS_QTY) AS PR_QTY \n");				
			sbSql.append( "     , ROUND(SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * A.SALE_PRICE * A.TRANS_QTY)) AS IN_PRICE \n");				
			sbSql.append( "     , ROUND(SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.TAX_CODE, '100', 0.1, 0) * ROUND(A.SALE_PRICE * A.TRANS_QTY)))  AS TAX_AMOUNT \n");				
			sbSql.append( "     , ROUND(SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * A.SALE_PRICE * A.TRANS_QTY)) + ROUND(SUM(DECODE(A.TAX_CODE, '100', 0.1, 0) * ROUND(A.SALE_PRICE * A.TRANS_QTY)))  AS IN_AMOUNT \n");				
			sbSql.append( "  FROM PO_TRANSACTION@FCUS_TO_HLDC A,  FMS_UPJANG@FCUS_TO_FSUS C \n");
			sbSql.append( " WHERE A.TRANS_UPJANG = C.UPJANG");
			sbSql.append( "   AND A.TRANS_DATE BETWEEN '" + sSdate + "' AND '" + sEdate + "' \n");
			sbSql.append("    AND (A.TRANS_TYPE = 'I001' OR (A.TRANS_TYPE LIKE '_002' AND A.SOURCE_TYPE = 'PO')) \n");
			sbSql.append( "   AND A.SUBINV_CODE LIKE 'S10%' \n");
			
			if ( !sMainUpjang.equals(""))
				sbSql.append( "   AND C.MAIN_UPJANG = '" + nullToBlank(ds_cond.getString(0, "MAIN_UPJANG")) + "' \n");			
			if ( !sUpjang.equals(""))								
				sbSql.append( "   AND A.TRANS_UPJANG = '" + nullToBlank(ds_cond.getString(0, "UPJANG")) + "' \n");
			if ( !sSubinv_Code.equals(""))							
				sbSql.append( "   AND A.SUBINV_CODE = '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) + "' \n");
			if ( !sTax.equals(""))							
				sbSql.append( "   AND A.TAX_CODE = '" + sTax + "' \n");

			if ( !sSabun.equals(""))							

				sbSql.append( "   AND C.PART_SALES_SABUN = '" + sSabun + "' \n");			
			if ( !sItemName.equals(""))							
				sbSql.append( "   AND A.ITEM_NAME LIKE  '%" + sItemName + "%' \n");			
			sbSql.append( " GROUP BY A.TRANS_DATE, C.MAIN_UPJANG, A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.TRANS_UOM, A.TAX_CODE, A.SALE_PRICE \n");
		}
		if (sOtcustcd.equals(""))		
			sbSql.append( "  UNION ALL \n");
		if (sOtcustcd.equals("") || (! sOtcustcd.equals("0000")))		
		{
			//sbSql.append( "SELECT /*+ PARALLEL(A,4) */ A.NEED_DATE AS SDATE \n");		
			sbSql.append( "SELECT A.NEED_DATE AS SDATE \n");
			sbSql.append( "     , C.MAIN_UPJANG AS UPJANG \n");	
			sbSql.append( "     , A.ITEM_CODE \n");
			sbSql.append( "     , A.ITEM_NAME \n");
			sbSql.append( "     , A.ITEM_SIZE \n");
			sbSql.append( "     , A.PO_UOM \n");
			sbSql.append( "     , DECODE(A.TAX_CODE,'100''과세','면세') AS TAX_CODE \n");
			sbSql.append( "     , A.SALE_PRICE AS  SALE_PRICE \n");			
			sbSql.append( "     , ROUND(SUM(A.PO_QTY)) AS PR_QTY \n");
			sbSql.append( "     , ROUND(SUM(A.SALE_PRICE * A.PO_QTY)) AS IN_PRICE \n");				
			sbSql.append( "     , ROUND(SUM(DECODE(A.TAX_CODE, '100', 0.1, 0) * ROUND(A.SALE_PRICE * A.PO_QTY)))  AS TAX_AMOUNT \n");				
			sbSql.append( "     , ROUND(SUM(A.SALE_PRICE * A.PO_QTY)) + ROUND(SUM(DECODE(A.TAX_CODE, '100', 0.1, 0) * ROUND(A.SALE_PRICE * A.PO_QTY))) AS IN_AMOUNT \n");				
			sbSql.append( "  FROM FMP_OTCUST_PR@FCUS_TO_FSUS A, FMS_UPJANG@FCUS_TO_FSUS C \n");			
			sbSql.append( " WHERE A.UPJANG = C.UPJANG" );
			sbSql.append( "   AND A.NEED_DATE BETWEEN '" + sSdate + "' AND '" + sEdate + "' \n");
			
			if ( !sMainUpjang.equals(""))
				sbSql.append( "   AND C.MAIN_UPJANG = '" + nullToBlank(ds_cond.getString(0, "MAIN_UPJANG")) + "' \n");
			if ( !sUpjang.equals(""))								
				sbSql.append( "   AND A.UPJANG = '" + nullToBlank(ds_cond.getString(0, "UPJANG")) + "' \n");
			if ( !sSubinv_Code.equals(""))							
				sbSql.append( "   AND A.SUBINV_CODE = '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) + "' \n");
			if (! sOtcustcd.equals(""))
				sbSql.append( "   AND A.OTCUSTCD = '" + nullToBlank(ds_cond.getString(0, "OTCUSTCD")) + "' \n");
			if ( !sTax.equals(""))							
				sbSql.append( "   AND A.TAX_CODE = '" + sTax + "' \n");
			if ( !sSabun.equals(""))							

				sbSql.append( "   AND C.PART_SALES_SABUN = '" + sSabun + "' \n");

			if ( !sItemName.equals(""))							
				sbSql.append( "   AND A.ITEM_NAME LIKE '%" + sItemName + "%' \n");			
			sbSql.append( "   AND A.LINE_STATUS <> '003' \n");				
			sbSql.append( " GROUP BY A.NEED_DATE, C.MAIN_UPJANG, A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM, A.TAX_CODE, A.SALE_PRICE \n");
			sbSql.append( " ) A10, \n");
			sbSql.append( " FMS_UPJANG@FCUS_TO_FSUS B10 \n");
			sbSql.append( " WHERE A10.UPJANG = B10.UPJANG \n");
		}			
		if (sOtcustcd.equals(""))		
			sbSql.append( " GROUP BY SDATE, A10.UPJANG, UPJANGNM_DISP, ITEM_CODE, ITEM_NAME, ITEM_SIZE, PO_UOM, TAX_CODE \n");				
		
		//=========================================================================================
		// (2013-08-27 변경) 끝
		//=========================================================================================		
        	
//out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_list = this.makeDataSet(rs, "ds_list");
		
		pstmt.close();
		rs.close();

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
