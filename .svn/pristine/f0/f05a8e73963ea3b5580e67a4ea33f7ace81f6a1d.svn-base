<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 위생관리/신규테스트관리
■ 프로그램ID   : FSC92020E_T005.jsp
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
        String strTrainee		= nullToBlank(ds_input.getString(0, "TRAINEE"));
        String strTestDate		= nullToBlank(ds_input.getString(0, "TEST_DATE"));

        //out 데이타
        DataSet ds_Detail;

        //sql문 버퍼생성
        StringBuffer sbSql = new StringBuffer();

        // 정검양식조회
        sbSql.delete(0, sbSql.length());
        sbSql.append("SELECT A.UPJANG \n");
        sbSql.append("     , A.BIRTHDAY \n");
        sbSql.append("     , A.TRAINEE \n");
        sbSql.append("     , A.STATUS \n");
        sbSql.append("     , DECODE(A.STATUS,'10','등록','20','동영상교육','30','테스트','90','완료','') AS STATUSNM \n");
        sbSql.append("     , A.SEQNO \n");
        sbSql.append("     , TO_CHAR(TO_DATE(A.START_DT,'YYYYMMDDHH24MISS'),'YYYY-MM-DD HH24:MI:SS') AS START_DT \n");
        sbSql.append("     , TO_CHAR(TO_DATE(A.END_DT,'YYYYMMDDHH24MISS'),'YYYY-MM-DD HH24:MI:SS') AS END_DT \n");
        sbSql.append("     , A.ATTR01 AS ANSWER \n");
        sbSql.append("  FROM FSC_TEST_RESULT_DTL A \n");
        sbSql.append(" WHERE A.UPJANG = '" + strUpjang + "' \n");
        sbSql.append("   AND A.TRAINEE = '" + strTrainee + "' \n");
        sbSql.append("   AND A.TEST_DATE = '" + strTestDate + "' \n");
        sbSql.append(" ORDER BY A.STATUS, A.SEQNO \n");

        //System.out.println(sbSql.toString());
        pstmt = conn.prepareStatement(sbSql.toString());
        rs = pstmt.executeQuery();
        ds_Detail = this.makeDataSet(rs, "ds_Detail");

        rs.close();
        pstmt.close();

        /**종료**/
        out_dl.add(ds_Detail);
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