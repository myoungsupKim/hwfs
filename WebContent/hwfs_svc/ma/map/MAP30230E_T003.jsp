
<%
    /*-----------------------------------------------------------------------------
    ■ 시스템명     : 사업계획관리
    ■ 프로그램ID   : MAP30230E_T003.jsp
    ■ 프로그램명   : 마케팅별 일계획/추정 관리 확정
    ■ 작성일자     : 2015-09-02
    ■ 작성자       : 김태윤
    ■ 이력관리     :
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
        DataSet ds_Cond = in_dl.get("ds_Cond");
        DataSet ds_List = in_dl.get("ds_List");// 변경된 데이타

        //입력 파라메터
        String g_Upjang = nullToBlank(in_vl.getString("g_Upjang"));
        String g_EmpNo = nullToBlank(in_vl.getString("g_EmpNo"));

        //FileLog.println("d:\\b.txt", ds_List);
        //FileLog.println("d:\\a.txt", ds_List_ALL);

        // 일계획 데이터
        int chkDt = Integer.parseInt(ds_Cond.getString(0, "SAVE_DD"));
        int chkCol = Integer.parseInt(ds_Cond.getString(0, "COL_CNT"));

        //sql문 버퍼생성
        StringBuffer sbSql = new StringBuffer();

        //입력,수정
        sbSql.delete(0, sbSql.length());
        sbSql.append("      UPDATE MAP_DAY_LOG_MGMT2                           									\n");
        sbSql.append("         SET CONFIRM_YN = '" + "Y" + "' 													\n");
        sbSql.append("           , UDATE      = SYSDATE 														\n");
        sbSql.append("           , UUSER      = '" + g_EmpNo + "' 												\n");
        sbSql.append(" 	 	 WHERE TM_CD = '" + nullToBlank(ds_Cond.getString(0, "TM_CD")) + "'					\n");
        sbSql.append("   	   AND SABUN = '" + nullToBlank(ds_Cond.getString(0, "SABUN")) + "'					\n");
        sbSql.append(" 	 	   AND YY = SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 1, 4)	\n");
        sbSql.append(" 	 	   AND MM = SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 5, 2)	\n");
        sbSql.append("   	   AND DAY_CLASS = '" + nullToBlank(ds_Cond.getString(0, "DAY_CLASS")) + "'			\n");

        out_vl.add("fa_Sql", sbSql.toString());
        //System.out.println(sbSql.toString());
        pstmt = conn.prepareStatement(sbSql.toString());
        pstmt.executeUpdate();
        pstmt.close();
        ///*

        // 기존에 BPC에 전송한 데이터가 있으면 삭제 후 인서트 한다.
        for (int iRow = 0; iRow < ds_List.getRowCount(); iRow++) {
            sbSql.delete(0, sbSql.length());
            sbSql.append("      DELETE MAP_BPC_CONFIRM_DAY_PL_CUST                     							\n");
            sbSql.append("       WHERE UPJANG    = '" + nullToBlank(ds_List.getString(iRow, "UPJANG")) + "'		\n");
            sbSql.append("         AND ACCT_CD = '" + nullToBlank(ds_List.getString(iRow, "ACCT_CD")) + "'		\n");
            sbSql.append("         AND YYMM = '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'			\n");
            sbSql.append("         AND DAY_CLASS  = '" + nullToBlank(ds_Cond.getString(0, "DAY_GBN")) + "'		\n");

            out_vl.add("fa_Sql", sbSql.toString());
            //System.out.println(sbSql.toString());
            pstmt = conn.prepareStatement(sbSql.toString());
            pstmt.executeUpdate();
            pstmt.close();
        } // END FOR

        //월추정 확정정보 FC -> BPC로 정보 전송
        sbSql.delete(0, sbSql.length());
        sbSql.append("      INSERT INTO MAP_BPC_CONFIRM_DAY_PL_CUST                                         \n");
        sbSql.append("             ( YYMM                                                                   \n");
        sbSql.append("             , YMD                                                                    \n");
        sbSql.append("             , DAY_CLASS                                                              \n");
        sbSql.append("             , BU_CD                                                                  \n");
        sbSql.append("             , CC_CD                                                                  \n");
        sbSql.append("             , UPJANG                                                                 \n");
        sbSql.append("             , ACCT_CD                                                                \n");
        sbSql.append("             , MU_CD                                                                  \n");
        sbSql.append("             , TM_CD                                                                  \n");
        sbSql.append("             , DD_AMT                                                                 \n");
        sbSql.append("             , CURRENCY_CD                                                            \n");
        sbSql.append("             , CUSER                                                                  \n");
        sbSql.append("             , CDATE                                                                  \n");
        sbSql.append("             , UUSER                                                                  \n");
        sbSql.append("             , UDATE )                                                                \n");
        sbSql.append("      VALUES ( ?  \n");
        sbSql.append("             , ?  \n");
        sbSql.append("             , ?  \n");
        sbSql.append("             , ?  \n");
        sbSql.append("             , ?  \n");
        sbSql.append("             , ?  \n");
        sbSql.append("             , ?  \n");
        sbSql.append("             , ?  \n");
        sbSql.append("             , ?  \n");
        sbSql.append("             , ?  \n");
        sbSql.append("             , ?  \n");
        sbSql.append("             , ?  \n");
        sbSql.append("             , SYSDATE  \n");
        sbSql.append("             , ?  \n");
        sbSql.append("             , SYSDATE  \n");
        sbSql.append("             )    \n");
        pstmt = conn.prepareStatement(sbSql.toString());

        for (int iRow = 0; iRow < ds_List.getRowCount(); iRow++) {
            int j = 1;
            for (int k = 10; k <= chkDt; k++) {
                pstmt.setString(1, nullToBlank(ds_Cond.getString(0, "INPUT_YY")));

                if (k < 19) {
                    pstmt.setString(2, nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + '0' + j);
                } else if (k >= 19 && k <= chkDt) {
                    pstmt.setString(2, nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + j);
                }

                pstmt.setString(3, nullToBlank(ds_Cond.getString(0, "DAY_GBN")));
                pstmt.setString(4, "2000");
                pstmt.setString(5, nullToBlank(ds_List.getString(iRow, "CC_CD")));
                pstmt.setString(6, nullToBlank(ds_List.getString(iRow, "UPJANG")));
                pstmt.setString(7, nullToBlank(ds_List.getString(iRow, "ACCT_CD")));
                pstmt.setString(8, "2004");
                pstmt.setString(9, nullToBlank(ds_Cond.getString(0, "TM_CD")));

                pstmt.setFloat(10, stringToFloat(ds_List.getString(iRow, k)) * 1000);

                pstmt.setString(11, "KRW");
                pstmt.setString(12, g_EmpNo);
                pstmt.setString(13, g_EmpNo);

                j++;

                //out_vl.add("fa_Sql", sbSql.toString());
                //System.out.println(sbSql.toString());
                //pstmt = conn.prepareStatement(sbSql.toString());
                //pstmt.executeUpdate();
                //pstmt.close();
                pstmt.addBatch(); //변수대입이 끝나면 다음 배치추가
            }
        } // END FOR
        pstmt.executeBatch(); //배치처리
        pstmt.close();

        /**종료**/
        conn.commit();
        this.setResultMessage(0, "OK", out_vl);
    } catch (Exception ex) {
        conn.rollback();
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