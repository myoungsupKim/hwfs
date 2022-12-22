<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 테스트정답조회
■ 프로그램ID   : FSC91021P_T001.jsp
■ 프로그램명   : 신규테스트관리
■ 작성일자     : 2019-09-03
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
        DataSet ds_list;

        //sql문 버퍼생성
        StringBuffer sbSql = new StringBuffer();

        //조회
        sbSql.delete(0, sbSql.length());
        sbSql.append(" SELECT T1.SEQNO, \n");
        sbSql.append("        T3.TEST, \n");
        sbSql.append("        T3.EXAMPLE1, \n");
        sbSql.append("        T3.EXAMPLE2, \n");
        sbSql.append("        T3.EXAMPLE3, \n");
        sbSql.append("        T3.EXAMPLE4, \n");
        sbSql.append("        CASE WHEN T3.EXAMPLE1 IS NULL AND T3.EXAMPLE2 IS NULL AND T3.EXAMPLE3 IS NULL AND T3.EXAMPLE4 IS NULL THEN '주관식' ELSE '객관식' END AS TEST_CASE, \n");
        sbSql.append("        T3.ANSWER, \n");
        sbSql.append("        T3.DISTRIBUTION, \n");
        sbSql.append("        T1.ATTR01 AS RESULT, \n");
        sbSql.append("        CASE WHEN T3.ANSWER = T1.ATTR01 THEN '0' ELSE 'X' END AS RESULT_OX, \n");
        sbSql.append("        CASE WHEN T3.ANSWER = T1.ATTR01 THEN T3.DISTRIBUTION ELSE 0 END AS RESULT_SCR \n");
        sbSql.append("   FROM FSC_TEST_RESULT_DTL T1, \n");
        sbSql.append("        FSC_TEST_RESULT_MST T2, \n");
        sbSql.append("        FSC_TEST_FORM_DTL   T3 \n");
        sbSql.append("  WHERE T1.upjang = '" + strUpjang + "' \n");
        sbSql.append("    AND T1.TRAINEE = '" + strTrainee + "' \n");
        sbSql.append("    AND T1.TEST_DATE = '" + strTestDate + "' \n");
        sbSql.append("    AND T1.STATUS = '30' \n");
        sbSql.append("    AND T1.UPJANG = T2.UPJANG \n");
        sbSql.append("    AND T1.TRAINEE = T2.TRAINEE \n");
        sbSql.append("    AND T1.TEST_DATE = T2.TEST_DATE \n");
        sbSql.append("    AND T2.TEST_TYPE = T3.TEST_TYPE \n");
        sbSql.append("    AND T2.FORM_CD = T3.FORM_CD \n");
        sbSql.append("    AND T1.SEQNO = T3.SEQ \n");
        sbSql.append(" ORDER BY T1.SEQNO \n");
        
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