<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 협력업체 > 발주서 > 차수별 발주현황
■ 프로그램ID   : FSV00100V_T001.jsp
■ 프로그램명   : 차수별 발주현황
■ 작성일자     : 
■ 작성자      : 
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
		DataSet ds_Cond     = in_dl.get("ds_Cond");
		//입력 파라메터
		String g_CustCd     = nullToBlank(in_vl.getString("g_CustCd"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
	
		//FileLog.println("d:\\aaa.txt", ds_Cond);

		//IRIS DB연결
		if(conn != null && !conn.isClosed()) conn.close();
		conn = getIRISConn();

		//out 데이타
		DataSet ds_List;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		//내역조회
                sbSql.append("SELECT B.CENTER_NAME                                                                                                                                               \n");
        sbSql.append("     , C.CUSTNM                                                                                                                                                    \n");
        sbSql.append("     , TO_NUMBER(MAX(DECODE(A.ORDER_SEQ,'010',DECODE(TO_CHAR(A.REORDER_TIME, 'HH24MI'),NULL,TO_CHAR(D.UPDATE_DATE, 'HH24MI'))))) AS PRT_CHE1                       \n");
        sbSql.append("     , MAX(DECODE(A.ORDER_SEQ,'010',DECODE(TO_CHAR(A.REORDER_TIME, 'YYYY-MM-DD HH24:MI'),NULL,TO_CHAR(D.UPDATE_DATE, 'YYYY-MM-DD HH24:MI')))) AS PRT_TIME1         \n");
        sbSql.append("     , COUNT(DECODE(A.ORDER_SEQ,'010',DECODE(TO_CHAR(A.REORDER_TIME),NULL,D.PO_ID))) AS PRT_ORD1                                                                   \n");
        sbSql.append("     , COUNT(DECODE(A.ORDER_SEQ,'010',DECODE(TO_CHAR(A.REORDER_TIME),NULL,A.PO_ID))) AS PO_ORD1                                                                    \n");
        sbSql.append("     , TO_NUMBER(MAX(DECODE(A.ORDER_SEQ,'020',DECODE(TO_CHAR(A.REORDER_TIME, 'HH24MI'),NULL,TO_CHAR(D.UPDATE_DATE,'HH24MI'))))) AS PRT_CHE2                        \n");
        sbSql.append("     , MAX(DECODE(A.ORDER_SEQ,'020',DECODE(TO_CHAR(A.REORDER_TIME, 'YYYY-MM-DD HH24:MI'),NULL,TO_CHAR(D.UPDATE_DATE, 'YYYY-MM-DD HH24:MI')))) AS PRT_TIME2         \n");
        sbSql.append("     , COUNT(DECODE(A.ORDER_SEQ,'020',DECODE(TO_CHAR(A.REORDER_TIME),NULL,D.PO_ID))) AS PRT_ORD2                                                                   \n");
        sbSql.append("     , COUNT(DECODE(A.ORDER_SEQ,'020',DECODE(TO_CHAR(A.REORDER_TIME),NULL,A.PO_ID))) AS PO_ORD2                                                                    \n");
        sbSql.append("     , TO_NUMBER(MAX(DECODE(A.ORDER_SEQ,'030',DECODE(TO_CHAR(A.REORDER_TIME, 'HH24MI'),NULL,TO_CHAR(D.UPDATE_DATE, 'HH24MI'))))) AS PRT_CHE3                       \n");
        sbSql.append("     , MAX(DECODE(A.ORDER_SEQ,'030',DECODE(TO_CHAR(A.REORDER_TIME, 'YYYY-MM-DD HH24:MI'),NULL,TO_CHAR(D.UPDATE_DATE, 'YYYY-MM-DD HH24:MI')))) AS PRT_TIME3         \n");
        sbSql.append("     , COUNT(DECODE(A.ORDER_SEQ,'030',DECODE(TO_CHAR(A.REORDER_TIME),NULL,D.PO_ID))) AS PRT_ORD3                                                                   \n");
        sbSql.append("     , COUNT(DECODE(A.ORDER_SEQ,'030',DECODE(TO_CHAR(A.REORDER_TIME),NULL,A.PO_ID))) AS PO_ORD3                                                                    \n");
        sbSql.append("     , TO_NUMBER(MAX(DECODE(A.ORDER_SEQ,'040',DECODE(TO_CHAR(A.REORDER_TIME, 'HH24MI'),NULL,TO_CHAR(D.UPDATE_DATE,'HH24MI'))))) AS PRT_CHE4                        \n");
        sbSql.append("     , MAX(DECODE(A.ORDER_SEQ,'040',DECODE(TO_CHAR(A.REORDER_TIME, 'YYYY-MM-DD HH24:MI'),NULL,TO_CHAR(D.UPDATE_DATE, 'YYYY-MM-DD HH24:MI')))) AS PRT_TIME4         \n");
        sbSql.append("     , COUNT(DECODE(A.ORDER_SEQ,'040',DECODE(TO_CHAR(A.REORDER_TIME),NULL,D.PO_ID))) AS PRT_ORD4                                                                   \n");
        sbSql.append("     , COUNT(DECODE(A.ORDER_SEQ,'040',DECODE(TO_CHAR(A.REORDER_TIME),NULL,A.PO_ID))) AS PO_ORD4                                                                    \n");
        sbSql.append("     , MAX(DECODE(NVL(A.ORDER_SEQ,'000'),'000',DECODE(TO_CHAR(A.REORDER_TIME, 'YYYY-MM-DD HH24:MI'),NULL,TO_CHAR(D.UPDATE_DATE, 'YYYY-MM-DD HH24:MI')))) AS PRT_TIME0 \n");
        sbSql.append("     , COUNT(DECODE(NVL(A.ORDER_SEQ,'000'),'000',DECODE(TO_CHAR(A.REORDER_TIME),NULL,D.PO_ID))) AS PRT_ORD0                                                        \n");
        sbSql.append("     , COUNT(DECODE(NVL(A.ORDER_SEQ,'000'),'000',DECODE(TO_CHAR(A.REORDER_TIME),NULL,A.PO_ID))) AS PO_ORD0                                                         \n");
        sbSql.append("     , MAX(DECODE(TO_CHAR(A.REORDER_TIME, 'YYYY-MM-DD HH24:MI'),NULL,NULL,TO_CHAR(D.UPDATE_DATE, 'YYYY-MM-DD HH24:MI'))) AS PRT_TIMECH                             \n");
        sbSql.append("     , COUNT(DECODE(TO_CHAR(A.REORDER_TIME),NULL,NULL,D.PO_ID)) AS PRT_ORDCH                                                                                       \n");
        sbSql.append("     , COUNT(DECODE(TO_CHAR(A.REORDER_TIME),NULL,NULL,A.PO_ID)) AS PO_ORDCH                                                                                        \n");
        sbSql.append("     , MAX(DECODE(A.ORDER_SEQ,'050',DECODE(TO_CHAR(A.REORDER_TIME, 'YYYY-MM-DD HH24:MI'),NULL,TO_CHAR(D.UPDATE_DATE, 'YYYY-MM-DD HH24:MI'))))  AS PRT_TIME5        \n");
        sbSql.append("     , COUNT(DECODE(A.ORDER_SEQ,'050',DECODE(TO_CHAR(A.REORDER_TIME),NULL,D.PO_ID))) AS PRT_ORD5                                                                   \n");
        sbSql.append("     , COUNT(DECODE(A.ORDER_SEQ,'050',DECODE(TO_CHAR(A.REORDER_TIME),NULL,A.PO_ID))) AS PO_ORD5                                                                    \n");         
		sbSql.append("  FROM PO_PO A, PO_CENTER B, ST_CUST C, PO_ORDERLINE_PRT D \n");
		sbSql.append(" WHERE A.CENTER_CODE = B.CENTER_CODE \n");
		sbSql.append("   AND A.CUSTCD = C.CUSTCD \n");
		sbSql.append("   AND A.PO_ID = D.PO_ID(+) \n");
		sbSql.append("   AND A.NEED_DATE = '" + nullToBlank(ds_Cond.getString(0, "NEED_DATE")) + "' \n");
		sbSql.append("   AND A.LINE_STATUS >= '008' \n");
		sbSql.append("   AND A.CENTER_FLAG = 'Y' \n");
		if (! nullToBlank(ds_Cond.getString(0, "CENTER_CODE")).equals(""))
			sbSql.append("   AND A.CENTER_CODE = " + nullToBlank(ds_Cond.getString(0, "CENTER_CODE")) + " \n");
		if ((!g_CustCd.equals("350511")) && (!g_CustCd.equals("")))
			sbSql.append("   AND A.CUSTCD = " + g_CustCd + " \n");
		sbSql.append(" GROUP BY B.CENTER_NAME, C.CUSTNM \n");
        out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_List = this.makeDataSet(rs, "ds_List");
		
		pstmt.close();
		rs.close();

		/**종료**/
		out_dl.add(ds_List);
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
