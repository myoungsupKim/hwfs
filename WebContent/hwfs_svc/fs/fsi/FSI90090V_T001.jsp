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
		DataSet ds_list31, ds_tmList;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		//팀조회
		sbSql.append("SELECT CODE, CODE_NAME FROM SCC_COMMON_CODE \n");
		sbSql.append(" WHERE GROUP_CODE = 'MA0045' AND USE_YN = 'Y' \n");
		sbSql.append(" ORDER BY SORT_SEQ, CODE \n");
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_tmList = this.makeDataSet(rs, "ds_tmList");
		rs.close();
		pstmt.close();
		
		//내역조회
		sbSql.delete(0, sbSql.length());
		
	    sbSql.append("SELECT A.CENTER_CODE                                                                                                   \n");                                                                      
	    sbSql.append("     , (SELECT CENTER_NAME FROM HLDC_PO_CENTER WHERE CENTER_CODE = A.CENTER_CODE) AS CENTER_NAME                       \n");                                                                    
	    sbSql.append("     , A.ITEM_CODE                                                                                                     \n");                                                                      
	    sbSql.append("     , C.ITEM_NAME                                                                                                     \n");                                                                      
	    sbSql.append("     , C.ITEM_SIZE                                                                                                     \n");                                                                      
	    sbSql.append("     , C.PO_UOM                                                                                                        \n");                                                                      
	    sbSql.append("     , SUM(E.TRANS_QTY) AS TRANS_QTY                                                                                   \n");                                                                      
	    sbSql.append("     , SUM(E.TRANS_MAMOUNT) AS TRANS_MAMOUNT                                                                           \n");                                                                      
	    sbSql.append("     , SUM(E.TRANS_UAMOUNT) AS TRANS_UAMOUNT                                                                           \n");                                                                      

        // 팀 조회수 만큼 쿼리 동적생성
		for(int i=0; i<ds_tmList.getRowCount(); i++) {
			sbSql.append("   , SUM(DECODE(E.PT_CD, '" + ds_tmList.getString(i, "CODE") + "', E.TRANS_QTY, 0)) AS TRANS_QTY" + i + " \n");
			sbSql.append("   , SUM(DECODE(E.PT_CD, '" + ds_tmList.getString(i, "CODE") + "', E.TRANS_UAMOUNT, 0)) AS TRANS_UAMOUNT" + i + " \n");
			sbSql.append("   , SUM(DECODE(E.PT_CD, '" + ds_tmList.getString(i, "CODE") + "', E.TRANS_MAMOUNT, 0)) AS TRANS_MAMOUNT" + i + " \n");
		}
	    
	    sbSql.append("     , NVL(A.MARKET_PRICE, 0) AS PLAN_PRICE -- 기획단가                                                                 \n");                                                                  
	    sbSql.append("     , NVL(A.MD_PRICE, 0) AS MD_PRICE  -- 식재기준단가                                                                  \n");                                                                
	    sbSql.append("     , A.LIMIT_DUTY_QTY                                                                                                 \n");                                                                      
	    sbSql.append("     , DECODE(NVL(A.MD_PRICE,0), 0, 0, ROUND(NVL(A.MARKET_PRICE, 0) / NVL(A.MD_PRICE,0) * 100, 2)) AS PRICE_RATE -- 대비율         \n");
	    sbSql.append("     , NVL(A.MD_PRICE,0) - NVL(A.MARKET_PRICE, 0) AS PRICE_DIFF --금액차                                                \n");
	    sbSql.append("     , A.LIMIT_DUTY_QTY * NVL(A.MARKET_PRICE, 0) AS PLAN_AMOUNT -- 예상사용금액                                         \n");
	    sbSql.append("     , A.LIMIT_DUTY_QTY * (NVL(A.MD_PRICE,0) - NVL(A.MARKET_PRICE, 0)) AS PLAN_SAVE  -- 예상 절감금액                   \n");
	    sbSql.append("     , ROUND(SUM(E.TRANS_QTY) * (NVL(A.MD_PRICE,0) - NVL(A.MARKET_PRICE, 0))) AS REAL_SAVE  -- 확정 절감금액                   \n");
	    sbSql.append("  FROM FSI_DUTY_MST A                                                                                                   \n");
	    sbSql.append("     , VO_FC_VENDOR B                                                                                                   \n");
	    sbSql.append("     , HLDC_PO_ITEM_MST C                                                                                               \n");
	    sbSql.append("     , HLDC_PO_CENTER D                                                                                                 \n");
	    sbSql.append("     , (SELECT B.TM_CD                                                                                                  \n");
	    sbSql.append("             , B.PT_CD                                                                                                  \n");
	    sbSql.append("             , A.CENTER_CODE                                                                                            \n");
	    sbSql.append("             , A.CUSTCD                                                                                                 \n");
	    sbSql.append("             , A.ITEM_CODE                                                                                              \n");
	    sbSql.append("             , A.START_DATE                                                                                             \n");
	    sbSql.append("             , SUM(NVL(B.TRANS_QTY, 0)) AS TRANS_QTY                                                                    \n");
	    sbSql.append("             , SUM(ROUND(NVL(B.TRANS_UAMOUNT, 0))) AS TRANS_UAMOUNT                                                     \n");
	    sbSql.append("             , SUM(ROUND(NVL(B.TRANS_MAMOUNT, 0))) AS TRANS_MAMOUNT                                                     \n");
	    sbSql.append("          FROM FSI_DUTY_MST A                                                                                           \n");
	    sbSql.append("             , FSI_DUTY_DAILY_SUM B                                                                                     \n");
	    sbSql.append("             , SCO_UPJANG_MST_V C                                                                                       \n");
	    sbSql.append("         WHERE A.CENTER_CODE = B.CENTER_CODE                                                                            \n");
	    sbSql.append("           AND A.CUSTCD = B.CUSTCD                                                                                      \n");
	    sbSql.append("           AND A.ITEM_CODE = B.ITEM_CODE                                                                                \n");
	    sbSql.append("           AND A.START_DATE = B.START_DATE(+)                                                                              \n");
	    sbSql.append("           AND B.DUTY_YN = 'Y'                                                                                          \n");
	    sbSql.append("           AND A.START_DATE <= '" + END_DATE + "' AND A.END_DATE >= '" + START_DATE + "'                                \n");
	    sbSql.append("           AND B.TRANS_DATE BETWEEN A.START_DATE AND A.END_DATE                                                         \n");
	    sbSql.append("           AND A.USE_YN = 'Y'                                                                                           \n");
	    sbSql.append("           AND B.UPJANG = C.UPJANG                                                                                      \n");
	    
        if(!TM_CD.equals("")) {  
        	//sbSql.append("	   AND (C.TM_CD = '" + TM_CD + "' OR C.PT_CD = '" + TM_CD + "')                                                                                                                           \n");
        	sbSql.append("	   AND (C.TM_CD LIKE '" + TM_CD + "'||'%' OR C.PT_CD LIKE '" + TM_CD + "'||'%')                                                                                                                           \n");
        
        }
        
        if(!UPJANG.equals("")) {
        	sbSql.append("	   AND B.UPJANG = '" + UPJANG + "'                                                                                                                                                       \n");
        }
        
        if(!CLOSED.equals("")) {
        	sbSql.append("	   AND C.CLOSE_DATE IS NULL                                                                                                                                                              \n");
        }

        if(!CENTER_CODE.equals("")) {
        	sbSql.append("	   AND A.CENTER_CODE = '" + CENTER_CODE + "'                                                                                                                                             \n");
        }
        
	    sbSql.append("         GROUP BY B.TM_CD, B.PT_CD, A.CENTER_CODE, A.CUSTCD, A.ITEM_CODE, A.START_DATE                                           \n");
	    sbSql.append("       ) E                                                                                                              \n");
	    sbSql.append(" WHERE A.CUSTCD = B.VD_CD                                                                                               \n");
	    sbSql.append("   AND A.ITEM_CODE = C.ITEM_CODE                                                                                        \n");
	    sbSql.append("   AND A.CENTER_CODE = D.CENTER_CODE                                                                                    \n");
	    sbSql.append("   AND A.USE_YN = 'Y'                                                                                                   \n");
	    sbSql.append("   AND A.START_DATE <= '" + END_DATE + "' AND A.END_DATE >= '" + START_DATE + "'                                        \n");
	    sbSql.append("   AND A.CENTER_CODE = E.CENTER_CODE                                                                                    \n");
	    sbSql.append("   AND A.CUSTCD = E.CUSTCD                                                                                              \n");
	    sbSql.append("   AND A.ITEM_CODE = E.ITEM_CODE                                                                                        \n");
	    sbSql.append("   AND A.START_DATE = E.START_DATE(+)                                                                                      \n");
	    sbSql.append(" GROUP BY A.CENTER_CODE                                                                                                 \n");                                                                     
	    sbSql.append("        , A.ITEM_CODE                                                                                                   \n");                                                                     
	    sbSql.append("	      , C.ITEM_NAME                                                                                                   \n");                                                                     
	    sbSql.append("	      , C.ITEM_SIZE                                                                                                   \n");                                                                     
	    sbSql.append("	      , C.PO_UOM                                                                                                      \n");
	    sbSql.append("	      , A.MARKET_PRICE                                                                                                \n");
	    sbSql.append("	      , A.MD_PRICE                                                                                                    \n");                                                                     
	    sbSql.append("	      , A.LIMIT_DUTY_QTY      		                                                                                  \n");
		
		out_vl.add("fa_Sql", sbSql.toString());

		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_list31 = this.makeDataSet(rs, "ds_list31");

		rs.close();
		pstmt.close();

		/**종료**/
		out_dl.add(ds_tmList);
		out_dl.add(ds_list31);
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