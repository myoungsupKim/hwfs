
<%
    /*-----------------------------------------------------------------------------
    �� �ý��۸�     : �����ȹ����
    �� ���α׷�ID   : MAP30010E_T001.jsp
    �� ���α׷���   : �����ȹ����
    �� �ۼ�����     : 2015-06-08
    �� �ۼ���       : ������
    �� �̷°���     :
    -----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="../../sc/main/common.jsp"%>
<%
    try {
        PlatformRequest platformRequest = this.proc_input(request);
        in_vl = platformRequest.getData().getVariableList();
        in_dl = platformRequest.getData().getDataSetList();

        //jsp log ���� ����
        logger.startIndividualLog(in_vl.getString("titLogId"));

        //�Է� ����Ÿ
        DataSet ds_Cond = in_dl.get("ds_Cond");
        //�Է� �Ķ����
        String g_Upjang = nullToBlank(in_vl.getString("g_Upjang"));
        String g_EmpNo = nullToBlank(in_vl.getString("g_EmpNo"));
        String g_Yy = nullToBlank(in_vl.getString("g_Yy"));

        //FileLog.println("d:\\aaa.txt", ds_Cond);

        //out ����Ÿ
        DataSet ds_List;

        //sql�� ���ۻ���
        StringBuffer sbSql = new StringBuffer();

        // �����ȹ, ����PL, ������ȹ �Է¿��� ��ȸ.
        sbSql.append("SELECT COUNT(1) ISDATA  														\n");
        sbSql.append("  FROM MAP_BIZ_LOG_MGMT														\n");
        sbSql.append(" WHERE YY = '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "' 			\n");
        sbSql.append("   AND UPJANG = '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "' 		\n");
        sbSql.append("   AND BIZ_CLASS = '" + nullToBlank(ds_Cond.getString(0, "BIZ_CLASS")) + "'	\n");

        pstmt = conn.prepareStatement(sbSql.toString());
        rs = pstmt.executeQuery();

        rs.next();

        String isData = rs.getString("ISDATA");

        // �������� ��ȸ.
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

        // ������ ���� ��ȸ.
        sbSql.delete(0, sbSql.length());
        sbSql.append("SELECT COUNT(1) ISDATA3  														\n");
        sbSql.append("  FROM MAP_MON_PLAN															\n");
        sbSql.append(" WHERE UPJANG = '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "' 		\n");
        sbSql.append("  AND YY = '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "' 			\n");

        pstmt = conn.prepareStatement(sbSql.toString());
        rs = pstmt.executeQuery();

        rs.next();

        String isData3 = rs.getString("ISDATA3");

        // BPC���� ����PL ���� ���� ��ȸ.
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

        // ������ "_����" �������϶��� BPC���� ����PL ������ ��ȸ
        //System.out.println("ORGIN_YN================>"+ds_Cond.getString(0, "ORGIN_YN"));
        String isData5 = ds_Cond.getString(0, "ORGIN_YN");

        //System.out.println("CLOSE_TYPE ==> " + ds_Cond.getString(0, "CLOSE_TYPE"));

        // ���� ����̸� ������ ������(����+����)�� �⺻������ �����ش�.
        if ("0".equals(isData)) {
            sbSql.delete(0, sbSql.length());
            sbSql.append("SELECT B.ACCT_CLASS, B.ACCT_NM, B.ACCT_CD, A.FISCAL_YEAR AS YY, 'N' AS CONFIRM_YN, 'N' AS IMPROV_YN, 'Y' AS ORGIN_YN, 'N' AS BPC_SEND_YN, '' AS JOB_GRADE_CD, '' AS JOB_GRADE_NM	\n");
            // �����ݾ�
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
                // �繫�ݾ�
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
            sbSql.append("  		,DECODE(B.ACCT_CLASS, '�����', '1', '����', '2', '�ΰǺ�', '3', '���', '4') SKEY					\n");
            sbSql.append("  FROM (  																			\n");
            // ��ȸ�⵵�� �����Ͱ� ������ ��ȸ�⵵ -1���� ������ ��ȸ.
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
                // ��ȸ�⵵�� �����Ͱ� ������ ��ȸ�⵵ ������ ��ȸ.
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
            // ��ȸ�⵵�� �����Ͱ� ������ ��ȸ�⵵ -1���� ������ ��ȸ.
            if ("0".equals(isData2)) {
                sbSql.append(" 		 SELECT ACCT_CLASS, ACCT_NM, ACCT_CD, YY, UPJANG								\n");
                sbSql.append(" 		   	   ,MM_AMT_01, MM_AMT_02, MM_AMT_03, MM_AMT_04, MM_AMT_05, MM_AMT_06 		\n");
                sbSql.append(" 			   ,MM_AMT_07, MM_AMT_08, MM_AMT_09, MM_AMT_10, MM_AMT_11, MM_AMT_12 		\n");
                sbSql.append(" 		  FROM MAP_MON_PLAN 															\n");
                sbSql.append(" 		 WHERE UPJANG ='" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'	  		\n");
                sbSql.append(" 		   AND YY = '" + g_Yy + "'		  												\n");
                // ��ȸ�⵵�� �����Ͱ� ������ ��ȸ�⵵ ������ ��ȸ.
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
            // ��ϵ� ���� ������ �����ȹ, ����PL, ������ȹ �������� ��ȸ.
            // ���� PL ���� �� BPC���� �ۼ��� �����Ͱ� ������ �� �����͸� �����ش�.
            sbSql.delete(0, sbSql.length());
            sbSql.append("          SELECT B.ACCT_CLASS, B.ACCT_NM, B.ACCT_CD, A.BIZ_CLASS, A.YY, C.CONFIRM_YN, C.IMPROV_YN, C.ORGIN_YN, C.BPC_SEND_YN	\n");
            // �繫�ݾ�(����� ���� �����ݾ������� �繫�ݾ����� ��ȯ�Ѵ�.)
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
                // �����ݾ�(����� ���� ���� �ݾ������� �״�� �����ش�.)
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
            // ����PL�� BPC�� �����ϱ� ���� �繫�ݾ��� ��ȸ�Ѵ�.
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
            sbSql.append("  	,DECODE(B.ACCT_CLASS, '�����', '1', '����', '2', '�ΰǺ�', '3', '���', '4') SKEY					\n");
            sbSql.append("            FROM (																							\n");

            // BPC���� ����PL �����Ͱ� ������ �� �����͸� �����ְ� ������ FC���� �ۼ��� ����PL�� �����ش�.
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
                // ������ �ƴϰ� BPC ���� PL �����Ͱ� ������ FC ���� �����͸� �����ش�.
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
                // �繫�ݾ�
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
             //   }  �ּ������ʿ� 20160129
                sbSql.append("             FROM MAP_BIZ_PLAN A                                                                \n");
                //sbSql.append("                 ,(                    														  \n");
                //sbSql.append("                    SELECT A.PLAN_YEAR, A.CC_CD, A.ACCT_CD                                                    \n");
                //
                //// �繫�ݾ�
                //if ("U".equals(ds_Cond.getString(0, "CLOSE_TYPE"))) {
                //    sbSql.append("                      ,A.MM_AMT_01, A.MM_AMT_02, A.MM_AMT_03, A.MM_AMT_04, A.MM_AMT_05, A.MM_AMT_06     	\n");
                //    sbSql.append("                      ,A.MM_AMT_07, A.MM_AMT_08, A.MM_AMT_09, A.MM_AMT_10, A.MM_AMT_11, A.MM_AMT_12     	\n");
                //    // �繫�ݾ��� �����ݾ����� ����.
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

        /**����**/
        out_dl.add(ds_List);
        this.setResultMessage(0, "OK", out_vl);

    } catch (Exception ex) {
        //ex.printStackTrace();
        //jsp �α׳����
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
        //jsp log ���� �ݱ�
        try {
            logger.endIndividualLog();
        } catch (Exception logE) {
            logE.printStackTrace();
        }
    }

    proc_output(response, out, out_vl, out_dl);
%>