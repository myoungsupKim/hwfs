<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 위생관리/외부기관점검결과관리
■ 프로그램ID   : FSC92030E_T002.jsp
■ 프로그램명   : 외부기간점검결과조회
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

        //out 데이타
        DataSet ds_UpjangInfo;

        //sql문 버퍼생성
        StringBuffer sbSql = new StringBuffer();

        // 정검양식조회
        sbSql.delete(0, sbSql.length());
        sbSql.append("SELECT  V.UPJANG                                                                                                         \n");
        sbSql.append("       ,V.UPJANGNM                                                                                                       \n");
        sbSql.append("       ,V.TM_CD                                                                                                          \n");
        sbSql.append("       ,V.TM_NM                                                                                                          \n");
        sbSql.append("       ,V.TEAM_MST_SABUN                                                                                                 \n");
        sbSql.append("       ,(SELECT NM_KOR FROM SCO_FS_HR_PERSONAL_V WHERE SABUN = V.TEAM_MST_SABUN) TEAM_MST_SABUNNM		/* 대팀장명 */       \n");
        sbSql.append("       ,V.SUBTEAM_MST_SABUN                                                                                              \n");
        sbSql.append("       ,(SELECT NM_KOR FROM SCO_FS_HR_PERSONAL_V WHERE SABUN = V.SUBTEAM_MST_SABUN) SUBTEAM_MST_SABUNNM	/* 소팀장명 */   \n");
        sbSql.append("       ,V.CHARGE_SABUN                                                                                                   \n");
        sbSql.append("       ,(SELECT NM_KOR FROM SCO_FS_HR_PERSONAL_V WHERE SABUN = V.CHARGE_SABUN) CHARGE_SABUNNM	/* 점장명 */               \n");
        sbSql.append("       ,SUBSTR(V.PERMISSION_TYPE,1,3) AS PERMISSION_TYPE	/* 인허가형태(MA0004) */                                       \n");
        sbSql.append("       ,SCC_CODE_NM('MA0004',SUBSTRB(V.PERMISSION_TYPE,1,3)) AS PERMISSION_NM                                            \n");
        sbSql.append("  FROM SCO_UPJANG_MST_V V                                                                                                \n");
        sbSql.append("  	  ,(SELECT UPJANG, ADDR_KEY FROM SCO_UPJANG_MST) S                                                                   \n");
        sbSql.append(" WHERE V.UPJANG = S.UPJANG(+)                                                                                            \n");
        sbSql.append("   AND V.UPJANG = '" + strUpjang + "' \n");

        //System.out.println(sbSql.toString());
        pstmt = conn.prepareStatement(sbSql.toString());
        rs = pstmt.executeQuery();
        ds_UpjangInfo = this.makeDataSet(rs, "ds_UpjangInfo");

        rs.close();
        pstmt.close();

        /**종료**/
        out_dl.add(ds_UpjangInfo);
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