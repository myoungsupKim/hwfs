<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 사업계획관리
■ 프로그램ID   : MAP30230E_T001.jsp
■ 프로그램명   : 마케터별 일계획 관리
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
		DataSet ds_Cond     	= in_dl.get("ds_Cond");
		
		//입력 파라메터
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		String g_Yy     	= nullToBlank(in_vl.getString("g_Yy"));
		
		//FileLog.println("d:\\aaa.txt", ds_Cond);
		//out 데이타
		DataSet ds_List;

		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		// 일계획 입력여부 조회.
		sbSql.append("SELECT COUNT(1) ISDATA  																\n");
        sbSql.append("  FROM MAP_DAY_LOG_MGMT2																\n");
        sbSql.append(" WHERE TM_CD ='" + nullToBlank(ds_Cond.getString(0, "TM_CD")) + "'	  				\n");
		sbSql.append(" 	 AND SABUN = '" + nullToBlank(ds_Cond.getString(0, "SABUN")) + "'					\n");
		sbSql.append(" 	 AND YY = SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 1, 4)		\n");
		sbSql.append(" 	 AND MM = SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 5, 2)		\n");
		sbSql.append("   AND DAY_CLASS = '" + nullToBlank(ds_Cond.getString(0, "DAY_CLASS")) + "'			\n");

		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();

		rs.next();

		String isData = rs.getString("ISDATA");
		
		//  Confirm 유무 조회.
		sbSql.delete(0, sbSql.length());
		sbSql.append("SELECT  COUNT(CONFIRM_YN)	CONFIRM_YN													\n");
        sbSql.append("  FROM MAP_DAY_LOG_MGMT2																\n");
        sbSql.append(" WHERE YY = SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 1, 4)		\n");
		sbSql.append(" 	 AND MM = SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 5, 2)		\n");
		sbSql.append("   AND TM_CD = '" + nullToBlank(ds_Cond.getString(0, "TM_CD")) + "'					\n");
		sbSql.append("   AND SABUN = '" + nullToBlank(ds_Cond.getString(0, "SABUN")) + "'					\n");
		sbSql.append("   AND DAY_CLASS = '" + nullToBlank(ds_Cond.getString(0, "DAY_CLASS")) + "'			\n");

		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();

		rs.next();

		String isData2 = nullToBlank(rs.getString("CONFIRM_YN"));
		
		if("1".equals(isData2)){
			//  Confirm 여부 조회.
			sbSql.delete(0, sbSql.length());
			sbSql.append("SELECT  	CONFIRM_YN																	\n");
	        sbSql.append("  FROM MAP_DAY_LOG_MGMT2																\n");
	        sbSql.append(" WHERE YY = SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 1, 4)		\n");
			sbSql.append(" 	 AND MM = SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 5, 2)		\n");
			sbSql.append("   AND TM_CD = '" + nullToBlank(ds_Cond.getString(0, "TM_CD")) + "'					\n");
			sbSql.append("   AND SABUN = '" + nullToBlank(ds_Cond.getString(0, "SABUN")) + "'					\n");
			sbSql.append("   AND DAY_CLASS = '" + nullToBlank(ds_Cond.getString(0, "DAY_CLASS")) + "'			\n");

			pstmt = conn.prepareStatement(sbSql.toString());
			rs = pstmt.executeQuery();

			rs.next();

			String isData3 = nullToBlank(rs.getString("CONFIRM_YN"));
			
			isData2 = isData3;
			
		}else{
			isData2 = "N";
		}

		if("0".equals(isData)){
			
			// 월추정값은 관리금액임으로 그대로 사용한다.
			// SELECT            A.ACCT_CLASS, A.ACCT_NM, A.ACCT_CD, A.CC_CD, A.YMD, B.CONFIRM_YN, B.DAY_CLASS
			sbSql.delete(0, sbSql.length());
			sbSql.append(" SELECT *	\n");
			sbSql.append("   FROM (	\n");
			sbSql.append(" SELECT A.ACCT_CLASS, A.ACCT_NM, A.ACCT_CD, A.UPJANGNM, A.UPJANG, A.CC_CD, 'N' CONFIRM_YN, '' AS YMD, B.P_DATE\n");
			sbSql.append("       ,ROUND((A.MM_AMT / 1000)) SUM_AMT	 									\n"); //-- 추가 계정별 월 합계
			sbSql.append("       ,ROUND((A.MM_AMT / 1000)) MM_AMT	 									\n"); //-- 계정별 월 합계
			sbSql.append("       ,ROUND(((MM_AMT / LAST_DD_CNT) / 1000), 0) DD_AMT						\n");  //-- 계정별 월일의 1/N
			sbSql.append("   FROM (																		\n");
			sbSql.append("  SELECT DECODE(A.ACCT_CD, '41201010', '매출액', '42201010', '재료비', '43216050', '경비', '44000000', '매출이익') ACCT_CLASS					 \n");
			sbSql.append("	 	  ,C.UPJANGNM 	                     																									 \n");
			sbSql.append("        ,DECODE(A.ACCT_CD, '41201010', '상품매출_일반', '42201010', '상품원가_일반', '43216050', '지급수수료', '44000000', '매출이익') ACCT_NM \n");
			sbSql.append("	 	  ,A.ACCT_CD, A.UPJANG, A.CC_CD 	                     																									 \n");
			sbSql.append("        ,SUBSTR(TO_CHAR(LAST_DAY('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+ "'||'01' ),'YYYYMMDD'), 7,2) LAST_DD_CNT	\n");
			sbSql.append("        ,(CASE WHEN SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 5, 2) = '01' THEN A.MM_AMT_01	\n");
			sbSql.append("               WHEN SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 5, 2) = '02' THEN A.MM_AMT_02	\n");
			sbSql.append("               WHEN SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 5, 2) = '03' THEN A.MM_AMT_03	\n");
			sbSql.append("               WHEN SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 5, 2) = '04' THEN A.MM_AMT_04	\n");
			sbSql.append("               WHEN SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 5, 2) = '05' THEN A.MM_AMT_05	\n");
			sbSql.append("               WHEN SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 5, 2) = '06' THEN A.MM_AMT_06	\n");
			sbSql.append("               WHEN SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 5, 2) = '07' THEN A.MM_AMT_07	\n");
			sbSql.append("               WHEN SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 5, 2) = '08' THEN A.MM_AMT_08	\n");
			sbSql.append("               WHEN SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 5, 2) = '09' THEN A.MM_AMT_09	\n");
			sbSql.append("               WHEN SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 5, 2) = '10' THEN A.MM_AMT_10	\n");
			sbSql.append("               WHEN SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 5, 2) = '11' THEN A.MM_AMT_11	\n");
			sbSql.append("               WHEN SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 5, 2) = '12' THEN A.MM_AMT_12	\n");
			sbSql.append("               ELSE 0																							  	\n");
			sbSql.append("               END																								\n");
			sbSql.append("          ) AS MM_AMT																								\n");
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
			sbSql.append("	    AND A.PLAN_YEAR = SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 1, 4)      \n");                                                                   
			sbSql.append("	    AND B.TM_CD = '" + nullToBlank(ds_Cond.getString(0, "TM_CD")) + "'          		         \n");                                                                  
			sbSql.append("	    AND B.SABUN = '" + nullToBlank(ds_Cond.getString(0, "SABUN")) + "'            	             \n");                                                            
			/*
			sbSql.append("         SELECT A.ACCT_CLASS, C.UPJANGNM, A.ACCT_NM, A.ACCT_CD, A.UPJANG, A.CC_CD				\n");
			sbSql.append("               ,SUBSTR(TO_CHAR(LAST_DAY('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+ "'||'01' ),'YYYYMMDD'), 7,2) LAST_DD_CNT	\n");
			sbSql.append("               ,(CASE WHEN SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 5, 2) = '01' THEN A.MM_AMT_01						\n");
			sbSql.append("                      WHEN SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 5, 2) = '02' THEN A.MM_AMT_02						\n");
			sbSql.append("                      WHEN SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 5, 2) = '03' THEN A.MM_AMT_03						\n");
			sbSql.append("                      WHEN SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 5, 2) = '04' THEN A.MM_AMT_04						\n");
			sbSql.append("                      WHEN SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 5, 2) = '05' THEN A.MM_AMT_05						\n");
			sbSql.append("                      WHEN SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 5, 2) = '06' THEN A.MM_AMT_06						\n");
			sbSql.append("                      WHEN SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 5, 2) = '07' THEN A.MM_AMT_07						\n");
			sbSql.append("                      WHEN SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 5, 2) = '08' THEN A.MM_AMT_08						\n");
			sbSql.append("                      WHEN SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 5, 2) = '09' THEN A.MM_AMT_09						\n");
			sbSql.append("                      WHEN SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 5, 2) = '10' THEN A.MM_AMT_10						\n");
			sbSql.append("                      WHEN SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 5, 2) = '11' THEN A.MM_AMT_11						\n");
			sbSql.append("                      WHEN SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 5, 2) = '12' THEN A.MM_AMT_12						\n");
			sbSql.append("                      ELSE 0																	\n");
			sbSql.append("                      END																		\n");
			sbSql.append("                ) AS MM_AMT																	\n");
			sbSql.append("           FROM MAP_MON_PLAN2 A																\n");
			sbSql.append("           	 ,MAP_MON_LOG_MGMT2 B															\n");
			sbSql.append("          	 ,ST_UPJANG C																	\n");
			sbSql.append("          WHERE A.TM_CD = B.TM_CD																\n");
			sbSql.append("   		  AND A.SABUN = B.SABUN																\n");
			sbSql.append("   		  AND A.YY = B.YY																	\n");
			sbSql.append("   		  AND A.BIZ_CLASS = B.BIZ_CLASS														\n");
			sbSql.append("   		  AND A.UPJANG = C.UPJANG															\n");
			sbSql.append("            AND A.TM_CD = '" + nullToBlank(ds_Cond.getString(0, "TM_CD")) + "'				\n");
			sbSql.append("            AND A.SABUN = '" + nullToBlank(ds_Cond.getString(0, "SABUN")) + "'				\n");
			sbSql.append("            AND A.YY = SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 1, 4)	\n");
			sbSql.append("   		  AND B.CONFIRM_YN = '" + "Y" + "'													\n");
			*/
			sbSql.append("        ) A																					\n");
			sbSql.append("       ,(SELECT P_DATE   																		\n");
			sbSql.append("           FROM (																				\n");
			sbSql.append("                 SELECT TO_CHAR(TO_DATE('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'||'01', 'YYYYMMDD')+LEVEL-1,'YYYYMMDD') P_DATE \n");
			sbSql.append("                   FROM DUAL																	\n");
			sbSql.append("                  WHERE 1=1																	\n");
			sbSql.append("                  CONNECT BY LEVEL-1 <= 365*10												\n");
			sbSql.append("                 )																			\n");
			sbSql.append("          WHERE P_DATE BETWEEN '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'||'01' AND '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'||'31'	\n");
			sbSql.append("        ) B																					\n");
			sbSql.append("   	)																						\n");
			sbSql.append("   		  PIVOT ( AVG(DD_AMT) FOR P_DATE IN (" + nullToBlank(ds_Cond.getString(0, "SEARCH_COL")) + ") )	\n");
			sbSql.append("  ORDER BY UPJANGNM, ACCT_CD																	\n");
		
		}else{
			sbSql.delete(0, sbSql.length());
			sbSql.append(" SELECT A.*																							\n");
			sbSql.append("   FROM (																								\n");
			sbSql.append(" 			SELECT *																					\n");
			sbSql.append("   		  FROM (																					\n");
			sbSql.append("					SELECT A.ACCT_CLASS, A.ACCT_NM, A.ACCT_CD, E.UPJANGNM, A.UPJANG, A.CC_CD, B.CONFIRM_YN, A.YMD, '' AS P_DATE	\n");			
			sbSql.append("      				  ,C.SUM_AMT																	\n");
			sbSql.append("      				  ,C.MM_AMT																		\n");
			sbSql.append("      				  ,ROUND((A.DD_AMT / 1000), 0) AS DD_AMT										\n");
			sbSql.append("  				  FROM MAP_DAY_PLAN2 A 																\n");
	        sbSql.append(" 						  ,MAP_DAY_LOG_MGMT2 B 															\n");
	        sbSql.append(" 						  ,(				 															\n");
	        sbSql.append("							SELECT UPJANG, ACCT_CD, ROUND((SUM(A.DD_AMT) / 1000)) AS MM_AMT, MM_AMT AS SUM_AMT	\n");
	        sbSql.append("							  FROM MAP_DAY_PLAN2 A														\n");
	        sbSql.append("							 WHERE A.TM_CD = '" + nullToBlank(ds_Cond.getString(0, "TM_CD")) + "'		\n");
	        sbSql.append("							   AND A.SABUN = '" + nullToBlank(ds_Cond.getString(0, "SABUN")) + "'		\n");
	        //sbSql.append("							   AND A.UPJANG = '" + nullToBlank(ds_List.getString(iRow, "UPJANG")) + "'		\n");	        
	        sbSql.append(" 	 				   		   AND A.YY = SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 1, 4)	\n");
			sbSql.append(" 	 				   		   AND A.MM = SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 5, 2)	\n");
			sbSql.append("   				   		   AND A.DAY_CLASS = '" + nullToBlank(ds_Cond.getString(0, "DAY_CLASS")) + "'		\n");
			sbSql.append("					 		 GROUP BY UPJANG, ACCT_CD, MM_AMT											\n");
	        sbSql.append(" 						   ) C				 															\n");
	        sbSql.append(" 						  ,ST_UPJANG E				 													\n");
	        sbSql.append(" 				     WHERE A.TM_CD = B.TM_CD															\n");
			sbSql.append("   				   AND A.SABUN = B.SABUN															\n");
			sbSql.append("   				   AND A.YY = B.YY																	\n");
			sbSql.append("   				   AND A.MM = B.MM																	\n");
			//sbSql.append("   				   AND A.TM_CD = '" + nullToBlank(ds_Cond.getString(0, "TM_CD")) + "'				\n");
			//sbSql.append("   				   AND A.SABUN = '" + nullToBlank(ds_Cond.getString(0, "SABUN")) + "'				\n");
			//sbSql.append(" 	 			   AND A.YY = SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 1, 4)	\n");
			//sbSql.append(" 	 			   AND A.MM = SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 5, 2)	\n");
			sbSql.append("   				   AND A.DAY_CLASS = '" + nullToBlank(ds_Cond.getString(0, "DAY_CLASS")) + "'		\n");
			sbSql.append("   				   AND B.DAY_CLASS = '" + nullToBlank(ds_Cond.getString(0, "DAY_CLASS")) + "'		\n");
			sbSql.append("   				   AND B.CONFIRM_YN = '" + isData2 + "'												\n");
			sbSql.append("   				   AND A.UPJANG = C.UPJANG															\n");
			sbSql.append("   				   AND A.ACCT_CD = C.ACCT_CD														\n");
			sbSql.append("   				   AND A.UPJANG = E.UPJANG															\n");
			sbSql.append("					 GROUP BY A.ACCT_CLASS, A.ACCT_NM, A.ACCT_CD, E.UPJANGNM, A.UPJANG, A.CC_CD, B.CONFIRM_YN, A.YMD, A.DD_AMT, C.MM_AMT, C.SUM_AMT 	\n");
			sbSql.append("   				)																					\n");
			sbSql.append(" PIVOT ( AVG(DD_AMT) FOR YMD IN (" + nullToBlank(ds_Cond.getString(0, "SEARCH_COL")) + ") )			\n");
			sbSql.append("   		) A																							\n");
			sbSql.append(" ORDER BY A.UPJANGNM, A.ACCT_CD																		\n");

		}

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