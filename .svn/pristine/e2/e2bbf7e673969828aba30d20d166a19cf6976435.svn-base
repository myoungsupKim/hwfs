
<%
    /*-----------------------------------------------------------------------------
    ■ 시스템명     : 사업계획관리
    ■ 프로그램ID   : MAP30010E_T001.jsp
    ■ 프로그램명   : 사업계획관리
    ■ 작성일자     : 2015-06-08
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

        // 사업계획, 최종PL, 수정계획 입력여부 조회.
        sbSql.append("SELECT COUNT(1) ISDATA  														\n");
        sbSql.append("  FROM MAP_BIZ_LOG_MGMT														\n");
        sbSql.append(" WHERE YY = '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "' 			\n");
        sbSql.append("   AND UPJANG = '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "' 		\n");
        sbSql.append("   AND BIZ_CLASS = '" + nullToBlank(ds_Cond.getString(0, "BIZ_CLASS")) + "'	\n");

        pstmt = conn.prepareStatement(sbSql.toString());
        rs = pstmt.executeQuery();

        rs.next();

        String isData = rs.getString("ISDATA");

        // 실적정보 조회.
        sbSql.delete(0, sbSql.length());
        sbSql.append("SELECT COUNT(1) ISDATA2  														\n");
        sbSql.append("  FROM MAP_UPJANG_PL															\n");
        //sbSql.append(" WHERE CC_CD = (SELECT CC_CD FROM ST_UPJANG WHERE UPJANG = '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "') 			\n");
        sbSql.append(" WHERE CC_CD = '" + nullToBlank(ds_Cond.getString(0, "CC_CD")) + "' 			\n");
        sbSql.append("   AND FISCAL_YEAR = '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "' 	\n");

        pstmt = conn.prepareStatement(sbSql.toString());
        rs = pstmt.executeQuery();

        rs.next();

        String isData2 = rs.getString("ISDATA2");

        // 월추정 정보 조회.
        sbSql.delete(0, sbSql.length());
        sbSql.append("SELECT COUNT(1) ISDATA3  														\n");
        sbSql.append("  FROM MAP_MON_PLAN															\n");
        sbSql.append(" WHERE UPJANG = '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "' 		\n");
        sbSql.append("  AND YY = '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "' 			\n");

        pstmt = conn.prepareStatement(sbSql.toString());
        rs = pstmt.executeQuery();

        rs.next();

        String isData3 = rs.getString("ISDATA3");

        // BPC에서 최종PL 정보 유무 조회.
        sbSql.delete(0, sbSql.length());
        sbSql.append("SELECT COUNT(1) ISDATA4  														\n");
        sbSql.append("  FROM MAP_BPC_CONFIRM_PL_INFO												\n");
        sbSql.append(" WHERE PLAN_CLASS = 'AP'												 		\n");
        sbSql.append("  AND CC_CD = '" + nullToBlank(ds_Cond.getString(0, "CC_CD")) + "' 			\n");
        sbSql.append("  AND PLAN_YEAR = '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "' 	\n");

        pstmt = conn.prepareStatement(sbSql.toString());
        rs = pstmt.executeQuery();

        rs.next();

        String isData4 = rs.getString("ISDATA4");

        // 구분이 "_최종" 데이터일때만 BPC에서 최종PL 정보를 조회
        //System.out.println("ORGIN_YN================>"+ds_Cond.getString(0, "ORGIN_YN"));
        String isData5 = ds_Cond.getString(0, "ORGIN_YN");

        //System.out.println("CLOSE_TYPE ==> " + ds_Cond.getString(0, "CLOSE_TYPE"));

        // 최초 등록이면 월추정 데이터(실적+추정)를 기본값으로 보여준다.
        if ("0".equals(isData)) {
            sbSql.delete(0, sbSql.length());
            sbSql.append("SELECT B.ACCT_CLASS, B.ACCT_NM, B.ACCT_CD, A.FISCAL_YEAR AS YY, 'N' AS CONFIRM_YN, 'N' AS IMPROV_YN, 'Y' AS ORGIN_YN, 'N' AS BPC_SEND_YN, '' AS JOB_GRADE_CD, '' AS JOB_GRADE_NM	\n");
            // 관리금액
            if ("M".equals(ds_Cond.getString(0, "CLOSE_TYPE"))) {
                sbSql.append("      ,CASE WHEN SUBSTR(B.ACCT_CD,1,5) = '42203' THEN MAX(DECODE(D.MM_MARGIN_RATE_01,0,0,ROUND(DECODE(A.MM_AMT_01, 0, C.MM_AMT_01, NULL, C.MM_AMT_01, A.MM_AMT_01) * NVL((D.MM_MARGIN_RATE_01 / 100), 1)  / 1000)) )	  \n");
                sbSql.append("       ELSE MAX(ROUND(DECODE(A.MM_AMT_01, 0, C.MM_AMT_01, NULL, C.MM_AMT_01, A.MM_AMT_01) / 1000))                                                                                   \n");
                sbSql.append("        END MM_AMT_01                                                                                                                                                                   \n");
                sbSql.append("      ,CASE WHEN SUBSTR(B.ACCT_CD,1,5) = '42203' THEN MAX(DECODE(D.MM_MARGIN_RATE_02,0,0,ROUND(DECODE(A.MM_AMT_02, 0, C.MM_AMT_02, NULL, C.MM_AMT_02, A.MM_AMT_02) * NVL((D.MM_MARGIN_RATE_02 / 100), 1)  / 1000)))      \n");
                sbSql.append("       ELSE MAX(ROUND(DECODE(A.MM_AMT_02, 0, C.MM_AMT_02, NULL, C.MM_AMT_02, A.MM_AMT_02) / 1000))                                                                                   \n");
                sbSql.append("        END MM_AMT_02                                                                                                                                                                   \n");
                sbSql.append("      ,CASE WHEN SUBSTR(B.ACCT_CD,1,5) = '42203' THEN MAX(DECODE(D.MM_MARGIN_RATE_03,0,0,ROUND(DECODE(A.MM_AMT_03, 0, C.MM_AMT_03, NULL, C.MM_AMT_03, A.MM_AMT_03) * NVL((D.MM_MARGIN_RATE_03 / 100), 1)  / 1000)) )     \n");
                sbSql.append("       ELSE MAX(ROUND(DECODE(A.MM_AMT_03, 0, C.MM_AMT_03, NULL, C.MM_AMT_03, A.MM_AMT_03) / 1000))                                                                                   \n");
                sbSql.append("        END MM_AMT_03                                                                                                                                                                   \n");
                sbSql.append("      ,CASE WHEN SUBSTR(B.ACCT_CD,1,5) = '42203' THEN MAX(DECODE(D.MM_MARGIN_RATE_04,0,0,ROUND(DECODE(A.MM_AMT_04, 0, C.MM_AMT_04, NULL, C.MM_AMT_04, A.MM_AMT_04) * NVL((D.MM_MARGIN_RATE_04 / 100), 1)  / 1000)) )     \n");
                sbSql.append("       ELSE MAX(ROUND(DECODE(A.MM_AMT_04, 0, C.MM_AMT_04, NULL, C.MM_AMT_04, A.MM_AMT_04) / 1000))                                                                                   \n");
                sbSql.append("        END MM_AMT_04                                                                                                                                                                   \n");
                sbSql.append("      ,CASE WHEN SUBSTR(B.ACCT_CD,1,5) = '42203' THEN MAX(DECODE(D.MM_MARGIN_RATE_05,0,0,ROUND(DECODE(A.MM_AMT_05, 0, C.MM_AMT_05, NULL, C.MM_AMT_05, A.MM_AMT_05) * NVL((D.MM_MARGIN_RATE_05 / 100), 1)  / 1000)))      \n");
                sbSql.append("       ELSE MAX(ROUND(DECODE(A.MM_AMT_05, 0, C.MM_AMT_05, NULL, C.MM_AMT_05, A.MM_AMT_05) / 1000))                                                                                   \n");
                sbSql.append("        END MM_AMT_05                                                                                                                                                                   \n");
                sbSql.append("      ,CASE WHEN SUBSTR(B.ACCT_CD,1,5) = '42203' THEN MAX(DECODE(D.MM_MARGIN_RATE_06,0,0,ROUND(DECODE(A.MM_AMT_06, 0, C.MM_AMT_06, NULL, C.MM_AMT_06, A.MM_AMT_06) * NVL((D.MM_MARGIN_RATE_06 / 100), 1)  / 1000)))      \n");
                sbSql.append("       ELSE MAX(ROUND(DECODE(A.MM_AMT_06, 0, C.MM_AMT_06, NULL, C.MM_AMT_06, A.MM_AMT_06) / 1000))                                                                                   \n");
                sbSql.append("        END MM_AMT_06                                                                                                                                                                   \n");
                sbSql.append("      ,CASE WHEN SUBSTR(B.ACCT_CD,1,5) = '42203' THEN MAX(DECODE(D.MM_MARGIN_RATE_07,0,0,ROUND(DECODE(A.MM_AMT_07, 0, C.MM_AMT_07, NULL, C.MM_AMT_07, A.MM_AMT_07) * NVL((D.MM_MARGIN_RATE_07 / 100), 1)  / 1000)))      \n");
                sbSql.append("       ELSE MAX(ROUND(DECODE(A.MM_AMT_07, 0, C.MM_AMT_07, NULL, C.MM_AMT_07, A.MM_AMT_07) / 1000))                                                                                   \n");
                sbSql.append("        END MM_AMT_07                                                                                                                                                                   \n");
                sbSql.append("      ,CASE WHEN SUBSTR(B.ACCT_CD,1,5) = '42203' THEN MAX(DECODE(D.MM_MARGIN_RATE_08,0,0,ROUND(DECODE(A.MM_AMT_08, 0, C.MM_AMT_08, NULL, C.MM_AMT_08, A.MM_AMT_08) * NVL((D.MM_MARGIN_RATE_08 / 100), 1)  / 1000)))      \n");
                sbSql.append("       ELSE MAX(ROUND(DECODE(A.MM_AMT_08, 0, C.MM_AMT_08, NULL, C.MM_AMT_08, A.MM_AMT_08) / 1000))                                                                                   \n");
                sbSql.append("        END MM_AMT_08                                                                                                                                                                   \n");
                sbSql.append("      ,CASE WHEN SUBSTR(B.ACCT_CD,1,5) = '42203' THEN MAX(DECODE(D.MM_MARGIN_RATE_09,0,0,ROUND(DECODE(A.MM_AMT_09, 0, C.MM_AMT_09, NULL, C.MM_AMT_09, A.MM_AMT_09) * NVL((D.MM_MARGIN_RATE_09 / 100), 1)  / 1000)))      \n");
                sbSql.append("       ELSE MAX(ROUND(DECODE(A.MM_AMT_09, 0, C.MM_AMT_09, NULL, C.MM_AMT_09, A.MM_AMT_09) / 1000))                                                                                   \n");
                sbSql.append("        END MM_AMT_09                                                                                                                                                                   \n");
                sbSql.append("      ,CASE WHEN SUBSTR(B.ACCT_CD,1,5) = '42203' THEN MAX(DECODE(D.MM_MARGIN_RATE_10,0,0,ROUND(DECODE(A.MM_AMT_10, 0, C.MM_AMT_10, NULL, C.MM_AMT_10, A.MM_AMT_10) * NVL((D.MM_MARGIN_RATE_10 / 100), 1)  / 1000)))      \n");
                sbSql.append("       ELSE MAX(ROUND(DECODE(A.MM_AMT_10, 0, C.MM_AMT_10, NULL, C.MM_AMT_10, A.MM_AMT_10) / 1000))                                                                                   \n");
                sbSql.append("        END MM_AMT_10                                                                                                                                                                   \n");
                sbSql.append("      ,CASE WHEN SUBSTR(B.ACCT_CD,1,5) = '42203' THEN MAX(DECODE(D.MM_MARGIN_RATE_11,0,0,ROUND(DECODE(A.MM_AMT_11, 0, C.MM_AMT_11, NULL, C.MM_AMT_11, A.MM_AMT_11) * NVL((D.MM_MARGIN_RATE_11 / 100), 1)  / 1000)))      \n");
                sbSql.append("       ELSE MAX(ROUND(DECODE(A.MM_AMT_11, 0, C.MM_AMT_11, NULL, C.MM_AMT_11, A.MM_AMT_11) / 1000))                                                                                   \n");
                sbSql.append("        END MM_AMT_11                                                                                                                                                                   \n");
                sbSql.append("      ,CASE WHEN SUBSTR(B.ACCT_CD,1,5) = '42203' THEN MAX(DECODE(D.MM_MARGIN_RATE_12,0,0,ROUND(DECODE(A.MM_AMT_12, 0, C.MM_AMT_12, NULL, C.MM_AMT_12, A.MM_AMT_12) * NVL((D.MM_MARGIN_RATE_12 / 100), 1)  / 1000)))     \n");
                sbSql.append("       ELSE MAX(ROUND(DECODE(A.MM_AMT_12, 0, C.MM_AMT_12, NULL, C.MM_AMT_12, A.MM_AMT_12) / 1000))                                                                                   \n");
                sbSql.append("        END MM_AMT_12                                                                                                                                                                   \n");
                sbSql.append("      ,SUM(ROUND(( CASE WHEN SUBSTR(B.ACCT_CD,1,5) = '42203' THEN DECODE(D.MM_MARGIN_RATE_01,0,0,NVL(DECODE(A.MM_AMT_01, 0, C.MM_AMT_01, NULL, C.MM_AMT_01, A.MM_AMT_01) * NVL((D.MM_MARGIN_RATE_01 / 100), 1), 0) )       \n");
                sbSql.append("                   ELSE NVL(DECODE(A.MM_AMT_01, 0, C.MM_AMT_01, NULL, C.MM_AMT_01, A.MM_AMT_01), 0)                                                                                     \n");
                sbSql.append("                    END                                                                                                                                                                 \n");
                sbSql.append("                  +CASE WHEN SUBSTR(B.ACCT_CD,1,5) = '42203' THEN DECODE(D.MM_MARGIN_RATE_02,0,0,NVL(DECODE(A.MM_AMT_02, 0, C.MM_AMT_02, NULL, C.MM_AMT_02, A.MM_AMT_02) * NVL((D.MM_MARGIN_RATE_02 / 100), 1), 0))        \n");
                sbSql.append("                   ELSE NVL(DECODE(A.MM_AMT_02, 0, C.MM_AMT_02, NULL, C.MM_AMT_02, A.MM_AMT_02),  0)                                                                                    \n");
                sbSql.append("                    END                                                                                                                                                                 \n");
                sbSql.append("                  +CASE WHEN SUBSTR(B.ACCT_CD,1,5) = '42203' THEN DECODE(D.MM_MARGIN_RATE_03,0,0,NVL(DECODE(A.MM_AMT_03, 0, C.MM_AMT_03, NULL, C.MM_AMT_03, A.MM_AMT_03) * NVL((D.MM_MARGIN_RATE_03 / 100), 1), 0) )       \n");
                sbSql.append("                   ELSE NVL(DECODE(A.MM_AMT_03, 0, C.MM_AMT_03, NULL, C.MM_AMT_03, A.MM_AMT_03),  0)                                                                                    \n");
                sbSql.append("                    END                                                                                                                                                                 \n");
                sbSql.append("                  +CASE WHEN SUBSTR(B.ACCT_CD,1,5) = '42203' THEN DECODE(D.MM_MARGIN_RATE_04,0,0,NVL(DECODE(A.MM_AMT_04, 0, C.MM_AMT_04, NULL, C.MM_AMT_04, A.MM_AMT_04) * NVL((D.MM_MARGIN_RATE_04 / 100), 1), 0))        \n");
                sbSql.append("                   ELSE NVL(DECODE(A.MM_AMT_04, 0, C.MM_AMT_04, NULL, C.MM_AMT_04, A.MM_AMT_04),  0)                                                                                    \n");
                sbSql.append("                    END                                                                                                                                                                 \n");
                sbSql.append("                  +CASE WHEN SUBSTR(B.ACCT_CD,1,5) = '42203' THEN DECODE(D.MM_MARGIN_RATE_05,0,0,NVL(DECODE(A.MM_AMT_05, 0, C.MM_AMT_05, NULL, C.MM_AMT_05, A.MM_AMT_05) * NVL((D.MM_MARGIN_RATE_05 / 100), 1), 0))        \n");
                sbSql.append("                   ELSE NVL(DECODE(A.MM_AMT_05, 0, C.MM_AMT_05, NULL, C.MM_AMT_05, A.MM_AMT_05),  0)                                                                                    \n");
                sbSql.append("                    END                                                                                                                                                                 \n");
                sbSql.append("                  +CASE WHEN SUBSTR(B.ACCT_CD,1,5) = '42203' THEN DECODE(D.MM_MARGIN_RATE_06,0,0,NVL(DECODE(A.MM_AMT_06, 0, C.MM_AMT_06, NULL, C.MM_AMT_06, A.MM_AMT_06) * NVL((D.MM_MARGIN_RATE_06 / 100), 1), 0))        \n");
                sbSql.append("                   ELSE NVL(DECODE(A.MM_AMT_06, 0, C.MM_AMT_06, NULL, C.MM_AMT_06, A.MM_AMT_06),  0)                                                                                    \n");
                sbSql.append("                    END                                                                                                                                                                 \n");
                sbSql.append("                  +CASE WHEN SUBSTR(B.ACCT_CD,1,5) = '42203' THEN DECODE(D.MM_MARGIN_RATE_07,0,0,NVL(DECODE(A.MM_AMT_07, 0, C.MM_AMT_07, NULL, C.MM_AMT_07, A.MM_AMT_07) * NVL((D.MM_MARGIN_RATE_07 / 100), 1), 0))        \n");
                sbSql.append("                   ELSE NVL(DECODE(A.MM_AMT_07, 0, C.MM_AMT_07, NULL, C.MM_AMT_07, A.MM_AMT_07),  0)                                                                                    \n");
                sbSql.append("                    END                                                                                                                                                                 \n");
                sbSql.append("                   +CASE WHEN SUBSTR(B.ACCT_CD,1,5) = '42203' THEN DECODE(D.MM_MARGIN_RATE_08,0,0,NVL(DECODE(A.MM_AMT_08, 0, C.MM_AMT_08, NULL, C.MM_AMT_08, A.MM_AMT_08) * NVL((D.MM_MARGIN_RATE_08 / 100), 1), 0))       \n");
                sbSql.append("                   ELSE NVL(DECODE(A.MM_AMT_08, 0, C.MM_AMT_08, NULL, C.MM_AMT_08, A.MM_AMT_08),  0)                                                                                    \n");
                sbSql.append("                    END                                                                                                                                                                 \n");
                sbSql.append("                  +CASE WHEN SUBSTR(B.ACCT_CD,1,5) = '42203' THEN DECODE(D.MM_MARGIN_RATE_09,0,0,NVL(DECODE(A.MM_AMT_09, 0, C.MM_AMT_09, NULL, C.MM_AMT_09, A.MM_AMT_09) * NVL((D.MM_MARGIN_RATE_09 / 100), 1), 0))        \n");
                sbSql.append("                   ELSE NVL(DECODE(A.MM_AMT_09, 0, C.MM_AMT_09, NULL, C.MM_AMT_09, A.MM_AMT_09),  0)                                                                                    \n");
                sbSql.append("                    END                                                                                                                                                                 \n");
                sbSql.append("                  +CASE WHEN SUBSTR(B.ACCT_CD,1,5) = '42203' THEN DECODE(D.MM_MARGIN_RATE_10,0,0,NVL(DECODE(A.MM_AMT_10, 0, C.MM_AMT_10, NULL, C.MM_AMT_10, A.MM_AMT_10) * NVL((D.MM_MARGIN_RATE_10 / 100), 1), 0))        \n");
                sbSql.append("                   ELSE NVL(DECODE(A.MM_AMT_10, 0, C.MM_AMT_10, NULL, C.MM_AMT_10, A.MM_AMT_10),  0)                                                                                    \n");
                sbSql.append("                    END                                                                                                                                                                 \n");
                sbSql.append("                  +CASE WHEN SUBSTR(B.ACCT_CD,1,5) = '42203' THEN DECODE(D.MM_MARGIN_RATE_11,0,0,NVL(DECODE(A.MM_AMT_11, 0, C.MM_AMT_11, NULL, C.MM_AMT_11, A.MM_AMT_11) * NVL((D.MM_MARGIN_RATE_11 / 100), 1), 0))        \n");
                sbSql.append("                   ELSE NVL(DECODE(A.MM_AMT_11, 0, C.MM_AMT_11, NULL, C.MM_AMT_11, A.MM_AMT_11),  0)                                                                                    \n");
                sbSql.append("                    END                                                                                                                                                                 \n");
                sbSql.append("                  +CASE WHEN SUBSTR(B.ACCT_CD,1,5) = '42203' THEN DECODE(D.MM_MARGIN_RATE_12,0,0,NVL(DECODE(A.MM_AMT_12, 0, C.MM_AMT_12, NULL, C.MM_AMT_12, A.MM_AMT_12) * NVL((D.MM_MARGIN_RATE_12 / 100), 1), 0))        \n");
                sbSql.append("                   ELSE NVL(DECODE(A.MM_AMT_12, 0, C.MM_AMT_12, NULL, C.MM_AMT_12, A.MM_AMT_12),  0)                                                                                    \n");
                sbSql.append("                    END                                                                                                                                                                 \n");
                sbSql.append("                ) / 1000 ))  SUM_AMT                                                                                                                                                 \n");
                // 재무금액
            } else {
                sbSql.append("      ,MAX(ROUND(DECODE(A.MM_AMT_01, 0, C.MM_AMT_01, NULL, C.MM_AMT_01, A.MM_AMT_01) / 1000)) MM_AMT_01	\n");
                sbSql.append("      ,MAX(ROUND(DECODE(A.MM_AMT_02, 0, C.MM_AMT_02, NULL, C.MM_AMT_02, A.MM_AMT_02) / 1000)) MM_AMT_02	\n");
                sbSql.append("      ,MAX(ROUND(DECODE(A.MM_AMT_03, 0, C.MM_AMT_03, NULL, C.MM_AMT_03, A.MM_AMT_03) / 1000)) MM_AMT_03	\n");
                sbSql.append("      ,MAX(ROUND(DECODE(A.MM_AMT_04, 0, C.MM_AMT_04, NULL, C.MM_AMT_04, A.MM_AMT_04) / 1000)) MM_AMT_04	\n");
                sbSql.append("      ,MAX(ROUND(DECODE(A.MM_AMT_05, 0, C.MM_AMT_05, NULL, C.MM_AMT_05, A.MM_AMT_05) / 1000)) MM_AMT_05	\n");
                sbSql.append("      ,MAX(ROUND(DECODE(A.MM_AMT_06, 0, C.MM_AMT_06, NULL, C.MM_AMT_06, A.MM_AMT_06) / 1000)) MM_AMT_06	\n");
                sbSql.append("      ,MAX(ROUND(DECODE(A.MM_AMT_07, 0, C.MM_AMT_07, NULL, C.MM_AMT_07, A.MM_AMT_07) / 1000)) MM_AMT_07	\n");
                sbSql.append("      ,MAX(ROUND(DECODE(A.MM_AMT_08, 0, C.MM_AMT_08, NULL, C.MM_AMT_08, A.MM_AMT_08) / 1000)) MM_AMT_08	\n");
                sbSql.append("      ,MAX(ROUND(DECODE(A.MM_AMT_09, 0, C.MM_AMT_09, NULL, C.MM_AMT_09, A.MM_AMT_09) / 1000)) MM_AMT_09	\n");
                sbSql.append("      ,MAX(ROUND(DECODE(A.MM_AMT_10, 0, C.MM_AMT_10, NULL, C.MM_AMT_10, A.MM_AMT_10) / 1000)) MM_AMT_10	\n");
                sbSql.append("      ,MAX(ROUND(DECODE(A.MM_AMT_11, 0, C.MM_AMT_11, NULL, C.MM_AMT_11, A.MM_AMT_11) / 1000)) MM_AMT_11	\n");
                sbSql.append("      ,MAX(ROUND(DECODE(A.MM_AMT_12, 0, C.MM_AMT_12, NULL, C.MM_AMT_12, A.MM_AMT_12) / 1000)) MM_AMT_12	\n");
                sbSql.append("		,SUM(ROUND(( DECODE(A.MM_AMT_01, 0, C.MM_AMT_01, NULL, C.MM_AMT_01, A.MM_AMT_01)  						\n");
                sbSql.append("				+DECODE(A.MM_AMT_02, 0, C.MM_AMT_02, NULL, C.MM_AMT_02, A.MM_AMT_02)							\n");
                sbSql.append("				+DECODE(A.MM_AMT_03, 0, C.MM_AMT_03, NULL, C.MM_AMT_03, A.MM_AMT_03)							\n");
                sbSql.append("				+DECODE(A.MM_AMT_04, 0, C.MM_AMT_04, NULL, C.MM_AMT_04, A.MM_AMT_04)							\n");
                sbSql.append("				+DECODE(A.MM_AMT_05, 0, C.MM_AMT_05, NULL, C.MM_AMT_05, A.MM_AMT_05)							\n");
                sbSql.append("				+DECODE(A.MM_AMT_06, 0, C.MM_AMT_06, NULL, C.MM_AMT_06, A.MM_AMT_06)							\n");
                sbSql.append("				+DECODE(A.MM_AMT_07, 0, C.MM_AMT_07, NULL, C.MM_AMT_07, A.MM_AMT_07)							\n");
                sbSql.append("				+DECODE(A.MM_AMT_08, 0, C.MM_AMT_08, NULL, C.MM_AMT_08, A.MM_AMT_08)							\n");
                sbSql.append("				+DECODE(A.MM_AMT_09, 0, C.MM_AMT_09, NULL, C.MM_AMT_09, A.MM_AMT_09)							\n");
                sbSql.append("				+DECODE(A.MM_AMT_10, 0, C.MM_AMT_10, NULL, C.MM_AMT_10, A.MM_AMT_10)							\n");
                sbSql.append("				+DECODE(A.MM_AMT_11, 0, C.MM_AMT_11, NULL, C.MM_AMT_11, A.MM_AMT_11)							\n");
                sbSql.append("				+DECODE(A.MM_AMT_12, 0, C.MM_AMT_12, NULL, C.MM_AMT_12, A.MM_AMT_12)							\n");
                sbSql.append("  			) / 1000 ))  SUM_AMT												\n");
            }
            //
            sbSql.append("  		,DECODE(B.ACCT_CLASS, '매출액', '1', '재료비', '2', '인건비', '3', '경비', '4') SKEY					\n");
            sbSql.append("  FROM (  																			\n");
            // 조회년도의 데이터가 없으면 조회년도 -1년의 데이터 조회.
            if ("0".equals(isData2)) {
                sbSql.append("  		SELECT ACCT_CD, FISCAL_YEAR													\n");
                sbSql.append("  		      ,MM_AMT_01, MM_AMT_02, MM_AMT_03, MM_AMT_04, MM_AMT_05, MM_AMT_06		\n");
                sbSql.append("  			  ,MM_AMT_07, MM_AMT_08, MM_AMT_09, MM_AMT_10, MM_AMT_11, MM_AMT_12		\n");
                sbSql.append("  			  ,'0' AS SUM_AMT														\n");
                sbSql.append("  		  FROM MAP_UPJANG_PL														\n");
                //sbSql.append("  		 WHERE CC_CD = (SELECT CC_CD FROM ST_UPJANG WHERE UPJANG = '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "')	\n");
                sbSql.append(" 			WHERE CC_CD = '" + nullToBlank(ds_Cond.getString(0, "CC_CD")) + "' 			\n");
                sbSql.append("  		   AND FISCAL_YEAR = '" + g_Yy + "'											\n");
                sbSql.append("  		   AND PL_CLASS = '" + "KS" + "'												\n");
                // 조회년도의 데이터가 있으면 조회년도 데이터 조회.
            } else {
                sbSql.append("  		SELECT ACCT_CD, FISCAL_YEAR													\n");
                sbSql.append("  		      ,MM_AMT_01, MM_AMT_02, MM_AMT_03, MM_AMT_04, MM_AMT_05, MM_AMT_06		\n");
                sbSql.append("  			  ,MM_AMT_07, MM_AMT_08, MM_AMT_09, MM_AMT_10, MM_AMT_11, MM_AMT_12		\n");
                sbSql.append("  			  ,'0' AS SUM_AMT														\n");
                sbSql.append("  		  FROM MAP_UPJANG_PL														\n");
                //sbSql.append("  		 WHERE CC_CD = (SELECT CC_CD FROM ST_UPJANG WHERE UPJANG = '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "')	\n");
                sbSql.append(" 			WHERE CC_CD = '" + nullToBlank(ds_Cond.getString(0, "CC_CD")) + "' 			\n");
                sbSql.append("  		   AND FISCAL_YEAR = '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'\n");
                sbSql.append("  		   AND PL_CLASS = '" + "KS" + "'												\n");
            }
            sbSql.append("  	) A																				\n");
            //sbSql.append("	   ,MAP_ACCT_CD_INFO B  															\n");
            ///*
       		sbSql.append("      ,(    SELECT ACCT_CD   \n");
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
        	sbSql.append("           ORDER BY SEQ    \n");
        	sbSql.append("	    ) B		  																		\n");
            //*/
            sbSql.append("     ,(																				\n");
            // 조회년도의 데이터가 없으면 조회년도 -1년의 데이터 조회.
            if ("0".equals(isData2)) {
                sbSql.append(" 		 SELECT ACCT_CLASS, ACCT_NM, ACCT_CD, YY, UPJANG								\n");
                sbSql.append(" 		   	   ,MM_AMT_01, MM_AMT_02, MM_AMT_03, MM_AMT_04, MM_AMT_05, MM_AMT_06 		\n");
                sbSql.append(" 			   ,MM_AMT_07, MM_AMT_08, MM_AMT_09, MM_AMT_10, MM_AMT_11, MM_AMT_12 		\n");
                sbSql.append(" 		  FROM MAP_MON_PLAN 															\n");
                sbSql.append(" 		 WHERE UPJANG ='" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'	  		\n");
                sbSql.append(" 		   AND YY = '" + g_Yy + "'		  												\n");
                // 조회년도의 데이터가 있으면 조회년도 데이터 조회.
            } else {
                sbSql.append(" 		 SELECT ACCT_CLASS, ACCT_NM, ACCT_CD, YY, UPJANG								\n");
                sbSql.append(" 		   	   ,MM_AMT_01, MM_AMT_02, MM_AMT_03, MM_AMT_04, MM_AMT_05, MM_AMT_06 		\n");
                sbSql.append(" 			   ,MM_AMT_07, MM_AMT_08, MM_AMT_09, MM_AMT_10, MM_AMT_11, MM_AMT_12 		\n");
                sbSql.append(" 		  FROM MAP_MON_PLAN 															\n");
                sbSql.append(" 		 WHERE UPJANG ='" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'	  		\n");
                sbSql.append(" 		   AND YY = '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'				\n");
            }
            sbSql.append(" 		) C 																			\n");
            sbSql.append("     ,(																				\n");
            sbSql.append(" 		 SELECT *								  										\n");
            sbSql.append(" 		  FROM MAP_MARGIN_RATE_MGMT														\n");
            sbSql.append(" 		 WHERE UPJANG ='" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'	  		\n");
            sbSql.append(" 		   AND YY = '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'				\n");
            sbSql.append(" 		   AND CLASS = '" + "P" + "'													\n");
            sbSql.append(" 		) D 																			\n");
            sbSql.append(" WHERE B.ACCT_CD = A.ACCT_CD(+) 														\n");
            sbSql.append("   AND A.ACCT_CD = C.ACCT_CD(+)														\n");
            sbSql.append("   AND C.UPJANG = D.UPJANG(+)															\n");
            sbSql.append(" GROUP BY B.SEQ, B.ACCT_CLASS, B.ACCT_NM, B.ACCT_CD, A.FISCAL_YEAR								\n");
            sbSql.append(" ORDER BY B.SEQ																	\n");

        } else {
            // 등록된 값이 있으면 사업계획, 최종PL, 수정계획 구분으로 조회.
            // 최종 PL 전송 후 BPC에서 작성된 데이터가 들어오면 그 데이터를 보여준다.
            sbSql.delete(0, sbSql.length());
            sbSql.append("          SELECT B.ACCT_CLASS, B.ACCT_NM, B.ACCT_CD, A.BIZ_CLASS, A.YY, C.CONFIRM_YN, C.IMPROV_YN, C.ORGIN_YN, C.BPC_SEND_YN	\n");
            // 재무금액(저장된 값이 관리금액임으로 재무금액으로 변환한다.)
            if ("U".equals(ds_Cond.getString(0, "CLOSE_TYPE"))) {
                sbSql.append("      ,CASE WHEN SUBSTR(B.ACCT_CD,1,5) = '42203' THEN DECODE(D.MM_MARGIN_RATE_01,0,0,NVL(ROUND(A.MM_AMT_01 / NVL((D.MM_MARGIN_RATE_01 / 100), 1)  / 1000), 0))	  \n");
                sbSql.append("       ELSE NVL(ROUND(A.MM_AMT_01 / 1000), 0)                                                                                   \n");
                sbSql.append("        END MM_AMT_01                                                                                                                                                                   \n");
                sbSql.append("      ,CASE WHEN SUBSTR(B.ACCT_CD,1,5) = '42203' THEN DECODE(D.MM_MARGIN_RATE_02,0,0,NVL(ROUND(A.MM_AMT_02 / NVL((D.MM_MARGIN_RATE_02 / 100), 1)  / 1000), 0))     \n");
                sbSql.append("       ELSE NVL(ROUND(A.MM_AMT_02 / 1000), 0)                                                                                   \n");
                sbSql.append("        END MM_AMT_02                                                                                                                                                                   \n");
                sbSql.append("      ,CASE WHEN SUBSTR(B.ACCT_CD,1,5) = '42203' THEN DECODE(D.MM_MARGIN_RATE_03,0,0,NVL(ROUND(A.MM_AMT_03 / NVL((D.MM_MARGIN_RATE_03 / 100), 1)  / 1000), 0))     \n");
                sbSql.append("       ELSE NVL(ROUND(A.MM_AMT_03 / 1000), 0)                                                                                   \n");
                sbSql.append("        END MM_AMT_03                                                                                                                                                                   \n");
                sbSql.append("      ,CASE WHEN SUBSTR(B.ACCT_CD,1,5) = '42203' THEN DECODE(D.MM_MARGIN_RATE_04,0,0,NVL(ROUND(A.MM_AMT_04 / NVL((D.MM_MARGIN_RATE_04 / 100), 1)  / 1000), 0))     \n");
                sbSql.append("       ELSE NVL(ROUND(A.MM_AMT_04 / 1000), 0)                                                                                   \n");
                sbSql.append("        END MM_AMT_04                                                                                                                                                                   \n");
                sbSql.append("      ,CASE WHEN SUBSTR(B.ACCT_CD,1,5) = '42203' THEN DECODE(D.MM_MARGIN_RATE_05,0,0,NVL(ROUND(A.MM_AMT_05 / NVL((D.MM_MARGIN_RATE_05 / 100), 1)  / 1000), 0))     \n");
                sbSql.append("       ELSE NVL(ROUND(A.MM_AMT_05 / 1000), 0)                                                                                   \n");
                sbSql.append("        END MM_AMT_05                                                                                                                                                                   \n");
                sbSql.append("      ,CASE WHEN SUBSTR(B.ACCT_CD,1,5) = '42203' THEN DECODE(D.MM_MARGIN_RATE_06,0,0,NVL(ROUND(A.MM_AMT_06 / NVL((D.MM_MARGIN_RATE_06 / 100), 1)  / 1000), 0))     \n");
                sbSql.append("       ELSE NVL(ROUND(A.MM_AMT_06 / 1000), 0)                                                                                   \n");
                sbSql.append("        END MM_AMT_06                                                                                                                                                                   \n");
                sbSql.append("      ,CASE WHEN SUBSTR(B.ACCT_CD,1,5) = '42203' THEN DECODE(D.MM_MARGIN_RATE_07,0,0,NVL(ROUND(A.MM_AMT_07 / NVL((D.MM_MARGIN_RATE_07 / 100), 1)  / 1000), 0))     \n");
                sbSql.append("       ELSE NVL(ROUND(A.MM_AMT_07 / 1000), 0)                                                                                   \n");
                sbSql.append("        END MM_AMT_07                                                                                                                                                                   \n");
                sbSql.append("      ,CASE WHEN SUBSTR(B.ACCT_CD,1,5) = '42203' THEN DECODE(D.MM_MARGIN_RATE_08,0,0,NVL(ROUND(A.MM_AMT_08 / NVL((D.MM_MARGIN_RATE_08 / 100), 1)  / 1000), 0))     \n");
                sbSql.append("       ELSE NVL(ROUND(A.MM_AMT_08 / 1000), 0)                                                                                   \n");
                sbSql.append("        END MM_AMT_08                                                                                                                                                                   \n");
                sbSql.append("      ,CASE WHEN SUBSTR(B.ACCT_CD,1,5) = '42203' THEN DECODE(D.MM_MARGIN_RATE_09,0,0,NVL(ROUND(A.MM_AMT_09 / NVL((D.MM_MARGIN_RATE_09 / 100), 1)  / 1000), 0))     \n");
                sbSql.append("       ELSE NVL(ROUND(A.MM_AMT_09 / 1000), 0)                                                                                   \n");
                sbSql.append("        END MM_AMT_09                                                                                                                                                                   \n");
                sbSql.append("      ,CASE WHEN SUBSTR(B.ACCT_CD,1,5) = '42203' THEN DECODE(D.MM_MARGIN_RATE_10,0,0,NVL(ROUND(A.MM_AMT_10 / NVL((D.MM_MARGIN_RATE_10 / 100), 1)  / 1000), 0))     \n");
                sbSql.append("       ELSE NVL(ROUND(A.MM_AMT_10 / 1000), 0)                                                                                   \n");
                sbSql.append("        END MM_AMT_10                                                                                                                                                                   \n");
                sbSql.append("      ,CASE WHEN SUBSTR(B.ACCT_CD,1,5) = '42203' THEN DECODE(D.MM_MARGIN_RATE_11,0,0,NVL(ROUND(A.MM_AMT_11 / NVL((D.MM_MARGIN_RATE_11 / 100), 1)  / 1000), 0))     \n");
                sbSql.append("       ELSE NVL(ROUND(A.MM_AMT_11 / 1000), 0)                                                                                   \n");
                sbSql.append("        END MM_AMT_11                                                                                                                                                                   \n");
                sbSql.append("      ,CASE WHEN SUBSTR(B.ACCT_CD,1,5) = '42203' THEN DECODE(D.MM_MARGIN_RATE_12,0,0,NVL(ROUND(A.MM_AMT_12 / NVL((D.MM_MARGIN_RATE_12 / 100), 1)  / 1000), 0))     \n");
                sbSql.append("       ELSE NVL(ROUND(A.MM_AMT_12 / 1000), 0)                                                                                   \n");
                sbSql.append("        END MM_AMT_12                                                                                                                                                                   \n");
                sbSql.append("      ,NVL(ROUND(( CASE WHEN SUBSTR(B.ACCT_CD,1,5) = '42203' THEN DECODE(D.MM_MARGIN_RATE_01,0,0,NVL(A.MM_AMT_01 / NVL((D.MM_MARGIN_RATE_01 / 100), 1), 0) )       \n");
                sbSql.append("                   ELSE NVL(A.MM_AMT_01, 0)                                                                                     \n");
                sbSql.append("                    END                                                                                                                                                                 \n");
                sbSql.append("                  +CASE WHEN SUBSTR(B.ACCT_CD,1,5) = '42203' THEN DECODE(D.MM_MARGIN_RATE_02,0,0,NVL(A.MM_AMT_02 / NVL((D.MM_MARGIN_RATE_02 / 100), 1), 0) )       \n");
                sbSql.append("                   ELSE NVL(A.MM_AMT_02,  0)                                                                                    \n");
                sbSql.append("                    END                                                                                                                                                                 \n");
                sbSql.append("                  +CASE WHEN SUBSTR(B.ACCT_CD,1,5) = '42203' THEN DECODE(D.MM_MARGIN_RATE_03,0,0,NVL(A.MM_AMT_03 / NVL((D.MM_MARGIN_RATE_03 / 100), 1), 0) )       \n");
                sbSql.append("                   ELSE NVL(A.MM_AMT_03,  0)                                                                                    \n");
                sbSql.append("                    END                                                                                                                                                                 \n");
                sbSql.append("                  +CASE WHEN SUBSTR(B.ACCT_CD,1,5) = '42203' THEN DECODE(D.MM_MARGIN_RATE_04,0,0,NVL(A.MM_AMT_04 / NVL((D.MM_MARGIN_RATE_04 / 100), 1), 0))        \n");
                sbSql.append("                   ELSE NVL(A.MM_AMT_04,  0)                                                                                    \n");
                sbSql.append("                    END                                                                                                                                                                 \n");
                sbSql.append("                  +CASE WHEN SUBSTR(B.ACCT_CD,1,5) = '42203' THEN DECODE(D.MM_MARGIN_RATE_05,0,0,NVL(A.MM_AMT_05 / NVL((D.MM_MARGIN_RATE_05 / 100), 1), 0))        \n");
                sbSql.append("                   ELSE NVL(A.MM_AMT_05,  0)                                                                                    \n");
                sbSql.append("                    END                                                                                                                                                                 \n");
                sbSql.append("                  +CASE WHEN SUBSTR(B.ACCT_CD,1,5) = '42203' THEN DECODE(D.MM_MARGIN_RATE_06,0,0,NVL(A.MM_AMT_06 / NVL((D.MM_MARGIN_RATE_06 / 100), 1), 0))        \n");
                sbSql.append("                   ELSE NVL(A.MM_AMT_06,  0)                                                                                    \n");
                sbSql.append("                    END                                                                                                                                                                 \n");
                sbSql.append("                  +CASE WHEN SUBSTR(B.ACCT_CD,1,5) = '42203' THEN DECODE(D.MM_MARGIN_RATE_07,0,0,NVL(A.MM_AMT_07 / NVL((D.MM_MARGIN_RATE_07 / 100), 1), 0))        \n");
                sbSql.append("                   ELSE NVL(A.MM_AMT_07,  0)                                                                                    \n");
                sbSql.append("                    END                                                                                                                                                                 \n");
                sbSql.append("                  +CASE WHEN SUBSTR(B.ACCT_CD,1,5) = '42203' THEN DECODE(D.MM_MARGIN_RATE_08,0,0,NVL(A.MM_AMT_08 / NVL((D.MM_MARGIN_RATE_08 / 100), 1), 0))        \n");
                sbSql.append("                   ELSE NVL(A.MM_AMT_08,  0)                                                                                    \n");
                sbSql.append("                    END                                                                                                                                                                 \n");
                sbSql.append("                  +CASE WHEN SUBSTR(B.ACCT_CD,1,5) = '42203' THEN DECODE(D.MM_MARGIN_RATE_09,0,0,NVL(A.MM_AMT_09 / NVL((D.MM_MARGIN_RATE_09 / 100), 1), 0))        \n");
                sbSql.append("                   ELSE NVL(A.MM_AMT_09,  0)                                                                                    \n");
                sbSql.append("                    END                                                                                                                                                                 \n");
                sbSql.append("                  +CASE WHEN SUBSTR(B.ACCT_CD,1,5) = '42203' THEN DECODE(D.MM_MARGIN_RATE_10,0,0,NVL(A.MM_AMT_10 / NVL((D.MM_MARGIN_RATE_10 / 100), 1), 0))        \n");
                sbSql.append("                   ELSE NVL(A.MM_AMT_10,  0)                                                                                    \n");
                sbSql.append("                    END                                                                                                                                                                 \n");
                sbSql.append("                  +CASE WHEN SUBSTR(B.ACCT_CD,1,5) = '42203' THEN DECODE(D.MM_MARGIN_RATE_11,0,0,NVL(A.MM_AMT_11 / NVL((D.MM_MARGIN_RATE_11 / 100), 1), 0))        \n");
                sbSql.append("                   ELSE NVL(A.MM_AMT_11,  0)                                                                                    \n");
                sbSql.append("                    END                                                                                                                                                                 \n");
                sbSql.append("                  +CASE WHEN SUBSTR(B.ACCT_CD,1,5) = '42203' THEN DECODE(D.MM_MARGIN_RATE_12,0,0,NVL(A.MM_AMT_12 / NVL((D.MM_MARGIN_RATE_12 / 100), 1), 0))        \n");
                sbSql.append("                   ELSE NVL(A.MM_AMT_12,  0)                                                                                    \n");
                sbSql.append("                    END                                                                                                                                                                 \n");
                sbSql.append("                ) / 1000 ), 0)  SUM_AMT                                                                                                                                                 \n");
                // 관리금액(저장된 값이 관리 금액임으로 그대로 보여준다.)
            } else {
                sbSql.append("                ,ROUND(A.MM_AMT_01 / 1000) MM_AMT_01															\n");
                sbSql.append("                ,ROUND(A.MM_AMT_02 / 1000) MM_AMT_02															\n");
                sbSql.append("                ,ROUND(A.MM_AMT_03 / 1000) MM_AMT_03															\n");
                sbSql.append("                ,ROUND(A.MM_AMT_04 / 1000) MM_AMT_04															\n");
                sbSql.append("                ,ROUND(A.MM_AMT_05 / 1000) MM_AMT_05															\n");
                sbSql.append("                ,ROUND(A.MM_AMT_06 / 1000) MM_AMT_06															\n");
                sbSql.append("                ,ROUND(A.MM_AMT_07 / 1000) MM_AMT_07															\n");
                sbSql.append("                ,ROUND(A.MM_AMT_08 / 1000) MM_AMT_08															\n");
                sbSql.append("                ,ROUND(A.MM_AMT_09 / 1000) MM_AMT_09															\n");
                sbSql.append("                ,ROUND(A.MM_AMT_10 / 1000) MM_AMT_10															\n");
                sbSql.append("                ,ROUND(A.MM_AMT_11 / 1000) MM_AMT_11															\n");
                sbSql.append("                ,ROUND(A.MM_AMT_12 / 1000) MM_AMT_12															\n");
                sbSql.append("                ,ROUND(( A.MM_AMT_01 + A.MM_AMT_02 + A.MM_AMT_03 + A.MM_AMT_04 + A.MM_AMT_05 + A.MM_AMT_06	\n");
                sbSql.append("                       + A.MM_AMT_07 + A.MM_AMT_08 + A.MM_AMT_09 + A.MM_AMT_10 + A.MM_AMT_11 + A.MM_AMT_12	\n");
                sbSql.append("                       ) / 1000 )  SUM_AMT																	\n");
            }
            sbSql.append("                ,A.VER_CD, CC_CD, JOB_GRADE_CD, JOB_GRADE_NM													\n");
            // 최종PL를 BPC에 전송하기 위해 재무금액을 조회한다.
            sbSql.append("      ,CASE WHEN SUBSTR(B.ACCT_CD,1,5) = '42203' THEN DECODE(D.MM_MARGIN_RATE_01,0,0,NVL(ROUND(A.MM_AMT_01 / NVL((D.MM_MARGIN_RATE_01 / 100), 1)  / 1000), 0))	  \n");
            sbSql.append("       ELSE NVL(ROUND(A.MM_AMT_01 / 1000), 0)                                                                                   \n");
            sbSql.append("        END U_MM_AMT_01                                                                                                                                                                   \n");
            sbSql.append("      ,CASE WHEN SUBSTR(B.ACCT_CD,1,5) = '42203' THEN DECODE(D.MM_MARGIN_RATE_02,0,0,NVL(ROUND(A.MM_AMT_02 / NVL((D.MM_MARGIN_RATE_02 / 100), 1)  / 1000), 0))     \n");
            sbSql.append("       ELSE NVL(ROUND(A.MM_AMT_02 / 1000), 0)                                                                                   \n");
            sbSql.append("        END U_MM_AMT_02                                                                                                                                                                   \n");
            sbSql.append("      ,CASE WHEN SUBSTR(B.ACCT_CD,1,5) = '42203' THEN DECODE(D.MM_MARGIN_RATE_03,0,0,NVL(ROUND(A.MM_AMT_03 / NVL((D.MM_MARGIN_RATE_03 / 100), 1)  / 1000), 0))     \n");
            sbSql.append("       ELSE NVL(ROUND(A.MM_AMT_03 / 1000), 0)                                                                                   \n");
            sbSql.append("        END U_MM_AMT_03                                                                                                                                                                   \n");
            sbSql.append("      ,CASE WHEN SUBSTR(B.ACCT_CD,1,5) = '42203' THEN DECODE(D.MM_MARGIN_RATE_04,0,0,NVL(ROUND(A.MM_AMT_04 / NVL((D.MM_MARGIN_RATE_04 / 100), 1)  / 1000), 0))     \n");
            sbSql.append("       ELSE NVL(ROUND(A.MM_AMT_04 / 1000), 0)                                                                                   \n");
            sbSql.append("        END U_MM_AMT_04                                                                                                                                                                   \n");
            sbSql.append("      ,CASE WHEN SUBSTR(B.ACCT_CD,1,5) = '42203' THEN DECODE(D.MM_MARGIN_RATE_05,0,0,NVL(ROUND(A.MM_AMT_05 / NVL((D.MM_MARGIN_RATE_05 / 100), 1)  / 1000), 0))     \n");
            sbSql.append("       ELSE NVL(ROUND(A.MM_AMT_05 / 1000), 0)                                                                                   \n");
            sbSql.append("        END U_MM_AMT_05                                                                                                                                                                   \n");
            sbSql.append("      ,CASE WHEN SUBSTR(B.ACCT_CD,1,5) = '42203' THEN DECODE(D.MM_MARGIN_RATE_06,0,0,NVL(ROUND(A.MM_AMT_06 / NVL((D.MM_MARGIN_RATE_06 / 100), 1)  / 1000), 0) )    \n");
            sbSql.append("       ELSE NVL(ROUND(A.MM_AMT_06 / 1000), 0)                                                                                   \n");
            sbSql.append("        END U_MM_AMT_06                                                                                                                                                                   \n");
            sbSql.append("      ,CASE WHEN SUBSTR(B.ACCT_CD,1,5) = '42203' THEN DECODE(D.MM_MARGIN_RATE_07,0,0,NVL(ROUND(A.MM_AMT_07 / NVL((D.MM_MARGIN_RATE_07 / 100), 1)  / 1000), 0))     \n");
            sbSql.append("       ELSE NVL(ROUND(A.MM_AMT_07 / 1000), 0)                                                                                   \n");
            sbSql.append("        END U_MM_AMT_07                                                                                                                                                                   \n");
            sbSql.append("      ,CASE WHEN SUBSTR(B.ACCT_CD,1,5) = '42203' THEN DECODE(D.MM_MARGIN_RATE_08,0,0,NVL(ROUND(A.MM_AMT_08 / NVL((D.MM_MARGIN_RATE_08 / 100), 1)  / 1000), 0) )    \n");
            sbSql.append("       ELSE NVL(ROUND(A.MM_AMT_08 / 1000), 0)                                                                                   \n");
            sbSql.append("        END U_MM_AMT_08                                                                                                                                                                   \n");
            sbSql.append("      ,CASE WHEN SUBSTR(B.ACCT_CD,1,5) = '42203' THEN DECODE(D.MM_MARGIN_RATE_09,0,0,NVL(ROUND(A.MM_AMT_09 / NVL((D.MM_MARGIN_RATE_09 / 100), 1)  / 1000), 0))     \n");
            sbSql.append("       ELSE NVL(ROUND(A.MM_AMT_09 / 1000), 0)                                                                                   \n");
            sbSql.append("        END U_MM_AMT_09                                                                                                                                                                   \n");
            sbSql.append("      ,CASE WHEN SUBSTR(B.ACCT_CD,1,5) = '42203' THEN DECODE(D.MM_MARGIN_RATE_10,0,0,NVL(ROUND(A.MM_AMT_10 / NVL((D.MM_MARGIN_RATE_10 / 100), 1)  / 1000), 0))     \n");
            sbSql.append("       ELSE NVL(ROUND(A.MM_AMT_10 / 1000), 0)                                                                                   \n");
            sbSql.append("        END U_MM_AMT_10                                                                                                                                                                   \n");
            sbSql.append("      ,CASE WHEN SUBSTR(B.ACCT_CD,1,5) = '42203' THEN DECODE(D.MM_MARGIN_RATE_11,0,0,NVL(ROUND(A.MM_AMT_11 / NVL((D.MM_MARGIN_RATE_11 / 100), 1)  / 1000), 0))     \n");
            sbSql.append("       ELSE NVL(ROUND(A.MM_AMT_11 / 1000), 0)                                                                                   \n");
            sbSql.append("        END U_MM_AMT_11                                                                                                                                                                   \n");
            sbSql.append("      ,CASE WHEN SUBSTR(B.ACCT_CD,1,5) = '42203' THEN DECODE(D.MM_MARGIN_RATE_12,0,0,NVL(ROUND(A.MM_AMT_12 / NVL((D.MM_MARGIN_RATE_12 / 100), 1)  / 1000), 0))     \n");
            sbSql.append("       ELSE NVL(ROUND(A.MM_AMT_12 / 1000), 0)                                                                                   \n");
            sbSql.append("        END U_MM_AMT_12                                                                                                                                                                   \n");
            //
            sbSql.append("  	,DECODE(B.ACCT_CLASS, '매출액', '1', '재료비', '2', '인건비', '3', '경비', '4') SKEY					\n");
            sbSql.append("            FROM (																							\n");

            // BPC에서 최종PL 데이터가 있으면 그 데이터를 보여주고 없으면 FC에서 작성한 최종PL을 보여준다.
            if ("Y".equals(isData5)) {
                sbSql.append("           SELECT ACCT_CLASS, ACCT_NM, ACCT_CD, BIZ_CLASS, YY, UPJANG											\n");
                sbSql.append("                 ,VER_CD, CC_CD, JOB_GRADE_CD, JOB_GRADE_NM													\n");
                sbSql.append("                 ,MM_AMT_01, MM_AMT_02, MM_AMT_03, MM_AMT_04, MM_AMT_05, MM_AMT_06							\n");
                sbSql.append("           	   ,MM_AMT_07, MM_AMT_08, MM_AMT_09, MM_AMT_10, MM_AMT_11, MM_AMT_12							\n");
                sbSql.append("                 ,'0' AS SUM_AMT																				\n");
                sbSql.append("             FROM MAP_BIZ_PLAN																				\n");
                sbSql.append("        	   WHERE UPJANG = '" + ds_Cond.getString(0, "UPJANG") + "'											\n");
                sbSql.append("        		 AND YY =  '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'	  							\n");
                sbSql.append("  		     AND BIZ_CLASS = '" + nullToBlank(ds_Cond.getString(0, "BIZ_CLASS")) + "'						\n");
                sbSql.append("       			) A																							\n");
                // 원본이 아니고 BPC 최종 PL 데이터가 없으면 FC 최종 데이터를 보여준다.
            } else if ("N".equals(isData5) && "0".equals(isData4)) {
                sbSql.append("           SELECT ACCT_CLASS, ACCT_NM, ACCT_CD, BIZ_CLASS, YY, UPJANG											\n");
                sbSql.append("                 ,VER_CD, CC_CD, JOB_GRADE_CD, JOB_GRADE_NM													\n");
                sbSql.append("                 ,MM_AMT_01, MM_AMT_02, MM_AMT_03, MM_AMT_04, MM_AMT_05, MM_AMT_06							\n");
                sbSql.append("           	   ,MM_AMT_07, MM_AMT_08, MM_AMT_09, MM_AMT_10, MM_AMT_11, MM_AMT_12							\n");
                sbSql.append("                 ,'0' AS SUM_AMT																				\n");
                sbSql.append("             FROM MAP_BIZ_PLAN																				\n");
                sbSql.append("        	   WHERE UPJANG = '" + ds_Cond.getString(0, "UPJANG") + "'											\n");
                sbSql.append("        		 AND YY =  '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'	  							\n");
                sbSql.append("  		     AND BIZ_CLASS = '" + nullToBlank(ds_Cond.getString(0, "BIZ_CLASS")) + "'						\n");
                sbSql.append("       			) A																							\n");
            } else {
                sbSql.append("           SELECT A.ACCT_CLASS, A.ACCT_NM, A.BIZ_CLASS, A.YY, A.UPJANG						  \n");
                sbSql.append("                 ,A.VER_CD, A.CC_CD, A.JOB_GRADE_CD, A.JOB_GRADE_NM                             \n");
                sbSql.append("                 ,A.ACCT_CD                             \n");
                // 재무금액
             /*   if ("U".equals(ds_Cond.getString(0, "CLOSE_TYPE"))) {
                    sbSql.append("                 ,CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN DECODE(D.MM_MARGIN_RATE_01,0,0,NVL(ROUND(A.MM_AMT_01 / NVL((D.MM_MARGIN_RATE_01 / 100), 1)), 0)) \n");
                    sbSql.append("                  ELSE NVL(A.MM_AMT_01, 0) \n");
                    sbSql.append("                  END AS MM_AMT_01 \n");
                    sbSql.append("                 ,CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN DECODE(D.MM_MARGIN_RATE_02,0,0,NVL(ROUND(A.MM_AMT_02 / NVL((D.MM_MARGIN_RATE_02 / 100), 1)), 0)) \n");
                    sbSql.append("                  ELSE NVL(A.MM_AMT_02, 0) \n");
                    sbSql.append("                  END AS MM_AMT_02 \n");
                    sbSql.append("                 ,CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN DECODE(D.MM_MARGIN_RATE_03,0,0,NVL(ROUND(A.MM_AMT_03 / NVL((D.MM_MARGIN_RATE_03 / 100), 1)), 0)) \n");
                    sbSql.append("                  ELSE NVL(A.MM_AMT_03, 0) \n");
                    sbSql.append("                  END AS MM_AMT_03 \n");
                    sbSql.append("                 ,CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN DECODE(D.MM_MARGIN_RATE_04,0,0,NVL(ROUND(A.MM_AMT_04 / NVL((D.MM_MARGIN_RATE_04 / 100), 1)), 0)) \n");
                    sbSql.append("                  ELSE NVL(A.MM_AMT_04, 0) \n");
                    sbSql.append("                  END AS MM_AMT_04 \n");
                    sbSql.append("                 ,CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN DECODE(D.MM_MARGIN_RATE_05,0,0,NVL(ROUND(A.MM_AMT_05 / NVL((D.MM_MARGIN_RATE_05 / 100), 1)), 0)) \n");
                    sbSql.append("                  ELSE NVL(A.MM_AMT_05, 0) \n");
                    sbSql.append("                  END AS MM_AMT_05 \n");
                    sbSql.append("                 ,CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN DECODE(D.MM_MARGIN_RATE_06,0,0,NVL(ROUND(A.MM_AMT_06 / NVL((D.MM_MARGIN_RATE_06 / 100), 1)), 0) )\n");
                    sbSql.append("                  ELSE NVL(A.MM_AMT_06, 0) \n");
                    sbSql.append("                  END AS MM_AMT_06 \n");
                    sbSql.append("                 ,CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN DECODE(D.MM_MARGIN_RATE_07,0,0,NVL(ROUND(A.MM_AMT_07 / NVL((D.MM_MARGIN_RATE_07 / 100), 1)), 0)) \n");
                    sbSql.append("                  ELSE NVL(A.MM_AMT_07, 0) \n");
                    sbSql.append("                  END AS MM_AMT_07 \n");
                    sbSql.append("                 ,CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN DECODE(D.MM_MARGIN_RATE_08,0,0,NVL(ROUND(A.MM_AMT_08 / NVL((D.MM_MARGIN_RATE_08 / 100), 1)), 0)) \n");
                    sbSql.append("                  ELSE NVL(A.MM_AMT_08, 0) \n");
                    sbSql.append("                  END AS MM_AMT_08 \n");
                    sbSql.append("                 ,CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN DECODE(D.MM_MARGIN_RATE_09,0,0,NVL(ROUND(A.MM_AMT_09 / NVL((D.MM_MARGIN_RATE_09 / 100), 1)), 0)) \n");
                    sbSql.append("                  ELSE NVL(A.MM_AMT_09, 0) \n");
                    sbSql.append("                  END AS MM_AMT_09 \n");
                    sbSql.append("                 ,CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN DECODE(D.MM_MARGIN_RATE_10,0,0,NVL(ROUND(A.MM_AMT_10 / NVL((D.MM_MARGIN_RATE_10 / 100), 1)), 0)) \n");
                    sbSql.append("                  ELSE NVL(A.MM_AMT_10, 0) \n");
                    sbSql.append("                  END AS MM_AMT_10 \n");
                    sbSql.append("                 ,CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN DECODE(D.MM_MARGIN_RATE_11,0,0,NVL(ROUND(A.MM_AMT_11 / NVL((D.MM_MARGIN_RATE_11 / 100), 1)), 0)) \n");
                    sbSql.append("                  ELSE NVL(A.MM_AMT_11, 0) \n");
                    sbSql.append("                  END AS MM_AMT_11 \n");
                    sbSql.append("                 ,CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN DECODE(D.MM_MARGIN_RATE_12,0,0,NVL(ROUND(A.MM_AMT_12 / NVL((D.MM_MARGIN_RATE_12 / 100), 1)), 0)) \n");
                    sbSql.append("                  ELSE NVL(A.MM_AMT_12, 0) \n");
                    sbSql.append("                  END AS MM_AMT_12 \n");
                    sbSql.append("                 ,'0' AS SUM_AMT \n");
                } else {    */
                    sbSql.append("                 ,NVL(A.MM_AMT_01, 0) AS MM_AMT_01                       \n");
                    sbSql.append("                 ,NVL(A.MM_AMT_02, 0) AS MM_AMT_02                       \n");
                    sbSql.append("                 ,NVL(A.MM_AMT_03, 0) AS MM_AMT_03                       \n");
                    sbSql.append("                 ,NVL(A.MM_AMT_04, 0) AS MM_AMT_04                       \n");
                    sbSql.append("                 ,NVL(A.MM_AMT_05, 0) AS MM_AMT_05                       \n");
                    sbSql.append("                 ,NVL(A.MM_AMT_06, 0) AS MM_AMT_06                       \n");
                    sbSql.append("                 ,NVL(A.MM_AMT_07, 0) AS MM_AMT_07                       \n");
                    sbSql.append("                 ,NVL(A.MM_AMT_08, 0) AS MM_AMT_08                       \n");
                    sbSql.append("                 ,NVL(A.MM_AMT_09, 0) AS MM_AMT_09                       \n");
                    sbSql.append("                 ,NVL(A.MM_AMT_10, 0) AS MM_AMT_10                       \n");
                    sbSql.append("                 ,NVL(A.MM_AMT_11, 0) AS MM_AMT_11                       \n");
                    sbSql.append("                 ,NVL(A.MM_AMT_12, 0) AS MM_AMT_12                       \n");
                //sbSql.append("                 ,NVL2(B.ACCT_CD, B.ACCT_CD, A.ACCT_CD) ACCT_CD                                 \n");
                //sbSql.append("                 ,NVL2(B.MM_AMT_01, B.MM_AMT_01, A.MM_AMT_01) MM_AMT_01                         \n");
                //sbSql.append("                 ,NVL2(B.MM_AMT_02, B.MM_AMT_02, A.MM_AMT_02) MM_AMT_02                         \n");
                //sbSql.append("                 ,NVL2(B.MM_AMT_03, B.MM_AMT_03, A.MM_AMT_03) MM_AMT_03                         \n");
                //sbSql.append("                 ,NVL2(B.MM_AMT_04, B.MM_AMT_04, A.MM_AMT_04) MM_AMT_04                         \n");
                //sbSql.append("                 ,NVL2(B.MM_AMT_05, B.MM_AMT_05, A.MM_AMT_05) MM_AMT_05						  \n");
                //sbSql.append("                 ,NVL2(B.MM_AMT_06, B.MM_AMT_06, A.MM_AMT_06) MM_AMT_06                         \n");
                //sbSql.append("           	     ,NVL2(B.MM_AMT_07, B.MM_AMT_07, A.MM_AMT_07) MM_AMT_07                         \n");
                //sbSql.append("                 ,NVL2(B.MM_AMT_08, B.MM_AMT_08, A.MM_AMT_08) MM_AMT_08                         \n");
                //sbSql.append("                 ,NVL2(B.MM_AMT_09, B.MM_AMT_09, A.MM_AMT_09) MM_AMT_09                         \n");
                //sbSql.append("                 ,NVL2(B.MM_AMT_10, B.MM_AMT_10, A.MM_AMT_10) MM_AMT_10                         \n");
                //sbSql.append("                 ,NVL2(B.MM_AMT_11, B.MM_AMT_11, A.MM_AMT_11) MM_AMT_11						  \n");
                //sbSql.append("                 ,NVL2(B.MM_AMT_12, B.MM_AMT_12, A.MM_AMT_12) MM_AMT_12                         \n");
                    sbSql.append("                 ,'0' AS SUM_AMT                                                                \n");
             //   }  주석해제필요 20160129
                sbSql.append("             FROM MAP_BIZ_PLAN A                                                                \n");
                //sbSql.append("                 ,(                    														  \n");
                //sbSql.append("                    SELECT A.PLAN_YEAR, A.CC_CD, A.ACCT_CD                                                    \n");
                //
                //// 재무금액
                //if ("U".equals(ds_Cond.getString(0, "CLOSE_TYPE"))) {
                //    sbSql.append("                      ,A.MM_AMT_01, A.MM_AMT_02, A.MM_AMT_03, A.MM_AMT_04, A.MM_AMT_05, A.MM_AMT_06     	\n");
                //    sbSql.append("                      ,A.MM_AMT_07, A.MM_AMT_08, A.MM_AMT_09, A.MM_AMT_10, A.MM_AMT_11, A.MM_AMT_12     	\n");
                //    // 재무금액을 관리금액으로 변경.
                //} else {
                //    sbSql.append("                          ,CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN A.MM_AMT_01 * NVL((D.MM_MARGIN_RATE_01 / 100), 1)  	\n");
                //    sbSql.append("                           ELSE A.MM_AMT_01                                                                                   \n");
                //    sbSql.append("                            END MM_AMT_01                                                                                     \n");
                //    sbSql.append("                          ,CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN A.MM_AMT_02 * NVL((D.MM_MARGIN_RATE_02 / 100), 1)  	\n");
                //    sbSql.append("                           ELSE A.MM_AMT_02                                                                                   \n");
                //    sbSql.append("                            END MM_AMT_02                                                                                     \n");
                //    sbSql.append("                          ,CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN A.MM_AMT_03 * NVL((D.MM_MARGIN_RATE_03 / 100), 1)  	\n");
                //    sbSql.append("                           ELSE A.MM_AMT_03                                                                                   \n");
                //    sbSql.append("                            END MM_AMT_03                                                                                     \n");
                //    sbSql.append("                          ,CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN A.MM_AMT_04 * NVL((D.MM_MARGIN_RATE_04 / 100), 1)  	\n");
                //    sbSql.append("                           ELSE A.MM_AMT_04                                                                                   \n");
                //    sbSql.append("                            END MM_AMT_04                                                                                     \n");
                //    sbSql.append("                          ,CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN A.MM_AMT_05 * NVL((D.MM_MARGIN_RATE_05 / 100), 1)  	\n");
                //    sbSql.append("                           ELSE A.MM_AMT_05                                                                                   \n");
                //    sbSql.append("                            END MM_AMT_05                                                                                     \n");
                //    sbSql.append("                          ,CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN A.MM_AMT_06 * NVL((D.MM_MARGIN_RATE_06 / 100), 1)  	\n");
                //    sbSql.append("                           ELSE A.MM_AMT_06                                                                                   \n");
                //    sbSql.append("                            END MM_AMT_06                                                                                     \n");
                //    sbSql.append("                          ,CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN A.MM_AMT_07 * NVL((D.MM_MARGIN_RATE_07 / 100), 1)  	\n");
                //    sbSql.append("                           ELSE A.MM_AMT_07                                                                                   \n");
                //    sbSql.append("                            END MM_AMT_07                                                                                     \n");
                //    sbSql.append("                          ,CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN A.MM_AMT_08 * NVL((D.MM_MARGIN_RATE_08 / 100), 1)  	\n");
                //    sbSql.append("                           ELSE A.MM_AMT_08                                                                                   \n");
                //    sbSql.append("                            END MM_AMT_08                                                                                     \n");
                //    sbSql.append("                          ,CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN A.MM_AMT_09 * NVL((D.MM_MARGIN_RATE_09 / 100), 1)  	\n");
                //    sbSql.append("                           ELSE A.MM_AMT_09                                                                                   \n");
                //    sbSql.append("                            END MM_AMT_09                                                                                     \n");
                //    sbSql.append("                          ,CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN A.MM_AMT_10 * NVL((D.MM_MARGIN_RATE_10 / 100), 1)  	\n");
                //    sbSql.append("                           ELSE A.MM_AMT_10                                                                                   \n");
                //    sbSql.append("                            END MM_AMT_10                                                                                     \n");
                //    sbSql.append("                          ,CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN A.MM_AMT_11 * NVL((D.MM_MARGIN_RATE_11 / 100), 1)  	\n");
                //    sbSql.append("                           ELSE A.MM_AMT_11                                                                                   \n");
                //    sbSql.append("                            END MM_AMT_11                                                                                     \n");
                //    sbSql.append("                          ,CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN A.MM_AMT_12 * NVL((D.MM_MARGIN_RATE_12 / 100), 1)  	\n");
                //    sbSql.append("                           ELSE A.MM_AMT_12                                                                                   \n");
                //    sbSql.append("                            END MM_AMT_12                                                                                     \n");
                //}
                //
                //sbSql.append("                      FROM MAP_BPC_CONFIRM_PL_INFO A                                                          \n");
                //sbSql.append("                          ,MAP_MARGIN_RATE_MGMT D                                                             \n");
                //sbSql.append("                     WHERE A.PLAN_CLASS = 'AP'                                                                \n");
                //sbSql.append("                       AND A.PLAN_YEAR = '" + ds_Cond.getString(0, "INPUT_YY") + "'                           \n");
                //sbSql.append("                       AND A.CC_CD = '" + ds_Cond.getString(0, "CC_CD") + "'                                  \n");
                //sbSql.append("                       AND A.VER_CD = (                                                                       \n");
                //sbSql.append("                                      SELECT ( 'AP3' || MAX(SUBSTR(VER_CD, 4, 7 ))) AS VER_CD                 \n");
                //sbSql.append("                                          FROM MAP_BPC_CONFIRM_PL_INFO                                        \n");
                //sbSql.append("                                         WHERE PLAN_CLASS = 'AP'                                              \n");
                //sbSql.append("                                           AND PLAN_YEAR = '" + ds_Cond.getString(0, "INPUT_YY") + "'         \n");
                //sbSql.append("                                           AND CC_CD = '" + ds_Cond.getString(0, "CC_CD") + "'                \n");
                //sbSql.append("                                    )                                                                         \n");
                //sbSql.append("                       AND A.PLAN_YEAR = D.YY(+)                                                              \n");
                //sbSql.append("                       AND D.UPJANG(+) = '" + ds_Cond.getString(0, "UPJANG") + "'                             \n");
                //sbSql.append("                       AND D.YY(+) = '" + ds_Cond.getString(0, "INPUT_YY") + "'                               \n");
                //sbSql.append("                       AND D.CLASS(+) = '" + "P" + "'                               							\n");
                //sbSql.append("                  ) B                                                                                         \n");
                sbSql.append("        	WHERE 1 = 1                                                               \n");
                //sbSql.append("              AND A.CC_CD = B.CC_CD                                                               \n");
                //sbSql.append("              AND A.YY = B.PLAN_YEAR                                                            \n");
                //sbSql.append("              AND A.ACCT_CD = B.ACCT_CD                                                         \n");
                sbSql.append("              AND A.UPJANG = '" + ds_Cond.getString(0, "UPJANG") + "'							  \n");
                sbSql.append("        	    AND A.YY =  '" + ds_Cond.getString(0, "INPUT_YY") + "'                              \n");
                sbSql.append("  		      AND A.BIZ_CLASS = '" + nullToBlank(ds_Cond.getString(0, "BIZ_CLASS")) + "'      \n");
                sbSql.append("       			) A																			  \n");
            }

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
            sbSql.append("           ORDER BY SEQ    \n");
            sbSql.append("	    ) B		  																								\n");
            sbSql.append("     				,MAP_BIZ_LOG_MGMT C																			\n");
            sbSql.append("     ,(																				\n");
            sbSql.append(" 		 SELECT *								  										\n");
            sbSql.append(" 		  FROM MAP_MARGIN_RATE_MGMT														\n");
            sbSql.append(" 		 WHERE UPJANG ='" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'	  		\n");
            sbSql.append(" 		   AND YY = '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'				\n");
            sbSql.append(" 		   AND CLASS = '" + "P" + "'													\n");
            sbSql.append(" 		) D 																			\n");
            //sbSql.append("       	   WHERE B.ACCT_CD = A.ACCT_CD(+)																	\n");
            sbSql.append("       	   WHERE B.ACCT_CD = A.ACCT_CD																	\n");
            sbSql.append("        	     AND C.UPJANG = '" + ds_Cond.getString(0, "UPJANG") + "'										\n");
            sbSql.append("        		 AND C.YY =  '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'	  						\n");
            sbSql.append("  		     AND C.BIZ_CLASS = '" + nullToBlank(ds_Cond.getString(0, "BIZ_CLASS")) + "'						\n");
            sbSql.append("   			 AND C.UPJANG = D.UPJANG(+)															\n");
            sbSql.append(" 			    ORDER BY B.SEQ																			\n");
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