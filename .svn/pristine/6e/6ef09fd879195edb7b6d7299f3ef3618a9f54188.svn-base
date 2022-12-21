<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/급식채권관리
■ 프로그램ID   : FMO00550V_T001.jsp
■ 프로그램명   : 본사별 잔고집계
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
		String sUpjang      = nullToBlank(in_vl.getString("sUpjang"));
		//***************************************************************
		//CSR RFC Number : 25276 
		//수정 : 조회 조건 파라메터 추가. 수정자 : 노규완.  수정일 : 2009/03/10
		//***************************************************************
		String sSabun       = nullToBlank(in_vl.getString("sSabun"));
		//***************************************************************		
		String sDate        = nullToBlank(in_vl.getString("sDate"));
		//FileLog.println("d:\\aaa.txt", ds_cond);


		//out 데이타
		DataSet ds_list;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		//내역조회
		sbSql.append("SELECT A.UPJANG, A.UPJANGNM_DISP, B.AMT1, C.AMT2, D.AMT3 \n");
		sbSql.append("     , NVL(B.AMT1,0) + NVL(C.AMT2,0) - NVL(D.AMT3,0) AS AMT4 \n");
		// 개인정보보호를 위한 마스킹처리 20140305 김장욱 수정
		//sbSql.append("     , SC_CRYPTO_FUN('DEC', A.ACNTCD_ENC , '3') AS ACNTCD \n");
		//sbSql.append("     , RPAD(SUBSTR(SC_CRYPTO_FUN('DEC', A.ACNTCD_ENC , '3'), 1, LENGTH(SC_CRYPTO_FUN('DEC', A.ACNTCD_ENC , '3'))-4), LENGTH(SC_CRYPTO_FUN('DEC', A.ACNTCD_ENC , '3')), '*') AS ACNTCD \n");
		sbSql.append("     , HLDC_SC_PRIVINFODISP_FUN('" + g_EmpNo + "', 'FMO00550V.xml', '3', SC_CRYPTO_FUN('DEC', A.ACNTCD_ENC, '3'), '3') ACNTCD \n");
		//sbSql.append("     ,(SELECT B.NM_KOR  FROM HLDC_HR_PERSONAL B WHERE A.PART_SALES_SABUN = B.SABUN) AS PART_SALES_SABUN ");  //CSR RFC Number : 25276 영업사원 필드 추가
		sbSql.append("     ,HLDC_SC_PRIVINFODISP_FUN('" + g_EmpNo + "', 'FMO00550V.xml', '10', (SELECT B.NM_KOR  FROM HLDC_HR_PERSONAL B WHERE A.PART_SALES_SABUN = B.SABUN), '3') AS PART_SALES_SABUN ");  //CSR RFC Number : 25276 영업사원 필드 추가
		sbSql.append("  FROM FMS_UPJANG A \n");
		sbSql.append("       --전월잔고 \n");
		sbSql.append("     ,(SELECT A.MAIN_UPJANG AS UPJANG \n");
		sbSql.append("            , SUM((B.BILL_AMOUNT + B.BILL_VAT) - NVL(C.RCP_AMT,0)) AS AMT1 \n");
		sbSql.append("         FROM FMS_UPJANG A, HLDC_FM_BILL B \n");
		sbSql.append("            ,(SELECT C.BILL_ID, SUM(C.AMOUNT) AS RCP_AMT \n");
		sbSql.append("                FROM HLDC_FM_RECEIPT B, HLDC_FM_BILL_RECEIPT C \n");
		sbSql.append("               WHERE B.RECEIPT_ID = C.RECEIPT_ID \n");
		if (! sUpjang.equals(""))
		{
			sbSql.append("                 AND B.UPJANG IN (SELECT UPJANG FROM FMS_UPJANG \n");
			sbSql.append("                                   WHERE MAIN_UPJANG = " + sUpjang + ") \n");
		}
		sbSql.append("                 AND B.RECEIPT_DATE < SUBSTR('" + sDate + "',1,6) \n");
		sbSql.append("               GROUP BY C.BILL_ID) C \n");
		sbSql.append("        WHERE A.UPJANG = B.UPJANG \n");
		sbSql.append("          AND B.BILL_ID = C.BILL_ID(+) \n");
		if (! sUpjang.equals(""))
			sbSql.append("          AND A.MAIN_UPJANG = " + sUpjang + " \n");
		sbSql.append("          AND B.BILL_DATE < SUBSTR('" + sDate + "',1,6) \n");
		sbSql.append("          AND B.CANCEL_FLAG = 'N' \n");
		sbSql.append("          AND B.DCGUBUN = '1' \n");
		sbSql.append("          AND B.ACCTCD = '1110411' \n");
		sbSql.append("          AND ((B.BILL_AMOUNT + B.BILL_VAT) - NVL(C.RCP_AMT,0)) != 0 \n");
		sbSql.append("        GROUP BY A.MAIN_UPJANG) B \n");
		sbSql.append("       --당월매출 \n");
		sbSql.append("     ,(SELECT A.MAIN_UPJANG AS UPJANG \n");
		sbSql.append("            , SUM(B.BILL_AMOUNT + B.BILL_VAT) AS AMT2 \n");
		sbSql.append("         FROM FMS_UPJANG A, HLDC_FM_BILL B \n");
		sbSql.append("        WHERE A.UPJANG = B.UPJANG \n");
		if (! sUpjang.equals(""))
			sbSql.append("          AND A.MAIN_UPJANG = " + sUpjang + " \n");
		// (#29877)2009-08-18 추가 수정 시작. 
		// 내용 : 매출 계산서를 해당월 다음달 계산서를 먼저 발행했을 경우를 대비 하여 수정(ADD_MONTHS(날짜,1))를 통하여 최고 2달치 까지 끌고 오게 수정.
		//       기존 수정 된 한달 후 조회 에서 최고 2달까지 미리 발행 한 것들을 조회 가능 하게 수정. 입금 부분은 적용 하지 않았음. 향후 입금 부분이 이상하다고 할때는 아래 입금 부분도 동일하게 적용 하면 됨.
		//       관련 화면 : FMO00570V,FMO00550V,FMO00530V,MAK10170S,FMZ_CREDIT_INFO_T001.jsp 
		// sbSql.append("          AND B.BILL_DATE <= GREATEST('" + sDate + "', TO_CHAR(ADD_MONTHS(LAST_DAY(SYSDATE),1),'YYYYMMDD')) \n");
		sbSql.append("          AND B.BILL_DATE BETWEEN SUBSTR('" + sDate + "',1,6)||'01' AND '" + sDate + "' \n");		
		// (#29877)2009-08-18 추가 수정 끝.
		sbSql.append("          AND B.CANCEL_FLAG = 'N' \n");
		sbSql.append("          AND B.DCGUBUN = '1' \n");
		sbSql.append("          AND B.ACCTCD = '1110411' \n");
		sbSql.append("          AND (B.BILL_AMOUNT + B.BILL_VAT) != 0 \n");
		sbSql.append("        GROUP BY A.MAIN_UPJANG) C \n");
		sbSql.append("       --당월입금 \n");
		sbSql.append("     ,(SELECT A.MAIN_UPJANG AS UPJANG \n");
		sbSql.append("            , SUM(B.AMOUNT) AS AMT3 \n");
		sbSql.append("         FROM FMS_UPJANG A, HLDC_FM_RECEIPT B \n");
		sbSql.append("        WHERE A.UPJANG = B.UPJANG \n");
		if (! sUpjang.equals(""))
			sbSql.append("          AND A.MAIN_UPJANG = " + sUpjang + " \n");
		sbSql.append("          AND B.RECEIPT_DATE BETWEEN SUBSTR('" + sDate + "',1,6)||'01' AND '" + sDate + "' \n");
		sbSql.append("          AND B.DCGUBUN = '2' \n");
		sbSql.append("          AND B.ACCTCD = '1110411' \n");
		sbSql.append("          AND B.AMOUNT != 0 \n");
		sbSql.append("        GROUP BY A.MAIN_UPJANG) D \n");
		sbSql.append(" WHERE A.UPJANG = B.UPJANG(+) \n");
		sbSql.append("   AND A.UPJANG = C.UPJANG(+) \n");
		sbSql.append("   AND A.UPJANG = D.UPJANG(+) \n");		
		if (! sSabun.equals(""))	                                                      //CSR RFC Number : 25276
			sbSql.append("   AND A.PART_SALES_SABUN = '" + sSabun + "' \n");		      //영업사원별 조회 조건 추가 / 수정자:노규완 / 수정일:2009-03-10
		if (sUpjang.equals(""))
			sbSql.append("   AND A.MAIN_UPJANG = A.UPJANG \n");
		else
			sbSql.append("   AND A.UPJANG = " + sUpjang + " \n");
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
