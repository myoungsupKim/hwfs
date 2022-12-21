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
		DataSet ds_cond     = in_dl.get("ds_cond");
		
		String YY           = nullToBlank(ds_cond.getString(0, "YY"));
		String QT		    = nullToBlank(ds_cond.getString(0, "QT"));
		String CENTER_CODE  = nullToBlank(ds_cond.getString(0, "CENTER_CODE"));
		String TM_CD		= nullToBlank(ds_cond.getString(0, "TM_CD"));
		String UPJANG	    = nullToBlank(ds_cond.getString(0, "UPJANG"));
		String CLOSED	    = nullToBlank(ds_cond.getString(0, "CLOSED"));
		String STYPE		= nullToBlank(ds_cond.getString(0, "STYPE"));
		int iYy = 0;
		int iQt = 0;

		//out 데이타
		DataSet ds_list51;
		
		// 전분기 처리
		if(QT.equals("1")) {
			iYy = Integer.parseInt(YY) - 1;
			iQt = 4;
		} else {
			iYy = Integer.parseInt(YY);
			iQt = Integer.parseInt(QT) - 1;
		}
		
		
		
		//sql문 버퍼생성
		
		StringBuffer sbSql = new StringBuffer();
		
		// 현재분기
		sbSql.delete(0, sbSql.length());
        sbSql.append("SELECT '"+YY+"' || LPAD(1 + (QT * 3), 2, '0') || '01' AS START_DD                                                                                           \n");
        sbSql.append("     , '"+YY+"' || LPAD(3 + (QT * 3), 2, '0') || TO_CHAR(LAST_DAY(TO_DATE('2015'||LPAD(1 + (QT * 3), 2, '0'), 'YYYYMM')), 'DD') AS END_DD                   \n");
        sbSql.append("  FROM (SELECT "+QT+" - 1 AS QT                                                                                                                             \n");
        sbSql.append("          FROM DUAL)                                                                                                                                        \n");
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery();
		rs.next();
		
		String aStartDd = rs.getString("START_DD");
		String aEndDd = rs.getString("END_DD");
		
		rs.close();
		pstmt.close();

        
		// 전분기
		sbSql.delete(0, sbSql.length());
        sbSql.append("SELECT '"+iYy+"' || LPAD(1 + (QT * 3), 2, '0') || '01' AS START_DD                                                                                             \n");
        sbSql.append("     , '"+iYy+"' || LPAD(3 + (QT * 3), 2, '0') || TO_CHAR(LAST_DAY(TO_DATE('2015'||LPAD(1 + (QT * 3), 2, '0'), 'YYYYMM')), 'DD') AS END_DD                     \n");
        sbSql.append("  FROM (SELECT "+iQt+" - 1 AS QT                                                                                                                                  \n");
        sbSql.append("          FROM DUAL)                                                                                                                                        \n");
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery();
		rs.next();
		
		String bStartDd = rs.getString("START_DD");
		String bEndDd = rs.getString("END_DD");
		
		rs.close();
		pstmt.close();
		
		sbSql.delete(0, sbSql.length());
        sbSql.append("SELECT B.TM_NAME                                                                                                                                                                \n");
        sbSql.append("    , B.JOB_NAME                                                                                                                                                                   \n");
        sbSql.append("    , B.SUB_JOB_NAME                                                                                                                                                               \n");
        sbSql.append("    , B.UPJANG                                                                                                                                                                     \n");
        sbSql.append("    , B.UPJANGNM                                                                                                                                                                   \n");
        sbSql.append("    , NVL(C.U_PLN_AMT, 0) AS PU_PLN_AMT                                                                                                                                            \n");          
        sbSql.append("    , NVL(C.M_PLN_AMT, 0) AS PM_PLN_AMT                                                                                                                                            \n");         
        sbSql.append("    , NVL(C.U_ALL_AMT, 0) AS PU_ALL_AMT                                                                                                                                            \n");         
        sbSql.append("    , NVL(C.M_ALL_AMT, 0) AS PM_ALL_AMT                                                                                                                                            \n");         
        sbSql.append("    , DECODE(NVL(C.U_ALL_AMT, 0), 0, 0, ROUND(C.U_PLN_AMT / C.U_ALL_AMT * 100, 2)) AS PU_PLN_RATE                                                                                  \n");
        sbSql.append("    , DECODE(NVL(C.M_ALL_AMT, 0), 0, 0, ROUND(C.M_PLN_AMT / C.M_ALL_AMT * 100, 2)) AS PM_PLN_RATE                                                                                  \n");
        sbSql.append("    , A.U_PLN_AMT                                                                                                                                                                  \n");
        sbSql.append("    , A.M_PLN_AMT                                                                                                                                                                  \n");
        sbSql.append("    , A.U_ALL_AMT                                                                                                                                                                  \n");
        sbSql.append("    , A.M_ALL_AMT                                                                                                                                                                  \n");
        sbSql.append("    , DECODE(A.U_ALL_AMT, 0, 0, ROUND(A.U_PLN_AMT / A.U_ALL_AMT * 100, 2)) AS U_PLN_RATE                                                                                           \n");
        sbSql.append("    , DECODE(A.M_ALL_AMT, 0, 0, ROUND(A.M_PLN_AMT / A.M_ALL_AMT * 100, 2)) AS M_PLN_RATE                                                                                           \n");
        sbSql.append("    , DECODE(A.U_ALL_AMT, 0, 0, ROUND(A.U_PLN_AMT / A.U_ALL_AMT * 100, 2)) - DECODE(NVL(C.U_ALL_AMT, 0), 0, 0, ROUND(C.U_PLN_AMT / C.U_ALL_AMT * 100, 2)) AS U_PLN_RATE_DIFF       \n");                                                                         
        sbSql.append("    , DECODE(A.M_ALL_AMT, 0, 0, ROUND(A.M_PLN_AMT / A.M_ALL_AMT * 100, 2)) - DECODE(NVL(C.M_ALL_AMT, 0), 0, 0, ROUND(C.M_PLN_AMT / C.M_ALL_AMT * 100, 2)) AS M_PLN_RATE_DIFF       \n");
        sbSql.append(" FROM (                                                                                                                                                                            \n");
        sbSql.append("       SELECT UPJANG                                                                                                                                                               \n");
        sbSql.append("            , SUM(U_PLN_AMT) AS U_PLN_AMT                                                                                                                                          \n");
        sbSql.append("            , SUM(U_ALL_AMT) AS U_ALL_AMT                                                                                                                                          \n");
        sbSql.append("            , SUM(U_REAL_SAVE) AS U_REAL_SAVE                                                                                                                                      \n");
        sbSql.append("            , SUM(M_PLN_AMT) AS M_PLN_AMT                                                                                                                                          \n");
        sbSql.append("            , SUM(M_ALL_AMT) AS M_ALL_AMT                                                                                                                                          \n");
        sbSql.append("            , SUM(M_REAL_SAVE) AS M_REAL_SAVE                                                                                                                                      \n");
        sbSql.append("         FROM (                                                                                                                                                                    \n");
        sbSql.append("               SELECT A.UPJANG                                                                                                                                                     \n");
        sbSql.append("                    , CASE WHEN NVL(A.DUTY_YN, 'N') = 'Y' AND NVL(B.USE_YN, 'N') = 'Y' THEN SUM(A.TRANS_UAMOUNT) ELSE 0 END AS U_PLN_AMT                                                                                  \n");
        sbSql.append("                    , CASE WHEN NVL(A.DUTY_YN, 'N') = 'Y' AND NVL(B.USE_YN, 'N') = 'Y' THEN SUM(A.TRANS_MAMOUNT) ELSE 0 END AS M_PLN_AMT                                                                                  \n");
        sbSql.append("                    , SUM(A.TRANS_UAMOUNT) AS U_ALL_AMT                                                                                                                            \n");
        sbSql.append("                    , SUM(A.TRANS_MAMOUNT) AS M_ALL_AMT                                                                                                                            \n");
        sbSql.append("                    , CASE WHEN NVL(A.DUTY_YN, 'N') = 'Y' AND NVL(B.USE_YN, 'N') = 'Y' THEN SUM(A.TRANS_QTY) * (NVL(B.MD_PRICE,0) - NVL(B.MARKET_PRICE, 0)) ELSE 0 END AS U_REAL_SAVE                \n");
        sbSql.append("                    , CASE WHEN NVL(A.DUTY_YN, 'N') = 'Y' AND NVL(B.USE_YN, 'N') = 'Y' THEN SUM(A.TRANS_QTY) * (NVL(B.MD_PRICE,0) - NVL(B.MARKET_PRICE, 0)) ELSE 0 END AS M_REAL_SAVE                \n");
        sbSql.append("                 FROM FSI_DUTY_DAILY_SUM A                                                                                                                                         \n");
        sbSql.append("                    , FSI_DUTY_MST B                                                                                                                                               \n");
        sbSql.append("                WHERE A.CENTER_CODE = B.CENTER_CODE(+)                                                                                                                             \n");
        sbSql.append("                  AND A.CUSTCD = B.CUSTCD(+)                                                                                                                                       \n");
        sbSql.append("                  AND A.ITEM_CODE = B.ITEM_CODE(+)                                                                                                                                 \n");
        sbSql.append("                  AND A.START_DATE = B.START_DATE(+)                                                                                                                               \n");
        sbSql.append("	                AND A.TRANS_DATE BETWEEN '" + aStartDd + "' AND '" + aEndDd + "'                                                                                            \n");
        sbSql.append("	                AND B.START_DATE(+) <= '" + aEndDd + "' AND B.END_DATE(+) >= '" + aStartDd + "'                                                               \n");
        sbSql.append("                  AND B.USE_YN(+) = 'Y'                                                                                                                                            \n");
        sbSql.append("                GROUP BY A.UPJANG                                                                                                                                                  \n");
        sbSql.append("                       , A.DUTY_YN                                                                                                                                                 \n");
        sbSql.append("                       , B.MARKET_PRICE                                                                                                                                                \n");        
        sbSql.append("                       , B.MD_PRICE                                                                                                                                                \n");
        sbSql.append("                       , NVL(B.USE_YN, 'N')                                                                                                                                        \n");        
        sbSql.append("              )                                                                                                                                                                    \n");
        sbSql.append("        GROUP BY UPJANG                                                                                                                                                            \n");
        sbSql.append("      ) A                                                                                                                                                                          \n");
        sbSql.append("    , (                                                                                                                                                                            \n");
        sbSql.append("       SELECT UPJANG                                                                                                                                                               \n");
        sbSql.append("            , SUM(U_PLN_AMT) AS U_PLN_AMT                                                                                                                                          \n");
        sbSql.append("            , SUM(U_ALL_AMT) AS U_ALL_AMT                                                                                                                                          \n");
        sbSql.append("            , SUM(U_REAL_SAVE) AS U_REAL_SAVE                                                                                                                                      \n");
        sbSql.append("            , SUM(M_PLN_AMT) AS M_PLN_AMT                                                                                                                                          \n");
        sbSql.append("            , SUM(M_ALL_AMT) AS M_ALL_AMT                                                                                                                                          \n");
        sbSql.append("            , SUM(M_REAL_SAVE) AS M_REAL_SAVE                                                                                                                                      \n");
        sbSql.append("         FROM (                                                                                                                                                                    \n");
        sbSql.append("               SELECT A.UPJANG                                                                                                                                                     \n");
        sbSql.append("                    , CASE WHEN A.DUTY_YN = 'Y' AND NVL(B.USE_YN, 'N') = 'Y' THEN SUM(A.TRANS_UAMOUNT) ELSE 0 END AS U_PLN_AMT                                                                                  \n");
        sbSql.append("                    , CASE WHEN A.DUTY_YN = 'Y' AND NVL(B.USE_YN, 'N') = 'Y' THEN SUM(A.TRANS_MAMOUNT) ELSE 0 END AS M_PLN_AMT                                                                                  \n");
        sbSql.append("                    , SUM(A.TRANS_UAMOUNT) AS U_ALL_AMT                                                                                                                            \n");
        sbSql.append("                    , SUM(A.TRANS_MAMOUNT) AS M_ALL_AMT                                                                                                                            \n");
        sbSql.append("                    , CASE WHEN A.DUTY_YN = 'Y' AND NVL(B.USE_YN, 'N') = 'Y' THEN SUM(A.TRANS_QTY) * (NVL(B.MD_PRICE,0) - NVL(B.MARKET_PRICE, 0)) ELSE 0 END AS U_REAL_SAVE                \n");
        sbSql.append("                    , CASE WHEN A.DUTY_YN = 'Y' AND NVL(B.USE_YN, 'N') = 'Y' THEN SUM(A.TRANS_QTY) * (NVL(B.MD_PRICE,0) - NVL(B.MARKET_PRICE, 0)) ELSE 0 END AS M_REAL_SAVE                \n");
        sbSql.append("                 FROM FSI_DUTY_DAILY_SUM A                                                                                                                                         \n");
        sbSql.append("                    , FSI_DUTY_MST B                                                                                                                                               \n");
        sbSql.append("                WHERE A.CENTER_CODE = B.CENTER_CODE(+)                                                                                                                             \n");
        sbSql.append("                  AND A.CUSTCD = B.CUSTCD(+)                                                                                                                                       \n");
        sbSql.append("                  AND A.ITEM_CODE = B.ITEM_CODE(+)                                                                                                                                 \n");
        sbSql.append("                  AND A.START_DATE = B.START_DATE(+)                                                                                                                               \n");
        sbSql.append("	                AND A.TRANS_DATE BETWEEN '" + bStartDd + "' AND '" + bEndDd + "'                                                                                            \n");
        sbSql.append("	                AND B.START_DATE(+) <= '" + bEndDd + "' AND B.END_DATE(+) >= '" + bStartDd + "'                                                               \n");
        sbSql.append("                  AND B.USE_YN(+) = 'Y'                                                                                                                               \n");
        sbSql.append("                GROUP BY A.UPJANG                                                                                                                                                  \n");
        sbSql.append("                       , A.DUTY_YN                                                                                                                                                 \n");
        sbSql.append("                       , B.MARKET_PRICE                                                                                                                                                \n");        
        sbSql.append("                       , B.MD_PRICE                                                                                                                                                \n");
        sbSql.append("                       , NVL(B.USE_YN, 'N')                                                                                                                                                \n");
        sbSql.append("              )                                                                                                                                                                    \n");
        sbSql.append("        GROUP BY UPJANG                                                                                                                                                            \n");
        sbSql.append("      ) C                                                                                                                                                                          \n");
        sbSql.append("    , MAC_UPJANG_V B                                                                                                                                                               \n");
        sbSql.append("WHERE A.UPJANG = B.UPJANG                                                                                                                                                          \n");
        sbSql.append("  AND A.UPJANG = C.UPJANG(+)                                                                                                                                                       \n");
        
        if(!TM_CD.equals("")) {  
        	//sbSql.append("    AND (B.TM_CD = '" + TM_CD + "' OR B.PT_CD = '" + TM_CD + "')                                                                                                               \n");
        	//부문 조회 추가   20160229  요청자:윤지혜  처리자 : 맹수영
        	sbSql.append("    AND (B.TM_CD LIKE '" + TM_CD + "'||'%' OR B.PT_CD LIKE '" + TM_CD + "'||'%')                                                                                                               \n");
        }
        
        if(!UPJANG.equals("")) {
        	sbSql.append("    AND B.UPJANG = '" + UPJANG + "'                                                                                                                                            \n");
        }
        
        if(!CLOSED.equals("")) {
        	sbSql.append("    AND B.CLOSE_DATE IS NULL                                                                                                                                                   \n");
        }
        
        sbSql.append("ORDER BY B.MU_CD, B.TM_CD, B.JOB_CD, B.SUB_JOB_CD, B.UPJANG		                                                                                                                         \n");

		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_list51 = this.makeDataSet(rs, "ds_list51");

		rs.close();
		pstmt.close();

		/**종료**/
		out_dl.add(ds_list51);
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