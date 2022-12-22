
<%
    /*-----------------------------------------------------------------------------
    ■ 시스템명     : 메뉴관리/위생관리
    ■ 프로그램ID   : FSC00010E_T001.jsp
    ■ 프로그램명   : 점검양식관리
    ■ 작성일자     : 2008-03-18
    ■ 작성자       : 박지영
    ■ 이력관리     : 2008-03-18
                    : 박은규 2009-01-14 CSR#(23819) 요청자:이명희(건강관리센터)
                        점검표 등록 후 수정불가 및 상단조회조건에 '전체'추가
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

        String strTableType = nullToBlank(ds_input.getString(0, "TABLE_TYPE"));
        String strUseYn = nullToBlank(ds_input.getString(0, "USE_YN"));

        //out 데이타
        DataSet ds_list;

        //sql문 버퍼생성
        StringBuffer sbSql = new StringBuffer();

        // 정검양식조회
        sbSql.delete(0, sbSql.length());
        sbSql.append("SELECT TABLE_TYPE \n");
        //============================================================================================
        //(2009-01-14 추가) 시작
        // 박은규 2009-01-14 CSR#(23819) 요청자:이명희(건강관리센터)
        // 점검표 등록 후 수정불가 및 상단조회조건에 '전체'추가
        //============================================================================================
        sbSql.append("     ,(SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0041' AND CODE = A.TABLE_TYPE) AS TYPE_NAME \n");
        //============================================================================================
        //(2009-01-14 추가) 시작
        //============================================================================================
        //20210419078 - 1 : MAN_SCORE 추가
        sbSql.append("     , FORM_CD \n");
        sbSql.append("     , FORM_NAME \n");
        sbSql.append("     , START_DATE \n");
        sbSql.append("     , END_DATE \n");
        sbSql.append("     , START_DATE || END_DATE AS DATE_PERIOD \n");
        sbSql.append("     , USE_YN \n");
        sbSql.append("     , TO_CHAR(UDATE,'YYYY.MM.DD') AS UDATE \n");
        sbSql.append("     , (SELECT COUNT(*) FROM FSC_RESULT_MST WHERE A.TABLE_TYPE = TABLE_TYPE AND A.FORM_CD = FORM_CD) AS CNT \n");
        sbSql.append("     , MAN_SCORE \n");
        sbSql.append("  FROM FSC_FORM_MST A \n");
        sbSql.append(" WHERE 1 = 1 \n");
        //============================================================================================
        //(2009-01-14 수정) 시작
        // 박은규 2009-01-14 CSR#(23819) 요청자:이명희(건강관리센터)
        // 점검표 등록 후 수정불가 및 상단조회조건에 '전체'추가
        //============================================================================================
        if (!strTableType.equals(""))
            sbSql.append("  AND TABLE_TYPE = '" + strTableType + "' \n");
        if (!strUseYn.equals(""))
            sbSql.append("  AND USE_YN = '" + strUseYn + "' \n");
        //============================================================================================
        //(2009-01-14 수정) 끝
        //============================================================================================
        sbSql.append("ORDER BY CDATE DESC, TABLE_TYPE, FORM_CD \n");

        //System.out.println(sbSql.toString());
        pstmt = conn.prepareStatement(sbSql.toString());
        rs = pstmt.executeQuery();
        ds_list = this.makeDataSet(rs, "ds_list");

        rs.close();
        pstmt.close();

        /**종료**/
        out_dl.add(ds_list);
        this.setResultMessage(0, "OK", out_vl);

    } catch (Exception ex) {
        //ex.printStackTrace();
        //jsp 로그남기기
        logger.debug(ex.getMessage(), ex);
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

        //jsp log 서비스 닫기
        try {
            logger.endIndividualLog();
        } catch (Exception logE) {
            logE.printStackTrace();
        }
    }

    proc_output(response, out, out_vl, out_dl);
%>