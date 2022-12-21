<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/기준정보
■ 프로그램ID   : FMS00560E_T001.jsp
■ 프로그램명   : 가상계좌 입금내역조회
■ 작성일자     : 2013-05-13
■ 작성자       : 문형광
■ 이력관리     : 2013-05-13
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
		DataSet ds_cond     = in_dl.get("ds_Cond");
		//입력 파라메터
		//String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		//FileLog.println("d:\\aaa.txt", ds_cond);

		//out 데이타
		DataSet ds_list;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		//
		//내역조회
		sbSql.append("SELECT C.UPJANG AS RTN4_UPJANG \n");
		sbSql.append("     , C.UPJANGNM_DISP AS RTN4_UPJANGNM \n");
		sbSql.append("     , SCC_CRYPTO.DEC_FUN(A.BANK_ACCT_NO) AS RTN4_VIRACTNUM \n");
		sbSql.append("     , TO_CHAR(TO_DATE(A.RECEIVE_DATE, 'YYYYMMDD'), 'YYYY-MM-DD') AS RTN4_ADDDATE \n");
		sbSql.append("     , TO_CHAR(A.ADDTIME,'HH24:MI:SS') AS RTN4_ADDTIME \n");
		sbSql.append("     , A.RECEIVE_AMT AS RTN4_TRNMONEY \n");
		sbSql.append("     , A.RECEIVE_GUEST_NM ||' '|| (SELECT MAX(BB.REMARK) FROM SLA_ADVANCE_ALT_DETAIL BB, SLA_SAP_SUSPENSE_ALT_DETAIL AD WHERE A.SAP_SUSPENSE_NUM = AD.SAP_SUSPENSE_NUM AND AD.ADVANCE_NUM = BB.ADVANCE_NUM(+) AND BB.RECD_STATUS = 'L') AS RTN4_RECVNAME \n");
		sbSql.append("     --, A.RECEIVE_GUEST_NM ||' '|| BB.REMARK AS RTN4_RECVNAME \n");
		sbSql.append("  FROM SLA_SAP_SUSPENSE_INFO A -- SAP 가수금 정보를 관리한다. \n");
		sbSql.append("     , SLA_SAP_BANK_ACCT_NO B -- SAP에서 전송된 계좌번호 \n");
		sbSql.append("     , FMS_UPJANG C \n");
		sbSql.append("     --, SLA_ADVANCE_ALT_DETAIL BB \n");
		sbSql.append("     --, SLA_SAP_SUSPENSE_ALT_DETAIL AD \n");
		sbSql.append(" WHERE A.BANK_ACCT_NO = B.BANK_ACCT_NO \n");
		sbSql.append("   --AND A.SAP_SUSPENSE_NUM = AD.SAP_SUSPENSE_NUM\n");
		sbSql.append("   --AND AD.ADVANCE_NUM = BB.ADVANCE_NUM\n");
		sbSql.append("   --AND BB.RECD_STATUS = 'L' \n");
		sbSql.append("   AND B.UPJANG_CD = C.UPJANG \n");
		if ( !"".equals(nullToBlank(ds_cond.getString(0, "MAIN_UPJANG"))) && !"0".equals(nullToBlank(ds_cond.getString(0, "MAIN_UPJANG"))) ) {
			sbSql.append("   AND C.MAIN_UPJANG = "+ds_cond.getString(0, "MAIN_UPJANG")+" \n");
		}
		sbSql.append("   AND A.RECEIVE_DATE BETWEEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATET")) + "' \n");
		
		if (!ds_cond.getString(0, "UPJANG").equals("0")) {
			sbSql.append("   AND C.UPJANG = "+ds_cond.getString(0, "UPJANG")+" \n");
		}
		
		sbSql.append("   AND B.BANK_ACCT_TYPE = 'V' -- 가상계좌 \n");
		sbSql.append("   AND A.RECD_STATUS = 'L' \n");
		sbSql.append("   AND A.RECEIVE_AMT > 0 \n");
		sbSql.append(" ORDER BY A.RECEIVE_DATE, A.ADDTIME \n");
		
		/*
		sbSql.append("SELECT RTN4_UPJANG \n");
		sbSql.append("     , RTN4_UPJANGNM \n");
		sbSql.append("     , RTN4_VIRACTNUM \n");
		sbSql.append("     , RTN4_ADDDATE \n");
		sbSql.append("     , RTN4_ADDTIME \n");
		sbSql.append("     , RTN4_TRNMONEY \n");
		sbSql.append("     , RTN4_CUSTCD \n");
		sbSql.append("     , RTN4_CUSTNM \n");
		sbSql.append("     , RTN4_CC_NM \n");
		sbSql.append("     , RTN4_RECVNAME \n");
		sbSql.append("  FROM TABLE (HLDC_TR_VIR_ACCOUNT_LIST_FUN('" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "','" + nullToBlank(ds_cond.getString(0, "NEED_DATET")) + "','" + nullToBlank(ds_cond.getString(0, "MAIN_UPJANG")) + "','" + nullToBlank(ds_cond.getString(0, "UPJANG")) + "')) \n");
		sbSql.append(" ORDER BY RTN4_UPJANG, RTN4_VIRACTNUM, RTN4_ADDDATE, RTN4_ADDTIME \n");
		*/
		
//out_vl.add("fa_Sql", sbSql.toString());
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
