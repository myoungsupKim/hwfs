<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 위생관리/신규테스트관리
■ 프로그램ID   : FSC92020E_T002.jsp
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
        DataSet ds_Master     = in_dl.get("ds_Master");

        String strTestType 		= nullToBlank(ds_Master.getString(0, "TEST_TYPE"));
        String strFormCd		= nullToBlank(ds_Master.getString(0, "FORM_CD"));

        //out 데이타
        DataSet ds_TEST_EXAM;

        //sql문 버퍼생성
        StringBuffer sbSql = new StringBuffer();

        // 정검양식조회
        sbSql.delete(0, sbSql.length());
        sbSql.append("SELECT A.TEST_TYPE \n");
        sbSql.append("     , A.FORM_CD \n");
        sbSql.append("     , A.SEQ \n");
        sbSql.append("     , (CASE WHEN A.SERVER_FILENM IS NOT NULL THEN '문제'||A.SEQ||'. '||'(배점 '||A.DISTRIBUTION||'점 / 이미지포함)'||CHR(13)||A.TEST \n");
        sbSql.append("        ELSE '문제'||A.SEQ||'. '||'(배점 '||A.DISTRIBUTION||'점)'||CHR(13)||A.TEST \n");
        sbSql.append("        END) AS TEST \n");
        sbSql.append("     , (CASE WHEN A.EXAMPLE1 IS NOT NULL THEN '①'||A.EXAMPLE1 END) AS EXAMPLE1 \n");
        sbSql.append("     , (CASE WHEN A.EXAMPLE2 IS NOT NULL THEN '②'||A.EXAMPLE2 END) AS EXAMPLE2 \n");
        sbSql.append("     , (CASE WHEN A.EXAMPLE3 IS NOT NULL THEN '③'||A.EXAMPLE3 END) AS EXAMPLE3 \n");
        sbSql.append("     , (CASE WHEN A.EXAMPLE4 IS NOT NULL THEN '④'||A.EXAMPLE4 END) AS EXAMPLE4 \n");
        sbSql.append("     , A.APPEND_FILENM \n");
        sbSql.append("     , A.SERVER_FILENM \n");
        sbSql.append("     , A.DISTRIBUTION \n");
        sbSql.append("     , A.ANSWER \n");
        sbSql.append("  FROM FSC_TEST_FORM_DTL A \n");
        sbSql.append(" WHERE A.TEST_TYPE = '" + strTestType + "' \n");
        sbSql.append("   AND A.FORM_CD = '" + strFormCd + "' \n");
        sbSql.append(" ORDER BY A.SEQ \n");

        //System.out.println(sbSql.toString());
        pstmt = conn.prepareStatement(sbSql.toString());
        rs = pstmt.executeQuery();
        ds_TEST_EXAM = this.makeDataSet(rs, "ds_TEST_EXAM");

        rs.close();
        pstmt.close();

        /**종료**/
        out_dl.add(ds_TEST_EXAM);
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