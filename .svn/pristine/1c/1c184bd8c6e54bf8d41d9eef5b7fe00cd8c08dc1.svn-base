<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 메뉴관리/자재관리/기획자재 사용현황 조회
■ 프로그램ID   : FSI00091V_T001.jsp
■ 프로그램명   : 자재별 사용현황조회-상세내역
■ 작성일자     : 2008.02.12
■ 작성자       : 박지영
■ 이력관리     : 2008.02.12
1)박은규 2012-11-05 CSR#(CH201210_00143) 요청자:박현정(FS기획팀)
조회조건에 센터, 팀 조건 추가
설정량 항목삭제, FS사업부만 조회(식재영업, 외식 등 제외)
신청량,입고량 없어도 조회
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
	
		//FileLog.println("d:\\aaa.txt", ds_input);
		
		/*
		ds_input.SetColumn(0,"DUTY_SEQ",ds_list.GetColumn(nRow,"DUTY_SEQ"));
		ds_input.SetColumn(0,"ITEM_CODE",ds_list.GetColumn(nRow,"ITEM_CODE"));
		ds_input.SetColumn(0,"START_DATE",ds_list.GetColumn(nRow,"START_DATE"));
		ds_input.SetColumn(0,"END_DATE",ds_list.GetColumn(nRow,"END_DATE"));
		*/
	
		String strDutySEQ 	= nullToBlank(ds_input.getString(0, "DUTY_SEQ"));
		String strItemCode	= nullToBlank(ds_input.getString(0, "ITEM_CODE"));
		String strStartDate	= nullToBlank(ds_input.getString(0, "START_DATE"));
		String strEndDate	= nullToBlank(ds_input.getString(0, "END_DATE"));
		//============================================================================================
		//(2012-11-05 추가) 시작
		// 박은규 2012-11-05 CSR#(CH201210_00143) 요청자:박현정(FS기획팀)
		// 조회조건에 센터, 팀 조건 추가
		//============================================================================================
		String strCustCd    = nullToBlank(ds_input.getString(0, "CUSTCD"));
		String strCenterCode= nullToBlank(ds_input.getString(0, "CENTER_CODE"));
		String strTmCd		= nullToBlank(ds_input.getString(0, "TM_CD"));
		//============================================================================================
		//(2012-11-05 추가) 끝
		//============================================================================================
		String strExcept	= in_vl.getString("strExcept");

		//out 데이타
		DataSet ds_list;

		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		//sbSql.append("-- 자재별 사용현황 조회 디테일 \n");
		sbSql.append("SELECT \n");
		sbSql.append("       C.TM_CD, \n");
		sbSql.append("       C.TM_NAME, \n");
		sbSql.append("       C.JOB_CD, \n");
		sbSql.append("       C.JOB_NAME, \n");
		sbSql.append("       C.SUB_JOB_CD, \n");
		sbSql.append("       C.SUB_JOB_NAME, \n");
		sbSql.append("       C.UPJANG, \n");
		sbSql.append("       C.UPJANGNM, \n");
		if (strExcept.equals("TRUE"))
			sbSql.append("       NVL(NEED_QTY,0) NEED_QTY, --식단등록량  [수정] \n");
		else
			sbSql.append("       NULL AS NEED_QTY, --식단등록량  [수정] \n");
		//sbSql.append("       NVL(PR_QTY,0) PR_QTY, --신청량 \n");
		sbSql.append("       NVL(TRANS_QTY,0) TRANS_QTY --입고량 \n");
		//============================================================================================
		//(2012-11-05 삭제) 시작
		// 박은규 2012-11-05 CSR#(CH201210_00143) 요청자:박현정(FS기획팀)
		// 설정량 항목삭제
		//============================================================================================
		//sbSql.append("       F.DUTY_QTY, --설정량 \n");
		//sbSql.append("       DECODE(DUTY_QTY, 0, 0, ROUND(NVL(PR_QTY,0) / DUTY_QTY * 100,2)) PR_RATE, --신청비율 \n");
		//sbSql.append("       DECODE(DUTY_QTY, 0, 0, ROUND(NVL(TRANS_QTY,0) / DUTY_QTY * 100,2)) TRANS_RATE --입고비율 \n");
		//============================================================================================
		//(2012-11-05 삭제) 끝
		//============================================================================================
		sbSql.append("  FROM \n");
		//sbSql.append("       FSI_DUTY_MST A \n");
		//sbSql.append("      ,HLDC_PO_ITEM_MST B  --[수정] \n");
		sbSql.append("       MAC_UPJANG_V C \n");
		sbSql.append("      ,(SELECT CODE FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'MA0045' AND USE_YN = 'Y') C1 \n");
		if (strExcept.equals("TRUE"))
		{
			sbSql.append("      ,( \n");
			sbSql.append("        SELECT A.UPJANG, B.ITEM_CODE \n");
			sbSql.append("              ,SUM(ROUND(B.NEED_QTY*DECODE(D.CAFE_YN,'Y',C.EXPECT_SALE_QTY,DECODE(D.CATER_YN,'Y',C.EXPECT_SALE_QTY,A.EXPECT_MEAL_QTY))/E.KG_CONVERT_RATE/1000,2)) NEED_QTY \n");
			sbSql.append("          FROM FSM_REAL_MENU_MST A \n");
			sbSql.append("              ,FSM_REAL_RECIPE_ITEM B \n");
			sbSql.append("              ,FSM_REAL_RECIPE_MST C \n");
			sbSql.append("              ,FSA_HALL_MST D \n");
			sbSql.append("              ,HLDC_PO_ITEM_MST E \n");
			sbSql.append("         WHERE A.UPJANG = C.UPJANG \n");
			sbSql.append("           AND A.MENU_CD = C.MENU_CD \n");
			sbSql.append("           AND C.UPJANG = B.UPJANG \n");
			sbSql.append("           AND C.MENU_CD = B.MENU_CD \n");
			sbSql.append("           AND C.RECIPE_CD = B.RECIPE_CD \n");
			sbSql.append("           AND A.UPJANG = D.UPJANG \n");
			sbSql.append("           AND A.HALL_CD = D.HALL_CD \n");
			sbSql.append("           AND B.ITEM_CODE = E.ITEM_CODE \n");
			sbSql.append("           AND B.NEED_DATE BETWEEN '" + strStartDate + "' AND '" + strEndDate + "' \n");
			sbSql.append("           AND B.ITEM_CODE = '" + strItemCode + "' \n");
			//sbSql.append("           AND EXISTS (SELECT 1 FROM FSI_DUTY_SET C WHERE C.UPJANG = A.UPJANG AND C.DUTY_SEQ = '" + strDutySEQ + "') \n");
			sbSql.append("         GROUP BY A.UPJANG, B.ITEM_CODE \n");
			sbSql.append("       ) D \n");
		}
		sbSql.append("      ,(SELECT CENTER_CODE, CUSTCD, ITEM_CODE, UPJANG \n");
		//sbSql.append("             , SUM(DUTY_QTY) AS DUTY_QTY \n");
		sbSql.append("             , SUM(PR_QTY) AS PR_QTY \n");
		sbSql.append("             , SUM(TRANS_QTY) AS TRANS_QTY \n");
		sbSql.append("          FROM \n");
		sbSql.append("( \n");
/*
		sbSql.append("        SELECT A.CENTER_CODE, A.CUSTCD, A.ITEM_CODE, B.UPJANG AS UPJANG \n");
		sbSql.append("             , B.DUTY_QTY \n");
		sbSql.append("             , 0 PR_QTY \n");
		sbSql.append("             , 0 AS TRANS_QTY \n");
		sbSql.append("          FROM FSI_DUTY_MST A, FSI_DUTY_SET B \n");
		sbSql.append("         WHERE A.DUTY_SEQ = B.DUTY_SEQ \n");
		sbSql.append("           AND A.DUTY_SEQ = " + strDutySEQ + " \n");
		sbSql.append("         UNION ALL \n");
*/
/*
		sbSql.append("        SELECT CENTER_CODE, CUSTCD, ITEM_CODE, RC_UPJANG AS UPJANG \n");
		sbSql.append("             , 0 DUTY_QTY \n");
		sbSql.append("             , SUM(PR_QTY) PR_QTY \n");
		sbSql.append("             , 0 AS TRANS_QTY \n");
		sbSql.append("          FROM HLDC_PO_PR \n");
		sbSql.append("         WHERE RC_MU_CD = 'YA' \n");
		sbSql.append("           AND LINE_STATUS >= '004' \n");
		sbSql.append("           AND SUBINV_CODE LIKE 'C%' \n");
		sbSql.append("           AND ITEM_CODE = '" + strItemCode + "'  -- [INPUT:마스터.ITEM_CODE] \n");
		sbSql.append("           AND NEED_DATE BETWEEN '" + strStartDate + "' AND '" + strEndDate + "' \n");
		if (! strCenterCode.equals(""))
			sbSql.append("           AND CENTER_CODE = " + strCenterCode + " \n");
		sbSql.append("           AND CUSTCD = " + strCustCd + " \n");
		sbSql.append("         GROUP BY CENTER_CODE, CUSTCD, ITEM_CODE, RC_UPJANG \n");
		sbSql.append("         UNION ALL \n");
*/
		sbSql.append("        SELECT A.CENTER_CODE, A.CUSTCD, A.ITEM_CODE, A.TRANS_UPJANG AS UPJANG\n");
		sbSql.append("             , 0 DUTY_QTY \n");
		sbSql.append("             , 0 AS PR_QTY \n");
		sbSql.append("             , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * A.TRANS_QTY) AS TRANS_QTY \n");
		sbSql.append("          FROM HLDC_PO_TRANSACTION A \n");
		sbSql.append("         WHERE A.TRANS_MU_CD = '2002' \n");
		sbSql.append("           AND A.SUBINV_CODE LIKE 'C%' \n");
		//TRANS_TYPE = 'I001':정상입고(PO)/반품출고(INV)  OR  SOURCE_TYE = 'PO':센터인수입고/센터반송이관출고
		//sbSql.append("           AND TRANS_TYPE = 'I001' \n");
		sbSql.append("           AND (A.TRANS_TYPE = 'I001' OR (TRANS_TYPE LIKE '_002' AND SOURCE_TYPE = 'PO')) \n");
		sbSql.append("           AND A.ITEM_CODE = '" + strItemCode + "' \n");
		sbSql.append("           AND A.TRANS_DATE BETWEEN '" + strStartDate + "' AND '" + strEndDate + "' \n");
		if (! strCenterCode.equals(""))
			sbSql.append("           AND A.CENTER_CODE = " + strCenterCode + " \n");
		sbSql.append("           AND A.CUSTCD = " + strCustCd + " \n");
		sbSql.append("         GROUP BY A.CENTER_CODE, A.CUSTCD, A.ITEM_CODE, A.TRANS_UPJANG \n");
		sbSql.append(") \n");
		sbSql.append("         GROUP BY CENTER_CODE, CUSTCD, ITEM_CODE, UPJANG \n");
		sbSql.append("       ) F \n");
		//sbSql.append(" WHERE F.UPJANG      = C.UPJANG \n");
		//sbSql.append("   AND F.UPJANG      = D.UPJANG(+) \n");
		//sbSql.append("   AND F.ITEM_CODE   = D.ITEM_CODE(+) \n");
		//sbSql.append("   AND A.ITEM_CODE   = B.ITEM_CODE --[수정] \n");
		//sbSql.append("   AND A.ITEM_CODE   = F.ITEM_CODE(+) \n");
		//sbSql.append("   AND A.CENTER_CODE = F.CENTER_CODE(+) \n");
		//sbSql.append("   AND A.CUSTCD      = F.CUSTCD(+) \n");
		//sbSql.append("   AND A.DUTY_SEQ    = " + strDutySEQ + " \n");
		sbSql.append(" WHERE C.TM_CD = C1.CODE \n");
		if (! strTmCd.equals(""))
			sbSql.append("   AND C.TM_CD = '" + strTmCd + "' \n");
		if (strExcept.equals("TRUE"))
			sbSql.append("   AND C.UPJANG = D.UPJANG(+) \n");
		sbSql.append("   AND C.UPJANG = F.UPJANG(+) \n");
		sbSql.append("   AND C.OPEN_DATE <= '" + strEndDate + "' \n");
		sbSql.append("   AND NVL(C.CLOSE_DATE,'99999999') >= '" + strStartDate + "' \n");
		sbSql.append(" ORDER BY C.TM_CD, C.JOB_CD, C.JOB_CD, C.UPJANG \n");

out_vl.add("fa_Sql", sbSql.toString());
		System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		DataSet ds_Detail = this.makeDataSet(rs, "ds_Detail");
		
		rs.close();
		pstmt.close();

		/**종료**/
		out_dl.add(ds_Detail);
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