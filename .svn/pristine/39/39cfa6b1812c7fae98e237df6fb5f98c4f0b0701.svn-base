<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 위생점검
■ 프로그램ID   : FSC00024P_T001.jsp
■ 프로그램명   : 사진팝업 조회
■ 작성일자     : 20170118
■ 작성자       : 박용대
■ 이력관리     : 20170118
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
        String strPhotoType		= nullToBlank(ds_input.getString(0, "PHOTO_TYPE"));
        
        //out 데이타
        DataSet ds_list;

        //sql문 버퍼생성
        StringBuffer sbSql = new StringBuffer();

        // 정검양식조회
        sbSql.delete(0, sbSql.length());
        sbSql.append("SELECT A.PHOTO_TYPE,        \n");
        sbSql.append("       (SELECT Z.UPJANGNM FROM ST_UPJANG Z WHERE A.UPJANG = Z.UPJANG) AS UPJANG,        \n");
        sbSql.append("       A.CHK_DD,       \n");
        sbSql.append("       B.CLASS_NAME,      \n");
        sbSql.append("       A.SVR_IMGE      \n");
        sbSql.append("  FROM FSC_CHK_IMGE A   \n");
        sbSql.append("       ,FSC_FORM_DTL B   \n");
        sbSql.append(" WHERE 1=1 \n");
        sbSql.append("   AND A.TABLE_TYPE = B.TABLE_TYPE \n");
        sbSql.append("   AND A.FORM_CD = B.FORM_CD \n");
        sbSql.append("   AND A.CLASS_CD = B.CLASS_CD \n");
        if (strUpjang.length() != 0)				sbSql.append("   AND A.UPJANG = " + strUpjang + " \n");
        sbSql.append("   AND A.CHK_DD BETWEEN '" + strFromDt + "' AND '" + strToDt + "' \n");
        if (strPhotoType.length() != 0)				sbSql.append("   AND A.PHOTO_TYPE = " + strPhotoType + " \n");
        sbSql.append("   ORDER BY A.CLASS_CD   \n");
        
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