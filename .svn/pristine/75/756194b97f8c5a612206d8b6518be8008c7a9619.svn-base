<%
//-----------------------------------------------------------------------------
//■ 시스템명        : 운영관리/급식채권관리/매출 및 입금내역 조회(월별 고객사별 외상매출/입금 내역조회 FMO00490V를 변경함.)
//■ 프로그램ID  : FMO00490V_T001.jsp
//■ 프로그램명     : 매출 및 입금내역조회
//■ 작성일자        : 2008.02.21
//■ 작성자           : 노규완
//■ 이력관리        : 2008.02.21
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
		String sUpjang = nullToBlank(ds_cond.getString(0, "UPJANG"));			//업장		
		String sYYMM = nullToBlank(ds_cond.getString(0, "YYMM"));				//조회 월

// alert기능	 System.out.println(nullToBlank(ds_cond.getString(0, "ITEM_DETAIL")));
			
		//내역조회
		
		sbSql.append( " SELECT TO_CHAR(TO_DATE(AMT_DATE,'YYYYMMDD'),'YYYY-MM-DD' || '(' ||  'DY' || ')','NLS_DATE_LANGUAGE=KOREAN') AS AMT_DATE \n");
		sbSql.append( "      , SUM(NVL(OCCUR_AMT,0)) AS OCCUR_AMT \n");
		sbSql.append( "      , SUM(NVL(CASH_AMT,0)) AS CASH_AMT \n");
		sbSql.append( "      , SUM(NVL(CARD_AMT,0)) AS CARD_AMT \n");
		sbSql.append( "      , SUM(NVL(BALANCE_CASH_AMT,0)) AS BALANCE_CASH_AMT \n");
		sbSql.append( "      , SUM(NVL(BALANCE_CARD_AMT,0)) AS BALANCE_CARD_AMT \n");
		sbSql.append( " FROM(SELECT  A.OCCUR_DATE AS AMT_DATE \n");
		sbSql.append( "            , SUM(NVL(A.OCCUR_AMT,0)) AS OCCUR_AMT \n");
		sbSql.append( "            , NULL AS CASH_AMT \n");
		sbSql.append( "            , NULL AS CARD_AMT \n");
		sbSql.append( "            , NULL AS BALANCE_CASH_AMT \n");
		sbSql.append( "            , NULL AS BALANCE_CARD_AMT \n");
		sbSql.append( "      FROM FMO_ACCT_OCCUR A, SCC_COMMON_CODE B \n");
		sbSql.append( "                WHERE (1=1) \n");
		sbSql.append( "                 AND A.SALE_TYPE = B.CODE \n");
		sbSql.append( "                 AND A.UPJANG    = '" +sUpjang+ "' \n");
		sbSql.append( "                 AND A.OCCUR_DATE BETWEEN '" +sYYMM+ "' || '01' AND '" +sYYMM+ "' || '31' \n");
		sbSql.append( "                 AND B.GROUP_CODE = '매출유형' \n");
		sbSql.append( "       GROUP BY A.OCCUR_DATE \n");
		sbSql.append( "  UNION ALL \n");
		sbSql.append( "      SELECT  A.OCCUR_DATE AS AMT_DATE \n");
		sbSql.append( "            , NULL AS OCCUR_AMT \n");
		sbSql.append( "            , SUM(NVL(A.OCCUR_AMT,0)) AS CASH_AMT \n");
		sbSql.append( "            , NULL AS CARD_AMT \n");
		sbSql.append( "            , NULL AS BALANCE_CASH_AMT \n");
		sbSql.append( "            , NULL AS BALANCE_CARD_AMT \n");
		sbSql.append( "      FROM FMO_ACCT_OCCUR A, SCC_COMMON_CODE B \n");
		sbSql.append( "              WHERE (1=1) \n");
		sbSql.append( "                AND A.SALE_TYPE  = B.CODE \n");
		sbSql.append( "                AND A.UPJANG     = '" +sUpjang+ "' \n");
		sbSql.append( "                AND A.OCCUR_DATE BETWEEN '" +sYYMM+ "' || '01' AND '" +sYYMM+ "' || '31' \n");
		sbSql.append( "                AND B.GROUP_CODE = '매출유형' \n");
		sbSql.append( "                AND B.CODE = '001' \n");
		sbSql.append( "              GROUP BY A.OCCUR_DATE \n");
		sbSql.append( "  UNION ALL \n");
		sbSql.append( "      SELECT  A.OCCUR_DATE AS AMT_DATE \n");
		sbSql.append( "            , NULL AS OCCUR_AMT \n");
		sbSql.append( "            , NULL AS CASH_AMT \n");
		sbSql.append( "            , SUM(NVL(A.OCCUR_AMT,0)) AS CARD_AMT \n");
		sbSql.append( "            , NULL AS BALANCE_CASH_AMT \n");
		sbSql.append( "            , NULL AS BALANCE_CARD_AMT \n");
		sbSql.append( "      FROM FMO_ACCT_OCCUR A, SCC_COMMON_CODE B \n");
		sbSql.append( "              WHERE (1=1) \n");
		sbSql.append( "                AND A.SALE_TYPE  = B.CODE \n");
		sbSql.append( "                AND A.UPJANG     = '" +sUpjang+ "' \n");
		sbSql.append( "                AND A.OCCUR_DATE BETWEEN '" +sYYMM+ "' || '01' AND '" +sYYMM+ "' || '31' \n");
		sbSql.append( "                AND B.GROUP_CODE = '매출유형' \n");
		sbSql.append( "                AND B.CODE = '002' \n");
		sbSql.append( "              GROUP BY A.OCCUR_DATE \n");
		sbSql.append( " UNION ALL \n");
		sbSql.append( "      SELECT  A.RCV_DATE AS AMT_DATE \n");
		sbSql.append( "            , NULL AS OCCUR_AMT \n");
		sbSql.append( "            , NULL AS CASH_AMT \n");
		sbSql.append( "            , NULL AS CARD_AMT \n");
		sbSql.append( "            , SUM(NVL(A.RCV_AMT,0)) AS BALANCE_CASH_AMT \n");
		sbSql.append( "            , NULL AS BALANCE_CARD_AMT \n");
		sbSql.append( "      FROM  FMO_RCV A, SCC_COMMON_CODE B \n");
		sbSql.append( "             WHERE (1=1) \n");
		sbSql.append( "                AND A.RCV_TYPE = B.CODE \n");
		sbSql.append( "                AND A.UPJANG   = '" +sUpjang+ "' \n");
		sbSql.append( "                AND A.RCV_DATE BETWEEN '" +sYYMM+ "' || '01' AND '" +sYYMM+ "' || '31' \n");
		sbSql.append( "                AND B.GROUP_CODE = '입금유형' \n");
		sbSql.append( "                AND B.CODE = '001' \n");
		sbSql.append( "                AND NVL(B.SET1,'N') = 'Y' \n");
		sbSql.append( "                AND A.USE_YN = 'Y' \n");		
		sbSql.append( "             GROUP BY A.RCV_DATE \n");
		sbSql.append( " UNION ALL \n");
		sbSql.append( "      SELECT  A.RCV_DATE AS AMT_DATE \n");
		sbSql.append( "            , NULL AS OCCUR_AMT \n");
		sbSql.append( "            , NULL AS CASH_AMT \n");
		sbSql.append( "            , NULL AS CARD_AMT \n");
		sbSql.append( "            , NULL BALANCE_CASH_AMT \n");
		sbSql.append( "            , SUM(NVL(A.RCV_AMT,0)) AS BALANCE_CARD_AMT \n");
		sbSql.append( "      FROM  FMO_RCV A, SCC_COMMON_CODE B \n");
		sbSql.append( "             WHERE (1=1) \n");
		sbSql.append( "                AND A.RCV_TYPE = B.CODE \n");
		sbSql.append( "                AND A.UPJANG   = '" +sUpjang+ "' \n");
		sbSql.append( "                AND A.RCV_DATE BETWEEN '" +sYYMM+ "' || '01' AND '" +sYYMM+ "' || '31' \n");
		sbSql.append( "                AND B.GROUP_CODE = '입금유형' \n");
		sbSql.append( "                AND B.CODE = '002' \n");
		sbSql.append( "                AND NVL(B.SET1,'N') = 'Y' \n");
		sbSql.append( "                AND A.USE_YN = 'Y' \n");		
		sbSql.append( "             GROUP BY A.RCV_DATE) \n");
		sbSql.append( " GROUP BY AMT_DATE \n");
		
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