<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 사업계획관리
■ 프로그램ID   : MAP30220E_T004.jsp
■ 프로그램명   : 마케터별 월추정 적용대상 조회
■ 작성일자     : 2015-09-01
■ 작성자       : 김태윤
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
		DataSet ds_Cond     = in_dl.get("ds_Cond");
		//입력 파라메터
		String g_Yy     	= nullToBlank(in_vl.getString("g_Yy"));
			
		//out 데이타
		DataSet ds_List;
		
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		
		// 월추정 입력여부 조회. 해당사번이 관리하는 업장중 하나만 조회한다.
		// 무조건 BPC에서 전송한 최종PL로 월추정 생성.
		sbSql.append("SELECT COUNT(1) ISDATA  														\n");
        sbSql.append("  FROM MAP_BPC_CONFIRM_PL_INFO												\n");
        sbSql.append(" WHERE PLAN_CLASS = '" + "AP" + "' 											\n");
        sbSql.append(" 	 AND PLAN_YEAR = '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "' 	\n");
        sbSql.append("   AND UPJANG  IN (SELECT UPJANG FROM FMS_UPJANG WHERE PART_SALES_SABUN = '" + nullToBlank(ds_Cond.getString(0, "SABUN")) + "' )	\n");
        
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		
		rs.next();
		
		String isData = rs.getString("ISDATA");
		
		// 월추정 입력여부 조회.
		// BPC에서 받는 최종PL로만 월추정 생성
		/*
		sbSql.append("SELECT COUNT(1) ISDATA  														\n");
        sbSql.append("  FROM MAP_MON_LOG_MGMT2														\n");
        sbSql.append(" WHERE YY = '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "' 			\n");
        sbSql.append("   AND TM_CD = '" + nullToBlank(ds_Cond.getString(0, "TM_CD")) + "' 			\n");
        sbSql.append("   AND SABUN = '" + nullToBlank(ds_Cond.getString(0, "SABUN")) + "' 			\n");
        sbSql.append("   AND BIZ_CLASS = '" + nullToBlank(ds_Cond.getString(0, "BIZ_CLASS2")) + "'	\n");

		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		
		rs.next();
		
		String isData = rs.getString("ISDATA");
		*/
		// 등록된 월추정 데이터가 없으면 BPC에서 제공한 최종사업계획 데이터에서 조회한다.
		//if("0".equals(isData)){

			sbSql.delete(0, sbSql.length());
            
sbSql.append("	SELECT A.UPJANGNM, B.UPJANG, B.ACCT_CD, B.ACCT_NM, B.ACCT_CLASS, A.YY, A.CONFIRM_YN, A.IMPROV_YN \n");                  
sbSql.append("	      ,MM_AMT_01, MM_AMT_02, MM_AMT_03, MM_AMT_04, MM_AMT_05, MM_AMT_06							 \n");
sbSql.append("	      ,MM_AMT_07, MM_AMT_08, MM_AMT_09, MM_AMT_10, MM_AMT_11, MM_AMT_12                          \n");
sbSql.append("	      ,A.SUM_AMT                                                                                 \n");
sbSql.append("	      ,A.VER_CD, A.CC_CD, A.JOB_GRADE_CD, A.JOB_GRADE_NM				                         \n");                  
sbSql.append("	  FROM (                                                                                         \n");                  
sbSql.append("	SELECT C.UPJANGNM, A.UPJANG									                                     \n");                  
sbSql.append("	 	   ,A.ACCT_CD, A.PLAN_YEAR AS YY, 'N' AS CONFIRM_YN, 'N' AS IMPROV_YN	                     \n");                  
sbSql.append("	       ,ROUND(A.MM_AMT_01 / 1000) AS MM_AMT_01										             \n");                  
sbSql.append("	       ,ROUND(A.MM_AMT_02 / 1000) AS MM_AMT_02										             \n");                  
sbSql.append("	       ,ROUND(A.MM_AMT_03 / 1000) AS MM_AMT_03										             \n");                  
sbSql.append("	       ,ROUND(A.MM_AMT_04 / 1000) AS MM_AMT_04										             \n");                  
sbSql.append("	       ,ROUND(A.MM_AMT_05 / 1000) AS MM_AMT_05										             \n");                  
sbSql.append("	       ,ROUND(A.MM_AMT_06 / 1000) AS MM_AMT_06										             \n");                  
sbSql.append("	       ,ROUND(A.MM_AMT_07 / 1000) AS MM_AMT_07										             \n");                  
sbSql.append("	       ,ROUND(A.MM_AMT_08 / 1000) AS MM_AMT_08										             \n");                  
sbSql.append("	       ,ROUND(A.MM_AMT_09 / 1000) AS MM_AMT_09										             \n");                  
sbSql.append("	       ,ROUND(A.MM_AMT_10 / 1000) AS MM_AMT_10										             \n");                  
sbSql.append("	       ,ROUND(A.MM_AMT_11 / 1000) AS MM_AMT_11										             \n");                  
sbSql.append("	       ,ROUND(A.MM_AMT_12 / 1000) AS MM_AMT_12										             \n");                  
sbSql.append("	 		,ROUND((A.MM_AMT_01+A.MM_AMT_02+A.MM_AMT_03+A.MM_AMT_04+A.MM_AMT_05+A.MM_AMT_06	         \n");                  
sbSql.append("	 			   +A.MM_AMT_07+A.MM_AMT_08+A.MM_AMT_09+A.MM_AMT_10+A.MM_AMT_11+A.MM_AMT_12	         \n");                  
sbSql.append("	   		    ) / 1000 ) SUM_AMT														             \n");                  
sbSql.append("	       , A.VER_CD, A.CC_CD, A.JOB_GRADE_CD, A.JOB_GRADE_NM, A.PLAN_CLASS			             \n");                  
sbSql.append("	   FROM MAP_BPC_CONFIRM_PL_INFO A 													             \n");                  
sbSql.append("	  	  ,MAP_BIZ_PLAN2 B 																             \n");                  
sbSql.append("	  	  ,ST_UPJANG C	 																             \n");                  
sbSql.append("	  WHERE A.VER_CD = B.VER_CD	 														             \n");                  
sbSql.append("	    AND A.PLAN_YEAR  = B.YY 															         \n");                  
sbSql.append("	    AND A.CC_CD  = B.CC_CD 															             \n");                  
sbSql.append("	    AND A.UPJANG  = B.UPJANG 															         \n");                  
sbSql.append("	    AND A.ACCT_CD  = B.ACCT_CD														             \n");                  
sbSql.append("	    AND A.UPJANG  = C.UPJANG 															         \n");                  
sbSql.append("	    AND A.PLAN_CLASS = 'AP'															         	 \n");
sbSql.append("	    AND A.UPJANG  != 100000															             \n");                  
sbSql.append("	    AND A.PLAN_YEAR = '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'                    \n");                                                                   
sbSql.append("	    AND B.TM_CD = '" + nullToBlank(ds_Cond.getString(0, "TM_CD")) + "'          		         \n");                                                                  
sbSql.append("	    AND B.SABUN = '" + nullToBlank(ds_Cond.getString(0, "SABUN")) + "'            	             \n");                                                            
sbSql.append("	    AND B.BIZ_CLASS = '" + nullToBlank(ds_Cond.getString(0, "BIZ_CLASS")) + "'                   \n");                                    
sbSql.append("	       ) A                                                                                       \n");                  
sbSql.append("	      ,(				          																 \n");                  
sbSql.append("	        SELECT A.ACCT_CD          																 \n");                  
sbSql.append("	              ,A.ACCT_NM                                                                         \n");                  
sbSql.append("	              ,A.ACCT_CLASS                                                                      \n");                  
sbSql.append("	              ,B.UPJANG                                                                          \n");                  
sbSql.append("	          FROM (                                                                                 \n");                  
sbSql.append("	                SELECT '41201010' AS ACCT_CD                                                     \n");                  
sbSql.append("	                      , '상품매출_일반' AS ACCT_NM                                               \n");                  
sbSql.append("	                      , '매출액' AS ACCT_CLASS                                                   \n");                  
sbSql.append("	                  FROM DUAL                                                                      \n");                  
sbSql.append("	                 UNION ALL                                                                       \n");                  
sbSql.append("	                SELECT '42201010' AS ACCT_CD                                                     \n");                  
sbSql.append("	                      , '상품원가_일반' AS ACCT_NM                                               \n");                  
sbSql.append("	                      , '재료비' AS ACCT_CLASS                                                   \n");                  
sbSql.append("	                  FROM DUAL                                                                      \n");                  
sbSql.append("	                 UNION ALL                                                                       \n");                  
sbSql.append("	                SELECT '43216050' AS ACCT_CD                                                     \n");                  
sbSql.append("	                      , '지급수수료' AS ACCT_NM                                                  \n");                  
sbSql.append("	                      , '경비' AS ACCT_CLASS                                                     \n");                  
sbSql.append("	                  FROM DUAL                                                                      \n");                  
sbSql.append("	                 UNION ALL                                                                       \n");                  
sbSql.append("	                SELECT '44000000' AS ACCT_CD                                                     \n");                  
sbSql.append("	                      , '매출이익' AS ACCT_NM                                               	 \n");                  
sbSql.append("	                      , '매출이익' AS ACCT_CLASS                                                 \n");                  
sbSql.append("	                  FROM DUAL                                                                      \n");                  
sbSql.append("	               ) A                                                                               \n");                  
sbSql.append("	              ,( SELECT UPJANG, YY, VER_CD, TM_CD, SABUN, CC_CD, ACCT_CD, ACCT_NM, ACCT_CLASS	 \n");                  
sbSql.append("	                   FROM MAP_BIZ_PLAN2                                                            \n");                  
sbSql.append("	                  WHERE YY = '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'             \n");
sbSql.append("	                    AND TM_CD = '" + nullToBlank(ds_Cond.getString(0, "TM_CD")) + "'          	 \n");                                                                  
sbSql.append("	                    AND SABUN = '" + nullToBlank(ds_Cond.getString(0, "SABUN")) + "'             \n");                                                            
sbSql.append("	                    AND BIZ_CLASS = '" + nullToBlank(ds_Cond.getString(0, "BIZ_CLASS")) + "'     \n");                                    
sbSql.append("	               ) B                                                                               \n");                  
sbSql.append("	         WHERE A.ACCT_CD = B.ACCT_CD(+)                                                          \n");                  
sbSql.append("	      )  B                                                                                       \n");                  
sbSql.append("	 WHERE A.UPJANG(+) = B.UPJANG                                                                    \n");                  
sbSql.append("	   AND A.ACCT_CD(+) = B.ACCT_CD                                                                  \n");
//최종BPC 데이터가 있을때만 조회.
if(!"0".equals(isData)){
	sbSql.append("	    AND A.PLAN_CLASS(+) = 'AP'															         \n");
//데이터 안나오게 처리.
}else{
	sbSql.append("      AND A.PLAN_CLASS = 'XX'																	 \n");
}
sbSql.append("	 ORDER BY B.UPJANG, B.ACCT_CD, A.CC_CD                                                           \n");

			
		out_vl.add("fa_Sql", sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_List = this.makeDataSet(rs, "ds_List");

		pstmt.close();
		rs.close();

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