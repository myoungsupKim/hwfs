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
		
		String START_DATE   = nullToBlank(ds_cond.getString(0, "START_DATE"));
		String END_DATE		= nullToBlank(ds_cond.getString(0, "END_DATE"));
		String CENTER_CODE  = nullToBlank(ds_cond.getString(0, "CENTER_CODE"));
		String TM_CD		= nullToBlank(ds_cond.getString(0, "TM_CD"));
		String UPJANG	    = nullToBlank(ds_cond.getString(0, "UPJANG"));
		String CLOSED	    = nullToBlank(ds_cond.getString(0, "CLOSED"));
		String STYPE		= nullToBlank(ds_cond.getString(0, "STYPE"));

		//out 데이타
		DataSet ds_list41;
		
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
        sbSql.append("	SELECT B.TM_NAME                                                                                                                                                         \n");
        sbSql.append("	     , B.JOB_NAME                                                                                                                                                        \n");
        sbSql.append("	     , B.SUB_JOB_NAME                                                                                                                                                    \n");
        sbSql.append("	     , B.UPJANG                                                                                                                                                          \n");
        sbSql.append("	     , B.UPJANGNM                                                                                                                                                        \n");
        sbSql.append("	     , A.U_PLN_AMT                                                                                                                                                       \n");
        sbSql.append("	     , A.M_PLN_AMT                                                                                                                                                       \n");
        sbSql.append("	     , A.U_ALL_AMT                                                                                                                                                       \n");
        sbSql.append("	     , A.M_ALL_AMT                                                                                                                                                       \n");
        sbSql.append("	     , DECODE(A.U_ALL_AMT, 0, 0, ROUND(A.U_PLN_AMT / A.U_ALL_AMT * 100, 2)) AS U_PLN_RATE                                                                                \n");
        sbSql.append("	     , DECODE(A.M_ALL_AMT, 0, 0, ROUND(A.M_PLN_AMT / A.M_ALL_AMT * 100, 2)) AS M_PLN_RATE                                                                                \n");
        sbSql.append("	     , A.U_REAL_SAVE                                                                                                                                                     \n");
        sbSql.append("	     , A.M_REAL_SAVE                                                                                                                                                     \n");
        sbSql.append("	     , DECODE(A.U_ALL_AMT, 0, 0, ROUND(A.U_REAL_SAVE / A.U_ALL_AMT * 100, 2)) AS U_REAL_SAVE_RATE                                                                        \n");
        sbSql.append("	     , DECODE(A.M_ALL_AMT, 0, 0, ROUND(A.M_REAL_SAVE / A.M_ALL_AMT * 100, 2)) AS M_REAL_SAVE_RATE                                                                        \n");
        sbSql.append("	     , DECODE(C.ALL_ITEM_CNT, 0, 0, ROUND(C.REP_ITEM_CNT / ALL_ITEM_CNT *100, 2)) AS VARI_RATE                                                                           \n");        
        sbSql.append("	  FROM (                                                                                                                                                                 \n");
        sbSql.append("	        SELECT UPJANG                                                                                                                                                    \n");
        sbSql.append("	             , SUM(U_PLN_AMT) AS U_PLN_AMT                                                                                                                               \n");
        sbSql.append("	             , SUM(U_ALL_AMT) AS U_ALL_AMT                                                                                                                               \n");
        sbSql.append("	             , SUM(U_REAL_SAVE) AS U_REAL_SAVE                                                                                                                           \n");
        sbSql.append("	             , SUM(M_PLN_AMT) AS M_PLN_AMT                                                                                                                               \n");
        sbSql.append("	             , SUM(M_ALL_AMT) AS M_ALL_AMT                                                                                                                               \n");
        sbSql.append("	             , SUM(M_REAL_SAVE) AS M_REAL_SAVE                                                                                                                           \n");
        sbSql.append("	          FROM (                                                                                                                                                         \n");
        sbSql.append("	                SELECT A.UPJANG                                                                                                                                          \n");
        sbSql.append("	                     , CASE WHEN A.DUTY_YN = 'Y' AND NVL(B.USE_YN, 'N') = 'Y' THEN SUM(ROUND(A.TRANS_UAMOUNT)) ELSE 0 END AS U_PLN_AMT                                                                       \n");
        sbSql.append("	                     , CASE WHEN A.DUTY_YN = 'Y' AND NVL(B.USE_YN, 'N') = 'Y' THEN SUM(ROUND(A.TRANS_MAMOUNT)) ELSE 0 END AS M_PLN_AMT                                                                       \n");
        sbSql.append("	                     , SUM(ROUND(A.TRANS_UAMOUNT)) AS U_ALL_AMT                                                                                                                 \n");
        sbSql.append("	                     , SUM(ROUND(A.TRANS_MAMOUNT)) AS M_ALL_AMT                                                                                                                 \n");
        sbSql.append("	                     , CASE WHEN A.DUTY_YN = 'Y' AND NVL(B.USE_YN, 'N') = 'Y' THEN ROUND(SUM(A.TRANS_QTY) * (NVL(B.MD_PRICE,0) - NVL(B.MARKET_PRICE, 0))) ELSE 0 END AS U_REAL_SAVE     \n");
        sbSql.append("	                     , CASE WHEN A.DUTY_YN = 'Y' AND NVL(B.USE_YN, 'N') = 'Y' THEN ROUND(SUM(A.TRANS_QTY) * (NVL(B.MD_PRICE,0) - NVL(B.MARKET_PRICE, 0))) ELSE 0 END AS M_REAL_SAVE     \n");
        sbSql.append("	                  FROM FSI_DUTY_DAILY_SUM A                                                                                                                              \n");
        sbSql.append("	                     , FSI_DUTY_MST B                                                                                                                                    \n");
        sbSql.append("	                 WHERE A.CENTER_CODE = B.CENTER_CODE(+)                                                                                                                  \n");
        sbSql.append("	                   AND A.CUSTCD = B.CUSTCD(+)                                                                                                                            \n");
        sbSql.append("	                   AND A.ITEM_CODE = B.ITEM_CODE(+)                                                                                                                      \n");
        sbSql.append("	                   AND A.START_DATE = B.START_DATE(+)                                                                                                                    \n");
        sbSql.append("	                   AND A.TRANS_DATE BETWEEN '" + START_DATE + "' AND '" + END_DATE + "'                                                                                  \n");
        sbSql.append("	                   AND B.START_DATE(+) <= '" + END_DATE + "' AND B.END_DATE(+) >= '" + START_DATE + "'                                                                   \n");
        sbSql.append("	                   AND B.USE_YN(+) = 'Y'                                                                                                                                 \n");
        sbSql.append("	                 GROUP BY A.UPJANG                                                                                                                                       \n");
        sbSql.append("	                        , A.DUTY_YN                                                                                                                                      \n");
        sbSql.append("	                        , B.MARKET_PRICE                                                                                                                                 \n");
        sbSql.append("	                        , B.MD_PRICE                                                                                                                                     \n");
        sbSql.append("	                        , NVL(B.USE_YN, 'N')                                                                                                                             \n");
        sbSql.append("	               )                                                                                                                                                         \n");
        sbSql.append("	         GROUP BY UPJANG                                                                                                                                                 \n");
        sbSql.append("	       ) A                                                                                                                                                               \n");
        sbSql.append("	     , MAC_UPJANG_V B                                                                                                                                                    \n");
        sbSql.append("	     , (                                                                                                                                                                 \n");
        sbSql.append("          SELECT A.UPJANG                                                                                                                                                  \n");
        sbSql.append("               , (SELECT COUNT(DISTINCT REP_ITEM_CODE)                                                                                                                     \n");
        sbSql.append("                    FROM FSI_DUTY_MST                                                                                                                                      \n");
        sbSql.append("                   WHERE CENTER_CODE = (SELECT CENTER_CODE                                                                                                                 \n");
        sbSql.append("                                          FROM HLDC_PO_UPJANG_CENTER                                                                                                       \n");
        sbSql.append("                                         WHERE UPJANG = A.UPJANG)                                                                                                          \n");
        sbSql.append("                     AND START_DATE <= '" + END_DATE + "' AND END_DATE >= '" + START_DATE + "') AS ALL_ITEM_CNT                                                            \n");
        sbSql.append("               , COUNT(DISTINCT B.REP_ITEM_CODE) AS REP_ITEM_CNT                                                                                                           \n");
        sbSql.append("            FROM FSI_DUTY_DAILY_SUM A                                                                                                                                      \n");
        sbSql.append("               , FSI_DUTY_MST B                                                                                                                                            \n");
        sbSql.append("           WHERE A.CENTER_CODE = B.CENTER_CODE                                                                                                                             \n");
        sbSql.append("             AND A.CUSTCD = B.CUSTCD                                                                                                                                       \n");
        sbSql.append("             AND A.ITEM_CODE = B.ITEM_CODE                                                                                                                                 \n");
        sbSql.append("             AND A.START_DATE = B.START_DATE                                                                                                                               \n");
        sbSql.append("             AND A.TRANS_DATE BETWEEN '" + START_DATE + "' AND '" + END_DATE + "'                                                                                          \n");
        sbSql.append("             AND B.USE_YN = 'Y'                                                                                         \n");
        sbSql.append("           GROUP BY A.UPJANG                                                                                                                                               \n");
   		sbSql.append("	       ) C                                                                                                                                                               \n");
        sbSql.append("	 WHERE A.UPJANG = B.UPJANG		                                                                                                                                         \n");
        sbSql.append("	   AND A.UPJANG = C.UPJANG		                                                                                                                                         \n");
        
        if(!TM_CD.equals("")) { 
        	//sbSql.append("	   AND (B.TM_CD = '" + TM_CD + "' OR B.PT_CD = '" + TM_CD + "')                                                                                                       \n");
        	//부문 조회 추가   20160229  요청자:윤지혜  처리자 : 맹수영
        	sbSql.append("	   AND (B.TM_CD LIKE '" + TM_CD + "'||'%' OR B.PT_CD LIKE '" + TM_CD + "'||'%')                                                                                                       \n");
        }
        
        if(!UPJANG.equals("")) {
        	sbSql.append("	   AND B.UPJANG = '" + UPJANG + "'                                                                                                                                                       \n");
        }
        
        if(!CLOSED.equals("")) {
        	sbSql.append("	   AND B.CLOSE_DATE IS NULL                                                                                                                                                              \n");
        }

        if(!CENTER_CODE.equals("")) {
        	//sbSql.append("	   AND A.CENTER_CODE = '" + CENTER_CODE + "'                                                                                                                     \n");
        }        
        
        sbSql.append("	 ORDER BY B.MU_CD, B.TM_CD, B.JOB_CD, B.SUB_JOB_CD, B.UPJANG                                                                                                                      \n");

		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_list41 = this.makeDataSet(rs, "ds_list41");

		rs.close();
		pstmt.close();

		/**종료**/
		out_dl.add(ds_list41);
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