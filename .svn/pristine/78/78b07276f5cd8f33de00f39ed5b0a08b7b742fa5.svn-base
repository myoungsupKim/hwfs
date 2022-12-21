<%
    /*-----------------------------------------------------------------------------
    ■ 시스템명     : 사업계획관리
    ■ 프로그램ID   : MAP30090V_T001.jsp
    ■ 프로그램명   : 사업계획 최종PL조회
    ■ 작성일자     : 2015-10-20
    ■ 작성자       : 김태윤
    ■ 이력관리     :
  	  2018.04.20 김명섭 사업계획관리개선
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
        String g_sType = nullToBlank(in_vl.getString("g_sType"));

        //FileLog.println("d:\\aaa.txt", ds_Cond);

        //out 데이타
        DataSet ds_List;

        //sql문 버퍼생성
        StringBuffer sbSql = new StringBuffer();
        sbSql.delete(0, sbSql.length());
        
        //CC_CD조회
        String strCC_CD = "";
        sbSql.append("SELECT NVL(MAX(CC_CD),'%') isCCCD  								     \n");
        sbSql.append("  FROM MAC_UPJANG_V												     \n");
        sbSql.append(" WHERE UPJANG = '" + nullToBlank(ds_Cond.getString(0, "UPJANG"))  + "' \n");
        sbSql.append("   AND ROWNUM = 1                                          	 		 \n");
        pstmt = conn.prepareStatement(sbSql.toString());
        rs = pstmt.executeQuery();
        rs.next();
        strCC_CD = rs.getString("isCCCD");
        rs.close();
        
        sbSql.delete(0, sbSql.length());

        if( !g_sType.equals("4") )
        {
            sbSql.append("SELECT A. *                                                                                                                                       \n");
            sbSql.append("  FROM (                                                                                                                                          \n");
        }
        if( g_sType.equals("1") )
        {
            sbSql.append("        SELECT B.L_ACCT_NM AS L_ACCT_NM                                                                                                           \n");
        }
        else if( g_sType.equals("2") )
        {
            sbSql.append("        SELECT B.L_ACCT_NM AS L_ACCT_NM                                                                                                           \n");
            sbSql.append("             , B.M_ACCT_NM AS M_ACCT_NM                                                                                                           \n");
        	
        }
        else if( g_sType.equals("3") )
        {
            sbSql.append("        SELECT B.L_ACCT_NM AS L_ACCT_NM                                                                                                           \n");
            sbSql.append("             , B.M_ACCT_NM AS M_ACCT_NM                                                                                                           \n");
            sbSql.append("             , B.S_ACCT_NM AS S_ACCT_NM                                                                                                           \n");
        }
        else
        {
            sbSql.append("        SELECT B.L_ACCT_NM AS L_ACCT_NM                                                                                                           \n");
            sbSql.append("             , B.M_ACCT_NM AS M_ACCT_NM                                                                                                           \n");
            sbSql.append("             , B.S_ACCT_NM AS S_ACCT_NM                                                                                                           \n");
            sbSql.append("             , B.ACCT_NM AS ACCT_NM                                                                                                               \n");
            sbSql.append("             , B.ACCT_CD AS ACCT_CD                                                                                                               \n");
        }

        sbSql.append("             , '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "' AS PLAN_YEAR                                                               \n");
        sbSql.append("             , 'Y' AS CONFIRM_YN                                                                                                                  \n");

        // 절, 세, 세세절만 그룹키가 필요함.
        if(!g_sType.equals("1"))
        	sbSql.append("             , DECODE(B.M_ACCT_NM, '매출액', '1', '재료비', '2', '인건비', '3', '경비', '4') AS SKEY                                              \n");

        sbSql.append("             , SUM(A.MM_AMT_01) AS MM_AMT_01                                                                                                             \n");
        sbSql.append("             , SUM(A.MM_AMT_02) AS MM_AMT_02                                                                                                             \n");
        sbSql.append("             , SUM(A.MM_AMT_03) AS MM_AMT_03                                                                                                             \n");
        sbSql.append("             , SUM(A.MM_AMT_04) AS MM_AMT_04                                                                                                             \n");
        sbSql.append("             , SUM(A.MM_AMT_05) AS MM_AMT_05                                                                                                             \n");
        sbSql.append("             , SUM(A.MM_AMT_06) AS MM_AMT_06                                                                                                             \n");
        sbSql.append("             , SUM(A.MM_AMT_07) AS MM_AMT_07                                                                                                             \n");
        sbSql.append("             , SUM(A.MM_AMT_08) AS MM_AMT_08                                                                                                             \n");
        sbSql.append("             , SUM(A.MM_AMT_09) AS MM_AMT_09                                                                                                             \n");
        sbSql.append("             , SUM(A.MM_AMT_10) AS MM_AMT_10                                                                                                             \n");
        sbSql.append("             , SUM(A.MM_AMT_11) AS MM_AMT_11                                                                                                             \n");
        sbSql.append("             , SUM(A.MM_AMT_12) AS MM_AMT_12                                                                                                             \n");
        sbSql.append("             , SUM(MM_AMT_01+MM_AMT_02+MM_AMT_03+MM_AMT_04+MM_AMT_05+MM_AMT_06+MM_AMT_07+MM_AMT_08+MM_AMT_09+MM_AMT_10+MM_AMT_11+MM_AMT_12) AS SUM_AMT                                                                                                               \n");

        sbSql.append("        FROM (                                                                                                                                    \n");
        sbSql.append("                SELECT A.ACCT_CD AS ACCT_CD                                                                                                       \n");
        // 관리금액
        if( "M".equals(ds_Cond.getString(0, "CLOSE_TYPE")) )
        {
        	sbSql.append("                     , CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN NVL(ROUND(A.MM_AMT_01 * NVL(((SELECT MM_MARGIN_RATE_01 FROM MAC_UPJANG_V T1, MAP_MARGIN_RATE_MGMT T2 WHERE T1.CC_CD = A.CC_CD AND T1.UPJANG = T2.UPJANG AND T2.YY = A.PLAN_YEAR AND T2.CLASS = 'P' AND ROWNUM = 1) / 100), 1) / 1000), 0)   \n");
            sbSql.append("                       ELSE NVL(ROUND(A.MM_AMT_01 / 1000), 0)                                                                                                                                                                                                                                                         \n");
            sbSql.append("                       END MM_AMT_01                                                                                                                                                                                                                                                                                  \n");
            sbSql.append("                     , CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN NVL(ROUND(A.MM_AMT_02 * NVL(((SELECT MM_MARGIN_RATE_02 FROM MAC_UPJANG_V T1, MAP_MARGIN_RATE_MGMT T2 WHERE T1.CC_CD = A.CC_CD AND T1.UPJANG = T2.UPJANG AND T2.YY = A.PLAN_YEAR AND T2.CLASS = 'P' AND ROWNUM = 1) / 100), 1) / 1000), 0)   \n");
            sbSql.append("                       ELSE NVL(ROUND(A.MM_AMT_02 / 1000), 0)                                                                                                                                                                                                                                                         \n");
            sbSql.append("                       END MM_AMT_02                                                                                                                                                                                                                                                                                  \n");
            sbSql.append("                     , CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN NVL(ROUND(A.MM_AMT_03 * NVL(((SELECT MM_MARGIN_RATE_03 FROM MAC_UPJANG_V T1, MAP_MARGIN_RATE_MGMT T2 WHERE T1.CC_CD = A.CC_CD AND T1.UPJANG = T2.UPJANG AND T2.YY = A.PLAN_YEAR AND T2.CLASS = 'P' AND ROWNUM = 1) / 100), 1) / 1000), 0)   \n");
            sbSql.append("                       ELSE NVL(ROUND(A.MM_AMT_03 / 1000), 0)                                                                                                                                                                                                                                                         \n");
            sbSql.append("                       END MM_AMT_03                                                                                                                                                                                                                                                                                  \n");
            sbSql.append("                     , CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN NVL(ROUND(A.MM_AMT_04 * NVL(((SELECT MM_MARGIN_RATE_04 FROM MAC_UPJANG_V T1, MAP_MARGIN_RATE_MGMT T2 WHERE T1.CC_CD = A.CC_CD AND T1.UPJANG = T2.UPJANG AND T2.YY = A.PLAN_YEAR AND T2.CLASS = 'P' AND ROWNUM = 1) / 100), 1) / 1000), 0)   \n");
            sbSql.append("                       ELSE NVL(ROUND(A.MM_AMT_04 / 1000), 0)                                                                                                                                                                                                                                                         \n");
            sbSql.append("                       END MM_AMT_04                                                                                                                                                                                                                                                                                  \n");
            sbSql.append("                     , CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN NVL(ROUND(A.MM_AMT_05 * NVL(((SELECT MM_MARGIN_RATE_05 FROM MAC_UPJANG_V T1, MAP_MARGIN_RATE_MGMT T2 WHERE T1.CC_CD = A.CC_CD AND T1.UPJANG = T2.UPJANG AND T2.YY = A.PLAN_YEAR AND T2.CLASS = 'P' AND ROWNUM = 1) / 100), 1) / 1000), 0)   \n");
            sbSql.append("                       ELSE NVL(ROUND(A.MM_AMT_05 / 1000), 0)                                                                                                                                                                                                                                                         \n");
            sbSql.append("                       END MM_AMT_05                                                                                                                                                                                                                                                                                  \n");
            sbSql.append("                     , CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN NVL(ROUND(A.MM_AMT_06 * NVL(((SELECT MM_MARGIN_RATE_06 FROM MAC_UPJANG_V T1, MAP_MARGIN_RATE_MGMT T2 WHERE T1.CC_CD = A.CC_CD AND T1.UPJANG = T2.UPJANG AND T2.YY = A.PLAN_YEAR AND T2.CLASS = 'P' AND ROWNUM = 1) / 100), 1) / 1000), 0)   \n");
            sbSql.append("                       ELSE NVL(ROUND(A.MM_AMT_06 / 1000), 0)                                                                                                                                                                                                                                                         \n");
            sbSql.append("                       END MM_AMT_06                                                                                                                                                                                                                                                                                  \n");
            sbSql.append("                     , CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN NVL(ROUND(A.MM_AMT_07 * NVL(((SELECT MM_MARGIN_RATE_07 FROM MAC_UPJANG_V T1, MAP_MARGIN_RATE_MGMT T2 WHERE T1.CC_CD = A.CC_CD AND T1.UPJANG = T2.UPJANG AND T2.YY = A.PLAN_YEAR AND T2.CLASS = 'P' AND ROWNUM = 1) / 100), 1) / 1000), 0)   \n");
            sbSql.append("                       ELSE NVL(ROUND(A.MM_AMT_07 / 1000), 0)                                                                                                                                                                                                                                                         \n");
            sbSql.append("                       END MM_AMT_07                                                                                                                                                                                                                                                                                  \n");
            sbSql.append("                     , CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN NVL(ROUND(A.MM_AMT_08 * NVL(((SELECT MM_MARGIN_RATE_08 FROM MAC_UPJANG_V T1, MAP_MARGIN_RATE_MGMT T2 WHERE T1.CC_CD = A.CC_CD AND T1.UPJANG = T2.UPJANG AND T2.YY = A.PLAN_YEAR AND T2.CLASS = 'P' AND ROWNUM = 1) / 100), 1) / 1000), 0)   \n");
            sbSql.append("                       ELSE NVL(ROUND(A.MM_AMT_08 / 1000), 0)                                                                                                                                                                                                                                                         \n");
            sbSql.append("                       END MM_AMT_08                                                                                                                                                                                                                                                                                  \n");
            sbSql.append("                     , CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN NVL(ROUND(A.MM_AMT_09 * NVL(((SELECT MM_MARGIN_RATE_09 FROM MAC_UPJANG_V T1, MAP_MARGIN_RATE_MGMT T2 WHERE T1.CC_CD = A.CC_CD AND T1.UPJANG = T2.UPJANG AND T2.YY = A.PLAN_YEAR AND T2.CLASS = 'P' AND ROWNUM = 1) / 100), 1) / 1000), 0)   \n");
            sbSql.append("                       ELSE NVL(ROUND(A.MM_AMT_09 / 1000), 0)                                                                                                                                                                                                                                                         \n");
            sbSql.append("                       END MM_AMT_09                                                                                                                                                                                                                                                                                  \n");
            sbSql.append("                     , CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN NVL(ROUND(A.MM_AMT_10 * NVL(((SELECT MM_MARGIN_RATE_10 FROM MAC_UPJANG_V T1, MAP_MARGIN_RATE_MGMT T2 WHERE T1.CC_CD = A.CC_CD AND T1.UPJANG = T2.UPJANG AND T2.YY = A.PLAN_YEAR AND T2.CLASS = 'P' AND ROWNUM = 1) / 100), 1) / 1000), 0)   \n");
            sbSql.append("                       ELSE NVL(ROUND(A.MM_AMT_10 / 1000), 0)                                                                                                                                                                                                                                                         \n");
            sbSql.append("                       END MM_AMT_10                                                                                                                                                                                                                                                                                  \n");
            sbSql.append("                     , CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN NVL(ROUND(A.MM_AMT_11 * NVL(((SELECT MM_MARGIN_RATE_11 FROM MAC_UPJANG_V T1, MAP_MARGIN_RATE_MGMT T2 WHERE T1.CC_CD = A.CC_CD AND T1.UPJANG = T2.UPJANG AND T2.YY = A.PLAN_YEAR AND T2.CLASS = 'P' AND ROWNUM = 1) / 100), 1) / 1000), 0)   \n");
            sbSql.append("                       ELSE NVL(ROUND(A.MM_AMT_11 / 1000), 0)                                                                                                                                                                                                                                                         \n");
            sbSql.append("                       END MM_AMT_11                                                                                                                                                                                                                                                                                  \n");
            sbSql.append("                     , CASE WHEN SUBSTR(A.ACCT_CD,1,5) = '42203' THEN NVL(ROUND(A.MM_AMT_12 * NVL(((SELECT MM_MARGIN_RATE_12 FROM MAC_UPJANG_V T1, MAP_MARGIN_RATE_MGMT T2 WHERE T1.CC_CD = A.CC_CD AND T1.UPJANG = T2.UPJANG AND T2.YY = A.PLAN_YEAR AND T2.CLASS = 'P' AND ROWNUM = 1) / 100), 1) / 1000), 0)   \n");
            sbSql.append("                       ELSE NVL(ROUND(A.MM_AMT_12 / 1000), 0)                                                                                                                                                                                                                                                         \n");
            sbSql.append("                       END MM_AMT_12                                                                                                                                                                                                                                                                                  \n");
        }
        // 재무금액
        else
        {
        	sbSql.append("                     , ROUND(A.MM_AMT_01/1000) AS MM_AMT_01                                                                                       \n");
        	sbSql.append("                     , ROUND(A.MM_AMT_02/1000) AS MM_AMT_02                                                                                       \n");
        	sbSql.append("                     , ROUND(A.MM_AMT_03/1000) AS MM_AMT_03                                                                                       \n");
        	sbSql.append("                     , ROUND(A.MM_AMT_04/1000) AS MM_AMT_04                                                                                       \n");
        	sbSql.append("                     , ROUND(A.MM_AMT_05/1000) AS MM_AMT_05                                                                                       \n");
        	sbSql.append("                     , ROUND(A.MM_AMT_06/1000) AS MM_AMT_06                                                                                       \n");
        	sbSql.append("                     , ROUND(A.MM_AMT_07/1000) AS MM_AMT_07                                                                                       \n");
        	sbSql.append("                     , ROUND(A.MM_AMT_08/1000) AS MM_AMT_08                                                                                       \n");
        	sbSql.append("                     , ROUND(A.MM_AMT_09/1000) AS MM_AMT_09                                                                                       \n");
        	sbSql.append("                     , ROUND(A.MM_AMT_10/1000) AS MM_AMT_10                                                                                       \n");
        	sbSql.append("                     , ROUND(A.MM_AMT_11/1000) AS MM_AMT_11                                                                                       \n");
        	sbSql.append("                     , ROUND(A.MM_AMT_12/1000) AS MM_AMT_12                                                                                       \n");
        }
        sbSql.append("                  FROM MAP_BPC_CONFIRM_PL_INFO A                                                                                                  \n");
        //2018.03.05 김명섭 버젼정보 조건 추가
        sbSql.append("                 WHERE A.VER_CD = '" + nullToBlank(ds_Cond.getString(0, "VER_CD")) + "'                                                                                                   \n");
        //2018.03.05 김명섭 버젼정보 조건 추가
        sbSql.append("                   AND A.PLAN_CLASS = 'AP'                                                                                                     \n");
        sbSql.append("                   AND A.PLAN_YEAR = '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'                                                   \n");
        //2019.02.07 김명섭 팀/본부 조회 시 판관CC 제외
        //if( "".equals(nullToBlank(ds_Cond.getString(0, "UPJANG"))) )
        //{
        //	sbSql.append("  AND A.CC_CD NOT IN (SELECT CC_CD FROM SCC_CC WHERE CST_PLNKGVRN_CLASS_CD = 'SG')  \n");
        //}
        sbSql.append("                   AND A.CC_CD LIKE '" + strCC_CD + "'                                                   \n");
        sbSql.append("                   AND EXISTS (SELECT 'x' FROM MAC_UPJANG_V WHERE CC_CD = A.CC_CD AND TM_CD LIKE '" + nullToBlank(ds_Cond.getString(0, "TM_CD")) + "'||'%')                                                                                                   \n");

        sbSql.append("               ) A                                                                                                                                \n");
        sbSql.append("                     , (                                                                                                                          \n");
        sbSql.append("                        SELECT ACCTNM1 AS L_ACCT_NM                                                                                               \n");
        sbSql.append("                             , ACCTNM2 AS M_ACCT_NM                                                                                               \n");
        sbSql.append("                             , ACCTNM3 AS S_ACCT_NM                                                                                               \n");
        sbSql.append("                             , ACCTNM4 AS ACCT_NM                                                                                                 \n");
        sbSql.append("                             , ACCTCD AS ACCT_CD                                                                                                  \n");
        sbSql.append("                             , SEQ AS SEQ                                                                                                         \n");
        sbSql.append("                          FROM MAS_ST_ACCOUNT                                                                                                     \n");
        sbSql.append("                       ) B                                                                                                        \n");
        sbSql.append("               WHERE A.ACCT_CD(+) = B.ACCT_CD                                                                                                   \n");

        if( !g_sType.equals("4") )
		{
        	if( g_sType.equals("1") )
        		sbSql.append("         GROUP BY B.SEQ, B.L_ACCT_NM                                                                                                                     \n");
        	else if( g_sType.equals("2") )
        		sbSql.append("         GROUP BY B.SEQ, B.L_ACCT_NM, B.M_ACCT_NM                                                                                                        \n");
       		else if( g_sType.equals("3") )
       			sbSql.append("         GROUP BY B.SEQ, B.L_ACCT_NM, B.M_ACCT_NM, B.S_ACCT_NM                                                                                           \n");
       				
            
	        sbSql.append("       ) A                                                                                                                                        \n");

	        sbSql.append("	 , (                                                                                                                                            \n");

	        if( g_sType.equals("1") )
	        {
	        	sbSql.append("      SELECT MIN(SEQ) AS SEQ                                                                                                                      \n");
	        	sbSql.append("           , ACCTNM1 AS L_ACCT_NM                                                                                                                 \n");
		        sbSql.append("		  FROM MAS_ST_ACCOUNT                                                                                                                       \n");
		        sbSql.append("       GROUP BY ACCTNM1                                                                                                                           \n");	        	
	        }
	        else if( g_sType.equals("2") )
	        {
	        	sbSql.append("      SELECT MIN(SEQ) AS SEQ                                                                                                                      \n");
	        	sbSql.append("           , ACCTNM2 AS M_ACCT_NM                                                                                                                 \n");
		        sbSql.append("		  FROM MAS_ST_ACCOUNT                                                                                                                       \n");
		        sbSql.append("       GROUP BY ACCTNM2                                                                                                                           \n");
	        }
	        else if( g_sType.equals("3") )
	        {
	        	sbSql.append("      SELECT MIN(SEQ) AS SEQ                                                                                                                      \n");
	        	sbSql.append("           , ACCTNM3 AS S_ACCT_NM                                                                                                                 \n");
		        sbSql.append("		  FROM MAS_ST_ACCOUNT                                                                                                                       \n");
		        sbSql.append("       GROUP BY ACCTNM3                                                                                                                           \n");
	        }

	        sbSql.append("	   )B                                                                                                                                           \n");

	        if( g_sType.equals("1") )
	        {
	        	sbSql.append(" WHERE A.L_ACCT_NM = B.L_ACCT_NM                                                                                                                  \n");
	        }
	        else if( g_sType.equals("2") )
	        {
	        	sbSql.append(" WHERE A.M_ACCT_NM = B.M_ACCT_NM                                                                                                                  \n");
	        }
	        else if( g_sType.equals("3") )
	        {
	        	sbSql.append(" WHERE A.S_ACCT_NM = B.S_ACCT_NM                                                                                                                  \n");
	        }
	        sbSql.append(" ORDER BY B.SEQ                                                                                                                                   \n");
		}
        else
        {
   			sbSql.append("        GROUP BY B.SEQ, B.L_ACCT_NM, B.M_ACCT_NM, B.S_ACCT_NM, B.ACCT_NM, B.ACCT_CD                                                                                          \n");
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