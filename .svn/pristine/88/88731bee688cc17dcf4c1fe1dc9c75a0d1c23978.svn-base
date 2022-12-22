<%                                                                                                                                                                                                      
/*-----------------------------------------------------------------------------                                                                                                                         
■ 시스템명     : 메뉴관리/위생관리                                                                                                                                                                     
■ 프로그램ID   : FSC00041P_T001.jsp                                                                                                                                                                    
■ 프로그램명   : 분기별 점검결과조회/부적합 상세팝업                                                                                                                                               
■ 작성일자     : 2008-12-29                                                                                                                                                                            
■ 작성자       : 박은규                                                                                                                                                                                
■ 이력관리     : 2008-12-29                                                                                                                                                                            
1)박은규 2012-10-22 CSR#(CH201210_00118) 요청자:홍호준(식품연구소)
기존 년별 조회에서 기간으로 조회
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
		//입력 파라메터
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		//============================================================================================
		//(2012-10-22 수정) 시작
		// 박은규 2012-10-22 CSR#(CH201210_00118) 요청자:홍호준(식품연구소)
		// 년도조회에서 기간조회로 변경
		//============================================================================================
		//String sYear        = nullToBlank(in_vl.getString("sYear"));
		String sFromDate      = nullToBlank(in_vl.getString("sFromDate"));
		String sToDate        = nullToBlank(in_vl.getString("sToDate"));
		//============================================================================================
		//(2012-10-22 수정) 끝
		//============================================================================================
		String sUpjang      = nullToBlank(in_vl.getString("sUpjang"));
		//FileLog.println("d:\\aaa.txt", ds_cond);


		//out 데이타
		DataSet ds_List;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		//

		//내역조회
		sbSql.append("SELECT TO_CHAR(TO_DATE(C.CHECK_DATE,'YYYYMMDD'),'YYYY.MM.DD') AS CHECK_DATE \n");
		sbSql.append("     , A.CLASS_NAME \n");
		sbSql.append("     , C.EVAL_CONTENTS \n");
		sbSql.append("     , C.MARK \n");
		sbSql.append("  FROM FSC_SAFE_CLASS_MST A, FSC_SAFE_FORM_DTL B, FSC_SAFE_RESULT_DTL C \n");
		sbSql.append(" WHERE A.CLASS_CD = C.CLASS_CD \n");
		sbSql.append("   AND B.TABLE_TYPE = C.TABLE_TYPE \n");
		sbSql.append("   AND B.FORM_CD = C.FORM_CD \n");
		sbSql.append("   AND B.CLASS_CD = C.CLASS_CD \n");
		//============================================================================================
		//(2012-10-22 수정) 시작
		// 박은규 2012-10-22 CSR#(CH201210_00118) 요청자:홍호준(식품연구소)
		// 년도조회에서 기간조회로 변경
		//============================================================================================
		//sbSql.append("   AND C.CHECK_DATE BETWEEN '" + sYear + "'||'0101' AND '" + sYear + "'||'1231' \n");
		sbSql.append("   AND C.CHECK_DATE BETWEEN '" + sFromDate + "' AND '" + sToDate + "' \n");
		//============================================================================================
		//(2012-10-22 수정) 끝
		//============================================================================================
		sbSql.append("   AND C.UPJANG = " + sUpjang + " \n");
		sbSql.append("   -- 최소점이면서 부적합 건수가 있는것 \n");
		sbSql.append("   AND ((LEAST(NVL(B.MARK_1,999), NVL(B.MARK_2,999), NVL(B.MARK_3,999), NVL(B.MARK_4,999)) = C.MARK AND C.NOT_FIT_CNT > 0) \n");
		sbSql.append("   -- 또는, 합계점수가 60미만인것 \n");
		sbSql.append("        OR EXISTS (SELECT 1 \n");
		sbSql.append("                     FROM FSC_SAFE_RESULT_MST X \n");
		sbSql.append("                    WHERE X.TABLE_TYPE = C.TABLE_TYPE \n");
		sbSql.append("                      AND X.FORM_CD = C.FORM_CD \n");
		sbSql.append("                      AND X.UPJANG = C.UPJANG \n");
		sbSql.append("                      AND X.CHECK_DATE = C.CHECK_DATE \n");
		sbSql.append("                      AND X.SCORE < 60) \n");
		sbSql.append("   -- 또는, 중분류가 중점관리인데 최대점이 아닌 것이 중점관리 건수 이상인것 \n");
		sbSql.append("        OR EXISTS (SELECT 1 \n");
		sbSql.append("                     FROM FSC_SAFE_RESULT_DTL X, FSC_SAFE_CLASS_MST Y \n");
		sbSql.append("                    WHERE X.TABLE_TYPE = Y.TABLE_TYPE \n");
		sbSql.append("                      AND X.FORM_CD = Y.FORM_CD \n");
		sbSql.append("                      AND SUBSTR(X.CLASS_CD,1,5)||'000' = Y.CLASS_CD \n");
		sbSql.append("                      AND Y.MNGM_FLAG = 'Y' --중점관리하는 중분류 \n");
		sbSql.append("                      AND Y.MNGM_CNT > 0 --중점관리수량설정이 있는 것 \n");
		sbSql.append("                      AND X.MAX_YN != 'Y' --만점이 아닌 항목 \n");
		sbSql.append("                      AND X.TABLE_TYPE = C.TABLE_TYPE \n");
		sbSql.append("                      AND X.FORM_CD = C.FORM_CD \n");
		sbSql.append("                      AND X.UPJANG = C.UPJANG \n");
		sbSql.append("                      AND X.CHECK_DATE = C.CHECK_DATE \n");
		sbSql.append("                    GROUP BY Y.CLASS_CD, Y.MNGM_CNT \n");
		sbSql.append("                   HAVING Y.MNGM_CNT <= COUNT(X.CLASS_CD))--만점아닌 갯수가 중점관리갯수 이상이면 부적합 \n");
		sbSql.append("       ) \n");
		sbSql.append(" ORDER BY C.CHECK_DATE, C.CLASS_CD \n");

out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_List = this.makeDataSet(rs, "ds_List");
		
		pstmt.close();
		rs.close();
		
		//FileLog.println("d:\\aaa.txt", ds_List);

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
                                                                                                                                                                                                      