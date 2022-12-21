<%
/*------------------------------------------------------------------------------------------
■ 시스템명     : 식재영업/수불관리
■ 프로그램ID   : FMP00660V_T001.jsp
■ 프로그램명   : 본부 담당자별 거래실적 집계
■ 작성일자     : 2008-01-31
■ 작성자       : 박은규
■ 이력관리     : 2008-01-31
               [수정] 2009/07/22 BY 노규완
                     : 매출 장려율 테이블 FM_SALE_RATE 에서 과/면세 율(%)을 따로 관리 하기 위해 수정.
                     DECODE(A.TAX_CODE,'100',NVL(K.FM_SALE_RATE,0),NVL(K.FM_NOSALE_RATE,0))
-------------------------------------------------------------------------------------------*/
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
		DataSet ds_cond     = in_dl.get("ds_Cond");
		//입력 파라메터
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		String sType        = nullToBlank(in_vl.getString("sType"));
		//FileLog.println("d:\\aaa.txt", ds_cond);


		//out 데이타
		DataSet ds_list;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		
		String sMainUpjang = nullToBlank(ds_cond.getString(0, "MAIN_UPJANG"));
		//내역조회
		sbSql.append("SELECT E.UPJANGNM_DISP AS MAIN_UPJANG \n");
		sbSql.append("     , D.UPJANGNM_DISP AS UPJANG \n");
		sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.TRANS_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))) AS OP_AMOUNT \n");
		sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(ROUND(A.TRANS_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)) * DECODE(A.TAX_CODE,'100',1.1,1))) AS OP_AMOUNT1 \n");
		sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * A.SALE_AMOUNT) AS SALE_AMOUNT \n");
		sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.SALE_AMOUNT * DECODE(A.TAX_CODE,'100',1.1,1))) AS SALE_AMOUNT1 \n");
//**************  FM_NOSALE_RATE 추가에 따른 변경  2009/07/22 백업 및 수정  *******************
//		sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.TRANS_QTY * ROUND(A.SALE_PRICE / (1 + (NVL(B.FM_SALE_RATE,0)/100))))) AS HQ_AMOUNT \n");
		sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.TRANS_QTY * ROUND(A.SALE_PRICE / (1 + DECODE(A.TAX_CODE,'100',NVL(B.FM_SALE_RATE,0),NVL(B.FM_NOSALE_RATE,0))/100)))) AS HQ_AMOUNT \n");
//**************  FM_NOSALE_RATE 추가에 따른 변경  2009/07/22 백업 및 수정  *******************
		//부가세는 매출장려율 적용하지 않는다. 또한 합계 후 라운드
		sbSql.append("     , ROUND(SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.TAX_CODE,'100',A.SALE_AMOUNT*0.1 + A.TRANS_QTY*A.SALE_VAT,0))) \n");
//**************  FM_NOSALE_RATE 추가에 따른 변경  2009/07/22 백업 및 수정  *******************		
//		sbSql.append("     + SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.TRANS_QTY * ROUND(A.SALE_PRICE / (1 + (NVL(B.FM_SALE_RATE,0)/100))))) AS HQ_AMOUNT1 \n");
		sbSql.append("     + SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.TRANS_QTY * ROUND(A.SALE_PRICE / (1 + DECODE(A.TAX_CODE,'100',NVL(B.FM_SALE_RATE,0),NVL(B.FM_NOSALE_RATE,0))/100)))) AS HQ_AMOUNT1 \n");
//**************  FM_NOSALE_RATE 추가에 따른 변경  2009/07/22 백업 및 수정  *******************
		sbSql.append("  FROM PO_TRANSACTION@FCUS_TO_HLDC A, FM_SALE_RATE@FCUS_TO_HLDC B, FMU_OP_RATE@FCUS_TO_FSUS C \n");
		sbSql.append("     , FMS_UPJANG@FCUS_TO_FSUS D, FMS_UPJANG@FCUS_TO_FSUS E \n");
		sbSql.append(" WHERE A.SUBINV_CODE = B.SUBINV_CODE(+) \n");
		sbSql.append("   AND A.TRANS_DATE BETWEEN B.SDATE(+) AND B.EDATE(+) \n");
		sbSql.append("   AND SUBSTR(A.ITEM_CODE,1,8) = B.ITEM_CLASS(+) \n");		
		sbSql.append("   AND B.USE_YN(+) = 'Y' \n");
		sbSql.append("   AND A.TRANS_UPJANG = D.UPJANG \n");
		sbSql.append("   AND D.MAIN_UPJANG = E.UPJANG \n");
		sbSql.append("   AND A.TRANS_UPJANG = C.UPJANG(+) \n");
		sbSql.append("   AND A.TRANS_DATE BETWEEN C.SDATE(+) AND C.EDATE(+) \n");
		sbSql.append("   AND A.ITEM_CODE BETWEEN C.ITEM_CODE(+) AND C.ITEM_CODE(+)||'9999' \n");
		sbSql.append("   AND C.USE_YN(+) = 'Y' \n");
		sbSql.append("   AND A.TRANS_DATE BETWEEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATET")) + "' \n");
		sbSql.append("   AND (A.TRANS_TYPE = 'I001' OR (A.TRANS_TYPE LIKE '_002' AND A.SOURCE_TYPE = 'PO')) \n");
		if (! sMainUpjang.equals(""))
			sbSql.append("   AND D.MAIN_UPJANG = " + nullToBlank(ds_cond.getString(0, "MAIN_UPJANG")) + " \n");
		sbSql.append("   AND D." + sType + " = '" + nullToBlank(ds_cond.getString(0, "SABUN")) + "' \n");
		sbSql.append(" GROUP BY E.UPJANGNM_DISP, D.UPJANGNM_DISP \n");

out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_list = this.makeDataSet(rs, "ds_List");
		
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
