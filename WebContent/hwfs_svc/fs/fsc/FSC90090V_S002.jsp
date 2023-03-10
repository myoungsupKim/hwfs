
<%
    /*-----------------------------------------------------------------------------
    ■ 시스템명     : 메뉴관리/위생관리
    ■ 프로그램ID   : FSC00090V_S002.jsp
    ■ 프로그램명   : 항목별 득점율 관리
    ■ 작성일자     : 2008-03-20
    ■ 작성자       : 박지영
    ■ 이력관리     : 2008-03-20
    : 박은규 2012-04-16 CSR#(SR201204_09204) 요청자:김희선(건강관리센터)
    특별점검 여부 추가 : 결과조회/출력에서 평균점수에서 제외
    -----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="../../sc/main/common.jsp"%>
<%
    try {
        PlatformRequest platformRequest = this.proc_input(request);
        in_vl = platformRequest.getData().getVariableList();
        in_dl = platformRequest.getData().getDataSetList();

        //jsp log 서비스 시작
        logger.startIndividualLog(in_vl.getString("titLogId"));

        //입력 데이타
        DataSet ds_input = in_dl.get("ds_input");

        String TABLE_TYPE = nullToBlank(ds_input.getString(0, "TABLE_TYPE"));
        String FROM = nullToBlank(ds_input.getString(0, "FROM"));
        String TO = nullToBlank(ds_input.getString(0, "TO"));
        String FORM_CD = nullToBlank(ds_input.getString(0, "FORM_CD"));
        String CHECK_TYPE1 = nullToBlank(ds_input.getString(0, "CHECK_TYPE1"));
        String CHECK_TYPE2 = nullToBlank(ds_input.getString(0, "CHECK_TYPE2"));
        String CHECK_TYPE3 = nullToBlank(ds_input.getString(0, "CHECK_TYPE3"));
        String CHECK_TYPE4 = nullToBlank(ds_input.getString(0, "CHECK_TYPE4"));
        String MU = nullToBlank(ds_input.getString(0, "MU_CD"));
        String TM = nullToBlank(ds_input.getString(0, "TM_CD"));
        String JOB = nullToBlank(ds_input.getString(0, "JOB"));
        String SUB_JOB = nullToBlank(ds_input.getString(0, "SUB_JOB"));
        String UPJANG = nullToBlank(ds_input.getString(0, "UPJANG"));
        String CHECK_SABUN = nullToBlank(ds_input.getString(0, "CHECK_SABUN"));
        String TEAM = nullToBlank(ds_input.getString(0, "TEAM"));
        String LEADER = nullToBlank(ds_input.getString(0, "LEADER"));

        //out 데이타
        DataSet ds_list;

        //sql문 버퍼생성
        StringBuffer sbSql = new StringBuffer();

        // 정검양식조회
        sbSql.delete(0, sbSql.length());
        sbSql.append("                         SELECT COUNT(CHECK_MON) CNT \n");
        sbSql.append("                         FROM( \n");
        sbSql.append("                         SELECT  SUBSTR(A.CHECK_DATE,1,6) CHECK_MON, E.SET1 \n");
        sbSql.append("                              FROM FSC_SAFE_RESULT_DTL A, \n");
        sbSql.append("                                   FSC_SAFE_RESULT_MST B, \n");
        sbSql.append("                                   FSC_SAFE_FORM_DTL C, \n");
        sbSql.append(
                "                                   (SELECT Z.CODE, Z.SET1 FROM SCC_COMMON_CODE Z WHERE Z.GROUP_CODE = 'FS0042') E, \n");
        sbSql.append("                                   ( \n");
        sbSql.append("                                      SELECT UPJANG \n");
        sbSql.append("                                       FROM   FSA_UPJANG_V \n");
        sbSql.append("                                       WHERE  1=1 \n");

        if (!MU.equals("")) {
            sbSql.append("                                       AND    MU_CD='" + MU + "' \n");
        }
        if (!TM.equals("")) {
            sbSql.append("                                       AND    TM_CD='" + TM + "' \n");
        }
        if (!UPJANG.equals("")) {
            sbSql.append("                                       AND    UPJANG=" + UPJANG + " \n");
        }
        if (!JOB.equals("")) {
            sbSql.append("                                       AND    JOB_CD='" + JOB + "' \n");
        }
        if (!SUB_JOB.equals("")) {
            sbSql.append("                                       AND    SUB_JOB_CD='" + SUB_JOB + "' \n");
        }
        if (!TEAM.equals("")) {
            sbSql.append("                                       AND    SUBTEAM_MST_SABUN='" + TEAM + "' \n");
        }
        if (!LEADER.equals("")) {
            sbSql.append("                                       AND    LEADER_SABUN='" + LEADER + "' \n");
        }
        sbSql.append("                                   ) D \n");
        sbSql.append("                             WHERE A.TABLE_TYPE='" + TABLE_TYPE + "' \n");
        sbSql.append(
                "                               AND SUBSTR(A.CHECK_DATE,1,6) BETWEEN '" + FROM + "' AND '" + TO + "' \n");
        if (!UPJANG.equals("")) {
            sbSql.append("                               AND A.UPJANG=" + UPJANG + "          			-- \n");
        }
        sbSql.append("                               AND A.FORM_CD='" + FORM_CD + "' \n");
        if (CHECK_TYPE1.equals("999") && CHECK_TYPE2.equals("999") && CHECK_TYPE3.equals("999")
                && CHECK_TYPE4.equals("999")) {
            // ****
        } else {
            sbSql.append("                               AND ( B.CHECK_TYPE='" + CHECK_TYPE1 + "'  OR B.CHECK_TYPE='"
                    + CHECK_TYPE2 + "' OR B.CHECK_TYPE='" + CHECK_TYPE3 + "' OR B.CHECK_TYPE='" + CHECK_TYPE4 + "' ) \n");
        }
        sbSql.append("                               AND B.CONFIRM_YN='Y' \n");
        if (!CHECK_SABUN.equals("")) {
            sbSql.append("                               AND B.CHECK_SABUN='" + CHECK_SABUN + "'  	-- \n");
        }
        if (!TEAM.equals("")) {
            sbSql.append("                               AND B.SUBTEAM_MST_SABUN='" + TEAM + "'   	-- \n");
        }
        if (!LEADER.equals("")) {
            sbSql.append("                               AND B.LEADER_SABUN='" + LEADER + "'        -- \n");
        }
        sbSql.append("                               AND A.UPJANG=D.UPJANG \n");
        sbSql.append("                               AND A.TABLE_TYPE=B.TABLE_TYPE \n");
        sbSql.append("                               AND A.CHECK_DATE=B.CHECK_DATE \n");
        sbSql.append("                               AND A.FORM_CD=B.FORM_CD \n");
        sbSql.append("                               AND A.UPJANG=B.UPJANG \n");
        sbSql.append("                               AND A.TABLE_TYPE=C.TABLE_TYPE \n");
        sbSql.append("                               AND A.FORM_CD=C.FORM_CD \n");
        sbSql.append("                               AND A.CLASS_CD=C.CLASS_CD \n");
        //============================================================================================
        //(2012-04-16 수정) 시작
        // 박은규 2012-04-16 CSR#(SR201204_09204) 요청자:김희선(건강관리센터)
        // 특별점검 여부 추가 : 결과조회/출력에서 평균점수에서 제외
        // 어차피 점수/평균에는 제외되어야 하는데 횟수/부적합 등은 조회안하니 아예 특별점검은 빼고 조회하자.
        //============================================================================================
        sbSql.append("                               AND B.CHECK_TYPE = E.CODE \n");
        sbSql.append("                               AND NVL(E.SET1,'N') = 'N' \n");
        //============================================================================================
        //(2012-04-16 수정) 끝
        //============================================================================================
        sbSql.append("                         GROUP BY SUBSTR(A.CHECK_DATE,1,6), E.SET1 \n");
        sbSql.append("                         ) \n");

        //System.out.println(sbSql.toString());
        pstmt = conn.prepareStatement(sbSql.toString());
        rs = pstmt.executeQuery();
        DataSet ds_Cnt = this.makeDataSet(rs, "ds_Cnt");

        /**종료**/
        out_dl.add(ds_Cnt);
        this.setResultMessage(0, "OK", out_vl);

    } catch (Exception ex) {
        ex.printStackTrace();
        this.setResultMessage(-1, ex.toString(), out_vl);
    } finally {
        if (rs != null) {
            try {
                rs.close();
            } catch (Exception e) {
            }
        }
        if (pstmt != null) {
            try {
                pstmt.close();
            } catch (Exception e) {
            }
        }
        if (conn != null) {
            try {
                conn.close();
            } catch (Exception e) {
            }
        }
    }

    proc_output(response, out, out_vl, out_dl);
%>