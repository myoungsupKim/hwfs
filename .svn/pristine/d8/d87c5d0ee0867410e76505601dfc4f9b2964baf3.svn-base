<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 사업계획관리
■ 프로그램ID   : MAP30020E_T001.jsp
■ 프로그램명   : 월추정 관리
■ 작성일자     : 2015-06-18
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
        String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
        String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
        String g_Yy     	= nullToBlank(in_vl.getString("g_Yy"));

        //FileLog.println("d:\\aaa.txt", ds_Cond);

        //out 데이타
        DataSet ds_List;

        //sql문 버퍼생성
        StringBuffer sbSql = new StringBuffer();
        sbSql.delete(0, sbSql.length());
        sbSql.append("SELECT A.ACCT_CLASS, A.ACCT_NM, A.ACCT_CD, A.YY, B.CONFIRM_YN		 					\n");
        // 재무금액 = 관리금액 / (출하율/100) (저장된 값이 관리금액임으로 재무금액으로 변환한다.)
        //2018.01.17 김명섭 관리/재무 조회 기준 변경
        if("U".equals(ds_Cond.getString(0, "CLOSE_TYPE"))){
            sbSql.append("      ,CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN NVL(ROUND(NVL((CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'01' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_01 ELSE NVL(A.MM_AMT_01 / DECODE(NVL((D.MM_MARGIN_RATE_01 / 100), 1),0,NULL,NVL((D.MM_MARGIN_RATE_01 / 100), 1)),0) END), 0) / 1000), 0)	  \n");
            //sbSql.append("       ELSE NVL(ROUND(A.MM_AMT_01 / 1000), 0)                                                                                   \n");
            sbSql.append("       ELSE (CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'01' < TO_CHAR(SYSDATE, 'YYYYMM') THEN  NVL(ROUND(C.MM_AMT_01 / 1000), 0) ELSE  NVL(ROUND(A.MM_AMT_01 / 1000), 0) END )                                                                                  \n");
            sbSql.append("        END MM_AMT_01                                                                                                                                                                   \n");
            sbSql.append("      ,CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN NVL(ROUND(NVL((CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'02' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_02 ELSE NVL(A.MM_AMT_02 / DECODE(NVL((D.MM_MARGIN_RATE_02 / 100), 1),0,NULL,NVL((D.MM_MARGIN_RATE_02 / 100), 1)),0) END), 0) / 1000), 0)     \n");
            //sbSql.append("       ELSE NVL(ROUND(A.MM_AMT_02 / 1000), 0)                                                                                   \n");
            sbSql.append("       ELSE (CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'02' < TO_CHAR(SYSDATE, 'YYYYMM') THEN  NVL(ROUND(C.MM_AMT_02 / 1000), 0) ELSE  NVL(ROUND(A.MM_AMT_02 / 1000), 0) END )                                                                                  \n");
            sbSql.append("        END MM_AMT_02                                                                                                                                                                   \n");
            sbSql.append("      ,CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN NVL(ROUND(NVL((CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'03' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_03 ELSE NVL(A.MM_AMT_03 / DECODE(NVL((D.MM_MARGIN_RATE_03 / 100), 1),0,NULL,NVL((D.MM_MARGIN_RATE_03 / 100), 1)),0) END), 0) / 1000), 0)     \n");
            //sbSql.append("       ELSE NVL(ROUND(A.MM_AMT_03 / 1000), 0)                                                                                   \n");
            sbSql.append("       ELSE (CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'03' < TO_CHAR(SYSDATE, 'YYYYMM') THEN  NVL(ROUND(C.MM_AMT_03 / 1000), 0) ELSE  NVL(ROUND(A.MM_AMT_03 / 1000), 0) END )                                                                                  \n");            
            sbSql.append("        END MM_AMT_03                                                                                                                                                                   \n");
            sbSql.append("      ,CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN NVL(ROUND(NVL((CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'04' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_04 ELSE NVL(A.MM_AMT_04 / DECODE(NVL((D.MM_MARGIN_RATE_04 / 100), 1),0,NULL,NVL((D.MM_MARGIN_RATE_04 / 100), 1)),0) END), 0) / 1000), 0)     \n");
            //sbSql.append("       ELSE NVL(ROUND(A.MM_AMT_04 / 1000), 0)                                                                                   \n");
            sbSql.append("       ELSE (CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'04' < TO_CHAR(SYSDATE, 'YYYYMM') THEN  NVL(ROUND(C.MM_AMT_04 / 1000), 0) ELSE  NVL(ROUND(A.MM_AMT_04 / 1000), 0) END )                                                                                  \n");
            sbSql.append("        END MM_AMT_04                                                                                                                                                                   \n");
            sbSql.append("      ,CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN NVL(ROUND(NVL((CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'05' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_05 ELSE NVL(A.MM_AMT_05 / DECODE(NVL((D.MM_MARGIN_RATE_05 / 100), 1),0,NULL,NVL((D.MM_MARGIN_RATE_05 / 100), 1)),0) END), 0) / 1000), 0)     \n");
            //sbSql.append("       ELSE NVL(ROUND(A.MM_AMT_05 / 1000), 0)                                                                                   \n");
            sbSql.append("       ELSE (CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'05' < TO_CHAR(SYSDATE, 'YYYYMM') THEN  NVL(ROUND(C.MM_AMT_05 / 1000), 0) ELSE  NVL(ROUND(A.MM_AMT_05 / 1000), 0) END )                                                                                  \n");            
            sbSql.append("        END MM_AMT_05                                                                                                                                                                   \n");
            sbSql.append("      ,CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN NVL(ROUND(NVL((CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'06' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_06 ELSE NVL(A.MM_AMT_06 / DECODE(NVL((D.MM_MARGIN_RATE_06 / 100), 1),0,NULL,NVL((D.MM_MARGIN_RATE_06 / 100), 1)),0) END), 0) / 1000), 0)     \n");
            //sbSql.append("       ELSE NVL(ROUND(A.MM_AMT_06 / 1000), 0)                                                                                   \n");
            sbSql.append("       ELSE (CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'06' < TO_CHAR(SYSDATE, 'YYYYMM') THEN  NVL(ROUND(C.MM_AMT_06 / 1000), 0) ELSE  NVL(ROUND(A.MM_AMT_06 / 1000), 0) END )                                                                                  \n");
            sbSql.append("        END MM_AMT_06                                                                                                                                                                   \n");
            sbSql.append("      ,CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN NVL(ROUND(NVL((CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'07' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_07 ELSE NVL(A.MM_AMT_07 / DECODE(NVL((D.MM_MARGIN_RATE_07 / 100), 1),0,NULL,NVL((D.MM_MARGIN_RATE_07 / 100), 1)),0) END), 0) / 1000), 0)     \n");
            //sbSql.append("       ELSE NVL(ROUND(A.MM_AMT_07 / 1000), 0)                                                                                   \n");
            sbSql.append("       ELSE (CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'07' < TO_CHAR(SYSDATE, 'YYYYMM') THEN  NVL(ROUND(C.MM_AMT_07 / 1000), 0) ELSE  NVL(ROUND(A.MM_AMT_07 / 1000), 0) END )                                                                                  \n");
            sbSql.append("        END MM_AMT_07                                                                                                                                                                   \n");
            sbSql.append("      ,CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN NVL(ROUND(NVL((CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'08' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_08 ELSE NVL(A.MM_AMT_08 / DECODE(NVL((D.MM_MARGIN_RATE_08 / 100), 1),0,NULL,NVL((D.MM_MARGIN_RATE_08 / 100), 1)),0) END), 0) / 1000), 0)     \n");
            //sbSql.append("       ELSE NVL(ROUND(A.MM_AMT_08 / 1000), 0)                                                                                   \n");
            sbSql.append("       ELSE (CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'08' < TO_CHAR(SYSDATE, 'YYYYMM') THEN  NVL(ROUND(C.MM_AMT_08 / 1000), 0) ELSE  NVL(ROUND(A.MM_AMT_08 / 1000), 0) END )                                                                                  \n");
            sbSql.append("        END MM_AMT_08                                                                                                                                                                   \n");
            sbSql.append("      ,CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN NVL(ROUND(NVL((CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'09' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_09 ELSE NVL(A.MM_AMT_09 / DECODE(NVL((D.MM_MARGIN_RATE_09 / 100), 1),0,NULL,NVL((D.MM_MARGIN_RATE_09 / 100), 1)),0) END), 0) / 1000), 0)    \n");
            //sbSql.append("       ELSE NVL(ROUND(A.MM_AMT_09 / 1000), 0)                                                                                   \n");
            sbSql.append("       ELSE (CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'09' < TO_CHAR(SYSDATE, 'YYYYMM') THEN  NVL(ROUND(C.MM_AMT_09 / 1000), 0) ELSE  NVL(ROUND(A.MM_AMT_09 / 1000), 0) END )                                                                                  \n");
            sbSql.append("        END MM_AMT_09                                                                                                                                                                   \n");
            sbSql.append("      ,CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN NVL(ROUND(NVL((CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'10' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_10 ELSE NVL(A.MM_AMT_10 / DECODE(NVL((D.MM_MARGIN_RATE_10 / 100), 1),0,NULL,NVL((D.MM_MARGIN_RATE_10 / 100), 1)),0) END), 0) / 1000), 0)    \n");
            //sbSql.append("       ELSE NVL(ROUND(A.MM_AMT_10 / 1000), 0)                                                                                   \n");
            sbSql.append("       ELSE (CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'10' < TO_CHAR(SYSDATE, 'YYYYMM') THEN  NVL(ROUND(C.MM_AMT_10 / 1000), 0) ELSE  NVL(ROUND(A.MM_AMT_10 / 1000), 0) END )                                                                                  \n");
            sbSql.append("        END MM_AMT_10                                                                                                                                                                   \n");
            sbSql.append("      ,CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN NVL(ROUND(NVL((CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'11' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_11 ELSE NVL(A.MM_AMT_11 / DECODE(NVL((D.MM_MARGIN_RATE_11 / 100), 1),0,NULL,NVL((D.MM_MARGIN_RATE_11 / 100), 1)),0) END), 0) / 1000), 0)     \n");
            //sbSql.append("       ELSE NVL(ROUND(A.MM_AMT_11 / 1000), 0)                                                                                   \n");
            sbSql.append("       ELSE (CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'11' < TO_CHAR(SYSDATE, 'YYYYMM') THEN  NVL(ROUND(C.MM_AMT_11 / 1000), 0) ELSE  NVL(ROUND(A.MM_AMT_11 / 1000), 0) END )                                                                                  \n");
            sbSql.append("        END MM_AMT_11                                                                                                                                                                   \n");
            sbSql.append("      ,CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN NVL(ROUND(NVL((CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'12' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_12 ELSE NVL(A.MM_AMT_12 / DECODE(NVL((D.MM_MARGIN_RATE_12 / 100), 1),0,NULL,NVL((D.MM_MARGIN_RATE_12 / 100), 1)),0) END), 0) / 1000), 0)    \n");
            //sbSql.append("       ELSE NVL(ROUND(A.MM_AMT_12 / 1000), 0)                                                                                   \n");
            sbSql.append("       ELSE (CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'12' < TO_CHAR(SYSDATE, 'YYYYMM') THEN  NVL(ROUND(C.MM_AMT_12 / 1000), 0) ELSE  NVL(ROUND(A.MM_AMT_12 / 1000), 0) END )                                                                                  \n");
            sbSql.append("        END MM_AMT_12                                                                                                                                                                   \n");
            sbSql.append("      ,NVL(ROUND(( CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN NVL((CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'01' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_01 ELSE A.MM_AMT_01 / NVL((D.MM_MARGIN_RATE_01 / 100), 1) END), 1)        \n");
            sbSql.append("                   ELSE NVL(A.MM_AMT_01, 0)                                                                                     \n");
            sbSql.append("                    END                                                                                                                                                                 \n");
            sbSql.append("                  +CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN NVL((CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'02' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_02 ELSE A.MM_AMT_02 / NVL((D.MM_MARGIN_RATE_02 / 100), 1) END), 1)        \n");
            sbSql.append("                   ELSE NVL(A.MM_AMT_02,  0)                                                                                    \n");
            sbSql.append("                    END                                                                                                                                                                 \n");
            sbSql.append("                  +CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN NVL((CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'03' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_03 ELSE A.MM_AMT_03 / NVL((D.MM_MARGIN_RATE_03 / 100), 1) END), 1)        \n");
            sbSql.append("                   ELSE NVL(A.MM_AMT_03,  0)                                                                                    \n");
            sbSql.append("                    END                                                                                                                                                                 \n");
            sbSql.append("                  +CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN NVL((CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'04' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_04 ELSE A.MM_AMT_04 / NVL((D.MM_MARGIN_RATE_04 / 100), 1) END), 1)        \n");
            sbSql.append("                   ELSE NVL(A.MM_AMT_04,  0)                                                                                    \n");
            sbSql.append("                    END                                                                                                                                                                 \n");
            sbSql.append("                  +CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN NVL((CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'05' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_05 ELSE A.MM_AMT_05 / NVL((D.MM_MARGIN_RATE_05 / 100), 1) END), 1)        \n");
            sbSql.append("                   ELSE NVL(A.MM_AMT_05,  0)                                                                                    \n");
            sbSql.append("                    END                                                                                                                                                                 \n");
            sbSql.append("                  +CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN NVL((CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'06' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_06 ELSE A.MM_AMT_06 / NVL((D.MM_MARGIN_RATE_06 / 100), 1) END), 1)        \n");
            sbSql.append("                   ELSE NVL(A.MM_AMT_06,  0)                                                                                    \n");
            sbSql.append("                    END                                                                                                                                                                 \n");
            sbSql.append("                  +CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN NVL((CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'07' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_07 ELSE A.MM_AMT_07 / NVL((D.MM_MARGIN_RATE_07 / 100), 1) END), 1)        \n");
            sbSql.append("                   ELSE NVL(A.MM_AMT_07,  0)                                                                                    \n");
            sbSql.append("                    END                                                                                                                                                                 \n");
            sbSql.append("                  +CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN NVL((CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'08' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_08 ELSE A.MM_AMT_08 / NVL((D.MM_MARGIN_RATE_08 / 100), 1) END), 1)        \n");
            sbSql.append("                   ELSE NVL(A.MM_AMT_08,  0)                                                                                    \n");
            sbSql.append("                    END                                                                                                                                                                 \n");
            sbSql.append("                  +CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN NVL((CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'09' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_09 ELSE A.MM_AMT_09 / NVL((D.MM_MARGIN_RATE_09 / 100), 1) END), 1)        \n");
            sbSql.append("                   ELSE NVL(A.MM_AMT_09,  0)                                                                                    \n");
            sbSql.append("                    END                                                                                                                                                                 \n");
            sbSql.append("                  +CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN NVL((CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'10' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_10 ELSE A.MM_AMT_10 / NVL((D.MM_MARGIN_RATE_10 / 100), 1) END), 1)        \n");
            sbSql.append("                   ELSE NVL(A.MM_AMT_10,  0)                                                                                    \n");
            sbSql.append("                    END                                                                                                                                                                 \n");
            sbSql.append("                  +CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN NVL((CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'11' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_11 ELSE A.MM_AMT_11 / NVL((D.MM_MARGIN_RATE_11 / 100), 1) END), 1)        \n");
            sbSql.append("                   ELSE NVL(A.MM_AMT_11,  0)                                                                                    \n");
            sbSql.append("                    END                                                                                                                                                                 \n");
            sbSql.append("                  +CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN NVL((CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'12' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_12 ELSE A.MM_AMT_12 / NVL((D.MM_MARGIN_RATE_12 / 100), 1) END), 1)        \n");
            sbSql.append("                   ELSE NVL(A.MM_AMT_12,  0)                                                                                    \n");
            sbSql.append("                    END                                                                                                                                                                 \n");
            sbSql.append("                ) / 1000 ), 0)  SUM_AMT                                                                                                                                                 \n");
            sbSql.append("  		     ,DECODE(A.ACCT_CLASS, '매출액', '1', '재료비', '2', '인건비', '3', '경비', '4') SKEY					\n");

        // 저장된 값은 관리금액임으로 그대로 보여준다.
        }else{
           // sbSql.append("      ,ROUND(NVL((CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'01' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_01 * NVL((DECODE(D.MM_MARGIN_RATE_01,NULL,100,0,100,D.MM_MARGIN_RATE_01) / 100), 1) ELSE A.MM_AMT_01 END), 0) / 1000) AS MM_AMT_01 \n");
           // sbSql.append("      ,ROUND(NVL((CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'02' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_02 * NVL((DECODE(D.MM_MARGIN_RATE_02,NULL,100,0,100,D.MM_MARGIN_RATE_02) / 100), 1) ELSE A.MM_AMT_02 END), 0) / 1000) AS MM_AMT_02 \n");
           // sbSql.append("      ,ROUND(NVL((CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'03' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_03 * NVL((DECODE(D.MM_MARGIN_RATE_03,NULL,100,0,100,D.MM_MARGIN_RATE_03) / 100), 1) ELSE A.MM_AMT_03 END), 0) / 1000) AS MM_AMT_03 \n");
           // sbSql.append("      ,ROUND(NVL((CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'04' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_04 * NVL((DECODE(D.MM_MARGIN_RATE_04,NULL,100,0,100,D.MM_MARGIN_RATE_04) / 100), 1) ELSE A.MM_AMT_04 END), 0) / 1000) AS MM_AMT_04 \n");
           // sbSql.append("      ,ROUND(NVL((CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'05' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_05 * NVL((DECODE(D.MM_MARGIN_RATE_05,NULL,100,0,100,D.MM_MARGIN_RATE_05) / 100), 1) ELSE A.MM_AMT_05 END), 0) / 1000) AS MM_AMT_05 \n");
           // sbSql.append("      ,ROUND(NVL((CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'06' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_06 * NVL((DECODE(D.MM_MARGIN_RATE_06,NULL,100,0,100,D.MM_MARGIN_RATE_06) / 100), 1) ELSE A.MM_AMT_06 END), 0) / 1000) AS MM_AMT_06 \n");
           // sbSql.append("      ,ROUND(NVL((CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'07' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_07 * NVL((DECODE(D.MM_MARGIN_RATE_07,NULL,100,0,100,D.MM_MARGIN_RATE_07) / 100), 1) ELSE A.MM_AMT_07 END), 0) / 1000) AS MM_AMT_07 \n");
           // sbSql.append("      ,ROUND(NVL((CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'08' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_08 * NVL((DECODE(D.MM_MARGIN_RATE_08,NULL,100,0,100,D.MM_MARGIN_RATE_08) / 100), 1) ELSE A.MM_AMT_08 END), 0) / 1000) AS MM_AMT_08 \n");
           // sbSql.append("      ,ROUND(NVL((CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'09' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_09 * NVL((DECODE(D.MM_MARGIN_RATE_09,NULL,100,0,100,D.MM_MARGIN_RATE_09) / 100), 1) ELSE A.MM_AMT_09 END), 0) / 1000) AS MM_AMT_09 \n");
           // sbSql.append("      ,ROUND(NVL((CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'10' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_10 * NVL((DECODE(D.MM_MARGIN_RATE_10,NULL,100,0,100,D.MM_MARGIN_RATE_10) / 100), 1) ELSE A.MM_AMT_10 END), 0) / 1000) AS MM_AMT_10 \n");
           // sbSql.append("      ,ROUND(NVL((CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'11' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_11 * NVL((DECODE(D.MM_MARGIN_RATE_11,NULL,100,0,100,D.MM_MARGIN_RATE_11) / 100), 1) ELSE A.MM_AMT_11 END), 0) / 1000) AS MM_AMT_11 \n");
           //  sbSql.append("      ,ROUND(NVL((CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'12' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_12 * NVL((DECODE(D.MM_MARGIN_RATE_12,NULL,100,0,100,D.MM_MARGIN_RATE_12) / 100), 1) ELSE A.MM_AMT_12 END), 0) / 1000) AS MM_AMT_12 \n");
           // sbSql.append("        ,NVL(ROUND(( NVL((CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'01' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_01 * NVL((DECODE(D.MM_MARGIN_RATE_01,NULL,100,0,100,D.MM_MARGIN_RATE_01) / 100), 1) ELSE A.MM_AMT_01 END), 0)              \n");
           // sbSql.append("                    +NVL((CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'02' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_02 * NVL((DECODE(D.MM_MARGIN_RATE_02,NULL,100,0,100,D.MM_MARGIN_RATE_02) / 100), 1) ELSE A.MM_AMT_02 END), 0)              \n");
           // sbSql.append("                    +NVL((CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'03' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_03 * NVL((DECODE(D.MM_MARGIN_RATE_03,NULL,100,0,100,D.MM_MARGIN_RATE_03) / 100), 1) ELSE A.MM_AMT_03 END), 0)              \n");
          //  sbSql.append("                    +NVL((CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'04' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_04 * NVL((DECODE(D.MM_MARGIN_RATE_04,NULL,100,0,100,D.MM_MARGIN_RATE_04) / 100), 1) ELSE A.MM_AMT_04 END), 0)              \n");
          //  sbSql.append("                    +NVL((CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'05' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_05 * NVL((DECODE(D.MM_MARGIN_RATE_05,NULL,100,0,100,D.MM_MARGIN_RATE_05) / 100), 1) ELSE A.MM_AMT_05 END), 0)              \n");
          //  sbSql.append("                    +NVL((CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'06' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_06 * NVL((DECODE(D.MM_MARGIN_RATE_06,NULL,100,0,100,D.MM_MARGIN_RATE_06) / 100), 1) ELSE A.MM_AMT_06 END), 0)              \n");
          //  sbSql.append("                    +NVL((CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'07' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_07 * NVL((DECODE(D.MM_MARGIN_RATE_07,NULL,100,0,100,D.MM_MARGIN_RATE_07) / 100), 1) ELSE A.MM_AMT_07 END), 0)              \n");
          //  sbSql.append("                    +NVL((CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'08' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_08 * NVL((DECODE(D.MM_MARGIN_RATE_08,NULL,100,0,100,D.MM_MARGIN_RATE_08) / 100), 1) ELSE A.MM_AMT_08 END), 0)              \n");
          //  sbSql.append("                    +NVL((CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'09' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_09 * NVL((DECODE(D.MM_MARGIN_RATE_09,NULL,100,0,100,D.MM_MARGIN_RATE_09) / 100), 1) ELSE A.MM_AMT_09 END), 0)              \n");
          //  sbSql.append("                    +NVL((CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'10' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_10 * NVL((DECODE(D.MM_MARGIN_RATE_10,NULL,100,0,100,D.MM_MARGIN_RATE_10) / 100), 1) ELSE A.MM_AMT_10 END), 0)              \n");
         //   sbSql.append("                    +NVL((CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'11' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_11 * NVL((DECODE(D.MM_MARGIN_RATE_11,NULL,100,0,100,D.MM_MARGIN_RATE_11) / 100), 1) ELSE A.MM_AMT_11 END), 0)              \n");
          //  sbSql.append("                    +NVL((CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'12' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_12 * NVL((DECODE(D.MM_MARGIN_RATE_12,NULL,100,0,100,D.MM_MARGIN_RATE_12) / 100), 1) ELSE A.MM_AMT_12 END), 0)              \n");
          //  sbSql.append("              ) / 1000 ), 0)  SUM_AMT \n");
            sbSql.append("      ,ROUND(NVL((CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'01' < TO_CHAR(SYSDATE, 'YYYYMM') THEN (CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN C.MM_AMT_01 * NVL((DECODE(D.MM_MARGIN_RATE_01,NULL,100,0,100,D.MM_MARGIN_RATE_01) / 100), 1) ELSE  C.MM_AMT_01 END ) ELSE A.MM_AMT_01 END), 0) / 1000) AS MM_AMT_01 \n");
            sbSql.append("      ,ROUND(NVL((CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'02' < TO_CHAR(SYSDATE, 'YYYYMM') THEN (CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN C.MM_AMT_02 * NVL((DECODE(D.MM_MARGIN_RATE_02,NULL,100,0,100,D.MM_MARGIN_RATE_02) / 100), 1) ELSE  C.MM_AMT_02 END ) ELSE A.MM_AMT_02 END), 0) / 1000) AS MM_AMT_02 \n");
            sbSql.append("      ,ROUND(NVL((CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'03' < TO_CHAR(SYSDATE, 'YYYYMM') THEN (CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN C.MM_AMT_03 * NVL((DECODE(D.MM_MARGIN_RATE_03,NULL,100,0,100,D.MM_MARGIN_RATE_03) / 100), 1) ELSE  C.MM_AMT_03 END ) ELSE A.MM_AMT_03 END), 0) / 1000) AS MM_AMT_03 \n");
            sbSql.append("      ,ROUND(NVL((CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'04' < TO_CHAR(SYSDATE, 'YYYYMM') THEN (CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN C.MM_AMT_04 * NVL((DECODE(D.MM_MARGIN_RATE_05,NULL,100,0,100,D.MM_MARGIN_RATE_04) / 100), 1) ELSE  C.MM_AMT_04 END ) ELSE A.MM_AMT_04 END), 0) / 1000) AS MM_AMT_04 \n");
            sbSql.append("      ,ROUND(NVL((CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'05' < TO_CHAR(SYSDATE, 'YYYYMM') THEN (CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN C.MM_AMT_05 * NVL((DECODE(D.MM_MARGIN_RATE_05,NULL,100,0,100,D.MM_MARGIN_RATE_05) / 100), 1) ELSE  C.MM_AMT_05 END ) ELSE A.MM_AMT_05 END), 0) / 1000) AS MM_AMT_05 \n");
            sbSql.append("      ,ROUND(NVL((CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'06' < TO_CHAR(SYSDATE, 'YYYYMM') THEN (CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN C.MM_AMT_06 * NVL((DECODE(D.MM_MARGIN_RATE_06,NULL,100,0,100,D.MM_MARGIN_RATE_06) / 100), 1) ELSE  C.MM_AMT_06 END ) ELSE A.MM_AMT_06 END), 0) / 1000) AS MM_AMT_06 \n");
            sbSql.append("      ,ROUND(NVL((CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'07' < TO_CHAR(SYSDATE, 'YYYYMM') THEN (CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN C.MM_AMT_07 * NVL((DECODE(D.MM_MARGIN_RATE_07,NULL,100,0,100,D.MM_MARGIN_RATE_07) / 100), 1) ELSE  C.MM_AMT_07 END ) ELSE A.MM_AMT_07 END), 0) / 1000) AS MM_AMT_07 \n");
            sbSql.append("      ,ROUND(NVL((CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'08' < TO_CHAR(SYSDATE, 'YYYYMM') THEN (CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN C.MM_AMT_08 * NVL((DECODE(D.MM_MARGIN_RATE_08,NULL,100,0,100,D.MM_MARGIN_RATE_08) / 100), 1) ELSE  C.MM_AMT_08 END ) ELSE A.MM_AMT_08 END), 0) / 1000) AS MM_AMT_08 \n");
            sbSql.append("      ,ROUND(NVL((CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'09' < TO_CHAR(SYSDATE, 'YYYYMM') THEN (CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN C.MM_AMT_09 * NVL((DECODE(D.MM_MARGIN_RATE_09,NULL,100,0,100,D.MM_MARGIN_RATE_09) / 100), 1) ELSE  C.MM_AMT_09 END ) ELSE A.MM_AMT_09 END), 0) / 1000) AS MM_AMT_09 \n");
            sbSql.append("      ,ROUND(NVL((CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'10' < TO_CHAR(SYSDATE, 'YYYYMM') THEN (CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN C.MM_AMT_10 * NVL((DECODE(D.MM_MARGIN_RATE_10,NULL,100,0,100,D.MM_MARGIN_RATE_10) / 100), 1) ELSE  C.MM_AMT_10 END ) ELSE A.MM_AMT_10 END), 0) / 1000) AS MM_AMT_10 \n");
            sbSql.append("      ,ROUND(NVL((CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'11' < TO_CHAR(SYSDATE, 'YYYYMM') THEN (CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN C.MM_AMT_11 * NVL((DECODE(D.MM_MARGIN_RATE_11,NULL,100,0,100,D.MM_MARGIN_RATE_11) / 100), 1) ELSE  C.MM_AMT_11 END ) ELSE A.MM_AMT_11 END), 0) / 1000) AS MM_AMT_11 \n");
            sbSql.append("      ,ROUND(NVL((CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'12' < TO_CHAR(SYSDATE, 'YYYYMM') THEN (CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN C.MM_AMT_12 * NVL((DECODE(D.MM_MARGIN_RATE_12,NULL,100,0,100,D.MM_MARGIN_RATE_12) / 100), 1) ELSE  C.MM_AMT_12 END ) ELSE A.MM_AMT_12 END), 0) / 1000) AS MM_AMT_12 \n");
            sbSql.append("        ,NVL(ROUND(( NVL((CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'01' < TO_CHAR(SYSDATE, 'YYYYMM') THEN (CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN C.MM_AMT_01 * NVL((DECODE(D.MM_MARGIN_RATE_01,NULL,100,0,100,D.MM_MARGIN_RATE_01) / 100), 1) ELSE  C.MM_AMT_01 END ) ELSE A.MM_AMT_01 END), 0)              \n");
            sbSql.append("                    +NVL((CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'02' < TO_CHAR(SYSDATE, 'YYYYMM') THEN (CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN C.MM_AMT_02 * NVL((DECODE(D.MM_MARGIN_RATE_02,NULL,100,0,100,D.MM_MARGIN_RATE_02) / 100), 1) ELSE  C.MM_AMT_02 END ) ELSE A.MM_AMT_02 END), 0)              \n");
            sbSql.append("                    +NVL((CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'03' < TO_CHAR(SYSDATE, 'YYYYMM') THEN (CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN C.MM_AMT_03 * NVL((DECODE(D.MM_MARGIN_RATE_03,NULL,100,0,100,D.MM_MARGIN_RATE_03) / 100), 1) ELSE  C.MM_AMT_03 END ) ELSE A.MM_AMT_03 END), 0)              \n");
            sbSql.append("                    +NVL((CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'04' < TO_CHAR(SYSDATE, 'YYYYMM') THEN (CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN C.MM_AMT_04 * NVL((DECODE(D.MM_MARGIN_RATE_04,NULL,100,0,100,D.MM_MARGIN_RATE_04) / 100), 1) ELSE  C.MM_AMT_04 END ) ELSE A.MM_AMT_04 END), 0)              \n");
            sbSql.append("                    +NVL((CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'05' < TO_CHAR(SYSDATE, 'YYYYMM') THEN (CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN C.MM_AMT_05 * NVL((DECODE(D.MM_MARGIN_RATE_05,NULL,100,0,100,D.MM_MARGIN_RATE_05) / 100), 1) ELSE  C.MM_AMT_05 END ) ELSE A.MM_AMT_05 END), 0)              \n");
            sbSql.append("                    +NVL((CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'06' < TO_CHAR(SYSDATE, 'YYYYMM') THEN (CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN C.MM_AMT_06 * NVL((DECODE(D.MM_MARGIN_RATE_06,NULL,100,0,100,D.MM_MARGIN_RATE_06) / 100), 1) ELSE  C.MM_AMT_06 END ) ELSE A.MM_AMT_06 END), 0)              \n");
            sbSql.append("                    +NVL((CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'07' < TO_CHAR(SYSDATE, 'YYYYMM') THEN (CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN C.MM_AMT_07 * NVL((DECODE(D.MM_MARGIN_RATE_07,NULL,100,0,100,D.MM_MARGIN_RATE_07) / 100), 1) ELSE  C.MM_AMT_07 END ) ELSE A.MM_AMT_07 END), 0)              \n");
            sbSql.append("                    +NVL((CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'08' < TO_CHAR(SYSDATE, 'YYYYMM') THEN (CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN C.MM_AMT_08 * NVL((DECODE(D.MM_MARGIN_RATE_08,NULL,100,0,100,D.MM_MARGIN_RATE_08) / 100), 1) ELSE  C.MM_AMT_08 END ) ELSE A.MM_AMT_08 END), 0)              \n");
            sbSql.append("                    +NVL((CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'09' < TO_CHAR(SYSDATE, 'YYYYMM') THEN (CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN C.MM_AMT_09 * NVL((DECODE(D.MM_MARGIN_RATE_09,NULL,100,0,100,D.MM_MARGIN_RATE_09) / 100), 1) ELSE  C.MM_AMT_09 END ) ELSE A.MM_AMT_09 END), 0)              \n");
            sbSql.append("                    +NVL((CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'10' < TO_CHAR(SYSDATE, 'YYYYMM') THEN (CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN C.MM_AMT_10 * NVL((DECODE(D.MM_MARGIN_RATE_10,NULL,100,0,100,D.MM_MARGIN_RATE_10) / 100), 1) ELSE  C.MM_AMT_10 END ) ELSE A.MM_AMT_10 END), 0)              \n");
            sbSql.append("                    +NVL((CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'11' < TO_CHAR(SYSDATE, 'YYYYMM') THEN (CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN C.MM_AMT_11 * NVL((DECODE(D.MM_MARGIN_RATE_11,NULL,100,0,100,D.MM_MARGIN_RATE_11) / 100), 1) ELSE  C.MM_AMT_11 END ) ELSE A.MM_AMT_11 END), 0)              \n");
            sbSql.append("                    +NVL((CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'12' < TO_CHAR(SYSDATE, 'YYYYMM') THEN (CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN C.MM_AMT_12 * NVL((DECODE(D.MM_MARGIN_RATE_12,NULL,100,0,100,D.MM_MARGIN_RATE_12) / 100), 1) ELSE  C.MM_AMT_12 END ) ELSE A.MM_AMT_12 END), 0)              \n");
            sbSql.append("              ) / 1000 ), 0)  SUM_AMT \n");
            sbSql.append("             ,DECODE(A.ACCT_CLASS, '매출액', '1', '재료비', '2', '인건비', '3', '경비', '4') SKEY \n");
        }
        sbSql.append("      , A.VER_CD, A.CC_CD, A.JOB_GRADE_CD, A.JOB_GRADE_NM								\n");
        /// 확정시 BPC에 재무금액을 보내기위한 조회.
        //월추정 관리금액 계산시 재료비계정만 출하율 계산 하도록 변경 20160308 처리:맹수영 요청자:윤지혜
        sbSql.append("      ,CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN NVL(ROUND(NVL((CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'01' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_01 ELSE NVL(A.MM_AMT_01 / DECODE(NVL((D.MM_MARGIN_RATE_01 / 100), 1),0,NULL,NVL((D.MM_MARGIN_RATE_01 / 100), 1)),0) END), 1)  / 1000), 0) \n");
        sbSql.append("       ELSE NVL(ROUND(NVL((CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'01' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_01 ELSE A.MM_AMT_01 END), 0) / 1000), 0)                                                                                  \n");
        sbSql.append("       END U_MM_AMT_01                                                                                                                                                                                                 \n");
        sbSql.append("      ,CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN NVL(ROUND(NVL((CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'02' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_02 ELSE NVL(A.MM_AMT_02 / DECODE(NVL((D.MM_MARGIN_RATE_02 / 100), 1),0,NULL,NVL((D.MM_MARGIN_RATE_02 / 100), 1)),0) END), 1)  / 1000), 0) \n");
        sbSql.append("       ELSE NVL(ROUND(NVL((CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'02' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_02 ELSE A.MM_AMT_02 END), 0) / 1000), 0)                                                                                  \n");
        sbSql.append("       END U_MM_AMT_02                                                                                                                                                                                                 \n");
        sbSql.append("      ,CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN NVL(ROUND(NVL((CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'03' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_03 ELSE NVL(A.MM_AMT_03 / DECODE(NVL((D.MM_MARGIN_RATE_03 / 100), 1),0,NULL,NVL((D.MM_MARGIN_RATE_03 / 100), 1)),0) END), 1)  / 1000), 0) \n");
        sbSql.append("       ELSE NVL(ROUND(NVL((CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'03' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_03 ELSE A.MM_AMT_03 END), 0) / 1000), 0)                                                                                  \n");
        sbSql.append("       END U_MM_AMT_03                                                                                                                                                                                                 \n");
        sbSql.append("      ,CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN NVL(ROUND(NVL((CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'04' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_04 ELSE NVL(A.MM_AMT_04 / DECODE(NVL((D.MM_MARGIN_RATE_04 / 100), 1),0,NULL,NVL((D.MM_MARGIN_RATE_04 / 100), 1)),0) END), 1)  / 1000), 0) \n");
        sbSql.append("       ELSE NVL(ROUND(NVL((CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'04' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_04 ELSE A.MM_AMT_04 END), 0) / 1000), 0)                                                                                  \n");
        sbSql.append("       END U_MM_AMT_04                                                                                                                                                                                                 \n");
        sbSql.append("      ,CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN NVL(ROUND(NVL((CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'05' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_05 ELSE NVL(A.MM_AMT_05 / DECODE(NVL((D.MM_MARGIN_RATE_05 / 100), 1),0,NULL,NVL((D.MM_MARGIN_RATE_05 / 100), 1)),0) END), 1)  / 1000), 0) \n");
        sbSql.append("       ELSE NVL(ROUND(NVL((CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'05' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_05 ELSE A.MM_AMT_05 END), 0) / 1000), 0)                                                                                  \n");
        sbSql.append("       END U_MM_AMT_05                                                                                                                                                                                                 \n");
        sbSql.append("      ,CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN NVL(ROUND(NVL((CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'06' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_06 ELSE NVL(A.MM_AMT_06 / DECODE(NVL((D.MM_MARGIN_RATE_06 / 100), 1),0,NULL,NVL((D.MM_MARGIN_RATE_06 / 100), 1)),0) END), 1)  / 1000), 0) \n");
        sbSql.append("       ELSE NVL(ROUND(NVL((CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'06' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_06 ELSE A.MM_AMT_06 END), 0) / 1000), 0)                                                                                  \n");
        sbSql.append("       END U_MM_AMT_06                                                                                                                                                                                                 \n");
        sbSql.append("      ,CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN NVL(ROUND(NVL((CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'07' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_07 ELSE NVL(A.MM_AMT_07 / DECODE(NVL((D.MM_MARGIN_RATE_07 / 100), 1),0,NULL,NVL((D.MM_MARGIN_RATE_07 / 100), 1)),0) END), 1)  / 1000), 0) \n");
        sbSql.append("       ELSE NVL(ROUND(NVL((CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'07' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_07 ELSE A.MM_AMT_07 END), 0) / 1000), 0)                                                                                  \n");
        sbSql.append("       END U_MM_AMT_07                                                                                                                                                                                                 \n");
        sbSql.append("      ,CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN NVL(ROUND(NVL((CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'08' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_08 ELSE NVL(A.MM_AMT_08 / DECODE(NVL((D.MM_MARGIN_RATE_08 / 100), 1),0,NULL,NVL((D.MM_MARGIN_RATE_08 / 100), 1)),0) END), 1)  / 1000), 0) \n");
        sbSql.append("       ELSE NVL(ROUND(NVL((CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'08' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_08 ELSE A.MM_AMT_08 END), 0) / 1000), 0)                                                                                  \n");
        sbSql.append("       END U_MM_AMT_08                                                                                                                                                                                                 \n");
        sbSql.append("      ,CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN NVL(ROUND(NVL((CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'09' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_09 ELSE NVL(A.MM_AMT_09 / DECODE(NVL((D.MM_MARGIN_RATE_09 / 100), 1),0,NULL,NVL((D.MM_MARGIN_RATE_09 / 100), 1)),0) END), 1)  / 1000), 0) \n");
        sbSql.append("       ELSE NVL(ROUND(NVL((CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'09' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_09 ELSE A.MM_AMT_09 END), 0) / 1000), 0)                                                                                  \n");
        sbSql.append("       END U_MM_AMT_09                                                                                                                                                                                                 \n");
        sbSql.append("      ,CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN NVL(ROUND(NVL((CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'10' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_10 ELSE NVL(A.MM_AMT_10 / DECODE(NVL((D.MM_MARGIN_RATE_10 / 100), 1),0,NULL,NVL((D.MM_MARGIN_RATE_10 / 100), 1)),0) END), 1)  / 1000), 0) \n");
        sbSql.append("       ELSE NVL(ROUND(NVL((CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'10' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_10 ELSE A.MM_AMT_10 END), 0) / 1000), 0)                                                                                  \n");
        sbSql.append("       END U_MM_AMT_10                                                                                                                                                                                                 \n");
        sbSql.append("      ,CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN NVL(ROUND(NVL((CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'11' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_11 ELSE NVL(A.MM_AMT_11 / DECODE(NVL((D.MM_MARGIN_RATE_11 / 100), 1),0,NULL,NVL((D.MM_MARGIN_RATE_11 / 100), 1)),0) END), 1)  / 1000), 0) \n");
        sbSql.append("       ELSE NVL(ROUND(NVL((CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'11' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_11 ELSE A.MM_AMT_11 END), 0) / 1000), 0)                                                                                  \n");
        sbSql.append("       END U_MM_AMT_11                                                                                                                                                                                                 \n");
        sbSql.append("      ,CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN NVL(ROUND(NVL((CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'12' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_12 ELSE NVL(A.MM_AMT_12 / DECODE(NVL((D.MM_MARGIN_RATE_12 / 100), 1),0,NULL,NVL((D.MM_MARGIN_RATE_12 / 100), 1)),0) END), 1)  / 1000), 0) \n");
        sbSql.append("       ELSE NVL(ROUND(NVL((CASE WHEN '"+nullToBlank(ds_Cond.getString(0, "INPUT_YY"))+"'||'12' < TO_CHAR(SYSDATE, 'YYYYMM') THEN C.MM_AMT_12 ELSE A.MM_AMT_12 END), 0) / 1000), 0)                                                                                  \n");
        sbSql.append("       END U_MM_AMT_12                                                                                                                                                                                                 \n");

        sbSql.append("  FROM MAP_MON_PLAN A  																\n");
        sbSql.append(" 		,MAP_MON_LOG_MGMT B 															\n");
        sbSql.append("  	,( 																				\n");
        sbSql.append("  		SELECT ACCT_CD, FISCAL_YEAR													\n");
        sbSql.append("  		      ,MM_AMT_01, MM_AMT_02, MM_AMT_03, MM_AMT_04, MM_AMT_05, MM_AMT_06		\n");
        sbSql.append("  			  ,MM_AMT_07, MM_AMT_08, MM_AMT_09, MM_AMT_10, MM_AMT_11, MM_AMT_12		\n");
        sbSql.append("  			  ,'0' AS SUM_AMT														\n");
        sbSql.append("  		  FROM MAP_UPJANG_PL														\n");
        sbSql.append("  		 WHERE CC_CD = (SELECT CC_CD FROM ST_UPJANG WHERE UPJANG = '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "')	\n");
        sbSql.append("  		   AND FISCAL_YEAR = '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'\n");
        sbSql.append("  		   AND PL_CLASS = '" + "KS" + "'											\n");
        sbSql.append("  	 ) C																			\n");

        sbSql.append("      ,(																				\n");
        sbSql.append(" 		 SELECT *								  										\n");
        sbSql.append(" 		  FROM MAP_MARGIN_RATE_MGMT														\n");
        sbSql.append(" 		 WHERE UPJANG ='" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'	  		\n");
        sbSql.append(" 		   AND YY = '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'				\n");
        sbSql.append(" 		   AND CLASS = '" + "R" + "'													\n");
        sbSql.append(" 		 ) D 																			\n");
        //2018.10.01 김명섭 계정코드 정렬순서 변경
        sbSql.append("      ,(                                                                              \n");
        sbSql.append("       SELECT ACCTCD, SEQ FROM MAS_ST_ACCOUNT                                         \n");
        sbSql.append("       ) E                                                                            \n");
        sbSql.append(" WHERE A.UPJANG = B.UPJANG	 														\n");
        sbSql.append("   AND A.YY = B.YY 																	\n");
        sbSql.append("   AND A.UPJANG = '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'				\n");
        sbSql.append("   AND A.YY = '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'					\n");
        sbSql.append("   AND A.BIZ_CLASS = '" + nullToBlank(ds_Cond.getString(0, "BIZ_CLASS2")) + "'		\n");
        sbSql.append("   AND B.BIZ_CLASS = '" + nullToBlank(ds_Cond.getString(0, "BIZ_CLASS2")) + "'		\n");
        sbSql.append("   AND A.ACCT_CD = C.ACCT_CD(+)														\n");
        sbSql.append("   AND A.UPJANG = D.UPJANG(+)															\n");
        sbSql.append("   AND A.ACCT_CD = E.ACCTCD(+)                                                        \n");
        sbSql.append(" ORDER BY E.SEQ, A.ACCT_CD	    													\n");

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