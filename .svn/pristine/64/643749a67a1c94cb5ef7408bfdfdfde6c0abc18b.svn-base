<%
//-----------------------------------------------------------------------------
//  ■ 시스템명     : 식재영업/보조금 내역 조회
//  ■ 프로그램ID   : FMP00930V_T002.jsp
//  ■ 프로그램명   : 친환경 자재 정부 보조금 세부 내역 조회
//  ■ 작성일자     : 2010.08.17
//  ■ 작성자       : 노규완
//■ 이력관리     : 2010.08.17

//* HISTORY    :
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
		DataSet ds_Cond     = in_dl.get("ds_Cond");
		//입력 파라메터
	//	String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
	//	String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
	
	//FileLog.println("d:\\aaa.txt", ds_cond);


		//out 데이타
		DataSet ds_list;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		//
		String sMainUpjang = nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG"));
		//String sUpjang = nullToBlank(ds_Cond.getString(0, "UPJANG"));
		String sSdate = nullToBlank(ds_Cond.getString(0, "SDATE"));
		String sEdate = nullToBlank(ds_Cond.getString(0, "EDATE"));		

		//내역조회
        sbSql.append("SELECT A.UPJANG                                                                                                                                 \n");
        sbSql.append("      ,B.UPJANGNM_DISP                                                                                                                          \n");
        sbSql.append("      ,SUBSTR(A.NEED_DATE,1,4)||'-'||SUBSTR(A.NEED_DATE,5,2)||'-'||SUBSTR(A.NEED_DATE,7,2) AS NEED_DATE                                         \n");
        sbSql.append("      ,(SELECT SUB_AMOUNT FROM FMS_GREEN_SUB  WHERE UPJANG = A.UPJANG  AND A.NEED_DATE BETWEEN SUB_START AND SUB_END  AND USE_YN = 'Y') AS SUB_AMOUNT \n");
        sbSql.append("      ,A.ITEM_CODE                                                                                                                              \n");
        sbSql.append("      ,A.ITEM_NAME                                                                                                                              \n");
        sbSql.append("      ,A.QTY                                                                                                                                    \n");
        sbSql.append("      ,A.PRICE                                                                                                                                  \n");
        sbSql.append("      ,(A.QTY * A.PRICE) AS SALE_PRICE                                                                                                          \n");
        sbSql.append("      ,A.GREEN_AMT                                                                                                                              \n");
        sbSql.append("      ,( (A.QTY * A.PRICE) - A.GREEN_AMT ) AS UPJANG_PRICE                                                                                      \n");
        sbSql.append("  FROM FMP_PO_GREEN_AMT A                                                                                                                       \n");
        sbSql.append("      ,FMS_UPJANG B                                                                                                                             \n");
        sbSql.append(" WHERE A.UPJANG = B.UPJANG                                                                                                                      \n");
        sbSql.append("   AND A.NEED_DATE BETWEEN '" + sSdate + "' AND '" + sEdate + "'                                                                                \n");
        sbSql.append("   AND B.MAIN_UPJANG = '" + sMainUpjang + "'                                                                                                    \n");		
        sbSql.append("   AND A.UPJANG LIKE '%" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'                                                                                                    \n");
        sbSql.append("   AND A.LINE_STATUS NOT IN ('003','005') \n");        
	
		
out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_list = this.makeDataSet(rs, "ds_List");
		
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
