<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 메뉴관리/자재관리/기획자재 사용현황 조회
■ 프로그램ID   : FSI00093V_T001.jsp
■ 프로그램명   : 분석결과(상세)
■ 작성일자     : 2012-11-05
■ 작성자       : 박은규
■ 이력관리     : 
1)박은규 2012-11-05 CSR#(CH201210_00143) 요청자:박현정(FS기획팀)
최초 작성
2)박은규 2013-04-18 CSR#(CH201304_00072) 요청자:박현정(FS기획팀)
사업장 조회조건 추가
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
		//FileLog.println("d:\\aaa.txt", ds_cond
		
		String strFromDt 	= nullToBlank(ds_Cond.getString(0, "FROM_DT"));
		String strToDt		= nullToBlank(ds_Cond.getString(0, "TO_DT"));
		String strCenterCode= nullToBlank(ds_Cond.getString(0, "CENTER_CODE"));
		String strTmCd		= nullToBlank(ds_Cond.getString(0, "TM_CD"));
		//============================================================================================
		//(2013-04-18 추가) 시작
		// 박은규 2013-04-18 CSR#(CH201304_00072) 요청자:박현정(FS기획팀)
		// 사업장 조회조건 추가
		//============================================================================================
		String strUpjang	= nullToBlank(ds_Cond.getString(0, "UPJANG"));
		//============================================================================================
		//(2013-04-18 추가) 끝
		//============================================================================================
		String strType		= nullToBlank(ds_Cond.getString(0, "STYPE"));

		//out 데이타
		DataSet ds_List, ds_TmList;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		//팀조회
		sbSql.append("SELECT CODE, CODE_NAME FROM SCC_COMMON_CODE \n");
		sbSql.append(" WHERE GROUP_CODE = 'MA0045' AND USE_YN = 'Y' \n");
		sbSql.append(" ORDER BY SORT_SEQ, CODE \n");
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_TmList = this.makeDataSet(rs, "ds_TmList");
		rs.close();
		pstmt.close();
		
		//내역조회
		sbSql.delete(0, sbSql.length());
		sbSql.append("WITH TR_TBL AS \n");
		sbSql.append("( \n");
		sbSql.append("        SELECT /*+ ORDERED USE_NL(B A) */ \n");
		sbSql.append("               A.CENTER_CODE, A.CUSTCD, A.ITEM_CODE, B.START_DATE \n");
		sbSql.append("             , A.TRANS_UPJANG AS UPJANG \n");
		sbSql.append("             , DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * A.TRANS_QTY AS TRANS_QTY \n");
		sbSql.append("             , DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * A.TRANS_MAMOUNT AS TRANS_MAMOUNT \n");
		sbSql.append("          FROM FSI_DUTY_MST B \n");
		sbSql.append("             , HLDC_PO_TRANSACTION A \n");
		sbSql.append("         WHERE A.CENTER_CODE = B.CENTER_CODE \n");
		sbSql.append("           AND A.CUSTCD = B.CUSTCD \n");
		sbSql.append("           AND A.ITEM_CODE = B.ITEM_CODE \n");
		//sbSql.append("           AND A.TRANS_DATE BETWEEN B.START_DATE AND B.END_DATE \n");
		sbSql.append("           AND A.TRANS_DATE BETWEEN GREATEST(B.START_DATE,'" + strFromDt + "') AND LEAST(B.END_DATE,'" + strToDt + "') \n");
		if (! strCenterCode.equals(""))
			sbSql.append("           AND B.CENTER_CODE = " + strCenterCode + " \n");
/*
		sbSql.append("           AND ( (B.START_DATE BETWEEN '" + strFromDt + "' AND '" + strToDt + "')  -- [INPUT:기간] \n");
		sbSql.append("                                OR (B.END_DATE BETWEEN '" + strFromDt + "' AND '" + strToDt + "')  -- [INPUT:기간] \n");
		sbSql.append("                                OR (B.START_DATE <= '" + strFromDt + "' AND B.END_DATE >= '" + strToDt + "') )  -- [INPUT:기간] \n");
*/
		sbSql.append("           AND B.START_DATE <= '" + strToDt + "' AND B.END_DATE >= '" + strFromDt + "' \n");
		sbSql.append("           AND A.TRANS_MU_CD = '2002' \n");
		//============================================================================================
		//(2013-04-18 추가) 시작
		// 박은규 2013-04-18 CSR#(CH201304_00072) 요청자:박현정(FS기획팀)
		// 사업장 조회조건 추가
		//============================================================================================
		if (! strUpjang.equals(""))
			sbSql.append("           AND A.TRANS_UPJANG = " + strUpjang + " \n");
		//============================================================================================
		//(2013-04-18 추가) 끝
		//============================================================================================
		sbSql.append("           AND (A.TRANS_TYPE = 'I001' OR (A.TRANS_TYPE LIKE '_002' AND A.SOURCE_TYPE = 'PO')) \n");
		sbSql.append(") \n");
		sbSql.append("SELECT A.CENTER_CODE \n");
		sbSql.append("     , (SELECT Z.CENTER_NAME FROM HLDC_PO_CENTER Z WHERE Z.CENTER_CODE = A.CENTER_CODE) AS CENTER_NAME \n");
		sbSql.append("     , A.ITEM_CODE \n");
		sbSql.append("     , B.ITEM_NAME \n");
		sbSql.append("     , B.ITEM_SIZE \n");
		sbSql.append("     , B.PO_UOM \n");
		//팀별 실적
		//for (int iRow=0; iRow<ds_TmList.getRowCount(); iRow++)
		for (int iRow=0; iRow<10; iRow++)
		{
			if (strType.equals("QTY"))
			{
				if (iRow < ds_TmList.getRowCount())
					sbSql.append("     , SUM(DECODE(C.TM_CD, '" + ds_TmList.getString(iRow,"CODE") + "', C.TRANS_QTY, 0)) AS TRANS_QTY" + iRow + " \n");
				else
					sbSql.append("     , 0 AS TRANS_QTY" + iRow + " \n");
				sbSql.append("     , 0 AS TRANS_MAMOUNT" + iRow + " \n");
			}
			else
			{
				sbSql.append("     , 0 AS TRANS_QTY" + iRow + " \n");
				if (iRow < ds_TmList.getRowCount())
					sbSql.append("     , SUM(DECODE(C.TM_CD, '" + ds_TmList.getString(iRow,"CODE") + "', C.TRANS_MAMOUNT, 0)) AS TRANS_MAMOUNT" + iRow + " \n");
				else
					sbSql.append("     , 0 AS TRANS_MAMOUNT" + iRow + " \n");
			}
		}
		//
		if (strType.equals("QTY"))
		{
			sbSql.append("     , SUM(C.TRANS_QTY) AS TRANS_QTY \n");
			sbSql.append("     , A.LIMIT_DUTY_QTY \n");
			sbSql.append("     , DECODE(A.LIMIT_DUTY_QTY, 0, 0, ROUND(NVL(SUM(C.TRANS_QTY),0) / A.LIMIT_DUTY_QTY * 100, 2)) AS PLAN_RATE \n");
			sbSql.append("     , NULL AS REASON \n");
			sbSql.append("     , 0 AS TRANS_MAMOUNT \n");
			sbSql.append("     , 0 AS PLAN_PRICE \n");
			sbSql.append("     , 0 AS MARKET_PRICE \n");
			sbSql.append("     , 0 AS PRICE_RATE \n");
			sbSql.append("     , 0 AS PRICE_DIFF \n");
			sbSql.append("     , 0 AS PLAN_AMOUNT \n");
			sbSql.append("     , 0 AS PLAN_SAVE \n");
			sbSql.append("     , 0 AS REAL_SAVE \n");
		}
		else
		{
			sbSql.append("     , 0 AS TRANS_QTY \n");
			sbSql.append("     , 0 AS TOT_DUTY_QTY \n");
			sbSql.append("     , 0 AS PLAN_RATE \n");
			sbSql.append("     , NULL AS REASON \n");
			sbSql.append("     , NVL(SUM(C.TRANS_MAMOUNT), 0) AS TRANS_MAMOUNT \n");
			sbSql.append("     , DECODE(NVL(SUM(C.TRANS_QTY),0), 0, 0, ROUND(SUM(C.TRANS_MAMOUNT) / SUM(C.TRANS_QTY))) AS PLAN_PRICE \n");
			sbSql.append("     , NVL(A.MARKET_PRICE,0) AS MARKET_PRICE \n");
			sbSql.append("     , DECODE(NVL(A.MARKET_PRICE,0), 0, 0, ROUND(DECODE(NVL(SUM(C.TRANS_QTY),0), 0, 0, ROUND(SUM(C.TRANS_MAMOUNT) / SUM(C.TRANS_QTY))) / NVL(A.MARKET_PRICE,0) * 100, 2)) AS PRICE_RATE \n");
			sbSql.append("     , NVL(A.MARKET_PRICE,0) - DECODE(NVL(SUM(C.TRANS_QTY),0), 0, 0, ROUND(SUM(C.TRANS_MAMOUNT) / SUM(C.TRANS_QTY))) AS PRICE_DIFF \n");
			sbSql.append("     , A.LIMIT_DUTY_QTY * DECODE(NVL(SUM(C.TRANS_QTY),0), 0, 0, ROUND(SUM(C.TRANS_MAMOUNT) / SUM(C.TRANS_QTY))) AS PLAN_AMOUNT \n");
			sbSql.append("     , A.LIMIT_DUTY_QTY * (A.MARKET_PRICE - DECODE(NVL(SUM(C.TRANS_QTY),0), 0, 0, ROUND(SUM(C.TRANS_MAMOUNT) / SUM(C.TRANS_QTY)))) AS PLAN_SAVE \n");
			sbSql.append("     , SUM(C.TRANS_QTY) * (A.MARKET_PRICE - DECODE(NVL(SUM(C.TRANS_QTY),0), 0, 0, ROUND(SUM(C.TRANS_MAMOUNT) / SUM(C.TRANS_QTY)))) AS REAL_SAVE \n");
		}
		sbSql.append("  FROM FSI_DUTY_MST A \n");
		sbSql.append("     , HLDC_PO_ITEM_MST B \n");
		sbSql.append("     , (SELECT A.*, C.TM_CD \n");
		sbSql.append("          FROM TR_TBL A, HLDC_ST_UPJANG B, HLDC_SC_DEPT C \n");
		sbSql.append("             ,(SELECT CODE FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'MA0045' AND USE_YN = 'Y') D \n");
		sbSql.append("         WHERE A.UPJANG = B.UPJANG \n");
		sbSql.append("           AND B.DEPT_ID = C.DEPT_ID \n");
		sbSql.append("           AND C.TM_CD = D.CODE \n");
		if (! strTmCd.equals(""))
			sbSql.append("           AND C.TM_CD = '" + strTmCd + "' \n");
		sbSql.append("       ) C \n");
		sbSql.append(" WHERE A.ITEM_CODE   = B.ITEM_CODE \n");
		sbSql.append("   AND A.CENTER_CODE = C.CENTER_CODE(+) \n");
		sbSql.append("   AND A.CUSTCD      = C.CUSTCD(+) \n");
		sbSql.append("   AND A.ITEM_CODE   = C.ITEM_CODE(+) \n");
		//sbSql.append("   AND A.DUTY_SEQ   = C.DUTY_SEQ \n");
		if (! strCenterCode.equals(""))
			sbSql.append("   AND A.CENTER_CODE = " + strCenterCode + " \n");
/*
		sbSql.append("   AND ( (A.START_DATE BETWEEN '" + strFromDt + "' AND '" + strToDt + "')  -- [INPUT:기간] \n");
		sbSql.append("                       OR (A.END_DATE BETWEEN '" + strFromDt + "' AND '" + strToDt + "')  -- [INPUT:기간] \n");
		sbSql.append("                       OR (A.START_DATE <= '" + strFromDt + "' AND A.END_DATE >= '" + strToDt + "') )  -- [INPUT:기간] \n");
*/
		sbSql.append("   AND A.START_DATE <= '" + strToDt + "' AND A.END_DATE >= '" + strFromDt + "' \n");
		sbSql.append(" GROUP BY A.CENTER_CODE \n");
		sbSql.append("        , A.ITEM_CODE \n");
		sbSql.append("        , B.ITEM_NAME \n");
		sbSql.append("        , B.ITEM_SIZE \n");
		sbSql.append("        , B.PO_UOM \n");
		sbSql.append("        , A.LIMIT_DUTY_QTY \n");
		sbSql.append("        , A.MARKET_PRICE \n");
/*		
		if (strType.equals("QTY"))
			sbSql.append("HAVING SUM(C.TRANS_QTY) > 0 \n");
		else
			sbSql.append("HAVING SUM(C.TRANS_MAMOUNT) > 0 \n");
*/

		out_vl.add("fa_Sql", sbSql.toString());

		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_List = this.makeDataSet(rs, "ds_List");

		rs.close();
		pstmt.close();

		/**종료**/
		out_dl.add(ds_TmList);
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