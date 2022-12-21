<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 메뉴관리/자재관리
■ 프로그램ID   : FSI00091V_T001.jsp
■ 프로그램명   : 업장별 사용현황조회
■ 작성일자     : 2008.02.12
■ 작성자       : 박지영
■ 이력관리     : 2008.02.12
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
		DataSet ds_input     = in_dl.get("ds_input");
	
		//FileLog.println("d:\\aaa.txt", ds_cond);
		
		String strTmCd	    = nullToBlank(ds_input.getString(0, "TM_CD"));
		String strUpjang	= nullToBlank(ds_input.getString(0, "UPJANG"));
		String strFromDt 	= nullToBlank(ds_input.getString(0, "FROM_DT"));
		String strToDt		= nullToBlank(ds_input.getString(0, "TO_DT"));
		String strExcept	= in_vl.getString("strExcept");

		//out 데이타
		DataSet ds_list;
		
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
	    sbSql.append("SELECT C.TM_CD                                                                                                                           \n");
	    sbSql.append("     , C.TM_NAME                                                                                                                         \n");
	    sbSql.append("     , C.JOB_CD                                                                                                                          \n");
	    sbSql.append("     , C.JOB_NAME                                                                                                                        \n");
	    sbSql.append("     , C.SUB_JOB_CD                                                                                                                      \n");
	    sbSql.append("     , C.SUB_JOB_NAME                                                                                                                    \n");
	    sbSql.append("     , C.UPJANG                                                                                                                          \n");
	    sbSql.append("     , C.UPJANGNM                                                                                                                        \n");
	    sbSql.append("     , C.ITEM_CODE                                                                                                                       \n");
	    sbSql.append("     , E.ITEM_NAME                                                                                                                       \n");
	    sbSql.append("     , E.ITEM_SIZE                                                                                                                       \n");
	    sbSql.append("     , E.PO_UOM                                                                                                                          \n");
	    sbSql.append("     , TO_CHAR(TO_DATE(C.START_DATE,'YYYYMMDD'),'YYYY.MM.DD') || '~' || TO_CHAR(TO_DATE(C.END_DATE,'YYYYMMDD'),'YYYY.MM.DD') AS PERIOD   \n");
	    sbSql.append("     , GREATEST(C.START_DATE, '" + strFromDt + "') AS START_DATE                                                                         \n");
	    sbSql.append("     , LEAST(C.END_DATE, '" + strToDt + "') AS END_DATE                                                                                  \n");
	    sbSql.append("     , NVL(D.TRANS_QTY,0) AS TRANS_QTY --입고량                                                                                          \n");
	    sbSql.append("  FROM (                                                                                                                                 \n");
	    sbSql.append("        SELECT A.CENTER_CODE                                                                                                             \n");
	    sbSql.append("             , A.CUSTCD                                                                                                                  \n");
	    sbSql.append("             , A.ITEM_CODE                                                                                                               \n");
	    sbSql.append("             , A.START_DATE                                                                                                              \n");
	    sbSql.append("             , A.END_DATE                                                                                                                \n");
	    sbSql.append("             , B.TM_CD                                                                                                                   \n");
	    sbSql.append("             , B.TM_NAME                                                                                                                 \n");
	    sbSql.append("             , B.JOB_CD                                                                                                                  \n");
	    sbSql.append("             , B.JOB_NAME                                                                                                                \n");
	    sbSql.append("             , B.SUB_JOB_CD                                                                                                              \n");
	    sbSql.append("             , B.SUB_JOB_NAME                                                                                                            \n");
	    sbSql.append("             , B.UPJANG                                                                                                                  \n");
	    sbSql.append("             , B.UPJANGNM                                                                                                                \n");
	    sbSql.append("          FROM FSI_DUTY_MST A                                                                                                            \n");
	    sbSql.append("             , MAC_UPJANG_V B                                                                                                            \n");
	    sbSql.append("             , HLDC_PO_UPJANG_CENTER C                                                                                                   \n");
	    sbSql.append("         WHERE B.AP_UNITPRICE_UPJANG = C.UPJANG                                                                                          \n");
	    sbSql.append("           AND C.CENTER_CODE = A.CENTER_CODE                                                                                             \n");
	    sbSql.append("           AND B.TM_CD = '" + strTmCd + "'                                                                                               \n");
	    sbSql.append("           AND A.START_DATE <= '" + strToDt + "' AND A.END_DATE >= '" + strFromDt + "'                                                   \n");
	    sbSql.append("           AND NVL(B.CLOSE_DATE, '99999999') >= '" + strFromDt + "'                                                                      \n");
	    sbSql.append("       ) C                                                                                                                               \n");
	    sbSql.append("     , (SELECT B.CENTER_CODE                                                                                                             \n");
	    sbSql.append("             , B.CUSTCD                                                                                                                  \n");
	    sbSql.append("             , B.ITEM_CODE                                                                                                               \n");
	    sbSql.append("             , B.START_DATE                                                                                                              \n");
	    sbSql.append("             , A.TRANS_UPJANG AS UPJANG                                                                                                  \n");
	    sbSql.append("             , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * A.TRANS_QTY) AS TRANS_QTY                                                 \n");
	    sbSql.append("          FROM FSI_DUTY_MST B                                                                                                            \n");
	    sbSql.append("             , HLDC_PO_TRANSACTION A                                                                                                     \n");
	    sbSql.append("         WHERE A.CENTER_CODE = B.CENTER_CODE                                                                                             \n");
	    sbSql.append("           AND A.CUSTCD = B.CUSTCD                                                                                                       \n");
	    sbSql.append("           AND A.ITEM_CODE = B.ITEM_CODE                                                                                                 \n");
	    sbSql.append("           AND A.TRANS_DATE BETWEEN GREATEST(B.START_DATE, '" + strFromDt + "') AND LEAST(B.END_DATE, '" + strToDt + "')                 \n");
	    sbSql.append("           AND B.START_DATE <= '" + strToDt + "' AND B.END_DATE >= '" + strFromDt + "'                                                   \n");
	    sbSql.append("           AND A.TRANS_MU_CD = '2002'                                                                                                    \n");
	    sbSql.append("           --AND A.SUBINV_CODE LIKE 'C%'                                                                                                 \n");
	    sbSql.append("           AND (A.TRANS_TYPE = 'I001' OR (A.TRANS_TYPE LIKE '_002' AND A.SOURCE_TYPE = 'PO'))                                            \n");
	    sbSql.append("         GROUP BY B.CENTER_CODE, B.CUSTCD, B.ITEM_CODE, B.START_DATE, A.TRANS_UPJANG                                                     \n");
	    sbSql.append("       ) D                                                                                                                               \n");
	    sbSql.append("     , HLDC_PO_ITEM_MST E                                                                                                                \n");
	    sbSql.append(" WHERE C.CENTER_CODE = D.CENTER_CODE(+)                                                                                                  \n");
	    sbSql.append("   AND C.CUSTCD      = D.CUSTCD(+)                                                                                                       \n");
	    sbSql.append("   AND C.ITEM_CODE   = D.ITEM_CODE(+)                                                                                                    \n");
	    sbSql.append("   AND C.UPJANG      = D.UPJANG(+)                                                                                                       \n");
	    sbSql.append("   AND C.ITEM_CODE   = E.ITEM_CODE                                                                                                       \n");

	    System.out.println(sbSql.toString());
	    
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery(); 
		ds_list = this.makeDataSet(rs, "ds_list");
		
		rs.close();
		pstmt.close();

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