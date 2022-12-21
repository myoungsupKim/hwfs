
<%
    /*-----------------------------------------------------------------------------
    ■ 시스템명     : 사업계획관리
    ■ 프로그램ID   : MAP30020E_T003.jsp
    ■ 프로그램명   : 일계획/추정 관리 확정
    ■ 작성일자     : 2015-06-29
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
        //DataSet ds_Man      = in_dl.get("ds_Man"); // FC -> BPC로 조리직 인건비 데이타

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
        sbSql.append("      UPDATE MAP_DAY_LOG_MGMT                           									\n");
        sbSql.append("         SET CONFIRM_YN = '" + "Y" + "' 													\n");
        sbSql.append("           , UDATE      = SYSDATE 														\n");
        sbSql.append("           , UUSER      = '" + g_EmpNo + "' 												\n");
        sbSql.append("		 WHERE UPJANG = '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'				\n");
        sbSql.append(" 	 	   AND YY = SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 1, 4)	\n");
        sbSql.append(" 	 	   AND MM = SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 5, 2)	\n");
        sbSql.append("   	   AND DAY_CLASS = '" + nullToBlank(ds_Cond.getString(0, "DAY_CLASS")) + "'			\n");

        out_vl.add("fa_Sql", sbSql.toString());
        //System.out.println(sbSql.toString());
        pstmt = conn.prepareStatement(sbSql.toString());
        pstmt.executeUpdate();
        pstmt.close();

        // 기존에 BPC에 전송한 데이터가 있으면 삭제 후 인서트 한다.
        for (int iRow = 0; iRow < 1; iRow++) {
            sbSql.delete(0, sbSql.length());
            sbSql.append("      DELETE MAP_BPC_CONFIRM_DAY_PL_INFO                     							\n");
            sbSql.append("       WHERE CC_CD     = '" + nullToBlank(ds_List.getString(0, "CC_CD")) + "'			\n");
            sbSql.append("         AND YYMM = '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'			\n");
            sbSql.append("         AND DAY_CLASS  = '" + nullToBlank(ds_Cond.getString(0, "DAY_GBN")) + "'		\n");

            out_vl.add("fa_Sql", sbSql.toString());
            //System.out.println(sbSql.toString());
            pstmt = conn.prepareStatement(sbSql.toString());
            pstmt.executeUpdate();
            pstmt.close();
        } // END FOR

        // 재무금액으로 변경을 위한 출하율 조회
        double marginRate01 = 100.0;
        double marginRate02 = 100.0;
        double marginRate03 = 100.0;
        double marginRate04 = 100.0;
        double marginRate05 = 100.0;
        double marginRate06 = 100.0;
        double marginRate07 = 100.0;
        double marginRate08 = 100.0;
        double marginRate09 = 100.0;
        double marginRate10 = 100.0;
        double marginRate11 = 100.0;
        double marginRate12 = 100.0;

        sbSql.delete(0, sbSql.length());
        sbSql.append(" SELECT NVL(A.MM_MARGIN_RATE_01, 100) AS MM_MARGIN_RATE_01 \n");
        sbSql.append("       ,NVL(A.MM_MARGIN_RATE_02, 100) AS MM_MARGIN_RATE_02 \n");
        sbSql.append("       ,NVL(A.MM_MARGIN_RATE_03, 100) AS MM_MARGIN_RATE_03 \n");
        sbSql.append("       ,NVL(A.MM_MARGIN_RATE_04, 100) AS MM_MARGIN_RATE_04 \n");
        sbSql.append("       ,NVL(A.MM_MARGIN_RATE_05, 100) AS MM_MARGIN_RATE_05 \n");
        sbSql.append("       ,NVL(A.MM_MARGIN_RATE_06, 100) AS MM_MARGIN_RATE_06 \n");
        sbSql.append("       ,NVL(A.MM_MARGIN_RATE_07, 100) AS MM_MARGIN_RATE_07 \n");
        sbSql.append("       ,NVL(A.MM_MARGIN_RATE_08, 100) AS MM_MARGIN_RATE_08 \n");
        sbSql.append("       ,NVL(A.MM_MARGIN_RATE_09, 100) AS MM_MARGIN_RATE_09 \n");
        sbSql.append("       ,NVL(A.MM_MARGIN_RATE_10, 100) AS MM_MARGIN_RATE_10 \n");
        sbSql.append("       ,NVL(A.MM_MARGIN_RATE_11, 100) AS MM_MARGIN_RATE_11 \n");
        sbSql.append("       ,NVL(A.MM_MARGIN_RATE_12, 100) AS MM_MARGIN_RATE_12 \n");
        sbSql.append("   FROM MAP_MARGIN_RATE_MGMT A \n");
        sbSql.append("      , SCO_UPJANG_MST_V B \n");
        sbSql.append("  WHERE A.UPJANG(+) = B.UPJANG \n");
        sbSql.append("    AND A.CLASS(+) = 'R' \n");
        sbSql.append("    AND A.YY(+) = '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY").substring(0, 4)) + "' \n");
        sbSql.append("    AND B.CLOSE_DATE IS NULL \n");
        //sbSql.append("    AND B.MU_CD = '2002' \n");
        //sbSql.append("    AND (B.TM_CD = 'CDH' OR PT_CD = 'CDH') \n");
        sbSql.append("    AND B.UPJANG = '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "' \n");
        pstmt = conn.prepareStatement(sbSql.toString());
        rs = pstmt.executeQuery();
        while (rs.next()) {
            marginRate01 = rs.getDouble("MM_MARGIN_RATE_01");
            marginRate02 = rs.getDouble("MM_MARGIN_RATE_02");
            marginRate03 = rs.getDouble("MM_MARGIN_RATE_03");
            marginRate04 = rs.getDouble("MM_MARGIN_RATE_04");
            marginRate05 = rs.getDouble("MM_MARGIN_RATE_05");
            marginRate06 = rs.getDouble("MM_MARGIN_RATE_06");
            marginRate07 = rs.getDouble("MM_MARGIN_RATE_07");
            marginRate08 = rs.getDouble("MM_MARGIN_RATE_08");
            marginRate09 = rs.getDouble("MM_MARGIN_RATE_09");
            marginRate10 = rs.getDouble("MM_MARGIN_RATE_10");
            marginRate11 = rs.getDouble("MM_MARGIN_RATE_11");
            marginRate12 = rs.getDouble("MM_MARGIN_RATE_12");
        }
        rs.close();
        pstmt.close();

        //pstmt.setString(4, nullToBlank(ds_Cond.getString(0, "INPUT_YY").substring(4, 6)));

        sbSql.delete(0, sbSql.length());
        sbSql.append("      INSERT INTO MAP_BPC_CONFIRM_DAY_PL_INFO                                         \n");
        sbSql.append("             ( YYMM                                                                   \n");
        sbSql.append("             , YMD                                                                    \n");
        sbSql.append("             , DAY_CLASS                                                              \n");
        sbSql.append("             , BU_CD                                                                  \n");
        sbSql.append("             , CC_CD                                                                  \n");
        sbSql.append("             , ACCT_CD                                                                \n");
        sbSql.append("             , MU_CD                                                                  \n");
        sbSql.append("             , TM_CD                                                                  \n");
        sbSql.append("             , DD_AMT                                                                 \n");
        sbSql.append("             , CURRENCY_CD                                                            \n");
        sbSql.append("             , CUSER                                                                  \n");
        sbSql.append("             , CDATE                                                                  \n");
        sbSql.append("             , UUSER                                                                  \n");
        sbSql.append("             , UDATE )                                                                \n");
        sbSql.append("      VALUES ( ?   \n");
        sbSql.append("             , ?   \n");
        sbSql.append("             , ?   \n");
        sbSql.append("             , ?   \n");
        sbSql.append("             , ?   \n");
        sbSql.append("             , ?   \n");
        sbSql.append("             , ?   \n");
        sbSql.append("             , ?   \n");
        sbSql.append("             , ?   \n");
        sbSql.append("             , ?   \n");
        sbSql.append("             , ?   \n");
        sbSql.append("             , SYSDATE \n");
        sbSql.append("             , ?       \n");
        sbSql.append("             , SYSDATE \n");
        sbSql.append("             )        \n");
        pstmt = conn.prepareStatement(sbSql.toString());

        //월추정 확정정보 FC -> BPC로 정보 전송
        StringBuffer tmpString = new StringBuffer();
        for (int iRow = 0; iRow < ds_List.getRowCount(); iRow++) {
            int j = 1;
            double marginRate = 100.0;
            for (int k = 11; k <= chkDt; k++) {
                marginRate = 100.0;
                pstmt.setString(1, nullToBlank(ds_Cond.getString(0, "INPUT_YY")));
                if (k < 20) {
                    pstmt.setString(2, nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + '0' + String.valueOf(j));
                } else if (k >= 20 && k <= chkDt) {
                    pstmt.setString(2, nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + String.valueOf(j));
                }
                pstmt.setString(3, nullToBlank(ds_Cond.getString(0, "DAY_GBN")));
                pstmt.setString(4, "2000");
                pstmt.setString(5, nullToBlank(ds_List.getString(iRow, "CC_CD")));
                pstmt.setString(6, nullToBlank(ds_List.getString(iRow, "ACCT_CD")));
                pstmt.setString(7, "");
                pstmt.setString(8, "");

                // 재무금액으로 변경하여 BPC쪽으로 전송한다.
                if (nullToBlank(ds_List.getString(iRow, "ACCT_CD").substring(0, 5)).equals("42203")) {
                    if (nullToBlank(ds_Cond.getString(0, "INPUT_YY").substring(4, 6)).equals("01")) marginRate = marginRate01;
                    else if (nullToBlank(ds_Cond.getString(0, "INPUT_YY").substring(4, 6)).equals("02")) marginRate = marginRate02;
                    else if (nullToBlank(ds_Cond.getString(0, "INPUT_YY").substring(4, 6)).equals("03")) marginRate = marginRate03;
                    else if (nullToBlank(ds_Cond.getString(0, "INPUT_YY").substring(4, 6)).equals("04")) marginRate = marginRate04;
                    else if (nullToBlank(ds_Cond.getString(0, "INPUT_YY").substring(4, 6)).equals("05")) marginRate = marginRate05;
                    else if (nullToBlank(ds_Cond.getString(0, "INPUT_YY").substring(4, 6)).equals("06")) marginRate = marginRate06;
                    else if (nullToBlank(ds_Cond.getString(0, "INPUT_YY").substring(4, 6)).equals("07")) marginRate = marginRate07;
                    else if (nullToBlank(ds_Cond.getString(0, "INPUT_YY").substring(4, 6)).equals("08")) marginRate = marginRate08;
                    else if (nullToBlank(ds_Cond.getString(0, "INPUT_YY").substring(4, 6)).equals("09")) marginRate = marginRate09;
                    else if (nullToBlank(ds_Cond.getString(0, "INPUT_YY").substring(4, 6)).equals("10")) marginRate = marginRate10;
                    else if (nullToBlank(ds_Cond.getString(0, "INPUT_YY").substring(4, 6)).equals("11")) marginRate = marginRate11;
                    else if (nullToBlank(ds_Cond.getString(0, "INPUT_YY").substring(4, 6)).equals("12")) marginRate = marginRate12;
                    else marginRate = 100.0;
                    pstmt.setFloat(9, (int)Math.ceil(stringToFloat(ds_List.getString(iRow, k)) / (marginRate / 100.0)) * 1000);
                    //tmpString.append(nullToBlank(ds_Cond.getString(0, "INPUT_YY").substring(4, 6)) + " , " + marginRate + " , " + stringToFloat(ds_List.getString(iRow, k)) + " , "+ (marginRate / 100) + " , "+ ((int)Math.ceil(stringToFloat(ds_List.getString(iRow, k)) / (marginRate / 100)) * 1000) + "\n");
                } else {
                    pstmt.setFloat(9, stringToFloat(ds_List.getString(iRow, k)) * 1000);
                }

                pstmt.setString(10, "KRW");
                pstmt.setString(11, g_EmpNo);
                pstmt.setString(12, g_EmpNo);

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

        //System.out.println(tmpString.toString());

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