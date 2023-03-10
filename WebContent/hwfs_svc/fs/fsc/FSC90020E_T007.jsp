<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 메뉴관리/위생관리
■ 프로그램ID   : FSC00020E_T007.jsp
■ 프로그램명   : 정검결과등록 - 점장 근속일자 key체크
■ 작성일자     : 2008-03-20
■ 작성자       : 박지영
■ 이력관리     : 2008-03-20
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
        String strSabun 	= in_vl.getString("SABUN");



        //out 데이타
        DataSet ds_list;

        //sql문 버퍼생성
        StringBuffer sbSql = new StringBuffer();

        // 정검양식조회
        sbSql.delete(0, sbSql.length());
        sbSql.append("SELECT 	(CASE WHEN B.PER_DTA IS NULL AND B.PER_DTB IS NULL THEN \n");
        sbSql.append("                  '' \n");
        sbSql.append("           ELSE \n");
        sbSql.append("                 SCC_KUNSOK_YMD_FUN(DECODE(B.PER_DTA,NULL,B.PER_DTB,B.PER_DTA), TO_CHAR(SYSDATE,'YYYYMMDD')) \n");
        sbSql.append("           END)    AS KUNSOK \n");
        sbSql.append("  FROM SCO_FS_HR_PERSONAL_V B \n");
        sbSql.append(" WHERE SABUN ='" + strSabun + "' \n");

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