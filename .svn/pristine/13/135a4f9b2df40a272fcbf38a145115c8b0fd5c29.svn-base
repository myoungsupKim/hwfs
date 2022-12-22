<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 사업계획관리
■ 프로그램ID   : MAP30250E_T001.jsp
■ 프로그램명   : 팀별 사업계획관리
■ 작성일자     : 2015-08-20
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
		DataSet ds_CcCd     = in_dl.get("ds_CcCd");
		
		//입력 파라메터
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		String g_Yy     	= nullToBlank(in_vl.getString("g_Yy"));
		
		//out 데이타
		DataSet ds_List;
		
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		
		// BPC에서 최종PL 정보 유무 조회.
		sbSql.delete(0, sbSql.length());
		sbSql.append("	SELECT COUNT(1) ISDATA																	\n");
		sbSql.append("	  FROM MAP_BPC_CONFIRM_PL_INFO            												\n");
		sbSql.append("	 WHERE PLAN_CLASS = 'AP'                  												\n");
		sbSql.append("	   AND PLAN_YEAR = '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'				\n");
		sbSql.append("	   AND CC_CD IN (SELECT DISTINCT CC_CD    												\n");
		sbSql.append("	                   FROM MAP_BIZ_PLAN      												\n");
		sbSql.append("	                  WHERE YY = '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'    \n");
		sbSql.append("	                    AND TM_CD = '" + nullToBlank(ds_Cond.getString(0, "TM_CD")) + "'	\n");
		sbSql.append("	                 )                       												\n");
		
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		rs.next();
		String isData = rs.getString("ISDATA");
		//System.out.println("isData4================>"+isData4);
		
		String chkVal = nullToBlank(ds_Cond.getString(0, "CLASS")); // 기본:S, 최종:E
		
		
		// 팀별 사업계획 조회. 기본PL
		if("S".equals(chkVal)){
			sbSql.delete(0, sbSql.length());
			sbSql.append("	SELECT   B.ACCT_CLASS, B.ACCT_CD, B.ACCT_NM,                                                                                                \n");
			sbSql.append("	         (                                                                                 													\n");
			sbSql.append("	           SUM(ROUND(A.MM_AMT_01 / 1000)) + SUM(ROUND(A.MM_AMT_02 / 1000)) + SUM(ROUND(A.MM_AMT_03 / 1000)) + 								\n");
			sbSql.append("	           SUM(ROUND(A.MM_AMT_04 / 1000)) + SUM(ROUND(A.MM_AMT_05 / 1000)) + SUM(ROUND(A.MM_AMT_06 / 1000)) + 								\n");
			sbSql.append("	           SUM(ROUND(A.MM_AMT_07 / 1000)) + SUM(ROUND(A.MM_AMT_08 / 1000)) + SUM(ROUND(A.MM_AMT_09 / 1000)) + 								\n");
			sbSql.append("	           SUM(ROUND(A.MM_AMT_10 / 1000)) + SUM(ROUND(A.MM_AMT_11 / 1000)) + SUM(ROUND(A.MM_AMT_12 / 1000))   								\n");
			sbSql.append("	         ) SUM_AMT,                                                                         												\n");
			sbSql.append("	           SUM(ROUND(A.MM_AMT_01 / 1000)) MM_AMT_01, SUM(ROUND(A.MM_AMT_02 / 1000)) MM_AMT_02, SUM(ROUND(A.MM_AMT_03 / 1000)) MM_AMT_03,    \n");
			sbSql.append("	           SUM(ROUND(A.MM_AMT_04 / 1000)) MM_AMT_04, SUM(ROUND(A.MM_AMT_05 / 1000)) MM_AMT_05, SUM(ROUND(A.MM_AMT_06 / 1000)) MM_AMT_06,    \n");
			sbSql.append("	           SUM(ROUND(A.MM_AMT_07 / 1000)) MM_AMT_07, SUM(ROUND(A.MM_AMT_08 / 1000)) MM_AMT_08, SUM(ROUND(A.MM_AMT_09 / 1000)) MM_AMT_09,    \n");
			sbSql.append("	           SUM(ROUND(A.MM_AMT_10 / 1000)) MM_AMT_10, SUM(ROUND(A.MM_AMT_11 / 1000)) MM_AMT_11, SUM(ROUND(A.MM_AMT_12 / 1000)) MM_AMT_12     \n");
			sbSql.append("            ,DECODE(B.ACCT_CLASS, '매출액', '1', '재료비', '2', '노무비', '3', '경비', '4') SKEY                                              \n");
			sbSql.append("	  FROM MAP_BIZ_PLAN2 A                                                                    												    \n");
			sbSql.append("	      ,(				          																				                            \n");
			sbSql.append("	        SELECT ACCT_CD          																				                            \n");
			sbSql.append("	              ,ACCT_NM                                                                                                                      \n");
			sbSql.append("	              ,ACCT_CLASS                                                                                                                   \n");
			sbSql.append("	          FROM (                                                                                                                            \n");
			sbSql.append("	                SELECT ACCTCD AS ACCT_CD                                                                                                    \n");
			sbSql.append("	                      ,ACCTNM6 AS ACCT_NM                                                                                                   \n");
			//sbSql.append("	                      ,DECODE(SUBSTR(ACCTCD,1,2), '41', '매출액', '42', '재료비', '43', '노무비/경비') ACCT_CLASS                           \n");
            //내부매출, 내부비용 추가 20151211  맹수영 시작
            sbSql.append("      ,CASE WHEN SUBSTR(ACCTCD,1,3) = '431' THEN '노무비' \n");
            sbSql.append("            WHEN ( ACCTCD = '43201120' ) OR ( ACCTCD = '43201130' )  OR ( ACCTCD = '43201140' )  OR ( ACCTCD = '43201150' )  OR ( ACCTCD = '43201160' )THEN '노무비'  \n");
            sbSql.append("            WHEN  ((SUBSTR(ACCTCD,1,2) = '41' ) OR ( ACCTCD = '98001010')) THEN '매출액'\n");
            sbSql.append("            WHEN  SUBSTR(ACCTCD,1,2) = '42' THEN '재료비'\n");
            sbSql.append("            ELSE \n");
            sbSql.append("            		'경비' \n");
            sbSql.append("           END ACCT_CLASS       \n");                   
            //내부매출, 내부비용 추가 20151211  맹수영 끝   
			sbSql.append("	                  FROM ST_ACCOUNT                                                                                                           \n");
			sbSql.append("	                 WHERE ACCT_TYPE1 = 'PL'                                                                                                    \n");
			sbSql.append("	                   AND USE_YN = 'Y'                                                                                                         \n");
			sbSql.append("	                   AND BU_CD = '2000'                                                                                                       \n");
			//sbSql.append("	                   AND SUBSTR(ACCTCD,1,2) IN ('41', '42')                                                                                   \n");
            //내부매출, 내부비용 추가 20151211  맹수영 시작
            sbSql.append("		           AND (SUBSTR(ACCTCD,1,2) IN ('41', '42') OR (ACCTCD = '98001010') ) -- 41 매출액, 42, 재료비, 4310 노무비 경비, 4320~ 경비 , 내부매출추가 \n");
            //내부매출, 내부비용 추가 20151211  맹수영 끝			
			sbSql.append("	                 UNION ALL                                                                                                                  \n");
			sbSql.append("	                SELECT ACCTCD AS ACCT_CD                                                                                                    \n");
			sbSql.append("	                      ,ACCTNM6 AS ACCT_NM                                                                                                   \n");
			//sbSql.append("	                      ,DECODE(SUBSTR(ACCTCD,1,3), '431', '노무비', '432', '경비', '경비') ACCT_CLASS                                        \n");
            //복리후생비 일부 노무비로 위치 변경 20151211  맹수영  시작                                                                   \n");
            sbSql.append("      ,CASE WHEN SUBSTR(ACCTCD,1,3) = '431' THEN '노무비' \n");
            sbSql.append("            WHEN ( ACCTCD = '43201120' ) OR ( ACCTCD = '43201130' )  OR ( ACCTCD = '43201140' )  OR ( ACCTCD = '43201150' )  OR ( ACCTCD = '43201160' )THEN '노무비'  \n");
            sbSql.append("            ELSE \n");
            sbSql.append("            		'경비' \n");
            sbSql.append("            END ACCT_CLASS     \n");
            //복리후생비 일부 노무비로 위치 변경 20151211  맹수영  끝			
			sbSql.append("	                  FROM ST_ACCOUNT                                                                                                           \n");
			sbSql.append("	                 WHERE ACCT_TYPE1 = 'PL'                                                                                                    \n");
			sbSql.append("	                   AND USE_YN = 'Y'                                                                                                         \n");
			sbSql.append("	                   AND BU_CD = '2000'                                                                                                       \n");
			//sbSql.append("	                   AND SUBSTR(ACCTCD,1,2) IN ('43')                                                                                         \n");
            //복리후생비 일부 노무비로 위치 변경 20151211  맹수영  시작                                                                        \n");
            sbSql.append("		           AND ( SUBSTR(ACCTCD,1,2) IN ('43') OR SUBSTR(ACCTCD,1,5) IN ('98002') )  -- 41 매출액, 42, 재료비, 4310 노무비 경비, 4320~ 경비 , 내부비용 추가   \n"); 
            //복리후생비 일부 노무비로 위치 변경 20151211  맹수영  끝
			sbSql.append("	                )                                                                                                                           \n");
			sbSql.append("	         ORDER BY ACCT_CD                                                                                                                   \n");
			sbSql.append("	       ) B	                                                                                                                                \n");
			sbSql.append("	 WHERE A.ACCT_CD(+) = B.ACCT_CD                                                                                                             \n");
			sbSql.append("	   AND A.YY(+) = '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'                                                                    \n");
			sbSql.append("	   AND A.TM_CD(+) = '" + nullToBlank(ds_Cond.getString(0, "TM_CD")) + "'                                                                    \n");
			sbSql.append("	   AND SUBSTR(A.BIZ_CLASS(+), -2) != '최종'                                                                                                 \n");
			sbSql.append("	 GROUP BY B.ACCT_CD, B.ACCT_NM, B.ACCT_CLASS                                                                                                \n");
			sbSql.append("	 ORDER BY SKEY, B.ACCT_CD, B.ACCT_NM                                                                                                              \n");
			
		}else{
			// 팀별 사업계획 조회. FC 최종PL
			if("0".equals(isData) ){
				sbSql.delete(0, sbSql.length());
				sbSql.append("	SELECT   B.ACCT_CLASS, B.ACCT_CD, B.ACCT_NM,                                                                                                \n");
				sbSql.append("	         (                                                                                 													\n");
				sbSql.append("	           SUM(ROUND(A.MM_AMT_01 / 1000)) + SUM(ROUND(A.MM_AMT_02 / 1000)) + SUM(ROUND(A.MM_AMT_03 / 1000)) + 								\n");
				sbSql.append("	           SUM(ROUND(A.MM_AMT_04 / 1000)) + SUM(ROUND(A.MM_AMT_05 / 1000)) + SUM(ROUND(A.MM_AMT_06 / 1000)) + 								\n");
				sbSql.append("	           SUM(ROUND(A.MM_AMT_07 / 1000)) + SUM(ROUND(A.MM_AMT_08 / 1000)) + SUM(ROUND(A.MM_AMT_09 / 1000)) + 								\n");
				sbSql.append("	           SUM(ROUND(A.MM_AMT_10 / 1000)) + SUM(ROUND(A.MM_AMT_11 / 1000)) + SUM(ROUND(A.MM_AMT_12 / 1000))   								\n");
				sbSql.append("	         ) SUM_AMT,                                                                         												\n");
				sbSql.append("	           SUM(ROUND(A.MM_AMT_01 / 1000)) MM_AMT_01, SUM(ROUND(A.MM_AMT_02 / 1000)) MM_AMT_02, SUM(ROUND(A.MM_AMT_03 / 1000)) MM_AMT_03,    \n");
				sbSql.append("	           SUM(ROUND(A.MM_AMT_04 / 1000)) MM_AMT_04, SUM(ROUND(A.MM_AMT_05 / 1000)) MM_AMT_05, SUM(ROUND(A.MM_AMT_06 / 1000)) MM_AMT_06,    \n");
				sbSql.append("	           SUM(ROUND(A.MM_AMT_07 / 1000)) MM_AMT_07, SUM(ROUND(A.MM_AMT_08 / 1000)) MM_AMT_08, SUM(ROUND(A.MM_AMT_09 / 1000)) MM_AMT_09,    \n");
				sbSql.append("	           SUM(ROUND(A.MM_AMT_10 / 1000)) MM_AMT_10, SUM(ROUND(A.MM_AMT_11 / 1000)) MM_AMT_11, SUM(ROUND(A.MM_AMT_12 / 1000)) MM_AMT_12     \n");
				sbSql.append("            ,DECODE(B.ACCT_CLASS, '매출액', '1', '재료비', '2', '노무비', '3', '경비', '4') SKEY                                              \n");				
				sbSql.append("	  FROM MAP_BIZ_PLAN2 A                                                                    												    \n");
				sbSql.append("	      ,(				          																				                            \n");
				sbSql.append("	        SELECT ACCT_CD          																				                            \n");
				sbSql.append("	              ,ACCT_NM                                                                                                                      \n");
				sbSql.append("	              ,ACCT_CLASS                                                                                                                   \n");
				sbSql.append("	          FROM (                                                                                                                            \n");				
				sbSql.append("	                SELECT ACCTCD AS ACCT_CD                                                                                                    \n");
				sbSql.append("	                      ,ACCTNM6 AS ACCT_NM                                                                                                   \n");
				//sbSql.append("	                      ,DECODE(SUBSTR(ACCTCD,1,2), '41', '매출액', '42', '재료비', '43', '노무비/경비') ACCT_CLASS                           \n");
	            //내부매출, 내부비용 추가 20151211  맹수영 시작
	            sbSql.append("      ,CASE WHEN SUBSTR(ACCTCD,1,3) = '431' THEN '노무비' \n");
	            sbSql.append("            WHEN ( ACCTCD = '43201120' ) OR ( ACCTCD = '43201130' )  OR ( ACCTCD = '43201140' )  OR ( ACCTCD = '43201150' )  OR ( ACCTCD = '43201160' )THEN '노무비'  \n");
	            sbSql.append("            WHEN  ((SUBSTR(ACCTCD,1,2) = '41' ) OR ( ACCTCD = '98001010')) THEN '매출액'\n");
	            sbSql.append("            WHEN  SUBSTR(ACCTCD,1,2) = '42' THEN '재료비'\n");
	            sbSql.append("            ELSE \n");
	            sbSql.append("            		'경비' \n");
	            sbSql.append("           END ACCT_CLASS       \n");                   
	            //내부매출, 내부비용 추가 20151211  맹수영 끝   
				sbSql.append("	                  FROM ST_ACCOUNT                                                                                                           \n");
				sbSql.append("	                 WHERE ACCT_TYPE1 = 'PL'                                                                                                    \n");
				sbSql.append("	                   AND USE_YN = 'Y'                                                                                                         \n");
				sbSql.append("	                   AND BU_CD = '2000'                                                                                                       \n");
				//sbSql.append("	                   AND SUBSTR(ACCTCD,1,2) IN ('41', '42')                                                                                   \n");
	            //내부매출, 내부비용 추가 20151211  맹수영 시작
	            sbSql.append("		           AND (SUBSTR(ACCTCD,1,2) IN ('41', '42') OR (ACCTCD = '98001010') ) -- 41 매출액, 42, 재료비, 4310 노무비 경비, 4320~ 경비 , 내부매출추가 \n");
	            //내부매출, 내부비용 추가 20151211  맹수영 끝			
				sbSql.append("	                 UNION ALL                                                                                                                  \n");
				sbSql.append("	                SELECT ACCTCD AS ACCT_CD                                                                                                    \n");
				sbSql.append("	                      ,ACCTNM6 AS ACCT_NM                                                                                                   \n");
				//sbSql.append("	                      ,DECODE(SUBSTR(ACCTCD,1,3), '431', '노무비', '432', '경비', '경비') ACCT_CLASS                                        \n");
	            //복리후생비 일부 노무비로 위치 변경 20151211  맹수영  시작                                                                   \n");
	            sbSql.append("      ,CASE WHEN SUBSTR(ACCTCD,1,3) = '431' THEN '노무비' \n");
	            sbSql.append("            WHEN ( ACCTCD = '43201120' ) OR ( ACCTCD = '43201130' )  OR ( ACCTCD = '43201140' )  OR ( ACCTCD = '43201150' )  OR ( ACCTCD = '43201160' )THEN '노무비'  \n");
	            sbSql.append("            ELSE \n");
	            sbSql.append("            		'경비' \n");
	            sbSql.append("            END ACCT_CLASS     \n");
	            //복리후생비 일부 노무비로 위치 변경 20151211  맹수영  끝			
				sbSql.append("	                  FROM ST_ACCOUNT                                                                                                           \n");
				sbSql.append("	                 WHERE ACCT_TYPE1 = 'PL'                                                                                                    \n");
				sbSql.append("	                   AND USE_YN = 'Y'                                                                                                         \n");
				sbSql.append("	                   AND BU_CD = '2000'                                                                                                       \n");
				//sbSql.append("	                   AND SUBSTR(ACCTCD,1,2) IN ('43')                                                                                         \n");
	            //복리후생비 일부 노무비로 위치 변경 20151211  맹수영  시작                                                                        \n");
	            sbSql.append("		           AND ( SUBSTR(ACCTCD,1,2) IN ('43') OR SUBSTR(ACCTCD,1,5) IN ('98002') )  -- 41 매출액, 42, 재료비, 4310 노무비 경비, 4320~ 경비 , 내부비용 추가   \n"); 
	            //복리후생비 일부 노무비로 위치 변경 20151211  맹수영  끝
				sbSql.append("	                )                                                                                                                           \n");
				sbSql.append("	         ORDER BY ACCT_CD                                                                                                                   \n");

				sbSql.append("	       ) B	                                                                                                                                \n");
				sbSql.append("	 WHERE A.ACCT_CD(+) = B.ACCT_CD                                                                                                             \n");
				sbSql.append("	   AND A.YY(+) = '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'                                                                    \n");
				sbSql.append("	   AND A.TM_CD(+) = '" + nullToBlank(ds_Cond.getString(0, "TM_CD")) + "'                                                                    \n");
				sbSql.append("	   AND SUBSTR(A.BIZ_CLASS(+), -2) = '최종'                                                                                                  \n");
				sbSql.append("	 GROUP BY B.ACCT_CD, B.ACCT_NM, B.ACCT_CLASS                                                                                                \n");
				sbSql.append("	 ORDER BY SKEY, B.ACCT_CD, B.ACCT_NM                                                                                                              \n");
				
			}else{
				// 팀별 사업계획 조회. BPC 최종PL
				sbSql.delete(0, sbSql.length());
				sbSql.append("	SELECT   B.ACCT_CLASS, B.ACCT_CD, B.ACCT_NM,    																																														\n");	
				sbSql.append("	         (                                                                                 													                        \n");
				sbSql.append("	           SUM(ROUND(A.MM_AMT_01 / 1000)) + SUM(ROUND(A.MM_AMT_02 / 1000)) + SUM(ROUND(A.MM_AMT_03 / 1000)) + 								              \n");
				sbSql.append("	           SUM(ROUND(A.MM_AMT_04 / 1000)) + SUM(ROUND(A.MM_AMT_05 / 1000)) + SUM(ROUND(A.MM_AMT_06 / 1000)) + 								              \n");
				sbSql.append("	           SUM(ROUND(A.MM_AMT_07 / 1000)) + SUM(ROUND(A.MM_AMT_08 / 1000)) + SUM(ROUND(A.MM_AMT_09 / 1000)) + 								              \n");
				sbSql.append("	           SUM(ROUND(A.MM_AMT_10 / 1000)) + SUM(ROUND(A.MM_AMT_11 / 1000)) + SUM(ROUND(A.MM_AMT_12 / 1000))   								              \n");
				sbSql.append("	         ) SUM_AMT,                                                                         													                      \n");
				sbSql.append("	           SUM(ROUND(A.MM_AMT_01 / 1000)) MM_AMT_01, SUM(ROUND(A.MM_AMT_02 / 1000)) MM_AMT_02, SUM(ROUND(A.MM_AMT_03 / 1000)) MM_AMT_03,    \n");
				sbSql.append("	           SUM(ROUND(A.MM_AMT_04 / 1000)) MM_AMT_04, SUM(ROUND(A.MM_AMT_05 / 1000)) MM_AMT_05, SUM(ROUND(A.MM_AMT_06 / 1000)) MM_AMT_06,    \n");
				sbSql.append("	           SUM(ROUND(A.MM_AMT_07 / 1000)) MM_AMT_07, SUM(ROUND(A.MM_AMT_08 / 1000)) MM_AMT_08, SUM(ROUND(A.MM_AMT_09 / 1000)) MM_AMT_09,    \n");
				sbSql.append("	           SUM(ROUND(A.MM_AMT_10 / 1000)) MM_AMT_10, SUM(ROUND(A.MM_AMT_11 / 1000)) MM_AMT_11, SUM(ROUND(A.MM_AMT_12 / 1000)) MM_AMT_12     \n");
				sbSql.append("            ,DECODE(A.ACCT_CLASS, '매출액', '1', '재료비', '2', '노무비', '3', '경비', '4') SKEY                                              \n");				
				sbSql.append("	  FROM MAP_BPC_CONFIRM_PL_INFO A                                                                    												                \n");
				sbSql.append("	      ,(				          																				                                                                          \n");
				sbSql.append("	        SELECT A.ACCT_CD                                                                                                                    \n");
				sbSql.append("	              ,A.ACCT_NM                                                                                                                    \n");
				sbSql.append("	              ,A.ACCT_CLASS                                                                                                                 \n");
				sbSql.append("	              ,B.YY                                                                                                                         \n");
				sbSql.append("	              ,B.TM_CD                                                                                                                      \n");
				sbSql.append("	          FROM (                                                                                                                            \n");
				sbSql.append("	                SELECT ACCTCD AS ACCT_CD                                                                                                    \n");
				sbSql.append("	                      ,ACCTNM6 AS ACCT_NM                                                                                                   \n");
				//sbSql.append("	                      ,DECODE(SUBSTR(ACCTCD,1,2), '41', '매출액', '42', '재료비', '43', '노무비/경비') ACCT_CLASS                           \n");
	            //내부매출, 내부비용 추가 20151211  맹수영 시작
	            sbSql.append("      ,CASE WHEN SUBSTR(ACCTCD,1,3) = '431' THEN '노무비' \n");
	            sbSql.append("            WHEN ( ACCTCD = '43201120' ) OR ( ACCTCD = '43201130' )  OR ( ACCTCD = '43201140' )  OR ( ACCTCD = '43201150' )  OR ( ACCTCD = '43201160' )THEN '노무비'  \n");
	            sbSql.append("            WHEN  ((SUBSTR(ACCTCD,1,2) = '41' ) OR ( ACCTCD = '98001010')) THEN '매출액'\n");
	            sbSql.append("            WHEN  SUBSTR(ACCTCD,1,2) = '42' THEN '재료비'\n");
	            sbSql.append("            ELSE \n");
	            sbSql.append("            		'경비' \n");
	            sbSql.append("           END ACCT_CLASS       \n");                   
	            //내부매출, 내부비용 추가 20151211  맹수영 끝   
				sbSql.append("	                  FROM ST_ACCOUNT                                                                                                           \n");
				sbSql.append("	                 WHERE ACCT_TYPE1 = 'PL'                                                                                                    \n");
				sbSql.append("	                   AND USE_YN = 'Y'                                                                                                         \n");
				sbSql.append("	                   AND BU_CD = '2000'                                                                                                       \n");
				//sbSql.append("	                   AND SUBSTR(ACCTCD,1,2) IN ('41', '42')                                                                                   \n");
	            //내부매출, 내부비용 추가 20151211  맹수영 시작
	            sbSql.append("		           AND (SUBSTR(ACCTCD,1,2) IN ('41', '42') OR (ACCTCD = '98001010') ) -- 41 매출액, 42, 재료비, 4310 노무비 경비, 4320~ 경비 , 내부매출추가 \n");
	            //내부매출, 내부비용 추가 20151211  맹수영 끝			
				sbSql.append("	                 UNION ALL                                                                                                                  \n");
				sbSql.append("	                SELECT ACCTCD AS ACCT_CD                                                                                                    \n");
				sbSql.append("	                      ,ACCTNM6 AS ACCT_NM                                                                                                   \n");
				//sbSql.append("	                      ,DECODE(SUBSTR(ACCTCD,1,3), '431', '노무비', '432', '경비', '경비') ACCT_CLASS                                        \n");
	            //복리후생비 일부 노무비로 위치 변경 20151211  맹수영  시작                                                                   \n");
	            sbSql.append("      ,CASE WHEN SUBSTR(ACCTCD,1,3) = '431' THEN '노무비' \n");
	            sbSql.append("            WHEN ( ACCTCD = '43201120' ) OR ( ACCTCD = '43201130' )  OR ( ACCTCD = '43201140' )  OR ( ACCTCD = '43201150' )  OR ( ACCTCD = '43201160' )THEN '노무비'  \n");
	            sbSql.append("            ELSE \n");
	            sbSql.append("            		'경비' \n");
	            sbSql.append("            END ACCT_CLASS     \n");
	            //복리후생비 일부 노무비로 위치 변경 20151211  맹수영  끝			
				sbSql.append("	                  FROM ST_ACCOUNT                                                                                                           \n");
				sbSql.append("	                 WHERE ACCT_TYPE1 = 'PL'                                                                                                    \n");
				sbSql.append("	                   AND USE_YN = 'Y'                                                                                                         \n");
				sbSql.append("	                   AND BU_CD = '2000'                                                                                                       \n");
				//sbSql.append("	                   AND SUBSTR(ACCTCD,1,2) IN ('43')                                                                                         \n");
	            //복리후생비 일부 노무비로 위치 변경 20151211  맹수영  시작                                                                        \n");
	            sbSql.append("		           AND ( SUBSTR(ACCTCD,1,2) IN ('43') OR SUBSTR(ACCTCD,1,5) IN ('98002') )  -- 41 매출액, 42, 재료비, 4310 노무비 경비, 4320~ 경비 , 내부비용 추가   \n"); 
	            //복리후생비 일부 노무비로 위치 변경 20151211  맹수영  끝
				sbSql.append("	                ) A                                                                                                                         \n");
				sbSql.append("	               ,MAP_BIZ_PLAN B                                                                                                              \n");
				sbSql.append("	         WHERE A.ACCT_CLASS  = B.ACCT_CLASS(+)                                                                                              \n");
				sbSql.append("	           AND A.ACCT_CD = B.ACCT_CD(+)                                                                                                     \n");
				sbSql.append("	           AND B.YY(+) = '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'                                               				\n");
				sbSql.append("	           AND B.TM_CD(+) = '" + nullToBlank(ds_Cond.getString(0, "TM_CD")) + "'                                                            \n");
				sbSql.append("	           AND SUBSTR(B.BIZ_CLASS(+), -2) = '최종'                                                                                          \n");
				sbSql.append("	         GROUP BY A.ACCT_CD, A.ACCT_NM, A.ACCT_CLASS, B.YY, B.TM_CD                                                                         \n");
				sbSql.append("	         ORDER BY A.ACCT_CD                                                                                                                 \n");
				sbSql.append("	       ) B                                                                                                                                  \n");
				sbSql.append("	 WHERE A.ACCT_CD(+) = B.ACCT_CD                                                                                                             \n");
				sbSql.append("	   AND A.PLAN_YEAR(+) = B.YY                                                                                                                \n");
				sbSql.append("	   AND A.PLAN_YEAR(+) = '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'                                                             \n");
				sbSql.append("	 GROUP BY B.ACCT_CD, B.ACCT_NM, B.ACCT_CLASS                                                                                                \n");
				sbSql.append("	 ORDER BY SKEY, B.ACCT_CD, B.ACCT_NM                                                                                                              \n");				
				
			}
			
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