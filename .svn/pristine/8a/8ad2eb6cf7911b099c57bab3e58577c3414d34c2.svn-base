<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 특별교육
■ 프로그램ID   : FSC00023E_T001.jsp
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
        String strName 			= nullToBlank(ds_input.getString(0, "NAME"));
        
        System.out.println(strName);

        //out 데이타
        DataSet ds_list;

        //sql문 버퍼생성
        StringBuffer sbSql = new StringBuffer();

        // 정검양식조회
        sbSql.delete(0, sbSql.length());
        sbSql.append("SELECT         \n");
        sbSql.append("     A.EDU_ID         \n");
        sbSql.append("    ,A.EDU_DATE       \n");
        sbSql.append("    ,A.EDU_SABUN      \n");
        sbSql.append("    ,(SELECT Z.NM_KOR FROM HLDC_HR_PERSONAL Z WHERE A.EDU_SABUN = Z.SABUN) AS EDU_NM      \n");
        sbSql.append("    ,A.EDU_SCORE      \n");
        sbSql.append("    ,A.EDU_APPLY_YN   \n");
        sbSql.append("    ,A.HW1   \n");
        sbSql.append("    ,A.HW2   \n");
        sbSql.append("    ,A.HW3   \n");
        sbSql.append("    ,A.USE_YN         \n");
        sbSql.append("    ,A.TABLE_TYPE       \n");
        sbSql.append("    ,A.FORM_CD          \n");
        sbSql.append("    ,A.UPJANG           \n");
        sbSql.append("    ,A.LV           \n");
        sbSql.append("    ,(SELECT Z.UPJANGNM FROM ST_UPJANG Z WHERE Z.UPJANG = A.UPJANG ) AS UPJANGNM           \n");
        sbSql.append("    ,A.CHECK_DATE       \n");
        sbSql.append("    ,A.CHECK_TYPE       \n");
        sbSql.append("FROM FSC_EDULIST A  \n");
        sbSql.append("    WHERE 1=1 \n");
        sbSql.append("   	AND A.EDU_DATE BETWEEN '" + strFromDt + "' AND '" + strToDt + "' \n");
        sbSql.append("   	AND A.USE_YN = 'Y' \n");
        if (strName.length() != 0)				
        	sbSql.append("   AND (SELECT Z.NM_KOR FROM SCC_USERINFOV Z WHERE A.EDU_SABUN = Z.SABUN) LIKE '%"+ strName +"%' \n");
        sbSql.append("    ORDER BY A.EDU_DATE DESC\n");
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