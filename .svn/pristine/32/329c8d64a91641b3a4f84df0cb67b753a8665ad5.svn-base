
<%
    /*-----------------------------------------------------------------------------
    ■ 시스템명     : 사업계획관리
    ■ 프로그램ID   : MAP30010E_T002.jsp
    ■ 프로그램명   : 월추정 관리 저장
    ■ 작성일자     : 2015-06-19
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

        //sql문 버퍼생성
        StringBuffer sbSql = new StringBuffer();

        // 현재일 기준하여 수정계획이 있으면 저장될 내용은 '수정계획명' 으로 저장한다.
        sbSql.append("SELECT COUNT(1) ISDATA  														\n");
        sbSql.append("  FROM MAP_MON_LOG_MGMT														\n");
        sbSql.append(" WHERE YY = '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "' 			\n");
        sbSql.append("   AND UPJANG = '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "' 		\n");
        sbSql.append("   AND BIZ_CLASS = '" + nullToBlank(ds_Cond.getString(0, "BIZ_CLASS2")) + "'	\n");
        //sbSql.append("   AND CONFIRM_YN = '" + "N" + "'	\n");
        //sbSql.append("   AND CONFIRM_YN = '" + ds_Cond.getString(0, "CONFIRM_YN") + "'	\n");
        sbSql.append("   AND CONFIRM_YN = '" + ds_List.getString(1, "CONFIRM_YN") + "'	\n");

        pstmt = conn.prepareStatement(sbSql.toString());
        rs = pstmt.executeQuery();

        rs.next();

        String isData = rs.getString("ISDATA");

        if ("0".equals(isData)) {
            // 사업계획 이력관리(수정계획) 저장.
            sbSql.delete(0, sbSql.length());
            //sbSql.append("INSERT INTO MAP_MON_LOG_MGMT 															\n");
            //sbSql.append("		 (UPJANG, YY, BIZ_CLASS, CONFIRM_YN, BPC_SEND_YN, CDATE, CUSER, UDATE, UUSER )						 		\n");
            //sbSql.append("VALUES ('" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'			 				\n");
            //sbSql.append("      , '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "' 			 			\n");
            //sbSql.append("      , '" + nullToBlank(ds_Cond.getString(0, "BIZ_CLASS2")) + "'						\n");
            //sbSql.append("      , 'N', 'N', SYSDATE, '" + g_EmpNo + "', SYSDATE, '" + g_EmpNo + "' )		 										\n");

            sbSql.append(" MERGE INTO MAP_MON_LOG_MGMT A \n");
            sbSql.append(" USING DUAL \n");
            sbSql.append(" ON ( \n");
            sbSql.append("      A.UPJANG = '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'     \n");
            sbSql.append("  AND A.YY = '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'   \n");
            sbSql.append("  AND A.BIZ_CLASS = '" + nullToBlank(ds_Cond.getString(0, "BIZ_CLASS2")) + "'  \n");
            sbSql.append(" ) \n");
            sbSql.append(" WHEN MATCHED THEN \n");
            sbSql.append("     UPDATE SET \n");
            sbSql.append("           A.CONFIRM_YN = 'N' \n");
            sbSql.append("         , A.UDATE = SYSDATE \n");
            sbSql.append("         , A.UUSER = '" + g_EmpNo + "' \n");
            sbSql.append(" WHEN NOT MATCHED THEN \n");
            sbSql.append("     INSERT (UPJANG, YY, BIZ_CLASS, CONFIRM_YN, BPC_SEND_YN, CDATE, CUSER, UDATE, UUSER ) VALUES ( \n");
            sbSql.append("      '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'                         \n");
            sbSql.append("      , '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'                       \n");
            sbSql.append("      , '" + nullToBlank(ds_Cond.getString(0, "BIZ_CLASS2")) + "'                     \n");
            sbSql.append("      , 'N', 'N', SYSDATE, '" + g_EmpNo + "', SYSDATE, '" + g_EmpNo + "' )            \n");
            pstmt = conn.prepareStatement(sbSql.toString());
            pstmt.executeUpdate();
            pstmt.close();
        }
        //pstmt = conn.prepareStatement(sbSql.toString());
        //rs = pstmt.executeQuery();
        //
        //rs.next();

        //입력,수정
        for (int iRow = 0; iRow < ds_List.getRowCount(); iRow++) {
            //if(ds_List.getRowType(iRow) == DataSet.ROW_TYPE_UPDATED){
            sbSql.delete(0, sbSql.length());
            sbSql.append("MERGE INTO MAP_MON_PLAN A 															\n");
            sbSql.append("USING (SELECT '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "' AS YY 			\n");
            sbSql.append("            , '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "' AS UPJANG 		\n");
            sbSql.append("            , '" + nullToBlank(ds_List.getString(iRow, "ACCT_CD")) + "' AS ACCT_CD 	\n");
            sbSql.append("            , '" + nullToBlank(ds_Cond.getString(0, "BIZ_CLASS2")) + "' AS BIZ_CLASS 	\n");
            sbSql.append("         FROM DUAL) B                   												\n");
            sbSql.append("   ON (A.YY     		= B.YY 			AND  											\n");
            sbSql.append("       A.UPJANG     	= B.UPJANG 		AND      										\n");
            sbSql.append("       A.ACCT_CD      = B.ACCT_CD 	AND        										\n");
            sbSql.append("       A.BIZ_CLASS    = '" + nullToBlank(ds_Cond.getString(0, "BIZ_CLASS2")) + "' )	\n");
            sbSql.append(" WHEN MATCHED THEN                      												\n");
            sbSql.append("      UPDATE                            												\n");
            sbSql.append("         SET A.MM_AMT_01 = " + stringToFloat(ds_List.getString(iRow, "MM_AMT_01")) * 1000 + " 	\n");
            sbSql.append("           , A.MM_AMT_02 = " + stringToFloat(ds_List.getString(iRow, "MM_AMT_02")) * 1000 + " 	\n");
            sbSql.append("           , A.MM_AMT_03 = " + stringToFloat(ds_List.getString(iRow, "MM_AMT_03")) * 1000 + " 	\n");
            sbSql.append("           , A.MM_AMT_04 = " + stringToFloat(ds_List.getString(iRow, "MM_AMT_04")) * 1000 + " 	\n");
            sbSql.append("           , A.MM_AMT_05 = " + stringToFloat(ds_List.getString(iRow, "MM_AMT_05")) * 1000 + " 	\n");
            sbSql.append("           , A.MM_AMT_06 = " + stringToFloat(ds_List.getString(iRow, "MM_AMT_06")) * 1000 + " 	\n");
            sbSql.append("           , A.MM_AMT_07 = " + stringToFloat(ds_List.getString(iRow, "MM_AMT_07")) * 1000 + " 	\n");
            sbSql.append("           , A.MM_AMT_08 = " + stringToFloat(ds_List.getString(iRow, "MM_AMT_08")) * 1000 + " 	\n");
            sbSql.append("           , A.MM_AMT_09 = " + stringToFloat(ds_List.getString(iRow, "MM_AMT_09")) * 1000 + " 	\n");
            sbSql.append("           , A.MM_AMT_10 = " + stringToFloat(ds_List.getString(iRow, "MM_AMT_10")) * 1000 + " 	\n");
            sbSql.append("           , A.MM_AMT_11 = " + stringToFloat(ds_List.getString(iRow, "MM_AMT_11")) * 1000 + " 	\n");
            sbSql.append("           , A.MM_AMT_12 = " + stringToFloat(ds_List.getString(iRow, "MM_AMT_12")) * 1000 + " 	\n");
            sbSql.append("           , A.UDATE      = SYSDATE 													\n");
            sbSql.append("           , A.UUSER      = '" + g_EmpNo + "' 										\n");
            sbSql.append(" WHEN NOT MATCHED THEN 																\n");
            sbSql.append("      INSERT ( A.UPJANG 																\n");
            sbSql.append("             , A.CC_CD																\n");
            sbSql.append("             , A.YY 																	\n");
            sbSql.append("             , A.VER_CD																\n");
            sbSql.append("             , A.ACCT_CD 																\n");
            sbSql.append("             , A.ACCT_NM 																\n");
            sbSql.append("             , A.JOB_GRADE_CD															\n");
            sbSql.append("             , A.JOB_GRADE_NM															\n");
            sbSql.append("             , A.ACCT_CLASS 															\n");
            sbSql.append("             , A.BIZ_CLASS 															\n");
            sbSql.append("             , A.MM_AMT_01 															\n");
            sbSql.append("             , A.MM_AMT_02 															\n");
            sbSql.append("             , A.MM_AMT_03 															\n");
            sbSql.append("             , A.MM_AMT_04 															\n");
            sbSql.append("             , A.MM_AMT_05 															\n");
            sbSql.append("             , A.MM_AMT_06 															\n");
            sbSql.append("             , A.MM_AMT_07 															\n");
            sbSql.append("             , A.MM_AMT_08 															\n");
            sbSql.append("             , A.MM_AMT_09 															\n");
            sbSql.append("             , A.MM_AMT_10 															\n");
            sbSql.append("             , A.MM_AMT_11 															\n");
            sbSql.append("             , A.MM_AMT_12 															\n");
            sbSql.append("             , A.CUSER 																\n");
            sbSql.append("             , A.CDATE 																\n");
            sbSql.append("             , A.UUSER 																\n");
            sbSql.append("             , A.UDATE ) 																\n");
            sbSql.append("      VALUES ( '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "' 					\n");
            sbSql.append("             , '" + nullToBlank(ds_List.getString(iRow, "CC_CD")) + "' 					\n");
            sbSql.append("             , '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "' 				\n");
            //sbSql.append("             , '" + nullToBlank(ds_Cond.getString(0, "VER_CD")) + "' 					\n");
            sbSql.append("             , (SELECT VER_CD FROM MAP_BPC_MODIFY_PLAN WHERE PLAN_CLASS = 'MP' AND OPEN_YN = 'Y') \n");
            sbSql.append("             , '" + nullToBlank(ds_List.getString(iRow, "ACCT_CD")) + "' 				\n");
            sbSql.append("             , '" + nullToBlank(ds_List.getString(iRow, "ACCT_NM")) + "' 				\n");
            sbSql.append("             , '" + nullToBlank(ds_List.getString(iRow, "JOB_GRADE_CD")) + "' 		\n");
            sbSql.append("             , '" + nullToBlank(ds_List.getString(iRow, "JOB_GRADE_NM")) + "' 		\n");
            sbSql.append("             , '" + nullToBlank(ds_List.getString(iRow, "ACCT_CLASS")) + "' 			\n");
            sbSql.append("             , '" + nullToBlank(ds_Cond.getString(0, "BIZ_CLASS2")) + "' 				\n");
            sbSql.append("             , '" + stringToFloat(ds_List.getString(iRow, "MM_AMT_01")) * 1000 + "' 	\n");
            sbSql.append("             , '" + stringToFloat(ds_List.getString(iRow, "MM_AMT_02")) * 1000 + "' 	\n");
            sbSql.append("             , '" + stringToFloat(ds_List.getString(iRow, "MM_AMT_03")) * 1000 + "' 	\n");
            sbSql.append("             , '" + stringToFloat(ds_List.getString(iRow, "MM_AMT_04")) * 1000 + "' 	\n");
            sbSql.append("             , '" + stringToFloat(ds_List.getString(iRow, "MM_AMT_05")) * 1000 + "' 	\n");
            sbSql.append("             , '" + stringToFloat(ds_List.getString(iRow, "MM_AMT_06")) * 1000 + "' 	\n");
            sbSql.append("             , '" + stringToFloat(ds_List.getString(iRow, "MM_AMT_07")) * 1000 + "' 	\n");
            sbSql.append("             , '" + stringToFloat(ds_List.getString(iRow, "MM_AMT_08")) * 1000 + "' 	\n");
            sbSql.append("             , '" + stringToFloat(ds_List.getString(iRow, "MM_AMT_09")) * 1000 + "' 	\n");
            sbSql.append("             , '" + stringToFloat(ds_List.getString(iRow, "MM_AMT_10")) * 1000 + "' 	\n");
            sbSql.append("             , '" + stringToFloat(ds_List.getString(iRow, "MM_AMT_11")) * 1000 + "' 	\n");
            sbSql.append("             , '" + stringToFloat(ds_List.getString(iRow, "MM_AMT_12")) * 1000 + "' 	\n");
            sbSql.append("             , '" + g_EmpNo + "' 														\n");
            sbSql.append("             , SYSDATE 																\n");
            sbSql.append("             , '" + g_EmpNo + "' 														\n");
            sbSql.append("             , SYSDATE 																\n");
            sbSql.append("             ) 																		\n");

            out_vl.add("fa_Sql", sbSql.toString());
            //System.out.println(sbSql.toString());
            pstmt = conn.prepareStatement(sbSql.toString());
            pstmt.executeUpdate();
            pstmt.close();
            //}//END IF
        } // END FOR

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