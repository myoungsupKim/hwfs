<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 협력업체/세금계산서 조회
■ 프로그램ID   : FSV00240V_S001.jsp
■ 프로그램명   : 세금계산서 조회
■ 작성일자     : 2008-07-25
■ 작성자       : 박은규
■ 이력관리     : 1) 문형광 2010-02-25 CSR#(34676) 요청자: 최희정사원
               세금계산서 발행사업부정보추가
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	try	{
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		if(conn != null && !conn.isClosed()) conn.close();
	
		conn = getIRISConn();

		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));		
	
		//입력 데이타
		//DataSet ds_cond     = in_dl.get("ds_Cond");
		//입력 파라메터
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		String g_CustCd		= nullToBlank(in_vl.getString("g_CustCd"));
		String FROM 		= nullToBlank(in_vl.getString("FROM"));		
		String TO 		    = nullToBlank(in_vl.getString("TO"));		
		//FileLog.println("d:\\aaa.txt", ds_cond);

		//out 데이타
		DataSet ds_List;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		//내역조회
		sbSql.append("SELECT TO_CHAR(TO_DATE(A.BILL_DATE,'YYYYMMDD'),'YYYY-MM-DD') AS BILL_DATE   	\n");
		sbSql.append("     , '('||SUBSTRB(A.BILL_TYPE,1,2)||')'||A.BILL_NO AS BILL_NO             	\n");
//============================================================================================
//2010/02/25 문형광 - 발행사업부정보추가 - 최희정 요청 CSR#(34676) - 시작
//============================================================================================		
		sbSql.append("     , CASE D.CNT WHEN 1 THEN (SELECT Y.CENTER_NAME FROM PO_TRANSACTION X, PO_CENTER Y \n");
		sbSql.append("     				              WHERE X.GAMU = A.GAMU AND X.GADATE = A.GADATE AND X.GANO = A.GANO AND X.CENTER_CODE = Y.CENTER_CODE AND ROWNUM <= 1) \n");
		sbSql.append("                         ELSE '공통' 		                                 	\n");
		sbSql.append("        END AS CENTER_NAME 												    \n");
		sbSql.append("     , B.MU_NM 												             	\n");
		sbSql.append("     , B.CC_NM AS DEPT_NM                        								\n");
		sbSql.append("     , A.BILL_AMOUNT AS AMT                                                 	\n");
		sbSql.append("     , A.BILL_VAT AS VAT                                                    	\n");
		sbSql.append("     , A.BILL_AMOUNT + A.BILL_VAT AS TOTAL                                  	\n");
		sbSql.append("     , A.BILL_ID, A.BILL_TYPE                                               	\n");
		sbSql.append("     , A.CONFIRM_FLAG  -- 출력여부 필드 추가                                      					\n");
		sbSql.append("     , A.AUTO_BILL_YN  -- 전자세금계산서 여부 추가                                             		   	\n");
		sbSql.append("  FROM PO_CLSBILL A, SC_DEPT_V B, GA_INTERFACE C                          	\n");
//============================================================================================
//2010/02/25 문형광 - 발행사업부정보추가 - 최희정 요청 CSR#(34676) - 종료
//============================================================================================
		sbSql.append("     , (SELECT Y.GAMU, Y.GADATE, Y.GANO, COUNT(*) AS CNT                      \n");
		sbSql.append("          FROM (SELECT DISTINCT X.GAMU, X.GADATE, X.GANO, X.CENTER_CODE       \n");
		sbSql.append("                  FROM PO_TRANSACTION X                                 		\n");
		sbSql.append("                 WHERE X.CUSTCD = "+g_CustCd+"           						\n");
		sbSql.append("                   AND X.TRANS_TYPE = 'I001'           						\n");
		sbSql.append("                   AND X.GANO <> -1                    						\n");
		sbSql.append("                   AND X.TRANS_DATE BETWEEN '"+FROM+"' AND '"+TO+"') Y        \n");
		sbSql.append("         GROUP BY Y.GAMU, Y.GADATE, Y.GANO                                 	\n");
		sbSql.append("       ) D                                     						        \n");
		sbSql.append(" WHERE A.GAMU = C.GAMU                                 						\n");
		sbSql.append("   AND A.GADATE = C.GADATE                               						\n");
		sbSql.append("   AND A.GANO = C.GANO                               						    \n");
		sbSql.append("   AND A.GALINE = C.GALINE                              						\n");
		sbSql.append("   AND C.GADEPT_ID = B.DEPT_ID                               					\n");
		sbSql.append("   AND A.GAMU  = D.GAMU                              						    \n");
		sbSql.append("   AND A.GADATE = D.GADATE                              						\n");
		sbSql.append("   AND A.GANO = D.GANO                            						    \n");
		sbSql.append("   AND A.BILL_DATE BETWEEN '"+FROM+"' AND '"+TO+"'                      		\n");
		sbSql.append("   AND A.CUSTCD = "+g_CustCd+"                 						        \n");
		sbSql.append("   AND A.CANCEL_FLAG = 'N'                                                  	\n");
		sbSql.append(" ORDER BY A.BILL_DATE, A.BILL_NO                                            	\n");		
out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_List = this.makeDataSet(rs, "ds_List");
		
		pstmt.close();
		rs.close();
		
		//FileLog.println("d:\\aaa.txt", ds_list);

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
