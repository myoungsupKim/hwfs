
<%
    /*-----------------------------------------------------------------------------
    ■ 시스템명     : 사업계획관리/손익 실적조회
    ■ 프로그램ID   : MAP30070E_S002.jsp
    ■ 프로그램명   : 업장출하율 관리 / 실적적용
    ■ 작성일자     : 2015-07-14
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
        //String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
        String g_EmpNo = nullToBlank(in_vl.getString("g_EmpNo"));
        String g_PreYy = nullToBlank(in_vl.getString("g_PreYy"));

        String g_Upjang = nullToBlank(ds_Cond.getString(0, "UPJANG"));
        String g_Yy = nullToBlank(ds_Cond.getString(0, "INPUT_YY"));
        String g_Class = nullToBlank(ds_Cond.getString(0, "CLASS"));
        String g_MuCd = nullToBlank(ds_Cond.getString(0, "MU_CD"));
        String g_TmCd = nullToBlank(ds_Cond.getString(0, "TM_CD"));
        String g_Mm = nullToBlank(ds_Cond.getString(0, "INPUT_MM"));

        String g_tmpMm = "";
        if (!g_Mm.equals("")) {
            if (Integer.parseInt(g_Mm) < 10) g_tmpMm = "0" + String.valueOf(Integer.parseInt(g_Mm));
            else g_tmpMm = g_Mm;
        }

        //out 데이타
        DataSet ds_List;

        //sql문 버퍼생성
        StringBuffer sbSql = new StringBuffer();

        if ("P".equals(g_Class)) {
            sbSql.delete(0, sbSql.length());
            sbSql.append("	SELECT B.UPJANGNM                                          			\n");
            sbSql.append("	      ,B.UPJANG                                            			\n");
            sbSql.append("	      ,'" + g_PreYy + "' AS YY                               			\n");
            sbSql.append("	      ,'실적적용' AS CLASS 											\n");
            sbSql.append("	      ,B.MU_CD		                                     			\n");
            sbSql.append("	      ,B.TM_CD		                                     			\n");
            if (!g_Mm.equals("")) {
                sbSql.append("       , NVL(A.MM_MARGIN_RATE_"+g_tmpMm+", 0) AS MM_MARGIN_RATE_"+g_tmpMm+"        \n");
            } else {
                sbSql.append("	      ,NVL(A.MM_MARGIN_RATE_01, 0) AS MM_MARGIN_RATE_01    			\n");
                sbSql.append("	      ,NVL(A.MM_MARGIN_RATE_02, 0) AS MM_MARGIN_RATE_02    			\n");
                sbSql.append("	      ,NVL(A.MM_MARGIN_RATE_03, 0) AS MM_MARGIN_RATE_03    			\n");
                sbSql.append("	      ,NVL(A.MM_MARGIN_RATE_04, 0) AS MM_MARGIN_RATE_04    			\n");
                sbSql.append("	      ,NVL(A.MM_MARGIN_RATE_05, 0) AS MM_MARGIN_RATE_05    			\n");
                sbSql.append("	      ,NVL(A.MM_MARGIN_RATE_06, 0) AS MM_MARGIN_RATE_06    			\n");
                sbSql.append("	      ,NVL(A.MM_MARGIN_RATE_07, 0) AS MM_MARGIN_RATE_07    			\n");
                sbSql.append("	      ,NVL(A.MM_MARGIN_RATE_08, 0) AS MM_MARGIN_RATE_08    			\n");
                sbSql.append("	      ,NVL(A.MM_MARGIN_RATE_09, 0) AS MM_MARGIN_RATE_09    			\n");
                sbSql.append("	      ,NVL(A.MM_MARGIN_RATE_10, 0) AS MM_MARGIN_RATE_10    			\n");
                sbSql.append("	      ,NVL(A.MM_MARGIN_RATE_11, 0) AS MM_MARGIN_RATE_11    			\n");
                sbSql.append("	      ,NVL(A.MM_MARGIN_RATE_12, 0) AS MM_MARGIN_RATE_12    			\n");
            }
            sbSql.append("	  FROM MAP_MARGIN_RATE_MGMT A                              			\n");
            sbSql.append("	      ,SCO_UPJANG_MST_V B                                  			\n");
            sbSql.append("	 WHERE A.UPJANG(+) = B.UPJANG                                 		\n");
            sbSql.append("	   AND A.CLASS(+) = '" + "R" + "' 	                         		\n");
            sbSql.append("	   AND A.YY(+) = '" + g_PreYy + "' 									\n");
            sbSql.append("	   AND B.CLOSE_DATE IS NULL                       					\n");

            if (!"".equals(g_MuCd)) {
                sbSql.append("	   AND B.MU_CD = '" + g_MuCd + "'   								\n");
            }
            if (!"".equals(g_TmCd)) {
                sbSql.append("	   AND (B.TM_CD = '" + g_TmCd + "' OR PT_CD = '" + g_TmCd + "') 	\n");
            }
            if (!"".equals(g_Upjang)) {
                sbSql.append("	   AND B.UPJANG = " + g_Upjang + " 									\n");
            }
            sbSql.append("	 ORDER BY UPJANGNM 													\n");
            /*
            sbSql.delete(0, sbSql.length());
            sbSql.append("	SELECT C.UPJANGNM                                                                                                \n");
            sbSql.append("	      ,C.UPJANG                                                                                            		 \n");
            sbSql.append("	      ,'"+ g_PreYy +"' AS YY                                                                          			 \n");
            sbSql.append("	      , '실적적용' AS CLASS                                                                                          \n");
            sbSql.append("	      ,C.MU_CD		                                     														 \n");
            sbSql.append("	      ,C.TM_CD		                                     														 \n");
            //sbSql.append("	      ,A.ACCTCD AS ACCT_CD                                                                                       \n");
            sbSql.append("	      ,CASE WHEN SUBSTR(A.TRANS_DATE, 5, 2) = '01' THEN ROUND(SUM(A.MARGIN_AMOUNT / A.UNIT_AMOUNT) * 100)   \n");
            sbSql.append("	       ELSE 0                                                                                                    \n");
            sbSql.append("	       END MM_MARGIN_RATE_01                                                                                     \n");
            sbSql.append("	      ,CASE WHEN SUBSTR(A.TRANS_DATE, 5, 2) = '02' THEN ROUND(SUM(A.MARGIN_AMOUNT / A.UNIT_AMOUNT) * 100)   \n");
            sbSql.append("	       ELSE 0                                                                                                    \n");
            sbSql.append("	       END MM_MARGIN_RATE_02                                                                                     \n");
            sbSql.append("	      ,CASE WHEN SUBSTR(A.TRANS_DATE, 5, 2) = '03' THEN ROUND(SUM(A.MARGIN_AMOUNT / A.UNIT_AMOUNT) * 100)   \n");
            sbSql.append("	       ELSE 0                                                                                                    \n");
            sbSql.append("	       END MM_MARGIN_RATE_03                                                                                     \n");
            sbSql.append("	      ,CASE WHEN SUBSTR(A.TRANS_DATE, 5, 2) = '04' THEN ROUND(SUM(A.MARGIN_AMOUNT / A.UNIT_AMOUNT) * 100)   \n");
            sbSql.append("	       ELSE 0                                                                                                    \n");
            sbSql.append("	       END MM_MARGIN_RATE_04                                                                                     \n");
            sbSql.append("	      ,CASE WHEN SUBSTR(A.TRANS_DATE, 5, 2) = '05' THEN ROUND(SUM(A.MARGIN_AMOUNT / A.UNIT_AMOUNT) * 100)   \n");
            sbSql.append("	       ELSE 0                                                                                                    \n");
            sbSql.append("	       END MM_MARGIN_RATE_05                                                                                     \n");
            sbSql.append("	      ,CASE WHEN SUBSTR(A.TRANS_DATE, 5, 2) = '06' THEN ROUND(SUM(A.MARGIN_AMOUNT / A.UNIT_AMOUNT) * 100)   \n");
            sbSql.append("	       ELSE 0                                                                                                    \n");
            sbSql.append("	       END MM_MARGIN_RATE_06                                                                                     \n");
            sbSql.append("	      ,CASE WHEN SUBSTR(A.TRANS_DATE, 5, 2) = '07' THEN ROUND(SUM(A.MARGIN_AMOUNT / A.UNIT_AMOUNT) * 100)   \n");
            sbSql.append("	       ELSE 0                                                                                                    \n");
            sbSql.append("	       END MM_MARGIN_RATE_07                                                                                     \n");
            sbSql.append("	      ,CASE WHEN SUBSTR(A.TRANS_DATE, 5, 2) = '08' THEN ROUND(SUM(A.MARGIN_AMOUNT / A.UNIT_AMOUNT) * 100)   \n");
            sbSql.append("	       ELSE 0                                                                                                    \n");
            sbSql.append("	       END MM_MARGIN_RATE_08                                                                                     \n");
            sbSql.append("	      ,CASE WHEN SUBSTR(A.TRANS_DATE, 5, 2) = '09' THEN ROUND(SUM(A.MARGIN_AMOUNT / A.UNIT_AMOUNT) * 100)   \n");
            sbSql.append("	       ELSE 0                                                                                                    \n");
            sbSql.append("	       END MM_MARGIN_RATE_09                                                                                     \n");
            sbSql.append("	      ,CASE WHEN SUBSTR(A.TRANS_DATE, 5, 2) = '10' THEN ROUND(SUM(A.MARGIN_AMOUNT / A.UNIT_AMOUNT) * 100)   \n");
            sbSql.append("	       ELSE 0                                                                                                    \n");
            sbSql.append("	       END MM_MARGIN_RATE_11                                                                                     \n");
            sbSql.append("	      ,CASE WHEN SUBSTR(A.TRANS_DATE, 5, 2) = '11' THEN ROUND(SUM(A.MARGIN_AMOUNT / A.UNIT_AMOUNT) * 100)   \n");
            sbSql.append("	       ELSE 0                                                                                                    \n");
            sbSql.append("	       END MM_MARGIN_RATE_1                                                                                      \n");
            sbSql.append("	      ,CASE WHEN SUBSTR(A.TRANS_DATE, 5, 2) = '12' THEN ROUND(SUM(A.MARGIN_AMOUNT / A.UNIT_AMOUNT) * 100)   \n");
            sbSql.append("	       ELSE 0                                                                                                    \n");
            sbSql.append("	       END MM_MARGIN_RATE_12                                                                                     \n");
            sbSql.append("	  FROM HLDC_PO_TRANSACTION A										                                             \n");
            sbSql.append("	      ,HLDC_PO_SUBINVENTORY B                                                                                    \n");
            //sbSql.append("	      ,SCO_UPJANG_MST_V C                                                                                        \n");
            sbSql.append("	      ,(																										 \n");
            sbSql.append("            select DISTINCT C.UPJANG                        														 \n");
            sbSql.append("                  ,C.UPJANGNM                               														 \n");
            sbSql.append("                  ,C.MU_CD                                  														 \n");
            sbSql.append("                  ,C.TM_CD                                  														 \n");
            sbSql.append("              from HLDC_PO_TRANSACTION A                    														 \n");
            sbSql.append("                  ,( SELECT UPJANGNM                        														 \n");
            sbSql.append("                           ,UPJANG                          														 \n");
            sbSql.append("                           ,MU_CD                           														 \n");
            sbSql.append("                           ,TM_CD                           														 \n");
            sbSql.append("                       FROM SCO_UPJANG_MST_V                														 \n");
            if(!"".equals(g_MuCd)){
                sbSql.append("	   				WHERE MU_CD = '" + g_MuCd + "'   															 \n");
            }
            if(!"".equals(g_TmCd)){
                sbSql.append("	   				  AND TM_CD = '" + g_TmCd + "'   															 \n");
            }
            if(!"".equals(g_Upjang)){
                sbSql.append("	   				  AND UPJANG = " + g_Upjang + " 															 \n");
            }
            sbSql.append("                   ) C                                      \n");
            sbSql.append("             WHERE 1=1                                      \n");
            sbSql.append("               AND A.TRANS_UPJANG(+) = C.UPJANG             \n");
            sbSql.append("           ) C                                              \n");
            sbSql.append("	 WHERE A.SUBINV_CODE(+) = B.SUBINV_CODE								                                             \n");
            sbSql.append("	   AND B.UPJANG(+) = C.UPJANG                                                                                 	 \n");
            sbSql.append("	   AND SUBSTR(A.TRANS_DATE(+), 1, 4) = '" + g_PreYy + "'                                                         \n");
            sbSql.append("	   AND A.TRANS_TYPE(+) LIKE 'O%'										                                         \n");
            sbSql.append("	   AND A.TRANS_TYPE(+) <> 'O002'                                                                                 \n");
            sbSql.append("	   AND A.ACCTCD(+) IN ('42201010', '42201030', '42201040', '42203010', '42203020')                               \n");
            sbSql.append("	 GROUP BY C.UPJANGNM, C.UPJANG, SUBSTR(A.TRANS_DATE, 1, 4), C.MU_CD, C.TM_CD                               		 \n");
            sbSql.append("	 ORDER BY C.UPJANGNM														                               		 \n");
            */
        } else {
            sbSql.delete(0, sbSql.length());
            sbSql.append(" SELECT X.UPJANGNM                                          \n");
            sbSql.append("      , X.UPJANG                                            \n");
            sbSql.append("      , X.YY                                                \n");
            sbSql.append("      , X.CLASS                                             \n");
            sbSql.append("      , X.MU_CD                                             \n");
            sbSql.append("      , X.TM_CD                                             \n");

            if (!g_Mm.equals("")) {
                sbSql.append("      , NVL(MAX(MM_MARGIN_RATE_"+g_tmpMm+"), 100) AS MM_MARGIN_RATE_"+g_tmpMm+"         \n");
            } else {
                sbSql.append("      , NVL(MAX(MM_MARGIN_RATE_01), 100) AS MM_MARGIN_RATE_01         \n");
                sbSql.append("      , NVL(MAX(MM_MARGIN_RATE_02), 100) AS MM_MARGIN_RATE_02         \n");
                sbSql.append("      , NVL(MAX(MM_MARGIN_RATE_03), 100) AS MM_MARGIN_RATE_03         \n");
                sbSql.append("      , NVL(MAX(MM_MARGIN_RATE_04), 100) AS MM_MARGIN_RATE_04         \n");
                sbSql.append("      , NVL(MAX(MM_MARGIN_RATE_05), 100) AS MM_MARGIN_RATE_05         \n");
                sbSql.append("      , NVL(MAX(MM_MARGIN_RATE_06), 100) AS MM_MARGIN_RATE_06         \n");
                sbSql.append("      , NVL(MAX(MM_MARGIN_RATE_07), 100) AS MM_MARGIN_RATE_07         \n");
                sbSql.append("      , NVL(MAX(MM_MARGIN_RATE_08), 100) AS MM_MARGIN_RATE_08         \n");
                sbSql.append("      , NVL(MAX(MM_MARGIN_RATE_09), 100) AS MM_MARGIN_RATE_09         \n");
                sbSql.append("      , NVL(MAX(MM_MARGIN_RATE_10), 100) AS MM_MARGIN_RATE_10         \n");
                sbSql.append("      , NVL(MAX(MM_MARGIN_RATE_11), 100) AS MM_MARGIN_RATE_11         \n");
                sbSql.append("      , NVL(MAX(MM_MARGIN_RATE_12), 100) AS MM_MARGIN_RATE_12         \n");
            }

            sbSql.append("   FROM (                                                   \n");
            sbSql.append("	       SELECT C.UPJANGNM                                                                                                \n");
            sbSql.append("	             ,C.UPJANG                                                                                            		 \n");
            sbSql.append("	             ,'" + g_Yy + "' AS YY                                                                          			 	 \n");
            sbSql.append("	             , '실적적용' AS CLASS                                                                                          \n");
            sbSql.append("	             ,C.MU_CD		                                     														 \n");
            sbSql.append("	             ,C.TM_CD		                                     														 \n");
            if (!g_Mm.equals("")) {
                //sbSql.append("               ,CASE WHEN SUBSTR(A.TRANS_DATE, 5, 2) = '"+g_tmpMm+"' AND SUM(A.UNIT_AMOUNT) > 0 THEN ROUND((SUM(A.MARGIN_AMOUNT) / SUM(A.UNIT_AMOUNT)) * 100, 2)   \n");
                sbSql.append("               ,CASE WHEN SUBSTR(A.TRANS_DATE, 5, 2) = '"+g_tmpMm+"' AND SUM(A.UNIT_AMOUNT) > 0 THEN ROUND((SUM(A.MARGIN_AMOUNT) / (SUM(A.UNIT_AMOUNT) -NVL(MAX(YIJAE_AMT),0))) * 100, 2)   \n");
                sbSql.append("                ELSE AVG(NVL(D.MM_MARGIN_RATE_"+g_tmpMm+",100))                                                                      \n");
                sbSql.append("                END MM_MARGIN_RATE_"+g_tmpMm+"                                                                                     \n");
            } else {
                sbSql.append("	             ,CASE WHEN SUBSTR(A.TRANS_DATE, 5, 2) = '01' AND SUM(A.UNIT_AMOUNT) > 0 THEN ROUND((SUM(A.MARGIN_AMOUNT) / SUM(A.UNIT_AMOUNT)) * 100, 2)   \n");
                sbSql.append("	              ELSE AVG(NVL(D.MM_MARGIN_RATE_01,100))                                                                      \n");
                sbSql.append("	              END MM_MARGIN_RATE_01                                                                                     \n");
                sbSql.append("	             ,CASE WHEN SUBSTR(A.TRANS_DATE, 5, 2) = '02' AND SUM(A.UNIT_AMOUNT) > 0 THEN ROUND((SUM(A.MARGIN_AMOUNT) / SUM(A.UNIT_AMOUNT)) * 100, 2)   \n");
                sbSql.append("	              ELSE AVG(NVL(D.MM_MARGIN_RATE_02,100))                                                                      \n");
                sbSql.append("	              END MM_MARGIN_RATE_02                                                                                     \n");
                sbSql.append("	             ,CASE WHEN SUBSTR(A.TRANS_DATE, 5, 2) = '03' AND SUM(A.UNIT_AMOUNT) > 0 THEN ROUND((SUM(A.MARGIN_AMOUNT) / (SUM(A.UNIT_AMOUNT) -NVL(MAX(YIJAE_AMT),0))) * 100, 2)   \n");
                sbSql.append("	              ELSE AVG(NVL(D.MM_MARGIN_RATE_03,100))                                                                      \n");
                sbSql.append("	              END MM_MARGIN_RATE_03                                                                                     \n");
                sbSql.append("	             ,CASE WHEN SUBSTR(A.TRANS_DATE, 5, 2) = '04' AND SUM(A.UNIT_AMOUNT) > 0 THEN ROUND((SUM(A.MARGIN_AMOUNT) / SUM(A.UNIT_AMOUNT)) * 100, 2)   \n");
                sbSql.append("	              ELSE AVG(NVL(D.MM_MARGIN_RATE_04,100))                                                                      \n");
                sbSql.append("	              END MM_MARGIN_RATE_04                                                                                     \n");
                sbSql.append("	             ,CASE WHEN SUBSTR(A.TRANS_DATE, 5, 2) = '05' AND SUM(A.UNIT_AMOUNT) > 0 THEN ROUND((SUM(A.MARGIN_AMOUNT) / SUM(A.UNIT_AMOUNT)) * 100, 2)   \n");
                sbSql.append("	              ELSE AVG(NVL(D.MM_MARGIN_RATE_05,100))                                                                      \n");
                sbSql.append("	              END MM_MARGIN_RATE_05                                                                                     \n");
                sbSql.append("	             ,CASE WHEN SUBSTR(A.TRANS_DATE, 5, 2) = '06' AND SUM(A.UNIT_AMOUNT) > 0 THEN ROUND((SUM(A.MARGIN_AMOUNT) / (SUM(A.UNIT_AMOUNT) -NVL(MAX(YIJAE_AMT),0))) * 100, 2)   \n");
                sbSql.append("	              ELSE AVG(NVL(D.MM_MARGIN_RATE_06,100))                                                                      \n");
                sbSql.append("	              END MM_MARGIN_RATE_06                                                                                     \n");
                sbSql.append("	             ,CASE WHEN SUBSTR(A.TRANS_DATE, 5, 2) = '07' AND SUM(A.UNIT_AMOUNT) > 0 THEN ROUND((SUM(A.MARGIN_AMOUNT) / SUM(A.UNIT_AMOUNT)) * 100, 2)   \n");
                sbSql.append("	              ELSE AVG(NVL(D.MM_MARGIN_RATE_07,100))                                                                      \n");
                sbSql.append("	              END MM_MARGIN_RATE_07                                                                                     \n");
                sbSql.append("	             ,CASE WHEN SUBSTR(A.TRANS_DATE, 5, 2) = '08' AND SUM(A.UNIT_AMOUNT) > 0 THEN ROUND((SUM(A.MARGIN_AMOUNT) / SUM(A.UNIT_AMOUNT)) * 100, 2)   \n");
                sbSql.append("	              ELSE AVG(NVL(D.MM_MARGIN_RATE_08,100))                                                                      \n");
                sbSql.append("	              END MM_MARGIN_RATE_08                                                                                     \n");
                sbSql.append("	             ,CASE WHEN SUBSTR(A.TRANS_DATE, 5, 2) = '09' AND SUM(A.UNIT_AMOUNT) > 0 THEN ROUND((SUM(A.MARGIN_AMOUNT) / (SUM(A.UNIT_AMOUNT) -NVL(MAX(YIJAE_AMT),0))) * 100, 2)   \n");
                sbSql.append("	              ELSE AVG(NVL(D.MM_MARGIN_RATE_09,100))                                                                      \n");
                sbSql.append("	              END MM_MARGIN_RATE_09                                                                                     \n");
                sbSql.append("	             ,CASE WHEN SUBSTR(A.TRANS_DATE, 5, 2) = '10' AND SUM(A.UNIT_AMOUNT) > 0 THEN ROUND((SUM(A.MARGIN_AMOUNT) / SUM(A.UNIT_AMOUNT)) * 100, 2)   \n");
                sbSql.append("	              ELSE AVG(NVL(D.MM_MARGIN_RATE_10,100))                                                                      \n");
                sbSql.append("	              END MM_MARGIN_RATE_10                                                                                     \n");
                sbSql.append("	             ,CASE WHEN SUBSTR(A.TRANS_DATE, 5, 2) = '11' AND SUM(A.UNIT_AMOUNT) > 0 THEN ROUND((SUM(A.MARGIN_AMOUNT) / SUM(A.UNIT_AMOUNT)) * 100, 2)   \n");
                sbSql.append("	              ELSE AVG(NVL(D.MM_MARGIN_RATE_11,100))                                                                      \n");
                sbSql.append("	              END MM_MARGIN_RATE_11                                                                                     \n");
                sbSql.append("	             ,CASE WHEN SUBSTR(A.TRANS_DATE, 5, 2) = '12' AND SUM(A.UNIT_AMOUNT) > 0 THEN ROUND((SUM(A.MARGIN_AMOUNT) / (SUM(A.UNIT_AMOUNT) -NVL(MAX(YIJAE_AMT),0))) * 100, 2)   \n");
                sbSql.append("	              ELSE AVG(NVL(D.MM_MARGIN_RATE_12,100))                                                                      \n");
                sbSql.append("	              END MM_MARGIN_RATE_12                                                                                     \n");
            }
            sbSql.append("	         FROM								                                             \n");

 			sbSql.append("        (  SELECT B.UPJANG, MIHD.WH_CD SUBINV_CODE,    \n");
 			sbSql.append("                    MIHD.INSP_DATE TRANS_DATE \n");
 			//sbSql.append("                   , SUM(ROUND(NVL(DECODE(MIDT.CANCEL_YN, 'N', MIDT.GAP_BUY_AMT, 0), 0) + DECODE(MIDT.CANCEL_YN, 'Y', MIDT.AMEND_AMT, 0) , 2))  AS UNIT_AMOUNT    \n");
 			//sbSql.append("                    , SUM(ROUND(NVL(DECODE(MIDT.CANCEL_YN, 'N', MIDT.GAP_MGT_AMT, 0), 0) + DECODE(MIDT.CANCEL_YN, 'Y', MIDT.AMEND_MGT_AMT, 0) , 2)) AS MARGIN_AMOUNT    \n");
 			//불공제 업장 과세 품목 계산식 추가 ( 유신창현고) 20161114 요청자:윤지혜 처리: 맹수영
 			sbSql.append("                   , SUM(ROUND(NVL(DECODE(MIDT.CANCEL_YN, 'N', CASE WHEN MTGL.ACC_TAX_CD = '1' AND SWHU.NO_DEDUC_YN = 'Y' THEN MIDT.GAP_BUY_AMT * 1.1 ELSE MIDT.GAP_BUY_AMT END, 0), 0) + DECODE(MIDT.CANCEL_YN, 'Y', MIDT.AMEND_AMT, 0) , 2))  AS UNIT_AMOUNT   \n");
 			sbSql.append("                   , SUM(ROUND(NVL(DECODE(MIDT.CANCEL_YN, 'N', CASE WHEN MTGL.ACC_TAX_CD = '1' AND SWHU.NO_DEDUC_YN = 'Y' THEN MIDT.GAP_MGT_AMT * 1.1 ELSE MIDT.GAP_MGT_AMT END, 0), 0) + DECODE(MIDT.CANCEL_YN, 'Y', MIDT.AMEND_MGT_AMT, 0) , 2)) AS MARGIN_AMOUNT   \n");
 			//불공제 업장 과세 품목 계산식 추가 ( 유신창현고) 20161114 요청자:윤지혜 처리: 맹수영
 			//의제매입 계산 추가
 			sbSql.append("                  , DECODE(SUBSTR(MIHD.INSP_DATE,5,2),'03',(SELECT LCAL_AMT FROM SAP_IF.SAP_IFC_YIJAE WHERE SUBSTR(SLIP_PERIOD_DATE,1,6) =  SUBSTR(MIHD.INSP_DATE,1,6)  AND (ATTACH_DEPT = B.CC_CD))     \n");
 			sbSql.append("                                                    , '06',(SELECT LCAL_AMT FROM SAP_IF.SAP_IFC_YIJAE WHERE SUBSTR(SLIP_PERIOD_DATE,1,6) =  SUBSTR(MIHD.INSP_DATE,1,6)  AND (ATTACH_DEPT = B.CC_CD))     \n");
 			sbSql.append("                                                    , '09',(SELECT LCAL_AMT FROM SAP_IF.SAP_IFC_YIJAE WHERE SUBSTR(SLIP_PERIOD_DATE,1,6) =  SUBSTR(MIHD.INSP_DATE,1,6)  AND (ATTACH_DEPT = B.CC_CD))    \n");
 			sbSql.append("                                                    , '12',(SELECT LCAL_AMT FROM SAP_IF.SAP_IFC_YIJAE WHERE SUBSTR(SLIP_PERIOD_DATE,1,6) =  SUBSTR(MIHD.INSP_DATE,1,6)  AND (ATTACH_DEPT = B.CC_CD)),0)  YIJAE_AMT   \n");
 			sbSql.append("               FROM EPROCUSR.ESIMIHD MIHD   \n");
 			sbSql.append("                  INNER JOIN EPROCUSR.ESIMIDT MIDT   \n");
 			sbSql.append("                     ON MIHD.SYS_ID = MIDT.SYS_ID   \n");
			sbSql.append("                     AND MIHD.COMP_CD = MIDT.COMP_CD   \n");
 			sbSql.append("                     AND MIHD.IVT_INSP_NO = MIDT.IVT_INSP_NO   \n");
 			sbSql.append("                  INNER JOIN EPROCUSR.ESPSWHU SWHU   \n");
 			sbSql.append("                     ON MIHD.SYS_ID = SWHU.SYS_ID   \n");
 			sbSql.append("                     AND MIHD.COMP_CD = SWHU.COMP_CD   \n");
 			sbSql.append("                    AND MIHD.WH_CD = SWHU.WH_CD   \n");
 			sbSql.append("                  INNER JOIN SCO_UPJANG_MST A   \n");
 			sbSql.append("                     ON TO_NUMBER(SWHU.SHOP_CD) = A.UPJANG   \n");
 			sbSql.append("                  INNER JOIN ST_UPJANG B   \n");
 			sbSql.append("                     ON A.UPJANG = B.UPJANG   \n");
 			sbSql.append("                  INNER JOIN HLDC_SC_DEPT_V C   \n");
 			sbSql.append("                     ON B.DEPT_ID = C.DEPT_ID   \n");
 			//불공제 업장 과세 품목 계산식 추가 ( 유신창현고) 20161114 요청자:윤지혜 처리: 맹수영  시작
 			sbSql.append("                  INNER JOIN EPROCUSR.ESMMTGL MTGL    \n");
 			sbSql.append("                  ON MIDT.SYS_ID = MTGL.SYS_ID   \n");
 			sbSql.append("                  AND MIDT.ITEM_CD = MTGL.ITEM_CD  \n");
 			//불공제 업장 과세 품목 계산식 추가 ( 유신창현고) 20161114 요청자:윤지혜 처리: 맹수영  끝
 			sbSql.append("              WHERE MIHD.SYS_ID = '100'   \n");
 			sbSql.append("                AND MIHD.COMP_CD = 'HFC'   \n");
 			sbSql.append("                AND SUBSTR(MIHD.INSP_DATE,1,4) = '" + g_Yy + "'	  									                                 \n");
 			sbSql.append("                AND SUBSTR(MIHD.INSP_DATE,5,2) = '" + g_tmpMm + "'	  									                                 \n");
 			sbSql.append("                AND MIDT.MG_NO IS NOT NULL   \n");
 			sbSql.append("                AND MIHD.WH_CD LIKE 'C%'   \n");
 			sbSql.append("                AND MIDT.JRNL_TYP_CD IN (SELECT JRNL_TYP_CD FROM EPROCUSR.ESIJRNL WHERE SYS_ID = '100' AND COMP_CD = 'HFC' AND DR_ACC_CD IN  ('42201010', '42201020', '42201030', '42201040', '42203010', '42203020', '42203030')   AND MG_CLS_CD = 'GI')   \n");
 
 			if (!"".equals(g_MuCd)) {
     			sbSql.append("	   		       		  AND C.MU_CD = '" + g_MuCd + "'   															 \n");
 			}
 			if (!"".equals(g_TmCd)) {
     			sbSql.append("	   		       		  AND C.TM_CD = '" + g_TmCd + "'   															 \n");
 			}
 			if (!"".equals(g_Upjang)) {
     			sbSql.append("	   		       		  AND B.UPJANG = " + g_Upjang + " 															 \n");
 			}
 			sbSql.append("                GROUP BY B.UPJANG, MIHD.INSP_DATE , MIHD.WH_CD,  B.CC_CD \n");
 			sbSql.append("                ) A						 \n");				                                                                                 
 			sbSql.append("             ,(                  \n");          
 			sbSql.append("                  SELECT UPJANGNM      \n");                                  
 			sbSql.append("                                 ,UPJANG           \n");                               
 			sbSql.append("                                 ,MU_CD           \n");                                
 			sbSql.append("                                 ,TM_CD               \n");                            
 			sbSql.append("                             FROM SCO_UPJANG_MST_V     \n");                           
 			sbSql.append("                     WHERE CLOSE_DATE IS NULL          \n");                               
 			if (!"".equals(g_MuCd)) {
 			    sbSql.append("	   		       		  AND MU_CD = '" + g_MuCd + "'   															 \n");
 			}
 			if (!"".equals(g_TmCd)) {
 			    sbSql.append("	   		       		  AND TM_CD = '" + g_TmCd + "'   															 \n");
 			}
 			if (!"".equals(g_Upjang)) {
    	    sbSql.append("	   		       		  AND UPJANG = " + g_Upjang + " 															 \n");
 			}         
            sbSql.append("                  ) C                                              \n");
            sbSql.append("                 ,(                                                                                       \n");
            sbSql.append("                   SELECT A.UPJANG                                                                        \n");
            if (!g_Mm.equals("")) {
                sbSql.append("                         ,NVL(A.MM_MARGIN_RATE_"+g_tmpMm+", 0) AS MM_MARGIN_RATE_"+g_tmpMm+"                                      \n");
            } else {
                sbSql.append("                         ,NVL(A.MM_MARGIN_RATE_01, 100) AS MM_MARGIN_RATE_01    			                       \n");
                sbSql.append("                         ,NVL(A.MM_MARGIN_RATE_02, 100) AS MM_MARGIN_RATE_02    			                       \n");
                sbSql.append("                         ,NVL(A.MM_MARGIN_RATE_03, 100) AS MM_MARGIN_RATE_03    			                       \n");
                sbSql.append("                         ,NVL(A.MM_MARGIN_RATE_04, 100) AS MM_MARGIN_RATE_04    			                       \n");
                sbSql.append("                         ,NVL(A.MM_MARGIN_RATE_05, 100) AS MM_MARGIN_RATE_05    			                       \n");
                sbSql.append("                         ,NVL(A.MM_MARGIN_RATE_06, 100) AS MM_MARGIN_RATE_06    			                       \n");
                sbSql.append("                         ,NVL(A.MM_MARGIN_RATE_07, 100) AS MM_MARGIN_RATE_07    			                       \n");
                sbSql.append("                         ,NVL(A.MM_MARGIN_RATE_08, 100) AS MM_MARGIN_RATE_08    			                       \n");
                sbSql.append("                         ,NVL(A.MM_MARGIN_RATE_09, 100) AS MM_MARGIN_RATE_09    			                       \n");
                sbSql.append("                         ,NVL(A.MM_MARGIN_RATE_10, 100) AS MM_MARGIN_RATE_10    			                       \n");
                sbSql.append("                         ,NVL(A.MM_MARGIN_RATE_11, 100) AS MM_MARGIN_RATE_11    			                       \n");
                sbSql.append("                         ,NVL(A.MM_MARGIN_RATE_12, 100) AS MM_MARGIN_RATE_12    			                       \n");
            }
            sbSql.append("                     FROM MAP_MARGIN_RATE_MGMT A                              			                       \n");
            sbSql.append("                         ,SCO_UPJANG_MST_V B                                  			                       \n");
            sbSql.append("                    WHERE A.UPJANG(+) = B.UPJANG                                 		                       \n");
            sbSql.append("                      AND A.CLASS(+) = 'P'                          		                                   	   \n");
            sbSql.append("	          			AND B.CLOSE_DATE IS NULL                       										   \n");
            if (!"".equals(g_MuCd)) {
                sbSql.append("	   		        AND B.MU_CD = '" + g_MuCd + "'   																	 \n");
            }
            if (!"".equals(g_TmCd)) {
                sbSql.append("	   		        AND B.TM_CD = '" + g_TmCd + "'   															 		 \n");
            }
            if (!"".equals(g_Upjang)) {
                sbSql.append("	   	            AND B.UPJANG = " + g_Upjang + " 															 		 \n");
            }
            sbSql.append("                      AND A.YY(+) = '" + g_Yy + "'	  									                                 \n");
            sbSql.append("                  ) D -- 추가                                                                             				 \n");
         	sbSql.append("        WHERE A.UPJANG(+) = C.UPJANG          \n");                                                                         	 
    	    sbSql.append("          AND A.UPJANG = D.UPJANG(+)          \n");   
           // sbSql.append("	        WHERE A.SUBINV_CODE(+) = B.SUBINV_CODE								                                             \n");
           // sbSql.append("	          AND B.UPJANG(+) = C.UPJANG                                                                                 	 \n");
           // sbSql.append("	          AND B.UPJANG = D.UPJANG(+)                                                                                 	 \n");
            sbSql.append("	          AND SUBSTR(A.TRANS_DATE(+), 1, 4) = '" + g_Yy + "'  		                                                     \n");
            if (!g_Mm.equals("")) {
                sbSql.append("            AND SUBSTR(A.TRANS_DATE(+), 5, 2) = '" + g_tmpMm + "'                                                             \n");
            }
          //  sbSql.append("            AND A.TRANS_DATE IS NOT NULL                                                                              \n");
          //  sbSql.append("	          AND A.TRANS_TYPE(+) LIKE 'O%'										                                         \n");
           // sbSql.append("	          AND A.TRANS_TYPE(+) <> 'O002'                                                                                 \n");
            //출하율 계산시 부서별 z실적과 달라서 추가  20160226  맹수영   요청자 : 유영진대리
         //   sbSql.append("	          AND A.SUBINV_CODE(+) LIKE 'C%'                                                                                  \n");
           //출하율 계산시 부서별 z실적과 달라서 추가  20160226  맹수영   요청자 : 유영진대리 
         //   sbSql.append("	          AND A.ACCTCD(+) IN ('42201010', '42201020', '42201030', '42201040', '42203010', '42203020', '42203030')       \n");
            /*
            if(!"".equals(g_MuCd)){
            sbSql.append("	   AND C.MU_CD = '" + g_MuCd + "'   																			 \n");
            }
            if(!"".equals(g_TmCd)){
            sbSql.append("	   AND C.TM_CD = '" + g_TmCd + "'   																			 \n");
            }
            if(!"".equals(g_Upjang)){
            sbSql.append("	   AND C.UPJANG = " + g_Upjang + " 																				 \n");
            }
            */
            sbSql.append("	        GROUP BY C.UPJANGNM, C.UPJANG, SUBSTR(A.TRANS_DATE, 1, 4), C.MU_CD, C.TM_CD, SUBSTR(A.TRANS_DATE, 5, 2)    \n");
            sbSql.append("       ) X                                                                                                        \n");
            sbSql.append("   GROUP BY X.UPJANGNM                                                                                            \n");
            sbSql.append("          , X.UPJANG                                                                                              \n");
            sbSql.append("          , X.YY                                                                                                  \n");
            sbSql.append("          , X.CLASS                                                                                               \n");
            sbSql.append("          , X.MU_CD                                                                                               \n");
            sbSql.append("          , X.TM_CD                                                                                               \n");
            sbSql.append("	 ORDER BY X.UPJANGNM														                                	\n");
        }

        //out_vl.add("fa_Sql", sbSql.toString());
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