<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 사업계획관리
■ 프로그램ID   : MAP30020E_T004.jsp
■ 프로그램명   : 월추정 적용대상 조회
■ 작성일자     : 2015-06-21
■ 작성자       : 김태윤
■ 이력관리     :
  2018.04.20 김명섭 사업계획관리개선
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
        String g_Upjang = nullToBlank(in_vl.getString("g_Upjang"));
        String g_Yy     	= nullToBlank(in_vl.getString("g_Yy"));
        String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));

        //out 데이타
        DataSet ds_List;

        //sql문 버퍼생성
        StringBuffer sbSql = new StringBuffer();

        // 월추정 입력여부 조회.
        // 무조건 BPC에서 전송한 최종PL로 월추정 생성.
        String isData = "0"; 
        sbSql.append("SELECT COUNT(1) ISDATA  														\n");
        sbSql.append("  FROM MAP_BPC_MODIFY_PLAN T1, MAP_BPC_CONFIRM_PL_INFO T2                     \n");
        sbSql.append(" WHERE T1.PLAN_CLASS = '" + "AP" + "' 										\n");
        sbSql.append(" 	 AND T1.PLAN_YEAR = '" + g_Yy + "' 	                                        \n");
        sbSql.append("   AND T1.VER_NM = '" + nullToBlank(ds_Cond.getString(0, "BIZ_CLASS")) + "'	\n");
        sbSql.append("   AND T1.PLAN_CLASS = T2.PLAN_CLASS 											\n");
        sbSql.append("   AND T1.PLAN_CLASS = T2.PLAN_CLASS 											\n");
        sbSql.append("   AND T1.PLAN_YEAR = T2.PLAN_YEAR 											\n");
        sbSql.append("   AND T1.VER_CD = T2.VER_CD 					        						\n");
        sbSql.append("   AND T2.CC_CD  = '" + nullToBlank(ds_Cond.getString(0, "CC_CD")) + "'	 	\n");
        pstmt = conn.prepareStatement(sbSql.toString());
        rs = pstmt.executeQuery();
        
        while(rs.next()) {
          isData = rs.getString("ISDATA");
        }
        if(rs != null) rs.close();

    	//2018.03.16 김명섭 최종버젼 정보 조회되도록 개선
        String strVercd = ""; 
        sbSql.delete(0, sbSql.length());
        sbSql.append(" SELECT VER_CD VER_CD FROM MAP_BPC_MODIFY_PLAN	\n");
        sbSql.append(" 	WHERE PLAN_YEAR = '" + g_Yy + "' 	\n");
        sbSql.append(" 	  AND PLAN_CLASS = 'AP'	\n");
        sbSql.append("    AND VER_NM = '" + nullToBlank(ds_Cond.getString(0, "BIZ_CLASS")) + "'	\n");
        sbSql.append(" 	  AND BPC_CONFIRM_YN = 'Y'	\n");
        pstmt = conn.prepareStatement(sbSql.toString());
        rs = pstmt.executeQuery();

        while(rs.next()) {
          strVercd = rs.getString("VER_CD");
        }
        if(rs != null) rs.close();
        
        // BPC에서 내려준 업장이 존재하지 않다면(신규업장) MAP_BPC_CONFIRM_PL_INFO 0으로 기본 Base를 깔아준다.(Insert)
        if ("0".equals(isData)) {
            sbSql.delete(0, sbSql.length());
            sbSql.append(" INSERT INTO MAP_BPC_CONFIRM_PL_INFO \n");
            sbSql.append(" SELECT  'AP' \n");
            sbSql.append("        ,'" + g_Yy + "' \n");
            //버전증가에 따른 중복데이터 조회 개선
            //sbSql.append("        ,(SELECT DISTINCT VER_CD FROM MAP_BIZ_LOG_MGMT WHERE YY = '" + g_Yy + "' AND CONFIRM_YN = 'Y' AND ORGIN_YN = 'N') \n");
            sbSql.append("        ,(SELECT MAX(VER_CD) FROM MAP_BIZ_LOG_MGMT WHERE YY = '" + g_Yy + "' AND CONFIRM_YN = 'Y' AND ORGIN_YN = 'N') \n");
            sbSql.append("        ,'" + nullToBlank(ds_Cond.getString(0, "CC_CD")) + "' \n");
            sbSql.append("        ,'100000' \n");
            sbSql.append("        ,'N_RANK' \n");
            sbSql.append("        ,'' \n");
            sbSql.append("        ,B.ACCT_CD \n");
            sbSql.append("        ,B.ACCT_NM \n");
            sbSql.append("        ,0 AS MM_AMT_01 \n");
            sbSql.append("        ,0 AS MM_AMT_02 \n");
            sbSql.append("        ,0 AS MM_AMT_03 \n");
            sbSql.append("        ,0 AS MM_AMT_04 \n");
            sbSql.append("        ,0 AS MM_AMT_05 \n");
            sbSql.append("        ,0 AS MM_AMT_06 \n");
            sbSql.append("        ,0 AS MM_AMT_07 \n");
            sbSql.append("        ,0 AS MM_AMT_08 \n");
            sbSql.append("        ,0 AS MM_AMT_09 \n");
            sbSql.append("        ,0 AS MM_AMT_10 \n");
            sbSql.append("        ,0 AS MM_AMT_11 \n");
            sbSql.append("        ,0 AS MM_AMT_12 \n");
            sbSql.append("        ,SYSDATE \n");
            sbSql.append("        ,'" + g_EmpNo + "' \n");
            sbSql.append("        ,'" + g_EmpNo + "' \n");
            sbSql.append("        ,SYSDATE \n");
            sbSql.append("    FROM DUAL A \n");
            sbSql.append("        ,( \n");
            sbSql.append("         SELECT ACCT_CD \n");
            sbSql.append("               ,ACCT_NM \n");
            sbSql.append("               ,ACCT_CLASS \n");
            sbSql.append("           FROM ( \n");
            sbSql.append("                 SELECT ACCTCD AS ACCT_CD \n");
            sbSql.append("                       ,ACCTNM6 AS ACCT_NM \n");
            sbSql.append("                       ,DECODE(SUBSTR(ACCTCD,1,2), '41', '매출액', '42', '재료비', '43', '노무비/경비') ACCT_CLASS \n");
            sbSql.append("                   FROM ST_ACCOUNT \n");
            sbSql.append("                  WHERE ACCT_TYPE1 = 'PL' \n");
            sbSql.append("                    AND USE_YN = 'Y' \n");
            sbSql.append("                    AND BU_CD = '2000' \n");
            sbSql.append("                    AND SUBSTR(ACCTCD,1,2) IN ('41', '42')  -- 41 매출액, 42, 재료비, 4310 노무비 경비, 4320~ 경비\n");
            sbSql.append("                  UNION ALL \n");
            sbSql.append("                 SELECT ACCTCD AS ACCT_CD \n");
            sbSql.append("                       ,ACCTNM6 AS ACCT_NM \n");
            sbSql.append("                       ,DECODE(SUBSTR(ACCTCD,1,3), '431', '노무비', '432', '경비', '경비') ACCT_CLASS \n");
            sbSql.append("                   FROM ST_ACCOUNT \n");
            sbSql.append("                  WHERE ACCT_TYPE1 = 'PL' \n");
            sbSql.append("                    AND USE_YN = 'Y' \n");
            sbSql.append("                    AND BU_CD = '2000' \n");
            sbSql.append("                    AND SUBSTR(ACCTCD,1,2) IN ('43') -- 41 매출액, 42, 재료비, 4310 노무비 경비, 4320~ 경비\n");
            sbSql.append("                 ) \n");
            sbSql.append("          ORDER BY ACCT_CD \n");
            sbSql.append("         ) B \n");
            sbSql.append("   WHERE 1 = 1 \n");
            sbSql.append("   ORDER BY B.ACCT_CD \n");

            pstmt = conn.prepareStatement(sbSql.toString());
            pstmt.executeUpdate();
            pstmt.close();
            conn.commit();
            isData = "1";
        }

        // 등록된 월추정 데이터가 없으면 BPC에서 제공한 최종사업계획 데이터에서 조회한다.
        //if(!"0".equals(isData)){

            sbSql.delete(0, sbSql.length());
            /*sbSql.append(" SELECT CASE WHEN SUBSTR(A.ACCT_CD, 1, 2) = '41' THEN '매출액'                        \n");
            sbSql.append("             WHEN SUBSTR(A.ACCT_CD, 1, 2) = '42' THEN '재료비'                        \n");
            sbSql.append("             WHEN SUBSTR(A.ACCT_CD, 1, 3) = '431' THEN '노무비'                       \n");
            sbSql.append("             WHEN SUBSTR(A.ACCT_CD, 1, 3) = '432' THEN '경비'                         \n");
            sbSql.append("         ELSE '경비'                                                                  \n");
            sbSql.append("         END ACCT_CLASS                                                               \n");
            */

            sbSql.append(" SELECT B.ACCT_CLASS, B.L_ACCT_NM, B.M_ACCT_NM, B.S_ACCT_NM							\n");
            sbSql.append("       ,B.ACCT_NM, B.ACCT_CD, A.PLAN_YEAR AS YY, 'N' AS CONFIRM_YN, 'N' AS IMPROV_YN	\n");
            //관리 추가 20160111  맹수영  요청자 : 유영진
            if("M".equals(ds_Cond.getString(0, "CLOSE_TYPE"))){            
                sbSql.append("       ,CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203'                                                                                                                                                                 \n");
                sbSql.append("             THEN  ROUND((A.MM_AMT_01	* (SELECT  NVL(MM_MARGIN_RATE_01/ 100,1) FROM MAP_MARGIN_RATE_MGMT WHERE A.PLAN_YEAR = YY AND UPJANG = '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'	 AND CLASS = 'P'))/ 1000) \n");
                sbSql.append("             ELSE ROUND(A.MM_AMT_01 / 1000)                                                                                                                                                                       \n");
                sbSql.append("             END                                                                                                                                                                                                  \n");
                sbSql.append("             AS MM_AMT_01                                                                                                                                                                                         \n");
                sbSql.append("       ,CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203'                                                                                                                                                                 \n");
                sbSql.append("             THEN  ROUND((A.MM_AMT_02	* (SELECT  NVL(MM_MARGIN_RATE_02/ 100,1) FROM MAP_MARGIN_RATE_MGMT WHERE A.PLAN_YEAR = YY AND UPJANG = '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'	 AND CLASS = 'P'))/ 1000) \n");
                sbSql.append("             ELSE ROUND(A.MM_AMT_02 / 1000)                                                                                                                                                                       \n");
                sbSql.append("             END                                                                                                                                                                                                  \n");
                sbSql.append("             AS MM_AMT_02                                                                                                                                                                                         \n");
                sbSql.append("       ,CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203'                                                                                                                                                                 \n");
                sbSql.append("             THEN  ROUND((A.MM_AMT_03	* (SELECT  NVL(MM_MARGIN_RATE_03/ 100,1) FROM MAP_MARGIN_RATE_MGMT WHERE A.PLAN_YEAR = YY AND UPJANG ='" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'	 AND CLASS = 'P'))/ 1000) \n");
                sbSql.append("             ELSE ROUND(A.MM_AMT_03 / 1000)                                                                                                                                                                       \n");
                sbSql.append("             END                                                                                                                                                                                                  \n");
                sbSql.append("             AS MM_AMT_03                                                                                                                                                                                         \n");
                sbSql.append("       ,CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203'                                                                                                                                                                 \n");
                sbSql.append("             THEN  ROUND((A.MM_AMT_04	* (SELECT  NVL(MM_MARGIN_RATE_04/ 100,1) FROM MAP_MARGIN_RATE_MGMT WHERE A.PLAN_YEAR = YY AND UPJANG ='" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'	 AND CLASS = 'P'))/ 1000) \n");
                sbSql.append("             ELSE ROUND(A.MM_AMT_04 / 1000)                                                                                                                                                                       \n");
                sbSql.append("             END                                                                                                                                                                                                  \n");
                sbSql.append("             AS MM_AMT_04                                                                                                                                                                                        \n");
                sbSql.append("       ,CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203'                                                                                                                                                                 \n");
                sbSql.append("             THEN  ROUND((A.MM_AMT_05	* (SELECT  NVL(MM_MARGIN_RATE_05/ 100,1) FROM MAP_MARGIN_RATE_MGMT WHERE A.PLAN_YEAR = YY AND UPJANG ='" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'	 AND CLASS = 'P'))/ 1000) \n");
                sbSql.append("             ELSE ROUND(A.MM_AMT_05 / 1000)                                                                                                                                                                       \n");
                sbSql.append("             END                                                                                                                                                                                                  \n");
                sbSql.append("             AS MM_AMT_05                                                                                                                                                                                         \n");
                sbSql.append("       ,CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203'                                                                                                                                                                 \n");
                sbSql.append("             THEN  ROUND((A.MM_AMT_06	* (SELECT  NVL(MM_MARGIN_RATE_06/ 100,1) FROM MAP_MARGIN_RATE_MGMT WHERE A.PLAN_YEAR = YY AND UPJANG ='" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'	 AND CLASS = 'P'))/ 1000) \n");
                sbSql.append("             ELSE ROUND(A.MM_AMT_06 / 1000)                                                                                                                                                                       \n");
                sbSql.append("             END                                                                                                                                                                                                  \n");
                sbSql.append("             AS MM_AMT_06                                                                                                                                                                                         \n");
                sbSql.append("       ,CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203'                                                                                                                                                                 \n");
                sbSql.append("             THEN  ROUND((A.MM_AMT_07	* (SELECT  NVL(MM_MARGIN_RATE_07/ 100,1) FROM MAP_MARGIN_RATE_MGMT WHERE A.PLAN_YEAR = YY AND UPJANG ='" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'	 AND CLASS = 'P'))/ 1000) \n");
                sbSql.append("             ELSE ROUND(A.MM_AMT_07 / 1000)                                                                                                                                                                       \n");
                sbSql.append("             END                                                                                                                                                                                                  \n");
                sbSql.append("             AS MM_AMT_07                                                                                                                                                                                         \n");
                sbSql.append("       ,CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203'                                                                                                                                                                 \n");
                sbSql.append("             THEN  ROUND((A.MM_AMT_08	* (SELECT  NVL(MM_MARGIN_RATE_08/ 100,1) FROM MAP_MARGIN_RATE_MGMT WHERE A.PLAN_YEAR = YY AND UPJANG ='" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'	 AND CLASS = 'P'))/ 1000) \n");
                sbSql.append("             ELSE ROUND(A.MM_AMT_08 / 1000)                                                                                                                                                                       \n");
                sbSql.append("             END                                                                                                                                                                                                  \n");
                sbSql.append("             AS MM_AMT_08                                                                                                                                                                                         \n");
                sbSql.append("       ,CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203'                                                                                                                                                                 \n");
                sbSql.append("             THEN  ROUND((A.MM_AMT_09	* (SELECT  NVL(MM_MARGIN_RATE_09/ 100,1) FROM MAP_MARGIN_RATE_MGMT WHERE A.PLAN_YEAR = YY AND UPJANG ='" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'	 AND CLASS = 'P'))/ 1000) \n");
                sbSql.append("             ELSE ROUND(A.MM_AMT_09 / 1000)                                                                                                                                                                       \n");
                sbSql.append("             END                                                                                                                                                                                                  \n");
                sbSql.append("             AS MM_AMT_09                                                                                                                                                                                         \n");
                sbSql.append("       ,CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203'                                                                                                                                                                 \n");
                sbSql.append("             THEN  ROUND((A.MM_AMT_10	* (SELECT  NVL(MM_MARGIN_RATE_10/ 100,1) FROM MAP_MARGIN_RATE_MGMT WHERE A.PLAN_YEAR = YY AND UPJANG ='" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'	 AND CLASS = 'P'))/ 1000) \n");
                sbSql.append("             ELSE ROUND(A.MM_AMT_10 / 1000)                                                                                                                                                                       \n");
                sbSql.append("             END                                                                                                                                                                                                  \n");
                sbSql.append("             AS MM_AMT_10                                                                                                                                                                                         \n");
                sbSql.append("       ,CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203'                                                                                                                                                                 \n");
                sbSql.append("             THEN  ROUND((A.MM_AMT_11	* (SELECT  NVL(MM_MARGIN_RATE_11/ 100,1) FROM MAP_MARGIN_RATE_MGMT WHERE A.PLAN_YEAR = YY AND UPJANG ='" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'	 AND CLASS = 'P'))/ 1000) \n");
                sbSql.append("             ELSE ROUND(A.MM_AMT_11 / 1000)                                                                                                                                                                       \n");
                sbSql.append("             END                                                                                                                                                                                                  \n");
                sbSql.append("             AS MM_AMT_11                                                                                                                                                                                         \n");
                sbSql.append("       ,CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203'                                                                                                                                                                 \n");
                sbSql.append("             THEN  ROUND((A.MM_AMT_12	* (SELECT  NVL(MM_MARGIN_RATE_12/ 100,1) FROM MAP_MARGIN_RATE_MGMT WHERE A.PLAN_YEAR = YY AND UPJANG ='" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'	 AND CLASS = 'P'))/ 1000) \n");
                sbSql.append("             ELSE ROUND(A.MM_AMT_12 / 1000)                                                                                                                                                                       \n");
                sbSql.append("             END                                                                                                                                                                                                  \n");
                sbSql.append("             AS MM_AMT_12                                                                                                                                                                                        \n");

                sbSql.append("       ,CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203'                                                                                                                                                                 \n");
                sbSql.append("             THEN  ROUND((A.MM_AMT_01	* (SELECT  NVL(MM_MARGIN_RATE_01/ 100,1) FROM MAP_MARGIN_RATE_MGMT WHERE A.PLAN_YEAR = YY AND UPJANG = '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'	 AND CLASS = 'P'))/ 1000) \n");
                sbSql.append("             ELSE ROUND(A.MM_AMT_01 / 1000)                                                                                                                                                                       \n");
                sbSql.append("             END                                                                                                                                                                                                  \n");
                
                sbSql.append("       +CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203'                                                                                                                                                                 \n");
                sbSql.append("             THEN  ROUND((A.MM_AMT_02	* (SELECT  NVL(MM_MARGIN_RATE_02/ 100,1) FROM MAP_MARGIN_RATE_MGMT WHERE A.PLAN_YEAR = YY AND UPJANG = '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'	 AND CLASS = 'P'))/ 1000) \n");
                sbSql.append("             ELSE ROUND(A.MM_AMT_02 / 1000)                                                                                                                                                                       \n");
                sbSql.append("             END                                                                                                                                                                                                  \n");
                
                sbSql.append("       +CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203'                                                                                                                                                                 \n");
                sbSql.append("             THEN  ROUND((A.MM_AMT_03	* (SELECT  NVL(MM_MARGIN_RATE_03/ 100,1) FROM MAP_MARGIN_RATE_MGMT WHERE A.PLAN_YEAR = YY AND UPJANG ='" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'	 AND CLASS = 'P'))/ 1000) \n");
                sbSql.append("             ELSE ROUND(A.MM_AMT_03 / 1000)                                                                                                                                                                       \n");
                sbSql.append("             END                                                                                                                                                                                                  \n");
                
                sbSql.append("       +CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203'                                                                                                                                                                 \n");
                sbSql.append("             THEN  ROUND((A.MM_AMT_04	* (SELECT  NVL(MM_MARGIN_RATE_04/ 100,1) FROM MAP_MARGIN_RATE_MGMT WHERE A.PLAN_YEAR = YY AND UPJANG ='" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'	 AND CLASS = 'P'))/ 1000) \n");
                sbSql.append("             ELSE ROUND(A.MM_AMT_04 / 1000)                                                                                                                                                                       \n");
                sbSql.append("             END                                                                                                                                                                                                  \n");
                
                sbSql.append("       +CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203'                                                                                                                                                                 \n");
                sbSql.append("             THEN  ROUND((A.MM_AMT_05	* (SELECT  NVL(MM_MARGIN_RATE_05/ 100,1) FROM MAP_MARGIN_RATE_MGMT WHERE A.PLAN_YEAR = YY AND UPJANG ='" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'	 AND CLASS = 'P'))/ 1000) \n");
                sbSql.append("             ELSE ROUND(A.MM_AMT_05 / 1000)                                                                                                                                                                       \n");
                sbSql.append("             END                                                                                                                                                                                                  \n");
                
                sbSql.append("       +CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203'                                                                                                                                                                 \n");
                sbSql.append("             THEN  ROUND((A.MM_AMT_06	* (SELECT  NVL(MM_MARGIN_RATE_06/ 100,1) FROM MAP_MARGIN_RATE_MGMT WHERE A.PLAN_YEAR = YY AND UPJANG ='" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'	 AND CLASS = 'P'))/ 1000) \n");
                sbSql.append("             ELSE ROUND(A.MM_AMT_06 / 1000)                                                                                                                                                                       \n");
                sbSql.append("             END                                                                                                                                                                                                  \n");
                
                sbSql.append("       +CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203'                                                                                                                                                                 \n");
                sbSql.append("             THEN  ROUND((A.MM_AMT_07	* (SELECT  NVL(MM_MARGIN_RATE_07/ 100,1) FROM MAP_MARGIN_RATE_MGMT WHERE A.PLAN_YEAR = YY AND UPJANG ='" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'	 AND CLASS = 'P'))/ 1000) \n");
                sbSql.append("             ELSE ROUND(A.MM_AMT_07 / 1000)                                                                                                                                                                       \n");
                sbSql.append("             END                                                                                                                                                                                                  \n");
                
                sbSql.append("       +CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203'                                                                                                                                                                 \n");
                sbSql.append("             THEN  ROUND((A.MM_AMT_08	* (SELECT  NVL(MM_MARGIN_RATE_08/ 100,1) FROM MAP_MARGIN_RATE_MGMT WHERE A.PLAN_YEAR = YY AND UPJANG ='" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'	 AND CLASS = 'P'))/ 1000) \n");
                sbSql.append("             ELSE ROUND(A.MM_AMT_08 / 1000)                                                                                                                                                                       \n");
                sbSql.append("             END                                                                                                                                                                                                  \n");
                
                sbSql.append("       +CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203'                                                                                                                                                                 \n");
                sbSql.append("             THEN  ROUND((A.MM_AMT_09	* (SELECT  NVL(MM_MARGIN_RATE_09/ 100,1) FROM MAP_MARGIN_RATE_MGMT WHERE A.PLAN_YEAR = YY AND UPJANG ='" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'	 AND CLASS = 'P'))/ 1000) \n");
                sbSql.append("             ELSE ROUND(A.MM_AMT_09 / 1000)                                                                                                                                                                       \n");
                sbSql.append("             END                                                                                                                                                                                                  \n");
                
                sbSql.append("       +CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203'                                                                                                                                                                 \n");
                sbSql.append("             THEN  ROUND((A.MM_AMT_10	* (SELECT  NVL(MM_MARGIN_RATE_10/ 100,1) FROM MAP_MARGIN_RATE_MGMT WHERE A.PLAN_YEAR = YY AND UPJANG ='" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'	 AND CLASS = 'P'))/ 1000) \n");
                sbSql.append("             ELSE ROUND(A.MM_AMT_10 / 1000)                                                                                                                                                                       \n");
                sbSql.append("             END                                                                                                                                                                                                  \n");
                
                sbSql.append("       +CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203'                                                                                                                                                                 \n");
                sbSql.append("             THEN  ROUND((A.MM_AMT_11	* (SELECT  NVL(MM_MARGIN_RATE_11/ 100,1) FROM MAP_MARGIN_RATE_MGMT WHERE A.PLAN_YEAR = YY AND UPJANG ='" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'	 AND CLASS = 'P'))/ 1000) \n");
                sbSql.append("             ELSE ROUND(A.MM_AMT_11 / 1000)                                                                                                                                                                       \n");
                sbSql.append("             END                                                                                                                                                                                                  \n");
                
                sbSql.append("       +CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203'                                                                                                                                                                 \n");
                sbSql.append("             THEN  ROUND((A.MM_AMT_12	* (SELECT  NVL(MM_MARGIN_RATE_12/ 100,1) FROM MAP_MARGIN_RATE_MGMT WHERE A.PLAN_YEAR = YY AND UPJANG ='" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'	 AND CLASS = 'P'))/ 1000) \n");
                sbSql.append("             ELSE ROUND(A.MM_AMT_12 / 1000)                                                                                                                                                                       \n");
                sbSql.append("             END                                                                                                                                                                                                  \n");
                sbSql.append("             AS SUM_AMT                                                                                                                                                                                        \n");
                

            } else  //재무
            {
                sbSql.append("       ,ROUND(A.MM_AMT_01 / 1000) AS MM_AMT_01										\n");
                sbSql.append("       ,ROUND(A.MM_AMT_02 / 1000) AS MM_AMT_02										\n");
                sbSql.append("       ,ROUND(A.MM_AMT_03 / 1000) AS MM_AMT_03										\n");
                sbSql.append("       ,ROUND(A.MM_AMT_04 / 1000) AS MM_AMT_04										\n");
                sbSql.append("       ,ROUND(A.MM_AMT_05 / 1000) AS MM_AMT_05										\n");
                sbSql.append("       ,ROUND(A.MM_AMT_06 / 1000) AS MM_AMT_06										\n");
                sbSql.append("       ,ROUND(A.MM_AMT_07 / 1000) AS MM_AMT_07										\n");
                sbSql.append("       ,ROUND(A.MM_AMT_08 / 1000) AS MM_AMT_08										\n");
                sbSql.append("       ,ROUND(A.MM_AMT_09 / 1000) AS MM_AMT_09										\n");
                sbSql.append("       ,ROUND(A.MM_AMT_10 / 1000) AS MM_AMT_10										\n");
                sbSql.append("       ,ROUND(A.MM_AMT_11 / 1000) AS MM_AMT_11										\n");
                sbSql.append("       ,ROUND(A.MM_AMT_12 / 1000) AS MM_AMT_12										\n");
                sbSql.append(" 		,ROUND((A.MM_AMT_01+A.MM_AMT_02+A.MM_AMT_03+A.MM_AMT_04+A.MM_AMT_05+A.MM_AMT_06	\n");
                sbSql.append(" 			   +A.MM_AMT_07+A.MM_AMT_08+A.MM_AMT_09+A.MM_AMT_10+A.MM_AMT_11+A.MM_AMT_12	\n");
                sbSql.append("   		    ) / 1000 ) SUM_AMT														\n");
            	
            }
            sbSql.append("       , A.VER_CD, '" + nullToBlank(ds_Cond.getString(0, "CC_CD")) + "' AS CC_CD, A.JOB_GRADE_CD, A.JOB_GRADE_NM							\n");
            sbSql.append("  	 ,DECODE(B.ACCT_CLASS, '매출액', '1', '재료비', '2', '인건비', '3', '경비', '4') SKEY					\n");
            sbSql.append("   FROM MAP_BPC_CONFIRM_PL_INFO A 													\n");
            sbSql.append("	   ,(				          																				  \n");
            sbSql.append("          SELECT ACCT_CD   \n");
            sbSql.append("                ,ACCT_NM   \n");
            sbSql.append("                ,L_ACCT_NM   \n");
            sbSql.append("                ,M_ACCT_NM   \n");
            sbSql.append("                ,S_ACCT_NM   \n");
            sbSql.append("                ,M_ACCT_NM ACCT_CLASS \n");
            sbSql.append("                ,SEQ       \n");
            sbSql.append("            FROM (         \n");
            sbSql.append("                  SELECT ACCTCD AS ACCT_CD \n");
            sbSql.append("                        ,ACCTNM4 AS ACCT_NM \n");
            sbSql.append("                        ,ACCTNM1 AS L_ACCT_NM \n");
            sbSql.append("                        ,ACCTNM2 AS M_ACCT_NM \n");
            sbSql.append("                        ,ACCTNM3 AS S_ACCT_NM \n");
            sbSql.append("                        ,SEQ \n");
            sbSql.append("                    FROM MAS_ST_ACCOUNT \n");
            sbSql.append("                  )        \n");
            sbSql.append("           ORDER BY SEQ    \n");            
            
            sbSql.append("	    ) B		  																								\n");
            sbSql.append("  WHERE A.ACCT_CD(+) = B.ACCT_CD														\n");
            // 최종BPC 데이터가 있을때만 조회.
            if(!"0".equals(isData)){
                sbSql.append("    AND A.PLAN_CLASS(+) = 'AP'													\n");
                sbSql.append("    AND A.VER_CD(+) = '" + strVercd + "'											\n");
            // 데이터 안나오게 처리.
            }else{
                sbSql.append("    AND A.PLAN_CLASS = 'XX'														\n");
            }
            sbSql.append("    AND A.CC_CD(+) = '" + nullToBlank(ds_Cond.getString(0, "CC_CD")) + "'        		\n");
            sbSql.append("    AND A.PLAN_YEAR(+) = '" + g_Yy + "'      											\n");
            sbSql.append("    AND A.JOB_GRADE_CD(+) = 'N_RANK'	     											\n");
            sbSql.append("  ORDER BY B.SEQ                                                                  \n");
            /*
            sbSql.append("SELECT A.ACCT_CLASS, A.ACCT_NM, A.ACCT_CD, A.YY, 'N' AS CONFIRM_YN, 'N' AS IMPROV_YN	\n");
            sbSql.append("      ,ROUND(A.MM_AMT_01 / 1000) AS MM_AMT_01											\n");
            sbSql.append("      ,ROUND(A.MM_AMT_02 / 1000) AS MM_AMT_02											\n");
            sbSql.append("      ,ROUND(A.MM_AMT_03 / 1000) AS MM_AMT_03											\n");
            sbSql.append("      ,ROUND(A.MM_AMT_04 / 1000) AS MM_AMT_04											\n");
            sbSql.append("      ,ROUND(A.MM_AMT_05 / 1000) AS MM_AMT_05											\n");
            sbSql.append("      ,ROUND(A.MM_AMT_06 / 1000) AS MM_AMT_06											\n");
            sbSql.append("      ,ROUND(A.MM_AMT_07 / 1000) AS MM_AMT_07											\n");
            sbSql.append("      ,ROUND(A.MM_AMT_08 / 1000) AS MM_AMT_08											\n");
            sbSql.append("      ,ROUND(A.MM_AMT_09 / 1000) AS MM_AMT_09											\n");
            sbSql.append("      ,ROUND(A.MM_AMT_10 / 1000) AS MM_AMT_10											\n");
            sbSql.append("      ,ROUND(A.MM_AMT_11 / 1000) AS MM_AMT_11											\n");
            sbSql.append("      ,ROUND(A.MM_AMT_12 / 1000) AS MM_AMT_12											\n");
            sbSql.append("		,ROUND((A.MM_AMT_01+A.MM_AMT_02+A.MM_AMT_03+A.MM_AMT_04+A.MM_AMT_05+A.MM_AMT_06	\n");
            sbSql.append("			   +A.MM_AMT_07+A.MM_AMT_08+A.MM_AMT_09+A.MM_AMT_10+A.MM_AMT_11+A.MM_AMT_12	\n");
            sbSql.append("  		    ) / 1000 ) SUM_AMT														\n");
            sbSql.append("      , A.VER_CD, A.CC_CD, A.JOB_GRADE_CD, A.JOB_GRADE_NM								\n");
            sbSql.append("  FROM MAP_BIZ_PLAN A  																\n");
            sbSql.append(" 		,MAP_BIZ_LOG_MGMT B 															\n");
            sbSql.append(" WHERE A.UPJANG = B.UPJANG	 														\n");
            sbSql.append("   AND A.YY = B.YY 																	\n");
            sbSql.append("   AND B.CONFIRM_YN = 'Y'																\n");
            sbSql.append("   AND A.UPJANG = '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'				\n");
            //sbSql.append("   AND A.YY = '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'					\n");
            sbSql.append("   AND A.YY = '" + g_Yy + "'															\n");
            sbSql.append("   AND A.BIZ_CLASS = '" + nullToBlank(ds_Cond.getString(0, "BIZ_CLASS")) + "'			\n");
            sbSql.append("   AND B.BIZ_CLASS = '" + nullToBlank(ds_Cond.getString(0, "BIZ_CLASS")) + "'			\n");
            sbSql.append(" ORDER BY A.ACCT_CD																	\n");
            */
        //}else{
            /*
            sbSql.delete(0, sbSql.length());
            sbSql.append("SELECT A.ACCT_CLASS, A.ACCT_NM, A.ACCT_CD, A.YY, B.CONFIRM_YN		 					\n");
            sbSql.append("      ,ROUND(A.MM_AMT_01 / 1000) AS MM_AMT_01											\n");
            sbSql.append("      ,ROUND(A.MM_AMT_02 / 1000) AS MM_AMT_02											\n");
            sbSql.append("      ,ROUND(A.MM_AMT_03 / 1000) AS MM_AMT_03											\n");
            sbSql.append("      ,ROUND(A.MM_AMT_04 / 1000) AS MM_AMT_04											\n");
            sbSql.append("      ,ROUND(A.MM_AMT_05 / 1000) AS MM_AMT_05											\n");
            sbSql.append("      ,ROUND(A.MM_AMT_06 / 1000) AS MM_AMT_06											\n");
            sbSql.append("      ,ROUND(A.MM_AMT_07 / 1000) AS MM_AMT_07											\n");
            sbSql.append("      ,ROUND(A.MM_AMT_08 / 1000) AS MM_AMT_08											\n");
            sbSql.append("      ,ROUND(A.MM_AMT_09 / 1000) AS MM_AMT_09											\n");
            sbSql.append("      ,ROUND(A.MM_AMT_10 / 1000) AS MM_AMT_10											\n");
            sbSql.append("      ,ROUND(A.MM_AMT_11 / 1000) AS MM_AMT_11											\n");
            sbSql.append("      ,ROUND(A.MM_AMT_12 / 1000) AS MM_AMT_12											\n");
            sbSql.append("		,ROUND((A.MM_AMT_01+A.MM_AMT_02+A.MM_AMT_03+A.MM_AMT_04+A.MM_AMT_05+A.MM_AMT_06	\n");
            sbSql.append("			  +A.MM_AMT_07+A.MM_AMT_08+A.MM_AMT_09+A.MM_AMT_10+A.MM_AMT_11+A.MM_AMT_12	\n");
            sbSql.append("  			) / 1000 ) SUM_AMT														\n");
            sbSql.append("  FROM MAP_MON_PLAN A  																\n");
            sbSql.append(" 		,MAP_MON_LOG_MGMT B 															\n");
            sbSql.append(" WHERE A.UPJANG = B.UPJANG	 														\n");
            sbSql.append("   AND A.YY = B.YY 																	\n");
            //sbSql.append("   AND A.UPJANG = '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'				\n");
            sbSql.append("    AND A.UPJANG = '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'          	\n");
            sbSql.append("   AND A.YY = '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'					\n");
            sbSql.append("   AND A.BIZ_CLASS = '" + nullToBlank(ds_Cond.getString(0, "BIZ_CLASS2")) + "'		\n");
            sbSql.append("   AND B.BIZ_CLASS = '" + nullToBlank(ds_Cond.getString(0, "BIZ_CLASS2")) + "'		\n");
            sbSql.append(" ORDER BY A.ACCT_CD																	\n");
            */
        //}

        out_vl.add("fa_Sql", sbSql.toString());
        pstmt = conn.prepareStatement(sbSql.toString());
        rs = pstmt.executeQuery();
        ds_List = this.makeDataSet(rs, "ds_List");
        rs.close();
        pstmt.close();

        /**종료**/
        out_dl.add(ds_List);
        this.setResultMessage(0, "OK", out_vl);
    }
    catch(Exception ex)
    {
        conn.rollback();
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