
<%
    /*-----------------------------------------------------------------------------
    ■ 시스템명     : 사업계획관리
    ■ 프로그램ID   : MAP30040E_T001.jsp
    ■ 프로그램명   : 일추정 관리
    ■ 작성일자     : 2015-06-30
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
        sbSql.append("   	   AND DAY_CLASS = '" + nullToBlank(ds_Cond.getString(0, "DAY_CLASS")) + "'			\n");

        pstmt = conn.prepareStatement(sbSql.toString());
        rs = pstmt.executeQuery();

        rs.next();

        String isData = rs.getString("ISDATA");

        if ("0".equals(isData)) {
            // 월추정 데이터로 기초값을 세팅한다.
            sbSql.delete(0, sbSql.length());
            sbSql.append(" SELECT *	\n");
            sbSql.append("   FROM (	\n");
            sbSql.append(" SELECT A.ACCT_CLASS, A.ACCT_NM, A.ACCT_CD, A.CC_CD, '' AS YMD, A.YY, 'N' CONFIRM_YN,  '' AS DAY_CLASS, B.P_DATE	\n");
            sbSql.append("       ,ROUND((A.MM_AMT / 1000)) SUM_AMT	 									\n"); //-- 사업계획 월 합계
            sbSql.append("       ,ROUND((A.MM_AMT / 1000)) MM_AMT	 									\n"); //-- 계정별 월 합계
            //2018.02.22 김명섭 [CH201802_00201] 인건비계정 ehr 인터페이스 데이터(ehr_if.IF_EHR_LABOR_COST) 참조 반영
            //sbSql.append("       ,ROUND(((MM_AMT / LAST_DD_CNT) / 1000), 0) DD_AMT						\n"); //-- 계정별 월일의 1/N
            sbSql.append("       /* 일추정 인건비 계정 ehr 인터페이스: ehr데이터 없는 경우 일할 추정 반영 */            \n");
            sbSql.append("       ,NVL((SELECT ROUND(EST_AMT/1000)                                                       \n");
            sbSql.append("               FROM EHR_IF.IF_EHR_LABOR_COST                                                  \n");
            sbSql.append("              WHERE CC_CD = A.CC_CD                                                           \n");
            sbSql.append("                AND YMD = B.P_DATE                                                            \n");
            sbSql.append("                AND ACCT_CD = A.ACCT_CD),ROUND(((MM_AMT / LAST_DD_CNT) / 1000), 0)) AS DD_AMT \n");
            sbSql.append("   FROM (																		\n");
            sbSql.append("         SELECT A.ACCT_CLASS, A.ACCT_NM, A.ACCT_CD, A.CC_CD, A.YY				\n");
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
            sbSql.append("  ORDER BY ACCT_CD																			\n");
            /*
            // 일계획 값은 관리금액임으로 그대로 사용한다.
            sbSql.append(" SELECT A.*																							\n");
            sbSql.append("   FROM (																								\n");
            sbSql.append(" 			SELECT *																					\n");
            sbSql.append("   		  FROM (																					\n");
            sbSql.append("					SELECT A.ACCT_CLASS, A.ACCT_NM, A.ACCT_CD, A.CC_CD, A.YMD, 'N' AS CONFIRM_YN, '' AS LAST_DD_CNT, '' AS DAY_CLASS	\n");
            sbSql.append("      				  ,ROUND((A.DD_AMT / 1000), 2) AS DD_AMT										\n");
            sbSql.append("      				  ,C.MM_AMT																		\n");
            sbSql.append("  				  FROM MAP_DAY_PLAN A 																\n");
            sbSql.append(" 						  ,MAP_DAY_LOG_MGMT B 															\n");
            sbSql.append(" 						  ,(				 															\n");
            sbSql.append("							SELECT ACCT_CD, ROUND((SUM(A.DD_AMT) / 1000)) AS MM_AMT						\n");
            sbSql.append("							  FROM MAP_DAY_PLAN A														\n");
            sbSql.append("							 WHERE A.UPJANG = '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'		\n");
            sbSql.append(" 	 				   		   AND A.YY = SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 1, 4)	\n");
            sbSql.append(" 	 				   		   AND A.MM = SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 5, 2)	\n");
            sbSql.append("   				   		   AND A.DAY_CLASS = '" + "P" + "'											\n");
            sbSql.append("					 		 GROUP BY ACCT_CD															\n");
            sbSql.append(" 						   ) C				 															\n");
            sbSql.append(" 				     WHERE A.UPJANG = B.UPJANG															\n");
            sbSql.append("   				   AND A.YY = B.YY																	\n");
            sbSql.append("   				   AND A.MM = B.MM																	\n");
            sbSql.append("   				   AND A.UPJANG = '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'				\n");
            sbSql.append(" 	 				   AND A.YY = SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 1, 4)	\n");
            sbSql.append(" 	 				   AND A.MM = SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 5, 2)	\n");
            sbSql.append("   				   AND A.DAY_CLASS = '" + "P" + "'													\n");
            sbSql.append("   				   AND B.DAY_CLASS = '" + "P" + "'													\n");
            sbSql.append("   				   AND A.ACCT_CD = C.ACCT_CD														\n");
            sbSql.append("   				   AND B.CONFIRM_YN = '" + "Y" + "'													\n");
            sbSql.append("					 GROUP BY A.ACCT_CLASS, A.ACCT_NM, A.ACCT_CD, A.CC_CD, A.YMD, B.CONFIRM_YN, A.DD_AMT, C.MM_AMT	\n");
            sbSql.append("   				)																					\n");
            sbSql.append(" PIVOT ( AVG(DD_AMT) FOR YMD IN (" + nullToBlank(ds_Cond.getString(0, "SEARCH_COL")) + ") )			\n");
            sbSql.append("   		) A																							\n");
            sbSql.append(" ORDER BY A.ACCT_CD																					\n");
            */
        } else {
            sbSql.delete(0, sbSql.length());
            sbSql.append(" SELECT A.*																							\n");
            sbSql.append("   FROM (																								\n");
            sbSql.append(" 			SELECT *																					\n");
            sbSql.append("   		  FROM (																					\n");
            sbSql.append("					SELECT A.ACCT_CLASS, A.ACCT_NM, A.ACCT_CD, A.CC_CD, A.YMD, '' AS YY, 'N' AS CONFIRM_YN, 'R' AS DAY_CLASS, '' AS P_DATE	\n");

            // 재무금액일때.
            if ("U".equals(ds_Cond.getString(0, "CLOSE_TYPE"))) {
                //sbSql.append("                        ,CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN NVL(ROUND(C.SUM_AMT / NVL((D.MM_MARGIN_RATE / 100), 1) ), 0)              \n");
                //sbSql.append("                         ELSE NVL(ROUND(C.SUM_AMT * NVL((DECODE(D.MM_MARGIN_RATE,NULL,100,0,100,D.MM_MARGIN_RATE) / 100), 1) ), 0)            \n");
                //sbSql.append("                         END SUM_AMT                                                                                                       \n");
                //SUM_AMT 저장된 금액 그대로 나오게 수정 20160113  요청자 : 유영진 처리자 : 맹수영
                //sbSql.append("      				  ,C.SUM_AMT AS SUM_AMT															\n");
                sbSql.append("                        ,CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN NVL(ROUND(C.SUM_AMT / NVL((D.MM_MARGIN_RATE / 100), 1) ), 0)     \n");          
                sbSql.append("                              ELSE NVL(ROUND(C.SUM_AMT), 0)        \n");                                                                             
                sbSql.append("                               END SUM_AMT  \n");
                sbSql.append("                        ,CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN NVL(ROUND(C.MM_AMT / NVL((D.MM_MARGIN_RATE / 100), 1) / 1000), 0)               \n");
                sbSql.append("                         ELSE NVL(ROUND(C.MM_AMT/ 1000), 0)                                                                                     \n");
                sbSql.append("                         END MM_AMT                                                                                                       \n");
                sbSql.append("      				  ,CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN	\n");
                sbSql.append("                             CASE WHEN A.YMD > TO_CHAR(SYSDATE, 'YYYYMMDD') THEN NVL(ROUND(DECODE(SUM(B.DD_AMT), 0, A.DD_AMT, NULL,  A.DD_AMT, SUM(B.DD_AMT)) / NVL((D.MM_MARGIN_RATE  / 100), 1)  / 1000), 0)    \n");
                sbSql.append("                             ELSE ROUND((DECODE((SUM(B.DD_AMT) / NVL((D.MM_MARGIN_RATE  / 100), 1)), 0, A.DD_AMT, NULL,  A.DD_AMT, (SUM(B.DD_AMT) / NVL((D.MM_MARGIN_RATE  / 100), 1))) / 1000), 2)                          \n");
                sbSql.append("                             END                          \n");
                sbSql.append("       				   ELSE ROUND((DECODE((SUM(B.DD_AMT) / NVL((D.MM_MARGIN_RATE  / 100), 1)), 0, A.DD_AMT, NULL,  A.DD_AMT, (SUM(B.DD_AMT))) / 1000), 2)                            \n");
                sbSql.append("        				   END DD_AMT                                                                                                       \n");

            
            } else {
                //sbSql.append("      				  ,C.SUM_AMT																	\n");
                //sbSql.append("                        ,NVL(ROUND(C.SUM_AMT * NVL((DECODE(D.MM_MARGIN_RATE,NULL,100,0,100,D.MM_MARGIN_RATE) / 100), 1) ), 0) AS SUM_AMT       \n");
                //SUM_AMT 저장된 금액 그대로 나오게 수정 20160113  요청자 : 유영진 처리자 : 맹수영
                sbSql.append("      				  ,C.SUM_AMT AS SUM_AMT															\n");
                sbSql.append("      				  ,C.MM_AMT AS MM_AMT															\n");
                sbSql.append("      				  ,ROUND((DECODE(SUM(B.DD_AMT), 0, A.DD_AMT, NULL,  A.DD_AMT, SUM(B.DD_AMT)) / 1000), 2) AS DD_AMT	\n");

            }

            sbSql.append("  				  FROM (			 																\n");
            sbSql.append("                           SELECT A.UPJANG, A.ACCT_CLASS, A.ACCT_NM, A.ACCT_CD, A.CC_CD				\n");
            sbSql.append("                                 ,DECODE(SUM(B.DD_AMT), 0, SUM(A.DD_AMT), NULL, SUM(A.DD_AMT), SUM(B.DD_AMT)) AS DD_AMT	\n");
            sbSql.append("                                 ,A.YMD, A.DAY_CLASS													\n");
            sbSql.append("                             FROM MAP_DAY_PLAN A														\n");
            sbSql.append("                                 ,(																	\n");
            sbSql.append("                                   SELECT A.ACCTCD AS ACCT_CD											\n");
            // 관리
            //sbSql.append("                                         ,NVL( DECODE(B.OUTVAT_FLAG, 'Y', ROUND( SUM( MARGIN_AMOUNT * DECODE( TAX_CODE, '100', DECODE( MATERIAL_ACCTCD, '1120311', 1.1, 1), 1) ) ), SUM( MARGIN_AMOUNT ) ), 0) AS DD_AMT	\n");
            // 재무
            //sbSql.append("                                         ,NVL( DECODE(B.OUTVAT_FLAG, 'Y', ROUND( SUM( (UNIT_PRICE * TRANS_QTY) * DECODE( TAX_CODE, '100', DECODE( MATERIAL_ACCTCD, '11402000', 1.1, 1), 1) ) ), SUM( (UNIT_PRICE * TRANS_QTY) ) ), 0) AS DD_AMT	\n");
            sbSql.append("                                         ,ROUND(                                                      \n");
            //sbSql.append("                                              NVL( DECODE(B.OUTVAT_FLAG, 'Y',                         \n");
            //sbSql.append("                                                         ROUND( SUM( (UNIT_PRICE * TRANS_QTY) * DECODE( TAX_CODE, '100', DECODE( MATERIAL_ACCTCD, '11402000', 1.1, 1), 1) ) ), \n");
            //sbSql.append("                                                         SUM( (UNIT_PRICE * TRANS_QTY) ) )            \n");
            //sbSql.append("                                                 , 0)                                                 \n");
            //sbSql.append("                                              * (NVL(MAX(X.MM_MARGIN_RATE), 100) / 100)               \n");
            // 재무금액일때.
            if ("U".equals(ds_Cond.getString(0, "CLOSE_TYPE"))) {
                sbSql.append("                                              NVL( DECODE(B.OUTVAT_FLAG, 'Y',                         \n");
                sbSql.append("                                                         ROUND( SUM( UNIT_AMOUNT * DECODE( TAX_CODE, '100', DECODE( MATERIAL_ACCTCD, '11402000', 1.1, 1), 1) ) ), \n");
                sbSql.append("                                                         SUM( UNIT_AMOUNT ) )            \n");
                sbSql.append("                                                 , 0)                                                 \n");
            } else {
                sbSql.append("                                              NVL( DECODE(B.OUTVAT_FLAG, 'Y',                         \n");
                sbSql.append("                                                         ROUND( SUM( MARGIN_AMOUNT * DECODE( TAX_CODE, '100', DECODE( MATERIAL_ACCTCD, '11402000', 1.1, 1), 1) ) ), \n");
                sbSql.append("                                                         SUM( MARGIN_AMOUNT ) )            \n");
                sbSql.append("                                                 , 0)                                                 \n");
            }
            sbSql.append("                                              * (100 / 100)               \n");
            sbSql.append("                                          ) AS DD_AMT                                                 \n");
            sbSql.append("                                         ,TRANS_DATE AS YMD											\n");
            sbSql.append("                                     FROM HLDC_PO_TRANSACTION A										\n");
            sbSql.append("                                         ,HLDC_PO_SUBINVENTORY B										\n");
            sbSql.append("                                         ,( \n");
            sbSql.append("                                           SELECT B.UPJANG \n");
            sbSql.append("                                                , CASE WHEN '" + ds_Cond.getString(0, "INPUT_YY").substring(4,6) + "' = '01' THEN NVL(A.MM_MARGIN_RATE_01, 100) \n");
            sbSql.append("                                                       WHEN '" + ds_Cond.getString(0, "INPUT_YY").substring(4,6) + "' = '02' THEN NVL(A.MM_MARGIN_RATE_02, 100) \n");
            sbSql.append("                                                       WHEN '" + ds_Cond.getString(0, "INPUT_YY").substring(4,6) + "' = '03' THEN NVL(A.MM_MARGIN_RATE_03, 100) \n");
            sbSql.append("                                                       WHEN '" + ds_Cond.getString(0, "INPUT_YY").substring(4,6) + "' = '04' THEN NVL(A.MM_MARGIN_RATE_04, 100) \n");
            sbSql.append("                                                       WHEN '" + ds_Cond.getString(0, "INPUT_YY").substring(4,6) + "' = '05' THEN NVL(A.MM_MARGIN_RATE_05, 100) \n");
            sbSql.append("                                                       WHEN '" + ds_Cond.getString(0, "INPUT_YY").substring(4,6) + "' = '06' THEN NVL(A.MM_MARGIN_RATE_06, 100) \n");
            sbSql.append("                                                       WHEN '" + ds_Cond.getString(0, "INPUT_YY").substring(4,6) + "' = '07' THEN NVL(A.MM_MARGIN_RATE_07, 100) \n");
            sbSql.append("                                                       WHEN '" + ds_Cond.getString(0, "INPUT_YY").substring(4,6) + "' = '08' THEN NVL(A.MM_MARGIN_RATE_08, 100) \n");
            sbSql.append("                                                       WHEN '" + ds_Cond.getString(0, "INPUT_YY").substring(4,6) + "' = '09' THEN NVL(A.MM_MARGIN_RATE_09, 100) \n");
            sbSql.append("                                                       WHEN '" + ds_Cond.getString(0, "INPUT_YY").substring(4,6) + "' = '10' THEN NVL(A.MM_MARGIN_RATE_10, 100) \n");
            sbSql.append("                                                       WHEN '" + ds_Cond.getString(0, "INPUT_YY").substring(4,6) + "' = '11' THEN NVL(A.MM_MARGIN_RATE_11, 100) \n");
            sbSql.append("                                                       WHEN '" + ds_Cond.getString(0, "INPUT_YY").substring(4,6) + "' = '12' THEN NVL(A.MM_MARGIN_RATE_12, 100) \n");
            sbSql.append("                                                  END MM_MARGIN_RATE \n");
            sbSql.append("                                             FROM MAP_MARGIN_RATE_MGMT A  \n");
            sbSql.append("                                                , SCO_UPJANG_MST_V B \n");
            sbSql.append("                                            WHERE A.UPJANG(+) = B.UPJANG \n");
            sbSql.append("                                              AND A.CLASS(+) = 'R' \n");
            sbSql.append("                                              AND A.YY(+) = '" + ds_Cond.getString(0, "INPUT_YY").substring(0,4) + "' \n");
            sbSql.append("                                              AND B.CLOSE_DATE IS NULL \n");
            sbSql.append("                                         ) X             \n");
            sbSql.append("                                    WHERE A.SUBINV_CODE = B.SUBINV_CODE								\n");
            //sbSql.append("                                      AND SUBSTR(A.TRANS_DATE, 1, 6) = '" + ds_Cond.getString(0, "INPUT_YY") + "'		\n");
            sbSql.append("                                      AND A.TRANS_DATE LIKE '" + ds_Cond.getString(0, "INPUT_YY") + "'||'%'		\n");
            sbSql.append("                                      AND A.TRANS_UPJANG = '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'		\n");
            sbSql.append("                                      AND A.TRANS_TYPE LIKE 'O%'										\n");
            sbSql.append("                                      AND A.TRANS_TYPE <> 'O002'										\n");
            sbSql.append("                                      AND A.ACCTCD IN ('42201010', '42201020', '42203010', '42203020', '42203030') 	\n");
            sbSql.append("                                      AND A.TRANS_UPJANG = X.UPJANG(+)						\n");
            sbSql.append("                                    GROUP BY A.ACCTCD, B.OUTVAT_FLAG, TRANS_DATE                      \n");
            sbSql.append("                                  ) B																	\n");
            sbSql.append("                            WHERE 1=1																	\n");
            sbSql.append("                              AND A.ACCT_CD = B.ACCT_CD(+)											\n");
            sbSql.append("                              AND A.YMD = B.YMD(+) 													\n");
            sbSql.append("                              AND A.UPJANG = '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'	\n");
            //sbSql.append("                              AND SUBSTR(A.YMD, 1, 6) = '" + ds_Cond.getString(0, "INPUT_YY") + "'	\n");
            sbSql.append("                              AND A.YMD LIKE '" + ds_Cond.getString(0, "INPUT_YY") + "'||'%'	\n");
            sbSql.append("                              AND A.DAY_CLASS = 'R'													\n");
            sbSql.append("                            GROUP BY A.UPJANG, A.ACCT_CLASS, A.ACCT_NM, A.ACCT_CD, A.CC_CD, A.YMD, A.DAY_CLASS	\n");
            sbSql.append("                       ) A																			\n");

            // 금일 이전일의 매출실적을 조회.
            sbSql.append(" 						  ,(				 															\n");

            //sbSql.append("							SELECT ACCT_CD, NET_AMT AS DD_AMT, SALS_DATE								\n");
            //sbSql.append("							  FROM SLA_UPJANG_SALS_ISRC													\n");
            //sbSql.append("							 WHERE UPJANG_CD = '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'	\n");
            //sbSql.append(" 	 				   		   AND SUBSTR(SALS_DATE, 1, 6) = '" + ds_Cond.getString(0, "INPUT_YY") + "'	\n");
            //sbSql.append(" 	 				   		   AND SYS_CLASS = '11'														\n");
            //sbSql.append(" 	 				   		   AND ACCT_CD IN (														\n");
            //sbSql.append(" 	'41201010','41201020','41201030','41201040','41203010','41203020','41206010','41206020','41206030','41209060'\n");
            ////sbSql.append(" ,'42201010','42201020','42201030','42201040','42202000','42203010','42203020','42204000'			\n");
            //sbSql.append(" 	 				   		                  )														\n");

            sbSql.append("                              SELECT C.ACCT_CD                                                               \n");
            sbSql.append("                                   , B.OCCUR_DATE AS SALS_DATE                                               \n");
            sbSql.append("                                   , SUM(B.NET_AMT) AS DD_AMT                                                \n");
            sbSql.append("                                FROM SLA_IF_UPJANG_SALS_DETAIL B                                             \n");
            sbSql.append("                                   , (SELECT DISTINCT B.ACCT_CD, A.SALS_TYPE                                 \n");
            sbSql.append("                                        FROM SLA_SALES_SALS_TYPE A                                           \n");
            sbSql.append("                                            ,SLA_TYPE_CD_MST B                                               \n");
            sbSql.append("                                       WHERE A.TYPE_GRP_CD = B.TYPE_GRP_CD(+)                                \n");
            sbSql.append("                                         AND A.TYPE_CD = B.TYPE_CD(+)                                        \n");
            sbSql.append("                                         AND A.SALS_TYPE IN ('2004','1103', '1102', '1202', '1203', '2001', '1106', '1204', '1205', '2101', '2102')  \n");
            sbSql.append("                                         AND A.USE_YN = 'Y'                                                  \n");
            sbSql.append("                                         AND B.ACCT_CD != '98001010'                                         \n");
            sbSql.append("                                     ) C                                                                     \n");
            sbSql.append("                               WHERE B.SALS_CLASS = C.SALS_TYPE                                              \n");
            sbSql.append("                                 AND B.UPJANG_CD = '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'     \n");
            //sbSql.append("                                 AND SUBSTR(B.OCCUR_DATE, 1, 6) = '" + ds_Cond.getString(0, "INPUT_YY") + "' \n");
            sbSql.append("                                 AND B.OCCUR_DATE LIKE '" + ds_Cond.getString(0, "INPUT_YY") + "'||'%' \n");
            //sbSql.append("                                 AND B.SYS_CLASS = '11'                                                    \n");
            sbSql.append("                                 AND B.RECD_STATUS = 'L'                                                     \n");
            sbSql.append("                               GROUP BY B.UPJANG_CD, C.ACCT_CD, B.OCCUR_DATE                                 \n");

            sbSql.append(" 						   ) B				 															\n");
            // 끝.
            sbSql.append(" 						  ,(				 															\n");
            //sbSql.append("							SELECT ACCT_CD, ROUND((SUM(A.DD_AMT) / 1000)) AS MM_AMT, ROUND((SUM(A.MM_AMT) / 1000)) AS SUM_AMT	\n");
            //sbSql.append("							SELECT ACCT_CD, ROUND((SUM(A.DD_AMT) / 1000)) AS MM_AMT, ROUND((SUM(A.MM_AMT) / 1000)) AS SUM_AMT	\n");
            //SUM_AMT 저장된 금액 그대로 나오게 수정 20160113  요청자 : 유영진 처리자 : 맹수영
            sbSql.append("							SELECT ACCT_CD, ROUND((SUM(A.DD_AMT) / 1000)) AS MM_AMT, MAX(A.MM_AMT) AS SUM_AMT	\n");
            sbSql.append("							  FROM MAP_DAY_PLAN A														\n");
            sbSql.append("							 WHERE A.UPJANG = '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'		\n");
            //sbSql.append(" 	 				   		   AND SUBSTR(A.YMD, 1, 6) = '" + ds_Cond.getString(0, "INPUT_YY") + "'		\n");
            sbSql.append(" 	 				   		   AND A.YMD LIKE '" + ds_Cond.getString(0, "INPUT_YY") + "'||'%'		\n");
            sbSql.append("   				   		   AND A.DAY_CLASS = '" + nullToBlank(ds_Cond.getString(0, "DAY_CLASS")) + "'	\n");
            sbSql.append("					 		 GROUP BY ACCT_CD															\n");
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
            sbSql.append(" 		   					   AND CLASS = '" + "R" + "'												\n");
            sbSql.append(" 		 				   ) D 																			\n");
            sbSql.append(" 				     WHERE A.ACCT_CD = B.ACCT_CD(+)														\n");
            sbSql.append("   				   AND A.YMD = B.SALS_DATE(+)														\n");
            sbSql.append("   				   AND A.UPJANG = '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'				\n");
            //sbSql.append(" 	 				   AND SUBSTR(A.YMD, 1, 6) = '" + ds_Cond.getString(0, "INPUT_YY") + "'				\n");
            sbSql.append(" 	 				   AND A.YMD LIKE '" + ds_Cond.getString(0, "INPUT_YY") + "'||'%'				\n");
            sbSql.append("   				   AND A.DAY_CLASS = '" + "R" + "'													\n");
            sbSql.append("   				   AND A.ACCT_CD = C.ACCT_CD														\n");
            sbSql.append("   				   AND A.UPJANG = D.UPJANG(+)														\n");
            //sbSql.append("   				   AND B.CONFIRM_YN = '" + "Y" + "'													\n");
            sbSql.append("					 GROUP BY A.ACCT_CLASS, A.ACCT_NM, A.ACCT_CD, A.CC_CD, A.YMD, A.DD_AMT, C.MM_AMT, D.MM_MARGIN_RATE, D.UPJANG, C.SUM_AMT	\n");
            sbSql.append("   				)																					\n");
            sbSql.append(" PIVOT ( AVG(DD_AMT) FOR YMD IN (" + nullToBlank(ds_Cond.getString(0, "SEARCH_COL")) + ") )			\n");
            sbSql.append("   		) A																							\n");
            /*
            sbSql.append("   	   ,(																							\n");
            sbSql.append("					SELECT DISTINCT ACCT_CD AS ACCT_CD2, ACCT_NM, ACCT_CLASS, YY, '' AS LAST_DD_CNT		\n");
            sbSql.append("  				  FROM MAP_DAY_PLAN  																\n");
            sbSql.append(" 				     WHERE YMD IN (" + nullToBlank(ds_Cond.getString(0, "SEARCH_DD")) + ")				\n");
            sbSql.append("   		) B																							\n");
            */
            //sbSql.append(" WHERE A.ACCT_CD = B.ACCT_CD2																			\n");
            //sbSql.append(" WHERE A.DAY_CLASS = 'R'																				\n");
            sbSql.append("  ORDER BY DECODE(A.ACCT_CLASS,'매출액','1','재료비','2','인건비','3','경비','4'), A.ACCT_CD																					\n");
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