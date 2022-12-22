<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 메뉴관리/자재관리/효율화식재 실적 조회
■ 프로그램ID   : FSI00096V_S001.jsp
■ 프로그램명   : 분석결과(상세)
■ 작성일자     : 2017-12-22
■ 작성자       : 김호석
■ 이력관리     : 

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
		DataSet ds_list, ds_tmList;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		
		//내역조회
		sbSql.delete(0, sbSql.length());
		

		 sbSql.append(" SELECT \n");   
		 sbSql.append("			C.ORG_LEVEL_NM3 \n");   
		 sbSql.append("       , B.TM_NAME \n");   
		 sbSql.append("       , B.TM_CD \n");   
		 sbSql.append("	    --, B.JOB_NAME \n");   
		 sbSql.append("	      , B.SUB_JOB_NAME \n");   
		 sbSql.append("       , B.SUB_JOB_CD \n");   
		 sbSql.append("	      , B.UPJANG \n");   
		 sbSql.append("	      , B.UPJANGNM \n");   
		 sbSql.append("       , SUM(DECODE(EFF_GUBUN, 'H001', M_EFF_AMT, 0)) AS H001_M_AMT \n");   
		 sbSql.append("       , SUM(DECODE(EFF_GUBUN, 'H002', M_EFF_AMT, 0)) AS H002_M_AMT \n");   
		 sbSql.append("       , SUM(DECODE(EFF_GUBUN, 'H003', M_EFF_AMT, 0)) AS H003_M_AMT \n");   
		 sbSql.append("       , SUM(DECODE(EFF_GUBUN, 'H004', M_EFF_AMT, 0)) AS H004_M_AMT \n");   
		 sbSql.append("       , SUM(DECODE(EFF_GUBUN, 'H005', M_EFF_AMT, 0)) AS H005_M_AMT \n");   
		 sbSql.append("       , SUM(DECODE(EFF_GUBUN, 'H006', M_EFF_AMT, 0)) AS H006_M_AMT \n");   
		 sbSql.append("       , SUM(DECODE(EFF_GUBUN, 'H007', M_EFF_AMT, 0)) AS H007_M_AMT \n");   
		 sbSql.append("       , SUM(DECODE(EFF_GUBUN, 'H008', M_EFF_AMT, 0)) AS H008_M_AMT \n");   
		 sbSql.append("       , SUM(DECODE(EFF_GUBUN, 'H008', M_EFF_AMT, 0)) AS H009_M_AMT \n");   
		 sbSql.append("       , SUM(DECODE(EFF_GUBUN, 'H010', M_EFF_AMT, 0)) AS H010_M_AMT \n");   
		 sbSql.append("       , SUM(DECODE(EFF_GUBUN, 'H001', U_EFF_AMT, 0)) AS H001_U_AMT \n");   
		 sbSql.append("       , SUM(DECODE(EFF_GUBUN, 'H002', U_EFF_AMT, 0)) AS H002_U_AMT \n");   
		 sbSql.append("       , SUM(DECODE(EFF_GUBUN, 'H003', U_EFF_AMT, 0)) AS H003_U_AMT \n");   
		 sbSql.append("       , SUM(DECODE(EFF_GUBUN, 'H004', U_EFF_AMT, 0)) AS H004_U_AMT \n");   
		 sbSql.append("       , SUM(DECODE(EFF_GUBUN, 'H005', U_EFF_AMT, 0)) AS H005_U_AMT \n");   
		 sbSql.append("       , SUM(DECODE(EFF_GUBUN, 'H006', U_EFF_AMT, 0)) AS H006_U_AMT \n");   
		 sbSql.append("       , SUM(DECODE(EFF_GUBUN, 'H007', U_EFF_AMT, 0)) AS H007_U_AMT \n");   
		 sbSql.append("       , SUM(DECODE(EFF_GUBUN, 'H008', U_EFF_AMT, 0)) AS H008_U_AMT \n");   
		 sbSql.append("       , SUM(DECODE(EFF_GUBUN, 'H008', U_EFF_AMT, 0)) AS H009_U_AMT \n");   
		 sbSql.append("       , SUM(DECODE(EFF_GUBUN, 'H010', U_EFF_AMT, 0)) AS H010_U_AMT \n");   
		 sbSql.append("	     , SUM(A.U_EFF_AMT) AS U_EFF_AMT \n");   
		 sbSql.append("	     , SUM(A.M_EFF_AMT) AS M_EFF_AMT \n");   
		 sbSql.append("	     , SUM(A.U_ALL_AMT) AS U_ALL_AMT \n");   
		 sbSql.append("	     , SUM(A.M_ALL_AMT) AS M_ALL_AMT \n");   
		 sbSql.append("	     , DECODE(SUM(A.U_ALL_AMT), 0, 0, ROUND(SUM(A.U_EFF_AMT) / SUM(A.U_ALL_AMT) * 100, 2)) AS U_PLN_RATE \n");   
		 sbSql.append("	     , DECODE(SUM(A.M_ALL_AMT), 0, 0, ROUND(SUM(A.M_EFF_AMT) / SUM(A.M_ALL_AMT) * 100, 2)) AS M_PLN_RATE \n");   
		 sbSql.append("	  FROM ( \n");   
		 sbSql.append("	        SELECT UPJANG \n");   
		 sbSql.append("          	 , EFF_GUBUN \n");   
		 sbSql.append("	             , SUM(U_EFF_AMT) AS U_EFF_AMT			--효율화식재 매입액(재무) \n");   
		 sbSql.append("	             , SUM(U_ALL_AMT) AS U_ALL_AMT			--전체 매입액(재무) \n");   
		 sbSql.append("	             , SUM(M_EFF_AMT) AS M_EFF_AMT          --효율화식재 매입액(관리) \n");   
		 sbSql.append("	             , SUM(M_ALL_AMT) AS M_ALL_AMT          --전체 매입액(관리) \n");   
		 sbSql.append("	          FROM ( \n");   
		 sbSql.append("	                SELECT A.UPJANG \n");   
		 sbSql.append("                      , B.ITEM_CODE \n");   
		 sbSql.append("                      , B.EFF_GUBUN \n");   
		 sbSql.append("	                     , CASE WHEN B.ITEM_CODE IS NOT NULL THEN SUM(ROUND(A.TRANS_UAMOUNT)) ELSE 0 END AS U_EFF_AMT \n");   
		 sbSql.append("	                     , CASE WHEN B.ITEM_CODE IS NOT NULL THEN SUM(ROUND(A.TRANS_MAMOUNT)) ELSE 0 END AS M_EFF_AMT \n");   
		 sbSql.append("	                     , SUM(ROUND(A.TRANS_UAMOUNT)) AS U_ALL_AMT \n");   
		 sbSql.append("	                     , SUM(ROUND(A.TRANS_MAMOUNT)) AS M_ALL_AMT \n");   
		 sbSql.append("	                  FROM FSI_DUTY_DAILY_SUM A \n");   
		 sbSql.append("	                     , FSI_EFF_MST B \n");   
		 sbSql.append("	                 WHERE 1=1 --A.CENTER_CODE = B.CENTER_CODE(+) \n");   
		 sbSql.append("	                   AND A.ITEM_CODE = B.ITEM_CODE(+) \n");   
		 sbSql.append("	                   AND A.TRANS_DATE BETWEEN ? AND ? \n");   
		 sbSql.append("	                   AND B.START_DATE(+) <= ? AND B.END_DATE(+) >= ? \n");   
		 sbSql.append("	                   AND B.USE_YN(+) = 'Y' \n");
         if(!CENTER_CODE.equals("")) {
        	sbSql.append("	  			   --AND A.CENTER_CODE = ?   \n");
         }
		 sbSql.append("	                 GROUP BY A.UPJANG \n");   
		 sbSql.append("                   		, B.ITEM_CODE \n");   
		 sbSql.append("                         , B.EFF_GUBUN \n");   
		 sbSql.append("	                        , NVL(B.USE_YN, 'N') \n");   
		 sbSql.append("	               ) \n");   
		 sbSql.append("	         GROUP BY UPJANG, EFF_GUBUN \n");   
		 sbSql.append("	       ) A \n");   
		 sbSql.append("	     , MAC_UPJANG_V B \n");   
		 sbSql.append("       , SCC_CC C \n");   
		 sbSql.append("	 WHERE A.UPJANG = B.UPJANG \n");   
		 sbSql.append("     AND B.CC_CD = C.CC_CD \n");   
		 sbSql.append("     --AND C.ORG_LEVEL_CD3 = ''  \n");   
		 if(!TM_CD.equals("")) {
	        sbSql.append("	   AND (B.TM_CD LIKE ?||'%' OR B.PT_CD LIKE ?||'%')  \n");	        
	     }	        
         if(!UPJANG.equals("")) {
         	sbSql.append("	   AND B.UPJANG = ?       \n");
         }
		 //sbSql.append("	   AND B.CLOSE_DATE IS NULL \n");   

		 sbSql.append("     GROUP BY C.ORG_LEVEL_NM3 \n");   
		 sbSql.append("       , B.TM_NAME \n");   
		 sbSql.append("       , B.TM_CD \n");   
		 sbSql.append("	      , B.SUB_JOB_NAME \n");   
		 sbSql.append("       , B.SUB_JOB_CD \n");   
		 sbSql.append("	      , B.UPJANG \n");   
		 sbSql.append("	      , B.UPJANGNM \n");   
		 sbSql.append("	 ORDER BY B.TM_CD, B.SUB_JOB_CD, B.UPJANG \n");   

		int idx = 1;
		pstmt = conn.prepareStatement(sbSql.toString());
		pstmt.setString(idx++, START_DATE);
		pstmt.setString(idx++, END_DATE);		
		pstmt.setString(idx++, END_DATE);
		pstmt.setString(idx++, START_DATE);
		if (CENTER_CODE.trim().length() != 0) pstmt.setString(idx++, CENTER_CODE);
		if (TM_CD.trim().length() != 0) pstmt.setString(idx++, TM_CD);
		if (UPJANG.trim().length() != 0) pstmt.setString(idx++, UPJANG);

		out_vl.add("fa_Sql", sbSql.toString());
		rs = pstmt.executeQuery();                   		
		
		ds_list = this.makeDataSet(rs, "ds_list");

		rs.close();
		pstmt.close();

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