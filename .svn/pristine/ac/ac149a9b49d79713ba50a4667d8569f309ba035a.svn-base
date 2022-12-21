<%
    /*-----------------------------------------------------------------------------
    ■ 시스템명     : 사업계획관리
    ■ 프로그램ID   : MAP30010P_T001.jsp
    ■ 프로그램명   : 사업계획관리 전년도 실적조회
    ■ 작성일자     : 2015-06-10
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
        String g_Yy = nullToBlank(in_vl.getString("g_Yy"));

        //FileLog.println("d:\\aaa.txt", ds_Cond);

        //out 데이타
        DataSet ds_List;
        //sql문 버퍼생성
        StringBuffer sbSql = new StringBuffer();

        // 계정정보에 해당년도의 입력값
        //sbSql.append("          SELECT CC_CD, CC_NM, ACCT_CD, ACCT_NM, FISCAL_YEAR													\n");
        //sbSql.append("                ,ROUND(MM_AMT_01 / 1000) MM_AMT_01															\n");
        //sbSql.append("                ,ROUND(MM_AMT_02 / 1000) MM_AMT_02															\n");
        //sbSql.append("                ,ROUND(MM_AMT_03 / 1000) MM_AMT_03															\n");
        //sbSql.append("                ,ROUND(MM_AMT_04 / 1000) MM_AMT_04															\n");
        //sbSql.append("                ,ROUND(MM_AMT_05 / 1000) MM_AMT_05															\n");
        //sbSql.append("                ,ROUND(MM_AMT_06 / 1000) MM_AMT_06															\n");
        //sbSql.append("                ,ROUND(MM_AMT_07 / 1000) MM_AMT_07															\n");
        //sbSql.append("                ,ROUND(MM_AMT_08 / 1000) MM_AMT_08															\n");
        //sbSql.append("                ,ROUND(MM_AMT_09 / 1000) MM_AMT_09															\n");
        //sbSql.append("                ,ROUND(MM_AMT_10 / 1000) MM_AMT_10															\n");
        //sbSql.append("                ,ROUND(MM_AMT_11 / 1000) MM_AMT_11															\n");
        //sbSql.append("                ,ROUND(MM_AMT_12 / 1000) MM_AMT_12															\n");
        //sbSql.append("            FROM MAP_UPJANG_PL																				\n");
        //sbSql.append("           WHERE CC_CD = (SELECT CC_CD FROM ST_UPJANG WHERE UPJANG = '" + g_Upjang + "')						\n");
        //sbSql.append("        	   AND FISCAL_YEAR = '" + g_Yy + "'																	\n");
        //sbSql.append("        	 ORDER BY ACCT_CD																					\n");

        sbSql.append("  SELECT A.CC_CD, A.CC_NM, A.ACCT_CD, A.ACCT_NM, A.FISCAL_YEAR   \n");
        sbSql.append("      ,CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN NVL(ROUND(A.MM_AMT_01 * NVL((NVL(D.MM_MARGIN_RATE_01, 100) / 100), 1)  / 1000), 0)      \n");
        sbSql.append("       ELSE NVL(ROUND(A.MM_AMT_01 / 1000), 0)                                                                                      \n");
        sbSql.append("        END MM_AMT_01                                                                                                                        \n");
        sbSql.append("      ,CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN NVL(ROUND(A.MM_AMT_02 * NVL((NVL(D.MM_MARGIN_RATE_02, 100) / 100), 1)  / 1000), 0)        \n");
        sbSql.append("       ELSE NVL(ROUND(A.MM_AMT_02 / 1000), 0)                                                                                      \n");
        sbSql.append("        END MM_AMT_02                                                                                                                       \n");
        sbSql.append("      ,CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN NVL(ROUND(A.MM_AMT_03 * NVL((NVL(D.MM_MARGIN_RATE_03, 100) / 100), 1)  / 1000), 0)        \n");
        sbSql.append("       ELSE NVL(ROUND(A.MM_AMT_03 / 1000), 0)                                                                                      \n");
        sbSql.append("        END MM_AMT_03                                                                                                                     \n");
        sbSql.append("      ,CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN NVL(ROUND(A.MM_AMT_04 * NVL((NVL(D.MM_MARGIN_RATE_04, 100) / 100), 1)  / 1000), 0)        \n");
        sbSql.append("       ELSE NVL(ROUND(A.MM_AMT_04 / 1000), 0)                                                                                      \n");
        sbSql.append("        END MM_AMT_04                                                                                                                   \n");
        sbSql.append("      ,CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN NVL(ROUND(A.MM_AMT_05 * NVL((NVL(D.MM_MARGIN_RATE_05, 100) / 100), 1)  / 1000), 0)        \n");
        sbSql.append("       ELSE NVL(ROUND(A.MM_AMT_05 / 1000), 0)                                                                                      \n");
        sbSql.append("        END MM_AMT_05                                                                                                                   \n");
        sbSql.append("      ,CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN NVL(ROUND(A.MM_AMT_06 * NVL((NVL(D.MM_MARGIN_RATE_06, 100) / 100), 1)  / 1000), 0)        \n");
        sbSql.append("       ELSE NVL(ROUND(A.MM_AMT_06 / 1000), 0)                                                                                      \n");
        sbSql.append("        END MM_AMT_06                                                                                                                 \n");
        sbSql.append("      ,CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN NVL(ROUND(A.MM_AMT_07 * NVL((NVL(D.MM_MARGIN_RATE_07, 100) / 100), 1)  / 1000), 0)       \n");
        sbSql.append("       ELSE NVL(ROUND(A.MM_AMT_07 / 1000), 0)                                                                                      \n");
        sbSql.append("        END MM_AMT_07                                                                                                                 \n");
        sbSql.append("      ,CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN NVL(ROUND(A.MM_AMT_08 * NVL((NVL(D.MM_MARGIN_RATE_08, 100) / 100), 1)  / 1000), 0)       \n");
        sbSql.append("       ELSE NVL(ROUND(A.MM_AMT_08 / 1000), 0)                                                                                      \n");
        sbSql.append("        END MM_AMT_08                                                                                                                \n");
        sbSql.append("      ,CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN NVL(ROUND(A.MM_AMT_09 * NVL((NVL(D.MM_MARGIN_RATE_09, 100) / 100), 1)  / 1000), 0)       \n");
        sbSql.append("       ELSE NVL(ROUND(A.MM_AMT_09 / 1000), 0)                                                                                      \n");
        sbSql.append("        END MM_AMT_09                                                                                                                \n");
        sbSql.append("      ,CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN NVL(ROUND(A.MM_AMT_10 * NVL((NVL(D.MM_MARGIN_RATE_10, 100) / 100), 1)  / 1000), 0)       \n");
        sbSql.append("       ELSE NVL(ROUND(A.MM_AMT_10 / 1000), 0)                                                                                      \n");
        sbSql.append("        END MM_AMT_10                                                                                                                \n");
        sbSql.append("      ,CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN NVL(ROUND(A.MM_AMT_11 * NVL((NVL(D.MM_MARGIN_RATE_11, 100) / 100), 1)  / 1000), 0)       \n");
        sbSql.append("       ELSE NVL(ROUND(A.MM_AMT_11 / 1000), 0)                                                                                      \n");
        sbSql.append("        END MM_AMT_11                                                                                                                 \n");
        sbSql.append("      ,CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN NVL(ROUND(A.MM_AMT_12 * NVL((NVL(D.MM_MARGIN_RATE_12, 100) / 100), 1)  / 1000), 0)        \n");
        sbSql.append("       ELSE NVL(ROUND(A.MM_AMT_12 / 1000), 0)                                                                                      \n");
        sbSql.append("        END MM_AMT_12                                                     \n");
        sbSql.append(" FROM MAP_UPJANG_PL A   \n");
        sbSql.append("       ,(                                                                                \n");
        sbSql.append("         SELECT *                                                                      \n");
        sbSql.append("          FROM MAP_MARGIN_RATE_MGMT                                                        \n");
        sbSql.append("         WHERE UPJANG = '" + g_Upjang + "'                \n");
        sbSql.append("           AND YY = '" + g_Yy + "'                 \n");
        sbSql.append("           AND CLASS = 'R'                                                     \n");
        sbSql.append("        ) D   \n");
        sbSql.append(" WHERE A.CC_CD = (SELECT CC_CD FROM ST_UPJANG WHERE UPJANG = '" + g_Upjang + "')                         \n");
        sbSql.append("   AND A.FISCAL_YEAR = '" + g_Yy + "'    \n");
        sbSql.append(" ORDER BY A.ACCT_CD   \n");

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