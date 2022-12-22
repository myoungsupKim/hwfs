<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 사업계획관리
■ 프로그램ID   : MAP30120E_T001.jsp
■ 프로그램명   : 사업계획 개선과제 관리
■ 작성일자     : 2015-06-23
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
		//String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		//String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		//String g_Yy     	= nullToBlank(in_vl.getString("g_Yy"));
		
		//FileLog.println("d:\\aaa.txt", ds_Cond);

		//out 데이타
		DataSet ds_List;
		
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		
		sbSql.delete(0, sbSql.length());
		///*
		sbSql.append("SELECT '1' CHK, BIZ_CLASS, UPJANG, YY, 'ALL' ACCT_CLASS	 											\n");
		sbSql.append("      ,'ALL' ACCT_CD, 'ALL' ACCT_NM, '' APPLY_ST_DT, '' APPLY_ND_DT, 'S' AS APPROV_YN					\n");
		sbSql.append("      ,'' IMPROV_MGRP, '' IMPROV_MCALSS, '' IMPROV_SCLASS, 0 IMPROV_THEME_SEQ, 0 REV_SEQ 			\n");
		sbSql.append("      ,0 AS MM_AMT_01, 0 AS MM_AMT_02, 0 AS MM_AMT_03, 0 AS MM_AMT_04, 0 AS MM_AMT_05, 0 AS MM_AMT_06	\n");
		sbSql.append("      ,0 AS MM_AMT_07, 0 AS MM_AMT_08, 0 AS MM_AMT_09, 0 AS MM_AMT_10, 0 AS MM_AMT_11, 0 AS MM_AMT_12	\n");
		sbSql.append("  FROM MAP_BIZ_LOG_MGMT																				\n");
		sbSql.append(" WHERE UPJANG = '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'									\n");
		sbSql.append("   AND YY = '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'									\n");
		sbSql.append("   AND BIZ_CLASS = '" + nullToBlank(ds_Cond.getString(0, "BIZ_CLASS"))  + "'							\n");
		sbSql.append("   AND CONFIRM_YN = 'Y'																				\n");
		sbSql.append("   AND ORGIN_YN = 'Y'																					\n");
		sbSql.append(" UNION ALL																							\n");		
		//*/
		sbSql.append("SELECT T2.CHECK_YN AS CHK, T1.DTL_IMPROV_THEME AS BIZ_CLASS, T1.UPJANG, T1.IMPROV_YEAR AS YY			\n");
		sbSql.append("      ,'ALL' ACCT_CLASS, T2.ACCT_CD, T3.ACCT_NM, '' APPLY_ST_DT, '' APPLY_ND_DT, T1.APPROV_YN			\n");
		sbSql.append("      ,T2.IMPROV_MGRP, T2.IMPROV_MCALSS, T2.IMPROV_SCLASS, T2.IMPROV_THEME_SEQ, T2.REV_SEQ 			\n");
		/*
		sbSql.append("      ,ROUND(T2.MM_IMPROV_AMT_01 / 1000) AS MM_AMT_01													\n");
		sbSql.append("      ,ROUND(T2.MM_IMPROV_AMT_02 / 1000) AS MM_AMT_02													\n");
		sbSql.append("      ,ROUND(T2.MM_IMPROV_AMT_03 / 1000) AS MM_AMT_03													\n");
		sbSql.append("      ,ROUND(T2.MM_IMPROV_AMT_04 / 1000) AS MM_AMT_04													\n");
		sbSql.append("      ,ROUND(T2.MM_IMPROV_AMT_05 / 1000) AS MM_AMT_05													\n");
		sbSql.append("      ,ROUND(T2.MM_IMPROV_AMT_06 / 1000) AS MM_AMT_06													\n");
		sbSql.append("      ,ROUND(T2.MM_IMPROV_AMT_07 / 1000) AS MM_AMT_07													\n");
		sbSql.append("      ,ROUND(T2.MM_IMPROV_AMT_08 / 1000) AS MM_AMT_08													\n");
		sbSql.append("      ,ROUND(T2.MM_IMPROV_AMT_09 / 1000) AS MM_AMT_09													\n");
		sbSql.append("      ,ROUND(T2.MM_IMPROV_AMT_10 / 1000) AS MM_AMT_10													\n");
		sbSql.append("      ,ROUND(T2.MM_IMPROV_AMT_11 / 1000) AS MM_AMT_11													\n");
		sbSql.append("      ,ROUND(T2.MM_IMPROV_AMT_12 / 1000) AS MM_AMT_12													\n");
		*/
		sbSql.append("      ,ROUND(T2.MM_IMPROV_AMT_01) AS MM_AMT_01													\n");
		sbSql.append("      ,ROUND(T2.MM_IMPROV_AMT_02) AS MM_AMT_02													\n");
		sbSql.append("      ,ROUND(T2.MM_IMPROV_AMT_03) AS MM_AMT_03													\n");
		sbSql.append("      ,ROUND(T2.MM_IMPROV_AMT_04) AS MM_AMT_04													\n");
		sbSql.append("      ,ROUND(T2.MM_IMPROV_AMT_05) AS MM_AMT_05													\n");
		sbSql.append("      ,ROUND(T2.MM_IMPROV_AMT_06) AS MM_AMT_06													\n");
		sbSql.append("      ,ROUND(T2.MM_IMPROV_AMT_07) AS MM_AMT_07													\n");
		sbSql.append("      ,ROUND(T2.MM_IMPROV_AMT_08) AS MM_AMT_08													\n");
		sbSql.append("      ,ROUND(T2.MM_IMPROV_AMT_09) AS MM_AMT_09													\n");
		sbSql.append("      ,ROUND(T2.MM_IMPROV_AMT_10) AS MM_AMT_10													\n");
		sbSql.append("      ,ROUND(T2.MM_IMPROV_AMT_11) AS MM_AMT_11													\n");
		sbSql.append("      ,ROUND(T2.MM_IMPROV_AMT_12) AS MM_AMT_12													\n");
		
		sbSql.append("  FROM MAP_IMPROV_MGT_MST T1																			\n");
		sbSql.append("  	,MAP_IMPROV_PL_DTL  T2																			\n");
		sbSql.append("	   ,(				          																				  \n");
		sbSql.append("		SELECT ACCT_CD          																				  \n");
		sbSql.append("		      ,ACCT_NM                                                                                            \n");
		sbSql.append("		      ,ACCT_CLASS                                                                                         \n");
		sbSql.append("		  FROM (                                                                                                  \n");
		sbSql.append("		        SELECT ACCTCD AS ACCT_CD                                                                          \n");
		sbSql.append("		              ,ACCTNM6 AS ACCT_NM                                                                         \n");
		//sbSql.append("		              ,DECODE(SUBSTR(ACCTCD,1,2), '41', '매출액', '42', '재료비', '43', '노무비/경비') ACCT_CLASS \n");
        //내부매출, 내부비용 추가 20151211  맹수영 시작
        sbSql.append("      ,CASE WHEN SUBSTR(ACCTCD,1,3) = '431' THEN '노무비' \n");
        sbSql.append("            WHEN ( ACCTCD = '43201120' ) OR ( ACCTCD = '43201130' )  OR ( ACCTCD = '43201140' )  OR ( ACCTCD = '43201150' )  OR ( ACCTCD = '43201160' )THEN '노무비'  \n");
        sbSql.append("            WHEN  ((SUBSTR(ACCTCD,1,2) = '41' ) OR ( ACCTCD = '98001010')) THEN '매출액'\n");
        sbSql.append("            WHEN  SUBSTR(ACCTCD,1,2) = '42' THEN '재료비'\n");
        sbSql.append("            ELSE \n");
        sbSql.append("            		'경비' \n");
        sbSql.append("           END ACCT_CLASS       \n");
        //내부매출, 내부비용 추가 20151211  맹수영 끝

		sbSql.append("		          FROM ST_ACCOUNT                                                                                 \n");
		sbSql.append("		         WHERE ACCT_TYPE1 = 'PL'                                                                          \n");
		sbSql.append("		           AND USE_YN = 'Y'                                                                               \n");
		sbSql.append("		           AND BU_CD = '2000'                                                                             \n");
		//sbSql.append("		           AND SUBSTR(ACCTCD,1,2) IN ('41', '42') -- 41 매출액, 42, 재료비, 4310 노무비 경비, 4320~ 경비  \n");
        //내부매출, 내부비용 추가 20151211  맹수영 시작
        //sbSql.append("		           AND SUBSTR(ACCTCD,1,2) IN ('41', '42') -- 41 매출액, 42, 재료비, 4310 노무비 경비, 4320~ 경비  \n");
        sbSql.append("		           AND (SUBSTR(ACCTCD,1,2) IN ('41', '42') OR (ACCTCD = '98001010') ) -- 41 매출액, 42, 재료비, 4310 노무비 경비, 4320~ 경비 , 내부매출추가 \n");
        //내부매출, 내부비용 추가 20151211  맹수영 끝
		
		sbSql.append("		         UNION ALL                                                                                        \n");
		sbSql.append("		        SELECT ACCTCD AS ACCT_CD                                                                          \n");
		sbSql.append("		              ,ACCTNM6 AS ACCT_NM                                                                         \n");
		//sbSql.append("		              ,DECODE(SUBSTR(ACCTCD,1,3), '431', '노무비', '432', '경비', '경비') ACCT_CLASS              \n");
        //복리후생비 일부 노무비로 위치 변경 20151211  맹수영  시작                                                                   \n");
        sbSql.append("      ,CASE WHEN SUBSTR(ACCTCD,1,3) = '431' THEN '노무비' \n");
        sbSql.append("            WHEN ( ACCTCD = '43201120' ) OR ( ACCTCD = '43201130' )  OR ( ACCTCD = '43201140' )  OR ( ACCTCD = '43201150' )  OR ( ACCTCD = '43201160' )THEN '노무비'  \n");
        sbSql.append("            ELSE \n");
        sbSql.append("            		'경비' \n");
        sbSql.append("            END ACCT_CLASS     \n");
        //복리후생비 일부 노무비로 위치 변경 20151211  맹수영  끝
		sbSql.append("		          FROM ST_ACCOUNT                                                                                 \n");
		sbSql.append("		         WHERE ACCT_TYPE1 = 'PL'                                                                          \n");
		sbSql.append("		           AND USE_YN = 'Y'                                                                               \n");
		sbSql.append("		           AND BU_CD = '2000'                                                                             \n");
		//sbSql.append("		           AND SUBSTR(ACCTCD,1,2) IN ('43') -- 41 매출액, 42, 재료비, 4310 노무비 경비, 4320~ 경비        \n");
        //복리후생비 일부 노무비로 위치 변경 20151211  맹수영  시작                                                                        \n");
        sbSql.append("		           AND ( SUBSTR(ACCTCD,1,2) IN ('43') OR SUBSTR(ACCTCD,1,5) IN ('98002') )  -- 41 매출액, 42, 재료비, 4310 노무비 경비, 4320~ 경비 , 내부비용 추가   \n");
        //복리후생비 일부 노무비로 위치 변경 20151211  맹수영  끝
		sbSql.append("		        )                                                                                                 \n");
		sbSql.append("		 ORDER BY ACCT_CD                                                                                         \n");
		sbSql.append("	    ) T3		  																							  \n");
		sbSql.append(" WHERE  T1.IMPROV_YEAR      = T2.IMPROV_YEAR																	  \n");
		sbSql.append("   AND T1.UPJANG           = T2.UPJANG																		  \n");
		sbSql.append("   AND T1.IMPROV_MGRP      = T2.IMPROV_MGRP																	  \n");
		sbSql.append("   AND T1.IMPROV_MCALSS    = T2.IMPROV_MCALSS																	  \n");
		sbSql.append("   AND T1.IMPROV_SCLASS    = T2.IMPROV_SCLASS																	  \n");
		sbSql.append("   AND T1.IMPROV_THEME_SEQ = T2.IMPROV_THEME_SEQ																  \n");
		sbSql.append("   AND T1.REV_SEQ          = T2.REV_SEQ																		  \n");
		sbSql.append("   AND T2.ACCT_CD          = T3.ACCT_CD																		  \n");
		//sbSql.append("   AND T1.APPROV_YN = 'Y'																						  \n");
		sbSql.append("   AND T1.UPJANG = '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'										  \n");
		//sbSql.append("   AND '" + ds_Cond.getString(0, "INPUT_YMD") + "' BETWEEN T1.APPLY_ST_DT AND T1.APPLY_ND_DT					  \n");
		sbSql.append("   AND SUBSTR('" + ds_Cond.getString(0, "INPUT_YMD") + "',1,4) BETWEEN  SUBSTR(T1.APPLY_ST_DT,1,4) AND  SUBSTR(T1.APPLY_ND_DT,1,4)					  \n");
		
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