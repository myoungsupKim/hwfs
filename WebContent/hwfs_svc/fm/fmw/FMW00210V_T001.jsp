<%
//*-----------------------------------------------------------------------------
//■ 시스템명     : 도소매관리/판매내역 일괄처리/수금관리
//■ 프로그램ID   : FMW00200E_S002.jsp
//■ 프로그램명   : 판매내역 일괄처리/수금내역조회
//■ 작성일자      : 2010.01.06
//■ 작성자         : 노규완
//■ 이력관리      :  
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
		String strSDATE		    = nullToBlank(ds_input.getString(0, "SDATE"));
		String strEDATE		    = nullToBlank(ds_input.getString(0, "EDATE"));
		
		//out 데이타
		DataSet ds_list;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		sbSql.delete(0, sbSql.length()); //내역조회		

		//전일미수 : 전일까지의 매출에서 전일까지의 수금액과 에누리를  뺀 나머지
		//당일미수 : 당일까지의 매출에서 당일까지의 수금액과 에누리를 뺀 나머지
		//당일에누리 : 당일의 에누리 합계
		//당일 수금액 : 당일의 수금액 합계
		//당일매출 : 당일의 매출 합계
        sbSql.append("SELECT T.UPJANG                                                                                          \n");
        sbSql.append("       , K.UPJANGNM_DISP                                                                                 \n");
        sbSql.append("       , T.HALL_CODE                                                                                     \n");
        sbSql.append("       , S.HALL_NAME                                                                                     \n");
        sbSql.append("       , T.RCV_DATE                                                                                      \n");
        sbSql.append("       , T.당일매출                                                                                                                                                                                \n");
        sbSql.append("       , T.당일수금액                                                                                                                                                                             \n");
        sbSql.append("       , T.당일에누리                                                                                                                                                                             \n");
        sbSql.append("       , T.당일매출 - (T.당일수금액 + T.당일에누리) AS 당일미수금                                                                                                              \n");
        sbSql.append("       , T.전일매출합                                                                                                                                                                             \n");
        sbSql.append("       , T.전일수금합                                                                                                                                                                              \n");
        sbSql.append("       , T.전일매출합 - T.전일수금합 as 전일미수금                                                                                                                              \n");
        sbSql.append(" FROM (SELECT  A.UPJANG                                                                                   \n");
        sbSql.append("        ,A.HALL_CODE                                                                                      \n");
        sbSql.append("        ,A.RCV_DATE                                                                                       \n");
        sbSql.append("        ,(SELECT NVL(SUM(M.SALE_AMOUNT),0) FROM FMW_PO_TRANSACTION M WHERE M.UPJANG = A.UPJANG AND M.TRANS_DATE = A.RCV_DATE AND SUBSTR(M.TRANS_TYPE,1,1) = 'O' AND M.HALL_CODE = A.HALL_CODE) AS 당일매출 \n");
        sbSql.append("        ,SUM(A.RCV_AMT) AS 당일수금액                                                                                                                                                      \n");
        sbSql.append("        ,SUM(A.DISCOUNT_AMT) AS 당일에누리                                                                                                                                             \n");
        sbSql.append("        ,(SELECT NVL(SUM(B.SALE_AMOUNT),0)                                                                 \n");
        sbSql.append("            FROM FMW_PO_TRANSACTION B                                                                      \n");
        sbSql.append("           WHERE B.TRANS_DATE < A.RCV_DATE                                                                 \n");
        sbSql.append("             AND B.UPJANG = A.UPJANG                                                                       \n");
        sbSql.append("             AND SUBSTR(B.TRANS_TYPE,1,1) = 'O'                                                            \n");
        sbSql.append("             AND B.HALL_CODE = A.HALL_CODE) AS 전일매출합                                                                                                        \n");
        sbSql.append("        ,(SELECT NVL(SUM(C.RCV_AMT),0) + NVL(SUM(C.DISCOUNT_AMT),0)                                        \n");
        sbSql.append("            FROM FMW_RCV C                                                                                 \n");
        sbSql.append("           WHERE C.RCV_DATE < A.RCV_DATE                                                                   \n");
        sbSql.append("             AND C.UPJANG = A.UPJANG                                                                       \n");
        sbSql.append("             AND C.HALL_CODE = A.HALL_CODE) AS 전일수금합                                                                                                        \n");
        sbSql.append("         FROM FMW_RCV A                                                                                    \n");
        sbSql.append("        WHERE A.UPJANG = '" + strUpjang + "'                                                               \n");
        sbSql.append("          AND A.RCV_DATE BETWEEN '" + strSDATE + "' AND '" + strEDATE + "'                                 \n");
        if (! strHALL_CODE.equals(""))        
	        sbSql.append("          AND A.HALL_CODE = '" + strHALL_CODE + "'                                                         \n");
        sbSql.append("        GROUP BY A.UPJANG,A.HALL_CODE,A.RCV_DATE                                                           \n");
        sbSql.append("    ) T, FMS_UPJANG K, FMW_HALL S                                                                          \n");
        sbSql.append("    WHERE T.UPJANG = K.UPJANG                                                                              \n");
        sbSql.append("      AND T.HALL_CODE = S.HALL_CODE                                                                        \n");
        sbSql.append("    ORDER BY T.UPJANG, T.HALL_CODE,T.RCV_DATE                                                              \n");
        
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		ds_list = this.makeDataSet(rs, "ds_list"); //ds_in
		rs.close();
		pstmt.close();		
		
		/**종료**/
		out_dl.add(ds_list);
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
