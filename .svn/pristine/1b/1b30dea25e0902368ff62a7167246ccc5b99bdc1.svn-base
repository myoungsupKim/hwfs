<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 특별교육
■ 프로그램ID   : FSC00023E_T005.jsp
■ 프로그램명   : 특별교육 조회
■ 작성일자     : 20160826
■ 작성자       : 박용대
■ 이력관리     : 20160826
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
        sbSql.append(" SELECT A.UPJANG                                                                      \n");
        sbSql.append("       ,(SELECT UPJANGNM FROM MAC_UPJANG_V WHERE A.UPJANG = UPJANG) AS UPJANGNM       \n");
        sbSql.append("       ,A.CHECK_DATE                                                                  \n");
        sbSql.append("       ,A.CHECK_TYPE                                                                  \n");
        sbSql.append("       ,A.TABLE_TYPE                                                                  \n");
        sbSql.append("       ,A.FORM_CD                                                                     \n");
        sbSql.append("       ,B.FORM_NAME                                                                   \n");
        sbSql.append("       ,A.CHARGE_SABUN                                                              \n");
        sbSql.append("       ,(SELECT Z.NM_KOR FROM HLDC_HR_PERSONAL Z WHERE Z.SABUN = A.CHARGE_SABUN) CHARGE_NM \n");
        sbSql.append("       , '등록' AS Y                                                                     \n");
        sbSql.append("       ,A.RESP_SABUN1                                                               \n");
        sbSql.append("       ,(SELECT Z.NM_KOR FROM HLDC_HR_PERSONAL Z WHERE Z.SABUN = A.RESP_SABUN1) RESP1_NM \n");
        sbSql.append("       , '등록' AS Y1                                                                    \n");
        sbSql.append("       ,A.RESP_SABUN2                                                               \n");
        sbSql.append("       ,(SELECT Z.NM_KOR FROM HLDC_HR_PERSONAL Z WHERE Z.SABUN = A.RESP_SABUN2) RESP2_NM \n");
        sbSql.append("       , '등록' AS Y2                                                                    \n");
        sbSql.append("       ,A.RESP_SABUN3                                                               \n");
        sbSql.append("       ,(SELECT Z.NM_KOR FROM HLDC_HR_PERSONAL Z WHERE Z.SABUN = A.RESP_SABUN3) RESP3_NM \n");
        sbSql.append("       , '등록' AS Y3                                                                    \n");
        sbSql.append("       ,A.SCORE                                                                       \n");
        sbSql.append("  FROM FSC_RESULT_MST A                                                               \n");
        sbSql.append("       ,FSC_FORM_MST B                                                                \n");
        sbSql.append(" WHERE 1=1                                                                            \n");
        sbSql.append(" AND A.TABLE_TYPE = B.TABLE_TYPE                                                      \n");
        sbSql.append(" AND A.FORM_CD = B.FORM_CD                                                            \n");
        sbSql.append(" AND A.NOT_FIT_YN > 0                                                          \n");
        sbSql.append(" AND A.CHECK_DATE BETWEEN '" + strFromDt + "' AND '" + strToDt + "'                                   \n");
        if (strUpjang.length() != 0)				
        	sbSql.append("   AND A.UPJANG = '" + strUpjang + "'  \n");
        /*
        sbSql.append(" WHERE A.TABLE_TYPE = B.TABLE_TYPE \n");
        sbSql.append("   AND A .FORM_CD = B.FORM_CD \n");
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