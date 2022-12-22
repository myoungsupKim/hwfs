
<%
    /*-----------------------------------------------------------------------------
    ■ 시스템명     : 사업계획관리
    ■ 프로그램ID   : MAP30130E_T001.jsp
    ■ 프로그램명   : 월추정 관리
    ■ 작성일자     : 2015-09-10
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
        //System.out.println("UPJANG===>"+nullToBlank(ds_Cond.getString(0, "UPJANG")));
        String chkGbn = nullToBlank(ds_Cond.getString(0, "UPJANG"));
        String s_Type = nullToBlank(ds_Cond.getString(0, "S_TYPE"));

        //FileLog.println("d:\\aaa.txt", ds_Cond);

        //out 데이타
        DataSet ds_List;

        //sql문 버퍼생성
        StringBuffer sbSql = new StringBuffer();

        // 사업장 전체
        if ("".equals(chkGbn))
        {
           	sbSql.append("SELECT A.*                                               \n"); 
           	sbSql.append("  FROM (                                                 \n");
           	if( s_Type.equals("1") )
           	{
               	sbSql.append("SELECT D.ACCTNM1 AS L_ACCTNM                             \n"); 
           	}
           	else if( s_Type.equals("2") )
           	{
               	sbSql.append("SELECT D.ACCTNM1 AS L_ACCTNM                             \n"); 
    			sbSql.append("     , D.ACCTNM2 AS M_ACCTNM                             \n");
           	}
           	else if( s_Type.equals("3") )
           	{
               	sbSql.append("SELECT D.ACCTNM1 AS L_ACCTNM                             \n"); 
    			sbSql.append("     , D.ACCTNM2 AS M_ACCTNM                             \n");
    			sbSql.append("     , D.ACCTNM3 AS S_ACCTNM                             \n");
           	}
           	else if( s_Type.equals("4") )
           	{
               	sbSql.append("SELECT D.ACCTNM1 AS L_ACCTNM                             \n"); 
    			sbSql.append("     , D.ACCTNM2 AS M_ACCTNM                             \n");
    			sbSql.append("     , D.ACCTNM3 AS S_ACCTNM                             \n");
    			sbSql.append("     , A.ACCT_NM                                         \n");
    			sbSql.append("     , A.ACCT_CD                                         \n");
           	}
            sbSql.append("     , SUM(ROUND(A.MM_AMT_01 / 1000)) AS MM_AMT_01       \n");
            sbSql.append("     , SUM(ROUND(A.MM_AMT_02 / 1000)) AS MM_AMT_02       \n");
            sbSql.append("     , SUM(ROUND(A.MM_AMT_03 / 1000)) AS MM_AMT_03       \n");
            sbSql.append("     , SUM(ROUND(A.MM_AMT_04 / 1000)) AS MM_AMT_04       \n");
            sbSql.append("     , SUM(ROUND(A.MM_AMT_05 / 1000)) AS MM_AMT_05       \n");
            sbSql.append("     , SUM(ROUND(A.MM_AMT_06 / 1000)) AS MM_AMT_06       \n");
            sbSql.append("     , SUM(ROUND(A.MM_AMT_07 / 1000)) AS MM_AMT_07       \n");
            sbSql.append("     , SUM(ROUND(A.MM_AMT_08 / 1000)) AS MM_AMT_08       \n");
            sbSql.append("     , SUM(ROUND(A.MM_AMT_09 / 1000)) AS MM_AMT_09       \n");
            sbSql.append("     , SUM(ROUND(A.MM_AMT_10 / 1000)) AS MM_AMT_10       \n");
            sbSql.append("     , SUM(ROUND(A.MM_AMT_11 / 1000)) AS MM_AMT_11       \n");
            sbSql.append("     , SUM(ROUND(A.MM_AMT_12 / 1000)) AS MM_AMT_12       \n");
            sbSql.append("     , SUM(NVL(ROUND(( A.MM_AMT_01                       \n");
            sbSql.append("                      +A.MM_AMT_02                       \n");
            sbSql.append("                      +A.MM_AMT_03                       \n");
            sbSql.append("                      +A.MM_AMT_04                       \n");
            sbSql.append("                      +A.MM_AMT_05                       \n");
            sbSql.append("                      +A.MM_AMT_06                       \n");
            sbSql.append("                      +A.MM_AMT_07                       \n");
            sbSql.append("                      +A.MM_AMT_08                       \n");
            sbSql.append("                      +A.MM_AMT_09                       \n");
            sbSql.append("                      +A.MM_AMT_10                       \n");
            sbSql.append("                      +A.MM_AMT_11                       \n");
            sbSql.append("                      +A.MM_AMT_12                       \n");
            sbSql.append("	  			  ) / 1000 ), 0))  SUM_AMT                 \n");
            sbSql.append("  FROM MAP_MON_PLAN_DTL A                                \n");
            sbSql.append("     , MAP_MON_LOG_MGMT B                                \n");
            sbSql.append("     , (                                                 \n");
            sbSql.append("        SELECT MAX(CKEY)  AS CKEY, UPJANG                \n");
            sbSql.append("          FROM MAP_MON_PLAN_DTL                          \n");
            sbSql.append("         WHERE YY = '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'  \n");
            sbSql.append("	           AND UPJANG IN (SELECT UPJANG	FROM HLDC_SC_DEPT_V A, ST_UPJANG B WHERE A.CC_CD = B.CC_CD AND A.TM_CD = '" + nullToBlank(ds_Cond.getString(0, "TM_CD")) + "' ) \n");
            sbSql.append("	         GROUP BY UPJANG                               \n");
            sbSql.append("	        ) C                                            \n");
            //양식 테이블 조인 추가 
            sbSql.append("     , MAS_ST_ACCOUNT D                                  \n");           
            sbSql.append(" WHERE A.UPJANG = B.UPJANG                               \n");
            sbSql.append("   AND A.YY = B.YY                                       \n");
            sbSql.append("   AND A.UPJANG = C.UPJANG                               \n");
            sbSql.append("   AND A.CKEY = C.CKEY                                   \n");
			sbSql.append("   AND B.BIZ_CLASS = '" + nullToBlank(ds_Cond.getString(0, "BIZ_CLASS2")) + "' \n");
			sbSql.append("   AND A.ACCT_CD = D.ACCTCD                              \n");
			if( s_Type.equals("1") )
			{
				sbSql.append(" GROUP BY D.ACCTNM1 \n");				
			}
			else if( s_Type.equals("2") )
			{
				sbSql.append(" GROUP BY D.ACCTNM1, D.ACCTNM2 \n");
			}
			else if( s_Type.equals("3") )
			{
				sbSql.append(" GROUP BY D.ACCTNM1, D.ACCTNM2, D.ACCTNM3 \n");
			}
			else if( s_Type.equals("4") )
			{
				sbSql.append(" GROUP BY D.ACCTNM1, D.ACCTNM2, D.ACCTNM3, A.ACCT_NM, A.ACCT_CD \n");
			}
           	sbSql.append("       ) A                                               \n");

			if( s_Type.equals("1") )
			{
	           	sbSql.append("     , (                                                 \n");
	           	sbSql.append("        SELECT MIN(SEQ) AS SEQ                           \n");
	           	sbSql.append("             , ACCTNM1 AS L_ACCTNM                       \n");
	           	sbSql.append("          FROM MAS_ST_ACCOUNT                            \n");
	           	sbSql.append("         GROUP BY ACCTNM1                                \n");
	           	sbSql.append("       ) B                                               \n");
	           	sbSql.append(" WHERE A.L_ACCTNM = B.L_ACCTNM                           \n");
	           	sbSql.append(" ORDER BY B.SEQ \n");
			}
			else if( s_Type.equals("2") )
			{
	           	sbSql.append("     , (                                                 \n");
	           	sbSql.append("        SELECT MIN(SEQ) AS SEQ                           \n");
	           	sbSql.append("             , ACCTNM2 AS M_ACCTNM                       \n");
	           	sbSql.append("          FROM MAS_ST_ACCOUNT                            \n");
	           	sbSql.append("         GROUP BY ACCTNM2                                \n");
	           	sbSql.append("       ) B                                               \n");
	           	sbSql.append(" WHERE A.M_ACCTNM = B.M_ACCTNM                           \n");
	           	sbSql.append(" ORDER BY B.SEQ \n");
			}
			else if( s_Type.equals("3") )
			{
	           	sbSql.append("     , (                                                 \n");				
	           	sbSql.append("        SELECT MIN(SEQ) AS SEQ                           \n");
	           	sbSql.append("             , ACCTNM3 AS S_ACCTNM                       \n");
	           	sbSql.append("          FROM MAS_ST_ACCOUNT                            \n");
	           	sbSql.append("         GROUP BY ACCTNM3                                \n");
	           	sbSql.append("       ) B                                               \n");
	           	sbSql.append(" WHERE A.S_ACCTNM = B.S_ACCTNM                           \n");
	           	sbSql.append(" ORDER BY B.SEQ \n");
			}
			else if( s_Type.equals("4") )
			{
	           	sbSql.append("     , (                                                 \n");
	           	sbSql.append("        SELECT SEQ AS SEQ                                \n");
	           	sbSql.append("             , ACCTCD AS ACCT_CD                         \n");
	           	sbSql.append("          FROM MAS_ST_ACCOUNT                            \n");
	           	sbSql.append("       ) B                                               \n");
	           	sbSql.append(" WHERE A.ACCT_CD = B.ACCT_CD                             \n");
				sbSql.append(" ORDER BY B.SEQ                                          \n");
			}
        }
        else
        {
            sbSql.delete(0, sbSql.length());
            sbSql.append("SELECT A.* \n");
            sbSql.append("  FROM ( \n");
            if( s_Type.equals("1") )
            {
                sbSql.append("        SELECT A.L_ACCTNM \n");
            }
            else if( s_Type.equals("2") )
            {
                sbSql.append("        SELECT A.L_ACCTNM \n");
                sbSql.append("             , A.M_ACCTNM \n");
            }
            else if( s_Type.equals("3") )
            {
                sbSql.append("        SELECT A.L_ACCTNM \n");
                sbSql.append("             , A.M_ACCTNM \n");
                sbSql.append("             , A.S_ACCTNM \n");
            }
            else if( s_Type.equals("4") )
            {
                sbSql.append("        SELECT A.L_ACCTNM \n");
                sbSql.append("             , A.M_ACCTNM \n");
                sbSql.append("             , A.S_ACCTNM \n");
                sbSql.append("             , A.ACCT_NM \n");
                sbSql.append("             , A.ACCT_CD \n");
            }
            sbSql.append("             , SUM(A.MM_AMT_01) AS MM_AMT01 \n");
            sbSql.append("             , SUM(A.MM_AMT_02) AS MM_AMT02 \n");
            sbSql.append("             , SUM(A.MM_AMT_03) AS MM_AMT03 \n");
            sbSql.append("             , SUM(A.MM_AMT_04) AS MM_AMT04 \n");
            sbSql.append("             , SUM(A.MM_AMT_05) AS MM_AMT05 \n");
            sbSql.append("             , SUM(A.MM_AMT_06) AS MM_AMT06 \n");
            sbSql.append("             , SUM(A.MM_AMT_07) AS MM_AMT07 \n");
            sbSql.append("             , SUM(A.MM_AMT_08) AS MM_AMT08 \n");
            sbSql.append("             , SUM(A.MM_AMT_09) AS MM_AMT09 \n");
            sbSql.append("             , SUM(A.MM_AMT_10) AS MM_AMT10 \n");
            sbSql.append("             , SUM(A.MM_AMT_11) AS MM_AMT11 \n");
            sbSql.append("             , SUM(A.MM_AMT_12) AS MM_AMT12 \n");
            sbSql.append("             , SUM(A.SUM_AMT) AS SUM_AMT \n");
            sbSql.append("          FROM ( \n");
            sbSql.append("                SELECT E.ACCTNM1 AS L_ACCTNM \n");
            sbSql.append("                     , E.ACCTNM2 AS M_ACCTNM \n");
            sbSql.append("                     , E.ACCTNM3 AS S_ACCTNM \n");
            sbSql.append("                     , A.ACCT_NM \n");
            sbSql.append("                     , A.ACCT_CD \n");

            if ("U".equals(ds_Cond.getString(0, "CLOSE_TYPE")))
            {
                sbSql.append("                     , CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN NVL(ROUND(NVL((CASE WHEN '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'||'01' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_01 ELSE A.MM_AMT_01 / NVL((D.MM_MARGIN_RATE_01 / 100), 1) END), 0) / 1000), 0)      \n");
                sbSql.append("                       ELSE NVL(ROUND(A.MM_AMT_01 / 1000), 0)                                                                                   \n");
                sbSql.append("                       END MM_AMT_01                                                                                                                                                                   \n");
                sbSql.append("                     , CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN NVL(ROUND(NVL((CASE WHEN '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'||'02' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_02 ELSE A.MM_AMT_02 / NVL((D.MM_MARGIN_RATE_02 / 100), 1) END), 0) / 1000), 0)     \n");
                sbSql.append("                       ELSE NVL(ROUND(A.MM_AMT_02 / 1000), 0)                                                                                   \n");
                sbSql.append("                       END MM_AMT_02                                                                                                                                                                   \n");
                sbSql.append("                     , CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN NVL(ROUND(NVL((CASE WHEN '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'||'03' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_03 ELSE A.MM_AMT_03 / NVL((D.MM_MARGIN_RATE_03 / 100), 1) END), 0) / 1000), 0)     \n");
                sbSql.append("                       ELSE NVL(ROUND(A.MM_AMT_03 / 1000), 0)                                                                                   \n");
                sbSql.append("                       END MM_AMT_03                                                                                                                                                                   \n");
                sbSql.append("                     , CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN NVL(ROUND(NVL((CASE WHEN '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'||'04' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_04 ELSE A.MM_AMT_04 / NVL((D.MM_MARGIN_RATE_04 / 100), 1) END), 0) / 1000), 0)     \n");
                sbSql.append("                       ELSE NVL(ROUND(A.MM_AMT_04 / 1000), 0)                                                                                   \n");
                sbSql.append("                       END MM_AMT_04                                                                                                                                                                   \n");
                sbSql.append("                     , CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN NVL(ROUND(NVL((CASE WHEN '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'||'05' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_05 ELSE A.MM_AMT_05 / NVL((D.MM_MARGIN_RATE_05 / 100), 1) END), 0) / 1000), 0)     \n");
                sbSql.append("                       ELSE NVL(ROUND(A.MM_AMT_05 / 1000), 0)                                                                                   \n");
                sbSql.append("                       END MM_AMT_05                                                                                                                                                                   \n");
                sbSql.append("                     , CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN NVL(ROUND(NVL((CASE WHEN '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'||'06' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_06 ELSE A.MM_AMT_06 / NVL((D.MM_MARGIN_RATE_06 / 100), 1) END), 0) / 1000), 0)     \n");
                sbSql.append("                       ELSE NVL(ROUND(A.MM_AMT_06 / 1000), 0)                                                                                   \n");
                sbSql.append("                       END MM_AMT_06                                                                                                                                                                   \n");
                sbSql.append("                     , CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN NVL(ROUND(NVL((CASE WHEN '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'||'07' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_07 ELSE A.MM_AMT_07 / NVL((D.MM_MARGIN_RATE_07 / 100), 1) END), 0) / 1000), 0)     \n");
                sbSql.append("                       ELSE NVL(ROUND(A.MM_AMT_07 / 1000), 0)                                                                                   \n");
                sbSql.append("                       END MM_AMT_07                                                                                                                                                                   \n");
                sbSql.append("                     , CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN NVL(ROUND(NVL((CASE WHEN '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'||'08' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_08 ELSE A.MM_AMT_08 / NVL((D.MM_MARGIN_RATE_08 / 100), 1) END), 0) / 1000), 0)     \n");
                sbSql.append("                       ELSE NVL(ROUND(A.MM_AMT_08 / 1000), 0)                                                                                   \n");
                sbSql.append("                       END MM_AMT_08                                                                                                                                                                   \n");
                sbSql.append("                     , CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN NVL(ROUND(NVL((CASE WHEN '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'||'09' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_09 ELSE A.MM_AMT_09 / NVL((D.MM_MARGIN_RATE_09 / 100), 1) END), 0) / 1000), 0)     \n");
                sbSql.append("                       ELSE NVL(ROUND(A.MM_AMT_09 / 1000), 0)                                                                                   \n");
                sbSql.append("                       END MM_AMT_09                                                                                                                                                                   \n");
                sbSql.append("                     , CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN NVL(ROUND(NVL((CASE WHEN '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'||'10' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_10 ELSE A.MM_AMT_10 / NVL((D.MM_MARGIN_RATE_10 / 100), 1) END), 0) / 1000), 0)     \n");
                sbSql.append("                       ELSE NVL(ROUND(A.MM_AMT_10 / 1000), 0)                                                                                   \n");
                sbSql.append("                       END MM_AMT_10                                                                                                                                                                   \n");
                sbSql.append("                     , CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN NVL(ROUND(NVL((CASE WHEN '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'||'11' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_11 ELSE A.MM_AMT_11 / NVL((D.MM_MARGIN_RATE_11 / 100), 1) END), 0) / 1000), 0)     \n");
                sbSql.append("                       ELSE NVL(ROUND(A.MM_AMT_11 / 1000), 0)                                                                                   \n");
                sbSql.append("                       END MM_AMT_11                                                                                                                                                                   \n");
                sbSql.append("                     , CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN NVL(ROUND(NVL((CASE WHEN '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'||'12' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_12 ELSE A.MM_AMT_12 / NVL((D.MM_MARGIN_RATE_12 / 100), 1) END), 0) / 1000), 0)     \n");
                sbSql.append("                       ELSE NVL(ROUND(A.MM_AMT_12 / 1000), 0)                                                                                   \n");
                sbSql.append("                       END MM_AMT_12                                                                                                                                                                   \n");
                sbSql.append("                     , NVL(ROUND(( CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN NVL((CASE WHEN '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'||'01' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_01 ELSE A.MM_AMT_01 / NVL((D.MM_MARGIN_RATE_01 / 100), 1) END), 1)        \n");
                sbSql.append("                                   ELSE NVL(A.MM_AMT_01, 0)                                                                                     \n");
                sbSql.append("                                   END                                                                                                                                                                 \n");
                sbSql.append("                                  +CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN NVL((CASE WHEN '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'||'02' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_02 ELSE A.MM_AMT_02 / NVL((D.MM_MARGIN_RATE_02 / 100), 1) END), 1)        \n");
                sbSql.append("                                   ELSE NVL(A.MM_AMT_02,  0)                                                                                    \n");
                sbSql.append("                                   END                                                                                                                                                                 \n");
                sbSql.append("                                  +CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN NVL((CASE WHEN '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'||'03' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_03 ELSE A.MM_AMT_03 / NVL((D.MM_MARGIN_RATE_03 / 100), 1) END), 1)        \n");
                sbSql.append("                                   ELSE NVL(A.MM_AMT_03,  0)                                                                                    \n");
                sbSql.append("                                   END                                                                                                                                                                 \n");
                sbSql.append("                                  +CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN NVL((CASE WHEN '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'||'04' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_04 ELSE A.MM_AMT_04 / NVL((D.MM_MARGIN_RATE_04 / 100), 1) END), 1)        \n");
                sbSql.append("                                   ELSE NVL(A.MM_AMT_04,  0)                                                                                    \n");
                sbSql.append("                                   END                                                                                                                                                                 \n");
                sbSql.append("                                  +CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN NVL((CASE WHEN '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'||'05' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_05 ELSE A.MM_AMT_05 / NVL((D.MM_MARGIN_RATE_05 / 100), 1) END), 1)        \n");
                sbSql.append("                                   ELSE NVL(A.MM_AMT_05,  0)                                                                                    \n");
                sbSql.append("                                   END                                                                                                                                                                 \n");
                sbSql.append("                                  +CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN NVL((CASE WHEN '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'||'06' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_06 ELSE A.MM_AMT_06 / NVL((D.MM_MARGIN_RATE_06 / 100), 1) END), 1)        \n");
                sbSql.append("                                   ELSE NVL(A.MM_AMT_06,  0)                                                                                    \n");
                sbSql.append("                                   END                                                                                                                                                                 \n");
                sbSql.append("                                  +CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN NVL((CASE WHEN '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'||'07' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_07 ELSE A.MM_AMT_07 / NVL((D.MM_MARGIN_RATE_07 / 100), 1) END), 1)        \n");
                sbSql.append("                                   ELSE NVL(A.MM_AMT_07,  0)                                                                                    \n");
                sbSql.append("                                   END                                                                                                                                                                 \n");
                sbSql.append("                                  +CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN NVL((CASE WHEN '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'||'08' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_08 ELSE A.MM_AMT_08 / NVL((D.MM_MARGIN_RATE_08 / 100), 1) END), 1)        \n");
                sbSql.append("                                   ELSE NVL(A.MM_AMT_08,  0)                                                                                    \n");
                sbSql.append("                                   END                                                                                                                                                                 \n");
                sbSql.append("                                  +CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN NVL((CASE WHEN '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'||'09' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_09 ELSE A.MM_AMT_09 / NVL((D.MM_MARGIN_RATE_09 / 100), 1) END), 1)        \n");
                sbSql.append("                                   ELSE NVL(A.MM_AMT_09,  0)                                                                                    \n");
                sbSql.append("                                   END                                                                                                                                                                 \n");
                sbSql.append("                                  +CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN NVL((CASE WHEN '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'||'10' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_10 ELSE A.MM_AMT_10 / NVL((D.MM_MARGIN_RATE_10 / 100), 1) END), 1)        \n");
                sbSql.append("                                   ELSE NVL(A.MM_AMT_10,  0)                                                                                    \n");
                sbSql.append("                                   END                                                                                                                                                                 \n");
                sbSql.append("                                  +CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN NVL((CASE WHEN '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'||'11' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_11 ELSE A.MM_AMT_11 / NVL((D.MM_MARGIN_RATE_11 / 100), 1) END), 1)        \n");
                sbSql.append("                                   ELSE NVL(A.MM_AMT_11,  0)                                                                                    \n");
                sbSql.append("                                   END                                                                                                                                                                 \n");
                sbSql.append("                                  +CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN NVL((CASE WHEN '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'||'12' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_12 ELSE A.MM_AMT_12 / NVL((D.MM_MARGIN_RATE_12 / 100), 1) END), 1)        \n");
                sbSql.append("                                   ELSE NVL(A.MM_AMT_12,  0)                                                                                    \n");
                sbSql.append("                                   END                                                                                                                                                                 \n");
                sbSql.append("                                 ) / 1000 ), 0)  SUM_AMT                                                                                                                                                 \n");
            } 
            else
            {
                sbSql.append("                     , ROUND(NVL((CASE WHEN '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'||'01' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_01 * NVL((DECODE(D.MM_MARGIN_RATE_01,NULL,100,0,100,D.MM_MARGIN_RATE_01) / 100), 1) ELSE A.MM_AMT_01 END), 0) / 1000) AS MM_AMT_01 \n");
                sbSql.append("                     , ROUND(NVL((CASE WHEN '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'||'02' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_02 * NVL((DECODE(D.MM_MARGIN_RATE_02,NULL,100,0,100,D.MM_MARGIN_RATE_02) / 100), 1) ELSE A.MM_AMT_02 END), 0) / 1000) AS MM_AMT_02 \n");
                sbSql.append("                     , ROUND(NVL((CASE WHEN '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'||'03' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_03 * NVL((DECODE(D.MM_MARGIN_RATE_03,NULL,100,0,100,D.MM_MARGIN_RATE_03) / 100), 1) ELSE A.MM_AMT_03 END), 0) / 1000) AS MM_AMT_03 \n");
                sbSql.append("                     , ROUND(NVL((CASE WHEN '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'||'04' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_04 * NVL((DECODE(D.MM_MARGIN_RATE_04,NULL,100,0,100,D.MM_MARGIN_RATE_04) / 100), 1) ELSE A.MM_AMT_04 END), 0) / 1000) AS MM_AMT_04 \n");
                sbSql.append("                     , ROUND(NVL((CASE WHEN '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'||'05' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_05 * NVL((DECODE(D.MM_MARGIN_RATE_05,NULL,100,0,100,D.MM_MARGIN_RATE_05) / 100), 1) ELSE A.MM_AMT_05 END), 0) / 1000) AS MM_AMT_05 \n");
                sbSql.append("                     , ROUND(NVL((CASE WHEN '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'||'06' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_06 * NVL((DECODE(D.MM_MARGIN_RATE_06,NULL,100,0,100,D.MM_MARGIN_RATE_06) / 100), 1) ELSE A.MM_AMT_06 END), 0) / 1000) AS MM_AMT_06 \n");
                sbSql.append("                     , ROUND(NVL((CASE WHEN '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'||'07' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_07 * NVL((DECODE(D.MM_MARGIN_RATE_07,NULL,100,0,100,D.MM_MARGIN_RATE_07) / 100), 1) ELSE A.MM_AMT_07 END), 0) / 1000) AS MM_AMT_07 \n");
                sbSql.append("                     , ROUND(NVL((CASE WHEN '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'||'08' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_08 * NVL((DECODE(D.MM_MARGIN_RATE_08,NULL,100,0,100,D.MM_MARGIN_RATE_08) / 100), 1) ELSE A.MM_AMT_08 END), 0) / 1000) AS MM_AMT_08 \n");
                sbSql.append("                     , ROUND(NVL((CASE WHEN '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'||'09' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_09 * NVL((DECODE(D.MM_MARGIN_RATE_09,NULL,100,0,100,D.MM_MARGIN_RATE_09) / 100), 1) ELSE A.MM_AMT_09 END), 0) / 1000) AS MM_AMT_09 \n");
                sbSql.append("                     , ROUND(NVL((CASE WHEN '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'||'10' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_10 * NVL((DECODE(D.MM_MARGIN_RATE_10,NULL,100,0,100,D.MM_MARGIN_RATE_10) / 100), 1) ELSE A.MM_AMT_10 END), 0) / 1000) AS MM_AMT_10 \n");
                sbSql.append("                     , ROUND(NVL((CASE WHEN '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'||'11' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_11 * NVL((DECODE(D.MM_MARGIN_RATE_11,NULL,100,0,100,D.MM_MARGIN_RATE_11) / 100), 1) ELSE A.MM_AMT_11 END), 0) / 1000) AS MM_AMT_11 \n");
                sbSql.append("                     , ROUND(NVL((CASE WHEN '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'||'12' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_12 * NVL((DECODE(D.MM_MARGIN_RATE_12,NULL,100,0,100,D.MM_MARGIN_RATE_12) / 100), 1) ELSE A.MM_AMT_12 END), 0) / 1000) AS MM_AMT_12 \n");
                sbSql.append("                     , NVL(ROUND(( NVL((CASE WHEN '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'||'01' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_01 * NVL((DECODE(D.MM_MARGIN_RATE_01,NULL,100,0,100,D.MM_MARGIN_RATE_01) / 100), 1) ELSE A.MM_AMT_01 END), 0)              \n");
                sbSql.append("                                  +NVL((CASE WHEN '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'||'02' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_02 * NVL((DECODE(D.MM_MARGIN_RATE_02,NULL,100,0,100,D.MM_MARGIN_RATE_02) / 100), 1) ELSE A.MM_AMT_02 END), 0)              \n");
                sbSql.append("                                  +NVL((CASE WHEN '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'||'03' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_03 * NVL((DECODE(D.MM_MARGIN_RATE_03,NULL,100,0,100,D.MM_MARGIN_RATE_03) / 100), 1) ELSE A.MM_AMT_03 END), 0)              \n");
                sbSql.append("                                  +NVL((CASE WHEN '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'||'04' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_04 * NVL((DECODE(D.MM_MARGIN_RATE_04,NULL,100,0,100,D.MM_MARGIN_RATE_04) / 100), 1) ELSE A.MM_AMT_04 END), 0)              \n");
                sbSql.append("                                  +NVL((CASE WHEN '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'||'05' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_05 * NVL((DECODE(D.MM_MARGIN_RATE_05,NULL,100,0,100,D.MM_MARGIN_RATE_05) / 100), 1) ELSE A.MM_AMT_05 END), 0)              \n");
                sbSql.append("                                  +NVL((CASE WHEN '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'||'06' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_06 * NVL((DECODE(D.MM_MARGIN_RATE_06,NULL,100,0,100,D.MM_MARGIN_RATE_06) / 100), 1) ELSE A.MM_AMT_06 END), 0)              \n");
                sbSql.append("                                  +NVL((CASE WHEN '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'||'07' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_07 * NVL((DECODE(D.MM_MARGIN_RATE_07,NULL,100,0,100,D.MM_MARGIN_RATE_07) / 100), 1) ELSE A.MM_AMT_07 END), 0)              \n");
                sbSql.append("                                  +NVL((CASE WHEN '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'||'08' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_08 * NVL((DECODE(D.MM_MARGIN_RATE_08,NULL,100,0,100,D.MM_MARGIN_RATE_08) / 100), 1) ELSE A.MM_AMT_08 END), 0)              \n");
                sbSql.append("                                  +NVL((CASE WHEN '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'||'09' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_09 * NVL((DECODE(D.MM_MARGIN_RATE_09,NULL,100,0,100,D.MM_MARGIN_RATE_09) / 100), 1) ELSE A.MM_AMT_09 END), 0)              \n");
                sbSql.append("                                  +NVL((CASE WHEN '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'||'10' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_10 * NVL((DECODE(D.MM_MARGIN_RATE_10,NULL,100,0,100,D.MM_MARGIN_RATE_10) / 100), 1) ELSE A.MM_AMT_10 END), 0)              \n");
                sbSql.append("                                  +NVL((CASE WHEN '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'||'11' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_11 * NVL((DECODE(D.MM_MARGIN_RATE_11,NULL,100,0,100,D.MM_MARGIN_RATE_11) / 100), 1) ELSE A.MM_AMT_11 END), 0)              \n");
                sbSql.append("                                  +NVL((CASE WHEN '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'||'12' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_12 * NVL((DECODE(D.MM_MARGIN_RATE_12,NULL,100,0,100,D.MM_MARGIN_RATE_12) / 100), 1) ELSE A.MM_AMT_12 END), 0)              \n");
                sbSql.append("                                 ) / 1000 ), 0)  SUM_AMT \n");
                //sbSql.append("      ,ROUND(A.MM_AMT_01 / 1000) AS MM_AMT_01											\n");
                //sbSql.append("      ,ROUND(A.MM_AMT_02 / 1000) AS MM_AMT_02											\n");
                //sbSql.append("      ,ROUND(A.MM_AMT_03 / 1000) AS MM_AMT_03											\n");
                //sbSql.append("      ,ROUND(A.MM_AMT_04 / 1000) AS MM_AMT_04											\n");
                //sbSql.append("      ,ROUND(A.MM_AMT_05 / 1000) AS MM_AMT_05											\n");
                //sbSql.append("      ,ROUND(A.MM_AMT_06 / 1000) AS MM_AMT_06											\n");
                //sbSql.append("      ,ROUND(A.MM_AMT_07 / 1000) AS MM_AMT_07											\n");
                //sbSql.append("      ,ROUND(A.MM_AMT_08 / 1000) AS MM_AMT_08											\n");
                //sbSql.append("      ,ROUND(A.MM_AMT_09 / 1000) AS MM_AMT_09											\n");
                //sbSql.append("      ,ROUND(A.MM_AMT_10 / 1000) AS MM_AMT_10											\n");
                //sbSql.append("      ,ROUND(A.MM_AMT_11 / 1000) AS MM_AMT_11											\n");
                //sbSql.append("      ,ROUND(A.MM_AMT_12 / 1000) AS MM_AMT_12											\n");
                //sbSql.append("		,NVL(ROUND(( A.MM_AMT_01      			  										\n");
                //sbSql.append("					+A.MM_AMT_02  														\n");
                //sbSql.append("					+A.MM_AMT_03  														\n");
                //sbSql.append("					+A.MM_AMT_04  														\n");
                //sbSql.append("					+A.MM_AMT_05  														\n");
                //sbSql.append("					+A.MM_AMT_06  														\n");
                //sbSql.append("					+A.MM_AMT_07  														\n");
                //sbSql.append("					+A.MM_AMT_08  														\n");
                //sbSql.append("					+A.MM_AMT_09  														\n");
                //sbSql.append("					+A.MM_AMT_10  														\n");
                //sbSql.append("					+A.MM_AMT_11  														\n");
                //sbSql.append("					+A.MM_AMT_12  														\n");
                //sbSql.append("  			  ) / 1000 ), 0)  SUM_AMT												\n");
            }

            sbSql.append("                FROM MAP_MON_PLAN_DTL A \n");
            sbSql.append("                   , MAP_MON_LOG_MGMT B \n");
            sbSql.append("                   , ( \n");
            sbSql.append("                      SELECT ACCT_CD, FISCAL_YEAR \n");
            sbSql.append("                           , MM_AMT_01, MM_AMT_02, MM_AMT_03, MM_AMT_04, MM_AMT_05, MM_AMT_06 \n");
            sbSql.append("                           , MM_AMT_07, MM_AMT_08, MM_AMT_09, MM_AMT_10, MM_AMT_11, MM_AMT_12 \n");
            sbSql.append("                           , '0' AS SUM_AMT \n");
            sbSql.append("                        FROM MAP_UPJANG_PL \n");
            sbSql.append("                       WHERE CC_CD = (SELECT CC_CD FROM ST_UPJANG WHERE UPJANG = '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "') \n");
            sbSql.append("                         AND FISCAL_YEAR = '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "' \n");
            sbSql.append("                         AND PL_CLASS = '" + "KS" + "' \n");
            sbSql.append("                     ) C \n");
            sbSql.append("                   , ( \n");
            sbSql.append("                      SELECT * \n");
            sbSql.append("                      FROM MAP_MARGIN_RATE_MGMT \n");
            sbSql.append("                      WHERE UPJANG ='" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "' \n");
            sbSql.append("                      AND YY = '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "' \n");
            sbSql.append("                      AND CLASS = '" + "R" + "' \n");
            sbSql.append("                     ) D \n");
            //양식 테이블 조인 추가 
            sbSql.append("                   , MAS_ST_ACCOUNT E \n");
            sbSql.append("               WHERE A.UPJANG = B.UPJANG \n");
            sbSql.append("                 AND A.YY = B.YY \n");
            //sbSql.append(" 	 AND A.UPJANG IN (SELECT UPJANG	FROM HLDC_SC_DEPT_V A, ST_UPJANG B WHERE A.CC_CD = B.CC_CD AND A.TM_CD = '" + nullToBlank(ds_Cond.getString(0, "TM_CD")) + "' )	\n");
            sbSql.append("                 AND A.UPJANG = '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'				\n");
            sbSql.append("                 AND A.YY = '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'					\n");
            sbSql.append("                 AND A.CKEY = '" + nullToBlank(ds_Cond.getString(0, "BIZ_CLASS")) + "'				\n");
            sbSql.append("                 AND A.BIZ_CLASS = '" + nullToBlank(ds_Cond.getString(0, "BIZ_CLASS2")) + "'		\n");
            sbSql.append("                 AND B.BIZ_CLASS = '" + nullToBlank(ds_Cond.getString(0, "BIZ_CLASS2")) + "'        \n");
            sbSql.append("                 AND A.ACCT_CD = C.ACCT_CD(+)                                                       \n");
            sbSql.append("                 AND A.UPJANG = D.UPJANG(+)                                                         \n");
            sbSql.append("                 AND A.ACCT_CD = E.ACCTCD                                                          \n");
            sbSql.append("               ) A \n");
            if( s_Type.equals("1") )
            	sbSql.append("         GROUP BY A.L_ACCTNM \n");
            else if( s_Type.equals("2") )
            	sbSql.append("         GROUP BY A.L_ACCTNM, A.M_ACCTNM \n");
           	else if( s_Type.equals("3") )
           		sbSql.append("         GROUP BY A.L_ACCTNM, A.M_ACCTNM, A.S_ACCTNM \n");
       		else if( s_Type.equals("4") )
       			sbSql.append("         GROUP BY A.L_ACCTNM, A.M_ACCTNM, A.S_ACCTNM, A.ACCT_NM, A.ACCT_CD \n");
            sbSql.append("       ) A \n");
            
			if( s_Type.equals("1") )
			{
	           	sbSql.append("     , (                                                 \n");
	           	sbSql.append("        SELECT MIN(SEQ) AS SEQ                           \n");
	           	sbSql.append("             , ACCTNM1 AS L_ACCTNM                       \n");
	           	sbSql.append("          FROM MAS_ST_ACCOUNT                            \n");
	           	sbSql.append("         GROUP BY ACCTNM1                                \n");
	           	sbSql.append("       ) B                                               \n");
	           	sbSql.append(" WHERE A.L_ACCTNM = B.L_ACCTNM                           \n");
	           	sbSql.append(" ORDER BY B.SEQ \n");
			}
			else if( s_Type.equals("2") )
			{
	           	sbSql.append("     , (                                                 \n");
	           	sbSql.append("        SELECT MIN(SEQ) AS SEQ                           \n");
	           	sbSql.append("             , ACCTNM2 AS M_ACCTNM                       \n");
	           	sbSql.append("          FROM MAS_ST_ACCOUNT                            \n");
	           	sbSql.append("         GROUP BY ACCTNM2                                \n");
	           	sbSql.append("       ) B                                               \n");
	           	sbSql.append(" WHERE A.M_ACCTNM = B.M_ACCTNM                           \n");
	           	sbSql.append(" ORDER BY B.SEQ \n");
			}
			else if( s_Type.equals("3") )
			{
	           	sbSql.append("     , (                                                 \n");				
	           	sbSql.append("        SELECT MIN(SEQ) AS SEQ                           \n");
	           	sbSql.append("             , ACCTNM3 AS S_ACCTNM                       \n");
	           	sbSql.append("          FROM MAS_ST_ACCOUNT                            \n");
	           	sbSql.append("         GROUP BY ACCTNM3                                \n");
	           	sbSql.append("       ) B                                               \n");
	           	sbSql.append(" WHERE A.S_ACCTNM = B.S_ACCTNM                           \n");
	           	sbSql.append(" ORDER BY B.SEQ \n");
			}
			else if( s_Type.equals("4") )
			{
	           	sbSql.append("     , (                                                 \n");
	           	sbSql.append("        SELECT SEQ AS SEQ                                \n");
	           	sbSql.append("             , ACCTCD AS ACCT_CD                         \n");
	           	sbSql.append("          FROM MAS_ST_ACCOUNT                            \n");
	           	sbSql.append("       ) B                                               \n");
	           	sbSql.append(" WHERE A.ACCT_CD = B.ACCT_CD                             \n");
				sbSql.append(" ORDER BY B.SEQ                                          \n");
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