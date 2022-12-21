<%
//-----------------------------------------------------------------------------
//■ 시스템명     : 단가관리/공급업체 관리/ 공급업체 발주내역 조회
//■ 프로그램ID   : FMP00590V_T001.jsp
//■ 프로그램명   : 공급업체 발주내역 조회
//■ 작성일자     : 2008.02.12
//■ 작성자       : 노규완
//■ 이력관리     : 2008.02.12
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
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		String sType        = nullToBlank(in_vl.getString("sType"));


		//out 데이타
		DataSet ds_list;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		//
		//String sUpjang = nullToBlank(ds_cond.getString(0, "UPJANG"));			//업장		
		String sSdate = nullToBlank(ds_cond.getString(0, "SDATE"));				//입고예정시작일
		String sEdate = nullToBlank(ds_cond.getString(0, "EDATE"));				//입고예정종료일
		String sOtcust = nullToBlank(ds_cond.getString(0, "OTCUSTCD"));			//공급업체
		String mainUpjang = nullToBlank(ds_cond.getString(0, "MAIN_UPJANG"));	//메인업장
		//String sSubinv = nullToBlank(ds_cond.getString(0, "SUBINV_CODE"));		//식당코드

// alert기능	 System.out.println(nullToBlank(ds_cond.getString(0, "ITEM_DETAIL")));
			
		//내역조회
		
		sbSql.append( "SELECT B.UPJANGNM_DISP \n");
		sbSql.append( "     , C.SUBINV_NAME_DISP \n");
		sbSql.append( "     , A.ITEM_CODE \n");
		sbSql.append( "     , A.PR_ID \n");		
		sbSql.append( "     , A.ITEM_NAME \n");
		sbSql.append( "     , A.ITEM_SIZE \n");
		sbSql.append( "     , A.PO_UOM \n");
		//sbSql.append( "     , A.FST_QTY \n");
		sbSql.append( "     , A.PR_QTY AS FST_QTY \n");
		sbSql.append( "     , A.PR_QTY \n");
		sbSql.append( "     , A.OTCUSTCD \n");	
		sbSql.append( "     , A.UPJANG \n");	
		sbSql.append( "     , A.SUBINV_CODE \n");			
		sbSql.append( "     , A.NEED_DATE \n");			
		sbSql.append( "     , A.TAX_CODE \n");
		if (sType.equals("운영"))
		{
			//운영율 FMU_OP_RATE -> FMS_TRANSACTION_V 수정 강대성 20150919 시작
			/*
			sbSql.append( "     , DECODE(NVL(E.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(E.OP_RATE,0) / 100),E.CEIL_VAL),E.OP_PRICE) AS SALE_PRICE \n");
			sbSql.append( "     , ROUND(A.PR_QTY * DECODE(NVL(E.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(E.OP_RATE,0) / 100),E.CEIL_VAL),E.OP_PRICE)) AS SUPPLYAMT \n");
			sbSql.append( "     , ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * ROUND(A.PR_QTY * DECODE(NVL(E.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(E.OP_RATE,0) / 100),E.CEIL_VAL),E.OP_PRICE))) AS VAT \n");
			sbSql.append( "     , ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.PR_QTY * DECODE(NVL(E.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(E.OP_RATE,0) / 100),E.CEIL_VAL),E.OP_PRICE))) AS AMT_SUM \n");
			*/
			//운영율 FMU_OP_RATE -> FMS_TRANSACTION_V 수정 강대성 20150919 끝
			sbSql.append( "     , DECODE(NVL(A.OP_PRICE,0),0,A.SALE_PRICE,A.OP_PRICE) AS SALE_PRICE \n");
			sbSql.append( "     , DECODE(A.OP_PRICE,0,ROUND(A.PR_QTY * A.SALE_PRICE),ROUND(A.PR_QTY * A.OP_PRICE)) AS SUPPLYAMT \n");
			sbSql.append( "     , DECODE(A.OP_PRICE,0,ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * ROUND(A.PR_QTY * A.SALE_PRICE)),ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * ROUND(A.PR_QTY * A.OP_PRICE))) AS VAT \n");
			sbSql.append( "     , DECODE(A.OP_PRICE,0,ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.PR_QTY * A.SALE_PRICE)),ROUND(DECODE(A.TAX_CODE,'100',1.1,0) * ROUND(A.PR_QTY * A.OP_PRICE))) AS AMT_SUM \n");
			
		}
		else
		{
			sbSql.append( "     , A.SALE_PRICE \n");
			sbSql.append( "     , ROUND(A.PR_QTY * A.SALE_PRICE) AS SUPPLYAMT \n");
			sbSql.append( "     , ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * ROUND(A.PR_QTY * A.SALE_PRICE)) AS VAT \n");
			sbSql.append( "     , ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.PR_QTY * A.SALE_PRICE)) AS AMT_SUM \n");
		}
		sbSql.append( "     , A.CONTENTS \n");
		sbSql.append( "  FROM FMP_OTCUST_PR A, FMS_UPJANG B, FMS_SUBINVENTORY C \n");
		//if (sType.equals("운영"))
			//운영율 FMU_OP_RATE -> FMS_TRANSACTION_V 수정 강대성 20150919 시작
			//sbSql.append( "     , FMU_OP_RATE E \n");
			//운영율 FMU_OP_RATE -> FMS_TRANSACTION_V 수정 강대성 20150919 끝
		sbSql.append( " WHERE A.UPJANG = B.UPJANG \n");
		sbSql.append( "   AND A.SUBINV_CODE = C.SUBINV_CODE \n");
		if (sType.equals("운영"))
		{
			//운영율 FMU_OP_RATE -> FMS_TRANSACTION_V 수정 강대성 20150919 시작
			/*
			sbSql.append( "   AND A.UPJANG = E.UPJANG(+) \n");
			sbSql.append( "   AND A.NEED_DATE BETWEEN E.SDATE(+) AND E.EDATE(+) \n");
			sbSql.append( "   AND A.ITEM_CODE BETWEEN E.ITEM_CODE(+) AND E.ITEM_CODE(+)||'9999' \n");
			sbSql.append( "   AND E.USE_YN(+) = 'Y' \n");
			*/
			//운영율 FMU_OP_RATE -> FMS_TRANSACTION_V 수정 강대성 20150919 끝
		}
		sbSql.append( "   AND A.NEED_DATE BETWEEN '" + sSdate + "' AND '" + sEdate +  "'\n");
		//sbSql.append( "   AND A.UPJANG = '" + sUpjang + "' \n");
		sbSql.append( "   AND A.OTCUSTCD = '" + sOtcust + "' \n");
		//sbSql.append( "   AND A.SUBINV_CODE = '" + sSubinv + "' \n");
		sbSql.append( "   AND A.LINE_STATUS <> '003' \n");
		sbSql.append( "   AND A.UPJANG IN (SELECT UPJANG FROM FMS_UPJANG WHERE MAIN_UPJANG='"+ mainUpjang + "') \n");
		sbSql.append( " ORDER BY B.UPJANGNM_DISP,A.ITEM_CODE \n");		
		
out_vl.add("fa_Sql", sbSql.toString());
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
