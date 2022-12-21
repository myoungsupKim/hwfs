<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 특별교육
■ 프로그램ID   : FSC00023E_T003.jsp
■ 프로그램명   : 특별교육 조회
■ 작성일자     : 20161018
■ 작성자       : 박용대
■ 이력관리     : 20161018
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
        //DataSet ds_input     = in_dl.get("ds_input");

        //String strSabun		= nullToBlank(ds_input.getString(0, "SABUN"));
        String strSabun 	= in_vl.getString("SABUN");
        
        //out 데이타
        DataSet ds_list;

        //sql문 버퍼생성
        StringBuffer sbSql = new StringBuffer();

        // 정검양식조회
        sbSql.delete(0, sbSql.length());
        sbSql.append("SELECT AA.*, (SELECT Z.UPJANGNM FROM ST_UPJANG Z WHERE Z.UPJANG = AA.UPJANG ) AS UPJANGNM FROM  \n");
        sbSql.append("(            \n");
        sbSql.append("SELECT ROWNUM, TABLE_TYPE,                          \n");
        sbSql.append("       FORM_CD,                             \n");
        sbSql.append("       UPJANG,                              \n");
        sbSql.append("       CHECK_DATE,                          \n");
        sbSql.append("       CHECK_TYPE,                           \n");
        sbSql.append("       SCORE,                           \n");
        sbSql.append("       (SELECT Z.NM_KOR FROM SCC_USERINFO Z WHERE Z.SABUN = CHARGE_SABUN) AS CHARGE_SABUN_NM    \n");
        sbSql.append("  FROM FSC_RESULT_MST                       \n");
        sbSql.append(" WHERE CHARGE_SABUN = '"+strSabun+"'           \n");
        sbSql.append("   AND CHECK_DATE IN (SELECT MAX(CHECK_DATE) \n");
        sbSql.append("                        FROM FSC_RESULT_MST \n");
        sbSql.append("                       WHERE CHARGE_SABUN = '"+strSabun+"') \n");
        sbSql.append("   AND ROWNUM = 1 \n");
        sbSql.append("   ) AA \n");
        /*
        sbSql.append(" WHERE A.TABLE_TYPE = B.TABLE_TYPE \n");
        sbSql.append("   AND A.FORM_CD = B.FORM_CD \n");
        sbSql.append("   AND CHECK_DATE BETWEEN '" + strFromDt + "' AND '" + strToDt + "' \n");
        if (strUpjang.length() != 0)				sbSql.append("   AND UPJANG = " + strUpjang + " \n");
        // 사업장인 경우 확정결과만 조회가능
        if (strConfirmYN.length() != 0)				sbSql.append("   AND A.CONFIRM_YN = '" + strConfirmYN + "' \n");
        sbSql.append(" ORDER BY A.CHECK_DATE DESC, A.CHECK_TYPE \n");
        */

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