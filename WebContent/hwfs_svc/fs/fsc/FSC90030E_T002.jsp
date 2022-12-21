<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 메뉴관리/위생관리
■ 프로그램ID   : FSC00020E_T001.jsp
■ 프로그램명   : 정검결과등록 - 정검결과정보조회
■ 작성일자     : 2008-03-20
■ 작성자       : 박지영
■ 이력관리     : 2008-03-18 최초작성
              : 박은규 2009-01-14 CSR#(23819) 요청자:이명희(건강관리센터)
                법규관리지적 = 부적합지적건합계 + 중점관리 지적건 합계로 변경
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

        String strTableType		= nullToBlank(ds_input.getString(0, "TABLE_TYPE"));
          String strFormCD 		= nullToBlank(ds_input.getString(0, "FORM_CD"));
        String strUpjang 		= nullToBlank(ds_input.getString(0, "MST_UPJANG"));
        String strCheckDate 	= nullToBlank(ds_input.getString(0, "CHECK_DATE"));


        //out 데이타
        DataSet ds_list;

        //sql문 버퍼생성
        StringBuffer sbSql = new StringBuffer();

        // 정검양식조회
        sbSql.delete(0, sbSql.length());
        sbSql.append("SELECT A.TABLE_TYPE \n");
        sbSql.append("     , A.FORM_CD \n");
        sbSql.append("     , A.UPJANG \n");
        sbSql.append("     , (SELECT UPJANGNM FROM HLDC_ST_UPJANG WHERE A.UPJANG = UPJANG) AS UPJANGNM \n");
        sbSql.append("     , A.CHECK_DATE \n");
        sbSql.append("     , A.CHECK_TYPE \n");
        sbSql.append("     , (SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0042' AND A.CHECK_TYPE = CODE) AS CHECK_TYPE_NM \n");
        sbSql.append("     , A.LEAD_CHECK_TYPE \n");
        sbSql.append("     , (SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0043' AND A.LEAD_CHECK_TYPE = CODE) AS LEAD_CHECK_TYPE_NM \n");
        sbSql.append("     , A.CHECK_SABUN \n");
        sbSql.append("     , (SELECT NM_KOR FROM SCO_FS_HR_PERSONAL_V WHERE A.CHECK_SABUN = SABUN) AS CHECK_SABUN_NM \n");
        sbSql.append("     , A.CHECK_DATE || A.CHECK_START_TIME || '00' AS CHECK_START_TIME \n");
        sbSql.append("     , A.CHECK_DATE || A.CHECK_END_TIME || '00' AS CHECK_END_TIME \n");
        sbSql.append("     , A.RPT_DATE \n");
        sbSql.append("     , A.THEME_MGMT \n");
        sbSql.append("     , A.REMARK \n");
        sbSql.append("     , A.TM_CD \n");
        sbSql.append("     , (SELECT DISTINCT TM_NM FROM HLDC_SC_DEPT_V WHERE A.TM_CD = TM_CD) AS TM_NM \n");
        sbSql.append("     , A.TEAM_MST_SABUN \n");
        sbSql.append("     , (SELECT NM_KOR FROM HLDC_HR_PERSONAL WHERE SABUN =  A.TEAM_MST_SABUN) AS TEAM_MST_NM \n");
        sbSql.append("     , A.SUBTEAM_MST_SABUN \n");
        sbSql.append("     , (SELECT NM_KOR FROM HLDC_HR_PERSONAL WHERE SABUN =  A.SUBTEAM_MST_SABUN) AS SUBTEAM_MST_NM \n");
        sbSql.append("     , A.LEADER_SABUN \n");
        sbSql.append("     , (SELECT NM_KOR FROM HLDC_HR_PERSONAL WHERE SABUN =  A.LEADER_SABUN) AS LEADER_NM \n");
        sbSql.append("     , A.CHARGE_SABUN \n");
        sbSql.append("     , (SELECT NM_KOR FROM HLDC_HR_PERSONAL WHERE SABUN =  A.CHARGE_SABUN) AS CHARGE_NM \n");
        sbSql.append("     , A.KUNSOK \n");
        sbSql.append("     , A.WATER_IRRIGATION \n");
        sbSql.append("     , A.OPEN_DATE \n");
        sbSql.append("     , A.PERMISSION_TYPE \n");
        sbSql.append("     , A.PERSON_CNT \n");
        sbSql.append("     , A.DIST_TYPE \n");
        sbSql.append("     , A.AVG_MEAL_QTY \n");
        sbSql.append("     , A.MEAL_CNT \n");
        sbSql.append("     , A.MENU_CNT \n");
        sbSql.append("     , A.SPECIAL_FACT \n");
        sbSql.append("     , ROUND(A.SCORE, 1) AS SCORE \n");
        //sbSql.append("     , A.NOT_FIT_TOT_CNT \n");
//============================================================================================
//(2009-01-14 수정) 시작
// 박은규 2009-01-14 CSR#(23819) 요청자:이명희(건강관리센터)
// 법규관리지적 = 부적합지적건합계 + 중점관리 지적건 합계로 변경
//============================================================================================
        sbSql.append("     , FSC_GETLAWCNT_FUN(A.TABLE_TYPE,A.FORM_CD,A.UPJANG,A.CHECK_DATE) AS NOT_FIT_TOT_CNT \n");
//============================================================================================
//(2009-01-14 수정) 끝
//============================================================================================
        sbSql.append("     , A.INDICATE_CNT \n");
        sbSql.append("     , A.CONFIRM_YN \n");
        sbSql.append("     , A.IMPROV_RPT_DATE \n");
        sbSql.append("     , A.NOT_FIT_YN \n");
        sbSql.append("     , A.ADD_REMARK \n");
        sbSql.append("     , NVL2(A.IMPROV_RPT_DATE,'Y','N') AS WRITE_YN \n");
        sbSql.append("  FROM FSC_SAFE_RESULT_MST A \n");
        sbSql.append(" WHERE A.TABLE_TYPE = '" + strTableType + "' \n");
        sbSql.append("   AND A.FORM_CD = '" + strFormCD + "' \n");
        sbSql.append("   AND A.UPJANG = " + strUpjang + " \n");
        sbSql.append("   AND A.CHECK_DATE = '" + strCheckDate + "' \n");


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