<%
//*-----------------------------------------------------------------------------
//■ 시스템명     : 도소매관리/판매내역 일괄처리/수금관리
//■ 프로그램ID   : FMW00200E_S002.jsp
//■ 프로그램명   : 판매내역 일괄처리/수금관리
//■ 작성일자     : 2010.01.06
//■ 작성자       : 맹수영
//■ 이력관리     :  
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
		DataSet ds_input     	= in_dl.get("ds_in");
	
		String strUpjang 		= nullToBlank(ds_input.getString(0, "UPJANG"));
		String strHALL_CODE 	= nullToBlank(ds_input.getString(0, "HALL_CODE"));
		String strDATE		    = nullToBlank(ds_input.getString(0, "DATE"));
		
		//out 데이타
		DataSet ds_cond2;

		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		sbSql.delete(0, sbSql.length()); //내역조회		

		//전일미수 : 전일까지의 매출에서 전일까지의 수금액과 에누리를  뺀 나머지
		//당일미수 : 당일까지의 매출에서 당일까지의 수금액과 에누리를 뺀 나머지
		//당일에누리 : 당일의 에누리 합계
		//당일 수금액 : 당일의 수금액 합계
		//당일매출 : 당일의 매출 합계
        sbSql.append("SELECT 'A' AS GUBUN,V.RCV_ID,  LPAD(RCV_ID,4,'0') AS RCV_ID_DIS, REMARK,                                                                                    \n");
        sbSql.append("       V.UPJANG,                                                                                                                        \n");
        sbSql.append("       V.HALL_CODE,                                                                                                                     \n");
        sbSql.append("       V.RCV_DATE ,                                                                                                                     \n");
        sbSql.append("       V.RCV_AMT,                                                                                                                       \n");
        sbSql.append("       V.DISCOUNT_AMT ,                                                                                                                 \n");
        sbSql.append("       NVL(A.전일매출,0) - NVL((SELECT SUM(RCV_AMT)+ SUM(DISCOUNT_AMT) FROM FMW_RCV WHERE RCV_DATE <= TO_CHAR(TO_DATE('" + strDATE + "', 'YYYYMMDD') -1,'YYYYMMDD') AND UPJANG =  '" + strUpjang + "' AND HALL_CODE = '" + strHALL_CODE + "' ),0) BEFORE_MISU, \n");
        //sbSql.append("       (NVL(A.전일매출,0) + NVL(B.당일매출,0)) - (SELECT SUM(RCV_AMT)+ SUM(DISCOUNT_AMT) FROM FMW_RCV WHERE RCV_DATE <= '" + strDATE + "'  AND UPJANG =  '" + strUpjang + "' AND HALL_CODE = '" + strHALL_CODE + "') TODAY_MISU,                                         \n");
        sbSql.append("       (NVL(B.당일매출,0)) - NVL((SELECT SUM(RCV_AMT)+ SUM(DISCOUNT_AMT) FROM FMW_RCV WHERE RCV_DATE = '" + strDATE + "'  AND UPJANG =  '" + strUpjang + "' AND HALL_CODE = '" + strHALL_CODE + "'),0) TODAY_MISU,                                         \n");
        sbSql.append("       NVL(B.당일매출,0) TODAY_MAECHUL,                                                                                                        \n");
        sbSql.append("       NVL((SELECT SUM(DISCOUNT_AMT) FROM FMW_RCV WHERE RCV_DATE = '" + strDATE + "'  AND UPJANG =  '" + strUpjang + "' AND HALL_CODE = '" + strHALL_CODE + "'),0) TODAY_DISCOUNT_AMT,                                          \n");
        sbSql.append("       NVL((SELECT SUM(RCV_AMT) FROM FMW_RCV WHERE RCV_DATE ='" + strDATE + "'  AND UPJANG =  '" + strUpjang + "' AND HALL_CODE = '" + strHALL_CODE + "'),0) TODAY_RCV_AMT                                                     \n");
        sbSql.append("  FROM  FMW_RCV V,                                                                                                                      \n");
        sbSql.append("        (SELECT MAX(UPJANG) UPJANG, MAX(HALL_CODE) HALL_CODE, NVL(SUM(SALE_AMOUNT),0) 전일매출                                          \n");
        sbSql.append("          FROM FMW_PO_TRANSACTION                                                                                                       \n");
        sbSql.append("         WHERE TRANS_DATE <=  TO_CHAR(TO_DATE('" + strDATE + "', 'YYYYMMDD') -1,'YYYYMMDD') --전일까지                                         \n");
        sbSql.append("           AND UPJANG =  '" + strUpjang + "'                                                                                                        \n");
        sbSql.append("           AND HALL_CODE = '" + strHALL_CODE + "') A,                                                                                                     \n");
        sbSql.append("        (SELECT MAX(UPJANG) UPJANG, MAX(HALL_CODE) HALL_CODE,NVL(SUM(SALE_AMOUNT),0) 당일매출                                           \n");
        sbSql.append("          FROM FMW_PO_TRANSACTION                                                                                                       \n");
        sbSql.append("         WHERE TRANS_DATE =  '" + strDATE + "' --당일만                                                                                        \n");
        sbSql.append("           AND UPJANG =  '" + strUpjang + "'                                                                                                        \n");
        sbSql.append("           AND HALL_CODE =  '" + strHALL_CODE + "') B                                                                                                      \n");
        sbSql.append(" WHERE V.UPJANG = A.UPJANG(+)                                                                                                           \n");
        sbSql.append("   AND V.UPJANG = B.UPJANG(+)                                                                                                           \n");
        sbSql.append("   AND V.HALL_CODE = A.HALL_CODE(+)                                                                                                     \n");
        sbSql.append("   AND V.HALL_CODE = B.HALL_CODE(+)                                                                                                     \n");
        sbSql.append("   AND V.UPJANG =   '" + strUpjang + "'                                                                                                            \n");
        sbSql.append("   AND V.HALL_CODE = '" + strHALL_CODE + "'                                                                                                               \n");
        sbSql.append("   AND V.RCV_DATE = '" + strDATE + "'                                                                                                          \n");
        sbSql.append("  ORDER BY V.RCV_ID   \n");
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		ds_cond2 = this.makeDataSet(rs, "ds_cond2"); //ds_in
		
		rs.close();
		pstmt.close();		
		
		/**종료**/
		out_dl.add(ds_cond2);

		//this.setResultMessage(0, "OK", out_vl);

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
