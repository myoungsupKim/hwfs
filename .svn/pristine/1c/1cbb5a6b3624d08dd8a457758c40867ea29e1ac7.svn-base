
<%
    /*-----------------------------------------------------------------------------
    ■ 시스템명     : 사업계획관리
    ■ 프로그램ID   : MAP30030E_T001.jsp
    ■ 프로그램명   : 일계획 관리
    ■ 작성일자     : 2015-06-24
    ■ 작성자       : 김태윤
    ■ 이력관리     :
    -----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="../../sc/main/common.jsp"%>
<%
    try {
        PlatformRequest platformRequest = this.proc_input(request);
        in_vl = platformRequest.getData().getVariableList();
        in_dl = platformRequest.getData().getDataSetList();

        //jsp log 서비스 시작
        logger.startIndividualLog(in_vl.getString("titLogId"));

        //입력 데이타
        DataSet ds_Cond = in_dl.get("ds_Cond");
        //입력 파라메터
        String g_Upjang = nullToBlank(in_vl.getString("g_Upjang"));
        String g_EmpNo = nullToBlank(in_vl.getString("g_EmpNo"));
        String g_Yy = nullToBlank(in_vl.getString("g_Yy"));

        //FileLog.println("d:\\aaa.txt", ds_Cond);

        //out 데이타
        DataSet ds_List;

        //sql문 버퍼생성
        StringBuffer sbSql = new StringBuffer();

        // 일계획 입력여부 조회.
        sbSql.append("SELECT COUNT(1) ISDATA  																	\n");
        sbSql.append("  FROM MAP_DAY_LOG_MGMT																	\n");
        sbSql.append(" 	     WHERE UPJANG ='" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'	  			\n");
        sbSql.append(" 		   AND YY = SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 1, 4)	\n");
        sbSql.append(" 		   AND MM = SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 5, 2)	\n");
        //sbSql.append(" 		   AND DD = '" + nullToBlank(ds_Cond.getString(0, "INPUT_DD")) + "'					\n");
        sbSql.append("   	   AND DAY_CLASS = '" + nullToBlank(ds_Cond.getString(0, "DAY_CLASS")) + "'			\n");

        pstmt = conn.prepareStatement(sbSql.toString());
        rs = pstmt.executeQuery();

        rs.next();

        String isData = rs.getString("ISDATA");

        if ("0".equals(isData)) {
        	
        	//2018.03.15 김명섭 최종버젼 정보 조회되도록 개선
            sbSql.delete(0, sbSql.length());
            sbSql.append(" SELECT MAX(VER_CD) VER_CD FROM MAP_BPC_MODIFY_PLAN	\n");
            sbSql.append(" 	WHERE PLAN_YEAR = SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 1, 4)	\n");
            sbSql.append(" 	  AND PLAN_CLASS = 'AP'	\n");
            sbSql.append(" 	  AND BPC_CONFIRM_YN = 'Y'	\n");
            pstmt = conn.prepareStatement(sbSql.toString());
            rs = pstmt.executeQuery();
            rs.next();
            String strVercd = rs.getString("VER_CD");
            
            // 월추정값은 관리금액임으로 그대로 사용한다.
            sbSql.delete(0, sbSql.length());
            sbSql.append(" SELECT *	\n");
            sbSql.append("   FROM (	\n");
            //sbSql.append(" SELECT *	\n");
            //sbSql.append("   FROM (	\n");
            sbSql.append(" SELECT A.SEQ, A.ACCT_CLASS, A.ACCT_NM, A.ACCT_CD, A.CC_CD, '' AS YMD, A.YY, 'N' CONFIRM_YN, '' AS DAY_CLASS, B.P_DATE	\n");
            //sbSql.append("       ,DECODE(A.ACCT_CLASS, '매출액', '1', '재료비', '2', '노무비', '3', '경비', '4') SKEY	\n"); //-- 소계
            sbSql.append("       ,ROUND((A.MM_AMT / 1000)) SUM_AMT	 									\n"); //-- 추가 계정별 월 합계
            sbSql.append("       ,ROUND((A.MM_AMT / 1000)) MM_AMT	 									\n"); //-- 계정별 월 합계
            sbSql.append("       ,ROUND(((MM_AMT / LAST_DD_CNT) / 1000), 0) DD_AMT						\n"); //-- 계정별 월일의 1/N
            sbSql.append("   FROM (																		\n");

            /*
            sbSql.append("         SELECT A.ACCT_CLASS, A.ACCT_NM, A.ACCT_CD, A.CC_CD, A.YY				\n");
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
            sbSql.append("           FROM MAP_MON_PLAN A																\n");
            sbSql.append("           	 ,MAP_MON_LOG_MGMT B															\n");
            sbSql.append("               ,(	SELECT UPJANG, YY, BIZ_CLASS												\n");
            sbSql.append("                    FROM MAP_MON_LOG_MGMT														\n");
            // 마직막 적용 대상을 찾는다.
            sbSql.append("                   WHERE UDATE = ( SELECT MAX(UDATE) UDATE									\n");
            sbSql.append("                      			   FROM MAP_MON_LOG_MGMT									\n");
            sbSql.append("                      			  WHERE UPJANG = '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'	\n");
            sbSql.append("            							AND YY = SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 1, 4)\n");
            sbSql.append("   		  							AND CONFIRM_YN = '" + "Y" + "'							\n");
            sbSql.append("                      			)															\n");
            sbSql.append("                )	C																			\n");
            sbSql.append("          WHERE A.UPJANG = B.UPJANG															\n");
            sbSql.append("   		  AND A.YY = B.YY																	\n");
            sbSql.append("   		  AND A.BIZ_CLASS = B.BIZ_CLASS														\n");
            sbSql.append("            AND B.UPJANG = C.UPJANG															\n");
            sbSql.append("   		  AND B.YY = C.YY																	\n");
            sbSql.append("   		  AND B.BIZ_CLASS = C.BIZ_CLASS														\n");
            sbSql.append("            AND A.UPJANG = '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'				\n");
            sbSql.append("            AND A.YY = SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 1, 4)	\n");
            sbSql.append("   		  AND B.CONFIRM_YN = '" + "Y" + "'													\n");
            */
            // 관리금액
            if("M".equals(ds_Cond.getString(0, "CLOSE_TYPE"))){
                sbSql.append(" SELECT B.SEQ, B.ACCT_CLASS                        																	  \n");
                sbSql.append("       ,B.ACCT_NM, B.ACCT_CD, '" + nullToBlank(ds_Cond.getString(0, "CC_CD")) + "' AS CC_CD, A.PLAN_YEAR AS YY  \n");
                sbSql.append("       ,SUBSTR(TO_CHAR(LAST_DAY('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'||'01' ),'YYYYMMDD'), 7,2) LAST_DD_CNT	\n");
                //2018.03.19 김명섭 업장출하율조회개선:마스터데이터없을경우 1로 디폴트세팅
                sbSql.append("       ,(CASE WHEN SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 5, 2) = '01' THEN CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN ROUND(A.MM_AMT_01	* NVL((SELECT  NVL(MM_MARGIN_RATE_01/ 100,1) FROM MAP_MARGIN_RATE_MGMT WHERE A.PLAN_YEAR = YY AND UPJANG = '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'	 AND CLASS = 'P'),1)) ELSE A.MM_AMT_01 END	\n");
                sbSql.append("              WHEN SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 5, 2) = '02' THEN CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN ROUND(A.MM_AMT_02	* NVL((SELECT  NVL(MM_MARGIN_RATE_02/ 100,1) FROM MAP_MARGIN_RATE_MGMT WHERE A.PLAN_YEAR = YY AND UPJANG = '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'	 AND CLASS = 'P'),1)) ELSE A.MM_AMT_02 END	\n");
                sbSql.append("              WHEN SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 5, 2) = '03' THEN CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN ROUND(A.MM_AMT_03	* NVL((SELECT  NVL(MM_MARGIN_RATE_03/ 100,1) FROM MAP_MARGIN_RATE_MGMT WHERE A.PLAN_YEAR = YY AND UPJANG = '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'	 AND CLASS = 'P'),1)) ELSE A.MM_AMT_03 END	\n");
                sbSql.append("              WHEN SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 5, 2) = '04' THEN CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN ROUND(A.MM_AMT_04	* NVL((SELECT  NVL(MM_MARGIN_RATE_04/ 100,1) FROM MAP_MARGIN_RATE_MGMT WHERE A.PLAN_YEAR = YY AND UPJANG = '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'	 AND CLASS = 'P'),1)) ELSE A.MM_AMT_04 END	\n");
                sbSql.append("              WHEN SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 5, 2) = '05' THEN CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN ROUND(A.MM_AMT_05	* NVL((SELECT  NVL(MM_MARGIN_RATE_05/ 100,1) FROM MAP_MARGIN_RATE_MGMT WHERE A.PLAN_YEAR = YY AND UPJANG = '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'	 AND CLASS = 'P'),1)) ELSE A.MM_AMT_05 END	\n");
                sbSql.append("              WHEN SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 5, 2) = '06' THEN CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN ROUND(A.MM_AMT_06	* NVL((SELECT  NVL(MM_MARGIN_RATE_06/ 100,1) FROM MAP_MARGIN_RATE_MGMT WHERE A.PLAN_YEAR = YY AND UPJANG = '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'	 AND CLASS = 'P'),1)) ELSE A.MM_AMT_06 END	\n");
                sbSql.append("              WHEN SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 5, 2) = '07' THEN CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN ROUND(A.MM_AMT_07	* NVL((SELECT  NVL(MM_MARGIN_RATE_07/ 100,1) FROM MAP_MARGIN_RATE_MGMT WHERE A.PLAN_YEAR = YY AND UPJANG = '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'	 AND CLASS = 'P'),1)) ELSE A.MM_AMT_07 END	\n");
                sbSql.append("              WHEN SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 5, 2) = '08' THEN CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN ROUND(A.MM_AMT_08	* NVL((SELECT  NVL(MM_MARGIN_RATE_08/ 100,1) FROM MAP_MARGIN_RATE_MGMT WHERE A.PLAN_YEAR = YY AND UPJANG = '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'	 AND CLASS = 'P'),1)) ELSE A.MM_AMT_08 END	\n");
                sbSql.append("              WHEN SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 5, 2) = '09' THEN CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN ROUND(A.MM_AMT_09	* NVL((SELECT  NVL(MM_MARGIN_RATE_09/ 100,1) FROM MAP_MARGIN_RATE_MGMT WHERE A.PLAN_YEAR = YY AND UPJANG = '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'	 AND CLASS = 'P'),1)) ELSE A.MM_AMT_09 END	\n");
                sbSql.append("              WHEN SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 5, 2) = '10' THEN CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN ROUND(A.MM_AMT_10	* NVL((SELECT  NVL(MM_MARGIN_RATE_10/ 100,1) FROM MAP_MARGIN_RATE_MGMT WHERE A.PLAN_YEAR = YY AND UPJANG = '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'	 AND CLASS = 'P'),1)) ELSE A.MM_AMT_10 END	\n");
                sbSql.append("              WHEN SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 5, 2) = '11' THEN CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN ROUND(A.MM_AMT_11	* NVL((SELECT  NVL(MM_MARGIN_RATE_11/ 100,1) FROM MAP_MARGIN_RATE_MGMT WHERE A.PLAN_YEAR = YY AND UPJANG = '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'	 AND CLASS = 'P'),1)) ELSE A.MM_AMT_11 END	\n");
                sbSql.append("              WHEN SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 5, 2) = '12' THEN CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN ROUND(A.MM_AMT_12	* NVL((SELECT  NVL(MM_MARGIN_RATE_12/ 100,1) FROM MAP_MARGIN_RATE_MGMT WHERE A.PLAN_YEAR = YY AND UPJANG = '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'	 AND CLASS = 'P'),1)) ELSE A.MM_AMT_12 END	\n");
                sbSql.append("              ELSE 0																							  	\n");
                sbSql.append("               END																								\n");
                sbSql.append("         ) AS MM_AMT																								\n");
                            	
            
            } else
            {
            sbSql.append(" SELECT B.SEQ, B.ACCT_CLASS                        																	  \n");
            sbSql.append("       ,B.ACCT_NM, B.ACCT_CD, '" + nullToBlank(ds_Cond.getString(0, "CC_CD")) + "' AS CC_CD, A.PLAN_YEAR AS YY  \n");
            sbSql.append("       ,SUBSTR(TO_CHAR(LAST_DAY('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'||'01' ),'YYYYMMDD'), 7,2) LAST_DD_CNT	\n");
            sbSql.append("       ,(CASE WHEN SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 5, 2) = '01' THEN A.MM_AMT_01	\n");
            sbSql.append("              WHEN SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 5, 2) = '02' THEN A.MM_AMT_02	\n");
            sbSql.append("              WHEN SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 5, 2) = '03' THEN A.MM_AMT_03	\n");
            sbSql.append("              WHEN SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 5, 2) = '04' THEN A.MM_AMT_04	\n");
            sbSql.append("              WHEN SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 5, 2) = '05' THEN A.MM_AMT_05	\n");
            sbSql.append("              WHEN SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 5, 2) = '06' THEN A.MM_AMT_06	\n");
            sbSql.append("              WHEN SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 5, 2) = '07' THEN A.MM_AMT_07	\n");
            sbSql.append("              WHEN SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 5, 2) = '08' THEN A.MM_AMT_08	\n");
            sbSql.append("              WHEN SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 5, 2) = '09' THEN A.MM_AMT_09	\n");
            sbSql.append("              WHEN SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 5, 2) = '10' THEN A.MM_AMT_10	\n");
            sbSql.append("              WHEN SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 5, 2) = '11' THEN A.MM_AMT_11	\n");
            sbSql.append("              WHEN SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 5, 2) = '12' THEN A.MM_AMT_12	\n");
            sbSql.append("              ELSE 0																							  	\n");
            sbSql.append("               END																								\n");
            sbSql.append("         ) AS MM_AMT																								\n");
            }
            sbSql.append("   FROM MAP_BPC_CONFIRM_PL_INFO A 																			  \n");
            sbSql.append("	   ,(				          																				  \n");
            sbSql.append("          SELECT ACCT_CD   \n");
            sbSql.append("                ,ACCT_NM   \n");
            sbSql.append("                ,ACCTNM2 ACCT_CLASS \n");
            sbSql.append("                ,SEQ       \n");
            sbSql.append("            FROM (         \n");
            sbSql.append("                  SELECT ACCTCD AS ACCT_CD \n");
            sbSql.append("                        ,ACCTNM4 AS ACCT_NM \n");
            sbSql.append("                        ,ACCTNM1 \n");
            sbSql.append("                        ,ACCTNM2 \n");
            sbSql.append("                        ,ACCTNM3 \n");
            sbSql.append("                        ,SEQ \n");
            sbSql.append("                    FROM MAS_ST_ACCOUNT \n");
            sbSql.append("                  )        \n");
            sbSql.append("           ORDER BY SEQ    \n");sbSql.append("	    ) B		  																								  \n");
            sbSql.append("  WHERE B.ACCT_CD = A.ACCT_CD(+)																	\n");
            sbSql.append("    AND A.PLAN_CLASS(+) = 'AP'																	\n");
            sbSql.append("    AND A.CC_CD(+) = '" + nullToBlank(ds_Cond.getString(0, "CC_CD")) + "'        					\n");
            sbSql.append("    AND A.PLAN_YEAR(+) = SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 1, 4)	\n");
            sbSql.append("    AND A.JOB_GRADE_CD(+) = 'N_RANK'		     													\n");
            sbSql.append("    AND A.PLAN_YEAR(+) IS NOT NULL																\n");
            sbSql.append("    AND A.VER_CD(+) = '" + strVercd + "'                                                      \n");
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
            // BPC최종값중 안남겨주는 계정을 아웃터로 잡기위해 한번 더감쌈.
            //sbSql.append("   	WHERE MM_AMT IS NOT NULL																\n");
            //sbSql.append("   	)																						\n");
            sbSql.append("   		  PIVOT ( AVG(DD_AMT) FOR P_DATE IN (" + nullToBlank(ds_Cond.getString(0, "SEARCH_COL")) + ") )	\n");
            sbSql.append("  ORDER BY SEQ																	\n");
        } else {
            sbSql.delete(0, sbSql.length());
            sbSql.append(" SELECT A.*																							\n");
            sbSql.append("   FROM (																								\n");
            sbSql.append(" 			SELECT *																					\n");
            sbSql.append("   		  FROM (																					\n");
            sbSql.append("					SELECT '' SEQ, A.ACCT_CLASS, A.ACCT_NM, A.ACCT_CD, A.CC_CD, A.YMD, '' AS YY, B.CONFIRM_YN, B.DAY_CLASS, '' AS P_DATE	\n");
            //sbSql.append("       				  ,DECODE(A.ACCT_CLASS, '매출액', '1', '재료비', '2', '노무비', '3', '경비', '4') SKEY	\n"); //-- 소계

            // 재무금액일때.
            if ("U".equals(ds_Cond.getString(0, "CLOSE_TYPE"))) {
                sbSql.append("      				  ,CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN NVL(ROUND(C.SUM_AMT / (DECODE(D.MM_MARGIN_RATE, NULL, 100, 0, 100, D.MM_MARGIN_RATE) / 100) ), 0)	  		\n");
                sbSql.append("       				   ELSE NVL(C.SUM_AMT, 0)                                                                                 \n");
                sbSql.append("        				   END SUM_AMT                                                                                                  \n");
                sbSql.append("      				  ,CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN NVL(ROUND(C.MM_AMT / (DECODE(D.MM_MARGIN_RATE, NULL, 100, 0, 100, D.MM_MARGIN_RATE) / 100) ), 0)	  		\n");
                sbSql.append("       				   ELSE NVL(ROUND(C.MM_AMT), 0)                                                                                 \n");
                sbSql.append("        				   END MM_AMT                                                                                                   \n");
                sbSql.append("      				  ,CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN NVL(ROUND(A.DD_AMT / (DECODE(D.MM_MARGIN_RATE, NULL, 100, 0, 100, D.MM_MARGIN_RATE) / 100) / 1000), 0)	\n");
                sbSql.append("       				   ELSE NVL(ROUND(A.DD_AMT / 1000), 0)                                                                          \n");
                sbSql.append("        				   END DD_AMT                                                                                                   \n");
                //sbSql.append("                        ,CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN NVL(ROUND(C.SUM_AMT * NVL((D.MM_MARGIN_RATE / 100), 1) ), 0)         \n");
                //sbSql.append("                         ELSE NVL(C.SUM_AMT, 0)                                                                                 \n");
                //sbSql.append("                         END SUM_AMT                                                                                                  \n");
                //sbSql.append("                        ,CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN NVL(ROUND(C.MM_AMT), 0)          \n");
                //sbSql.append("                         ELSE NVL(ROUND(C.MM_AMT), 0)                                                                                 \n");
                //sbSql.append("                         END MM_AMT                                                                                                   \n");
                //sbSql.append("                        ,CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN NVL(ROUND(A.DD_AMT / 1000), 0)  \n");
                //sbSql.append("                         ELSE NVL(ROUND(A.DD_AMT / 1000), 0)                                                                          \n");
                //sbSql.append("                         END DD_AMT                                                                                                   \n");
            } else {
            	//2018.03.21 김명섭 관리금액조회개선: 일계획관리테이블(MAP_DAY_PLAN) 금액은 관리금액으로 업장출하율적용 불필요
                sbSql.append("      				  ,C.SUM_AMT																\n"); // 추가
                //sbSql.append("                        ,CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN NVL(ROUND(C.SUM_AMT * NVL((DECODE(D.MM_MARGIN_RATE,NULL,100,0,100,D.MM_MARGIN_RATE) / 100), 1) ), 0)    \n"); // 추가
                //sbSql.append("                              ELSE C.SUM_AMT             \n");
                //sbSql.append("                              END SUM_AMT                \n");
                sbSql.append("      				  ,C.MM_AMT																	\n");
                sbSql.append("      				  ,ROUND((A.DD_AMT / 1000), 0) AS DD_AMT									\n");
            }

            sbSql.append("  				  FROM MAP_DAY_PLAN A 																\n");
            sbSql.append(" 						  ,MAP_DAY_LOG_MGMT B 															\n");
            sbSql.append(" 						  ,(				 															\n");
            //sbSql.append("							SELECT ACCT_CD, ROUND((SUM(A.DD_AMT) / 1000)) AS MM_AMT, ROUND(A.MM_AMT / 1000) AS SUM_AMT	\n");
            sbSql.append("                          SELECT ACCT_CD, ROUND((SUM(A.DD_AMT) / 1000)) AS MM_AMT, A.MM_AMT AS SUM_AMT  \n");
            sbSql.append("							  FROM MAP_DAY_PLAN A														\n");
            sbSql.append("							 WHERE A.UPJANG = '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'		\n");
            sbSql.append(" 	 				   		   AND A.YY = SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 1, 4)	\n");
            sbSql.append(" 	 				   		   AND A.MM = SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 5, 2)	\n");
            sbSql.append("   				   		   AND A.DAY_CLASS = '" + nullToBlank(ds_Cond.getString(0, "DAY_CLASS")) + "'		\n");
            sbSql.append("					 		 GROUP BY ACCT_CD, MM_AMT													\n");
            sbSql.append(" 						   ) C				 															\n");
            sbSql.append("      				  ,(																			\n");
            sbSql.append(" 		 					SELECT (CASE WHEN SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 5, 2) = '01' THEN MM_MARGIN_RATE_01 \n");
            sbSql.append(" 		 					             WHEN SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 5, 2) = '02' THEN MM_MARGIN_RATE_02 \n");
            sbSql.append(" 		 					             WHEN SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 5, 2) = '03' THEN MM_MARGIN_RATE_03 \n");
            sbSql.append(" 		 					             WHEN SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 5, 2) = '04' THEN MM_MARGIN_RATE_04 \n");
            sbSql.append(" 		 					             WHEN SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 5, 2) = '05' THEN MM_MARGIN_RATE_05 \n");
            sbSql.append(" 		 					             WHEN SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 5, 2) = '06' THEN MM_MARGIN_RATE_06 \n");
            sbSql.append(" 		 					             WHEN SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 5, 2) = '07' THEN MM_MARGIN_RATE_07 \n");
            sbSql.append(" 		 					             WHEN SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 5, 2) = '08' THEN MM_MARGIN_RATE_08 \n");
            sbSql.append(" 		 					             WHEN SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 5, 2) = '09' THEN MM_MARGIN_RATE_09 \n");
            sbSql.append(" 		 					             WHEN SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 5, 2) = '10' THEN MM_MARGIN_RATE_10 \n");
            sbSql.append(" 		 					             WHEN SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 5, 2) = '11' THEN MM_MARGIN_RATE_11 \n");
            sbSql.append(" 		 					             WHEN SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 5, 2) = '12' THEN MM_MARGIN_RATE_12 \n");
            sbSql.append(" 		 					             ELSE 0															\n");
            sbSql.append(" 		 					              END															\n");
            sbSql.append(" 		 					       ) MM_MARGIN_RATE														\n");
            sbSql.append(" 		 					      ,UPJANG																\n");
            sbSql.append(" 		  					  FROM MAP_MARGIN_RATE_MGMT													\n");
            sbSql.append(" 		 					 WHERE UPJANG ='" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'	  	\n");
            sbSql.append(" 		   					   AND YY = SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 1, 4)	\n");
            sbSql.append(" 		   					   AND CLASS = '" + "P" + "'												\n");
            sbSql.append(" 		 				   ) D 																			\n");
            sbSql.append(" 				     WHERE A.UPJANG = B.UPJANG															\n");
            sbSql.append("   				   AND A.YY = B.YY																	\n");
            sbSql.append("   				   AND A.MM = B.MM																	\n");
            sbSql.append("   				   AND A.UPJANG = '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'				\n");
            sbSql.append(" 	 				   AND A.YY = SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 1, 4)	\n");
            sbSql.append(" 	 				   AND A.MM = SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 5, 2)	\n");
            sbSql.append("   				   AND A.DAY_CLASS = '" + nullToBlank(ds_Cond.getString(0, "DAY_CLASS")) + "'		\n");
            sbSql.append("   				   AND B.DAY_CLASS = '" + nullToBlank(ds_Cond.getString(0, "DAY_CLASS")) + "'		\n");
            sbSql.append("   				   AND A.ACCT_CD = C.ACCT_CD(+)														\n");
            sbSql.append("   				   AND A.UPJANG = D.UPJANG(+)														\n");
            sbSql.append("					 GROUP BY A.ACCT_CLASS, A.ACCT_NM, A.ACCT_CD, A.CC_CD, A.YMD, B.CONFIRM_YN, B.DAY_CLASS, C.SUM_AMT, A.DD_AMT, C.MM_AMT, D.MM_MARGIN_RATE	\n");
            sbSql.append("   				)																					\n");
            sbSql.append(" PIVOT ( AVG(DD_AMT) FOR YMD IN (" + nullToBlank(ds_Cond.getString(0, "SEARCH_COL")) + ") )			\n");
            sbSql.append("   		) A																							\n");
            sbSql.append(" ORDER BY A.ACCT_CD																					\n");

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

    } catch (Exception ex) {
        //ex.printStackTrace();
        //jsp 로그남기기
        logger.debug(ex.getMessage(), ex);
        this.setResultMessage(-1, ex.toString(), out_vl);
    } finally {
        if (rs != null) {
            try {
                rs.close();
            } catch (Exception e) {
            }
        }
        if (pstmt != null) {
            try {
                pstmt.close();
            } catch (Exception e) {
            }
        }
        if (conn != null) {
            try {
                conn.close();
            } catch (Exception e) {
            }
        }
        //jsp log 서비스 닫기
        try {
            logger.endIndividualLog();
        } catch (Exception logE) {
            logE.printStackTrace();
        }
    }

    proc_output(response, out, out_vl, out_dl);
%>