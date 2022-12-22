<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 업종별판매실적조회
■ 프로그램ID   : FMW00350V_T001.jsp
■ 프로그램명   : 업종별판매실적조회
■ 작성일자     : 2011-02-24
■ 작성자       : 맹수영
■ 이력관리     : 
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
		//DataSet ds_cond     = in_dl.get("ds_Cond");
		DataSet ds_input  	    = in_dl.get("ds_input");
		//입력 파라메터

		String v_Upjang         = nullToBlank(ds_input.getString(0, "UPJANG"));
		String v_Sdate         = nullToBlank(ds_input.getString(0, "SDATE"));
		String v_Edate         = nullToBlank(ds_input.getString(0, "EDATE"));
		String v_Hall_Code         = nullToBlank(ds_input.getString(0, "HALL_CODE"));
		String v_Stype         = nullToBlank(ds_input.getString(0, "STYPE"));
		
		//FileLog.println("d:\\aaa.txt", ds_cond);


		//out 데이타
		DataSet ds_list;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		//내역조회
         sbSql.append("SELECT (SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FMW003' AND CODE = T.HALL_TYPE) 업종                                                                                                                         \n");
        //sbSql.append("     , NVL((( SELECT SUM(K.SALE_AMOUNT)                                                                                                     \n");
        //sbSql.append("            FROM FMW_PO_TRANSACTION K                                                                                                       \n");
        //sbSql.append("           WHERE K.UPJANG = '" + v_Upjang + "' AND K.TRANS_TYPE IN ('O001','O002')                                                                    \n");
        //sbSql.append("             AND K.TRANS_DATE BETWEEN '20110101' AND TO_CHAR(TO_DATE('" + v_Edate + "' ,'YYYYMMDD') -1,'YYYYMMDD')  --시작날짜 고정                 \n");
        //sbSql.append("             )                                                                                                         \n");
        //sbSql.append("          -                                                                                                                                 \n");
        //sbSql.append("         (SELECT NVL(SUM(C.RCV_AMT),0) + NVL(SUM(C.DISCOUNT_AMT),0)                                                                         \n");
        //sbSql.append("            FROM FMW_RCV C                                                                                                                  \n");
        //sbSql.append("           WHERE C.UPJANG = '" + v_Upjang + "'                                                                                                       \n");
        //sbSql.append("             AND C.RCV_DATE BETWEEN '20110101' AND TO_CHAR(TO_DATE('" + v_Edate + "' ,'YYYYMMDD') -1,'YYYYMMDD')                                    \n");
        //sbSql.append("            )),0) AS 전일미수                                                                                                               \n");
        sbSql.append("     , SUM(T.매출) AS 매출                                                                                                                  \n");
        sbSql.append("     , SUM(T.반품) AS 반품                                                                                                                  \n");
        sbSql.append("     , SUM(T.순매출) AS 순매출                                                                                                              \n");
        sbSql.append("     , SUM(T.수금액) AS 수금액                                                                                                              \n");
        sbSql.append("     , (SUM(T.매출) + SUM(T.반품)) - (SUM(T.수금액) + SUM(T.에누리))  AS 미수금                                                             \n");
        sbSql.append("     , SUM(T.에누리) AS 에누리                                                                                                              \n");
        sbSql.append("     , SUM(T.매입원가) AS 매입원가                                                                                                          \n");
        sbSql.append("     , SUM(T.순매출) - SUM(T.매입원가) AS 이익금                                                                                            \n");
        sbSql.append("     , DECODE(SUM(T.순매출),0,0, (SUM(T.순매출) - SUM(T.매입원가)) / SUM(T.순매출) * 100) AS 이익율                                         \n");
        sbSql.append("  FROM                                                                                                                                      \n");
        sbSql.append("(                                                                                                                                           \n");
        sbSql.append("SELECT B.HALL_TYPE                                                                                                                          \n");
        sbSql.append("      ,SUM(DECODE(A.TRANS_TYPE,'O001', NVL(A.SALE_AMOUNT,0),0)) AS 매출                                                                     \n");
        sbSql.append("      ,SUM(DECODE(A.TRANS_TYPE,'O002', NVL(A.SALE_AMOUNT,0),0)) AS 반품                                                                     \n");
        sbSql.append("      ,(SUM(DECODE(A.TRANS_TYPE,'O001', NVL(A.SALE_AMOUNT,0),0))                                                                            \n");
        sbSql.append("      + SUM(DECODE(A.TRANS_TYPE,'O002', NVL(A.SALE_AMOUNT,0),0))) - SUM(DECODE(C.TAX_CODE,'100',ROUND(NVL(A.SALE_AMOUNT,0) / 10),0))  AS 순매출 \n");
        sbSql.append("      ,0 AS 수금액                                                                                                                          \n");
        sbSql.append("      ,0 AS 에누리                                                                                                                          \n");
        sbSql.append("      ,SUM(NVL(A.AVG_AMOUNT,0)) AS 매입원가                                                                                                 \n");
        sbSql.append("  FROM FMW_PO_TRANSACTION A, FMW_HALL B, FMW_ITEM_V C                                                                                       \n");
        sbSql.append(" WHERE A.UPJANG = B.UPJANG                                                                                                                  \n");
        sbSql.append("   AND A.HALL_CODE = B.HALL_CODE                                                                                                            \n");
        sbSql.append("   AND A.UPJANG = '" + v_Upjang + "'                                                                                                                 \n");
        sbSql.append("   AND A.TRANS_DATE BETWEEN '" + v_Sdate + "' AND '" + v_Edate + "'     --시작일 고정                                                                      \n");
        sbSql.append("   AND A.TRANS_TYPE IN ('O001','O002')                                                                                                      \n");
        sbSql.append("   AND A.ITEM_CODE = C.ITEM_CODE                                                                                                            \n");
        sbSql.append(" GROUP BY B.HALL_TYPE                                                                                                                       \n");
        sbSql.append("UNION ALL                                                                                                                                   \n");
        sbSql.append("SELECT B.HALL_TYPE                                                                                                                          \n");
        sbSql.append("    , 0 매출                                                                                                                                \n");
        sbSql.append("    , 0 반품                                                                                                                                \n");
        sbSql.append("    , 0 순매출                                                                                                                              \n");
        sbSql.append("    ,  SUM(NVL(A.RCV_AMT,0)) AS 수금액                                                                                                      \n");
        sbSql.append("    ,  SUM(NVL(A.DISCOUNT_AMT,0)) AS 에누리                                                                                                 \n");
        sbSql.append("    , 0 매입원가                                                                                                                            \n");
        sbSql.append("FROM FMW_RCV A, FMW_HALL B                                                                                                                  \n");
        sbSql.append("WHERE A.UPJANG = '" + v_Upjang + "'                                                                                                                  \n");
        sbSql.append("  AND A.UPJANG = B.UPJANG                                                                                                                   \n");
        sbSql.append("  AND A.HALL_CODE = B.HALL_CODE                                                                                                             \n");
        sbSql.append("  AND RCV_DATE BETWEEN '" + v_Sdate + "' AND '" + v_Edate + "'                                                                                             \n");
        sbSql.append("  GROUP BY B.HALL_TYPE                                                                                                                      \n");
        sbSql.append("  ) T GROUP BY T.HALL_TYPE   ORDER BY T.HALL_TYPE                                                                                           \n");

out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery();
				
		ds_list = this.makeDataSet(rs, "ds_list");
		
		rs.close();
		pstmt.close();		
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
