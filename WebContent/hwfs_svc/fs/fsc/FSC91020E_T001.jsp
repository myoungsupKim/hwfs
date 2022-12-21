<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 위생관리/신규테스트관리
■ 프로그램ID   : FSC92020E_T001.jsp
■ 프로그램명   : 신규테스트관리
■ 작성일자     : 2019-07-08
■ 작성자       : 김명섭
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

        String strUpjang 		= nullToBlank(ds_input.getString(0, "UPJANG"));
        String strFromDt		= nullToBlank(ds_input.getString(0, "FROM_DT"));
        String strToDt 			= nullToBlank(ds_input.getString(0, "TO_DT"));

        //out 데이타
        DataSet ds_list;

        //sql문 버퍼생성
        StringBuffer sbSql = new StringBuffer();

        // 정검양식조회
        sbSql.delete(0, sbSql.length());
        sbSql.append("SELECT A.TEST_TYPE \n");
        sbSql.append("     , A.FORM_CD \n");
        sbSql.append("     , B.FORM_NAME \n");
        sbSql.append("     , A.UPJANG \n");
        sbSql.append("     , (SELECT UPJANGNM FROM ST_UPJANG WHERE A.UPJANG = UPJANG) AS UPJANGNM \n");
        sbSql.append("     , A.BIRTHDAY \n");
        sbSql.append("     , A.TRAINEE \n");
        sbSql.append("     , A.TEST_DATE \n");
        sbSql.append("     , A.STATUS \n");
        sbSql.append("     , A.TM_CD \n");
        sbSql.append("     , (SELECT TM_NM FROM HLDC_SC_DEPT_V WHERE A.TM_CD = TM_CD AND ROWNUM = 1) AS TM_NM \n");
        sbSql.append("     , DECODE(A.STATUS,'10','등록','20','동영상교육','30','테스트','90','완료','') AS STATUSNM \n");
        sbSql.append("     , A.CHARGE_SABUN \n");
        sbSql.append("     , (SELECT NM_KOR FROM SCO_FS_HR_PERSONAL_V WHERE A.CHARGE_SABUN = SABUN) AS CHARGE_NM \n");
        sbSql.append("     , (SELECT NM_KOR FROM SCO_FS_HR_PERSONAL_V WHERE A.UUSER = SABUN) AS UUSER \n");
        sbSql.append("     , A.COMPLETEYN \n");
        sbSql.append("     , A.SCORE \n");
        sbSql.append("     , B.ATTR01 AS URL_LINK \n");
        sbSql.append("     , B.ATTR02 AS TIME_LIMIT \n");
        sbSql.append("  FROM FSC_TEST_RESULT_MST A \n");
        sbSql.append("     , FSC_TEST_FORM_MST B \n");
        sbSql.append(" WHERE A.TEST_TYPE = B.TEST_TYPE \n");
        sbSql.append("   AND A.FORM_CD = B.FORM_CD \n");
        sbSql.append("   AND A.TEST_DATE BETWEEN '" + strFromDt + "' AND '" + strToDt + "' \n");
        sbSql.append("   AND A.UPJANG LIKE '" + strUpjang + "'||'%' \n");
        sbSql.append(" ORDER BY A.TEST_DATE DESC, A.TEST_TYPE, A.FORM_CD \n");

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