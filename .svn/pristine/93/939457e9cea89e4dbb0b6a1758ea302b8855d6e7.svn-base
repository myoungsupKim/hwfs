
<%
    /*-----------------------------------------------------------------------------
    ■ 시스템명     : 사업계획관리
    ■ 프로그램ID   : MAP30030E_T002.jsp
    ■ 프로그램명   : 일계획 관리 저장
    ■ 작성일자     : 2015-06-26
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

        //sql문 버퍼생성
        StringBuffer sbSql = new StringBuffer();

        // 일계획 등록여부 확인
        sbSql.append("SELECT COUNT(1) ISDATA                                                            \n");
        sbSql.append("  FROM MAP_DAY_LOG_MGMT                                                           \n");
        sbSql.append(" WHERE UPJANG = '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'             \n");
        sbSql.append("   AND YY = SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 1, 4) \n");
        sbSql.append("   AND MM = SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 5, 2) \n");
        sbSql.append("   AND DAY_CLASS = '" + nullToBlank(ds_Cond.getString(0, "DAY_CLASS")) + "'       \n");
        sbSql.append("   AND CONFIRM_YN = '" + "N" + "' \n");
        pstmt = conn.prepareStatement(sbSql.toString());
        rs = pstmt.executeQuery();
        rs.next();
        String isData = rs.getString("ISDATA");
        rs.close();
        pstmt.close();

        // 월추정 최종PL값을 반영한다
        sbSql.delete(0, sbSql.length());
        sbSql.append("SELECT NVL(MAX(CKEY), TO_CHAR(SYSDATE, 'YYYYMMDDHH24MISS')) AS CKEY               \n");
        sbSql.append("  FROM MAP_MON_PLAN_DTL                                                           \n");
        sbSql.append(" WHERE UPJANG = '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'             \n");
        sbSql.append("   AND YY = SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 1, 4) \n");
        pstmt = conn.prepareStatement(sbSql.toString());
        rs = pstmt.executeQuery();
        rs.next();
        String isCkey = rs.getString("CKEY");
        rs.close();
        pstmt.close();

        // 일계획 마스터 데이터.
        // 기존값이 있으면 일계획 데이터 삭제 후 인서트
        if ("0".equals(isData)) {
            // 일계획 등록.
            sbSql.delete(0, sbSql.length());
            sbSql.append("INSERT INTO MAP_DAY_LOG_MGMT                                                  \n");
            sbSql.append("       (UPJANG, YY, MM, DAY_CLASS, CONFIRM_YN, CDATE, CUSER)                  \n");
            sbSql.append("VALUES ('" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'                 \n");
            sbSql.append("      , SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 1, 4) \n");
            sbSql.append("      , SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 5, 2) \n");
            sbSql.append("      , '" + nullToBlank(ds_Cond.getString(0, "DAY_CLASS")) + "'              \n");
            sbSql.append("      , 'N', SYSDATE, '" + g_EmpNo + "' )                                     \n");
            pstmt = conn.prepareStatement(sbSql.toString());
            pstmt.executeUpdate();
            pstmt.close();
            //rs = pstmt.executeQuery();
            //rs.next();
        } /*else{
               sbSql.delete(0, sbSql.length());
               sbSql.append("DELETE MAP_DAY_PLAN                                                                       \n");
               sbSql.append("       WHERE UPJANG ='" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'                \n");
               sbSql.append("         AND YY = SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 1, 4)   \n");
               sbSql.append("         AND MM = SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 5, 2)   \n");
               //sbSql.append("           AND DD = '" + nullToBlank(ds_Cond.getString(0, "INPUT_DD")) + "'                 \n");
               sbSql.append("         AND DAY_CLASS = '" + nullToBlank(ds_Cond.getString(0, "DAY_CLASS")) + "'         \n");

               pstmt = conn.prepareStatement(sbSql.toString());
               rs = pstmt.executeQuery();
               rs.next();
            }*/

        // 일계획 데이터
        int chkDt = Integer.parseInt(ds_Cond.getString(0, "SAVE_DD"));
        int chkCol = Integer.parseInt(ds_Cond.getString(0, "COL_CNT"));

        //System.out.println("chkDt===========>"+chkDt); //39
        //System.out.println("chkCol===========>"+chkCol); //31

        if ("0".equals(isData)) {
            // 기존값이 있으면 삭제 후 인서트. 없으면 인서트.
            sbSql.delete(0, sbSql.length());
            sbSql.append(" INSERT INTO MAP_DAY_PLAN (                                                           \n");
            sbSql.append("               UPJANG                                                                 \n");
            sbSql.append("             , CC_CD                                                                  \n");
            sbSql.append("             , YY                                                                     \n");
            sbSql.append("             , MM                                                                     \n");
            sbSql.append("             , DD                                                                     \n");
            sbSql.append("             , YMD                                                                    \n");
            sbSql.append("             , ACCT_CD                                                                \n");
            sbSql.append("             , ACCT_NM                                                                \n");
            sbSql.append("             , ACCT_CLASS                                                             \n");
            sbSql.append("             , DD_AMT                                                                 \n");
            sbSql.append("             , DAY_CLASS                                                              \n");
            sbSql.append("             , CKEY                                                                   \n");
            sbSql.append("             , MM_AMT                                                                 \n");
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
            sbSql.append("             , ?  \n");
            sbSql.append("             , ?  \n");
            sbSql.append("             , SYSDATE \n");
            sbSql.append("             , ?  \n");
            sbSql.append("             , SYSDATE \n");
            sbSql.append("             )    \n");
            pstmt = conn.prepareStatement(sbSql.toString());

            //입력,수정
            for (int iRow = 0; iRow < ds_List.getRowCount(); iRow++) {
                //
                int j = 1;
                //pstmt = conn.prepareStatement(sbSql.toString());
                for (int k = 11; k <= chkDt; k++) {
                    pstmt.setString(1, nullToBlank(ds_Cond.getString(0, "UPJANG")));
                    pstmt.setString(2, nullToBlank(ds_List.getString(iRow, "CC_CD")));
                    pstmt.setString(3, nullToBlank(ds_Cond.getString(0, "INPUT_YY").substring(0, 4)));
                    pstmt.setString(4, nullToBlank(ds_Cond.getString(0, "INPUT_YY").substring(4, 6)));
                    if (k < 20) {
                        pstmt.setString(5, '0' + String.valueOf(j));
                    } else if (k >= 20 && k <= chkDt) {
                        pstmt.setString(5, String.valueOf(j));
                    }
                    if (k < 20) {
                        pstmt.setString(6, nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + '0' + j);
                    } else if (k >= 20 && k <= chkDt) {
                        pstmt.setString(6, nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + j);
                    }
                    pstmt.setString(7, nullToBlank(ds_List.getString(iRow, "ACCT_CD")));
                    pstmt.setString(8, nullToBlank(ds_List.getString(iRow, "ACCT_NM")));
                    pstmt.setString(9, nullToBlank(ds_List.getString(iRow, "ACCT_CLASS")));
                    pstmt.setFloat(10, stringToFloat(ds_List.getString(iRow, k)) * 1000);
                    pstmt.setString(11, nullToBlank(ds_Cond.getString(0, "DAY_CLASS")));
                    pstmt.setString(12, isCkey);
                    pstmt.setString(13, nullToBlank(ds_List.getString(iRow, "SUM_AMT")));
                    pstmt.setString(14, g_EmpNo);
                    pstmt.setString(15, g_EmpNo);
                    //
                    j++;

                    //out_vl.add("fa_Sql", sbSql.toString());
                    //System.out.println(sbSql.toString());
                    pstmt.addBatch(); //변수대입이 끝나면 다음 배치추가
                } //END FOR 2
                //pstmt.executeBatch(); //배치처리
                //pstmt.close();
            } //END FOR
            pstmt.executeBatch(); //배치처리
            pstmt.close();
        } else {
            for (int iRow = 0; iRow < ds_List.getRowCount(); iRow++) {
                if (ds_List.getRowType(iRow) == DataSet.ROW_TYPE_UPDATED) {
                    //
                    int j = 1;
                    for (int k = 11; k <= chkDt; k++) {
                        sbSql.delete(0, sbSql.length());
                        sbSql.append("MERGE INTO MAP_DAY_PLAN A                                                             \n");
                        sbSql.append("USING (SELECT '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "' AS UPJANG         \n");
                        if (k < 20) {
                            sbSql.append("        , '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + '0' + j + "' AS YMD \n");
                        } else if (k >= 20 && k <= chkDt) {
                            sbSql.append("        , '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + j + "'  AS YMD     \n");
                        }
                        sbSql.append("            , '" + nullToBlank(ds_List.getString(iRow, "ACCT_CD")) + "' AS ACCT_CD    \n");
                        sbSql.append("            , '" + nullToBlank(ds_Cond.getString(0, "DAY_CLASS")) + "' AS DAY_CLASS   \n");
                        sbSql.append("         FROM DUAL) B                                                                 \n");
                        sbSql.append("   ON (A.UPJANG       = B.UPJANG      AND                                             \n");
                        sbSql.append("       A.YMD          = B.YMD         AND                                             \n");
                        sbSql.append("       A.ACCT_CD      = B.ACCT_CD     AND                                             \n");
                        sbSql.append("       A.DAY_CLASS    = '" + nullToBlank(ds_Cond.getString(0, "DAY_CLASS")) + "' )    \n");
                        sbSql.append(" WHEN MATCHED THEN                                                                    \n");
                        sbSql.append("      UPDATE                                                                          \n");
                        sbSql.append("         SET A.DD_AMT = " + stringToFloat(ds_List.getString(iRow, k)) * 1000 + "      \n");
                        sbSql.append("           , A.UDATE      = SYSDATE                                                   \n");
                        sbSql.append("           , A.UUSER      = '" + g_EmpNo + "'                                         \n");
                        sbSql.append(" WHEN NOT MATCHED THEN                                                                \n");
                        sbSql.append("      INSERT ( A.UPJANG                                                               \n");
                        sbSql.append("             , A.CC_CD                                                                \n");
                        sbSql.append("             , A.YY                                                                   \n");
                        sbSql.append("             , A.MM                                                                   \n");
                        sbSql.append("             , A.DD                                                                   \n");
                        sbSql.append("             , A.YMD                                                                  \n");
                        sbSql.append("             , A.ACCT_CD                                                              \n");
                        sbSql.append("             , A.ACCT_NM                                                              \n");
                        sbSql.append("             , A.ACCT_CLASS                                                           \n");
                        sbSql.append("             , A.DD_AMT                                                               \n");
                        sbSql.append("             , A.DAY_CLASS                                                            \n");
                        sbSql.append("             , A.CUSER                                                                \n");
                        sbSql.append("             , A.CDATE                                                                \n");
                        sbSql.append("             , A.UUSER                                                                \n");
                        sbSql.append("             , A.UDATE )                                                              \n");
                        sbSql.append("      VALUES ( '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'                  \n");
                        sbSql.append("             , '" + nullToBlank(ds_List.getString(iRow, "CC_CD")) + "'                \n");
                        sbSql.append("             , SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 1, 4)  \n");
                        sbSql.append("             , SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 5, 2)  \n");

                        // 날짜가 들어가야함 마지막 날이 31 이면 1~31까지 일자가 들어가야함.
                        if (k < 20) {
                            sbSql.append("             , '" + '0' + j + "'                                                   \n");
                        } else if (k >= 20 && k <= chkDt) {
                            sbSql.append("             , '" + j + "'                                                        \n");
                        }

                        if (k < 20) {
                            sbSql.append("             , '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + '0' + j + "'   \n");
                        } else if (k >= 20 && k <= chkDt) {
                            sbSql.append("             , '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + j + "'        \n");
                        }

                        sbSql.append("             , '" + nullToBlank(ds_List.getString(iRow, "ACCT_CD")) + "'              \n");
                        sbSql.append("             , '" + nullToBlank(ds_List.getString(iRow, "ACCT_NM")) + "'              \n");
                        sbSql.append("             , '" + nullToBlank(ds_List.getString(iRow, "ACCT_CLASS")) + "'           \n");
                        sbSql.append("             , '" + stringToFloat(ds_List.getString(iRow, k)) * 1000 + "'             \n");
                        sbSql.append("             , '" + nullToBlank(ds_Cond.getString(0, "DAY_CLASS")) + "'               \n");
                        sbSql.append("             , '" + g_EmpNo + "'                                                      \n");
                        sbSql.append("             , SYSDATE                                                                \n");
                        sbSql.append("             , '" + g_EmpNo + "'                                                      \n");
                        sbSql.append("             , SYSDATE                                                                \n");
                        sbSql.append("             )                                                                        \n");

                        j++;

                        out_vl.add("fa_Sql", sbSql.toString());
                        //System.out.println(sbSql.toString());
                        pstmt = conn.prepareStatement(sbSql.toString());
                        pstmt.executeUpdate();
                        pstmt.close();
                    } //END FOR
                } //END IF
            } //END FOR
        } //END ELSE

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