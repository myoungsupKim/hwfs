
<%
    /*-----------------------------------------------------------------------------
    ■ 시스템명     : 사업계획관리
    ■ 프로그램ID   : MAP30230E_T001.jsp
    ■ 프로그램명   : 마케터별 일추정 관리
    ■ 작성일자     : 2015-09-03
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
        sbSql.append("SELECT COUNT(1) ISDATA  																\n");
        sbSql.append("  FROM MAP_DAY_LOG_MGMT2																\n");
        sbSql.append(" WHERE TM_CD ='" + nullToBlank(ds_Cond.getString(0, "TM_CD")) + "'	  				\n");
        sbSql.append("   AND SABUN = '" + nullToBlank(ds_Cond.getString(0, "SABUN")) + "'					\n");
        sbSql.append("   AND YY = SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 1, 4)		\n");
        sbSql.append("   AND MM = SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 5, 2)		\n");
        sbSql.append("   AND DAY_CLASS = '" + nullToBlank(ds_Cond.getString(0, "DAY_CLASS")) + "'			\n");

        pstmt = conn.prepareStatement(sbSql.toString());
        rs = pstmt.executeQuery();

        rs.next();

        String isData = rs.getString("ISDATA");

        if ("0".equals(isData)) {
            sbSql.delete(0, sbSql.length());
            sbSql.append(" SELECT *	\n");
            sbSql.append("   FROM (	\n");
            sbSql.append(" SELECT A.ACCT_CLASS, A.ACCT_NM, A.ACCT_CD, A.UPJANGNM, A.UPJANG, A.CC_CD, 'N' CONFIRM_YN, '' AS YMD, B.P_DATE	\n");
            sbSql.append("       ,ROUND((A.MM_AMT / 1000)) SUM_AMT	 									\n"); //-- 사업계획 월 합계
            sbSql.append("       ,ROUND((A.MM_AMT / 1000)) MM_AMT	 									\n"); //-- 계정별 월 합계
            sbSql.append("       ,ROUND(((MM_AMT / LAST_DD_CNT) / 1000), 0) DD_AMT						\n"); //-- 계정별 월일의 1/N
            sbSql.append("   FROM (																		\n");
            sbSql.append("         SELECT A.ACCT_CLASS, C.UPJANGNM, A.ACCT_NM, A.ACCT_CD, A.UPJANG, A.CC_CD				\n");
            sbSql.append("               ,SUBSTR(TO_CHAR(LAST_DAY('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'||'01' ),'YYYYMMDD'), 7,2) LAST_DD_CNT	\n");
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

            /*
            sbSql.append(" SELECT A.*																							\n");
            sbSql.append("   FROM (																								\n");
            sbSql.append(" 			SELECT *																					\n");
            sbSql.append("   		  FROM (																					\n");
            sbSql.append("					SELECT A.ACCT_CLASS, A.ACCT_NM, A.ACCT_CD, E.UPJANGNM, A.UPJANG, A.CC_CD, 'N' CONFIRM_YN, A.YMD, '' AS P_DATE	\n");
            sbSql.append("      				  ,ROUND((A.DD_AMT / 1000), 0) AS DD_AMT										\n");
            sbSql.append("      				  ,C.MM_AMT																		\n");
            sbSql.append("  				  FROM MAP_DAY_PLAN2 A 																\n");
            sbSql.append(" 						  ,MAP_DAY_LOG_MGMT2 B 															\n");
            sbSql.append(" 						  ,(				 															\n");
            sbSql.append("							SELECT UPJANG, ACCT_CD, ROUND((SUM(A.DD_AMT) / 1000)) AS MM_AMT				\n");
            sbSql.append("							  FROM MAP_DAY_PLAN2 A														\n");
            sbSql.append("							 WHERE A.TM_CD = '" + nullToBlank(ds_Cond.getString(0, "TM_CD")) + "'		\n");
            sbSql.append("							   AND A.SABUN = '" + nullToBlank(ds_Cond.getString(0, "SABUN")) + "'		\n");
            sbSql.append(" 	 				   		   AND A.YY = SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 1, 4)	\n");
            sbSql.append(" 	 				   		   AND A.MM = SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 5, 2)	\n");
            sbSql.append("   				   		   AND A.DAY_CLASS = '" + "P" + "'											\n");
            sbSql.append("					 		 GROUP BY UPJANG, ACCT_CD													\n");
            sbSql.append(" 						   ) C				 															\n");
            sbSql.append(" 						  ,ST_UPJANG E				 													\n");
            sbSql.append(" 				     WHERE A.TM_CD = B.TM_CD															\n");
            sbSql.append("   				   AND A.SABUN = B.SABUN															\n");
            sbSql.append("   				   AND A.YY = B.YY																	\n");
            sbSql.append("   				   AND A.MM = B.MM																	\n");
            sbSql.append("   				   AND A.DAY_CLASS = '" + "P" + "'													\n");
            sbSql.append("   				   AND B.DAY_CLASS = '" + "P" + "'													\n");
            sbSql.append("   				   AND A.UPJANG = C.UPJANG															\n");
            sbSql.append("   				   AND A.ACCT_CD = C.ACCT_CD														\n");
            sbSql.append("   				   AND A.UPJANG = E.UPJANG															\n");
            sbSql.append("					 GROUP BY A.ACCT_CLASS, A.ACCT_NM, A.ACCT_CD, E.UPJANGNM, A.UPJANG, A.CC_CD, A.YMD, A.DD_AMT, C.MM_AMT 	\n");
            sbSql.append("   				)																					\n");
            sbSql.append(" PIVOT ( AVG(DD_AMT) FOR YMD IN (" + nullToBlank(ds_Cond.getString(0, "SEARCH_COL")) + ") )			\n");
            sbSql.append("   		) A																							\n");
            sbSql.append(" ORDER BY A.UPJANGNM, A.ACCT_CD																		\n");
            */
        } else {
            sbSql.delete(0, sbSql.length());
            sbSql.append(" SELECT A.*																							\n");
            sbSql.append("   FROM (																								\n");
            sbSql.append(" 			SELECT *																					\n");
            sbSql.append("   		  FROM (																					\n");
            sbSql.append("					SELECT A.ACCT_CLASS, A.ACCT_NM, A.ACCT_CD, A.UPJANGNM, A.UPJANG, A.CC_CD, A.CONFIRM_YN, A.YMD, '' AS P_DATE	\n");
            sbSql.append("      				  ,C.SUM_AMT																	\n");
            sbSql.append("      				  ,C.MM_AMT AS MM_AMT															\n");
            sbSql.append("      				  ,ROUND((DECODE(SUM(B.DD_AMT), 0, A.DD_AMT, NULL,  A.DD_AMT, SUM(B.DD_AMT)) / 1000), 2) AS DD_AMT	\n");
            sbSql.append("  				  FROM (			 																\n");
            sbSql.append("                           SELECT A.UPJANG, A.ACCT_CLASS, A.ACCT_NM, A.ACCT_CD, A.CC_CD, E.UPJANGNM				\n");
            sbSql.append("                                 ,DECODE(SUM(B.DD_AMT), 0, SUM(A.DD_AMT), NULL, SUM(A.DD_AMT), SUM(B.DD_AMT)) AS DD_AMT	\n");
            sbSql.append("                                 ,A.YMD, A.DAY_CLASS, A.CONFIRM_YN									\n");
            sbSql.append("                             FROM MAP_DAY_PLAN2 A														\n");
            sbSql.append("                                 ,(																	\n");
            sbSql.append("                                   SELECT A.ACCTCD AS ACCT_CD											\n");
            //sbSql.append("                                         ,NVL( DECODE(B.OUTVAT_FLAG, 'Y', ROUND( SUM( (UNIT_PRICE * TRANS_QTY) * DECODE( TAX_CODE, '100', DECODE( MATERIAL_ACCTCD, '11402000', 1.1, 1), 1) ) ), SUM( (UNIT_PRICE * TRANS_QTY) ) ), 0) AS DD_AMT	\n");
            sbSql.append("                                         ,ROUND(                                                      \n");
            sbSql.append("                                              NVL( DECODE(B.OUTVAT_FLAG, 'Y',                         \n");
            sbSql.append("                                                         ROUND( SUM( UNIT_AMOUNT * DECODE( TAX_CODE, '100', DECODE( MATERIAL_ACCTCD, '11402000', 1.1, 1), 1) ) ), \n");
            sbSql.append("                                                         SUM( UNIT_AMOUNT ) )            \n");
            sbSql.append("                                                 , 0)                                                 \n");
            sbSql.append("                                              * (100 / 100)               \n");
            sbSql.append("                                          ) AS DD_AMT                                                 \n");
            sbSql.append("                                         ,TRANS_DATE AS YMD											\n");
            sbSql.append("                                     FROM HLDC_PO_TRANSACTION A										\n");
            sbSql.append("                                         ,HLDC_PO_SUBINVENTORY B										\n");
            sbSql.append("                                         ,( \n");
            sbSql.append("                                           SELECT B.UPJANG \n");
            sbSql.append("                                                , CASE WHEN '" + ds_Cond.getString(0, "INPUT_YY").substring(4, 6) + "' = '01' THEN NVL(A.MM_MARGIN_RATE_01, 100) \n");
            sbSql.append("                                                       WHEN '" + ds_Cond.getString(0, "INPUT_YY").substring(4, 6) + "' = '02' THEN NVL(A.MM_MARGIN_RATE_02, 100) \n");
            sbSql.append("                                                       WHEN '" + ds_Cond.getString(0, "INPUT_YY").substring(4, 6) + "' = '03' THEN NVL(A.MM_MARGIN_RATE_03, 100) \n");
            sbSql.append("                                                       WHEN '" + ds_Cond.getString(0, "INPUT_YY").substring(4, 6) + "' = '04' THEN NVL(A.MM_MARGIN_RATE_04, 100) \n");
            sbSql.append("                                                       WHEN '" + ds_Cond.getString(0, "INPUT_YY").substring(4, 6) + "' = '05' THEN NVL(A.MM_MARGIN_RATE_05, 100) \n");
            sbSql.append("                                                       WHEN '" + ds_Cond.getString(0, "INPUT_YY").substring(4, 6) + "' = '06' THEN NVL(A.MM_MARGIN_RATE_06, 100) \n");
            sbSql.append("                                                       WHEN '" + ds_Cond.getString(0, "INPUT_YY").substring(4, 6) + "' = '07' THEN NVL(A.MM_MARGIN_RATE_07, 100) \n");
            sbSql.append("                                                       WHEN '" + ds_Cond.getString(0, "INPUT_YY").substring(4, 6) + "' = '08' THEN NVL(A.MM_MARGIN_RATE_08, 100) \n");
            sbSql.append("                                                       WHEN '" + ds_Cond.getString(0, "INPUT_YY").substring(4, 6) + "' = '09' THEN NVL(A.MM_MARGIN_RATE_09, 100) \n");
            sbSql.append("                                                       WHEN '" + ds_Cond.getString(0, "INPUT_YY").substring(4, 6) + "' = '10' THEN NVL(A.MM_MARGIN_RATE_10, 100) \n");
            sbSql.append("                                                       WHEN '" + ds_Cond.getString(0, "INPUT_YY").substring(4, 6) + "' = '11' THEN NVL(A.MM_MARGIN_RATE_11, 100) \n");
            sbSql.append("                                                       WHEN '" + ds_Cond.getString(0, "INPUT_YY").substring(4, 6) + "' = '12' THEN NVL(A.MM_MARGIN_RATE_12, 100) \n");
            sbSql.append("                                                  END MM_MARGIN_RATE \n");
            sbSql.append("                                             FROM MAP_MARGIN_RATE_MGMT A  \n");
            sbSql.append("                                                , SCO_UPJANG_MST_V B \n");
            sbSql.append("                                            WHERE A.UPJANG(+) = B.UPJANG \n");
            sbSql.append("                                              AND A.CLASS(+) = 'R' \n");
            sbSql.append("                                              AND A.YY(+) = '" + ds_Cond.getString(0, "INPUT_YY").substring(0, 4) + "' \n");
            sbSql.append("                                              AND B.CLOSE_DATE IS NULL \n");
            sbSql.append("                                         ) X             \n");
            sbSql.append("                                    WHERE A.SUBINV_CODE = B.SUBINV_CODE								\n");
            sbSql.append("                                      AND SUBSTR(A.TRANS_DATE, 1, 6) = '" + ds_Cond.getString(0, "INPUT_YY") + "'		\n");
            sbSql.append(" 		 					   			AND A.TRANS_UPJANG IN (SELECT DISTINCT B.UPJANG FROM FMS_UPJANG A, ST_UPJANG B, ST_CUST C  WHERE A.UPJANG = B.UPJANG      \n");
            sbSql.append("                             									  AND A.UPJANGNM_DISP = B.UPJANGNM AND B.CUSTCD = C.CUSTCD AND A.USE_YN = 'Y' AND C.USE_YN = 'Y'  \n");
            sbSql.append("                             									  AND A.PART_SALES_SABUN = '" + nullToBlank(ds_Cond.getString(0, "SABUN")) + "')  				\n");
            sbSql.append("                                      AND A.TRANS_TYPE LIKE 'O%'										\n");
            sbSql.append("                                      AND A.TRANS_TYPE <> 'O002'										\n");
            sbSql.append("                                      AND A.ACCTCD IN ('42201010', '42201020', '42203010', '42203020', '42203030') 	\n");
            sbSql.append("                                      AND A.TRANS_UPJANG = X.UPJANG(+)                        \n");
            sbSql.append("                                    GROUP BY A.ACCTCD, B.OUTVAT_FLAG, TRANS_DATE						\n");
            sbSql.append("                                  ) B																	\n");
            sbSql.append("                                 , ST_UPJANG E														\n");
            sbSql.append("                            WHERE 1=1																	\n");
            sbSql.append("                              AND A.ACCT_CD = B.ACCT_CD(+)											\n");
            sbSql.append("                              AND A.YMD = B.YMD(+) 													\n");
            sbSql.append(" 		 					    AND A.UPJANG IN (SELECT DISTINCT B.UPJANG FROM FMS_UPJANG A, ST_UPJANG B, ST_CUST C  WHERE A.UPJANG = B.UPJANG      \n");
            sbSql.append("                             					    AND A.UPJANGNM_DISP = B.UPJANGNM AND B.CUSTCD = C.CUSTCD AND A.USE_YN = 'Y' AND C.USE_YN = 'Y'  \n");
            sbSql.append("                             						AND A.PART_SALES_SABUN = '" + nullToBlank(ds_Cond.getString(0, "SABUN")) + "')  				\n");
            sbSql.append("                              AND SUBSTR(A.YMD, 1, 6) = '" + ds_Cond.getString(0, "INPUT_YY") + "'	\n");
            sbSql.append("                              AND A.DAY_CLASS = 'R'													\n");
            sbSql.append("                              AND A.UPJANG = E.UPJANG													\n");
            sbSql.append("                            GROUP BY A.UPJANG, A.ACCT_CLASS, A.ACCT_NM, A.ACCT_CD, A.CC_CD, A.YMD, A.DAY_CLASS, E.UPJANGNM, A.CONFIRM_YN	\n");
            sbSql.append("                       ) A																					\n");

            // 금일 이전일의 매출실적을 조회.
            sbSql.append(" 						  ,(				 																	\n");

            //sbSql.append("							SELECT ACCT_CD, NET_AMT AS DD_AMT, SALS_DATE										\n");
            //sbSql.append("							  FROM SLA_UPJANG_SALS_ISRC															\n");
            ////sbSql.append("							 WHERE UPJANG_CD = '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'			\n");
            //sbSql.append(" 		 					 WHERE UPJANG_CD IN (SELECT DISTINCT B.UPJANG FROM FMS_UPJANG A, ST_UPJANG B, ST_CUST C  WHERE A.UPJANG = B.UPJANG      \n");
            //sbSql.append("                             					    AND A.UPJANGNM_DISP = B.UPJANGNM AND B.CUSTCD = C.CUSTCD AND A.USE_YN = 'Y' AND C.USE_YN = 'Y'  \n");
            //sbSql.append("                             						AND A.PART_SALES_SABUN = '" + nullToBlank(ds_Cond.getString(0, "SABUN")) + "')  				\n");
            //sbSql.append(" 	 				   		   AND SUBSTR(SALS_DATE, 1, 6) = '" + ds_Cond.getString(0, "INPUT_YY") + "'			\n");
            //sbSql.append(" 	 				   		   AND SYS_CLASS = '11'																\n");
            //sbSql.append(" 	 				   		   AND ACCT_CD IN (																	\n");
            //sbSql.append(" 	'41201010','41201020','41201030','41201040','41202000','41203010','41203020','41206010','41206020','41206030','41209060'\n");
            ////sbSql.append(" ,'42201010','42201020','42201030','42201040','42202000','42203010','42203020','42204000'			\n");
            //sbSql.append(" 	 				   		                  )																	\n");

            sbSql.append("                              SELECT C.ACCT_CD                                                               \n");
            sbSql.append("                                   , B.OCCUR_DATE AS SALS_DATE                                               \n");
            sbSql.append("                                   , SUM(B.NET_AMT) AS DD_AMT                                                \n");
            sbSql.append("                                FROM SLA_IF_UPJANG_SALS_DETAIL B                                             \n");
            sbSql.append("                                   , (SELECT DISTINCT B.ACCT_CD, A.SALS_TYPE                                 \n");
            sbSql.append("                                        FROM SLA_SALES_SALS_TYPE A                                           \n");
            sbSql.append("                                            ,SLA_TYPE_CD_MST B                                               \n");
            sbSql.append("                                       WHERE A.TYPE_GRP_CD = B.TYPE_GRP_CD(+)                                \n");
            sbSql.append("                                         AND A.TYPE_CD = B.TYPE_CD(+)                                        \n");
            sbSql.append("                                         AND A.SALS_TYPE IN ('1103', '1102', '1202', '1203', '2001', '1106', '1204', '1205', '2101', '2102')  \n");
            sbSql.append("                                         AND A.USE_YN = 'Y'                                                  \n");
            sbSql.append("                                         AND B.ACCT_CD != '98001010'                                         \n");
            sbSql.append("                                     ) C                                                                     \n");
            sbSql.append("                               WHERE B.SALS_CLASS = C.SALS_TYPE                                              \n");
            sbSql.append("                                 AND B.UPJANG_CD = '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'     \n");
            sbSql.append("                                 AND SUBSTR(B.OCCUR_DATE, 1, 6) = '" + ds_Cond.getString(0, "INPUT_YY") + "' \n");
            //sbSql.append("                                 AND B.SYS_CLASS = '11'                                                      \n");
            sbSql.append("                                 AND B.RECD_STATUS = 'L'                                                     \n");
            sbSql.append("                               GROUP BY B.UPJANG_CD, C.ACCT_CD, B.OCCUR_DATE                                 \n");

            sbSql.append(" 						   ) B				 																	\n");
            // 끝.
            sbSql.append(" 						  ,(				 																	\n");
            sbSql.append("							SELECT UPJANG, ACCT_CD, ROUND((SUM(A.DD_AMT) / 1000)) AS MM_AMT, A.MM_AMT AS SUM_AMT	\n");
            sbSql.append("							  FROM MAP_DAY_PLAN2 A																\n");
            sbSql.append("							 WHERE A.TM_CD = '" + nullToBlank(ds_Cond.getString(0, "TM_CD")) + "'				\n");
            sbSql.append("   				   		   AND A.SABUN = '" + nullToBlank(ds_Cond.getString(0, "SABUN")) + "'				\n");
            sbSql.append(" 	 				   		   AND SUBSTR(A.YMD, 1, 6) = '" + ds_Cond.getString(0, "INPUT_YY") + "'				\n");
            sbSql.append("   				   		   AND A.DAY_CLASS = '" + nullToBlank(ds_Cond.getString(0, "DAY_CLASS")) + "'		\n");
            sbSql.append("					 		 GROUP BY UPJANG, ACCT_CD, MM_AMT													\n");
            sbSql.append(" 						   ) C				 																	\n");
            sbSql.append("      				  ,(																					\n");
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
            sbSql.append(" 		 					 WHERE UPJANG IN (SELECT DISTINCT B.UPJANG FROM FMS_UPJANG A, ST_UPJANG B, ST_CUST C  WHERE A.UPJANG = B.UPJANG      \n");
            sbSql.append("                             AND A.UPJANGNM_DISP = B.UPJANGNM AND B.CUSTCD = C.CUSTCD AND A.USE_YN = 'Y' AND C.USE_YN = 'Y'  \n");
            sbSql.append("                             AND A.PART_SALES_SABUN = '" + nullToBlank(ds_Cond.getString(0, "SABUN")) + "')  				\n");
            sbSql.append(" 		   					   AND YY = SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 1, 4)	\n");
            sbSql.append(" 		   					   AND CLASS = '" + "R" + "'												\n");
            sbSql.append(" 		 				   ) D 																			\n");
            sbSql.append(" 				     WHERE A.ACCT_CD = B.ACCT_CD(+)														\n");
            sbSql.append("   				   AND A.YMD = B.SALS_DATE(+)														\n");
            sbSql.append("   				   AND A.UPJANG = C.UPJANG															\n");
            sbSql.append(" 	 				   AND SUBSTR(A.YMD, 1, 6) = '" + ds_Cond.getString(0, "INPUT_YY") + "'				\n");
            sbSql.append("   				   AND A.DAY_CLASS = '" + "R" + "'													\n");
            sbSql.append("   				   AND A.ACCT_CD = C.ACCT_CD														\n");
            sbSql.append("   				   AND A.UPJANG = D.UPJANG(+)														\n");
            sbSql.append("					 GROUP BY A.ACCT_CLASS, A.ACCT_NM, A.ACCT_CD, A.UPJANGNM, A.CONFIRM_YN, A.UPJANG, A.CC_CD, A.YMD, A.DD_AMT, C.MM_AMT, D.MM_MARGIN_RATE, D.UPJANG, C.SUM_AMT	\n");
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