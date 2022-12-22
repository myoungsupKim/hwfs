<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/급식채권관리
■ 프로그램ID   : FMO00570V_T001.jsp
■ 프로그램명   : 사업장별 잔고집계
■ 작성일자     : 2008.02.21
■ 작성자       : 박은규
■ 이력관리     : 2008.02.21
* HISTORY    :
	  1. 변경 일자 : 2009/08/18(화)  변경번호 : #29877 인시던트 : 123488
	     수정자 : 노규완
	     변경 내용 : 외상/선수 잔액을 먼저 등록 한  경우를 대비 하여 수정(ADD_MONTHS(날짜,1))를 통하여 
	               최고 2달치 까지 끌고 오게 수정.
	     요청자 : FS 식재사업 김진희씨
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
		String sUpjang  	= nullToBlank(in_vl.getString("sUpjang"));
		String sMainUpjang  = nullToBlank(in_vl.getString("sMainUpjang"));
		String sDate        = nullToBlank(in_vl.getString("sDate"));
		String sUserKind    = nullToBlank(in_vl.getString("sUserKind"));
		String p_MaskAuth     = nullToBlank(in_vl.getString("p_MaskAuth"));
		String g_PersInfoMask = nullToBlank(in_vl.getString("g_PersInfoMask"));
		
		//out 데이타
		DataSet ds_list;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		//내역조회
		sbSql.append("SELECT A.UPJANG \n");
		sbSql.append("     , A.UPJANGNM_DISP \n"); 
		sbSql.append("     , NVL(B.AR_AMT, 0) AS AMT1 \n");
		sbSql.append("     , NVL(C.SAL_AMT, 0) AS AMT2 \n");
		sbSql.append("     , NVL(D.RECEIVE_AMT, 0) AS AMT3 \n");
		sbSql.append("     , NVL(B.AR_AMT, 0) + NVL(C.SAL_AMT, 0) - NVL(D.RECEIVE_AMT, 0) AS AMT4 \n");
		sbSql.append("     , SC_CRYPTO_FUN('DEC', E.BANK_ACCT_NO) AS ACNTCD \n"); 
		//sbSql.append("     , SCC_CRYPTO.MASKAUTH_FUN(E.BANK_ACCT_NO, 6, '"+g_PersInfoMask+"', '"+p_MaskAuth+"') AS ACNTCD \n");
		sbSql.append("  FROM FMS_UPJANG A \n");
		sbSql.append("     , (-- 기초잔고 \n");
				sbSql.append(" SELECT	\n");
				sbSql.append(" 	  X.UPJANG_CD AS UPJANG	\n");
				sbSql.append(" 	, SUM(NVL(X.AR_AMT,0) - NVL(X.RECEIVE_AMT,0)) AS AR_AMT	\n");
				sbSql.append(" FROM 	\n");
				sbSql.append(" 	(	\n");
				sbSql.append(" 	SELECT	\n");
				sbSql.append(" 		 M.UPJANG_CD	\n");
				sbSql.append(" 		, NVL(M.AR_AMT,0) AS AR_AMT  	\n");
				sbSql.append(" 		, (SELECT NVL(SUM(D.RECEIVE_AMT),0) 	\n");
				sbSql.append(" 		   FROM SLA_AR_RECEIVE_DETAIL D 	\n");
				sbSql.append(" 		   WHERE D.RECD_STATUS  = 'L' 	\n");
				sbSql.append(" 		   AND D.RECEIVE_DATE < SUBSTR('" + sDate + "', 1, 6)||'01'	\n");
				sbSql.append(" 		   AND D.AR_NUM = M.AR_NUM) AS RECEIVE_AMT	\n");
				sbSql.append(" 	FROM SLA_AR_MST M	\n");
				sbSql.append(" 	WHERE M.SYS_CLASS = '13'	\n");
				sbSql.append(" 	AND    M.RECD_STATUS = 'L'	\n");
				sbSql.append(" 	AND    M.OCCUR_DATE < SUBSTR('" + sDate + "', 1, 6)||'01'	\n");
				sbSql.append(" 	AND    M.UPJANG_CD IN (SELECT UPJANG FROM FMS_UPJANG  WHERE 1=1 \n");
				
				if (!sMainUpjang.equals("")) {
	 				sbSql.append(" 					    AND MAIN_UPJANG = " + sMainUpjang + " 	\n");
	 				if (!sUpjang.equals("")) {
		 				sbSql.append(" 					AND UPJANG = " + sUpjang + " 	\n");
					}
				}
				
				sbSql.append(" 					AND USE_YN = 'Y' 	\n");
				sbSql.append(" 					) 	\n");
				sbSql.append(" 	) X		\n");
				sbSql.append(" GROUP BY X.UPJANG_CD	\n");
		sbSql.append("       ) B \n");
				sbSql.append("     , (-- 당월채권액 \n");
				sbSql.append(" 	SELECT \n");
				sbSql.append(" 		  M.UPJANG_CD AS UPJANG \n");
				sbSql.append(" 		, SUM(NVL(M.AR_AMT,0)) AS SAL_AMT   \n");
				sbSql.append(" 	FROM SLA_AR_MST M \n");
				sbSql.append(" 	WHERE M.SYS_CLASS = '13' \n");
				sbSql.append(" 	AND    M.RECD_STATUS = 'L' \n");
				sbSql.append(" 	AND    M.OCCUR_DATE BETWEEN SUBSTR('" + sDate + "', 1, 6)||'01'  AND '" + sDate + "' \n");
				sbSql.append(" 	AND    M.UPJANG_CD IN (SELECT UPJANG FROM FMS_UPJANG  WHERE 1=1 \n");
				
				if (!sMainUpjang.equals("")) {
	 				sbSql.append(" 					    AND MAIN_UPJANG = " + sMainUpjang + " 	\n");
	 				if (!sUpjang.equals("")) {
		 				sbSql.append(" 					AND UPJANG = " + sUpjang + " 	\n");
					}
				}
				
				sbSql.append(" 					AND USE_YN = 'Y'  \n");
				sbSql.append(" 					)  \n");
				sbSql.append(" 	GROUP BY M.UPJANG_CD \n");
		sbSql.append("       ) C \n");
				sbSql.append("     , (-- 당월입금액 \n");
				sbSql.append(" SELECT \n");
				sbSql.append(" 	  X.UPJANG_CD AS UPJANG \n");
				sbSql.append(" 	, SUM(NVL(X.RECEIVE_AMT,0)) AS RECEIVE_AMT \n");
				sbSql.append(" FROM  \n");
				sbSql.append(" 	( \n");
				sbSql.append(" 	SELECT \n");
				sbSql.append(" 			  M.UPJANG_CD \n");
				sbSql.append(" 			, M.AR_NUM \n");
				sbSql.append(" 		, (SELECT NVL(SUM(D.RECEIVE_AMT),0)  \n");
				sbSql.append(" 		   FROM SLA_AR_RECEIVE_DETAIL D  \n");
				sbSql.append(" 		   WHERE D.RECD_STATUS  = 'L'  \n");
				sbSql.append(" 		   AND  D.RECEIVE_DATE BETWEEN SUBSTR('" + sDate + "', 1, 6)||'01'  AND '" + sDate + "' \n");
				sbSql.append(" 		   AND D.AR_NUM = M.AR_NUM) AS RECEIVE_AMT \n");
				sbSql.append(" 	FROM SLA_AR_MST M \n");
				sbSql.append(" 	WHERE M.SYS_CLASS = '13' \n");
				sbSql.append(" 	AND    M.RECD_STATUS = 'L' \n");
				sbSql.append(" 	AND    M.UPJANG_CD IN (SELECT UPJANG FROM FMS_UPJANG  WHERE 1=1 \n");
				
				if (!sMainUpjang.equals("")) {
	 				sbSql.append(" 					    AND MAIN_UPJANG = " + sMainUpjang + " 	\n");
	 				if (!sUpjang.equals("")) {
		 				sbSql.append(" 					AND UPJANG = " + sUpjang + " 	\n");
					}
				}
				
				sbSql.append(" 					AND USE_YN = 'Y'  \n");
				sbSql.append(" 					)  \n");
				sbSql.append(" 	) X	 \n");
				sbSql.append(" GROUP BY X.UPJANG_CD \n");
		sbSql.append("       ) D \n"); 
		sbSql.append("     , SLA_SAP_BANK_ACCT_NO E \n");  
		sbSql.append(" WHERE 1=1 					\n");
		
		if (!sMainUpjang.equals("")) {
				sbSql.append(" 					    AND A.MAIN_UPJANG = " + sMainUpjang + " 	\n");
				if (!sUpjang.equals("")) {
 				sbSql.append(" 					AND A.UPJANG = " + sUpjang + " 	\n");
			}
		}
		
		sbSql.append("   AND A.USE_YN = 'Y' \n");
		sbSql.append("   AND A.UPJANG = B.UPJANG(+) \n");
		sbSql.append("   AND A.UPJANG = C.UPJANG(+) \n");
		sbSql.append("   AND A.UPJANG = D.UPJANG(+) \n");   
		sbSql.append("   AND A.UPJANG = E.UPJANG_CD(+) \n");   
		sbSql.append(" ORDER BY A.UPJANG \n"); 
	
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

<%--
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
		String sUpjang      = nullToBlank(in_vl.getString("sUpjang"));
		String sDate        = nullToBlank(in_vl.getString("sDate"));
		String sUserKind    = nullToBlank(in_vl.getString("sUserKind"));
		//FileLog.println("d:\\aaa.txt", ds_cond);
	

		//out 데이타
		DataSet ds_list;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		//내역조회
		sbSql.append("SELECT A.UPJANG, A.UPJANGNM_DISP, B.AMT1, C.AMT2, D.AMT3 \n");
		sbSql.append("     , NVL(B.AMT1,0) + NVL(C.AMT2,0) - NVL(D.AMT3,0) AS AMT4 \n");
		sbSql.append("     , SC_CRYPTO_FUN('DEC', A.ACNTCD_ENC , '3') AS ACNTCD \n");
		sbSql.append("  FROM FMS_UPJANG A \n");
		sbSql.append("       --전월잔고 \n");
		sbSql.append("     ,(SELECT A.UPJANG \n");
		sbSql.append("            , SUM(A.AMOUNT) AS AMT1 \n");
		sbSql.append("         FROM \n");
		sbSql.append("         --전월 누적매출 \n");
        sbSql.append("              (SELECT B.UPJANG                      \n");
        sbSql.append("                    , SUM(B.BILL_AMOUNT + B.BILL_VAT) AS AMOUNT \n");
        sbSql.append("                 FROM HLDC_FM_BILL B                \n");
        sbSql.append("                WHERE B.UPJANG IN (SELECT UPJANG FROM FMS_UPJANG \n");
        sbSql.append("                                    WHERE MAIN_UPJANG = " + sUpjang + ") \n");
        sbSql.append("                  AND B.BILL_DATE < SUBSTR('" + sDate + "',1,6)||'01' \n");
        sbSql.append("                  AND B.CANCEL_FLAG = 'N'           \n");
        sbSql.append("                  AND B.DCGUBUN = '1'               \n");
        sbSql.append("                  AND (B.BILL_AMOUNT + B.BILL_VAT) != 0 \n");
        sbSql.append("                GROUP BY B.UPJANG                   \n");
        sbSql.append("                ---------                           \n");
        sbSql.append("                UNION ALL                           \n");
        sbSql.append("                ---------                           \n");
        sbSql.append("                --전월 누적입금                     \n");
        sbSql.append("               SELECT B.UPJANG                      \n");
        sbSql.append("                    , SUM(-B.AMOUNT) AS AMOUNT      \n");
        sbSql.append("                 FROM HLDC_FM_RECEIPT B             \n");
        sbSql.append("                WHERE B.UPJANG IN (SELECT UPJANG FROM FMS_UPJANG \n");
        sbSql.append("                                    WHERE MAIN_UPJANG = " + sUpjang + ") \n");
        sbSql.append("                  AND B.RECEIPT_DATE < SUBSTR('" + sDate + "',1,6)||'01' \n");
        sbSql.append("                  AND B.DCGUBUN = '1'               \n");
        sbSql.append("                  AND B.AMOUNT != 0                 \n");
        sbSql.append("                GROUP BY B.UPJANG) A                \n");
        sbSql.append("        GROUP BY A.UPJANG) B                        \n");
		sbSql.append("       --당월매출 \n");
		sbSql.append("     ,(SELECT B.UPJANG \n");
		sbSql.append("            , SUM(B.BILL_AMOUNT + B.BILL_VAT) AS AMT2 \n");
		sbSql.append("         FROM HLDC_FM_BILL B \n");
		sbSql.append("        WHERE B.UPJANG IN (SELECT UPJANG FROM FMS_UPJANG \n");
		sbSql.append("                            WHERE MAIN_UPJANG = " + sUpjang + ") \n");
		// (#29877)2009-08-18 추가 수정 시작. 
		// 내용 : 매출 계산서를 해당월 다음달 계산서를 먼저 발행했을 경우를 대비 하여 수정(ADD_MONTHS(날짜,1))를 통하여 최고 2달치 까지 끌고 오게 수정.
		//       기존 수정 된 한달 후 조회 에서 최고 2달까지 미리 발행 한 것들을 조회 가능 하게 수정. 입금 부분은 적용 하지 않았음. 향후 입금 부분이 이상하다고 할때는 아래 입금 부분도 동일하게 적용 하면 됨.
		//       관련 화면 : FMO00570V,FMO00550V,FMO00530V,MAK10170S,FMZ_CREDIT_INFO_T001.jsp 
		//sbSql.append("          AND B.BILL_DATE <= GREATEST('" + sDate + "', TO_CHAR(ADD_MONTHS(LAST_DAY(SYSDATE),1),'YYYYMMDD')) \n");
		sbSql.append("          AND B.BILL_DATE BETWEEN SUBSTR('" + sDate + "',1,6)||'01' AND '" + sDate + "' \n");		
		// (#29877)2009-08-18 추가 수정 끝.
		sbSql.append("          AND B.CANCEL_FLAG = 'N' \n");
		sbSql.append("          AND B.DCGUBUN = '1' \n");
		//sbSql.append("          AND B.ACCTCD = '1110411' \n");
		sbSql.append("          AND (B.BILL_AMOUNT + B.BILL_VAT) != 0 \n");
		sbSql.append("        GROUP BY B.UPJANG) C \n");
		sbSql.append("       --당월입금 \n");
		sbSql.append("     ,(SELECT B.UPJANG \n");
		sbSql.append("            , SUM(B.AMOUNT) AS AMT3 \n");
		sbSql.append("         FROM HLDC_FM_RECEIPT B \n");
		sbSql.append("        WHERE B.UPJANG IN (SELECT UPJANG FROM FMS_UPJANG \n");
		sbSql.append("                            WHERE MAIN_UPJANG = " + sUpjang + ") \n");
		sbSql.append("          AND B.RECEIPT_DATE BETWEEN SUBSTR('" + sDate + "',1,6)||'01' AND '" + sDate + "' \n");
		//sbSql.append("          AND B.DCGUBUN = '2' \n");
		sbSql.append("          AND B.DCGUBUN = '1' \n");
		//sbSql.append("          AND B.ACCTCD = '1110411' \n");
		sbSql.append("          AND B.AMOUNT != 0 \n");
		sbSql.append("        GROUP BY B.UPJANG) D \n");
		sbSql.append(" WHERE A.UPJANG = B.UPJANG(+) \n");
		sbSql.append("   AND A.UPJANG = C.UPJANG(+) \n");
		sbSql.append("   AND A.UPJANG = D.UPJANG(+) \n");
		sbSql.append("   AND A.MAIN_UPJANG = " + sUpjang + " \n");
		if (sUserKind.equals("사업장"))
			sbSql.append("   AND (A.UPJANG = " + g_Upjang + " OR EXISTS (SELECT 1 FROM FMS_USER_UPJANG Z WHERE Z.USE_YN = 'Y' AND Z.UPJANG = A.UPJANG AND Z.SABUN = '" + g_EmpNo + "')) \n");
		sbSql.append(" ORDER BY A.UPJANG \n");

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

--%>
