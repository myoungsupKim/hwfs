<%
//-----------------------------------------------------------------------------
//■ 시스템명     : 운영관리/급식채권관리/고객사 채권조회(조회)
//■ 프로그램ID   : FMO00470V_T001.jsp
//■ 프로그램명   : 고객사 채권조회
//■ 작성일자     : 2008.02.20
//■ 작성자       : 노규완
//■ 이력관리     : 2008.02.20
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
		
		sbSql.append( " SELECT CUST_ID, CUSTNM \n");
		sbSql.append( "      , SUM(NVL(PRE_AMT,0)) AS PRE_AMT \n");
		sbSql.append( "      , SUM(NVL(OCCUR_AMT,0)) AS OCCUR_AMT \n");
		sbSql.append( "      , SUM(NVL(FMO_RCV,0)) AS FMO_RCV \n");
		sbSql.append( "      , SUM(NVL(PRE_AMT,0)) + SUM(NVL(OCCUR_AMT,0)) - SUM(NVL(FMO_RCV,0)) AS BALANCE_AMT \n");
		sbSql.append( " FROM ( SELECT CUST_ID,CUSTNM, PRE_AMT, NULL AS OCCUR_AMT, NULL AS FMO_RCV \n");
		sbSql.append( "          FROM ( SELECT CUST_ID, CUSTNM, SUM(NVL(OCCUR_AMT,0)) - SUM(NVL(RCV_AMT,0)) AS PRE_AMT \n");
		sbSql.append( "         			          FROM (SELECT A.CUST_ID, A.CUSTNM, NULL AS OCCUR_AMT, SUM(NVL(C.RCV_AMT,0)) + SUM(NVL(C.COMM_AMT,0)) AS RCV_AMT \n");
		sbSql.append( "         FROM FMS_CUSTOM A, FMO_RCV C, SCC_COMMON_CODE E \n");
		sbSql.append( "         			                 WHERE  C.UPJANG = A.UPJANG \n");
		sbSql.append( "         			                  AND   C.CUST_ID = A.CUST_ID \n");
		sbSql.append( "         			                  AND   C.RCV_TYPE = E.CODE \n");
		sbSql.append( "			                  AND   A.UPJANG = '" +sUpjang+ "' \n");
		sbSql.append( "           				  AND   C.RCV_DATE < '" +sYYMM+ "' || '01' \n");
		sbSql.append( "			                  AND   E.GROUP_CODE = '입금유형' \n");
		sbSql.append( "			                  AND   E.SET1 = 'Y' \n");
		sbSql.append( "    					      AND   C.USE_YN = 'Y' \n");		
		sbSql.append( "			                  GROUP BY A.CUST_ID, A.CUSTNM \n");
		sbSql.append( "			            UNION ALL \n");
		sbSql.append( "			                 SELECT A.CUST_ID, A.CUSTNM, SUM(NVL(B.OCCUR_AMT,0)), NULL AS RCV_AMT \n");
		sbSql.append( "			                FROM FMS_CUSTOM A, FMO_ACCT_OCCUR B, SCC_COMMON_CODE D \n");
		sbSql.append( "			                WHERE B.UPJANG = A.UPJANG \n");
		sbSql.append( "			                AND B.CUST_ID = A.CUST_ID \n");
		sbSql.append( "			                AND B.SALE_TYPE = D.CODE \n");
		sbSql.append( "			                AND A.UPJANG = '" +sUpjang+ "' \n");
		sbSql.append( "			                AND B.OCCUR_DATE < '" +sYYMM+ "' || '01' \n");
		sbSql.append( "			                AND D.GROUP_CODE = '매출유형' \n");
		sbSql.append( "			                AND D.SET1 = 'Y' \n");
		sbSql.append( "			                GROUP BY  A.CUST_ID, A.CUSTNM) \n");
		sbSql.append( "			                GROUP BY CUST_ID, CUSTNM ) \n");
		sbSql.append( " UNION ALL \n");
		sbSql.append( " SELECT A.CUST_ID, A.CUSTNM, NULL AS PRE_AMT, SUM(NVL(B.OCCUR_AMT,0)) AS OCCUR_AMT, NULL AS FMO_RCV \n");
		sbSql.append( "          FROM FMS_CUSTOM A, FMO_ACCT_OCCUR B, SCC_COMMON_CODE C \n");
		sbSql.append( "         WHERE (1=1) \n");
		sbSql.append( "           AND A.UPJANG     = B.UPJANG \n");
		sbSql.append( "           AND A.CUST_ID    = B.CUST_ID \n");
		sbSql.append( "           AND B.SALE_TYPE  = C.CODE \n");
		sbSql.append( "           AND B.UPJANG     = '" +sUpjang+ "' \n");
		sbSql.append( "           AND B.OCCUR_DATE BETWEEN '" +sYYMM+ "' || '01' AND '" +sYYMM+ "' || '31' \n");
		sbSql.append( "           AND C.GROUP_CODE = '매출유형' \n");
		sbSql.append( "           AND NVL(C.SET1,'N') = 'Y' \n");
		sbSql.append( " GROUP BY A.CUST_ID, A.CUSTNM \n");
		sbSql.append( " UNION ALL \n");
		sbSql.append( " SELECT A.CUST_ID, A.CUSTNM, NULL AS PRE_AMT, NULL AS OCCUR_AMT, SUM(NVL(B.RCV_AMT,0)) + SUM(NVL(B.COMM_AMT,0)) FMO_RCV \n");
		sbSql.append( "           FROM FMS_CUSTOM A, FMO_RCV B, SCC_COMMON_CODE C \n");
		sbSql.append( "           WHERE (1=1) \n");
		sbSql.append( "            AND A.UPJANG     = B.UPJANG \n");
		sbSql.append( "            AND A.CUST_ID    = B.CUST_ID \n");
		sbSql.append( "            AND B.RCV_TYPE   = C.CODE \n");
		sbSql.append( "            AND B.UPJANG     = '" +sUpjang+ "' \n");
		sbSql.append( "            AND B.RCV_DATE BETWEEN '" +sYYMM+ "' || '01' AND '" +sYYMM+ "' || '31' \n");
		sbSql.append( "            AND C.GROUP_CODE = '입금유형' \n");
		sbSql.append( "            AND NVL(C.SET1,'N') = 'Y' \n");
		sbSql.append( "            AND B.USE_YN = 'Y' \n");
		sbSql.append( " GROUP BY A.CUST_ID, A.CUSTNM) \n");
		sbSql.append( " GROUP BY CUST_ID, CUSTNM \n");
		
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
