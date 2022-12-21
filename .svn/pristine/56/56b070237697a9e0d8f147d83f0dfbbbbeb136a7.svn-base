<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 메뉴관리/위생관리
■ 프로그램ID   : FSC00050V_T001.jsp
■ 프로그램명   : 점장별 점검결과 조회
■ 작성일자     : 2008-03-26
■ 작성자       : 박지영
■ 이력관리     : 2008-03-26 최초작성
              : 박은규 2009-01-14 CSR#(23819) 요청자:이명희(건강관리센터)
                전체점장 체크 시 다른 검색조건을 걸고 조회를 해도 조건이 적용되게 수정.
                : 박은규 2012-04-16 CSR#(SR201204_09204) 요청자:김희선(건강관리센터)
                특별점검 여부 추가 : 결과조회/출력에서 평균점수에서 제외
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
    try {
        PlatformRequest platformRequest = this.proc_input(request);
        in_vl = platformRequest.getData().getVariableList();
        in_dl = platformRequest.getData().getDataSetList();

        //jsp log 서비스 시작
        logger.startIndividualLog(in_vl.getString("titLogId"));

        //입력 데이타
        DataSet ds_input     = in_dl.get("ds_input");

        String strTableType			= nullToBlank(ds_input.getString(0, "TABLE_TYPE"));
        String strFromDt			= nullToBlank(ds_input.getString(0, "FROM_DT"));
        String strToDt 				= nullToBlank(ds_input.getString(0, "TO_DT"));
        String strCheckType			= nullToBlank(ds_input.getString(0, "CHECK_TYPE"));
        String strCheckAll			= nullToBlank(ds_input.getString(0, "CHECK_ALL"));
        String strTmCD				= nullToBlank(ds_input.getString(0, "TM_CD"));
        String strTeamMstSabun	    = nullToBlank(ds_input.getString(0, "TEAM_MST_SABUN"));
        String strSubteamMstSabun	= nullToBlank(ds_input.getString(0, "SUBTEAM_MST_SABUN"));
        String strChargeSabun		= nullToBlank(ds_input.getString(0, "CHARGE_SABUN"));
        String strRespSabun  		= nullToBlank(ds_input.getString(0, "RESP_SABUN"));
        String strNotFitYN			= nullToBlank(ds_input.getString(0, "NOT_FIT_YN"));
        String strFromNotFit		= nullToBlank(ds_input.getString(0, "FROM_NOT_FIT"));
        String strToNotFit			= nullToBlank(ds_input.getString(0, "TO_NOT_FIT"));
        String strFromCnt   		= nullToBlank(ds_input.getString(0, "FROM_CNT"));
        String strToCnt 			= nullToBlank(ds_input.getString(0, "TO_CNT"));

        //out 데이타
        DataSet ds_list;

        //sql문 버퍼생성
        StringBuffer sbSql = new StringBuffer();

        sbSql.delete(0, sbSql.length());
        sbSql.append("SELECT CHARGE_SABUN                                                                        \n");
        sbSql.append("     , CHARGE_NM                                                                           \n");
        sbSql.append("     , CHECK_DATE                                                                          \n");
        sbSql.append("     , CNT                                                                                 \n");
        sbSql.append("     , SCORE                                                                               \n");
        sbSql.append("     , TOT_SCORE                                                                           \n");
        sbSql.append("     , AVG_CNT                                                                             \n");
        sbSql.append("     , NOT_FIT                                                                             \n");
        sbSql.append("     , GRADE                                                                               \n");
        sbSql.append("  FROM (                                                                                   \n");
        sbSql.append("        SELECT X.CHARGE_SABUN                                                                      \n");
        sbSql.append("             , (SELECT NM_KOR FROM HLDC_HR_PERSONAL WHERE SABUN = X.CHARGE_SABUN) AS CHARGE_NM     \n");
        sbSql.append("             , SUBSTR(A.CHECK_DATE, 1, 6) AS CHECK_DATE                                            \n");
        sbSql.append("             , SUM(A.CHK_CNT) AS CNT                                                               \n");
        sbSql.append("             , ROUND(AVG(DECODE(A.SET1,'Y',NULL, FSC_GETPATROL_AVG_FUN(A.TABLE_TYPE, A.UPJANG, SUBSTR(A.CHECK_DATE,1,6) || '01', SUBSTR(A.CHECK_DATE,1,6) || '31') )),1) AS SCORE \n"); 
        sbSql.append("             , SUM(DECODE(A.SET1,'Y', 0, FSC_GETPATROL_FUN(A.TABLE_TYPE, A.FORM_CD, A.UPJANG, A.CHECK_DATE, 'Y') )) AS TOT_SCORE \n");
        sbSql.append("             , SUM(A.AVG_CNT) AS AVG_CNT                                                           \n");
        sbSql.append("             , SUM(A.NOT_FIT_YN) AS NOT_FIT                                                        \n");
        sbSql.append("             , CASE WHEN DECODE(SUM(A.AVG_CNT), 0, 0, ROUND(SUM(A.SCORE) / SUM(A.AVG_CNT), 1)) >= 90 THEN 'A'              \n");
        sbSql.append("        	          WHEN DECODE(SUM(A.AVG_CNT), 0, 0, ROUND(SUM(A.SCORE) / SUM(A.AVG_CNT), 1)) >= 80 THEN 'B'              \n");
        sbSql.append("        	          WHEN DECODE(SUM(A.AVG_CNT), 0, 0, ROUND(SUM(A.SCORE) / SUM(A.AVG_CNT), 1)) >= 70 THEN 'C'              \n");
        sbSql.append("        		      WHEN DECODE(SUM(A.AVG_CNT), 0, 0, ROUND(SUM(A.SCORE) / SUM(A.AVG_CNT), 1)) >= 60 THEN 'D'              \n");
        sbSql.append("        	          ELSE 'E'                                                                       \n");
        sbSql.append("        	     END GRADE                                                                           \n");
        sbSql.append("         FROM (                                                                                    \n");
        sbSql.append("               SELECT A.CHARGE_SABUN                                                               \n");
        sbSql.append("                 FROM SCO_UPJANG_MST_V A                                                           \n");
        sbSql.append("                WHERE 1 = 1                                                                        \n");
        
        // 운영부서
        if(!strTmCD.equals("")) {
            sbSql.append("               AND A.TM_CD = '" + strTmCD + "'                                             \n");        	
        }
        
        // 대팀장
        if(!strTeamMstSabun.equals("")) {
            sbSql.append("               AND A.TEAM_MST_SABUN = '" + strTeamMstSabun + "'                            \n");        	
        }

        // 소팀장
        if(!strSubteamMstSabun.equals("")) {
            sbSql.append("               AND A.SUBTEAM_MST_SABUN = '" + strSubteamMstSabun + "'                      \n");        	
        }

        // 점장
        if(!strChargeSabun.equals("")) {
            sbSql.append("               AND A.CHARGE_SABUN = '" + strChargeSabun + "'                               \n");        	
        }
        
   		sbSql.append("                GROUP BY A.CHARGE_SABUN                                                            \n");
   		sbSql.append("               ) X                                                                                 \n");
   		sbSql.append("             , (                                                                                   \n");
        sbSql.append("                SELECT A.CHARGE_SABUN                                                              \n");
        sbSql.append("                     , A.CHECK_DATE                                                                \n");
        sbSql.append("                     , 1 AS CHK_CNT                                                                \n");
        sbSql.append("                     , CASE WHEN C.SET1 = 'Y' THEN 0 ELSE 1 END AS AVG_CNT                         \n");        
        sbSql.append("                     , CASE WHEN C.SET1 = 'Y' THEN 0 ELSE A.SCORE END AS SCORE                     \n");
        sbSql.append("                     , A.NOT_FIT_YN                                                                \n");
        sbSql.append("                     , C.SET1                                                                      \n");
        sbSql.append("                     , A.TABLE_TYPE                                                                \n");
        sbSql.append("                     , A.UPJANG                                                                    \n");
        sbSql.append("                     , A.FORM_CD                                                                   \n");
        sbSql.append("                  FROM FSC_RESULT_MST A                                                            \n");
        sbSql.append("                     , SCO_UPJANG_MST_V B                                                          \n");
        sbSql.append("                     , SCC_COMMON_CODE C                                                           \n");
        sbSql.append("                 WHERE A.CONFIRM_YN = 'Y'                                                          \n");
        
		if(strTableType.length() != 0) {
			sbSql.append("               AND TABLE_TYPE = '" + strTableType + "'                                         \n");
		}
        
        sbSql.append("                   AND A.CHECK_DATE BETWEEN '" + strFromDt + "' AND '" + strToDt + "'              \n");
        sbSql.append("                   AND A.CHECK_TYPE IN (" + strCheckType + ")                                      \n");
        sbSql.append("                   AND A.UPJANG = B.UPJANG                                                         \n");
        sbSql.append("                   AND C.GROUP_CODE = 'FS0042'                                                     \n");
        sbSql.append("                   AND A.CHECK_TYPE = C.CODE                                                       \n");

        // 운영부서
        if(!strTmCD.equals("")) {
            sbSql.append("               AND A.TM_CD = '" + strTmCD + "'                                             \n");        	
        }
        
        // 대팀장
        if(!strTeamMstSabun.equals("")) {
            sbSql.append("               AND A.TEAM_MST_SABUN = '" + strTeamMstSabun + "'                            \n");        	
        }

        // 소팀장
        if(!strSubteamMstSabun.equals("")) {
            sbSql.append("               AND A.SUBTEAM_MST_SABUN = '" + strSubteamMstSabun + "'                      \n");        	
        }

        // 점장
        if(!strChargeSabun.equals("")) {
            sbSql.append("               AND A.CHARGE_SABUN = '" + strChargeSabun + "'                               \n");        	
        }

        // 책임자
        if(!strRespSabun.equals("")) {
            sbSql.append("               AND A.RESP_SABUN1 || '-' || A.RESP_SABUN2 || '-' || A.RESP_SABUN3 LIKE '%" + strRespSabun + "%'    \n");        	
        }
        
        sbSql.append("               ) A                                                                              \n");
        sbSql.append("           WHERE X.CHARGE_SABUN = A.CHARGE_SABUN(+)                                             \n");
        if(!strCheckAll.equals("Y")) {
        	sbSql.append("         AND A.CHARGE_SABUN IS NOT NULL \n");
        }
        sbSql.append("         GROUP BY X.CHARGE_SABUN, SUBSTR(A.CHECK_DATE, 1, 6))                                   \n");
        sbSql.append(" WHERE 1 = 1                                                                                    \n");
		if (strFromNotFit.length() != 0)	sbSql.append("                    AND NOT_FIT >= " + strFromNotFit + "    \n");
		if (strToNotFit.length() != 0)		sbSql.append("                    AND NOT_FIT <= " + strToNotFit + "      \n");
		if (strFromCnt.length() != 0)		sbSql.append("                    AND CNT >= " + strFromCnt + "           \n");
		if (strToCnt.length() != 0)			sbSql.append("                    AND CNT <= " + strToCnt + "             \n");
        
        pstmt = conn.prepareStatement(sbSql.toString());
        rs = pstmt.executeQuery();
        ds_list = this.makeDataSet(rs, "ds_list");

        rs.close();
        pstmt.close();

        /**종료**/
        out_dl.add(ds_list);
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