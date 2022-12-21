<%
//-----------------------------------------------------------------------------
//■ 시스템명     : 식재영업/수불관리/실적관리/공급업체별 거래실적 조회
//■ 프로그램ID   : FMP00710V_T001.jsp
//■ 프로그램명   : 공급업체별 거래실적 조회
//■ 작성일자     : 2008.01.29
//■ 작성자       : 노규완
//■ 이력관리     : 2008.01.29
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
	
		//out 데이타
		DataSet ds_list;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		//
		String sUpjang = nullToBlank(ds_cond.getString(0, "UPJANG"));
		String sOtcustcd = nullToBlank(ds_cond.getString(0, "OTCUSTCD"));
		String sSdate = nullToBlank(ds_cond.getString(0, "SDATE"));
		String sEdate = nullToBlank(ds_cond.getString(0, "EDATE"));		
	
		//내역조회
		//공급업체가 한화(OTCUSTCD = '0000')일 경우.	*************************************************************************************************		
		if ( sOtcustcd.equals("0000")){								
				sbSql.append( "          SELECT '0000' AS OTCUSTCD  \n");
				sbSql.append( "           , C.OTCUSTNM  \n");
				sbSql.append( "           , A.TRANS_UPJANG AS UPJANG  \n");
				sbSql.append( "           , B.UPJANGNM_DISP  \n");
				sbSql.append( "           , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * A.SALE_AMOUNT) AS TOT_AMOUNT  \n");
				sbSql.append( "           , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.TAX_CODE, '100', 0, A.SALE_AMOUNT)) TAX_AMOUNT_N  \n");
				sbSql.append( "           , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.TAX_CODE, '100', A.SALE_AMOUNT, 0)) TAX_AMOUNT_Y  \n");
				sbSql.append( "           , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE, '100', 0.1, 0) * A.SALE_AMOUNT))  AS TAX_AMOUNT  \n");
				sbSql.append( "           , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE, '100', 1.1, 1) * A.SALE_AMOUNT))  AS IN_TOT  \n");
				sbSql.append( "        FROM FMS_TRANSACTION_V A, FMS_UPJANG B, FMP_OTHER_CUST C  \n");
				sbSql.append( "       WHERE A.TRANS_UPJANG = B.UPJANG  \n");
				sbSql.append( "         AND C.OTCUSTCD = '0000'  \n");
				if ( !sUpjang.equals("")){				
					sbSql.append( "         AND B.MAIN_UPJANG = '" + nullToBlank(ds_cond.getString(0, "UPJANG")) + "' \n");
				}
				if ( !sSdate.equals("") && !sEdate.equals("")){
					sbSql.append( "         AND A.TRANS_DATE BETWEEN '" +sSdate+ "' AND '" +sEdate+ "'  \n");
				}
				sbSql.append( "         AND (A.TRANS_TYPE = 'I001' OR (A.TRANS_TYPE LIKE '_002' AND A.SOURCE_TYPE = 'PO')) \n");
				sbSql.append( "       GROUP BY OTCUSTCD, A.TRANS_UPJANG, C.OTCUSTNM, B.UPJANGNM_DISP  \n");
				sbSql.append( "       HAVING SUM(ROUND(DECODE(A.TAX_CODE, '100', 1.1, 1) * NVL(A.SALE_PRICE,0))) <> 0  \n");
		}
		//공급업체가 <전체>(OTCUSTCD = '')일 경우.	*************************************************************************************************		
		else if ( sOtcustcd.equals("") ){
				sbSql.append( "   SELECT A.OTCUSTCD \n");
				sbSql.append( "       , C.OTCUSTNM \n");
				sbSql.append( "       , TO_CHAR(A.UPJANG) AS UPJANG \n");
				sbSql.append( "       , B.UPJANGNM_DISP \n");
				sbSql.append( "       , SUM(A.SALE_AMOUNT) AS TOT_AMOUNT \n");
				sbSql.append( "       , SUM(DECODE(A.TAX_CODE, '100', 0, A.SALE_AMOUNT)) TAX_AMOUNT_N \n");
				sbSql.append( "       , SUM(DECODE(A.TAX_CODE, '100', A.SALE_AMOUNT, 0)) TAX_AMOUNT_Y \n");
				sbSql.append( "       , SUM(ROUND(DECODE(A.TAX_CODE, '100', 0.1, 0) * A.SALE_AMOUNT))  AS TAX_AMOUNT \n");
				sbSql.append( "       , SUM(ROUND(DECODE(A.TAX_CODE, '100', 1.1, 1) * A.SALE_AMOUNT))  AS IN_TOT \n");
				sbSql.append( "    FROM FMP_OTCUST_PR A, FMS_UPJANG B, FMP_OTHER_CUST C \n");
				sbSql.append( "   WHERE A.UPJANG = B.UPJANG \n");
				sbSql.append( "     AND A.OTCUSTCD = C.OTCUSTCD \n");
				sbSql.append( "     AND A.LINE_STATUS <> '003' \n");			     
			if ( !sUpjang.equals("")){								
				sbSql.append( "     AND B.MAIN_UPJANG = '" + nullToBlank(ds_cond.getString(0, "UPJANG")) + "' \n");
			}
			if ( !sOtcustcd.equals("")){							
				sbSql.append( "     AND A.OTCUSTCD = '" + nullToBlank(ds_cond.getString(0, "OTCUSTCD")) + "' \n");
			}
			if ( !sSdate.equals("") && !sEdate.equals("")){
				sbSql.append( "     AND A.NEED_DATE BETWEEN '" +sSdate+ "' AND '" +sEdate+ "' \n");
			}
				sbSql.append( "   GROUP BY A.OTCUSTCD, A.UPJANG, C.OTCUSTNM, B.UPJANGNM_DISP \n");
				sbSql.append( "   HAVING SUM(ROUND(DECODE(A.TAX_CODE, '100', 1.1, 1) * NVL(A.SALE_AMOUNT,0))) <> 0 \n");
				sbSql.append( "   UNION ALL  \n");      	//UNION ALL ************************************************************			
				sbSql.append( "          SELECT '0000' AS OTCUSTCD  \n");
				sbSql.append( "           , C.OTCUSTNM  \n");
				sbSql.append( "           , TO_CHAR(A.TRANS_UPJANG) AS UPJANG  \n");
				sbSql.append( "           , B.UPJANGNM_DISP  \n");
				sbSql.append( "           , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * A.SALE_AMOUNT) AS TOT_AMOUNT  \n");
				sbSql.append( "           , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.TAX_CODE, '100', 0, A.SALE_AMOUNT)) TAX_AMOUNT_N  \n");
				sbSql.append( "           , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.TAX_CODE, '100', A.SALE_AMOUNT, 0)) TAX_AMOUNT_Y  \n");
				sbSql.append( "           , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE, '100', 0.1, 0) * A.SALE_AMOUNT))  AS TAX_AMOUNT  \n");
				sbSql.append( "           , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE, '100', 1.1, 1) * A.SALE_AMOUNT))  AS IN_TOT  \n");
				sbSql.append( "        FROM FMS_TRANSACTION_V A, FMS_UPJANG B, FMP_OTHER_CUST C  \n");
				sbSql.append( "       WHERE A.TRANS_UPJANG = B.UPJANG  \n");
				sbSql.append( "         AND C.OTCUSTCD = '0000'  \n");
				if ( !sUpjang.equals("")){				
					sbSql.append( "         AND B.MAIN_UPJANG = '" + nullToBlank(ds_cond.getString(0, "UPJANG")) + "' \n");
				}
				if ( !sSdate.equals("") && !sEdate.equals("")){
					sbSql.append( "         AND A.TRANS_DATE BETWEEN '" +sSdate+ "' AND '" +sEdate+ "'  \n");
				}
				sbSql.append( "         AND (A.TRANS_TYPE = 'I001' OR (A.TRANS_TYPE LIKE '_002' AND A.SOURCE_TYPE = 'PO')) \n");
				sbSql.append( "       GROUP BY OTCUSTCD, A.TRANS_UPJANG, C.OTCUSTNM, B.UPJANGNM_DISP  \n");
				sbSql.append( "       HAVING SUM(ROUND(DECODE(A.TAX_CODE, '100', 1.1, 1) * NVL(A.SALE_PRICE,0))) <> 0  \n");			
		}
		//공급업체가 한화 를 제외 한 경우.	*********************************************************************************************************		
		else{	
				sbSql.append( "   SELECT A.OTCUSTCD \n");
				sbSql.append( "       , C.OTCUSTNM \n");
				sbSql.append( "       , A.UPJANG \n");
				sbSql.append( "       , B.UPJANGNM_DISP \n");
				sbSql.append( "       , SUM(A.SALE_AMOUNT) AS TOT_AMOUNT \n");
				sbSql.append( "       , SUM(DECODE(A.TAX_CODE, '100', 0, A.SALE_AMOUNT)) TAX_AMOUNT_N \n");
				sbSql.append( "       , SUM(DECODE(A.TAX_CODE, '100', A.SALE_AMOUNT, 0)) TAX_AMOUNT_Y \n");
				sbSql.append( "       , SUM(ROUND(DECODE(A.TAX_CODE, '100', 0.1, 0) * A.SALE_AMOUNT))  AS TAX_AMOUNT \n");
				sbSql.append( "       , SUM(ROUND(DECODE(A.TAX_CODE, '100', 1.1, 1) * A.SALE_AMOUNT))  AS IN_TOT \n");
				sbSql.append( "    FROM FMP_OTCUST_PR A, FMS_UPJANG B, FMP_OTHER_CUST C \n");
				sbSql.append( "   WHERE A.UPJANG = B.UPJANG \n");
				sbSql.append( "     AND A.OTCUSTCD = C.OTCUSTCD \n");
				sbSql.append( "     AND A.LINE_STATUS <> '003' \n");				
			if ( !sUpjang.equals("")){								
				sbSql.append( "     AND B.MAIN_UPJANG = '" + nullToBlank(ds_cond.getString(0, "UPJANG")) + "' \n");
			}
			if ( !sOtcustcd.equals("")){							
				sbSql.append( "     AND A.OTCUSTCD = '" + nullToBlank(ds_cond.getString(0, "OTCUSTCD")) + "' \n");
			}
			if ( !sSdate.equals("") && !sEdate.equals("")){
				sbSql.append( "     AND A.NEED_DATE BETWEEN '" +sSdate+ "' AND '" +sEdate+ "' \n");
			}
				sbSql.append( "   GROUP BY A.OTCUSTCD, A.UPJANG, C.OTCUSTNM, B.UPJANGNM_DISP \n");
				sbSql.append( "   HAVING SUM(ROUND(DECODE(A.TAX_CODE, '100', 1.1, 1) * NVL(A.SALE_AMOUNT,0))) <> 0 \n");				
		}				
		
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
