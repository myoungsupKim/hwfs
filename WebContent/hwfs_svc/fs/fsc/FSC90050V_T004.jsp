<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 메뉴관리/위생관리
■ 프로그램ID   : FSC00060V_T001.jsp
■ 프로그램명   : 점검자별 점검결과 조회
■ 작성일자     : 2008-03-26
■ 작성자       : 박지영
■ 이력관리     : 2008-03-26
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
        String strTmCD				= nullToBlank(ds_input.getString(0, "TM_CD"));
        String strTeamMstSabun	    = nullToBlank(ds_input.getString(0, "TEAM_MST_SABUN"));
        String strSubteamMstSabun	= nullToBlank(ds_input.getString(0, "SUBTEAM_MST_SABUN"));
        String strChargeSabun		= nullToBlank(in_vl.getString("CHARGE_SABUN"));
        String strRespSabun		    = nullToBlank(ds_input.getString(0, "RESP_SABUN"));

        //out 데이타
        DataSet ds_list;

        //sql문 버퍼생성
        StringBuffer sbSql = new StringBuffer();

        sbSql.delete(0, sbSql.length());

        sbSql.append("SELECT A.* \n");
        sbSql.append("     , CASE WHEN SCORE >= 90 THEN 'A' \n");
        sbSql.append("	          WHEN SCORE >= 80 THEN 'B' \n");
        sbSql.append("	          WHEN SCORE >= 70 THEN 'C' \n");
        sbSql.append("		      WHEN SCORE >= 60 THEN 'D' \n");
        sbSql.append("	          ELSE 'E' \n");
        sbSql.append("	     END GRADE \n");
        sbSql.append("  FROM ( \n");
        sbSql.append("        SELECT A.CHARGE_SABUN \n");
        sbSql.append("            , (SELECT NM_KOR FROM HLDC_HR_PERSONAL WHERE SABUN = A.CHARGE_SABUN) AS CHARGE_NM \n");
        sbSql.append("            , UPJANG \n");
        sbSql.append("            , (SELECT UPJANGNM FROM HLDC_ST_UPJANG WHERE A.UPJANG = UPJANG) AS UPJANGNM \n");
        sbSql.append("            , CHECK_DATE \n");
        sbSql.append("            , ROUND(FSC_GETPATROL_FUN(A.TABLE_TYPE, A.FORM_CD, A.UPJANG, A.CHECK_DATE), 1) AS SCORE \n");
        sbSql.append("            , 0 NOT_FIT \n");
        sbSql.append("         FROM FSC_SAFE_RESULT_MST A \n");
        sbSql.append("        WHERE CONFIRM_YN = 'Y' \n");
        
        // 운영부서
        if(!strTmCD.equals("")) {
            sbSql.append("           AND A.TM_CD = '" + strTmCD + "'                                             \n");        	
        }
        
        // 대팀장
        if(!strTeamMstSabun.equals("")) {
            sbSql.append("           AND A.TEAM_MST_SABUN = '" + strTeamMstSabun + "'                            \n");        	
        }

        // 소팀장
        if(!strSubteamMstSabun.equals("")) {
            sbSql.append("           AND A.SUBTEAM_MST_SABUN = '" + strSubteamMstSabun + "'                      \n");        	
        }

        // 점장
        if(!strChargeSabun.equals("")) {
            sbSql.append("           AND A.CHARGE_SABUN = '" + strChargeSabun + "'                               \n");        	
        }

        // 책임자
        if(!strRespSabun.equals("")) {
            sbSql.append("           AND A.RESP1_SABUN || '-' || A.RESP2_SABUN || '-' || A.RESP3_SABUN LIKE '%" + strRespSabun + "%'    \n");        	
        }
        
        if (strTableType.length() != 0)
            sbSql.append("      AND TABLE_TYPE = '" + strTableType + "' \n");
        sbSql.append("          AND CHECK_DATE BETWEEN '" + strFromDt + "' AND '" + strToDt + "' \n");
        sbSql.append("          AND CHECK_TYPE IN (" + strCheckType + ") \n");
        sbSql.append("      ) A \n");
        sbSql.append(" WHERE A.SCORE IS NOT NULL \n");
        sbSql.append(" ORDER BY UPJANG, CHECK_DATE \n");

        //System.out.println(sbSql.toString());
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